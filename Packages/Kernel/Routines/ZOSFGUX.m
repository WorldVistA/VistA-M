ZOSFGUX ;SFISC/MVB,PUG/TOAD,OSE/SMH - ZOSF Table for GT.M for Unix ;2019-12-26  2:33 PM
 ;;8.0;KERNEL;**275,425,10006**;Jul 10, 1995;Build 18
 ;
 ; Original Code written by the VA
 ; *10006 Modifications to update code to be consistent with patch 661 by OSE/SMH
 ; - NOASK entry point for silent setting of nodes
 ; - ONE(X) to set a single node
 ; - Short description for each node
 ; - Nodes: Remove $INC, add GSEL, fix RESJOB, remove commented text
 ; - Remove code in INIT not found in Cache version
 ;
 ; (c) 2019 Sam Habiel
 ;
 ; NB: <===== means that the code has not been tested or has a problem. Not
 ;     sure which.
 ;
 S %Y=1 ; Be verbose and ask the user for stuff
 ;
 I $G(ZTMODE)=2 S %Y=0 ; Patch Load from ZTMGRSET, be silent.
 ;
INIT ;
 S DTIME=$G(DTIME,600)
 N ZO F I="MGR","PROD","VOL","TMP" S:$D(^%ZOSF(I)) ZO(I)=^%ZOSF(I)
 F I=1:2 S Z=$P($T(Z+I),";;",2) Q:Z=""  S X=$P($T(Z+1+I),";;",2,99) S ^%ZOSF(Z)=$S($D(ZO(Z)):ZO(Z),1:X)
OS S ^%ZOSF("OS")="GT.M (Unix)^19"
 I '$G(%Y) QUIT  ; ** EXIT FOR SILENT ENTRY POINT **
 ;
 ; // Interactive Code
 ;
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
TMP ;Get the temp directory
 W !,"The temp directory for the system: '"_^%ZOSF("TMP")_"'//"
 R X:DTIME I $L(X),X'?1"/".E G TMP
 I $L(X) S ^%ZOSF("TMP")=X
 W !,"^%ZOSF setup"
 Q
 ;
 ; // Patch 661 entry points
 ;
NOASK ;Setup %ZOSF without terminal interaction
 S %Y=0
 G INIT
 ;
ONE(X) ;update a single global node
 Q:X=""
 F I=1:2 S Z=$P($T(Z+I),";;",2) Q:Z=""  I Z=X S Y=$P($T(Z+1+I),";;",2,99),^%ZOSF(X)=Y Q
 Q
 ;
 ; // ZOSF nodes
 ;
Z ;;
 ;;ACTJ;;Active Jobs
 ;;S Y=$$ACTJ^%ZOSV()
 ;;AVJ;;Available Jobs
 ;;S Y=$$AVJ^%ZOSV()
 ;;BRK;;Enable Break
 ;;U $I:(CENABLE)
 ;;DEL;;Delete Routine
 ;;D DEL^%ZOSV2(X)
 ;;EOFF;;Echo off
 ;;U $I:(NOECHO)
 ;;EON;;Echo On
 ;;U $I:(ECHO)
 ;;EOT;;End of Tape
 ;;S Y=$ZA\1024#2 ; <=====
 ;;ERRTN;;Error Routine
 ;;^%ZTER
 ;;ETRP;;obsolete
 ;;Q
 ;;GD;;Global Directory
 ;;G ^%GD
 ;;GSEL;;Select Globals
 ;;K ^UTILITY($J) N %ZG D ^%GSEL ZK %ZG M ^UTILITY($J)=%ZG
 ;;JOBPARAM;;Local Job
 ;;G JOBPAR^%ZOSV
 ;;LABOFF;;Special Lab Echo off
 ;;U IO:(NOECHO) ; <=====
 ;;LOAD;;Load Routine
 ;;D LOAD^%ZOSV2(X)
 ;;LPC;;Longitudinal Parity Check
 ;;S Y="" ; <=====
 ;;MAXSIZ;;Set Partition Size
 ;;Q
 ;;MGR
 ;;VAH,ROU
 ;;MAGTAPE;;Sets magtape functions into %MT
 ;;S %MT("BS")="*1",%MT("FS")="*2",%MT("WTM")="*3",%MT("WB")="*4",%MT("REW")="*5",%MT("RB")="*6",%MT("REL")="*7",%MT("WHL")="*8",%MT("WEL")="*9" ; <=====
 ;;MTBOT;;Begining of Tape
 ;;S Y=$ZA\32#2 ; <=====
 ;;MTERR;;Magtape Error
 ;;S Y=$ZA\32768#2 ; <=====
 ;;MTONLINE;;Magtape Online
 ;;S Y=$ZA\64#2 ; <=====
 ;;MTWPROT;;Magtape Write Protected
 ;;S Y=$ZA\4#2 ; <=====
 ;;NBRK;;No break
 ;;U $I:(NOCENABLE)
 ;;NO-PASSALL;;Set terminal to normal text mode
 ;;U $I:(ESCAPE:TERMINATOR="":NOPASTHRU)
 ;;NO-TYPE-AHEAD;;Turn off Type Ahead
 ;;U $I:(NOTYPEAHEAD)
 ;;PASSALL;;Set terminal to pass all codes
 ;;U $I:(NOESCAPE:NOTERMINATOR:PASTHRU)
 ;;PRIINQ;;Priority in current queue
 ;;S Y=$$PRIINQ^%ZOSV()
 ;;PRIORITY;;set priority to X (1=low, 10=high)
 ;;Q  ;G PRIORITY^%ZOSV
 ;;PROD
 ;;VAH,ROU
 ;;PROGMODE;;Checks Programmer Mode
 ;;S Y=$$PROGMODE^%ZOSV()
 ;;RD;;Routine Directory
 ;;G ^%RD
 ;;RESJOB;;Kill job on local node
 ;;Q:'$D(DUZ)  Q:'$D(^XUSEC("XUMGR",+DUZ))  D RESJOB^ZSY
 ;;RM;;Set Right Margin for terminal
 ;;U $I:WIDTH=$S(X<256:X,1:0)
 ;;RSEL;;Routine Select
 ;;K ^UTILITY($J) D ^%RSEL S X="" X "F  S X=$O(%ZR(X)) Q:X=""""  S ^UTILITY($J,X)=""""" K %ZR
 ;;RSUM;;Returns Checksum of Routine
 ;;S Y=0 F %=1,3:1 S %1=$T(+%^@X),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*%2+Y
 ;;RSUM1;;Returns new Checksum of Routine
 ;;N %,%1,%2,%3 S Y=0 F %=1,3:1 S %1=$T(+%^@X),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*(%2+%)+Y
 ;;SS;;System Status
 ;;D ^ZSY
 ;;SAVE;;Save Routine
 ;;D SAVE^%ZOSV2(X)
 ;;SIZE;;Routine size in Bytes
 ;;S Y=0 F I=1:1 S %=$T(+I) Q:%=""  S Y=Y+$L(%)+2
 ;;TEST;;Routine exist
 ;;I X]"",$T(^@X)]""
 ;;TMK;;Magtape Mark
 ;;S Y=$ZA\16384#2
 ;;TMP;;GT.M Temporary Directory
 ;;/tmp/
 ;;TRAP;;Sets Error Trap
 ;;$ZT="G "_X
 ;;TRMOFF;;Terminators off
 ;;U $I:(TERMINATOR="")
 ;;TRMON;;Terminators on
 ;;U $I:(TERMINATOR=$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127))
 ;;TRMRD;;Read Terminator
 ;;S Y=$A($ZB)
 ;;TYPE-AHEAD;;Allows Type-ahead
 ;;U $I:(TYPEAHEAD)
 ;;UCI;;Current UCI
 ;;S Y=^%ZOSF("PROD")
 ;;UCICHECK;;UCI Valid
 ;;S Y=1
 ;;UPPERCASE;;Convert Lower case to Upper case
 ;;S Y=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;;XY;;Set $X & $Y
 ;;S $X=DX,$Y=DY
 ;;VOL;;VOLUME SET NAME
 ;;ROU
 ;;ZD;;$H to external
 ;;S Y=$$HTE^XLFDT(X,2) I $L($P(Y,"/"))=1 S Y=0_Y
