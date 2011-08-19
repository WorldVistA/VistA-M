OOPSUTL1 ;HINES/WAA-Utilities Routines ;3/24/98
 ;;2.0;ASISTS;**8**;Jun 03, 2002
 ;;
EMP(IEN,SSN,OPEN) ; DIC filter for Employee enter edit
 ;This is a screening routine that will filter
 ;  out those entries that the user cannot see.
 ; Input:
 ;  IEN  is the internal entry number for the entry in 2260.
 ;  SSN is the Employee Number in file 200
 ;=========================================
 ;  VIEW is an indicator telling if the user can enter/edit
 ;       this entry
 ;
 N VIEW
 S VIEW=0
 S OPEN=$G(OPEN,0)
 I $$OPEN(IEN,OPEN) D  ;Record
 .I $$GET1^DIQ(2260,IEN,5,"I")=SSN D  ; Is this record for this employee
 ..N SIG,INC
 ..S SIG=$$EDSTA^OOPSUTL1(IEN,"S")
 ..S INC=$$GET1^DIQ(2260,IEN,52,"I")
 ..I '$P(SIG,U,INC) S VIEW=1 ; Super has not signed
 ..I $$GET1^DIQ(2260,IEN,67)'="" S VIEW=0  ; Patch 8, no edit if to DOL
 .Q
 Q VIEW
WS ; The following 4 subroutines are added with Patch 8 - DOL project
 ; Sets the "W" xref. A routine call is used to prevent the inadvertent
 ; re-indexing of xref.  Xref is used for determining which records
 ; should be included in transmission of claims to DOL.  When the record
 ; is placed in a Mailman message (WC xref set) this xref is killed.
 ; Variables
 ;           WOK = set in OOPSWCE, used to prevent inadvertent
 ;                 re-indexing of ^OOPS(2260,"AW",X,IEN)
 ;           IEN = uses IEN for DA of file 2260
 ;           X   = field 67 (DUZ)
 I '$D(WOK) Q
 I '$D(IEN) D  Q
 . S MSG("DIHELP",1)="Required Cross Reference (""AW"") was not set up, call your IRM."
 . D MSG^DIALOG("WH","","","","MSG")
 S ^OOPS(2260,"AW",X,IEN)=""
 Q
WK ; Kills the "AW" xref.  See above as reason for manually setting
 ;           WOK = set in OOPSWCE, used to prevent inadvertent reindex
 ;           IEN = uses IEN for DA of file 2260
 ;           X   = field 67, file 2260 = DUZ
 N WCDUZ
 I '$D(WOK) Q
 I '$D(IEN) D  Q
 . S MSG("DIHELP",1)="Required Cross Reference (""AW"") was not properly destroyed, call your IRM."
 . D MSG^DIALOG("WH","","","","MSG")
 ; V2.0 temp fix to keep duplicate entries out of x-ref
 S WCDUZ=""
 F  S WCDUZ=$O(^OOPS(2260,"AW",WCDUZ)) Q:WCDUZ=""  D
 . I $D(^OOPS(2260,"AW",WCDUZ,IEN)) K ^OOPS(2260,"AW",WCDUZ,IEN)
 Q
WCS ; Sets the "AWC" xref. A routine call is used to prevent inadvertent
 ; re-indexing of the xref.  Xref is used for determining which records
 ; were included in Mailman messages that transmitted claims to DOL
 ; Variables
 ;           WOK = set in OOPSWCE, used to prevent inadvertent
 ;                 re-indexing of ^OOPS(2260,"AW",DUZ,IEN)
 ;           IEN = record ID file 2260
 ;           X   = field 66 - Date Transmitted to DOL
 N WCDUZ
 I '$D(WOK) Q
 I '$D(IEN) D  Q
 . S MSG("DIHELP",1)="Required Cross Reference (""AWC"") was not set up, call your IRM."
 . D MSG^DIALOG("WH","","","","MSG")
 S ^OOPS(2260,"AWC",X,IEN)=""
 ; V2.0 temp fix to keep duplicate entries out of x-ref
 S WCDUZ=""
 F  S WCDUZ=$O(^OOPS(2260,"AW",WCDUZ)) Q:WCDUZ=""  D
 . I $D(^OOPS(2260,"AW",WCDUZ,IEN)) K ^OOPS(2260,"AW",WCDUZ,IEN)
 Q
WCK ; Kills the "AWC" xref.  See above as reason for manually setting
 ;           WOK = set in OOPSWCE, used to prevent inadvertent reindex
 ;           IEN = uses IEN for DA of file 2260
 ;           X   = field 66 - Date Transmitted to DOL
 I '$D(WOK) Q
 I '$D(IEN) D  Q
 . S MSG("DIHELP",1)="Required Cross Reference (""AWC"") was not properly destroyed, call your IRM."
 . D MSG^DIALOG("WH","","","","MSG")
 K ^OOPS(2260,"AWC",X,IEN)
 Q
OPEN(IEN,OPEN) ; Determine if record is open
 N VIEW
 S OPEN=$G(OPEN,0)
 S VIEW=0
 I $G(^OOPS(2260,IEN,0))="" Q VIEW
 I 'OPEN,'$P(^OOPS(2260,IEN,0),U,6) S VIEW=1
 I OPEN,$P(^OOPS(2260,IEN,0),U,6)'=2 S VIEW=1
 Q VIEW
EDSTA(IEN,CALLER) ; Gives the status of form to allows the user to
 ;Inputs:
 ; IEN is the internal entry number for the entry in 2260.
 ; CALLER is the type of user who is calling the routine.
 ;   "E" = EMPLOYEE
 ;   "S" = SUPERVISOR
 ;   "O" = SAFETY
 ;   "V" = VOLUNTEER
 ;
 ;   ======================================
 ;Outputs
 ;   If the Caller is Employee:
 ;   SELECT=1^1 Both FORMS have been signed
 ;          0^0 Neither form has been signed
 ;          1^0 CA1 has been signed
 ;          0^1 CA2 has been signed
 ;   If caller is Supervisor:
 ;   SELECT=1^1^1 all FORMS have been signed
 ;          0^0^0 no form has been signed
 ;          1^0^0 CA1 has been signed
 ;          0^1^0 CA2 has been signed
 ;          0^0^1 2162 has been signed
 ;   If caller is Safety Officer
 ;   SELECT=1 File has been signed
 ;          0 File has not been signed
 ;   If caller is Volunteer Supervisor
 ;   SELECT=1 File has been signed
 ;          0 File has not been signed
 N SELECT,CA1,CA2,ACCD
 S SELECT=""
 I CALLER="S" D
 .N LINE
 .S LINE=""
 .F I=170,266,45 D
 ..S LINE=LINE_$S($$GET1^DIQ(2260,IEN,I,"I")'="":1,1:0)_U
 ..Q
 .S SELECT=$P(LINE,U,1,3)
 .Q
 I CALLER="E" S SELECT=$S($$GET1^DIQ(2260,IEN,120,"I")'="":1,1:0)_U_$S($$GET1^DIQ(2260,IEN,222,"I")'="":1,1:0)
 I CALLER="O" S SELECT=$S($$GET1^DIQ(2260,IEN,49,"I")'="":1,1:0)_U
 Q SELECT
 ;
EDSEL(IEN,CALLER) ; Allow you to select the form part to edit
 ;
 ;
 ; IEN is the internal entry number for the entry in 2260.
 ; CALLER is the type of user who is calling the routine.
 ;   "E" = EMPLOYEE
 ;   "S" = SUPERVISOR
 ;   "O" = SAFETY OFFICER
 ; 
 ;
 N SELECT,EEFORM,CNT,Y,SEC
 S CNT=0
 S SELECT="",SEC="0^0",FORM=""
 S EEFORM=$$EDSTA(IEN,CALLER)
 I CALLER="E" S SEC=$$EDSTA^OOPSUTL1(IEN,"S")
 W @IOF,!!,?10,"Select Forms: "
 I CALLER="S" S CNT=CNT+1 W !,?20,CNT,") Form 2162" S FORM=FORM_"2162^"
 I '$P(SEC,U,1) S CNT=CNT+1 W !,?20,CNT,") ",$S($P(EEFORM,U)=1:"Edit",1:"Enter")," form CA1 (Injury)" S FORM=FORM_"CA1^"
 I '$P(SEC,U,2) S CNT=CNT+1 W !,?20,CNT,") ",$S($P(EEFORM,U,2)=1:"Edit",1:"Enter")," form CA2 (Illness)" S FORM=FORM_"CA2^"
 I CNT=1 S Y="1,"
 E  D
 .W !!!
 .N DIR
 .S DIR("A")=" Select Forms"
 .S DIR(0)="L^1:"_CNT
 .D ^DIR
 I +Y F I=1:1 Q:$P(Y,",",I)<1  S SELECT=SELECT_$P(FORM,U,$P(Y,",",I))_"^"
 Q SELECT
CLRES(IEN,CALLER,FORM) ; Clean out electronic SIG
 ;Input
 ;   IEN = Internal Entry Number from file 2260
 ;   CALLER is the type of user who is calling the routine.
 ;     "E" = EMPLOYEE
 ;     "S" = SUPERVISOR
 ;     "O" = SAFETY OFFICER
 ;     "W" = WORKER'S COMP OFFICIAL
 ;   FORM Is the form to clear out ES
 ;     Safety Officer = 2162
 ;     Supervisor = CA1,CA2 and 2162
 ;     Employee = CA1 and CA2, DUAL  ;patch 5 added DUAL
 ;     Workers Comp = CA1 and CA2, DUAL
 ;
 ;   DOL = 1 if call from ^OOPSUTL6 to suppress printing cleared msg. 
 ;
 N SIG,NODE,FIELD,FLG,CALL
 Q:FORM=""
 S FLG=""
 ; patch 5 llh - added D block logic and new form DUAL
 I CALLER="W" D
 . S SIG="WCES;1,3"
 . I FORM="DUAL" S SIG="DUAL;10,12"
 I CALLER="O" S SIG=$S(FORM="2162":"2162ES;4,6",1:"")
 S:CALLER="S" SIG=$S(FORM="CA1":"CA1ES;4,6",FORM="CA2":"CA2ES;4,6",FORM="2162":"2162ES;1,3",1:"")
 ; patch 5 llh - added logic for DUAL
 S:CALLER="E" SIG=$S(FORM="CA1":"CA1ES;1,3",FORM="CA2":"CA2ES;1,3",FORM="DUAL":"DUAL;7,9",1:"")
 Q:SIG=""
 S NODE=$P(SIG,";") Q:NODE=""
 S FIELD=$P(SIG,";",2)
 S CALL=$S(CALLER="W":2,CALLER="O":1,CALLER="S":1,CALLER="E":2,1:"")
 I 'CALL Q
 I '$D(^OOPS(2260,IEN,NODE)) Q
 I CALL=1,$P(^OOPS(2260,IEN,NODE),U,5)'="" S FLG=1
 I CALL=2,$P(^OOPS(2260,IEN,NODE),U,2)'="" S FLG=1
 ; patch 5 llh - added reset flag if form = DUAL
 I FORM="DUAL" S FLG=""
 F I=$P(FIELD,","):1:$P(FIELD,",",2) S $P(^OOPS(2260,IEN,NODE),U,I)=""
 I FLG&('$G(DOL)) D
 . ; Added '$$BROKER^XWBLIB to line below ASISTS V2.0 11/09/01 LLH
 . I '$$BROKER^XWBLIB W !!,"Your ES has been cleared.  You will need to resign.",!
 . ;PATCH 11 CLEAR DATE SENT TO NDB IF SAFETY SIGNATURE REMOVED
 . I CALLER="O" S $P(^OOPS(2260,IEN,0),U,11)=""
 ; Security on ES - late in patch 8
 ; clears checksums set when emp portion of claim signed by emp
 ; patch 5 llh - added form DUAL
 I CALLER="E"&('$G(DOL)),(FORM'="DUAL") D
 . N RECORD
 . S RECORD=$G(^OOPS(2260,IEN,"CA"))
 . S $P(RECORD,U,7)="",$P(RECORD,U,9)="",^OOPS(2260,IEN,"CA")=RECORD
 Q
PAID(IEN,FLD) ; Get the data value from the PAID file (#450), if employee
 ;   Input - IEN     internal entry number of case in file 2260
 ;         - FLD     the PAID field number to retrieve
 ;         - NAME    Name of Person Involved, used to get PAID IEN
 ;         - VAL     Data value from the PAID #450, field #FLD
 ;  Output - DESC    Description from Paid, if there
 ;
 N DESC,IEN450,NAME,LP
 S DESC="",LP=0
 S NAME=$$GET1^DIQ(2260,IEN,1)
 D FIND^DIC(450,,"@;8","MPS",NAME,100)
 I $G(DIERR) D CLEAN^DILF Q
 F  S LP=$O(^TMP("DILIST",$J,LP)) Q:LP=""  D
 . I $$GET1^DIQ(2260,IEN,5)=$P(^TMP("DILIST",$J,LP,0),U,2) D
 .. S IEN450=$P(^TMP("DILIST",$J,LP,0),U)
 .. S DESC=$$GET1^DIQ(450,IEN450,FLD)
 Q DESC
 ;
PAYP(PAY) ; Map PAID Pay Plan to higher category for DOL project
 ;
 ;   Input   - PLAN    This is the PAID Pay Plan Description
 ;                     from file 454, not the PAID Code
 ;  Output   - PPLAN   Pay Plan that PAID Code maps to
 ;
 N PPLAN
 S PPLAN=$S($E(PAY)="G":"GS",$E(PAY)="W":"WG",$E(PAY)="N":"WG",$E(PAY)="V":PAY,PAY="AD":PAY,$E(PAY)="E":PAY,$E(PAY)="S":PAY,1:"OT")
 Q PPLAN
