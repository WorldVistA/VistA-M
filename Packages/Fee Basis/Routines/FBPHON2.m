FBPHON2 ;AISC/CMR-LIST PAYMENTS CONT. ;4/17/2000
 ;;3.5;FEE BASIS;**4,21,77**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D FULL^VALM1
EN N FBI,FBX,FBAAOUT,Q S Q="-",$P(Q,"-",80)="-",FBAAOUT=0,VALMBCK="R"
 D SEL^VALM2 G END:'$O(VALMY(0))
 S FBI=0 F  S FBI=$O(VALMY(FBI)) Q:'FBI  I $D(^TMP("FBPHIDX",$J,FBI)) S FBX=^(FBI) D @FBPR I '$G(FBAAOUT) S DIR(0)="E",DIR("A")="Press 'ENTER' to "_$S($O(VALMY(FBI)):"view next selection",1:"return to list") D ^DIR K DIR Q:'Y
 Q
END S VALMBCK="R" Q
BT ;display batch for chosen line item
 W @IOF N B
 S B=$P(FBX,U,8) I B']"" D ERR Q
 I $D(^FBAA(161.7,B,0)) S FBTYPE=$P(^FBAA(161.7,B,0),U,3)
 D ENM^FBAACCB:FBTYPE="B3",ENP^FBAACCB:FBTYPE="B5",ENT^FBAACCB0:FBTYPE="B2",PRTC^FBAACCB1:FBTYPE="B9"
 Q
INV ;display invoice for chosen line item
 W @IOF N FBAAIN,FBAAOUT,FBINTOT,J,DA,FBI
 I $P(FBX,U,7)']"" D ERR Q
 I $P(FBX,U)="PHAR" S DA=$P(FBX,U,7) D START^FBAAPII Q
 I $P(FBX,U)="CH"!($P(FBX,U)="CNH") S FBI=$P(FBX,U,7) D START^FBCHDI2 Q
 I $P(FBX,U)="OPT" D  D Q^FBAAPIN
 .S FBAAIN=$P(FBX,U,7),(FBAAOUT,FBINTOT,J)=0 F  S J=$O(^FBAAC("C",FBAAIN,J)) Q:'J!(FBAAOUT)  D MMORE^FBAAPIN
 D Q^FBAAPIN
 Q
BS ;display batch status for chosen line item
 W @IOF N DA
 I $P(FBX,U,8)']"" D ERR Q
 S DA=$P(FBX,U,8) D START^FBAABS
 Q
DV ;display vendor demographics for chosen vendor
 N DA S VALMBCK="R"
 S DA=FBV D CLEAR^VALM1,EN1^FBAAVD
 I $D(^XUSEC("FBAA ESTABLISH VENDOR",DUZ)) S DIR(0)="Y",DIR("A")="Want to Edit data",DIR("B")="NO" D ^DIR K DIR Q:$D(DIRUT)  D:Y EDITV^FBAAVD
 I '$D(^XUSEC("FBAA ESTABLISH VENDOR",DUZ)) S DIR(0)="E" D ^DIR K DIR
 D Q^FBAAVD Q
DA ;display patient auth for selected line item
 W @IOF N FB1,FBDA,FBTYP
 S FBDA=$P(FBX,U,9)
 I $P(FBX,U)="OPT" S FB1=$P(^FBAAC(DFN,1,FBV,1,$P(FBDA,",",3),1,$P(FBDA,",",4),0),U,13) D  Q
 .I FB1']"" S FBPROG=$P(^FBAAC(DFN,1,FBV,1,$P(FBDA,",",3),0),U,4),FBPROG=$S(FBPROG:"I FBI="_FBPROG,1:""),PI="" D ^FBAADEM K FBPROG,FBAUT,PI Q
 .I FB1["583" D UNAUTH Q
 .I FB1["7078" D INP Q
 I $P(FBX,U)="PHAR" S FB1=$P(^FBAA(162.1,+FBDA,"RX",$P(FBDA,",",2),2),U,6) D  Q
 .I FB1']"" S FBPROG=$P($G(^FBAA(162.1,+FBDA,"RX",$P(FBDA,",",2),2)),U,7),FBPROG=$S(FBPROG:"I FBI="_FBPROG,1:""),PI="" D ^FBAADEM K FBPROG,FBAUT,PI Q
 .I FB1["583" D UNAUTH Q
 .I FB1["7078" D INP Q
 I $P(FBX,U)["C" S FB1=$P(^FBAAI(+FBDA,0),U,5) I FB1["583" D UNAUTH Q
INP N DA,FBDA,DIC,DR S (FBDA,DA)=+FB1,DIC="^FB7078(",DR="0;1" W @IOF D EN^DIQ
 I $$DISCH^FBCH780(FBDA)]"" W ?2,"DISCHARGE TYPE: ",$$DISCH^FBCH780(FBDA)
 Q
UNAUTH N DA,DIC,DR S DA=+FB1,DIC="^FB583(",DR="0;1" W @IOF D EN^DIQ
 Q
EV ;expand view
 W @IOF N FBZ S FBZ=$P(FBX,U,9)
 I $P(FBX,U)="OPT" S DIC="^FBAAC("_DFN_",1,"_FBV_",1,"_$P(FBZ,",",3)_",1,",DA(3)=DFN,DA(2)=FBV,DA(1)=$P(FBZ,",",3),DA=$P(FBZ,",",4),DR=""
 I $P(FBX,U)="PHAR" S DIC="^FBAA(162.1,"_+FBZ_",""RX"",",DA(1)=+FBZ,DA=$P(FBZ,",",2),DR=""
 I $P(FBX,U)["C" S DIC="^FBAAI(",DA=FBZ,DR=""
 W @IOF D EN^DIQ
 K DIC,DA,DR
 Q
CP ;change patient
 D CLEAR^VALM1
 N FBCP S VALMBCK="R"
 S DIR(0)="P^161:EMZ",DIR("A")="Payments for veteran" D ^DIR K DIR I $D(DIRUT) Q
 S DFN=+Y,FBCP=1 D HDR^FBPHON,START^FBPHON
 Q
CV ;change vendor
 D CLEAR^VALM1
 N FBCP S VALMBCK="R"
 S DIR(0)="P^161.2:EMZ" D ^DIR K DIR Q:$D(DIRUT)
 S FBV=+Y,FBCP=1 D HDR^FBPHON,START^FBPHON
 Q
DC ;display check
 W @IOF S FBCN=$P(FBX,U,11) I FBCN']"" W !,*7,"No check found for this line item." Q
 D START^FBCKDIS
 Q
CD ;display CPT/MOD description
 W @IOF
 N FBCPT,FBJ,FBMOD,FBMODX
 Q:$P(FBX,U)'="OPT"!($P(FBX,U,3)']"")
 S FBCPT=$P(FBX,U,3) W !,"Line item #",FBI,!?5,"CPT: ",$P(FBCPT,"-"),?18,$P($$CPT^ICPTCOD($P(FBCPT,"-"),$S(+$P(FBX,U,2)>0:+$P(FBX,U,2),1:""),1),U,3)
 I FBCPT["-" F FBJ=1:1 S FBMOD=$P($P(FBCPT,"-",2),",",FBJ) Q:FBMOD=""  D
 . W !?5,"MOD: ",FBMOD
 . S FBMODX=$$MOD^ICPTMOD(FBMOD,"E",$P(FBX,U,2))
 . ; if modifier data not obtained then try another API to resolve it
 . ; since there can be duplicate modifiers with same external value
 . I $P(FBMODX,U)'>0 D
 . . N FBY
 . . S FBY=$$MODP^ICPTMOD($P(FBCPT,"-"),FBMOD,"E",$P(FBX,U,2))
 . . I $P(FBY,U)>0 S FBMODX=$$MOD^ICPTMOD($P(FBY,U),"I",$P(FBX,U,2))
 . W ?18,$S($P(FBMODX,U)>0:$P(FBMODX,U,3),1:"")
 Q
ERR ;
 W !,"No ",$S(FBPR["B":"batch",1:"invoice")," number on file for this entry" Q
