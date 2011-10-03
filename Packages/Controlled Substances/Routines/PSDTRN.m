PSDTRN ;BIR/JPW-Transfer Stock Entries from NAOU to NAOU ; 18 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 K LOC("TR") S CNT=0,PSDUZ=DUZ
 W !!,"This option will copy the stock entries from one NAOU into NAOUs you select.",!,"No more than 10 transfers are allowed at a time.",!,"Inactive drugs will not be transferred.",!
NUM ;ask how many NAOUs
 W ! K DA,DIR,DIRUT S DIR(0)="SO^1:Transfer to one NAOU;2:Transfer to multiple NAOUs",DIR("A")="Select Transfer Type"
 S DIR("?",1)="Answer '1' if transfer to only ONE NAOU is desired, '2' if the same",DIR("?")="stock list is to be copied into more than one NAOU, or '^' to quit"
 D ^DIR K DIR G:$D(DIRUT) END S ANS=+Y
METHOD ;asks method of stock transfer
 W !!!,"=>  Methods of transferring stock drug data."
 W ! K DA,DIR,DIRUT S DIR(0)="SO^1:Drug name only;2:Drug name, stock level, and location code;3:Drug name, stock level, location code, and inv. types",DIR("A")="Select Transfer Method"
 S DIR("?",1)="Answer '1' if transfer of ONLY drug name is desired, '2' if you wish to",DIR("?",2)="copy drug name, stock level, and location code, '3' if you wish to transfer"
 S DIR("?")="drug name, stock level, location code, and inv. type, or '^' to quit"
 D ^DIR K DIR G:$D(DIRUT) END S MTR=+Y
FROM ;select NAOU to transfer stock from
 W ! K DA,DIC S DIC=58.8,DIC(0)="QEA",DIC("A")="Select NAOU to transfer drug stock FROM: ",DIC("S")="I $P(^(0),""^"",2)'=""P"",$P(^(0),""^"",3)=+PSDSITE" D ^DIC K DIC G:Y<0 END S NSF=+Y
TO ;select NAOU(s) to transfer stock to
 W ! K DA,DIC S DIC=58.8,DIC(0)="QEA",DIC("A")="Select NAOU to transfer drug stock INTO: ",DIC("S")="I $P(^(0),""^"",2)'=""P"",$P(^(0),""^"",3)=+PSDSITE"
 D ^DIC K DIC G:(Y<0)&(ANS=1) END G:(Y<0)&(ANS=2) CHK S LOC("TR",+Y)="",CNT=CNT+1
 I CNT>9 W !!,"You may not transfer TO additional NAOUs at this time.",!,"Enter the option again to transfer to more NAOUs."
 I ANS=2,CNT<10 G TO
CHK ;checks for valid NAOUs
 I $D(LOC("TR",NSF)) W $C(7),$C(7),!!,?5," ** NOT ALLOWED to transfer out of and into SAME NAOU! **" G END
 G:'$O(LOC("TR",0)) END
 W !!,?5,"I will now COPY the ENTIRE drug stock list from ",!,?5,$P(^PSD(58.8,NSF,0),"^")," into" F TR=0:0 S TR=$O(LOC("TR",TR)) Q:'TR  W !,?5,$P(^PSD(58.8,TR,0),"^")
 W !!,?5,"I will transfer ",$S(MTR=3:"drug name, stock level, location code and types.",MTR=2:"drug name, stock level and location code.",1:"drug name only.")
 W !! K DA,DIR,DIRUT S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure that is what you want to do"
 S DIR("?",1)="Answer 'YES' if you wish to transfer stock entries,",DIR("?")="answer 'NO' or <RET> if you do not."
 D ^DIR K DIR I 'Y!$D(DIRUT) G END
QUE W !!,"This job will automatically be queued to run in the background.",!,"You will be notified by a MailMan message when the transfer is completed.",!
 S NAOUT="" F TR=0:0 S TR=$O(LOC("TR",TR)) Q:'TR  S NAOUT=NAOUT_TR_","
 S ZTIO="",ZTDTH=$H,ZTRTN="^PSDTRN1",ZTDESC="Transfer NAOU Stock" S (ZTSAVE("MTR"),ZTSAVE("NAOUT"),ZTSAVE("NSF"),ZTSAVE("PSDUZ"))=""
 D ^%ZTLOAD W !!,"'Transfer Stock Drugs from NAOU to NAOU' has been queued.",!
END K ANS,CNT,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LOC,MTR,NAOUT,NSF,PSDUZ,TR,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK S:$D(ZTQUEUED) ZTREQ="@"
