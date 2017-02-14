XOBWPA04 ;OAK/BDT - HWSC :: Environmental Check ; 06/28/2016
 ;;1.0;HwscWebServiceClient;**4**;September 13, 2010;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ***** IMPORTANT NOTE *******************************************
 ; This routine requires access to the manager (%SYS) namespace and
 ; can only be run by a user with permissions to that namespace.
 ; ****************************************************************
 ;
 ; Loads "xobw4.xml" into XOBW*1*4 transport global. Post-installation
 ; routine ^XOBWPA04 will reconstruct the file for the installation of Cache
 ; classes into VistA to support SSL. The "xobw4.xml"
 ; file must be in the PRIMARY HFS DIRECTORY prior to transport.
 ;
 ; Note: Make sure that there are no lines longer than 255 chars in the file
 ; to be loaded! It appears $$FTG is not creating overflow nodes.
 ;
POST ;
 D SETDATA ;
 D IMPDATA ;
 Q
GETDATA ; export data from xobw4.xml file
 N I,X,XFILE,XPATH,XREF
 K ^TMP($J,4)
 S XFILE="xobw4.xml"
 S XPATH=$$DEFDIR^%ZISH ;PRIMARY HFS DIRECTORY
 S XREF="^TMP("_$J_",4,1,0)"
 S X=$$FTG^%ZISH(XPATH,XFILE,XREF,3) ;Load file into global
 Q
 ;
IMPDATA ; import data into xobw4.xml file
 N XDIR,XOBWY,Y
 S XDIR=$$DEFDIR^%ZISH
     S XREF="^TMP("_$J_",4,1,0)"
     S Y=$$GTF^%ZISH(XREF,3,XDIR,"xobw4.xml")  ;Export ^TMP global to XML file
     K ^TMP($J,4)
     S XDIR=$$DEFDIR^%ZISH
     S XOBWY=$$IMPORT^XOBWLIB1(XDIR,"xobw4.xml")  ;Import Cache classes
     IF 'XOBWY DO
     . DO BMES^XPDUTL("Error occurred during the importing of support classes file:")
     . DO MES^XPDUTL("  Directory: "_XDIR)
     . DO MES^XPDUTL("  File Name: "_"xobw4.xml")
     . DO MES^XPDUTL("      Error: "_$PIECE(XOBWY,"^",2))
     . DO MES^XPDUTL(" o  Classes not imported.")
  ELSE  DO
   . DO MES^XPDUTL(" o  Support classes imported successfully.")
   . DO MES^XPDUTL(" ")
 Q
 ;
SETDATA ;
   N I,IT
   K ^TMP($J,4)
   F I=1:1:158 S IT=$T(DATA+I)  S ^TMP($J,4,I,0)=$P(IT,";;",2)
   Q
DATA ;
   ;;<?xml version="1.0" encoding="UTF-8"?>
   ;;<Export generator="Cache" version="25" zv="Cache for UNIX (Red Hat Enterprise Linux for x86-64) 2014.1.3 (Build 775)" ts="2016-06-10 11:14:51">
   ;;<Class name="xobw.WebServiceProxyFactory">
   ;;<Description><![CDATA[
   ;;This factory class contains methods to create web service proxy instances.
   ;;<br><br>As part of the creation process, web server ip/port resolution is performed and
   ;;any security implementation, as defined by ISS, is executed. ]]></Description>
   ;;<ClassType/>
   ;;<ProcedureBlock>1</ProcedureBlock>
   ;;<Super>%RegisteredObject</Super>
   ;;<TimeChanged>64072,51245.767727</TimeChanged>
   ;;<TimeCreated>60655,58903.754395</TimeCreated>
   ;;
   ;;<UDLText name="T">
   ;;<Content><![CDATA[
   ;;// 1.0;HwscWebServiceClient   ;;September 13, 2010
   ;;
   ;;]]></Content>
   ;;</UDLText>
   ;;
   ;;<UDLText name="T">
   ;;<Content><![CDATA[
   ;;// HealtheVet Web Service Client v1 [Build: 1.0.1.009]
   ;;
   ;;]]></Content>
   ;;</UDLText>
   ;;
   ;;<Property name="webServiceMetadata">
   ;;<Type>WebServiceMetadata</Type>
   ;;<Private>1</Private>
   ;;</Property>
   ;;
   ;;<Method name="%OnNew">
   ;;<FormalSpec>webServiceName:%String</FormalSpec>
   ;;<ReturnType>%Status</ReturnType>
   ;;<Implementation><![CDATA[
   ;; set webServiceId=##class(xobw.WebServiceMetadata).getWebServiceId(webServiceName)
   ;; if 'webServiceId {
   ;;     do ##class(xobw.error.DialogError).forceError(186006_"^"_webServiceName)
   ;; }
   ;; set ..webServiceMetadata=##class(xobw.WebServiceMetadata).%OpenId(webServiceId)
   ;; quit $$$OK
   ;;]]></Implementation>
   ;;</Method>
   ;;
   ;;<Method name="getProxy">
   ;;<Description><![CDATA[
   ;;Creates web service client proxy for a web server.
   ;;<ul>
   ;;Parameter:
   ;; <li><parameter>webServerName = name of server as it appears in NAME (#.01) field of a WEB SERVER (#18.12) file entry</parameter>
   ;;</ul>]]></Description>
   ;;<FormalSpec>webServerName:%String</FormalSpec>
   ;;<ReturnType>%SOAP.WebClient</ReturnType>
   ;;<Implementation><![CDATA[
   ;;  // Future: Add any required headers to proxy when discovered, if any
   ;;  new %proxy
   ;;  if ..webServiceMetadata.type'=1 {
   ;;      do ##class(xobw.error.DialogError).forceError(186007)
   ;;  }
   ;;  xecute "set %proxy=##class("_..webServiceMetadata.proxyClassName_").%New()"
   ;;  if %proxy'=$$$NULLOREF {
   ;;   set webServerId=##class(xobw.WebServer).getWebServerId(webServerName)
   ;;    if 'webServerId {
   ;;      do ##class(xobw.error.DialogError).forceError(186005_"^"_webServerName)
   ;;   }    
   ;;   set webServer=##class(xobw.WebServer).%OpenId(webServerId)
   ;;   
   ;;   // web server is disabled
   ;;   if 'webServer.status {
   ;;    do ##class(xobw.error.DialogError).forceError(186002_"^"_webServer.name)
   ;;   }
   ;;   
   ;;   do ..setUpCredentials(webServer, %proxy)
   ;;   do ..setUpLocation(webServer, %proxy)
   ;;  }
   ;; quit $get(%proxy)
   ;;]]></Implementation>
   ;;</Method>
   ;;
   ;;<Method name="setUpCredentials">
   ;;<FormalSpec>webServer:WebServer,proxy:%SOAP.WebClient</FormalSpec>
   ;;<Private>1</Private>
   ;;<Implementation><![CDATA[
   ;; set authorizedWebServiceId=##class(xobw.WebServicesAuthorized).getAuthorizedWebServiceId(webServer,..webServiceMetadata)
   ;; 
   ;; // web service is not authorized
   ;; if 'authorizedWebServiceId {
   ;;  do ##class(xobw.error.DialogError).forceError(186003_"^"_..webServiceMetadata.name_"^"_webServer.name)
   ;; }
   ;; 
   ;; set authorizedWebService=##class(xobw.WebServicesAuthorized).%OpenId(authorizedWebServiceId)
   ;; 
   ;; // web service is disabled
   ;; if 'authorizedWebService.status {
   ;;  do ##class(xobw.error.DialogError).forceError(186004_"^"_..webServiceMetadata.name_"^"_webServer.name)
   ;; }
   ;; 
   ;; if webServer.loginRequired="1"!(webServer.loginRequired="") {
   ;;  set proxy.HttpUsername=webServer.userName
   ;;  set proxy.HttpPassword=webServer.getPassword()
   ;; }
   ;; quit
   ;;]]></Implementation>
   ;;</Method>
   ;;
   ;;<Method name="setUpLocation">
   ;;<FormalSpec>webServer:WebServer,proxy:%SOAP.WebClient</FormalSpec>
   ;;<Private>1</Private>
   ;;<Implementation><![CDATA[
   ;; if (webServer.sslEnabled && ('$$SSLOK^XOBWENV())) {
   ;;  do ##class(xobw.error.DialogError).forceError(186002_"^"_webServer.name_" (SSL is disabled on VMS)")
   ;; }
   ;; if (webServer.sslEnabled) {
   ;;  set proxy.Location="https://"_webServer.server_":"_webServer.sslPort_"/"_..webServiceMetadata.contextRoot
   ;;  set proxy.SSLConfiguration = webServer.sslConfiguration
   ;;  set proxy.SSLCheckServerIdentity = 0
   ;; } else {
   ;;  set proxy.Location="http://"_webServer.server_":"_webServer.port_"/"_..webServiceMetadata.contextRoot
   ;; }
   ;; set proxy.Timeout=webServer.defaultTimeout
   ;; quit
   ;;]]></Implementation>
   ;;</Method>
   ;;
   ;;<Method name="close">
   ;;<Description><![CDATA[
   ;;Close web service proxy factory
   ;;<br>
   ;;<br>Performs any close processing activities required.]]></Description>
   ;;<ReturnType>%Status</ReturnType>
   ;;<Implementation><![CDATA[ quit $$$OK
   ;;]]></Implementation>
   ;;</Method>
   ;;
   ;;<Method name="getWebServiceProxy">
   ;;<Description><![CDATA[
   ;;Create web service proxy
   ;;<ul>
   ;;Parameters:
   ;; <li><parameter>webServiceName = name of service as it appears NAME (#.01) field in an WEB SERVICE (#18.02) file entry</parameter>
   ;; <li><parameter>webServerName = name of server as it appears NAME (#.01) field in an WEB SERVER (#18.12) file entry</parameter>
   ;;</ul>
   ;;<br><b>Restricted Use:</b> This method is for HWSC use only. Applications should use the $$GETPROXY^XOBWLB(...) API]]></Description>
   ;;<ClassMethod>1</ClassMethod>
   ;;<FormalSpec>webServiceName:%String,webServerName:%String</FormalSpec>
   ;;<ReturnType>%SOAP.WebClient</ReturnType>
   ;;<Implementation><![CDATA[
   ;; set factory=##class(xobw.WebServiceProxyFactory).%New(webServiceName)
   ;; if factory'=$$$NULLOREF {
   ;;  set proxy=factory.getProxy(webServerName)
   ;;  set ok=factory.close()
   ;; }
   ;; quit $get(proxy,$$$NULLOREF)
   ;;]]></Implementation>
   ;;</Method>
   ;;</Class>
   ;;</Export>
