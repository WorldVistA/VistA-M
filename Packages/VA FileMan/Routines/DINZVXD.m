DINZVXD ;SFISC/MVB-SETS %ZOSF FOR VAX DSM(V6) ;1:10 PM  30 Sep 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 K ^%ZOSF("MASTER"),^%ZOSF("SIGNOFF")
 F I=1:2 S Z=$P($T(Z+I),";;",2) Q:Z=""  S X=$P($T(Z+1+I),";;",2,99),^%ZOSF(Z)=X
 K I,X,Z
 Q
 ;
Z ;
 ;;OS
 ;;DSM for OpenVMS^16
 ;;ACTJ
 ;;S Y=$$ACTJ^%ZOSV()
 ;;AVJ
 ;;S Y=$$AVJ^%ZOSV()
 ;;BRK
 ;;U $I:CENABLE
 ;;DEL
 ;;X "ZR  ZS @X"
 ;;EOFF
 ;;U $I:NOECHO
 ;;EON
 ;;U $I:ECHO
 ;;EOT
 ;;S Y=$ZA\1024#2
 ;;ERRTN
 ;;^%ZTER
 ;;ETRP
 ;;Q
 ;;GD
 ;;G ^%GD
 ;;JOBPARAM
 ;;S Y=$$INFO^%SY(X),Y=$P(Y,",",1,2)
 ;;LABOFF
 ;;U IO:NOECHO
 ;;LOAD
 ;;S %N=0 X "ZL @X F XCNP=XCNP+1:1 S %N=%N+1,%=$T(+%N) Q:$L(%)=0  S @(DIF_XCNP_"",0)"")=%"
 ;;LPC
 ;;S Y=$ZC(%LPC,X)
 ;;MAGTAPE
 ;;S %MT("BS")="*1",%MT("FS")="*2",%MT("WTM")="*3",%MT("WB")="*4",%MT("REW")="*5",%MT("RB")="*6",%MT("REL")="*7",%MT("WHL")="*8",%MT("WEL")="*9"
 ;;MAXSIZ
 ;;Q
 ;;MTBOT
 ;;S Y=$ZA\32#2
 ;;MTERR
 ;;S Y=$ZA\32768#2
 ;;MTONLINE
 ;;S Y=$ZA\64#2
 ;;MTWPROT
 ;;S Y=$ZA\4#2
 ;;NBRK
 ;;U $I:NOCENABLE
 ;;NO-PASSALL
 ;;G NOPASS^%ZOSV
 ;;NO-TYPE-AHEAD
 ;;U $I:NOTYPE
 ;;PASSALL
 ;;G PASSALL^%ZOSV
 ;;PRIINQ
 ;;S Y=$$PRIINQ^%ZOSV()
 ;;PRIORITY
 ;;Q  ;G PRIORITY^%ZOSV
 ;;PROGMODE
 ;;S Y=$$PROGMODE^%ZOSV()
 ;;RD
 ;;G ^%RD
 ;;RESJOB
 ;;Q:'$D(DUZ)  Q:'$D(^XUSEC("XUMGR",+DUZ))  N XQZ S XQZ="^FORCEX[MGR]" D DO^%XUCI
 ;;RM
 ;;U $I:WIDTH=$S(X<256:X,1:0)
 ;;RSEL
 ;;K ^UTILITY($J) D ^%RSEL M ^UTILITY($J)=%UTILITY K %UTILITY
 ;;RSUM
 ;;ZL @X S Y=0 F %=1,3:1 S %1=$T(+%),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*%2+Y
 ;;SS
 ;;G ^%SY
 ;;SAVE
 ;;S XCS="F XCM=1:1 S XCN=$O(@(DIE_XCN_"")"")) Q:+XCN'=XCN  S %=^(XCN,0) Q:$E(%,1)=""$""  I $E(%,1)'="";"" ZI %" X "ZR  X XCS ZS @X" S ^UTILITY("ROU",X)="" K XCS
 ;;SIZE
 ;;S Y=0 F I=1:1 S %=$T(+I) Q:%=""  S Y=Y+$L(%)+2
 ;;TEST
 ;;I $D(^ (X))!$D(^!(X))
 ;;TMK
 ;;S Y=$ZA\16384#2
 ;;TRAP
 ;;$ZT=X
 ;;TRMOFF
 ;;U $I:TERM=""
 ;;TRMON
 ;;U $I:TERM=$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127)
 ;;TRMRD
 ;;S Y=$ZB
 ;;TYPE-AHEAD
 ;;U $I:TYPE
 ;;UCI
 ;;S Y=$ZC(%UCI),Y=$P(Y,",",1)_","_$P(Y,",",4)
 ;;UCICHECK
 ;;S Y=$$UCICHECK^%ZOSV(X)
 ;;UPPERCASE
 ;;S Y=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;;XY
 ;;S $X=DX,$Y=DY
 ;;ZD
 ;;N % S Y=$ZC(%CDATASC,+X,1) F %=1:1:3 I $L($P(Y,"/",%))<2 S $P(Y,"/",%)=0_$P(Y,"/",%)
