SCMCTMM ;ALB/REW - Patient Team Changes MailMessages ; 26 Mar 1996
 ;;5.3;Scheduling;**41,45,87,100,130,177**;AUG 13, 1993
 ;1
MAIL ;Do Patient Team Changes MailMan Message
 ; - called by SCMC PT TEAM CHANGES MAIL MESSAGE protocol
 G:$G(SCNOMAIL) END  ;- flag can be set to stop message generation
 N XMDUZ,XMY,XMSUB,XMTEXT,VA,VAERR,XMZ,Y,SCX,ZTQUEUED
 N SCTMAR,SCSTAT,DFN,SCNODE,SCY,SCSPACE,SCPAD,SCPHONE,SCB,SCE,SCB2,SCE2,SCTMDT,SCTMXM,SCPTNM,SCLNCNT
 S ZTQUEUED=1
 S $P(SCSPACE," ",80)=""
 ;   SCTMAR - ARRAY OF TEAMS (before & after)
 S:SCTMB4 SCTMAR(SCTMB4)=""
 S:SCTMAF SCTMAR(SCTMAF)=""
 IF 'SCTMAF D
 .S SCSTAT="DELETED",SCB=$P(SCTMB4,U,2),SCE=$S($P(SCPTTMB4,U,9):$P(SCPTTMB4,U,9),1:DT)
 IF 'SCTMB4 D
 .S SCSTAT="NEW",SCB=$P(SCTMAF,U,2),SCE=$S($P(SCPTTMAF,U,9):$P(SCPTTMAF,U,9),1:DT)
 IF SCTMB4&SCTMAF D
 .S SCSTAT="CHANGED"
 .S SCB=$P(SCTMB4,U,2),SCE=$S($P(SCPTTMB4,U,9):$P(SCPTTMB4,U,9),1:DT)
 .S SCB2=$P(SCTMAF,U,2),SCE2=$S($P(SCPTTMAF,U,9):$P(SCPTTMAF,U,9),1:DT)
 .S SCTMDT("BEGIN")=$S(SCB<SCB2:SCB,1:SCB2)
 .S SCTMDT("END")=$S(SCE>SCE2:SCE,1:SCE2)
 .S SCTMDT("INCL")=0
 IF SCSTAT="NEW"!(SCSTAT="DELETED") D
 .S SCTMDT("BEGIN")=SCB
 .S SCTMDT("END")=SCE
 .S SCTMDT("INCL")=0
 S DFN=$S(SCSTAT="DELETED":+SCPTTMB4,1:+SCPTTMAF)
 ;set xmy array for practitioners in positions receiving tmchg notices
 G:'$$PCMMXMY^SCAPMC25(3,DFN,"SCTMAR","SCTMDT",0) END
 D:'$G(DGQUIET) EN^DDIOL("Sending "_SCSTAT_" Patient-Team Assignment Message")
 D PID^VADPT6
 S SCPTNM=$P(^DPT(DFN,0),U,1)
 S XMSUB=SCSTAT_" PATIENT-TEAM ASSIGNMENT for Patient ("_$E(SCPTNM,1)_$G(VA("BID"))_")",XMTEXT="^TMP($J,""SCTMXM"",",SCLNCNT=0
 IF SCSTAT="NEW" D
 .D SETLN("Current Patient Team Data:")
 .D SETLN("==========================")
 .F SCX=1:1:14 D
 ..D SETLN($$TEXT(404.42,SCPTTMAF,SCX,SCSPACE,1))
 IF SCSTAT="DELETED" D
 .D SETLN("Previous Patient Team Data:")
 .D SETLN("===========================")
 .F SCX=1:1:14 S SCFLD=SCX*.01 D
 ..D SETLN($$TEXT(404.42,SCPTTMB4,SCX,SCSPACE,1))
 IF SCSTAT="CHANGED" D
 .D SETLN("Fields: "_$E(SCSPACE,1,15)_"Previous Data:             Current Patient Data:")
 .D SETLN("=======================================================================")
 .F SCX=1:1:14 S SCFLD=SCX*.01 D
 ..N SCLAB2,SCY,SCZ
 ..S SCY=$$TEXT(404.42,SCPTTMB4,SCX,SCSPACE,1)
 ..S:'$L(SCY) SCLAB2=2
 ..S SCZ=$$TEXT(404.42,SCPTTMAF,SCX,SCSPACE,+$G(SCLAB2))
 ..D:$L(SCY)!($L(SCZ)) SETLN(SCY_$E(SCSPACE,1,(50-$L(SCY)))_SCZ)
 S SCLNCNT=$$PCMAIL^SCMCMM(DFN,"^TMP($J,""SCTMXM"")",DT)
 S XMDUZ=$G(DUZ,.5)
 S XMY(XMDUZ)=""
 D ^XMD
END K ^TMP($J,"SCTMXM")
 Q
 ;
SETLN(TEXT) ;
 Q:$G(TEXT)=""
 ; increments SCLNCNT, adds text to sctmxm(sclncnt)
 S SCLNCNT=SCLNCNT+1
 S ^TMP($J,"SCTMXM",SCLNCNT)=TEXT
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
 .S SCX=$$DDNAME(SCFILE,SCFLD)_":"
 .S:$G(SCLAB)=1 SCX=SCX_$E(SCSPACE,1,(23-$L(SCX)))
 .S:$G(SCLAB)=2 SCX=SCX_$E(SCSPACE,1,(50-$L(SCX)))
 S:SCINT]"" SCX=SCX_$$EXTERNAL^DILFD(SCFILE,SCFLD,"",SCINT)
 ;adding SSN to the end of name for alpha 177
 I $P(SCX,":",1)="PATIENT" S SCX=SCX_"  ("_$G(VA("PID"))_")"
QTTXT Q SCX
 ;
DDNAME(FILE,FIELD) ;return the fieldname
 N SCX
 D FIELD^DID(FILE,FIELD,"","LABEL","SCX")
 Q $G(SCX("LABEL"))
 ;
MAILLST(SCTM,SCFIELDA,SCDATE,SCNEWTM,SCOLDTM,SCBADTM) ;
 ; Input:
 ;    SCTM     - Pointer to Team File (#404.51)
 ;    SCFIELDA - Field array with internal values
 ;    SCDATE   - Effective Date
 ;    SCNEWTM  - DFN array of newly assigned to team
 ;    SCOLDTM  - DFN array of previously assigned to team
 ;    SCBADTM  - DFN array of patients unassignable to team
 ;
 G:$G(SCNOMAIL) QTMULT  ;- flag can be set to stop message generation
 G:'$D(SCNEWTM) QTMULT
 G:'$O(@SCNEWTM@(0)) QTMULT  ;if no new assignments
 N XMDUZ,XMY,XMSUB,XMTEXT,VA,VAERR,XMZ,Y,ZTQUEUED
 N SCTMNM,DFN,SCOK,SCPTNM,SCFLD,SCNODE,SCNDX,SCSPACE,SCE,SCB,SCTMDT,SCDELTEM
 S ZTQUEUED=1
 S SCDELTEM=1 ;ok to delete tmp global
 IF $D(SCFIELDA) D
 .IF $D(SCFIELDA(.02)) S SCB=SCFIELDA(.02)
 .IF $D(SCFIELDA(.09)) S SCE=SCFIELDA(.09)
 S SCB=$G(SCB,DT)
 S SCE=$G(SCE,DT)
 S $P(SCSPACE," ",80)=""
 S SCTMDT("BEGIN")=$S(SCB<SCDATE:SCB,1:SCDATE)
 S SCTMDT("END")=$S(SCE>SCDATE:SCE,1:SCDATE)
 S SCTMDT("INCL")=0
 S SCTMNM=$P($G(^SCTM(404.51,+SCTM,0)),U,1)
 S XMSUB="Multiple PATIENT-TEAM ASSIGNMENT for "_SCTMNM,XMTEXT="^TMP($J,""SCTMXM"",",SCLNCNT=0
 D:'$G(DGQUIET) EN^DDIOL("Sending Multiple Patient-Team Assignment Message")
 S SCOK=1
 S SCTMNM=$P($G(^SCTM(404.51,+SCTM,0)),U,1)
 D SETLN("Team:                  "_SCTMNM)
 S Y=SCDATE X ^DD("DD")
 D SETLN("Effective Date:        "_Y)
 D SETLN(" ")
 IF $D(SCFIELDA) D
 .F SCNDX=1:1:14 S SCFLD=SCNDX*.01 IF $D(SCFIELDA(SCFLD)) D
 ..S $P(SCNODE,U,SCNDX)=SCFIELDA(SCFLD)
 ..D SETLN($$TEXT(404.42,SCNODE,SCNDX,SCSPACE,1))
 D SETLN(" ")
 D SETLN("There has been a new team assignment for the following patients:")
 S DFN=0
 F  S DFN=$O(@SCNEWTM@(DFN)) Q:'DFN  D
 .S:$$PCMMXMY^SCAPMC25(3,DFN,,"SCTMDT",0) SCOK=0
 .D PID^VADPT6
 .S SCPTNM=$P(^DPT(DFN,0),U,1)
 .S ^TMP("SCTM MAIL LST",$J,SCTM,1,DFN)=("    "_SCPTNM_" ("_$G(VA("PID"))_")")
 .S ^TMP("SCTM MAIL LST",$J,SCTM,1,"B",SCPTNM,DFN)=""
 S SCPTNM=""
 F  S SCPTNM=$O(^TMP("SCTM MAIL LST",$J,SCTM,1,"B",SCPTNM)) Q:SCPTNM']""  D
 .S DFN=0
 .F  S DFN=$O(^TMP("SCTM MAIL LST",$J,SCTM,1,"B",SCPTNM,DFN)) Q:'DFN  D
 ..S SCDETAIL=$G(^TMP("SCTM MAIL LST",$J,SCTM,1,DFN)) Q:SCDETAIL']""  D SETLN(SCDETAIL)
BAD IF $S('$D(SCBADTM):0,1:$O(@SCBADTM@(0))) D
 .D SETLN(" ")
 .D SETLN("There has been NO new team assignment for the following patients:")
 .S DFN=0
 .F  S DFN=$O(@SCBADTM@(DFN)) Q:'DFN  D
 ..S:$$PCMMXMY^SCAPMC25(3,DFN,,"SCTMDT",0) SCOK=0
 ..S SCPTNM=$P(^DPT(DFN,0),U,1)
 ..D PID^VADPT6
 ..S ^TMP("SCTM MAIL LST",$J,SCTM,2,DFN)=("    "_SCPTNM_" ("_$G(VA("PID"))_")")
 ..S ^TMP("SCTM MAIL LST",$J,SCTM,2,"B",SCPTNM,DFN)=""
 .S SCPTNM=""
 .F  S SCPTNM=$O(^TMP("SCTM MAIL LST",$J,SCTM,2,"B",SCPTNM)) Q:SCPTNM']""  D
 ..S DFN=0
 ..F  S DFN=$O(^TMP("SCTM MAIL LST",$J,SCTM,2,"B",SCPTNM,DFN)) Q:'DFN  D
 ...S SCDETAIL=$G(^TMP("SCTM MAIL LST",$J,SCTM,2,DFN)) Q:SCDETAIL']""  D SETLN(SCDETAIL)
 S XMDUZ=$G(DUZ,.5)
 D ^XMD
QTMULT K:$G(SCDELTEM) ^TMP("SCTM MAIL LST",$J,SCTM)
 K ^TMP($J,"SCTMXM")
 Q
