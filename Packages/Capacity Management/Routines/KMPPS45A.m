KMPPS45A ;SP/JML - KMP*4*5 POST INSTALL ROUTINE ;7/1/2025
 ;;4.0;CAPACITY MANAGEMENT;**5**;3/1/2018;Build 9
 ;
 ;
 ;
GERROR(MDEF) ;
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("         D ^%ZTER")
 D MDEF.Implementation.WriteLine("         W ""<BR>An error has occurred. Check the VistA Error Trap<BR><BR>""")
 D MDEF.Implementation.WriteLine("         I %request.Get(""SHOW500"")'="""" Return ..Http500(KMPERR)")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D MDEF.Implementation.WriteLine("    }")
 Q
 ;
PERROR(MDEF) ;
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("         D ^%ZTER")
 D MDEF.Implementation.WriteLine("         Return ..Http500(KMPERR)")
 D MDEF.Implementation.WriteLine("    }")
 ;
CPRSKILLG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP CprsKillGEvent"")")
 D MDEF.Implementation.WriteLine("         D CPRSKILLG^KMPURE1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP CprsKillGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 ;
GETCONFIGG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetConfigGEvent"")")
 D MDEF.Implementation.WriteLine("         D CONFIGG^KMPURG1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetConfigGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 Q
 ;
GETCPRSLOGG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetCprsLogGEvent"")")
 D MDEF.Implementation.WriteLine("         D CPRSLOGG^KMPURE1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetCprsLogGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 Q
 ;
GETCPRSLISTG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetCprsListGEvent"")")
 D MDEF.Implementation.WriteLine("         D CPRSLISTG^KMPURE1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetCprsListGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 Q
 ;
GETCPFG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetCprsListGEvent"")")
 D MDEF.Implementation.WriteLine("         D GETCPFG^KMPURG1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetCprsListGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 ;
GETGLOBUFFG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetGloBuffGEvent"")")
 D MDEF.Implementation.WriteLine("         D GLOBUFFG^KMPURG1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetGloBuffGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 ;
GETHTTPG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetHttpMetricsGEvent"")")
 D MDEF.Implementation.WriteLine("         D HTTPMETG^KMPURG1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetHttpMetricsGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 Q
 ;
GETNODEG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("        W ""<H>""_##class(%SYS.System).GetNodeName(1)_""</H>""")
 D MDEF.Implementation.WriteLine("        Return $$$OK")
 D MDEF.Implementation.WriteLine("    } CATCH KMPERR {")
 D MDEF.Implementation.WriteLine("        Return ..Http500(KMPERR)")
 D MDEF.Implementation.WriteLine("    }")
 Q
 ;
GETOPSG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetOpsGEvent"")")
 D MDEF.Implementation.WriteLine("         D GETOPSG^KMPURG1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetOpsGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 Q
 ;
GETRETRYG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetRetryGEvent"")")
 D MDEF.Implementation.WriteLine("         D GETRETRYG^KMPURG1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetRetryGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 Q
 ;
GETRUNLOGG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetRunLogGEvent"")")
 D MDEF.Implementation.WriteLine("         D RUNLOGG^KMPURG1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetRunLogGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 Q
 ;
KILLDATAG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP KillDataGEvent"")")
 D MDEF.Implementation.WriteLine("         D KILLG^KMPURG1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP KillDataGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 Q
 ;
STARTMONG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP StartMonitorGEvent"")")
 D MDEF.Implementation.WriteLine("         D STARTMONG^KMPURG1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP StartMonitorGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 Q
 ;
STOPMONG(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP StopMonitorGEvent"")")
 D MDEF.Implementation.WriteLine("         D STOPMONG^KMPURG1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP StopMonitorGHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D GERROR(.MDEF)
 Q
 ;
 ;
CPRSKILLP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP CprsKillPEvent"")")
 D MDEF.Implementation.WriteLine("         D CPRSKILLP^KMPURE1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP CprsKillPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
GETCONFIGP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetConfigPEvent"")")
 D MDEF.Implementation.WriteLine("         D GETCONFIGP^KMPURP1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetConfigPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
GETCPRSLOGP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetCprsLogPEvent"")")
 D MDEF.Implementation.WriteLine("         D CPRSLOGP^KMPURE1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetCprsLogPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
GETCPRSLISTP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetCprsListPEvent"")")
 D MDEF.Implementation.WriteLine("         D CPRSLISTP^KMPURE1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetCprsListPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
GETERRORP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetErrorPEvent"")")
 D MDEF.Implementation.WriteLine("         D GETERRORP^KMPURP1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetErrorPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
GETHTTPP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetHttpMetricsPEvent"")")
 D MDEF.Implementation.WriteLine("         D HTTPMETP^KMPURP1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetHttpMetricsPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
GETOPSP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetOpsPEvent"")")
 D MDEF.Implementation.WriteLine("         D GETOPSP^KMPURP1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetOpsPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
GETPACKP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetPackagesPEvent"")")
 D MDEF.Implementation.WriteLine("         D GETPACKP^KMPURP1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetPackagesPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
GETRUNLOGP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetRunLogPEvent"")")
 D MDEF.Implementation.WriteLine("         D GETLOGP^KMPURP1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetRunLogPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
RETRYP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP RetryPEvent"")")
 D MDEF.Implementation.WriteLine("         D RETRYP^KMPURP1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP RetryPPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
SETCONFIGP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP SetConfigPEvent"")")
 D MDEF.Implementation.WriteLine("         D SETCONFIGP^KMPURP1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP SetConfigPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
IMALIVEP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         S KMPINST=##class(%SYS.System).GetInstanceName(),KMPNDTYP=$$NODETYPE^KMPUTLW(KMPINST)")
 D MDEF.Implementation.WriteLine("         I KMPNDTYP=""BE"",##CLASS(%SYSTEM.Mirror).IsPrimary()=0,##CLASS(%SYSTEM.Mirror).GetStatus()'=""NOTINIT""  D  Return $$$OK")
 D MDEF.Implementation.WriteLine("         .S KMPRET=##class(%DynamicObject).%New()")
 D MDEF.Implementation.WriteLine("         .S KMPRET.ResultText=""Not Primary Backend""")
 D MDEF.Implementation.WriteLine("         .W KMPRET.%ToJSON()")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP ImAlivePEvent"")")
 D MDEF.Implementation.WriteLine("         D IMALIVEP^KMPURS1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP ImAlivePHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
SYNTHFILEP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         S KMPINST=##class(%SYS.System).GetInstanceName(),KMPNDTYP=$$NODETYPE^KMPUTLW(KMPINST)")
 D MDEF.Implementation.WriteLine("         I KMPNDTYP=""BE"",##CLASS(%SYSTEM.Mirror).IsPrimary()=0,##CLASS(%SYSTEM.Mirror).GetStatus()'=""NOTINIT""  D  Return $$$OK")
 D MDEF.Implementation.WriteLine("         .S KMPRET=##class(%DynamicObject).%New()")
 D MDEF.Implementation.WriteLine("         .S KMPRET.ResultText=""Not Primary Backend""")
 D MDEF.Implementation.WriteLine("         .W KMPRET.%ToJSON()")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP SynthFilePEvent"")")
 D MDEF.Implementation.WriteLine("         D SYNTHFILEP^KMPURS1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP SynthFilePHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
SYNTHRCMDP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         S KMPINST=##class(%SYS.System).GetInstanceName(),KMPNDTYP=$$NODETYPE^KMPUTLW(KMPINST)")
 D MDEF.Implementation.WriteLine("         I KMPNDTYP=""BE"",##CLASS(%SYSTEM.Mirror).IsPrimary()=0,##CLASS(%SYSTEM.Mirror).GetStatus()'=""NOTINIT""  D  Return $$$OK")
 D MDEF.Implementation.WriteLine("         .S KMPRET=##class(%DynamicObject).%New()")
 D MDEF.Implementation.WriteLine("         .S KMPRET.ResultText=""Not Primary Backend""")
 D MDEF.Implementation.WriteLine("         .W KMPRET.%ToJSON()")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP SynthRcmdPEvent"")")
 D MDEF.Implementation.WriteLine("         D SYNTHRCMDP^KMPURS1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP SynthRcmdPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
SYNTHVPRP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         S KMPINST=##class(%SYS.System).GetInstanceName(),KMPNDTYP=$$NODETYPE^KMPUTLW(KMPINST)")
 D MDEF.Implementation.WriteLine("         I KMPNDTYP=""BE"",##CLASS(%SYSTEM.Mirror).IsPrimary()=0,##CLASS(%SYSTEM.Mirror).GetStatus()'=""NOTINIT""  D  Return $$$OK")
 D MDEF.Implementation.WriteLine("         .S KMPRET=##class(%DynamicObject).%New()")
 D MDEF.Implementation.WriteLine("         .S KMPRET.ResultText=""Not Primary Backend""")
 D MDEF.Implementation.WriteLine("         .W KMPRET.%ToJSON()")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP SynthVprPEvent"")")
 D MDEF.Implementation.WriteLine("         D SYNTHVPRP^KMPURS1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP SynthVprPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
 ;
GETPLISTP(MDEF) ;
 D MDEF.Implementation.WriteLine("    TRY {")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetPatientListPEvent"")")
 D MDEF.Implementation.WriteLine("         D GETPLISTP^KMPURS1")
 D MDEF.Implementation.WriteLine("         D RU^%ZOSVKR(""KMP GetPatientListPHandler"")")
 D MDEF.Implementation.WriteLine("         Return $$$OK")
 D PERROR(.MDEF)
 Q
