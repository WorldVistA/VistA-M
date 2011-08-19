PRCEADJ ;WISC/CLH/LDB/PLT/SJG - CP 1358 ADJUSTMENTS ; 9/15/2010
V ;;5.1;IFCAP;**140,148**;Oct 20, 2000;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;Create increase/decrease adjustment
EN N PRC410,PRC442,PRCS,DIE,DR,PRC,PRCS2,DIC,X,X410,X442,X1,X2,X3,X4,PRCSIP,Y,Y410,DIR,TRNODE,Z,Z410,PRCSOBN
EN1 ;
 D EN^PRCSUT ; ask site, fiscal year, quarter, control point; set X & Z
 I '$D(PRC("SITE")) W !,$C(7),"You are not an authorized control point user.",! G OUT
 G OUT:'$D(PRC("QTR"))!(Y<0)
 S X410=X ; station-FY-FCP
 S Z410=Z ; station-FY-quarter-FCP
 ;
 ; warn CP official, allow to quit (PRC*5.1*148)
 G:$$Q1358^PRCEN(PRC("SITE"),PRC("CP"),"A") OUT
 ;
ENA1 S DIC=410,Y=""
 D OROBL^PRCS58OB(DIC,.PRC,.Y) ; get obligation # from old 1358
 I $D(DTOUT)!$D(DUOUT) G OUT
 I Y<0 W $C(7),!!,"    Obligation number is required.  Use '^' to exit this option.",! G ENA1
 S Y410=Y
 S X442=X
 D NODE^PRCS58OB(+Y,.TRNODE) ; set up TRNODE array from data in 410
 S X="0101"_$P(TRNODE(0),"-",2),%DT="X" D ^%DT
 S X2=$E(Y,1,3) ; FY of original 1358
 S X="0101"_PRC("FY"),%DT="X" D ^%DT
 S X3=$E(Y,1,3) ; adjustment FY
 I X2_"-"_$P(TRNODE(0),"-",3)](X3_"-"_PRC("QTR")) D EN^DDIOL("Adjustments cannot be earlier than the original 1358's FY-QTR.") G ENA1
 N POOBL S POOBL=$P($G(TRNODE(10)),U,3)
 I POOBL="" D EN^DDIOL("    Obligation number is required.") W ! G ENA1
 N OBLSTAT S OBLSTAT=$$NP^PRC0B("^PRC(442,"_POOBL_",",7,1)
 I $G(OBLSTAT)=40 D EN^DDIOL("    Adjusting a closed 1358 request is not allowed.") W ! G ENA1
ENA2 N EXIT S EXIT=0
 D FMSTAT(POOBL,.FMSDOC,.STATUS)
 I $D(STATUS),"AF"'[$E(STATUS,1) D  I EXIT D MSG1,OUT G EN1
 .Q:STATUS="CALM"
 .; S TMP=Y,%X="Y",%Y="TMP(" D %XY^%RCR K %X,%Y ; PRC*5*231 - saves Y earlier
 .K MSG W !
 .S MSG(1)="    Note that one of the previous documents has not been processed in FMS."
 .S MSG(2)="    The adjustment to this 1358 cannot be obligated until the previous"
 .S MSG(3)="    document has been processed in FMS.",MSG(5)="  "
 .S MSG(6)="    FMS Document: "_FMSDOC,MSG(7)="    Status: "_STATUS
 .D EN^DDIOL(.MSG) K MSG
 .W ! D PROMPT
 .S:Y EXIT=0 I 'Y!($D(DIRUT)) S EXIT=1
 .Q
 ;The following lines commented out by PRC*5*231 - Y doesn't need to be restored
 ; I $D(STATUS) S:"AF"[$E(STATUS,1)!(STATUS="CALM") EXIT=1
ENA3 ; I $D(EXIT) I 'EXIT S Y=TMP,%X="TMP",%Y="Y(" D %XY^%RCR,MSG2 K TMP,%X,%Y
 S PRC442=$P($G(TRNODE(10)),U,3)
 S PRCSOBN=$$BAL^PRCH58(PRC442) ; get obligation# from file 442,node 8
 I PRCSOBN'=-1 W !," Original Obligation Amount:  $ ",$FN($P(PRCSOBN,U),",P",2)
 I PRCSOBN'=-1 D
 .W ?46,"Service Balance: $ ",$FN((+PRCSOBN-$P(PRCSOBN,U,3)),",P",2),!
 .W ?4,"  Fiscal's 1358 Balance:  $ ",$FN(+PRCSOBN-$P(PRCSOBN,U,2),",P",2),!
 S Y=Y410,X=X410,X1=X,Z=Z410
 D EN1^PRCSUT3 Q:'X  S X1=X
 D EN2 Q:'$D(X1)  S X=X1 ; add data to record in 410
 W !,"This transaction is assigned transaction number: ",X
 L +^PRCS(410,DA):$S($D(DILOCKTM):DILOCKTM,1:3) I $T=0 D EN^DDIOL("File in use.... Please try again later") D KILL G EN1
 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)) S:$P(^(0),U,11)="Y" PRCS2=1
 S PRC410=DA
 S PRCSIP=$S($D(PRCSIP):PRCSIP,1:"")
 D ADJ^PRCS58OB(DIC,DA,PRCSIP,.X4)
 K PRCSOBN
 D ADJ1^PRCS58OB(DA,X,Y410)
 D ADJ2^PRCS58OB(.PRC,X442,DA)
 L -^PRCS(410,DA)
 S DIR("A")="Enter another increase/decrease adjustment"
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("?")="Yes to enter an adjustment, return or '^' to quit"
 D ^DIR I Y D KILL G EN1
OUT K DIRUT,DTOUT,DUOUT
KILL K PRC410,PRC442,PRCS,DIE,DR,PRC,PRCSL,PRCS2,DIC,X,X410,X442,X1,X4,PRCSIP,Y,Y410,DIR,TRNODE,Z,Z410,PRCSOBN
 K DA,FMSDOC,STATUS,TMP,%DT
 QUIT
 ;
ASK ; entry point from other options
 S DIR(0)="YO"
 S DIR("A")="Do you want to enter an increase adjustment at this time"
 S DIR("B")="NO"
 S DIR("?")="Yes to enter an increase adjustment, return or '^' to quit"
 D ^DIR I 'Y&'$D(DIRUT) W !!,"No action can be taken with this authorization amount now.",! K DIR Q
 K DIR,DIC,X,Y I $D(DIRUT) Q
 G EN
 ;
FMSTAT(POOBL,FMSDOC,STATUS) ; Check status of prior FMS Documents
 N LOOP,NODE
 S LOOP=0,(FMSDOC,STATUS)=""
 F  S LOOP=$O(^PRC(442,+POOBL,10,LOOP)) Q:LOOP'>0  D
 .S NODE=^PRC(442,+POOBL,10,LOOP,0)
 .I $E(NODE,1,2)="SO"!($E(NODE,1,2)="AR") D
 ..S FMSDOC=$P($G(^PRC(442,+POOBL,10,LOOP,0)),U,4)
 ..S STATUS=$$STATUS^GECSSGET(FMSDOC)
 ..Q
 .I $E(NODE,1,6)?3N1"."2N S STATUS="CALM"
 Q
PROMPT ;
 S DIR(0)="Y"
 S DIR("A")="    Do you wish to create the adjustment to this 1358"
 S DIR("B")="YES"
 S DIR("?")="    Enter 'YES' or 'Y' or 'RETURN' to create the adjustment."
 S DIR("?",1)="    Enter 'NO' or 'N' or '^' to exit."
 D ^DIR K DIR
 Q
 ;
EN2 ;add record in file 410
 S DLAYGO=410,DIC="^PRCS(410,",DIC(0)="LXZ" D ^DIC K DLAYGO G:Y<0 W4
EN2A S DA=+Y S:'$D(T(2)) T(2)=""
 S PRC("ACC")=$$ACC^PRC0C(PRC("SITE"),PRC("CP")_"^"_PRC("FY")_"^"_PRC("BBFY"))
 S PRCSAPP=$P(PRC("ACC"),U,11)
 S ^PRCS(410,DA,0)=$P(^PRCS(410,DA,0),U)_"^^"_T(2)_"^^"_PRC("SITE")
 S $P(^PRCS(410,DA,1),U,6,7)=$P($G(^PRCS(410,+Y410,1)),U,6,7)
 S ^PRCS(410,DA,2)=$G(^PRCS(410,+Y410,2))
 S ^PRCS(410,DA,3)=PRC("CP")_U_PRCSAPP,$P(^(3),U,12)=$P(PRC("ACC"),U,3)
 S $P(^PRCS(410,DA,3),U,11)=$P($$DATE^PRC0C(PRC("BBFY"),"E"),U,7)
 S $P(^PRCS(410,DA,3),U,10)=$P($G(^PRCS(410,+Y410,3)),U,10)
 S $P(^PRCS(410,DA,11),U,4,5)=$P($G(^PRCS(410,+Y410,11)),U,4,5)
 S ^PRCS(410,"AN",$E(PRC("CP"),1,30),DA)=""
 D ERS410^PRC0G(DA_"^E")
 S:T(2)'="" ^PRCS(410,"H",$E(T(2),1,30),DA)=DUZ,$P(^PRCS(410,DA,11),U,2)=DUZ,^PRCS(410,"K",+$P(PRC("CP")," "),DA)="",$P(^PRCS(410,DA,6),U,4)=+$P(PRC("CP")," ") K PRCSAPP
EN2B S:$D(PRC("SST")) $P(^PRCS(410,DA,0),U,10)=PRC("SST")
 D:$D(MYY) ERS410^PRC0G(DA_"^E")
 K T(2),MYY
 Q
W4 W !!,"Another user is accessing this file...  Try later.",$C(7) R:$E(IOST,1,2)="C-" X:5
 Q
 ;
MSG1 W ! D EN^DDIOL("    No further action taken on this adjustment.") W ! Q
MSG2 W ! D EN^DDIOL("    Returning to creating the 1358 adjustment...") W !! Q
