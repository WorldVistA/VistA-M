DGPTC2 ;ALN/MJK - Census Record Processing; jAN 27,2005
 ;;5.3;Registration;**58,189,643**;Aug 13, 1993
 ;
SETP ; -- P node processing
 ;I DGCSUF="9AA"!(DGCSUF="BU") S I=999 G SETPQ
 G SETPQ:X<DGBEG!(X>DGEND) S ^DGPT(DGCI,"P",I,0)=X
 S:'$D(^DGPT(DGCI,"P",0)) ^(0)="^45.05D^^" S X=^(0),^(0)=$P(X,U,1,2)_"^"_I_"^"_($P(X,U,4)+1)
SETPQ Q
 ;
SETS ; -- S node processing
 D GETSUFF
 I $G(DGSFLAG) S I=999 G SETSQ
 G SETSQ:X<DGBEG!(X>DGEND) S ^DGPT(DGCI,"S",I,0)=X
 S:'$D(^DGPT(DGCI,"S",0)) ^(0)="^45.01D^^" S X=^(0),^(0)=$P(X,U,1,2)_"^"_I_"^"_($P(X,U,4)+1)
SETSQ K DGSFLAG Q
 ;
SET535 ; -- 535 node processing
 D GETSUFF
 I '$P(X,U,7),$G(DGSFLAG) G SET535Q
 I $P(X,U,7) D CONE G SET535Q
 G SET535Q:$P(X,U,10)<DGBEG!($P(X,U,10)>DGEND) S ^DGPT(DGCI,535,I,0)=X
 S:'$D(^DGPT(DGCI,535,0)) ^(0)="^45.0535^^" S X=^(0),^(0)=$P(X,U,1,2)_"^"_I_"^"_($P(X,U,4)+1)
SET535Q K DGSFLAG Q
 ;
SETM ; -- M node processing
 D GETSUFF
 I I'=1,$G(DGSFLAG) S I=999 G SETMQ
 I I=1 D ONE G SETMQ
 G SETMQ:($P(X,U,10)<DGBEG)!($P(X,U,10)>DGEND) S ^DGPT(DGCI,"M",I,0)=X
 S:'$D(^DGPT(DGCI,"M",0)) ^(0)="^45.02AI^^" S X=^(0),^(0)=$P(X,U,1,2)_"^"_I_"^"_($P(X,U,4)+1)
 S:$D(^DGPT(PTF,"M",I,"P")) ^DGPT(DGCI,"M",I,"P")=^("P")
SETMQ K DGSFLAG Q
 ;
BSEC ; -- set bed sec in 1 mvt ; input X := one node of "M" ; output := same
 N Y
 S Y=+$O(^DGPM("ATS",DFN,DGPMCA,9999999.9999999-DGEND)),Y=+$O(^(Y,0))
 S $P(X,U,2)=$S($D(^DIC(45.7,+Y,0)):$P(^(0),U,2),1:0)
 Q
 ;
BS ; -- determine bed status on census date
 S I=+$O(^DGPM("APMV",DFN,DGPMCA,9999999.9999999-Y)),I=+$O(^(I,0))
 S I=$S($D(^DGPM(I,0)):$P(^(0),U,18),1:0),Y=1
 I I S I=U_I_U,Y=$S("^43^44^13^45^"[I:4,"^1^"[I:2,"^2^3^"[I:3,1:1)
 Q
 ;
CONE ;-- find last 535 before last census date
 S DGX=$O(^DGPT(PTF,535,"AM",DGEND)) S DGX=+$S(DGX:$O(^(DGX,0)),1:$O(^DGPT(PTF,535,"ADC",1,0))) I $D(^DGPT(PTF,535,DGX,0)) S ^DGPT(DGCI,535,DGX,0)=^DGPT(PTF,535,DGX,0),$P(^DGPT(DGCI,535,DGX,0),U,10)=DGEND
 S:'$D(^DGPT(DGCI,535,0)) ^(0)="^45.0535^^" S X=^(0),^(0)=$P(X,U,1,2)_"^"_I_"^"_($P(X,U,4)+1)
 Q
 ;
ONE ; -- find last mvt before census date
 S M=$O(^DGPT(PTF,"M","AM",DGEND)),M=$S('M:M,1:$O(^(M,0))),M=$S(M:M,1:1)
 I M>1,$D(^DGPT(PTF,"M",M,0)) S X="1^"_$P(^(0),U,2,99)
 I M=1,DGFEE=0 D BSEC
 S $P(X,U,10)=DGEND,^DGPT(DGCI,"M",1,0)=X
 S:'$D(^DGPT(DGCI,"M",0)) ^(0)="^45.02AI^^" S X=^(0),^(0)=$P(X,U,1,2)_"^1^"_($P(X,U,4)+1)
 ;;Following code added to transmit GAF scores in Census Record
 ;;Code added by EDS-GRR 6/4/1998
 ;;
 M ^DGPT(DGCI,"M",M,300)=^DGPT(PTF,"M",M,300)
 ;;
 ;;End of GAF enhancement
 ;;
 S:$D(^DGPT(PTF,"M",M,"P")) ^DGPT(DGCI,"M",1,"P")=^("P")
 Q
GETSUFF ; -- get suffix if from Va Domiciliary or VA Nursing home
 F DGSTA=30,40 D
 .D NUMACT^DGPTSUF(DGSTA)
 .I DGANUM>0 D
 ..F DGCTR=1:1:DGANUM I DGCSUF=DGSUFNAM(DGCTR) S DGSFLAG=1
 .K DGANUM,DGCTR,DGSUFNAM
 K DGSTA
 Q
