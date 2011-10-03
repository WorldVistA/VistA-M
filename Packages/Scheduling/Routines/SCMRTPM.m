SCMRTPM ;ALB/REW/PDR/cmf - Patient Position Changes MailMessages ; nov 1998
 ;;5.3;Scheduling;**148,157**;AUG 13, 1993
 ;
 ;
MAILLST(SCTP,SCFIELDA,SCDATE,SCBADTP,SCFTP)   ;
 ; Input:
 ;    SCTP     - Pointer to Team Position File (#404.57)
 ;    SCFIELDA - Field array with internal values
 ;    SCDATE   - Effective Date
 ;    SCBADTP  - DFN array of patients unassignable to position
 ;    SCFTP    - Pointer to 404.57 ('from' team ien)
 ;
 G:$G(SCNOMAIL) QTMULT  ;- flag can be set to stop message generation
 G:'$D(SCBADTP) QTMULT
 G:'$O(@SCBADTP@(0)) QTMULT  ;if no BAD REassignments
 N XMDUZ,XMY,XMSUB,XMTEXT,VA,VAERR,XMZ,Y,SCTPDT,ZTQUEUED
 N DFN,SCOK,SCPTNM,SCFLD,SCNODE,SCNDX,SCSPACE,SCE,SCB
 N SCTPNM,SCTMNM,SCFTPNM,SCFTMNM,SCDELTEM,SCDETAIL
 S ZTQUEUED=1
 S DELTEM=1 ;ok to delete tmp global
 S $P(SCSPACE," ",80)=""
 S XMSUB="Multiple PATIENT-POSITION REASSIGNMENT FAILURES for "_$$POSNAME(+SCTP)
 S XMTEXT="^TMP($J,""SCTPXM"","
 S SCLNCNT=0
 S SCOK=1
 D SETLN("Team:                  "_$$TMNAME(+SCTP))
 D SETLN("Position:              "_$$POSNAME(+SCTP))
 D SETLN("Effective Date:        "_$$FMTE^XLFDT(SCDATE))
 D SETLN("Total Processed:       "_$$PASSCNT^SCMCBK5(DFNA))
 D SETLN("From Team:             "_$$TMNAME(+SCFTP))
 D SETLN("From Position:         "_$$POSNAME(+SCFTP))
 D SETLN(" ")
 IF $D(SCFIELDA) D
 .F SCNDX=1:1:14 S SCFLD=SCNDX*.01 IF $D(SCFIELDA(SCFLD)) D
 ..S $P(SCNODE,U,SCNDX)=SCFIELDA(SCFLD)
 ..D SETLN($$TEXT(404.43,SCNODE,SCNDX,SCSPACE,1))
 D SETLN(" ")
BAD IF $O(@SCBADTP@(0)) D
 .D SETLN(" ")
 .;;D SETLN("There has been NO new position reassignment for the following patients:")
 .D SETLN("The following position reassignments did not complete processing:")
 .S DFN=0
 .F  S DFN=$O(@SCBADTP@(DFN)) Q:'DFN  D
 ..S SCPTNM=$P(^DPT(DFN,0),U,1)
 ..D PID^VADPT6
 ..S ^TMP("SCTP MAIL LST",$J,SCTP,2,DFN)=(" "_SCPTNM_" ("_$G(VA("PID"))_")")
 ..S ^TMP("SCTP MAIL LST",$J,SCTP,3,DFN)=" "_@SCBADTP@(DFN)
 ..S ^TMP("SCTP MAIL LST",$J,SCTP,2,"B",SCPTNM,DFN)=""
 .S SCPTNM=""
 .F  S SCPTNM=$O(^TMP("SCTP MAIL LST",$J,SCTP,2,"B",SCPTNM)) Q:SCPTNM']""  D
 ..S DFN=0
 ..F  S DFN=$O(^TMP("SCTP MAIL LST",$J,SCTP,2,"B",SCPTNM,DFN)) Q:'DFN  D
 ...S SCDETAIL=$G(^TMP("SCTP MAIL LST",$J,SCTP,2,DFN)) Q:SCDETAIL']""  D SETLN(SCDETAIL)
 ...S SCDETAIL=$G(^TMP("SCTP MAIL LST",$J,SCTP,3,DFN)) Q:SCDETAIL']""  D SETLN(SCDETAIL)
 S XMDUZ="PCMM Reassignment"
 K XMY S XMY(DUZ)=""
 S SCX=$O(^SD(404.91,"B",0))_","
 I +SCX S XMY("G."_$$GET1^DIQ(404.91,SCX,804))=""
 D ^XMD
QTMULT  K:$G(SCDELTEM) ^TMP("SCTP MAIL LST",$J,SCTP)
 K ^TMP($J,"SCTPXM")
 Q
 ;
 ;----------------------------- subs ------------------------------------
 ;
SETLN(TEXT)     ;
 Q:$G(TEXT)=""
 ; increments SCLNCNT, adds text to scTPxm(sclncnt)
 S SCLNCNT=SCLNCNT+1
 S ^TMP($J,"SCTPXM",SCLNCNT)=TEXT
 Q
 ;
TEXT(SCFILE,SCNODE,SCPC,SCSPACE,SCLAB)  ;returns fldname & external value
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
QTTXT   Q SCX
 ;
DDNAME(FILE,FIELD)      ;return the fieldname
 N SCX
 D FIELD^DID(FILE,FIELD,"","LABEL","SCX")
 Q $G(SCX("LABEL"))
 ;
POSNAME(SCX) ; return position external name
 Q $P($G(^SCTM(404.57,+SCX,0)),U)
 ;
TMNAME(SCX) ; return team external name
 Q $P($G(^SCTM(404.51,+$P($G(^SCTM(404.57,+SCX,0)),U,2),0)),U)
 ;
                   
