XUTLS ;SLC/JLA - TLS API's ; AUG 1, 2025@7:30
 ;;8.0;KERNEL;**787**;Jul 10, 1995;Build 73
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 ; External API's
 ;
 ; FileMan
GET1(AFILE,AIENS,AFIELD,AFLAGS,ATROOT,AMROOT) Q $$GET1^DIQ($G(AFILE),$G(AIENS),$G(AFIELD),$G(AFLAGS),$G(ATROOT),$G(AMROOT))
DT() Q $$DT^XLFDT()
NOW() Q $$NOW^XLFDT()
FMADD(AFMDATE,ADAYS) Q $$FMADD^XLFDT($G(AFMDATE),$G(ADAYS))
 ;
 ; KERNEL/TLS API's
UPSTR(ASTRING) Q $$UP^XLFSTR($G(ASTRING))
ISTLSSERVERCONF(ATLSCONFIGNAME) Q $$ISTLSSERVERCONF^XUSUDO($G(ATLSCONFIGNAME))
APPERROR(AMESSAGE) D APPERROR^%ZTER($G(AMESSAGE)) Q
 ;
 ;
 ; Get Kernel System Parameter "DEFAULT TLS SERVER CONFIG." (FILE=8989.3, FIELD=667)
 ;
 ; Returns
 ;   0^GKSPTLSCN^XUTLS^Error message
 ;   1^Default TLS Server Name
 ;
 ; KRNDEV>ZW ^DD(8989.3,667)
 ; ^DD(8989.3,667,0)="DEFAULT TLS SERVER CONFIG.^FJ30^^667;1^K:$L(X)>30!($L(X)<3) X"
 ; ^DD(8989.3,667,3)="Enter the number that corresponds to the TLS server configuration name."
 ; ^DD(8989.3,667,21,0)="^^2^2^3250627^"
 ; ^DD(8989.3,667,21,1,0)="This is the name of the default TLS server configuration used by Kernel "
 ; ^DD(8989.3,667,21,2,0)="for TLS communication. It should not be blank. "
 ; ^DD(8989.3,667,"DT")=3250627
 ;
 ; W $$GKSPTLSCN^XUTLS()    ;ZW ^XTV(8989.3,1,667)
 ;
GKSPTLSCN() ;
 N DTLSN,FILE,KSPIEN,TLSFIELD,EMA,RTNVAL
 S FILE=8989.3,KSPIEN="1,",TLSFIELD=667,EMA="ERRMSGA"
 S DTLSN=$$GET1(FILE,KSPIEN,TLSFIELD,,,EMA)
 I +$P($G(@EMA@("DIERR")),"^") D
 . S RTNVAL="0^GKSPTLSCN^XUTLS^"_@EMA@("DIERR",1,"TEXT",1)
 E  S RTNVAL="1^"_DTLSN
 Q RTNVAL
 ;
 ;
 ; Initialize the already open TCP principal device to use TLS communication
 ; following the RPC Broker expected return format
 ;
 ; Returns
 ;   0^INIT^XUTLS^Error: <message>
 ;   1^INIT^XUTLS^Use Command executed
 ;   Sets XWBTLS to 0 by default and to 1 when $$INIT^XUTLS("USE",$P) is successful
 ;
INITRPC(ARESULT) ;
 S XWBTLS=0
 S ARESULT=$$INIT^XUTLS("USE",$P)
 I ARESULT S XWBTLS=1
 Q
 ;
 ;
 ; Initialize the already open TCP principal device to USE TLS communication.
 ;
 ; Returns
 ;   0^INIT^XUTLS^Error: <message>
 ;   1^INIT^XUTLS^Use Command executed
 ;
INITUP ;
 N returnValue
 S returnValue=$$INIT("USE",$P)
 Q returnValue
 ;
 ;
 ; Initialize the principal device to OPEN TLS communication.
 ;
 ; Returns
 ;   0^INIT^XUTLS^Error: <message>
 ;   1^INIT^XUTLS^Open Command executed
 ;
INITOP ;
 N returnValue
 S returnValue=$$INIT("OPEN",$P)
 Q returnValue
 ;
 ;
 ; A server-side USE command for TLS communication.
 ;
 ;   USE an existing open device for TLS communication.
 ;
 ;   USE:   USE device:(::/TLS=TLSConfigName):"mnespace"
 ;
 ;   Packet mode is the default if no mode is specified. If stream mode is disabled, the mode defaults to packet mode.
 ;   In packet mode READ commands complete as soon as there is some data to return. 
 ; 
 ; Parameters
 ;   ADEVICENAME    - A string of the form |TCP| followed by some number of numeric digits.
 ;                    The numeric portion of the device name is called the device identifier.
 ;                    This device identifier must be a unique TCP port number.
 ;   ATLSCONFIGNAME - A TLS Configuration Name.
 ;
 ; Returns
 ;   0^INIT^XUTLS^Error: <message>
 ;   1^INIT^XUTLS^Use Command executed
 ;
 ; S ADEVICE="|TCP|1234"
 ; S ATLSCN="server_encrypt"
 ; W $$USE^XUTLS(ADEVICE,ATLSCN)
 ;
USE(ADEVICENAME,ATLSCONFIGNAME) ;
 N returnValue
 S returnValue=$$INIT("USE",ADEVICENAME,ATLSCONFIGNAME)
 Q returnValue
 ;
 ;
 ; A server-side TCP OPEN command for TLS communication.
 ;
 ;   OPEN establishes ownership of the specified device. The process retains ownership of the device until 
 ;        the process either terminates or releases the device with a subsequent CLOSE command. While a 
 ;        device is owned by a process, no other process can acquire or use the device.
 ;
 ;   OPEN device:(::/TLS=TLSConfigName):timeout:"mnespace"
 ;
 ;   Packet mode is the default if no mode is specified. If stream mode is disabled, the mode defaults to packet mode.
 ;   In packet mode READ commands complete as soon as there is some data to return. 
 ; 
 ; Parameters
 ;   ADEVICENAME    - A string of the form |TCP| followed by some number of numeric digits.
 ;                    The numeric portion of the device name is called the device identifier.
 ;                    This device identifier must be a unique TCP port number.
 ;   ATLSCONFIGNAME - A TLS Configuration Name.
 ;   ATIMEOUT       - A TCP OPEN command Timeout.
 ;
 ; Returns
 ;   0^INIT^XUTLS^Error: <message>
 ;   1^INIT^XUTLS^Open Command executed
 ;
 ; S ADEVICE="|TCP|1234"
 ; S ATLSCN="server_encrypt"
 ; S ATIMEOUT=5
 ; W $$OPEN^XUTLS(ADEVICE,ATLSCN,ATIMEOUT)
 ;
OPEN(ADEVICENAME,ATLSCONFIGNAME,ATIMEOUT) ;
 N returnValue
 S returnValue=$$INIT("OPEN",ADEVICENAME,ATLSCONFIGNAME,ATIMEOUT)
 Q returnValue
 ;
 ;
 ; Initialize a server-side OPEN or USE command for TLS communication.
 ;
 ;   OPEN:  OPEN device:(::/TLS=TLSConfigName):timeout:"mnespace"
 ;    USE:   USE device:(::/TLS=TLSConfigName):"mnespace"
 ;
 ; Parameters
 ;   ACOMMAND       - A OPEN or USE command
 ;   ADEVICENAME    - A string of the form |TCP| followed by some number of numeric digits.
 ;                    The numeric portion of the device name is called the device identifier.
 ;                    This device identifier must be a unique TCP port number.
 ;   ATLSCONFIGNAME - A TLS Configuration Name.
 ;   ATIMEOUT       - A TCP OPEN command Timeout.
 ;   ASCREEN        - A Screen for logging (ex: XUDEBUG>2).
 ;     If the ASCREEN parameter is NOT passed in, it defaults the local screen variable to 1. 
 ;   ALOGGER        - A Logger to call to log messages when ASCREEN evaluates to true (ex: "LOG^XUTLS").
 ;     If the ALOGGER parameter is NOT passed in, the local logger variable is set to the local logging funtion LOG
 ;     Any logger passed in assumed to be ready for logging and must have the logging message as the first parameter.
 ;
 ; Returns
 ;   0^INIT^XUTLS^Error: <message>
 ;   1^INIT^XUTLS^<TLSCommand>
 ;
 ; S ACOMMAND="OPEN", S ACOMMAND="USE"
 ; S ADEVICE="|TCP|1234",ATLSCN="server_encrypt",ATIMEOUT=5
 ; S ADEVICE="|TCP|1234",ATLSCN="tls_encrypt_server",ATIMEOUT=5
 ; S ASCREEN="XWBDEBUG>1",XWBDEBUG=2,ALOGGER="LOG^XWBTCPM"
 ; W $$INIT^XUTLS(ACOMMAND,ADEVICE,ATLSCN,ATIMEOUT,ASCREEN,ALOGGER)
 ;
INIT(ACOMMAND,ADEVICENAME,ATLSCONFIGNAME,ATIMEOUT,ASCREEN,ALOGGER) ;
 N command,deviceName,TLSConfigName,timeout,TLSCommand,defaultTimeout,screen,logger,validTLSConfig,returnValue,message
 S returnValue=1,validTLSConfig=1,defaultTimeout=10
 I '$D(VERBOSE) NEW VERBOSE S VERBOSE=0
 I VERBOSE W !,"INIT^XUTLS(""",$G(ACOMMAND),""",""",$G(ADEVICENAME),""",""",$G(ATLSCONFIGNAME),""",",$G(ATIMEOUT),",""",$G(ASCREEN),""",""",$G(ALOGGER),""") Called",!!
 ;
 ; Define logger
 S screen=1,logger="LOG(message)"
 S:$L($G(ASCREEN)) screen=$G(ASCREEN)
 I $L($G(ALOGGER)) S logger=$G(ALOGGER)_"(message)"
 E  D LOGSTART("XUTLS")
 ;
 ; Validate the COMMAND passed in
 S command=$G(ACOMMAND)
 I '$L(command) D  G TLSCOMDN
 . S message="INIT^XUTLS^Error: Undefined TLS command parameter, 'OPEN' or 'USE' only."
 . I @screen D @logger
 . S returnValue="0^"_message
 S command=$$UPSTR($E(command,1))
 I '((command="O")!(command="U")) D  G TLSCOMDN
 . S message="INIT^XUTLS^Error: Invalid TLS command parameter, 'OPEN' or 'USE' only."
 . I @screen D @logger
 . S returnValue="0^"_message
 I @screen S message="INIT^XUTLS^Command parameter: "_command D @logger
 ;
 ; Validate the DEVICENAME passed in
 S deviceName=$G(ADEVICENAME)
 I '$L(deviceName) D  G TLSCOMDN
 . S message="INIT^XUTLS^Error: Undefined devicename parameter."
 . I @screen D @logger
 . S returnValue="0^"_message
 I '(deviceName?1"|TCP|".(1.10N1"|")1.10N) D  G TLSCOMDN
 . S message="INIT^XUTLS^Error: Invalid devicename parameter, devicename must be of the form: '|TCP|PORT'."
 . I @screen D @logger
 . S returnValue="0^"_message
 I @screen S message="INIT^XUTLS^Device: "_deviceName D @logger
 ;
 ; If the TLSCONFIGNAME is not passed in, read the default TLS configuration name.
 S TLSConfigName=$G(ATLSCONFIGNAME)
 I '$L(TLSConfigName) D
 . S returnValue=$$GKSPTLSCN()
 . I (+returnValue) S TLSConfigName=$P(returnValue,"^",2)
 I '$L(TLSConfigName) G TLSCOMDN
 I @screen S message="INIT^XUTLS^ConfigName: "_TLSConfigName D @logger
 ;
 ; Validate the TLSConfigName
 S validTLSConfig=$$ISTLSSERVERCONF(TLSConfigName)
 I 'validTLSConfig D  G TLSCOMDN
 . S message="INIT^XUTLS^Error: Invalid TLS configuration name: '"_TLSConfigName_"'."
 . I @screen D @logger
 . S returnValue="0^"_message
 S TLSCommand=command_" """_deviceName_""":(::/TLS="""_TLSConfigName_""")"
 ;
 ; Add the timeout for an OPEN command
 I command="O" D
 . S timeout=+$G(ATIMEOUT)
 . I 'timeout D  ; If the timeout is not passed in, use defaultTimeout
 .. S timeout=defaultTimeout
 .. I VERBOSE W !,"Defaulting timeout: ",timeout,!
 . S TLSCommand=TLSCommand_":"_timeout
 I @screen S message="INIT^XUTLS^Full Command: "_TLSCommand D @logger
 ;
 ; Open/Use the device
 X TLSCommand
 ;O deviceName:(::/TLS=TLSConfigName):timeout ; THIS WORKS
 I '$T S returnValue="0^INIT^XUTLS^Error: "_TLSCommand_" Failed, $ZA^$ZB: "_$ZA_"^"_$ZB G TLSCOMDN
 S returnValue="1^INIT^XUTLS^"_TLSCommand
 ;
TLSCOMDN ;
 I VERBOSE W !,"INIT^XUTLS(""",$G(ACOMMAND),""",""",$G(ADEVICENAME),""",""",$G(ATLSCONFIGNAME),""",",$G(ATIMEOUT),",""",$G(ASCREEN),""",""",$G(ALOGGER),""") Exiting. Returning: ",returnValue,!!
 I 'returnValue D APPERROR($P(returnValue,"^",4))
 I @screen S message="INIT^XUTLS^Status: "_$E(returnValue,1) D @logger
 Q returnValue
 ;
 ;
 ; Setup the log, Clear the log location.
 ;
 ;   Note: purgeDate is hard coded to 7 days past the current Date.
 ;
 ; Parameters
 ;   AROUTINE - The name of the routine starting to log.
 ;   ADAYSUP  - The number of days until log is purged.
 ;
 ; D LOGSTART^XUTLS("XUTLS",5)
 ;
LOGSTART(AROUTINE,ADAYSUP) ;Clear the debug log
 N routine,currentDateTime,currentDate,daysUntilPurge,purgeDate
 S routine="UNKNOWN"
 I $L($G(AROUTINE)) S routine=$G(AROUTINE)
 S currentDateTime=$$NOW,currentDate=$P(currentDateTime,".",1)
 ;
 ; Initialize the logger for this session and date
 K ^XTMP("TLS "_$J_" "_currentDate)
 ;
 ; Set the create date and purge date for the logger
 S daysUntilPurge=7
 S:+($G(ADAYSUP))>0 daysUntilPurge=+($G(ADAYSUP))
 S purgeDate=$$FMADD(currentDate,daysUntilPurge)
 S ^XTMP("TLS "_$J_" "_currentDate,0)=purgeDate_"^"_currentDate_"^"_"TLS INIT logging"
 ;
 ; Initialize the message counter
 S ^XTMP("TLS "_$J_" "_currentDate,.1)=0
 D LOG("LOGSTART^XUTLS^Log start: "_routine)
 Q
 ;
 ;
 ; Log AMESSAGE to ^XTMP("TLS "_$J_" "_currentDate)
 ;
 ; Parameters
 ;   AMESSAGE - A TLS message to log.
 ;
 ; D LOG^XUTLS("A Test TLS Log Message")
 ;
 ; S A="TLS " F  S A=$O(^XTMP(A)) Q:A'["TLS"  ZW ^XTMP(A)
 ; S A="TLS "_$J F  S A=$O(^XTMP(A)) Q:A'[("TLS "_$J)  ZW ^XTMP(A)
 ; 
LOG(AMESSAGE) ;
 N count,currentDateTime,currentDate,currentTime
 Q:'$L($G(AMESSAGE))
 S currentDateTime=$$NOW,currentDate=$P(currentDateTime,".",1),currentTime=$P(currentDateTime,".",2)
 S count=1+$G(^XTMP("TLS "_$J_" "_currentDate,.1)),^(.1)=count,^(count)=$E(currentTime_"^"_AMESSAGE,1,255)
 Q
 ;
