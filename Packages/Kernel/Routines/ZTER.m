%ZTER ; ISC-SF.SEA/JLI - KERNEL ERROR TRAP TO LOG ERRORS ;08/02/2011
 ;;8.0;KERNEL;**8,18,32,24,36,63,73,79,86,112,118,162,275,392,455,431,582**;JUL 10, 1995;Build 6
 ;Per VHA Directive 2004-038, this routine should not be modified.
 S ^TMP("$ZE",$J,1)=$$LGR^%ZOSV
 S ^TMP("$ZE",$J,0)=$$EC^%ZOSV
 S ^TMP("$ZE",$J,2)=$ETRAP,$ETRAP="D ERR^%ZTER"
 S ^TMP("$ZE",$J,3)=$ZA_"~#~"_$ZB
 I (^TMP("$ZE",$J,0)["-ALLOC,")!(^TMP("$ZE",$J,0)["<STORE>")!(^TMP("$ZE",$J,0)["-MEMORY") D
 . I '$D(XUALLOC) D
 . . K (%ZTERLGR,DUZ,DT,DISYS,IO,IOBS,IOF,IOM,ION,IOSL,IOST,IOT,IOS,IOXY,U,XRTL,XQVOL,XQY,XQY0,XQDIC,XQPSM,XQPT,XQAUDIT,XQXFLG,ZTSTOP,ZTQUEUED,ZTREQ,DA,D0,DI,DIC,DIE)
 . S %ZTER13A="ALLOC"
Z1 K XUALLOC
 S %ZTERZE=^TMP("$ZE",$J,0),%ZT("^XUTL(""XQ"",$J)")="" S:'$D(%ZTERLGR) %ZTERLGR=^TMP("$ZE",$J,1)
 G:$$SCREEN(%ZTERZE,1) EXIT ;Let site screen errors, count don't show
 ;Get a record.
 S %ZTERH1=+$H L +^%ZTER(1,%ZTERH1,0):15
 S %ZTER11N=$P($G(^%ZTER(1,%ZTERH1,1,0)),"^",3)
 ;S %ZTER11N=$P($G(^%ZTER(1,%ZTERH1,0)),"^",2)+1,^%ZTER(1,%ZTERH1,0)=%ZTERH1_"^"_%ZTER11N,^(1,0)="^3.0751^"_%ZTER11N_"^"_%ZTER11N
Z2 S %ZTER11N=%ZTER11N+1 G:$D(^%ZTER(1,%ZTERH1,1,%ZTER11N,0)) Z2
 S %ZTER11C=$P($G(^%ZTER(1,%ZTERH1,0)),"^",2)+1
 S ^%ZTER(1,%ZTERH1,0)=%ZTERH1_"^"_%ZTER11C,^%ZTER(1,%ZTERH1,1,0)="^3.0751^"_%ZTER11N_"^"_%ZTER11C
 I %ZTER11N=1 S ^%ZTER(1,0)="ERROR LOG^3.075^"_%ZTERH1_"^"_($P(^%ZTER(1,0),"^",4)+1)
 S %ZTERRT=$NA(^%ZTER(1,%ZTERH1,1,%ZTER11N))
 S @%ZTERRT@(0)=%ZTER11N_"^"_$G(%ZTERAPP),^("ZE")=%ZTERZE S:$D(%ZTERLGR) ^("GR")=%ZTERLGR K %ZTERLGR ;p431
 L -^%ZTER(1,%ZTERH1,0)
 K %ZTER12A,%ZTER12B,%ZTER11C
 ;Save $ZA and $ZB
 S %ZTER12A=$$ENC($P(^TMP("$ZE",$J,3),"~#~",1)),%ZTER12B=$$ENC($P(^TMP("$ZE",$J,3),"~#~",2))
 S %ZTER11I=$$UCI()
 S @%ZTERRT@("H")=$H,^("J")=$J_"^^^"_%ZTER11I_"^"_$J
 S @%ZTERRT@("I")=$I_"^"_%ZTER12A_"^"_%ZTER12B_"^"_$G(IO("ZIO"))_"^"_$X_"^"_$Y_"^"_$P
 S %ZTERROR=$$ETXT
 S %ZTERCNT=0
 D STACK^%ZTER1 ;Save Special Variables
 D SAVE("$X $Y",$X_" "_$Y)
 I ^%ZOSF("OS")["OpenM" D
 . D SAVE("$ZU(56,2)",$ZU(56,2))
 . I $ZV["VMS" S $P(@%ZTERRT@("J"),"^",2,3)=$ZF("GETJPI",$J,"PRCNAM")_"^"_$ZF("GETJPI",$J,"USERNAME")
 D SAVE("$ZV",$ZV)
 ;End Special Variables
 I ^%ZOSF("OS")["VAX DSM" K %ZTER11A,%ZTER11B D VXD^%ZTER1 I 1
 E  D
 . S %ZTERVAR="%"
 . F  D VAR:$D(@%ZTERVAR)#2,SUBS:$D(@%ZTERVAR)>9 S %ZTERVAR=$O(@%ZTERVAR) Q:%ZTERVAR=""
 D GLOB
 S:%ZTERCNT>0 @%ZTERRT@("ZV",0)="^3.0752^"_%ZTERCNT_"^"_%ZTERCNT
 S:'$D(^%ZTER(1,"B",%ZTERH1)) ^(%ZTERH1,%ZTERH1)=""
 S ^%ZTER(1,%ZTERH1,1,"B",%ZTER11N,%ZTER11N)=""
LIN ;Find the line of the error
 S %ZTERY=$P(%ZTERZE,","),%ZTERX=$P(%ZTERY,"^") S:%ZTERX[">" %ZTERX=$P(%ZTERX,">",2)
 I %ZTERX'="" D
 . N X,XCNP,DIF K ^TMP($J,"XTER1")
 . S X=$P($P(%ZTERY,"^",2),":") Q:X=""  X ^%ZOSF("TEST") Q:'$T
 . S XCNP=0,DIF="^TMP($J,""XTER1""," X ^%ZOSF("LOAD") S %ZTERY=$P(%ZTERX,"+",1)
 . I %ZTERY'="" F X=0:0 S X=$O(^TMP($J,"XTER1",X)) Q:X'>0  I $P(^(X,0)," ")=%ZTERY S X=X+$P(%ZTERX,"+",2),%ZTZLIN=$G(^TMP($J,"XTER1",X,0)) Q
 . I %ZTERY="" S X=+$P(%ZTERX,"+",2) Q:X'>0  S %ZTZLIN=$G(^TMP($J,"XTER1",X,0))
 K ^TMP($J,"XTER1")
 S:$D(%ZTZLIN) @%ZTERRT@("LINE")=%ZTZLIN K %ZTZLIN
 I %ZTERROR'="",$D(^%ZTER(2,"B",%ZTERROR)) S %ZTERROR=%ZTERROR_"^"_$P(^%ZTER(2,+$O(^(%ZTERROR,0)),0),"^",2)
EXIT ;
 D ECNT ;Update the Error Count in the Summary
 I $G(%ZTER13A)["ALLOC" HALT  ;Don't allow job to go on.
 S $EC="",$ET=$G(^TMP("$ZE",$J,2))
 K ^TMP("$ZE",$J)
 K %ZTER11A,%ZTER11B,%ZTER11D,%ZTER11H,%ZTER11I,%ZTER11L,%ZTER11N,%ZTER11Q,%ZTER11S,%ZTER11Z,%ZTER111,%ZTER112
 K %ZTER12A,%ZTER12B,%ZTER13A,%ZTERVAP,%ZTERVAR,%ZTERSUB,%ZTERROR,%ZTERZE
 K %ZTERRT,%ZTERH1,%ZTERCNT,%ZTERX,%ZTERY,%ZT
 H 1 ;Slow down process
 Q
 ;
VAR I "%ZTER"'=$E(%ZTERVAR,1,5) D SAVE(%ZTERVAR,@%ZTERVAR) Q
 Q
 ;
SAVE(%ZTERN,%ZTERV) ;Save name and value into global, use special variables
 S %ZTERCNT=%ZTERCNT+1,@%ZTERRT@("ZV",%ZTERCNT,0)=%ZTERN
 I $L(%ZTERV)<256 S @%ZTERRT@("ZV",%ZTERCNT,"D")=%ZTERV Q
 ;Variable too long for global node
 S @%ZTERRT@("ZV",%ZTERCNT,"D")=$E(%ZTERV,1,255),^("L")=$L(%ZTERV)
 N %ZTERI
 F %ZTERI=1:1 S %ZTERV=$E(%ZTERV,256,$L(%ZTERV)) Q:'$L(%ZTERV)  S @%ZTERRT@("ZV",%ZTERCNT,"D",%ZTERI)=$E(%ZTERV,1,255)
 Q
 ;
SUBS ;Save sub-nodes
 S %ZTER11S="" Q:"%ZT("=$E(%ZTERVAR,1,4)  Q:",%ZTER11S,%ZTER11L,"[(","_%ZTERVAR_",")
 S %ZTERVAP=%ZTERVAR_"(",%ZTERSUB="%ZTER11S)"
 S %ZTER11S=%ZTERVAR
 F  S %ZTER11S=$Q(@%ZTER11S) Q:%ZTER11S=""  D SAVE(%ZTER11S,@%ZTER11S)
 Q
 ;
GLOB ; save off a list of global subtrees, %ZT is passed in subscripted by name
 ; %ZTERCNT passed in to count the nodes we traverse
 ; %ZTERNOD the nodes through which we $QUERY
 ; %ZTERNAM the names of the global subtrees we're saving
 ; %ZTEROPN is %ZTERNAM, evaluated, without close paren for $PIECEing
 N %ZTERNOD,%ZTERNAM,%ZTEROPN
 S %ZTERNAM="" ; the names of the global subtrees we're saving
 F  S %ZTERNAM=$O(%ZT(%ZTERNAM)) Q:%ZTERNAM=""  D
 . S %ZTERNOD=$NA(@%ZTERNAM) ; fully evaluate all the subscripts (incl. $J)
 . S %ZTEROPN=$E(%ZTERNOD,1,$L(%ZTERNOD)-1) ; save %ZTERNOD w/o close paren
 . ;S %ZTERSUB=$QL(%ZTERNOD) ; how many subscripts in the subtree root's name
 . F  S %ZTERNOD=$Q(@%ZTERNOD) Q:%ZTERNOD=""  Q:%ZTERNOD'[%ZTEROPN  D  ; traverse subtree
 . . S %ZTERCNT=%ZTERCNT+1 ; count each node
 . . S @%ZTERRT@("ZV",%ZTERCNT,0)=$P(%ZTERNAM,")")_$P(%ZTERNOD,%ZTEROPN,2) ; unevaluated name
 . . S @%ZTERRT@("ZV",%ZTERCNT,"D")=$G(@%ZTERNOD) ; value of node
 Q
 ;
ETXT() ;Return the Text of the error
 Q $S(%ZTERZE["%DSM-E":$P($P(%ZTERZE,"%DSM-E-",2),","),1:$P($P(%ZTERZE,"<",2),">"))
 ;
ENC(%ZT1) ;Encode a string with control char in \027 format
 N %ZTI,%ZTB,%ZTC S %ZTB=""
 F %ZTI=1:1:$L(%ZT1) S %ZTC=$E(%ZT1,%ZTI),%ZTB=%ZTB_$S(%ZTC'?1C:%ZTC,1:"\"_$E($A(%ZTC)+1000,2,4))_","
 Q $E(%ZTB,1,$L(%ZTB)-1)
 ;
UCI() ;Return the UCI, Changed to Box:Volume p431
 N Y S Y=""
 D GETENV^%ZOSV S Y=$P(Y,"^",4)
 Q Y
 ;
APPERROR(%ZTERNM) ;Caller gives name to Error. p431
 S ^TMP("$ZE",$J,1)=$$LGR^%ZOSV
 S ^TMP("$ZE",$J,0)=%ZTERNM
 S ^TMP("$ZE",$J,2)=$ETRAP,$ETRAP="D ERR^%ZTER"
 S ^TMP("$ZE",$J,3)=$ZA_"~#~"_$ZB
 S %ZTERAPP=1
 G Z1
 ;
ERR ;Handle an error in %ZTER
 I $D(%ZTERH1),$D(%ZTER11N) S ^%ZTER(1,%ZTERH1,1,%ZTER11N,"ZE2")="%ZTER error: "_$ECODE
 ;Should ^TMP("$ZE",$J) be killed here
 HALT
 ;
ECNT ;Add to the error count
 S %ZTER11A=$$FMT(%ZTERZE),%ZTER11N=0
 I $L(%ZTER11A) L +^%ZTER(3.077,0):15 D  L -^%ZTER(3.077,0)
 . S %ZTER11N=$O(^%ZTER(3.077,"B",$E(%ZTER11A,1,30),0))
 . I '%ZTER11N F  Q:%ZTER11N  D
 . . S %ZTER11N=$P($G(^%ZTER(3.077,0)),"^",3)+1,$P(^(0),"^",2,4)="3.077^"_%ZTER11N_"^"_%ZTER11N
 . . I $D(^%ZTER(3.077,%ZTER11N,0)) S %ZTER11N=0 Q
 . . S ^%ZTER(3.077,%ZTER11N,0)=%ZTER11A,^%ZTER(3.077,"B",$E(%ZTER11A,1,30),%ZTER11N)=""
 . . Q
 . I '$D(^%ZTER(3.077,%ZTER11N,4,0)) S ^(0)="^3.0775"
 . S %ZTER11H=$H,%ZTER11S=($P(%ZTER11H,",",2)\3600)+1,%ZTER11H=+%ZTER11H
 . S $P(^%ZTER(3.077,%ZTER11N,4,%ZTER11H,0),"~",%ZTER11S)=$P($G(^%ZTER(3.077,%ZTER11N,4,%ZTER11H,0)),"~",%ZTER11S)+1
 . I $P($G(^%ZTER(3.077,%ZTER11N,0)),"^",2)="" S $P(^%ZTER(3.077,%ZTER11N,0),"^",2)=$$HTFM^XLFDT($H) ;P582
 . S $P(^%ZTER(3.077,%ZTER11N,0),"^",3)=$$HTFM^XLFDT($H) ;P583
 . Q
 Q
 ;
 ;Output format 'Tag+offset^Routine, <error code>'
FMT(%ZTE) ;Format the error text
 I $E(%ZTE,1,2)="<>" S %ZTE=$E(%ZTE,3,999)
 S %ZTE=$TR(%ZTE,"^","~")
 I %ZTE["<"&($P(%ZTE,"<",2)[">") S %ZTE=$P($P(%ZTE,">",2)," ")_", "_$P(%ZTE,">")_">"
 Q %ZTE
 ;
SCREEN(ERR,%ZT3) ;Screen out certain errors.
 N %ZTA,%ZTE,%ZTI,%ZTJ,%ZTH,%ZTR S:'$D(ERR) ERR=$$EC^%ZOSV
 I '$L(ERR) Q 0 ;Record
 ;Set error text format
 S %ZTH=+$H,%ZTE=$$FMT(ERR)
 ;Find error in summary
 S %ZTI=$O(^%ZTER(3.077,"B",%ZTE,0)),%ZTR=$G(^%ZTER(3.077,+%ZTI,4,%ZTH,0)),%ZTJ=0
 F %ZTA=1:1:24 S %ZTJ=%ZTJ+$P(%ZTR,"~",%ZTA)
 ;Check the limit on the number of errors to record.
 I $P($G(^XTV(8989.3,1,"ZTER")),"^",1)'="",%ZTJ'<(+$P($G(^XTV(8989.3,1,"ZTER"),"10"),"^",1)) Q 1 ;Don't record
 ;Check error screens
 S %ZTE="",%ZTI=0
 ;See if error is in list.
 F %ZTJ=2,1 D  Q:%ZTI>0
 . F %ZTI=0:0 S %ZTI=$O(^%ZTER(2,"AC",%ZTJ,%ZTI)) Q:%ZTI=""  S %ZTE=$S($G(^%ZTER(2,%ZTI,2))]"":^(2),1:$P(^(0),"^")) Q:ERR[%ZTE
 . Q
 ;Next see if we should count the error
 I %ZTI>0 S %ZTE=$G(^%ZTER(2,%ZTI,0)) D  Q $P(%ZTE,"^",3)=2 ;See if we skip the recording of the error.
 . Q:(%ZTJ=1)&('$G(%ZT3))
 . I $P(%ZTE,"^",4) L +^%ZTER(2,%ZTI):10 S ^(3)=$G(^%ZTER(2,%ZTI,3))+1 L -^%ZTER(2,%ZTI)
 . Q
 Q 0 ;record error
 ;
UNWIND ;Unwind stack for new error trap. Called by app code.
 S $ECODE="" S $ETRAP="D UNW^%ZTER Q:'$QUIT  Q -9" S $ECODE=",U1,"
UNW Q:$ESTACK>1  S $ECODE="" Q
 ;
NEWERR() ;Does this OS support the M95 error trapping
 Q 1 ;All current M system now support 95 error trapping
 ;
ABORT ;Pop the stack all the way.
 S $ETRAP="Q:$ST>1  S $ECODE="""" Q"
 Q
 ;
POST ;Do the post-init
