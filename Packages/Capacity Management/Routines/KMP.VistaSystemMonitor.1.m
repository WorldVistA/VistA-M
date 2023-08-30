 ;KMP.VistaSystemMonitor.1
 ;Generated for class KMP.VistaSystemMonitor.  Do NOT edit. 03/23/2023 12:17:53PM
 ;;70594C4D;KMP.VistaSystemMonitor
 ;
zDispatchMap(pIndex) public {
 If pIndex=1 Quit $ListBuild("R","/GetNode","GET","GetNode","false")
 If pIndex=2 Quit $ListBuild("R","/GetConfiguration","GET","GetConfiguration","false")
 If pIndex=3 Quit $ListBuild("R","/GetHttpMetrics","GET","GetHttpMetricsG","false")
 If pIndex=4 Quit $ListBuild("R","/KillData","GET","KillData","false")
 If pIndex=5 Quit $ListBuild("R","/GetConfig","POST","GetConfig","false")
 If pIndex=6 Quit $ListBuild("R","/SetConfig","POST","SetConfig","false")
 If pIndex=7 Quit $ListBuild("R","/GetError","POST","GetError","false")
 If pIndex=8 Quit $ListBuild("R","/GetCtmLog","POST","GetCtmLog","false")
 If pIndex=9 Quit $ListBuild("R","/GetPatientList","POST","GetPatientList","false")
 If pIndex=10 Quit $ListBuild("R","/Retry","POST","Retry","false")
 If pIndex=11 Quit $ListBuild("R","/GetPackages","POST","GetPackages","false")
 If pIndex=12 Quit $ListBuild("R","/GetHttpMetrics","POST","GetHttpMetricsP","false")
 If pIndex=13 Quit $ListBuild("R","/ImAlive","POST","ImAlive","false")
 If pIndex=14 Quit $ListBuild("R","/SynthRcmd","POST","SynthRcmd","false")
 If pIndex=15 Quit $ListBuild("R","/SynthFile","POST","SynthFile","false")
 If pIndex=16 Quit $ListBuild("R","/SynthVpr","POST","SynthVpr","false")
 Quit "" }
zGetConfig() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP GetConfigEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    Do %response.SetHeader("Access-Control-Allow-Origin","*")
    Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
    S KMPRET=##class(%Library.DynamicObject).%New()
    S KMPREQ=##class(%Library.DynamicAbstractObject).%FromJSON(%request.Content)
    I KMPREQ.Function'="GetConfig" D  Quit 1
    .S KMPRET.ResultText="Incorrect Function Type"
    .W KMPRET.%ToJSON()
    D SITE^KMPUTLW(KMPRET)
    D CPF^KMPUTLW(KMPRET)
    D MON^KMPUTLW(KMPRET)
    S KMPRET.ResultText="OK"
    S KMPRET.Function=KMPREQ.Function
    W KMPRET.%ToJSON()
    D RU^%ZOSVKR("KMP GetConfigHandler")
    Quit 1 }
zGetConfiguration() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP GetConfigurationEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    S KMPRET=##class(%Library.DynamicObject).%New()
    D SITE^KMPUTLW(KMPRET)
    D CPF^KMPUTLW(KMPRET)
    D MON^KMPUTLW(KMPRET)
    W "<H1>Site</H1>"
    S KMPITER=KMPRET.Site.%GetIterator()
    WHILE KMPITER.%GetNext(.KMPKEY,.KMPVALUE) {
      W KMPKEY_": "_KMPVALUE_"<BR>"
    }
    W "<H1>CPF</H1>"
    W "<H2>CPF Startup</H2>"
    S KMPITER=KMPRET.CPF.Startup.%GetIterator()
    WHILE KMPITER.%GetNext(.KMPKEY,.KMPVALUE) {
    W KMPKEY_": "_KMPVALUE_"<BR>"
    }
    W "<H2>CPF Mirror</H2>"
    S KMPITER=KMPRET.CPF.MirrorMember.%GetIterator()
    WHILE KMPITER.%GetNext(.KMPKEY,.KMPVALUE) {
      W KMPKEY_": "_KMPVALUE_"<BR>"
    }
    W "<H2>CPF Config</H2>"
    S KMPITER=KMPRET.CPF.Config.%GetIterator()
    WHILE KMPITER.%GetNext(.KMPKEY,.KMPVALUE) {
      W KMPKEY_": "_KMPVALUE_"<BR>"
    }
    W "<H1>Monitors</H1>"
    S KMPITER=KMPRET.MonCFG.%GetIterator()
    while KMPITER.%GetNext(.KMPKEY,.KMPLINE) {
        W "<H3>"_KMPLINE.Monitor_"</H3>"
        S KMPITER2 = KMPLINE.%GetIterator()
        while KMPITER2.%GetNext(.KMPKEY2, .KMPLINE2) {
          I KMPKEY2'="ApiKey" W KMPKEY2_": "_KMPLINE2_"<BR>"
        }
    }
    D RU^%ZOSVKR("KMP SetConfigurationHandler")
    Quit 1 }
zGetCtmLog() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP GetCtmLogEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    Do %response.SetHeader("Access-Control-Allow-Origin","*")
    Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
    S KMPRET=##class(%Library.DynamicObject).%New()
    S KMPREQ=##class(%Library.DynamicAbstractObject).%FromJSON(%request.Content)
    I KMPREQ.Function'="GetCtmLog" D  Quit 1
    .S KMPRET.ResultText="Incorrect Function Type"
    .W KMPRET.%ToJSON()
    D SITE^KMPUTLW(KMPRET)
    D CTMLOG^KMPUTLW(KMPRET)
    S KMPRET.ResultText="OK"
    S KMPRET.Function=KMPREQ.Function
    W KMPRET.%ToJSON()
    D RU^%ZOSVKR("KMP GetCtmLogHandler")
    Quit 1 }
zGetError() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP GetErrorEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    Do %response.SetHeader("Access-Control-Allow-Origin","*")
    Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
    S KMPRET=##class(%Library.DynamicObject).%New()
    S KMPREQ=##class(%Library.DynamicAbstractObject).%FromJSON(%request.Content)
    I KMPREQ.Function'="GetError" D  Quit 1
    .S KMPRET.ResultText="Incorrect Function Type"
    .W KMPRET.%ToJSON()
    D GETERR^KMPUTLW2(KMPRET,KMPREQ)
    D SITE^KMPUTLW(KMPRET)
    S KMPRET.ResultText="OK"
    S KMPRET.Function=KMPREQ.Function
    W KMPRET.%ToJSON()
    D RU^%ZOSVKR("KMP GetErrorsHandler")
    Quit 1 }
zGetHttpMetricsG() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP GetHttpMetricsGetEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 W "Invalid Cache Version" Q 1
    S KMPRET=##class(%Library.DynamicObject).%New()
    D SITE^KMPUTLW(KMPRET)
    W "<H1>Site</H1>"
    S KMPITER = KMPRET.Site.%GetIterator()
    WHILE KMPITER.%GetNext(.KEY,.KMPVALUE) {
     W KEY_": "_KMPVALUE_"<BR>"
    }
    S KMPMCHK=%request.Get("MONTYPE")
    I KMPMCHK="" S KMPMCHK="ALL"
    S KMPDATE=%request.Get("DATE")
    I KMPDATE'="" S KMPDCHK="3"_KMPDATE
    E  S KMPDCHK="ALL"
    S KMPSUB="KMP"
    F  S KMPSUB=$O(^XTMP(KMPSUB)) Q:$E(KMPSUB,1,3)'="KMP"  D
    .S KMPDAY=$P(KMPSUB," ",2)
    .Q:(KMPDCHK'=KMPDAY)&&(KMPDCHK'="ALL")
    .W "<H2>"_$P(^XTMP(KMPSUB,0),"^",3)_"</H2>"
    .S KMPMTYP=0
    .F  S KMPMTYP=$O(^XTMP(KMPSUB,KMPMTYP)) Q:KMPMTYP=""  D
    ..Q:(KMPMTYP'[KMPMCHK)&&(KMPMCHK'="ALL")
    ..S KMPNODE=""
    ..F  S KMPNODE=$O(^XTMP(KMPSUB,KMPMTYP,"HTTP",KMPNODE)) Q:KMPNODE=""  D
    ...W "<H3>"_KMPMTYP_" : "_KMPNODE_"</H3>"
    ...S KMPT=""
    ...F  S KMPT=$O(^XTMP(KMPSUB,KMPMTYP,"HTTP",KMPNODE,KMPT)) Q:KMPT=""  D
    ....S KMPTIME=$ZT(KMPT)
    ....S KMPDATA=^XTMP(KMPSUB,KMPMTYP,"HTTP",KMPNODE,KMPT)
    ....W "<pre>"_KMPMTYP_" - "_KMPTIME_" - "_KMPDATA_"</pre>"
    D RU^%ZOSVKR("KMP GetHttpMetricsGetHandler")
    QUIT 1 }
zGetHttpMetricsP() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP GetHttpMetricsPostEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    D %response.SetHeader("Access-Control-Allow-Origin","*")
    D %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
    S KMPRET=##class(%Library.DynamicObject).%New()
    S KMPREQ=##class(%Library.DynamicAbstractObject).%FromJSON(%request.Content)
    I KMPREQ.Function'="HttpMetrics" D  Quit 1
    .S KMPRET.ResultText="Incorrect Function Type"
    .W KMPRET.%ToJSON()
    D SITE^KMPUTLW(KMPRET)
    ;
    S KMPMCHK=KMPREQ.Montype
    I KMPMCHK="" S KMPMCHK="ALL"
    S KMPDATE=KMPREQ.Date
    ; parse odbc date format into fileman data format
    S KMPDCHK="3"_$E(KMPDATE,3,4)_$P(KMPDATE,"-",2)_$P(KMPDATE,"-",3)
    S KMPRET.Date=KMPDATE
    S KMPMLIST=##class(%Library.DynamicArray).%New()
    S KMPSUB="KMP"
    F  S KMPSUB=$O(^XTMP(KMPSUB)) Q:$E(KMPSUB,1,3)'="KMP"  D
    .S KMPDAY=$P(KMPSUB," ",2)
    .Q:KMPDCHK'=KMPDAY
    .S KMPMTYP=0
    .F  S KMPMTYP=$O(^XTMP(KMPSUB,KMPMTYP)) Q:KMPMTYP=""  D
    ..Q:(KMPMCHK'[KMPMTYP)&&(KMPMCHK'="ALL")
    ..S KMPMOBJ=##class(%Library.DynamicObject).%New()
    ..S KMPMOBJ.Monitor=KMPMTYP
    ..S KMPNODE=""
    ..F  S KMPNODE=$O(^XTMP(KMPSUB,KMPMTYP,"HTTP",KMPNODE)) Q:KMPNODE=""  D
    ...S KMPDARR=##class(%Library.DynamicArray).%New()
    ...S KMPT=""
    ...F  S KMPT=$O(^XTMP(KMPSUB,KMPMTYP,"HTTP",KMPNODE,KMPT)) Q:KMPT=""  D
    ....S KMPTIME=$ZT(KMPT)
    ....S KMPDATA=^XTMP(KMPSUB,KMPMTYP,"HTTP",KMPNODE,KMPT)
    ....S KMPDATA=KMPTIME_"^"_KMPNODE_"^"_KMPDATA
    ....D KMPDARR.%Push(KMPDATA)
    ...S KMPMOBJ.Data=KMPDARR
    ..D KMPMLIST.%Push(KMPMOBJ)
    S KMPRET.Monitors=KMPMLIST
    ;
    S KMPRET.Function=KMPREQ.Function
    S KMPRET.ResultText="OK"
    W KMPRET.%ToJSON()
    D RU^%ZOSVKR("KMP GetHttpMetricsPostHandler")
    Quit 1 }
zGetNode() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    W "<H>"_##class(%SYS.System).GetNodeName(1)_"</H>"
    Quit 1 }
zGetPackages() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP GetPackagesEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    Do %response.SetHeader("Access-Control-Allow-Origin","*")
    Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
    S KMPRET=##class(%Library.DynamicObject).%New()
    S KMPREQ=##class(%Library.DynamicAbstractObject).%FromJSON(%request.Content)
    I KMPREQ.Function'="GetPackages" D  Quit 1
    .S KMPRET.ResultText="Incorrect Function Type"
    .W KMPRET.%ToJSON()
    D SITE^KMPUTLW(KMPRET)
    D PACKAGES^KMPUTLW(KMPRET)
    S KMPRET.ResultText="OK"
    S KMPRET.Function=KMPREQ.Function
    W KMPRET.%ToJSON()
    D RU^%ZOSVKR("KMP GetPackagesHandler")
    Quit 1 }
zGetPatientList() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP GetPatientListEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    Do %response.SetHeader("Access-Control-Allow-Origin","*")
    Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
    S KMPRET=##class(%Library.DynamicObject).%New()
    S KMPREQ=##class(%Library.DynamicAbstractObject).%FromJSON(%request.Content)
    I KMPREQ.Function'="GetPatientList" D  Quit 1
    .S KMPRET.ResultText="Incorrect Function Type"
    .W KMPRET.%ToJSON()
    D SITE^KMPUTLW(KMPRET)
    D PATLIST^KMPSYNTH(KMPRET,KMPREQ.Count)
    S KMPRET.Function=KMPREQ.Function
    W KMPRET.%ToJSON()
    D RU^%ZOSVKR("KMP GetPatientListHandler")
    Quit 1 }
zImAlive() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP ImAliveEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    Do %response.SetHeader("Access-Control-Allow-Origin","*")
    Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
    S KMPRET=##class(%Library.DynamicObject).%New()
    S KMPREQ=##class(%Library.DynamicAbstractObject).%FromJSON(%request.Content)
    I KMPREQ.Function'="ImAlive" D  Quit 1
    .S KMPRET.ResultText="Incorrect Function Type"
    .W KMPRET.%ToJSON()
    D SITE^KMPUTLW(KMPRET)
    S KMPRET.Function=KMPREQ.Function
    S KMPRET.ResultText="OK"
    W KMPRET.%ToJSON()
    D RU^%ZOSVKR("KMP ImAliveHandler")
    Quit 1 }
zKillData() public {
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    N $ESTACK,$ETRAP S $ETRAP="D ERR^ZU,UNWIND^%ZTER"
    S KMPRET=##class(%Library.DynamicObject).%New()
    D SITE^KMPUTLW(KMPRET)
    W "<H1>Site</H1>"
    S KMPITER = KMPRET.Site.%GetIterator()
    WHILE KMPITER.%GetNext(.KEY,.KMPVALUE) {
     W KEY_": "_KMPVALUE_"<BR>"
    }
    S KMPMCHK=%request.Get("MONTYPE")
    S KMPMCHK=$REPLACE(KMPMCHK,"""","")
    I KMPMCHK="" S KMPMCHK="VBEM:VCSM:VETM:VHLM:VMCM:VSTM:VTCM"
    S KMPL=$L(KMPMCHK,":")
    F KMPI=1:1:KMPL D
    .S KMPMTYP=$P(KMPMCHK,":",KMPI)
    .K ^KMPTMP("KMPV",KMPMTYP)
    .W "<BR>Data deleted: ",KMPMTYP
    .D STOPMON^KMPVCBG(KMPMTYP,1,0)
    .W "<BR>Monitor stopped: ",KMPMTYP
    Quit 1 }
zRetry() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP RetryEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    Do %response.SetHeader("Access-Control-Allow-Origin","*")
    Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
    S KMPRET=##class(%Library.DynamicObject).%New()
    S KMPREQ=##class(%Library.DynamicAbstractObject).%FromJSON(%request.Content)
    I KMPREQ.Function'="Retry" D  Quit 1
    .S KMPRET.ResultText="Incorrect Function Type"
    .W KMPRET.%ToJSON()
    S KMPRET.ResultText=$$RETRY^KMPUTLW(KMPREQ)
    D SITE^KMPUTLW(KMPRET)
    S KMPRET.Function=KMPREQ.Function
    W KMPRET.%ToJSON()
    D RU^%ZOSVKR("KMP RetryHandler")
    Quit 1 }
zSetConfig() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP SetConfigEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    Do %response.SetHeader("Access-Control-Allow-Origin","*")
    Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
    S KMPRET=##class(%Library.DynamicObject).%New()
    S KMPREQ=##class(%Library.DynamicAbstractObject).%FromJSON(%request.Content)
    I KMPREQ.Function'="SetConfig" D  Quit 1
    .S KMPRET.ResultText="Incorrect Function Type"
    .W KMPRET.%ToJSON()
    S KMPRET.ResultText=$$SETCFG^KMPUTLW2(KMPREQ)
    D SITE^KMPUTLW(KMPRET)
    D CPF^KMPUTLW(KMPRET)
    D MON^KMPUTLW(KMPRET)
    S KMPRET.Function=KMPREQ.Function
    W KMPRET.%ToJSON()
    D RU^%ZOSVKR("KMP SetConfigHandler")
    Quit 1 }
zSupportedVerbs(pUrl,pVerbs) public {
 Set pVerbs="",tSC=1
 Do {
   Set tSC=..ResolveTarget(pUrl,.tTargetUrl,.tTargetClass)
   If ('tSC)||((tTargetUrl="")&&(tTargetClass="")) Quit
   If (tTargetUrl'=pUrl)&&(tTargetClass'=$classname()) {
       Set tSC=$zobjclassmethod(tTargetClass,"SupportedVerbs",tTargetUrl,.pVerbs)
       Quit
   }
   If ##class(%Regex.Matcher).%New("/GetConfig").Match(pUrl) Set pVerbs="POST,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/GetConfiguration").Match(pUrl) Set pVerbs="GET,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/GetCtmLog").Match(pUrl) Set pVerbs="POST,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/GetError").Match(pUrl) Set pVerbs="POST,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/GetHttpMetrics").Match(pUrl) Set pVerbs="GET,POST,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/GetNode").Match(pUrl) Set pVerbs="GET,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/GetPackages").Match(pUrl) Set pVerbs="POST,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/GetPatientList").Match(pUrl) Set pVerbs="POST,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/ImAlive").Match(pUrl) Set pVerbs="POST,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/KillData").Match(pUrl) Set pVerbs="GET,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/Retry").Match(pUrl) Set pVerbs="POST,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/SetConfig").Match(pUrl) Set pVerbs="POST,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/SynthFile").Match(pUrl) Set pVerbs="POST,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/SynthRcmd").Match(pUrl) Set pVerbs="POST,OPTIONS" Quit
   If ##class(%Regex.Matcher).%New("/SynthVpr").Match(pUrl) Set pVerbs="POST,OPTIONS" Quit
 } while 0
 Quit tSC }
zSynthFile() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP SynthFileEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    Do %response.SetHeader("Access-Control-Allow-Origin","*")
    Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
    S KMPRET=##class(%Library.DynamicObject).%New()
    S KMPREQ=##class(%Library.DynamicAbstractObject).%FromJSON(%request.Content)
    I KMPREQ.Function'="SynthFile" D  Quit 1
    .S KMPRET.ResultText="Incorrect Function Type"
    .W KMPRET.%ToJSON()
    D SITE^KMPUTLW(KMPRET)
    D SYNFILE^KMPSYNTH(KMPRET)
    S KMPRET.Function=KMPREQ.Function
    S KMPRET.ResultText="OK"
    W KMPRET.%ToJSON()
    D RU^%ZOSVKR("KMP SynthFileHandler")
    Quit 1 }
zSynthRcmd() public {
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP SynthRcmdEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    Do %response.SetHeader("Access-Control-Allow-Origin","*")
    Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
    S KMPRET=##class(%Library.DynamicObject).%New()
    S KMPREQ=##class(%Library.DynamicAbstractObject).%FromJSON(%request.Content)
    I KMPREQ.Function'="SynthRcmd" D  Quit 1
    .S KMPRET.ResultText="Incorrect Function Type"
    .W KMPRET.%ToJSON()
    D SITE^KMPUTLW(KMPRET)
    D SYNRCMD^KMPSYNTH(KMPRET)
    S KMPRET.Function=KMPREQ.Function
    S KMPRET.ResultText="OK"
    W KMPRET.%ToJSON()
    D RU^%ZOSVKR("KMP SynthRcmdHandler")
    Quit 1 }
zSynthVpr() public {
    ;demographics;reactions;problems;vitals;labs;meds;immunizations;observation;visits;appointments;documents;procedures;consults;flags;factors;skinTests;exams;education;insurance
    N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER,UNWIND^%ZTER"
    D RU^%ZOSVKR("KMP SynthVprEvent")
    I $P($$VERSION^%ZOSV(0),".") < 2017 Q $$Error^%apiOBJ("Invalid Cache Version")
    Do %response.SetHeader("Access-Control-Allow-Origin","*")
    Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
    S KMPRET=##class(%Library.DynamicObject).%New()
    S KMPREQ=##class(%Library.DynamicAbstractObject).%FromJSON(%request.Content)
    I KMPREQ.Function'="SynthVpr" D  Quit 1
    .S KMPRET.ResultText="Incorrect Function Type"
    .W KMPRET.%ToJSON()
    D SITE^KMPUTLW(KMPRET)
    D SYNVPR^KMPSYNTH(KMPRET,KMPREQ.PatientDfn,KMPREQ.ClinicalDomains)
    S KMPRET.Function=KMPREQ.Function
    S KMPRET.ResultText="OK"
    W KMPRET.%ToJSON()
    D RU^%ZOSVKR("KMP SynthVprHandler")
    Quit 1 }
