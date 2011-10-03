SRTPKID1 ;BIR/SJA - KIDNEY-RECIPIENT INFORMATION ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRSOUT=0,$P(SRLINE,"-",80)="" D SRHDR^SRTPUTL
START Q:SRSOUT  D DISP
 W !,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" D ^SRTPKID2 G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S SREMIL=X W !! D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (1-"_SRX_") to update the information in that field.  (For",!,"   example, enter '1' to update VACO ID.)"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 W !! S SRNOMORE=0,SRSHEMP=$P(X,":"),SRCURL=$P(X,":",2) F SREMIL=SRSHEMP:1:SRCURL Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 K DR,DIE S DA=SRTPP,DR=$P(SRAO(SREMIL),"^",2)_"T",DIE=139.5 D ^DIE K DR I $D(Y) S SRNOMORE=1 Q
 I $P(SRAO(SREMIL),"^",2)=1!($P(SRAO(SREMIL),"^",2)=3) D SRHDR^SRTPUTL
 Q
DISP ; display fields
 S SRPAGE="PAGE: 1 OF "_$S(SRNOVA:6,1:5),SRHPG="RECIPIENT INFORMATION" D HDR^SRTPUTL
 K SRAO,DR S SRDR=$S(SRNOVA:"3;1;11;187;10;12;4;5;96;26;27;95;97;33;19;98;37;42;94",1:"3;11;187;10;12;96;26;27;95;97;33;19;98;37;42;94")
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
VA I 'SRNOVA D   W !,SRLINE Q
 .W "1.  VACO ID:",?30,$P(SRAO(1),"^")
 .W !,"2.  Date Placed on Waiting:",?30,$P(SRAO(2),"^")
 .W !,"3.  Date Started Dialysis:",?30,$P(SRAO(3),"^")
 .W !,"4.  Recipient ABO Blood Type:",?30,$P(SRAO(4),"^")
 .W !,"5.  Recipient CMV:",?30,$P(SRAO(5),"^")
 .W !!,"Diagnosis Information",!,"======================"
 .W !,"6.  Calcineurin Inhibitor Toxicity:",?36,$P(SRAO(6),"^"),?41,"13. Obstructive Uropathy from BPH:",?76,$P(SRAO(13),"^")
 .W !,"7.  Glomerular Sclerosis/Nephritis:",?36,$P(SRAO(7),"^"),?41,"14. Polycistic Disease:",?76,$P(SRAO(14),"^")
 .W !,"8.  Graft Failure:",?36,$P(SRAO(8),"^"),?41,"15. Renal Cancer:",?76,$P(SRAO(15),"^")
 .W !,"9.  IgA Nephropathy:",?36,$P(SRAO(9),"^"),?41,"16. Rejection:",?76,$P(SRAO(16),"^")
 .W !,"10. Lithium Toxicity:",?36,$P(SRAO(10),"^")
 .W !,"11. Membranous Nephropathy:",?36,$P(SRAO(11),"^")
 .W !!,"12. Transplant Comments: " S SREXT=$P(SRAO(12),"^") D COMM^SRTPLIV1
NONVA I SRNOVA D
 .W "1.  VACO ID:",?30,$P(SRAO(1),"^"),?47,"6. Recipient CMV:",?68,$P(SRAO(6),"^")
 .D HW^SRTPUTL
 .S SRAO(7)=$$OUT^SRTPLUN1(4,$P(^SRT(SRTPP,0),"^",4))_"^4"
 .S Y=$P(SRAO(2),"^") X ^DD("DD") W !,"2.  Date of Transplant:",?30,Y,?47,"7. Recipient Height: ",$P(SRAO(7),"^")
 .S SRAO(8)=$$OUT^SRTPLUN1(5,$P(^SRT(SRTPP,0),"^",5))_"^5"
 .W !,"3.  Date Placed on Waiting:",?30,$P(SRAO(3),"^"),?47,"8. Recipient Weight: ",$P(SRAO(8),"^")
 .W !,"4.  Date Started Dialysis: ",?30,$P(SRAO(4),"^")
 .W !,"5.  Recipient ABO Blood Type:",?30,$P(SRAO(5),"^")
 .W !!,"Diagnosis Information",!,"======================"
 .W !,"9.  Calcineurin Inhibitor Toxicity:",?36,$P(SRAO(9),"^"),?41,"16. Obstructive Uropathy from BPH:",?76,$P(SRAO(16),"^")
 .W !,"10. Glomerular Sclerosis/Nephritis:",?36,$P(SRAO(10),"^"),?41,"17. Polycistic Disease:",?76,$P(SRAO(17),"^")
 .W !,"11. Graft Failure:",?36,$P(SRAO(11),"^"),?41,"18. Renal Cancer:",?76,$P(SRAO(18),"^")
 .W !,"12. IgA Nephropathy:",?36,$P(SRAO(12),"^"),?41,"19. Rejection:",?76,$P(SRAO(19),"^")
 .W !,"13. Lithium Toxicity:",?36,$P(SRAO(13),"^")
 .W !,"14. Membranous Nephropathy:",?36,$P(SRAO(14),"^")
 .W !!,"15. Transplant Comments: " S SREXT=$P(SRAO(15),"^") D COMM^SRTPLIV1
 W !,SRLINE Q
