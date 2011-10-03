DINZDTM ;SFISC/HGL,AL-SETS %ZOSF FOR DATATREE ;2:32 PM  1 Oct 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 K ^%ZOSF("MASTER"),^%ZOSF("SIGNOFF")
 F I=1:2 S Z=$P($T(Z+I),";;",2) Q:Z=""  S X=$P($T(Z+1+I),";;",2,99) S ^%ZOSF(Z)=X
 K I,X,Z
 Q
V3 ;
 S ^%ZOSF("TRAP")="$ZE=X"
 S ^%ZOSF("PROGMODE")="S Y=0"
 Q
Z ;;
 ;;OS;; Operating System Name
 ;;DTM-PC^9
 ;;ACTJ;; Active Jobs
 ;;S Y=$$ACTJ^%ZOSV
 ;;AVJ;; Available Jobs
 ;;S Y=$$AVJ^%ZOSV
 ;;MAXJ;; Maximum # of Jobs
 ;;G MAXJ^%ZOSV
 ;;BRK;; Enable Break
 ;;B 1
 ;;DEL;; Delete Routine in X
 ;;X "ZR  ZS @X"
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
 ;;NBRK;; Disable Break
 ;;B 0
 ;;NO-PASSALL
 ;;G NOPASS^%ZOSV
 ;;NO-TYPE-AHEAD;; Turn off type-ahead
 ;;U $I:(ta=0)
 ;;PARSIZ
 ;;S X=3
 ;;PASSALL
 ;;G PASSALL^%ZOSV
 ;;PRIINQ;; Find job's priority
 ;;S Y=$$PRIINQ^%ZOSV()
 ;;PRIORITY;; Set a job's priority
 ;;G PRIORITY^%ZOSV
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
 ;;XY;; Position cursor
 ;;S $X=DX,$Y=DY
 ;;ZD;; External date format in Y
 ;;S Y=$ZD($H,1)
