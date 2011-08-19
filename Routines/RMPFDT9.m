RMPFDT9 ;DDC/KAW-EXTENDED DISPLAY FOR ROES ORDER [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 ;; input: RMPFX
 ;;output: None
 S DFN=$P(^RMPF(791810,RMPFX,0),U,4) G END:'DFN D PAT^RMPFUTL
 D HEAD,SET,DISP,CONT:'$D(ZTSK)
END K DFN,RMPFNAM,RMPFSSN,RMPFDOB,RMPFDOD,X,Y,I,RMPFOUT,RMPFQUT,%XX,%YY
 K ZTSK Q
SET ;; input: RMPFX
 ;;output: EC,ED,EE,ET,EU,SE
 S SX=$G(^RMPF(791810,RMPFX,2)),SS=$P(SX,U,2)
 S EB=$P(SX,U,4),EU=$S('EB&SS:"DETERMINED FROM DATABASE BY ROES",'EB:"",1:$P(SX,U,3))
 I EU,$D(^VA(200,EU,0)) S EU=$P(^(0),U,1)
 S ED=$P(SX,U,5) I ED S Y=ED D DD^%DT S ED=Y
 S SE=$P(SX,U,6) I SE,$D(^RMPF(791810.4,SE,0)) S SE=$P(^(0),U,1)
 S EE=$P(SX,U,7) I EE,$D(^VA(200,EE,0)) S EE=$P(^(0),U,1)
 S ET=$P(SX,U,8) I ET S Y=ET D DD^%DT S ET=Y
 S EC=$P(SX,U,9),SX=$G(^RMPF(791810,RMPFX,10))
 K EB,SX,SS Q
DISP ;; input: EC,ED,EE,ET,EU,SE
 ;;output: None
 W !!,"Eligibility Entered By: ",EU
 W !!,"Eligibility Entered On: ",ED
 W:EC'="" !!?10,"PSAS Comment: ",EC
 I SE'="" D
 .W !!!?4,"ASPS Proposed Elig: ",SE
 .W !!?6,"Elig Proposed By: ",EE
 .W !!?4,"Request to PSAS On: ",ET
 I IOST?1"P-".E W @IOF
 D:$D(IO("S")) ^%ZISC
 K EC,ED,EE,ET,EU,SE Q
HEAD W:'$D(ZTSK) @IOF W !?24,"ROES ORDER EXTENDED INFORMATION"
 I $D(RMPFNAM) W !,"Patient: ",$E(RMPFNAM,1,25),?35,"SSN: ",RMPFSSN,?68,RMPFDAT
 W ! F I=1:1:80 W "-"
 Q
CONT F I=1:1 Q:$Y>20  W !
 W !,"Type <RETURN> to continue" W:RMPFMENU=0 ", <L>ine Item View" W " or <P>rint: " D READ
 Q:$D(RMPFOUT)
C1 I $D(RMPFQUT) D  G CONT
 .W !!,"Enter "
 .W:RMPFMENU=0 "an <L> to go to the extended line item view",!?6
 .W "a <P> to print this screen or",!?6,"<RETURN> to exit."
 Q:Y=""  S Y=$E(Y,1) I "LlPp"'[Y S RMPFQUT="" G CONT
 I "Pp"[Y D QUE Q
 I "Ll"[Y,RMPFMENU=0 D ^RMPFDT10 Q
 Q
QUE W ! S %ZIS="NPQ" D ^%ZIS G END:POP
 I IO=IO(0),'$D(IO("S")) D ^RMPFDT9 G QUEE
 I $D(IO("S")) S %ZIS="",IOP=ION D ^%ZIS G ^RMPFDT9
 S ZTRTN="^RMPFDT9",ZTSAVE("RMPF*")=""
 S ZTIO=ION D ^%ZTLOAD
 D HOME^%ZIS S RMPFOUT=""
 W:$D(ZTSK) !!,"*** Request Queued ***" H 1
QUEE K %T,%ZIS,POP,ZTRTN,ZTSAVE,ZTIO,ZTSK Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
