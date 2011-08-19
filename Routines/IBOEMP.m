IBOEMP ;ALB/ARH - EMPLOYER REPORT ; 6/19/92
 ;;Version 2.0 ; INTEGRATED BILLING ;**33**; 21-MAR-94
 ;
 ;Included in Report:
 ;                Employer Name Range can be choosen
 ;    All:        Patient must NOT have active insurance on date of event
 ;                Patient must not be dead
 ;                Patients (2,.31115) or Spouses (2,.2515) Eployment Status is:
 ;                       1 - EMPLOYED FULL TIME
 ;                       2 - EMPLOYED PART TIME
 ;                       4 - SELF EMPLOYED
 ;                       5 - RETIRED
 ;     or
 ;                Patient (2,.3111) or Spouse (2,.251) (VAOA(9)) Employer Name is defined
 ;
 ;    Inpatient:  Admission Movements (405,.02=1):
 ;
 ;    Outpatient: division can be choosen by the user
 ;                Scheduling Visits (409.5), unscheduled visits
 ;                Scheduled visits:
 ;                        Hospital Location must be "C" Clinic (44,2.1)
 ;                        Patient visit Outpatient, not cancelled or no-showed (2,1900,3="")
 ;                Dispositions, that are not Application Without Exam ((2,1000,1)<2)
 ;
 ;Printed on Report: Report is sorted by employer name, within employers, by patient name
 ;                   For employers to match their name, address, and  phone number must match exactly
 ;    All:        Employer Name, phone, address
 ;                if employment status is employed but no employer name use {unspecified} for employer name
 ;                Patient Name, SSN, Primary Eligibility, home ph number
 ;    Inpatient:  Admission Date, Transaction (405,.02)
 ;    Outpatient: Appointment Date, Appointment Type (409.5,5) or "DIPSOSITION"
 ;    For Employed: Name, SSN, Occupation, Employment Status, for patient-work ph number
 ;              
 ;               
EN ;report on employers of patients with no insurance at time of care
 D HOME^%ZIS S IBHDR="EMPLOYER REPORT" W @IOF,?27,IBHDR,!!!!
RG S DIR("?",1)="Specify the employers to list in the report by entering:",DIR("?",2)=" 1. the first character in the Employer's Name"
 S DIR("?",3)=" 2.""-"" for patients who indicated they were employed but who have no employer"
 S DIR("?",4)=" 3.""+"" for all employers.",DIR("?")="Enter one character only"
 S DIR(0)="FO^1:1",DIR("A")="Beginning Value",DIR("B")="+"
 D ^DIR K DIR G:$D(DIRUT) EXIT I Y="+" S IBRGB=-1,IBRGE=999 G NX
 I Y="-" S (IBRGB,IBRGE)=-1 G NX
 S IBRGB=$A(Y) S DIR("?")="Enter the last character in the Employer Name range to include"
 S DIR(0)="FO^1:15",DIR("A")="Ending Value",DIR("B")="Z" D ^DIR K DIR G:$D(DIRUT) EXIT S IBRGE=$A(Y)
 I IBRGB<65!(IBRGE>90) W "??" G RG
NX I IBRGE<IBRGB W "??" G RG
 ;
 S DIR("?")="The Employer Report can be printed for either INPATIENT MOVEMENTS or OUTPATIENT VISITS.  Enter the code cooresponding to your choice."
 S DIR(0)="SOB^INPT:Inpatient;OPT:Outpatient",DIR("A")="Select PATIENT TYPE"
 D ^DIR K DIR G:$D(DIRUT) EXIT S IBCH=Y I IBCH="OPT" D ASK2^IBODIV G:Y<0 EXIT
 S IBFLD="Date" D RANGE G:IBQUIT EXIT
 ;
DEV ;get the device
 W !!,"Report requires 132 columns."
 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="EN1^IBOEMP",ZTDESC=IBHDR,ZTSAVE("IB*")="",ZTSAVE("VAUTD*")="" D ^%ZTLOAD K IO("Q") G EXIT
 U IO
 ;
EN1 ;tasked entry point
 S IBES="FULL TIME^PART TIME^NOT EMPL'D^SELF EMPL'D^RETIRED^ACTIVE DUTY^^^UNKNOWN"
 D ^IBOEMP1 I 'IBQ D PHDR,^IBOEMP2
 K IBES,VAUTD,VAERR,IBHDR1,IBPGN,IBQ,IBLN,IBDSH,IBI,IBDIV,IBCDT,IBX,IBY,X,Y
 ;
EXIT K ^TMP("IBEMP",$J) I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K X,Y,VA,DTOUT,DUOUT,DIRUT,DIROUT,DIOEND,IBCH,IBEND,IBBEG,IBQUIT,IBBEGE,IBENDE,IBFLD,IBHDR,IBRGB,IBRGE
 Q
 ;
PHDR ;create print header
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S IBCDT=$P(Y,"@",1)_"  "_$P(Y,"@",2)
 S (IBPGN,IBQ,IBLN)=0,IBDSH="" F IBI=1:1:IOM S IBDSH=IBDSH_"-"
 S (IBHDR1,IBDIV)="" I $D(VAUTD) S:VAUTD=1 IBHDR1="ALL DIVISIONS" I $D(VAUTD)=11 D
 . S IBDIV=$O(VAUTD(IBDIV)),IBHDR1="DIVISION: "_VAUTD(IBDIV)
 . F  S IBDIV=$O(VAUTD(IBDIV)) Q:IBDIV=""  S IBHDR1=IBHDR1_", "_VAUTD(IBDIV)
 Q
 ;
 ;
RANGE ;get date range
 S DIR(0)="D^:NOW:EX",DIR("A")="START WITH "_IBFLD
 D ^DIR K DIR I $D(DIRUT) S IBQUIT=1 Q
 S IBBEG=Y X ^DD("DD") S IBBEGE=Y
 S DIR(0)="D^"_IBBEG_":NOW:EX",DIR("A")="GO TO "_IBFLD,DIR("B")="TODAY"
 D ^DIR K DIR I $D(DIRUT) S IBQUIT=1 Q
 S IBEND=Y X ^DD("DD") S IBENDE=Y,IBQUIT=0
 Q
