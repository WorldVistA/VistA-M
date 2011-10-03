DGEN339 ;ALB/SCK - IVMB HEC CLEANUP - VETERAN MERGE EXTRACT ; 1/13/2001
 ;;5.3;Registration;**339,410**;Aug 13,1993
 ;
EN ; Main entry point for veteran merged pair collection and transmission to the HEC
 N ZTRTN,ZTIO,ZTDESC,ZTSK,ZTDTH,ZTSAVE,DGDEST,DIR,DIRUT
 ;
 ; Check for merge of patient file in file #15.3
 I '$D(^VA(15.3,2)) D  Q
 . W !?2,*7,">> There were no patient merge entries in the XDR REPOINTED ENTRY File (15.3)"
 . W !?2,">> Please check that the Duplicate Patient Merge was completed."
 ;
 S DIR(0)="YAO",DIR("B")="YES",DIR("A")="Transmit to HEC Production? "
 S DIR("?",1)="'YES' will transmit extracts to the HEC production system."
 S DIR("?")="'NO' will transmit the extracts to the HEC Development accounts."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S DGDEST=+Y
 ;
 S ZTSAVE("DGDEST")=""
 S ZTRTN="QUE^DGEN339"
 S ZTDESC="DG53_339 VETERAN MERGE GENERATION"
 S ZTIO=""
 S ZTDTH=$$NOW^XLFDT
 D ^%ZTLOAD
 ;
 I $G(ZTSK) W !,"Task Number: ",ZTSK
 Q
 ;
QUE ;
 N DGEXTRCT,DGDATA
 ;
 S DGEXTRCT="^TMP(""DGEN VET MRG"",$J)"
 K @DGEXTRCT
 ;
 S DGDATA("SITE")=$P($$SITE^VASITE,U,3)
 ;
 D COLLECT(DGEXTRCT,.DGDATA)
 D BUILD(DGEXTRCT,.DGDATA,1000,DGDEST)
 D NOTIFY(.DGDATA)
 ;
 K @DGEXTRCT
 Q
 ;
TEST(MODE) ;  Test entry point for development testing.  This entry point is not
 ; supported for user use.
 ;
 N LINE,DGEXTRCT,DGDATA
 ;
 S MODE=$G(MODE)
 ;
 S DGDATA("TEST")=1
 S DGEXTRCT="^TMP(""DGEN VET MRG"",$J)"
 K @DGEXTRCT
 ;
 S DGDATA("SITE")=$P($$SITE^VASITE,U,3)
 ;
 I 'MODE D
 . F LINE=1:1:1200 D
 . . S @DGEXTRCT@(LINE)=$R(2000)_"^"_$R(2000)
 . S DGDATA("NUMREC")=LINE
 E  D
 . D COLLECT(DGEXTRCT,.DGDATA)
 ;
 D BUILD(DGEXTRCT,.DGDATA,500)
 D NOTIFY(.DGDATA)
 ;
 K @DGEXTRCT
 Q
 ;
COLLECT(DGEXTRCT,DGDATA) ; Collect Merge From and Merge To pair from XDR Repointed Entry File
 ; Append ICN to end of merge pair using API call
 N LINE,IX,ZVALUE,DFN1,DFN2
 ;
 S IX=0,LINE=1
 F  S IX=$O(^VA(15.3,2,1,IX)) Q:'IX  D
 . S ZVALUE=$G(^VA(15.3,2,1,IX,0))
 . I ($T(GETICN^MPIF001)'="") D
 . . S DFN1=$P(ZVALUE,U)
 . . S DFN2=$P(ZVALUE,U,2)
 . . S ZVALUE=ZVALUE_U_"M~"_$$GETICN^MPIF001(DFN1)_U_"MT~"_$$GETICN^MPIF001(DFN2)
 . S @DGEXTRCT@(LINE)=ZVALUE
 . S LINE=LINE+1
 S DGDATA("NUMREC")=LINE-1
 ;
 Q
 ;
BUILD(DGEXTRCT,DGDATA,MAX,DGDEST) ; Build and send mailman messages of veteran pairs
 N DGX,COUNT,DGMSG,LINE
 ;
 S MAX=$G(MAX)
 S:'MAX MAX=1000
 ;
 S DGMSG="^TMP(""DG339TXT"",$J)"
 K @DGMSG
 ;
 ; Calculate the number of messages to send using MAX and number of records
 S DGDATA("TOSEND")=DGDATA("NUMREC")\MAX
 S:DGDATA("NUMREC")#MAX>0 DGDATA("TOSEND")=DGDATA("TOSEND")+1
 ;
 S DGDATA("MSGNUM")=1 ; Initialize first message
 S COUNT=0,LINE=1
 F  S COUNT=$O(@DGEXTRCT@(COUNT)) Q:'COUNT  D
 . S @DGMSG@(LINE)=@DGEXTRCT@(COUNT)
 . S LINE=LINE+1
 . I LINE>MAX D
 . . S DGDATA("MSG",DGDATA("MSGNUM"))=LINE-1
 . . D SEND(.DGDATA,DGMSG,DGDEST)
 . . S DGDATA("MSGNUM")=$G(DGDATA("MSGNUM"))+1
 . . K @DGMSG
 . . S LINE=1
 ; Send last message
 S DGDATA("MSG",DGDATA("MSGNUM"))=LINE-1
 D SEND(.DGDATA,DGMSG,DGDEST)
 ;
 Q
 ;
SEND(DGDATA,DGMSG,DGDEST) ;  Build and send individual mailman messages
 N XMY,XMSUB,XMDUZ,XMZ,XMERR,XMTEXT,MSG
 ;
 S XMDUZ="HEC VETERAN MERGE EXTRACT"
 I $G(DGDEST) S XMY("S.IVMB VSE SERVER@IVM.MED.VA.GOV")=""
 E  S XMY("S.IVMB VSE SERVER@PDQMGR.IVM.MED.VA.GOV")=""
 ;
 S XMY(.5)=""
 S XMY("G.IVMB HEC VSE NOTIFICATION")=""
 S XMSUB=$$GET1^DIQ(4,DGDATA("SITE"),.01)_"/"_DGDATA("SITE")_":VSE #"_DGDATA("MSGNUM")_" OF "_DGDATA("TOSEND")
 S @DGMSG@(.5)=DGDATA("SITE")_U_DGDATA("MSGNUM")_U_DGDATA("TOSEND")_U_DGDATA("MSG",DGDATA("MSGNUM"))_"^"_DGDATA("NUMREC")
 S XMTEXT="MSG("
 M MSG=@DGMSG
 ;
 D ^XMD
 Q
 ;
NOTIFY(DGDATA) ;  Send notification message to local mailgroup.
 N XMY,XMSUB,XMTEXT,XMDUZ,XMZ,XMERR,DGTXT
 ;
 S XMDUZ="HEC VETERAN MERGE EXTRACT"
 S XMY("G.IVMB HEC VSE NOTIFICATION")=""
 S XMSUB="HEC VETERAN MERGE EXTRACT TRANSMISSION"
 ;
 S DGTXT(.1)="A total of "_DGDATA("NUMREC")_" veteran extract records in "_DGDATA("MSGNUM")
 S DGTXT(.2)="messages have been transmitted to the HEC"
 S DGTXT(.3)=""
 ;
 S X=0
 F  S X=$O(DGDATA("MSG",X)) Q:'X  D
 .  S DGTXT(X)="     Message #"_X_"  - "_DGDATA("MSG",X)_" records"
 S XMTEXT="DGTXT("
 D ^XMD
 Q
