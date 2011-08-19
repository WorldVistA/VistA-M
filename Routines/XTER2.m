XTER2 ;ISC-SF.SEA/JLI - MODIFICATION OF %XTER FOR USE WITH VAX DSM ;04/01/98  12:06
 ;;8.0;KERNEL;**71,77**;Jul 10, 1995
RESTOR ;
 X ^%ZOSF("PROGMODE") I 'Y W !,$C(7),"^R to restore environment is restricted to users in programmer mode",$C(7),! G ^XTER1
 S %XTZUCI=$P(%XTJOB,U,4) X ^%ZOSF("UCI") I Y'=%XTZUCI K %XTZUCI
 K (%XTZDAT,%XTZNUM,%XTZUCI)
 F %XTZZZ=0:0 S %XTZZZ=$O(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZV",%XTZZZ)) Q:%XTZZZ'>0  I $D(^(%XTZZZ,"D"))#2,$D(^(0))#2,$E(^(0))'="$" I $E(^(0),1,6)'="%ZT(""^",$E(^(0),1)'="^" S @(^(0))=^("D")
 I '$D(%XTZUCI) W !,$C(7),"MUST BE IN SAME UCI TO RESTORE PROGRAM --- VARIABLES RESTORED",! K %XTZDAT,%XTZNUM,%XTZZZ Q
 S X=$P($P($P(^%ZTER(1,%XTZDAT,1,%XTZNUM,"ZE"),",",1),"^",2),":",1) I X'="" X ^%ZOSF("TEST") I $T S XCNP=0,DIF="^TMP($J," X ^%ZOSF("LOAD") K XCNP,DIF,^TMP($J)
 W !,"VARIABLES RESTORED"
 K %XTZZZ,%XTZDAT,%XTZNUM,%XTZUCI
 Q
 ;
SLIST ;
 S XTSTR1=0 R !!,"Enter part of error or routine to be matched: ",XTSTR:DTIME Q:'$T!(XTSTR="")!(XTSTR="^")  D T11
 D T13 F XTI=0:0 Q:XTOUT  S XTI=$O(^TMP("XTER",$J,XTI)) Q:XTI'>0  F X=0:0 S X=$O(^TMP("XTER",$J,XTI,X)) Q:X'>0  S %XTZDAT=^(X),XTSTR1=XTSTR1+1,XTD=0 S %XTYL=%XTYL-1 D:'%XTYL MORE^XTER1A Q:XTOUT  D:'%XTYL T11 W:'%XTYL ! D T10
 I XTSTR1=0 W !!?10,XTSTR," not found in error log",!
 K XTSTR,XTSTR1
Z Q
T10 I ^%ZTER(1,%XTZDAT,1,X,"ZE")["," S %XTERR=$P($P(^("ZE"),",",4),"-",4),%XTERR=$P($P(^("ZE"),",",2),"-",3)_$S(%XTERR="":"",1:"(")_%XTERR_$S(%XTERR="":"",1:")")
 S %XTERR(1)=$H-%XTZDAT,%XTERR(1)="T"_$S(%XTERR(1)=0:"",1:"-"_%XTERR(1)),%XTERR(1)=$E(%XTERR(1)_"     ",1,5)_" #"
 I ^%ZTER(1,%XTZDAT,1,X,"ZE")["," W !,%XTERR(1),$J(X,3),")  ","<",%XTERR,">",$P(^%ZTER(1,%XTZDAT,1,X,"ZE"),",",1)_" "
 I ^%ZTER(1,%XTZDAT,1,X,"ZE")'["," W !,%XTERR(1),$J(X,3),")  ",^("ZE")
 S %XTZNUM=X,%="" I $D(^%ZTER(1,%XTZDAT,1,%XTZNUM,"H")) S %H=^("H") D YMD^%DTC S %=$P(%,".",2)_"000000",%=$E(%,1,2)_":"_$E(%,3,4)_":"_$E(%,5,6)
 S X=%XTZNUM W ?39,%
 W "  ",$P($S('$D(^%ZTER(1,%XTZDAT,1,X,"J")):"",1:^("J")),U,4),"  ",$J($P($S('$D(^("J")):"",1:^("J")),U,5),7),"  ",$P($S('$D(^("I")):"",1:^("I")),U)
 Q
T11 W !!,"Date",?6,"ErrNum",?17,"$ZE",?41,"Time",?49,"UCI/VOL",?61,"$J",?69,"$I" S %XTYL=IOSL-6
 Q
 ;
T13 K ^TMP("XTER",$J) S %XTZDAT=0 F XTI=0:0 S %XTZDAT=$O(^%ZTER(1,%XTZDAT)) Q:%XTZDAT'>0  F X=0:0 S X=$O(^%ZTER(1,%XTZDAT,1,X)) Q:X'>0  I $D(^(X,"ZE")),^("ZE")[XTSTR S ^TMP("XTER",$J,(99999-%XTZDAT),X)=%XTZDAT
 Q
UDD ;Convert user date
 K XTDTE,XTDTH,XTERR N %XTF,%XTY,X,Y
 G T:%XTZDAT?1"T".E,T:%XTZDAT?1"t".E
 S %XTF=$TR(%XTZDAT,$C(32,44,45,46),"////")
B S %XTY="//" D R
 S X=%XTF,%DT="XP",%DT(0)="-NOW" D ^%DT K %DT I Y'>0 S XTERR=1 K XTDTE,XTDTH G K
 S XTDTH=+$$FMTH^XLFDT(Y),XTDTE=$$FMTE^XLFDT(Y,5)
K Q
E S XTERR=1 K XTDTH,XTDTE G K
R Q:%XTF'[%XTY  S %XTF=$P(%XTF,%XTY,1)_"/"_$P(%XTF,%XTY,2,256) G R
 ;
T S %XTT=$E(%XTZDAT,2,99) I %XTT'="" G E:%XTT?7E.E,E:%XTT'?1"-"1N.N&(%XTT'?1"+"1N.N)
 S XTDTH=$P($H,",",1)+%XTT G E:XTDTH<0 D UDA S XTDTH=-XTDTH G K
 ;
UDA ;
 I '$D(XTDTH) S XTDTH=$P($H,",",1)
 S XTDTE=$$HTE^XLFDT(XTDTH,5)
 Q
