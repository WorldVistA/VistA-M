DVBHSVER ;ALB/JLU;This is the print for the verification screen ; 8/23/05 11:04am
 ;;4.0;HINQ;**7,21,23,49**;03/25/92 
 N Y
 ;Gets info from patient file.
 K DVBDIQ,DVBX(1)
 S DIC="^DPT(",DA=DFN,DIQ(0)="E",DIQ="DVBDIQ("
 I $D(X(1)) S DVBX(1)=X(1)
 S DR=".01;.02;.09;.111:.113;.301:.303;.3014;.313;.361;.3611;.3612;.3615;391;1901"
 D EN^DIQ1
 I $D(DVBX(1)) S X(1)=DVBX(1) K DVBX(1)
 ;
 W ?23 W "****** HINQ Upload/edit ******"
 W !,?35,DVBON,"<<0>>",DVBOFF
 W !,?26,"Verification screen only"
 W !!,?9,"Patient file"
 ;with DVB*4*49 the value of DVBCAP will no longer be checked
 W DVBON,"            VBA ",$S($P(^DVB(395.5,DFN,0),U,5)="Y":"UPDATED",1:"NOT UPDATED"),DVBOFF,"   " X DVBLIT1
 W ?50,"HINQ Response"
 W !,"--------------------------------------------------------------------------------"
 I $D(DVBBAS(2)) I $P(DVBBAS(2),U,35)!($P(DVBBAS(2),U,36))!($P(DVBBAS(2),U,37))!($P(DVBBAS(2),U,38)) D BAD
 I $D(DVBP(6)),$P(DVBP(6),U) S M=$E(DVBP(6),1,2) D MM^DVBHQM11 W !,?11,$C(7),$C(7),DVBON,"** VBA indicates Patient is deceased.  ",M_" "_$S(+$E(DVBP(6),3,4)>0:$E(DVBP(6),3,4)_", ",1:" ")_$E(DVBP(6),5,8)," **",DVBOFF
 ;all records are type "A" after DVB*4*49, so instead of checking
 ;record type check if there are SC disabilities, but no VA check
 I $G(DVBCHECK)'>0,($G(DVBDXNO)'>0) W:$D(M) ! W ?8,$C(7),DVBON,"** NO Monetary Benefits - Means Test Required **",DVBOFF
 W !,?3,DVBON,"Name: ",DVBOFF,DVBDIQ(2,DFN,.01,"E") X DVBLIT1 W ?49,$S($D(DVBADR(1)):DVBADR(1),$D(DVBNAME):$E(DVBNAME,1,30),1:"")
 ;
 W !,?4,DVBON,"Sex: ",DVBOFF,DVBDIQ(2,DFN,.02,"E") X DVBLIT1
 I $D(DVBVET),$P(DVBVET,U,1)'="C" W ?49,$S($P(DVBVET,U,3)="M":"MALE",$P(DVBVET,U,3)="F":"FEMALE",1:"")
 E  I $D(DVBBIR) W ?49,$S($P(DVBBIR,U,25)="M":"MALE",$P(DVBBIR,U,25)="F":"FEMALE",1:"")
 W !,?4,DVBON,"SSN: ",DVBOFF,DVBDIQ(2,DFN,.09,"E") X DVBLIT1
 S (B,C)=0
 I $D(DVBP(6)) S C=$P(DVBP(6),U,3),B=1
 I $D(DVBP(1)) S C=$P(DVBP(1),U,8)
 I C S C=$S(C=1:" Verified SSA",C=2:" Verified VBA",C=4:" Verified by BIRLS",C=9:" SSA Verified No Number Exists",C=0:" Unverified",C=3:" Not Required, Child Under 2",1:" "_C)
 I $D(DVBREF),$P(DVBREF,U,1)?9N D:$P(DVBREF,U,1)'=$P(^DPT(D0,0),U,9) SS W ?49,$P(DVBREF,U,1) W:C]"" ?60,DVBON,$E(C,2,99),DVBOFF X DVBLIT1 K C
 I $P($G(DVBREF),U)'?9N I $D(DVBSSN),DVBSSN?9N W ! D:DVBSSN'=$P(^DPT(D0,0),U,9) SS W ?49,DVBSSN W:B ?60,DVBON,$E(C,2,99),DVBOFF X DVBLIT1 K C
 W !,DVBON,"Claim #: ",DVBOFF,DVBDIQ(2,DFN,.313,"E") X DVBLIT1
 I $D(DVBCN),DVBCN W ?49,DVBCN
 W !,DVBON,"Address: ",DVBOFF,DVBDIQ(2,DFN,.111,"E") X DVBLIT1 I $D(DVBADR(1)) W ?49,DVBADR(1)
 W !,?9,DVBDIQ(2,DFN,.112,"E") I $D(DVBADR(2)) W ?49,DVBADR(2)
 W !,?9,DVBDIQ(2,DFN,.113,"E") I $D(DVBADR(3)) W ?49,DVBADR(3)
 W !!,?2,DVBON,"Pat. Type: ",DVBOFF,DVBDIQ(2,DFN,391,"E") X DVBLIT1
 W ?45,DVBON,"Elig. Stat.: ",DVBOFF,$E(DVBDIQ(2,DFN,.3611,"E"),1,20)
 W !,?3,DVBON,"Vet. Y/N: ",DVBOFF,DVBDIQ(2,DFN,1901,"E") X DVBLIT1
 W ?46,DVBON,"Stat. Date: ",DVBOFF,DVBDIQ(2,DFN,.3612,"E")
 W !,?2,DVBON,"Ser. Con.: ",DVBOFF,DVBDIQ(2,DFN,.301,"E") X DVBLIT1
 W ?44,DVBON,"Verif. Meth.: ",DVBOFF,DVBDIQ(2,DFN,.3615,"E")
 W !,DVBON,"Ser. Con. %: ",DVBOFF,DVBDIQ(2,DFN,.302,"E") X DVBLIT1
 W ?35,DVBON,"Eff. Date Comb. Eval.:",DVBOFF,DVBDIQ(2,DFN,.3014,"E")
 W !,?1,DVBON,"Elig. code: ",DVBOFF,DVBDIQ(2,DFN,.361,"E")
 Q
 ;
 ;
SS W ?46,DVBON,DVBBLO,"-->",DVBBLF,DVBOFF X DVBLIT2,DVBLIT1
 Q
 ;
BAD S T1="WARNING: Error Indicators for " F N=38:-1:35 I $P(DVBBAS(2),U,N) S T1=T1_" "_$S(N=38:"BASIC",N=37:"STATISTICAL",N=36:"DIAGNOSTIC",N=35:"FUTURE",1:"")_","
 W !,DVBON,DVBBLO,"  ***",DVBOFF,DVBBLF,$E(T1,1,$L(T1)-1),DVBON,DVBBLO,"***",DVBOFF,DVBBLF
 Q
