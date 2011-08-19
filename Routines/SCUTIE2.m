SCUTIE2 ;ALB/SCK - IEMM LIST MANAGER UTILITIES; 16-JUN-97
 ;;5.3;Scheduling;**66**;AUG 13, 1993
 ;
 Q
ENTRY(SDYX) ;   Get entry for incomplete encounter lookup.  Mimics the selection process in
 ;  Appointment Management, but allows for the additional selection of an error code from
 ;  the Transmitted OP ENC Error Code file.
 ;
 ;    Input:
 ;        SDYX - Pointer to return variable for the IEN of the selected Patient, Clinic, or Error code
 ;
 ;    Sets SDENTYP as follows:
 ;          P  -   Patient Selection
 ;          C  -   Clinic Selection
 ;          E  -   Error Code Selection
 ;
 S DIR(0)="FA",DIR("A")="Select Patient name, Clinic name, or Error Code: "
 S DIR("?")="Enter as P.patient name, C.clinic name, or E.error name"
 S DIR("??")="^D HELP^SCUTIE2"
 D ^DIR K DIR I $D(DIRUT) S VALMQUIT="" G ENQ
 ;
 I $E(Y,1,2)="P."!($E(Y,1,2)="p.") D  G ENQ
 . S SDYX=$$LOOKUP($P(Y,".",2),2)
 . S SDENTYP="P"
 ;
 I $E(Y,1,2)="C."!($E(Y,1,2)="c.") D  G ENQ
 . S SDYX=$$LOOKUP($P(Y,".",2),44)
 . S SDENTYP="C"
 ;
 I $E(Y,1,2)="E."!($E(Y,1,2)="e.") D  G ENQ
 . S SDYX=$$LOOKUP($P(Y,".",2),409.76)
 . S SDENTYP="E"
 ;
 S SDYX=$$MULTLKUP(Y)
ENQ Q $G(SDYX)>0
 ;
LOOKUP(X,SCG) ;  Look up IEN for the specified file
 ;
 ;    Input:
 ;        X     - Lookup value for the DIC call
 ;      SCG     - The file to do the lookup on
 ;
 ;    Returns  Y = the IEN of the selected entry
 ;
 S DIC=SCG,DIC(0)="EMQ"
 D ^DIC
 Q $G(Y)
 ;
MULTLKUP(SD1) ;  Lookup entry for unspecified selection file.  Try searching the patient
 ;  file, hospital location file, and the transmitted OP ENC error code file for
 ;  a possible match.
 ;
 ;   Input:
 ;          SD1  -  Lookup value
 ;
 ;   Returns Y = The IEN of the selected entry
 ;  
 N Y,X,SCVAL,DUOUT,DTOUT
 ;
 S SD1=$$UPPER^VALM1(SD1)
 ;  First pass, try patient file for match
 W !!,"Searching for patient ",SD1
 K DIC S DIC=2,DIC(0)="EM",X=SD1
 D ^DIC K DIC
 I +Y>0 S SCVAL=$$OK
 E  S SCVAL=0
 I $G(SCVAL)<0 Q -1
 I $G(SCVAL)'=0 S SDENTYP="P" G MLTQ
 ;
 ; Second pass, try hospital location file for match
 W !!,"Searching for Clinic ",SD1
 K DIC S DIC=44,DIC(0)="EM",X=SD1
 D ^DIC K DIC
 I +Y>0 S SCVAL=$$OK
 E  S SCVAL=0
 I SCVAL<0 Q -1
 I SCVAL'=0 S SDENTYP="C" G MLTQ
 ;
 ; Final pass, try error file for match
 W !!,"Searching for Error Code ",SD1
 K DIC S DIC=409.76,DIC(0)="EM",X=SD1
 D ^DIC K DIC
 I +Y>0 S SCVAL=$$OK
 E  S SCVAL=0
 I SCVAL<0 Q -1
 I SCVAL'=0 S SDENTYP="E" G MLTQ
MLTQ Q $G(Y)
 ;
OK() ;  Ask user if displayed entry is ok for selection.
 ;  Return 1 if Ok, 0 if not
 N Y
 K DIRUT,DIR
 W !
 S DIR(0)="SA^Y:Yes;N:No",DIR("A")="  ...OK? ",DIR("B")="Yes"
 S DIR("?")="Answer with Yes to accept, or No to ignore"
 D ^DIR K DIR
 Q $S($D(DIRUT):-1,1:Y="Y")
 ;
HELP ;
 ;
 W !?2,"Enter P.patient name to select a specific patient,"
 W !?2,"C.clinic name to select a specific clinic, or E.Error Name"
 W !?2,"to select a specific error.",!
 W !?2,"If selecting a specific error by its description it may be"
 W !?2,"necessary to enter more than three characters(Ex. E.Abxxxx)."
 W !?2,"Because this is a descriptive field, case sensitivity applies.",!
 W !?2,"If just a name is entered, any matches will be displayed in"
 W !?2,"patient, clinic, error code order.  You will have the option"
 W !?2,"of selecting or ignoring the choice.",!
 Q
