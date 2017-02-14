XOBWPB04 ;OAK/BDT - HWSC :: Environmental Check ; 06/28/2016
 ;;1.0;HwscWebServiceClient;**4**;September 13, 2010;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ***** IMPORTANT NOTE *******************************************
 ; This routine requires access to the manager (%SYS) namespace and
 ; can only be run by a user with permissions to that namespace.
 ; ****************************************************************
 ;
 ; Loads "xobw4b.xml" into XOBW*1*4 transport global. Post-installation
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
GETDATA ; export data from xobw4b.xml file
 N I,X,XFILE,XPATH,XREF
 K ^TMP($J,4)
 S XFILE="xobw4b.xml"
 S XPATH=$$DEFDIR^%ZISH ;PRIMARY HFS DIRECTORY
 S XREF="^TMP("_$J_",4,1,0)"
 S X=$$FTG^%ZISH(XPATH,XFILE,XREF,3) ;Load file into global
 Q
 ;
IMPDATA ; import data into xobw4b.xml file
 N XDIR,XOBWY,Y
 S XDIR=$$DEFDIR^%ZISH
     S XREF="^TMP("_$J_",4,1,0)"
     S Y=$$GTF^%ZISH(XREF,3,XDIR,"xobw4b.xml")  ;Export ^TMP global to XML file
     K ^TMP($J,4)
     S XDIR=$$DEFDIR^%ZISH
     S XOBWY=$$IMPORT^XOBWLIB1(XDIR,"xobw4b.xml")  ;Import Cache classes
     IF 'XOBWY DO
     . DO BMES^XPDUTL("Error occurred during the importing of support classes file:")
     . DO MES^XPDUTL("  Directory: "_XDIR)
     . DO MES^XPDUTL("  File Name: "_"xobw4b.xml")
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
   F I=1:1:323 S IT=$T(DATA+I)  S ^TMP($J,4,I,0)=$P(IT,"   ;;",2,99)
   Q
DATA ;
   ;;<?xml version="1.0" encoding="UTF-8"?>
   ;;<Export generator="Cache" version="25" zv="Cache for UNIX (Red Hat Enterprise Linux for x86-64) 2014.1.3 (Build 775)" ts="2016-06-22 15:48:50">
   ;;<Class name="xobw.WebServer">
   ;;<Description><![CDATA[
   ;;This persistent class contains web server connection information used to connect to server hosting web services
   ;;<br>
   ;;This class is mapped to the VA FileMan WEB SERVER (#18.12) file
   ;;<br><br>
   ;;<b>Restricted Use:</b> The properties and methods of this class are for HWSC use only.
   ;;  ]]></Description>
   ;;<ClassType>persistent</ClassType>
   ;;<ProcedureBlock>1</ProcedureBlock>
   ;;<SqlRowIdPrivate>1</SqlRowIdPrivate>
   ;;<SqlTableName>WebServer</SqlTableName>
   ;;<StorageStrategy>WebServerStorage</StorageStrategy>
   ;;<Super>%Persistent</Super>
   ;;<TimeChanged>64091,56835.117773</TimeChanged>
   ;;<TimeCreated>60654,21265.065878</TimeCreated>
   ;;
   ;;<UDLText name="T">
   ;;<Content><![CDATA[
   ;;// 1.0;HwscWebServiceClient;;September 13, 2010
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
   ;;<Index name="ienIndex">
   ;;<IdKey>1</IdKey>
   ;;<PrimaryKey>1</PrimaryKey>
   ;;<Properties>ien</Properties>
   ;;<Unique>1</Unique>
   ;;</Index>
   ;;
   ;;<Property name="server">
   ;;<Type>%String</Type>
   ;;<Parameter name="TRUNCATE" value="1"/>
   ;;</Property>
   ;;
   ;;<Property name="port">
   ;;<Type>%Integer</Type>
   ;;<Collection/>
   ;;<Relationship>0</Relationship>
   ;;</Property>
   ;;
   ;;<Property name="ien">
   ;;<Type>%String</Type>
   ;;<Collection/>
   ;;<Relationship>0</Relationship>
   ;;<Parameter name="TRUNCATE" value="1"/>
   ;;</Property>
   ;;
   ;;<Property name="name">
   ;;<Type>%String</Type>
   ;;<Collection/>
   ;;<Relationship>0</Relationship>
   ;;<Parameter name="TRUNCATE" value="1"/>
   ;;</Property>
   ;;
   ;;<Property name="production">
   ;;<Type>%Boolean</Type>
   ;;<Collection/>
   ;;<Relationship>0</Relationship>
   ;;<Transient>1</Transient>
   ;;</Property>
   ;;
   ;;<UDLText name="T">
   ;;<Content><![CDATA[
   ;;// server credentials
   ;;
   ;;]]></Content>
   ;;</UDLText>
   ;;
   ;;<Property name="loginRequired">
   ;;<Type>%Boolean</Type>
   ;;<SqlFieldName>loginRequired</SqlFieldName>
   ;;</Property>
   ;;
   ;;<Property name="password">
   ;;<Type>%String</Type>
   ;;<Private>1</Private>
   ;;<SqlFieldName>password</SqlFieldName>
   ;;<Parameter name="TRUNCATE" value="1"/>
   ;;</Property>
   ;;
   ;;<Property name="userName">
   ;;<Type>%String</Type>
   ;;<SqlFieldName>userName</SqlFieldName>
   ;;<Parameter name="TRUNCATE" value="1"/>
   ;;</Property>
   ;;
   ;;<Property name="defaultTimeout">
   ;;<Type>%Integer</Type>
   ;;<InitialExpression>30</InitialExpression>
   ;;<SqlFieldName>defaultTimeout</SqlFieldName>
   ;;<Parameter name="MAXVAL" value="7200"/>
   ;;<Parameter name="MINVAL" value="5"/>
   ;;</Property>
   ;;
   ;;<Property name="sslEnabled">
   ;;<Type>%Boolean</Type>
   ;;<SqlFieldName>sslEnabled</SqlFieldName>
   ;;</Property>
   ;;
   ;;<Property name="sslConfiguration">
   ;;<Type>%String</Type>
   ;;<SqlFieldName>sslConfiguration</SqlFieldName>
   ;;<Parameter name="TRUNCATE" value="1"/>
   ;;</Property>
   ;;
   ;;<Property name="sslPort">
   ;;<Type>%String</Type>
   ;;<SqlFieldName>sslPort</SqlFieldName>
   ;;<Parameter name="TRUNCATE" value="1"/>
   ;;</Property>
   ;;
   ;;<UDLText name="T">
   ;;<Content><![CDATA[
   ;;// for ISS use ------------------------
   ;;
   ;;]]></Content>
   ;;</UDLText>
   ;;
   ;;<Property name="authorizedWebServices">
   ;;<Type>xobw.WebServicesAuthorized</Type>
   ;;<Cardinality>children</Cardinality>
   ;;<Inverse>webServerRef</Inverse>
   ;;<Relationship>1</Relationship>
   ;;</Property>
   ;;
   ;;<Property name="status">
   ;;<Type>%Boolean</Type>
   ;;<Collection/>
   ;;<Relationship>0</Relationship>
   ;;</Property>
   ;;
   ;;<Method name="getPassword">
   ;;<ReturnType>%String</ReturnType>
   ;;<Implementation><![CDATA[ quit $$DECRYP^XOBWPWD(..password)
   ;;]]></Implementation>
   ;;</Method>
   ;;
   ;;<Method name="checkWebServicesAvailability">
   ;;<FormalSpec>dots:%String</FormalSpec>
   ;;<ReturnType>%Library.ListOfDataTypes</ReturnType>
   ;;<Implementation><![CDATA[
   ;; set key = ""
   ;; set count=0
   ;; set result=##class(%ListOfDataTypes).%New()
   ;;
   ;; // if server is disabled, stop
   ;; if '..status {
   ;;  do result.Insert("")
   ;;  do result.Insert(" o Web server is disabled")
   ;;  do result.Insert("")
   ;;  quit result
   ;; }
   ;;
   ;; // loop thru web services credentials defined for server and build list output
   ;; // mainly for ListMan consumption (AVAIL^XOBWUT1)
   ;; do {
   ;;  set authorizedWebService = ..authorizedWebServices.GetNext(.key)
   ;;  if $get(dots) write "."
   ;;  set count=count+1
   ;;  if (authorizedWebService '= $$$NULLOREF) {
   ;;   set webService=##class(xobw.WebServiceMetadata).%OpenId(authorizedWebService.webServiceIen)
   ;;   if (authorizedWebService.status) {
   ;;    if ((webService.type=1) || (webService.type=2)) {
   ;;     if ##class(xobw.WebServiceMetadata).checkResourceAvailability(##this,authorizedWebService,webService,.httpStatusCode) {
   ;;      do result.Insert(count_" "_webService.name_" is available")
   ;;     } else {
   ;;      do result.Insert(count_" Unable to retrieve '"_webService.availResource_"' for "_webService.name)
   ;;      //
   ;;      // the following lines will report spurious %objlasterror errors.
   ;;      // supposed to be fixed in Cache 5.1+.
   ;;      // 
   ;;      if ($data(%objlasterror)'=0) {
   ;;       do $system.Status.DecomposeStatus(%objlasterror,.err)
   ;;       set x=$get(err(1)," o no reason available")
   ;;       set length=$length(x)
   ;;       do result.Insert(" o "_$extract(x,1,70))
   ;;       set x=$extract(x,71,length)
   ;;       while (x'="") {
   ;;        do result.Insert(" "_$extract(x,1,70))
   ;;        set x=$extract(x,71,length)
   ;;       } // while
   ;;       // if there is a status code, show it
   ;;       if $get(httpStatusCode)]"" do result.Insert(" o HTTP Response Status Code: "_httpStatusCode)
   ;;      } else {
   ;;       do result.Insert(" o HTTP Response Status Code: "_$get(httpStatusCode,"<no status code available>"))
   ;;      } // %objlasterror 
   ;;     } // resource availability
   ;;    } else {
   ;;     do result.Insert(count_" "_webService.name_" is not a valid web service type ["_webservice.type_"]")
   ;;    } // not valid type (rare and should not occur)
   ;;   } else {
   ;;    do result.Insert(count_" "_webService.name_" is not enabled")
   ;;   } // authorizedWebService.status
   ;;  } // authorizedWebService
   ;; } while (key '= "")
   ;; quit result
   ;;]]></Implementation>
   ;;</Method>
   ;;
   ;;<Method name="getWebServerId">
   ;;<ClassMethod>1</ClassMethod>
   ;;<FormalSpec>name:%String</FormalSpec>
   ;;<ReturnType>%String</ReturnType>
   ;;<Implementation><![CDATA[
   ;; if $get(name)="" {
   ;;     do ##class(xobw.error.DialogError).forceError(186005_"^<empty string>")
   ;; }
   ;; quit +$order(^XOB(18.12,"B",name,0))
   ;;]]></Implementation>
   ;;</Method>
   ;;
   ;;<Method name="setUpHttpRequest">
   ;;<FormalSpec>httpRequest:%Net.HttpRequest</FormalSpec>
   ;;<Implementation><![CDATA[
   ;; if (..sslEnabled && ('$$SSLOK^XOBWENV())) {
   ;;  do ##class(xobw.error.DialogError).forceError(186002_"^"_..name_" (SSL is disabled on VMS)")
   ;; }
   ;; if (..sslEnabled) {
   ;;  set httpRequest.Https=1
   ;;  set httpRequest.SSLConfiguration=..sslConfiguration
   ;;  set httpRequest.Port=..sslPort
   ;;  set httpRequest.SSLCheckServerIdentity = 0
   ;; } else {
   ;;  set httpRequest.Port=..port
   ;; }
   ;; // common setting
   ;; set httpRequest.Server=..server
   ;; set httpRequest.Timeout=..defaultTimeout
   ;; quit
   ;;]]></Implementation>
   ;;</Method>
   ;;
   ;;<Method name="defaultTimeoutGet">
   ;;<ReturnType>%Integer</ReturnType>
   ;;<Implementation><![CDATA[ quit $select(i%defaultTimeout:i%defaultTimeout,1:30)
   ;;]]></Implementation>
   ;;</Method>
   ;;
   ;;<Storage name="WebServerStorage">
   ;;<Type>%CacheSQLStorage</Type>
   ;;<StreamLocation>^xobw.WebServerS</StreamLocation>
   ;;<ExtentSize>100000</ExtentSize>
   ;;<SQLMap name="MasterMap">
   ;;<Type>data</Type>
   ;;<Global>^XOB</Global>
   ;;<Subscript name="1">
   ;;<Expression>18.12</Expression>
   ;;</Subscript>
   ;;<Subscript name="2">
   ;;<Expression>{ien}</Expression>
   ;;<LoopInitValue>0</LoopInitValue>
   ;;<StopExpression>'+{L2}</StopExpression>
   ;;</Subscript>
   ;;<RowIdSpec name="1">
   ;;<Expression>{L2}</Expression>
   ;;<Field>ien</Field>
   ;;</RowIdSpec>
   ;;<Data name="defaultTimeout">
   ;;<Delimiter>"^"</Delimiter>
   ;;<Node>0</Node>
   ;;<Piece>7</Piece>
   ;;</Data>
   ;;<Data name="loginRequired">
   ;;<Delimiter>"^"</Delimiter>
   ;;<Node>1</Node>
   ;;<Piece>1</Piece>
   ;;</Data>
   ;;<Data name="name">
   ;;<Delimiter>"^"</Delimiter>
   ;;<Node>0</Node>
   ;;<Piece>1</Piece>
   ;;</Data>
   ;;<Data name="password">
   ;;<Node>300</Node>
   ;;</Data>
   ;;<Data name="port">
   ;;<Delimiter>"^"</Delimiter>
   ;;<Node>0</Node>
   ;;<Piece>3</Piece>
   ;;</Data>
   ;;<Data name="server">
   ;;<Delimiter>"^"</Delimiter>
   ;;<Node>0</Node>
   ;;<Piece>4</Piece>
   ;;</Data>
   ;;<Data name="sslConfiguration">
   ;;<Delimiter>"^"</Delimiter>
   ;;<Node>3</Node>
   ;;<Piece>2</Piece>
   ;;</Data>
   ;;<Data name="sslEnabled">
   ;;<Delimiter>"^"</Delimiter>
   ;;<Node>3</Node>
   ;;<Piece>1</Piece>
   ;;</Data>
   ;;<Data name="sslPort">
   ;;<Delimiter>"^"</Delimiter>
   ;;<Node>3</Node>
   ;;<Piece>3</Piece>
   ;;</Data>
   ;;<Data name="status">
   ;;<Delimiter>"^"</Delimiter>
   ;;<Node>0</Node>
   ;;<Piece>6</Piece>
   ;;</Data>
   ;;<Data name="userName">
   ;;<Node>200</Node>
   ;;</Data>
   ;;</SQLMap>
   ;;</Storage>
   ;;</Class>
   ;;</Export>
