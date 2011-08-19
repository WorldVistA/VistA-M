ZOSFONT ;SFISC/AC - SETS UP ^%ZOSF for Cache for NT/VMS ;10/19/06  14:01
 ;;8.0;KERNEL;**34,104,365**;JUL 10, 1995;Build 5
 ;For Cache versions 3.2, 4 and 5
 S %Y=1 K ^%ZOSF("MASTER"),^%ZOSF("SIGNOFF")
 N ZO F I="MGR","PROD","VOL" S:$D(^%ZOSF(I)) ZO(I)=^%ZOSF(I)
 F I=1:2 S Z=$P($T(Z+I),";;",2) Q:Z=""  S X=$P($T(Z+1+I),";;",2,99) S ^%ZOSF(Z)=$S($D(ZO(Z)):ZO(Z),1:X)
 ;
MGR W !,"NAME OF MANAGER'S NAMESPACE: "_^%ZOSF("MGR")_"// " R X:$S($G(DTIME):DTIME,1:9999) I X]"" X ^("UCICHECK") G MGR:0[Y S ^%ZOSF("MGR")=X
PROD W !,"PRODUCTION (SIGN-ON) NAMESPACE: "_^%ZOSF("PROD")_"// " R X:$S($G(DTIME):DTIME,1:9999) I X]"" X ^("UCICHECK") G PROD:0[Y S ^%ZOSF("PROD")=Y
VOL W !,"NAME OF THIS CONFIGURATION: "_^%ZOSF("VOL")_"//" R X:$S($G(DTIME):DTIME,1:9999) I X]"" S:X?1.22U ^%ZOSF("VOL")=X I X'?1.22U W "MUST BE 1-22 uppercase characters." G VOL
 ;
OS S $P(^%ZOSF("OS"),"^",1)="OpenM-NT" S:'$P(^%ZOSF("OS"),"^",2) $P(^%ZOSF("OS"),"^",2)=18
 ;For Cache 5.1 and above
 I $$VERSION^ZOSVONT>5 S ^%ZOSF("GSEL")="K ^CacheTempJ($J),^UTILITY($J) D ^%SYS.GSET M ^UTILITY($J)=CacheTempJ($J)"
 W !!,"ALL SET UP",!! Q
Z ;;
 ;;ACTJ
 ;;S Y=$$ACTJ^%ZOSV()
 ;;AVJ
 ;;S Y=$$AVJ^%ZOSV()
 ;;BRK
 ;;U $I:("":"+B")
 ;;DEL
 ;;X "ZR  ZS @X"
 ;;EOFF
 ;;U $I:("":"+S")
 ;;EON
 ;;U $I:("":"-S")
 ;;EOT
 ;;S Y=$ZA\1024#2
 ;;ERRTN
 ;;^%ZTER
 ;;ETRP
 ;;Q
 ;;GD
 ;;D ^%GD
 ;;GSEL;Select Globals
 ;;K ^UTILITY($J) D ^%GSET
 ;;JOBPARAM
 ;;D JOBPAR^%ZOSV
 ;;LABOFF
 ;;U IO:("":"+S+I-T":$C(13,27))
 ;;LOAD
 ;;N %,%N S %N=0 X "ZL @X F XCNP=XCNP+1:1 S %N=%N+1,%=$T(+%N) Q:$L(%)=0  S @(DIF_XCNP_"",0)"")=%"
 ;;LPC
 ;;S Y=$ZC(X)
 ;;MAXSIZ
 ;;S $ZS=X+X
 ;;MGR
 ;;%SYS
 ;;MAGTAPE
 ;;S %MT("BS")="*-1",%MT("FS")="*-2",%MT("WTM")="*-3",%MT("WB")="*-4",%MT("REW")="*-5",%MT("RB")="*-6",%MT("REL")="*-7",%MT("WHL")="*-8",%MT("WEL")="*-9"
 ;;MTBOT
 ;;S Y=$ZA\32#2
 ;;MTONLINE
 ;;S Y=$ZA\64#2
 ;;MTWPROT
 ;;S Y=$ZA\4#2
 ;;MTERR;;MAGTAPE ERROR
 ;;S Y=$ZA\32768#2
 ;;NBRK
 ;;U $I:("":"-B")
 ;;NO-PASSALL
 ;;U $I:("":"-I+T")
 ;;NO-TYPE-AHEAD
 ;;U $I:("":"+F":$C(13,27))
 ;;PASSALL
 ;;U $I:("":"+I-T")
 ;;PRIINQ;; Priority in current queue
 ;;N %PRIO D ^%PRIO S Y=$S('%PRIO:5,%PRIO>0:8,1:3)
 ;;PRIORITY;;set priority to X (1=low, 10=high)
 ;;D @($S(X>7:"NORMAL",X>3:"NORMAL",1:"LOW")_"^%PRIO") ;Don't do HIGH
 ;;PROGMODE
 ;;S Y=$ZJOB#2
 ;;PROD
 ;;VAH
 ;;RD
 ;;D ^%RD
 ;;RESJOB
 ;;N OLD S OLD=$ZNSPACE ZNSPACE "%SYS" D ^RESJOB ZNSPACE OLD Q
 ;;RM
 ;;I $G(IOT)["TRM" U $I:X
 ;;RSEL;;ROUTINE SELECT
 ;;K ^UTILITY($J) D KERNEL^%RSET K %ST ;Special entry point for VA
 ;;RSUM
 ;;N %,%1,%3 ZL @X S Y=0 F %=1,3:1 S %1=$T(+%),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*%2+Y
 ;;RSUM1
 ;;N %,%1,%3 ZL @X S Y=0 F %=1,3:1 S %1=$T(+%),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*(%2+%)+Y
 ;;SS
 ;;D ^%SS
 ;;SAVE
 ;;N XCS S XCS="F XCM=1:1 S XCN=$O(@(DIE_XCN_"")"")) Q:+XCN'=XCN  S %=^(XCN,0) Q:$E(%,1)=""$""  I $E(%,1)'="";"" ZI %" X "ZR  X XCS ZS @X"
 ;;SIZE
 ;;S Y=0 F I=1:1 S %=$T(+I) Q:%=""  S Y=Y+$L(%)+2
 ;;TEST
 ;;I X?1(1"%",1A).7AN,$D(^$ROUTINE(X))
 ;;TMK;;MAGTAPE MARK
 ;;S Y=$ZA\4#2
 ;;TRAP;;S X="^%ET",@^%ZOSF("TRAP"); User $ETRAP
 ;;$ZT=X
 ;;TRMOFF
 ;;U $I:("":"-I-T":$C(13,27))
 ;;TRMON
 ;;U $I:("":"+I+T")
 ;;TRMRD;;old Y=$A($ZB),Y=$S(Y<32:Y,Y=127:Y,1:0)
 ;;S Y=$A($ZB),Y=$S(Y<32:Y,Y=127:Y,1:0)
 ;;TYPE-AHEAD
 ;;U $I:("":"-F":$C(13,27))
 ;;UCI
 ;;D UCI^%ZOSV
 ;;UCICHECK
 ;;S Y=$$UCICHECK^%ZOSV(X)
 ;;UPPERCASE
 ;;S Y=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;;XY
 ;;S $X=DX,$Y=DY
 ;;VOL;;VOLUME SET NAME
 ;;ROU
 ;;ZD;;$H to external
 ;;S Y=$ZD(X)
