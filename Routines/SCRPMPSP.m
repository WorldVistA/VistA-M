SCRPMPSP        ;ALB/PDR - Team APIs:ACPTTP ; AUG 1998
 ;;5.3;Scheduling;**148,157,169,177**;AUG 13, 1993
 ;
ACPTTP(DFN,SCTP,SCFIELDA,SCACT,FASIEN,SCERR,SCYESTM,SCMAINA) ;add/edit a patient to a position (pt TP assgn - #404.43
 ; input:
 ;  DFN     = pointer to PATIENT file (#2)
 ;  SCTP    = pointer to TEAM POSTION file (#404.57) (DESTINATION POSITION)
 ;  SCFIELDA= array of extra field entries - scfielda('fld#')=value for 404.43
 ;  SCACT   = date to activate [default=DT]
 ;  FASIEN  = "FROM" position assignment IEN
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;  SCYESTM = Should team assignment be made, if none active now?[1=YES]
 ;  SCMAINA= array of extra field entries for 404.42
 ;
 ; Output:
 ;  Returned = ien of 404.43^new?^404.42 ien (new entries only)^new?^Message
 ;  SCERR()  = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 N SCESEQ,SCPARM,SCIEN,SC,HISTPTTP,SCFLD,SCTM,SCPTTMA,SCST,PATH
 N SCPTTPA,SCTMFLDA,SCNEWTP,SCNEWTM,SCAPTDT,SCAPTTPO,SCAPTTPE,SCMESS
 N SCLOCK,SCXLOCK,SCX
 ;
 ;
 I '$$OKDATA D ERROR(1,FASIEN,5) G APTTPQ
 ;
 I '$D(^XTMP("SCMC POS REASGN")) D
 . S ^XTMP("SCMC POS REASGN",0)=DT_U_DT_U_"POS REASGN PROCESS LOCK"
 . Q
 ;
 S SCXLOCK=0
 S SCLOCK="^XTMP(""SCMC POS REASGN"",DFN)"
 I $D(@SCLOCK) D ERROR(10,FASIEN,7) G APTTPQ
 S @SCLOCK=""
 S SCXLOCK=1
 H 1
 ;
        ;
 D INITVARS
 I '$$GETPLST D ERROR(2,FASIEN,10) G APTTPQ
 ;
 ;bp/cmf 177 new begin
 S SCX=$$OKPREC5^SCMCLK(SCTP,SCACT)
 I SCX<1 D ERROR($P(SCX,U,2),FASIEN,11) G APTTPQ
 ;bp/cmf 177 new end
 ;
 ; Business rule processing
 ;
 ; case 1
 I $$POSEXIST(.SCTM,SCTP,.SCPTTPA,.SCPTTMA) D  D SETP(1) G APTTPQ
 . ; destin pos asgn exists
 . I '$$PCPCASN^SCRPM21U(FASIEN,SCTP) D  D SETP(1.1) Q
 .. ; not PC to PC pos reasgn
 .. ;
 .. ; update pos asgn
 .. D UPDATPOS^SCRPM21U(.SCPTTPA,SCERR)
 .. I 'SCPTTPA D ERROR(3,SCPTTPA,12) Q
 .. ;
 .. ; update tm asgn
 .. I $$FUTMASN^SCRPM21U(SCPTTMA,SCACT)!$$FUTTMDIS^SCRPM21U(.SCPTTMA,SCACT) D  Q:'SCPTTMA
 ... D TMACTIV^SCRPM21U(.SCPTTMA,$$PCPOS)
 ... I 'SCPTTMA D ERROR(4,SCPTTMA,20)
 ... Q
 .. ;
 .. ; dschrg source pos
 .. D DISPOS^SCRPM21U(FASIEN,.SCPTTPA)
 .. I 'SCPTTPA D ERROR(5,SCPTTPA,30)
 .. Q
 . ;
 . ;  PC to PC pos reasgn
 . N SCFLAG
 . S SCFLAG=0
 . N SCY
 . S SCY=0
 . F  S SCY=$O(SCAPTTPO("SCTP",SCTM,SCTP,SCY)) Q:'SCY!(SCFLAG)  D
 .. S SCPTTPA=SCY
 .. S SCPTTMA=$$GETPOSTM^SCRPM21U(SCPTTPA)
 .. I '$D(^SCPT(404.43,SCPTTPA)) Q
 .. S SCFLAG=$$DPOSPROB^SCRPM21U(SCPTTPA,SCACT)
 .. I SCFLAG Q
 .. I '$D(^SCPT(404.42,SCPTTMA)) Q
 .. S SCFLAG=$$DTMPROB^SCRPM21U(SCPTTMA,SCACT)
 .. Q
 . Q:SCFLAG
 . ;
 . ; create new destin tm, pos asgns
 . D CREATETM^SCRPM21U(DFN,$$DSTTEAM,SCACT,.SCPTTMA)
 . I 'SCPTTMA D ERROR(6,SCPTTMA,40) Q
 . D CREATPOS^SCRPM21U(.SCPTTPA,SCPTTMA)
 . I 'SCPTTPA D ERROR(7,SCPTTPA,50) Q
 . ;
 . ; take care of source bookkeeping
 . D XALLPOS^SCRPM21U(FASIEN,.SCPTTPA)
 . I 'SCPTTMA D ERROR(8,SCPTTMA,60) Q
 . D DISTEAM^SCRPM21U($$SRCTEAM)
 . I 'SCPTTPA D ERROR(9,SCST,70) Q
 . Q
 ;
 ; case 2
 I $$TMEXIST^SCRPM21U(DFN,SCTM,SCACT,.SCPTTMA) D  D SETP(2) G APTTPQ
 . ; destin tm asgn exists
 . I $$PCPCASN^SCRPM21U(FASIEN,SCTP) D  D SETP(2.1) Q
 .. ; PC to PC tm reassgn
 .. ;
 .. ; take care of destin bookkeeping
 .. Q:$$DTMPROB^SCRPM21U(SCPTTMA,SCACT)
 .. ;
 .. ; create new destin tm, pos asgns
 .. D CREATETM^SCRPM21U(DFN,$$DSTTEAM,SCACT,.SCPTTMA)
 .. I 'SCPTTMA D ERROR(6,SCPTTMA,80) Q
 .. D CREATPOS^SCRPM21U(.SCPTTPA,.SCPTTMA)
 .. I 'SCPTTPA D ERROR(7,SCPTTPA,100) Q
 .. ;
 .. ; take care of source bookkeeping
 .. D XALLPOS^SCRPM21U(FASIEN,.SCPTTPA)
 .. I 'SCPTTMA D ERROR(8,SCPTTMA,105) Q
 .. D DISTEAM^SCRPM21U($$SRCTEAM)
 .. I 'SCPTTPA D ERROR(9,SCST,107) Q
 .. Q
 . ;
 . ;not PC to PC tm reassgn
 . ; update tm asgn 
 . I $$FUTMASN^SCRPM21U(.SCPTTMA,SCACT)!$$FUTTMDIS^SCRPM21U(.SCPTTMA,SCACT) D  Q:'SCPTTMA
 .. D TMACTIV^SCRPM21U(.SCPTTMA,$$PCPOS)
 .. I 'SCPTTMA D ERROR(4,SCPTTMA,120)
 .. Q
 . ;
 . ; create pos asgn
 . D CREATPOS^SCRPM21U(.SCPTTPA,.SCPTTMA)
 . I 'SCPTTPA D ERROR(7,SCPTTPA,130)
 . ;
 . ; dschrg source pos
 . D DISPOS^SCRPM21U(FASIEN,.SCPTTPA)
 . I 'SCPTTPA D ERROR(5,SCPTTPA,135)
 . Q
 ;
 ; case 3 
 ; no destin asgn
 I $$PCPCASN^SCRPM21U(FASIEN,SCTP) D  D SETP(3.1) G APTTPQ
 . ; PC to PC reasgn
 . ;
 . ; create new destin tm, pos asgns
 . D CREATETM^SCRPM21U(DFN,$$DSTTEAM,SCACT,.SCPTTMA)
 . I 'SCPTTMA D ERROR(6,SCPTTMA,140) Q
 . D CREATPOS^SCRPM21U(.SCPTTPA,SCPTTMA)
 . I 'SCPTTPA D ERROR(7,SCPTTPA,160)  Q
 . ;
 . ; take care of source bookkeeping
 . D XALLPOS^SCRPM21U(FASIEN,.SCPTTPA)
 . I 'SCPTTPA D ERROR(8,SCPTTMA,180) Q
 . D DISTEAM^SCRPM21U($$SRCTEAM)
 . I 'SCPTTPA D ERROR(9,SCST,185) Q
 . Q
 ;
 D SETP(3)
 ; not PC to PC reasgn
 ;
 ; create new destin tm, pos asgns
 D CREATETM^SCRPM21U(DFN,$$DSTTEAM,SCACT,.SCPTTMA)
 I 'SCPTTMA D ERROR(6,SCPTTMA,187) G APTTPQ
 D CREATPOS^SCRPM21U(.SCPTTPA,SCPTTMA)
 I 'SCPTTPA D ERROR(7,SCPTTPA,190) G APTTPQ
 ;
 ; dschrg source pos
 D DISPOS^SCRPM21U(FASIEN,.SCPTTPA)
 I 'SCPTTPA D ERROR(5,SCPTTPA,200)
 ;
APTTPQ ; All done
 D SAVPARMS
 I SCXLOCK=1 K @SCLOCK
 Q +$G(SCPTTPA)_U_+$G(SCNEWTP)_U_+$G(SCPTTMA)_U_+$P($G(SCPTTMA),U,2)_U_$G(SCMESS)
 ;
 ;
OKDATA()        ;setup/check variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK)
 IF '$D(^DPT(DFN,0))!('$D(^SCTM(404.57,SCTPTO,0))) D  S SCOK=0
 . S SCPARM("PATIENT")=DFN
 . S SCPARM("POSITION")=SCTPTO
 . D ERR^SCAPMCU1(SCESEQ,4045101,.SCPARM,"",SCERR)
 S:'$G(SCACT) SCACT=DT
 S:'$D(SCMAINA) SCMAINA="SC40443A"
 Q SCOK
 ;
INITVARS        ; INITIALIZE LOCAL VARIABLES
 S SCTM=$P($G(^SCTM(404.57,SCTP,0)),U,2) ; destin tm ien
 S SCAPTDT("BEGIN")=SCACT
 S SCAPTDT("END")=3990101
 S SCAPTDT("INCL")=0
 S SCST=$$GETPOSTM^SCRPM21U(FASIEN) ; source tm ien
 S SCPTTMA=""
 S SCMESS=""
 K @SCERR
 Q
 ;
GETPLST() ; get patient position list
 Q $$TPPT^SCAPMC(DFN,"SCAPTDT",,,,,0,"SCAPTTPO","SCAPTTPE")
 ;
POSEXIST(SCTM,SCTP,POSAIEN,TMIEN) ;
 ; if active pos asgn, return ien
 N DISDT,SCX,SCY,SCFLAG
 S TMIEN=""
 S SCTM=+$P($G(^SCTM(404.57,SCTP,0)),U,2)  ;ptr to 404.51
 ;
 S SCFLAG=0
 S POSAIEN=0
 ;
 S SCX=0
 F  S SCX=$O(SCAPTTPO("SCTP",SCTM,SCTP,SCX)) Q:'SCX!(SCFLAG)  D
 . S SCY=$O(SCAPTTPO("SCTP",SCTM,SCTP,SCX,0))
 . S DISDT=$P(SCAPTTPO(SCY),U,6)
 . I DISDT=SCACT Q  ;pos is discharged
 . S TMIEN=$$GETPOSTM^SCRPM21U(SCX) ; tm asgn ien
 . S DISDT=$P($G(^SCPT(404.42,TMIEN,0)),U,9)
 . I DISDT,DISDT'>SCACT Q  ;tm is discharged
 . S SCFLAG=1
 . S POSAIEN=SCX
 . Q
 ;
 I SCFLAG Q POSAIEN
 Q 0_U_$O(SCAPTTPO("SCTP",SCTM,SCTP,0))
 ;
ERROR(TXT,IEN,ENUM)     ; HANDLE ERRORS FOR REPORTING
 I +TXT S TXT=$P($T(T+TXT),";;",2)
 S SCMESS=" "_TXT_" [E#"_ENUM_"]"
 ; NVS - use below for more detailed ien and path data
 ;I $P(IEN,U,1)=0 S IEN=$P(IEN,U,2)
 ;S SCMESS=TXT_" [(IEN="_IEN_") E#"_ENUM_" PTH:"_$G(PATH)_"]"
 ;S ^TMP("PDR",$J,"POSREASGN",$H,DFN)=SCMESS
 Q
 ;
T ;;
1 ;;Data Integrity error.;;
2 ;;Unable to get positions list.;;
3 ;;Unable to activate existing position.;;
4 ;;Unable to activate existing team.;;
5 ;;Unable to discharge source position.;;
6 ;;Unable to create destination team.;;
7 ;;Unable to create destination position.;;
8 ;;Unable to discharge all positions for PC source team.;;
9 ;;Unable to discharge PC source team.;;
10 ;;Patient is being reassigned by another PCMM process.;;
 ;;
 ;
SAVPARMS ; save params for debugging
 ; NVS - comment out the quit to save path/variable data
 Q
 N S,F,NVP
 S S=""
 S S=$O(^TMP("PDR",S),-1)+1 ; get next occurence
 S ^TMP("PDR",S,$J,"INIT")=DFN_U_SCTP_U_SCACT_U_FASIEN_U_SCYESTM ; initial params passed in
 S F="",NVP=""
 F  S F=$O(@SCFIELDA@(F)) Q:F=""  S NVP=NVP_F_"="_@SCFIELDA@(F)_U  ; Get the params passed in for new pos
 S ^TMP("PDR",S,$J,"NPOS")=NVP
 S F="",NVP=""
 F  S F=$O(@SCMAINA@(F)) Q:F=""  S NVP=NVP_F_"="_@SCFIELDA@(F)_U  ; Get the params passed in for new TEAM
 S ^TMP("PDR",S,$J,"NTEAM")=NVP
 S ^TMP("PDR",S,$J,"NASSGN")=$G(SCPTTPA)_U_$G(SCPTTMA)_U_$G(PATH)_U_$G(SCMESS)_U_$H ; conserve new pos and team assigns if present
 Q
 ;
SETP(BR) ; SET PATH INDICATOR FOR DEBUGGING
 ; NVS - comment out the quit to save path/variable data
 Q
 S PATH=$G(PATH)_BR_"-"
 Q
 ;
SRCTEAM()       ; return source tm ien
 ; value set in INITVARS
 Q SCST
 ;
DSTTEAM()       ; return destin tm ien
 Q SCTM
 ;
PCPOS() ; IS THIS A PC POSITION?
 Q $G(@SCFIELDA@(.05),0)
 ;
