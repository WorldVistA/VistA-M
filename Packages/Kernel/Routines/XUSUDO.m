XUSUDO ;SLC/JLA - Elevated privileges for P787 ; SEP 8, 2025@7:30
 ;;8.0;KERNEL;**787**;Jul 10, 1995;Build 73
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;
 ; Verify the TLS configuration with name ACONFNAME exists in the IRIS Security.SSLConfigs table.
 ;   If so, return the type of the SSLConfig (server or client).
 ;
 ; W $$HASTLSCONF^XUSUDO(ACONFNAME,.ACONFTYPE)
 ; W $$HASTLSCONF^XUSUDO("tls_encrypt_server",.ACONFTYPE)
 ;
HASTLSCONF(ACONFNAME,ACONFTYPE) ;
 N returnValue,status,properties
 ;
 ; Validate the ACONFNAME parameter
 I '$D(ACONFNAME) D  G HASTLSCDN
 . S returnValue="0^Undefined ACONFNAME parameter is required."
 ;
 S $ZTRAP="EREXITHTC"
 N $ROLES,$NAMESPACE ;Special case of NEW where $ROLES & $NAMESPACE will be reset on exiting
 D $SYSTEM.Security.AddRoles("XU") ; roles increased.
 S $NAMESPACE="%SYS"
 ;
 ; Verify the TLS configuration with name ACONFNAME exists 
 I '##class(Security.SSLConfigs).Exists(ACONFNAME) D  G HASTLSCDN
 . S returnValue="0^Configuration: """_ACONFNAME_""" does NOT exist"
 S returnValue="1^Configuration """_ACONFNAME_""" does exist"
 ;
 ; Get the TLS Configuration properties for ACONFNAME
 S status=##class(Security.SSLConfigs).Get(ACONFNAME,.properties)
 I $SYSTEM.Status.IsError(status) D  G HASTLSCDN
 . S returnValue="0^Get properties Failed: "_$System.Status.GetErrorText(status)
 ;
 ; Initialize the TLS Configuration type to "unknown"
 S ACONFTYPE="unknown"
 I $D(properties("Type")) D  G HASTLSCDN
 . I properties("Type")=1 S ACONFTYPE="server"
 . E  I properties("Type")=0 S ACONFTYPE="client"
 ;
EREXITHTC ;
 S returnValue="0^"_$ZERROR
 D APPERROR^%ZTER("TLS ERROR: "_returnValue)
 ;
HASTLSCDN ;
 Q returnValue
 ;
 ;
 ; Verify the TLS configuration with name ACONFNAME exists in the IRIS Security.SSLConfigs table and is of type client.
 ;
 ; W $$ISTLSCLIENTCONF^XUSUDO(ACONFNAME)
 ; W $$ISTLSCLIENTCONF^XUSUDO("tls_encrypt_server")
 ;
ISTLSCLIENTCONF(ACONFNAME) ;
 Q $$ISTLSCONFTYPE($G(ACONFNAME),0)
 ;
 ;
 ; Verify the TLS configuration with name ACONFNAME exists in the IRIS Security.SSLConfigs table and is of type server.
 ;
 ; W $$ISTLSSERVERCONF^XUSUDO(ACONFNAME)
 ; W $$ISTLSSERVERCONF^XUSUDO("tls_encrypt_server")
 ;
ISTLSSERVERCONF(ACONFNAME) ;
 Q $$ISTLSCONFTYPE($G(ACONFNAME),1)
 ;
 ;
 ; Verify the TLS configuration with name ACONFNAME exists in the IRIS Security.SSLConfigs table and is of type ACONFTYPE. 
 ; If ACONFTYPE is not passed in, just do the verification on ACONFNAME.
 ;
 ; W $$ISTLSCONFTYPE^XUSUDO(ACONFNAME,ACONFTYPE)
 ; W $$ISTLSCONFTYPE^XUSUDO("tls_encrypt_server",1)
 ;
ISTLSCONFTYPE(ACONFNAME,ACONFTYPE) ;
 N returnValue,cTypeString,status,properties
 ;
 ; Validate the ACONFNAME parameter
 I '$D(ACONFNAME) D  G ISTLSCDN
 . S returnValue="0^Undefined ACONFNAME parameter is required."
 ;
 S $ZTRAP="ERREXITITC"
 N $ROLES,$NAMESPACE ;Special case of NEW where $ROLES & $NAMESPACE will be reset on exiting
 D $SYSTEM.Security.AddRoles("XU") ; roles increased.
 S $NAMESPACE="%SYS"
 ;
 ; Verify the TLS configuration with name ACONFNAME exists
 I '##class(Security.SSLConfigs).Exists(ACONFNAME) D  G ISTLSCDN
 . S returnValue="0^TLS Configuration: """_ACONFNAME_""", does NOT exist"
 ;
 ; If no ACONFTYPE was passed in then no further checking
 I '$D(ACONFTYPE)  D  G ISTLSCDN
 . S returnValue="1^TLS Configuration: """_ACONFNAME_""", does exist"
 ;
 ; Verify that the ACONFTYPE is CLIENT or SERVER
 I ('(ACONFTYPE=0)&'(ACONFTYPE=1)) D  G ISTLSCDN
 . S returnValue="0^Invalid ACONFTYPE: """_configType_""", 0 for client or 1 for server"
 E  S cTypeString=$SELECT(ACONFTYPE=0:"client",ACONFTYPE=1:"server")
 ;
 ; Get the TLS Configuration properties for ACONFNAME
 S status=##class(Security.SSLConfigs).Get(ACONFNAME,.properties)
 I $SYSTEM.Status.IsError(status) D  G ISTLSCDN
 . S returnValue="0^Get properties Failed: "_$System.Status.GetErrorText(status)
 ;
 ; Verify that the Type property matches the ACONFTYPE passed in
 I $D(properties("Type")) D  G ISTLSCDN
 . I properties("Type")=ACONFTYPE D
 .. S returnValue="1^"_ACONFNAME_" is of type "_cTypeString
 . E  D
 .. S returnValue="0^"_ACONFNAME_" is NOT of type "_cTypeString
 E  D  G ISTLSCDN
 . S returnValue="0^"_ACONFNAME_" has no type property"
 ;
ERREXITITC ;
 S returnValue="0^"_$ZERROR
 D APPERROR^%ZTER("TLS ERROR: "_returnValue)
 ;
ISTLSCDN ;
 Q returnValue
 ;
 ;
 ; Read the TLS Configuration Names from the Security.SSLConfigs table and return them
 ; in the ACONFNAMES reference parameter.
 ;
 ; N ACONFNAMES S ACONFNAMES(0)=0
 ; W !,$$GETTLSCNS^XUSUDO(.ACONFNAMES),! ZW ACONFNAMES
 ;
GETTLSCNS(ACONFNAMES) ;
 N statement,query,status,resultset,returnValue,index,configName,configType
 ;
 ; Validate the ACONFNAME parameter
 I '$D(ACONFNAMES) D  G GETTLSCNDN
 . S returnValue="0^Undefined ACONFNAMES parameter is required to save results."
 ;
 S $ZTRAP="ERREXITGTC"
 N $ROLES,$NAMESPACE ;Special case of NEW where $ROLES & $NAMESPACE will be reset on exiting
 D $SYSTEM.Security.AddRoles("XU") ; roles increased.
 S $NAMESPACE="%SYS"
 ;
 ;Create a new Statement for the query
 S statement=##class(%SQL.Statement).%New()
 S query="select Name, Type from Security.SSLConfigs order by Name"
 S status=statement.%Prepare(query)
 I $SYSTEM.Status.IsError(status) D  G GETTLSCNDN
 . S returnValue="0^PrepareClassQuery Failed: "_$System.Status.GetErrorText(status)
 ;
 ; Execute the Statement
 S resultset=statement.%Execute()
 I (resultset.%SQLCODE'=0) D  G GETTLSCNDN
 . S returnValue="0^Execute Query Failed: "_resultset.%Message
 ;
 ; Iterate through the resultset
 S (index,ACONFNAMES(0))=0
 F  Q:'(resultset.%Next())  D
 . S index=index+1
 . S configName=resultset.%Get("Name")
 . S configType=resultset.%Get("Type")
 . S ACONFNAMES(index)=configName_"^"_configType
 S ACONFNAMES(0)=index
 ;
 ; If we made it here, we have success
 S returnValue="1^Success, "_index_" TLS configuration names read"
 G GETTLSCNDN
 ;
ERREXITGTC ;
 S returnValue="0^"_$ZERROR
 D APPERROR^%ZTER("TLS ERROR: "_returnValue)
 ;
GETTLSCNDN ;
 Q returnValue
 ;
 ;
 ; Read the TLS Client Configuration Names from the Security.SSLConfigs table and return them 
 ; in the ACONFNAMES reference parameter.
 ; 
 ; W $$GETTLSCLIENTCNS^XUSUDO(.ACONFNAMES),! ZW ACONFNAMES
 ;
GETTLSCLIENTCNS(ACONFNAMES) ;
 Q $$GETTLSCNSBYTYPE(0,.ACONFNAMES)
 ;
 ;
 ; Read the TLS Server Configuration Names from the Security.SSLConfigs table and return them 
 ; in the ACONFNAMES reference parameter.
 ;
 ; w $$GETTLSSERVERCNS^XUSUDO(.ACONFNAMES),! ZW ACONFNAMES
 ;
GETTLSSERVERCNS(ACONFNAMES) ;
 Q $$GETTLSCNSBYTYPE(1,.ACONFNAMES)
 ;
 ;
 ; Read the TLS Configurations from the Security.SSLConfigs table and 
 ; return the names that meet the type criteria in the ACONFNAMES reference parameter.
 ;   If the ACONFTYPE parameter is passed in, only return names with matching types. 
 ;   If no ACONFTYPE parameter is passed in, return all client and Server names.
 ;
 ; N ACONFNAMES S ACONFNAMES(0)=0
 ; W $$GETTLSCNSBYTYPE^XUSUDO( ,.ACONFNAMES ),! ZW ACONFNAMES
 ; W $$GETTLSCNSBYTYPE^XUSUDO( 0,.ACONFNAMES ),! ZW ACONFNAMES
 ; W $$GETTLSCNSBYTYPE^XUSUDO( 1,.ACONFNAMES ),! ZW ACONFNAMES
 ;
GETTLSCNSBYTYPE(ACONFTYPE,ACONFNAMES) ;
 N statement,query,status,resultset,cType,returnValue,index
 ;
 ; Validate the ACONFNAME parameter
 I '$D(ACONFNAMES) D  G GETTLSCNBTDN
 . S returnValue="0^Undefined ACONFNAMES parameter is required to save results."
 ;
 S $ZTRAP="ERREXITGTCBT"
 N $ROLES,$NAMESPACE ;Special case of NEW where $ROLES & $NAMESPACE will be reset on exiting
 D $SYSTEM.Security.AddRoles("XU") ; roles increased.
 S $NAMESPACE="%SYS"
 ;
 ;Create a new Statement for the query
 S statement=##class(%SQL.Statement).%New()
 ; Look for TLS client and server configurations, ACONFTYPE=0 for client, and ACONFTYPE=1 for server
 ; You must have select privileges on the SQL Table Security.SSLConfigs
 S query="select Name, Type from Security.SSLConfigs"
 ; If ACONFTYPE was passed in, use it in the query
 S cType=-1
 I $D(ACONFTYPE) D
 . S cType=+$g(ACONFTYPE)
 . I ((cType=0)!(cType=1)) D
 .. S query=query_" where type="_cType
 S status=statement.%Prepare(query)
 I $SYSTEM.Status.IsError(status) D  G GETTLSCNBTDN
 . S returnValue="0^PrepareClassQuery Failed: "_$System.Status.GetErrorText(status)
 ;
 ; Execute the Statement
 S resultset=statement.%Execute()
 I (resultset.%SQLCODE'=0) D  G GETTLSCNBTDN
 . S returnValue="0^Execute Query Failed: "_resultset.%Message
 ;
 ; Iterate through the resultset
 S (index,ACONFNAMES(0))=0
 F  Q:'(resultset.%Next())  D
 . S index=index+1
 . S ACONFNAMES(index)=resultset.%Get("Name")
 . I ((cType'=0)&(cType'=1)) D
 .. S ACONFNAMES(index)=ACONFNAMES(index)_"^"_resultset.%Get("Type")
 S ACONFNAMES(0)=index
 ;
 ; If we made it here, we have success
 S returnValue="1^Success, "_index_" TLS configuration names read"
 G GETTLSCNBTDN
 ;
ERREXITGTCBT ;
 S returnValue="0^"_$ZERROR
 D APPERROR^%ZTER("TLS ERROR: "_returnValue)
 ;
GETTLSCNBTDN ;
 Q returnValue
 ;
