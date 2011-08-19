SRTPKID6 ;BIR/SJA - PANCREAS INFORMATION ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
START Q:SRSOUT  D DISP
 W !!,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?1.2N1":"1.2N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?1.2N1":"1.2N D RANGE G START
 I $D(SRAO(X)),+X=X S SREMIL=X D ONE G START
END D:'SRSOUT ^SRTPCOM W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRX_") to update the information in that field.  (For example,",!,"   enter '1' to update Pancreas (SPK/PAK))"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 W ! K DIR S DIR("A")="Press the return key to continue or '^' to exit: ",DIR(0)="FOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 S SRNOMORE=0,SRSHEMP=$P(X,":"),SRCURL=$P(X,":",2) F SREMIL=SRSHEMP:1:SRCURL Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 K DR,DIE S DA=SRTPP,DR=$P(SRAO(SREMIL),"^",2)_"T",DIE=139.5 D ^DIE K DR I $D(Y) S SRNOMORE=1
 Q
DISP ; display fields
 S SRHPG="PANCREAS INFORMATION",SRPAGE="PAGE: "_$S(SRNOVA:"6",1:"5")_" OF "_$S(SRNOVA:6,1:5) D HDR^SRTPUTL
 K DR,SRAO S (DR,SRDR)="134;135;136;137;138;139;140;141;142"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"1. Pancreas (SPK/PAK):",?35,$P(SRAO(1),"^")
 W !,"2. Glucose at Time of Listing: ",?35,$$NS($P(SRAO(2),"^"))
 W !,"3. C-peptide at Time of Listing:",?35,$$NS($P(SRAO(3),"^"))
 W !,"4. Pancreatic Duct Anastomosis:",?35,$P(SRAO(4),"^")
 W !,"5. Glucose Post Transplant:",?35,$$NS($P(SRAO(5),"^"))
 W !,"6. Amylase Post Transplant: ",?35,$$NS($P(SRAO(6),"^"))
 W !,"7. Lipase Post Transplant:",?35,$$NS($P(SRAO(7),"^"))
 W !,"8. Insulin Req Post transplant:",?35,$P(SRAO(8),"^")
 W !,"9. Oral Hypoglycemics Req Post-TX:",?35,$P(SRAO(9),"^")
 W !!,SRLINE
 Q
NS(SRF) ;
 Q $S(SRF="NS":"NO STUDY",1:SRF)
