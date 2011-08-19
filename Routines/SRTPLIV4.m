SRTPLIV4 ;BIR/SJA - LIVER-RISK ASSESSMENT INFO ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
START Q:SRSOUT  D DISP
 W !!,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" D:'SRNOVA ^SRTPLIV7 D:SRNOVA ^SRTPLIV5 G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?1.2N1":"1.2N D RANGE G START
 I $D(SRAO(X)),+X=X S SREMIL=X D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRX_") to update an individual item.  (For example,",!,"   enter '1' to update Acute or Chronic Encephalopathy)"
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
 S SRHPG="RISK ASSESSMENT INFORMATION",SRPAGE="PAGE: 4 OF "_$S(SRNOVA:7,1:5) D HDR^SRTPUTL
 K DR,SRAO S:'SRNOVA SRDR="86;84;59;60;108;113;114;90;91;78;79;81;82;83;109;110"
 I SRNOVA S SRDR="86;84;147;59;60;113;108;114;90;91;78;79"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
VA I 'SRNOVA D
 .W !,"1.  Acute or Chronic Encephalopathy:",?52,$P(SRAO(1),"^")
 .W !,"2.  Active Infection (for PSC):",?52,$P(SRAO(2),"^")
 .W !,"3.  Diabetic Retinopathy:",?52,$P(SRAO(3),"^")
 .W !,"4.  Diabetic Neuropathy:",?52,$P(SRAO(4),"^")
 .W !,"5.  HIV + (positive):",?52,$P(SRAO(5),"^")
 .W !,"6.  Lung Disease:",?52,$P(SRAO(6),"^")
 .W !,"7.  Renal impairment:",?52,$P(SRAO(7),"^")
 .W !,"8.  Non-Compliance (Med and Diet):",?52,$P(SRAO(8),"^")
 .W !,"9.  On Methadone:",?52,$P(SRAO(9),"^")
 .W !,"10. Porto Pulmonary Hypertension:",?52,$P(SRAO(10),"^")
 .W !,"11. Esophageal and/or Gastric Varices:",?52,$P(SRAO(11),"^")
 .W !,"12. Preop Transplant Skin Malignancy:",?52,$P(SRAO(12),"^")
 .W !,"13. Other Pre-Transplant Malignancy:",?52,$P(SRAO(13),"^")
 .W !,"14. Recipient Substance Abuse:",?52,$P(SRAO(14),"^")
 .W !,"15. Post TX Prophylaxis - CMV/Antiviral Treatment:",?52,$P(SRAO(15),"^")
 .W !,"16. Post TX Prophylaxis - PCP/Antibiotic Treatment:",?52,$P(SRAO(16),"^")
NONVA I SRNOVA D
 .W !,"1.  Acute or Chronic Encephalopathy:",?39,$P(SRAO(1),"^")
 .W !,"2.  Active Infection (for PSC):",?39,$P(SRAO(2),"^")
 .W !,"3.  Diabetes Mellitus:",?39,$P(SRAO(3),"^")
 .W !,"4.  Diabetic Retinopathy:",?39,$P(SRAO(4),"^")
 .W !,"5.  Diabetic Neuropathy:",?39,$P(SRAO(5),"^")
 .W !,"6.  Lung Disease:",?39,$P(SRAO(6),"^")
 .W !,"7.  HIV + (positive):",?39,$P(SRAO(7),"^")
 .W !,"8.  Renal impairment:",?39,$P(SRAO(8),"^")
 .W !,"9.  Non-Compliance (Med and Diet):",?39,$P(SRAO(9),"^")
 .W !,"10. On Methadone:",?39,$P(SRAO(10),"^")
 .W !,"11. Porto Pulmonary Hypertension:",?39,$P(SRAO(11),"^")
 .W !,"12. Esophageal and/or Gastric Varices:",?39,$P(SRAO(12),"^")
 W !!,SRLINE
 Q
