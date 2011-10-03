DGEN408 ;ALB/RKS - SEED THE HEC ; 5/3/02 3:04pm
 ;;5.3;Registration;**408**;Aug 13,1993
 Q
 ;
EN ; Main entry point for collection of MPI fields & transmission to HEC
 ;
 N ZTRTN,ZTIO,ZTDESC,ZTSK,ZTDTH,ZTSAVE,DGDEST,DIR,DIRUT
 ;
 ; Check for MPI
 I ($T(GETICN^MPIF001)="") D  Q
 . W !?2,*7,">> There were no patient MPI"
 ;
 S DIR(0)="YAO",DIR("B")="YES",DIR("A")="Transmit to HEC Production? "
 S DIR("?",1)="'YES' will transmit extracts to the HEC production system."
 S DIR("?")="'NO' will transmit the extracts to the HEC Development accounts."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S DGDEST=+Y              ;Destination = 1 for Production
 I 'DGDEST D TEST Q       ;else Test Mode and Quit
 ;
 S ZTSAVE("DGDEST")=""
 S ZTRTN="QUE^DGEN408"
 S ZTDESC="DG53_408 SEED THE HEC WITH ICN"
 S ZTIO=""
 S ZTDTH=$$NOW^XLFDT
 D ^%ZTLOAD
 ;
 I $G(ZTSK) W !,"Task Number: ",ZTSK
 Q
 ;
QUE ;Background task entry point for Production option
 N DGEXTRCT,DGDATA
 ;
 S DGEXTRCT="^TMP(""SEED HEC"",$J)"
 K @DGEXTRCT
 ;
 S DGDATA("SITE")=$P($$SITE^VASITE,U,3)
 K IVMQUERY("LTD"),IVMQUERY("OVIS")
 ;
 D COLLECT(DGEXTRCT,.DGDATA)
 D BUILD(DGEXTRCT,.DGDATA,1000,DGDEST)
 D NOTIFY(.DGDATA)
 ;
 K @DGEXTRCT
 Q
 ;
TEST ;  Test entry point for development testing.  This entry point is
 ;    not supported for user use.
 N LINE,DGEXTRCT,DGDATA
 K DIR
 S DIR(0)="SO^P:PDQMGR ENV;S:SDQMGR ENV;Q:QDQMGR ENV"
 S DIR("A")="Transmit to which Environment? "
 S DIR("?")="Enter 1 of the 3 test environments allowed"
 D ^DIR K DIR Q:$D(DIRUT)
 S DGDEST=Y            ;Destination = P, S, or Q for testing
 S DGDATA("TEST")=1
 S DGEXTRCT="^TMP(""SEED HEC"",$J)"
 K @DGEXTRCT
 S DGDATA("SITE")=$P($$SITE^VASITE,U,3)
 ;
 W !!,"COLLECTING DATA TO SEND TO "_DGDEST_"DQMGR...please wait..."
 D COLLECT(DGEXTRCT,.DGDATA)
 D BUILD(DGEXTRCT,.DGDATA,1000,DGDEST)    ;batch 1000 vets per message
 D NOTIFY(.DGDATA)
 ;
 K @DGEXTRCT
 Q
 ;
COLLECT(DGEXTRCT,DGDATA) ; Collect valid MPI data
 N LINE,DFN
 ;
 S DFN=0,LINE=1
 ;
 ;loop and set TMP extract global with patients that qualify, ignoring
 ;those patients whose CMOR is not from this site or have a Local ICN
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . I +$$GETICN^MPIF001(DFN)<0!(($$IFLOCAL^MPIF001(DFN)=1)!($$IFVCCI^MPIF001(DFN)'=1)) Q
 . S @DGEXTRCT@(LINE)=DFN_U_$$GETICN^MPIF001(DFN)_U
 . S @DGEXTRCT@(LINE)=@DGEXTRCT@(LINE)_$$GETVCCI^MPIF001(DFN)
 . S LINE=LINE+1
 ;
 S DGDATA("NUMREC")=LINE-1
 ;
 Q
 ;
BUILD(DGEXTRCT,DGDATA,MAX,DGDEST) ; Build mailman messages of MPI data
 N DGX,COUNT,DGMSG,LINE
 ;
 S MAX=$G(MAX)
 S:'MAX MAX=1000
 ;
 S DGMSG="^TMP(""DGEN408TXT"",$J)"
 K @DGMSG
 ;
 ; Calculate the number of messages (batches) to send based on MAX
 S DGDATA("TOSEND")=DGDATA("NUMREC")\MAX
 S:DGDATA("NUMREC")#MAX>0 DGDATA("TOSEND")=DGDATA("TOSEND")+1
 ;
 S (COUNT,LINE)=0
 F  S COUNT=$O(@DGEXTRCT@(COUNT)) Q:'COUNT  D
 . S LINE=LINE+1
 . S @DGMSG@(LINE)=@DGEXTRCT@(COUNT)
 . ;  if exceed max per batch, then stop and send now & reset for next
 . I LINE=MAX D
 . . S DGDATA("MSGNUM")=$G(DGDATA("MSGNUM"))+1
 . . S DGDATA("MSG",DGDATA("MSGNUM"))=LINE
 . . D SEND(.DGDATA,DGMSG,DGDEST)
 . . K @DGMSG
 . . S LINE=0
 ;
 ; Quit if Not at least 1 record exists, else send last batch
 Q:'LINE
 ;
 ;send the last partial batch
 S DGDATA("MSGNUM")=$G(DGDATA("MSGNUM"))+1
 S DGDATA("MSG",DGDATA("MSGNUM"))=LINE
 D SEND(.DGDATA,DGMSG,DGDEST)
 ;
 Q
 ;
SEND(DGDATA,DGMSG,DGDEST) ;  Build and send individual mailman messages
 N XMY,XMSUB,XMDUZ,XMZ,XMERR,XMTEXT,MSG
 ;
 S XMDUZ="HEC MPI SEEDING"
 I DGDEST=1 D                                 ;send to production
 . S XMY("S.IVMB MPI SERVER@IVM.MED.VA.GOV")=""
 E  D                                       ;send to a test account
 . N TMP
 . S TMP="S.IVMB MPI SERVER@"_DGDEST_"DQMGR.IVM.MED.VA.GOV"
 . S XMY(TMP)=""
 ;
 S XMY(.5)=""
 S XMY("G.IVMB HEC MPI NOTIFICATION")=""
 S XMSUB=$$GET1^DIQ(4,DGDATA("SITE"),.01)_"/"_DGDATA("SITE")
 S XMSUB=XMSUB_":MPI #"_DGDATA("MSGNUM")_" OF "_DGDATA("TOSEND")
 S @DGMSG@(.5)=DGDATA("SITE")_U_DGDATA("MSGNUM")_U_DGDATA("TOSEND")
 S @DGMSG@(.5)=@DGMSG@(.5)_U_DGDATA("MSG",DGDATA("MSGNUM"))_U
 S @DGMSG@(.5)=@DGMSG@(.5)_DGDATA("NUMREC")
 S XMTEXT="MSG("
 M MSG=@DGMSG
 ;
 D ^XMD
 Q
 ;
NOTIFY(DGDATA) ;  Send notification message to local mailgroup.
 N XMY,XMSUB,XMTEXT,XMDUZ,XMZ,XMERR,DGTXT
 ;
 S XMDUZ="HEC MPI SEEDING"
 S XMY("G.IVMB HEC MPI NOTIFICATION")=""
 S XMSUB="HEC MPI TRANSMISSION"
 ;
 S DGTXT(.1)="A total of "_DGDATA("NUMREC")_" MPI seeding records in "_DGDATA("MSGNUM")
 S DGTXT(.2)="messages have been transmitted to the HEC"
 S DGTXT(.3)=""
 ;
 S X=0
 F  S X=$O(DGDATA("MSG",X)) Q:'X  D
 . S DGTXT(X)="     Message #"_X_"  - "_DGDATA("MSG",X)_" records"
 S XMTEXT="DGTXT("
 ;
 D ^XMD
 Q
