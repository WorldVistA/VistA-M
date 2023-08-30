KMPPST43A ;SP/JML - KMP*4*3 POST INSTALL ROUTINE ;2/1/2023
 ;;4.0;CAPACITY MANAGEMENT;**3**;3/1/2018;Build 17
 ;
 ;
PRE ;
 ; stop current KMP monitors
 W !,"Stopping Monitors"
 D STOPALL^KMPVCBG
 Q
POST ;
 N %DT,DA,DIC,DIE,DIK,DR,X,Y,KMP,MDEF,XDATA,KMPDATE,KMPKEY
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
 D XDATA.Data.WriteLine("    <Route Url=""/GetNode"" Method=""GET"" Call=""GetNode"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetConfiguration"" Method=""GET"" Call=""GetConfiguration"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetHttpMetrics"" Method=""GET"" Call=""GetHttpMetricsG"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/KillData"" Method=""GET"" Call=""KillData"" />")
 D XDATA.Data.WriteLine("")
 D XDATA.Data.WriteLine("    <Route Url=""/GetConfig"" Method=""POST"" Call=""GetConfig"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/SetConfig"" Method=""POST"" Call=""SetConfig"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetError"" Method=""POST"" Call=""GetError"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetCtmLog"" Method=""POST"" Call=""GetCtmLog"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetPatientList"" Method=""POST"" Call=""GetPatientList"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/Retry"" Method=""POST"" Call=""Retry"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetPackages"" Method=""POST"" Call=""GetPackages"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetHttpMetrics"" Method=""POST"" Call=""GetHttpMetricsP"" />")
 D XDATA.Data.WriteLine("")
 D XDATA.Data.WriteLine("    <Route Url=""/ImAlive"" Method=""POST"" Call=""ImAlive"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/SynthRcmd"" Method=""POST"" Call=""SynthRcmd"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/SynthFile"" Method=""POST"" Call=""SynthFile"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/SynthVpr"" Method=""POST"" Call=""SynthVpr"" />")
 D XDATA.Data.WriteLine("  </Routes>")
 D KMP.XDatas.Insert(XDATA)
 ; GetCFG()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetConfig"
 S MDEF.ReturnType="%Status"
 D GETCFG^KMPPST43B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; SetCFG()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SetConfig"
 S MDEF.ReturnType="%Status"
 D SETCFG^KMPPST43B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetConfiguration - get method
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetConfiguration"
 S MDEF.ReturnType="%Status"
 D GETCONFIG^KMPPST43B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetHttpMetricsG - get method
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetHttpMetricsG"
 S MDEF.ReturnType="%Status"
 D GETHTTPG^KMPPST43C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetHttpMetricsP - get method
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetHttpMetricsP"
 S MDEF.ReturnType="%Status"
 D GETHTTPP^KMPPST43C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; KillData - get method
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="KillData"
 S MDEF.ReturnType="%Status"
 D KILLDATA^KMPPST43B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetCTMLog()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetCtmLog"
 S MDEF.ReturnType="%Status"
 D CTMLOG^KMPPST43B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetPackages()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetPackages"
 S MDEF.ReturnType="%Status"
 D GETPACK^KMPPST43B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; Retry()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 s MDEF.Name="Retry"
 S MDEF.ReturnType="%Status"
 D RETRY^KMPPST43B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; ImAlive()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="ImAlive"
 S MDEF.ReturnType="%Status"
 D IMALIVE^KMPPST43C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetNode()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetNode"
 S MDEF.ReturnType="%Status"
 D GETNODE^KMPPST43B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; SynthRcmd()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SynthRcmd"
 S MDEF.ReturnType="%Status"
 D SYNRCMD^KMPPST43C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; SynthFile()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SynthFile"
 S MDEF.ReturnType="%Status"
 D SYNFILE^KMPPST43C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; SynthVpr()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SynthVpr"
 S MDEF.ReturnType="%Status"
 D SYNVPR^KMPPST43C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetError()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetError"
 S MDEF.ReturnType="%Status"
 D GETERR^KMPPST43C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetPatientList()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetPatientList"
 S MDEF.ReturnType="%Status"
 D GETPAT^KMPPST43B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 D KMP.%Save()
 D $system.OBJ.Compile("KMP.VistaSystemMonitor","ck")
 ;
 ; Update VersionInstallDate
 S X="T",%DT="ESTX" D ^%DT S KMPDATE=Y
 S DIE=8969
 S KMPKEY=""
 F  S KMPKEY=$O(^KMPV(8969,"B",KMPKEY)) Q:KMPKEY=""  D
 .S DA=$O(^KMPV(8969,"B",KMPKEY,""))
 .S DR=".05///"_KMPDATE
 .D ^DIE
 ; job off restart-will hang to allow current jobs to exit before starting
 J RESTART^KMPPST43A
 W !,"Post Install Complete"
 Q
RESTART ;
 ; Restart monitors
 H 60*20
 W !,"Restarting Monitors"
 D STARTALL^KMPVCBG
 D CFGMSG^KMPUTLW
 Q
