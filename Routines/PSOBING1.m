PSOBING1 ;BHAM ISC/LC - bingo board utility routine ;6/29/06 11:46am
 ;;7.0;OUTPATIENT PHARMACY;**5,28,56,135,244,268**;DEC 1997;Build 9
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to DD(52.11 and DD(59.2 supported by DBIA 999
 ;
 ;*244 don't store to file 52.11 if Rx Status > 11
 ;
BEG D:'$D(PSOPAR) ^PSOLSET G:'$D(PSOPAR) END
NEW K DD,DO S (DIC,DIE)="^PS(52.11,",(NDA,X,DA)=PSODFN,DIC(0)="LMNQZ" D FILE^DICN K DIC G:Y'>0 NEW S (ODA,DA)=+Y,BNGSUS=0 S:$D(SUSROUTE) BNGSUS=1
NEW1 S GRTP=$P($G(^PS(59.3,DISGROUP,0)),"^",2),NAM=$P($G(^DPT(PSODFN,0)),"^"),SSN=$P($G(^DPT(PSODFN,0)),"^",9) I GRTP="T" D  G:'$D(DA) END
 .K TFLAG S DR="1;2////"_DISGROUP_";3////"_PSOSITE_";4////"_TM_";5////"_$E(TM1_"0000",1,4)_";8////"_NAM_";9////"_SSN_";13////"_BNGSUS_"" D STO  Q:'$D(DA)
 .W !! S TIC=$P(^PS(52.11,DA,0),"^",2) D
 ..F TIEN=0:0 S TIEN=$O(^PS(52.11,"C",TIC,TIEN)) Q:'TIEN  I DA'=TIEN,($P(^PS(52.11,DA,0),"^",4)=+$P(^PS(52.11,TIEN,0),"^",4)) D
 ...S TDFN=$P(^PS(52.11,TIEN,0),"^"),TSSN=$P(^PS(52.11,TIEN,1),"^",2),TFLAG=0 W !,$C(7),$P(^DPT(TDFN,0),"^")_" ("_TSSN_") was issued ticket # "_TIC,". Try again!",!
 ..K TDFN,TIEN,TSSN Q:'TFLAG
 I $G(GRTP)="T" G:'TFLAG NEW1 G:TFLAG END
 S DR="2////"_DISGROUP_";3////"_PSOSITE_";4////"_TM_";5////"_$E(TM1_"0000",1,4)_";8////"_NAM_";9////"_SSN_";13////"_BNGSUS_""
STO S NFLAG=1 L +^PS(52.11,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) E  W !!,$C(7),Y(0,0)," is being edited!",! S DA=NDA D WARN Q:$G(GRTP)="T"  G END
 S XDA=DA D ^DIE I $G(DUOUT)!($G(DTOUT))!(X="") S DA=ODA D WARN G END
 S DA=XDA D STORX S DA=XDA L -^PS(52.11,DA)
 S TFLAG=1 D:$G(GRTP)="N" CHKUP^PSOBINGO,NOTE G:$G(GRTP)="N" END
 Q
NOTE S DFN=$P($G(^PS(52.11,DA,0)),"^"),NFLAG=1 W !!,?5,"NAME",?30,"SSN",?45,"ID",?50,"ORDER"
 F Z=0:0 S Z=$O(^PS(52.11,"B",DFN,Z)) Q:'Z  S ZDA=Z S NODE=^PS(52.11,ZDA,1),Z1=$P($G(NODE),"^"),Z2=$P($G(NODE),"^",3),Z3=$P($G(NODE),"^",4),Z4=$P($G(NODE),"^",2) W !,?5,Z1,?30,Z4,?46,Z2,?52,Z3
 W !!,"Please advise the patient that the above ID # and/or ORDER Letter"
 W !,"will be displayed with his/her name on the Bingo Display",!!
 I $G(^PS(55,"ASTALK",DFN)) W !,$C(7),"** ",Z1," is enrolled for ScripTalk.",!,"  Please use label(s) from ScripTalk printer." D  W !
 .I $P($G(^PS(59,+PSOSITE,"STALK")),"^")="" W !,"  ** NO SCRIPTALK PRINTER DEFINED FOR THIS DIVISION!",! Q
 .I $P($G(^PS(59,+PSOSITE,"STALK")),"^",2)'="A" W !,"  ** SCRIPTALK PRINTER IS NOT DEFINED FOR AUTO-PRINT",!,"You must manually queue the ScripTalk label(s) to print.",!
 K NODE,Z1,Z2,Z3
 Q
HELP W !!,"Wand the barcode of the Rx or manually key in",!,"the number below the barcode, the Rx number, or the",!,"patient name in the format - 'LASTNAME,FIRSTNAME'"
 W !!,"The barcode # should be of the format - 'NNN-NNNNNNN'"
 Q
BCRMV W !! K DIR S DIR("A")="Enter/Wand Rx # or Enter PATIENT NAME",DIR("?")="^D HELP^PSOBING1",DIR(0)="FO^1:45" D ^DIR
 G:$D(DIRUT) END
 I X'["-" D BCI^PSODISP Q:'$G(RXP)  G BCRMV1
 I X["-",$P(X,"-")'=$P($$SITE^VASITE(),"^",3) W !?7,$C(7)," INVALID STATION # !",! G BCRMV
 I X["-" S RXP=$P(X,"-",2) I '$D(^PSRX(+$G(RXP),0))!($G(RXP)']"") W !?7,$C(7)," NON-EXISTENT RX #" G BCRMV
 G:$D(^PSRX(RXP,0)) BCRMV1
 W !?7,$C(7)," IMPROPER BARCODE FORMAT" G BCRMV
BCRMV1 S NME=$P($G(^PSRX(RXP,0)),"^",2),BNAME=$P($G(^DPT(NME,0)),"^"),BDA="",CNT1=0
 F XX=0:0 S XX=$O(^PS(52.11,"B",NME,XX)) Q:'XX  D
 .F BRX=0:0 S BRX=$O(^PS(52.11,XX,2,"B",BRX)) Q:'BRX  D
 ..I BRX=RXP S DA=XX
 I '$D(DA) W !!,BNAME," isn't in the Bingo Board file.",$C(7) G BCRMV
 I $D(^PS(52.11,"ANAMK",DA)) W !!,BNAME," has already been removed from the display.",$C(7) G BCRMV
 D REMOVE1^PSOBINGO
 K BRX,DIK,DA,XX W !!,BNAME," is removed from the display."
 G BCRMV
WARN W !!,$C(7),"Bingo record is incomplete!" S DIK="^PS(52.11," D ^DIK K DIK,DA W !!,"Bingo record removed.",!
 Q
STORX ;Sto Rx # for each entry in 52.11
 Q:'$D(BBRX(1))  N DIC,DIE,NUM,BB,BBN,DR,FL,FLN,I
 S DA(1)=DA,(DIC,DIE)="^PS(52.11,"_DA(1)_",2,",DIC(0)="L",DIC("P")=$P(^DD(52.11,12,0),"^",2),DLAYGO=52.11
 F BBN=0:0 S BBN=$O(BBRX(BBN)) Q:'BBN  F NUM=1:1 S BB=$P(BBRX(BBN),",",NUM) Q:'BB  D
 .Q:$G(^PSRX(BB,"STA"))>11                            ;*244
 .I $D(RXPR(BB)) S FL="P",FLN=$G(RXPR(BB))
 .I '$D(RXPR(BB)) F I=0:0 S I=$O(^PSRX(BB,1,I)) Q:'I  S FL="F",FLN=I
 .I '$D(FL) S FL="F",FLN=0
 .S X=$P(^PSRX(BB,0),"^") D ^DIC
 .S DA=$P(Y,"^"),DR="1////"_FL_";2////"_FLN_"" D ^DIE K FL,FLN
 Q
 ;
WTIME ;sto bingo wait time in 52
 Q:'$D(DA)!'$D(DIF)  S BDA=DA
 N DIE,XX,BRX1,BRXFL,BRXFLN,DR
 S DA(1)=DA,DIE="^PS(52.11,"_DA(1)_",2,"
 F XX=0:0 S XX=$O(^PS(52.11,BDA,2,XX)) Q:'XX  S DA=XX,BRX=$G(^PS(52.11,BDA,2,DA,0)),BRX1=$P(^(0),"^"),BRXFL=$P(^(0),"^",2),BRXFLN=$P(^(0),"^",3) D
 .S DR="3////"_DIF_"" D ^DIE D
 ..N DA,DIE S DA=BRX1
 ..I $G(BRXFLN)=0 S DIE="^PSRX(",DR="32.3////"_DIF_"" D ^DIE K DIE
 ..I $G(BRXFLN)>0,$G(BRXFL)="F",$G(^PSRX(DA,1,BRXFLN,0)) S DA(1)=DA,DIE="^PSRX("_DA(1)_",1,",DA=BRXFLN,DR="18////"_DIF_"" D ^DIE K DIE
 ..I $G(BRXFLN)>0,$G(BRXFL)="P",$G(^PSRX(DA,"P",BRXFLN,0)) S DA(1)=DA,DIE="^PSRX("_DA(1)_",""P"",",DA=BRXFLN,DR="9////"_DIF_"" D ^DIE K DIE
 S DA=BDA K DIE,XX,BRX,BRX1,BRXFL,BRXFLN,DR,DA(1)
 Q
 ;
CREF ;check for deleted refills
 S BDA=DA,XX=0,BRB="" F  S XX=$O(^PS(52.11,BDA,2,XX)) Q:'XX  S DA=XX D
 .S BRX0=$G(^PS(52.11,BDA,2,DA,0)),BRX1=$P(BRX0,"^"),BRXFL=$P(BRX0,"^",2),BRXFLN=$P(BRX0,"^",3)
 .I BRXFLN,BRXFL="F",$G(^PSRX(BRX1,1,BRXFLN,0))']"" D
 ..S DA(1)=BDA,DIK="^PS(52.11,"_DA(1)_",2," D ^DIK K DIK,DA(1)
 ..S BRB=BRB_$S(BRB="":"",1:"; ")_BRX1_","_BRXFLN
 S DA=BDA I BRB]"",$P($G(^PS(52.11,BDA,2,0)),"^",4)=0 D
 .W !!,$C(7),"Refill(s) "_BRB_" does not exist.",!,"It can't be displayed and is now deleted."
 .S DIK="^PS(52.11," D ^DIK S PSODRF=1
 K BDA,BRB,BRX0,BRX1,BRXFL,BRXFLN
 Q
 ;
REL S BNGRXP=RXP N NAM,NAME,RXO,SSN
 S NAM=$P($G(^DPT(BINGNAM,0)),"^"),ADA="",BNGRXP=RXP
 F XX=0:0 S XX=$O(^PS(52.11,"B",BINGNAM,XX)) Q:'XX  D
 .F BRX=0:0 S BRX=$O(^PS(52.11,XX,2,"B",BRX)) Q:'BRX  D
 ..I BRX=BNGRXP S (DA,ODA)=XX
 I '$D(DA) W !!,"The Rx for ",NAM," isn't in the Bingo Board",!,"file and must be entered manually.",$C(7) G END
 I $P($G(^PS(52.11,DA,0)),"^",7)]"" W !!,NAM,"  is already in the display queue.",$C(7) G END
 I $P($P($G(^PS(52.11,DA,0)),"^",5),".")'=DT S Y=$P($P($G(^PS(52.11,DA,0)),"^",5),".") D DD^%DT W !!,$C(7),NAM," was entered on "_Y_".",!,"It can't be displayed and is now deleted." S DIK="^PS(52.11," D ^DIK K DIK G END
 G:$P($G(^PS(52.11,DA,0)),"^",9) REL1
 I $P($G(^PS(52.11,DA,0)),"^",4)'=PSOSITE W !!,NAM," is from another division",!,"and must be displayed manually.",$C(7) G END
 I $D(BINGRO),$D(BINGDIV) S BDIV=BINGDIV G REL1
 I $D(BINGRPR),$D(BNGPDV) S BDIV=BNGPDV G REL1
 I $D(BINGRPR),$D(BNGRDV) S BDIV=BNGRDV G REL1
REL1 N TM,TM1 D NOW^%DTC S TM=$E(%,1,12),TM1=$P(TM,".",2)
 S NM=$P(^DPT($P(^PS(52.11,DA,0),"^"),0),"^"),DR="6////"_$E(TM1_"0000",1,4)_";8////"_NM_"",DIE="^PS(52.11,"
 L +^PS(52.11,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) E  W !!,$C(7),NM," is being edited!",! D WARN G END
 D ^DIE L -^PS(52.11,DA) I $G(DUOUT)!($G(DTOUT))!(X="") D WARN G END
 S RX0=^PS(52.11,DA,0),JOES=$P(RX0,"^",4),TICK=+$P($G(RX0),"^",2),GRP=$P($G(^PS(59.3,$P($G(^PS(52.11,DA,0)),"^",3),0)),"^",2) D:GRP="T"&('$G(TICK)) WARN G:'$D(DA) END
 W !!,NAM," added to the "_$P($G(^PS(59.3,$P(RX0,"^",3),0)),"^")_" display."
 I +$G(^PS(55,"ASTALK",$P(^PS(52.11,DA,0),"^"))) W !,$C(7),"This patient is enrolled in ScripTalk and may benefit from",!,"a non-visual announcement that prescriptions are ready."
 S PSZ=0 I '$D(^PS(59.2,DT,0)) K DD,DIC,DO,DA S X=DT,DIC="^PS(59.2,",DIC(0)="",DINUM=X D FILE^DICN S PSZ=1 Q:Y'>0 
 I PSZ=1 S DA(1)=+Y,DIC=DIC_DA(1)_",1,",(DINUM,X)=JOES,DIC(0)="",DIC("P")=$P(^DD(59.2,1,0),"^",2) K DD,DO D FILE^DICN K DIC,DA Q:Y'>0
 I PSZ=0 K DD,DIC,DO,DA S DA(1)=DT,(DINUM,X)=JOES,DIC="^PS(59.2,"_DT_",1,",DIC(0)="LZ" D FILE^DICN K DIC,DA,DO
 S DA=ODA D STATS1^PSOBRPRT,WTIME
END K ADA,BDA,BDIV,BNGRXP,BNGSUS,BNAME,BRX,CNT1,CT,DA,DD,DIC,DIE,DIK,DIR,DO,DR,DTOUT,DUOUT,GRP,GRTP,JOES
 K NAM,NDA,NFLAG,NME,ODA,PSZ,RXO,SSN,TDFN,TFLAG,TIC,TICK,TIEN,TM,TM1,TSSN,X,Y,XX
 Q
