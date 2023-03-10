KMPPST3A ;SP/JML - VSM VERSION 2 POST INSTALL ROUTINE ;6/1/2020
 ;;4.0;CAPACITY MANAGEMENT;**1**;3/1/2018;Build 27
 ;
MAKE ;  create class needed for RESTful web services
 N KMP,MDEF,XDATA
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
 D XDATA.Data.WriteLine("    <Route Url=""/ImAlive"" Method=""POST"" Call=""ImAlive"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetNode"" Method=""GET"" Call=""GetNode"" />")
 D XDATA.Data.WriteLine("")
 D XDATA.Data.WriteLine("    <Route Url=""/GetConfig"" Method=""POST"" Call=""GetConfig"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/SetConfig"" Method=""POST"" Call=""SetConfig"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetError"" Method=""POST"" Call=""GetError"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetCtmLog"" Method=""POST"" Call=""GetCtmLog"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetPatientList"" Method=""POST"" Call=""GetPatientList"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/Retry"" Method=""POST"" Call=""Retry"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/GetPackages"" Method=""POST"" Call=""GetPackages"" />")
 D XDATA.Data.WriteLine("")
 D XDATA.Data.WriteLine("    <Route Url=""/SynthRcmd"" Method=""POST"" Call=""SynthRcmd"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/SynthGbl"" Method=""POST"" Call=""SynthGbl"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/SynthFile"" Method=""POST"" Call=""SynthFile"" />")
 D XDATA.Data.WriteLine("    <Route Url=""/SynthVpr"" Method=""POST"" Call=""SynthVpr"" />")
 D XDATA.Data.WriteLine("  </Routes>")
 D KMP.XDatas.Insert(XDATA)
 ; GetCFG()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetConfig"
 S MDEF.ReturnType="%Status"
 D GETCFG^KMPPST3B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; SetCFG()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SetConfig"
 S MDEF.ReturnType="%Status"
 D SETCFG^KMPPST3B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetCTMLog()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetCtmLog"
 S MDEF.ReturnType="%Status"
 D CTMLOG^KMPPST3B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetPackages()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetPackages"
 S MDEF.ReturnType="%Status"
 D GETPACK^KMPPST3B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; Retry()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 s MDEF.Name="Retry"
 S MDEF.ReturnType="%Status"
 D RETRY^KMPPST3B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; ImAlive()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="ImAlive"
 S MDEF.ReturnType="%Status"
 D IMALIVE^KMPPST3C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetNode()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetNode"
 S MDEF.ReturnType="%Status"
 D GETNODE^KMPPST3B(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; SynthRcmd()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SynthRcmd"
 S MDEF.ReturnType="%Status"
 D SYNRCMD^KMPPST3C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; SynthGbl()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SynthGbl"
 S MDEF.ReturnType="%Status"
 D SYNGBL^KMPPST3C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; SynthFile()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SynthFile"
 S MDEF.ReturnType="%Status"
 D SYNFILE^KMPPST3C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; SynthVpr()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="SynthVpr"
 S MDEF.ReturnType="%Status"
 D SYNVPR^KMPPST3C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetError()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetError"
 S MDEF.ReturnType="%Status"
 D GETERR^KMPPST3C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ; GetPatientList()
 S MDEF=##class(%Dictionary.MethodDefinition).%New()
 S MDEF.ClassMethod=1
 S MDEF.Name="GetPatientList"
 S MDEF.ReturnType="%Status"
 D GETPAT^KMPPST3C(.MDEF)
 D KMP.Methods.Insert(MDEF)
 ;
 D KMP.%Save()
 D $system.OBJ.Compile("KMP.VistaSystemMonitor","ck")
 Q
 ;
