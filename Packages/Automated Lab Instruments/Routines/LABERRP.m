LABERRP ; SLC/FHS - PRINT OUT LA("ERR" ERROR TRAP
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
EN ;
 I '$O(^LA("ERR",0)) W !!?10,"There is no data in File ",!! Q
 S LAERR0=^LA("ERR"),LAERR=$P(LAERR0,U,4),LANM=$S($D(^LAB(62.4,+$P(LAERR0,U,3),0)):$P(^(0),U),1:$P(LAERR0,U,3)) W !!?25,"There "_$S(LAERR=1:"is ",1:"are "),$P(LAERR0,U,4)," error"_$S(LAERR=1:"",1:"s")_" in the file"
 W !!?5,"The last entry (# ",+LAERR0,") is for ",LANM," instrument "
 I $D(^LA("ERR",+^LA("ERR"),"ZE"))#2 W !?10,^("ZE"),!
SEL ;
 R !?10,"Enter Error Number ",LEN:DTIME G END:'$T!(LEN="")!($E(LEN)="^")
 I $E(LEN)="?"!('$D(^LA("ERR",+LEN))) D QUE K %,END,A,AA,R G EN
 S LEN0=$S($D(^LA("ERR",LEN,0)):^(0),1:0) I 'LEN0 W !!,"Global is corrupeted ",! G EN
 S Y=+LEN0 D DD^LRX D LEN0
ZTSK ;
 W !!?10,"Correct Error ? " S %=1 D YN^DICN I %'=1 K ZTSK G EN
 F A=0:0 R !!?10," Enter Variable or '?' for listing ",A:DTIME Q:'$T!($E(A)="^")!(A="")  D @$S($E(A)="?":"LIST",1:"SHOW")
 G EN
 Q
END ;
 K %,END,A,AA,AZ,B,BB,BBB,LAERR,LAERR0,LANM,LEN,LEN0,R,Y,ZTSK Q
QUE ;
 W:$E(LEN)'="?" !!?5,"Invalid Number "
 W !?20,"Would you like a list " S %=1 D YN^DICN Q:%'=1  W @IOF
 S (END,LEN,A)="" F AA=0:0 S A=$O(^LA("ERR","B",A)) Q:A=""  S LEN="" F AA=0:0 S LEN=$O(^LA("ERR","B",A,LEN)) Q:LEN=""  D WAIT:$Y>20 Q:END  W !?10,"ER # ",LEN,?20,"Instrument ",A
 Q
WAIT ;
 R !!?10,"Press return to continue  '^' to stop ",R:DTIME S:$E(R)="^" END=1 W @IOF
 Q
LEN0 ;
 W @IOF,!!?10,"Instrument ",$P(LEN0,U,5),?45,"Time : ",Y
 W !,"Device : ",$P(LEN0,U,2),?20,"UCI : ",$P(LEN0,U,8),?40,"TASK # : ",$P(LEN0,U,9)
 W !," $ZE : ",^LA("ERR",LEN,"ZE"),!,"$ZR : ",^("ZR") S ZTSK=^("ZTSK")
 Q
SHOW ;
 S AZ=$S(A="$ZE":"LABZE",A="$ZB":"LABZB",A="$ZR":"LABZR",A="B":"LABZB",A="Y":"LABZY",A="X":"LABZX",A="%DT":"LABZDT",A="X1":"LABZX1",A="X2":"LABZX2",A="X3":"LABZX3",1:A) I $D(^%ZTSK(ZTSK,.3,AZ))#2 W !,A_" = "_^(AZ)
 S BB="" F B=0:0 S BB=$O(^%ZTSK(ZTSK,.3,AZ,BB)) Q:BB=""  W:$D(^(BB))#2 !,A_"("_BB_") = "_^(BB) S BBB="" F B=0:0 S BBB=$O(^%ZTSK(ZTSK,.3,AZ,BB,BBB)) Q:BBB=""  W:$D(^(BBB))#2 !,A_"("_BB_")"_BBB_" = "_^(BBB)
 W:'$D(^%ZTSK(ZTSK,.3,AZ)) !,"NOT IN VARIABLE TABLE ",!
 Q
LIST ;
 S (END,B)="" F A=0:0 S B=$O(^%ZTSK(ZTSK,.3,B)) Q:B=""  D:$Y>20 WAIT Q:END  W:$D(^%ZTSK(ZTSK,.3,B))#2 !,B_" = "_^(B) D L1
 Q
L1 S BB="" F A=0:0 S BB=$O(^%ZTSK(ZTSK,.3,B,BB)) Q:BB=""  D:$Y>20 WAIT Q:END  W:$D(^(BB))#2 !,B_"("_BB_") = "_^(BB) D L2
 Q
L2 S BBB="" F A=0:0 S BBB=$O(^%ZTSK(ZTSK,.3,B,BB,BBB)) Q:BBB=""  D:$Y>20 WAIT Q:END  W:$D(^(BBB))#2 !,B_"("_BB_")"_BBB_" = "_^(BBB)
 Q
