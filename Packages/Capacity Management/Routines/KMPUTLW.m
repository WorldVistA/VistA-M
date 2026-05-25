KMPUTLW ;SP/JML - Manage REST interfaces for VSM Monitors ;7/1/2025
 ;;4.0;CAPACITY MANAGEMENT;**1,3,4,5**;3/1/2018;Build 9
 ;
 ; Reference to GETENV^%ZOSV in ICR #10097
 ; Reference to $$SITE^VASITE in ICR #10112
 ;
 ;
POST(KMPJSON,KMPRLOC,KMPFFLAG,KMPMKEY) ;
 N KMPAKEY,KMPFILE,KMPFN,KMPFQDN,KMPPORT,KMPRESP,KMPREQ,KMPRJSON,KMPSCODE,KMPSTAGE,KMPSTAT,KMPETIME,KMPSTIME,KMPSTEXT
 ;
 I $G(KMPMKEY)="" S KMPMKEY="VTCM"
 I KMPJSON.Site="" D SITE(KMPJSON)
 S KMPREQ=##class(%Net.HttpRequest).%New()
 S KMPREQ.ContentType="application/json"
 D KMPREQ.SetHeader("Accept","application/json")
 ;   Send SSL
 I $$GETVAL^KMPVCCFG(KMPMKEY,"ENCRYPT",8969,"I")=1 D
 .S KMPREQ.SSLConfiguration="KMPHttpsClient"
 .S KMPREQ.Https=1
 ;   Server/Resource/Port/Key
 S KMPREQ.Location="vsm"_$$PROD^KMPVCCFG()_KMPRLOC
 ; ****** FOR DEVL TESTING ONLY *****
 ;I $$PROD^KMPVCCFG()'="prod" S KMPREQ.Location="vsmdevl"_KMPRLOC ;**************** remove for release
 ; ***********************************
 S KMPFQDN=$$GETVAL^KMPVCCFG(KMPMKEY,"NATIONAL FQDN",8969)
 I KMPFQDN="" D
 .S KMPREQ.Server=$$GETVAL^KMPVCCFG(KMPMKEY,"NATIONAL IP",8969)
 .S KMPREQ.Port=$$GETVAL^KMPVCCFG(KMPMKEY,"NATIONAL PORT",8969)
 I KMPFQDN'="" S KMPREQ.Server=KMPFQDN
 ; only set NATIONAL PORT if other than 80/443
 S KMPPORT=$$GETVAL^KMPVCCFG(KMPMKEY,"NATIONAL PORT",8969)
 I KMPPORT'="" S KMPREQ.Port=KMPPORT
 S KMPAKEY=$$GETVAL^KMPVCCFG(KMPMKEY,"APIKEY",8969)
 I KMPAKEY'="" D KMPREQ.SetHeader("x-api-key",KMPAKEY)
 ;   Add JSON String to EntityBody from Object/File and send
 I $G(KMPFFLAG)=1 D
 .S KMPFN=$$DEFDIR^%ZISH()_$P(KMPRLOC,"/",2)_$J_".txt"
 .S KMPFILE=##class(%File).%New(KMPFN)
 .D KMPFILE.Open("WSN")
 .D KMPJSON.%ToJSON(KMPFILE)
 .D KMPFILE.Close()
 .D KMPFILE.Open("RS")
 .D KMPREQ.EntityBody.CopyFrom(KMPFILE)
 .D KMPFILE.Close()
 .S KMPSTAT=##class(%File).Delete(KMPFN)
 E  D KMPREQ.EntityBody.Write(KMPJSON.%ToJSON())
 I $D(KMPTEST) W !,KMPJSON.%ToJSON(),!
 S KMPSTIME=$P($ZTIMESTAMP,",",2)
 S KMPSTAT=KMPREQ.Post(,$G(KMPTEST))
 S KMPETIME=$P($ZTIMESTAMP,",",2)
 S KMPSCODE=KMPREQ.HttpResponse.StatusCode
 S KMPSTEXT=$S(+$G(KMPSCODE)>0:KMPREQ.HttpResponse.Data.Read(),1:"")
 I $D(KMPTEST) W !,"Http Response Status Code: ",KMPSCODE,!
 K KMPTEST
 Q KMPSCODE_"^"_KMPSTEXT_"^"_(KMPETIME-KMPSTIME)
 ;
INFOMSG(KMPVTEXT) ;  Send text POST
 N KMPEMAIL,KMPMSG,KMPI,KMPSERV,KMPSTAT,KMPVNODE
 S KMPSINF=$$SITEINFO^KMPVCCFG()
 D GETENV^%ZOSV S KMPVNODE=$P(Y,U,3)_":"_$P($P(Y,U,4),":",2) ;supported by ICR #10097
 S KMPMSG=##class(%Net.MailMessage).%New()
 S KMPMSG.From="VSM@"_$P(KMPSINF,"^",3)
 S KMPEMAIL=$$GETVAL^KMPVCCFG("VTCM","NATIONAL SUPPORT EMAIL ADDRESS",8969)
 D KMPMSG.To.Insert(KMPEMAIL)
 S KMPMSG.Subject=$G(KMPVTEXT("SUBJECT"))
 S KMPMSG.IsBinary=0
 S KMPMSG.IsHTML=0
 D KMPMSG.TextData.WriteLine("Do Not Reply - Informational Only")
 D KMPMSG.TextData.Write(" "_$c(13))
 S KMPI=0
 F  S KMPI=$o(KMPVTEXT(KMPI)) q:+KMPI=0  D
 .D KMPMSG.TextData.WriteLine("   "_KMPVTEXT(KMPI))
 D KMPMSG.TextData.Write(" "_$c(13))
 D KMPMSG.TextData.WriteLine("Site Name: "_$P(KMPSINF,"^",1))
 D KMPMSG.TextData.WriteLine("Site Number: "_$P(KMPSINF,"^",2))
 D KMPMSG.TextData.WriteLine("Site Domain: "_$P(KMPSINF,"^",3))
 D KMPMSG.TextData.WriteLine("Prod/Test: "_$P(KMPSINF,"^",4))
 D KMPMSG.TextData.WriteLine("Site Code: "_$P(KMPSINF,"^",5))
 D KMPMSG.TextData.WriteLine("Node: "_KMPVNODE)
 S KMPSERV=##class(%Net.SMTP).%New()
 S KMPSERV.smtpserver="smtp.domain.ext"
 S KMPSTAT=KMPSERV.Send(KMPMSG)
 Q
 ;
CANMSG(MTYPE,KMPMKEY,KMPSITE,KMPD) ; Repeatable, configured informational mail messages
 N KMPPROD,KMPTEXT
 S KMPPROD=$$PROD^KMPVCCFG()
 ;
 I MTYPE="JOBLATE" D
 .S KMPTEXT("SUBJECT")="VSM ALERT: "_KMPMKEY_" DAILY JOB NOT RUN: "_$P(KMPSITE,"^",2)
 .S KMPTEXT(1)="Daily "_KMPMKEY_" job behind "_KMPD_" days"
 .S KMPTEXT(2)=$$SITEINFO^KMPVCCFG()
 .D INFOMSG(.KMPTEXT)
 I MTYPE="DELETE" D
 .S KMPTEXT("SUBJECT")="VSM ALERT: Purging "_KMPMKEY_" data for "_$P(KMPSITE,"^",2)
 .S KMPTEXT(1)="Data purged for: "_KMPD
 .S KMPTEXT(2)=$$SITEINFO^KMPVCCFG()
 .D INFOMSG(.KMPTEXT)
 I MTYPE="TRANWARN" D
 .S KMPTEXT("SUBJECT")="VSM ALERT: Data transmissions of "_KMPMKEY_" data late for "_$P(KMPSITE,"^",2)
 .S KMPTEXT(1)=$$SITEINFO^KMPVCCFG()
 .D INFOMSG(.KMPTEXT)
 I MTYPE="FAILTRAN" D
 .S KMPTEXT("SUBJECT")="VSM ALERT: Failed transmission for "_$P(KMPSITE,"^",2)
 .S KMPTEXT(1)="Collection date: "_KMPD
 .S KMPTEXT(2)=$$SITEINFO^KMPVCCFG()
 .D INFOMSG(.KMPTEXT)
 I MTYPE="KILL" D
 .S KMPTEXT("SUBJECT")="VSM ALERT: All data deleted at "_$P(KMPSITE,"^",2)_" for "_KMPMKEY
 .S KMPTEXT(1)="Username: "_$$USERNAME^KMPVCCFG(DUZ)
 .S KMPTEXT(2)=$$SITEINFO^KMPVCCFG()
 .D INFOMSG(.KMPTEXT)
 Q
 ;
CFGMSG(KMPRQNAM) ;  Send configuration data to update Location Table at National VSM Database
 N KMPCFG,KMPJSON,KMPMARR,KMPMKEY,KMPMON,KMPROLES,KMPSCODE
 I $G(KMPRQNAM)="" S KMPRQNAM=$$USERNAME^KMPVCCFG($G(DUZ))
 S KMPJSON=##class(%DynamicObject).%New()
 ;W 1/0
 S KMPJSON.Function="KMP CFG"
 S KMPJSON.Requestor=KMPRQNAM
 D SITE(KMPJSON)
 S KMPROLES=##class(KMP.Utilities).getRoles()
 I (KMPROLES["%All")!(KMPROLES["%Manager") D CPF(KMPJSON)
 D MON(KMPJSON)
 D MAILGROUPS(KMPJSON)
 S KMPSCODE=$$POST(KMPJSON,"/config")
 Q
 ;
SITE(KMPJSON) ;
 N KMPINST,KMPNDTYP,KMPNODE,KMPSINF,KMPSITE,KMPSYS,%,Y
 D NOW^%DTC
 S KMPSITE=$$SITE^VASITE($P(%,".")) ;supported by ICR #10112
 S KMPSINF=$$SITEINFO^KMPVCCFG()
 S KMPSYS=$$SYSCFG^KMPVCCFG()
 S KMPSITE=##class(%DynamicObject).%New()
 S KMPSITE.SiteName=$P(KMPSINF,"^"),KMPSITE.SiteNum=$P(KMPSINF,"^",2),KMPSITE.SiteDomain=$P(KMPSINF,"^",3)
 S KMPSITE.SiteCode=$P(KMPSINF,"^",5),KMPSITE.Production=$P(KMPSINF,"^",4) ; ,KMPSITE.Date=$P($$TSTAMP($H,"HOROLOG",1),"^")
 S KMPSITE.Cache=$P(KMPSYS,"^",1),KMPSITE.OS=$P(KMPSYS,"^",2),KMPSITE.CacheVersion=$P(KMPSYS,"^",3)
 D GETENV^%ZOSV S KMPNODE=$P(Y,U,3)_":"_$P($P(Y,U,4),":",2) ;supported by ICR #10097
 S KMPINST=$P(KMPNODE,":",2),KMPNDTYP=$$NODETYPE^KMPUTLW(KMPINST)
 S KMPSITE.NodeType=KMPNDTYP,KMPSITE.Node=$p(KMPNODE,":")
 I KMPNDTYP="BE" S KMPSITE.BackendNode=$P(KMPNODE,":")
 S KMPIEN=$O(^KMPV(8969,"B","VTCM",""))
 S KMPJSON.Site=KMPSITE
 Q
 ;
SITEARR(KMPARR) ;
 N KMPIEN,KMPINST,KMPNDTYP,KMPNODE,KMPSINF,KMPSITE,KMPSYS,%,Y
 D NOW^%DTC
 S KMPSITE=$$SITE^VASITE($P(%,".")) ;supported by ICR #10112
 S KMPSINF=$$SITEINFO^KMPVCCFG()
 S KMPSYS=$$SYSCFG^KMPVCCFG()
 S KMPARR("SiteName")=$P(KMPSINF,"^"),KMPARR("SiteNum")=$P(KMPSINF,"^",2),KMPARR("SiteDomain")=$P(KMPSINF,"^",3)
 S KMPARR("SiteCode")=$P(KMPSINF,"^",5),KMPARR("Production")=$P(KMPSINF,"^",4)
 S KMPARR("Cache")=$P(KMPSYS,"^",1),KMPARR("OS")=$P(KMPSYS,"^",2),KMPARR("CacheVersion")=$P(KMPSYS,"^",3)
 D GETENV^%ZOSV S KMPNODE=$P(Y,U,3)_":"_$P($P(Y,U,4),":",2) ;supported by ICR #10097
 S KMPINST=$P(KMPNODE,":",2),KMPNDTYP=$$NODETYPE^KMPUTLW(KMPINST)
 S KMPARR("NodetType")=KMPNDTYP,KMPARR("Node")=$P(KMPNODE,":")
 I KMPNDTYP="BE" S KMPARR("BackendNode")=$P(KMPNODE,":")
 S KMPIEN=$O(^KMPV(8969,"B","VTCM",""))
 Q
 ;
CPF(KMPJSON) ;
 N KMPCONFIG,KMPCPF,KMPI,KMPLIST,KMPMIRROR,KMPSTART
 S KMPCPF=##class(%DynamicObject).%New()
 ;
 S KMPSTART=##class(%DynamicObject).%New()
 S KMPARR=##class(KMP.Utilities).getCPF("Startup")
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .D KMPSTART.%Set($LISTGET(KMPLIST,1),$LISTGET(KMPLIST,2))
 S KMPCPF.Startup=KMPSTART
 ;
 S KMPMIRROR=##class(%DynamicObject).%New()
 S KMPARR=##class(KMP.Utilities).getCPF("MirrorMember")
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .D KMPMIRROR.%Set($LISTGET(KMPLIST,1),$LISTGET(KMPLIST,2))
 S KMPCPF.MirrorMember=KMPMIRROR
 ;
 S KMPCONFIG=##class(%DynamicObject).%New()
 S KMPARR=##class(KMP.Utilities).getCPF("config")
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .D KMPCONFIG.%Set($LISTGET(KMPLIST,1),$LISTGET(KMPLIST,2))
 S KMPCPF.Config=KMPCONFIG
 ;
 S KMPJSON.CPF=KMPCPF
 Q
 ;
CPFARR(KMPCFG) ;
 N KMPI,KMPARR,KMPLIST
 ;
 S KMPARR=##class(KMP.Utilities).getCPF("Startup")
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .S KMPCFG("Startup",$LISTGET(KMPLIST,1))=$LISTGET(KMPLIST,2)
 ;
 S KMPMIRROR=##class(%DynamicObject).%New()
 S KMPARR=##class(KMP.Utilities).getCPF("MirrorMember")
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .S KMPCFG("MirrorMember",$LISTGET(KMPLIST,1))=$LISTGET(KMPLIST,2)
 ;
 S KMPCONFIG=##class(%DynamicObject).%New()
 S KMPARR=##class(KMP.Utilities).getCPF("config")
 F KMPI=1:1:KMPARR.Count() D
 .S KMPLIST=KMPARR.GetAt(KMPI)
 .S KMPCFG("config",$LISTGET(KMPLIST,1))=$LISTGET(KMPLIST,2)
 Q
 ;
MON(KMPJSON) ;
 ; Monitor Information
 N KMPMARR,KMPMKEY,KMPIEN,KMPMON,KMPCFG,KMP3,KMP4
 S KMPMARR=##class(%DynamicArray).%New()
 S KMPMKEY=""
 F  S KMPMKEY=$O(^KMPV(8969,"B",KMPMKEY)) Q:KMPMKEY=""  D
 .S KMPIEN=$O(^KMPV(8969,"B",KMPMKEY,""))
 .S KMPMON=##CLASS(%DynamicObject).%New()
 .S KMPCFG=$$CFGSTR^KMPVCCFG(KMPMKEY)
 .S KMP3=$G(^KMPV(8969,KMPIEN,3))
 .S KMP4=$G(^KMPV(8969,KMPIEN,4))
 .S KMPMON.AllowTestSystem=$P(KMPCFG,"^",9)
 .S KMPMON.ApiKey=$P(KMP4,"^",4)
 .S KMPMON.CacheDailyTask=$P(KMPCFG,"^",10)
 .S KMPMON.CollectionInterval=$P(KMPCFG,"^",6)
 .S KMPMON.DaysToKeepData=$P(KMPCFG,"^",5)
 .S KMPMON.Encrypt=$P(KMPCFG,"^",14)
 .S KMPMON.Monitor=KMPMKEY
 .S KMPMON.NationalFqdn=$P(KMP4,"^",2)
 .S KMPMON.NationalIpAddress=$P(KMP4,"^")
 .S KMPMON.NationalPort=$P(KMP4,"^",3)
 .S KMPMON.NationalSupportEmailAddress=$P(KMP3,"^",2)
 .S KMPMON.OnOff=$P(KMPCFG,"^",2)
 .S KMPMON.HttpRequestMaxLength=$P(KMPCFG,"^",7)
 .S KMPMON.MonitorStartDelay=$P(KMPCFG,"^",8)
 .S KMPMON.CoverSheetExpiration=$P(KMPCFG,"^",11)
 .S KMPMON.Version=$P(KMPCFG,"^",3)
 .S KMPMON.VersionInstallDate=$$SHORTDAT($P(KMPCFG,"^",4),"FILEMAN")
 .S KMPMON.FutureTaskCheck=$P(KMPCFG,"^",15)
 .D KMPMARR.%Push(KMPMON)
 S KMPJSON.MonCFG=KMPMARR
 Q
 ;
MONARR(KMPMON) ;
 N KMPMKEY,KMPIEN,KMPCFG,KMP3,KMP4
 S KMPMKEY=""
 F  S KMPMKEY=$O(^KMPV(8969,"B",KMPMKEY)) Q:KMPMKEY=""  D
 .S KMPIEN=$O(^KMPV(8969,"B",KMPMKEY,""))
 .S KMPCFG=$$CFGSTR^KMPVCCFG(KMPMKEY)
 .S KMP3=$G(^KMPV(8969,KMPIEN,3))
 .S KMP4=$G(^KMPV(8969,KMPIEN,4))
 .S KMPMON(KMPMKEY,"AllowTestSystem")=$P(KMPCFG,"^",9)
 .S KMPMON(KMPMKEY,"CacheDailyTask")=$P(KMPCFG,"^",10)
 .S KMPMON(KMPMKEY,"CollectionInterval")=$P(KMPCFG,"^",6)
 .S KMPMON(KMPMKEY,"DaysToKeepData")=$P(KMPCFG,"^",5)
 .S KMPMON(KMPMKEY,"Encrypt")=$P(KMPCFG,"^",14)
 .S KMPMON(KMPMKEY,"Monitor")=KMPMKEY
 .S KMPMON(KMPMKEY,"NationalFqdn")=$P(KMP4,"^",2)
 .S KMPMON(KMPMKEY,"NationalIpAddress")=$P(KMP4,"^")
 .S KMPMON(KMPMKEY,"NationalPort")=$P(KMP4,"^",3)
 .S KMPMON(KMPMKEY,"NationalSupportEmailAddress")=$P(KMP3,"^",2)
 .S KMPMON(KMPMKEY,"OnOff")=$P(KMPCFG,"^",2)
 .S KMPMON(KMPMKEY,"HttpRequestMaxLength")=$P(KMPCFG,"^",7)
 .S KMPMON(KMPMKEY,"MonitorStartDelay")=$P(KMPCFG,"^",8)
 .S KMPMON(KMPMKEY,"CoverSheetExpiration")=$P(KMPCFG,"^",11)
 .S KMPMON(KMPMKEY,"Version")=$P(KMPCFG,"^",3)
 .S KMPMON(KMPMKEY,"VersionInstallDate")=$$SHORTDAT($P(KMPCFG,"^",4),"FILEMAN")
 .S KMPMON(KMPMKEY,"FutureTaskCheck")=$P(KMPCFG,"^",15)
 Q
 ;
MAILGROUPS(KMPJSON) ;
 N KMPARR,KMPGROUP,KMPLIST,KMPI
 S KMPLIST=""
 I $$EXIST^%R("R1XUMSAR.int",$ZDEFNSP) D
 .D GETSENDTO^R1XUMSAR(.KMPARR)
 .S KMPGROUP="",KMPI=1
 .F  S KMPGROUP=$O(KMPARR(KMPGROUP)) Q:KMPGROUP=""  D
 ..S $P(KMPLIST,",",KMPI)=KMPGROUP
 ..S KMPI=KMPI+1
 S KMPJSON.MailGroups=KMPLIST
 Q
 ;
TSTAMP(KMPDAY,KMPFORMAT,KMPTZ) ;
 ; variables passed must be 1st and 2nd piece in $H format
 N KMPRTS,KMPTZONE,KMPUTC,X,%H,%T
 I KMPFORMAT="" Q ""
 I KMPDAY="" Q ""
 S KMPRTS=""
 S KMPTZONE=$ZTIMEZONE/60
 I KMPFORMAT="FILEMAN" D
 .S X=KMPDAY D H^%DTC
 .S $P(KMPDAY,",")=%H,$P(KMPDAY,",",2)=%T
 I $P(KMPDAY,",",2)>86399 S $P(KMPDAY,",",2)=""
 S KMPRTS=$ZDATE(+KMPDAY,3)_" "_$ZTIME($P(KMPDAY,",",2))
 S KMPRTS=$ZDATETIME(KMPDAY,3)
 I $G(KMPTZ)=1 S KMPRTS=KMPRTS_"Z"_KMPTZONE
 S KMPUTC=$SYSTEM.Util.LocalWithZTIMEZONEtoUTC(KMPDAY)
 S $P(KMPRTS,"^",2)=$ZDATETIME(KMPUTC,3)
 S $P(KMPRTS,"^",3)=(KMPUTC-47117*86400+$P($P(KMPUTC,",",2),"."))
 S $P(KMPRTS,"^",4)=$SYSTEM.Util.IsDST()
 Q KMPRTS
 ;
SHORTDAT(KMPDAY,KMPFORMAT) ; convert $h or fileman to external date
 ; passing $H whole or first piece
 N X
 I KMPDAY="" Q ""
 I KMPFORMAT="HOROLOG" Q $ZDATE(+KMPDAY,3)
 I KMPFORMAT="FILEMAN" D  Q $ZDATE(%H,3)
 .S X=KMPDAY D H^%DTC
 Q
 ;
UTC(KMPZTS) ; Requres $ZTIMSTAMP to convert to Linux Epoch format
 S KMPZTS=$G(KMPZTS) I KMPZTS="" S KMPZTS=$ZTIMESTAMP
 ; get delta from $h start to Epoch start -- then convert to seconds
 Q (KMPZTS-47117*86400+$P($P(KMPZTS,",",2),"."))
 ;
NODETYPE(INSTANCE) ; 
 ;  from ZSTU
 N X
 S X=INSTANCE ;,Y=SSPORT
 I $E(X,7,9)="SVR" Q "BE"
 I $E(X,7,8)="A0"!($E(X,7,8)="TM") Q "FE"
 I $E(X,6,9)="SHMS"!($E(X,6,8)="SSM") Q "MS"
 I $E(X,7,9)="LDR"!($E(X,6,8)="SSL") Q "LS"
 I $E(X,6,9)="SHDW"!($E(X,6,8)="SS0")!($E(X,6,8)="SS1") Q "VRO"
 Q "UK"
