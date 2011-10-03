YSCEN31 ;ALB/ASF-DX SUB PRINT,DRG ;4/27/90  11:35 ;11/19/93 09:28
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
11 ;  11/19/93 - Cannot find any calls to 11, EN2, DXN, or DXD from this
 ;  routine or other routines, templates, or options.  This code to be
 ;  removed in version 6.0...  LJA
 ;
 QUIT  ;11/18/93 - Don't remove code until Version 6.0 / LJA
 S C1=0 F  S C1=$O(^MR(YSDFN,"DX",C1)) Q:'C1  S G1=^(C1,0) D:YSP0+$Y>IOSL WAIT Q:Q3  D DXN W:Y4'?1"I".E !?3,Y1,?10,Y2,?62,Y3," ",$S(Y5="P":"prov.",Y5="R":"r.o.",Y5="H":"by hx.",Y5="V":"ver.",Y5="N":"n.f.",1:"")
 ;
EN2 ;
 QUIT  ;11/18/93 - Don't remove code until Version 6.0 / LJA
 S (C1,G1,N7,N8)=0 F  S C1=$O(^MR(YSDFN,"PDX",C1)) Q:'C1  S N7=^(C1,0) I $P(N7,U,2)'<N8 S G1=N7,N8=+$P(N7,U,2),N7=$P(N7,U,2) S:(N7>N8) G1=^(C1,0)
 W !?3,"PRIMARY DX: " I 'G1 W "NONE",! Q
 S Y1=$P(G1,U),Y1=$P(^DIC(627,Y1,0),U,2),Y3=$P(G1,U,2) D DXD S Y4=$P(G1,U,3),Y4=$P(^VA(200,Y4,0),U)
 W Y1," on ",Y3," by ",Y4,!
 QUIT
 ;
DXN ;
 QUIT  ;11/18/93 - Don't remove code until Version 6.0 / LJA
 S (N7,N8)=0 F  S N7=$O(^MR(YSDFN,"DX",C1,1,N7)) Q:'N7  S G2=^(N7,0) S:G2>N8 G3=G2,N8=+G2
 S Y1=$P(G1,U),Y4=$P(G1,U,2),Y3=+G2,Y5=$P(G2,U,2) S:$D(^DIC(627,Y1,0)) Y1=$P(^(0),U,2),Y2=$E($P(^(0),U),1,50)
DXD ;
 QUIT  ;11/18/93 - Don't remove code until Version 6.0 / LJA
 S Y3=$E(Y3,4,5)_"/"_$E(Y3,6,7)_"/"_$E(Y3,2,3)
 Q
 ;
ENPP ; Called from MENU option YSCENPP
 ;
 S YSPRG=0,YSOPT2="ENPP1^YSCEN31" D MENU G:YSPRG=0 END D A^YSCEN3 G:$G(Y)<1!($G(POP)) END
 I $D(IO("Q")) K IO("Q") S ZTRTN="ENPPQ^YSCEN31",ZTDESC="YS IP ENPP" F ZZ="W1","W2","YSPRG","T6","YSCR","YSWHO","YSPRG3" S ZTSAVE(ZZ)=""
 I  D ^%ZTLOAD W !,$S($D(ZTQUEUED):"QUEUED",1:"Not queued"),$C(7) G END
ENPPQ ;
 K YSOPT1 S YSOPT2="ENPP1^YSCEN31",(P,P1,Q3)=0,YSNOFORM=1 D:T6'="A" L2^YSCEN2 D:T6="A" L1^YSCEN2
 D KILL^%ZTLOAD
END ;
 F ZZ=1:1:18 S X="V"_ZZ K @X
 K A,YSOPT1,YSOPT2,YSPRG,DA,YSDFN,YSPRG3,YSO,T6,YSNOFORM,I0,YSCON,YSLFT,YSCENN D END^YSCEN2 Q
ENPP1 ;
 Q:Q3  S N3="" F  S N3=$O(^UTILITY($J,N3)) Q:N3=""  D PP1 Q:Q3
 Q
PP1 ;
 S YSDFN=0 F  S YSDFN=$O(^UTILITY($J,N3,YSDFN)) Q:'YSDFN!Q3  D KVAR^VADPT S DFN=YSDFN D DEM^VADPT,PID^VADPT,SET,TOP,@("ENCE"_YSPRG) D WAIT^YSCEN1
 Q
MENU ;
 W ! F ZZ=1:1:10 S G=$T(PROG+ZZ) S G3=$P(G,";",4) W !?4,$J(ZZ,2),?9,G3
 R !!,"Select number: ",YSO:DTIME S YSTOUT='$T,YSUOUT=YSO["^" Q:YSTOUT!YSUOUT  I YSO'?1N.N!(YSO>10)!(YSO<1) W !,"Enter number from above list, Prints out pages of data from Patient profile" G MENU
 S YSPRG=$T(PROG+YSO),YSPRG3=$P(YSPRG,";",4),YSPRG=$P(YSPRG,";",3),YSPRG="^"_$P(YSPRG,U,2),YSCENN=1 Q
 Q
SET ;
 S DA=YSDFN F ZZ=0,.11,.111,.13,.21,.211,.24,.15,.3,.311,.31,.321,.32,.33,.331,.34,.362,.36,.52,1010.15 S A(ZZ)="" S:$D(^DPT(DA,ZZ))#10 A(ZZ)=^(ZZ)
 Q
TOP ;
 W @IOF,!?3,"Ward: ",W2,"   Team: ",$S(T6?1N.N:$P(^YSG("SUB",T6,0),U),1:"Unassigned")," ",YSPRG3 S X="NOW",%DT="T" D ^%DT,DD^%DT W:$X>57 ! W ?60,Y,!
 ;W !,"NAME: ",$P(A(0),U),?40,"SSN: ",$P(A(0),U,9),?60,"DOB: " S D=$P(A(0),U,3) W $E(D,4,5),"/",$E(D,6,7),"/",$E(D,2,3) Q
 W !,"NAME: ",VADM(1),?40,"SSN: ",VA("PID"),?60,"DOB: ",$P(VADM(3),U,2)
 Q
PROG ;;
1 ;;EN^YSPP;Identifying data
2 ;;^YSPP1;Next of kin, employment, claim number
3 ;;^YSPP1A;Disability, financial
4 ;;^YSPP2;Military
5 ;;^YSPP4;Inpatient data
6 ;;^YSPP5;Outpatient data
7 ;;^YSPP6;DSM/ICDA9 Diagnosis list
8 ;;^YSPP7;Last physical exam
9 ;;^YSPP8;Problem list, Psychological tests & interviews
10 ;;^YSPP9;Short problem list
 ;
WAIT F I0=1:1:IOSL-$Y-2 W !
 N DTOUT,DUOUT,DIRUT
 S DIR(0)="E" D ^DIR K DIR S Q3=$D(DIRUT) W @IOF
 D H1^YSCEN2 Q
