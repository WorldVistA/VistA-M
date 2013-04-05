ZISPQ ;IRMFO-ALB/CJM - DEVICE HANDLER PRINT QUEUES;10/05/2011 ;08/01/2012
 ;;8.0;KERNEL;**585**;JUL 10, 9;Build 22
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
QEXIST(DEVICE) ;
 ;Check if print queue exists for this device on this system
 ;
 ;Input:
 ;  DEVICE = ien of device
 ;Output:
 ;  Function returns 1 if queue associated with DEVICE exists, 0 otherwise
 ;
 N OS,PQ
 S PQ=$$GETPQ(DEVICE)
 Q:PQ="" 0
 S OS=$$OS^%ZOSV()
 I OS["UNIX" Q $$LQEXIST(PQ)
 E  I OS["VMS" Q $$VQEXIST(PQ)
 Q 0
 ;
OPEN ;called from PQ^%ZIS6
 ;
 ;override %ZIS input parameters and device file parameters for printer queues
 ;
 W:'$D(IOP) !
 D:'POP&(%ZISB&(%ZIS'["T"))
 .K %ZIS("IOPAR"),%ZIS("IOUPAR")
 .S %ZISTO=2
 .S $P(%ZTIME,"^",3)="n"
 .I $$OS^%ZOSV()["UNIX" D
 ..S %ZISOPAR="(""NWU"":/TER=$CHAR(13))"
 .E  D
 ..S %ZISOPAR="(""NWS"")"
 .S %ZISUPAR=""
 .S IO=$$NEWJOB(%E,+$G(DUZ)) ;get a unique name for host file
 .Q:IO=""
 .I $$FEXIST(IO) D FDELETE(IO) ;make sure the file does not exist - it should not!
 .S %ZISLOCK=$NA(^%ZIS("lock",IO))
 .D O^%ZIS4
 .I POP D STATUS(IO,"QE")
 ;
 Q
 ;
DIR(CODE) ;get directory for printer queues, a subdirectory of host file directory
 ;Input - CODE (optional) 1 for primary, 2 for secondary.  If not passed, the directory of the current process is assumed
 N DIR
 I '$G(CODE) S CODE=$$PRI^%ZOSV
 S DIR=$$CHKNM^%ZISF($P($G(^XTV(8989.3,1,"DEV")),"^",CODE))
 I $$OS^%ZOSV()["VMS" D
 .S DIR=$P(DIR,"]")_".print_queues]"
 E  D
 .I $E(DIR,$L(DIR))'="/" S DIR=DIR_"/"
 .S DIR=DIR_"print_queues/"
 Q DIR
 ;
NEWJOB(DEVICE,DUZ) ;
 ;Creates a new entry in the PRINT QUEUE JOB file and creates a unique
 ;name for the print file.
 ;
 ;Input:
 ;  DEVICE - ien of the device
 ;  DUZ
 ;Output:
 ;  Function value - returns the full path name of the host file for the print queue.
 ;
 N I,DATA,DIR,PQ,JOB
 I '$G(DEVICE) S POP=1 Q ""
 ;
 ;Get the name of the print queue
 S PQ=$$GETPQ(DEVICE)
 I PQ="" S POP=1 Q ""
 ;
 S DATA(.01)=DEVICE,DATA(.02)=$$NOW^XLFDT,DATA(.04)=DUZ,DATA(.05)=PQ,DATA(.09)=$$PRI^%ZOSV
 S JOB=$$ADD^ZISFM(3.52,,.DATA,.ERROR)
 Q:'JOB ""
 ;
 ;add the status
 S DATA(.07)="O"
 ;add the filename -including the UCI and ien guarantees it to be unique
 S DATA(.06)="PQ$"_$$UCI_"_"_JOB_".TXT"
 D UPD^ZISFM(3.52,JOB,.DATA,.ERROR)
 Q $$DIR_DATA(.06)
 ;
STATUS(IO,STATUS,JOBID) ;Set the status of the PRINT QUEUE JOB
 ;Input:
 ;  IO - file name, may include or not include the path, the ien is parsed out.
 ;  STATUS (optional) status code. If ="" returns the current status.
 ;  JOBID (optional) The job id.  Should be passed in if the status is 'Q'ueued
 ;Output:
 ;  function returns the current status
 ;
 N IEN,DATA,ERROR
 Q:'$L($G(IO)) ""
 S IEN=$$GETIEN(IO)
 Q:IEN="" ""
 I $G(STATUS)="" Q $P($G(^%ZIS(3.52,IEN,0)),"^",7)
 I $L($G(JOBID)) S DATA(.08)=JOBID
 S DATA(.07)=STATUS
 I $E(STATUS,1)="Q" S DATA(.03)=$$NOW^XLFDT
 I STATUS="C",$P($G(^%ZIS(3.52,IEN,0)),"^",7)="C" S DATA(.03)=$$NOW^XLFDT
 D UPD^ZISFM(3.52,IEN,.DATA,.ERROR)
 Q STATUS
 ;
CLOSE(IO) ;Called from ^%ZISC. Closes the host file and passes it to the print queue
 ;
 N JOBID,STATUS
 ;
 S STATUS=$$STATUS(IO)
 ;
 ;queued tasks are calling CLOSE logic twice, check for that
 I (STATUS="Q")!(STATUS="P")!(STATUS="D") Q
 ;
 I '$$PRINT(IO,.JOBID) S STATUS="QE"
 E  S STATUS="Q"
 D STATUS(IO,STATUS,$G(JOBID))
 Q
 ;
VQEXIST(Q) ; Tests if queue exists on this node - VMS
 ;Function returns 1 if the queue exists, 0 if it doesn't
 ;
 N CMD,RET
 S CMD="PIPE Q = F$GETQUI(""DISPLAY_QUEUE"",""QUEUE_NAME"","""_Q_""")"
 S CMD=CMD_" ; IF F$LENGTH(Q) .EQ. 0 THEN DEFINE/JOB ZIS$VAL 0 ; IF F$LENGTH(Q) .GT. 0 THEN DEFINE/JOB ZIS$VAL 1 "
 I $ZF(-1,CMD)
 S RET=$ZF("TRNLNM","ZIS$VAL","LNM$JOB")
 I $ZF(-1,"DEASSIGN/JOB ZIS$VAL")
 Q +$G(RET)
 ;
LQEXIST(Q) ; Tests if queue exists - LINUX
 N EOF,CMD,RESULTS,RET
 S EOF=$ZU(68,40,1)
 S CMD="lpstat -p "_$$REPLACE(Q,"$","'$'")_" 2> /dev/null"
 O CMD:"qr" U CMD R RESULTS:2 C CMD
 I RESULTS]"" S RET=1
 S EOF=$ZU(68,40,EOF)
 Q +$G(RET)
 ;
PRINT(FILE,JOBID) ;Submits the file to be printed.
 ;Input:
 ;   FILE - full file name, including path
 ;Output:
 ;   function value - returns 1 on success, 0 on failure
 ;   JOBID (pass by reference) on sucess may return the job id for the print job (not guaranteed)
 N OS,JOB
 S JOB=FILE
 Q:'$$GETJOB(.JOB) 0
 S OS=$$OS^%ZOSV()
 I OS["UNIX" Q $$LPRINT(FILE,JOB("QUEUE"),.JOBID)
 I OS["VMS" Q $$VPRINT(FILE,JOB("QUEUE"),.JOBID)
 Q 0
 ;
LPRINT(FILE,Q,JOBID) ;
 N CMD,RESULT,EOF,RET
 S RET=0,JOBID=""
 S CMD="lpr -r -P"_Q_" "_FILE_" && echo success && lpq -P "_Q
 S CMD=$$REPLACE(CMD,"$","'$'")
 S EOF=$ZU(68,40,1)
 O CMD:"QR":5 Q:'$T  U CMD D  C CMD
 .R RESULT:5 Q:'$T  Q:RESULT=""
 .I RESULT["success" D
 ..N NAME
 ..S NAME="PQ$JOB_"_$P(FILE,"PQ$JOB_",2)
 ..S RET=1
 ..F  R RESULT:5 Q:'$T  Q:RESULT=""  I RESULT[NAME S JOBID=$$INVERT^XLFSTR($P($$INVERT^XLFSTR($$TRIM^XLFSTR($P(RESULT,NAME),"R"))," ")) Q
 S EOF=$ZU(68,40,EOF)
 Q RET
 ;
VPRINT(FILE,Q,JOBID) ; VMS Print
 ;First determine the /PASS or /NOPASS parameter
 N CMD,PASS,NOPASS,RET
 S RET=0,JOBID=""
 S CMD="PIPE DESCR = F$GETQUI(""DISPLAY_QUEUE"",""QUEUE_DESCRIPTION"","""_Q_""")"
 S CMD=CMD_" ; IF F$LOCATE( ""/NOPASS"",DESCR) .LT. F$LENGTH(DESCR) THEN DEFINE/JOB ZIS$VAL 1 "
 I $ZF(-1,CMD)
 ;
 S NOPASS=+$ZF("TRNLNM","ZIS$VAL","LNM$JOB")
 I $ZF(-1,"DEASSIGN/JOB/NOLOG ZIS$VAL")
 S PASS=$S(NOPASS:"/NOPASS",1:"/PASS")
 ;
 ;Build the complete VMS PRINT command
 S CMD="PIPE PRINT/DELETE"_PASS_"/NOIDENTITY/QUEUE="""_Q_""" "_FILE_" /PARAM=NOFLAG ; IF $STATUS THEN DEFINE/JOB ZIS$VAL &$ENTRY "
 ;
 I $ZF(-1,CMD)=1 D
 .S JOBID=$ZF("TRNLNM","ZIS$VAL","LNM$JOB")
 I JOBID'="",$ZF(-1,"DEASSIGN/JOB/NOLOG ZIS$VAL")
 Q JOBID'=""
 ;
GETPQ(DEVICE) ;
 ;Given the ien of the DEVICE, it returns the name of the print queue,
 ;parsed from the $I or SECONDARY $I field of the DEVICE
 ;
 ;Returns "" on failure
 ;
 Q:'$G(DEVICE) ""
 N PQ
 ;
 ;get $I and parse out the name of the print queue
 S:$$PRI^%ZOSV=2 PQ=$P($G(^%ZIS(1,DEVICE,2)),"^")
 S:$G(PQ)="" PQ=$P($G(^%ZIS(1,DEVICE,0)),"^",2)
 ;
 ;$I field might look like this:  DEV:[TEMP]HF_QUEUE.TXT -  parse out thequeue name
 I PQ[":" S PQ=$P(PQ,":",2)
 S PQ=$P(PQ,".",1)
 I PQ["]" S PQ=$P(PQ,"]",2)
 ;
 Q PQ
 ;
REPLACE(STRING,SUB1,SUB2) ;
 N REPLACE
 S REPLACE(SUB1)=SUB2
 Q $$REPLACE^XLFSTR(STRING,.REPLACE)
 ;
ID ;identifier logic on the PRINT QUEUES JOB file
 N ID,NAME,DATE
 S NAME=$P(^(0),"^",4)
 S DATE=$P(^(0),"^",2)
 I NAME S NAME=$$LJ^XLFSTR($P($G(^VA(200,NAME,0)),"^"),18)_" "
 I DATE S DATE=$$FMTE^XLFDT(DATE)
 S ID=$E(NAME,1,20)_" "_DATE
 D EN^DDIOL(ID,"")
 Q
 ;
PURGE ;Purge of PRINT JOB QUEUES (file #3.52) and old host files that were queued.  Also updates status on a regular basis.
 ;
 N DEVICE,STATUS,TIME,IEN,DIR,T1,T2,T3,NOW
 S NOW=$$NOW^XLFDT
 S ZTREQ=""
 ;
 ;set time parameters for this purge
 S T1=$$FMADD^XLFDT(NOW,,-1) ;10 minutes ago
 S T2=$$FMADD^XLFDT(NOW,-1) ;24 hours ago
 S T3=$$FMADD^XLFDT(NOW,-2) ;48 hours ago
 ;
 S DIR=$$PRI^%ZOSV
 ;
 L +%ZIS(3.52,"PURGE JOB"_DIR):0 Q:'$T  ;allow only one purge at a time on each system (primary, secondary)
 ;
 ;look for queued jobs older than 10 minutes whose status can be changed to 'PRINTED & DELETED'
 S STATUS="Q"
 S DEVICE=0
 F  S DEVICE=$O(^%ZIS(3.52,"E",DIR,DEVICE)) Q:'DEVICE  D
 .S TIME=T2 F  S TIME=$O(^%ZIS(3.52,"E",DIR,DEVICE,STATUS,TIME)) Q:'TIME  Q:TIME>T1  D
 ..S IEN=0 F  S IEN=$O(^%ZIS(3.52,"E",DIR,DEVICE,STATUS,TIME,IEN)) Q:'IEN  D
 ...N JOB S JOB=IEN
 ...I '$$GETJOB(.JOB) Q
 ...;if the host file is gone, it has been printed
 ...I $$FEXIST(JOB("FILE")) D STATUS(JOB("FILE"),"D")
 ;
 ;delete host files older than 24 hours
 S DEVICE=0
 F  S DEVICE=$O(^%ZIS(3.52,"E",DIR,DEVICE)) Q:'DEVICE  D
 .Q:$$STOPPED(DEVICE)
 .S STATUS=""
 .F  S STATUS=$O(^%ZIS(3.52,"E",DIR,DEVICE,STATUS)) Q:STATUS=""  I STATUS'="P",STATUS'="D"  D
 ..S TIME=0
 ..F  S TIME=$O(^%ZIS(3.52,"E",DIR,DEVICE,STATUS,TIME)) Q:'TIME  Q:TIME>T2  D
 ...S IEN=0 F  S IEN=$O(^%ZIS(3.52,"E",DIR,DEVICE,STATUS,TIME,IEN)) Q:'IEN  D
 ....N JOB S JOB=IEN
 ....I '$$GETJOB(.JOB) K ^%ZIS(3.52,"E",DIR,DEVICE,STATUS,TIME,IEN) Q
 ....;delete the host file if it exists and change the status
 ....I $$FEXIST(JOB("FILE")) D FDELETE(JOB("FILE")),STATUS(JOB("FILE"),"D")
 ;
 ;delete jobs (file #3.52) older than 48 hours
 S DEVICE=0
 F  S DEVICE=$O(^%ZIS(3.52,"E",DIR,DEVICE)) Q:'DEVICE  D
 .Q:$$STOPPED(DEVICE)
 .S STATUS="" F  S STATUS=$O(^%ZIS(3.52,"E",DIR,DEVICE,STATUS)) Q:STATUS=""  D
 ..S TIME=0 F  S TIME=$O(^%ZIS(3.52,"E",DIR,DEVICE,STATUS,TIME)) Q:'TIME  Q:TIME>T3  D
 ...S IEN=0 F  S IEN=$O(^%ZIS(3.52,"E",DIR,DEVICE,STATUS,TIME,IEN)) Q:'IEN  D
 ....N JOB S JOB=IEN
 ....I '$$GETJOB(.JOB) K ^%ZIS(3.52,"E",DIR,DEVICE,STATUS,TIME,IEN) Q
 ....;delete the job entry (file #3.52)
 ....D JDELETE(IEN)
 ;
 L -%ZIS(3.52,"PURGE JOB"_DIR)
 Q
 ;
GETJOB(JOB) ;returns job info (file 3.52).  Input JOB=ien OR the name of the host file, returns .JOB array with job's fields
 N NODE,FILE,DIR,IEN
 S IEN=$G(JOB)
 I 'IEN,$L(IEN) S IEN=$$GETIEN(IEN)
 Q:'IEN ""
 S JOB("IEN")=IEN
 S NODE=$G(^%ZIS(3.52,IEN,0))
 Q:NODE="" 0
 S JOB("QUEUE")=$P(NODE,"^",5)
 S JOB("ID")=$P(NODE,"^",8)
 S FILE=$P(NODE,"^",6)
 S DIR=$P(NODE,"^",9)
 S DIR=$$DIR(DIR)
 S FILE=DIR_FILE
 S JOB("FILE")=FILE
 Q 1
 ;
STOPPED(DEVICE) ;was purging suspended for this device?
 N RET
 S RET=$P($G(^%ZIS(1,+DEVICE,0)),"^",13)
 I RET="N" Q 1
 Q 0
 ;
FEXIST(FILE) ;returns 1 if the file exists, 0 otherwise
 ;
 N OS S OS=$$OS^%ZOSV()
 I OS["UNIX" Q $$LFEXIST(FILE)
 E  I OS["VMS" Q $$VFEXIST(FILE)
 Q 0
 ;
VFEXIST(FILE) ;checks file's existance - VMS
 N CMD,RET
 S CMD="PIPE F = F$SEARCH("""_FILE_""")"
 S CMD=CMD_" ; IF F$LENGTH(F) .EQ. 0 THEN DEFINE/JOB ZIS$VAL 0 ; IF F$LENGTH(F) .GT. 0 THEN DEFINE/JOB ZIS$VAL 1 "
 I $ZF(-1,CMD)
 S RET=$ZF("TRNLNM","ZIS$VAL","LNM$JOB")
 I $ZF(-1,"DEASSIGN/JOB ZIS$VAL")
 Q +$G(RET)
 ;
LFEXIST(FILE) ;checks file's existance - Linux,Unix
 N CMD
 S CMD="[ -f "_$$REPLACE(FILE,"$","'$'")_" ]"
 Q '$ZF(-1,CMD)
 ;
FDELETE(FILE) ;delete file
 N OS S OS=$$OS^%ZOSV()
 I OS["UNIX" D LFDELETE(FILE)
 E  I OS["VMS" D VFDELETE(FILE)
 Q
 ;
VFDELETE(FILE) ;delete file - VMS
 N CMD
 I FILE'[";" S FILE=FILE_";*"
 S CMD="DELETE "_FILE
 I $ZF(-1,CMD)
 Q
 ;
LFDELETE(FILE) ;delete file - Linux,Unix
 N CMD
 S CMD="rm -f "_$$REPLACE(FILE,"$","'$'")
 I $ZF(-1,CMD)
 Q
 ;
JDELETE(IEN) ;delete the job, file #3.52
 D DELETE^ZISFM(3.52,IEN)
 Q
 ;
DEQUEUE(JOBID,QUEUE) ;Remove a job from a queue
 N OS S OS=$$OS^%ZOSV()
 I OS["UNIX" Q $$LDEQUEUE(JOBID,QUEUE)
 E  I OS["VMS" Q $$VDEQUEUE(JOBID,QUEUE)
 Q
 ;
VDEQUEUE(JOBID,QUEUE) ;Remove a job from a queue - VMS
 I $ZF(-1,"DELETE /ENTRY="_JOBID_" "_QUEUE)
 Q
 ;
LDEQUEUE(JOBID,QUEUE) ;Remove a job from a queue - Linux, Unix
 N CMD
 S CMD="lprm -P "_$$REPLACE(QUEUE,"$","'$'")_" "_JOBID
 I $ZF(-1,CMD)
 Q
UCI() ;return the UCI
 N Y
 X ^%ZOSF("UCI")
 Q $P(Y,",")
 ;
GETIEN(FILE) ;given the file name, parses out the ien and returns it
 Q $P($P(FILE,"PQ$"_$$UCI_"_",2),".TXT")
 ;
 ;
 ;
 ;
