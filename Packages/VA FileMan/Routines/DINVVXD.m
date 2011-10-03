%ZOSV ;SFISC/AC - View commands & special functions. ;12:48 PM  30 Sep 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ACTJ() ; # active jobs
 Q $P($$JOBS^%SY,",",2)
 ;
AVJ() ; # available jobs
 N Y S Y=$$JOBS^%SY Q +Y-$P(Y,",",2)
 ;
T0 ; start RT clock
 S %ZH0=$ZH,%=$P(%ZH0,",",3) S:$E($ZV,10,12)>5.1 %=$E(%,13,23) S XRT0=+$H_","_($P(%,":")*3600+($P(%,":",2)*60)+$P(%,":",3)) Q
 ;
T1 ; store RT datum w/ZHDIF
 S %ZH1=$ZH,%=$P(%ZH1,",",3) S:$E($ZV,10,12)>5.1 %=$E(%,13,23) S XRT1=+$H_","_($P(%,":")*3600+($P(%,":",2)*60)+$P(%,":",3))
 S ^%ZRTL(3,XRTL,+XRT1,XRTN,$P(XRT1,",",2))=XRT0_"^^"_($P(%ZH1,",")-$P(%ZH0,","))_"^"_($P(%ZH1,",",7)-$P(%ZH0,",",7))_"^"_($P(%ZH1,",",8)-$P(%ZH0,",",8)) K XRT0,%ZH0,%ZH1 Q
 ;
PASSALL ;
 S Y=$ZC(%SPAWN,"SET TERM/PASTHRU "_$I) U $I:NOTERM Q
NOPASS ;
 S Y=$ZC(%SPAWN,"SET TERM/NOPASTHRU "_$I) U $I:TERM="" Q
 ;
PRGMODE ;
 W ! S ZTPAC=$S($D(^VA(200,+DUZ,.1))#10:$P(^(.1),"^",5),1:""),XUVOL=^%ZOSF("VOL")
 S X="" X ^%ZOSF("EOFF") R:ZTPAC]"" !,"PAC: ",X:60 D LC^XUS X ^%ZOSF("EON") I X'=ZTPAC W "??",*7 Q
 K XMB,XMTEXT,XMY S XMB="XUPROGMODE",XMB(1)=DUZ,XMB(2)=$I D ^XMB:$L($T(^XMB)) D BYE^XUSCLEAN K ZTPAC,X,XMB
 I '$$PROGMODE() D UCI S XUCI=Y,XQZ="PRGM^ZUA[MGR]",XUSLNT=1 D DO^%XUCI ZESCAPE
 E  S $ECODE=",<<PROG>>,"
 ;
PROGMODE() ;
 Q ($V($V($V(0)))#2=0)
 ;
UCI ;
 S Y=$ZC(%UCI),Y=$P(Y,",",1)_","_$P(Y,",",4) Q
 ;
UCICHECK(X) ;
 N %,%1,U,V,Y
 I '(X?3U!(X?3U1","3U)) Q ""
 S U=$ZC(%UCI),V=$P(U,",",4),U=$P(U,","),%1=$P(X,",",2),%=$P(X,",")
 S Y=$ZC(%SETUCI,%,%1),Y=$S(Y:%_","_$S(%1]"":%1,1:V),1:""),V=$ZC(%SETUCI,U,V)
 Q Y
 ;
PRIORITY ;
 Q  ;Q:X>10!(X<1)  S X=(X+1)\2-1,Y=$ZC(%SETPRI,X) Q  ;Let VSM do it's thing.
 ;
PRIINQ() ;
 Q $ZC(%GETJPI,0,"PRIB")*2+2
 ;
BAUD ;S X="UNKNOWN" Q
 Q
 ;
LGR() Q $ZR ;Last global ref.
 ;
EC() Q $ZE ;Error code
 ;
DOLRO ;SAVE ENTIRE SYMBOL TABLE IN LOCATION SPECIFIED BY X
 S Y="%" F  S Y=$ZSORT(@Y) Q:Y=""  D  ;code from DEC
 . I $D(@Y)#2 S @(X_"Y)="_Y)
 . I $D(@Y)>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 K %X,%Y,Y Q
 ;
ORDER ;SAVE PARTS OF SYMBOL TABLE IN LOCATION SPECIFIED BY X
 ;PARTS INDICATED BY X1("NAMESPACE*")="" ARRAY
 I $D(X1("*"))#2 D DOLRO Q
 S X1="" F  S X1=$O(X1(X1)) Q:X1=""  D
 . S (Y,Y1)=$P(X1,"*") I $D(@Y)=0 F  S Y=$ZSORT(@Y) Q:Y=""!(Y[Y1)
 . Q:Y=""  S %=$D(@Y) S:%#2 @(X_"Y)="_Y) I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 . F  S Y=$ZSORT(@Y) Q:Y=""!(Y'[Y1)  S %=$D(@Y) S:%#2 @(X_"Y)="_Y) I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 . Q
 K %,%X,%Y,Y,Y1 Q
 ;
PARSIZ ;
 S X=3 Q
 ;
NOLOG ;
 S Y=0 Q
 ;
DEVOPN G DEVOPN^%ZOSV1
DEVOK G DEVOK^%ZOSV1
RES G RES^%ZOSV1
 ;
GETENV ;Get environment Return Y='UCI^VOL/DIR^NODE^BOX LOOKUP'
 S Y=$P($ZU(0),",",1)_"^"_$P($ZU(0),",",2)_"^"_$P($ZC(%GETSYI),",",4)
 S $P(Y,"^",4)=$P(Y,"^",2)_":"_$P(Y,"^",3)
 Q
VERSION(X) ;return OS version, X=1 - return OS
 Q $S($G(X):$P($ZV," V"),1:$P($ZV," V",2))
 ;
SETNM(X) ;Set name, Trap dup's, Fall into SETENV
 N $ETRAP S $ETRAP="S $ECODE="""" Q"
SETENV ;Set environment X='PROCESS NAME^ '
 S %=$ZC(%SETPRN,$P(X,"^")) Q
 ;
ZHDIF ;Display dif of two $ZH's
 W !," CPU=",$J($P(%ZH1,",")-$P(%ZH0,","),6,2),?14," ET=",$J($P(%ZH1,",",2)-$P(%ZH0,",",2),6,1),?27," DIO=",$J($P(%ZH1,",",7)-$P(%ZH0,",",7),5),?40," BIO=",$J($P(%ZH1,",",8)-$P(%ZH0,",",8),5),! Q
 ;
LOGRSRC(OPT) ;record resource usage in ^XTMP("XUCP"
 N %,%D,%H,%M,%Y,C,H,U,X S C=",",U="^",%=$ZH,H=$P(%,C,3) S:$E($ZV,10,12)>5.1 H=$E(H,13,23) S H=$P($H,C)_C_($P(H,":")*3600+($P(H,":",2)*60)+$P(H,":",3))
 S ^XTMP("XUCP",$P($ZC(%GETSYI),C,4),$P(H,C),$J,$P(H,C,2))=$P(%,C)_U_$P(%,C,7)_U_$P(%,C,8)_U_$P(%,C,4)_U_OPT_U_$P(%,C,3)
 S %H=$H I $P(%H,C,2)#1000=0 S %=(%H>21608)+(%H>94657)+%H-.1,%Y=%\365.25+141,%=%#365.25\1,%D=%+306#(%Y#4=0+365)#153#61#31+1,%M=%-%D\29+1,X=%Y_"00"+%M_"00"+%D,^XTMP("XUCP",0)=X+10000_U_X
 Q
 ;
SETTRM(X) ;Turn on specified terminators.
 U $I:TERM=X
 Q 1
