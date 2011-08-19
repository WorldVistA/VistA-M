SRTPLIV2 ;BIR/SJA - LIVER-DIAGNOSIS INFORMATION ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
START Q:SRSOUT  D DISP
 W !!,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" D ^SRTPLIV3 G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?1.2N1":"1.2N D RANGE G START
 I $D(SRAO(X)),+X=X S SREMIL=X D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRX_") to update an individual item.  (For example,",!,"   enter '1' to update Acute Liver Failure"_")"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 I $D(SRFLG) W !,"4. Enter 'N' or 'NO' to enter negative response for all items.",!!,"5. Enter '@' to delete information from all items.",!
PRESS W ! K DIR S DIR("A")="Press the return key to continue or '^' to exit: ",DIR(0)="FOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 S SRNOMORE=0,SRSHEMP=$P(X,":"),SRCURL=$P(X,":",2) F SREMIL=SRSHEMP:1:SRCURL Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 K DR,DIE S DA=SRTPP,DR=$P(SRAO(SREMIL),"^",2)_"T",DIE=139.5 D ^DIE K DR I $D(Y) S SRNOMORE=1
 Q
DISP ; display fields
 S SRHPG="DIAGNOSIS INFORMATION",SRPAGE="PAGE: 2 OF "_$S(SRNOVA:7,1:5) D HDR^SRTPUTL
 K SRAO,DR S (DR,SRDR)="21;20;23;99;100;101;27;28;29;30;102;34;35;38;105;39;106;107;47;56;111;120;127;94"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"1.  Acute Liver Failure:",?33,$P(SRAO(1),"^"),?39,"14. Primary Biliary Cholangitis:",?75,$P(SRAO(14),"^")
 W !,"2.  Acetaminophen Toxicity:",?33,$P(SRAO(2),"^"),?39,"15. Primary Non-Function:",?75,$P(SRAO(15),"^")
 W !,"3.  Alcoholic Cirrhosis:",?33,$P(SRAO(3),"^"),?39,"16. Primary Sclerosing Cholangitis:",?75,$P(SRAO(16),"^")
 W !,"4.  Autoimmune Hepatitis:",?33,$P(SRAO(4),"^"),?39,"17. Second Sclerosing Cholangitis:",?75,$P(SRAO(17),"^")
 W !,"5.  Cryptogenic Cirrhosis:",?33,$P(SRAO(5),"^"),?39,"18. Toxic Exposure:",?75,$P(SRAO(18),"^")
 W !,"6.  Chronic Rejection:",?33,$P(SRAO(6),"^"),?39,"19. Biliary Stricture:",?75,$P(SRAO(19),"^")
 W !,"7.  Graft Failure:",?33,$P(SRAO(7),"^"),?39,"20. Bile Leak:",?75,$P(SRAO(20),"^")
 W !,"8.  HBV Cirrhosis (Hepatitis B):",?33,$P(SRAO(8),"^"),?39,"21. Portal Vein Thrombosis:",?75,$P(SRAO(21),"^")
 W !,"9.  HCC (Hepatocellular CA):",?33,$P(SRAO(9),"^"),?39,"22. Psychosis:",?75,$P(SRAO(22),"^")
 W !,"10. HCV Cirrhosis (Hepatitis C):",?33,$P(SRAO(10),"^"),?39,"23. Seizures:",?75,$P(SRAO(23),"^")
 W !,"11. Hepatic Artery Thrombosis:",?33,$P(SRAO(11),"^"),?39,"24. Rejection:",?75,$P(SRAO(24),"^")
 W !,"12. Metabolic:",?33,$P(SRAO(12),"^")
 W !,"13. NASH:",?33,$P(SRAO(13),"^")
 W !!,SRLINE Q
