%ZISH ;ISF/AC,RWF - VAX DSM Host file Control ;05/12/2004  10:43
 ;;8.0;KERNEL;**24,36,65,84,104,191,306**;JUL 10, 1995
 ;
OPEN(X1,X2,X3,X4,X5,X6) ;SR. Open file
 ;D OPEN^%ZISH([handlename],[directory],filename,[accessmode],[recsize])
 ;X1=handle name
 ;X2=directory, X3=filename, X4=access mode
 ;X5=new file max record size, X6=Subtype
 ;
 N %,%1,%2,%I,%IO,%I2,%P,%T,X,Y,$ETRAP
 S $ETRAP="D OPNERR^%ZISH"
 S U="^",%I=$I,X2=$$DEFDIR($G(X2)),X4=$$UP^XLFSTR(X4)
 S Y=$S(X4["A":"",X4["R":"READONLY",X4["W":"NEWVERSION",1:"READONLY")
 S Y=Y_$S(X4["B":":BLOCKSIZE=512",$G(X5)&(X4["W"):":RECORDSIZE="_+X5,1:"")
 S:$E(Y)=":" Y=$E(Y,2,999) S %IO=X2_X3,%I2="%IO:"_$S($L(Y):"("_Y_")",1:"")_":3"
 O @%I2 S %T=$T
 I '%T S POP=1 Q
 S IO=%IO,IO(1,IO)="",IOT="HFS",POP=0 D SUBTYPE^%ZIS3($G(X6))
 I $G(X1)]"" D SAVDEV^%ZISUTL(X1)
 U IO:NOTRAP U $S(%I]"":%I,1:$P) ;Enable use of $ZA to test EOF condition.
 Q
OPNERR ;error on open
 S POP=1,$ECODE=""
 U:$P]"" $P
 Q
 ;
CLOSE(X) ;SR. Close HFS device not opened by %ZIS.
 ;X1=Handle name, IO=device
 I IO]"" C IO K IO(1,IO)
 I $G(X)]"" D RMDEV^%ZISUTL(X)
 ;Only reset home if one setup.
 I $D(IO("HOME"))!$D(^XUTL("XQ",$J,"IOS")) D HOME^%ZIS
 Q
DEL(%ZX1,%ZX2) ;ef,SR. Del fl(s)
 ;S Y=$$DEL^%ZISH("/dir/",namevalue)
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
 N $ETRAP,$ESTACK S $ETRAP="",%ZX1=$$DEFDIR($G(%ZX1))
 S %IO=$I,%ZISHDN1="ZISH"_$J_".TMPA",%ZISHDN2="ZISH"_$J_".TMPB"
 S %ZISHDL1=%ZX1_%ZISHDN1,%ZISHDL2=%ZX1_%ZISHDN2
 S $ZT="SPAWNERR^%ZISH"
 ;Init %ZISHDL1, %ZISHDL2 by deleteing them
 I $ZSEARCH(%ZISHDL1)["ZISH" S X=$&ZLIB.%SPAWN("DEL "_%ZISHDL1_";*")
 I $ZSEARCH(%ZISHDL2)["ZISH" S X=$&ZLIB.%SPAWN("DEL "_%ZISHDL2_";*")
 ;Get fls to act on, Build listing in ZISH_$J_.TMPA (%ZISHDL1)
 S %ZISH1=0,%ZISH=""
 F  S %ZISH=$O(@%ZX2@(%ZISH)) Q:%ZISH=""  S X=$$LIST1(%ZX1_%ZISH)
 ;Open %ZISHDL1 to read list backin.
 S $ZT="LSTEOF^%ZISH"
 O %ZISHDL1::5 I '$T G LSTEOF
 U %ZISHDL1:NOTRAP R %ZX:5 I $ZA=-1 G LSTEOF
 F I=0:1 U %ZISHDL1 R %ZX:5 G LSTEOF:$ZA=-1 I %ZX]"" S %X=$P(%ZX,$C(32)) D
 . I %ZX'["Total of",%ZX'?.E1".DIR;".N,%ZX'?1"Directory".E D
 . . I (%X[%ZISHDN1)!(%X[%ZISHDN2) Q
 . . S @%ZX3@(%X)=""
LSTEOF S $ZT=""
 I $L(%IO) U:$D(IO(1,%IO)) IO
 C %ZISHDL1:DELETE
 I $ZSEARCH(%ZISHDL2)]"" S X=$&ZLIB.%SPAWN("DEL "_%ZISHDL2_";*")
 I $ZSEARCH(%ZISHDL1)]"" S X=$&ZLIB.%SPAWN("DEL "_%ZISHDL1_";*")
 S $ECODE=""
 Q ($Q(@%ZX3)]"")
 ;
LIST1(%ZX) ;Get one part of the list
 S $ZT="LSTERR^%ZISH"
 I %ZISH1 D
 . S X=$&ZLIB.%SPAWN("DIR/COL=1 "_%ZX,,%ZISHDL2)
 . I X S X=$&ZLIB.%SPAWN("APPEND "_%ZISHDL2_" "_%ZISHDL1)
 I '%ZISH1 S X=$&ZLIB.%SPAWN("DIR/COL=1 "_%ZX,,%ZISHDL1),%ZISH1=1
 Q 1
LSTERR ;Error in list
 I $ZSEARCH(%ZISHDL2)["ZISH" S X=$&ZLIB.%SPAWN("DEL "_%ZISHDL2_";*")
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
 I X1=Y1 D
 .O @(""""_X1_X2_"""")
 .C @(""""_X1_X2_""":RENAME="_""""_Y1_Y2_"""")
 E  D
 .S Y=$&ZLIB.%SPAWN("COPY "_X1_X2_" "_Y1_Y2,,%ZISHDL1)
 .O %ZISHDL1:READONLY:1
 .I $T C %ZISHDL1:DELETE
 .S X=$&ZLIB.%PARSE(X1_X2)
 .S Y=$&ZLIB.%SPAWN("DEL "_X,,%ZISHDL1)
 .O %ZISHDL1:READONLY:1
 .I $T C %ZISHDL1:DELETE
 Q 1
PWD() ;ef,SR. Print working directory
 N Y
 S Y=$$DEFDIR("")
 S:Y="" Y=$&ZLIB.%PARSE("TMP.TMP",,,"DEVICE")_$&ZLIB.%DIRECTORY
 Q Y
 ;
DEFDIR(DF) ;ef. Default Dir and frmt
 S DF=$G(DF) Q:DF="." "" ;Special way to get current dir.
 S:DF="" DF=$G(^XTV(8989.3,1,"DEV"))
 ;Check syntax, VMS needs [ ] or $
 N P1,P2
 I DF[":" S P1=$P(DF,":")_":",P2=$P(DF,":",2)
 E  S P1="",P2=DF
 I P1="",P2["$" S DF=P2 Q DF ;Assume a logical
 I $L(P2) S:P2'["[" P2="["_P2 S:P2'["]" P2=P2_"]"
 S DF=P1_P2
 Q DF
STATUS() ;ef,SR. Return EOF status
 U $I:NOTRAP
 Q $$EOF($ZA)
 ;
EOF(X) ;Eof flag, Pass in $ZA
 Q (X=-1)
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
 N %ZA,%ZB,%ZC,%ZL,X,%OVFCNT,%CONT
 N I,%ZISH,%ZISH1,%ZISHI,%ZISHL,%ZISHLGR,%ZISHOF,%ZISHOX,%ZISHS,%ZX,%ZISHY,POP,%ZISUB
 S %ZX1=$$DEFDIR($G(%ZX1)),%ZISHOF=$G(%ZX5,"OVF")
 D MAKEREF(%ZX3,%ZX4,"%ZISHOF")
 D OPEN^%ZISH(,%ZX1,%ZX2,"R")
 I POP Q 0
 N $ETRAP S $ETRAP="S $EC="""" D CLOSE^%ZISH Q:$Q 0 Q"
 U IO F  K %XX D READNXT(.%XX) Q:$$EOF(%ZA)  D
 . S @%ZISHF=%XX
 . I $D(%XX)>2 F %OVFCNT=1:1 Q:'$D(%XX(%OVFCNT))  S @%ZISHO=%XX(%OVFCNT)
 . S %ZISHI=%ZISHI+1
 . Q
 D CLOSE() ;Normal exit
 Q 1
 ;
ERREOF D CLOSE() ;Got error Reading file
 Q 0
 ;
READNXT(REC) ;
 N T,I,X,%ZL
 U IO:NOTRAP R REC#255:5 S %ZA=$ZA,%ZB=$ZB,%ZL=%ZA Q:$$EOF(%ZA)
 F I=1:1:%ZL\255 R X#255:5 S %ZA=$ZA Q:$$EOF(%ZA)  S REC(I)=X
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
 N $ETRAP S $ETRAP="S $EC="""" D CLOSE^%ZISH() Q 0"
 F  Q:'($D(@%ZISHF)#2)  S %ZX=@%ZISHF,%ZISHI=%ZISHI+1 U IO W %ZX,!
 D CLOSE() ;Normal Exit
 Q 1
 ;
