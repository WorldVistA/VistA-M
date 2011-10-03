IBDF1BA ;ALB/CJM - ENCOUNTER FORM (user options for printing - continuation of IBDF1B); 3/1/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**25,34**;APR 24, 1997
 ;
TERMSTRT ;get terminal digit to restart from - OUTPUT=IBREPRNT
 S IBREPRNT="",DIR(0)="F^4:5",DIR("A")="ENTER THE LAST 4 DIGITS OF THE SSN TO BEGIN REPRINT FROM",DIR("?")="ENTER THE LAST FOUR DIGITS OF THE SSN OF THE LAST PATIENT FOR WHOM FORMS WERE PRINTED"
 F  D ^DIR Q:$D(DIRUT)!(Y=-1)  D  Q:IBREPRNT'=""
 .I Y'?4N W !,$C(7),"MUST BE 4 NUMBERS!" Q
 .S IBREPRNT=Y,IBREPRNT=+($E(IBREPRNT,3,4)_$E(IBREPRNT,1,2))
 K DIR
 Q
CLNCSTRT ;get clinic and division to restart from,OUTPUT=IBREPRNT (name of clinic) and IBSTRTDV (division to restart from)
 ;
 N NODE
 S IBREPRNT=""
 S DIR(0)="409.95,.01",DIR("A")="ENTER CLINIC TO BEGIN REPRINT FROM",DIR("?")="ENTER THE LAST CLINIC FOR WHICH ANY FORMS WERE PRINTED"
 D ^DIR K DIR I $D(DIRUT)!(+Y<0) Q
 S NODE=$G(^SC(+Y,0))
 S IBREPRNT=$P(NODE,"^")
 S IBSTRTDV=+$P(NODE,"^",15) I IBSTRTDV S IBSTRTDV=$P($G(^DG(40.8,IBSTRTDV,0)),"^")
 Q
 ;
SEARCH ;get the appointment data on a patient, put in IBTMP array, indexed by appointment
 ;screens out any appts in clinics with nothing defined to print
 N IBX,IBLN,CLINIC,APPT
 S (VASD("F"),VASD("T"))=IBDT,VASD("W")=129 D SDA^VADPT Q:(VAERR!'$D(^UTILITY("VASD",$J)))
 S IBX="" F  S IBX=$O(^UTILITY("VASD",$J,IBX)) Q:IBX=""  D
 . S IBLN=^UTILITY("VASD",$J,IBX,"I"),APPT=+$P(IBLN,"^"),CLINIC=$P(IBLN,"^",2)
 .Q:'APPT!'CLINIC
 .Q:'($D(^SD(409.95,"B",CLINIC))!$D(^SD(409.96,"B",+$$DIVISION^IBDF1B5(CLINIC))))
 .;^UTILITY("VASD",$J,IBX,"E")=(EXTERNAL FORMAT) appt date time^clinic name^status^appt type
 .S IBTMP(APPT)=DFN_"^"_CLINIC_"^"_IBNM_"^"_^UTILITY("VASD",$J,IBX,"E")
 K VASD,VAERR,^UTILITY("VASD",$J)
 Q
 ;
DISP ;display patients/clinics appointments found and get users choice
 ;sort type is by clinic,patient
 N CLNCIEN,CLNCNAME
 I '$D(IBTMP) W !!,?5,"No Active Appointments for ",IBNM," on",!,"this date in any clinic or division that has forms or reports defined to print",! G ENDDISP
 I '$D(IBTMP) W !!,?10,"No Active Appointments in a Clinic with an Encounter Form",!,?10,"for ",IBNM," on this date.",! G ENDDISP
 W !!,"Appointments for ",IBNM,!
 S IBX="" F IBI=1:1 S IBX=$O(IBTMP(IBX)) Q:IBX=""  S IBLN=IBTMP(IBX) W !,$J(IBI,3),"  ",$E($P(IBLN,"^",5),1,20),?25,"   " F IBJ=4,6,7 W "  ",$P(IBLN,"^",IBJ)
 S DIR(0)="LO^1:"_(IBI-1),DIR("A")="    Select Appointments" D ^DIR K DIR G:$D(DIRUT) ENDDISP
 S IBX="" F IBI=1:1 S IBX=$O(IBTMP(IBX)) Q:IBX=""  I Y[(IBI_",") D
 .S CLNCIEN=$P(IBTMP(IBX),"^",2),CLNCNAME=$P(IBTMP(IBX),"^",5)
 .;
 .;list format - ^TMP("IBDF",$J,"P"," ",division name(but set it to " " because for selecting single appts sort by division not needed),clinic name,clinic ien,patient name,dfn,appt)=""
 .;S ^TMP("IBDF",$J,"P"," ",CLNCNAME,CLNCIEN,IBNM,DFN,IBX)=""
 .S ^TMP("IBDF",$J,"P"," ",$E(CLNCNAME,1,25),CLNCIEN,$E(IBNM,1,25),DFN,IBX)=""
 .;also keep an index by ...,"APPT LIST",DFN,APPT)
 .S ^TMP("IBDF",$J,"APPT LIST",DFN,IBX)=""
ENDDISP K IBTMP,IBX,IBI,IBJ,IBLN,DTOUT,DUOUT,DIRUT,DIROUT,X,Y,^UTILITY("VASD",$J)
 Q
 ;
STARTDIV() ;asks what division to restart the job from and returns division name, or "" if user declines
 N IBDIV
 K DIC S DIC="^DG(40.8,",DIC(0)="AEQMN",DIC("A")="SELECT THE DIVISION TO START THE REPRINT FROM: "
 S IBDIV=$O(^DG(40.8,0)) S:IBDIV DIC("B")=$P($G(^DG(40.8,IBDIV,0)),"^")
 D ^DIC K DIC
 I (+Y<0)!$D(DTOUT)!$D(DUOUT) Q ""
 Q $P(Y,"^",2)
SORTBY ;sort by clinic/patient, clinic/terminal digit, or terminal digit?
 K DIR S DIR(0)="S^1:Division/Clinic/Patient Name;2:Division/Terminal Digits;3:Division/Clinic/Terminal Digits"
 S DIR("?")="Enter '1' for sorting by Division/Clinic/Patient Name or '2' to sort by Division/Terminal Digits or '3' to sort by Division/Clinic/Terminal Digits."
 S DIR("A")="How should the output be SORTED?",DIR("B")="1" D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 I Y'=1,Y'=2,Y'=3 S QUIT=1 Q
 S IBSRT=Y
 Q
