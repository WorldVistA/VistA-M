webinit ; OSE/SMH - Initialize Web Server;2019-11-14  2:36 PM
 ;;1.1.1;MASH WEB SERVER/WEB SERVICES
 ;
 ; Map %web on Cache
 DO CACHEMAP("%web")
 ;
 ; Set-up TLS on Cache
 DO CACHETLS
 ;
 ; Install the package
 D INSTALLRO("https://github.com/shabiel/M-Web-Server/releases/download/1.1.1/mws.rsa")
 ;
 ; If fileman is installed, do an init for the %web(17.001 file
post ; [Public] Run this entry point if you don't want to download the code.
 I $D(^DD) D ^%webINIT
 ;
 ; Load the URLs
 D LOADHAND
 ; 
 ; Set the home directory for the server
 N % S %=$$HOMEDIR
 I '% QUIT
 ;
 ; Set start port
 N PORT S PORT=$$PORT()
 I PORT=0 QUIT
 ;
 ; Start Server
 D job^%webreq(PORT)
 ;
 W !!,"Mumps Web Services is now listening to port "_PORT,!
 N SERVER S SERVER="http://localhost:"_PORT_"/"
 W "Visit "_SERVER_" to see the home page.",!
 W "Also, try the sample web services...",!
 W " - "_SERVER_"xml",!
 W " - "_SERVER_"ping",!
 ;
 QUIT
 ;
CACHE() Q $L($SY,",")'=2
GTM()   Q $P($SY,",")=47
 ;
INSTALLRO(URL) ; [Private] Download and Install RO files
 ; Get current directory (GT.M may need it to write routines later)
 N PWD S PWD=$$PWD()
 ;
 ; Change to temporary directory (a bit complex for Windows)
 D CDTMPDIR
 ;
 ; Get temp dir
 N TMPDIR S TMPDIR=$$PWD()
 ;
 ; Download the files from Github into temp directory
 D DOWNLOAD(URL)
 ;
 ; Go back to the old directory
 D CD(PWD)
 ;
 ; Silently install RSA -- fur GT.M pass the GTM directory in case we need it.
 new filename set filename=$p(URL,"/",$l(URL,"/"))
 I $$CACHE DO RICACHE(TMPDIR_filename)
 I $$GTM DO RIGTM(TMPDIR_filename,,PWD)
 QUIT
 ;
PWD() ; $$ - Get current directory
 Q:$$CACHE $ZU(168)
 Q:$$GTM $ZD
 S $EC=",U-NOT-IMPLEMENTED,"
 QUIT
 ;
CDTMPDIR ; Proc - Change to temporary directory
 I $$GTM S $ZD="/tmp/" QUIT  ; GT.M
 I $$CACHE S %=$ZU(168,^%SYS("TempDir")) QUIT  ; Cache
 S $EC=",U-NOT-IMPLEMENTED,"
 QUIT
 ;
 ;
CD(DIR) ; Proc - Change to the old directory
 I $$CACHE N % S %=$ZU(168,DIR) QUIT
 I $$GTM S $ZD=DIR QUIT
 QUIT
 ;
 ;
CACHEMAP(G) ; Map Globals and Routines away from %SYS in Cache
 ; ZEXCEPT: AddGlobalMapping,Class,Config,Configuration,Create,Get,GetErrorText,GetGlobalMapping,MapRoutines,MapGlobals,Namespaces,Status,class - these are all part of Cache class names
 ; Get current namespace
 I $$GTM QUIT
 ;
 S G=G_"*"
 N NMSP
 I $P($P($ZV,") ",2),"(")<2012 S NMSP=$ZU(5)
 I $P($P($ZV,") ",2),"(")>2011 S NMSP=$NAMESPACE
 ;
 N $ET S $ET="ZN NMSP D ^%ZTER S $EC="""""
 ;
 ZN "%SYS" ; Go to SYS
 ;
 ; Props
 N PROP
 N % S %=##Class(Config.Namespaces).Get(NMSP,.PROP) ; Get all namespace properties
 I '% W !,"Error="_$SYSTEM.Status.GetErrorText(%) S $EC=",U-CONFIG-FAIL," QUIT
 ;
 N DBG S DBG=PROP("Globals")  ; get the database globals location
 N DBR S DBR=PROP("Routines") ; get the database routines location
 ;
 ; the following is needed for the call to MapGlobals.Create below, is not set in above call
 S PROP("Database")=NMSP
 ;
 N %
 S %=##class(Config.Configuration).GetGlobalMapping(NMSP,G,"",DBG,DBG)
 I '% S %=##class(Config.Configuration).AddGlobalMapping(NMSP,G,"",DBG,DBG)
 I '% W !,"Error="_$SYSTEM.Status.GetErrorText(%) S $EC=",U-CONFIG-FAIL," QUIT
 ;
 N PROPRTN S PROPRTN("Database")=DBR
 N % S %=##Class(Config.MapRoutines).Get(NMSP,G,.PROPRTN)
 S PROPRTN("Database")=DBR  ; Cache seems to like deleting this
 I '% S %=##Class(Config.MapRoutines).Create(NMSP,G,.PROPRTN)
 I '% W !,"Error="_$SYSTEM.Status.GetErrorText(%) S $EC=",U-CONFIG-FAIL," QUIT
 ZN NMSP ; Go back
 QUIT
 ;
 ;
CACHETLS ; Create a client SSL/TLS config on Cache
 I $$GTM QUIT
 ;
 ; Create the configuration
 N $NAMESPACE S $NAMESPACE="%SYS"
 n config,status
 n % s %=##class(Security.SSLConfigs).Exists("encrypt_only",.config,.status) ; check if config exists
 i '% d
 . n prop s prop("Name")="encrypt_only"
 . s %=##class(Security.SSLConfigs).Create("encrypt_only",.prop) ; create a default ssl config
 . i '% w $SYSTEM.Status.GetErrorText(%) s $ec=",u-cache-error,"
 . s %=##class(Security.SSLConfigs).Exists("encrypt_only",.config,.status) ; get config
 e  s %=config.Activate()
 ;
 ; Test it by connecting to encrypted.google.com
 n rtn
 d config.TestConnection("encrypted.google.com",443,.rtn)
 i rtn w "TLS/SSL client configured on Cache as config name 'encrypt_only'",!
 e  w "Cannot configure TLS/SSL on Cache",! s $ec=",u-cache-error,"
 QUIT
 ;
DOWNLOAD(URL) ; Download the files from Github
 D:$$CACHE DOWNCACH(URL)
 D:$$GTM DOWNGTM(URL)
 QUIT
 ;
DOWNCACH(URL) ; Download for Cache
 ; Download and save
 set httprequest=##class(%Net.HttpRequest).%New()
 if $e(URL,1,5)="https" do
 . set httprequest.Https=1
 . set httprequest.SSLConfiguration="encrypt_only"
 new server set server=$p(URL,"://",2),server=$p(server,"/")
 new port set port=$p(server,":",2)
 new filepath set filepath=$p(URL,"://",2),filepath=$p(filepath,"/",2,99)
 new filename set filename=$p(filepath,"/",$l(filepath,"/"))
 set httprequest.Server=server
 if port set httprequest.Port=port
 set httprequest.Timeout=5
 new status set status=httprequest.Get(filepath)
 new response set response=httprequest.HttpResponse.Data
 new sysfile set sysfile=##class(%Stream.FileBinary).%New()
 set status=sysfile.FilenameSet(filename)
 set status=sysfile.CopyFromAndSave(response)
 set status=sysfile.%Close()
 QUIT
 ;
DOWNGTM(URL) ; Download for GT.M
 N CMD S CMD="curl -s -L -O "_URL
 O "pipe":(shell="/bin/sh":command=CMD)::"pipe"
 U "pipe" C "pipe"
 QUIT
 ;
RIGTM(ROPATH,FF,GTMDIR) ; Silent Routine Input for GT.M
 ; ROPATH = full path to routine archive
 ; FF = Form Feed 1 = Yes 0 = No. Optional.
 ; GTMDIR = GTM directory in case gtmroutines is relative to current dir
 ;
 ; Check inputs
 I $ZPARSE(ROPATH)="" S $EC=",U-NO-SUCH-FILE,"
 S FF=$G(FF,0)
 ;
 ; Convert line endings from that other Mumps
 O "pipe":(shell="/bin/sh":command="perl -pi -e 's/\r\n?/\n/g' "_ROPATH:parse)::"pipe"
 U "pipe" C "pipe"
 ;
 ; Set end of routine
 N EOR
 I FF S EOR=$C(13,12)
 E  S EOR=""
 ;
 ; Get output directory
 N D D PARSEZRO(.D,$ZROUTINES)
 N OUTDIR S OUTDIR=$$ZRO1ST(.D)
 ;
 ; If output directory is relative, append GTM directory to it.
 I $E(OUTDIR)'="/" S OUTDIR=GTMDIR_OUTDIR
 ;
 ; Open use RO/RSA
 O ROPATH:(readonly:block=2048:record=2044:rewind):0 E  S $EC=",U-ERR-OPEN-FILE,"
 U ROPATH
 ;
 ; Discard first two lines
 N X,Y R X,Y
 ;
 F  D  Q:$ZEOF
 . ; Read routine info line
 . N RTNINFO R RTNINFO
 . Q:$ZEOF
 . ;
 . ; Routine Name is 1st piece
 . N RTNNAME S RTNNAME=$P(RTNINFO,"^")
 . ;
 . ; Check routine name
 . I RTNNAME="" QUIT
 . I RTNNAME'?1(1"%",1A).99AN S $EC=",U-INVALID-ROUTINE-NAME,"
 . ;
 . ; Path to save routine, and save
 . N SAVEPATH S SAVEPATH=OUTDIR_$TR(RTNNAME,"%","_")_".m"
 . O SAVEPATH:(newversion:noreadonly:blocksize=2048:recordsize=2044)
 . F  U ROPATH R Y Q:Y=EOR  Q:$ZEOF  U SAVEPATH W $S(Y="":" ",1:Y),!
 . C SAVEPATH
 ;
 C ROPATH
 ;
 QUIT  ; Done
 ;
PARSEZRO(DIRS,ZRO) ; Parse $zroutines properly into an array
 ; Eat spaces
 F  Q:($E(ZRO)'=" ")  S ZRO=$E(ZRO,2,999)
 ;
 N PIECE
 N I
 F I=1:1:$L(ZRO," ") S PIECE(I)=$P(ZRO," ",I)
 N CNT S CNT=1
 F I=0:0 S I=$O(PIECE(I)) Q:'I  D
 . S DIRS(CNT)=$G(DIRS(CNT))_PIECE(I)
 . I DIRS(CNT)["("&(DIRS(CNT)[")") S CNT=CNT+1 QUIT
 . I DIRS(CNT)'["("&(DIRS(CNT)'[")") S CNT=CNT+1 QUIT
 . S DIRS(CNT)=DIRS(CNT)_" " ; prep for next piece
 QUIT
 ;
ZRO1ST(DIRS) ; $$ Get first routine directory
 ; TODO: Deal with .so.
 N OUT ; $$ return
 N %1 S %1=DIRS(1) ; 1st directory
 ; Parse with (...)
 I %1["(" DO
 . S OUT=$P(%1,"(",2)
 . I OUT[" " S OUT=$P(OUT," ")
 . E  S OUT=$P(OUT,")")
 ; no parens
 E  S OUT=%1
 ;
 ; Add trailing slash
 I $E(OUT,$L(OUT))'="/" S OUT=OUT_"/"
 QUIT OUT
 ;
RICACHE(ROPATH) ; Silent Routine Input for Cache
 D $SYSTEM.Process.SetZEOF(1) ; Cache stuff!!
 I $ZSEARCH(ROPATH)="" S $EC=",U-NO-SUCH-FILE,"
 N EOR S EOR=""
 ;
 ; Open using Stream Format (TERMs are CR/LF/FF)
 O ROPATH:("RS"):0 E  S $EC=",U-ERR-OPEN-FILE,"
 U ROPATH
 ;
 ; Discard first two lines
 N X,Y R X,Y
 ;
 F  D  Q:$ZEOF
 . ; Read routine info line
 . N RTNINFO R RTNINFO
 . Q:$ZEOF
 . ;
 . ; Routine Name is 1st piece
 . N RTNNAME S RTNNAME=$P(RTNINFO,"^")
 . ;
 . ; Check routine name
 . I RTNNAME="" QUIT
 . I RTNNAME'?1(1"%",1A).99AN S $EC=",U-INVALID-ROUTINE-NAME,"
 . ;
 . N RTNCODE,L S L=1
 . F  R Y:0 Q:Y=EOR  Q:$ZEOF  S RTNCODE(L)=Y,L=L+1
 . S RTNCODE(0)=L-1 ; required for Cache
 . D ROUTINE^%R(RTNNAME_".INT",.RTNCODE,.ERR,"CS",0)
 ;
 C ROPATH
 ;
 QUIT  ; Done
 ;
TESTD(DIR) ; $$ ; Can I write to this directory?
 Q:($$CACHE) $$TESTD00(DIR)
 Q:($$GTM) $$TESTD47(DIR)
 ;
TESTD00(DIR) ; $$ ; Can I write to this directory in Cache?
 N $ET S $ET="G TESTDET"
 O DIR_"test.txt":"NWS":0
 E  Q 0
 U DIR_"test.txt"
 WRITE "TEST"
 C DIR_"test.txt":"D"
 QUIT 1
 ;
TESTD47(DIR) ; $$ ; Can I write to this directory in GT.M?
 N $ET S $ET="G TESTDET"
 O DIR_"test.txt":(newversion):0
 E  Q 0
 U DIR_"test.txt"
 WRITE "TEST"
 C DIR_"test.txt":(delete)
 QUIT 1
 ;
TESTDET ; Open File Error handler
 S $EC="" 
 QUIT 0
 ;
 ; Load URL handlers
LOADHAND ;
 do addService^%webutils("GET","r/{routine?.1""%25"".32AN}","R^%webapi")
 do addService^%webutils("PUT","r/{routine?.1""%25"".32AN}","PR^%webapi",1,"XUPROGMODE")
 do addService^%webutils("GET","error","ERR^%webapi")
 do addService^%webutils("POST","rpc/{rpc}","RPC^%webapi",1)
 do addService^%webutils("GET","bigoutput","bigoutput^%webapi")
 n params s params(1)="U^rpc",params(2)="F^start",params(3)="F^direction",params(4)="B"
 do addService^%webutils("POST","rpc2/{rpc}","rpc2^%webapi",1,"","",.params)
 quit
 ;
HOMEDIR() ; Set ^%webhome (0 = failure; 1 = success)
 W !!!
 W "Enter the home directory where you will store the html, js, and css files"
 W !!
 W "Make sure this is a directory where you have write permissions.",!!
 ;
 W "To help you, I am going to try to test various directories I think",!
 W "may work",!!
 ;
 N D F D=$$PWD(),"/var/www/","C:\Inetpub\www\" D
 . W D,?50,$S($$TESTD(D):"[OK]",1:"[NOT OK]"),!
 ;
 N DIR
AGAIN ; Try again
 W !,"Enter Directory: ",$$PWD(),"// "
 R DIR:30
 E  QUIT:$Q 0 QUIT
 I DIR["^" QUIT:$Q 0 QUIT
 I $L(DIR),DIR["/",$E(DIR,$L(DIR))'="/" S $E(DIR,$L(DIR)+1)="/"
 I $L(DIR),DIR["\",$E(DIR,$L(DIR))'="\" S $E(DIR,$L(DIR)+1)="\"
 S ^%webhome=$S($L(DIR):DIR,1:$$PWD())
 I '$$TESTD(^%webhome) WRITE "Sorry, I can't write to this directory" G AGAIN
 ;
 ; Create www directory; D = delimiter
 N D S D=$S(^%webhome["/":"/",1:"\")
 I $P(^%webhome,D,$L(^%webhome,D)-1)'="www" D MKDIR(^%webhome_"www") S ^%webhome=^%webhome_"www"_D
 QUIT:$QUIT 1 QUIT
 ;
MKDIR(DIR) ; Proc; Make directory; does not create parents
 I $$CACHE N % S %=$ZF(-1,"mkdir "_DIR)
 I $$GTM o "p":(shell="/bin/sh":command="mkdir "_DIR)::"pipe" U "p" C "p"
 QUIT
 ;
PORT() ; $$; select a port
 N PORT,PORTOK
 S PORT="",PORTOK=0
 F  D  Q:PORTOK
 . R !,"Enter a port number between 1024 and 65535: 9080// ",PORT:30
 . E  S PORT=0,PORTOK=1 QUIT
 . I PORT["^" S PORT=0,PORTOK=1 QUIT
 . I PORT="" S PORT=9080
 . Q:'((PORT>1023)&(PORT<65536)) ; De Morgan's law exit
 . S PORTOK=$$PORTOK(PORT)
 . I 'PORTOK W !,"Couldn't open this port... try another one"
 QUIT PORT
 ;
PORTOK(PORT) ; $$; Is this port okay?
 N OKAY
 N $ET,$ES S $ET="G PORTOKER"
 ;
 ; Cache
 I $$CACHE DO  QUIT OKAY
 . N TCPIO S TCPIO="|TCP|"_PORT
 . O TCPIO:(:PORT:"ACT"):2
 . I  S OKAY=1
 . E  S OKAY=0
 . C TCPIO
 ;
 ; GT.M
 I $$GTM DO  QUIT OKAY
 . N TCPIO S TCPIO="server$"_PORT
 . O TCPIO:(ZLISTEN=PORT_":TCP":delim=$c(10,13):attach="server"):2:"socket"
 . I  S OKAY=1
 . E  S OKAY=0
 . C TCPIO
 ;
 S $EC=",U-NOT-IMPLEMENTED,"
 QUIT
PORTOKER ; Error handler for open port
 I $ES QUIT
 S $EC=""
 QUIT 0
 ;
uninstallMWS ; Remove MWS completely
 if $data(^DD) do
 . do DT^DICRW
 . set DIU="^%web(17.6001,",DIU(0)="SD" do EN^DIU2
 do delRou("%web*")
 kill ^%web,^%webhttp
 quit
 ;
delRou(nmsp) ;
 if $$GTM do DELRGTM(nmsp)
 if $$CACHE do DELRCACH(nmsp)
 quit
 ;
TEST D EN^%ut($T(+0),3) QUIT
GTMRITST ; @TEST - Test GT.M Routine Input
 ; Use VPE's RSA file to test.
 Q:'$$GTM
 N OLDDIR S OLDDIR=$$PWD()
 D DELRGTM("%ZV*"),DELRGTM("ZV*")
 D SILENT^%RSEL("%ZV*")
 D CHKEQ^%ut(%ZR,0)
 N URL S URL="http://hardhats.org/tools/vpe/VPE_12.zip"
 S $ZD="/tmp/"
 N CMD S CMD="curl -L -s -O "_URL
 O "p":(shell="/bin/sh":command=CMD:parse)::"pipe"
 U "p" C "p"
 S CMD="unzip -o /tmp/VPE_12.zip"
 O "p":(shell="/bin/sh":command=CMD:parse)::"pipe"
 U "p" C "p"
 S $ZD=OLDDIR
 N PATH S PATH="/tmp/VPE_12_Rtns.MGR"
 D RIGTM(PATH,,OLDDIR)
 D SILENT^%RSEL("%ZV*")
 D CHKTF^%ut(%ZR>0)
 QUIT
 ;
DELRGTM(NMSP) ; Delete routines for GT.M - yahoo
 D SILENT^%RSEL(NMSP)
 N R S R="" F  S R=$O(%ZR(R)) Q:R=""  D
 . N P S P=%ZR(R)_$TR(R,"%","_")_".m"
 . O P C P:(delete)
 QUIT
 ;
CACHERIT ; @TEST - Test Cache Routine Input
 Q:'$$CACHE
 D DELRCACH("%ZV*"),DELRCACH("ZV*")
 D CHKTF^%ut('$D(^$R("%ZVEMD")))
 N OLD S OLD=$$PWD()
 D CDTMPDIR
 N URL S URL="http://hardhats.org/tools/vpe/VPE_12.zip"
 D DOWNCACH(URL)
 S %=$ZF(-1,"unzip -o VPE_12.zip")
 N PATH S PATH="VPE_12_Rtns.MGR"
 N %,A
 ; Fur VPE
 N NS S NS=$NAMESPACE
 ZN "%SYS"
 S %=##class(Config.Configuration).AddGlobalMapping(NS,"%Z*","",NS,NS)
 S A("Database")=NS S %=##Class(Config.MapRoutines).Create(NS,"%Z*",.A)
 ZN NS
 D RICACHE(PATH)
 D CD(OLD)
 D CHKTF^%ut($D(^$R("%ZVEMD")))
 QUIT
 ;
DELRCACH(NMSP) ; Delete routines for Cache - yahoo again
 I $E(NMSP,$L(NMSP))'="*" D  QUIT
 . D DEL^%R(NMSP_".INT")
 S NMSP=$E(NMSP,1,$L(NMSP)-1)
 N R S R=NMSP
 D:$D(^$R(R))  F  S R=$O(^$R(R)) Q:R=""  Q:($P(R,NMSP,2)="")  D
 . X "ZR  ZS @R"
 QUIT
 ;
LHTEST ; @TEST - Load hander test... make sure it loads okay even multiple times
 N I F I=1:1:30 D LOADHAND
 D CHKTF^%ut($O(^%web(17.6001," "),-1)<20) ; Should have just 6 entries
 QUIT
 ;
WDTESTY ; @TEST - Successful write to a directory!
 N OUT
 N OLD S OLD=$$PWD()
 D CDTMPDIR
 N D S D=$$PWD()
 I $$CACHE S OUT=$$TESTD00(D)
 I $$GTM S OUT=$$TESTD47(D)
 D CHKTF^%ut(OUT)
 D CD(OLD)
 QUIT
 ;
WDTESTN0 ; @TEST - Try to write to a directory with no permissions
 N OUT
 I $$GTM S OUT=$$TESTD00("/root/")
 I $$CACHE S OUT=$$TESTD47("/root/")
 D CHKTF^%ut(OUT=0)
 QUIT
WDTESTN1 ; @TEST - Try to write to a directory that doesn't exist
 N OUT
 I $$GTM S OUT=$$TESTD00("/lkjasdf/lkasjdflka/lakjdfs/")
 I $$CACHE S OUT=$$TESTD47("/lkjasdf/lkasjdflka/lakjdfs/")
 D CHKTF^%ut(OUT=0)
 QUIT
PORTOKT ; @TEST - Test Port Okay
 n gtmDarwin s gtmDarwin=$$GTM&($ZV["Darwin")
 I 'gtmDarwin do CHKEQ^%ut($$PORTOK(135),0)
 do CHKEQ^%ut($$PORTOK(61232),1)
 QUIT
 ;
 ; Copyright 2013-2019 Sam Habiel
 ;
 ;Licensed under the Apache License, Version 2.0 (the "License");
 ;you may not use this file except in compliance with the License.
 ;You may obtain a copy of the License at
 ;
 ;    http://www.apache.org/licenses/LICENSE-2.0
 ;
 ;Unless required by applicable law or agreed to in writing, software
 ;distributed under the License is distributed on an "AS IS" BASIS,
 ;WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ;See the License for the specific language governing permissions and
 ;limitations under the License.
