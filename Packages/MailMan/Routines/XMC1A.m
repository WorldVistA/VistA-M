XMC1A ;(WASH ISC)/THM-Script Interpreter (Look) ;12/04/2002  15:04
 ;;8.0;MailMan;**11**;Jun 28, 2002
 ;LOOK For Text
 ; 
 ;  There can only be one 'B' in a LOOK command.  It may be preceeded by
 ;  at least one 'A' and succeeded by as many 'C's as desired.
 ;  The 'B' parameter may be null.  In this case two spaces would 
 ;  separate the 'A' parameters for the 'C' parameters.
 ;
 ;X=SCRIPT COMMAND 'L:Timeout A A A ... B C C C ...'
 ;
 ;The string represented by 'x' must always have a length >0.
 ;The string being looked for must always be surrounded by '|'s.
 ;To use the new form, the looked for strings must be surrounded by '|'s.
 ;    If no '|'s are found, it is assumed to be of the old form
 ;    (see example 4 below).
 ;There must not be any '|'s for the "OLD" form as the 1st character
 ;     after the 1st space in the string.
 ;The 1st character after the 1st space in the string must be a '|'
 ;     in the "NEW" form.
 ;Condition A is always checked first
 ;
 ;WHERE 'A' (mandatory) has form 'x' / QUIT on finding string 'x'
 ;                 or 'x:y' / GOTO line 'y' on finding 'x'
 ;
 ;WHERE 'C' (optional) has form 'x' / QUIT setting ER=1 on finding 'x'
 ;
 ;WHERE 'B' (optional) has form 'y' / GOTO 'y' on timeout
 ;
 ;********************************************************************
 ;
 ;Examples:
 ;
 ;    1.  Look for "LINE" or "CONNECTED" on a timeout just error out
 ;        (Where the command is on line 3)
 ;
 ;            L |LINE|:3 |CONNECTED|:3
 ;                   or
 ;            L |LINE| |CONNECTED|
 ;
 ;    2.  Look for "LINE" and if found go to line 15 of this script
 ;        Look for "CONNECTED" and if found go to line 18 of this script.
 ;        Go to line 25 of this script on a time out.
 ;        If "DISCON" is found error out.
 ;
 ;            L |LINE|:15 |CONNECTED|:18 25 |DISCON|
 ;
 ;    3.  Same case as 2 except that on a timeout just error out.
 ;
 ;            L |LINE|:15 |CONNECTED|:18  |DISCON|
 ;
 ;        (Note that '18' is followed by 2 spaces [Timeout is null])
 ;
 ;    4.  Look for 'ON LINE', then look for the string 'CONNECTED'
 ;
 ;            L |ON LINE|:6 |CONNECTED|
 ;
 ;        This is a little tricky.  The old syntax for looking for a
 ;        string took $P(X," ",2,999) as the argument, where X is the
 ;        entire script command.  To be backwards compatible, there must
 ;        be '|'s surrounding all of the strings being looked for.
 ;
 ;****************************************************************
 ;
 ;     The old syntax still works:
 ;
 ;     L ON LINE
 ;
 ;     is interpreted in the old way as look for the phrase "ON LINE"
 ;
 ;*****************************************************************
 ;
 ;  VARIABLES
 ;
 ;XMC1A(,,)   === Array of checks XMC1A(1,,)=success checks
 ;                                XMC1A(2,1,1)=timout (also XMC1A(2))
 ;                                XMC1A(3,,)=failure checks
 ;failure is type 'C', success is type 'A', time-out is Type 'B' above
LOOK ;For Text (See documentation above)
 ; X  = command line from file 4.6
 ;    = 'L:180 220'
 N XMC1A,XMK,XMTIME,C,I,J,Y,%
 S XMC1A("TIMEOUT")=+$P($P(X," "),":",2)
 I 'XMC1A("TIMEOUT") S XMC1A("TIMEOUT")=45
 S XMTIME=$$TSTAMP^XMXUTIL1+XMC1A("TIMEOUT")
 S XMK=1
 S Y=1
 ;Recode encoded control characters
 S XMC1A("LOOK")=XMC1
 I XMC1["~" S XMC1=$$RTRAN^XMCU1(XMC1)
 ;Parse to separate time-outs/success/error conditions
 ;'OLD' form
 I $E(XMC1)'="|",XMC1'?1.N1" |".E S XMC1A(1,1,1)=XMC1,XMC1A(1,1,2)="" G G
 ;'NEW' form
 S I=0
E ;
 S I=I+1
 I Y=1,XMC1?1.N1" |".E D TIMOUT G F
 I Y=1,XMC1?1"  " S Y=2,XMC1=$E(XMC1,3,999) G F
 S %=Y
 S Y=$S(Y=3:Y,Y=2:3,XMC1?1.N1" |".E:2,$E(XMC1,1,2)="  ":3,XMC1?1" "1.N1" ":2,XMC1?1" "1.N:2,Y=1&(I>1)&(XMC1?1.N):2,XMC1?1" |".E:3,1:Y)
 I Y=2 S:$E(XMC1)=" " XMC1=$E(XMC1,2,999) D TIMOUT G F
 S:Y>% I=1
 S X=$P(XMC1,"|",2)
 S XMC1=$E(XMC1,$L($P(XMC1,"|",1,2))+1,999)
 S %=""
 I $E(XMC1,1,2)="|:" S %=$P($P(XMC1," "),":",2),XMC1=$P(XMC1,"|:",2,99) I %,$E(XMC1,1,2)'="  " S XMC1=$P(XMC1," ",2,99) G E1
 I $E(XMC1)="|" S XMC1=$E(XMC1,2,99)
E1 ;
 I $S($L(X):1,$L(%):1,1:0) S XMC1A(Y,I,1)=X,XMC1A(Y,I,2)=%
F ;
 G E:$L(XMC1)
 ;Save Timeout for efficient access
 I $D(XMC1A(2)) S XMC1A(2)=XMC1A(2,1,1)
G ;
 D DOTRAN^XMC1(42240,XMC1A("TIMEOUT"),XMC1A("LOOK")) ;Look: Timeout=|1|, Command String='|2|'
 U IO
 X ^%ZOSF("TRMON")
 S ER=0,Y=^%ZOSF("TRMRD"),XMC1A("TRMRD")="N Y "_Y_" S C=Y Q"
L1 ;
 S Y=""
 D L2
 S XMK=XMK+1
 I XMC("SHOW TRAN")["R" D DOTRAN^XMC1("R: "_Y)
 G LQ:$D(XMC1A("OK"))
 I ER=1 D ERTRAN^XMC1(37001) S J=$G(XMC1A(2)) G LQ:'J S ER=0 G GO ;Time out.
 I XMK>199 D DOTRAN^XMC1(42241) S J=$G(XMC1A(2)) G GO:J S ER=1 Q  ;200 Reads!
 G L1
L2 ;
 N C,X
L3 ;
 X "R X#"_$S(XMC1A("LOOK")[220:3,220-$L(Y)>0:220-$L(Y),1:1)_$S($D(XMDECNET):"",1:":1")
 S Y=Y_X
 X XMC1A("TRMRD")
 I C>0 S Y=Y_"~"_$S(C+64<255:$C(C+64),1:"~")
 F I=1,3 F %=0:0 S %=$O(XMC1A(I,%)) Q:'%  I Y[XMC1A(I,%,1) S J=XMC1A(I,%,2) G GO:J'="",OK:I=1 S ER=1 Q
 I $S($L(Y)>220:1,C=13:1,1:0) Q
 I $$TSTAMP^XMXUTIL1<XMTIME H 1 G L3 ; H 1 added to slow loop
 S ER=1
 Q
LQ ;
 K XMC1A
 X ^%ZOSF("TRMOFF")
 Q
GO ;
 S XMCI=J-.00001
OK ;
 S XMC1A("OK")=1
 Q
TIMOUT ;
 S Y=2,XMC1A(2,1,1)=+XMC1,XMC1=$P(XMC1," ",2,99)
 Q
