KMPURP1 ;SP/JML - VSM POST REST functions ;7/1/2025
 ;;4.0;CAPACITY MANAGEMENT;**5**;3/1/2018;Build 9
 ;
 ;
 ;
GETCONFIGP ;
 N KMPRET,KMPREQ
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="GetConfig" D  Q 0
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 ;
 D SITE^KMPUTLW(KMPRET)
 D CPF^KMPUTLW(KMPRET)
 D MON^KMPUTLW(KMPRET)
 D MAILGROUPS^KMPUTLW(KMPRET)
 S KMPRET.ResultText="OK"
 W KMPRET.%ToJSON()
 Q
 ;
GETERRORP ;
 N KMRET,KMPREQ,KMPD,KMPDAT,KMPENUM,KMPINODE,KMPJNODE,KMPUVNB,KMPVAL,KMPVAR,KMPVNUM,KMPVOBJ
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="GetError" D  Q 0
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 D SITE^KMPUTLW(KMPRET)
 S KMPDAT=KMPREQ.ErrorDate
 I KMPDAT="" D  Q
 .S KMPRET.Status="No Date Provided"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 S KMPDAT=$ZDATEH(KMPDAT,3)
 S KMPENUM=KMPREQ.ErrorNumber
 I KMPENUM="" D  Q 0
 .S KMPRET.Status="No Error Number Provided"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 S KMPD=##class(%DynamicObject).%New()
 I '$D(^%ZTER(1,KMPDAT,1,KMPENUM)) S KMPRET.Status="Error Not Found" Q
 S KMPD.ErrorNumber=+$G(^%ZTER(1,KMPDAT,1,KMPENUM,0))
 S KMPD.LastGlobalReference=$G(^%ZTER(1,KMPDAT,1,KMPENUM,"GR"))
 S KMPINODE=$G(^%ZTER(1,KMPDAT,1,KMPENUM,"I"))
 S KMPD.CurrentIo=$P(KMPINODE,"^",1)
 S KMPD.ZaValue=$P(KMPINODE,"^",2)
 S KMPD.ZbValue=$P(KMPINODE,"^",3)
 S KMPD.CurrentZio=$P(KMPINODE,"^",4)
 S KMPD.HValue=$G(^%ZTER(1,KMPDAT,1,KMPENUM,"H"))
 S KMPJNODE=$G(^%ZTER(1,KMPDAT,1,KMPENUM,"J"))
 S KMPD.JobNumber=$P(KMPJNODE,"^",1)
 S KMPD.ProcessName=$P(KMPJNODE,"^",2)
 S KMPD.UserName=$P(KMPJNODE,"^",3)
 S KMPUVNB=$P(KMPJNODE,"^",4)
 S KMPD.Uci=$P(KMPUVNB,"~",1)
 S KMPD.Vol=$P(KMPUVNB,"~",1)
 S KMPD.Node=$P(KMPUVNB,"~",1)
 S KMPD.Box=$P(KMPUVNB,"~",1)
 S KMPD.AlternateJobNumber=$P(KMPJNODE,"^",5)
 S KMPD.Line=$G(^%ZTER(1,KMPDAT,1,KMPENUM,"LINE"))
 S KMPD.ZE=$G(^%ZTER(1,KMPDAT,1,KMPENUM,"ZE"))
 S KMPVNUM=0,KMPVOBJ=##class(%DynamicObject).%New()
 F  S KMPVNUM=$O(^%ZTER(1,KMPDAT,1,KMPENUM,"ZV",KMPVNUM)) Q:+KMPVNUM=0  D
 .S KMPVAR=^%ZTER(1,KMPDAT,1,KMPENUM,"ZV",KMPVNUM,0)
 .S KMPVAL=^%ZTER(1,KMPDAT,1,KMPENUM,"ZV",KMPVNUM,"D")
 .D KMPVOBJ.%Set(KMPVAR,KMPVAL)
 S KMPD.Variables=KMPVOBJ
 S KMPRET.Status="Error Found"
 S KMPRET.Error=KMPD
 S KMPRET.ResultText="OK"
 W KMPRET.%ToJSON()
 Q
 ;
HTTPMETP ;
 N KMPRET,KMPREQ,KMPMCHK,KMPDATE,KMPDCHK,KMPMLIST,KMPSUB,KMPDAY,KMPMTYP,KMPMOBJ,KMPDARR,KMPNODE,KMPT,KMPTIME,KMPDATA
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="HttpMetrics" D  Q 0
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 D SITE^KMPUTLW(KMPRET)
 S KMPMCHK=KMPREQ.Montype
 I KMPMCHK="" S KMPMCHK="ALL"
 S KMPDATE=KMPREQ.Date
 I KMPDATE="" D  Q
 .S KMPRET.Status="No Date Provided"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 ; parse odbc date format into fileman data format
 S KMPDCHK="3"_$E(KMPDATE,3,4)_$P(KMPDATE,"-",2)_$P(KMPDATE,"-",3)
 S KMPRET.Date=KMPDATE
 S KMPMLIST=##class(%DynamicArray).%New()
 S KMPSUB="KMP"
 F  S KMPSUB=$O(^XTMP(KMPSUB)) Q:$E(KMPSUB,1,3)'="KMP"  D
 .S KMPDAY=$P(KMPSUB," ",2)
 .Q:KMPDCHK'=KMPDAY
 .S KMPMTYP=0
 .F  S KMPMTYP=$O(^XTMP(KMPSUB,KMPMTYP)) Q:KMPMTYP=""  D
 ..Q:(KMPMCHK'[KMPMTYP)&(KMPMCHK'="ALL")
 ..S KMPMOBJ=##class(%DynamicObject).%New()
 ..S KMPMOBJ.Monitor=KMPMTYP
 ..S KMPDARR=##class(%DynamicArray).%New()
 ..S KMPNODE=""
 ..F  S KMPNODE=$O(^XTMP(KMPSUB,KMPMTYP,"HTTP",KMPNODE)) Q:KMPNODE=""  D
 ...S KMPT=""
 ...F  S KMPT=$O(^XTMP(KMPSUB,KMPMTYP,"HTTP",KMPNODE,KMPT)) Q:KMPT=""  D
 ....S KMPTIME=$ZT(KMPT)
 ....S KMPDATA=^XTMP(KMPSUB,KMPMTYP,"HTTP",KMPNODE,KMPT)
 ....S KMPDATA=KMPTIME_"^"_KMPNODE_"^"_KMPDATA
 ....D KMPDARR.%Push(KMPDATA)
 ..S KMPMOBJ.Data=KMPDARR
 ..D KMPMLIST.%Push(KMPMOBJ)
 S KMPRET.Monitors=KMPMLIST
 S KMPRET.ResultText="OK"
 W KMPRET.%ToJSON()
 Q
 ;
GETOPSP ;
 N KMPRET,KMPREQ
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="GetOps" D  Q
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 D GETWEBP^KMPOPS(KMPREQ,KMPRET)
 W KMPRET.%ToJSON()
 Q
 ;
GETPACKP ;
 N KMPRET,KMPREQ,KMPIEN,KMPPACK,KMPPARR,KMPPNAM,KMPPRE
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="GetPackages" D  Q 0
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 D SITE^KMPUTLW(KMPRET)
 S KMPPARR=##class(%DynamicArray).%New()
 S KMPPRE=""
 F  S KMPPRE=$O(^DIC(9.4,"C",KMPPRE)) Q:KMPPRE=""  D
 .S KMPIEN=""
 .F  S KMPIEN=$O(^DIC(9.4,"C",KMPPRE,KMPIEN)) Q:KMPIEN=""  D
 ..S KMPPNAM=$P($G(^DIC(9.4,KMPIEN,0)),"^")
 ..S KMPPACK=##class(%DynamicObject).%New()
 ..S KMPPACK.Name=KMPPNAM,KMPPACK.Prefix=KMPPRE,KMPPACK.Ien=KMPIEN
 ..D KMPPARR.%Push(KMPPACK)
 S KMPRET.Packages=KMPPARR
 S KMPRET.ResultText="OK"
 W KMPRET.%ToJSON()
 Q
 ;
GETLOGP ;
 N KMPRET,KMPREQ,KMPD,KMPDATA,KMPIEN,KMPMARR,KMPREF,KMPMONLIST,KMPMON,KMPDAYS,KMPSTARTH,KMPENDH,KMPH,KMPMONOBJ
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="RunLog" D  Q 0
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 S KMPSTARTH="",KMPENDH=99999
 S KMPDAYS=+KMPREQ.Days
 I KMPDAYS D
 .S KMPSTARTH=$H-KMPDAYS
 S KMPDATE=KMPREQ.Date
 I KMPDATE]"" D
 .S KMPDATE=$ZDATEH(KMPDATE,3)
 .S KMPSTARTH=KMPDATE-1
 .S KMPENDH=KMPDATE
 S KMPREF("VTCM")=3
 S KMPREF("VSTM")=4
 S KMPREF("VMCM")=5
 S KMPREF("VBEM")=6
 S KMPREF("VCSM")=7
 S KMPREF("VETM")=8
 S KMPREF("VHLM")=9
 D SITE^KMPUTLW(KMPRET)
 S KMPMARR=##class(%DynamicArray).%New()
 S KMPIEN=0
 S KMPH=KMPSTARTH
 F  S KMPH=$O(^KMPV(8969.03,"B",KMPH)) Q:((+KMPH=0)!(KMPH>KMPENDH))  D
 .S KMPIEN=$O(^KMPV(8969.03,"B",KMPH,0))
 .S KMPDATA=$G(^KMPV(8969.03,KMPIEN,0))
 .S KMPD=##class(%DynamicObject).%New()
 .S KMPD.Date=$$SHORTDAT^KMPUTLW($P(KMPDATA,"^",1),"HOROLOG"),KMPD.Node=$P(KMPDATA,"^",2)
 .S KMPMONLIST=##class(%DynamicArray).%New()
 .S KMPMON=""
 .F  S KMPMON=$O(KMPREF(KMPMON)) Q:KMPMON=""  D
 ..S KMPMONOBJ=##class(%DynamicObject).%New()
 ..S KMPMONOBJ.Monitor=KMPMON
 ..S KMPMONOBJ.Timestamp=$P($$TSTAMP^KMPUTLW($P(KMPDATA,"^",KMPREF(KMPMON)),"FILEMAN"),"^")
 ..D KMPMONLIST.%Push(KMPMONOBJ)
 .S KMPD.Something=KMPMONLIST
 .D KMPMARR.%Push(KMPD)
 S KMPRET.Log=KMPMARR
 S KMPRET.ResultText="OK"
 W KMPRET.%ToJSON()
 Q
 ;
RETRYP ;
 N KMPREQ,KMPRET,KMPMKEY,KMPVER,ZTDESC,ZTDTH,ZTRTN
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="Retry" D  Q 0
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 S KMPMKEY=KMPREQ.Monitor
 S ZTDTH=$H
 I KMPMKEY="VTCM" S ZTRTN="RETRY^KMPTCMRT",ZTDESC="VTCM RETRY"
 I KMPMKEY="VSTM" S ZTRTN="RETRY^KMPSTMRT",ZTDESC="VSTM RETRY"
 I KMPMKEY="VBEM" S ZTRTN="RETRY^KMPBEMRT",ZTDESC="VBEM RETRY"
 I KMPMKEY="VMCM" S ZTRTN="RETRY^KMPMCMRT",ZTDESC="VMCM RETRY"
 I KMPMKEY="VHLM" S ZTRTN="RETRY^KMPHLMRT",ZTDESC="VHLM RETRY"
 I KMPMKEY="VCSM" S ZTRTN="RETRY^KMPCSMRT",ZTDESC="VCSM RETRY"
 I KMPMKEY="VETM" S ZTRTN="RETRY^KMPETMRT",ZTDESC="VETM RETRY"
 D ^ZTLOAD
 S KMPRET.ResultText="OK"
 D SITE^KMPUTLW(KMPRET)
 W KMPRET.%ToJSON()
 Q
 ;
SETCONFIGP ;
 N KMPRET,KMPREQ
 S KMPRET=##class(%DynamicObject).%New()
 Do %response.SetHeader("Access-Control-Allow-Origin","*")
 Do %response.SetHeader("Allow","HEAD,GET,POST,PUT,DELETE,OPTIONS")
 S KMPREQ=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
 S KMPRET.Function=KMPREQ.Function
 I KMPREQ.Function'="SetConfig" D  Q 0
 .S KMPRET.Status="Incorrect Function Type"
 .S KMPRET.ResultText="OK"
 .W KMPRET.%ToJSON()
 S KMPRET.ResultText=$$SETCFG^KMPUTLW2(KMPREQ)
 D SITE^KMPUTLW(KMPRET)
 D CPF^KMPUTLW(KMPRET)
 D MON^KMPUTLW(KMPRET)
 W KMPRET.%ToJSON()
 Q
