RMPFDT6 ;DDC/KAW-PATIENT DISPLAY TYPE SPECIFIC MODEL SCREEN [ 03/10/98  1:46 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**Y2K**;JUN 16, 1995
PRTB I CX=1 D
 .W ! W:$D(RMPFEDIT)&$D(CN) "[",CN,"]" W ?42,"Product Group of",!,?4,"Battery Type",?20,"Quantity",?38,"Item Requiring Batteries",?73,"Status"
 .W !,?4,"-------------",?20,"--------",?31,"--------------------------------------",?72,"--------"
 W !,$J(CX,2),". ",$E(RMPFITP,1,16),?20,$J(RMPFQTY,5),?31,RMPFPG,?72,$E(RMPFLIS,1,8)
 Q
PRTD I CX<2 W ! W:$D(RMPFEDIT)&$D(CN) "[",CN,"]" W ?4,"Battery Type",?20,"Quantity",?31,"Status",!,?4,"-------------",?20,"--------",?31,"------"
 W !,$J(CX,2)," ",?4,$E(RMPFITP,1,16),?20,$J(RMPFQTY,8),?31,$E(RMPFLIS,1,6)
 Q
PRTG I CX<2 D HEAD W ?4,"Make",?16,"Model",?27,"Pur By",?35,"Serial #",?45,"Battery",?54,"Acq. Dt.",?64,"Replace SN",?75,"Stat." D LINE1
 W !,$J(CX,2)," ",$E(RMPFMAK,1,7),?11,$E(RMPFITP,1,15),?27,RMPFOB
 W ?34,$E(RMPFSN,1,9),?45,$E(RMPFBAT,1,7)
 W ?53,RMPFACQD
 I $D(RMPFN) S X=0 F K=1:1 S X=$O(RMPFN(X)) Q:'X  D
 .W:CT>0 ! W ?64,$E(RMPFN(X),1,13) S CT=CT+1
 .I CT=0 W ?75,$E(RMPFLIS,1,5) K RMPFLIS
 I $D(RMPFLIS) W ?75,$E(RMPFLIS,1,5)
 Q
PRTW D PRTQ Q
PRTM I CX=1 D
 .W ! W:$D(RMPFEDIT)&$D(CN) "[",CN,"]" W ?9,"Make",?27,"Model",?42,"Quantity",?56,"Components",?72,"Status"
 .W !,?4,"--------------",?20,"--------------------",?42,"--------",?52,"------------------",?72,"-------"
 W !,$J(CX,2),". ",$E(RMPFMAK,1,16),?20,$E(RMPFITP,1,20),?42,$J(RMPFQTY,5)
 S CM="" D COMP^RMPFDT3 W ?52,CM W:$L(CM)>18 !
 W ?72,$E(RMPFLIS,1,8)
 Q
PRTQ I CX<2 W ! W:$D(RMPFEDIT)&($D(CN)) "[",CN,"]" W ?8,"Hearing Aid Accessory",?36,"Quantity",?46,"Status",!,?4,"------------------------------",?36,"--------",?46,"------"
 W !,$J(CX,2)," ",?4,$E(RMPFITP,1,30),?35,$J(RMPFQTY,9),?46,$E(RMPFLIS,1,6)
 Q
PRTX I CX<2 D HEAD W ?6,"Make",?21,"Model",?35,"Component",?47,"Comp Price",?59,"Ear",?64,"Status" S RMPFTOT=0 W !?4,"--------",?14,"-------------------",?35,"----------",?47,"----------",?59,"---",?64,"------"
 W !,$J(CX,2)," ",?4,$E(RMPFMAK,1,8),?14,$E(RMPFITP,1,19)
 S X=0 F K=1:1 S X=$O(RMPFC(X)) Q:'X  S Y=$P(RMPFC(X),U,1) I Y D
 .Q:'$D(^RMPF(791811.2,Y,0))  S S3=^(0)
 .S RMPFCOM=$P(S3,U,3),RMPFCOMC=$J($P(RMPFC(X),U,2),0,2)
 .S RMPFTOT=RMPFTOT+RMPFCOMC
 .W:$X'>0 "(cont.)",!,$J(CX,2),". ",$E(RMPFMAK,1,8),?18,$E(RMPFITP,1,11),?27,$J(RMPFCOST,6)
 .W:CT ! W ?35,$E(RMPFCOM,1,9),?47,$J(RMPFCOMC,10)
 .W:CT=0 ?56,RMPFISDP,?60,$E(RMPFLR,1),?64,$E(RMPFLIS,1,6)
 .S CT=CT+1
 I RMPFSN'="" W !?4,"Serial Number: ",RMPFSN
 I RMPFCERU'="" W:RMPFSN="" ! W:$P(^RMPF(791810,RMPFX,101,RMPFY,90),U,10) ?32,"Re-" W ?33,"Certified: ",RMPFCERD,?57,"By: ",$E(RMPFCERU,1,19)
 Q
PRTN I CX<2 D
 .W !,?5,"Make",?14,"Model",?24,"Serial #",?35,"Iss Date",?45,"Battery",?53,"Type",?58,"Ear",?63,"Replace",?73,"Status"
 .W !?3,"-------",?11,"-----------",?23,"----------",?34,"----------",?45,"-------",?53,"----",?58,"---",?62,"----------",?73,"------"
 W !,$J(CX,2)," ",$E(RMPFMAK,1,7),?11,$E(RMPFITP,1,11),?23,RMPFSN,?34,RMPFISDP,?45,$E(RMPFBAT,1,7),?53,$E(RMPFISRE,1,4),?59,RMPFLR
 I $D(RMPFN) S X=0 F K=1:1 S X=$O(RMPFN(X)) Q:'X  W:CT>0 ! W ?62,$E(RMPFN(X),1,10) W:CT=0 ?73,$E(RMPFLIS,1,6) K RMPFLIS S CT=CT+1
 I $D(RMPFLIS) W ?73,$E(RMPFLIS,1,6)
 Q
PRTT I CX<2 D HEAD W !?5,"Make",?17,"Model",?28,"Serial #",?48,"Type of Loss",?72,"Status",!?3,"---------",?14,"-----------",?27,"----------",?39,"-------------------------------",?72,"------"
 W !,$J(CX,2)," ",$E(RMPFMAK,1,9),?14,$E(RMPFITP,1,11),?27,RMPFSN,?39,RMPFTOL,?72,$E(RMPFLIS,1,6)
 Q
PRTV I CX<2 W !?5,"Make",?19,"Model",?32,"Serial #",?43,"Recover Date",?57,"Ear",?62,"Status",!?3,"---------",?14,"---------------",?31,"----------",?43,"------------",?57,"---",?62,"------"
 W !,$J(CX,2)," ",$E(RMPFMAK,1,9),?14,$E(RMPFITP,1,15),?31,$E(RMPFSN,1,10),?43,RMPFRED,?58,RMPFLR,?62,$E(RMPFLIS,1,6)
 Q
PRTZ I CX<2 W:$D(RMPFEDIT)&$D(CN) "[",CN,"]" D
 .W ?59,"SC/",?70,"Spec"
 .W !?10,"Prosthetic Item",?34,"Qty",?39,"Price",?46,"Typ",?50,"Disabil.",?59,"NSC",?63,"Categ.",?70,"Cat.",?75,"Stat."
 .W !?3,"------------------------------",?34,"---",?38,"-------",?46,"---",?50,"--------",?59,"---",?63,"------",?70,"----",?75,"-----"
 Q:CX=0
 W !,$J(CX,2)," ",$E(RMPFITP,1,30),?34,$J(RMPFQTY,3),?38,$J((RMPFCOST*QT),7,2),?47,RMPFTT,?50,RMPFDIS,?60,RMPFDSN,?63,RMPFPCT,?70,RMPFPSC,?75,$E(RMPFLIS,1,5)
 Q
PRTJ I CX<2 W:$D(RMPFEDIT)&($D(CN)) "[",CN,"]" W !?11,"Prosthetic Item",?37,"Qty",?43,"Price",?51,"Status",!?3,"--------------------------------",?37,"---",?42,"-------",?51,"------"
 Q:CX=0
 W !,$J(CX,2)," ",$E(RMPFITP,1,32),?37,$J(RMPFQTY,3),?42,$J((RMPFCOST*QT),7,2),?51,$E(RMPFLIS,1,6)
 Q
HEAD W ! W:$D(RMPFEDIT)&$D(CN) "[",CN,"]"
 Q
LINE W !?4,"--------",?14,"-----------",?27,"------",?35,"----------",?47,"-------",?56,"--------",?66,"-" W:RMPFHAT'="H" ?69,"-----------"
 Q
LINE1 W !?3,"-------",?11,"---------------",?27,"------",?34,"----------",?45,"-------",?53,"----------",?64,"----------",?75,"-----"
