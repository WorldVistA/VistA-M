SROACPM1 ;BIR/SJA - LAB INFO ;05/05/10
 ;;3.0; Surgery ;**125,153,166,174**;24 Jun 93;Build 8
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRSOUT=0 D ^SROAUTL
START G:SRSOUT END K SRA,SRAO D ^SROACPM2,DISP
ASK W !!,"Select Laboratory Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 D CONCC G END
 I X="" D CONCC G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X="A" S X="1:11"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>11)!(Y>Z) D HELP G:SRSOUT END G START
 S SRPAGE="" D HDR^SROAUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S EMILY=X D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (1-11) to update the information in that field.  (For",!,"   example, enter '7' to update Serum Creatinine)"
 W !!,"3. Enter a range of numbers (1-11) separated by a ':' to enter a range of",!,"   information.  (For example, enter '5:7' to update Serum Potassium,",!,"   Serum Bilirubin, and Serum Creatinine)"
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 S SRNOMORE=0,SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 K DR,DIE S DA=SRTN,DR=$P(SRAO(EMILY),"^",3)_"T;"_$P(SRAO(EMILY),"^",4)_"T",DIE=130 D ^DIE S:$D(Y) SRNOMORE=1 K DR
 Q
RET Q:SRSOUT  W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q
DISP N SRX S SRPAGE="PAGE: 1",SRHDR(.5)="PREOPERATIVE LABORATORY RESULTS" D HDR^SROAUTL
 S SRX=$P(SRAO(1),"^") W !," 1. HDL:",?25,$J(SRX,6),?35,$$NORCHK(21,SRX),?38,$P(SRAO(1),"^",2)
 S SRX=$P(SRAO(2),"^") W !," 2. LDL:",?25,$J(SRX,6),?35,$$NORCHK(23,SRX),?38,$P(SRAO(2),"^",2)
 S SRX=$P(SRAO(3),"^") W !," 3. Total Cholesterol:",?25,$J(SRX,6),?35,$$NORCHK(24,SRX),?38,$P(SRAO(3),"^",2)
 S SRX=$P(SRAO(4),"^") W !," 4. Serum Triglyceride:",?25,$J(SRX,6),?35,$$NORCHK(22,SRX),?38,$P(SRAO(4),"^",2)
 S SRX=$P(SRAO(5),"^") W !," 5. Serum Potassium:",?25,$J(SRX,6),?35,$$NORCHK(5,SRX),?38,$P(SRAO(5),"^",2)
 S SRX=$P(SRAO(6),"^") W !," 6. Serum Bilirubin:",?25,$J(SRX,6),?35,$$NORCHK(14,SRX),?38,$P(SRAO(6),"^",2)
 S SRX=$P(SRAO(7),"^") W !," 7. Serum Creatinine:",?25,$J(SRX,6),?35,$$NORCHK(7,SRX),?38,$P(SRAO(7),"^",2)
 S SRX=$P(SRAO(8),"^") W !," 8. Serum Albumin:",?25,$J(SRX,6),?35,$$NORCHK(11,SRX),?38,$P(SRAO(8),"^",2)
 S SRX=$P(SRAO(9),"^") W !," 9. Hemoglobin:",?25,$J(SRX,6),?35,$$NORCHK(1,SRX),?38,$P(SRAO(9),"^",2)
 S SRX=$P(SRAO(10),"^") W !,"10. Hemoglobin A1c:",?25,$J(SRX,6),?35,$$NORCHK(27,SRX),?38,$P(SRAO(10),"^",2)
 S SRX=$P(SRAO(11),"^") W !,"11. BNP:",?25,$J(SRX,6),?35,$$NORCHK(28,SRX),?38,$P(SRAO(11),"^",2)
 W !! F MOE=1:1:80 W "-"
 Q
CONCC ; check for concurrent case and update if one exists
 S SRCON=$P($G(^SRF(SRTN,"CON")),"^") Q:'SRCON
 S SRI="" F  S SRI=$O(SRAO(SRI)) Q:SRI=""  S S1=$P(SRAO(SRI),"^",3),S2=$P(SRAO(SRI),"^",4) K DA,DIC,DIQ,DR,SRY D
 .S DA=SRTN,DR=S1_";"_S2,DIC="^SRF(",DIQ="SRY",DIQ(0)="I" D EN^DIQ1 S P1=SRY(130,SRTN,S1,"I") S:P1="" P1="@" S P2=SRY(130,SRTN,S2,"I") S:P2="" P2="@"
 .K DA,DIE,DR S DA=SRCON,DIE=130,DR=S1_"////"_P1_";"_S2_"////"_P2 D ^DIE K DR
 Q
NORCHK(SRAT,RESULT) ;
 I RESULT']""!(RESULT="NS") Q ""
 N NODE,LOW,HIGH,SRY
 S SRY="" S:"<>"[$E(RESULT) SRY=$E(RESULT),RESULT=$E(RESULT,2,99)
 S NODE=$G(^SRO(139.2,SRAT,2)),LOW=$P(NODE,"^",2),HIGH=$P(NODE,"^",3) Q:LOW']""!(HIGH']"")
 I SRY'="" Q $S(RESULT<(LOW+.01):"L",((RESULT>(HIGH-.01))&(SRY=">")):"H",1:"")
 Q $S(RESULT<LOW:"L",RESULT>HIGH:"H",1:"")
