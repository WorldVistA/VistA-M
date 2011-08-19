DGQEMP ;RWA/SLC-DHW/OKC-ALB/MIR - EMBOSSER PRINT;04/02/85  5:48 PM ; 11 Feb 86  10:04 AM
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ;DGEMBTYP = device type (1 for embosser, 2 for addressograph, and 0 for plain printer
 ;
EN S %ZIS="",IOP="HOME" D ^%ZIS S DGI=$O(^DIC(39.3,"B",ION,0)),DGEMBTYP=0 K IOP,%ZIS
 I DGI,$D(^DIC(39.3,DGI,0)) S DGEMBTYP=$P(^(0),"^",2)
 I DGEMBTYP<0!(DGEMBTYP>2) G Q
 K DGFORMAT,CARD S (DGCOUNT,DGTRY,DGSOFT,DGHARD,DGUNK)=0
PRINT S:'$D(DGQUAN) DGQUAN=1 S ERR=0 D @(DGEMBTYP)
 I ERR S DGTRY=DGTRY+1 D MAIL G:'REC&(DGTRY'>2) PRINT D HOLD^DGQEMA1
 ;
 ;update file statistics
 ;
 I 'DGI G Q
 I '$D(^DIC(39.3,DGI,1,0)) S ^DIC(39.3,DGI,1,0)="^39.31A^^"
 S X="" I $D(^DIC(39.3,DGI,1,DT,0)) S X=^(0)
 S DGNUM=$P(X,"^",1),DGSOFER=$P(X,"^",2),DGHER=$P(X,"^",3),DGUKER=$P(X,"^",4)
 S DIC="^DIC(39.3,"_DGI_",1,"
 I '$D(^DIC(39.3,DGI,1,DT)) S DINUM=DT,DIC(0)="L",DA(1)=DGI,X=DGCOUNT D ^DIC
 I $D(^DIC(39.3,DGI,1,DT)) S DIE=DIC,DA=DT,DR=".01///"_(DGCOUNT+DGNUM)_";1///"_(DGSOFT+DGSOFER)_";2///"_(DGHARD+DGHER)_";3///"_(DGUNK+DGUKER) D ^DIE
 ;I DGCOUNT<DGQUAN S DGQUAN=DGQUAN-DGCOUNT G PRINT
Q D KILL^%ZTLOAD K DFN,DGCOUNT,DGCT,DGEMBTYP,DGHARD,DGF,DGFORMAT,DGHER,DGI,DGLINE,DGNUM,DGQUAN,DGSOFER,DGSOFT,DGTRY,DGUKER,DGUNK,ERR,F,FM,I,J,K,POP,REC,X,XMB,XMDUZ,Y
 K DA,DIC,DIE,DINUM
 Q
MAIL I $L($P(^DIC(39.1,DGTYP,0),"^",5)),$P(^(0),"^",5)="Y" S XMY(DUZ)=""
 S XMDUZ=.5,XMB=$S(REC:"DG EMBOSSER1",1:"DG EMBOSSER"),XMB($S(REC:1,1:2))=$S($D(^DPT(+DFN,0)):$P(^(0),"^",1),1:"UNSPECIFIED")
 I 'REC S XMB(1)=$P(^DIC(39.1,DGTYP,0),"^",1)
 D ^XMB
 K XMB,XMDUZ Q
 ;
 ;
BATCH ;process cards in hold status
 F DGCD=0:0 S DGCD=$O(^DIC(39.1,DGTYP,"HOLD",DGCD)) Q:'DGCD  I $D(^(DGCD,0)) S DFN=+^(0),DGQUAN=$P(^(0),"^",2) D TEXT
 S DIK="^DIC(39.1,"_DGTYP_",""HOLD"",",DA(1)=DGTYP F DA=0:0 S DA=$O(^DIC(39.1,DGTYP,"HOLD",DA)) Q:'DA  D ^DIK
 K DA,DIK,DGCD,DGTYP Q
 ;
TEXT ;get text from cards in hold
 F K=1:1:9 I $D(^DIC(39.1,DGTYP,"HOLD",DGCD,1,K,0)) S DGLINE(K)=^(0)
 I $D(DGLINE(1)) D EN ;print card
 Q
 ;
 ;
 ;WARNING!!!
 ;This section prints the patient data cards and interacts with the
 ;embosser and addressograph
 ;
 ;Line tags:
 ;                     0 - for plain printer
 ;                     1 - for embosser
 ;                     2 - for addressograph
 ;
 ;
0 ;plain paper printer
 F I=1:1:DGQUAN S DGCOUNT=DGCOUNT+1 W:I>1 !!!!!! F L=1:1:9 I $D(DGLINE(L)) W !,DGLINE(L)
 W @IOF
 Q
 ;
 ;
1 ;embosser
 S (REC,F,K,X)=0,DGF=2 X ^%ZOSF("EOFF"),^%ZOSF("TYPE-AHEAD")
 S FM=$S($D(DGFORMAT):9,1:0)
 F I=1:1 R *X:0 Q:'$T
A0 R *X:30 S X=$C(X) I X="" S DGUNK=1 G ERR
 I FM=1 S FM=2 G S1:X="B",H1:X="H",X1:X'="C" S DGFORMAT=1 G A0
 G A1:X="A",H1:X="H",S1:X="B",X1
 ;
A1 G S2:'FM D SB1 S REC=1
 F I=1:1:DGQUAN R *X:200 S X=$C(X) G S1:X="B",H1:X="H",X1:X'="C" S K=K+1
 G END
S1 G ERR:F>DGF R *X:30 S X=$C(X),F=F+1,DGSOFT=DGSOFT+1 G H1:X="H",ERR:X'="A"
S2 D SB2 S FM=1 G A0
H1 S DGHARD=DGHARD+1 G ERR
X1 S DGUNK=DGUNK+1 G ERR:F>DGF S F=F+1 G A0
ERR S ERR=1
END S DGCOUNT=K Q
SB1 W "#DCC##REP#",DGQUAN,"#EMB#" F L=1:1:9 Q:'$D(DGLINE(L))  W DGLINE(L),""""
 W "#END#@@@@@@" Q
SB2 W "#DCL#080400 1#FC1#1550 2#FC1#1400 3#FC1#1250"
 W " 4#FC1#1100 5#FC1#0950 6#FC1#0800 7#FC1#0650"
 W " 8#FC1#0500 9#FC1#0350#END#@@@@@@" Q
 ;
 ;
2 ;addressograph
 F I=1:1:DGQUAN D ADD S DGCOUNT=DGCOUNT+1
 Q
ADD F L=1:1:12 W *0
 W "<" F L=1:1:9 Q:'$D(DGLINE(L))  W !,"+00000",(L-1),"0",DGLINE(L)
 W ">" Q
