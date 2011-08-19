ZOSFVXD ;SFISC/MVB - ZOSF TABLE FOR VAX DSM V3.3, V4 & V6 ;06/30/97  15:23
 ;;8.0;KERNEL;**65**;JUL 03, 1995
 ;Remember to update XGKB for escape processing.
 S %Y=1 K ^%ZOSF("MASTER"),^%ZOSF("SIGNOFF")
 I '$D(^%ZOSF("VOL")) S ^%ZOSF("VOL")=$P($ZC(%UCI),",",4)
 K ZO F I="MGR","PROD","VOL" S:$D(^%ZOSF(I)) ZO(I)=^%ZOSF(I)
 F I=1:2 S Z=$P($T(Z+I),";;",2) Q:Z=""  S X=$P($T(Z+1+I),";;",2,99) S:Z="OS" $P(^%ZOSF(Z),"^")=X I Z'="OS" S ^%ZOSF(Z)=$S($D(ZO(Z)):ZO(Z),1:X)
 ;
OS S:'$P(^%ZOSF("OS"),"^",2) $P(^%ZOSF("OS"),"^",2)=16
MGR W !,"NAME OF MANAGER'S UCI,VOLUME SET: "_^%ZOSF("MGR")_"// " R X:$S($G(DTIME):DTIME,1:9999) I X]"" X ^("UCICHECK") G MGR:0[Y S ^%ZOSF("MGR")=X
PROD W !,"PRODUCTION (SIGN-ON) UCI,VOLUME SET: "_^%ZOSF("PROD")_"// " R X:$S($G(DTIME):DTIME,1:9999) I X]"" X ^("UCICHECK") G PROD:0[Y S ^%ZOSF("PROD")=Y
VOL W !,"NAME OF VOLUME SET: "_^%ZOSF("VOL")_"//" R X:$S($G(DTIME):DTIME,1:9999) I X]"" S:X?3U ^%ZOSF("VOL")=X I X'?3U W "MUST BE 3 Upper case." G VOL
 W ! Q
V4 S $P(^%ZOSF("OS"),"^",1)="VAX DSM(V4)"
 S ^("JOBPARAM")="S Y="""" Q" ; S Y=JOB X'S UCI,VOLUMESET
 S ^("TEST")="N %,Y S %=$P($ZC(%PGMSHOW),"","") O %:(INDEXED:READONLY) U %:KEY=$E($C(0)_X_$C(0,0,0,0,0,0,0,0),1,9) R Y C % I $L(Y)"
 Q
Z ;
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
 ;;MGR
 ;;MGR,AAA
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
 ;;OS
 ;;VAX DSM(V6)
 ;;PASSALL
 ;;G PASSALL^%ZOSV
 ;;PRIINQ
 ;;S Y=$$PRIINQ^%ZOSV()
 ;;PRIORITY
 ;;Q  ;G PRIORITY^%ZOSV
 ;;PROD
 ;;VAH,AAA
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
 ;;VOL
 ;;AAA
 ;;ZD
 ;;N % S Y=$ZC(%CDATASC,+X,1) F %=1:1:3 I $L($P(Y,"/",%))<2 S $P(Y,"/",%)=0_$P(Y,"/",%)
