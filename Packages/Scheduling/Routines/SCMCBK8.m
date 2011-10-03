SCMCBK8 ;bp/cmf - multiple patient assignments mail queue - RPCVersion = 1;;Aug 7, 1998
 ;;5.3;Scheduling;**148,177,210**;AUG 13, 1993
 Q
 ;
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
 ;
 N SCESEQ,SCPARM,SCIEN,SC,HISTPTTP,SCFLD,SCTM,SCPTTMA,SCPTTPA,SCTMFLDA
 N SCNEWTP,SCNEWTM,SCAPTDT,SCAPTTPO,SCAPTTPE,SCMESS
 N SCLOCK,SCXLOCK,SCX
 ;
 ;check/setup variables
 I '$$OKDATA^SCAPMC21 S SCMESS=$$S(9) G APTTPQ
 ;
 ;bp/cmf 210 new begin
 ;lock process/dfn/pos
 I '$D(^XTMP("SCMC POS ASGN")) D
 . S ^XTMP("SCMC POS ASGN",0)=DT_U_DT_U_"POS ASGN PROCESS LOCK"
 . Q
 ;
 S SCXLOCK=0
 S SCLOCK="^XTMP(""SCMC POS ASGN"",DFN)"
 I $D(@SCLOCK) S SCMESS=$$S(15) G APTTPQ
 S @SCLOCK=""
 S SCXLOCK=1
 H 1
 ;
 ;stop if active assignment
 S SCPTTPA=$$HISTPTTP^SCAPMCU2(DFN,SCTP,SCACT)
 I SCPTTPA S SCMESS=$$S(10) G APTTPQ
 ;bp/cmf 210 new end
 ;
 S SCTM=$P($G(^SCTM(404.57,SCTP,0)),U,2)
 S SCAPTDT("BEGIN")=SCACT
 S SCAPTDT("END")=3990101
 S SCAPTDT("INCL")=0
 ;
 ;is patient alive?
 I $$DP^SCMCBK6(DFN) S SCMESS=$$S(1) G APTTPQ
 ;
 S SCX=$$OKPREC5^SCMCLK(SCTP,SCACT)
 I SCX<1 S SCMESS=$P(SCX,U,2) G APTTPQ
 ;
 ;is PC role assignable?
 I $$T1(),'$$CHKPC^SCAPMC21(DFN) S SCMESS=$$S(12) G APTTPQ
 ;
 I '$$TPPT^SCAPMC(DFN,"SCAPTDT",,,,,0,"SCAPTTPO","SCAPTTPE") S SCMESS=$$S(13)  G APTTPQ
 S SCPTTPA=$O(SCAPTTPO("SCTP",SCTM,SCTP,0))
 ;
 ;to edit existing entry
 I SCPTTPA D  G APTTPQ
 .S SC($J,404.43,(+SCPTTPA)_",",.03)=SCACT
 .I $D(SCFIELDA) D
 ..S SCFLD=0
 ..F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 ...S SC($J,404.43,(+SCPTTPA)_",",SCFLD)=@SCFIELDA@(SCFLD)
 ...Q
 ..Q
 .D FILE^DIE("","SC($J)",SCERR)
 .Q
 ;
 ;needed: patient team assignment for date
 S SCPTTMA=+$$HISTPTTM^SCAPMCU2(DFN,SCTM,SCACT)
 ;
 ; if flag is set to add patient to team & no pt tm assignment exists
 I ('SCPTTMA)&($G(SCYESTM))&($D(SCFIELDA)) D
 .S:$D(@SCFIELDA@(.05)) @SCMAINA@(.08)=$G(@SCMAINA@(.08),$S(@SCFIELDA@(.05):1,1:99))
 .S:$D(@SCFIELDA@(.06)) @SCMAINA@(.11)=$G(@SCMAINA@(.11),@SCFIELDA@(.06))
 .S:$D(@SCFIELDA@(.07)) @SCMAINA@(.12)=$G(@SCMAINA@(.12),@SCFIELDA@(.07))
 .S:$D(@SCFIELDA@(.08)) @SCMAINA@(.13)=$G(@SCMAINA@(.13),@SCFIELDA@(.08))
 .S:$D(@SCFIELDA@(.09)) @SCMAINA@(.14)=$G(@SCMAINA@(.14),@SCFIELDA@(.09))
 .S SCPTTMA=+$$ACPTTM^SCAPMC(DFN,SCTM,.SCMAINA,SCACT,SCERR)
 .Q
 ;
TM I 'SCPTTMA S SCMESS=$$S(14) G APTTPQ
 ;
 I $D(SCFIELDA) D
 .S SCFLD=0
 .F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 ..S SC($J,404.43,"+1,",SCFLD)=@SCFIELDA@(SCFLD)
 ..Q
 .Q
 ;
 S SC($J,404.43,"+1,",.01)=SCPTTMA
 S SC($J,404.43,"+1,",.02)=SCTP
 S SC($J,404.43,"+1,",.03)=SCACT
 N SCTPERR
 D UPDATE^DIE("","SC($J)","SCIEN","SCTPERR")
 ;
 I $D(SCTPERR) S SCMESS=$$S(11) K SCIEN
 E  D
 .S SCPTTPA=+$G(SCIEN(1))
 .S SCNEWTP=1
 .D AFTERTP^SCMCDD1(SCPTTPA)
 .Q
 ;
APTTPQ ;bp/cmf 210 new code begin
 I SCXLOCK=1 K @SCLOCK
 ;bp/cmf 210 new code end
 Q +$G(SCPTTPA)_U_+$G(SCNEWTP)_U_+$G(SCPTTMA)_U_+$P($G(SCPTTMA),U,2)_U_$G(SCMESS)
 ;
T1() Q $S('$D(SCFIELDA):0,'$D(@SCFIELDA@(.05)):0,($G(@SCFIELDA@(.05))=1):1,($G(@SCFIELDA@(.05))=2):1,1:0)
 ;
S(SCX) Q $$S^SCMCBK6(SCX)
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
 ;
 N DFN,SCCNT,SCX,SCNOMAIL,SCTOTCNT
 S SCNOMAIL=1
 S SCCNT=0
 S SCTOTCNT=$$PASSCNT^SCMCBK5(DFNA)
 I SCTOTCNT=0 G MAIL
 S DFN=0
 F  S DFN=$O(@DFNA@(DFN)) Q:'DFN  D
 .S SCX=$$ACPTTP(.DFN,.SCTP,.SCFIELDA,.SCACT,.SCERR,.SCYESTM)
 .;
 .;newly assigned
 .I $P(SCX,U,2)=1 D  Q
 ..S SCCNT=SCCNT+1
 ..S @SCNEWTP@(DFN)=+SCX
 ..S:$P(SCX,U,4) @SCNEWTM@(DFN)=$P(SCX,U,3)
 ..Q
 .;
 .;already assigned
 .;I $P(SCX,U,1)&('$P(SCX,U,2)) D
 .I +SCX D  Q 
 ..S SCCNT=SCCNT+1
 ..S @SCOLDTP@(DFN)=+SCX
 ..Q
 .;
 .;not assigned;;I 'SCX D 
 .S @SCBADTP@(DFN)=$P(SCX,U,5)
 .Q
 ;
MAIL K SCNOMAIL
 D MAILLST^SCMCBK9(SCTP,.SCADDFLD,DT,.SCNEWTP,.SCOLDTP,.SCBADTP,SCTOTCNT)
 Q SCCNT
 ;
