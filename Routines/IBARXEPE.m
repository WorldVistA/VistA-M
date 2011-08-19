IBARXEPE ;ALB/AAS - EDIT EXEMPTION LETTER - 28-APR-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**34**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% I '$D(DT) D DT^DICRW
 ;
EDIT ; -- Edit form letter
 I '$D(IOF) D HOME^%ZIS
 W @IOF,"Edit Exemption Patient Notification Letter",!!!
 S IBQUIT=0
 S DIC(0)="AEQMNLZ",DIC="^IBE(354.6," D ^DIC K DIC G:+Y<1 EDQ S (IBLET,DA)=+Y,IBLET0=Y(0)
 ;
 S DR="" I $P($G(^IBE(354.6,DA,0)),"^",4)="" S DR=".04////15;"
 S DR=DR_"2;1;.04" I $P(IBLET0,"^",3)=2 S DR=DR_";.05;.07;.08"
 ;
 S DIE="^IBE(354.6," D ^DIE K DA,DIE,DR
 I $P(IBLET0,"^",3)=2 D SCHED
 ;
 W !!
TEST S DIR(0)="Y",DIR("A")="Test Print Letter",DIR("B")="YES" D ^DIR K DIR
 I Y'=1 G EDQ
 ;
 S DIC="^DPT(",DIC(0)="AEQM",DIC("S")=$S($P(IBLET0,"^",3)=2:"I $G(^IBA(354,+Y,0))",1:"I $P($G(^IBA(354,+Y,0)),U,4)")
 S DIC("A")="Select "_$S($P(IBLET0,"^",3)=2:"",1:"Exempt ")_"BILLING PATIENT: "
 W ! D ^DIC K DIC I +Y<1 G EDQ
 S DFN=+Y,IBDATA=$$PT^IBEFUNC(DFN),IBNAM=$P(IBDATA,"^")
 I $P(IBLET0,"^",3)=2 S IBEXPD="December 31, "_($E(DT,1,3)+1700)
 S %ZIS="QM" D ^%ZIS G:POP EDQ
 I $D(IO("Q")) K IO("Q") S ZTRTN="ED1^IBARXEPE",ZTSAVE("IB*")="",ZTSAVE("DFN")="",ZTDESC="Test Print Exemption Letter" D ^%ZTLOAD K ZTSK D HOME^%ZIS G EDQ
 U IO
 ; 
ED1 S IBALIN=$P($G(^IBE(354.6,IBLET,0)),"^",4)
 I IBALIN<10!(IBALIN>25) S IBALIN=15
 D ONE^IBARXEPL
 ;
EDQ D END^IBARXEPL
 K IBLET0,IBEXPD
 Q
 ;
 ;
SCHED ; Select days to generate the income test reminder letters.
 N DIR,DIRUT,DTOUT,DUOUT,DIROUT,IBD,IBDAY,IBI,IBQ
 S IBD=$P(IBLET0,"^",6),IBQ=0
 I IBD="" W !!,"The income test reminder letters are not currently scheduled to be printed."
 I IBD]"" D  I IBQ G SCHEDQ
 .W !!,"The income test reminder letters are scheduled to be printed on:",!
 .F IBI=1:1:$L(IBD) W !?8,$P("SUNDAY^MONDAY^TUESDAY^WEDNESDAY^THURSDAY^FRIDAY^SATURDAY","^",$E(IBD,IBI)+1)
 .S DIR(0)="Y",DIR("A")="Do you wish to stop this job from running"
 .S DIR("?")="Type 'YES' if you do not want this job to run any longer."
 .W ! D ^DIR I $D(DIRUT) S IBQ=1 Q
 .I Y S IBQ=1,$P(^IBE(354.6,IBLET,0),"^",6)="" W !,"The job has been unscheduled." Q
 ;
 S IBDAY=$$ASK I IBDAY]"" S $P(^IBE(354.6,IBLET,0),"^",6)=IBDAY
SCHEDQ Q
 ;
ASK() ; Ask what days to generate letters.
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,I,X,Y
 W !!?4,"Your printed letters may be picked up on the following mornings:"
 W !!?8,"0   SUNDAY"
 W !?8,"1   MONDAY"
 W !?8,"2   TUESDAY"
 W !?8,"3   WEDNESDAY"
 W !?8,"4   THURSDAY"
 W !?8,"5   FRIDAY"
 W !?8,"6   SATURDAY",!
 S DIR("A")="    Select, by number, those mornings to pick up letters"
 S DIR(0)="L^0:6" D ^DIR I Y'["," S Y="" G ASKQ
 F I=1:1:$L(Y,",") I $P(Y,",",I)]"" S X($P(Y,",",I))=""
 S (I,Y)="" F  S I=$O(X(I)) Q:I=""  S Y=Y_I
ASKQ Q Y
