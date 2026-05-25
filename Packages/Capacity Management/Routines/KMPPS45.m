KMPPS45 ;SP/JML - KMP*4*5 POST INSTALL ROUTINE ;7/1/2025
 ;;4.0;CAPACITY MANAGEMENT;**5**;3/1/2018;Build 9
 ;
 ;
 ;
PRE ;
 ; stop current KMP monitors
 W !,"Stopping Monitors"
 N KMPMKEY
 S KMPMKEY=""
 F  S KMPMKEY=$O(^KMPV(8969,"B",KMPMKEY)) Q:KMPMKEY=""  D
 .D STOPMON^KMPVCBG(KMPMKEY,1,1)
 ; set deprecated fields to null
 S DA=0,DIE=8969
 F  S DA=$O(^KMPV(8969,DA)) Q:+DA=0  D
 .S DR="1.07///@" D ^DIE
 .S DR="1.08///@" D ^DIE
 .S DR="3.01///@" D ^DIE
 .S DR="3.03///@" D ^DIE
 ; Delete current utility class if it exists
 I ##class(%Dictionary.CompiledClass).%ExistsId("KMP.Utilities") D $System.OBJ.Delete("KMP.Utilities")
 ; create new class
 S KMP=##class(%Dictionary.ClassDefinition).%New()
 S KMP.Name="KMP.Utilities"
 S KMP.Super="%RegisteredObject"
 ; Roles
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="getRoles"
 S MDEF.ReturnType="%String"
 D ROLES^KMPPS45B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; Total Buffers
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="getTotalBuffers"
 S MDEF.ReturnType="%String"
 D TOTBUFF^KMPPS45B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; List Buffers
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="getBuffers"
 S MDEF.ReturnType="%ArrayOfDataTypes"
 D LISTBUFF^KMPPS45B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; CPF
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="getCPF"
 S MDEF.FormalSpec="&CPFHEAD"
 S MDEF.ReturnType="%ArrayOfDataTypes"
 D CPF^KMPPS45B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; toArray
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="toArray"
 S MDEF.FormalSpec="&KMPOBJ"
 S MDEF.ReturnType="%ArrayOfDataTypes"
 D TOARRAY^KMPPS45B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 D KMP.%Save()
 D $system.OBJ.Compile("KMP.Utilities","ck")
 Q
 ;
POST ;
 N %DT,DA,DIC,DIE,DIK,DR,X,Y,KMP,MDEF,XDATA,KMPDATE,KMPKEY,KMPMON,KMPSC,KMPSINF,KMPTEXT
 ; Delete original class to get any changes compiled
 I ##class(%Dictionary.CompiledClass).%ExistsId("KMP.VistaSystemMonitor") D $System.OBJ.Delete("KMP.VistaSystemMonitor")
 ; create new class
 S KMP=##class(%Dictionary.ClassDefinition).%New()
 S KMP.Name="KMP.VistaSystemMonitor"
 S KMP.Super="%CSP.REST"
 S KMP.ProcedureBlock=1
 ; XDATA - Url Map
 S XDATA=##class(%Dictionary.XDataDefinition).%New()
 S XDATA.Name="UrlMap"
 D XDATA.Data.WriteLine("  <Routes>")
 D XDATA.Data.WriteLine("    <Route Url=""/CprsKill"" Method=""GET"" Call=""CprsKillG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetConfig"" Method=""GET"" Call=""GetConfigG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetCPF"" Method=""GET"" Call=""GetCPFG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetCprsLog"" Method=""GET"" Call=""GetCprsLogG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetCprsList"" Method=""GET"" Call=""GetCprsListG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetGlobuff"" Method=""GET"" Call=""GetGlobuffG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetHttpMetrics"" Method=""GET"" Call=""GetHttpMetricsG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetNode"" Method=""GET"" Call=""GetNodeG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetOps"" Method=""GET"" Call=""GetOpsG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetRetryData"" Method=""GET"" Call=""GetRetryDataG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetRunLog"" Method=""GET"" Call=""GetRunLogG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/KillData"" Method=""GET"" Call=""KillDataG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/StartMonitor"" Method=""GET"" Call=""StartMonG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/StopMonitor"" Method=""GET"" Call=""StopMonG"" />")
 D XDATA.Data.WriteLine("")
 D XDATA.Data.WriteLine("    <Route Url=""/CprsKill"" Method=""POST"" Call=""CprsKillP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetConfig"" Method=""POST"" Call=""GetConfigP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetCprsLog"" Method=""POST"" Call=""GetCprsLogP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetCprsList"" Method=""POST"" Call=""GetCprsListP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetError"" Method=""POST"" Call=""GetErrorP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetHttpMetrics"" Method=""POST"" Call=""GetHttpMetricsP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetOps"" Method=""POST"" Call=""GetOpsP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetPackages"" Method=""POST"" Call=""GetPackagesP""/>")
 D XDATA.Data.WriteLine("    <Route Url=""/GetPatientList"" Method=""POST"" Call=""GetPatientListP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetRunLog"" Method=""POST"" Call=""GetRunLogP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/Retry"" Method=""POST"" Call=""RetryP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/SetConfig"" Method=""POST"" Call=""SetConfigP"" />")
 D XDATA.Data.WriteLine("")
 D XDATA.Data.WriteLine("    <Route Url=""/ImAlive"" Method=""POST"" Call=""ImAliveP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/SynthFile"" Method=""POST"" Call=""SynthFileP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/SynthRcmd"" Method=""POST"" Call=""SynthRcmdP"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/SynthVpr"" Method=""POST"" Call=""SynthVprP"" />")
 D XDATA.Data.WriteLine("  </Routes>")
 D KMP.XDatas.Insert(XDATA)
 ;
 ; CprsKillG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="CprsKillG"
 S MDEF.ReturnType="%Status"
 D CPRSKILLG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetConfigG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetConfigG"
 S MDEF.ReturnType="%Status"
 D GETCONFIGG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetCprsLogG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetCprsLogG"
 S MDEF.ReturnType="%Status"
 D GETCPRSLOGG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetCprsListG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetCprsListG"
 S MDEF.ReturnType="%Status"
 D GETCPRSLISTG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetCPFG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetCPFG"
 S MDEF.ReturnType="%Status"
 D GETCPFG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetGlobuffG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetGlobuffG"
 S MDEF.ReturnType="%Status"
 D GETGLOBUFFG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetHttpMetricsG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetHttpMetricsG"
 S MDEF.ReturnType="%Status"
 D GETHTTPG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetNodeG()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetNodeG"
 S MDEF.ReturnType="%Status"
 D GETNODEG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetOpsG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetOpsG"
 S MDEF.ReturnType="%Status"
 D GETOPSG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetRetryDataG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetRetryDataG"
 S MDEF.ReturnType="%Status"
 D GETRETRYG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetRunLogG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetRunLogG"
 S MDEF.ReturnType="%Status"
 D GETRUNLOGG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; KillDataG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="KillDataG"
 S MDEF.ReturnType="%Status"
 D KILLDATAG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; StartMonG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="StartMonG"
 S MDEF.ReturnType="%Status"
 D STARTMONG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; StopMonG
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="StopMonG"
 S MDEF.ReturnType="%Status"
 D STOPMONG^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ;
 ; CprsKillP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="CprsKillP"
 S MDEF.ReturnType="%Status"
 D CPRSKILLP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetConfigP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetConfigP"
 S MDEF.ReturnType="%Status"
 D GETCONFIGP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetCprsLogP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetCprsLogP"
 S MDEF.ReturnType="%Status"
 D GETCPRSLOGP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetCprsListP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetCprsListP"
 S MDEF.ReturnType="%Status"
 D GETCPRSLISTP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetErrorP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetErrorP"
 S MDEF.ReturnType="%Status"
 D GETERRORP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetHttpMetricsP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetHttpMetricsP"
 S MDEF.ReturnType="%Status"
 D GETHTTPP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetOpsP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetOpsP"
 S MDEF.ReturnType="%Status"
 D GETOPSP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetPackagesP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetPackagesP"
 S MDEF.ReturnType="%Status"
 D GETPACKP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GetPatientListP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetPatientListP"
 S MDEF.ReturnType="%Status"
 D GETPLISTP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; GETRUNLOGP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetRunLogP"
 S MDEF.ReturnType="%Status"
 D GETRUNLOGP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; RETRYP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="RetryP"
 S MDEF.ReturnType="%Status"
 D RETRYP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; SETCONFIGP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SetConfigP"
 S MDEF.ReturnType="%Status"
 D SETCONFIGP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; IMALIVEP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="ImAliveP"
 S MDEF.ReturnType="%Status"
 D IMALIVEP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; SYNTHFILEP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SynthFileP"
 S MDEF.ReturnType="%Status"
 D SYNTHFILEP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; SYNTHRCMDP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SynthRcmdP"
 S MDEF.ReturnType="%Status"
 D SYNTHRCMDP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 ; SYNTHVPRP
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SynthVprP"
 S MDEF.ReturnType="%Status"
 D SYNTHVPRP^KMPPS45A(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 D KMP.%Save()
 D $system.OBJ.Compile("KMP.VistaSystemMonitor","ck")
 ;
 ; Set new INSTALL DATE value
 S X="T",%DT="ESTX" D ^%DT S KMPDATE=Y
 S DA=0,DIE=8969
 F  S DA=$O(^KMPV(8969,DA)) Q:+DA=0  D
 .S DR=".05///"_KMPDATE D ^DIE
 ;
 ; Set the new COVER SHEET EXPIRATION value for VCSM
 S DA=$O(^KMPV(8969,"B","VCSM",""))
 S DR="1.1///86400"
 D ^DIE
 ;
 ; Set new FUTURE TASK CHECK value for VMCM
 S DA=$O(^KMPV(8969,"B","VMCM",""))
 S DR="5.01///R2TERM1 AUTO DEAC:XUAUTODEACTIVATE"
 D ^DIE
 ; Phone home
 S KMPSINF=$$SITEINFO^KMPVCCFG()
 S KMPSC=$P(KMPSINF,"^",5)
 S KMPTEXT("SUBJECT")="VSM Patch KMP*4*5 Loaded: "_KMPSC
 D INFOMSG^KMPUTLW(.KMPTEXT)
 Q
