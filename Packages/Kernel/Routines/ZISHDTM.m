ZISHDTM ;IHS/PR,SFISC/AC HOST FILE COMMANDS FOR DTM ;06/30/95  13:34
 ;;8.0;KERNEL;;JUL 10, 1995
 ;
 ;
OPEN(X1,X2,X3,X4) ;
 ;X1=handle name
 ;X2=directory name \dir\
 ;X3=file name
 ;X4=file access mode e.g.: W for write, R for read, A for append.
 N %,%1,%2,%I,%T,%ZIOS,X
 S %I=$I
 S %1=$$MODE^%ZISF(X2_X3,X4)
 S X="OPNERR^%ZISH",@^%ZOSF("TRAP")
 F %=10:1:19 D  O @%2 S %T=$T Q:%T
 .S %2=%_":"_%1_":0"
 I %T S IO=%,IO(1,IO)="",POP=0
 E  U:$D(IO(1,%I)) %I S POP=1 Q  ;Q 0
 U @% S %ZIOS=$ZIOS
 I %ZIOS=4 U:$D(IO(1,%I)) %I C % S POP=1 Q  ; Q 0
 ;S IO=%,IO(1,IO)=""
 I $G(X1)]"" D SAVDEV^%ZISUTL(X1)
 Q  ;Q 1
 ;
OPNERR ;process errors during open of host file.
 S POP=1
 Q
CLOSE(X) ;Close HFS device not opened by %ZIS.
 ;X=HANDLE NAME
 N %
 I $G(X)]"" C IO K IO(1,IO) D RMDEV^%ZISUTL(X),HOME^%ZIS Q
 C IO K IO(1,IO) D HOME^%ZIS
 Q
 ;
OPENERR ;
 Q 0
 ;
DEL(%ZISHX1,%ZISHX2) ;Del fl(s)
 ;S Y=$$DEL^ZOSHMSM("\dir\",$NAME STRING)
 ;                         ,.array)
 ;Changed X2 to a $NAME string
 N %ZISH,%ZISHLGR
 N ZOSHDA,ZOSHF,ZOSHX,ZOSHQ,ZOSHDF,ZOSHC
 S %ZISHX1=$TR(%ZISHX1,"/","\")
 ;Get fls to act on
 ;No '*' allowed
 S %ZISHLGR=$$LGR^%ZOSV ;if possible, save off last global reference
 S %ZISH="" F  S %ZISH=$O(@%ZISHX2@(%ZISH)) Q:'%ZISH  I %ZISH["*" S ZOSHQ=1 Q
 I $D(ZOSHQ) X "I $G(%ZISHLGR)]"""",$D(@%ZISHLGR)" Q 0
 S %ZISH="" F   S %ZISH=$O(@%ZISHX2@(%ZISH)) Q:%ZISH=""  D
 .;S ZOSHC="rm "_X1_%
 .;S ZOSHC=$ZOS(2,%ZISHX1_%ZISH)
 .D del^%dos(%ZISHX1_%ZISH)
 .;D JW
 I $G(%ZISHLGR)]"",$D(@%ZISHLGR)
 Q 1
 ;
LIST(%ZISHX1,%ZISHX2,%ZISHX3) ;Create a local array holding fl names
 ;S Y=$$LIST^ZOSHDOS("\dir\","fl",".return array")
 ;                           "fl*",
 ;                           .array,
 ;
 ;Change X2 = $NAME OF CLOSE ROOT
 ;Change X3 = $NAME OF CLOSE ROOT
 ;
 N %ZISH,%ZISH1,%ZISH2,%ZISHLGR,%ZISHX,%ZISHY
 ;Get fls to act on
 S %ZISHLGR=$$LGR^%ZOSV ;if possible, save off last global reference
 S %ZISH="" F  S %ZISH=$O(@%ZISHX2@(%ZISH)) Q:%ZISH=""  D
 .S %ZISHX=%ZISHX1_%ZISH
 .S %ZISHY=$$files^%dos(%ZISHX)
 .F %ZISH1=1:1:$L(%ZISHY,$C(10))-1 D
 ..S %ZISH2=$P($P(%ZISHY,$C(10),%ZISH1),";")
 ..I %ZISH2="."!(%ZISH2="..") Q
 ..S @%ZISHX3@(%ZISH2)=""
 I $G(%ZISHLGR)]"",$D(@%ZISHLGR)
 Q $O(@%ZISHX3@(""))]""
 ;
MV(X1,X2,Y1,Y2) ;Rename a fl
 ;S Y=$$MV^ZOSHMSM("/dir/","fl","/dir/","fl")
 N %ZISHLGR
 S %ZISHLGR=$$LGR^%ZOSV ;if possible, save off last global reference
 ;
 ;Dir frmt
 S X1=$TR(X1,"/","\"),Y1=$TR(Y1,"/","\")
 I X1=Y1 D rename^%dos(X1_X2,Y1_Y2) Q 1
 D copy^%dos(X1_X2,Y1_Y2)
 D del^%dos(X1_X2)
 I $G(%ZISHLGR)]"",$D(@%ZISHLGR)
 Q 1
 Q
 ;
PWD() ;Print working directory
 ;S Y=$$PWD^ZOSHMSM(.return array)
 ;
 N Y
 S Y=$$curdrive^%dos
 S Y=Y_":\"_$$subdir^%dos(Y)
 S Y=Y_$S($E(Y,$L(Y))'="\":"\",1:"")
 Q Y
 ;
JW ;msm extrinsic
 S ZOSHX=$$JOBWAIT^%HOSTCMD(ZOSHC)
 Q
DF(X) ;Dir frmt
 Q:X=""
 S X=$TR(X,"\","/")
 I $E(X,$L(X))'="/" S X=X_"/"
 Q
STATUS() ;Eof flag
 Q $ZIOS=3
QL(X) ;Qlfrs
 Q:X=""
 S:$E(X)'="-" X="-"_X
 Q
FL(X) ;Fl len
 N ZOSHP1,ZOSHP2
 S ZOSHP1=$P(X,"."),ZOSHP2=$P(X,".",2)
 I $L(ZOSHP1)>14 S X=4 Q
 I $L(ZOSHP2)>8 S X=4 Q
 Q
 ;
FTG(%ZISHX1,%ZISHX2,%ZISHX3,%ZISHX4,%ZISHX5) ;Unload contents of host file into global
 ;p1=hostf file directory
 ;p2=host file name
 ;p3= NOW $NAME REFERENCE INCLUDING STARTING SUBSCRIPT
 ;p4=INCREMENT SUBSCRIPT
 ;p5=Overflow subscript, defaults to "OVL"
 N %ZISH,%ZISH1,%ZISHI,%ZISHL,%ZISHLGR,%ZISHS,ZISHIO,%ZISHOVL,%ZISHX,ZISHY
 N %CONT,%OVLCNT,%XX,%ZA,%ZB,%ZISH2,%ZISHNREC,%ZL,%ZPL,%ZPZB,ZIOS
 S %ZISHLGR=$$LGR^%ZOSV ;if possible, save off last global reference
 S %ZISHOVL=$G(%ZISHX5,"OVL")
 S %ZISHI=$$QS^XLFUTL(%ZISHX3,%ZISHX4)
 S %ZISHL=$$QL^XLFUTL(%ZISHX3)
 I %ZISHX4=(%ZISHL+1),%ZISHI="" S %ZISHI=1
 S %ZISH1=$NA(@%ZISHX3,%ZISHX4-1) ;name string before incrementing subscript
 F %ZISH=%ZISHX4+1:1:%ZISHL S %ZISHS(%ZISH)=$$QS^XLFUTL(%ZISHX3,%ZISH)
 D OPEN^%ZISH("",%ZISHX1,%ZISHX2,"R")
 S %ZISHX="",%ZPZB=0,%ZPL="",%OVLCNT=0,%CONT=0,%ZISHNREC=1
 U IO F  D READNXT(.%XX) Q:$$STATUS&'$L(%XX)  D
 .S ZIOS=$ZIOS
 .I %ZISHNREC D
 ..I $G(%ZISHRMD),%ZISHX]"" S %ZISHI=%ZISHI-1 D SETOVL S %ZISHI=%ZISHI+1
 ..S %ZISHX=%XX K %ZISHRMD
 ..S %ZISH2=$NA(@%ZISH1@(%ZISHI))
 ..S %ZISH=%ZISH+1
 ..F %ZISH=%ZISHX4+1:1:%ZISHL S %ZISH2=$NA(@%ZISH2@(%ZISHS(%ZISH)))
 ..S @%ZISH2=$E(%ZISHX,1,255)
 ..S %OVLCNT=0,%CONT=0
 ..Q:%ZL'>255
 ..D LOOP S %ZISHRMD=1
 .E  D
 ..S %ZL2=$L(%ZISHX),%ZISHX=%ZISHX_$E(%XX,1,255-%ZL2)
 ..K %ZISHRMD
 ..D SETOVL
 ..S %XX=$E(%XX,256-%ZL2,$L(%XX))
 ..S %ZISHX=%XX
 ..D:%ZISHX]"" SETOVL
 ..I $L(%ZISHX)>255 D LOOP S %ZISHRMD=1
 .S %ZISHNREC=($ZIOS=0)
 .I %ZISHNREC D
 ..S %ZISHI=%ZISHI+1 ;B:%ZISHI=2
 I $G(%ZISHRMD),%ZISHX]"" D SETOVL
EOF2 C IO K IO(1,IO)
 I $G(%ZISHLGR)]"",$D(@%ZISHLGR) ;restore last global reference.
 Q 1
LOOP S %CONT=1 F  Q:$L(%ZISHX)'>255  D
 .S %ZISHX=$E(%ZISHX,256,$L(%ZISHX))
 .D SETOVL:$L(%ZISHX)>255
 Q
NEXTLUP F  Q:%ZA=%ZL  D
 .D READNXT(.%XX) Q:$$STATUS
 .S %ZL2=$L(%ZISHX),%ZISHX=%ZISHX_$E(%XX,1,255-%L2)
 .D SETOVL
 .S %XX=$E(%XX,256-%L2,$L(%XX))
 .I $L(%XX)>255 S %ZISHX=%XX D LOOP
 .E  S %ZISHX=%XX D SETOVL
 Q
READNXT(%XX) ;
 U IO R %XX Q:$$STATUS&(%XX="")  S %ZA=$ZA,%ZB=$ZB,%ZL=$L(%XX)
 Q
SETOVL ;
 S %OVLCNT=%OVLCNT+1
 S @$NA(@%ZISH1@(%ZISHI))@(%ZISHOVL,%OVLCNT)=$E(%ZISHX,1,255)
 Q
 Q 1
GTF(%ZISHX1,%ZISHX2,%ZISHX3,%ZISHX4) ;Load contents of global to host file.
 ;p1=$NAME of global reference
 ;p2=incrementing subscript
 ;p3=host file directory
 ;p4=host file name
 ;
 N %ZISHLGR,%ZISHY
 S %ZISHLGR=$$LGR^%ZOSV ;if possible, save off last global reference
 S %ZISHY=$$MGTF(%ZISHX1,%ZISHX2,%ZISHX3,%ZISHX4,"W")
 I $G(%ZISHLGR)]"",$D(@%ZISHLGR)
 Q %ZISHY
GATF(%ZISHX1,%ZISHX2,%ZISHX3,%ZISHX4) ;Load contents of global to host file.
 ;p1=$NAME of global reference
 ;p2=incrementing subscript
 ;p3=host file directory
 ;p4=host file name
 N %ZISHLGR,%ZISHY
 S %ZISHLGR=$$LGR^%ZOSV ;if possible, save off last global reference
 S %ZISHY=$$MGTF(%ZISHX1,%ZISHX2,%ZISHX3,%ZISHX4,"A")
 I $G(%ZISHLGR)]"",$D(@%ZISHLGR)
 Q %ZISHY
 ;
MGTF(%ZISHX1,%ZISHX2,%ZISHX3,%ZISHX4,%ZISHX5) ;Load contents of global to host file.
 ;p1=$NAME of global reference
 ;p2=incrementing subscript
 ;p3=host file directory
 ;p4=host file name
 ;p5=access mode
 N %ZISH,%ZISH1,%ZISH2,%ZISHI,%ZISHL,%ZISHS,%ZISHIO,%ZISHX,%ZISHY
 S %ZISHI=$$QS^XLFUTL(%ZISHX1,%ZISHX2)
 S %ZISHL=$$QL^XLFUTL(%ZISHX1)
 S %ZISH1=$NA(@%ZISHX1,%ZISHX2-1)
 F %ZISH=%ZISHX2+1:1:%ZISHL S %ZISHS(%ZISH)=$$QS^XLFUTL(%ZISHX1,%ZISH)
 D OPEN^%ZISH("",%ZISHX3,%ZISHX4,%ZISHX5)
 S %ZISHX="EOF3^%ZISH"
 F  D  Q:'($D(@%ZISH2)#2)  S %ZISHX=@%ZISH2,%ZISHI=%ZISHI+1 U IO W %ZISHX,!
 .S %ZISH2=$NA(@%ZISH1@(%ZISHI))
 .F %ZISH=%ZISHX2+1:1:%ZISHL S %ZISH2=$NA(@%ZISH2@(%ZISHS(%ZISH)))
 ;C %ZISHIO
 D CLOSE^%ZISH("")
 Q 1
 Q
 ;
