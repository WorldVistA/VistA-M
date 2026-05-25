HLVSM ;BAY/JML - HL7 Read-Only Calls for the VistA System Monitor;7/1/2025
 ;;1.6;HEALTH LEVEL SEVEN;**177**;10/13/1995;Build 6
 ; SACC Exemption ID 202503211314-03 is in place for the close command at LSTAT+16
 ; This routine provides read-only callables to populate the VSM Operational Dashboard
 ;
 ;   Direct routine calls
GETFILERS(DIR,INFOARR) ; returns filer counts and list
 Q $$GETINFO^HLCSFMN1(DIR,INFOARR)
 ;
FILERCFG() ; returns # of filers configured
 Q $G(^HLCS(869.3,1,1))
 ;
LMSTAT() ; returns Link Manager Status
 Q $$STAT^HLCSLM()
 ;
CHKSTOP() ; returns HLO System Status
 Q $$CHKSTOP^HLOPROC
 ;
PROCMAN() ; returns HLO Process Manager Status
 Q $$RUNNING^HLOUSR
 ;
MPOQ(MPOQARR) ; returns # of messages pending on out queuess
 Q $$OUT^HLOQUE(.MPOQARR)
 ;
MPSQ(MPSQARR) ; returns # of messages pending on sequence queues
 Q $$SEQ^HLOQUE(.MPSQARR)
 ;
MPAQ(MPAQARR) ; returns # of messages pending on application queues
 Q $$IN^HLOQUE(.MPAQARR)
 ;
ADD(DIR) ; returns message sent/rec'd/error today
 N TODAY
 S TODAY=$$DT^XLFDT
 Q $$ADD^HLOUSR(DIR)
 ;
 ;
 ;   Global Reads
CLPROC(DIRECTION) ; returns # of client link processes
 Q +$G(^HLC("HL7 PROCESS COUNTS","RUNNING",DIRECTION))
 ;
FILE777() ; returns count/date of File 777
 Q $G(^HLTMP("FILE 777 RECORD COUNT"))
 ;
FILE778() ; returns count/date of File 778
 Q $G(^HLTMP("FILE 778 RECORD COUNT"))
 ;
 ;
 ;
 ;   Code Snippets from HL routines
SLM()    ; returns currency of Link Manager - FROM SLM^HLEVUTIL
 N BAD,DATA,DATE,DAY,DIFF,DOWN,FIEN,HR,IEN,IOBON,IOBOFF,LASTDT,MIN,SEC,X,NOW
 ;
 S DOWN="Monitor DOWN",U="^"
 ;
 I $P($G(^HLEV(776.999,1,0)),U,2)'="A" D  QUIT DOWN ; NEED ICR
 .S DOWN="Monitor STOPPED"
 ;
 S LASTDT=":",FIEN=0
 F  S LASTDT=$O(^HLEV(776.2,"B",LASTDT),-1) Q:'LASTDT!(FIEN)  D
 .S IEN=":"
 .F  S IEN=$O(^HLEV(776.2,"B",+LASTDT,IEN),-1) Q:'IEN!(FIEN)  D
 ..S DATA=$G(^HLEV(776.2,+IEN,0)) QUIT:$P(DATA,U,4)'="Q"  ;->
 ..S FIEN=IEN
 I 'FIEN QUIT DOWN ;->
 S DATA=$G(^HLEV(776.2,+FIEN,0))
 S DATE=$P(DATA,U,6) QUIT:DATE'?7N1"."1.N DOWN ;->
 S DATE=$$FMTH^XLFDT(DATE),DATE(1)=$$SEC^HLEVMST0(DATE)
 S NOW=$H,NOW(1)=$$SEC^HLEVMST0(NOW)
 I DATE(1)<NOW(1) D  QUIT $S(BAD:DOWN,1:"Monitor current") ;->
 .S BAD=0
 .QUIT:(NOW(1)-DATE(1))<(5*60)  ;-> OK if less than 5 minutes old
 .S BAD=1,DOWN="Monitor OVERDUE"
 S DIFF=$$DIFFDH^HLCSFMN1(NOW,DATE)
 S DAY=+DIFF,DIFF=$TR($P(DIFF,U,2),":",U)
 S HR=+DIFF+(DAY*24),MIN=+$P(DIFF,U,2),SEC=+$P(DIFF,U,3)
 S:SEC>30 MIN=MIN+1
 S HR=HR+MIN/60,HR=$J(HR,"",1)
 Q "Monitor current [next job "_HR_" hr]"
 ;
LSTAT()  ; returns HLO Standard Listener Status - Adapted from HLOUSR
 N HLSTAT,HLOS,HLIP,HLLINK
 S HLSTAT=$$KLISTEN^HLOUSR
 ;
 ;if the Kernel listner is NOT running, might check the listener via the OPEN command.  With loadbalancing, the IP address of the listener link sometimes fails, so also try 'loopback'.
 S HLOS=$$OS^%ZOSV
 I 'HLSTAT,(HLOS["VMS")!('$$CHKSTOP^HLOPROC) D
 .N HLIP,HLLINK
 .S HLLINK=$P($G(^HLD(779.1,1,0)),"^",10)
 .I HLLINK,$$GET^HLOTLNK(HLLINK,.HLLINK) D
 ..;ADD LOOPBACK FOR IPV6 - HL*1.6*163
 ..;$$CONVERT^XLFIPV(IP) API (ICR #5844)
 ..F HLIP=$$CONVERT^XLFIPV("127.0.0.1"),$$CONVERT^XLFIPV("0.0.0.0"),HLLINK("IP") D  Q:HLSTAT
 ...N POP,IO,IOF,IOST
 ...D CALL^%ZISTCP(HLIP,HLLINK("PORT"),5)
 ...S HLSTAT='POP
 ...C:HLSTAT IO
 Q HLSTAT
 ;
DLINKS() ; returns list of down links - Adapted from ^HLOUSR
 N HLLIST,HLLINK
 S (HLLIST,HLLINK)=""
 F  S HLLINK=$O(^HLTMP("FAILING LINKS",HLLINK)) Q:HLLINK=""  D  I $L(HLLIST)>60 S HLLIST=HLLIST_",..." Q
 .N HLTIME,HLQUE,HLLARY
 .S HLTIME=$G(^HLTMP("FAILING LINKS",HLLINK)) Q:HLTIME=""
 .I '$G(HLLARY("SHUTDOWN")),HLTIME="" Q
 .I '$G(HLLARY("SHUTDOWN")),($$HDIFF^XLFDT($H,HLTIME,2)<300) Q
 .S HLLIST=HLLIST_$S($L(HLLIST):", ",1:"")_HLLINK
 Q HLLIST
 ;
STQUES(HLDIR) ; returns up to 4 stopped in/out queues - adapted from ^HLOUSR
 N HLTEMP,HLCOUNT,HLQUE
 S HLTEMP="",HLCOUNT=0,HLQUE=""
 F  S HLQUE=$O(^HLTMP("STOPPED QUEUES",HLDIR,HLQUE)) Q:HLQUE=""  D
 .S HLCOUNT=HLCOUNT+1
 .Q:HLCOUNT>4
 .S:HLCOUNT=1 HLTEMP=HLTEMP_HLQUE
 .S:"23"[HLCOUNT HLTEMP=HLTEMP_"; "_HLQUE
 .S:HLCOUNT=4 HLTEMP=HLTEMP_" ..."
 Q HLTEMP
 ;
GETVIEWS(HLVARR) ; returns an array with the site's Logical LInk Views
 N HLVIEN,HLVIEW,HLVIDX,HLVDAT,HLLINK,HLLIEN,HLORD,HLVCNT
 S HLVCNT=0
 S HLVIEN=0
 F  S HLVIEN=$O(^HLCS(869.3,1,6,HLVIEN)) Q:+HLVIEN=0  D
 .S HLVIEW=$G(^HLCS(869.3,1,6,HLVIEN,0))
 .I HLVIEW="" S HLVIEW=HLVIEN
 .S HLVIDX=0
 .F  S HLVIDX=$O(^HLCS(869.3,1,6,HLVIEN,1,HLVIDX)) Q:+HLVIDX=0  D
 ..S HLVDAT=$G(^HLCS(869.3,1,6,HLVIEN,1,HLVIDX,0))
 ..S HLLIEN=$P(HLVDAT,"^"),HLORD=+$P(HLVDAT,"^",2)
 ..S HLLINK=$$GET1^DIQ(870,HLLIEN,.01)
 ..I HLLINK="" S HLLINK=HLLIEN
 ..S HLVARR(HLVIEW,HLORD,HLLINK)=""
 ..S HLVCNT=HLVCNT+1
 S HLVARR=HLVCNT
 Q
