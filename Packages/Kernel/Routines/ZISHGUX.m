%ZISH ;ISF/AC,RWF,VEN/SMH - GT.M for Unix Host file Control ;2018-06-06  1:47 PM
 ;;8.0;KERNEL;**275,306,385,524,10001,10002**;Jul 10, 1995;Build 26
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Original Routine authored by Department of Veterans Affairs
 ; EPs OPEN,DEL1,CD,PWD,MAXREC,MKDIR,SIZE,WGETSYNC,DF,SEND,SENDTO1 
 ; --> authored by Sam Habiel 2016-2018.
 ; EPs MV,DEFDIR,FTG,READNXT,MGTF have bugs fixed by Sam Habiel 2016.
 ; 
 ;
OPEN(X1,X2,X3,X4,X5,X6) ;SR. Open file
 ;D OPEN^%ZISH([handlename],[directory],filename,[accessmode],[recsize])
 ;X1=handle name
 ;X2=directory, X3=filename, X4=access mode
 ;X5=new file max record size, X6=Subtype
 ; ZEXCEPT: IOM,IOSL,IOT,POP
 ;
 ; RPMS has a 3 parameter version (directory, file, access mode)
 ; If we only have 3 parameters, move them over from X1,X2,X3 ->
 ; X2,X3,X4
 ; RPMS's OPENI also quits with a value, unlike the VistA call.
 ; So I added $Q to check for that.
 I '$D(X4) S X4=X3,X3=X2,X2=X1 K X1
 ;
 N %,%1,%2,%IO,%I2,%P,%T,X,Y,$ETRAP
 S $ETRAP="G OPNERR^%ZISH"
 ; If X2 isn't supplied, get default directory; or resolve it if supplied
 S U="^",X2=$$DEFDIR($G(X2)),X4=$$UP^XLFSTR(X4)
 ;
 ; These are common sense
 S Y=$S(X4["A":"append",X4["R":"readonly",X4["W":"newversion",1:"readonly")
 ;
 ; Binary mode. ! and # have no effect.
 ; NB: Reads are in record size; writes pad out to record size
 N RECSIZE S RECSIZE=$G(X5,"512")
 I X4["B" S Y=Y_":fixed:nowrap:recordsize="_RECSIZE ; Binary Mode
 ;
 ; Streaming Mode (almost everybody wants this all of the time)
 I X4'["B",'$G(X5) S Y=Y_":nowrap:stream" ; Streaming Mode (default)
 ;
 ; Variable records mode. Records are TRUNCATED at a specific width,
 ; but, unlike fixed records, you can end them early with a !.
 I X4'["B",$G(X5)  S Y=Y_":variable:nowrap:recordsize="_+X5
 ;
 S:$E(Y)=":" $E(Y)=""
 S %IO=X2_X3,%I2="%IO:"_$S($L(Y):"("_Y_")",1:"")_":0"
 O @%I2 E  S POP=1 Q:$Q 1 Q
 ;
 S IO=%IO,IO(1,IO)="",IOT="HFS",IOM=80,IOSL=60,POP=0 D SUBTYPE^%ZIS3($G(X6))
 I $G(X1)]"" D SAVDEV^%ZISUTL(X1)
 Q:$Q 0 Q
OPNERR ;error on open
 ; ZEXCEPT: POP
 S POP=1,$ECODE=""
 ;U:$G(%P)]"" %P
 Q:$Q 1 Q
 ;
CLOSE(X) ;SR. Close HFS device not opened by %ZIS.
 ;X1=Handle name, IO=device
 I IO]"" C IO K IO(1,IO)
 I $G(X)]"" D RMDEV^%ZISUTL(X)
 I $D(IO("HOME"))!$D(^XUTL("XQ",$J,"IOS")) D HOME^%ZIS
 Q
DEL(%ZX1,%ZX2) ;ef,SR. Del fl(s)
 ;S Y=$$DEL^%ZISH("dir path",$NA(array))
 N %ZISH,%ZISHLGR,%ZX,X,%ZXDEL
 S %ZX1=$$DEFDIR($G(%ZX1)),%ZXDEL=1,%ZISH=""
 ;
 ; Error trap is for $D(@%ZX2)
 N $ET S $ET="S $EC="""" G DELVAL^%ZISH"
 I $D(@%ZX2)<10 G DELVAL  ; RPMS format
 E  G DELNAME ; VISTA format
 ;
DELVAL ; [Internal] Delete by Val
 ; RPMS allows you to pass %ZX2 by value -- so handle that here
 ; Also, in the RPMS format, 0 = success and 1 = failure
 ; (b/c that's the return value of the unix rm command)
 ;
 S $ET="S $EC="""" Q 1"
 S %ZXDEL=0
 S %ZISH=%ZX2
 S %ZX=$S(%ZISH[%ZX1:%ZISH,1:%ZX1_%ZISH)
 O %ZX:READONLY:0
 E  S %ZXDEL=1 Q  ; Can't open it.
 C %ZX:DELETE
 I $ZSEARCH(%ZX)]"" S %ZXDEL=1 ; Delete was not successful.
 Q %ZXDEL
 ; /end RPMS implementation
 ;
DELNAME ; [Internal] Delete by Name
 ; ZEXCEPT: %ZISH,%ZISHLGR,%ZX,X,%ZXDEL,%ZX1,%ZX2
 ; %ZX2 is a named array (VistA format)
 F  S %ZISH=$O(@%ZX2@(%ZISH)) Q:%ZISH=""  D
 . N $ETRAP S $ETRAP="D DELERR^%ZISH"
 . I %ZISH["*" S %ZXDEL=0 Q  ; Wild card not allowed.
 . S %ZX=$ZSEARCH(%ZX1_%ZISH)
 . Q:%ZX=""           ; File doesn't exist - not an error, just quit.
 . O %ZX:READONLY:0
 . E  S %ZXDEL=0 Q  ; Can't open it.
 . C %ZX:DELETE
 . I $ZSEARCH(%ZX)]"" S %ZXDEL=0 ; Delete was not successful.
 Q %ZXDEL
 ;
DELERR ;Trap any $ETRAP error, unwind and return.
 ; ZEXCEPT: %ZXDEL
 S $ETRAP="D UNWIND^%ZTER"
 S %ZXDEL=0
 D UNWIND^%ZTER Q
 ;
DEL1(%ZX3) ;ef,SR. Delete one file
 N %ZI1,%ZI2
 D SPLIT(%ZX3,.%ZI1,.%ZI2) S %ZI2(%ZI2)=""
 Q $$DEL(%ZI1,$NA(%ZI2))
 ;
SPLIT(%I,%O1,%O2) ;[Public] Split to path,file
 N %D,D
 S %D="/",%O1="",%O2=""
 S D=$L(%I,%D),%O1=$P(%I,%D,1,D-1),%O2=$P(%I,%D,D)
 Q
LIST(%ZX1,%ZX2,%ZX3) ;ef,SR. Set local array holding fl names
 ;S Y=$$LIST^ZISH("/dir/","list_root","return_root")
 ;list_root can have XX("A*"), XX("test.com")...
 ;Both arrays passed as $NA values (closed roots).
 N %ZISH,%ZIX,%ZIY,POP,X
 N $ETRAP,$ESTACK
 S $ETRAP="G LSTX^%ZISH" ; for the next line
 S %ZX1=$$DEFDIR($G(%ZX1))
 ;
 ; RPMS allows %ZX2 to be passed by value and %ZX3 to be passed by reference
 ; Next line's error trap applies only to $D(@%ZX2)
 S $ETRAP="S $EC="""" Q $$LISTI()"
 I $D(@%ZX2)<10 Q $$LISTI()
 ;Get fls, Build listing in %ZISHDL1 with ls
 S $ETRAP="G LSTX^%ZISH"
 S %ZISH=""
 F  S %ZISH=$O(@%ZX2@(%ZISH)) Q:%ZISH=""  D
 . S %ZIX=$ZPARSE(%ZX1_%ZISH) Q:%ZIX=""
 . F  S %ZIY=$ZSEARCH(%ZIX) Q:%ZIY=""  S %ZIY=$ZPARSE(%ZIY,"NAME")_$ZPARSE(%ZIY,"TYPE"),@%ZX3@(%ZIY)=""
LSTX ;
 S $ECODE=""
 S $ETRAP="G LISTIX^%ZISH" ; This is in case $$DEFDIR fails but 2nd par is passed by reference (So @ on it will crash)
 Q ($Q(@%ZX3)]"")
 ;
LISTI() ; [Internal] RPMS implementation of directory lister
 ; %ZX1 by value; %ZX2 by value; %ZX3 by reference
 ; ZEXCEPT: %ZX1,%ZX2,%ZX3
 ; ZEXCEPT: %ZIX,%ZIY
 S $ETRAP="G LSTIX^%ZISH"
 I $G(%ZX1)']""!($G(%ZX2)']"") Q 0
 S %ZIX=$ZPARSE(%ZX1_%ZX2) Q:%ZIX="" 0
 N %ZISHN F %ZISHN=1:1 S %ZIY=$ZSEARCH(%ZIX) Q:%ZIY=""  D
 . S %ZIY=$ZPARSE(%ZIY,"NAME")_$ZPARSE(%ZIY,"TYPE")
 . S %ZX3(%ZISHN)=%ZIY
LISTIX ; [Internal] Error Trap target for LISTI; Fallthrough
 S $ECODE=""
 Q '$D(%ZX3)
 ;
MV(X1,X2,Y1,Y2) ;ef,SR. Rename a fl
 ;S Y=$$MV^ZISH("/dir/","fl","/dir/","fl")
 N %Z,%C
 S X1=$$DEFDIR($G(X1)),Y1=$$DEFDIR($G(Y1))
 S %C="mv "
 ;Pbv or qit
 I (X2="")!(Y2="") Q 0
 N % S %=$$RETURN^%ZOSV(%C_X1_X2_" "_Y1_Y2)
 S %Z=$ZSEARCH(Y1_Y2)
 Q $L(%Z)>0
 ;
CD(D) ; [Public] Change Directory
 S $ZD=D
 QUIT
 ;
PWD() ;ef,SR. Print working directory
 Q $ZDIRECTORY
 ;
DEFDIR(DF) ;ef. Default Dir and frmt
 S DF=$G(DF)
 S:DF="" DF=$P($G(^XTV(8989.3,1,"DEV")),"^",1)
 ;
 ; $ZPARSE is file specific; we need to tell it that we are looking for a DIRECTORY!
 ; Otherwise, we will get a false positive
 I $E(DF,$L(DF))'="/" S DF=DF_"/"
 ;
 S DF=$ZPARSE(DF)
 I DF="" S $EC=",U-INVALID-DIRECTORY,"
 ;
 Q DF
 ;
MKDIR(DIR) ; ef,SR. *10002* Make directory
 N % S %=$$RETURN^%ZOSV("mkdir -p "_DIR,1)
 Q %
 ;
SIZE(DIR,FILE) ; ef,SR. *10002* Get Size of a File
 I $ZV["Darwin" Q $$RETURN^%ZOSV("stat -f%z "_$$DEFDIR(DIR)_FILE)
 Q $$RETURN^%ZOSV("stat -c%s "_$$DEFDIR(DIR)_FILE)
 ;
WGETSYNC(server,remoteDir,localDir,filePatt,port,isTLS) ; ef,SR. *10002* Sync remote directory
 s port=$g(port,443)
 s isTLS=$g(isTLS,1)
 ;
 i $e(remoteDir)'="/" s remoteDir="/"_remoteDir
 ;
 n url s url="http"
 i isTLS s url=url_"s"
 s url=url_"://"_server_":"_port_remoteDir
 ;
 ; -r recursive
 ; -N Turn on time-stamping
 ; -nd Do not create directories
 ; -np Do not follow follow
 ; -A What to accept (file pattern)
 ; -P where to save
 ;
 ; Get compressed file from remote source
 n %cmd s %cmd="wget --header='Accept-Encoding: gzip' -rNndp -A '"_filePatt_"' '"_url_"' -P "_localDir
 n % s %=$$RETURN^%ZOSV(%cmd,1)
 i % quit %
 ;
 ; Rename them to .gz if they are really compressed
 n %cmd s %cmd="for f in `file "_localDir_"/* | grep gzip | cut -d':' -f1`; do mv $f $f.gz; done"
 n % s %=$$RETURN^%ZOSV(%cmd,1)
 i % quit %
 ;
 ; gunzip (but don't warn if there is nothing to do: -q)
 n %cmd s %cmd="gzip -dq "_localDir_"/*"
 n % s %=$$RETURN^%ZOSV(%cmd,1)
 i %=1 s %=0 ; BSD gzip (in OS X) will return 1 if there are no files to operate on. Error safe to ignore.
 i % quit %
 ;
 ; dos2unix
 n %cmd s %cmd="dos2unix "_localDir_"/"_filePatt
 n % s %=$$RETURN^%ZOSV(%cmd,1)
 i % quit %
 ;
 quit %
 ;
STATUS() ;ef,SR. Return EOF status
 U $I
 Q $ZEOF
 ;
EOF(X) ;Eof flag, Pass in $ZA
 Q X
 ;
MAKEREF(HF,IX,OVF) ;Internal call to rebuild global ref.
 ;Return %ZISHF,%ZISHO,%ZISHI,%ZISUB
 ; ZEXCEPT: %ZISHF,%ZISHO,%ZISHI,%ZISUB
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
 ; 
 N %ZA,%ZB,%ZC,%ZL,X,%OVFCNT,%CONT,%EXIT,%XX
 N I,%ZISH,%ZISH1,%ZISHI,%ZISHL,%ZISHLGR,%ZISHOF,%ZISHOX,%ZISHS,%ZX,%ZISHY,POP,%ZISUB,%ZISHF,%ZISHO
 S %ZX1=$$DEFDIR($G(%ZX1)),%ZISHOF=$G(%ZX5,"OVF")
 D MAKEREF(%ZX3,%ZX4,"%ZISHOF")
 D OPEN^%ZISH(,%ZX1,%ZX2,"R")
 I POP Q 0
 N $ETRAP S %EXIT=0,$ETRAP="S %ZA=1,%EXIT=1,$ECODE="""" Q"
 N MAX S MAX=$$MAXREC(%ZISHF)
 U IO F  K %XX D READNXT(.%XX,MAX) Q:$$EOF(%ZA)  D
 . S @%ZISHF=%XX
 . I $D(%XX)>2 F %OVFCNT=1:1 Q:'$D(%XX(%OVFCNT))  S @%ZISHO=%XX(%OVFCNT)
 . S %ZISHI=%ZISHI+1
 . Q
 D CLOSE() ;Normal exit
 Q '%EXIT
 ;
READNXT(REC,MAX) ;
 ; ZEXCEPT: %ZA
 N T,I,X,%
 U IO R X:0 S %ZA=$ZEOF,REC=$E(X,1,MAX-1)
 Q:$L(X)<MAX
 S %=MAX
 F I=1:1 Q:$L(X)<%  S REC(I)=$E(X,%,%+(MAX-2)),%=%+(MAX-1)
 Q
 ;
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
 ; ZEXCEPT: POP
 N %ZISH,%ZISH1,%ZISHI,%ZISHL,%ZISHLGR,%ZISHS,%ZISHOX,IO,%ZX,Y,%ZISHF
 D MAKEREF(%ZX1,%ZX2)
 D OPEN^%ZISH(,%ZX3,%ZX4,%ZX5) ;Default dir set in open
 I POP Q 0
 U IO
 N $ETRAP S $ETRAP="S $EC="""" D CLOSE^%ZISH() Q 0"
 ;
 ; This algorithm takes 20ms for 200,4,5; 
 ; Prev algo was faster I think, but had a bug where it would stop early if we skipped a sub
 D  F  S %ZISHI=$O(@$NA(@%ZX1,%ZX2-1)@(%ZISHI)) Q:'%ZISHI  D
 . Q:'($D(@%ZISHF)#2)
 . W @%ZISHF,!
 D CLOSE() ;Normal Exit
 Q 1
 ;
MAXREC(GLO) ; [Public] Maximum Record Size for a Global
 ; Global passed by name
 N REGION S REGION=$VIEW("REGION",$NA(@GLO))
 I REGION="" S $EC=",U-ERROR,"
 I $T(^%PEEKBYNAME)]"" Q $$^%PEEKBYNAME("gd_region.max_rec_size",REGION)
 I $T(^%DSEWRAP)]"" N FDUMP D  Q FDUMP(REGION,"Maximum record size")
 . D DUMP^%DSEWRAP(REGION,.FDUMP,"fileheader","all")
 ;
 ; -- RPMS ENTRY POINTS! --
 ;
DF(X) ;Directory format
 ; Pass X by ref - both input and output
 Q:X=""
 S X=$TR(X,"\","/")
 S:$E(X,$L(X))'="/" X=X_"/"
 Q
 ;
SEND(ZISH1,ZISH2,ZISH3,ZISHPARM) ;Send UNIX or Windows fl
 Q ""
 ;
SENDTO1(ZISH1,ZISH2)         ;use sendto1 script
 Q ""
