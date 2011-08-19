%ZTER1 ;ISC-SF.SEA/JLI - ERROR TRAP TO LOG ERRORS (VAX LOCAL SYMBOL TABLE) ;11/23/2005
 ;;8.0;KERNEL;**18,24,36,49,112,162,275,392**;JUL 10, 1995;Build 5
VXD ;Record VAX DSM variables
 S @%ZTERRT@("J")=$J_"^"_$ZC(%GETJPI,0,"PRCNAM")_"^"_$ZC(%GETJPI,0,"USERNAME")_"^"_%ZTER11I_"^"_$ZC(%SYSFAO,"!XL",$J),@%ZTERRT@("I")=$IO_"^"_$ZA_"^"_$ZB_"^"_$ZIO K %ZTER11I
 S @%ZTERRT@("ZH")=$TR($ZH,",","^")
 S %ZTER111="%" F  D  S %ZTER111=$ZSORT(@%ZTER111) Q:%ZTER111=""  ;Code from DEC
 . Q:$E(%ZTER111,1,5)="%ZTER"
 . I $D(@%ZTER111)#2 D VNXT2
 . I $D(@%ZTER111)>9 D VNXT3
 . Q
 Q
 ;
VNXT2 S %ZTERCNT=%ZTERCNT+1,@%ZTERRT@("ZV",%ZTERCNT,0)=%ZTER111,^("D")=$E(@%ZTER111,1,255)
 Q
VNXT3 S %ZTER11Q=%ZTER111
 F  S %ZTER11Q=$Q(@%ZTER11Q) Q:%ZTER11Q=""  S %ZTERCNT=%ZTERCNT+1,@%ZTERRT@("ZV",%ZTERCNT,0)=%ZTER11Q,^("D")=$E(@%ZTER11Q,1,255)
 Q
 ;
STACK ;Record the new $STACK variable
 I $ECODE]"" S $ZE=""
 N %ZTER35 S %ZTER35=$S($D(^TMP("$ZE",$J,2)):^(2),1:$ETRAP)
 D SAVE("$DEVICE",$DEVICE)
 D SAVE("$ECODE",$E($ECODE,1,255))
 D SAVE("$ESTACK",$ESTACK)
 D SAVE("$ETRAP",%ZTER35)
 D SAVE("$QUIT",$QUIT)
 D SAVE("$STACK",$STACK)
 N %,%1,%2 S %2=$ST
 F %=0:1:$ST S %1=$E(1000+%,2,4) Q:$ST(%,"PLACE")["^%ZTER"  D
 . D SAVE("$STACK("_%1_")",$STACK(%))
 . D SAVE("$STACK("_%1_",""ECODE"")",$STACK(%,"ECODE"))
 . D SAVE("$STACK("_%1_",""PLACE"")",$STACK(%,"PLACE"))
 . D SAVE("$STACK("_%1_",""MCODE"")",$STACK(%,"MCODE"))
 . S:$STACK(%,"ECODE")]"" %2=%
 S @%ZTERRT@("LINE")=$STACK(%2,"MCODE")
 S $ECODE=""
 Q
 ;
SAVE(%n,%v) ;Save name and value into global, use special variables
 S %ZTERCNT=%ZTERCNT+1,@%ZTERRT@("ZV",%ZTERCNT,0)=%n
 S @%ZTERRT@("ZV",%ZTERCNT,"D")=%v
 Q
 ;
VERR ;
 S @%ZTERRT@("ZE2")="%DSM-E-ET, Error occurred in %ZTER, "_$ECODE
 HALT
