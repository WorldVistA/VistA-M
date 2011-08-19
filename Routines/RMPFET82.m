RMPFET82 ;DDC/KAW-CANCEL A LINE ITEM [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 ;; input: RMPFX,RMPFHAT,RMPFTYP,RMPFST,RMPFTP,DFN
 ;;output: None
 Q:'$D(RMPFX)  Q:'RMPFX  K RMPFY
START W @IOF,?35,"ACTIVE LINE ITEMS",! D ^RMPFDT2
 D ARRAY^RMPFDT2 S CL=0 K RMPFRE,RMPFCAN
 S X=0 F  S X=$O(RMPFO(X)) Q:'X  D
 .S Y=RMPFO(X) Q:Y=""  S Y=$P($G(^RMPF(791810.2,Y,0)),U,2)
 .I RMPFHAT="C"!(RMPFHAT="I")!(RMPFHAT="X"),Y'="N" S CL=CL+1,RX=X
 .I "BQZWJD"[RMPFHAT,Y="B" S CL=CL+1,RX=X
 I '$D(RMPFO) W !!,"*** NO LINE ITEMS TO CANCEL ***" G EXIT
 I 'CL W !!,$S(RMPFHAT="C"!(RMPFHAT="I")!(RMPFHAT="X"):"*** ALL LINE ITEMS HAVE ALREADY BEEN CANCELED ***",1:"*** NO ITEMS HAVE BEEN BACKORDERED ***") G EXIT
 I CL=1 S RMPFY=RX D SET G EXECUTE
 D ASK1 G END:$D(RMPFOUT),EXECUTE:$D(RMPFCAN)
 D ASK2 G END:$D(RMPFOUT),END:'$D(RMPFCAN)
EXECUTE D APPROV G END:$D(RMPFOUT),END:'$D(RMPFCAN)
 I "CI"[RMPFHAT D ^RMPFET83 G END
 D CANCEL1 G END
EXIT F I=1:1 Q:$Y>21  W !
 W !,"Type <RETURN> to continue." D READ
END K RMPFY,RMPFRE,RMPFCAN,SL,RMPFO,RMPFMD,CL,CX,C Q
ASK1 ;;Ask to cancel multiple items
 ;; input: CL,RMPFO,RMPFX,RMPFY
 ;;output: RMPFCAN
 W !!,"Do you wish to cancel the orders for ",CL," line items? NO// " D READ G END:$D(RMPFOUT)
ASK11 I $D(RMPFQUT) W !!,"Enter a <Y> to cancel all line items",!?5,"an <N> or <RETURN> to select line items to cancel." G ASK1
 S:Y="" Y="N" I "NnYy"'[Y S RMPFQUT="" G ASK11
 G ASK1E:"Yy"'[Y S RMPFY=0
 F  S RMPFY=$O(RMPFO(RMPFY)) Q:'RMPFY  S X=RMPFO(RMPFY) I X,$D(^RMPF(791810.2,X,0)),$P(^(0),U,2)'="N" D SET
 K RMPFO
ASK1E K Y Q
ASK2 ;;Select items to cancel
 ;; input: RMPFMD,RMPFX,RMPFY,RMPFO
 ;;output: RMPFCAN
 W !!,"Select the Number of the item you wish to cancel: "
 D READ G END:$D(RMPFOUT)
ASK21 I $D(RMPFQUT) W !!,"Enter the number to the left of the item you wish to cancel." G ASK2
 G ASK2E:Y="" I '$D(RMPFMD(Y)) S RMPFQUT="" G ASK21
 S RMPFY=RMPFMD(Y) I $D(RMPFCAN(RMPFY)) W !!,"*** ITEM ALREADY SELECTED ***" G ASK2
 S X=RMPFO(RMPFY) I X,$D(^RMPF(791810.2,X,0)),$P(^(0),U,2)="N" K RMPFY W !!,"*** ITEM ALREADY CANCELED ***" G ASK2
 D SET
ASK22 W !!,"Select another? NO// " D READ Q:$D(RMPFOUT)
ASK221 I $D(RMPFQUT) W !!,"Enter a <Y> to select another item to cancel",!?5,"an <N> or <RETURN> to continue" G ASK22
 S:Y="" Y="N" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G ASK221
 G ASK2:"Yy"[Y
ASK2E K Y Q
APPROV ;;Display and ask if selection correct
 ;; input: RMPFCAN
 ;;output: None
 S (CN,RMPFY)=0 F  S RMPFY=$O(RMPFCAN(RMPFY)) Q:'RMPFY  D
 .S RMPFIT=$P(RMPFCAN(RMPFY),U,1),RMPFQTY=$P(RMPFCAN(RMPFY),U,2)
 .W:CN=0 !!,"Item(s) to be canceled: " W:CN ! W ?25,RMPFIT,"  (",RMPFQTY,")" S CN=CN+1
APP1 W !!,"Are you sure you wish to cancel ",$S(CN>1:"these",1:"this")," item",$S(CN>1:"s",1:""),"? NO// "
 D READ G APPROVE:$D(RMPFOUT)
APP11 I $D(RMPFQUT) W !!,"Enter a <Y> to cancel ",$S(CN>1:"these",1:"this")," item(s)",$S(CN>1:"s",1:""),"",!?5,"an <N> or <RETURN> to leave the item",$S(CN>1:"s",1:"")," active in the order." G APP1
 S:Y="" Y="N" S Y=$E(Y,1) I "Yy"'[Y K RMPFCAN
APPROVE K RMPFIT,RMPFQTY,S0,CN,Y Q
CANCEL1 ;;Cancel a line item
 ;; input: RMPFCAN
 ;;output: None
 S (C,DA)=0 F  S DA=$O(RMPFCAN(DA)) G CANCEL1E:'DA D
 .S C=C+1,%DT="T",X="NOW" D ^%DT S TD=Y
 .S RMPFIT=$P(RMPFCAN(DA),U,1),RMPFQTY=$P(RMPFCAN(DA),U,2)
 .W !!,"Item # ",C,": ",RMPFIT,?$X+5,"Quantity: ",RMPFQTY,!
 .S DIE="^RMPF(791810,"_RMPFX_",101,",DA(1)=RMPFX
 .S DR=".15////C;.17////"_TD_";.18///CANCELED;.19////C;.2////1;90.13////"_DUZ_";90.05"
 .D ^DIE
CANCEL1E W !!,"Item",$S(C=1:"",1:"(s)")," CANCELED",!!
 D APPROV1^RMPFEA2
 K C,DA,C,%DT,TD,X,Y,DIE,RMPFIT,RMPFQTY,DR,%X,%Y Q
SET ;;Set up array of items to cancel
 ;; input: RMPFX,RMPFY
 ;;output: RMPFCAN
 S X=$G(^RMPF(791810,RMPFX,101,RMPFY,0))
 S RMPFIT=$P(X,U,1),RMPFQTY=$P(X,U,6) S:'RMPFQTY RMPFQTY=1
 I RMPFIT,$D(^RMPF(791811,RMPFIT,0)) S RMPFIT=$P(^(0),U,1)
 S RMPFCAN(RMPFY)=RMPFIT_U_RMPFQTY
 K X,RMPFIT,RMPFQTY Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
