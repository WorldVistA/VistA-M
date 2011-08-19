SROACTH1 ;B'HAM ISC/SJA - CARDIAC CATH INFO (PAGE 2) ; [ 08/05/04  9:50 AM ]
 ;;3.0; Surgery ;**125**;24 Jun 93
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRSOUT=0 D ^SROAUTL
START G:SRSOUT END
 ;
EDIT N M,I,SRZ,SROFL S SRR=0 S SRPAGE="PAGE: 2 OF 2" D HDR^SROAUTL
 S SROFL=0 D REDO K DA,DIC,DIQ,DR,SRY S SRQ=0
 I SROFL=0 S (DR,SRDR)="361;362.1;362.2;362.3;478;479;480"
 I SROFL=1 S (DR,SRDR)="361;362.1;362.2;362.3"
 S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="IE",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S SRZ=0 F M=1:1 S I=$P(SRDR,";",M)  Q:'I  D
 .D TR,GET
 .S SRZ=SRZ+1,Y=$P(X,";;",2),SRFLD=$P(Y,"^"),(Z,SRZ(SRZ))=$P(Y,"^",2)_"^"_SRFLD,SREXT=SRY(130,SRTN,SRFLD,"E")
 .W:SRZ=1 !,"----- Native Coronaries -----"
 .W:SRZ=5 !!,"If a Re-do, indicate stenosis in graft to:"
 .W !,$J(SRZ,1)_". "_$P(Z,"^")_":",?32,SREXT
 W !! F K=1:1:80 W "-"
 D SEL G:SRR=1 EDIT
 S SRSOUT=1 G END
 Q
SEL S SRSOUT=0 W !!,"Select Cardiac Catheterization and Angiographic Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q:X=""  S:X="a" X="A" I '$D(SRFLG),'$D(SRZ(X)),(X'?1.2N1":"1.2N),X'="A" D HELP S SRR=1 Q
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRZ)!(Y>Z) D HELP S SRR=1 Q
 I X="A" S X="1:"_SRZ
 I X?1.2N1":"1.2N D RANGE S SRR=1 Q
 I $D(SRZ(X)),+X=X S EMILY=X D  S SRR=1
 .I $$LOCK^SROUTL(SRTN) D ONE,UNLOCK^SROUTL(SRTN)
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRZ_") to update an individual item.  (For example,",!,"   enter '1' to update "_$P(SRZ(1),"^")_".)"
 W !!,"3. Enter a range of numbers (1-"_SRZ_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:3' to update items Left main stenosis, ",!,"   LAD Stenosis and Right coronary stenosis.)",!
 I $D(SRFLG) W !,"4. Enter '@' to delete information from all items.",!
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
REDO I $P($G(^SRF(SRTN,206)),"^",15)=0!($P($G(^SRF(SRTN,206)),"^",42)=2) D
 .K DA,DIE,DR S DA=SRTN,DIE=130,DR="478////NS"_";479////NS"_";480////NS" D ^DIE K DA,DIE,DR
 .S SROFL=1
 Q
END W @IOF D ^SRSKILL
 Q
CFA ;;361^Left main stenosis
CFBPA ;;362.1^LAD Stenosis
CFBPB ;;362.2^Right coronary stenosis
CFBPC ;;362.3^Circumflex Stenosis
DGH ;;478^LAD
DGI ;;479^Right coronary
DHJ ;;480^Circumflex
