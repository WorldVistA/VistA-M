IBTRE2 ;ALB/AAS - CLAIMS TRACKING - ACTIONS ;27-JUN-93
 ;;2.0;INTEGRATED BILLING;**23,121,249,312**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G EN^IBTRE
 ;
AT ; -- Add tracking entry
 I '$$PFSSWARN^IBBSHDWN() S VALMBCK="R" Q                   ;IB*2.0*312
 D FULL^VALM1
 N X,Y,DIC,DA,DR,DD,DO,DIR,DIRUT,DTOUT,DUOUT,IBETYP,IBQUIT,IBTDT,VAIN,VAINDT,IBTRN,IBTDTE
 ;
TEST S IBQUIT=0
 S DIC(0)="AEQMNZ",DIC="^IBE(356.6,",DIC("S")="I $P(^(0),U,3)<3",DIC("A")="Select Tracking Type: "
 D ^DIC K DIC S IBETYP=+Y I +Y<0 G ATQ
 W !
 ;
ADM I IBETYP=$O(^IBE(356.6,"AC",1,0)) D  I IBQUIT G ATQ
 .N DIR
 .S DIR("?")="     "
 .S DIR("?",1)="    Enter any Date!"
 .S DIR("?",2)="  "
 .S DIR("?",3)="    If the patient was an inpatient on that date the system will use the"
 .S DIR("?",4)="    correct admission date.  If you are tracking an admissions at another"
 .S DIR("?",5)="    facility you may enter that date.  Enter '??' to get a list of the"
 .S DIR("?",6)="    last 10 admissions for this patient."
 .S DIR("??")="^D LISTA^IBTRE20"
 .S DIR(0)="DO^::AEXTP",DIR("A")="Admission Date"
 .D ^DIR K DIR S (IBTDT,VAINDT)=+Y I $P(VAINDT,".",2)="" S VAINDT=VAINDT+.24
 .I $D(DIRUT)!($P(IBTDT,".")'?7N) S IBQUIT=1 Q
 .; -- check for valid admission
 .S VA200="" D INP^VADPT I VAIN(1)="" D  ;look for one day admission
 ..S IBX=+$O(^(+$O(^DGPM("ATID1",DFN,9999999-IBTDT)),0)),IBX=+$G(^DGPM(IBX,0))
 ..I $E(IBX,1,7)=IBTDT S VAINDT=IBX D INP^VADPT ;9999999.9999999
 ..I VAIN(1) W !!,"WARNING: This appears to be a one day stay."
 .I VAIN(1)="" D
 ..W !!,*7,"WARNING: Patient does not appear to be an inpatient on this date!",!
 ..I VAIN(7)="" S VAIN(7)=IBTDT,Y=IBTDT D D^DIQ S $P(VAIN(7),"^",2)=Y
 .;
 .S DIR("?")="No admission was found for this date, enter 'Yes' if you want to add this anyway, or 'No' if you do not wish to track this date."
 .S DIR(0)="Y",DIR("A")="Okay to Add Claims Tracking entry for Admission Date "_$P(VAIN(7),"^",2),DIR("B")="NO"
 .D ^DIR K DIR I $D(DIRUT)!('Y) S IBQUIT=1 Q
 .I VAIN(1) D ADM^IBTUTL(VAIN(1))
 .I 'VAIN(1) D OTH^IBTUTL(DFN,IBETYP,IBTDT)
 .Q
 ;
OPT I IBETYP=$O(^IBE(356.6,"AC",2,0)) D  I IBQUIT G ATQ
 .;
 .N DIR,IBSD,IBARRAY
 .;get all possible scheduling data for patient
 .K ^TMP($J,"SDAMA301")
 .S IBARRAY(4)=DFN,IBARRAY("SORT")="P",IBARRAY("FLDS")="1;2;3;10;12",IBSD=$$SDAPI^SDAMA301(.IBARRAY)
 .;
 .S DIR("?")="Time is Required."
 .S DIR("?",1)="    Enter the Outpatient Visit Date."
 .S DIR("?",2)="    If no scheduled visit is found you will be given a warning.  Enter"
 .S DIR("?",3)="    '??' to get a list of scheduled visits between "_$$DAT1^IBOUTL(IBTBDT)_" and "_$$DAT1^IBOUTL(IBTEDT)_"."
 .I '$D(IBTASS) S DIR("?",4)="    Use the change date range action to change listing of scheduled Visits."
 .S DIR("??")="^D LISTO^IBTRE20"
 .S DIR(0)="DO^::AEXTP",DIR("A")="Outpatient Visit Date"
 .D ^DIR K DIR S IBTDT=Y
 .I $D(DIRUT)!($P(IBTDT,".")'?7N) S IBQUIT=1 Q
 .;
 .; check scheduling and encounters file for entries
 .S X=$D(^TMP($J,"SDAMA301",DFN,IBTDT))
 .;
 .I 'X,IBSD<0 W !!,*7,"WARNING: Unable to look up Visit information for this Patient" X "N IBX S IBX=0 F  S IBX=$O(^TMP($J,""SDAMA301"",IBX)) W !?5,IBX,?10,$G(^(IBX))"
 .;
 .I 'X,IBSD S Y=$O(^TMP($J,"SDAMA301",DFN,$P(IBTDT,"."))) I $P(IBTDT,".")=$P(Y,".") S IBTDT=Y,X=1
 .;
 .; if non say so
 .I 'X,IBSD'=-1 W !!,*7,"WARNING: No Visit information for this Patient for this date.",!
 .;
 .; ask if okay to add entry.
 .S Y=IBTDT D D^DIQ S IBTDTE=Y
 .S DIR(0)="Y",DIR("A")="Okay to Add Claims Tracking entry for Visit Date "_IBTDTE,DIR("B")="NO"
 .D ^DIR K DIR I $D(DIRUT)!('Y) S IBQUIT=1 Q
 .D OPT^IBTUTL1(DFN,IBETYP,IBTDT,$P($G(^TMP($J,"SDAMA301",DFN,IBTDT)),"^",12))
 .K ^TMP($J,"SDAMA301")
 .Q
 ;
SCH I IBETYP=$O(^IBE(356.6,"AC",5,0)) D  I IBQUIT G ATQ
 .N DIR
 .S DIR("?")="   "
 .S DIR("?",1)="    Enter date of the scheduled admission."
 .S DIR("?",2)="    If you use the scheduled admission package to schedule admissions"
 .S DIR("?",3)="    you may enter '??' to get a list of scheduled admissions between"
 .S DIR("?",4)="    "_$$DAT1^IBOUTL(IBTBDT)_" and "_$$DAT1^IBOUTL(IBTEDT)_".  Use the change date range action"
 .S DIR("?",5)="    to change listing of scheduled admissions."
 .S DIR("?",5)="    This should be a future scheduled admission."
 .S DIR(0)="DO^::AEXT",DIR("A")="Scheduled Admission Date"
 .S DIR("??")="^D LISTS^IBTRE20"
 .D ^DIR K DIR S IBTDT=+Y
 .I $D(DIRUT)!($P(IBTDT,".")'?7N) S IBQUIT=1 Q
 .; ask if okay to add entry.
 .D FINDS^IBTRE20
 .S Y=IBTDT D D^DIQ S IBTDTE=Y
 .S DIR(0)="Y",DIR("A")="Okay to Add Claims Tracking entry for Scheduled Adm. Date "_IBTDTE,DIR("B")="NO"
 .D ^DIR K DIR I $D(DIRUT)!('Y) S IBQUIT=1 Q
 .I IBTDT\1'>DT S VAINDT=IBTDT\1+.24 D INP^VADPT I $G(VAIN(1)) D  Q
 ..W !!,"Patient an inpatient on this date, using inpatient admission."
 ..D ADM^IBTUTL(VAIN(1))
 .D SCH^IBTUTL2(DFN,IBTDT)
 .Q
 I $G(IBQUIT) G ATQ
 I $D(IBTASS) Q  ; leave prematurely if from assign reason
 ;
 I $G(IBTRN) N IBTATRK S IBTATRK=1 D QE1^IBTRE1
 ;
 D BLD^IBTRE
ATQ Q:$D(IBTASS)
 I $G(IBQUIT) W !,"Nothing Added",! D PAUSE^VALM1
 S VALMBCK="R"
 Q
