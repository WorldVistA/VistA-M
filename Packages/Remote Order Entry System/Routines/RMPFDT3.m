RMPFDT3 ;DDC/KAW-DISPLAY TYPE SPECIFIC MODEL SCREENS [ 07/31/98  2:47 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**10,14**;JUN 16, 1995
PRTA ;;Cancel Order
 Q
PRTB ;;
 D PRTB^RMPFDT6 Q
PRTC I CX<2 D HEAD,H1
 S CM=""
 W !,$J(CX,2)," ",$E(RMPFMAK,1,8),?11,$E(RMPFITP,1,12)
 S X=0 F K=1:1 S X=$O(RMPFC(X)) Q:'X  S Y=$P(RMPFC(X),U,1) I Y D
 .Q:'$D(^RMPF(791811.2,Y,0))  S S3=^(0)
 .S RMPFCOM=$P(S3,U,3),RMPFCOMC=$J($P(RMPFC(X),U,2),0,2)
 .I $P(^RMPF(791810,RMPFX,101,RMPFY,0),U,15)="C" S RMPFCOMC=0
 .S RMPFTOT=RMPFTOT+RMPFCOMC,CM=$S(CM="":RMPFCOM,1:CM_","_RMPFCOM)
 .Q
 W ?25,CM W:$L(CM)>16 ! W ?43,$E(RMPFBAT,1,7)
 W ?51,RMPFISDP,?62,$E(RMPFLR,1)
 I $D(RMPFN) S X=0 F K=1:1 S X=$O(RMPFN(X)) Q:'X  D
 .W:CT>0 ! I $D(RMPFBAT2),RMPFBAT2'="",K=2 W ?43,$E(RMPFBAT2,1,7) K RMPFBAT2
 .W ?64,$E(RMPFN(X),1,10) S CT=CT+1
 .I $D(RMPFLIS) W ?75,$E(RMPFLIS,1,5) K RMPFLIS
 I $D(RMPFLIS) W ?75,$E(RMPFLIS,1,5)
 I $D(RMPFBAT2),RMPFBAT2'="" W !?43,$E(RMPFBAT2,1,7)
 I RMPFSN'="" W !?4,"Serial Number: ",RMPFSN
 I RMPFCERU'="" W:RMPFSN="" ! W:$P(^RMPF(791810,RMPFX,101,RMPFY,90),U,10) ?32,"Re-" W ?33,"Certified: ",RMPFCERD,?57,"By: ",$E(RMPFCERU,1,19)
 K K,Y,S3,RMPFCOM,RMPFCOMC Q
H1 W ?4,"Make",?15,"Model",?28,"Component(s)",?43,"Battery",?52,"Iss. Dt.",?62,"E",?64,"Replace SN",?75,"Stat."
LINE W !?3,"-------",?11,"-------------",?25,"-----------------",?43,"-------",?51,"----------",?62,"-",?64,"----------",?75,"-----"
 Q
PRTD D PRTD^RMPFDT6 Q
PRTE I CX<2 D HEAD W ?5,"Replace Serial Number",!?5,"---------------------",!
 Q:'$D(RMPFN)  S X=0 F  S X=$O(RMPFN(X)) Q:'X  D
 .I $D(CY),CX>CY W !
 .W:CT>0 ! W ?5,$E(RMPFN(X),1,21) S CT=CT+1,CY=CX
 Q
PRTF I CX=1 D HEAD W ?27,"Price",?36,"Serial #",?47,"Return Action",!?4,"--------",?14,"-----------",?27,"------",?35,"----------",?47,"-------------"
 W !,$J(CX,2),". ",$E(RMPFMAK,1,8),?14,$E(RMPFITP,1,11),?27,$J(RMPFCOST,6),?35,RMPFSN,?47,RMPFRACT
 Q
PRTG D PRTG^RMPFDT6 Q
PRTH I CX<2 D HEAD W ?5,"Make",?17,"Model",?28,"Pur",?33,"Serial #",?43,"Battery",?52,"Acq. Dt.",?62,"E",?64,"Replace SN",?75,"Stat." D LINE1
 W !,$J(CX,2)," ",$E(RMPFMAK,1,8),?12,$E(RMPFITP,1,15),?28,RMPFOB
 W ?32,$E(RMPFSN,1,9),?43,$E(RMPFBAT,1,7)
 W ?51,RMPFACQD,?62,$E(RMPFLR,1)
 I $D(RMPFN) S X=0 F K=1:1 S X=$O(RMPFN(X)) Q:'X  D
 .W:CT>0 ! W ?64,$E(RMPFN(X),1,11) S CT=CT+1
 .I CT=0 W ?75,$E(RMPFLIS,1,5) K RMPFLIS
 I $D(RMPFLIS) W ?75,$E(RMPFLIS,1,5)
 Q
PRTI D PRTC
 Q
PRTJ D PRTJ^RMPFDT6 Q
PRTL D PRTT Q
PRTM D PRTM^RMPFDT6 Q
PRTN D PRTN^RMPFDT6 Q
PRTO I CX=1 D
 .W ! W:$D(RMPFEDIT)&$D(CN) "[",CN,"]" W ?9,"Make",?27,"Model",?42,"Qty",?51,"Components",?67,"Battery",?76,"Stat"
 .W !,?4,"--------------",?20,"--------------------",?42,"---",?47,"------------------",?67,"-------",?76,"----"
 S CM=""
 W !,$J(CX,2),". ",$E(RMPFMAK,1,16),?20,$E(RMPFITP,1,20),?42,$J(RMPFQTY,3)
 D COMP W ?47,CM W:$L(CM)>18 ! W ?67,$E(RMPFBAT,1,7)
 W ?76,$E(RMPFLIS,1,4)
 Q
PRTP I CX=1 D HEAD W ?27,"Price",?36,"Serial #",!,?4,"--------",?14,"-----------",?27,"------",?35,"----------"
 W !,$J(CX,2),". ",$E(RMPFMAK,1,8),?14,$E(RMPFITP,1,11),?27,$J(RMPFCOST,6),?35,RMPFSN
 Q
PRTQ D PRTQ^RMPFDT6 Q
PRTR I CX<2 D HEAD W ?5,"Make",?17,"Model",?27,"Price",?35,"Quantity",?45,"Status",!?3,"---------",?14,"-----------",?27,"------",?35,"--------",?45,"------"
 W !,$J(CX,2)," ",$E(RMPFMAK,1,9),?14,$E(RMPFITP,1,11),?27,$J(RMPFCOST,6),?35,$J(RMPFQTY,8),?45,$E(RMPFLIS,1,6)
 Q
PRTS I CX<2 D HEAD W ?4,"Make",?14,"Model",?25,"Price",?33,"Serial #",?43,"Battery",?52,"Iss. Dt.",?62,"E",?64,"Replace SN",?75,"Stat." D LINE2
 W !,$J(CX,2)," ",$E(RMPFMAK,1,7),?11,$E(RMPFITP,1,12),?24,$J(RMPFCOST,7)
 W ?32,$E(RMPFSN,1,10),?43,$E(RMPFBAT,1,7)
 W ?51,RMPFISDP,?62,$E(RMPFLR,1)
 I $D(RMPFN) S X=0 F K=1:1 S X=$O(RMPFN(X)) Q:'X  D
 .W:CT>0 ! I $D(RMPFBAT2),RMPFBAT2'="",K=2 W ?45,$E(RMPFBAT2,1,7) K RMPFBAT2
 .W ?64,$E(RMPFN(X),1,10) S CT=CT+1
 .I CT=0 W ?75,$E(RMPFLIS,1,5) K RMPFLIS
 I $D(RMPFLIS) W ?75,$E(RMPFLIS,1,5)
 I $D(RMPFBAT2),RMPFBAT2'="" W !?45,$E(RMPFBAT2,1,7)
 Q
PRTT D PRTT^RMPFDT6 Q
PRTU I CX=1 D
 .D HEAD
 .W ?5,"Make",?15,"Model",?24,"Price",?31,"Ear",?36,"Returned",?46,"Status",?60,"Cancel Reason"
 .W !?3,"--------",?12,"-----------",?24,"------",?31,"---",?35,"----------",?46,"------",?53,"---------------------------"
 W !,$J(CX,2)," ",$E(RMPFMAK,1,8),?12,$E(RMPFITP,1,11),?24,$J(RMPFCOST,6),?32,RMPFLR,?35,RMPFRDC,?46,$E(RMPFLIS,1,6),?53,$E(RMPFCUR,1,27)
 Q
PRTV D PRTV^RMPFDT6 Q
PRTW D PRTW^RMPFDT6 Q
PRTX D PRTX^RMPFDT6 Q
PRTZ D PRTZ^RMPFDT6 Q
HEAD W ! W:$D(RMPFEDIT)&$D(CN) "[",CN,"]"
 Q
 W:RMPFHAT="Z"!(RMPFHAT="C")!(RMPFHAT="I") ?75,"-----"
 Q
LINE1 W !?3,"--------",?12,"---------------",?28,"---",?32,"----------",?43,"-------",?51,"----------",?62,"-",?64,"----------",?75,"-----" Q
LINE2 W !?3,"-------",?11,"------------",?24,"-------",?32,"----------",?43,"-------",?51,"----------",?62,"-",?64,"----------",?75,"-----" Q
COMP S X=0 F K=1:1 S X=$O(RMPFC(X)) Q:'X  S Y=$P(RMPFC(X),U,1) I Y D
 .Q:'$D(^RMPF(791811.2,Y,0))  S S3=^(0)
 .S RMPFCOM=$P(S3,U,3),RMPFCOMC=$J($P(RMPFC(X),U,2),0,2)
 .I $P(^RMPF(791810,RMPFX,101,RMPFY,0),U,15)="C" S RMPFCOMC=0
 .S RMPFTOT=RMPFTOT+RMPFCOMC,CM=$S(CM="":RMPFCOM,1:CM_","_RMPFCOM)
 Q
