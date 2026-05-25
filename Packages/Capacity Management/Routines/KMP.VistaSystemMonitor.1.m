 ;KMP.VistaSystemMonitor.1
 ;Generated for class KMP.VistaSystemMonitor.  Do NOT edit. 03/27/2026 10:44:05AM
 ;;66554A35;KMP.VistaSystemMonitor
 ;
CprsKillG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP CprsKillGEvent")
         D CPRSKILLG^KMPURE1
         D RU^%ZOSVKR("KMP CprsKillGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
CprsKillP() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP CprsKillPEvent")
         D CPRSKILLP^KMPURE1
         D RU^%ZOSVKR("KMP CprsKillPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
DispatchMap(url,method,verbsMatched="",args) methodimpl {
 Set searchMethod=","_method_","
 Do {
   Set matcher = ##class(%Regex.Matcher).%New("/CprsKill")
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","CprsKillG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/GetConfig"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","GetConfigG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/GetCPF"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","GetCPFG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/GetCprsLog"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","GetCprsLogG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/GetCprsList"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","GetCprsListG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/GetGlobuff"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","GetGlobuffG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/GetHttpMetrics"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","GetHttpMetricsG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/GetNode"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","GetNodeG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/GetOps"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","GetOpsG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/GetRetryData"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","GetRetryDataG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/GetRunLog"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","GetRunLogG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/KillData"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","KillDataG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/StartMonitor"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","StartMonG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/StopMonitor"
   If matcher.Match(url) {
     If ",GET,OPTIONS," [ searchMethod Set route=$lb("R","StopMonG",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",GET,OPTIONS"
   }
   Set matcher.Pattern="/CprsKill"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","CprsKillP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/GetConfig"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","GetConfigP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/GetCprsLog"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","GetCprsLogP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/GetCprsList"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","GetCprsListP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/GetError"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","GetErrorP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/GetHttpMetrics"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","GetHttpMetricsP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/GetOps"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","GetOpsP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/GetPackages"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","GetPackagesP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/GetPatientList"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","GetPatientListP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/GetRunLog"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","GetRunLogP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/Retry"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","RetryP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/SetConfig"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","SetConfigP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/ImAlive"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","ImAliveP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/SynthFile"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","SynthFileP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/SynthRcmd"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","SynthRcmdP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Set matcher.Pattern="/SynthVpr"
   If matcher.Match(url) {
     If ",POST,OPTIONS," [ searchMethod Set route=$lb("R","SynthVprP",$classname(),"false"),regex=1 Quit
     Set verbsMatched=verbsMatched_",POST,OPTIONS"
   }
   Return ""
 } While 0
 If regex && matcher.GroupCount {
   For i=1:1:matcher.GroupCount Set args($i(args))=matcher.Group(i)
 }
 If $li(route,1)="R" { 
   Return route 
 } Else { 
   Set continue=1
   Set sc=$classmethod($list(route,2),"OnPreDispatch", args(args), method, .continue) Throw:('sc) ##class(%Exception.StatusException).ThrowIfInterrupt(sc)
   If 'continue Return route
   Return $classmethod($list(route,2), "DispatchMap", args($i(args,-1)+1), method, .verbsMatched, .args)
 } }
GetCPFG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetCprsListGEvent")
         D GETCPFG^KMPURG1
         D RU^%ZOSVKR("KMP GetCprsListGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
GetConfigG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetConfigGEvent")
         D CONFIGG^KMPURG1
         D RU^%ZOSVKR("KMP GetConfigGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
GetConfigP() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetConfigPEvent")
         D GETCONFIGP^KMPURP1
         D RU^%ZOSVKR("KMP GetConfigPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
GetCprsListG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetCprsListGEvent")
         D CPRSLISTG^KMPURE1
         D RU^%ZOSVKR("KMP GetCprsListGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
GetCprsListP() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetCprsListPEvent")
         D CPRSLISTP^KMPURE1
         D RU^%ZOSVKR("KMP GetCprsListPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
GetCprsLogG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetCprsLogGEvent")
         D CPRSLOGG^KMPURE1
         D RU^%ZOSVKR("KMP GetCprsLogGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
GetCprsLogP() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetCprsLogPEvent")
         D CPRSLOGP^KMPURE1
         D RU^%ZOSVKR("KMP GetCprsLogPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
GetErrorP() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetErrorPEvent")
         D GETERRORP^KMPURP1
         D RU^%ZOSVKR("KMP GetErrorPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
GetGlobuffG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetGloBuffGEvent")
         D GLOBUFFG^KMPURG1
         D RU^%ZOSVKR("KMP GetGloBuffGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
GetHttpMetricsG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetHttpMetricsGEvent")
         D HTTPMETG^KMPURG1
         D RU^%ZOSVKR("KMP GetHttpMetricsGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
GetHttpMetricsP() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetHttpMetricsPEvent")
         D HTTPMETP^KMPURP1
         D RU^%ZOSVKR("KMP GetHttpMetricsPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
GetNodeG() methodimpl {
    TRY {
        W "<H>"_##class(%SYS.System).GetNodeName(1)_"</H>"
        Return 1
    } CATCH KMPERR {
        Return ..Http500(KMPERR)
    } }
GetOpsG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetOpsGEvent")
         D GETOPSG^KMPURG1
         D RU^%ZOSVKR("KMP GetOpsGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
GetOpsP() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetOpsPEvent")
         D GETOPSP^KMPURP1
         D RU^%ZOSVKR("KMP GetOpsPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
GetPackagesP() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetPackagesPEvent")
         D GETPACKP^KMPURP1
         D RU^%ZOSVKR("KMP GetPackagesPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
GetPatientListP() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetPatientListPEvent")
         D GETPLISTP^KMPURS1
         D RU^%ZOSVKR("KMP GetPatientListPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
GetRetryDataG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetRetryGEvent")
         D GETRETRYG^KMPURG1
         D RU^%ZOSVKR("KMP GetRetryGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
GetRunLogG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetRunLogGEvent")
         D RUNLOGG^KMPURG1
         D RU^%ZOSVKR("KMP GetRunLogGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
GetRunLogP() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP GetRunLogPEvent")
         D GETLOGP^KMPURP1
         D RU^%ZOSVKR("KMP GetRunLogPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
ImAliveP() methodimpl {
    TRY {
         S KMPINST=##class(%SYS.System).GetInstanceName(),KMPNDTYP=$$NODETYPE^KMPUTLW(KMPINST)
         I KMPNDTYP="BE",##CLASS(%SYSTEM.Mirror).IsPrimary()=0,##CLASS(%SYSTEM.Mirror).GetStatus()'="NOTINIT"  D  Return 1
         .S KMPRET=##class(%Library.DynamicObject).%New()
         .S KMPRET.ResultText="Not Primary Backend"
         .W KMPRET.%ToJSON()
         D RU^%ZOSVKR("KMP ImAlivePEvent")
         D IMALIVEP^KMPURS1
         D RU^%ZOSVKR("KMP ImAlivePHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
KillDataG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP KillDataGEvent")
         D KILLG^KMPURG1
         D RU^%ZOSVKR("KMP KillDataGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
RetryP() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP RetryPEvent")
         D RETRYP^KMPURP1
         D RU^%ZOSVKR("KMP RetryPPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
SetConfigP() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP SetConfigPEvent")
         D SETCONFIGP^KMPURP1
         D RU^%ZOSVKR("KMP SetConfigPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
StartMonG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP StartMonitorGEvent")
         D STARTMONG^KMPURG1
         D RU^%ZOSVKR("KMP StartMonitorGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
StopMonG() methodimpl {
    TRY {
         D RU^%ZOSVKR("KMP StopMonitorGEvent")
         D STOPMONG^KMPURG1
         D RU^%ZOSVKR("KMP StopMonitorGHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         W "<BR>An error has occurred. Check the VistA Error Trap<BR><BR>"
         I %request.Get("SHOW500")'="" Return ..Http500(KMPERR)
         Return 1
    } }
SupportedVerbs(pUrl,pVerbs) methodimpl {
 If '$isobject($get(pVerbs)) Set pVerbs = {}
 Set pMatcher = ##class(%Regex.Matcher).%New("/CprsKill")
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetConfig"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetCPF"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetCprsLog"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetCprsList"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetGlobuff"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetHttpMetrics"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetNode"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetOps"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetRetryData"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetRunLog"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/KillData"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/StartMonitor"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/StopMonitor"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("GET") Do pVerbs.%Set("GET", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/CprsKill"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetConfig"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetCprsLog"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetCprsList"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetError"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetHttpMetrics"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetOps"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetPackages"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetPatientList"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/GetRunLog"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/Retry"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/SetConfig"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/ImAlive"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/SynthFile"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/SynthRcmd"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set pMatcher.Pattern="/SynthVpr"
 If pMatcher.Match(pUrl) {
   If 'pVerbs.%IsDefined("POST") Do pVerbs.%Set("POST", 1, "boolean")
   If 'pVerbs.%IsDefined("OPTIONS") Do pVerbs.%Set("OPTIONS", 1, "boolean")
 }
 Set it=pVerbs.%GetIterator()
 Set value=""
 While it.%GetNext(.verb) {
   Set value=value_verb_","
 }
 Set pVerbs = $extract(value,1,*-1)
 Return 1 }
SynthFileP() methodimpl {
    TRY {
         S KMPINST=##class(%SYS.System).GetInstanceName(),KMPNDTYP=$$NODETYPE^KMPUTLW(KMPINST)
         I KMPNDTYP="BE",##CLASS(%SYSTEM.Mirror).IsPrimary()=0,##CLASS(%SYSTEM.Mirror).GetStatus()'="NOTINIT"  D  Return 1
         .S KMPRET=##class(%Library.DynamicObject).%New()
         .S KMPRET.ResultText="Not Primary Backend"
         .W KMPRET.%ToJSON()
         D RU^%ZOSVKR("KMP SynthFilePEvent")
         D SYNTHFILEP^KMPURS1
         D RU^%ZOSVKR("KMP SynthFilePHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
SynthRcmdP() methodimpl {
    TRY {
         S KMPINST=##class(%SYS.System).GetInstanceName(),KMPNDTYP=$$NODETYPE^KMPUTLW(KMPINST)
         I KMPNDTYP="BE",##CLASS(%SYSTEM.Mirror).IsPrimary()=0,##CLASS(%SYSTEM.Mirror).GetStatus()'="NOTINIT"  D  Return 1
         .S KMPRET=##class(%Library.DynamicObject).%New()
         .S KMPRET.ResultText="Not Primary Backend"
         .W KMPRET.%ToJSON()
         D RU^%ZOSVKR("KMP SynthRcmdPEvent")
         D SYNTHRCMDP^KMPURS1
         D RU^%ZOSVKR("KMP SynthRcmdPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
SynthVprP() methodimpl {
    TRY {
         S KMPINST=##class(%SYS.System).GetInstanceName(),KMPNDTYP=$$NODETYPE^KMPUTLW(KMPINST)
         I KMPNDTYP="BE",##CLASS(%SYSTEM.Mirror).IsPrimary()=0,##CLASS(%SYSTEM.Mirror).GetStatus()'="NOTINIT"  D  Return 1
         .S KMPRET=##class(%Library.DynamicObject).%New()
         .S KMPRET.ResultText="Not Primary Backend"
         .W KMPRET.%ToJSON()
         D RU^%ZOSVKR("KMP SynthVprPEvent")
         D SYNTHVPRP^KMPURS1
         D RU^%ZOSVKR("KMP SynthVprPHandler")
         Return 1
    } CATCH KMPERR {
         D ^%ZTER
         Return ..Http500(KMPERR)
    } }
