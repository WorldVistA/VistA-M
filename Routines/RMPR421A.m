RMPR421A ;PHX/HNB -CONT. CREATE PURCHASE CARD TRANSACTION ;3/1/1996
 ;;3.0;PROSTHETICS;**3,20,22,41,50**;Feb 09, 1996
 ;Per VHA Directive 10-93-142, this routine should not be modified.
P24 ;DATE REQUIRED
 ;die array set in rmpr421
 ;
 K %DT
 S DR="20//T+30" D ^DIE I $D(DTOUT)!($D(Y)'=0) G KILL^RMPR421
 ;
COT ;CONTRACT AUTHORITY
 I '$D(^RMPR(664,RMPRA,3)) S ^(3)=""
 S DR="4"
COT1 D ^DIE I $D(DTOUT)!($D(Y)'=0) G KILL^RMPR421
 S RMPRV=$P($G(^RMPR(664,RMPRA,0)),U,4)
 I $D(^PRC(440,RMPRV,4)) D VCON
 I $G(RMPRV)="" W !!,"Can Not Continue without a Vendor!" G KILL^RMPR421
IFCAP ;call PRCH7B here
 ;pass station number external 3 dig number,  and vendor ien to 440
 ;return PRCA as ien to 442^po number (no station) ^16 dig number
 S PRCA=$P(^RMPR(669.9,RMPRSITE,4),U,1)_U_RMPRV
 D ADD^PRCH7B(.PRCA)
 I PRCA="^" K PRCA S RMPRK=RMPRA G KILL^RMPR421
 ;scramble and set 16 dig purchase card number
 S $P(^RMPR(664,RMPRA,4),U,1)=$$ENC^RMPR4LI($P(PRCA,U,3),DUZ,RMPRA)
 ;set the transaction number the same as ifcap
 S $P(^RMPR(664,RMPRA,4),U,5)=$P(PRCA,U,2)
 ;set the pointer to file 442
 S $P(^RMPR(664,RMPRA,4),U,6)=$P(PRCA,U,1)
 K PRCA
 ;
L2 ;edit
 W !,"------------------------------",!
TRAN K DIR S DIR(0)="SMAO^I:INITIAL ISSUE;R:REPLACE;S:SPARE;X:REPAIR"
 S DIR("A")="TYPE OF TRANSACTION: " D ^DIR
 ;I $D(DUOUT)!$D(DTOUT) G:$G(RMCLOF)!($G(REDIT)) CHK
 I $D(DUOUT)!$D(DTOUT) G CHK
 I (Y="")&($D(^RMPR(664,RMPRA,1))) G CHK
 I (Y="")&('$D(^RMPR(664,RMPRA,1))) W !,"Please enter type of Transaction!!" G TRAN
 S RMTYPE=Y
PCAT K DIR S DIR(0)="SMAO^1:SC/OP;2:SC/IP;3:NSC/IP;4:NSC/OP"
 S DIR("A")="PATIENT CATEGORY: " D ^DIR
 I $D(DUOUT)!$D(DTOUT) G CHK
 I (Y="")&($D(^RMPR(664,RMPRA,1))) G CHK
 I (Y="")&('$D(^RMPR(664,RMPRA,1))) W !,"Please enter Patient Category!!" G PCAT
 S RMCAT=Y K DIR G:RMCAT<4 ITEM
SPES S DIR(0)="SMAO^1:SPECIAL LEGISLATION;2:A&A;3:PHC;4:ELIGIBILITY REFORM"
 S DIR("A")="SPECIAL CATEGORY: "
 I RMCAT=4 D ^DIR I $D(DUOUT)!$D(DTOUT) G CHK
 I RMCAT=4 S RMSPE=Y
 K DIR
ITEM ;
 K DIR S DIR(0)="FO",DIR("A")="Select ITEM"
 S DIR("?")="^S RFL=1 D ZDSP^RMPR421A"
 D ^DIR G:$D(DTOUT) KILL^RMPR421 G:$D(DUOUT) CHK
 G:$D(DIRUT)&($D(^RMPR(664,RMPRA,1))) CHK
 S DIC=661,DIC(0)="EQMZ" D ^DIC G:+Y'>0 ITEM
 D EDT^RMPR4UTL G:$D(DTOUT) KILL^RMPR421 G L2
CHK K RFL S FL=1
 I '$D(^RMPR(664,RMPRA,1)) W !!,?5,$C(7),"REQUIRED FIELDS DO NOT EXIST ON THIS FORM",! G KILL^RMPR421
 I $D(^RMPR(664,RMPRA,1)) S FL=0 F RI=0:0 S RI=$O(^RMPR(664,RMPRA,1,RI)) Q:RI'>0  I $D(^(RI,0)) S FL=1 I $P(^(0),U,3)=""!($P(^(0),U,4)="")!($P(^(0),U,5)="")!($P(^(0),U,9)="")!($P(^(0),U,10)="") S FL=0 Q
 I 'FL W !!,?5,$C(7),"REQUIRED FIELDS DO NOT EXIST ON THIS FORM",! G KILL^RMPR421
 S $P(^RMPR(664,RMPRA,0),U,9)=DUZ
 I $D(DUOUT)&('$D(^RMPR(664,RMPRA,1))) W !,$C(7),$C(7),"Please Try Later!" G KILL^RMPR421
 S DA=RMPRA,DIE=664,DR="11;17;26" D ^DIE
ASK ;deliver to
 K DIR
 S DIR(0)="SAO^1:VETERAN;2:VAMC WAREHOUSE;3:PROSTHETICS;4:OTHER;"
 S DIR("A")="DELIVER TO: "
 D ^DIR K DIR G:$D(DTOUT) KILL^RMPR421
 I $D(DIRUT)!(X="") W $C(7),"Delivery is required.  Enter '?' for additional help." G ASK
 ;deliver to other
 S:Y'=4 RMPRDELN=Y(0),$P(^RMPR(664,RMPRA,3),U)=RMPRDELN
 I Y=4 D  G:$D(DTOUT) KILL^RMPR421 S RMPRDELN=$P(^RMPR(664,RMPRA,3),U)
 .S DIE="^RMPR(664,",DA=RMPRA,DR="19T" D ^DIE
 .Q
ASK5 S %=2 W !!,"Are you ready to POST to 10-2319 NOW"
 S RMPRDFN=$P(^RMPR(664,RMPRA,0),U,2)
 D YN^DICN G:%=1 FILE^RMPR421B G:$D(DTOUT) KILL^RMPR421
 I %=0 W !,"This will Create an Entry on the Prosthetic 10-2319 Record" G ASK5
 I %=-1 S %=2 R !,"Do you want to Delete this Transaction" D YN^DICN G:$D(DTOUT)!(%=1) KILL^RMPR421
 D ^RMPR4LI I RMPRX]"" G ASK5
L W !!!,"Enter Item to Edit: " R X:DTIME G:'$T KILL^RMPR421
 G:"^"[X ASK5 I X["?" D ZDSP G L
 S DA(1)=RMPRA,DIC="^RMPR(664,"_RMPRA_",1,",DIC(0)="EQMZ" D ^DIC
 I +Y'>0 K DA,Y G L
 S:$D(RMPRCTK) RMPRCONT=RMPRCTK
 S DA=+Y,DA(1)=RMPRA,DR="8;9;I $P(^RMPR(664,DA(1),1,DA,0),U,10)=4 S Y=10;.01;17;1;14;3;2;4;7;S Y="""";10;.01;17;1;14;3;2;4;7"
 S DIE="^RMPR(664,"_RMPRA_",1," D ^DIE K DA
 S FL=1 I $D(^RMPR(664,RMPRA,1)) S FL=0 F RI=0:0 S RI=$O(^RMPR(664,RMPRA,1,RI)) Q:RI'>0  I $D(^(RI,0)) S FL=1 I $P(^(0),U,3)=""!($P(^(0),U,4)="")!($P(^(0),U,5)="")!($P(^(0),U,9)="")!($P(^(0),U,10)="") S FL=0 Q
 I 'FL W !!,?5,$C(7),"REQUIRED ITEMS DO NOT EXIST ON THIS FORM",! G KILL^RMPR421
 K DA S DIE="^RMPR(664,",DA=RMPRA,DR="11;17;26;20" D ^DIE
 D  G:$D(DTOUT) KILL^RMPR421 G:$D(DUOUT) ASK5
 .S DIR(0)="SA^1:VETERAN;2:VAMC WAREHOUSE;3:PROSTHETICS;4:OTHER;"
 .S DIR("A")="DELIVER TO: "
 .S DIR("B")=$P(^RMPR(664,DA,3),U,1)
 .D ^DIR K DIR
 .Q:$D(DTOUT)!($D(DUOUT))
 .S RMPRDELN=Y(0)
 .I Y=4 S:'$D(^RMPR(664,RMPRA,3)) ^(3)="" S Y1=Y,DIE="^RMPR(664,",DA=RMPRA,DR="19T" D ^DIE
 G:$D(DTOUT) KILL^RMPR421 S RMPRDELN=$S($D(Y1):$P(^RMPR(664,RMPRA,3),U),1:RMPRDELN) K Y1 G L
ZDSP ;MULTIPLE ITEM DISPLAY FOR PURCHASING AND CLOSE-OUT
 K RAC S RMPRI=0 F  S RMPRI=$O(^RMPR(664,RMPRA,1,RMPRI)) Q:RMPRI'>0  S RMPRI1=$P(^(RMPRI,0),U,1),RMPRIT=$P(^RMPR(661,RMPRI1,0),U,1),RAC(RMPRIT)=$P(^PRC(441,RMPRIT,0),U,2)
 W ! I $D(RAC) W !,?5,"Answer With Item # or Item Name",! F RI=0:0 S RI=$O(RAC(RI)) Q:RI'>0  W !,?5,RI,?10,RAC(RI)
LDIC I $D(RFL) S X="?",DIC=661,DIC(0)="EQM",DIC("W")="W "" "",$P(^PRC(441,$P(^(0),U,1),0),U,2)" D ^DIC K RFL
 Q
PR1 ;PRINT PATIENT NOTIFICATION LETTER
 S RMPRPN=0,%=2
 R !,"Would you like to print a Patient Notification letter"
 D YN^DICN I %=1 S RMPRPN=1 Q
 G:%=0 HELP1
 Q:(%=2)!(%=-1)
 Q
VCON ;vendor contract
 K DIR S DIR(0)="PO^PRC(440,"_RMPRV_",4,:QEM" D ^DIR
 I (Y'>0)&(X'="")&(X'["^") S DIR("B")="" G VCON
 I X["^" G KILL^RMPR421
 I Y>0,$P(^PRC(440,RMPRV,4,+Y,0),U,2)<DT W $C(7),!,"Sorry, contract has expired.  Enter another contract or `return` to continue." S DR="4//""""" G VCON
 K DIR,DA
 S:Y>0 (RMPRCONT,RMPRCTK)=$P(Y,U,2)
 Q
HELP1 ;
 W !,"Enter `Y` for YES to print the Patient Notification letter",!,"`N` for No if you do not wish to print the letter." G PR1
 Q
PR ;PRINT THE PRIVACY ACT STATEMENT
 S %=1 R !,"Would you like to print the Privacy Act Statement" D YN^DICN I %=1 S RMPRPRIV=1 D PR1 Q
 G:%=0 HELP D:%=2 PR1 Q
 Q:%=-1
HELP W !,"Enter `Y` for YES to print the Privacy Act Statement",!,"`N` for NO if you do not want to print the statement." G PR
 Q
 ;END
