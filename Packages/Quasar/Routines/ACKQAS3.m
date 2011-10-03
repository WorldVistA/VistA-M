ACKQAS3 ;AUG/JLTP BIR/PTD-Enter Cost Information for Procedures ; [ 02/14/96   3:30 PM ]
 ;;3.0;QUASAR;**8**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
ACCESS ;Only A&SP staff designated as supervisors can access this option.
 N ACKDUZ
 S ACKDUZ=$$PROVCHK^ACKQASU4(DUZ) S:ACKDUZ="" ACKDUZ=" "
 W @IOF I $O(^ACK(509850.3,ACKDUZ,""))="" W !,"You are not listed in the A&SP STAFF file (#509850.3).",!,"Access denied." G EXIT
 S X=$$STACT^ACKQUTL(ACKDUZ) I ((X=-2)!(X=-6)) W !,"Only clinicians may access this option!" G EXIT
 I X W !,"The A&SP STAFF file (#509850.3) indicates that you have been inactivated.",!,"Access denied." G EXIT
 I $P(^ACK(509850.3,ACKDUZ,0),"^",6)'=1 W !,"You must be listed as a SUPERVISOR in the A&SP STAFF file (#509850.3)",!,"in order to use this option.  Access denied." G EXIT
OPTN ;Introduce option.
 W @IOF,!,"This option allows you to enter cost data for each procedure code",!,"in the A&SP PROCEDURE CODE file (#509850.4).  The information is",!,"used to generate the Cost Comparison Report.",!
 I '$O(^ICPT(0)) W !,"The CPT file (#81) is required." G EXIT
CHOOSE ;Display user choices: edit selected entries or all entries.
 K DIR,X,Y S DIR(0)="NAO^1:2",DIR("A",1)="Select the action you wish to take.",DIR("A",2)="",DIR("A",3)="1. Edit a selected CPT-4 code.",DIR("A",4)="2. Edit all procedure codes.",DIR("A",5)=""
 S DIR("A")="Enter a number, 1 or 2: ",DIR("?")="Answer 1 to choose a code; answer 2 to loop through all procedures"
 S DIR("??")="^D CHOOSE^ACKQHLP1" D ^DIR K DIR G:$D(DIRUT) EXIT
 S ACKANS=+Y I ACKANS=1 K ACKANS,DIR,X,Y G SINGLE
LOOP ;Edit the cost of all CPT-4 procedure codes.
 S ACK=0 F  S ACK=$O(^ACK(509850.4,ACK)) Q:'ACK!($D(DIRUT))  S ACK0=^(ACK,0) D COST
EXIT ;Kill variables and exit routine.
 K %,%W,%Y,ACKANS,ACK,ACK0,ACK1,ACK(1),ACKM,C,DA,DIC,DIE,DIR,DR,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;
SINGLE ;Edit the cost of a selected CPT-4 code.
 S DIC="^ACK(509850.4,",DIC(0)="QEAMZ",DIC("A")="Enter Procedure Code: " W ! D ^DIC K DIC G:Y<0 EXIT
 S ACK=+Y,ACK0=Y(0)
 D COST,EXIT
 G SINGLE
 ;
COST ;Enter cost data for a single CPT-4 procedure code.
 ;ACK (IEN) and ACK0 (zero node) are defined upon entry.
 S DIR(0)="NAO^0:9999:2",DIR("A")="Enter Cost: $ ",DIR("?")="Enter the approximate PRIVATE SECTOR cost for this procedure"
 S DIR("??")="^W !?5,""Do not enter the $ sign.  Enter numeric values between 0 and 9999."""
 S:$P(ACK0,U,6) DIR("B")=$P(ACK0,U,6)
 I '$D(^ICPT(ACK,0)) W !!,"File 81, CPT, needs to be updated.  Code "_ACK_" is missing." Q
 W !!,$P(^ICPT(ACK,0),U),"  ",$$PROCTXT^ACKQUTL8(ACK,"")
 W:'$P(ACK0,U,4) "   *** INACTIVE ***",$C(7)
 D ^DIR K DIR("B") K:Y=""&('$D(DTOUT)) DIRUT
 I '$D(DIRUT),Y]"" S DIE="^ACK(509850.4,",DA=ACK,DR=".06////"_+Y D ^DIE K DIE
MOD ;Edit cost of modifier codes.
 S ACKM="" F  S ACKM=$O(^ACK(509850.4,ACK,1,"B",ACKM)) Q:ACKM=""!($D(DIRUT))  S ACK(1)=0 F  S ACK(1)=$O(^(ACKM,ACK(1))) Q:'ACK(1)!($D(DIRUT))  S ACK1=^ACK(509850.4,ACK,1,ACK(1),0) D
 .W !?5,ACKM,".  ",$P(ACK1,U,2)
 .S:$P(ACK1,U,3) DIR("B")=$P(ACK1,U,3) D ^DIR K DIR("B") K:'$D(DTOUT)&('$D(DUOUT)) DIRUT Q:$D(DIRUT)
 .S DIE="^ACK(509850.4,ACK,1,",DA(1)=ACK,DA=ACK(1),DR=".03////"_+Y
 .D ^DIE K DA,DIE,DR
