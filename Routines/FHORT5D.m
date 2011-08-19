FHORT5D ; HISC/REL/NCA/RVD - Tubefeeding Reports (cont) ;5/4/93  10:52 
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
CST ; Print Cost Report for Tubefeeding
 S NAM="" F  S NAM=$O(^FH(118.2,"B",NAM)) Q:NAM=""  F LL=0:0 S LL=$O(^FH(118.2,"B",NAM,LL)) Q:LL<1  S ^TMP($J,"P",NAM_"~"_LL)=LL
 I SUM S CNOD="0" D C2 Q
 S CNOD="0" F  S CNOD=$O(^TMP($J,"C",CNOD)) Q:CNOD=""  D C2
 Q
C2 S D2=0,NAM="" D HD4 S X0=$G(^TMP($J,"C",CNOD,0))
 F  S NAM=$O(^TMP($J,"P",NAM)) Q:NAM=""  S LL=^(NAM) I $D(^TMP($J,"C",CNOD,LL)) S X1=$G(^(LL,0)),TU=$P(X1,"^",1),TP=$P(X1,"^",2) D
 .I $Y>(IOSL-8) D HD4
 .S Y0=^FH(118.2,LL,0),TU=TU+.95\1,PR=$P($G(^FH(114,+$P(Y0,"^",7),0)),"^",13),D2=TU*PR+D2
 .W !,$P(Y0,"^",1),?31,$J($S(TP:TP,1:0),5),?41,$P(Y0,"^",2),?53,$J(TU,5),?62,$J(PR,7,2),?72,$J(TU*PR,7,2) Q
 W !!,"Total: ",?71,$J(D2,8,2),!!!,"No. of Patients on TF: ",?33,$J($P(X0,"^",1),6)
 W !,"No. of Patients on TF and Tray: ",?33,$J($P(X0,"^",2),6),!,"No. of Patients on TF and SF: ",?33,$J($P(X0,"^",3),6)
 W !,"No. of Patients on ALL Three: ",?33,$J($P(X0,"^",4),6),!,"Cost/Patient: ",?33 S X=$P(X0,"^",1) W $J($S(X:D2/X,1:""),6,2),! Q
LAB ; Print Labels
 S LAB=$P($G(^FH(119.9,1,"D",IOS,0)),"^",2) S:'LAB LAB=1 S S1=$S(LAB=1:6,1:9),S2=LAB=2*5+33
 S COUNT=0,LINE=1
 S TNOD="" F  S TNOD=$O(^TMP($J,"T",TNOD)) Q:TNOD=""  D L1
 I LAB>2 D DPLL^FHLABEL Q
 W !!!!!!!!!!!!!!!!!! Q
L1 S PNOD="" F  S PNOD=$O(^TMP($J,"T",TNOD,PNOD)) Q:PNOD=""  S X0=^(PNOD,0) D L2
 Q
L2 S NAM=$P(X0,"^",1),WARD=$P(X0,"^",3),RM=$P(X0,"^",4),X3=3
 F TF2=0:0 S TF2=$O(^TMP($J,"T",TNOD,PNOD,TF2)) Q:'TF2  S X1=^(TF2,0),X3=X3+3 D L3
 Q
L3 S Y0=$P(X1,"^",1),STR=$P(X1,"^",7),Y1="" I STR<4 S Y1=$S(STR=1:"1/4",STR=2:"1/2",1:"3/4")_" Str, "
 S Y1=Y1_$P(X1,"^",8),Y0=Y0_", "_$S('MUL:$P(X1,"^",6),1:1)_" "_$P(X1,"^",2) I 'MUL,$P(X1,"^",6)>1 S Y0=Y0_"S"
 I LAB>2 D LL Q
 I 'MUL D LHDR W !,Y0,!,Y1,! W:LAB=2 !!! Q
 F X2=1:1:+$P(X1,"^",6) D LHDR W !,Y0,!,Y1,! W:LAB=2 !!!
 Q
LHDR ; Label Header
 W !,NAM,?(S2-$L(WARD)),WARD,!,$P(X0,"^",2),?8,$E(DTP,1,9),?(S2-$L(RM)),RM,! Q
HD4 ; Cost Report Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !,$E(DTP,1,9),?17,"T U B E F E E D I N G   C O S T   R E P O R T",?73,"Page ",PG
 S Y=$S(SUM:"CONSOLIDATED",1:$P(CNOD,"~",2)) W !!?(80-$L(Y)\2),Y
 W !!,"Product",?30,"# Patient",?41,"Unit",?53,"# Units",?62,"Cost/Unit",?74,"Total",! Q
 Q
LL ;
 S FHCOL=$S(LAB=3:3,1:2)
 I LABSTART>1 F FHLABST=1:1:(LABSTART-1)*FHCOL D  S LABSTART=1
 .I LAB=3 S (PCL1,PCL2,PCL3,PCL4,PCL5,PCL6)="" D LL3^FHLABEL
 .I LAB=4 S (PCL1,PCL2,PCL3,PCL4,PCL5,PCL6,PCL7,PCL8)="" D LL4^FHLABEL
 .Q
 S FHTAB=$S(LAB=3:24,1:37)
 S NAM=$E(NAM,1,FHTAB-$L(WARD)),X02P=$P(X0,U,2),DTP=$E(DTP,1,9)
 S X0DTP=X02P_$E("        ",1,7-$L(X02P))_DTP
 S LNA=NAM_$J(WARD,FHTAB+1-$L(NAM))
 S LNB=X0DTP_$J($E(RM,1,8),FHTAB+1-$L(X0DTP))
 I 'MUL D LLB Q
 I MUL F X2=1:1:+$P(X1,"^",6) D LLB
 Q
LLB ;
 S FHST=$S(LAB=3:25,1:38)
 S FHN=FHST F CN=FHST:-1:FHST-5 S Y0X=$E(Y0,CN) I Y0X="," S FHN=CN Q
 I LAB=3 S PCL1="",PCL2=LNA,PCL3=LNB,PCL4=$E(Y0,1,FHN),PCL5=$E(Y0,FHN+1,99),PCL6=Y1
 I LAB=4 S (PCL1,PCL2,PCL8)="",PCL3=LNA,PCL4=LNB,PCL5=$E(Y0,1,FHN),PCL6=$E(Y0,FHN+1,99),PCL7=Y1
 D:LAB=3 LL3^FHLABEL D:LAB=4 LL4^FHLABEL
 Q
