ZOSFGTM ;ISF/staff - ZOSF Table for GT.M for VMS ;10/18/06  14:28
 ;;8.0;KERNEL;**275,425**;Jul 10, 1995;Build 18
 ; for GT.M for VMS, version 4.3
 ;
 S %Y=1,DTIME=$G(DTIME,600)
 K ^%ZOSF("MASTER"),^%ZOSF("SIGNOFF")
 I '$D(^%ZOSF("VOL")) S ^%ZOSF("VOL")="ROU"
 K ZO F I="MGR","PROD","VOL" S:$D(^%ZOSF(I)) ZO(I)=^%ZOSF(I)
 F I=1:2 S Z=$P($T(Z+I),";;",2) Q:Z=""  D
 . S X=$P($T(Z+1+I),";;",2,99)
 . S ^%ZOSF(Z)=$S($D(ZO(Z)):ZO(Z),1:X)
 . Q
 ;
OS S ^%ZOSF("OS")="GT.M (VMS)^17"
MGR W !,"NAME OF MANAGER'S UCI,VOLUME SET: "_^%ZOSF("MGR")_"// " R X:DTIME I X]"" X ^("UCICHECK") G MGR:0[Y S ^%ZOSF("MGR")=X
PROD ;
 W !,"The value of PRODUCTION will be used in the GETENV api."
 W !,"PRODUCTION (SIGN-ON) UCI,VOLUME SET: "_^%ZOSF("PROD")_"// " R X:DTIME I X]"" X ^("UCICHECK") G PROD:0[Y S ^%ZOSF("PROD")=X
 ;See that VOL and PROD agree.
 I ^%ZOSF("PROD")'[^%ZOSF("VOL") S ^%ZOSF("VOL")=$P(^%ZOSF("PROD"),",",2)
VOL W !,"The VOLUME name must match the one in PRODUCTION."
 W !,"NAME OF VOLUME SET: "_^%ZOSF("VOL")_"//" R X:DTIME
 I X]"" D  I X'?3U W "MUST BE 3 Upper case." G VOL
 . I ^%ZOSF("PROD")'[X W !,"Must match PRODUCTION"
 . S:X?3U ^%ZOSF("VOL")=X
 W !,"^%ZOSF setup"
 Q
 ;
Z ;
 ;;ACTJ
 ;;S Y=$$ACTJ^%ZOSV()
 ;;AVJ
 ;;S Y=$$AVJ^%ZOSV()
 ;;BRK
 ;;U $I:(CENABLE)
 ;;DEL
 ;;D DEL^%ZOSV2(X) ;N %DIR S %DIR=$P($ZRO,",") ZSYSTEM "DEL "_%DIR_X_".m;*" ZSYSTEM "DEL "_%DIR_X_".obj;*"
 ;;EOFF
 ;;U $I:(NOECHO)
 ;;EON
 ;;U $I:(ECHO)
 ;;EOT
 ;;S Y=$ZA\1024#2 ; <=====
 ;;ERRTN
 ;;^%ZTER
 ;;ETRP
 ;;Q
 ;;GD
 ;;G ^%GD
 ;;$INC
 ;;0
 ;;JOBPARAM
 ;;G JOBPAR^%ZOSV
 ;;LABOFF
 ;;U IO:(NOECHO)
 ;;LOAD
 ;;D LOAD^%ZOSV2(X) ;N % S %N=0 F XCNP=XCNP+1:1 S %N=%N+1,%=$T(+%N^@X) Q:$L(%)=0  S @(DIF_XCNP_",0)")=%
 ;;LPC;;Longitudinal Parity Check (Exclusive OR of the 8-bit bytes)
 ;;S Y=$$LPC^%ZOSV(X)
 ;;MAGTAPE
 ;;S %MT("BS")="*1",%MT("FS")="*2",%MT("WTM")="*3",%MT("WB")="*4",%MT("REW")="*5",%MT("RB")="*6",%MT("REL")="*7",%MT("WHL")="*8",%MT("WEL")="*9" ; <=====
 ;;MAXSIZ
 ;;Q
 ;;MGR
 ;;VAH,ROU
 ;;MTBOT
 ;;S Y=$ZA\32#2 ; <=====
 ;;MTERR
 ;;S Y=$ZA\32768#2 ; <=====
 ;;MTONLINE
 ;;S Y=$ZA\64#2 ; <=====
 ;;MTWPROT
 ;;S Y=$ZA\4#2 ; <=====
 ;;NBRK
 ;;U $I:(NOCENABLE)
 ;;NO-PASSALL
 ;;U $I:(ESCAPE:TERMINATOR="":NOPASTHRU)
 ;;NO-TYPE-AHEAD
 ;;U $I:(NOTYPEAHEAD)
 ;;PASSALL
 ;;U $I:(NOESCAPE:NOTERMINATOR:PASTHRU)
 ;;PRIINQ
 ;;S Y=$$PRIINQ^%ZOSV()
 ;;PRIORITY
 ;;Q  ;G PRIORITY^%ZOSV
 ;;PROD
 ;;VAH,ROU
 ;;PROGMODE
 ;;S Y=$$PROGMODE^%ZOSV()
 ;;RD
 ;;G ^%RD
 ;;RESJOB
 ;;Q:'$D(DUZ)  Q:'$D(^XUSEC("XUMGR",+DUZ))  W !!,"From VMS use: mupip stop /id=pid",!
 ;;RM
 ;;U $I:WIDTH=$S(X<256:X,1:0)
 ;;RSEL
 ;;N %ZR,X K ^UTILITY($J) D ^%RSEL S X="" X "F  S X=$O(%ZR(X)) Q:X=""""  S ^UTILITY($J,X)="""""
 ;;RSUM
 ;;N %,%1,%2,%3 S Y=0 F %=1,3:1 S %1=$T(+%^@X),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*%2+Y
 ;;RSUM1
 ;;N %,%1,%2,%3 S Y=0 F %=1,3:1 S %1=$T(+%^@X),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*(%2+%)+Y
 ;;SS
 ;;D ^ZSY
 ;;SAVE
 ;;D SAVE^%ZOSV2(X) ;N %I,%F,SP S %I=$I,SP=" ",%F=$P($ZRO,",")_X_".m" O %F:(NEWVERSION) U %F X "F  S XCN=$O(@(DIE_XCN_"")"")) Q:XCN'>0  S %=@(DIE_XCN_"",0)"") Q:$E(%,1)=""$""  I $E(%)'="";"" W $P(%,SP)_$C(9)_$P(%,SP,2,99999),!" C %F U %I
 ;;SIZE
 ;;N %,I S Y=0 F I=1:1 S %=$T(+I^@X) Q:%=""  S Y=Y+$L(%)+2
 ;;TEST
 ;;I X]"",$L($$TEST^%ZOSV2(X))
 ;;TMK
 ;;S Y=$ZA\16384#2
 ;;TRAP
 ;;$ZT="G "_X
 ;;TRMOFF
 ;;U $I:(TERMINATOR="":NOPASTHRU:ESCAPE)
 ;;TRMON
 ;;U $I:(TERMINATOR=$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127):NOESCAPE:PASTHRU)
 ;;TRMRD
 ;;S Y=$A($ZB)
 ;;TYPE-AHEAD
 ;;U $I:(TYPEAHEAD)
 ;;UCI
 ;;S Y=^%ZOSF("PROD")
 ;;UCICHECK
 ;;S Y=1
 ;;UPPERCASE
 ;;S Y=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;;XY
 ;;S $X=DX,$Y=DY
 ;;VOL
 ;;ROU
 ;;ZD;;Input X, output Y.
 ;;S Y=$ZDATE(X) ;$$HTE^XLFDT(X,2) I $L($P(Y,"/"))=1 S Y=0_Y
