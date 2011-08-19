SRSCHC ;B'HAM ISC/MAM - SCHEDULE CONCURRENT CASES ; [ 09/22/98  11:50 AM ]
 ;;3.0; Surgery ;**67,50**;24 Jun 93
 W @IOF,! S (SRNOREQ,SRSCHD,SRSC1)=1,ST="SCHEDULING" D ^SRSDISP
 W ! K DIC S DIC="^SRS(",DIC(0)="QEAMZ",DIC("S")="I $$ORDIV^SROUTL0(+Y,$G(SRSITE(""DIV""))),('$P(^SRS(+Y,0),U,6))",DIC("A")="Schedule "_$S($D(SRSCON(2)):"these cases",1:"this case")_" for which Operating Room ?  " D ^DIC
 I Y<0 W !,"A case cannot be scheduled without selecting an operating room.",!!,"Press RETURN to continue  " R X:DTIME S SRSOUT=1 Q
 S SRSOR=+Y,X1=SRSDATE,X2=2830103 D ^%DTC S SRSDAY=$P("MO^TU^WE^TH^FR^SA^SU","^",X#7+1)
 S (SRSOUT,SRSST,SRSET)=0,P="",Z="^" D ^SRSTIME I SRSOUT Q
 K SRGRPH,SRSDT3 S COUNT=1,MM=$E(SRSDT2,1,7),XX=$E(SRSDT1,1,7) I MM>XX S SRSDT3=MM,$P(SRSTIME,"^",2)="24:00"
GRPH I '$D(SRSTIME) Q
 S SRSST=$P(SRSTIME,"^"),SRSET=$P(SRSTIME,"^",2),SRSST=$P(SRSST,":")_"."_$P(SRSST,":",2),SRSET=$P(SRSET,":")_"."_$P(SRSET,":",2)
 S SRS1=11+($P(SRSST,".")*5)+(SRSST-$P(SRSST,".")*100\15),SRS2=11+($P(SRSET,".")*5)+(SRSET-$P(SRSET,".")*100\15),S="="
 F I=SRS1+1:1:SRS2-1 S S=S_$S('(I#5):"|",1:"X")
PATRN ; set up pattern
 I $E(^SRS(SRSOR,"S",SRSDATE,1),SRS1+1,SRS2)["X"!($E(^SRS(SRSOR,"S",SRSDATE,1),SRS1+1,SRS2)["=") D LAP H 1 S SRNOGO=1 Q
 S SRGRPH(COUNT)=SRSDATE_"^"_SRS1_"^"_SRS2_"^"_S,COUNT=COUNT+1
 I $D(SRSDT3) S SRSTIME="00:00^"_SRSET1,SRSDATE=SRSDT3 K SRSDT3 G GRPH
 F COUNT=1,2 I $D(SRGRPH(COUNT)) S SRSDATE=$P(SRGRPH(COUNT),"^"),SRS1=$P(SRGRPH(COUNT),"^",2),SRS2=$P(SRGRPH(COUNT),"^",3),S=$P(SRGRPH(COUNT),"^",4) D ^SRSGRPH
 S SRSDATE=$E(SRSDT1,1,7)
 S CON=0 F I=0:0 S CON=$O(SRSCON(CON)) Q:'CON  D SCH
 Q
SCH ; stuff scheduling info
 S SRTN=SRSCON(CON) K DR,DA S DIE=130,DA=SRTN,DR=".02////"_SRSOR_";Q;10////"_SRSDT1_";11////"_SRSDT2_";36////0;Q;.09///"_SRSDATE D ^DIE K DR
 S SRSOP=SRSCON(CON,"OP")
 S SROERR=SRTN D ^SROERR0
 Q
LAP W !!,"Overlapping reservations on "_$E(SRSDATE,4,5)_"/"_$E(SRSDATE,6,7)_"/"_$E(SRSDATE,2,3)_".  This case cannot be scheduled."
 W !!,"Press RETURN to continue  " R X:DTIME
 Q
