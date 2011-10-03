ORVOM0 ; slc/dcm - Gathers parts to send ;1/23/91  06:47 ;
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 S DIT=0,DL=DRN,DRN=1001,DHS=DH,DSEC=0
S ;
 K ^UTILITY("DI",$J)
I ;
M S DIRS="K ^UTILITY(U,$J),^UTILITY(""DIK"",$J) "
 W !,"MAXIMUM ROUTINE SIZE(BYTES): ",^DD("ROU"),"// "
 R %:$S($D(DTIME):DTIME,1:60) E  S DTOUT=1 G Q
 S DIFRM=^DD("ROU")
 I %]"" G Q:%[U S DIFRM=% I %\1'=%!(%<2000)!(%>9999) D M^ORVOMH G M
GO W !,"...OK, this may take a while, hold on please..."
 S Y=101,Y(101)="",X="PRO" D ADD
 K %,%1,%2,%3,Y,CTR,TOP G ^ORVOM1
 ;
ADD ;
 Q:$D(^DIC(Y,0))[0!$D(DTL(Y))  Q:$P(^(0),X,1)]""!'$D(^(0,"GL"))  S Y=^("GL")
 I $L(DH) D:$O(@(Y_"""B"",DH,0)")) A F  S DH=$O(@(Y_"""B"",DH)")) Q:DH=""!($E(DH,1,$L(DHS))'=DHS)!($E(DH,($L(DHS)+1))="Z")  D A
 S II=0 F  S II=$O(^ORD(100.99,1,5,DPK,1,II)) Q:II<1  S D=+^(II,0) D:'$D(^UTILITY(U,$J,X,D)) A1 S III=0 F  S III=$O(^ORD(100.99,1,5,DPK,1,II,1,III)) Q:III<1  S MEN=^(III,0) D MEN
 S DH=DHS
 Q
A ;
 S D=$O(@(Y_"""B"",DH,0)"))
A1 S %X=Y_"D,",%Y="^UTILITY(U,$J,X,D,"
 S Q(X)=0 D %XY^%RCR
 S %=^UTILITY(U,$J,X,D,0),%1=+$P(%,U,12),%1=$S($D(^DIC(9.4,%1,0)):$P(^(0),U),1:""),$P(%,U,12)=%1,$P(%,U,5)=""
 S ^UTILITY(U,$J,X,D,0)=% I $D(^(10,0)) S CTR=$P(^(0),"^",4),TOP=$P(^(0),"^",3) K ^("B"),^("C")
 I $D(^UTILITY(U,$J,X,D,5)) S %=$P(^(5),"^"),%1=$P(%,";",2) I %,$D(@("^"_%1_+%_",0)")) S %=$P(^(0),"^"),$P(^UTILITY(U,$J,X,D,5),"^")=%_";"_%1
 S %=0 F  S %=$O(^ORD(101,D,10,%)) Q:'%  I $D(^(%,0)) S %2=^(0) I $D(^ORD(101,+%2,0)) S %3=$P(^(0),"^"),%1=$E(%3,1,$L(DHS)) D A2
 I $D(^UTILITY(U,$J,X,D,10,0)) S $P(^(0),"^",3,4)=CTR_"^"_TOP
 I $D(^UTILITY(U,$J,X,D,3,0)) K ^("B") S I=0 F  S I=$O(^UTILITY(U,$J,X,D,3,I)) Q:I<1  S KEY=^(I,0) K ^(0) I $D(^DIC(19.1,+KEY,0)) S KEY=$P(^(0),"^"),^UTILITY(U,$J,X,D,3,I,0)=KEY
 Q
 ;
Q ;
 K ^UTILITY($J),^(U,$J),DH,DHS,EH,ORVROM,DR,DD,DLAYGO,DIRS,DIMA,DMAX,DWLW,DREF,D1
 K DIX,DIY,DO,DZ,DIK,DIFQ,DDF,DDT,NO,DIF,DIG,DIH,DIU,DIV,DIW
 K %A,%B,%C,%V,%X,%Y,%Z,NM,DG,D0,DA,DIFRM,DL,D,E,F,R,III,KEY,TXT,DIC,DIE,DN,DPK,DQ,DRN
 K DIFQR,DNAME,DSEC,DTL,DIFC,Q,DIDIU,DIFKEP,DIT,DILN2 Q
 ;
MEN ;add to menu
 Q:'$D(^ORD(101,+MEN,0))  S OMEN=$P(^(0),"^"),IT=$O(^ORD(101,+MEN,10,"B",D,0)) Q:$D(^UTILITY(U,$J,X,D,"MEN",OMEN))  S ^UTILITY(U,$J,X,D,"MEN",OMEN)=$S(IT:^ORD(101,+MEN,10,IT,0),1:D)
 I IT,$P(^ORD(101,+MEN,10,IT,0),"^",4) S X0=$P(^(0),"^",4),$P(^(0),"^",4)="" I $D(^ORD(101,X0,0)) S $P(^UTILITY(U,$J,X,D,"MEN",OMEN),"^",4)=$P(^(0),"^")
 W !,"Sending "_$P(^ORD(101,D,0),"^")_" to go on "_$P(^ORD(101,+MEN,0),"^")_" menu."
 Q
A2 I %1'=DHS,%3'?1"ORB".E K ^UTILITY(U,$J,X,D,10,%) S CTR=CTR-1,TOP=% Q
 S ^UTILITY(U,$J,X,D,10,%,U)=%3
 I $P(%2,"^",4),$D(^ORD(101,$P(%2,"^",4),0)) S $P(^UTILITY(U,$J,X,D,10,%,0),"^",4)=$P(^(0),"^")
 Q
