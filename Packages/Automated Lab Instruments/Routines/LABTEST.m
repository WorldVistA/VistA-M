LABTEST ;SLC/RWF - AUTOMATED INSTRUMENT INTERFACE TESTING ;7/20/90  07:37 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
A S DIC="^LAB(62.4,",DIC(0)="AEMQZ",DIC("S")="I Y<99,Y#10=1" D ^DIC G END:Y<1 S LANM=$P(Y(0),"^",3)
 S HOME=$O(^LAB(62.4,"C",LANM,0)),BASE=HOME-1 I HOME<1 W !,$C(7),"Can't find '",LANM,"' as a program name in auto instrument file." Q
 S U="^",IOP=$P(^LAB(62.4,HOME,0),U,2),%ZIS="" I IOP="" W !,$C(7),"No IO device to open in auto instrument file." Q
 D ^%ZIS W !,"I ",$S(POP:"Can't open",1:"Will use")," the data IO device: ",ION,"." Q:POP
 D INIT^LABINIT K IOP,%ZIS S LANM="LABTEST"
 X ^%ZOSF("NBRK") U IO(0) W $C(7),!,"Now please turn-OFF then ON the interface."
 F I=1:1:30 U IO R X:60 U IO(0) W !,X Q:X["START"
 X ^%ZOSF("BRK")
 U IO(0) I X'["START" W !,"Did not find starting point. Please check cables." G TRAP
 U IO W *13,*13 R X:2 ;
IO S T=T-BASE,HDR="T"_$E(100+T,2,3)_"L"_$E(1000+$L(OUT),2,4)
 U IO(0) W !,"==>",HDR," ",OUT," " F I=1:1:100 U IO W HDR,!,OUT,! R *X:5 U IO(0) W $C(X) Q:$C(X)=ACK  Q:(X=-1)&(T=0)
 S TRY=0
RD U IO R HRD:TOUT G TOUT:'$T R IN:2 U IO(0) W !,"<==",HRD," ",IN," " S T=+$E(HRD,2,3)+BASE,L=+$E(HRD,5,7),M=+$E(HRD,9,11)
 I HRD'?1"T"2N1"L"3N1"M"3N!(L'=$L(IN)),TRY<50 S TRY=TRY+1 U IO(0) W NAK U IO W NAK G RD
 U IO(0) W ACK U IO W ACK G W:TRY>49
IO1 S TOUT=2 IF $D(^LA("TP",0)) S ^LA("TP",0)=1+^(0),^(^(0))=IN
 IF T=HOME S RT=$H,ASK=-2
IO2 IF '$D(^LA(T)),$D(^LAB(62.4,T,1)) X ^(1)
 IF '$D(^LA(T)) S T=HOME
 LOCK ^LA(T) G IO2:'$D(^LA(T,"I"))#2 S CNT=^LA(T,"I")+1,^("I")=CNT,^("I",CNT)=IN L
 I $D(^LAB(62.4,T,.5)) S OUT="" X ^(.5) I OUT'="" S T=T+BASE G IO
W IF $D(^LA("STOP")) K ^LA("LOCK",HOME),^LA("STOP",HOME),^LA(HOME),^TMP($J),^TMP("LA",$J) G H^XUS
 S OTN=-1,OUT=$S(TOUT<10:"",1:"1"),T=$S(OUT:HOME,1:BASE) G IO:^LA("Q")=^LA(HOME,"Q")
 LOCK ^LA("Q") S Q=^LA(HOME,"Q")+1,^("Q")=Q,T=$S($D(^LA("Q",Q)):^(Q),1:0) G W:T<HOME,W:HOME+9<T
 K ^LA("Q",Q) L  G IO:T<1,W:'$D(^LA(T))
 S CNT=^LA(T,"O",0)+1 IF $D(^(CNT)) S ^(0)=CNT,OUT=^(CNT)
 S TOUT=2 G IO
 ;
SET G SET^LAB
 ;
TOUT S:TOUT<35 TOUT=TOUT+2 S:TOUT>35 ASK=ASK+1
 IF ASK=0,TOUT>35 S OUT="1",T=HOME G IO
 IF ASK>1 D ^LABALARM S ASK=-1 U IO
 G W
OUT S CNT=^LA(T,"O")+1,^("O")=CNT,^("O",CNT)=OUT
 LOCK ^LA("Q") S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=T LOCK
 Q
INIT ;
TRAP D ^LABERR K ^LA("LOCK",HOME) D ^%ZISC U IO(0) W !,"LABTEST STOPPED.",!
 Q
END K DIC,LANM Q
