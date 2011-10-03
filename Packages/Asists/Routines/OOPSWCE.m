OOPSWCE ;WIOFO/LLH-Workers Comp Edit routine ;3/23/00
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
EN1(CALLER) ;  Main Entry Point
 N CA,CASIGN,DIC,DONE,FORM,IEN,OOPS,OUT,SIGN,SSN,SUP,X,WOK,WCPDO
 S (DONE,OUT,IEN)=0
 S WOK=1                            ; to set cross reference
 Q:DUZ<1
 Q:$G(^VA(200,DUZ,1))=""
 ;  Select a Case
 S DIC="^OOPS(2260,"
 S DIC("S")="I $$WC^OOPSWCE(Y)"
 S DIC(0)="AEMNZ",DIC("A")="   Select Case: "
 D ^DIC
 Q:Y<1
 Q:$D(DTOUT)!($D(DUOUT))
 S IEN=$P(Y,U)
 D ^OOPSDIS                                      ; Display header info
 S (FORM,CA)=$$GET1^DIQ(2260,IEN,52,"I")
 S FORM=$S(FORM=1:"CA1",FORM=2:"CA2",1:"")
 S CASIGN=$P($$EDSTA^OOPSUTL1(IEN,"S"),U,CA)     ; Super signed CA form
 D FORMS ; Process correct form
 I OUT=2 G EXIT
 ; If controled fields have been edited, clear Sup fields, get re-signed
 I $D(OOPS) S DONE=$$CHGES(DONE) I DONE D CLRFLDS,SUPFLDS D:'OUT SUPSIGN
 I OUT G EXIT
 ; Need to have WC enter Supervisor fields
 I 'CASIGN D SUPFLDS D:'OUT SUPSIGN
EXIT ; Validate and allow user to sign if all required fields complete
 N DIR,Y
 I OUT=1 D
 . S DIR("A")="You '^'d out, Do you want to Sign"
 . S DIR(0)="SBM^Y:Yes;N:No"
 . D ^DIR
 . I Y="Y" S OUT=0
 I 'OUT D SIGNS(FORM)                 ; Sign/validate Document
 L -^OOPS(2260,IEN)
 Q
 ;
FORMS ; Process Form
 N DA,DIE,DR,FLD,I,MAX,MAX1,RET,SAL,PAY
 N AIEN,AGN,ADD,CITY,STATE,ZIP
 N PNAME,PADD,PCITY,PSTATE,PZIP,PTITLE,STAT,SIEN
 ; Patch 11 - Default Chargeback code, next 6 lines
 N OWCP,STA
 S OWCP=""
 S STA=$$GET1^DIQ(2260,IEN,13,"I")
 I STA S OWCP=$$FIND1^DIC(2262.03,",1,","Q",STA)
 I OWCP S OWCP=OWCP_",1," S OWCP=$$GET1^DIQ(2262.03,OWCP,.7)
 I 'OWCP S OWCP=""
 S MAX1=528                          ; Max length on some WP fields
 ; Get Default retirement from PAID - FLD = paid value
 S FLD=28,SAL=""
 S SAL=$$PAID^OOPSUTL1(IEN,FLD)
 S FLD=26,RET=""
 S RET=$$PAID^OOPSUTL1(IEN,FLD)
 S RET=$S(RET="FULL CSRS":"CSRS",RET="FERS":"FERS",1:"OTHER")
 S FLD=19,PAY=""
 S PAY=$$PAID^OOPSUTL1(IEN,FLD)
 S PAY=$S(PAY="PER ANNUM":"ANNUAL",PAY="PER HOUR":"HOURLY","PER DIEM":"DAILY","BIWEEKLY":"BI-WEEKLY",1:"")
 ; If WCP has signed, clear signature - added 5/19/00
 I $$GET1^DIQ(2260,IEN,67)'="" D CLRES^OOPSUTL1(IEN,"W",FORM)
 ; If Super has not signed, prompt WC to continue or not
 I 'CASIGN D WCSIGN Q:OUT
 ; If Super has signed and person editing form is not Supervisor who
 ; signed, then check for edits on certain fields.  ONLY FOR CA1
 I FORM="CA1",CASIGN,($$GET1^DIQ(2260,IEN,169,"I")'=DUZ) D WCEDIT
 L +^OOPS(2260,IEN):2
 E  W !!?5,"Another user is editing this entry. Try later." S OUT=2 Q
 I FORM="CA1" D CA1^OOPSWCE1 Q:OUT
 I FORM="CA2" D CA2^OOPSWCE2 Q:OUT
 S DIE="^OOPS(2260,",DA=IEN
 D ^DIE
 I ($D(Y)'=0)!($G(DIRUT)=1)  S OUT=1
 Q
WC(IEN) ; Selection Screen
 ;    Input  - IEN   Internal entry number of case
 ;   Output  - VIEW  If 0 case not accessible, if 1 case selectable
 ;
 N VIEW,FORM
 S VIEW=1
 S FORM=$$GET1^DIQ(2260,IEN,52,"I")
 I '$P($$EDSTA^OOPSUTL1(IEN,"E"),U,FORM) S VIEW=0   ;Employee not signed
 I $$GET1^DIQ(2260,IEN,66)'="" S VIEW=0             ;Case sent to DOL
 I $$GET1^DIQ(2260,IEN,51,"I")'=0 S VIEW=0          ;Case is not open
 I '$$ISEMP^OOPSUTL4(IEN) S VIEW=0                  ;not employee
 Q VIEW
WCEDIT ; check for edits by WC
 ; Get data from fields 146, 147, 148, 149, 163, 164, 165.
 N DA,DIC,DIQ,DR,%X,%Y
 K OOPS
 S DIC=2260,DR="146;147;148;149;163",DA=IEN,DIQ="OOPS",DIQ(0)="I"
 D EN^DIQ1
 S %X="^OOPS(2260,IEN,""CA1J"",",%Y="OOPS(2260,IEN,""CA1J""," D %XY^%RCR
 S %X="^OOPS(2260,IEN,""CA1K"",",%Y="OOPS(2260,IEN,""CA1K""," D %XY^%RCR
 Q
WCSIGN ; Prompt user to continue as Supervisor if Super has not signed form
 N DIR,Y
 S DIR("A")="Are you signing for the Supervisor"
 S DIR("A",1)="The Supervisor has not signed the "_FORM_".  To continue"
 S DIR("A",2)="editing, you will need to sign as Supervisor."
 S DIR(0)="SBM^Y:Yes;N:No"
 D ^DIR
 I Y'="Y" S OUT=1
 Q
SUPSIGN ; Sign/validate Document
 N DIR,ES,SUPSIGN,VALID,Y
 S VALID=0
 D VALIDATE^OOPSUTL4(IEN,FORM,"S",.VALID)
 I 'VALID S OUT=2 Q                     ; not valid, sup not signed
 S DIR("A")="Sign as Supervisor"
 S DIR(0)="SBM^Y:Yes;N:No"
 D ^DIR
 I Y'="Y" S OUT=2      ; sup 'signed, WC cant sign
 I Y="Y" D
 . S SUPSIGN=$$SIG^OOPSESIG(DUZ,IEN)
 . S ES=$S(FORM="CA1":"CA1ES",FORM="CA2":"CA2ES",1:0)
 . I $G(ES)'="" S $P(^OOPS(2260,IEN,ES),U,4,6)=SUPSIGN
 Q
SIGNS(FORM) ;
 N PAYPLAN,DA,DIE,DR,VALID
 S VALID=0,SIGN=""
 S PAYPLAN=$$GET1^DIQ(2260,IEN,63)
 I '$P($$EDSTA^OOPSUTL1(IEN,"S"),U,CA) D  Q        ; Super hasn't signed
 . W !!,"Supervisor has not signed "_FORM
 D VALIDATE^OOPSUTL4(IEN,FORM,"W",.VALID)
 I 'VALID Q
 ; V2.0 1/9/02 - fixes for Fee Basis, Non-Paid Employees
 I $$GET1^DIQ(2260,IEN,2,"I")=6 D  Q
 .W !,"This person is not in the PAID Employee File and does not appear "
 .W !,"eligible to submit a claim to DOL.  Please check with your"
 .W !,"Human Resources Department for assistance.  Sending a paper"
 .W !,"hardcopy may be necessary, if allowable."
 I (PAYPLAN="OT"),'$$VALEMP^OOPSUTL6 D  Q
 .W !,"This person does not appear to be eligible for submitting a claim"
 .W !,"to DOL, please review the RETIREMENT, GRADE, STEP, PAY"
 .W !,"PLAN, PAY RATE and PAY RATE PER Fields.  You may need to"
 .W !,"contact your Human Resources Department or IRM for assistance."
 N DIR,Y
 W !
 S DIR("A")="OK to transmit to DOL"
 S DIR(0)="SBM^Y:Yes;N:No"
 D ^DIR
 I Y="Y" S SIGN=$$SIG^OOPSESIG(DUZ,IEN)
 ; if signed, file and send bulletin
 I $P(SIGN,U) D
 . S DR="",DIE="^OOPS(2260,",DA=IEN
 . S DR(1,2260,1)="67////^S X=$P(SIGN,U)"
 . S DR(1,2260,5)="68////^S X=$P(SIGN,U,2)"
 . S DR(1,2260,10)="69////^S X=$P(SIGN,U,3)"
 I $P(SIGN,U) D ^DIE,WCP^OOPSMBUL(IEN,"S")
 Q
CLRFLDS ; Clear Supervisor Signature fields
 N DR,DA,DIE
 ; Clear Supervisor Signature
 ; Added next line for ASISTS V2.0 11/09/01
 I '$$BROKER^XWBLIB D
 . W !!,"Worker's Comp edit of special fields occurred, Supervisor"
 . W !,"signature fields cleared, you will need to sign as Supervisor."
 D CLRES^OOPSUTL1(IEN,"S",FORM)
 ; If get in this subroutine, need to set flag that Super needs to
 ; be notified of edits even if user ^'s out
 S DR="",DIE="^OOPS(2260,",DA=IEN
 S DR(1,2260,35)="199////Y"
 D ^DIE
 Q
SUPFLDS ; Get Supervisor signature related data for CA1 only
 I OUT Q
 N DR,DA,DIE,SUP
 S DR="",DIE="^OOPS(2260,",DA=IEN
 ; Clear Super Title and Phone # and set DR array
 I FORM="CA1" D
 . S SUP=$$GET1^DIQ(200,DUZ,.01)
 . S $P(^OOPS(2260,IEN,"CA1L"),U,4,5)="^"
 . S DR(1,2260,1)="W !!,""       Worker's Compensation Signing for Supervisor"",!"
 . S DR(1,2260,5)="W !,""      Signature of Supervisor and Filing Instructions"""
 . S DR(1,2260,10)="W !,""      -----------------------------------------------"""
 . S DR(1,2260,15)="S ITEM=38 D EXCEPT^OOPSUTL2;168    EXCEPTION"
 . S DR(1,2260,16)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,^,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=168"
 . S DR(1,2260,20)="W !,""     NAME OF SUPERVISOR.: ""_SUP"
 . S DR(1,2260,25)="172     SUPERVISOR'S TITLE.;I X="""" S Y=172"
 . S DR(1,2260,26)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,^,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=172"
 . S DR(1,2260,30)="173     OFFICE PHONE.......;I X="""" S Y=173"
 . ; Patch 8 - added error checking on phone per DOL requirement
 . S DR(1,2260,35)="I $TR(X,""/-*#"","""")'?10N W !?3,""Phone number must include area code and 7 digits only.  Example 703-123-8789"" S Y=173"
 D ^DIE
 I ($D(Y)'=0)!($G(DIRUT)=1)  S OUT=2
 Q
CHGES(DONE) ; Verify changes have been made to controlled fields
 ; Can quit as soon as any change is discovered
 ;    Input -   none
 ;   Output -   DONE   if 1, at least 1 field edited, else no edits (0)
 ;
 N I,LINE,LP
 F I=146:1:149,163 D  Q:DONE
 . I $$GET1^DIQ(2260,IEN,I,"I")'=OOPS(2260,IEN,I,"I") S DONE=1 Q
 I 'DONE F I="CA1J","CA1K" I $D(OOPS(2260,IEN,I)) D  Q:DONE
 . S LINE=$P(^OOPS(2260,IEN,I,0),U,4)
 . I LINE'=$P(OOPS(2260,IEN,I,0),U,4) S DONE=1 Q
 . F LP=1:1:LINE D  Q:DONE
 .. I ^OOPS(2260,IEN,I,LP,0)'=OOPS(2260,IEN,I,LP,0) S DONE=1 Q
 Q DONE
