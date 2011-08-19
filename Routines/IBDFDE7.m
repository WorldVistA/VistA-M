IBDFDE7 ;ALB/AAS - AICS Manual Data Entry, Entry point for Group Clinics ; 29-APR-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**36,51**;APR 24, 1997
 ;
 W !,?4,"** This option is OUT OF ORDER **" QUIT   ;Code set Versioning
 ;
% N %,%H,C,I,J,X,Y,ADD,DEL,ASKOTHER,DIR,DIC,DA,CNT,DFN,DIRUT,DUOUT,DTOUT,POP,RTN,FRMDATA,IBDA,IBY,IBQUIT,IBDF,IBDOBJ,IBDPTSTI,IBDPTSTE,IBDPTNM,IBDPTDTI,SEL,IBD,IBDCKOUT
 N IBDPTDTE,IBDFMNME,IBDFMIEN,IBDFMSTI,IBDFMSTE,IBDFMIDI,IBDCLNME,IBFORM,IBDCLNPH,IBDPID,IBDPTPRI,IBDSEL,IBDPI,IBDCO,PXCA,SDCLST,PXCASTAT,PXKNODA,PXKNODB,IBDREDIT,IBDASK,IBDPRE,IBDX,ANS,CLNAME,CLSETUP,IBDSC,FORM,FORMLST,IBDFDT
 ;
 I '$D(DT) D DT^DICRW
 D HOME^%ZIS
 W !!,"Data Entry of Encounter Forms for Group Clinics",!
 ;
STRT ; -- ask for Clinic, appt. date/time
 ;    list patients, allow to deselect
 ;    find all forms for appt., then go through 1 at a time
 ;    then send data for each patient
 ;
 D END W !
 S IBQUIT=0
 S (IBDSC,IBDF("CLINIC"))=$$SELCL^IBDFDE6 G:IBQUIT STRTQ
 I IBDSC<1 S IBQUIT=1 G STRTQ
 S CLNAME=$P($G(^SC(+IBDSC,0)),"^")
 S CLSETUP=$G(^SD(409.95,+$O(^SD(409.95,"B",+IBDSC,0)),0))
 ;
OVER ;
 W !
 S IBQUIT=0
 S IBDFDT=$$SELAPT(.IBDF) G:IBQUIT STRTQ
 I IBDFDT<0 G STRT
 S IBDF("APPT")=IBDFDT
 ;
 D BLD
 I '$D(^TMP("IBD-PL",$J,IBDF("CLINIC"))) W !!,"No valid appointments at that Date/Time!",!! G STRTQ
 ;
 D HDR^IBDFDE6,LIST^IBDFDE6
 W !!
 D EXCLUD
 I IBQUIT=2 S IBQUIT=0 G STRTQ
 G:IBQUIT STRTQ
 ;
 ; -- get first patient, check form(s)
 ;   do data entry on form and if okay pass data for all patients
 S IBDSTRT=+$O(^TMP("IBD-PL",$J,IBDF("CLINIC"),0))
 S NODE=$G(^TMP("IBD-PL",$J,IBDF("CLINIC"),IBDSTRT))
 S (DFN,IBDFN)=+NODE
 S FORMLST=$$FINDID^IBDF18C(DFN,IBDF("APPT"),"",1)
 I FORMLST="" W !,"No forms Printed for first Patient" D ANYWAY^IBDFDE6
 I FORMLST="" G OVERQ
 S IBDF("SAVE")=1 ;save ibdsel(array)
 F IBDX=1:1 S IBDF("FORM")=$P(FORMLST,"^",IBDX) Q:IBDF("FORM")=""  I IBDF("FORM")'="" D EN^IBDFDE D
 .I $G(IBDF("NOTHING"))!(IBQUIT) W !! Q
 .D ALLPTS K IBDSEL,IBDPI Q:IBQUIT
 K IBDF("SAVE")
 ;
OVERQ G OVER
 ;
STRTQ D PAUSE^IBDFDE G:IBQUIT END
 G STRT
 ;
ALLPTS ; -- loop through all patients, merge ibdf=^tmp("ibd-save),
 ;    reset dfn, pass data to ibdfrpc4
 N PARAM,FORMID,IBX,NODE
 S FORMID=$P(^IBD(357.96,+IBDF("FORM"),0),"^",4)
 S PARAM=$P($G(^IBD(357.09,1,0)),"^",7)
 I $G(^TMP("IBD-SAVED",$J,"DYNAMIC")) W !!,"Form contains patient specific information, Not available for this option!",!! G ALLPTQ
 S IBDA=IBDSTRT
 F  S IBDA=$O(^TMP("IBD-PL",$J,IBDF("CLINIC"),IBDA)) Q:IBDA=""!(IBQUIT)  D
 .S IBX=IBDA
 .S NODE=$G(^TMP("IBD-PL",$J,IBDF("CLINIC"),IBX))
 .M IBDF=^TMP("IBD-SAVED",$J)
 .S (DFN,IBDF("DFN"))=+NODE
 .S IBDF("SDOE")=$P(NODE,"^",22)
 .S IBDF("FORM")=+$$FID^IBDF18C(DFN,IBDF("APPT"),1,FORMID,IBDF("CLINIC"))
 .W !!,"Check out interview for: ",$P($G(^DPT(DFN,0)),"^")
 .K IBDCO,IBDF("AO"),IBDF("SC"),IBDF("IR"),IBDF("EC"),IBDF("MST")
 .D CHKOUT^IBDFDE0(IBDF("SDOE"))
 .M IBDF=IBDCO
 .D SEND^IBDFRPC4(.RESULT,.IBDF)
 .I PARAM=3 D DISP^IBDFDE1
 .I PARAM,$D(PXCA("ERROR"))!($D(PXCA("WARNING"))) D ERR^IBDFDE1
 .I $P($G(^IBD(357.09,1,0)),"^",6) D MAKAPPT^IBDFDE1
 ;
 K ^TMP("IBD-SAVED",$J)
ALLPTQ Q
 ;
SELAPT(IBDF) ; -- select appointment date/time for a clinic
 N DIR,DA,DR,DIC,DIE,X,Y,ANS,DIRUT
 S ANS=-1
 S DIR(0)="DO^:NOW:AEXRT^D SCRN^IBDFDE7",DIR("A")="Appointment Date/Time"
 S DIR("?")="Enter the date/time for the clinic that you wish to enter encounter forms for.  Appointments must be present to enter the date time."
 S DIR("??")="^D APDT^IBDFDE7"
 D ^DIR K DIR
 I $D(DIRUT) G SELAPQ
 S ANS=+Y
SELAPQ Q ANS
 ;
SCRN ; -- input transform logic for selecting an appointment date/time
 I $G(IBDF("CLINIC"))="" K X
 I '$D(^SC(IBDF("CLINIC"),"S",Y,1)) W $C(7),"??  No appointments that time." K X
 Q
 ;
EXCLUD ; -- select patient(s) to process
 S RESULT=""
 S DIR("?")="Enter the number of the patient to exclude."
 S DIR("??")="^D LIST^IBDFDE6"
 S DIR(0)="FO^1:30",DIR("A")="Exclude Patient"
 I RESULT'="" S DIR("A")="Exclude Another Patient"
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) S IBQUIT=1 G EXCLUDQ
 S ANS=Y
 I ANS="" G EXCLUDQ
 I ANS'=+ANS W !,"You must select a number from the list."
 I ANS=+ANS,$D(^TMP("IBD-PL",$J,IBDF("CLINIC"),ANS)) D
 .S RESULT=^TMP("IBD-PL",$J,IBDF("CLINIC"),ANS)
 .K ^TMP("IBD-PL",$J,IBDF("CLINIC"),ANS),^TMP("IBD-PLN",$J,IBDF("CLINIC"),$P($G(^DPT(+RESULT,0)),"^"))
 .W "  ",$P($G(^DPT(+RESULT,0)),"^"),"   ","Excluded!"
 ;
 I '$D(^TMP("IBD-PL",$J,IBDF("CLINIC"))) W !!,"No patients left" S IBQUIT=2 G EXCLUDQ
 ;
 G EXCLUD
EXCLUDQ Q
 ;
BLD ; -- Find all appointments for a date
 K ^TMP("IBD-PL",$J),^TMP("IBD-PLN",$J)
 N SC,IBD,IBD1
 S IBD=IBDFDT,SC=IBDF("CLINIC"),CNT=0
 S IBD1=0 F  S IBD1=$O(^SC(SC,"S",IBD,1,IBD1)) Q:'IBD1  D
 .S NODE=$G(^SC(SC,"S",IBD,1,IBD1,0))
 .S SNODE=$G(^DPT(+NODE,"S",IBD,0))
 .S X=$P(SNODE,"^",2)
 .I X'="","CNAPCA"[X Q  ;inpatient appointments are okay
 .S (DFN,IBDF("DFN"))=+NODE
 .S CNT=CNT+1
 .S ^TMP("IBD-PL",$J,SC,CNT)=DFN_"^"_IBD_"^"_SNODE
 .S ^TMP("IBD-PLN",$J,SC,$P(^DPT(DFN,0),"^"))=DFN_"^"_IBD_"^"_SNODE
 Q
 ;
LIST ; -- print list of patients
 N IBD,IBJ,FORM,STATUS
 S IBD=0 F  S IBD=$O(^TMP("IBD-PL",$J,IBDF("CLINIC"),IBD)) Q:'IBD  D
 .S DFN=+$G(^TMP("IBD-PL",$J,IBDF("CLINIC"),IBD)),APPT=$P($G(^(IBD)),"^",2),SNODE=$P($G(^(IBD)),"^",3,99)
 .S FORM=+$$FINDID^IBDF18C(DFN,APPT,"",1),STATUS="NO FORM PRINTED"
 .I FORM S Y=$P($G(^IBD(357.96,+FORM,0)),"^",11),C=$P(^DD(357.96,.11,0),"^",2) D Y^DIQ S STATUS=Y
 .W !?2,IBD,?5,$E($P(^DPT(DFN,0),"^"),1,20),?29,$P($G(^DPT(DFN,.36)),"^",3),?43,$$FMTE^XLFDT(+APPT),?64,$E($G(STATUS),1,16)
 Q
 ;
APDT ; -- list last 30 days appointment dates in clinic
 S (X,Y)=$$FMADD^XLFDT(DT,-60),CNT=0
 F  S X=$O(^SC(IBDF("CLINIC"),"S",X)) Q:'X!(X>DT)  D
 .S Y=X,CNT=CNT+1
 .I CNT=1 W !!,"The following are valid Appointment date/times in the past 60 days:"
 .W:(CNT#3=1) !,?3,$$FMTE^XLFDT(Y)
 .W:(CNT#3=2) ?30,$$FMTE^XLFDT(Y)
 .W:(CNT#3=0) ?60,$$FMTE^XLFDT(Y)
 Q
 ;
HDR ; -- print Clinic header
 W @IOF
 W !,"      Clinic: ",$E(CLNAME,1,25) W ?40,"       Date: ",$$FMTE^XLFDT(IBDFDT)
 S FORM=$P(CLSETUP,"^",2),IBDFMNME=$P($G(^IBE(357,+FORM,0)),"^")
 W !,"  Basic Form: ",$E(IBDFMNME,1,25) ;W ?40,"Form Status: ",$E(IBDFMSTE,1,25)
 W !,$TR($J(" ",IOM)," ","=")
 Q
 ;
END K I,J,X,Y,DA,DR,DIC,DIE,DIR,DTOUT,DUOUT,DIRUT,IBDSEL,CHOICE,TEXT,TEXTU,RESULT,IBDPI,IBDCO,IBDF,IBDA,SDFN
 K ^TMP("IBD-PL",$J),^TMP("IBD-PLN",$J),^TMP("IBD-SAVED",$J),^TMP("IBD-MORE",$J),^TMP("IBD-PLCHK",$J),^TMP("IBD-PL4",$J),^TMP("IBD-PLB",$J)
 K ^TMP("IBD-ASK",$J),^TMP("IBD-LCODE",$J),^TMP("IBD-LST",$J),^TMP("IBD-LTEXT",$J),^TMP("IBD-OBJ",$J)
 Q
