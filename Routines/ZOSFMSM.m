ZOSFMSM ;SFISC/AC - SETS UP ^%ZOSF FOR MSM-UNIX SYSTEMS ;8/1/94  11:16
 ;;8.0;KERNEL;;JUL 03, 1995
 S %Y=1 K ^%ZOSF("MASTER"),^%ZOSF("SIGNOFF")
 I '$D(^%ZOSF("VOL")) S ^%ZOSF("VOL")=$P($ZU(0),",",2)
 K ZO F I="MGR","PROD","VOL" S:$D(^%ZOSF(I)) ZO(I)=^%ZOSF(I)
 F I=1:2 S Z=$P($T(Z+I),";;",2) Q:Z=""  S X=$P($T(Z+1+I),";;",2,99) S ^%ZOSF(Z)=$S($D(ZO(Z)):ZO(Z),1:X)
MGR W !,"NAME OF MANAGER'S UCI,VOLUME GROUP: "_^%ZOSF("MGR")_"// " R X:$S($G(DTIME):DTIME,1:9999) S:X="" X=^%ZOSF("MGR") X ^("UCICHECK") I 0[Y W *7," ??" G MGR
 S ^%ZOSF("MGR")=Y
PROD W !,"PRODUCTION (SIGN-ON) UCI,VOLUME GROUP: "_^%ZOSF("PROD")_"// " R X:$S($G(DTIME):DTIME,1:9999) S:X="" X=^%ZOSF("PROD") X ^("UCICHECK") I 0[Y W *7," ??" G PROD
 S ^%ZOSF("PROD")=Y
VOL W !,"NAME OF THIS VOLUME GROUP: "_^%ZOSF("VOL")_"// " R X:$S($G(DTIME):DTIME,1:9999) I X]"" S:X?3U ^%ZOSF("VOL")=X I X'?3U W "MUST BE 3 UPPER case." G VOL
OS S $P(^%ZOSF("OS"),"^")=$S($ZV["MSM":$P($ZV,","),1:"MSM") S:'$P(^%ZOSF("OS"),"^",2) $P(^%ZOSF("OS"),"^",2)=8
 W !!,"ALL SET UP",!! Q
 ;
Z ;;
 ;;ACTJ
 ;;S Y=$$ACTJ^%ZOSV()
 ;;AVJ
 ;;S Y=$$AVJ^%ZOSV()
 ;;BRK
 ;;B 1
 ;;CPU
 ;;Q
 ;;DEL
 ;;X "ZR  ZS @X" K ^UTILITY("%RD",X)
 ;;EOFF
 ;;U $I:(::::1)
 ;;EON
 ;;U $I:(:::::1)
 ;;EOT
 ;;S Y=$ZA\1024#2
 ;;ERRTN
 ;;^%ZTER
 ;;ETRP
 ;;Q
 ;;GD
 ;;D ^%GD
 ;;LABOFF
 ;;U IO:(::::1)
 ;;JOBPARAM
 ;;G JOBPAR^%ZOSV
 ;;LOAD
 ;;S %N=0 X "ZL @X F XCNP=XCNP+1:1 S %N=%N+1,%=$T(+%N) Q:$L(%)=0  S @(DIF_XCNP_"",0)"")=%"
 ;;LPC;;Parity Check - ASCII sum
 ;;S Y=$ZCRC(X)
 ;;MAXSIZ
 ;;S %K=X D INT^%PARTSIZ
 ;;MGR
 ;;MGR,AAA
 ;;MAGTAPE
 ;;S %MT("BS")="*1",%MT("FS")="*2",%MT("WTM")="*3",%MT("WB")="*4",%MT("REW")="*5",%MT("RB")="*6",%MT("REL")="*7",%MT("WHL")="*8",%MT("WEL")="*9"
 ;;MTBOT
 ;;S Y=$ZA#2
 ;;MTERR
 ;;S Y=($ZA\256#8)+($ZA\4096#8)
 ;;MTONLINE
 ;;S Y=$ZA\16#4=3
 ;;MTWPROT
 ;;S Y=$ZA\2048#2
 ;;NBRK
 ;;B 0
 ;;NO-PASSALL
 ;;U $I:(:::::8388608)
 ;;NO-TYPE-AHEAD
 ;;U $I:(::::100663296)
 ;;PASSALL
 ;;U $I:(::::8388608)
 ;;PRIINQ
 ;;S Y=$$PRIINQ^%ZOSV()
 ;;PRIORITY
 ;;G PRIORITY^%ZOSV
 ;;PROD
 ;;VAH,AAA
 ;;PROGMODE
 ;;S Y=$$PROGMODE^%ZOSV()
 ;;RD
 ;;D ^%RD
 ;;RESJOB
 ;;Q:'$D(DUZ)  Q:'$D(^XUSEC("XUMGR",+DUZ))  N XQZ S XQZ="^KILLJOB[MGR]" D DO^%XUCI
 ;;RM
 ;;U:IOT["TRM" $I:X
 ;;RSEL
 ;;K ^UTILITY($J) G ^%RSEL
 ;;RSUM
 ;;ZL @X S Y=0 F %=1,3:1 S %1=$T(+%),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*%2+Y
 ;;SAVE
 ;;S XCS="F XCM=1:1 S XCN=$O(@(DIE_XCN_"")"")) Q:+XCN'=XCN  S %=^(XCN,0) Q:$E(%,1)=""$""  I $E(%,1)'="";"" ZI %" X "ZR  X XCS ZS @X" S ^UTILITY("%RD",X)="" K XCS
 ;;SIZE
 ;;S Y=0 F I=1:1 S %=$T(+I) Q:%=""  S Y=Y+$L(%)+2
 ;;SS
 ;;D ^%SS
 ;;TEST
 ;;I $D(^ (X))
 ;;TMK
 ;;S Y=$ZA\128#2
 ;;TRAP
 ;;$ZT=X
 ;;TRMOFF
 ;;U $I:(::::::::$C(13,27))
 ;;TRMON
 ;;U $I:(::::::::$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127))
 ;;TRMRD
 ;;S Y=$ZB
 ;;TYPE-AHEAD
 ;;U $I:(::::67108864:33554432)
 ;;UCI
 ;;S Y=$ZU(0)
 ;;UCICHECK
 ;;S Y=$$UCICHECK^%ZOSV(X)
 ;;UPPERCASE
 ;;S Y=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;;VOL
 ;;AAA
 ;;XY
 ;;U $I:(::::::DY*256+DX)
 ;;ZD
 ;;S Y=$ZD(X)
