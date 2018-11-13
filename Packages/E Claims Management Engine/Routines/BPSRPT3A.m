BPSRPT3A ;AITC/CKB - ECME REPORTS ;9/28/2017
 ;;1.0;E CLAIMS MGMT ENGINE;**23**;JUN 2004;Build 44
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
SELPRESC() ;
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
 D ^DIR K DIR
 ;
 ;If (A)LL was selected, return 0 (zero)
 I Y="A" Q 0
 ;If "^" was entered or there was a Timeout, return "^"
 I (Y="^")!($G(DUOUT)=1)!($G(DTOUT)=1)!($D(DIRUT)) Q "^"
 W !
 ;
BPPRESC ;
 ;User selected (S)pecific Prescriber, allow user to select one or multiple Prescribers.
 N DIC,DIRUT,DTOUT,DUOUT,X,Y
 N ARR,BPSARRAY,BPSRESCAR
 K DIC,X,Y
 ;
 S DIC(0)="QEAM",DIC="^VA(200,",DIC("A")="Select Prescriber: "
 S DIC("S")="I +$G(^VA(200,Y,""PS""))"
 F  D ^DIC Q:X=""  D  Q:$G(BPSARRAY)="^"
 . ; Check for "^" or a timeout, if found set BPSARRAY="^" and quit.
 . I $D(DUOUT)!$D(DTOUT)!($D(DIRUT)) S BPSARRAY="^" Q
 . ;
 . ; Add selection to BPSARRAY and display Prescriber's Name.
 . S BPSARRAY(+Y)=$P(Y,U,2)
 . W " ",$P(Y,"^",2),!
 . ;
 . ; Display a list of current selections.
 . I $D(BPSARRAY) D
 . . S ARR="" F  S ARR=$O(BPSARRAY(ARR)) Q:'ARR  W ?10,BPSARRAY(ARR),!
 ;
 ; If BPSARRAY="^" quit and return "^".
 I $G(BPSARRAY)="^" Q "^"
 ;
 ; If nothing was selected, return "^" so the user will return to the menu 
 I '$D(BPSARRAY) Q "^"
 ;
 ; Create a comma delimited string BPSRESCAR that contains the selected Prescribers ien's.
 S BPSRESCAR=""
 S ARR="" F  S ARR=$O(BPSARRAY(ARR)) Q:'ARR  S BPSRESCAR=BPSRESCAR_ARR_","
 ;
 Q BPSRESCAR
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
 ; If no Patient was selected, return "^" so the user will return to the menu 
 I $G(BPSARRAY)=0 Q "^"
 ;
 M BPARR("PATIENT")=BPSARRAY
 ;
 ; Creates a string of all the patient ien's selected separated by a comma.
 S BPSIEN=""
 F  S BPSIEN=$O(BPARR("PATIENT",BPSIEN)) Q:BPSIEN=""  D
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
 ; If no drug was selected, return "^" so the user will return to the menu
 I $G(BPSDRGARR)=0 Q "^"
 ;
 M BPARR("DRUG")=BPSDRGARR
 ;
 ; Creates a string of all the drug ien's selected separated by a comma.
 S BPSIEN=""
 F  S BPSIEN=$O(BPARR("DRUG",BPSIEN)) Q:BPSIEN=""  D
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
 D SEL("Drug Class","^PS(50.605,",.BPSDCARR)
 ;
 ; If the user entered "^" quit, no longer prompting the user to 'Select Drug Class'
 I $G(BPSDCARR)="^" Q "^"
 ;
 ; If no drug was selected, return "^" so the user will return to the menu
 I $G(BPSDCARR)=0 Q "^"
 ;
 M BPARR("DRUG CLASS")=BPSDCARR
 ;
 ; Creates a string of all the drug class ien's selected separated by a comma. 
 S BPSIEN=""
 F  S BPSIEN=$O(BPARR("DRUG CLASS",BPSIEN)) Q:BPSIEN=""  D
 . I BPARR("DRUG CLASS")'="" S BPARR("DRUG CLASS")=BPARR("DRUG CLASS")_";"
 . S BPARR("DRUG CLASS")=BPARR("DRUG CLASS")_$$GET1^DIQ(50.605,BPSIEN,1)
 . Q
 ;
 Q BPARR("DRUG CLASS")
 ; 
SEL(FIELD,FILE,BPSARRAY,DEFAULT) ;
 ; Provides field selection for One or More
 N DIC,DTOUT,DUOUT,QT,Y,X
 N BPSARR
 ;
 S DIC=FILE,DIC(0)="QEZAM",DIC("A")="Select "_FIELD_": "
 I $G(DEFAULT)'="" S DIC("B")=DEFAULT
 F  D ^DIC Q:X=""  D  Q:$G(QT)
 . ; Check for "^" or timeout, if found set BPSARRAY="^" and quit.
 . I $D(DTOUT)!$D(DUOUT) K BPSARRAY S BPSARRAY="^",QT=1 Q
 . ;
 . ; If selection already exists in BPSARRAY, then display  message
 . ; "(already selected)" and prompt for next selection.
 . I $D(BPSARRAY(+Y)) W "   (already selected)"
 . S BPSARRAY(+Y)=$P(Y,"^",2)
 . W "  ",$P(Y,"^",2),!
 . ;
 . S DIC("A")="Select "_FIELD_": "
 . ;
 . ; display a list of current selections
 . I FIELD="Drug Class" D
 . . S BPSARR=""
 . . F  S BPSARR=$O(BPSARRAY(BPSARR)) Q:'BPSARR  I BPSARR'=+Y W ?3,$$GET1^DIQ(50.605,BPSARR,1),"  ",$$GET1^DIQ(50.605,BPSARR,.01),!
 . ;
 . I $D(BPSARRAY),FIELD'="Drug Class" D
 . . S BPSARR="" F  S BPSARR=$O(BPSARRAY(BPSARR)) Q:'BPSARR  W ?10,BPSARRAY(BPSARR),!
 . K DIC("B")
 ;
 ; If nothing was selected set BPSARRAY=0
 I '$D(BPSARRAY) S BPSARRAY=0
 Q
 ;
