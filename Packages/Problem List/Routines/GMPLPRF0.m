GMPLPRF0 ; SLC/MKB -- Problem List User Prefs cont ;;9-5-95 11:54am
 ;;2.0;Problem List;**3**;Aug 25, 1994
CURRENT(USER) ; Show user's current preference
 N VIEW,NUM W !!,"CURRENT VIEW:  "
 S VIEW=$P($G(^VA(200,USER,125)),U),NUM=$S($L(VIEW,"/")<3:"all",1:$L(VIEW,"/")-2)
 I $E(VIEW)="S" W "Inpatient, "_NUM_" services included",! Q
 I $E(VIEW)="C" W "Outpatient, "_NUM_" clinics included",! Q
 W "None defined",!,"              (Default is outpatient, all clinics included)",!
 Q
 ;
CHANGE() ; Want to change preferred view?
 N DIR,X,Y S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Do you want to change your preferred view? "
 S DIR("?",1)="Enter YES if you want to change your preferred view of patient",DIR("?",2)="problem lists; NO will exit this option, leaving your view unchanged."
 S DIR("?",3)="Your preferred view will determine what information you see about",DIR("?")="each problem, and whether you see a complete or partial list."
 D ^DIR
 Q +Y
 ;
VIEW(MODE) ; Returns user's preferred view, by 'S'ervice or 'C'linic
 N DIR,X,Y S DIR("B")=$S(MODE="S":"INPATIENT",1:"OUTPATIENT")
 S DIR(0)="SAOM^C:OUTPATIENT;S:INPATIENT;",DIR("A")="Select VIEW: "
 S DIR("?",1)="Choose from: Outpatient"
 S DIR("?",2)="             Inpatient"
 S DIR("?",3)="An OUTPATIENT view will display information regarding the clinic that",DIR("?",4)="is following each problem; an INPATIENT view will display service and",DIR("?")="responsible provider information."
 D ^DIR S:$D(DTOUT)!($D(DUOUT)) Y="^"
 Q Y
 ;
ALL(MODE,DEFLT) ; Include all problems, or select from clinics/services?
 N DIR,X,Y
 S DIR(0)="SAOM^A:ALL;S:SELECTED;",DIR("B")=$S(DEFLT<3:"ALL",1:"SELECTED")
 S DIR("A")="Include (A)ll problems or only those from (S)elected "_$S(MODE="S":"services",1:"clinics")_"? "
 S DIR("?",1)="Enter A to display all active problems for the selected patient, or S to",DIR("?",2)="see a partial list.  You may select specific "_$S(MODE="S":"inpatient services",1:"outpatient clinics")_", and only"
 S DIR("?",3)="those problems associated with them will be shown at first; the remainder",DIR("?",4)="of the patient's problems are always available to display through the",DIR("?")="""Select View"" action."
 D ^DIR S:$D(DTOUT)!($D(DUOUT)) Y="^" S:Y="A" Y=1 S:Y="S" Y=0
 Q Y
