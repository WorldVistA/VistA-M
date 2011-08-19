SCMRTMM ;ALB/REW/PDR - Patient Team Multiple Reasssignment MailMessages ; 17 JUL 98
 ;;5.3;Scheduling;**148,157**;AUG 13, 1993
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
 . S SCX=$$DDNAME(SCFILE,SCFLD)_":"
 . S:$G(SCLAB)=1 SCX=SCX_$E(SCSPACE,1,(23-$L(SCX)))
 . S:$G(SCLAB)=2 SCX=SCX_$E(SCSPACE,1,(50-$L(SCX)))
 S:SCINT]"" SCX=SCX_$$EXTERNAL^DILFD(SCFILE,SCFLD,"",SCINT)
QTTXT Q SCX
 ;
DDNAME(FILE,FIELD) ;return the fieldname
 N SCX
 D FIELD^DID(FILE,FIELD,"","LABEL","SCX")
 Q $G(SCX("LABEL"))
 ;
MAILLST(SCTM,SCFIELDA,SCDATE,SCBADTM) ; Reports only reassignment failures
 ; Input:
 ;    SCTM     - Pointer to Team File (#404.51)
 ;    SCFIELDA - Field array with internal values
 ;    SCDATE   - Effective Date
 ;    SCBADTM  - DFN array of patients unassignable to team
 ;
 G:$G(SCNOMAIL) QTMULT  ;- flag can be set to stop message generation
 G:'$S('$D(SCBADTM):0,1:$O(@SCBADTM@(0))) QTMULT  ; bail out if nothing to print
 N XMDUZ,XMY,XMSUB,XMTEXT,VA,VAERR,XMZ,Y,ZTQUEUED
 N SCTMNM,DFN,SCOK,SCPTNM,SCFLD,SCNODE,SCNDX,SCSPACE,SCE,SCB,SCTMDT,SCDELTEM
 S ZTQUEUED=1
 S SCDELTEM=1 ;ok to delete tmp global
 IF $D(SCFIELDA) D
 . IF $D(SCFIELDA(.02)) S SCB=SCFIELDA(.02)
 . IF $D(SCFIELDA(.09)) S SCE=SCFIELDA(.09)
 S SCB=$G(SCB,DT)
 S SCE=$G(SCE,DT)
 S $P(SCSPACE," ",80)=""
 S SCTMDT("BEGIN")=$S(SCB<SCDATE:SCB,1:SCDATE)
 S SCTMDT("END")=$S(SCE>SCDATE:SCE,1:SCDATE)
 S SCTMDT("INCL")=0
 S SCTMNM=$P($G(^SCTM(404.51,+SCTM,0)),U,1)
 S XMSUB="Multiple PATIENT-TEAM REASSIGNMENT FAILURES for "_SCTMNM,XMTEXT="^TMP($J,""SCTMXM"",",SCLNCNT=0
 D:'$G(DGQUIET) EN^DDIOL("Sending Multiple Patient-Team Reassignment Failures Message")
 S SCOK=1
 S SCTMNM=$P($G(^SCTM(404.51,+SCTM,0)),U,1)
 D SETLN("Team:                  "_SCTMNM)
 S Y=SCDATE X ^DD("DD")
 D SETLN("Effective Date:        "_Y)
 D SETLN(" ")
 IF $D(SCFIELDA) D
 . F SCNDX=1:1:14 S SCFLD=SCNDX*.01 IF $D(SCFIELDA(SCFLD)) D
 .. S $P(SCNODE,U,SCNDX)=SCFIELDA(SCFLD)
 .. D SETLN($$TEXT(404.42,SCNODE,SCNDX,SCSPACE,1))
 D SETLN(" ")
BAD ; Guts of message
 D SETLN(" ")
 D SETLN("There has been NO new team reassignment for the following patients:")
 S DFN=0
 F  S DFN=$O(@SCBADTM@(DFN)) Q:'DFN  D
 . ;;;S:$$PCMMXMY^SCAPMC25(3,DFN,,"SCTMDT",0) SCOK=0
 . S SCPTNM=$P(^DPT(DFN,0),U,1)
 . D PID^VADPT6
 . S ^TMP("SCTM MAIL LST",$J,SCTM,2,DFN)=(" "_SCPTNM_" ("_$G(VA("PID"))_")")_":"
 . S ^TMP("SCTM MAIL LST",$J,SCTM,3,DFN)=" "_@SCBADTM@(DFN)
 . S ^TMP("SCTM MAIL LST",$J,SCTM,2,"B",SCPTNM,DFN)=""
 S SCPTNM=""
 F  S SCPTNM=$O(^TMP("SCTM MAIL LST",$J,SCTM,2,"B",SCPTNM)) Q:SCPTNM']""  D
 . S DFN=0
 . F  S DFN=$O(^TMP("SCTM MAIL LST",$J,SCTM,2,"B",SCPTNM,DFN)) Q:'DFN  D
 .. S SCDETAIL=$G(^TMP("SCTM MAIL LST",$J,SCTM,2,DFN)) Q:SCDETAIL']""  D SETLN(SCDETAIL)
 .. S SCDETAIL=$G(^TMP("SCTM MAIL LST",$J,SCTM,3,DFN)) Q:SCDETAIL']""  D SETLN(SCDETAIL)
 S XMDUZ="PCMM Reassignment"
 K XMY S XMY(DUZ)=""
 S SCX=$O(^SD(404.91,"B",0))_","
 I +SCX S XMY("G."_$$GET1^DIQ(404.91,SCX,804))=""
 D ^XMD
QTMULT ;
 K:$G(SCDELTEM) ^TMP("SCTM MAIL LST",$J,SCTM)
 K ^TMP($J,"SCTMXM")
 Q
