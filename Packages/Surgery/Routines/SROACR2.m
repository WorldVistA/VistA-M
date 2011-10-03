SROACR2 ;BIR/SJA - OPERATIVE DATA, PAGE 2 ;12/03/07
 ;;3.0; Surgery ;**125,153,160,166**;24 Jun 93;Build 6
 ;
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRSOUT=0 D ^SROAUTL
START G:SRSOUT END
 ;
EDIT S SRR=0 S SRPAGE="PAGE: 2 OF 2" D HDR^SROAUTL W "Indicate other cardiac procedures only if done with cardiopulmonary bypass",! F K=1:1:80 W "-"
 ;
 K DR S SRQ=0,(DR,SRDR)="381;382;451;450;468;469"
 K DA,DIC,DIQ,SRY S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="IE",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 K SRX S SRX=0 F M=1:1 S I=$P(SRDR,";",M)  Q:'I  D
 .K SREXT D TR,GET
 .S SRX=SRX+1,Y=$P(X,";;",2),SRFLD=$P(Y,"^"),(Z,SRX(SRX))=$P(Y,"^",2)_"^"_SRFLD,SREXT=SRY(130,SRTN,SRFLD,"E")
 .I SRFLD=451 W !,"Other Operative Data details:",!,"------------------------------"
 .W !,$J(SRX,2)_". "_$P(Z,"^")_":" D EXT
 .W:SRFLD=382 !
 D CHCK W ! F K=1:1:80 W "-"
 D SEL G:SRR=1 EDIT
 S SRSOUT=1 G END
 Q
SEL S SRSOUT=0 W !!,"Select Cardiac Procedures Operative Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q:X=""  S:X="a" X="A" I '$D(SRFLG),'$D(SRX(X)),(X'?1.2N1":"1.2N),X'="A" D HELP S SRR=1 Q
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP S SRR=1 Q
 I X="A" S X="1:"_SRX
 I X?1.2N1":"1.2N D RANGE S SRR=1 K SREXT Q
 I $D(SRX(X)),+X=X S EMILY=X D  S SRR=1
 .I $$LOCK^SROUTL(SRTN) W ! D ONE,UNLOCK^SROUTL(SRTN)
 Q
EXT W ?30,SREXT
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (1-6) to update the information in that field.  (For",!,"   example, enter '5' to update Incision Type.)"
 W !!,"3. Enter a range of numbers (1-6) separated by a ':' to enter a range of",!,"   information.  (For example, enter '3:5' to enter Total CPB time,",!,"   Total Ischemic time, and Incision Type.)"
 D RET
 Q
CHCK ; compare ischemic time to CPB time
 I '$D(IORVON) S X="IORVON;IORVOFF" D ENDR^%ZISS
 N SRISCH,SRCPB S SRISCH=SRY(130,SRTN,450,"E"),SRCPB=SRY(130,SRTN,451,"E")
 I SRISCH,SRCPB,SRISCH>SRCPB W !,IORVON_"***  NOTE: Ischemic Time is greater than CPB Time!!  Please check.  ***"_IORVOFF
 Q
RET Q:SRSOUT  W ! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .W ! S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 K DR,DA,DIE S DR=$P(SRX(EMILY),"^",2)_"T",DA=SRTN,DIE=130,SRDT=$P(SRX(EMILY),"^",3) S:SRDT DR=DR_";"_SRDT_"T" D ^DIE K DR,DA I $D(Y) S SRSOUT=1
 I EMILY=3,$P($G(^SRF(SRTN,206)),"^",37)>0,($P($G(^SRF(SRTN,207)),"^",27)=1) S $P(^SRF(SRTN,207),"^",27)=5
 Q
TR S J=I,J=$TR(J,"1234567890.","ABCDEFGHIJP")
 Q
GET S X=$T(@J)
 Q
END W @IOF D ^SRSKILL
 Q
CHA ;;381^Foreign Body Removal
CHB ;;382^Pericardiectomy
DEA ;;451^Total CPB Time
DEJ ;;450^Total Ischemic Time
DFH ;;468^Incision Type
DFI ;;469^Convert Off Pump to CPB
