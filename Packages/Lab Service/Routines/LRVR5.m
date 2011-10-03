LRVR5 ;DALOI/CJS/DALOI/FHS - LAB ROUTINE DATA VERIFICATION ;4/20/89  18:02
 ;;5.2;LAB SERVICE;**1,42,153,263,283,286**;Sep 27, 1994
 ;
 S LRNX=0,LRVRM=11
V40 ;
 S LRNX=$O(LRORD(LRNX))
 G V44:LRNX<1 D SUBS G V40:'LRTS,V40:'$D(LRVTS(LRSB))
 ;
 ; Only allow verifying reference lab results which exist in LAH, no
 ; entering results "on the fly" - use EM options (^LRVER)
 I $G(LRDUZ(2)),LRDUZ(2)'=DUZ(2),'$D(^LAH(LRLL,1,LRSQ,LRSB)) K LRSB(LRSB) G V40
 ;
 I $D(^LR(LRDFN,LRSS,LRIDT,LRSB)),^(LRSB)'["pending" D V25^LRVR4 G:LRVF V40
V42 D V25
 S X=$S($D(LRSB(LRSB)):$P(LRSB(LRSB),U),1:""),LREDIT=0
 I X="",LRDV'="" S $P(LRSB(LRSB),"^")=LRDV,X=LRDV
 S LRTEST=$P(^LAB(60,+LRTS,0),U),LROUT=0 K LRNOVER(LRSB)
Q42 W !,LRTEST," " W:X'="" @LRFP R "//",X:DTIME I X'?.ANP W $C(7)," No Control Characters Allowed." G V42
 I X=""&$D(LRSB(LRSB)) S X=$P(LRSB(LRSB),U)
Q43 S LRDL=X G V40:X="",V45:X'["^",V44:X="^",OUT:X="^^"
V43 S X=$P(X,U,2),DIC="^LAB(60,",DIC(0)="EOQZ" D ^DIC G:Y<1 Q42
 S LRPLOC=$P(Y(0),U,5),LRSSQ=$P(LRPLOC,";",1),LRSB=$P(LRPLOC,";",2),LRTS=+Y
 I LRSSQ="" W !,"Not in this group" G OUT
 I LRSS'=LRSSQ!'$D(^TMP("LR",$J,"TMP",LRSB)) W !,"Not in this group" G OUT
 F LRNX=0:0 S LRNX=$O(LRORD(LRNX)) Q:LRNX<1  G V42:LRSB=LRORD(LRNX)
V44 D COM^LRVR4
 S LRNUF=1
 Q
 ;
 ;
V45 ;
 K LRSKIP
 S LRDL=X
 I X="@" D  G V46
 . S X=$S($D(LRM(LRSB)):"pending",1:"")
 . S $P(LRSB(LRSB),"^")=X,$P(LRSB(LRSB),"^",2)=""
 ;
 S X7=U_$P(^LAB(60,+LRTS,0),U,12),X6=X7_"0)"
 X:'(X="*"!($E(X)="?")!(X="C")!(X="#")!(X="canc")!(X="pending")) $P(@X6,U,5,99)
 I '$D(X)#2 D HELP G V42
 I $D(X)#2,X["?" D HELP G:'($P(@X6,U,2)["S") V42
 I $D(X)#2,$P(@X6,U,2)["S",X'="*",X'="#",X'="canc",X'="pending" D SET G:'$D(X)#2 V42
 I $D(X)#2,X="C",$P(@X6,U,2)'["S" D COMP^LRVER5 G V42
 ;
V46 G V44:'$D(X)#2
 S X1=$S($D(^LR(LRDFN,LRSS,LRLDT,LRSB)):$P(^(LRSB),U),1:""),LRFLG=""
 S:X="*" X="canc" S:X="#" X="comment"
 K LRQ S Y=0
 I LRDEL'="" S LRQ=1 X LRDEL K LRQ
 D RANGE
 G:$D(LRNUF) V44
 K LRNUF
 G V40:'$D(LRSKIP)
 S X=LRSKIP
 G Q43:X["^",V40
 G RANGE
 ;
 ;
RANGE D RANGE^LRVER5
RQ S X=Y
NR ;
 S:$P(X,U)="" LRSB(LRSB)="" Q:$D(LRQ)
 I $P(X,U)'="" D
 . N I,LRX,LRY
 . S $P(LRSB(LRSB),U,1,2)=X_U_LRFLG
 . S $P(LRSB(LRSB),U,4)=$G(DUZ)
 . I $P(LRSB(LRSB),U,9)="" S $P(LRSB(LRSB),U,9)=$S($G(LRDUZ(2)):LRDUZ(2),$G(DUZ(2)):DUZ(2),1:"")
 . S LRX=$$TMPSB^LRVER1(LRSB),LRY=$P(LRSB(LRSB),U,3)
 . F I=1:1:$L(LRX,"!") I $P(LRY,"!",I)="" S $P(LRY,"!",I)=$P(LRX,"!",I)
 . S $P(LRSB(LRSB),U,3)=LRY
 . S LRX=LRNGS,LRY=$P(LRSB(LRSB),U,5)
 . F I=1:1:$L(LRX,U) I $P(LRY,"!",I)="" S $P(LRY,"!",I)=$P(LRX,U,I)
 . S $P(LRSB(LRSB),U,5)=LRY
 Q
 ;
 ;
SUBS ;
 D LRSUBS^LRVER5
 Q
 ;
 ;
SET ;
 D LRSET^LRVER5
 Q
 ;
 ;
HUH W !,"CHOOSE:" F I=1:1 S LRSUBS=$P(LRSET,";",I) Q:LRSUBS=""  W !,$P(LRSUBS,":")," FOR ",$P(LRSUBS,":",2)
 K X
 Q
 ;
 ;
V25 ; From LRVR4
 D V25^LRVER5
 Q
 ;
 ;
OUT S LROUT=1
 Q
 ;
 ;
HELP ;
 W !," ??",$C(7)
 S X5=X7_"3)"
 W:$D(@X5) " ",@X5
 W !,"Enter * to report ""canc"" for canceled."
 W !,"Enter # to report ""comment""."
 W:'($P(@X6,U,2)["S") !,"Enter C to enter calculate mode."
 Q
