MDCPSIGN ;HINES OIFO/BJ - CliO HL7 Handler/validator;23 Aug 2006
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ; This routine uses the following IAs:
 ;  # 2118       - %ZISTCP calls                Kernel                         (supported)
 ;  #10063       - %ZTLOAD calls                Kernel                         (supported)
 ;  # 2263       - XPAR calls                   Toolkit                        (supported)
 ;
 ;only call via line tags.
 Q
 ;
EN(MDCPIEN) ; Main entry point.
 ;
 ; This is meant to be called from the routine that changes  the STATUS field on
 ; the CLIO_HL7_LOG file.  The concept will be that this entry point is called, which will
 ; then notify a specific IP address and port that traffic is waiting.
 ;
 ; Note that there is also an assumption that the MD PARAMETERS parameter has had an "GATEWAY_SERVER_IP" instance
 ; and a "GATEWAY_NOTIFIER_PORT" instance added.
 ;
 L +^MDC("MDC GATEWAY"):0 E  Q  ; Can't get the lock, this means it's already running :)
 ; Queue this puppy up!
 S ZTRTN="ZTSK^MDCPSIGN"
 S ZTDESC="CliO Gateway Service Notifier"
 S ZTDTH=$H ; Start it NOW!
 S ZTIO=""
 D ^%ZTLOAD
 L -^MDC("MDC GATEWAY") ; Drop the lock so that the ZTSK dude can get it!
 Q
 ;
ZTSK ; This is the part that will notify the gateway and then monitor the progress
 N MDCPIP,MDCPPORT,MDCPIEN,POP
 S ZTREQ="@" ; Ensure that the task goes away
 Q:'$O(^MDC(704.002,"AS",2,0))  ; No data - See Ya!
 L +^MDC("MDC GATEWAY"):10 E  Q  ; Somebody beat us to it - See Ya!
 ;
 ; We have the lock, we have the data!
 ; We are in charge until we have no messages in
 ; status 2 or find that the messages aren't processing.
 ;
 H 30 ; Wait for anymore messages to be delivered
 ;
 S MDCPIEN=+$O(^MDC(704.002,"AS",2,0))
 S MDCPIP=$$GET^XPAR("SYS","MD PARAMETERS","GATEWAY_SERVER_IP")
 S MDCPPORT=$$GET^XPAR("SYS","MD PARAMETERS","GATEWAY_NOTIFY_PORT")
 I '$G(MDCPIP)!'$G(MDCPPORT) D ZTSKERR("Missing IP/Port Info") Q
 D CALL^%ZISTCP(MDCPIP,MDCPPORT,2) I POP D ZTSKERR("Unable to open the Gateway Port") Q
 U IO
 W "<?xml version=""1.0"" encoding=""utf-8""?>",!
 W "<message type=""hl7"">",!
 W "<id>",$G(MDCPIEN),!,"</id>",!
 W "<text/>",!
 W "</message>",!
 D CLOSE^%ZISTCP
 ;
 ; The gateway has been notified.
 ;
 ; We wait in 60 second chunks and then do the following:
 ;
 ; 1. Check to see if the top item (MDCPIEN) is still in status 2 - i.e. The gateway isn't running
 ;        if it has changed...
 ; 2. Get the top item in the index for the next loop/check or quit if it doesn't exist
 ;
 F  H 60 Q:$D(^MDC(704.002,"AS",2,MDCPIEN))  S MDCPIEN=+$O(^MDC(704.002,"AS",2,0)) Q:'MDCPIEN
 L -^MDC("MDC GATEWAY")
 Q
 ;
ZTSKERR(MDERR) ; Log an error and quit
 ; Need a logging method here
 N MDHL7,MDADMIN,MDMSG
 S MDHL7=$$GET^XPAR("SYS","MD PARAMETERS","NOTIFICATION_HL7_ERRORS","Q")
 S MDADMIN=$$GET^XPAR("SYS","MD PARAMETERS","NOTIFICATION_CPADMIN","Q")
 S MDMSG(0)="SUB:Error occurred in HL7 Processing"
 S MDMSG(1)="TEXT:Error Message: "_MDERR
 S MDMSG(2)="TO:"_MDHL7
 S MDMSG(3)="TO:"_MDADMIN
 D RPC^MDCLIO(.MDRET,"EXECUTE","SendEMailMessage",.MDMSG)
 L -^MDC("MDC GATEWAY")
 Q
 ;
