%ZISH ;IHS/PR,SFISC/AC - HOST COMMANDS - MSM UNIX ;10/15/96  11:11
 ;;8.0;KERNEL;;JUL 10, 1995
 ;
 ;
OPEN(X1,X2,X3,X4)    ;
 ;X1=handle name
 ;X2=directory name /dir/
 ;X3=file name
 ;X4=file access mode e.g.: W for write, R for read, A for append.
 N %,%1,%I
 S %I=$I
 F %=51:1:54 O %::0 S %T=$T Q:%T
 I %T S IO=%,IO(1,IO)="",POP=0
 E  U:$D(IO(1,%I) %I S POP=1 Q
 S %1=$$MODE^%ZISF(X2_X3,X4)
 S %=%_":"_%1
 U @% S %ZA=$ZA
 I %ZA=-1 U %I C IO K IO(1,IO) S POP=1 Q  ;Q 0
 ;S IO=%,IO(1,IO)=""
 I $G(X1)]"" D SAVDEV^%ZISUTL(X1)
 Q  ;Q 1
 ;
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
 ;S Y=$$DEL^ZOSHMSM("/dir/","fl")
 ;                         ,.array)
 ;Changed param 2 to a $NAME string.
 N %ZISH,%ZISHLGR
 N ZOSHDA,ZOSHF,ZOSHX,ZOSHQ,ZOSHDF,ZOSHC
 ;
 ;Dir frmt
 ;D DF(.ZOSH1) CHANGE TO USE $TR
 S %ZISHX1=$TR(%ZISHX1,"\","/")
 ;
 ;Get fls to act on
 ;No '*' allowed
 S %ZISHLGR=$$LGR^%ZOSV ;if possible, save off last global reference
 S %ZISH="" F  S %ZISH=$O(@%ZISHX2@(%ZISH)) Q:'%ZISH  I %ZISH["*" S ZOSHQ=1 Q
 I $D(ZOSHQ) X "I $G(%ZISHLGR)]"""",$D(@%ZISHLGR)" Q 0
 S %ZISH="" F   S %ZISH=$O(@%ZISHX2@(%ZISH)) Q:%ZISH=""  D
 .S ZOSHC="rm "_%ZISHX1_%ZISH
 .;S ZOSHC=$ZOS(2,%ZOSHX1_%ZISH)
 .D JW
 I $G(%ZISHLGR)]"",$D(@%ZISHLGR)
 Q 1
 ;
 ;
LIST(%ZISHX1,%ZISHX2,%ZISHX3) ;Create a local array holding fl names
 ;S Y=$$LIST^ZOSHDOS("\dir\","fl",".return array")
 ;                           "fl*",
 ;                           .array,
 ;
 ;Change X2 = $NAME OF CLOSE ROOT
 ;Change X3 = $NAME OF CLOSE ROOT
 ;
 N %ZISH,%ZISHLGR,%ZISHN,%ZISHX,%ZISXX,%ZISHY
 S %ZISHLGR=$$LGR^%ZOSV ;if possible, save off last global reference
 S ZOSHC="rm ZOSHAUTO."_$J
 D JW
 S %ZISHN=0
 ;Get fls to act on
 S %ZISH="" F  S %ZISH=$O(@%ZISHX2@(%ZISH)) Q:%ZISH=""  D
 .S %ZISHX=%ZISHX1_%ZISH
 .S ZOSHC="ls -d "_%ZISHX_" >> ZOSHAUTO."_$J
 .D JW
 D OPEN("","","ZOSHAUTO."_$J,"R")
 F ZOSHLN=1:1 U IO R %ZISHXX Q:$$STATUS=-1  D
 .S %ZISHY=$P(%ZISHXX,"/",$L(%ZISHXX,"/"))
 .I %ZISHY]"" S @%ZISHX3@(%ZISHY)=""
 C IO K IO(1,IO)
 ;Remove ZOSHAUTO.$J
 S ZOSHC="rm ZOSHAUTO."_$J
 D JW
 I $G(%ZISHLGR)]"",$D(@%ZISHLGR)
 Q $O(@%ZISHX3@(""))]""
 ;
MV(X1,X2,X3,X4) ;Rename a fl
 ;S Y=$$MV^ZOSHMSM("/dir/","fl","/dir/","fl")
 ;
 N %,%1
 N ZOSHC,ZOSHX
 ;
 ;Dir frmt
 D DF(.X1)
 D DF(.X3)
 ;
 ;Pbv or qit
 I $O(X2(0))!($O(X4(0))) S ZOSHX=3 X "I $G(%ZISHLGR)]"""",$D(@%ZISHLGR)" Q ZOSHX
 ;
 ;Check for 'from' and 'to' directory
 ;
 ;S ZOSHC="mv "_X1_X2_" "_X3_X4
 S ZOSHC="cp "_X1_X2_" "_X3_X4_" ; rm "_X1_X2
 D JW
 I $G(%ZISHLGR)]"",$D(@%ZISHLGR)
 Q 1 ;ZOSHX
 ;
PWD() ;Print working directory
 ;
 N %,%IS,POP,X,Y,ZOSHC,ZOSHDA,ZOSHDF,ZOSHF,ZOSHIOP,ZOSHLN,ZOSHQ,ZOSHX,ZOSHSYFI,ZOSHIOP1
 ;
 ;Init ZOSHAUTO.$J
 S ZOSHC="rm ZOSHAUTO."_$J
 D JW
 ;
 S ZOSHC="pwd > ZOSHAUTO."_$J
 D JW
 ;
 ;Open ZOSHAUTO.$J to read.
 ;Create the 'Return Array' to pass back to user
 D OPEN^%ZISH("","ZOSHAUTO."_$J,"R") I POP Q ""
 F %1=1:1 U IO R % Q:$$STATUS=-1  S Y=%
 D CLOSE^%ZISH("")
 ;
 ;Remove ZOSHAUTO.$J
 S ZOSHC="rm ZOSHAUTO."_$J
 D JW
 ;
 S Y=Y_$S($E(Y,$L(Y))'="/":"/",1:"")
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
 Q $ZC
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
 ;p5=Overflow subscript, defaults to "OVF"
 N %ZISH,%ZISH1,%ZISHI,%ZISHL,%ZISHLGR,%ZISHS,ZISHIO,%ZISHOVL,%ZISHX,ZISHY
 S %ZISHLGR=$$LGR^%ZOSV ;if possible, save off last global reference
 S %ZISHOVL=$G(%ZISHOVL,"OVF")
 S %ZISHI=$$QS^XLFUTL(%ZISHX3,%ZISHX4)
 S %ZISHL=$$QL^XLFUTL(%ZISHX3)
 I %ZISHX4=(%ZISHL+1),%ZISHI="" S %ZISHI=1
 S %ZISH1=$NA(@%ZISHX3,%ZISHX4-1)
 F %ZISH=%ZISHX4+1:1:%ZISHL S %ZISHS(%ZISH)=$$QS^XLFUTL(%ZISHX3,%ZISH)
 D OPEN^%ZISH("",%ZISHX1,%ZISHX2,"R")
 S %ZISHX="",%ZPZB="",%ZPL="",%OVLCNT=0,%CONT=0,%ZISHNREC=1
 U IO F  D READNXT(.%XX) Q:$$STATUS&'$L(%XX)  D  ;U 0 W !,"%ZB="_%ZB,!,"%ZPZB+%ZL="_(%ZPZB+%ZL),!,"%ZPZB="_%ZPZB_" %ZL="_%ZL U IO S %ZISHNREC=$S(%ZB'=(%ZPZB+%ZL):1,1:0) S:%ZISHNREC %ZISHI=%ZISHI+1 S %ZPZB=$ZB,%ZPL=%ZL
 .I %ZISHNREC D
 ..U 0 W !,"NEWRECORD" U IO
 ..S %ZISHX=%XX
 ..S %ZISH2=$NA(@%ZISH1@(%ZISHI))
 ..S %ZISH=%ZISH+1
 ..F %ZISH=%ZISHX4+1:1:%ZISHL S %ZISH2=$NA(@%ZISH2@(%ZISHS(%ZISH)))
 ..S @%ZISH2=$E(%ZISHX,1,255)
 ..S %OVLCNT=0,%CONT=0
 ..Q:%ZL'>255
 ..D LOOP
 .E  D
 ..U 0 W !,"CONTINUATION RECORD" U IO
 ..S %ZL2=$L(%ZISHX),%ZISHX=%ZISHX_$E(%XX,1,255-%ZL2)
 ..D SETOVL
 ..S %XX=$E(%XX,256-%ZL2,$L(%XX))
 ..S %ZISHX=%XX
 ..D:%ZISHX]"" SETOVL
 ..I $L(%ZISHX)>255 D LOOP
 .U 0 W !,"%ZB="_%ZB,!,"%ZPZB+%ZL="_(%ZPZB+%ZL),!,"%ZPZB="_%ZPZB_" %ZL="_%ZL U IO
 .S %ZISHNREC=$S(%ZB'=(%ZPZB+%ZL):1,1:0)
 .I %ZISHNREC D
 ..S %ZISHI=%ZISHI+1 ;B:%ZISHI=2
 .S %ZPZB=$ZB,%ZPL=%ZL
 ;I %ZISHX]"",%ZISHNREC D SETOVL
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
 U IO R %XX Q:$$STATUS  S %ZA=$ZA,%ZB=$ZB,%ZL=$L(%XX)
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
 Q %ZISHY
GATF(%ZISHX1,%ZISHX2,%ZISHX3,%ZISHX4) ;Load contents of global to host file.
 ;p1=$NAME of global reference
 ;p2=incrementing subscript
 ;p3=host file directory
 ;p4=host file name
 N %ZISHLGR,%ZISHY
 S %ZISHLGR=$$LGR^%ZOSV ;if possible, save off last global reference
 S %ZISY=$$MGTF(%ZISHX1,%ZISHX2,%ZISHX3,%ZISHX4,"A")
 I $G(%ZISHLGR)]"",$D(@%ZISHLGR)
 Q %ZISHY
 ;
MGTF(%ZISHX1,%ZISHX2,%ZISHX3,%ZISHX4,%ZISHX5) ;Load contents of global to host file.
 ;p1=$NAME of global reference
 ;p2=incrementing subscript
 ;p3=host file directory
 ;p4=host file name
 ;p5=access mode
 N %ZISH,%ZISH1,%ZISHI,%ZISHL,%ZISHS,%ZISHIO,%ZISHX,%ZISHY
 S %I=$$QS^XLFUTL(%ZISHX1,%ZISHX2)
 S %L=$$QL^XLFUTL(%ZISHX1)
 S %1=$NA(@%ZISHX1,%ZISHX2-1)
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
