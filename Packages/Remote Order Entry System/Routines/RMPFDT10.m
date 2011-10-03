RMPFDT10 ;DDC/KAW-LINE ITEM EXTENDED INFORMATION [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 ;; input: RMPFX
 ;;output: None
 S DFN=$P(^RMPF(791810,RMPFX,0),U,4) G END:'DFN D PAT^RMPFUTL K RMPFY
 D SEL G END:$D(RMPFOUT),END:'$D(RMPFY)
SHOW D HEAD,SET,DISP
 I IOST?1"C-".E D CONT G RMPFDT10:RMPFCT>1
 I IOST?1"P-".E W @IOF
 D:$D(IO("S")) ^%ZISC
END K DFN,RMPFNAM,RMPFSSN,RMPFDOB,RMPFDOD,X,Y,I,RMPFOUT,RMPFQUT,%XX,%YY
 K RMPFMD,RMPFO,RMPFTYP,RMPFHAT,ZTSK,XX,CX,RMPFY,CT,RR,RMPFCT
 Q
SET ;; input: RMPFX,RMPFY
 ;;output: None
 S SX=$G(^RMPF(791810,RMPFX,101,RMPFY,90))
 S AU=$P(SX,U,1) I AU,$D(^VA(200,AU,0)) S AU=$P(^(0),U,1)
 S AD=$P(SX,U,2) I AD S Y=AD D DD^%DT S AD=Y
 S AR=$P(SX,U,3),AM=$P(SX,U,4)
 S CR=$P(SX,U,5),DR=$P(SX,U,6) I DR S Y=DR D DD^%DT S DR=Y
 S UC=$P(SX,U,13) I UC,$D(^VA(200,UC,0)) S UC=$P(^(0),U,1)
 S SD=$P(SX,U,7) I SD S Y=SD D DD^%DT S SD=Y
 S CU=$P(SX,U,8) I CU,$D(^VA(200,CU,0)) S CU=$P(^(0),U,1)
 S CD=$P(SX,U,9) I CD S Y=CD D DD^%DT S CD=Y
 S RC=$P(SX,U,10) I RC,$D(^VA(200,RC,0)) S RC=$P(^(0),U,1)
 S RD=$P(SX,U,11) I RD S Y=RD D DD^%DT S RD=Y
 S IU=$P(SX,U,12) I IU,$D(^VA(200,IU,0)) S IU=$P(^(0),U,1)
 S OD=$P(SX,U,14) I OD,$D(^RMPF(791810.6,OD,0)) S OD=$P(^(0),U,1)
 I OD="OTHER",$P(SX,U,15)'="" S OD=$P(SX,U,15)
 S SX=$G(^RMPF(791810,RMPFX,101,RMPFY,2)),RR=$P(SX,U,7)
 K SX Q
DISP ;; input: AU,AD,AR,AM,CR,DR,SD,CU,CD,RC,RD,IU,UC,OD
 ;;output: None
 S XX=$Y G DI1:AU=""
 W !!,"User Making Last Adjustment: ",AU
 W !?4,"Date of Last Adjustment: ",AD
 W !?6,"Reason for Adjustment: ",AR
 W !?9,"Adjustment Message: ",AM
DI1 G DI2:UC=""&(CR="") W !!?16,"Canceled By: ",UC
 W:CR'="" !?14,"Cancel Reason: ",CR
DI2 W:DR'="" !?4,"Date Returned to Vendor: ",DR
 W:SD'="" !?18,"Ship Date: ",SD
 G DI3:CU=""
 W !!?15,"Certified By: ",CU
 W !?9,"Certification Date: ",CD
 W !?12,"Re-certified By: ",RC
 W !?6,"Re-certification Date: ",RD
DI3 W:IU'="" !?18,"Issued By: ",IU
 W:OD'="" !?11,"Reason for Delay: ",OD
 W:RR'="" !?4,"Reason for Registration: ",RR
 I $Y=XX W !!?9,"*** NO ADDITIONAL INFORMATION AVAILABLE FOR THIS LINE ITEM ***"
 K AU,AD,AR,AM,CR,DR,SD,CU,CD,IU,RD,RC,UC,XX,OD Q
SEL D ARRAY^RMPFDT2 S (RMPFCT,X)=0 F  S X=$O(RMPFO(X)) Q:'X  S RMPFY=X,RMPFCT=RMPFCT+1
 Q:RMPFCT=1
 S RMPFTYP=$P(^RMPF(791810,RMPFX,0),U,2),RMPFHAT=""
 I RMPFTYP,$D(^RMPF(791810.1,RMPFTYP,0)) S RMPFHAT=$P(^(0),U,2)
 W @IOF,!?33,"ITEMS ORDERED" D @("HEADP"_"^RMPFDT1")
 D ^RMPFDT2
S1 F  Q:$Y>21  W !
 W !,"Select number of a line item or <RETURN> to continue: " D READ
 Q:$D(RMPFOUT)
S2 I $D(RMPFQUT) W !!,"Select a number from the left of the display to choose a line item or",!,"<RETURN> to exit from the display." G S1
 Q:Y=""  I '$D(RMPFMD(Y)) S RMPFQUT="" G S2
 S RMPFY=RMPFMD(Y) Q
 Q
HEAD W:'$D(ZTSK) @IOF W !?22,"ROES LINE ITEM EXTENDED INFORMATION"
 I $D(RMPFNAM) W !,"Patient: ",$E(RMPFNAM,1,25),?35,"SSN: ",RMPFSSN,?68,RMPFDAT
 W ! F I=1:1:80 W "-"
 W ! Q
CONT F I=1:1 Q:$Y>20  W !
 W !,"Type <RETURN> to continue, <P>rint or <^> to exit: " D READ
 Q:$D(RMPFOUT)  G CONT:$D(RMPFQUT)
 D QUE:Y="P"
 Q
QUE W ! S %ZIS="NPQ" D ^%ZIS G END:POP
 I IO=IO(0),'$D(IO("S")) D SHOW^RMPFDT10 G QUEE
 I $D(IO("S")) S %ZIS="",IOP=ION D ^%ZIS G SHOW^RMPFDT10
 S ZTRTN="SHOW^RMPFDT10",ZTSAVE("RMPF*")="",ZTSAVE("DFN")=""
 S ZTIO=ION D ^%ZTLOAD
 D HOME^%ZIS S RMPFOUT=""
 W:$D(ZTSK) !!,"*** Request Queued ***" H 1
QUEE K %T,%ZIS,POP,ZTRTN,ZTSAVE,ZTIO,ZTSK Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
 K ZTSK Q
