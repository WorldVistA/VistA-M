%ZISH ;IHS\PR,SFISC/AC - Host File Control for MSM ;01/04/2005  08:44
 ;;8.0;KERNEL;**24,36,49,65,84,104,306**;JUL 10, 1995
 ;
OPEN(X1,X2,X3,X4,X5,X6)    ;SR. Open Host File
 ;X1=handle name
 ;X2=directory name \dir\
 ;X3=file name
 ;X4=file access mode e.g.: W for write, R for read, A for append, B for block.
 ;X5=Max record size for a new file, X6=Subtype
 N %,%1,%2,%I,%P1,%P2,%P6,%T,%ZA,%ZISHIO
 S %I=$I,%T=0,POP=0,X2=$$DEFDIR($G(X2)),%Q=$C(34) M %ZISHIO=IO
 S %P2=$S(X4["RW":"RW",X4["W":"W",X4["N":"W",X4["A":"A",1:"R")
 S %P1=X2_X3,%P6=$S(X4["B":%Q_%Q,1:$C(13,10))
 F %2=51:1:54 I '$D(IO(1,%2)) O %2:(%P1:%P2::::%P6):0 I $T S %T=%2 Q
 I '%T S POP=1 Q
 ;S %1=$$MODE^%ZISF(X2_X3,X4)
 U %2 S %ZA=$ZA
 I %ZA=-1 U:%I]"" %I C %2 S POP=1 Q
 S IO=%2,IO(1,IO)="",IOT="HFS",POP=0 D SUBTYPE^%ZIS3($G(X6))
 I $G(X1)]"" D SAVDEV^%ZISUTL(X1)
 Q
 ;
CLOSE(X) ;SR. Close HFS device not opened by %ZIS.
 ;X=HANDLE NAME, IO=Device
 N %
 I $G(IO)]"" C IO K IO(1,IO)
 I $G(X)]"" D RMDEV^%ZISUTL(X)
 D HOME^%ZIS
 Q
 ;
OPENERR ;
 Q 0
 ;
DEL(%ZX1,%ZX2) ;ef,SR. Del fl(s)
 ;S Y=$$DEL^ZOSHMSM("\dir\","fl")
 ;                         ,.array)
 ;Changed %ZX2 to a $NAME string
 N %,%ZH,%ZXDEL,ZOSHDA,ZOSHF,ZOSHX,ZOSHDF,ZOSHC
 S %ZX1=$$DEFDIR($G(%ZX1)) S:$D(@%ZX2)=1 @%ZX2(@%ZX2)=""
 ;Get fls to act on
 ;No '*' allowed
 S %ZH="",%ZXDEL=1
 F  S %ZH=$O(@%ZX2@(%ZH)) Q:%ZH=""  D
 . I %ZH["*" S %ZXDEL=0 Q  ; Wild card not allowed.
 .;S ZOSHC="rm "_X1_%
 .S ZOSHC=$ZOS(2,%ZX1_%ZH) ;Use system function to delete file
 Q %ZXDEL
 ;
LIST(%ZX1,%ZX2,%ZX3) ;ef,SR. Create a local array holding fl names
 ;S Y=$$LIST^ZOSHDOS("\dir\","fl",".return array")
 ;                           "fl*",
 ;                           .array,
 ;
 ;Change X2 = $NAME OF CLOSE ROOT
 ;Change X3 = $NAME OF CLOSE ROOT
 ;
 N %ZISH,%ZISHN,%ZX,%ZISHY
 S %ZISHN=0,%ZX1=$$DEFDIR($G(%ZX1)) S:$D(@%ZX2)=1 @%ZX2(@%ZX2)=""
 ;Get fls to act on
 S %ZISH="" F  S %ZISH=$O(@%ZX2@(%ZISH)) Q:%ZISH=""  D
 .S %ZX=%ZX1_%ZISH
 .F %ZISHN=1:1 D  Q:$P(%ZISHY,"^")=""!(%ZISHY<0)  S @%ZX3@($P(%ZISHY,"^"))="" ;S @%ZX3@(%ZISHN)=$P(%ZISHY,"^")
 ..I %ZISHN>1 S %ZISHY=$ZOS(13,%ZISHY)
 ..E  S %ZISHY=$ZOS(12,%ZX,0)
 Q $O(@%ZX3@(""))]""
 ;
MV(X1,X2,Y1,Y2) ;ef,SR. Rename a fl
 ;S Y=$$MV^ZOSHDOS("\dir\","fl","\dir\","fl")
 ;
 N %ZB,%ZC,%ZISHDV1,%ZISHDV2,%ZISHFN1,%ZISHFN2,%ZISHPCT,%ZISHSIZ,%ZISHX,X,Y
 S X1=$$DEFDIR($G(X1)),Y1=$$DEFDIR($G(Y1))
 I X1=Y1 Q $ZOS(3,X2,Y2)'<0
 S X=X1_X2,Y=Y1_Y2
 ;
 S %ZISHDV1=51,%ZISHDV2=52,%ZISHFN1=X,%ZISHFN2=Y
 O %ZISHDV1:(%ZISHFN1)
 O %ZISHDV2:(%ZISHFN2:"W")
 U %ZISHDV1:(::0:2) S %ZISHSIZ=$ZB U %ZISHDV1:(::0:0) S (%ZISHPCT,%ZB,%ZC)=0
 D SLOWCOPY S %ZISHX(X2)="" S Y=$$DEL^%ZISH(X1,$NA(%ZISHX))
 Q 1
 ;
SLOWCOPY ; Copy without view buffer
 N X,Y
 O %ZISHDV1:(%ZISHFN1:"R"::::""),%ZISHDV2:(%ZISHFN2:"W"::::"")
 FOR  DO  Q:%ZC!(%ZB=%ZISHSIZ)
 . U %ZISHDV1 R X#1024 Q:$L(X)=0
 . U %ZISHDV2 W X S %ZB=$ZB,%ZC=$ZC Q:%ZC
 . I %ZB=%ZISHSIZ C %ZISHDV2 S %ZC=($ZA=-1)
 . S X=%ZB/%ZISHSIZ*100\1 ; %done
 . Q:X=%ZISHPCT  S %ZISHPCT=X
 . Q  ;U 0 W $J(%ZISHPCT,3),*13
 Q
 ;
PWD() ;ef,SR. Print working directory
 N Y
 S Y=$$DEFDIR("") I $L(Y) Q Y
 S Y=$ZOS(11,$ZOS(14))
 Q:Y<0 ""
 S Y=Y_$S($E(Y,$L(Y))'="\":"\",1:"")
 Q $ZOS(14)_":"_Y
 ;
JW ;Call dos $ZOS
 S ZOSHX=$ZOS(ZOSHNUM,ZOSHC)
 Q
DEFDIR(DF) ;ef. Default Dir and frmt
 Q:DF="." "" ;Special way to get current dir.
 S:DF="" DF=$G(^XTV(8989.3,1,"DEV")) S DF=$TR(DF,"/","\")
 I $E(DF,$L(DF))'="\" S DF=DF_"\"
 Q DF
FL(X) ;Fl len
 N ZOSHP1,ZOSHP2
 S ZOSHP1=$P(X,"."),ZOSHP2=$P(X,".",2)
 I $L(ZOSHP1)>8 S X=4 Q
 I $L(ZOSHP2)>3 S X=4 Q
 Q
READNXT(REC) ;Read any sized record into array.
 N T,I,X,LB
 U IO S LB=$ZB R REC#255 S %ZA=$ZA,%ZB=$ZB,%ZC=$ZC,%ZL=%ZA Q:$$EOF(%ZC)
 Q:%ZA<255
 F I=1:1 S LB=LB+%ZA Q:LB<%ZB  R X#255 S %ZA=$ZA,%ZB=$ZB,%ZC=$ZC Q:$$EOF(%ZC)!('$L(X))  S REC(I)=X
 Q
STATUS() ;ef,SR. Return EOF status
 U $I
 Q $$EOF($ZC)
 ;
EOF(X) ;Eof flag, pass in $ZC
 Q (X=-1)
 ;
READREC(X) ;Read record from host file.
 N Y
 U IO R X S Y=$ZC
 U $P
 Q Y
MAKEREF(HF,IX,OVF) ;Internal call to rebuild global ref.
 ;Return %ZISHF,%ZISHO,%ZISHI,%ZISUB
 N I,F,MX
 S OVF=$G(OVF,"%ZISHOF")
 S %ZISHI=$QS(HF,IX),MX=$QL(HF) ;
 S F=$NA(@HF,IX-1) ;Get first part
 I IX=1 S %ZISHF=F_"(%ZISHI" ;Build root, IX=1
 I IX>1 S %ZISHF=$E(F,1,$L(F)-1)_",%ZISHI" ;Build root
 S %ZISHO=%ZISHF_","_OVF_",%OVFCNT)" ;Make overflow
 F I=IX+1:1:MX S %ZISHF=%ZISHF_",%ZISUB("_I_")",%ZISUB(I)=$QS(HF,I)
 S %ZISHF=%ZISHF_")"
 Q
FTG(%ZX1,%ZX2,%ZX3,%ZX4,%ZX5) ;ef,SR. Unload contents of host file into global
 ;p1=host file directory 
 ;p2=host file name
 ;p3= $NAME REFERENCE INCLUDING STARTING SUBSCRIPT
 ;p4=INCREMENT SUBSCRIPT
 ;p5=Overflow subscript, defaults to "OVF"
 N %ZA,%ZB,%ZC,%ZL,%OVFCNT,%CONT,%XX
 N I,%ZISH,%ZISH1,%ZISHI,%ZISHL,%ZISHOF,%ZISHOX,%ZISHS,%ZX,%ZISHY,POP,%ZISUB
 S %ZX1=$$DEFDIR($G(%ZX1)),%ZISHOF=$G(%ZX5,"OVF")
 D MAKEREF(%ZX3,%ZX4,"%ZISHOF")
 D OPEN^%ZISH(,%ZX1,%ZX2,"R")
 I POP Q 0
 S X="ERREOF^%ZISH",@^%ZOSF("TRAP")
 U IO F  K %XX D READNXT(.%XX) D  Q:$$EOF(%ZC)
 . S I=('$$EOF(%ZC))!($$EOF(%ZC)&$L(%XX)) Q:'I
 . S @%ZISHF=%XX
 . I $D(%XX)>2 F %OVFCNT=1:1 Q:'$D(%XX(%OVFCNT))  S @%ZISHO=%XX(%OVFCNT)
 . S %ZISHI=%ZISHI+1
 . Q
 D CLOSE() ;Normal exit
 Q 1
 ;
ERREOF D CLOSE() ;Error close and exit
 Q 0
 ;
GTF(%ZX1,%ZX2,%ZX3,%ZX4) ;ef,SR. Load contents of global to host file.
 ;Previously name LOAD
 ;p1=$NAME of global reference
 ;p2=incrementing subscript
 ;p3=host file directory, p4=host file name
 N %ZISHY,%ZISHOX
 S %ZISHY=$$MGTF(%ZX1,%ZX2,$G(%ZX3),%ZX4,"W")
 Q %ZISHY
 ;
GATF(%ZX1,%ZX2,%ZX3,%ZX4) ;ef,SR. Append to host file.
 ;
 ;p1=$NAME of global reference
 ;p2=incrementing subscript
 ;p3=host file directory
 ;p4=host file name
 N %ZISHY
 S %ZISHY=$$MGTF(%ZX1,%ZX2,$G(%ZX3),%ZX4,"A")
 Q %ZISHY
MGTF(%ZX1,%ZX2,%ZX3,%ZX4,%ZX5) ;
 ;p1=$NAME of global reference
 ;p2=incrementing subscript
 ;p3=host file directory
 ;p4=host file name
 N %ZISH,%ZISH1,%ZISHI,%ZISHL,%ZISHS,%ZISHOX,IO,%ZX,Y
 D MAKEREF(%ZX1,%ZX2)
 D OPEN^%ZISH(,%ZX3,%ZX4,%ZX5) ;Default dir set in open
 I POP Q 0
 N X
 S X="ERREOF^%ZISH",@^%ZOSF("TRAP")
 F  Q:'($D(@%ZISHF)#2)  S %ZX=@%ZISHF,%ZISHI=%ZISHI+1 U IO W %ZX,!
 D CLOSE()
 Q 1
 ;
