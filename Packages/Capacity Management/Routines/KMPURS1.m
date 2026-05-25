KMPURS1 ;SP/JML - VSM Synthetic REST functions ;7/1/2025
 ;;4.0;CAPACITY MANAGEMENT;**5**;3/1/2018;Build 9
 ;
 ;
 ;
IMALIVEP() ;
 N KMPRET,KMPINST,KMPINST,KMPNDTYP
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="ImAlive" D  Q 0
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 D SITE^KMPUTLW(KMPRET)
 S KMPRET.ResultText="OK"
 W KMPRET.%ToJSON()
 Q
 ;
SYNTHFILEP() ;
 N KMPRET,KMPREQ,KMPINST,KMPNDTYP
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="SynthFile" D  Q 0
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 D SITE^KMPUTLW(KMPRET)
 D SYNFILE^KMPSYNTH(KMPRET)
 S KMPRET.ResultText="OK"
 W KMPRET.%ToJSON()
 Q
 ;
SYNTHRCMDP() ;
 N KMPRET,KMPREQ,KMPINST,KMPNDTYP
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="SynthRcmd" D  Q 0
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 D SITE^KMPUTLW(KMPRET)
 D SYNRCMD^KMPSYNTH(KMPRET)
 S KMPRET.ResultText="OK"
 W KMPRET.%ToJSON()
 Q
 ;
SYNTHVPRP() ;
 N KMPRET,KMPREQ,KMPINST,KMPNDTYP
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="SynthVpr" D  Q 0
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 D SITE^KMPUTLW(KMPRET)
 D SYNVPR^KMPSYNTH(KMPRET,KMPREQ.PatientDfn,KMPREQ.ClinicalDomains)
 S KMPRET.ResultText="OK"
 W KMPRET.%ToJSON()
 Q
 ;
GETPLISTP ;
 N KMPREQ,KMPRET
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="GetPatientList" D  Q 0
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 D SITE^KMPUTLW(KMPRET)
 D PATLIST^KMPSYNTH(KMPRET,KMPREQ.Count)
 W KMPRET.%ToJSON()
 Q
