IVMCQ2 ;ALB/KCL - API FOR FINANCIAL QUERIES (continued) ; 27-APR-95
 ;;2.0;INCOME VERIFICATION MATCH;**17**;21-OCT-94
 ;
 ;
MONITOR ; Description:  This entry point is used to monitor the IVM FINANCIAL
 ; QUERY LOG file and check for query transmissions that have not been
 ; responded to for more than 2 days.  If a query is > 2 days old, the
 ; corresponding entry in the IVM FINANCIAL QUERY LOG file will be
 ; updated/closed and a new financial query may be sent.
 ;
 N IVMQLOG,QRYIEN,%
 ;
 ; roll through query log entries with 'open' status
 S QRYIEN=0 F  S QRYIEN=$O(^IVM(301.62,"AC",0,QRYIEN)) Q:'QRYIEN  D
 .;
 .; obtain record from IVM FINANCIAL QUERY LOG
 .Q:'$$GET(+QRYIEN,.IVMQLOG)
 .;
 .; quit if query msg not old enough
 .Q:IVMQLOG("SENT")>$$FMADD^XLFDT(DT,-2)
 .;
 .; update/auto-close query in IVM FINANCIAL QUERY LOG file
 .D NOW^%DTC,UPD(IVMQLOG("DFN"),+QRYIEN,%,6,2)
 .;
 .; quit if new query is not needed
 .Q:'$$NEED^IVMCQ(IVMQLOG("DFN"))
 .;
 .; send new query
 .I $$QUERY^IVMCQ1(IVMQLOG("DFN"),IVMQLOG("TRANBY"),IVMQLOG("NOTIFY"),IVMQLOG("OPTION"))
 ;
 Q
 ;
 ;
FIND(DFN,IVMMSG,IVMRECD,IVMCR,IVMCS) ; Description: Used to find and update
 ; entry in IVM FINANCIAL QUERY LOG file.
 ;
 ;  Input:
 ;       DFN - ien of patient record in PATIENT file
 ;    IVMMSG - query message id
 ;   IVMRECD - date/time query response received
 ;     IVMCR - query closure reason code
 ;     IVMCS - query closure source (1|DCD -- 2|DHCP)
 ;
 ;  Output: none
 ;
 I '$G(DFN)!'$G(IVMCR)!'$G(IVMCS) G FINDQ
 N IVM,IVMD
 S IVM=0 F  S IVM=$O(^IVM(301.62,"B",DFN,IVM)) Q:'IVM  D
 .S IVMD=$G(^IVM(301.62,+IVM,0))
 .Q:$P(IVMD,"^",5)'=$G(IVMMSG)  ; message, query ID's not same
 .D UPD(DFN,+IVM,$G(IVMRECD),IVMCR,IVMCS)
FINDQ Q
 ;
 ;
UPD(DFN,IVMDA,IVMRECD,IVMCR,IVMCS) ; Description: Used to update record found in IVM FINANCIAL QUERY LOG file.
 ;
 ;  Input:
 ;       DFN - ien of patient record in PATIENT file
 ;    IVMMSG - query message id
 ;   IVMRECD - date/time query response received
 ;     IVMCR - query closure reason code
 ;     IVMCS - query closure source (1|DCD -- 2|DHCP)
 ;
 ;  Output: none
 ;
 I '$G(DFN)!'$G(IVMDA)!'$G(IVMCR)!'$G(IVMCS) G FINDQ
 N DA,DIE,DR,IVMCRP,IVMOPT
 S IVMCRP=$O(^IVM(301.94,"AC",IVMCR,0)) S:'IVMCRP IVMCRP=IVMCR
 S DIE="^IVM(301.62,",DA=IVMDA
 S DR=".03////1"_$S($G(IVMRECD):";.06////"_IVMRECD,1:"")
 S DR=DR_";1.01////"_IVMCRP_";1.02///NOW;1.03////"_IVMCS
 D ^DIE
 ;
 ; determine if query reply requires user notification
 I '$$NOTIFY(IVMDA)
 ;
UPDQ Q
 ;
 ;
FINDMSG(MSGID) ;
 ; Description: Used to find a record in the IVM FINANCIAL QUERY LOG
 ; file, given the unique message id assigned to the query by the
 ; HL7 package.
 ;
 ;  Input:
 ;   MSGID - The unique id assigned to the query by the HL7 package and
 ;           stored in the IVM FINANCIAL QUERY LOG as the HL7 MESSAGE
 ;           CONTROL ID field.
 ;
 ; Output:
 ;  Function Value - If successful, returns the ien of the record in
 ;   the file, otherwise returns 0 on failure.
 ;
 Q:($G(MSGID)="") 0
 Q +$O(^IVM(301.62,"C",MSGID,0))
 ;
 ;
GET(IEN,IVMQRY) ;
 ; Description: Used to obtain a record in the IVM FINANCIAL QUERY LOG
 ; file.  The values are returned in the IVMQRY() array.
 ;
 ;  Input:
 ;   IEN - internal entry number of a record in the IVM FINANCIAL QUERY LOG file.
 ;
 ; Output:
 ;  Function Value - 1 on success, 0 on failure.
 ;   IVMQRY() array, pass by reference.  Subscripts are:
 ;    "DFN"           - PATIENT field
 ;    "SENT"          - QUERY TRANS DT/TM field
 ;    "STATUS"        - QUERY STATUS field
 ;    "TRANBY"        - TRANSMITTED BY field
 ;    "MSGID"         - HL7 MESSAGE CONTROL ID field
 ;    "RESPONSE"      - QUERY RESPONSE REC'D DT/TM field
 ;    "OPTION"        - DHCP OPTION field
 ;    "NOTIFY"        - NOTIFY FLAG field
 ;    "CLOSURE RSN"   - CLOSURE REASON field
 ;    "CLOSURE"       - CLOSURE DT/TM field
 ;    "CLOSURE SRC"   - CLOSURE SOURCE field
 ;
 N IVMNODE
 K IVMQRY S IVMQRY=""
 Q:'$G(IEN) 0
 ;
 S IVMNODE=$G(^IVM(301.62,IEN,0))
 Q:IVMNODE="" 0
 ;
 S IVMQRY("DFN")=$P(IVMNODE,"^")
 S IVMQRY("SENT")=$P(IVMNODE,"^",2)
 S IVMQRY("STATUS")=$P(IVMNODE,"^",3)
 S IVMQRY("TRANBY")=$P(IVMNODE,"^",4)
 S IVMQRY("MSGID")=$P(IVMNODE,"^",5)
 S IVMQRY("RESPONSE")=$P(IVMNODE,"^",6)
 S IVMQRY("OPTION")=$P(IVMNODE,"^",7)
 S IVMQRY("NOTIFY")=$P(IVMNODE,"^",8)
 ;
 S IVMNODE=$G(^IVM(301.62,IEN,1))
 S IVMQRY("CLOSURE RSN")=$P(IVMNODE,"^")
 S IVMQRY("CLOSURE")=$P(IVMNODE,"^",2)
 S IVMQRY("CLOSURE SRC")=$P(IVMNODE,"^",3)
 ;
 Q 1
 ;
 ;
DELETE(IEN) ;
 ; Description: Delete record in the IVM FINANCIAL QUERY LOG file,
 ; given the internal entry number (IEN).
 ;
 ;  Input:
 ;   IEN - The internal entry number of the record.
 ;
 ; Output:
 ;  Function Value - 1 on success, 0 on failure.
 ;
 Q:'$G(IEN) 0
 N DIK,DA
 S DIK="^IVM(301.62,"
 S DA=IEN
 D ^DIK
 Q 1
 ;
 ;
LASTQRY(DFN) ; Description: Used to find the last financial query for a patient.
 ;
 ;  Input:
 ;   DFN - ien of patient record in PATIENT file
 ;
 ; Output:
 ;  Function Value - If successful, returns the ien of the record in
 ;   the file, otherwise returns 0 on failure.
 ;
 Q:'$G(DFN) 0
 N QRYDT
 S QRYDT=$O(^IVM(301.62,"ADT1",DFN,9999999.999999),-1)
 Q:'QRYDT 0
 Q $O(^IVM(301.62,"ADT1",DFN,QRYDT,0))
 ;
 ;
OPEN(DFN) ; Description: Used to determine if a patient has a financial query that is open (QUERY STATUS=TRANSMITTED).
 ;
 ;  Input:
 ;   DFN - ien of patient record in PATIENT file
 ;
 ; Output:
 ;  Function Value - returns 1 if open query, otherwise returns 0.
 ;
 N IVMQRY,IVMIEN,OPEN
 S OPEN=0
 S IVMIEN=$$LASTQRY($G(DFN))
 I IVMIEN,$$GET(IVMIEN,.IVMQRY) D
 .I 'IVMQRY("STATUS") S OPEN=1
 Q OPEN
 ;
SENT(DFN,IVMDT) ; Description: Used to determine if a query was sent for a patien on a specific date.
 ;
 ;  Input:
 ;     DFN - IEN of patient record in PATIENT file
 ;   IVMDT - (optional) Date/Time - default TODAY 
 ;
 ; Output:
 ;  Function Value: returns 1 if query sent on date, 0 otherwise.
 ;
 N IVMIDT,IVMIEN,IVMLDT,IVMQRY,SAMEDAY
 ;
 S SAMEDAY=0
 I '$G(DFN) G SENTQ
 S IVMIDT=$S($G(IVMDT)>0:IVMDT,1:DT) S:'$P(IVMIDT,".",2) IVMIDT=IVMIDT_.999999
 S IVMIEN=$$LASTQRY(DFN)
 I IVMIEN,$$GET(IVMIEN,.IVMQRY) D
 .I $P(IVMIDT,".")=$P(IVMQRY("SENT"),".") S SAMEDAY=1
 ;
SENTQ Q SAMEDAY
 ;
 ;
QRYQUE(DFN) ; Description: Queue off job to send a financial query to the
 ; the HEC. This does first check to see if a query is needed.
 ;
 ;  Input:
 ;   DFN - ien of patient record in PATIENT file
 ;
 ; Output: none
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTDESC="IVM Financial Query" ; task description
 S ZTDTH=$H ; task start time
 S ZTRTN="QUERY^IVMCQ2(DFN)" ; entry point of tasked routine
 S ZTSAVE("DFN")="" ; input parameters
 S ZTIO="" ; i/o device - (not needed)
 D ^%ZTLOAD
 Q
 ;
QRYQUE2(DFN,DUZ,NOTIFY,OPTION) ; Description: Queue off job to send a financial query to the
 ; the HEC.  This version does NOT first check to see if a query is
 ; needed, but does check to see if a query is currently open.
 ;
 ;  Input:
 ;   DFN - ien of patient record in PATIENT file
 ;   DUZ (optional)
 ;   NOTIFY - (optional) 1 if the user requested notification when reply received
 ;   OPTION - (optional) the option where the query was requested
 ;
 ; Output: none
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTDESC="IVM Financial Query" ; task description
 S ZTDTH=$H ; task start time
 S ZTRTN="QUERY2^IVMCQ1(DFN,$G(DUZ),$G(NOTIFY),$G(OPTION),,1)" ; entry point of tasked routine
 S ZTSAVE("DFN")="",ZTSAVE("DUZ")="",ZTSAVE("NOTIFY")="",ZTSAVE("OPTION")=""
 S ZTIO="" ; i/o device - (not needed)
 D ^%ZTLOAD
 Q
 ;
QUERY(DFN) ; Description: Determine if a financial query should be sent to the HEC.
 ;
 ;  Input: 
 ;   DFN - ien of patient record in PATIENT file
 ;
 ; Output: none
 ;
 ;
 I '$G(DFN) Q
 I '$$NEED^IVMCQ(DFN,0) Q
 ;
 ; send query for patient
 I $$QUERY^IVMCQ1(DFN)
 ;
 Q
 ;
 ;
NOTIFY(QRYIEN) ; Description: Send notification message of reply received for financial query.
 ;
 ;  Input:
 ;   QRYIEN - ien of record in IVM FINANCIAL QUERY LOG file
 ;
 ; Output:
 ;  Function Value: 1 on success, 0 on failure
 ;
 N DIFROM,IVMTEXT,PATIENT,QARRAY,SUCCESS,XMDUZ,XMTEXT,XMSUB,XMY,XMZ
 ;
 S SUCCESS=0
 ;
 I '$G(QRYIEN) G MSGQ
 ;
 ; obtain record from IVM FINANCIAL QUERY LOG
 I '$$GET(QRYIEN,.QARRAY) G MSGQ
 ;
 ; check NOTIFY FLAG
 I '$G(QARRAY("NOTIFY")) G MSGQ
 ;
 ; obtain patient identifiers
 I '$$GETPAT^IVMUFNC($G(QARRAY("DFN")),.PATIENT) G MSGQ
 ;
 ; build notification message
 S XMDUZ="IVM PACKAGE"
 S XMY(QARRAY("TRANBY")_"@"_$G(^XMB("NETNAME")))=""
 S XMSUB="Financial Query Reply for: "_PATIENT("NAME")_" ("_PATIENT("SSN")_")"
 S XMTEXT="IVMTEXT("
 S IVMTEXT(1)="A reply to the financial query that you sent has been received."
 S IVMTEXT(2)=" "
 S IVMTEXT(3)="                 Patient Name: "_PATIENT("NAME")
 S IVMTEXT(4)="                  Patient SSN: "_PATIENT("SSN")
 S IVMTEXT(5)=" "
 S IVMTEXT(6)=" Query Transmission Date/Time: "_$$EXTERNAL^DILFD(301.62,.02,"F",QARRAY("SENT"))
 S IVMTEXT(7)="     Query Response Date/Time: "_$$EXTERNAL^DILFD(301.62,.06,"F",QARRAY("RESPONSE"))
 S IVMTEXT(8)=" "
 S IVMTEXT(9)="               Closure Reason: "_$$EXTERNAL^DILFD(301.62,1.01,"F",QARRAY("CLOSURE RSN"))
 S IVMTEXT(10)="               Closure Source: "_$$EXTERNAL^DILFD(301.62,1.03,"F",QARRAY("CLOSURE SRC"))
 ;
 D ^XMD
 ;
 S SUCCESS=1
 ;
MSGQ Q SUCCESS
