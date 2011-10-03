FBAABET ;AISC/ EDIT BATCH ;09AUG85
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RD W !! S DIC="^FBAA(161.7,",DIC(0)="AEQZ",DIC("S")=$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):"I $G(^(""ST""))=""O""",1:"I $P(^(0),U,5)=DUZ&($G(^(""ST""))=""O"")") D ^DIC K DIC G END:X="^"!(X=""),RD:Y<0 S FBDA=+Y,FBDA(0)=Y(0)
 S FBON=$P(FBDA(0),U,2),PRC("SITE")=$P(FBDA(0),U,8),FBTYPE=$P(FBDA(0),U,3)
 ;
OB W !,"Obligation Number:  ",FBON,"//"
 S DIR(0)="Y",DIR("A")="Do you want to change the Obligation Number",DIR("B")="No" D ^DIR K DIR G END:$D(DIRUT) D GETOB:Y
 S DIE="^FBAA(161.7,",DA=FBDA,DR="[FBAA BATCH EDIT]" D ^DIE K DIE,DIC,DR
 G RD
 ;
END K DR,DIC,DIE,X,DO,DA,DI,DQ,Z,ZZ,PRC,FBHOLDX,FBPOP,FBSITE,FBON,FBDA,DIRUT,DUOUT,DTOUT,PRCS,PRCSCPAN,Y,FBI,FBJ,FBK,FBL
 Q
 ;
GETOB ;Get valid Obligation Number
 S PRCS("A")="Select Obligation Number:  " K PRCS("X"),DR S PRCS("TYPE")="FB" D EN1^PRCS58 Q:Y=-1  S FBON=$P($P(Y,"^",2),"-",2) D
 . ;find if any payments are associated with this batch and change
 . ;obligation number
 . I FBTYPE="B3",$D(^FBAAC("AC",FBDA)) D
 ..S (FBI,FBJ,FBK,FBL)=0 F  S FBI=$O(^FBAAC("AC",FBDA,FBI)) Q:'FBI  F  S FBJ=$O(^FBAAC("AC",FBDA,FBI,FBJ)) Q:'FBJ  F  S FBK=$O(^FBAAC("AC",FBDA,FBI,FBJ,FBK)) Q:'FBK  D
 ... F  S FBL=$O(^FBAAC("AC",FBDA,FBI,FBJ,FBK,FBL)) Q:'FBL  I $G(^FBAAC(FBI,1,FBJ,1,FBK,1,FBL,0)),$P(^(0),U,8)=FBDA D
 .... S DA(3)=FBI,DA(2)=FBJ,DA(1)=FBK,DA=FBL,DIE="^FBAAC("_FBI_",1,"_FBJ_",1,"_FBK_",1,",DR="8////^S X=FBON" D ^DIE K DIC,DIE,DR,DA
 . I FBTYPE="B5",$D(^FBAA(162.1,"AE",FBDA)) D
 .. S (FBI,FBJ)=0 F  S FBI=$O(^FBAA(162.1,"AE",FBDA,FBI)) Q:'FBI  F  S FBJ=$O(^FBAA(162.1,"AE",FBDA,FBI,FBJ)) Q:'FBJ  I $G(^FBAA(162.1,FBI,"RX",FBJ,0)),$P(^(0),U,17)=FBDA D
 ... S DA(1)=FBI,DA=FBJ,DIE="^FBAA(162.1,"_FBI_",""RX"",",DR="14////^S X=FBON" D ^DIE K DIC,DIE,DR,DA
 Q
