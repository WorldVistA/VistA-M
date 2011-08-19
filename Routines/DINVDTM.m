%ZOSV ;SFISC/AC,LL/DFH,sfisc/fyb ;2:33 PM  1 Oct 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; ** For DataTree **
 ;
ACTJ() ; Active Jobs
 Q $$njobs^%mjob("running")
 ;
AVJ() ; Available Jobs
 Q $$njobs^%mjob("free")
 ;
T0 ; start RT clock
 S XRT0=$H Q
T1 ; store RT datum
 S ^%ZRTL(3,XRTL,+$H,XRTN,$P($H,",",2))=XRT0 K XRT0 Q
MAXJ ; Maximum # of Jobs
 S Y=$$njobs^%mjob("total") Q
 ;
BAUD ; Baud rate of device - used by BAUD field of the Device File
 ; Internal entry of device is D0
 ;ZETRAP BAUDERR
 ;S X=$zdevspeed($P(^%ZIS(1,D0,0),"^",2)) Q
 Q
BAUDERR S X="" Q
 ;
LGR() Q $ZR ;Last global reference
 ;
EC() Q $ZE ;Error code
 ;
DEVOPN ;X=$J,Y=List of devices separated by a comma
 G DEVOPN^%ZOSV1
 ;
DEVOK ;X=Device $I, Y=0 if available, Y=999 if device is busy
 ;Y=-1 if device is undefined.
 G RES:$G(X1)="RES" I $E(X)="/"!($E(X)="\") S Y=0 Q
 I $D(X)[0 S X=$I
 I X=$I S Y=$J Q
 I X<20,(X>9) S Y=0 D NULLDEV O X:("W":NULLDEV):0 C:$T X S:'$T Y=999 Q
 ZETRAP NODEV
 O X::0 I '$T S Y=999 Q
 C X S Y=0
 Q
RES S Y=0,%ZISD0=$O(^%ZISL(3.54,"B",X,0))
 I '%ZISD0 S Y=-1,%ZISD0=%O(^%ZIS(1,"C",X)) Q:'%ZISD0  Q:'$D(^%ZIS(1,+%ZISD0,0))  Q:$P(^(0),"^")'=X  Q:'$D(^("TYPE"))  Q:^("TYPE")'="RES"  S Y=0 Q
 S X1=$S($D(^%ZISL(3.54,+%ZISD0,0)):^(0),1:"")
 I $P(X1,"^",2)&(X=$P(X1,"^")) S Y=0 Q
 S Y=999 F %ZISD1=0:0 S %ZISD1=$O(^%ZISL(3.54,%ZISD0,1,%ZISD1)) Q:%ZISD1'>0  I $D(^(%ZISD1,0)) S Y=$P(^(0),"^",3) Q
 K %ZISD0,%ZISD1
 Q
NULLDEV ; based on %device
 K HWTYPE S NULLDEV="NUL",H=$V($S($P($ZVER,"/",2)<4:4,1:1),3,-1)
 S HWTYPE=$S(H<10:"WS",H<20:"MF",H<64:"?",H<129:"PC",1:"?")
 I HWTYPE'="PC" S NULLDEV="[NUL]"
 K H,HWTYPE Q
 ;
NODEV S Y=-1
 Q
 ;
DOLRO ;SAVE ENTIRE SYMBOL TABLE IN LOCATION SPECIFIED BY X
 ;I $P($ZVER,"/",2)<4 D ^%VARLOG
 S Y="%" F %=0:0 S Y=$O(@Y) Q:Y=""  S %=$D(@Y) S:%#2 @(X_"Y)="_Y) I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 Q
 ;
ORDER ; Save part of the symbol table in location specified by X
 S (Y,Y1)=$P(Y,"*",1) I $D(@Y)=0 F %=0:0 S Y=$O(@Y) Q:Y=""!(Y[Y1)
 Q:Y=""  S %=$D(@Y) S:%#2 @(X_"Y)="_Y)
 I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 F %=0:0 S Y=$O(@Y) Q:Y=""!(Y'[Y1)  S %=$D(@Y) S:%#2 @(X_"Y)="_Y) I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 K %,X,Y,Y1 Q
 ;
JOBPAR ; Returns job X's namespace
 D JSTAT^%ZOSV1
 I ($P($ZVER,"/",2)'<4)&($P($ZVER,"/",2)<4.3) S Y=$ZCONVERT($V(0,JA+908,-5),"U")
 E  S Y=$$jstat^%mjob(X),Y=$P(Y,"|",4)
 Q
 ;
 ;
NOLOG ; No logins allowed
 S Y=0 Q
 ;
PARSIZ ;
 S X=3 Q
 ;
PRIINQ() ; Priority Inquire
 N X,Y S X=$J ;D JSTAT^%ZOSV1
 ;I ZVER S Y=$V(0,$V(1,(X-1*2)+100,-2)*16+5,-1)-128\2 S:Y Y=10-Y
 S Y=$$jstat^%mjob(X),Y=$P(Y,"|",7) S:Y Y=10-Y
 Q Y
 ;
PRIORITY ; Set priority of job
 I X<1!(X>10) Q
 S Y=X,X=10-X ; convert Kernel to DTM priority
 I $P($ZVER,"/",2)<4 V 64+$J:50:$C(128+X) Q
 S X=X*2+128 zc #changepriority(X) V 2:5:$C(X)
 Q
PRGMODE ;
 W ! S ZTPAC=$S($D(^VA(200,+DUZ,.1))#10:$P(^(.1),"^",5),1:""),XUVOL=^%ZOSF("VOL")
 I ZTPAC]"" X ^%ZOSF("EOFF") R !,"PAC: ",X:60 S X=$ZCONVERT(X,"U") X ^%ZOSF("EON") I X'=ZTPAC W "??",*7 Q
 S XMB="XUPROGMODE",XMB(1)=DUZ,XMB(2)=$I D ^XMB:$L($T(^XMB)) D BYE^XUSCLEAN K ZTPAC,X,XMB
 X ^%ZOSF("UCI") S XUCI=Y,XQZ="PRGM^ZUA[MGR]",XUSLNT=1 D DO^%XUCI
 U:$I>99 $I:IXXLATE=2 D ^%mshell
 ;
UCICHECK(X) ; The call to ns^%m for Version 4 is necessary
 ; only if namespaces are password protected.
 ZETRAP BADUCI N CURUCI
 S X=$P(X,",")
 S X=$ZCONVERT(X,"U"),CURUCI=$ZNSPACE
 I $P($ZVER,"/",2)<4 ZNSPACE X ZNSPACE CURUCI Q X
 D ns^%m(X,1) S ^UTILITY($J)="" ; *** force error if dataset not mounted
 I CURUCI'=X D ns^%m(CURUCI,1)
 Q X
BADUCI ; set flag and return to old namespace
 S Y=0
 I $P($ZVER,"/",2)<4 ZNSPACE CURUCI
 E  D ns^%m(CURUCI,1)
 Q Y
 ;
VERSION(X) ;return OS version, X=1 - return OS
 Q $S($G(X):$P($ZV,"/"),1:$P($ZV,"/",2))
 ;
SETNM(X) ;Set name, Fall into SETENV
SETENV ; Set environment
 S XUENV=X_"^"
 I $P($ZVER,"/",2)>4.2 V 2:374:$C($L(X))_X:$J#256 Q
 S X1=X,X=$J D JSTAT^%ZOSV1
 V 0:JA+374:$C($L(X1))_X1
 Q
GETENV ; Get environment
 S Y=$ZNSPACE_"^"_^%ZOSF("VOL")_"^^"_^%ZOSF("VOL")
 Q
TRMON ;Turn terminators on
 U $I:IXINTERP=2 N % S %=$$getall^%mixinterp()
 I $A(%)'=35 F %=0:1:31,127 D set^%mixinterp(%,35)
 Q
TRMOFF ;Turn terminators off
 U $I:IXINTERP=$S($I>99:1,1:0)
 Q
PASSALL ;Pass all characters
 U $I:IXINTERP=3 N % S %=$$getall^%mixinterp()
 I $A(%)'=18 F %=0:1:31,127 D set^%mixinterp(%,18)
 Q
NOPASS ;Do not pass all characters
 D TRMOFF
 Q
 ;
HFSREW(IO,IOPAR) ;Rewind Host File
 S $ZT="HFSRWERR"
 U IO:(LFA=0)
 Q 1
HFSRWERR ;Error encountered.
 Q 0
LOGRSRC(OPT) ;record resource usage in ^XUCP
 Q
SETTRM(X) ;Turn on specified terminators.
 U $I:TERM=X
 Q 1
