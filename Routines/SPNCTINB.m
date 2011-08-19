SPNCTINB ;WDE/SD INPATIENT CREATE NEW CARE POINT ;6/27/02  05:15
 ;;2.0;Spinal Cord Dysfunction;**19,21**;01/02/1997
 ;
 ; 
IN ;called when there are no episodes on file and to 
 ;start a new care episode
 ;Q:SPNFEXIT=1
 ;Q:$D(SPNFDFN)=""
 ;S SPNFEXIT=0,SPNEXIT=0
 ;S SPNDFN=SPNFDFN
 ;S SPNCT=1  ;inpatient
 ;        ;^ was entered or they are finished with the group
 ;Q
ZAP ;was used in another version no longer need but left for future use
 ;Q
ADD ; *** Add a record to the OUTCOMES file (#154.1)
 ;I $D(SPNQUIT) I SPNQUIT=1 Q
 I $P($G(^TMP($J,0)),U,2)>1 I $P($G(^TMP($J,0)),U,3)="" S SPNSEL="^" S SPNEXIT=1 D  Q  ;episode is not closed.
 .W !!?10,"You need to add an Outcome to the current episode and select"
 .W !?10,"a Score Type of INPT FOLLOW-UP (END)."
 .R !?15,"Press Return to continue ",SPNZ:DTIME K SPNZ
 .Q
 K DIR,DIC,%
 I $P($G(^TMP($J,0)),U,2)=0 D
 .W !,*7,?10,"There are no INPATIENT episodes of care on file."
 .W !?10,"(An ASIA should be entered first if an episode is created.)"
 .W !?10,"Would you like to create an episode of care"
 I $G(SPNSEL)["C" D
 .W !?10,"Would you like to create a new episode of care"
 S %=1 D YN^DICN
 ;I %Y="^" D ZAP^SPNCTINA G KILL^SPNCTINA:$G(^TMP($J,1))="" G RESTART^SPNCTINA
 I %Y="^" I $D(^TMP($J,1)) D ZAP^SPNCTINA G RESTART^SPNCTINA
 I %Y="^" I $D(^TMP($J,1))=0 D ZAP^SPNCTINA G KILL^SPNCTINA
 I %=2 I $D(^TMP($J,1))=0 G KILL^SPNCTINA
 I %=2 I $D(^TMP($J,1)) D ZAP^SPNCTINA G RESTART^SPNCTINA
 ;I %=2  W !,"zdz" H 2 G ZAP^SPNCTINA:$G(^TMP($J,1))="" G RESTART^SPNCTINA
 I %Y["?" D  G RESTART^SPNCTINA
 .W !!?5,"Enter a Y to create a new INPATIENT episode."
 .W !?5,"Enter a N or just Return to return to the last episode"
 .R !!?10,"Press Return to continue",SPNASK:DTIME K SPNASK W !
 I %'=1 D ZAP^SPNCTINA G RESTART^SPNCTINA Q
 I %'=1 D ZAP S SPNEXIT=1 Q
 ;
 S SPNSCOR=1,SPNXMIT=0,SPNEXIT=0
 I $G(SPNFDFN)="" I +$G(SPNDFN) S SPNFDFN=SPNDFN
 I SPNFDFN="" D ZAP^SPNOGRDA Q
 D REPT^SPNFEDT0(SPNFDFN)
 I $D(SPNFTYPE)=0 G ZAP^SPNCTINA Q
 I SPNFTYPE="" G ZAP^SPNCTINA Q  ;no fim record type selected
 I SPNEXIT=1 D ADD Q
 I '+SPNSCOR D ADD Q
 K DIR S DIR("A")="Enter a New Record Date: "
 D DATES  ;Date range set up of dir(0) set above as saftey
 D ^DIR
 I '+Y K DIR,Y S SPNFEXIT=1 Q
 S SPNDATE=Y
 K DD,DIC,DINUM,DO
 S SPNFD0=-1
 S DIC="^SPNL(154.1,",DIC(0)="L"
 S DLAYGO=154.1,X=SPNFDFN
 D FILE^DICN W ! S SPNFD0=+Y
 K DA,DIE,DR
 K ^TMP($J)  ;CLEAN UP THE LAST TABLE OF CARE
 I $G(SPNSCOR)="" S SPNSCOR=""
 S DIE="^SPNL(154.1,",DA=SPNFD0
 S SPNCDT=SPNDATE
 I SPNCDT="" W !,"No care start date is on file for this patient !" D ZAP Q
 S DR=".02///^S X="_SPNFTYPE_";.04///"_SPNDATE_";.021///"_SPNSCOR_";.023///"_$$EN^SPNMAIN(DUZ)_";1001///"_SPNCDT_";1003////1"
 D ^DIE
 S SPNNEW="YES"
 D EDIT^SPNFEDT0
 D ZAP^SPNCTINA
 S SPNFDFN=SPNDFN
 G RESTART^SPNCTINA
 Q
DATES ;set up upper and lower boundaries for the new record
 ;     If there is a care stop date that will be the upper
 ;     If there is a care start date that will be the lower
 ;     The new episode start date must be greater then any
 ;     other episodes on file 
 ;           
 ;    
 S (SPNX,SPNY)="",DIR(0)=""
 S SPNX=$P($G(^TMP($J,0)),U,2)
 S SPNY=$P($G(^TMP($J,0)),U,3)
 I SPNY'=""  S DIR(0)="DAO^"_SPNY_":"_DT_":EX" Q
 ;spny = close date
 I SPNX=0 I SPNY="" S DIR(0)="DAO^:NOW" Q
