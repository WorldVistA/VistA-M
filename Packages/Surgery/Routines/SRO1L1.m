SRO1L1 ;BIR/ADM - UPDATE 1-LINER CASE, CONTINUED ;02/14/07
 ;;3.0; Surgery ;**86,88,100,129,142,153,160**;24 Jun 93;Build 7
 S SRSOUT=0,SRSUPCPT=2 D NCODE^SROAUTL
 N SRLCK,SRCSTAT S SRLCK=$$LOCK^SROUTL(SRTN) I 'SRLCK Q
 D SRA^SROES
EDIT S SRA=$G(^SRF(SRTN,"RA")) I $P(SRA,"^",2)="N",$P(SRA,"^",6)="N",$P(SRA,"^",7)'="" D ^SROAEX,END Q
 S SRCSTAT=">> Coding "_$S($P($G(^SRO(136,SRTN,10)),"^"):"",1:"Not ")_"Complete <<"
 S SRR=0 D TSTAT,HDR^SROAUTL D TECH^SROPRIN
 S X=$P(^SRF(SRTN,"OP"),"^",2) I X S Y=$P($$CPT^ICPTCOD(X),"^",2) D SSPRIN^SROCPT S SRCPT=Y
 S SRQ=0,SRDR=".011;.04;.035;.166;1.09;1.13"
 S SRAO(1)="In/Out-Patient Status^.011",SRAO(2)="Major or Minor^.03",SRAO(2)="Surgical Specialty^.04",SRAO(3)="Surgical Priority^.035",SRAO(4)="Attending Code^.166"
 S SRAO(5)="ASA Class^1.13",SRAO(6)="Wound Classification^1.09",SRAO(7)="Anesthesia Technique^.37",SRAO(8)="CPT Codes (view only)^",SRAO(9)="Other Procedures^.42"
 K DA,DIC,DIQ,DR,SRY S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S SRY(130,SRTN,.37,"E")=SRTECH,SRY(130,SRTN,.42,"E")=$S($O(^SRF(SRTN,13,0)):"***INFORMATION ENTERED***",1:"***NONE ENTERED***"),SRY(130,SRTN,27,"E")=SRCPT
 F I=1:1:9 W !,$J(I,2)_". "_$P(SRAO(I),"^")_":" D
 .I I=8 D PROC Q
 .S SREXT(1)=SRY(130,SRTN,$P(SRAO(I),"^",2),"E") I $L(SREXT(1))>48 D
 ..N I,J,X,Y S X=SREXT(1) F I=0:1:47 S J=48-I,Y=$E(X,J) I Y=" " S SREXT(1)=$E(X,1,J-1),SREXT(2)=$E(X,J+1,$L(X)) Q
 .W ?32,SREXT(1) W:$D(SREXT(2)) !,?32,SREXT(2) K SREXT
 W !! F I=1:1:80 W "-"
 S SRX=9 D SEL
 K DA,DIK S DIK="^SRF(",DIK(1)=".232^AQ",DA=SRTN D EN1^DIK K DA,DIK
 G:SRR=1 EDIT
END D EXIT^SROES D:$G(SRLCK) UNLOCK^SROUTL(SRTN)
 Q
PROC N I,SRPROC,SRL S SRL=48 D CPTS^SROAUTL0
 F I=1:1 Q:'$D(SRPROC(I))  W:I=1 ?32,SRPROC(I) W:I'=1 !,?32,SRPROC(I)
 Q
SEL W !!,"Select number of item to edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q:X=""  S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP S SRR=1 Q
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP S SRR=1 Q
 I X="A" S X="1:"_SRX
 I X?1.2N1":"1.2N D RANGE S SRR=1 Q
 I $D(SRAO(X)) S EMILY=X W !! D ONE S SRR=1
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit. Examples of proper"
 W !,"responses are listed below.",!!,"1. Enter 'A' to update all items."
 W !!,"2. Enter a number (1-"_SRX_") to update an individual item. (For example,"
 W !,"   enter '1' to update "_$P(SRAO(1),"^")_")"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range"
 W !,"   of items. (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
PRESS W ! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 I EMILY=7 D UPANES Q
 I EMILY=8 D DISP^SROAUTL0 Q
 I EMILY=9 D ^SROTHER Q
 K DR,DIE S DA=SRTN,DR=$P(SRAO(EMILY),"^",2)_"T",DIE=130 D ^DIE K DR I $D(Y) S SRSOUT=1
 Q
UPANES K DR,DIE,DA S DA=SRTN,DR=.37,DR(2,130.06)=".01T;.05T;42T",DIE=130 D ^DIE K DR
 Q
TSTAT ; transmission status
 N SR905 S SR905=$P($G(^SRF(SRTN,.4)),"^",2)
 S SRHDR(.5)="Transmission Status: "_$S(SR905="T":"TRANSMITTED",SR905="R":"QUEUED TO TRANSMIT",1:"NOT QUEUED")
 Q
