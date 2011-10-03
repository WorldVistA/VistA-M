SROAOP2 ;BIR/ADM - OPERATION INFO, PAGE 2 ; [ 04/13/04  12:35 PM ]
 ;;3.0; Surgery ;**81,88,100,125**;24 Jun 93
 ; called from SROAOP
EDIT Q:SRSOUT  S SRHDR(.5)=SRDOC,SRPAGE="PAGE: 2 OF 2" D HDR^SROAUTL
 K DR S SRQ=0,(DR,SRDR)=".205;.22;.23;.232;.21;.24;1.18"
 K DA,DIC,DIQ,SRY S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 K SRX S SRX=0 F M=1:1 S I=$P(SRDR,";",M)  Q:'I  D
 .D TR,GET
 .S SRX=SRX+1,Y=$P(X,";;",2),SRFLD=$P(Y,"^"),(Z,SRX(SRX))=$P(Y,"^",2)_"^"_SRFLD,SREXT=SRY(130,SRTN,SRFLD,"E")
 .W !,SRX_". "_$P(Z,"^")_":" D EXT
 W !! F K=1:1:80 W "-"
 D SEL G EDIT
 Q
EXT I SREXT["@" S X=$P(SREXT,"@")_"  "_$P(SREXT,"@",2),SREXT=X
 W ?39,SREXT
 Q
SEL W !!,"Select Operative Information to Edit: " R X:DTIME I '$T!(X["^")!(X="") S SRSOUT=1 Q
 S:X="a" X="A" I '$D(SRFLG),'$D(SRX(X)),(X'?1.2N1":"1.2N),X'="A" D HELP Q
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP Q
 I X="A" S X="1:"_SRX
 I X?1.2N1":"1.2N D RANGE Q
 I $D(SRX(X)),+X=X S EMILY=X D
 .I $$LOCK^SROUTL(SRTN) D ONE,UNLOCK^SROUTL(SRTN)
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRX_") to update an individual item.  (For example,",!,"   enter '1' to update "_$P(SRX(1),"^")_")"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 I $D(SRFLG) W !,"4. Enter 'N' or 'NO' to enter negative response for all items.",!!,"5. Enter '@' to delete information from all items.",!
PRESS W ! K DIR S DIR("A")="Press the return key to continue or '^' to exit: ",DIR(0)="FOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 N SRW
 W ! K DA,DIR S DA=SRTN,DIR(0)="130,"_$P(SRX(EMILY),"^",2),DIR("A")=$P(SRX(EMILY),"^") D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 S SRW=Y K DR,DA,DIE S DR=$P(SRX(EMILY),"^",2)_"////"_SRW,DA=SRTN,DIE=130 D ^DIE K DR,DA
 Q
TR S J=I,J=$TR(J,"1234567890.","ABCDEFGHIJP")
 Q
GET S X=$T(@J)
 Q
PBJE ;;.205^Patient in Room (PIR)
PBB ;;.22^Procedure/Surgery Start Time (PST)
PBC ;;.23^Procedure/Surgery Finish (PF)
PBCB ;;.232^Patient Out of Room (POR)
PBA ;;.21^Anesthesia Start (AS)
PBD ;;.24^Anesthesia Finish (AF)
APAH ;;1.18^Discharge from PACU (DPACU)
