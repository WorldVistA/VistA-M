OOPSGUI0 ;WIOFO/LLH-RPC routines ;01/02/02
 ;;2.0;ASISTS;**2,4,7,15**;Jun 03, 2002;Build 9
 ;
GETCASE(RESULTS,PERSON,CSTAT,PSTAT,CALL,OPT) ; Subroutine for Case Selection
 ; Returns a list of cases that can be displayed for selection
 ; RESULTS = return array containing, CASE#^IEN^NAME^DATE TIME OCCUR
 ; PERSON  = 0^ if no person selected
 ;           1^PERSON INVOLVED NAME
 ;           2^SUPERVISOR DUZ
 ;           3^USER SSN
 ;           4^CASE NUMBER
 ; CSTAT   = #^#^#^#  0^1^2^3 0=open, 1=closed, 2=deleted, 3=replaced
 ;           99^ if all Case Status should be included
 ;           CSTAT is only set programatically
 ; PSTAT   = 0^  if all personnel status types should be included
 ;           #^#^#^ for each personnel status selected
 ; CALL    = Calling menu, used to assure proper access
 ; OPT     = Option called from, used to assure proper access
 ; 
 K ^TMP("OOPSCASE",DUZ)
 N ARR,CNUM,OOPSDA,PER,STA,SUP,VIEWSUP,VIEWEMP,VALSSN
 I $G(PERSON)="" Q
 I +PERSON=1 D GETPER,SORT G EXIT
 I +PERSON=4 D  G EXIT
 . S CNUM=$P($G(PERSON),U,2) I '$G(CNUM) Q
 . S OOPSDA=$O(^OOPS(2260,"B",CNUM,"")) I '$G(OOPSDA) D  Q
 .. S ^TMP("OOPSCASE",DUZ,1)="No Cases Selectable"
 .. S RESULTS=$NA(^TMP("OOPSCASE",DUZ))
 ..; S RESULTS(0)="No Cases Selectable"
 . S STA=$$GET1^DIQ(2260,OOPSDA,51,"I")
 . I +CSTAT'=99,(CSTAT'[STA_"^") Q  ;allow only selected case status
 . I $$CALLER() S ARR(CNUM)=OOPSDA
 . D SORT
 S CNUM=0
 F  S CNUM=$O(^OOPS(2260,"B",CNUM)) Q:CNUM=""  D
 . S OOPSDA=""
 . F  S OOPSDA=$O(^OOPS(2260,"B",CNUM,OOPSDA)) Q:OOPSDA=""  D
 .. I +PERSON=3 D  Q:'VIEWEMP
 ... S VIEWEMP=1,VALSSN=$P($G(PERSON),U,2)
 ... I $$GET1^DIQ(2260,OOPSDA,5,"I")'=VALSSN  D
 .... S VIEWEMP=0
 .... S ^TMP("OOPSCASE",DUZ,1)="No Cases Selectable"
 .... S RESULTS=$NA(^TMP("OOPSCASE",DUZ))
 .. S STA=$$GET1^DIQ(2260,OOPSDA,51,"I")
 .. I +CSTAT'=99,(CSTAT'[STA_"^") Q  ;allow only selected case status
 .. S PER=$$GET1^DIQ(2260,OOPSDA,2,"I")
 .. I (+PSTAT)&(PSTAT'[(PER_"^")) Q      ;allow only selected per status
 .. I +PERSON=2 D  Q:'VIEWSUP
 ... S VIEWSUP=1,SUP=$P(PERSON,U,2)
 ... I $$GET1^DIQ(2260,OOPSDA,53,"I")'=SUP,($$GET1^DIQ(2260,OOPSDA,53.1,"I")'=SUP) D  Q
 ....; S RESULTS(0)="No Cases Selectable",VIEWSUP=0
 .... S ^TMP("OOPSCASE",DUZ,1)="No Cases Selectable",VIEWSUP=0
 .... S RESULTS=$NA(^TMP("OOPSCASE",DUZ))
 .. I $$CALLER() S CNUM=$$GET1^DIQ(2260,OOPSDA,.01),ARR(CNUM)=OOPSDA
 D SORT
EXIT ; quit the routine
 Q
GETPER ; Person Name passed in, match
 ; See above for documentation
 N NM
 S OOPSDA="",NM=$P(PERSON,U,2)
 F  S OOPSDA=$O(^OOPS(2260,"C",NM,OOPSDA)) Q:OOPSDA=""  D
 . S STA=$$GET1^DIQ(2260,OOPSDA,51,"I")
 . I +CSTAT'=99,(CSTAT'[STA_"^") Q  ;allow only selected case status
 . S PER=$$GET1^DIQ(2260,OOPSDA,2,"I")
 . I (+PSTAT)&(PSTAT'[(PER_"^")) Q      ;allow only selected per status
 . I $$CALLER() S CNUM=$$GET1^DIQ(2260,OOPSDA,.01),ARR(CNUM)=OOPSDA
 Q
CALLER() ; Check to make sure case should be included
 N EES,ESTAT,FLD,INC,SIG,SSN,VIEWC
 S VIEWC=1
 S INC=$$GET1^DIQ(2260,OOPSDA,52,"I")
 ; get users SSN 
 S SSN=$$GET1^DIQ(200,DUZ,9)
 ; make sure user cannot access claim from any menu but Employee
 I CALL'="E",($$GET1^DIQ(2260,OOPSDA,5,"I")=SSN) S VIEWC=0 Q VIEWC
 ; Claim already sent to DOL, can't edit, Caller / Option doesnt matter
 ; unless the Option = "CHGCASE"
 ; Patch 4 llh - should also be able to create amendment.  NOTE: Case
 ;               status should always = open
 ; patch 7 llh - allow access if also opt=iocome
 I ($$GET1^DIQ(2260,OOPSDA,66)'=""),(OPT'="CHGCASE"),(OPT'="PRINTCA"),(OPT'=2162),(OPT'="CRAMEND"),(OPT'="IOCOME") S VIEWC=0 Q VIEWC
 ; for any option from the supervisor menu
 I CALL="S" D  I 'VIEWC Q VIEWC
 . I $$GET1^DIQ(2260,OOPSDA,53,"I")'=DUZ,($$GET1^DIQ(2260,OOPSDA,53.1,"I")'=DUZ) S VIEWC=0 Q
 ; if opt = 2162
 I OPT=2162 D  Q VIEWC
 . I $$GET1^DIQ(2260,OOPSDA,51,"I")=1 S VIEWC=0  ; closed, can't edit
 . ; signed SO, coming from Supervisor menu, cant access
 . I (CALL="S"),+$$EDSTA^OOPSUTL1(OOPSDA,"O") S VIEWC=0
 . I CALL="H" D
 .. I $P($$EDSTA^OOPSUTL1(OOPSDA,"S"),U,3)!(+$$EDSTA^OOPSUTL1(OOPSDA,"O")) S VIEWC=0
 . I CALL="W" D
 .. I +$$EDSTA^OOPSUTL1(OOPSDA,"O") S VIEWC=0   ;safety signed cant see
 ; if opt = CA1 only return/allow CA1's, caller doesnt matter
 I OPT="CA1",INC'=1 S VIEWC=0 Q VIEWC
 ; if opt = CA2 only return/allow CA2's, caller doesnt matter
 I OPT="CA2",INC'=2 S VIEWC=0 Q VIEWC
 I CALL="E" D  Q VIEWC
 . I '$$ISEMP^OOPSUTL4(OOPSDA) S VIEWC=0 Q
 . I '$G(SSN) S VIEWC=0 Q
 . I $D(^OOPS(2260,"SSN",SSN))<1 S VIEWC=0 Q
 . ; user SSN must = case IEN from Employee menu
 . I $$GET1^DIQ(2260,OOPSDA,5,"I")'=SSN S VIEWC=0 Q
 . S SIG=$$EDSTA^OOPSUTL1(OOPSDA,"S")
 . I (OPT'="PRINTCA"),$P(SIG,U,INC) S VIEWC=0 Q
 I CALL="S" D  Q VIEWC
 . ; not Super or Sec Super, can't access form, regardless of form type
 . I $$GET1^DIQ(2260,OOPSDA,53,"I")'=DUZ&($$GET1^DIQ(2260,OOPSDA,53.1,"I")'=DUZ) S VIEWC=0 Q
 . ; Supervisor cannot complete their own form.
 . I $$GET1^DIQ(2260,OOPSDA,5,"I")=SSN S VIEWC=0 Q
 . I OPT="CA1"!(OPT="CA2") D  Q
 .. ; if form CA, must be employee to complete
 .. I '$$ISEMP^OOPSUTL4(OOPSDA) S VIEWC=0 Q
 .. ; commented out next 2 lines, ? whether wanted by TAG 11/1/01 llh
 .. ; Employee hasn't signed, super can't get to
 .. ; I '$P($$EDSTA^OOPSUTL1(OOPSDA,"E"),U,INC) S VIEWC=0 Q
 .. ; Supervisor has signed, can't re-edit
 .. I $P($$EDSTA^OOPSUTL1(OOPSDA,"S"),U,INC) S VIEWC=0 Q
 I CALL="O"!(CALL="W")!(CALL="H") D  Q VIEWC
 . I OPT="CA1"!(OPT="CA2") D  Q
 .. I '$$ISEMP^OOPSUTL4(OOPSDA) S VIEWC=0 Q
 . I OPT="WCSIGN" D  Q
 .. S ESTAT=$$EDSTA^OOPSUTL1(OOPSDA,"E")
 .. I '$$ISEMP^OOPSUTL4(OOPSDA) S VIEWC=0 Q
 .. I CALL'="W",$P(ESTAT,U,INC) S VIEWC=0 Q
 .. I CALL="W" D
 ... S FLD=$S(INC=1:119,INC=2:221,1:"") I 'FLD S VIEWC=0 Q
 ... S EES=$$GET1^DIQ(2260,OOPSDA,FLD,"I")
 ... ; employee hasn't signed, ok for WC to sign
 ... I 'EES Q
 ... ; employee signed, not signed by person accessing claim, no access
 ... I EES'=DUZ S VIEWC=0 Q
 ... I $P($$EDSTA^OOPSUTL1(OOPSDA,"S"),U,INC) S VIEWC=0 ;Sup Sign, no acc
 . I OPT="WCEMPSIGN" D  Q
 .. N CALLER,SVIEW
 .. S CALLER=CALL
 .. I $$GET1^DIQ(2260,OOPSDA,51,"I") S VIEWC=0 Q    ; claim must be open
 .. ;V2_P15 02/13/08 llh - remove requirement Safety or Occ Health must sign first
 .. ;I $$GET1^DIQ(2260,OOPSDA,77)="" S VIEWC=0 Q
 .. ;I $$GET1^DIQ(2260,OOPSDA,80)="" S VIEWC=0 Q
 .. S SVIEW=$$SCR^OOPSWCSE(OOPSDA) I 'SVIEW S VIEWC=0 Q
 I CALL="U" D  Q VIEWC
 . I '+$$EDSTA^OOPSUTL1(OOPSDA,"O") S VIEWC=0 Q
 . I '$P($$EDSTA^OOPSUTL1(OOPSDA,"S"),U,3) S VIEWC=0 Q
 Q VIEWC
SORT ; put cases in reverse number order
 N CN,CNUM,OOPSDA,SSN,DOI
 S ^TMP("OOPSCASE",DUZ,0)="",CNUM="",CN=1
 I '$D(ARR) S RESULTS(0)="No Cases Selectable"  D
 . S ^TMP("OOPSCASE",DUZ,1)="No Cases Selectable",VIEWSUP=0
 . S RESULTS=$NA(^TMP("OOPSCASE",DUZ))
 F  S CNUM=$O(ARR(CNUM),-1) Q:CNUM=""  D
 . S OOPSDA=ARR(CNUM)
 . S NM=$$GET1^DIQ(2260,OOPSDA,1)
 . S DOI=$$GET1^DIQ(2260,OOPSDA,4)
 . S SSN=$$GET1^DIQ(2260,OOPSDA,5)
 . I CALL="U" S (NM,DOI,SSN)=""
 . S ^TMP("OOPSCASE",DUZ,CN)=CNUM_U_DOI_U_NM_U_OOPSDA_U_SSN_$C(10),CN=CN+1
 S RESULTS=$NA(^TMP("OOPSCASE",DUZ))
 Q
