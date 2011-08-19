SROAOPS ;BIR/MAM - OTHER PROCEDURES ; 17 MAR 1992  1:30 pm [ 12/15/98  12:51 PM ]
 ;;3.0; Surgery ;**88**;24 Jun 93
OTHER ; other procedures
 I '$D(^SRF(SRTN,13,0)) S ^SRF(SRTN,13,0)="^130.16A^0^0"
 K SRAOTH F I=1:1:5 S SRAOTH(I)=""
 S (OPS,CNT)=0 F  S OPS=$O(^SRF(SRTN,13,OPS)) Q:'OPS  D SETOP
 D HDR
 W !,"1. Other Procedure (1):" I $D(SRAOTH(1)) W ?25,$P(SRAOTH(1),"^")
 W !,"   CPT Code:" I $D(SRAOTH("1A")) W ?25,$P(SRAOTH("1A"),"^")
 W !!,"2. Other Procedure (2):" I $D(SRAOTH(2)) W ?25,$P(SRAOTH(2),"^")
 W !,"   CPT Code:" I $D(SRAOTH("2A")) W ?25,$P(SRAOTH("2A"),"^")
 W !!,"3. Other Procedure (3):" I $D(SRAOTH(3)) W ?25,$P(SRAOTH(3),"^")
 W !,"   CPT Code:" I $D(SRAOTH("3A")) W ?25,$P(SRAOTH("3A"),"^")
 W !!,"4. Other Procedure (4):" I $D(SRAOTH(4)) W ?25,$P(SRAOTH(4),"^")
 W !,"   CPT Code:" I $D(SRAOTH("4A")) W ?25,$P(SRAOTH("4A"),"^")
 W !!,"5. Other Procedure (5):" I $D(SRAOTH(5)) W ?25,$P(SRAOTH(5),"^")
 W !,"   CPT Code:" I $D(SRAOTH("5A")) W ?25,$P(SRAOTH("5A"),"^")
 W ! F MOE=1:1:80 W "-"
ASK W !!,"Select Other Operative Procedure Information: " R X:DTIME I '$T!("^"[X) Q
 I X'="A",'$D(SRAOTH(X)) D HELP G:SRSOUT END G OTHER
 S:X="A" X="1:5" I X?.N1":".N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>5)!(Y>Z) D HELP G:SRSOUT END G OTHER
 D HDR I X?.N1":".N D RANGE,HDR G OTHER
 S KAREN=X D ONE G OTHER
 Q
END K SRAOTH,CNT
 Q
HELP W @IOF,!!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (1-5) to update one specific procedure.  For example, ",!,"   enter '1' to update Other Procedure (1)."
 W !!,"3. Enter a range of numbers, separated by a ':' to update more than one",!,"   procedure.  For example, enter '1:2' to enter Other Procedure (1) and",!,"   Other Procedure (2)."
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
SETOP ; set other operative info
 S OTHER=^SRF(SRTN,13,OPS,0),CNT=CNT+1,SRAOTH(CNT)=$P(OTHER,"^")_"^"_OPS,X=$P(OTHER,"^",2) S:X X=$P($$CPT^ICPTCOD(X),"^",2) S Y=CNT_"A",SRAOTH(Y)=X_"^"_OPS
 Q
RANGE ; range of numbers
 S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F KAREN=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one procedure
 W !! I SRAOTH(KAREN)'="" K DR,DIE S DA=$P(SRAOTH(KAREN),"^",2),DIE="^SRF("_SRTN_",11,",DA(1)=SRTN,DR=".01T;1T" D ^DIE K DR Q
 K DIR,DA S DIR(0)="130.16,.01",DIR("A")="Other Operative Procedure ("_KAREN_")" D ^DIR I Y="" Q
 K DA,DIC,DD,DO,DINUM S DA(1)=SRTN,X=Y,DIC="^SRF("_SRTN_",13,",DIC(0)="L" D FILE^DICN K DIC,DD,DO
 K DR,DIE S DA=+Y,DA(1)=SRTN,DR="1T",DIE="^SRF("_SRTN_",13," D ^DIE K DR
 Q
HDR W @IOF,!,SRANAME,! F MOE=1:1:80 W "-"
 Q
