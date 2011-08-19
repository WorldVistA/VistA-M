%ZISH ;ISF/AC,RWF - GT.M for UNIX Host file Control ;01/04/2005  08:13
 ;;8.0;KERNEL;**275,306**;Jul 10, 1995;
 ; for GT.M for Unix/VMS, version 4.3
 ;
OPENERR ;
 Q 0
 ;
OPEN(X1,X2,X3,X4,X5,X6) ;SR. Open file
 ;D OPEN^%ZISH([handlename],[directory],filename,[accessmode],[recsize])
 ;X1=handle name
 ;X2=directory, X3=filename, X4=access mode
 ;X5=new file max record size, X6=Subtype
 ;
 N %,%1,%2,%IO,%I2,%P,%T,X,Y,$ETRAP
 S $ETRAP="D OPNERR^%ZISH"
 S U="^",X2=$$DEFDIR($G(X2)),X4=$$UP^XLFSTR(X4)
 S Y=$S(X4["A":"append",X4["R":"readonly",X4["W":"newversion",1:"readonly")
 S Y=Y_$S(X4["B":":fixed:nowrap:recordsize=512",$G(X5)&(X4["W"):":WIDTH="_+X5,1:"")
 S:$E(Y)=":" Y=$E(Y,2,999) S %IO=X2_X3,%I2="%IO:"_$S($L(Y):"("_Y_")",1:"")_":3"
 O @%I2 S %T=$T
 I '%T S POP=1 Q
 S IO=%IO,IO(1,IO)="",IOT="HFS",POP=0 D SUBTYPE^%ZIS3($G(X6))
 I $G(X1)]"" D SAVDEV^%ZISUTL(X1)
 U IO U $P ;Enable use of $ZA to test EOF condition.
 Q
OPNERR ;error on open
 S POP=1,$ECODE=""
 U:$G(%P)]"" %P
 Q
 ;
CLOSE(X) ;SR. Close HFS device not opened by %ZIS.
 ;X1=Handle name, IO=device
 I IO]"" C IO K IO(1,IO)
 I $G(X)]"" D RMDEV^%ZISUTL(X)
 D HOME^%ZIS
 Q
DEL(%ZX1,%ZX2) ;ef,SR. Del fl(s)
 ;S Y=$$DEL^%ZISH("dir path",$NA(array))
 N %ZISH,%ZISHLGR,%ZX,X,%ZXDEL
 S %ZX1=$$DEFDIR($G(%ZX1)),%ZXDEL=1,%ZISH=""
 F  S %ZISH=$O(@%ZX2@(%ZISH)) Q:%ZISH=""  D
 . N $ETRAP,$ESTACK S $ETRAP="D DELERR^%ZISH"
 . I %ZISH["*" S %ZXDEL=0 Q  ; Wild card not allowed.
 . S %ZX=$ZSEARCH(%ZX1_%ZISH)
 . Q:%ZX']""           ; File doesn't exist - not an error, just quit.
 . O %ZX:READONLY:0
 . I '$T S %ZXDEL=0 Q  ; Can't open it.
 . C %ZX:DELETE
 . I $ZSEARCH(%ZX)]"" S %ZXDEL=0 ; Delete was not successful.
 Q %ZXDEL
DELERR ;Trap any $ETRAP error, unwind and return.
 S $ETRAP="D UNWIND^%ZTER"
 S %ZXDEL=0
 D UNWIND^%ZTER
 Q
 ;
LIST(%ZX1,%ZX2,%ZX3) ;ef,SR. Set local array holding fl names
 ;S Y=$$LIST^ZISH("/dir/","list_root","return_root")
 ;list_root can have XX("A*"), XX("test.com")...
 ;Both arrays passed as $NA values (closed roots).
 N %IO,%X,%ZISH,%ZISH1,%ZISHIO,%ZX,POP,X,%ZISHDL1,%ZISHDL2,%ZISHDN1,%ZISHDN2
 N $ETRAP,$ESTACK S $ETRAP="G LSTEOF^%ZISH",%ZX1=$$DEFDIR($G(%ZX1))
 S %IO=$I,%ZISHDN1="_ZISH"_$J_".TMPA",%ZISHDN2="ZISH"_$J_".TMPB"
 S %ZISHDL1=%ZX1_%ZISHDN1,%ZISHDL2=%ZX1_%ZISHDN2
 S $ZT="G SPAWNERR^%ZISH"
 ;Init %ZISHDL1, %ZISHDL2 by deleteing them
 ;I $ZSEARCH(%ZISHDL1)["ZISH" ZSYSTEM "rm "_%ZISHDL1
 ;I $ZSEARCH(%ZISHDL2)["ZISH" ZSYSTEM "rm "_%ZISHDL2_";*"
 ;Get fls, Build listing in %ZISHDL1 with ls
 S %ZISH1=0,%ZISH=""
 F  S %ZISH=$O(@%ZX2@(%ZISH)) Q:%ZISH=""  D
 . S X=$$LIST1(%ZX1_%ZISH,%ZX1)
LSTEOF S $ZT=""
 I $L(%IO) U:$D(IO(1,%IO)) IO
 ;C %ZISHDL1 ;:DELETE
 ;I $L($ZSEARCH(%ZISHDL2)) ZSYSTEM "DEL "_%ZISHDL2
 ;I $L($ZSEARCH(%ZISHDL1)) ZSYSTEM "DEL "_%ZISHDL1_";*"
 S $ECODE=""
 Q ($Q(@%ZX3)]"")
 ;
LIST1(%ZX,%ZD) ;Get one part of the list
 N $ET,$ES S $ET="D LSTERR^%ZISH"
 ;ZSYSTEM "ls -1 "_%ZX_" > "_%ZISHDL1
 ;O %ZISHDL1:readonly:1 U %ZISHDL1
 ;F  R %X:1 Q:$ZEOF  S @%ZX3@(%X)=""
 ;C %ZISHDL1:DELETE
 N %ZY,%ZI,%ZJ
 S %ZY=$ZSEARCH("*.X") ;Clear vector
 S %ZY=$P(%ZX,"*")
 F  S %ZI=$ZSEARCH(%ZX) Q:'$L(%ZI)!(%ZI'[%ZY)  S %ZJ=$P(%ZI,%ZD,2),@%ZX3@(%ZJ)=""
 Q 1
LSTERR ;Error in list
 I $ZSEARCH(%ZISHDL2)["ZISH" ZSYSTEM "DEL "_%ZISHDL2_";*"
 Q 0
 ;
SPAWNERR ;TRAP ERROR OF SPAWN
 O %ZISHDL1:READONLY:1 I $T C %ZISHDL1:DELETE
 S $ECODE=""
 Q 0
 ;
MV(X1,X2,Y1,Y2) ;ef,SR. Rename a fl
 ;S Y=$$MV^ZISH("/dir/","fl","/dir/","fl")
 N X,Y,%ZISHDL1
 S %ZISHDL1="ZISH"_$J_".TMPA",X1=$$DEFDIR($G(X1)),Y1=$$DEFDIR($G(Y1))
 S $ZT="SPAWNERR^%ZISH"
 ;Pbv or qit
 I (X2="")!(Y2="") Q 0
 ZSYSTEM "mv "_X1_X2_" "_Y1_Y2 ;Use system command
 S Y=$ZSEARCH(Y1_Y2)
 Q $L(Y)>0
 ;
PWD() ;ef,SR. Print working directory
 N Y
 S Y=$$DEFDIR("")
 S:Y="" Y=$ZDIR
 Q Y
 ;
DEFDIR(DF) ;ef. Default Dir and frmt
 S DF=$G(DF) Q:DF="." "" ;Special way to get current dir.
 S:DF="" DF=$G(^XTV(8989.3,1,"DEV"))
 ;Check syntax, VMS needs : or [ ]
 I ^%ZOSF("OS")["VMS" D  Q DF ;***EXIT FOR VMS/GTM
 . N P1,P2
 . I DF[":" S P1=$P(DF,":")_":",P2=$P(DF,":",2)
 . E  S P1="",P2=DF
 . I P1="",P2["$" S DF=P2 Q  ;Assume a logical
 . I $L(P2) S:P2'["[" P2="["_P2 S:P2'["]" P2=P2_"]"
 . S DF=P1_P2
 . Q
 ;
 ;Check syntax, Unix check leading & trailing "/"
 I "./"'[$E(DF) S DF="/"_DF
 I $E(DF,$L(DF))'="/" S DF=DF_"/"
 Q DF
STATUS() ;ef,SR. Return EOF status
 U $I
 Q $ZEOF
 ;
EOF(X) ;Eof flag, Pass in $ZA
 Q X
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
MAKEREF(HF,IX,OVF) ;Internal call to rebuild global ref.
 ;Return %ZISHF,%ZISHO,%ZISHI,%ZISUB
 N I,F,MX
 S OVF=$G(OVF,"%ZISHOF")
 S %ZISHI=$$QS^DDBRAP(HF,IX),MX=$$QL^DDBRAP(HF) ;
 S F=$NA(@HF,IX-1) ;Get first part
 I IX=1 S %ZISHF=F_"(%ZISHI" ;Build root, IX=1
 I IX>1 S %ZISHF=$E(F,1,$L(F)-1)_",%ZISHI" ;Build root
 S %ZISHO=%ZISHF_","_OVF_",%OVFCNT)" ;Make overflow
 F I=IX+1:1:MX S %ZISHF=%ZISHF_",%ZISUB("_I_")",%ZISUB(I)=$$QS^DDBRAP(HF,I)
 S %ZISHF=%ZISHF_")"
 Q
FTG(%ZX1,%ZX2,%ZX3,%ZX4,%ZX5) ;ef,SR. Unload contents of host file into global
 ;p1=host file directory
 ;p2=host file name
 ;p3= $NAME REFERENCE INCLUDING STARTING SUBSCRIPT
 ;p4=INCREMENT SUBSCRIPT
 ;p5=Overflow subscript, defaults to "OVF"
 N %ZA,%ZB,%ZC,%ZL,X,%OVFCNT,%CONT
 N I,%ZISH,%ZISH1,%ZISHI,%ZISHL,%ZISHLGR,%ZISHOF,%ZISHOX,%ZISHS,%ZX,%ZISHY,POP,%ZISUB,%EXIT
 S %ZX1=$$DEFDIR($G(%ZX1)),%ZISHOF=$G(%ZX5,"OVF")
 D MAKEREF(%ZX3,%ZX4,"%ZISHOF")
 D OPEN^%ZISH(,%ZX1,%ZX2,"R")
 I POP Q 0
 N $ETRAP S %EXIT=0,$ETRAP="S %ZA=1,%EXIT=1,$ECODE="""" Q"
 U IO F  K %XX D READNXT(.%XX) Q:$$EOF(%ZA)  D
 . S @%ZISHF=%XX
 . I $D(%XX)>2 F %OVFCNT=1:1 Q:'$D(%XX(%OVFCNT))  S @%ZISHO=%XX(%OVFCNT)
 . S %ZISHI=%ZISHI+1
 . Q
 D CLOSE() ;Normal exit
 Q '%EXIT
 ;
ERREOF D CLOSE() ;Got error Reading file
 Q 0
 ;
READNXT(REC) ;
 N T,I,X,%
 U IO R X:2 S %ZA=$ZEOF,REC=$E(X,1,255)
 Q:$L(X)<256
 S %=256 F I=1:1 Q:$L(X)<%  S REC(I)=$E(X,%,%+254),%=%+255
 Q
GTF(%ZX1,%ZX2,%ZX3,%ZX4) ;ef,SR. Load contents of global to host file.
 ;Previously name LOAD
 ;p1=$NAME of global reference
 ;p2=incrementing subscript
 ;p3=host file directory
 ;p4=host file name
 N %ZISHY,%ZISHLGR,%ZISHOX
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
 ;
MGTF(%ZX1,%ZX2,%ZX3,%ZX4,%ZX5) ;
 ;p1=$NAME of global reference
 ;p2=incrementing subscript
 ;p3=host file directory
 ;p4=host file name
 N %ZISH,%ZISH1,%ZISHI,%ZISHL,%ZISHLGR,%ZISHS,%ZISHOX,IO,%ZX,Y
 D MAKEREF(%ZX1,%ZX2)
 D OPEN^%ZISH(,%ZX3,%ZX4,%ZX5) ;Default dir set in open
 I POP Q 0
 N X
 N $ETRAP S $ETRAP="",X="ERREOF^%ZISH",@^%ZOSF("TRAP")
 F  Q:'($D(@%ZISHF)#2)  S %ZX=@%ZISHF,%ZISHI=%ZISHI+1 U IO W %ZX,!
 D CLOSE() ;Normal Exit
 Q 1
 ;
