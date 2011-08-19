SRSUP1 ;BIR/MAM - UPDATE SCHEDULED OPERATION ; [ 01/29/01  2:13 PM ]
 ;;3.0; Surgery ;**7,16,19,47,58,67,77,50,93,107,114,100,131**;24 Jun 93
 ;
 ; Reference to ^TMP("CSLSUR1" supported by DBIA #3498
 ;
 I $P($G(^SRF(SRTN,"CON")),"^") G CHANGE
CON W !!,"Do you want to add a concurrent case ?  NO// " R SRYN:DTIME I '$T!(SRYN["^") G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="N"
 I "YyNn"'[SRYN W !!,"Enter 'YES' if you need to add a case to be performed concurrently with this",!,"case.  Press RETURN to update other information related to this case." G CON
 I "Nn"'[SRYN G ^SRSCHCA
CHANGE S SRC=1,SRI=$P($G(^SRF(SRTN,8)),"^"),SRS=$O(^SRO(133,"B",SRI,0)),SRTIME=$P(^SRO(133,SRS,0),"^",12) S:SRTIME="" SRTIME=1500
 S X1=$E($P(^SRF(SRTN,0),"^",9),1,7),X2=-1,SRYN="N" G:X1<DT EDIT D C^%DTC S SRTIME=X_"."_SRTIME D NOW^%DTC I %>SRTIME S SRC=0
 K SRSCC S SRSUPDT=1 W !!,"Do you want to change the ",$S(SRC:"date/",1:""),"time or operating room for which this",!,"case is scheduled ? NO// " R SRYN:DTIME I '$T!(SRYN["^") G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="N"
 I "YyNn"'[SRYN W !!,"Enter 'YES' if you need to change the ",$S(SRC:"date, ",1:""),"time or operating room for this",!,"case.  Enter RETURN to update other information related to this case." G CHANGE
EDIT G:'$$LOCK^SROUTL(SRTN) END
 I "Yy"'[SRYN D RT K ST,DR,DIE,DA S SPD=$$CHKS^SRSCOR(SRTN),DR="[SRSRES-SCHED]",DIE=130,DA=SRTN D EN2^SROVAR K Q3("VIEW") D ^SRCUSS D SRDYN D:$D(SRODR) ^SROCON1 D RISK^SROAUTL3,^SROPCE1,OERR G END
 D ^SRSTCH I SRSOUT G END
 D ^SRORESV S SRTN("OR")=SRSOR,SRTN("START")=SRSDT1,SRTN("END")=SRSDT2,SRSEDT=$E(SRSDT2,1,7) D ^SRSCG
 S SRTN("SRT")=SRT,SRSTIME1=SRTN("START")_"^"_SRTN("END")_"^"_SRSDT1_"^"_SRSDT2
DATE W !! K NODATE S OLDATE=$E(SRTN("START"),1,7) I 'SRC S SRSDATE=OLDATE W !!,"Press RETURN to continue... " R X:DTIME G DIS
 S %DT="AEFX",%DT("A")="Reschedule this Procedure for which Date ?  " D ^%DT K %DT S SRSDATE=$S(Y>0:Y,1:OLDATE) I Y<0 S NODATE=1
 I '$D(NODATE) D CHECK I SRNOK G DATE
 I $D(NODATE) D NODATE I SRSOUT G SCHED
DIS D ^SRSDISP I SRSOUT G SCHED
 W ! K DIC S DIC="^SRS(",DIC(0)="QEAMZ",DIC("S")="I $$ORDIV^SROUTL0(+Y,$G(SRSITE(""DIV""))),('$P(^SRS(+Y,0),U,6))",DIC("A")="Schedule this case for which Operating Room: " D ^DIC K DIC I Y<0 S SRSOUT=1 G SCHED
 S SRSOR=+Y,X1=SRSDATE,X2=2830103 D ^%DTC S SRSDAY=$P("MO^TU^WE^TH^FR^SA^SU","^",X#7+1)
 D ^SRSTIME I SRSOUT G SCHED
 S SRNOREQ=1 K DIE,DR,DA S DR="36///1;Q;.09///"_$S(SRSDATE=OLDATE:OLDATE,1:SRSDATE),DA=SRTN,DIE=130 D ^DIE K DR,DA,DIE
SCHED S S(0)=^SRF(SRTN,0),SRSERV=$P(S(0),"^",4) S DA=SRTN,DIE=130,DR=".04////"_SRSERV D ^DIE K DR,DA,DIE
 I SRSOUT S SRSDATE=OLDATE,SRSOR=SRTN("OR"),SRSTIME=SRTN("SRT"),SRSDT1=$P(SRSTIME1,"^",3),SRSDT2=$P(SRSTIME1,"^",4),SRSET1=$P(SRSTIME,"^",2)
 K SRGRPH,SRSDT3 S COUNT=1,MM=$E(SRSDT2,1,7),XX=$E(SRSDT1,1,7) I MM>XX S SRSDT3=MM,$P(SRSTIME,"^",2)="24:00"
 K X0,X1 D EN2^SRSCHD2 I $D(SRSLAP) S SRSOUT=1 K SRSLAP G SCHED
 D:SRSDATE'=OLDATE ^SROXRET D OERR
 D UNLOCK^SROUTL(SRTN)
END ;
 W @IOF D ^SRSKILL K SRTN
 Q
NODATE ; new date not entered
 W !!,"Since no date has been entered, I must assume that you want to re-schedule",!,"this case for the same date.  If you have made a mistake and want to",!,"leave this case scheduled for the same operating room at the same times,"
 W !,"enter RETURN when prompted to select an operating room."
 R !!,"Press RETURN to continue  ",X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
DIE K ST,DR,DIE,DA S DR="[SRSRES-SCHED]",DIE=130,DA=SRTN D EN2^SROVAR K Q3("VIEW") D ^SRCUSS K DR D SRDYN
 Q
RT ; start RT logging
 I $D(XRTL) S XRTN="SRSUP1" D T0^%ZOSV
 Q
CHECK N SRHOL S SRHOL="",SRNOK=0,X=SRSDATE D H^%DTC S SRDAY=%Y+1 S SRDL=$P($G(^SRO(133,SRSITE,2)),"^",SRDAY) S:SRDL="" SRDL=1
 I 'SRDL W !!,"Scheduling not allowed for "_$S(SRDAY=1:"SUNDAY",SRDAY=2:"MONDAY",SRDAY=3:"TUESDAY",SRDAY=4:"WEDNESDAY",SRDAY=5:"THURSDAY",SRDAY=6:"FRIDAY",1:"SATURDAY")_" !!",! S SRNOK=1 Q
 K DIC S DIC=40.5,DIC(0)="XM",X=SRSDATE D ^DIC K DIC S SRHOL=$P(Y,"^") I SRHOL>0,'$D(^SRO(133,SRSITE,3,SRSDATE,0)) D  S SRNOK=1
 .S DIC=40.5,DR="2",DA=SRHOL,DIQ="SRY",DIQ(0)="E" D EN^DIQ1 K DA,DIC,DIQ,DR
 .W !!,"Scheduling not allowed for "_SRY(40.5,SRHOL,2,"E")_" !!",!
 Q
OERR ; update status in ORDER file (100)
 S SROERR=SRTN D ^SROERR0
 Q
SRDYN I SPD'=$$CHKS^SRSCOR(SRTN) S ^TMP("CSLSUR1",$J)=""
 Q
