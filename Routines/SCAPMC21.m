SCAPMC21 ;ALB/REW - Team APIs:ACPTTP ; 5 Jul 1995
 ;;5.3;Scheduling;**41,148,177**;AUG 13, 1993
 ;;1.0
ACPTTP(DFN,SCTP,SCFIELDA,SCACT,SCERR,SCYESTM,SCMAINA) ;add/edit a patient to a position (pt TP assgn - #404.43
 ; input:
 ;  DFN     = pointer to PATIENT file (#2)
 ;  SCTP    = pointer to TEAM POSTION file (#404.57)
 ;  SCFIELDA= array of extra field entries - scfielda('fld#')=value
 ;  SCACT   = date to activate [default=DT]
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;  SCYESTM = Should team assignment be made, if none active now?[1=YES]
 ;  SCMAINA= array of extra field entries for 404.42 (only if scyestm=1)
 ;
 ; Output:
 ;  Returned = ien of 404.43^new?^404.42 ien (new entries only)^new?^Message
 ;  SCERR()  = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 N SCESEQ,SCPARM,SCIEN,SC,HISTPTTP,SCFLD,SCTM,SCPTTMA,SCPTTPA
 N SCTMFLDA,SCNEWTP,SCNEWTM,SCAPTDT,SCAPTTPO,SCAPTTPE,SCMESS,SCX
 G:'$$OKDATA APTTPQ ;check/setup variables
 S SCTM=$P($G(^SCTM(404.57,SCTP,0)),U,2)
 ;S SCPTTPA=$$HISTPTTP^SCAPMCU2(DFN,SCTP,SCACT)
 S SCAPTDT("BEGIN")=SCACT
 S SCAPTDT("END")=3990101
 S SCAPTDT("INCL")=0
 IF $S('$D(SCFIELDA):0,'$D(@SCFIELDA@(.05)):0,($G(@SCFIELDA@(.05))=1):1,($G(@SCFIELDA@(.05))=2):1,1:0) IF '$$CHKPC(DFN) D  G APTTPQ
 .S SCMESS=4044300.001
 ;bp/cmf 177 new begin
 S SCX=$$OKPREC5^SCMCLK(SCTP,SCACT)
 I SCX<1 S SCMESS=$P(SCX,U,2) G APTTPQ
 ;bp/cmf 177 new end
 G:'$$TPPT^SCAPMC(DFN,"SCAPTDT",,,,,0,"SCAPTTPO","SCAPTTPE") APTTPQ
 S SCPTTPA=$O(SCAPTTPO("SCTP",SCTM,SCTP,0))
 ;to edit existing entry
 IF SCPTTPA D  G APTTPQ
 .S SC($J,404.43,(+SCPTTPA)_",",.03)=SCACT
 .IF $D(SCFIELDA) D
 ..S SCFLD=0
 ..F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 ...S SC($J,404.43,(+SCPTTPA)_",",SCFLD)=@SCFIELDA@(SCFLD)
 .D FILE^DIE("","SC($J)",SCERR)
 ;needed: patient team assignment for date
 S SCPTTMA=+$$HISTPTTM^SCAPMCU2(DFN,SCTM,SCACT)
 ; if flag is set to add patient to team & no pt tm assignment exists
 ;
 IF ('SCPTTMA)&($G(SCYESTM))&($D(SCFIELDA)) D
 .S:$D(@SCFIELDA@(.05)) @SCMAINA@(.08)=$G(@SCMAINA@(.08),$S(@SCFIELDA@(.05):1,1:99))
 .S:$D(@SCFIELDA@(.06)) @SCMAINA@(.11)=$G(@SCMAINA@(.11),@SCFIELDA@(.06))
 .S:$D(@SCFIELDA@(.07)) @SCMAINA@(.12)=$G(@SCMAINA@(.12),@SCFIELDA@(.07))
 .S:$D(@SCFIELDA@(.08)) @SCMAINA@(.13)=$G(@SCMAINA@(.13),@SCFIELDA@(.08))
 .S:$D(@SCFIELDA@(.09)) @SCMAINA@(.14)=$G(@SCMAINA@(.14),@SCFIELDA@(.09))
 .S SCPTTMA=+$$ACPTTM^SCAPMC(DFN,SCTM,.SCMAINA,SCACT,SCERR)
TM IF 'SCPTTMA G APTTPQ
 ELSE  D
 .IF $D(SCFIELDA) D
 ..S SCFLD=0
 ..F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 ...S SC($J,404.43,"+1,",SCFLD)=@SCFIELDA@(SCFLD)
 .S SC($J,404.43,"+1,",.01)=SCPTTMA
 .S SC($J,404.43,"+1,",.02)=SCTP
 .S SC($J,404.43,"+1,",.03)=SCACT
 .D UPDATE^DIE("","SC($J)","SCIEN",SCERR)
 .IF $D(@SCERR) K SCIEN
 .ELSE  D
 ..S SCPTTPA=+$G(SCIEN(1))
 ..S SCNEWTP=1
 ..D AFTERTP^SCMCDD1(SCPTTPA)
APTTPQ Q +$G(SCPTTPA)_U_+$G(SCNEWTP)_U_+$G(SCPTTMA)_U_+$P($G(SCPTTMA),U,2)_U_$G(SCMESS)
 ;
ACPTATP(DFNA,SCTP,SCFIELDA,SCACT,SCERR,SCYESTM,SCMAINA,SCNEWTP,SCNEWTM,SCOLDTP,SCBADTP) ;list of patients to a position (pt TP assgn - #404.43 and possibly #404.42
 ; input: as per ACPTTP (above with the following change:)
 ;    DFNA    = is the literal value of a patient array (e.g. "scpt"
 ;              there is at least one scpt(dfn)="" defined
 ;    SCNEWTP = Subset of DFNA that was NEWLY assigned to a Position
 ;    SCNEWTM = Subset of DFNA that was NEWLY assigned to a Team
 ;    SCOLDTP = Subset of DFNA that was already assigned to Position
 ;    SCBADTP = Subset of DFNA that was NOT assigned to Position
 ; output: Count of Patients (New or Old) assigned to Position
 N DFN,SCCNT,SCX,SCNOMAIL
 S SCNOMAIL=1
 S SCCNT=0
 S DFN=0 F  S DFN=$O(@DFNA@(DFN)) Q:'DFN  D
 .S SCX=$$ACPTTP(.DFN,.SCTP,.SCFIELDA,.SCACT,.SCERR,.SCYESTM)
 .;  SCX = ien of 404.43^new?^404.42 ien (new entries only)^new?
 .IF $P(SCX,U,2) D  ;newly assigned
 ..S SCCNT=SCCNT+1
 ..S @SCNEWTP@(DFN)=+SCX   ;scnewtp
 ..S:$P(SCX,U,4) @SCNEWTM@(DFN)=$P(SCX,U,3)  ;scnewtm
 .IF $P(SCX,U,1)&('$P(SCX,U,2)) D  ;old
 ..S SCCNT=SCCNT+1
 ..S @SCOLDTP@(DFN)=+SCX
 .IF 'SCX D
 ..S @SCBADTP@(DFN)=$P(SCX,U,5)
 K SCNOMAIL
 D MAILLST^SCMCTPM(SCTP,.SCADDFLD,DT,.SCNEWTP,.SCOLDTP,.SCBADTP)
 Q SCCNT
 ;
OKDATA() ;setup/check variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK)
 IF '$D(^DPT(DFN,0))!('$D(^SCTM(404.57,SCTP,0))) D  S SCOK=0
 . S SCPARM("PATIENT")=DFN
 . S SCPARM("POSITION")=SCTP
 . D ERR^SCAPMCU1(SCESEQ,4045101,.SCPARM,"",.SCERR)
 S:'$G(SCACT) SCACT=DT
 S:'$D(SCMAINA) SCMAINA="SC40443A"
 Q SCOK
CHKPC(DFN) ;not stand-alone
 N SCOK,SCX
 S SCOK=1
 G:@SCFIELDA@(.05)=0 QTCKPC  ;ignore if no pc role
 S SCX=$$PCRLPTTP^SCMCTPU2(DFN,SCTP,SCACT)
 IF @SCFIELDA@(.05)=1 D
 .S:'SCX SCOK=0
 IF @SCFIELDA@(.05)=2 D
 .S:'$P(SCX,U,2) SCOK=0
QTCKPC Q SCOK
