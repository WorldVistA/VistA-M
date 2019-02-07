BPSRPT3A ;AITC/CKB - ECME REPORTS ;9/28/2017
 ;;1.0;E CLAIMS MGMT ENGINE;**23,24**;JUN 2004;Build 43
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
SELPR(DFLT) ;
 ;
 ; Display (P)rescribers or (A)ll
 ; 
 ;    Input Variable -> DFLT = ALL
 ;                          
 ;     Return Value ->   1 = Prescribers
 ;                       0 = ALL
 ;                       ^ = Exit
 ;                       
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ;Select to include (S)pecific Prescriber or (A)ll Prescribers
 ;
 S DIR(0)="S^S:SPECIFIC PRESCRIBER(S);A:ALL PRESCRIBERS"
 S DIR("A")="Select Specific Prescriber(s) or include ALL Prescribers"
 S DIR("B")="A"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="     S         Specific Prescriber(s)"
 S DIR("L",4)="     A         ALL Prescribers"
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="A":0,Y="S":1,1:Y)
 Q Y
 ;
SELPRESC() ;
 ; Allow user to select a single or multiple PRESCRIBERS(s).
 ;
 ; If the users selected one or more PRESCRIBERs, the selection will be stored
 ; in BPARR("PRESC")separated by a comma. e.g. BPARR("PRESC")= ien1 , ien2
 ;
BPPRESC ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 N BPARR,BPSARRAY,BPSIEN
 ;
 S BPARR("PRESC")=""
 ;
 ; The SEL tag prompts user to 'Select Prescriber' and validates the selection against file #200.
 D SEL("Prescriber","^VA(200,",.BPSARRAY)
 ;
 ; If the user entered "^" quit, no longer prompting the user to 'Select Prescriber'
 I $G(BPSARRAY)="^" Q "^"
 ;
 ; If no Prescriber was selected, return the user to 'Display Selected (P)rescribers or (A)LL'
 I $G(BPSARRAY)=0 Q 0
 ;
 M BPARR("PRESC")=BPSARRAY
 ;
 ; Creates a string of all the Prescriber ien's selected separated by a comma.
 S BPSIEN=""
 F  S BPSIEN=$O(BPARR("PRESC",BPSIEN)) Q:BPSIEN=""  I BPSIEN'="B" D
 . I BPARR("PRESC")'="" S BPARR("PRESC")=BPARR("PRESC")_","
 . S BPARR("PRESC")=BPARR("PRESC")_BPSIEN
 . Q
 ;
 Q BPARR("PRESC")
 ;
SELPA(DFLT) ;
 ;
 ; Display (P)atients or (A)ll
 ; 
 ;    Input Variable -> DFLT = ALL
 ;                          
 ;     Return Value ->   1 = Patients
 ;                       0 = ALL
 ;                       ^ = Exit
 ;                       
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DFLT="ALL"
 S DIR(0)="S^P:Patient;A:ALL"
 S DIR("A")="Display Selected (P)atients or (A)LL"
 S DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="A":0,Y="P":1,1:Y)
 Q Y
 ;
SELPAT() ;
 ; Allow user to select a single or multiple PATIENT(s).
 ;
 ; If the users selected one or more PATIENTs, the selection will be stored
 ; in BPARR("PATIENT")separated by a comma. e.g. BPARR("PATIENT")= patient ien1 , patient ien2
 ;
BPPAT ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 N BPARR,BPSARRAY,BPSIEN
 ;
 S BPARR("PATIENT")=""
 ;
 ; The SEL tag prompts user to 'Select Patient' and validates the selection against the PATIENT file.
 D SEL("Patient","^DPT(",.BPSARRAY)
 ;
 ; If the user entered "^" quit, no longer prompting the user to 'Select Patient'
 I $G(BPSARRAY)="^" Q "^"
 ;
 ; If no Patient was selected, return the user to 'Display Selected (P)atients or (A)LL'
 I $G(BPSARRAY)=0 Q 0
 ;
 M BPARR("PATIENT")=BPSARRAY
 ;
 ; Creates a string of all the patient ien's selected separated by a comma.
 S BPSIEN=""
 F  S BPSIEN=$O(BPARR("PATIENT",BPSIEN)) Q:BPSIEN=""  I BPSIEN'="B" D
 . I BPARR("PATIENT")'="" S BPARR("PATIENT")=BPARR("PATIENT")_","
 . S BPARR("PATIENT")=BPARR("PATIENT")_BPSIEN
 . Q
 ;
 Q BPARR("PATIENT")
 ;
SELBAMT() ;
 ;
 ; Select (R)ange for Billed Amount or (A)ll
 ; 
 ;    Input Variable -> DFLT = ALL
 ;                          
 ;     Return Value ->   1 = Billed Amt Range
 ;                       0 = ALL
 ;                       ^ = Exit
 ;                       
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DFLT="ALL"
 S DIR(0)="S^R:Range;A:ALL"
 S DIR("A")="Select (R)ange for Billed Amount or (A)LL"
 S DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="A":0,Y="R":1,1:Y)
 Q Y
 ;
SELBMIN() ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR("A")="     Minimum Billed Amount: "
 S DIR("B")=0
 S DIR(0)="NA^0:999999"
 S DIR("?",1)="Enter the minimum billed amount OR press"
 S DIR("?",2)="return for a minimum billed amount of zero (0)."
 S DIR("?")=" Example: 500 - no decimal digits"
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) Q "^"
 Q Y
 ;
SELBMAX() ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR("A")="     Maximum Billed Amount: "
 S DIR("B")=999999
 S DIR(0)="NA^0:999999^I X'>$G(BPMIN) W !,""The Maximum Billed Amount must be greater than the Minimum Billed Amount."" K X"
 S DIR("?",1)="Enter the maximum billed amount. The amount"
 S DIR("?",2)="entered must be greater than the minimum billed."
 S DIR("?")=" Example: 1500 - no decimal digits"
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) Q "^"
 Q Y
 ;
SELDRG1() ;
 ;
 ; Allow user to select a single or multiple DRUGS.
 ;
 ; The users selection is stored in BPARR("DRUG") separated by a comma.
 ;  BPARR("DRUG")=drug ien1,drug ien2
 ;
DRG1 ;
 N BPARR,BPSIEN,BPSDRGARR
 S BPARR("DRUG")=""
 ;
 ; The SEL tag prompts user to 'Select Drug' and validates the selection against the DRUG file.
 D SEL("Drug","^PSDRUG(",.BPSDRGARR)
 ;
 ; If the user entered "^" quit, no longer prompting the user to 'Select Drug'
 I $G(BPSDRGARR)="^" Q "^"
 ;
 ; If no drug was selected, return "0" so the user will be returned to the Drug or Drug Class or All prompt.
 I $G(BPSDRGARR)=0 Q 0
 ;
 M BPARR("DRUG")=BPSDRGARR
 ;
 ; Creates a string of all the drug ien's selected separated by a comma.
 S BPSIEN=""
 F  S BPSIEN=$O(BPARR("DRUG",BPSIEN)) Q:BPSIEN=""  I BPSIEN'="B" D
 . I BPARR("DRUG")'="" S BPARR("DRUG")=BPARR("DRUG")_","
 . S BPARR("DRUG")=BPARR("DRUG")_BPSIEN
 . Q
 ;
 Q BPARR("DRUG")
 ;
SELDC() ;
 ;
 ; Allow user to select a single or multiple DRUG CLASSes,
 ;
 ; The users selection is stored in BPARR("DRUG CLASS") separated by a semi colon.
 ; BPARR("DRUG CLASS")=dc name ien ; dc name ien
 ;
DRGCL ;
 N BPARR,BPSIEN,BPSDCARR
 S BPARR("DRUG CLASS")=""
 ;
 ; The SEL tag prompts user and validates the selection against the DRUG CLASS file.
 D DCSEL("Drug Class","^PS(50.605,",.BPSDCARR)
 ;
 ; If the user entered "^" quit, no longer prompting the user to 'Select Drug Class'
 I $G(BPSDCARR)="^" Q "^"
 ;
 ; If no drug class was selected, return "0" so the user will be returned to the Drug or Drug Class or All prompt.
 I $G(BPSDCARR)=0 Q 0
 ;
 M BPARR("DRUG CLASS")=BPSDCARR
 ;
 ; Creates a string of all the drug class ien's selected separated by a comma. 
 S BPSIEN=""
 F  S BPSIEN=$O(BPARR("DRUG CLASS",BPSIEN)) Q:BPSIEN=""  I BPSIEN'="B" D
 . I BPARR("DRUG CLASS")'="" S BPARR("DRUG CLASS")=BPARR("DRUG CLASS")_";"
 . S BPARR("DRUG CLASS")=BPARR("DRUG CLASS")_$$GET1^DIQ(50.605,BPSIEN,1)
 . Q
 ;
 Q BPARR("DRUG CLASS")
 ; 
SEL(FIELD,FILE,BPSARRAY,DEFAULT) ;
 ; Provides selection of one or many Drug, Prescriber and Patients.
 ; Note: if you to make changes to this subroutine you need to check DCSEL, RCSEL^BPSRPT4, CCRSEL^BPSRPT4 
 ;       they might require the same changes.
 N DIC,DTOUT,DUOUT,QT,Y,X
 N BPSARR
 ;
 S DIC=FILE,DIC(0)="QEZAM",DIC("A")="Select "_FIELD_": "
 I FIELD="Prescriber" S DIC("S")="I +$G(^VA(200,Y,""PS""))"
 I $G(DEFAULT)'="" S DIC("B")=DEFAULT
 ;
 F  D ^DIC Q:X=""  D  Q:$G(QT)
 . ; Check for "^" or timeout, if found set BPSARRAY="^" and quit.
 . I $D(DTOUT)!$D(DUOUT) K BPSARRAY S BPSARRAY="^",QT=1 Q
 . ;
 . ; If selection already exists in BPSARRAY, ask user if they
 . ; want to Delete the entry
 . I $D(BPSARRAY(+Y)) D  Q
 . . N P
 . . S P=Y ;Save Original Value
 . . S DIR(0)="S^Y:YES;N:NO"
 . . S DIR("A")="Delete "_$P(P,U,2)_" from your list?"
 . . S DIR("B")="NO" D ^DIR
 . . I Y="Y" K BPSARRAY(+P),BPSARRAY("B",$P(P,U,2),+P)
 . . ; Display a list of current selections
 . . I $D(BPSARRAY) D
 . . . N X
 . . . W !,?2,"Selected:"
 . . . S X="" F  S X=$O(BPSARRAY("B",X)) Q:X=""  W ?12,X,!
 . E  D
 . . ;Define new entries in BPSCCR array
 . . S BPSARRAY(+Y)=$P(Y,U,2)
 . . S BPSARRAY("B",$P(Y,U,2),+Y)=""
 . ;
 . ;Display a list of current selections
 . N X
 . W !,?2,"Selected:"
 . S X="" F  S X=$O(BPSARRAY("B",X)) Q:X=""  W ?12,X,!
 . K DIC("B")
 ;
 ; If nothing was selected set BPSARRAY=0
 I '$D(BPSARRAY) S BPSARRAY=0
 Q
 ;
DCSEL(FIELD,FILE,BPSARRAY,DEFAULT) ;
 ; Provides selection of one or many for Drug Classes.
 N BPSARR,DIC,DTOUT,DUOUT,QT,Y,X
 ;
 S DIC=FILE,DIC(0)="QEZAM",DIC("A")="Select "_FIELD_": "
 I $G(DEFAULT)'="" S DIC("B")=DEFAULT
 ;
 F  D ^DIC Q:X=""  D  Q:$G(QT)
 . ;
 . ; Check for "^" or timeout, if found set BPSARRAY="^" and quit.
 . I $D(DTOUT)!$D(DUOUT) K BPSARRAY S BPSARRAY="^",QT=1 Q
 . ;
 . ; If selection already exists in BPSARRAY, ask user if they
 . ; want to Delete the entry
 . I $D(BPSARRAY(+Y)) D  Q
 . . N P
 . . S P=Y ;Save Original Value
 . . S DIR(0)="S^Y:YES;N:NO"
 . . S DIR("A")="Delete "_$$GET1^DIQ(50.605,+P,1)_" "_$$GET1^DIQ(50.605,+P,.01)_" from your list?"
 . . S DIR("B")="NO"
 . . D ^DIR
 . . I Y="Y" K BPSARRAY(+P),BPSARRAY("B",$P(P,U,2),+P)
 . . ; Display list of current selections
 . . I $D(BPSARRAY) D
 . . . N X
 . . . W !,?2,"Selected:"
 . . . S X="" F  S X=$O(BPSARRAY(X)) Q:(X="")!(X="B")  W ?12,$$GET1^DIQ(50.605,X,1)," ",$$GET1^DIQ(50.605,X,.01),!
 . E  D
 . . ;Define new entries in BPSCCR array
 . . S BPSARRAY(+Y)=$P(Y,U,2)
 . . S BPSARRAY("B",$P(Y,U,2),+Y)=""
 . ;
 . ;Display a list of current selections
 . N X
 . W !,?2,"Selected:"
 . S X="" F  S X=$O(BPSARRAY(X)) Q:(X="")!(X="B")  W ?12,$$GET1^DIQ(50.605,X,1)," ",$$GET1^DIQ(50.605,X,.01),!
 . K DIC("B")
 ;
 ; If nothing was selected set BPSARRAY=0
 I '$D(BPSARRAY) S BPSARRAY=0
 Q
 ;
