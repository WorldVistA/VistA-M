IBDF1B ;ALB/CJM - ENCOUNTER FORM (printing forms for appointments); 3/1/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**29**;APR 24, 1997
 ;
 ;IBSRT=1 for sort by clinic/patient name
 ;IBSRT=2 for sort by terminal digits
 ;IBSRT=3 for sort by clinic/terminal digits
 ;
 ;SELECTBY="P" if user wants to select appts by patient
 ;SELECTBY="C" if user wants to select appts by division/clinic
 ;
 ;IBDT=date for appointments
 ;IBREPRNT'="" if this is a reprint of a previous job - then it's either equal to clinic name or 1st 4 terminal digits
 ;IBSTRTDV is the division to start from in the case of a reprint
 ;IBADDONS=1 if user wants to do add-ons only, 0 otherwise
 ;
EN ;
 N IBREPRNT,SELECTBY,IBDT,IBSRT,IBADDONS,IBSTRTDV,QUIT,X
 S (IBSTRTDV,IBREPRNT)="",(QUIT,IBADDONS)=0
 ;
 ;set the error trap so workspace in ^TMP is erased in case of abnormal termination of the print job
 S X="ERRORTRP^IBDF1B",@^%ZOSF("TRAP")
 ;
 K ^TMP("IBDF",$J),^TMP("IB",$J)
 D HOME^%ZIS
 D
 .D SELECTBY Q:QUIT  S:SELECTBY="P" IBSRT=1 ;if selecting by patient then sort by clinic/patient rather than by terminal digits
 .D:SELECTBY="C" SORTBY^IBDF1BA Q:QUIT
 .D APPTDATE Q:QUIT
 .;now allow user to makes selections, whether by patient or clinic
 .D @SELECTBY
 .;
 .;if nothing selected exit
 .Q:'$D(^TMP("IBDF",$J))
 .;
 .;since selecting by entire clinics, may want to do add-ons only or restart the job
 .I SELECTBY="C" D  Q:QUIT
 ..D ADDONS Q:QUIT
 ..D REPRINT Q:QUIT
 ;
 ;
 ;if nothing selected exit
END G:('$D(^TMP("IBDF",$J)))!QUIT EXIT
 W !,$C(7),"** Encounter Forms require a page size of 80 lines and 132 columns. **"
 K %IS,%ZIS,IOP S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="^IBDF1B1",ZTDESC="IBDF Encounter Forms",ZTSAVE("^TMP(""IBDF"",$J,")="",ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q") W !,$S($D(ZTSK):"Request Queued Task="_ZTSK,1:"Request Canceled") D HOME^%ZIS G EXIT
 U IO
 D ^IBDF1B1
EXIT ;
 K ^TMP("IBDF",$J),^TMP("IB",$J),^TMP("RPT",$J),^TMP("DFN",$J)
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K DTOUT,DUOUT,DIRUT,DIROUT,X,Y,D0,DA,IBTYPE
 D ^%ZISC
 Q
 ;
REPRINT ;for prior job that partially completed?
 ;IBSTRTDV is the division to restart from
 ;IBREPRNT is the clinic or first 4 of terminal digits to restart from
 S DIR(0)="Y",DIR("A")="IS THIS A REPRINT OF A PREVIOUS RUN"
 S DIR("B")="NO",DIR("?")="ANSWER YES IF SOME OF THE FORMS WERE ALREADY PRINTED BY A PREVIOUS JOB THAT DID NOT SUCCESSFULLY COMPLETE"
 D ^DIR K DIR I $D(DIRUT)!(Y=-1) S QUIT=1 Q
 I Y D  I IBREPRNT="" S QUIT=1 Q
 .I IBSRT=2 D  ;sorting by division/terminal digit
 ..;ask which division to restart from
 ..S IBSTRTDV=$$STARTDIV^IBDF1BA I IBSTRTDV="" S IBREPRNT="" Q
 ..;ask which terminal digit to restart from
 ..D TERMSTRT^IBDF1BA Q:IBREPRNT=""
 .I (IBSRT=1)!(IBSRT=3) D CLNCSTRT^IBDF1BA ;sorting by division/clinic, ask which clinic to restart from
 Q
ADDONS ;add-ons only?
 S DIR(0)="Y",DIR("A")="WANT TO PRINT ADD-ONS ONLY"
 S DIR("B")="NO",DIR("?")="ANSWER YES TO ONLY PRINT ADD-ONS"
 D ^DIR K DIR I $D(DIRUT)!(Y=-1) S QUIT=1 Q
 S IBADDONS=Y
 Q
SELECTBY ;select by patient or clinic?
 W !,"Do you want to print forms for a particular patient or for entire clinics?",!
 K DIR S DIR("B")="Clinic",DIR(0)="SO^P:Patient;C:Clinic",DIR("A")="Select Appointment by"
 D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 S SELECTBY=Y
 Q
 ;
P ;print by patient - get patient then appointment(s) for date
 N IBTMP,IBNM,DFN
 ;IBNM=patient name, IBTMP=array to store patient's appts
 F  K DIC S DIC="^DPT(",DIC(0)="AEQM" D ^DIC K DIC Q:Y<0  S DFN=+Y,IBNM=$P(Y,"^",2) D SEARCH^IBDF1BA,DISP^IBDF1BA
 Q
 ;
C ;print all appointments for a clinic - find division then clinic, print all/some clinics for all/some divisions
 ;
 N GROUPS,IEN
 ;
 ;get the PRINT MANAGER CLINIC GROUPS
 S GROUPS=""
 K DIR
 S DIR(0)="PAO^357.99:AEMQ",DIR("A")="Select Print Manager Clinic Group:",DIR("?")="You can choose from previously defined clinic groups."
 F  D ^DIR Q:((+Y<0)!$D(DIRUT))  S GROUPS(+Y)="",DIR("A")="Select another Print Manager Clinic Group:"
 S GROUPS=0 F  S GROUPS=$O(GROUPS(GROUPS)) Q:'GROUPS  D
 .S IEN=0 F  S IEN=$O(^IBD(357.99,GROUPS,10,IEN)) Q:'IEN  S IBCLN=+$G(^IBD(357.99,GROUPS,10,IEN,0)) S:IBCLN ^TMP("IBDF",$J,"C",IBCLN)=""
 .S IEN=0 F  S IEN=$O(^IBD(357.99,GROUPS,11,IEN)) Q:'IEN  S IBDIV=+$G(^IBD(357.99,GROUPS,11,IEN,0)) S:IBDIV ^TMP("IBDF",$J,"D",IBDIV)=""
 K DIR
 G:$O(GROUPS(0)) ENDC
 ;
 ;now ask divisions and clinics
 W !!,"Now you can select individual divisions and clinics."
 ;D ASK2^IBODIV G:$D(VAUTD)<11&(VAUTD=0) ENDC
 S VAUTD=1 I $P($G(^DG(43,1,"GL")),"^",2) D DIVISION^VAUTOMA I Y=-1 G ENDC
 S DIC("S")="I $P(^SC(+Y,0),U,3)=""C"",$S(VAUTD:1,$D(VAUTD(+$P(^(0),U,15))):1,'+$P(^(0),U,15)&$D(VAUTD($O(^DG(40.8,0)))):1,1:0)"
 W !!,"If you want to print forms for all clinics in the divisions you have",!,"chosen (for those clinics with forms defined) then select ALL."
 W !!,"Otherwise, select the particular clinics you want.",!
 S DIC="^SC(",VAUTVB="VAUTC",VAUTNI=2,VAUTSTR="clinic" D FIRST^VAUTOMA K DIC G:$D(VAUTC)<11&(VAUTC=0) ENDC
 I VAUTC,VAUTD S ^TMP("IBDF",$J,"D","ALL")=""
 I VAUTC,'VAUTD S IBDIV="" F  S IBDIV=$O(VAUTD(IBDIV)) Q:IBDIV=""  S ^TMP("IBDF",$J,"D",IBDIV)=""
 I 'VAUTC S IBCLN="" F  S IBCLN=$O(VAUTC(IBCLN)) Q:IBCLN=""  S ^TMP("IBDF",$J,"C",IBCLN)=""
ENDC K VAUTNI,VAUTD,VAUTC,VAUTVB,VAUTSTR,IBDIV,IBCLN,DIC
 Q
 ;
APPTDATE ;print forms for appointments on what date?
 K DIR S DIR(0)="D^::AEX",DIR("B")="TODAY",DIR("A")="Appointment Date to Print Forms For"
 S DIR("?",1)="Only Clinics and Patients with Appointments on this Date will be allowed."
 S DIR("?")="Nothing will print for Appointments in Clinics/Divisions with no forms defined."
 D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 S IBDT=Y
 Q
 ;
ERRORTRP ;the error trap
 K ^TMP("IBDF",$J),^TMP("IB",$J)
 D @^%ZOSF("ERRTN")
 Q
