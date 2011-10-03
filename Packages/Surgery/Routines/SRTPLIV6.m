SRTPLIV6 ;BIR/SJA - LIVER-OUTCOME INFORMATION ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 N SRX,SRY,SRZ
START Q:SRSOUT  D DISP
 W !!,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" D:(SRNOVA&($P(SR("RA"),"^",2)="LI")) ^SRTPLIV7 G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?1.2N1":"1.2N D RANGE G START
 I $D(SRAO(X)),+X=X S SREMIL=X D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRX_") to update the information in that field.  (For example,",!,"   enter '1' to update Bleeding/Transfusions)"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
PRESS W ! K DIR S DIR("A")="Press the return key to continue or '^' to exit: ",DIR(0)="FOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 S SRNOMORE=0,SRSHEMP=$P(X,":"),SRCURL=$P(X,":",2) F SREMIL=SRSHEMP:1:SRCURL Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 K DR,DIE S DA=SRTPP,DR=$P(SRAO(SREMIL),"^",2)_"T",DIE=139.5 D ^DIE K DR I $D(Y) S SRNOMORE=1
 Q
DISP ; display fields
 S SRHPG="OUTCOME INFORMATION",SRPAGE="PAGE: "_$S(SRNOVA:"6",1:"")_" OF "_$S(SRNOVA:7,1:"")
 I $P(SR("RA"),"^",2)="LU" S SRPAGE="PAGE: "_$S(SRNOVA:"4",1:"")_" OF "_$S(SRNOVA:5,1:"")
 D HDR^SRTPUTL
 K DR,SRAO S (DR,SRDR)="116;117;118;119;192;121;122;123;124;125;126;193"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 D OUTNO
 W !,"1.  Bleeding/Transfusions:",?33,$P(SRAO(1),"^")
 W !,"2.  Pneumonia:",?33,$P(SRAO(2),"^")
 W !,"3.  On Ventilator >48 hours:",?33,$P(SRAO(3),"^")
 W !,"4.  Cardiac Arrest Req. CPR:",?33,$P(SRAO(4),"^")
 W !,"5.  Myocardial Infarction:",?33,$P(SRAO(5),"^")
 W !,"6.  Stroke/CVA:",?33,$P(SRAO(6),"^")
 W !,"7.  Coma >= 24 hr:",?33,$P(SRAO(7),"^")
 W !,"8.  Superficial Incisional SSI:",?33,$P(SRAO(8),"^")
 W !,"9.  Deep Incisional SSI:",?33,$P(SRAO(9),"^")
 W !,"10. Systemic Sepsis:",?33,$P(SRAO(10),"^")
 W !,"11. Return to Surgery < 30 Days:",?33,$P(SRAO(11),"^")
 W !,"12. Death within 30 Days:",?33,$P(SRAO(12),"^")
 W !!,SRLINE
 Q
OUTNO ; defualt empty outcome fields to "NO"
 K DA,DIE,DR S DR=""
 S II=0 F  S II=$O(SRAO(II)) Q:'II  S:$P(SRAO(II),"^")="" DR=$S(DR]"":(DR_";"_$P(SRDR,";",II)),1:$P(SRDR,";",II))_"////N"
 S DIE=139.5,DA=SRTPP D ^DIE K DA,DIE,DR
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 Q
