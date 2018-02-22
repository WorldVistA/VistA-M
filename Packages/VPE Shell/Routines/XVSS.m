XVSS ; Paideia/SMH,TOAD - VPE Symbol Table Save ;2017-08-16  10:59 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; (c) 2010-2016 Sam Habiel
 ; Sam's Notes: = ^XVEMS("ZS")
SAVE ; Save XVV variables (= ZS1,7,9)
ZS1 ;
 N %,LIST,VAR
 S ^XVEMS("%",$J_$G(^XVEMS("SY")))=+$H_"^Scratch Area"
 S ^XVEMS("%",$J_$G(^XVEMS("SY")),"SV")=""
 S LIST="XVV(""ID"")^XVV(""EON"")^XVV(""EOFF"")^XVV(""IOF"")^XVV(""IOSL"")^XVV(""OS"")^XVV(""IO"")^XVV(""IOM"")^XVV(""TRMON"")^XVV(""TRMOFF"")^XVV(""TRMRD"")^XVV(""$ZE"")"
 F %=1:1:$L(LIST,"^") D
 . S VAR=$P(LIST,"^",%)
 . S ^("SV")=^("SV")_$S($D(@VAR)#2:@VAR,1:"")_"^"
 QUIT
RESTORE ; Restore XVV variables (= ZS2,8,9)
ZS2 ;
 Q:$G(^XVEMS("%",$J_$G(^XVEMS("SY")),"SV"))=""
 N %,LIST
 S LIST="XVV(""ID"")^XVV(""EON"")^XVV(""EOFF"")^XVV(""IOF"")^XVV(""IOSL"")^XVV(""OS"")^XVV(""IO"")^XVV(""IOM"")^XVV(""TRMON"")^XVV(""TRMOFF"")^XVV(""TRMRD"")^XVV(""$ZE"")"
 F %=1:1:$L(LIST,"^") S @($P(LIST,"^",%)_"=$P(^XVEMS(""%"",$J_$G(^XVEMS(""SY"")),""SV""),""^"",%)")
 QUIT
RESET ; Reset XVV variables and backspace (ZS3)
ZS3 ;
 D RESTORE
 D BS^XVEMKY1 ; backspace
 NEW I
 F I=1:1:9 KILL @("%"_I) ; kill parameter variables
 QUIT
SAVECLH ; Save Command Line History (ZS5)
ZS5 ;
 S X=$G(^XVEMS("CLH",XVV("ID"),"VSHL"))+1 ; increment counter
 S ^("VSHL")=X ; save counter
 S ^("VSHL",X)=XVVSHC ; save command
 ; kill 21st command in fifo list
 I X>20 S X=$O(^XVEMS("CLH",XVV("ID"),"VSHL","")) KILL ^(X)
 QUIT
PROCCLH ; Process storage of CLH (ZS4,6)
ZS4 ;
 ; don't store commands that are in sq brakets or a halt command
 Q:XVVSHC?1"<".E1">"!(",^,H,h,HALT,halt,"[(","_XVVSHC_","))
 NEW CHK,X ; check to see if the command is already there
 S CHK=0
 S X=$G(^XVEMS("CLH",XVV("ID"),"VSHL")) ; grab the highest number stored
 ; if that subscript or the one below it has the command,
 ; don't store it.
 I X>0,$G(^XVEMS("CLH",XVV("ID"),"VSHL",X))=XVVSHC!($G(^(X-1))=XVVSHC) S CHK=1
 Q:CHK
 D SAVECLH
 Q
