PSADJ ;BIR/LTL,JMB-Balance Adjustments ;8/21/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,12,64**; 10/24/97;Build 4
 ;This routine allows the user to review the drug history then enter
 ;adjustments.
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;
 S DIR(0)="Y",DIR("A")="Review drug adjustment history",DIR("B")="No",DIR("?",1)="Enter yes to display all adjustments within a selected date range.",DIR("?")="Enter no to enter the adjustment."
 S DIR("??")="^D ADJ^PSADJ" D ^DIR K DIR G:$D(DIRUT) EXIT D:Y=1 ^PSADJR G:$G(DTOUT)!($G(DUOUT)) EXIT
 D SIG^XUSESIG G:X1="" EXIT
LOC ;Gets locations to have adjustments
 S (PSACNT,PSAOUT)=0 D ^PSAUTL3 G:PSAOUT EXIT
 S PSACNT=0,PSACHK=$O(PSALOC(""))
 I PSACHK="",'PSALOC W !,"There are no active pharmacy locations." G EXIT
 S PSALOCN="" F  S PSALOCN=$O(PSALOC(PSALOCN)) Q:PSALOCN=""  S PSALOC=0 F  S PSALOC=+$O(PSALOC(PSALOCN,PSALOC)) Q:'PSALOC  D  Q:PSAOUT
 .D SITES^PSAUTL1,DRUG
 .I PSAOUT S PSAX=$O(PSALOC(PSALOCN)) I PSAX'="" S PSAOUT=0
 .K PSAX
 ;
EXIT ;Kills all variables
 K %,%DT,%ZIS,D0,D1,DA,DD,DIC,DIE,DINUM,DIR,DIRUT,DO,DR,DTOUT,DUOUT,PSA,PSACHK,PSACNT,PSACOMB,PSADJDT,PSADRUG,PSADRUGN,PSADT,PSAIEN,PSAISIT,PSAISITN
 K PSALOC,PSALOCA,PSALOCN,PSAOUT,PSAQ,PSAR,PSAREC,PSASEL,PSAT,X,X1,X2,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
 ;
DRUG ;Selects location's drug and processes adjustment
 F  S DIC="^PSD(58.8,PSALOC,1,",DIC(0)="AEMQZ",DIC("A")="Select drug to adjust: " D  Q:PSAOUT
 .S DIC("S")="I $S($P($G(^(0)),""^"",14):$P($G(^(0)),""^"",14)>DT,1:1)",DA(1)=PSALOC
 .W !!,PSALOCN D ^DIC K DIC I (Y<0&(X="")!(X="^"))!($G(DTOUT))!($G(DUOUT)) S PSAOUT=1 Q
 .Q:Y<0&(X'="")
 .S PSADRUG=+Y,PSADRUGN=$P($G(^PSDRUG(PSADRUG,0)),"^")
 .S PSAQ=$P($G(^PSD(58.8,PSALOC,1,PSADRUG,0)),"^",4)
 .W !!,"Current Balance: ",$G(PSAQ),!
 .S DIR(0)="NO^-999999:999999:2" S DIR("A")="Adjustment quantity"
 .S DIR("?",1)="Enter the amount of the adjustment. If it is a negative",DIR("?")="number, enter a minus sign '-' before the number.",DIR("??")="^D QTY^PSADJ"
 .D ^DIR K DIR Q:Y=0!(Y="")!($G(DUOUT))  I $G(DTOUT) S PSAOUT=1 Q
 .S PSAREC=Y
 .S DIR(0)="F^1:45",DIR("A")="Adjustment reason",DIR("?")="Enter the reason why the adjustment was made",DIR("??")="^D REASON^PSADJ" D ^DIR K DIR
 .Q:$G(DUOUT)!(Y=" ")  I $G(DTOUT) S PSAOUT=1 Q
 .S PSAR=Y,Y=DT D DD^%DT S PSADJDT=Y
 .S DIR(0)="D^:"_DT_":EX",DIR("A")="Adjustment date",DIR("B")=PSADJDT,DIR("?")="Enter the date that the adjustment applies",DIR("??")="^D ADJDATE^PSADJ"
 .D ^DIR K DIR Q:$G(DUOUT)  I $G(DTOUT) S PSAOUT=1 Q
 .S PSADJDT=Y
POST .;Post adjustment if yes.
 .S DIR(0)="Y",DIR("A")="OK to post",DIR("B")="Yes",DIR("?",1)="Enter yes to add or subtract the adjustment quantity from the current",DIR("?")="balance and record this transaction. Enter no to cancel this transaction."
 .S DIR("??")="^D OK^PSADJ" D ^DIR K DIR
 .I 'Y!($G(DIRUT)) S:$G(DTOUT) PSAOUT=1 W ! Q
 .D:Y=1  K PSADRUG Q
 ..W !,"There were ",$S($P($G(^PSD(58.8,PSALOC,1,PSADRUG,0)),"^",4):$P($G(^(0)),"^",4),1:0)," on hand.  There are now ",$P($G(^(0)),"^",4)+$G(PSAREC)," on hand."
 ..W !,"Updating files. Please wait."
 ..F  L +^PSD(58.8,PSALOC,1,PSADRUG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 ..D NOW^%DTC S PSADT=+$E(%,1,12)
 ..S PSAQ=$S($P($G(^PSD(58.8,PSALOC,1,PSADRUG,0)),"^",4):$P($G(^(0)),"^",4),1:0)
 ..S $P(^PSD(58.8,PSALOC,1,PSADRUG,0),"^",4)=PSAREC+PSAQ
 ..L -^PSD(58.8,PSALOC,1,PSADRUG,0) W "."
MON ..S:'$D(^PSD(58.8,PSALOC,1,PSADRUG,5,0)) ^(0)="^58.801A^^"
 ..I '$D(^PSD(58.8,PSALOC,1,PSADRUG,5,$E(PSADJDT,1,5)*100,0)) D
 ...K DD,DO S DIC="^PSD(58.8,"_PSALOC_",1,"_PSADRUG_",5,",DIC(0)="L",DIC("DR")="1////^S X=PSAQ",(X,DINUM)=$E(PSADJDT,1,5)*100
 ...S DA(2)=PSALOC,DA(1)=PSADRUG,DLAYGO=58.8 D ^DIC K DIC,DLAYGO,DD,DO
 ...;S X="T-1M" D ^%DT S DIC="^PSD(58.8,"_PSALOC_",1,"_PSADRUG_",5,",DIC(0)="L",(X,DINUM)=$E(Y,1,5)*100,DA(2)=PSALOC,DA(1)=PSADRUG,DLAYGO=58.8 D ^DIC K DIC,DLAYGO S DA=+Y
 ...;S DIE="^PSD(58.8,"_PSALOC_",1,"_PSADRUG_",5,",DA(2)=PSALOC,DA(1)=PSADRUG,DR="3////^S X=PSAQ" D ^DIE K DIE
 ..;DAVE B (PSA*3*12)
 ..D PSA12
 ..S DIE="^PSD(58.8,"_PSALOC_",1,"_PSADRUG_",5,",DA(2)=PSALOC,DA(1)=PSADRUG,DA=$E(PSADJDT,1,5)*100
 ..S DR="7////^S X="_($P($G(^PSD(58.8,PSALOC,1,PSADRUG,5,DA,0)),"^",5)+PSAREC)_";3////^S X="_($P($G(^(0)),"^",4)+PSAREC)
 ..D ^DIE W "."
TR ..F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND ..S PSAT=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSAT,0)) S $P(^(0),"^",3)=$P(^(0),"^",3)+1 G FIND
 ..L -^PSD(58.81,0) K DD,DIC,DO W "."
 ..S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,X=PSAT D ^DIC K DIC,DLAYGO W "."
 ..S DR="1////9;2////^S X=PSALOC;3////^S X="_$S(PSADJDT=$E(PSADT,1,7):PSADT,1:PSADJDT)_";4////^S X=PSADRUG;5////^S X=PSAREC;6////^S X=DUZ;9////^S X=PSAQ;15////^S X=PSAR"_$S(PSADJDT'=$E(PSADT,1,7):";22////^S X="_PSADT,1:"")
 ..S DIE="^PSD(58.81,",DA=PSAT D ^DIE K DIE,DD,DO W "."
 ..S:'$D(^PSD(58.8,PSALOC,1,PSADRUG,4,0)) ^(0)="^58.800119PA^^"
 ..S DIC="^PSD(58.8,PSALOC,1,PSADRUG,4,",DIC(0)="L",(X,DINUM)=PSAT
 ..S DA(2)=PSALOC,DA(1)=PSADRUG,DLAYGO=58.8 D ^DIC K DIC,DLAYGO,DA,PSADRUG W ".",!
 Q
 ;
ADJ ;Extended help for "Review drug adjustment history" at PSADJ+2
 W !,"Enter yes to print all adjustments for this drug on the screen",!,"or printer. You can enter an adjustment after the report prints."
 W !!,"Enter no to bypass the report and make an adjustment."
 Q
ADJDATE ;Extended help for "Adjustment date"
 W !,"If the adjustment pertains today, press the Return key.",!!,"If the adjustment is for a previous date, enter that date."
 W !,"Today's date will be recorded as the date the adjustment was made."
 Q
OK    ;Extended help for "OK to post?"
 W !,"Enter yes to record this adjustment. The adjustment quantity will be subtracted",!,"from or added to the drug's current balance. The transaction will be recorded"
 W !,"in the activity log and the monthly balance will be adjusted.",!!,"Enter no to abort the adjustment process and return to the menu."
 Q
QTY ;Extended help for "Adjustment quantity"
 W !,"Enter the quantity to be added or subtracted from the current balance.",!,"If the quantity should be subtracted from the balance, enter a minus"
 W !,"sign '-' before the quantity.",!!,"For example: -10 or -150 will be subtracted from the balance.",!?14,"10 or 150 will be added to the balance."
 Q
REASON ;Extended help for "Adjustment reason"
 W !,"Enter the reason you are changing the current balance."
 Q
 ;
PSA12 ;Patch PSA*3*12
 I $E(PSADJDT,1,5)=$E(DT,1,5) Q
 ;This section was added to CORRECTLY make adjustments to
 ;the monthly activity balances when an adjustment was made.
 S X="T" D ^%DT S PSAENDDT=$E(Y,1,5)
 S PSADJDT1=$E(PSADJDT,1,5)
BGN S PSADJDT1=PSADJDT1+1
 S PSADAV=$E(PSADJDT1,4,5) I PSADAV=13 S PSADAV1=$E(PSADJDT1,1,3)+1,PSADAV2="01",PSADJDT1=PSADAV1_PSADAV2
 I PSADJDT1=PSAENDDT G DONE
 W !,"Updating " S Y=PSADJDT1 X ^DD("DD") W Y
 I '$D(^PSD(58.8,PSALOC,1,PSADRUG,5,(PSADJDT1*100),0)) S DIC="^PSD(58.8,"_PSALOC_",1,"_PSADRUG_",5,",DIC(0)="L",(X,DINUM)=$E(PSADJDT1,1,5)*100,DA(2)=PSALOC,DA(1)=PSADRUG,DLAYGO=58.8 D ^DIC S DA=+Y
 S DA=$S($G(DA)="":(PSADJDT1*100),1:DA)
 S DIE="^PSD(58.8,"_PSALOC_",1,"_PSADRUG_",5,",DA(2)=PSALOC,DA(1)=PSADRUG
 S DR="1////^S X="_($P($G(^PSD(58.8,PSALOC,1,PSADRUG,5,DA,0)),"^",2)+PSAREC)_";3////^S X="_($P($G(^(0)),"^",4)+PSAREC)
 D ^DIE
 K DA G BGN
DONE S $P(^PSD(58.8,PSALOC,1,PSADRUG,5,($E(PSADT,1,5)*100),0),"^",2)=$P($G(^PSD(58.8,PSALOC,1,PSADRUG,5,($E(PSADT,1,5)*100),0)),"^",2)+PSAREC
 S ^PSD(58.8,PSALOC,1,PSADRUG,5,"B",($E(PSADT,1,5)*100),($E(PSADT,1,5)*100))=""
 W !,"DONE" Q
