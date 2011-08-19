ZISETONT ;SF/AC - INITIALIZES DEVICE AND TERMINAL TYPES FOR INTERSYSTEMS ;03/05/97  16:51
 ;;8.0;KERNEL;;Jun 10, 1995
 W !,"This routine will setup some defaults for intersystems OpenM for NT.",!,"in the ^%ZIS files.",!!
 S X=0 I '$D(^%ZIS(1,0)) S X=1 W !!,"The device file is missing, Please install Kernel frist"
 I '$D(^%ZIS(2,0)) S X=1 W !!,"The Subtype file is missing, Please install  Kernel frist"
 I X W !,"Then run this routine again." Q
 R "OK? ",X:$S($D(DTIME):DTIME,1:60),!! G EXIT:X'?1"Y".E
 L +^%ZIS:2 W:'$T !,"FILE IS IN USE.  TRY AGAIN LATER!!!",*7 Q:'$T
 S $P(^%ZIS(1,0),U,3)=0,$P(^%ZIS(2,0),U,3)=0 ;Cause it to fillin.
 S U="^",%ZISV=$S($D(^%ZOSF("VOL")):^("VOL"),1:"")
QUES ;I %ZISV]"" W !,"Please Enter a Prefix for New Devices: "_%ZISV_"//" R %ZISV1:$S($D(DTIME):DTIME,1:300) G EXIT:%ZISV1="^"!'$T S:%ZISV1="" %ZISV1=%ZISV I %ZISV1?1"?"."?" D HLP G QUES
 F L=0:0 S L=$O(^DISV(L)) Q:L'>0  K ^DISV(L,"^%ZIS(1,")
BASIC ;Load some basic devices
 F IX=0:1 S X=$T(BX+IX) Q:$P(X,";",3)=""  D
 . F J=3:1:7 S:$P(X,";",J)]"" DEV($P(";;NAME;$I;ASKD;TYPE;SUB;",";",J))=$P(X,";",J)
 . D ADDDEV(.DEV) Q  ;FINISH
 Q
BX ;;Principal device;|TNT|;1;TRM;C-VT102
 ;;Windows NT Console;|TRM|;1;VTRM;C-VT320
 ;;Principal device;|LAT|;1;VTRM;C-VT320
 ;
SUB S (C,L,N)=0 I $D(^%ZIS(2,0)) S N=$P(^(0),U,4),L=$P(^(0),U,3)
 W "TERMINAL TYPES:",!
A S C=$O(^%IS(0,"SUB",C))
 I C="" S R=$S($D(^%ZIS(2,0)):^(0),1:"TERMINAL TYPE^3.2"),^(0)=$P(R,U,1,2)_U_L_U_N G DEVICE
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
 S I=0 F Y=0:0 S I=$O(^%IS(I)) Q:I'>0  I $D(^(I,0)),$D(^(1)),^(1)]"" S C=^(1),X=^(0) D CHK
 F I=0:0 S I=$O(^%ZIS(1,I)) Q:I'>0  I '$D(^(I,99)) S C=$P(^(0),U,1) I $D(^%IS(C,99)),^(99)]"" S C=$O(^%ZIS(1,"B",^(99),0)) I C>0 S ^%ZIS(1,I,99)=C
 S C=$S($D(^%ZIS(1,0)):^(0),1:"DEVICE^3.5"),^(0)=$P(C,U,1,2)_U_L_U_N
C K ^%ZIS("C") S ^%ZIS("C")="G ^%ZISC"
 W !!,"ALL SETUP"
EXIT L -^%ZIS K %ZISV,%ZISV1,C,I,I1,L,N,R,X,Y Q
 ;
CHK I $P(C,U,1)'=I,'$D(^%ZIS(1,"B",I)) S I1=I D ADD Q
 I $P(C,U,1)=I,'$S(%ZISV]"":$S($O(^%ZIS(1,"G","SYS."_%ZISV_"."_$P(C,U,1),0))>0:1,$O(^%ZIS(1,"CPU",%ZISV_"."_$P(C,U,1),0))>0:1,1:0),$O(^%ZIS(1,"C",$P(C,U,1),0))>0:1,1:0) S I1=%ZISV1_I D ADD Q
 Q
ADDDEV(IS) ;Add an entry to the device file
 W I1,! S L=$P(^%ZIS(1,0),U,3) F L=L+1:1 I '$D(^%ZIS(1,L,0)) Q
 ;S ^%ZIS(1,"B",NAM,L)="",^%ZIS(1,"C",DI,L)="",^%ZIS(1,L,0)=NAM_U_DI_U_($P(C,U,4)'=1)_U_'$P(C,U,4),^("TYPE")=$P(C,U,2),^("IOPAR")=$P(C,U,6),N=N+1 I X'?." " S ^(1)=X
 S ^%ZIS(1,"B",IS("NAME"),L)="",^%ZIS(1,"C",IS("$I"),L)="",^%ZIS(1,L,0)=IS("NAME")_U_IS("$I")_U_$G(IS("ASKD")),^("TYPE")=IS("TYPE") ;,^("IOPAR")=$P(C,U,6),N=N+1 I X'?." " S ^(1)=X
 I '$D(^%ZIS(1,"G","SYS."_%ZISV_"."_IS("$I"))) S ^("SYS."_%ZISV_"."_IS("$I"),L)="",$P(^%ZIS(1,L,0),U,11)=1
 I '$D(^%ZIS(1,"CPU",%ZISV_"."_IS("$I"),L)) S ^(L)=""
 I IO("SUB")]"" S C=$O(^%ZIS(2,"B",IO("SUB"),0)) I $D(^%ZIS(2,+C,0)) S ^%ZIS(1,L,"SUBTYPE")=C
 Q
HLP ;HELP FOR PREFIX QUESTION
 W !,"There must be a prefix for a new device"
 W !,"becuase the Device Name and the $I cannot"
 W !,"be the same." Q
