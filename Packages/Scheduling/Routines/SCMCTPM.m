SCMCTPM ;ALB/REW - Patient Position Changes MailMessages ; 26 Mar 1996
 ;;5.3;Scheduling;**41,45,48,87,100,130**;AUG 13, 1993
 ;1
MAIL ;Do Patient Team Changes MailMan Message
 ; - called by SCMC PT TEAM CHANGES MAIL MESSAGE protocol
 G:$G(SCNOMAIL) END  ;- flag can be set to stop message generation
 N XMDUZ,XMY,XMSUB,XMTEXT,VA,VAERR,XMZ,Y,ZTQUEUED
 N SCTMAR,SCSTAT,DFN,SCNODE,SCY,SCSPACE,SCPAD,SCTPXM,SCLNCNT,SCTPDT,SCPTNM
 S ZTQUEUED=1
 S $P(SCSPACE," ",80)=""
 ;   SCTMAR - ARRAY OF TEAMS (before & after)
 S:SCTMAF SCTMAR(SCTMAF)=""
 S:SCTMB4 SCTMAR(SCTMB4)=""
 S:'SCTPAF SCSTAT="DELETED"
 S:'SCTPB4 SCSTAT="NEW"
 S:SCTPB4&SCTPAF SCSTAT="CHANGED"
 S DFN=$S(SCSTAT="DELETED":+$G(^SCPT(404.42,+SCPTTPB4,0)),1:+$G(^SCPT(404.42,+SCPTTPAF,0)))
 ;set xmy array for practitioners in positions receiving TMchg notices
 G:'$$PCMMXMY^SCAPMC25(3,DFN,"SCTMAR","SCTPDT",0) END
 ;D:'$G(DGQUIET) EN^DDIOL("Sending "_SCSTAT_" Patient-Position Assignment Message")
 D PID^VADPT6
 S SCPTNM=$P(^DPT(DFN,0),U,1)
 S XMSUB=SCSTAT_" PATIENT-POSITION ASSIGNMENT for Patient ("_$E(SCPTNM,1)_$G(VA("BID"))_")",XMTEXT="^TMP($J,""SCTPXM"",",SCLNCNT=0
 IF SCSTAT="NEW" D
 .D SETLN("Current Patient Team Data:")
 .D SETLN("==========================")
 .F SCX=1:1:9 D
 ..D SETLN($$TEXT(404.43,SCPTTPAF,SCX,SCSPACE,1))
 IF SCSTAT="DELETED" D
 .D SETLN("Previous Patient Team Data:")
 .D SETLN("===========================")
 .F SCX=1:1:9 S SCFLD=SCX*.01 D
 ..D SETLN($$TEXT(404.43,SCPTTPB4,SCX,SCSPACE,1))
 IF SCSTAT="CHANGED" D
 .D SETLN("Fields: "_$E(SCSPACE,1,19)_"Previous Data:           Current Patient Data:")
 .D SETLN("=======================================================================")
 .F SCX=1:1:9 S SCFLD=SCX*.01 D
 ..N SCLAB2,SCY,SCZ
 ..S SCY=$$TEXT(404.43,SCPTTPB4,SCX,SCSPACE,1)
 ..S:'$L(SCY) SCLAB2=2
 ..S SCZ=$$TEXT(404.43,SCPTTPAF,SCX,SCSPACE,+$G(SCLAB2))
 ..D:$L(SCY)!($L(SCZ)) SETLN(SCY_$E(SCSPACE,1,(52-$L(SCY)))_SCZ)
 S SCLNCNT=$$PCMAIL^SCMCMM(DFN,"^TMP($J,""SCTPXM"")",DT)
 S XMDUZ=$G(DUZ,.5)
 D ^XMD
END K ^TMP($J,"SCTPXM")
 Q
 ;
SETLN(TEXT) ;
 Q:$G(TEXT)=""
 ; increments SCLNCNT, adds text to scTPxm(sclncnt)
 S SCLNCNT=SCLNCNT+1
 S ^TMP($J,"SCTPXM",SCLNCNT)=TEXT
 Q
 ;
TEXT(SCFILE,SCNODE,SCPC,SCSPACE,SCLAB) ;returns fldname & external value
 ;returns fldname & external value
 ;   Note- Only works for non wp fields of standard numbering conventions
 ;   SCFLILE =FILENUM
 ;   SCNODE  = 0 NODE
 ;   SCPC    = piece of node
 ;   SCSPACE = 80 SPACES
 ;   SCLAB = 1 if print field name
 N SCX,SCINT,SCFLD
 S SCX=""
 S SCINT=$P(SCNODE,U,SCPC)
 G:SCINT="" QTTXT
 S SCFLD=SCPC*.01
 ;;;
 IF $G(SCLAB) D
 .S SCX=$$DDNAME^SCMCRU(SCFILE,SCFLD)_":"
 .S:$G(SCLAB)=1 SCX=SCX_$E(SCSPACE,1,(27-$L(SCX)))
 .S:$G(SCLAB)=2 SCX=SCX_$E(SCSPACE,1,(52-$L(SCX)))
 S:SCINT]"" SCX=SCX_$$EXTERNAL^DILFD(SCFILE,SCFLD,"",SCINT)
QTTXT Q SCX
DDNAME(FILE,FIELD) ;return the fieldname
 N SCX
 D FIELD^DID(FILE,FIELD,"","LABEL","SCX")
 Q $G(SCX("LABEL"))
 ;
MAILLST(SCTP,SCFIELDA,SCDATE,SCNEWTP,SCOLDTP,SCBADTP) ;
 ; Input:
 ;    SCTP     - Pointer to Team Position File (#404.57)
 ;    SCFIELDA - Field array with internal values
 ;    SCDATE   - Effective Date
 ;    SCNEWTP  - DFN array of newly assigned to position
 ;    SCOLDTP  - DFN array of previously assigned to position
 ;    SCBADTP  - DFN array of patients unassignable to position
 ;
 G:$G(SCNOMAIL) QTMULT  ;- flag can be set to stop message generation
 G:'$D(SCNEWTP) QTMULT
 G:'$O(@SCNEWTP@(0)) QTMULT  ;if no new assignments
 N XMDUZ,XMY,XMSUB,XMTEXT,VA,VAERR,XMZ,Y,SCTPDT,ZTQUEUED
 N SCTPNM,DFN,SCOK,SCPTNM,SCFLD,SCNODE,SCNDX,SCSPACE,SCE,SCB,SCTMNM,SCDELTEM,SCDETAIL
 S ZTQUEUED=1
 S SCDELTEM=1 ;ok to delete tmp global
 IF $D(SCFIELDA) D
 .IF $D(SCFIELDA(.03)) S SCB=SCFIELDA(.03)
 .IF $D(SCFIELDA(.04)) S SCE=SCFIELDA(.04)
 S SCB=$G(SCB,DT)
 S SCE=$G(SCE,DT)
 S $P(SCSPACE," ",80)=""
 S SCTPDT("BEGIN")=$S(SCB<SCDATE:SCB,1:SCDATE)
 S SCTPDT("END")=$S(SCE>SCDATE:SCE,1:SCDATE)
 S SCTPDT("INCL")=0
 S SCTPNM=$P($G(^SCTM(404.57,+SCTP,0)),U,1)
 S XMSUB="Multiple PATIENT-POSITION ASSIGNMENT for "_SCTPNM,XMTEXT="^TMP($J,""SCTPXM"",",SCLNCNT=0
 D:'$G(DGQUIET) EN^DDIOL("Sending Multiple Patient-Position Assignment Message")
 S SCOK=1
 S SCTPNM=$P($G(^SCTM(404.57,+SCTP,0)),U,1)
 S SCTMNM=$P($G(^SCTM(404.51,+$P($G(^SCTM(404.57,+SCTP,0)),U,2),0)),U,1)
 D SETLN("Team:                  "_SCTMNM)
 D SETLN("Position:              "_SCTPNM)
 S Y=SCDATE X ^DD("DD")
 D SETLN("Effective Date:        "_Y)
 D SETLN(" ")
 IF $D(SCFIELDA) D
 .F SCNDX=1:1:14 S SCFLD=SCNDX*.01 IF $D(SCFIELDA(SCFLD)) D
 ..S $P(SCNODE,U,SCNDX)=SCFIELDA(SCFLD)
 ..D SETLN($$TEXT(404.43,SCNODE,SCNDX,SCSPACE,1))
 D SETLN(" ")
 D SETLN("There has been a new position assignment for the following patients:")
 S DFN=0
NEW F  S DFN=$O(@SCNEWTP@(DFN)) Q:'DFN  D
 .S:$$PCMMXMY^SCAPMC25(3,DFN,,"SCTPDT",0) SCOK=0
 .D PID^VADPT6
 .S SCPTNM=$P(^DPT(DFN,0),U,1)
 .S ^TMP("SCTP MAIL LST",$J,SCTP,1,DFN)=("    "_SCPTNM_" ("_$G(VA("PID"))_")")
 .S ^TMP("SCTP MAIL LST",$J,SCTP,1,"B",SCPTNM,DFN)=""
 S SCPTNM=""
 F  S SCPTNM=$O(^TMP("SCTP MAIL LST",$J,SCTP,1,"B",SCPTNM)) Q:SCPTNM']""  D
 .S DFN=0
 .F  S DFN=$O(^TMP("SCTP MAIL LST",$J,SCTP,1,"B",SCPTNM,DFN)) Q:'DFN  D
 ..S SCDETAIL=$G(^TMP("SCTP MAIL LST",$J,SCTP,1,DFN)) Q:SCDETAIL']""  D SETLN(SCDETAIL)
BAD IF $O(@SCBADTP@(0)) D
 .D SETLN(" ")
 .D SETLN("There has been NO new position assignment for the following patients:")
 .S DFN=0
 .F  S DFN=$O(@SCBADTP@(DFN)) Q:'DFN  D
 ..S:$$PCMMXMY^SCAPMC25(3,DFN,,"SCTPDT",0) SCOK=0
 ..S SCPTNM=$P(^DPT(DFN,0),U,1)
 ..D PID^VADPT6
 ..S ^TMP("SCTP MAIL LST",$J,SCTP,2,DFN)=("    "_SCPTNM_" ("_$G(VA("PID"))_")")
 ..S ^TMP("SCTP MAIL LST",$J,SCTP,2,"B",SCPTNM,DFN)=""
 .S SCPTNM=""
 .F  S SCPTNM=$O(^TMP("SCTP MAIL LST",$J,SCTP,2,"B",SCPTNM)) Q:SCPTNM']""  D
 ..S DFN=0
 ..F  S DFN=$O(^TMP("SCTP MAIL LST",$J,SCTP,2,"B",SCPTNM,DFN)) Q:'DFN  D
 ...S SCDETAIL=$G(^TMP("SCTP MAIL LST",$J,SCTP,2,DFN)) Q:SCDETAIL']""  D SETLN(SCDETAIL)
 S XMDUZ=$G(DUZ,.5)
 D ^XMD
QTMULT K:$G(SCDELTEM) ^TMP("SCTP MAIL LST",$J,SCTP)
 K ^TMP($J,"SCTPXM")
 Q
