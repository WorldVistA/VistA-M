SCMRBK  ;ALB/SCK - Broker Utilities for multiple patient reassignments; 4/8/96
 ;;5.3;Scheduling;**148,157,204**;AUG 13, 1993
 ;
 Q
 ;
PTGET(SCDATA,SC)        ;  Return a block of patients to the client
 ;     'SC GET PAT BLOCK'
 ;
 ;     SCJOB   = $J for the ^TMP global
 ;     SCJOBID = The second subscript id for the ^TMP global
 ;     SCSTART = Beginning entry number for the block retrieval in the ^TMP global
 ;     SCEND   = The ending entry number for the block retrieval
 ;     SCLAST  = The last entry number in the ^TMP global
 ;
 ; This RPC returns a list of patients from the temp global that was built by
 ; by the call to either SCMC BLD POS PAT LIST or SCMC BLD TEAM PAT LIST
 ;
 N SCJOB,SCSTART,SCEND,I,SCLAST,SCJOBID
 ;
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 D PARSE^SCMCBK1(.SC)
 ;
 F I=SCSTART:1:SCEND Q:'$G(^TMP(SCJOB,SCJOBID,I),0)  D
 . S SCDATA(I)=^TMP(SCJOB,SCJOBID,I)
 I SCEND>SCLAST K ^TMP(SCJOB,SCJOBID)
 ;
 D CLRVAR^SCMCBK1
 Q
 ;
 ; This is invoked after the Save button is clicked in Patient reasignment-both team and pos
 ; RPC - SC BLD REASSIGN PAT LST
PTLSTBLD(SCOK,SCVAL) ;  Build the list of patients to be assigned in the ^TMP($J,"SCPATIENT LIST",DFN) global
 ;  'SC BLD PAT LIST'
 ;
 N SCJOB,SCDFN
 ;
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 S SCOK=0
 I SCVAL["Start" D  G PTBLDQ
 . S SCOK=$J
 . K ^TMP(SCOK,"SC PATIENT LIST")
 ; 
 S SCJOB=$P(SCVAL,U,1)
 S SCDFN=$P(SCVAL,U,2)
 S ^TMP(SCJOB,"SC PATIENT LIST",SCDFN)=$P(SCVAL,U,3) ; equals assignment IEN (PDR)
 S SCOK=1
PTBLDQ  ;
 Q
 ;
 ; This is invoked by RPC (SC FILE PAT TM REASGN) for team reasignment
 ;
PTFILE(SCOK,SC) ;  File the patient assignments in the ^TMP($J,"SC TEAM ASSIGN",SCDFN) global
 ;    'SCMC FILE PAT TM REASGN'
 ;
 N SCADDFLD,SCTEAM,SCFILE,SCJOB,SCNEW,SCOLD,SCBAD,SCERMSG,SCX,SCDTVAR,SCOTH
 N ZTPRI,ZTRTN,ZTDESC,ZTDTH,SCNOW
 ;
 D CHK^SCUTBK
 D TMP^SCUTBK ; this sets up a DUZ=.5 and a DT of the current date
 D NOW^%DTC
 S SCNOW=% ; get actual FM date/time for enter/edit documentation
 ;
 D PARSE^SCMCBK1(.SC)
 G:+$G(SCJOB)=0 FILEQ
 ;
 ; Additional fields for 404.42 PATIENT TEAM ASSIGNMENT FILE
 S SCADDFLD(.08)=$G(SC("TYPE"),99)
 S SCADDFLD(.1)=$G(SC("RESTRICT"),0)
 ; note, the fields below are not appropriate if team is being activated or modified. Be sure
 ; to kill as necessary before filing, and to add edit by and edit D/T where necessary - PDR
 S SCADDFLD(.11)=DUZ ; user entering
 S SCADDFLD(.12)=SCNOW ; entry date/time (changed from =DT - PDR)
 ;
 I $G(SC("BKG"))="1" D BKG(1) Q  ;Bail out to run in background
 ; 
BKGTM   ; Run Team Reassignment Filer in BKG
 I $D(ZTQUEUED) S SCJOB=$J  ; want to use Task Manager assigned $J if BKG
 S SCX=$$ACPTRATM^SCAPMR6("^TMP(SCJOB,""SC PATIENT LIST"")",SCTEAM,SCFRMTM,.SCOTH,"SCADDFLD",SCDTVAR,"SCERMSG","SCNEW","SCOLD","SCBAD")
 I '$D(ZTQUEUED) D
 . D BAD^SCMCBK1(.SCBAD,.SCOLD,.SCOK) ; this sets up RPC return var SCOK for error report dialog
 . S SCOK(.1)=SCX_U_"FORE"
 ;
 K ^TMP(SCJOB,"SC PATIENT LIST")
 D CLRVAR^SCMCBK1
 ;
FILEQ Q
 ;
 ; This is invoked by RPC ('SC FILE PAT POS REASGN') for position reasignment
POSFILE(SCOK,SC)        ;  File the patient assignments in the ^TMP($J,"SC PATIENT LIST") global 
 ;   ' SCMC FILE PAT POS REASGN '
 ;
 N SCADDFLD,SCTEAM,SCFILE,SCJOB,SCNEW,SCOLD,SCBAD,SCERMSG,SCX
 N SCPOSTO,SCPOSFRM,SCDTVAR,SCMAFLD,SCADTM,SCNEW1,SCNOW
 ;
 D CHK^SCUTBK
 D TMP^SCUTBK
 S SCNOW=$$NOW^XLFDT
 ;
 D PARSE^SCMCBK1(.SC)
 S SCPOSTO=SC("POSITION")
 S SCPOSFRM=SC("FROMPOSITION")
 G:+$G(SCJOB)=0 FILEQ
 S SCADTM=1
 ;
 S SCADDFLD(.05)=$G(SC("TYPE"),0)
 S SCADDFLD(.06)=DUZ
 S SCADDFLD(.07)=SCNOW
 ;
 I $G(SC("BKG"))="1" D BKG(2) Q
 ;
BKGPOS  ;   BACKGROUND JOB ENTRY POINT
 I $D(ZTQUEUED) S SCJOB=$J  ;  want to use Task Manager assigned $J if BKG
 S SCX=$$ACPTATP^SCAPMR21("^TMP(SCJOB,""SC PATIENT LIST"")",SCPOSTO,SCPOSFRM,"SCADDFLD",SCDTVAR,"SCERMSG",SCADTM,"","SCNEW","SCNEW1","SCOLD","SCBAD")
 ;
 I '$D(ZTQUEUED) D
 . D BAD2^SCMCBK1(.SCBAD,.SCOLD,.SCOK) ; this sets up RPC return var SCOK for error report dialog
 . S SCOK(.1)=SCX_U_"FORE"
 ;
 K ^TMP(SCJOB,"SC PATIENT LIST")
 D CLRVAR^SCMCBK1
 Q
 ;
BLKPOS  ;
 N SCX
 S SCX=$G(SCDTRNG("END"))
 S SCDTRNG("END")=3990101 ;check forever
 S SCOK1=$$PTTP^SCAPMC(SCBLOCK,"SCDTRNG","^TMP(""SCMC"",$J,""EXCLUDE PT"")","SCER2")
 S SCDTRNG("END")=SCX
 Q
 ;
BLKTM   ;
 N SCX
 S SCX=$G(SCDTRNG("END"))
 S SCDTRNG("END")=3990101 ;check forever
 S SCOK1=$$PTTM^SCAPMC(SCBLOCK,"SCDTRNG","^TMP(""SCMC"",$J,""EXCLUDE PT"")","SCER2")
 S SCDTRNG("END")=SCX
 Q
 ;
 ; This is used to get the patient list to fill the list box after team and position selection
 ;
PTPOSLST(SCOK,SC)       ; Get a list of of patients for a team position
 ;  RPC:'SCMC BLD POS PAT LIST'
 ;
 N PD,FD,TD,ASNST,FC
 D NEWVAR^SCMCBK1
 D CHK^SCUTBK
 D TMP^SCUTBK
 S FD=SC("FROMDATE")
 S TD=SC("TODATE")
 S ASNSTAT=SC("ASSIGNSTAT") ; 0=assigned only, 1=Discharged only, 2=both
 ;
 D PARSE^SCMCBK1(.SC)
 ;
 K ^TMP($J,"SCPOS")
 ;
 S SCOK=0
 ; This date setting could be accomplished on GUI using the .MULT[] broker array, and
 ; loaded into SCDTRNG via the call to parse. I've opted to set the array explicitly
 ; here.
 S SCDTRNG("BEGIN")=FD
 S SCDTRNG("END")=TD
 S SCDTRNG("INCL")=0
 ; get list of pt active for time period specified
 ; future discharges included
 S SCOK=$$PTTP^SCAPMC11(SCFRMPOS,"SCDTRNG",.SCLOC,.SCERMSG)
 K ^TMP("SCMC",$J,"EXCLUDE PT")
 M ^TMP($J,"SC PCMM IN")=@SCLOC
 ;
 S I1=$G(^TMP($J,"SC PCMM IN",0))
 S FC=0 ; initialize filtered count of patients
 F I=1:1:I1 D
 . S PD=$G(^TMP($J,"SC PCMM IN",I)) ; get the discharge date
 . Q:$$FILTOUT(+$P(PD,U,5),+$P(PD,U,4))
 . S ^TMP($J,"PCMM TMP",I)=$G(^TMP($J,"SC PCMM IN",I))
 . S FC=FC+1
 D ALPHA^SCAPMCU2("^TMP($J,""PCMM TMP"")","^TMP($J,""SCPOS"")")
 S SCOK=$J_U_FC_U_SCOK
 ;
 D CLRVAR^SCMCBK1
 Q
 ;
FILTOUT(DD,AD)  ; FILTER OUT CANDIDATE PATIENTS
 ;bp/cmf 204t0 -- SCDTVAR(def = dt) replaces DT 
 ; Want actives only
 Q:ASNSTAT=0 ((DD)&(DD'>SCDTVAR))!(AD>SCDTVAR)
 ; ; disch date before tomorrow, or assign date greater than today 
 ;
 ; Want discharges between dates only
 Q:ASNSTAT=1 (DD>TD)!(DD<FD)
 ; ; disch date is after TO date, or discharge date is before FROM date
 ;
 ; Want discharges and actives from date
 Q:ASNSTAT=2 (DD&(DD<FD))!(AD>SCDTVAR)
 ; ; disch date less than FROM date, or assign date > dtvar
 Q 0
 ;
 ; 
 ; used to get the patient list after a team selection
 ;
PTTMLST(SCOK,SC)        ; ; Get a list of of patients for a team - FILTER FOR ACTIVE
 ;  RPC:'SCMC BLD TEAM PAT LIST' 
 ;
 ;bp/cmf 204t0 -- SCDTVAR(def = dt) replaces DT 
 N TD,SCDD
 D NEWVAR^SCMCBK1
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 D PARSE^SCMCBK1(.SC)
 K ^TMP($J,"SCTEAM")
 ;
 S SCOK=0
 ; get list of patient team assignments ordered by q
 S SCOK=$$PTTM^SCAPMC2(SCFRMTM,"SCDTRNG",.SCLOC,"SCERMSG")  ; SCLOC = ^TMP("SCTMP LIST",$J)
 K ^TMP("SCMC",$J,"EXCLUDE PT")
 M ^TMP($J,"SC PCMM IN")=@SCLOC
 ;
 S I=""
 F  S I=$O(^TMP($J,"SC PCMM IN",I)) Q:'I  D
 . S TD=^TMP($J,"SC PCMM IN",I)
 . S SCDD=$P(TD,U,5)
 . Q:(SCDD'="")&(SCDD'>SCDTVAR)  ; filter discharged assignments
 . Q:$P(TD,U,4)>SCDTVAR  ; filter future assignments
 . S ^TMP($J,"PCMM TMP",I)=^TMP($J,"SC PCMM IN",I)
 ;
 D ALPHA^SCAPMCU2("^TMP($J,""PCMM TMP"")","^TMP($J,""SCTEAM"")")
 ;
 S SCOK=$J_U_+$O(^TMP($J,"SCTEAM",""),-1)_U_SCOK
 ;
 D CLRVAR^SCMCBK1
 Q
 ;
DISCHPOS(SCOK,SC)       ; DISCHARGE POSITIONS FOR A TEAM - RPC: PDR SC DIS TEAM POS
 ; SC("DFN") = ptr to patient file
 ; SC("TMASGN") = ptr to team assignment file 404.42
 ; SC("DATE") = file date (date selected on client)
 N SCBEGIN,SCEND,SCINCL,SCDATES,SCERR
 D CHK^SCUTBK
 D TMP^SCUTBK
 S SCOK=1
 S SCERR="SCERRMSG"
 K @SCERR ;;bp/cmf 204 clean error array!!!!!!!!!!  [iow-0899-40854]
 D DISCHPOS^SCRPMTA(SC("DFN"),SC("TMASGN"),SC("DATE"),SCERR)
 S SCOK='$D(@SCERR)
 Q
 ;
BKG(SCX) ;hand off to taskman
 ;input SCX=toggle between team/position reassignment
 ;
 S ZTPRI=10
 S ZTRTN=$P($$S(SCX),"::")
 S ZTDESC=$P($$S(SCX),"::",2)
 S ZTDTH=$H
 S ZTSAVE("SC*")=""
 S ZTSAVE("^TMP($J,")=""
 I '$G(SC("NOP")) D ^%ZTLOAD ; define NOP on GUI side if don't want BKG
 S SCOK(0)=1_U_"BKG"_$G(ZTSK)
 S SCOK(.1)=$$PASSCNT^SCMCBK5($$S(3))_U_"BKG"_U_$G(SC("NOP"))
 Q
 ;
S(SCX) Q $P($T(T+SCX),";;",2)
 ;
T ;;
 ;;BKGTM^SCMRBK::PCMM TEAM REASSIGN BKG
 ;;BKGPOS^SCMRBK::PCMM POSITION REASSIGN BKG
 ;;^TMP($J,"SC PATIENT LIST")
 ;
