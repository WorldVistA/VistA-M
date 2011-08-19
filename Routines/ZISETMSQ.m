ZISETUPM ;BB,SF/GFT,AC - INITIALIZES DEVICE AND TERMINAL TYPES FOR INTERSYSTEMS;1/12/88  12:45 PM ;4/9/92  14:19
 ;;8.0;KERNEL;;JUL 10, 1995
 W !,"THIS ROUTINE WILL TAKE INTERSYSTEMS TERMINAL AND SUBTYPE FILES",!,"(IN ^%IS) AND MOVE THEM TO THE ^%ZIS FILES.",!!
 R "OK? ",X:$S($D(DTIME):DTIME,1:60),!! G EXIT:X'?1"Y".E
 L +^%ZIS:2 W:'$T !,"FILE IS IN USE.  TRY AGAIN LATER!!!",*7 Q:'$T
 I '$D(^%ZIS(1,0)) S ^%ZIS(1,0)="DEVICE^3.5"
 S U="^",%ZISV=$S($D(^%ZOSF("VOL")):^("VOL"),1:"")
QUES I %ZISV]"" W !,"Please Enter a Prefix for New Devices: "_%ZISV_"//" R %ZISV1:$S($D(DTIME):DTIME,1:300) G EXIT:%ZISV1="^"!'$T S:%ZISV1="" %ZISV1=%ZISV I %ZISV1?1"?"."?" D HLP G QUES
 F L=64:1:200,1 K ^DISV(L,"^%ZIS(1,")
SUB S (C,L,N)=0 I $D(^%ZIS(2,0)) S N=$P(^(0),U,4),L=$P(^(0),U,3)
 W "TERMINAL TYPES:",!
A S C=$N(^%IS(0,"SUB",C))
 I C<0 S R=$S($D(^%ZIS(2,0)):^(0),1:"TERMINAL TYPE^3.2"),^(0)=$P(R,U,1,2)_U_L_U_N G DEVICE
 S R=^(C),Z=$S($D(^(C,1)):^(1),1:"") G A:$D(^%ZIS(2,"B",C)) I Z?."^" S Z=""
 F L=L+1:1 I '$D(^%ZIS(2,L,0)) S ^(0)=C,^(1)=R,^%ZIS(2,"B",C,L)="",N=N+1 W C,! Q
 I Z]"" S X=$P(Z,U,1,5)_U_$P(Z,U,11),^%ZIS(2,L,6)=X,X=$P(Z,U,10,12) D X
 W !,C G A
 ;
X I X?."^" Q
 S X=$P(X,U,1)_U_$P(X,U,3) I '$D(^%ZIS(2,N,5)) S ^(5)=X
 Q
 ;
DEVICE S U="^",(L,N)=0 I $D(^%ZIS(1,0)) S N=$P(^(0),U,4),L=$P(^(0),U,3)
 W !!,"DEVICES:",!
 S I=0 F Y=0:0 S I=$N(^%IS(I)) Q:I<0  I $D(^(I,0)),$D(^(1)),^(1)]"" S C=^(1),X=^(0) D CHK
 F I=0:0 S I=$N(^%ZIS(1,I)) Q:I'>0  I '$D(^(I,99)) S C=$P(^(0),U,1) I $D(^%IS(C,99)),^(99)]"" S C=$N(^%ZIS(1,"B",^(99),0)) I C>0 S ^%ZIS(1,I,99)=C
 S C=$S($D(^%ZIS(1,0)):^(0),1:"DEVICE^3.5"),^(0)=$P(C,U,1,2)_U_L_U_N
C K ^%ZIS("C") S ^%ZIS("C")="G ^%ZISC"
 W !!,"ALL SETUP"
EXIT L -^%ZIS K %ZISV,%ZISV1,C,I,I1,L,N,R,X,Y Q
 ;
CHK I $P(C,U,1)'=I,'$D(^%ZIS(1,"B",I)) S I1=I D ADD Q
 I $P(C,U,1)=I,'$S(%ZISV]"":$S($O(^%ZIS(1,"G","SYS."_%ZISV_"."_$P(C,U,1),0))>0:1,$O(^%ZIS(1,"CPU",%ZISV_"."_$P(C,U,1),0))>0:1,1:0),$O(^%ZIS(1,"C",$P(C,U,1),0))>0:1,1:0) S I1=%ZISV1_I D ADD Q
 Q
ADD W I1,! F L=L+1:1 I '$D(^%ZIS(1,L,0)) Q
 S ^%ZIS(1,"C",$P(C,U,1),L)="",^%ZIS(1,"B",I1,L)="",^%ZIS(1,L,0)=I1_U_$P(C,U,1)_U_($P(C,U,4)'=1)_U_'$P(C,U,4),^("TYPE")=$P(C,U,2),^("IOPAR")=$P(C,U,6),N=N+1 I X'?." " S ^(1)=X
 I '$D(^%ZIS(1,"G","SYS."_%ZISV_"."_$P(C,U,1))) S ^("SYS."_%ZISV_"."_$P(C,U,1),L)="",$P(^%ZIS(1,L,0),U,11)=1
 I '$D(^%ZIS(1,"CPU",%ZISV_"."_$P(C,U,1),L)) S ^(L)=""
 S C=$P(C,U,3) I C]"" S C=$N(^%ZIS(2,"B",C,0)) I $D(^%ZIS(2,C,0)) S ^%ZIS(1,L,"SUBTYPE")=C
 F X=90,91,95,"L","F" I $D(^%IS(I,X))#2,^(X)]"" S ^%ZIS(1,L,X)=^(X) S:+X'=X ^%ZIS(1,X,^(X),L)=""
 Q
HLP ;HELP FOR PREFIX QUESTION
 W !,"There must be a prefix for a new device"
 W !,"becuase the Device Name and the $I cannot"
 W !,"be the same." Q
