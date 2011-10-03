ZOSFDTM ;SFISC/HGL,AL - For DataTree ;9/8/94  08:53
 ;;8.0;KERNEL;;JUL 03, 1995
 S %Y=1 K ^%ZOSF("MASTER"),^%ZOSF("SIGNOFF")
 K ZO F I="MGR","PROD","VOL" S:$D(^%ZOSF(I)) ZO(I)=^%ZOSF(I)
 S ZO("DISYS")=$S($D(^%ZOSF("OS")):$P(^("OS"),"^",2),1:"")
 F I=1:2 S Z=$P($T(Z+I),";;",2) Q:Z=""  S X=$P($T(Z+1+I),";;",2,99) S ^%ZOSF(Z)=$S($D(ZO(Z)):ZO(Z),1:X)
MGR W !,"NAME OF MANAGER'S NAMESPACE: "_^%ZOSF("MGR")_"// "
 R X:120 S:X="" X=^%ZOSF("MGR") X ^("UCICHECK") I 0[Y W " ??",*7 G MGR
 S ^%ZOSF("MGR")=Y
PROD W !,"PRODUCTION (SIGN-ON) NAMESPACE: "_^%ZOSF("PROD")_"// "
 R X:120 S:X="" X=^%ZOSF("PROD") X ^("UCICHECK") I 0[Y W " ??",*7 G PROD
 S ^%ZOSF("PROD")=Y
VOL W !,"NAME OF THIS CPU: "_^%ZOSF("VOL")_"// "
 R X:120 S:X="" X=^%ZOSF("VOL")
 I X'?3U.U!($L(X)<3)!($L(X)>8) W !," ?? Must be 3-8 uppercase characters",*7 G VOL
 S ^%ZOSF("VOL")=X
OS S ^%ZOSF("OS")="DTM-PC"_"^"_ZO("DISYS") S:'$P(^%ZOSF("OS"),"^",2) $P(^%ZOSF("OS"),"^",2)=9
 W !,"OPERATING SYSTEM FILE ALL SET UP",!
 K ZO Q
V3 ;
 S ^%ZOSF("TRAP")="$ZE=X"
 S ^%ZOSF("PROGMODE")="S Y=0"
 Q
Z ;;
 ;;ACTJ;; Active Jobs
 ;;S Y=$$ACTJ^%ZOSV
 ;;AVJ;; Available Jobs
 ;;S Y=$$AVJ^%ZOSV
 ;;MAXJ;; Maximum # of Jobs
 ;;G MAXJ^%ZOSV
 ;;BRK;; Enable Break
 ;;B 1
 ;;DEL;; Delete Routine in X
 ;;zdelete @X:1
 ;;EOFF;; Turn echo off
 ;;U $I:(echom=0)
 ;;EON;; Turn echo on
 ;;U $I:(echom=1)
 ;;EOT;; End of tape
 ;;S Y=($ZIOS=3)
 ;;ERRTN;; Error trap routine
 ;;^%ZTER
 ;;ETRP;; Set error trap to X
 ;;Q
 ;;GD;; Global Directory
 ;;G ^%gd
 ;;JOBPARAM
 ;;G JOBPAR^%ZOSV
 ;;LABOFF
 ;;U IO:(echom=0)
 ;;LOAD
 ;;S %N=0 X "ZL @X F XCNP=XCNP+1:1 S %N=%N+1,%=$T(+%N) Q:$L(%)=0  S @(DIF_XCNP_"",0)"")=%"
 ;;LPC;;
 ;;S Y=$ZCRC(X,1)
 ;;MAXSIZ;; Reset partition size
 ;;Q
 ;;MGR;; Manager's Account name
 ;;SYS
 ;;NBRK;; Disable Break
 ;;B 0
 ;;NO-PASSALL
 ;;G NOPASS^%ZOSV
 ;;NO-TYPE-AHEAD;; Turn off type-ahead
 ;;U $I:(ta=0)
 ;;OS;; Operating System Name
 ;;DTM-PC
 ;;PARSIZ
 ;;S X=3
 ;;PASSALL
 ;;G PASSALL^%ZOSV
 ;;PRIINQ;; Find job's priority
 ;;S Y=$$PRIINQ^%ZOSV()
 ;;PRIORITY;; Set a job's priority
 ;;G PRIORITY^%ZOSV
 ;;PROD;; Production Account Name
 ;;USER
 ;;PROGMODE;; Check if user is in programmer mode
 ;;S Y=$ZMODE
 ;;RD;; Routine Directory
 ;;G ^%rd
 ;;RESJOB
 ;;Q:'$D(DUZ)  Q:'$D(^XUSEC("XUMGR",+DUZ))  N XQZ S XQZ="^%mjob[MGR]" D DO^%XUCI
 ;;RM;; Set right margin to X ;***EDITED BY AC/SFISC***
 ;;U $I:(lmar=0:width=$S(X:X,1:$zdevfwid):wrap=(X&($I>99)))
 ;;RSEL;; Routine Select - returns number of routines in NRO
 ;;K ^UTILITY($J) S NRO=$$^%rselect W !,NRO," routines selected" S %X="^%RSET("_$J_",",%Y="^UTILITY("_$J_"," D %XY^%RCR S ^UTILITY($J)=^%RSET($J) K ^%RSET($J),%X,%Y
 ;;RSUM
 ;;ZL @X S Y=0 F %=1,3:1 S %1=$T(+%),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*%2+Y
 ;;SAVE
 ;;S XCS="F XCM=1:1 S XCN=$O(@(DIE_XCN_"")"")) Q:+XCN'=XCN  S %=^(XCN,0) Q:$E(%,1)=""$""  S:%'[$C(9) %=$P(%,"" "",1)_$C(9)_$P(%,"" "",2,999) I $E(%,1)'="";"" ZI %" X "ZR  X XCS ZS @X" S ^UTILITY("ROU",X)="" K XCS
 ;;SIZE;; Return size of routine in partition
 ;;S Y=$L($zrsource($zn))
 ;;SS;; System Status
 ;;G ^%mjob
 ;;TEST;; Routine existence test
 ;;I $ZRSTATUS(X)'=""
 ;;TMK;; Tapemark
 ;;Q
 ;;TRMOFF
 ;;G:$P($ZVER,"/",2)<4.3 TRMOFF^%ZOSV U $I:TERM=$C(13,27)
 ;;TRMON
 ;;G:$P($ZVER,"/",2)<4.3 TRMON^%ZOSV U $I:TERM=$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127)
 ;;TRMRD
 ;;S Y=$S('$ZIOS:$ZIOT,1:0)
 ;;TRAP;; DTM V4 only.  zetrap works for both versions
 ;;$ZT=X
 ;;TYPE-AHEAD;; Turn on type-ahead
 ;;U $I:(ta=1)
 ;;UCI;; Return current namespace in Y
 ;;S Y=$ZNSPACE
 ;;UCICHECK;;
 ;;S Y=$$UCICHECK^%ZOSV(X)
 ;;UPPERCASE
 ;;S Y=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;;VOL
 ;;AAA
 ;;XY;; Position cursor
 ;;S $X=DX,$Y=DY
 ;;ZD;; External date format in Y
 ;;S Y=$ZD($H,1)
