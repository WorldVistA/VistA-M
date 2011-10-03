OOPSGUI4 ;WIOFO/LLH-RPC BROKER CALLS ;10/02/01
 ;;2.0;ASISTS;**4,8,7,11,15,18,21**;Jun 03, 2002;Build 7
 ;
PAID(RESULTS,NAME) ; retrieves PAID employee and data from file 450
 ;  Input:    NAME - the Employee or partial Name Passed in
 ; Output: RESULTS - array containing PAID fields in the order returned
 ;                   from FIND^DIC
 ;
 N IEN200,LP,PAY,PAYP,PHONE,OCCDESC,RET,SAL,SSN,X,STATE,SERV,SAMEFLG
 N IEN450,TERM
 I NAME="" S RESULTS(1)="^NO SSN OR NAME PROVIDED" Q
 S X=NAME,SAMEFLG=0
 D FIND^DIC(450,,"@;.01;6;8;10;13;16EI;31;32;38;186.1;186.2;186;186.4;458I;30","MPS",X,500)
 I $G(DIERR) D CLEAN^DILF Q
 I $P(^TMP("DILIST",$J,0),U)=0 S RESULTS(0)="^NO PAID EMPLOYEE FOUND" Q
 F LP=0:0 S LP=$O(^TMP("DILIST",$J,LP)) Q:LP=""  D
 .; cannot pick yourself if selecting case,use SSN to see if DUZ matches
 .S SSN=$TR($P($G(^TMP("DILIST",$J,LP,0)),U,4),"-","")
 .I $G(SSN) S IEN200=$O(^VA(200,"SSN",SSN,""))
 .; 12/29/03 llh - also cannot pick a person from the PAID file with
 .;                a pseudo SSN (one that begins with 000)
 .I $E(SSN,1,3)="000" Q
 .I DUZ=IEN200 S SAMEFLG=1 Q
 .;V2_P18 expand logic, check for future date - if termination date not beyond today include
 .S TERM=$$GET1^DIQ(200,IEN200,9.2,"I") I $G(TERM) Q:($$FMDIFF^XLFDT(TERM,$$DT^XLFDT)<0)
 .;V2_P15 - moved/modified next line up from below & if separated from PAID, Q
 .S IEN450=$P(^TMP("DILIST",$J,LP,0),U)
 .I $$GET1^DIQ(450,IEN450,80,"I")="Y" Q
 .S RESULTS(LP)=^TMP("DILIST",$J,LP,0)
 .S $P(RESULTS(LP),U,5)=$E($P(RESULTS(LP),U,5),1,45)
 .;V2_P15 restrict output of OCCUPATION SERIES & TITLE to 30 characters
 .S $P(RESULTS(LP),U,7)=$E($P(RESULTS(LP),U,7),1,30)
 .S $P(RESULTS(LP),U,8)=$E($P($G(RESULTS(LP)),U,8),1,4)
 .S PHONE=""  ; ,SSN=$TR($P($G(RESULTS(LP)),U,4),"-","")
 .I $G(IEN200) S PHONE=$P($G(^VA(200,IEN200,.13)),U)
 .I $TR(PHONE,"(,)-^*/# &%@!","")'?10N S PHONE=""  ;Must be 10 char
 .S RESULTS(LP)=RESULTS(LP)_U_PHONE
 .I $G(IEN450) D
 ..S PAYP=$$GET1^DIQ(450,IEN450,20) I $G(PAYP)'="" S PAYP=$$PAYP^OOPSUTL1(PAYP)
 ..S SAL=$$GET1^DIQ(450,IEN450,28)
 ..S RET=$$GET1^DIQ(450,IEN450,26) I $G(RET)'="" S RET=$S(RET="FULL CSRS":"CSRS",RET="FERS":"FERS",1:"OTHER")
 ..S PAY=$$GET1^DIQ(450,IEN450,19) I $G(PAY)'="" S PAY=$S(PAY="PER ANNUM":"ANNUAL",PAY="PER HOUR":"HOURLY","PER DIEM":"DAILY","BIWEEKLY":"BI-WEEKLY",1:"")
 ..S OCCDESC=$E($$GET1^DIQ(450,IEN450,16),1,30)
 .S SERV="" I $G(IEN200) S SERV=$$GET1^DIQ(200,IEN200,29)
 .S RESULTS(LP)=RESULTS(LP)_U_PAY_U_SAL_U_RET_U_PAYP_U_OCCDESC_U_SERV
 I SAMEFLG,'$D(RESULTS) S RESULTS(0)="^CANNOT CREATE CASE FOR YOURSELF"
 KILL DIERR,^TMP("DILIST",$J)
 Q
ASISTS(RESULTS,NAME) ; Lookup on ASISTS Accident Reporting file_2260
 ;  Input:  - Name or partial name of person to lookup on
 ; Output:  - array with name of person, sex, DOB, and SSN
 N ARR,I,X,SAMEFLG
 K ^TMP("DILIST",$J)
 I NAME="" S RESULTS(0)="^NO SSN OR NAME PROVIDED" Q
 S X=NAME,SAMEFLG=0
 D FIND^DIC(2260,,"@;1;7;6;5","PSMC",X,500,"C^SSN^BS5")
 I $G(DIERR) D CLEAN^DILF Q
 I $P(^TMP("DILIST",$J,0),"^")=0 S RESULTS(1)="^NO ASISTS CASE FOUND" Q
 F I=0:0 S I=$O(^TMP("DILIST",$J,I)) Q:I=""  D
 .I DUZ=$P(^TMP("DILIST",$J,I,0),U) S SAMEFLG=1 Q
 .I $D(ARR($P(^TMP("DILIST",$J,I,0),U,2))) Q
 .S ARR($P(^TMP("DILIST",$J,I,0),U,2))=""
 .S RESULTS(I)=^TMP("DILIST",$J,I,0)
 I SAMEFLG,'$D(RESULTS) S RESULTS(0)="^CANNOT CREATE CASE FOR YOURSELF"
 I '$D(RESULTS) S RESULTS(0)="^NO SELECTABLE CASES FOUND"
 K DIERR,^TMP("DILIST",$J)
 Q
PER(RESULTS,NAME) ; Lookup for Non-Paid Employee (New Person file_
 ;  Input:  - Name or partial name of person to lookup on
 ; Output:  - array with name of new person, sex, DOB, and SSN
 N I,SSN,X,SAMEFLG,IEN200
 K ^TMP("DILIST",$J)
 I NAME="" S RESULTS(0)="^NO SSN OR NAME PROVIDED" Q
 S X=NAME,SAMEFLG=0
 D FIND^DIC(200,,"@;.01;4;5;9;29","PSMC",X,500)
 I $G(DIERR) D CLEAN^DILF Q
 I $P(^TMP("DILIST",$J,0),"^")=0 S RESULTS(1)="^NO NEW PERSON FOUND" Q
 F I=0:0 S I=$O(^TMP("DILIST",$J,I)) Q:I=""  D
 .; make sure not a PAID Employee
 .S SSN=$P(^TMP("DILIST",$J,I,0),U,5)
 .I $G(SSN),$$FIND1^DIC(450,"","MX",SSN) Q
 .;V2_P15 modified for HD0000000152026
 .S IEN200=$P(^TMP("DILIST",$J,I,0),U)
 .I DUZ=IEN200 S SAMEFLG=1 Q
 .;V2_P18 expand logic, check for future date - if termination date not beyond today include
 .S TERM=$$GET1^DIQ(200,IEN200,9.2,"I") I $G(TERM) Q:($$FMDIFF^XLFDT(TERM,$$DT^XLFDT)<0)
 .S RESULTS(I)=^TMP("DILIST",$J,I,0)
 I SAMEFLG,'$D(RESULTS) S RESULTS(0)="^CANNOT CREATE CASE FOR YOURSELF"
 I '$D(RESULTS) S RESULTS(0)="^NO SELECTABLE CASES FOUND"
 K DIERR,^TMP("DILIST",$J)
 Q
SUPER(RESULTS,NAME,EMPSSN) ; Lookup for Supervisors or anyone from the New 
 ;                 Person file.  Broker call will also be used to
 ;                 lookup Union Reps for the Enter/Edit Union Information.
 ;  Input:    NAME - Name or partial name of person to lookup on
 ;             SSN - SSN of the Person Involved if called from 2162
 ; Output: RESULTS - array with name of new person, sex, DOB, and SSN
 N I,SSN,SAME,STR,X
 K ^TMP("DILIST",$J)
 I NAME="" S RESULTS(1)="^NO SSN OR NAME PROVIDED" Q
 S X=NAME,SAME=0
 D FIND^DIC(200,,".01;9","PSCM",X,500)
 I $G(DIERR) D CLEAN^DILF Q
 I $P(^TMP("DILIST",$J,0),"^")=0 S RESULTS(1)="^NO NEW PERSON FOUND" Q
 F I=0:0 S I=$O(^TMP("DILIST",$J,I)) Q:I=""  D
 .S STR=$G(^TMP("DILIST",$J,I,0))
 .;Remedy Ticket: HD0000000311261 expand logic, check for future date - if term. date not beyond 
 .;today include. This changed logic from patch 15, was if terminated don't include
 .S TERM=$$GET1^DIQ(200,$P(STR,U,1),9.2,"I") I $G(TERM) Q:($$FMDIFF^XLFDT(TERM,$$DT^XLFDT)<0)
 .I $G(EMPSSN)'="",($P(STR,U,3)=$G(EMPSSN)) S SAME=1 Q
 .S RESULTS(I)=STR
 I SAME,'$D(RESULTS) S RESULTS(1)="^CANNOT BE SUPERVISOR FOR YOUR CLAIM"
 I '$D(RESULTS) S RESULTS(1)="^NO VALID SELECTION"
 K DIERR,^TMP("DILIST",$J)
 Q
 ;
LOAD(RESULTS,ARR) ; Create new OOPS record
 ;  Input:     ARR  - contains data entered from the Create Incident
 ;                    Report Option
 ; Output:  RESULTS - status message
 ;
 N ASUB,CAT,DA,DATE,DIC,DR,ERROR,FLDS,FNUM,FYEAR,IEN2260,LP,NUM,PCE,SSN,X
 N LIST,CNT,DLAYGO
 S CAT=""
 I $G(ARR(2)) S CAT=ARR(2)
 I $G(ARR(5)) S SSN=ARR(5)
 D NOW^%DTC
 S DATE=X
 S FYEAR=""
 S FYEAR=$$FYEAR^OOPSCSN(X)
 S NUM=$$NEWR^OOPSCSN(FYEAR)
 K DD,DO
 S DLAYGO=2260,DIC="^OOPS(2260,"
 S DIC(0)="QLZ"
 S X=NUM
 D FILE^DICN
 I Y<0 S (RESULTS,RESULTS(0))="UNABLE TO CREATE RECORD" Q
 S IEN2260=+Y
 S DIE="^OOPS(2260,"
 S DA=IEN2260
 S LIST="1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,52,60,63,86,90,335,"
 S LIST=LIST_"336,338,339,349,350,351,352,"
 I ARR(52)="Injury" S LIST=LIST_",111,166,167"
 I ARR(52)="Illness/Disease" S LIST=LIST_",208,334"
 F CNT=1:1 S FNUM=$P(LIST,",",CNT) Q:FNUM=""  I $G(ARR(FNUM))'="" D VAL(DA,FNUM,ARR(FNUM))
 K DR S DIE="^OOPS(2260,",DA=IEN2260,DR=""
 S DR(1,2260,1)="1///^S X=ARR(1)"
 S DR(1,2260,2)="2///^S X=ARR(2)"
 S DR(1,2260,3)="3///^S X=ARR(3)"
 S DR(1,2260,4)="4///^S X=ARR(4)"
 S DR(1,2260,5)="5///^S X=ARR(5)"
 S DR(1,2260,6)="6///^S X=ARR(6)"
 S DR(1,2260,7)="7///^S X=ARR(7)"
 S DR(1,2260,8)="8///^S X=ARR(8)"
 S DR(1,2260,9)="9///^S X=ARR(9)"
 S DR(1,2260,10)="10///^S X=ARR(10)"
 S DR(1,2260,12)="11///^S X=ARR(11)"
 S DR(1,2260,15)="12///^S X=ARR(12)"
 S DR(1,2260,18)="13////^S X=ARR(13)"
 S DR(1,2260,21)="14///^S X=ARR(14)"
 S DR(1,2260,24)="15///^S X=ARR(15)"
 S DR(1,2260,27)="16///^S X=ARR(16)"
 S DR(1,2260,30)="17///^S X=ARR(17)"
 S DR(1,2260,33)="18///^S X=ARR(18)"
 S DR(1,2260,36)="52///^S X=ARR(52)"
 S DR(1,2260,39)="53////^S X=ARR(53)"
 S DR(1,2260,42)="53.1////^S X=ARR(22)"
 S DR(1,2260,45)="56////^S X=ARR(48)"
 S DR(1,2260,48)="60///^S X=ARR(60)"
 S DR(1,2260,51)="63///^S X=ARR(63)"
 S DR(1,2260,54)="86///^S X=ARR(86)"
 S DR(1,2260,57)="90///^S X=ARR(90)"
 S DR(1,2260,58)="335///^S X=ARR(169)"
 S DR(1,2260,59)="336///^S X=ARR(170)"
 I ARR(52)="Injury" D
 .S DR(1,2260,60)="111///^S X=ARR(19)"
 .S DR(1,2260,63)="166///^S X=ARR(166)"
 .S DR(1,2260,67)="167///^S X=ARR(167)"
 I ARR(52)="Illness/Disease" D
 .S DR(1,2260,60)="208///^S X=ARR(19)"
 .S DR(1,2260,61)="334///^S X=ARR(168)"
 ; patch 11 - new OSHA 300 questions
 S DR(1,2260,70)="349///^S X=ARR(171)"
 S DR(1,2260,71)="339///^S X=ARR(172)"
 S DR(1,2260,72)="338///^S X=ARR(173)"
 S DR(1,2260,73)="350///^S X=ARR(174)"
 S DR(1,2260,74)="351///^S X=ARR(175)"
 S DR(1,2260,75)="352///^S X=ARR(176)"
 ; V2P15 new field
 S DR(1,2260,76)="360///^S X=ARR(177)"
 D ^DIE
 ;V2_P15 - if INITIAL RETURN TO WORK STATUS = Days Away work or Job Transfer/Restriction
 ;send a new bulletin
 I ARR(176)="DAYS AWAY WORK"!(ARR(176)="Job Transfer/Restriction") D CIO^OOPSMBUL(IEN2260)
 D CASE^OOPSMBUL(IEN2260) D:(CAT=1)!(CAT=6) BOR^OOPSMBUL(IEN2260):$D(^VA(200,"SSN",SSN))
 K DR S DIE="^OOPS(2260,",DA=IEN2260,DR="51///0" D ^DIE
 K DIE,DR,DA
 S (RESULTS,RESULTS(1))="OK" S:$G(ERROR)]"" (RESULTS,RESULTS(1))=ERROR
 S RESULTS(2)=$P(^OOPS(2260,IEN2260,0),"^")
 Q
DELETE ;Delete incomplete case
 N DIK,DA
 S DIK="^OOPS(2260,",DA=IEN2260
 D ^DIK
 Q
VAL(DA,FIELD,VALUE) ;Validate Input
 ;  Input:   DA  - IEN of the ASISTS record
 ;        FIELD  - field number for data to be validated
 ;        VALUE  - data to be validated
 ; Output:  none
 N X
 D VAL^DIE(2260,DA,FIELD,"",VALUE,.X)
 I X=U D
 .S:$G(ERROR)]"" ERROR=ERROR_","
 .S ERROR=$G(ERROR)_$$GET1^DID(2260,FIELD,"","LABEL")_U_VALUE
 .; set the data to nil so filing will not bomb
 .S ARR(FIELD)=""
 Q
DUP(RESULTS,SSN) ; Duplicate Case error checking broker call
 ;  Input:    INPUT - SSN of current ASISTS case number
 ; Output:  RESULTS - return array with case information
 ;
 N CN,DT,IEN,NM,TYPE
 S IEN="",CN=0
 S RESULTS(CN)="NO MATCHES FOUND"
 F  S IEN=$O(^OOPS(2260,"SSN",SSN,IEN)) Q:IEN=""  D
 .I $$GET1^DIQ(2260,IEN,51,"I") Q        ;case not open, don't include
 .S NM=$$GET1^DIQ(2260,IEN,1)
 .S TYPE=$$GET1^DIQ(2260,IEN,"3:.01")
 .S DT=$$GET1^DIQ(2260,IEN,4)
 .S RESULTS(CN)=NM_"  "_DT_"  "_TYPE
 .S CN=CN+1,(NM,TYPE,DT)=""
 Q
