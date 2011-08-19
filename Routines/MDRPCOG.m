MDRPCOG ; HOIFO/DP - CP Gateway ; [01-09-2003 15:20]
 ;;1.0;CLINICAL PROCEDURES;**6**;Apr 01, 2004;Build 102
 ; Description:
 ; This is the main routine that manages the CLINICAL PROCEDURES Gateway functions.  
 ; Access to these functions is controlled via the MD GATEWAY RPC.
 ;
 ; Integration Agreements:
 ; IA# 10097 [Supported] %ZOSV calls
 ; IA# 10103 [Supported] Calls to XLFDT
 ; IA# 2263 [Supported] Calls to XPAR
 ;
CLEANUP ; [Procedure] Cleanup a past results report
 F X=0:0 S X=$O(^MDD(703.1,DATA,.1,X)) Q:'X  D
 .S:$G(^MDD(703.1,DATA,.1,X,.1))]"" MDFDA(703.11,X_","_DATA_",",.1)="@"
 .S:$O(^MDD(703.1,DATA,.1,X,.2,0)) MDFDA(703.11,X_","_DATA_",",.2)="@"
 D:$D(MDFDA) FILE^DIE("K","MDFDA","MDERR")
 I $D(MDERR) D ERROR^MDRPCU(RESULTS,.MDERR) Q
 ; Manual cleanup of the empty UNC nodes and WP root
 F X=0:0 S X=$O(^MDD(703.1,DATA,.1,X)) Q:'X  D
 .K ^MDD(703.1,DATA,.1,X,.1)
 .K ^MDD(703.1,DATA,.1,X,.2)
 S @RESULTS@(0)="1^Item purged"
 Q
 ;
DONE ; [Procedure] Done processing, Mark study status
 S MDFDA(703.1,+DATA_",",.09)=$G(P1,"U")
 D FILE^DIE("","MDFDA")
 Q
 ;
GETATT ; [Procedure] Get attachments for study
 F X=0:0 S X=$O(^MDD(703.1,+DATA,.1,X)) Q:'X  D
 .S Y=+$O(@RESULTS@(""),-1)+1
 .S @RESULTS@(Y)="703.11;"_X_U_^MDD(703.1,+DATA,.1,X,0)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
GETOLD ; [Procedure] Returns old results by date
 ; Variables:
 ;  LOGDATE: [Private] Loop variable
 ;  STOPDATE: [Private] Date to stop retrieving entries
 ;
 ; New private variables
 NEW LOGDATE,STOPDATE,MDX
 S LOGDATE=+DATA,STOPDATE=+$P(DATA,U,2)+.2359
 F  S LOGDATE=$O(^MDD(703.1,"ADTP",LOGDATE)) W !,"-->",LOGDATE Q:'LOGDATE!(LOGDATE>STOPDATE)  D  Q:Y>50
 .F MDX=0:0 S MDX=$O(^MDD(703.1,"ADTP",LOGDATE,MDX)) Q:'MDX  D
 ..I '$$CHECK(MDX) Q
 ..S Y=$O(@RESULTS@(""),-1)+1
 ..S @RESULTS@(Y)="703.1;"_MDX_U_$G(^MDD(703.1,MDX,0))
 S:'LOGDATE!(LOGDATE>STOPDATE) LOGDATE=STOPDATE
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)_U_LOGDATE_U_$$FMTE^XLFDT(LOGDATE)
 Q
 ;
GETPAR ; [Procedure] Get a parameter value for an RPC Call
 S @RESULTS@(0)=$$PARVAL(DATA)
 Q
 ;
GETTXT ; [Procedure] Get attachment text for processing
 N X,STUDY,ATT
 S X=0,STUDY=$P(DATA,",",2),ATT=+DATA
 I '$O(^MDD(703.1,STUDY,.1,ATT,.2,0)) S @RESULTS@(0)="-1^No Data" Q
 F  S X=$O(^MDD(703.1,STUDY,.1,ATT,.2,X)) Q:'X  S @RESULTS@(X)=^(X,0)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
NEXT ; [Procedure] Get the next study to process
 S Y=+$O(^MDD(703.1,"ASTATUS","P",$G(DATA)))
 S @RESULTS@(0)=$S($D(^MDD(703.1,Y,0)):"703.1;"_Y_U_^MDD(703.1,Y,0),1:0)
 Q
 ;
PARVAL(INSTANCE) ; [Procedure] Extrinsic get of parameter values
 ; Input parameters
 ;  1. INSTANCE [Literal/Required] XPAR instance
 ;
 Q $$GET^XPAR("SYS","MD GATEWAY",INSTANCE)
 ;
POLL ; [Procedure] Returns server time and flag for studies to process
 I $$PARVAL("Shutdown Flag")]"" D  Q
 .S @RESULTS@(0)="-1^SHUTDOWN"
 .D SETPAR("Shutdown Flag","")
 S @RESULTS@(0)=$$FMTE^XLFDT($$NOW^XLFDT)
 S @RESULTS@(1)=$D(^MDD(703.1,"ASTATUS","P"))
 Q
 ;
POLLER(RESULTS) ; [Procedure] Non-Disk activity poller
 ; With the exception of a shutdown request pending, this stand alone RPC will operate 
 ; without creating any disk activity and not crash during backup operations on the main 
 ; VistA server.
 ;
 ; Input parameters
 ;  1. RESULTS [Reference/Required] 
 ;
 I $$PARVAL("Shutdown Flag")]"" D  Q
 .S RESULTS(0)="-1^SHUTDOWN"
 .D SETPAR("Shutdown Flag","")
 S RESULTS(0)=$$FMTE^XLFDT($$NOW^XLFDT)
 S RESULTS(1)=$D(^MDD(703.1,"ASTATUS","P"))
 Q
 ;
RPC(RESULTS,OPTION,DATA,P1) ; [Procedure] 
 ; Input parameters
 ;  1. RESULTS [Literal/Required] RPC Return Array
 ;  2. OPTION [Literal/Required] Gateway Option to execute
 ;  3. DATA [Literal/Required] Other information
 ;  4. P1 [Literal/Required] Overflow variable
 ;
 ; Variables:
 ;  MDENV: [Private] Server environment variable
 ;  MDERR: [Private] Fileman return array
 ;  MDFDA: [Private] Fileman FDA
 ;
 ; New private variables
 NEW MDENV,MDERR,MDFDA
 S RESULTS=$NA(^TMP("MDRPCOB",$J)) K @RESULTS
 D @OPTION
 Q
 ;
RUNNING ; [Procedure] Returns 0/1 and message on running status
 ; Note: If lock CAN be obtained, then gateway is NOT running
 L +^MDD("CPGATEWAY"):1 E  S @RESULTS@(0)="1^RUNNING" Q
 L -(^MDD("CPGATEWAY")) S @RESULTS@(0)="0^NOT RUNNING"
 Q
 ;
SETFILE ; [Procedure] Set filename of new attachment
 S MDFDA(703.11,$P(DATA,U,1),.02)=$P(DATA,U,2)
 D FILE^DIE("","MDFDA")
 Q
 ;
SETPAR(INSTANCE,VALUE) ; [Procedure] Set value into XPAR parameter
 ; Input parameters
 ;  1. INSTANCE [Literal/Required] Parameter Instance
 ;  2. VALUE [Literal/Required] Parameter Value
 ;
 D EN^XPAR("SYS","MD GATEWAY",INSTANCE,VALUE)
 Q
 ;
START ; [Procedure] Can we begin?
 ; Ensure only one Gateway per system by locking the phantom global node
 L +^MDD("CPGATEWAY"):1
 I '$T D STATUS S @RESULTS@(0)="-1^FAIL" Q
 ; Clear all process settings
 D NDEL^XPAR("SYS","MD GATEWAY")
 S DATA=$G(DATA,"30^1000") ; Default poll interval and log entries
 D SETPAR("Polling Interval",+$P(DATA,U,1))
 D SETPAR("Maximum Log Entries",+$P(DATA,U,2))
 D SETPAR("Job ID",$J)
 D SETPAR("Started At",$$FMTE^XLFDT($$NOW^XLFDT))
 D SETPAR("Started By",$$GET1^DIQ(200,DUZ_",",.01))
 D GETENV^%ZOSV S MDENV=Y
 D SETPAR("UCI",$P(MDENV,U,1))
 D SETPAR("Volume",$P(MDENV,U,2))
 D SETPAR("Node",$P(MDENV,U,3))
 D SETNM^%ZOSV("CP Gateway")
 S @RESULTS@(0)="1^OK"
 Q
 ;
STATUS ; [Procedure] Return status of BP
 D GETLST^XPAR(.MDRET,"SYS","MD GATEWAY","Q")
 F X=0:0 S X=$O(MDRET(X)) Q:'X  S @RESULTS@(X)=MDRET(X)
 Q
 ;
STOP ; [Procedure] Flag client to stop via cal to POLL
 D SETPAR("Shutdown Flag","Yes")
 Q
 ;
XFERDIR ; [Procedure] Return Imaging xfer directory
 S @RESULTS@(0)=$$GET^XPAR("SYS","MD IMAGING XFER")
 Q
 ;
CHECK(MDRI) ; Check if Upload Value and Upload Text has already been purged.
 N MDFLG S MDFLG=0
 F X=0:0 S X=$O(^MDD(703.1,MDRI,.1,X)) Q:'X  D  Q:MDFLG
 .S:$G(^MDD(703.1,MDRI,.1,X,.1))]"" MDFLG=1
 .S:$O(^MDD(703.1,MDRI,.1,X,.2,0)) MDFLG=1
 Q MDFLG
