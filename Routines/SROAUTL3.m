SROAUTL3 ;BIR/ADM - RISK ASSESSMENT UTILITY ;01/07/08
 ;;3.0; Surgery ;**38,47,63,77,142,163,166**;24 Jun 93;Build 6
 ;
 ; Reference to ^DIC(45.3 supported by DBIA #218
 ;
 Q
RISK ; allow entry of risk assessment preop information with case request
 S Y=$P(^SRO(133,SRSITE,0),"^",14) I 'Y Q
 W ! K DIR S DIR("A")="Enter risk assessment preop information for this patient (Y/N)",DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y Q
 S SREQST=1,SRCARD=0 I $$CARD^SROAUTLC S SRSP=$P(^DIC(45.3,$P(^SRO(137.45,$P(^SRF(SRTN,0),"^",4),0),"^",2),0),"^") I SRSP=48!(SRSP=58) D  I SRCARD Q
 .S SRCARD=1 W ! K DIR S DIR("A")="Will this procedure require cardiopulmonary bypass (Y/N) ? ",DIR(0)="YA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q
 .I 'Y S SRCARD=0 Q
 .D CARD S SRCARD=1
 I 'SRCARD D ^SROAPRE
 Q
CARD ; allow input of cardiac risk assessment preop information
 N SRSDATE,SRNM,SRSOUT
 W @IOF,!,"Enter Cardiac Preoperative information",!!,"  1. Clinical Information",!,"  2. Cardiac Catheterization & Angiographic Data",!,"  3. Operative Risk Summary Data",!
 K DIR S DIR(0)="NO^1:3:0",DIR("?")="Enter the number of the selection to be edited." D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y Q
 I Y=1 D ^SROACLN G CARD
 I Y=2 D ^SROACAT G CARD
 D ^SROACOP G CARD
 Q
PREOP ; print preop information (managerial)
 W:$E(IOST)="P" !! D PREOP^SROAUTL0 S SRDR=DR W !,?28,"PREOPERATIVE INFORMATION",! S SRQ=1 D OUT
 Q
OUT K DA,DIC,DIQ,SRY S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 K SRX S SRX=0 F M=1:1 S I=$P(SRDR,";",M) Q:'I  D
 .Q:I=413  D TR D:SRQ GET^SROAUTL1 D:'SRQ GET^SROAUTL2
 .S SRX=SRX+1,Y=$P(X,";;",2),SRFLD=$P(Y,"^"),(Z,SRX(SRX))=$S($P(Y,"^",3)'="":$P(Y,"^",3),1:$P(Y,"^",2))_"^"_SRFLD
 .W !,$J($P(Z,"^")_": ",39) S SREXT=SRY(130,SRTN,SRFLD,"E") D EXT
 Q
EXT I SRFLD=27 S SREXT=$S(SREXT="":"MISSING",1:$E(SREXT,1,5))
 I $L(SREXT)<40 W SREXT Q
 N I,J,X,Y S X=SREXT F  D  W:$L(X) ! I $L(X)<40!(X'[" ") W ?40,X Q
 .F I=0:1:38 S J=39-I,Y=$E(X,J) I Y=" " W ?40,$E(X,1,J-1) S X=$E(X,J+1,$L(X)) Q
 Q
LAB ; print preoperative laboratory test information (managerial)
 W !,?20,"PREOPERATIVE LABORATORY TEST INFORMATION",!
 D LR^SROAUTL0 S SRDR=DR K DA,DIC,DIQ,SRY S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 K SRX S SRX=0 F M=1:2 S L=$P(SRDR,";",M) Q:'L  S I=L D
 .D TR D GET^SROAUTL2 S SRX=SRX+1,Y=$P(X,";;",2),SRFLD=$P(Y,"^"),SRDT=$P(Y,"^",4),(Z,SRX(SRX))=$S($P(Y,"^",3)'="":$P(Y,"^",3),1:$P(Y,"^",2))_"^"_SRFLD_"^"_SRDT
 .W !,$J($P(Z,"^")_": ",39),SRY(130,SRTN,SRFLD,"E") W:SRY(130,SRTN,SRDT,"E")'="" ?50,"("_$P(SRY(130,SRTN,SRDT,"E"),"@")_")"
 Q
TR S J=I,J=$TR(J,"1234567890.","ABCDEFGHIJP")
 Q
NON S DR=".03;102;.035"
 Q
CHK ; check for missing information for excluded cases
 K SRX,DA,DIC,DIQ,DR,SRY S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="I" D NON D EN^DIQ1 D ^SROAUTL2
 K DA,DIC,DIQ,DR,SRY,SRZ D TECH^SROPRIN I SRTECH="NOT ENTERED" S SRX("ANESTHESIA TECHNIQUE")="Anesthesia Technique"
 Q
