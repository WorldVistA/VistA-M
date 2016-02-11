SROACPM0 ;BIR/SJA - CARDIAC RESOURCE INFO ;05/05/15
 ;;3.0;Surgery;**184**;24 Jun 93;Build 35
 ;
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRSOUT=0 D ^SROAUTL
START G:SRSOUT END
 ;
EDIT N DAYS,HOURS,MINS
 S SRR=0 S SRPAGE="PAGE: 2 OF 2" D HDR^SROAUTL K DR S SRQ=0,(DR,SRDR)="670;671;673;674;677"
 K DA,DIC,DIQ,SRY S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="IE",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 K SRZ S SRZ=0 F M=1:1 S I=$P(SRDR,";",M)  Q:'I  D
 .D TR,GET
 .S SRZ=SRZ+1,Y=$P(X,";;",2),SRFLD=$P(Y,"^"),(Z,SRZ(SRZ))=$P(Y,"^",2)_"^"_SRFLD,SREXT=SRY(130,SRTN,SRFLD,"E")
 .W:M>1 ! W $J(SRZ,2)_". "_$P(Z,"^")_": " D EXT
 W !! F K=1:1:80 W "-"
 D SEL G:SRR=1 EDIT
 S SRSOUT=1 G END
 Q
EXT ;
 W ?39,$E(SREXT,1,40)
 Q
SEL S SRSOUT=0 W !,"Select Resource Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q:X=""  S:X="a" X="A" I '$D(SRFLG),'$D(SRZ(X)),(X'?1.2N1":"1.2N),X'="A" D HELP S SRR=1 Q
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRZ)!(Y>Z) D HELP S SRR=1 Q
 I X="A" S X="1:"_SRZ
 I X?1.2N1":"1.2N D RANGE S SRR=1 Q
 I $D(SRZ(X)),+X=X S EMILY=X D  S SRR=1
 .I $$LOCK^SROUTL(SRTN) D ONE,UNLOCK^SROUTL(SRTN)
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRZ_") to update an individual item.  (For example,",!,"   enter '1' to update "_$P(SRZ(1),"^")_".)"
 W !!,"3. Enter a range of numbers (1-"_SRZ_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 I $D(SRFLG) W !,"4. Enter 'N' or 'NO' to enter negative response for all items.",!!,"5. Enter '@' to delete information from all items.",!
PRESS W ! K DIR S DIR("A")="Press the return key to continue or '^' to exit: ",DIR(0)="FOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 K DR,DA,DIE S DR=$P(SRZ(EMILY),"^",2)_"T",DA=SRTN,DIE=130,SRDT=$P(SRZ(EMILY),"^",3) S:SRDT DR=DR_";"_SRDT_"T" D ^DIE K DR,DA I $D(Y) S SRSOUT=1
 Q
TR S J=I,J=$TR(J,"1234567890.","ABCDEFGHIJP")
 Q
GET S X=$T(@J)
 Q
END W @IOF D ^SRSKILL
 Q
FGJ ;;670^Current Residence
FGA ;;671^Ambulation Device
FGC ;;673^History of Cancer
FGD ;;674^History of Radiation Therapy
FGG ;;677^Num of Prior Surg in Same OP
