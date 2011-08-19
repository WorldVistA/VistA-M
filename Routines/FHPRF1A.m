FHPRF1A ; HISC/REL/RVD - Print Forecast ;4/25/93  16:48 
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
STRT D NOW^%DTC S NOW=%
 S DTP=D1\1 D DTP^FH S TIM=$P("SUN^MON^TUES^WEDNES^THURS^FRI^SATUR","^",DOW)_"DAY  "_DTP
 S:'$D(FHSITENM) FHSITENM=""
 K S,D,N S L1=50
 F P0=0:0 S P0=$O(^TMP($J,P0)) Q:P0'>0  S X=^FH(119.72,P0,0),N1=$P(X,"^",1),N2=$P(X,"^",2),N3=$P(X,"^",4) S:N3="" N3=$E(N1,1,6) S S(N3,P0)=$J(N3,8)_"^"_N2,L1=L1+8
 S:L1<80 L1=80
 S Z="F O R E C A S T E D   D I E T   C E N S U S"
 S DTP=NOW D DTP^FH W:$E(IOST,1,2)="C-" @IOF W !,DTP,?(L1-$L(Z)\2),Z
 S Z=$P(^FH(119.71,FHP,0),"^",1)
 W !,FHSITENM
 W !,?(L1-$L(Z)\2),Z,!!?(L1-$L(TIM)\2),TIM
 W !!?(L1-31\2),"P R O D U C T I O N   D I E T S",!!
 S X="",FHCNTX=0 F  S X=$O(S(X)) Q:X=""  S FHCNTX=FHCNTX+1
 S FHSP1=31
 S:FHCNTX=5 FHSP1=18
 S:FHCNTX=4 FHSP1=19
 S:FHCNTX=3 FHSP1=25
 S:FHCNTX=2 FHSP1=31
 S:FHCNTX=1 FHSP1=37
 S FHSP2=33
 S:FHCNTX=5 FHSP2=20
 S:FHCNTX=4 FHSP2=21
 S:FHCNTX=3 FHSP2=27
 S:FHCNTX=2 FHSP2=33
 S:FHCNTX=1 FHSP2=39
 W ?FHSP1
 ;
 S X="" F  S X=$O(S(X)) Q:X=""  F K=0:0 S K=$O(S(X,K)) Q:K=""  W $P(S(X,K),"^",1)
 W "    Tray  Cafe  Total"
 S:L1>80 L1=80 S LN="",$P(LN,"-",L1)="" W !,LN,! K LN
 F P1=0:0 S P1=$O(^FH(116.2,"AP",P1)) Q:P1<1  F K=0:0 S K=$O(^FH(116.2,"AP",P1,K)) Q:K<1  I $D(^TMP($J,0,K)) D PRO
 W !!,"TOTAL MEALS",?FHSP2 S (N("T"),N("C"),N("D"),N("G"))=""
 S X="" F  S X=$O(S(X)) Q:X=""  F K1=0:0 S K1=$O(S(X,K1)) Q:K1=""  S Z=$G(^TMP($J,K1)),TYP=$P(S(X,K1),"^",2) S:Z N(TYP)=N(TYP)+Z W $J(Z,6),"  "
 S:N("D") N("T")=N("T")+N("D") W $J(N("T"),6),$J(N("C"),6),$J(N("T")+N("C"),7) Q
 W !!!,"*** Includes other gratuitous/paid meals.",! K S,D,N,P Q
PRO S (N("T"),N("C"),N("D"),N("G"))="" W !,$E($P($G(^FH(116.2,K,0)),"^",1),1,20),?FHSP2
 S X="" F  S X=$O(S(X)) Q:X=""  F K1=0:0 S K1=$O(S(X,K1)) Q:K1=""  S Z=$G(^TMP($J,K1,K)),TYP=$P(S(X,K1),"^",2) S:Z N(TYP)=N(TYP)+Z W $J(Z,6),"  "
 S:N("D") N("T")=N("T")+N("D") W $J(N("T"),6),$J(N("C"),6),$J(N("T")+N("C"),7) Q
