DVBCHS0 ;ALB/JRP - C & P EXTRACT FOR HEALTH SUMMARY;11-JAN-95
 ;;2.7;AMIE;;Apr 10, 1995
HSCP(PATPTR,INVBEGDT,INVENDDT,OUTCODE,ARRAY) ;MAIN ENTRY POINT
 ;INPUT  : PATPTR - Pointer to PATIENT file (#2)
 ;         INVBEGDT - Beginning date in inverse FileMan format
 ;                  - Defaults to one year before today
 ;         INVENDDT - Ending date in inverse FileMan format
 ;                  - Defaults to today
 ;         OUTCODE - Flag indicating which optional nodes to return
 ;                 0 = Do not return any optional nodes
 ;                 1 = Node 1 should also be returned
 ;                 2 = Node 2 should also be returned
 ;                 3 = Nodes 1 & 2 should also be returned (default)
 ;         ARRAY - Where to store output (full global reference)
 ;               - Defaults to ^TMP("DVBC",$J)
 ;
 ;OUTPUT : None
 ;      ARRAY(InvExDt,Type,0) = Code ^ DATE OF EXAM [.06]
 ;            ^ EXAM TYPE [.03] ^ EXAMINING PHYSICIAN [.07]
 ;            ^ PRIORITY OF EXAM [396.3;9]
 ; -->  ARRAY(InvExDt,Type,1) = ROUTING LOCATION [396.3;24]
 ;            ^ OWNER DOMAIN [396.3;28] ^ TRANSFERRED OUT TO [62]
 ; -->  ARRAY(InvExDt,Type,2) = REQUEST STATUS [396.3;17]
 ;            ^ APPROVED BY [396.3;25] ^ APPROVAL DATE/TIME [396.3;26]
 ;      ARRAY(InvExDt,Type,"RES",0) = Number of lines in EXAM RESULTS
 ;      ARRAY(InvExDt,Type,"RES",X) = Line X of EXAM RESULTS [70]
 ;
 ;   Subscripts:
 ;     InvExDt - Inverse FileMan date of DATE OF EXAM [.06]
 ;     Type - Poiner value of EXAM TYPE [.03]
 ;
 ;   Code used as follows:
 ;     1 = Exam was performed locally
 ;     2 = Exam was performed by another facility
 ;     3 = Exam was performed locally for another facility
 ;
 ;   All dates will be in the FileMan format
 ;
 ;   With the exception of dates, 'N/A' (not applicable) and 'UNKNOWN'
 ;   will be used for field values when appropriate
 ;
 ;   Optional nodes are marked by an arrow (-->)
 ;
 ;NOTES  : Output array will be initialized (KILLed)
 ;       : Information for an exam is only returned when
 ;           1. The exam status is COMPLETED
 ;           2. The status of the request containing the exam is
 ;              a) RELEASED TO RO, NOT PRINTED
 ;              b) COMPLETED, PRINTED BY RO
 ;              c) COMPLETED, TRANSFERRED OUT
 ;
 ;
 ;CHECK INPUT/SET DEFAULTS
 Q:('$D(^DPT((+$G(PATPTR)),0)))
 S INVBEGDT=+$G(INVBEGDT)
 S:('INVBEGDT) INVBEGDT=9999999-(DT-10000)
 S INVENDDT=+$G(INVENDDT)
 S:('INVENDDT) INVENDDT=9999999-DT
 S OUTCODE=$G(OUTCODE)
 S:((OUTCODE="")!(OUTCODE>3)!(OUTCODE<0)) OUTCODE=3
 S:($G(ARRAY)="") ARRAY="^TMP(""DVBC"",$J)"
 ;KILL OUTPUT ARRAY
 K @ARRAY
 ;DECLARE VARIABLES
 N BEGDATE,ENDDATE,TYPEPTR,EXAMPTR,TMP,NODE0
 ;CONVERT INVERSE DATES TO NORMAL DATES
 S BEGDATE=9999999-INVBEGDT
 S ENDDATE=9999999-INVENDDT
 ;NO EXAMS ON FILE
 Q:('$D(^DVB(396.4,"APS",PATPTR)))
 ;LOOK FOR COMPLETED EXAMS
 S TYPEPTR=0
 F  S TYPEPTR=+$O(^DVB(396.4,"APS",PATPTR,TYPEPTR)) Q:('TYPEPTR)  D
 .S EXAMPTR=0
 .F  S EXAMPTR=+$O(^DVB(396.4,"APS",PATPTR,TYPEPTR,"C",EXAMPTR)) Q:('EXAMPTR)  D
 ..;GET ZERO NODE OF EXAM
 ..S NODE0=$G(^DVB(396.4,EXAMPTR,0))
 ..;MAKE SURE EXAM IS WITHIN DATE RANGE
 ..S TMP=+$P(NODE0,"^",6)
 ..Q:(('TMP)!(TMP<BEGDATE)!(TMP>ENDDATE))
 ..;MAKE SURE REQUEST CONTAINING EXAM HAS BEEN RELEASED
 ..S TMP=+$P(NODE0,"^",2)
 ..Q:('TMP)
 ..S TMP=$P($G(^DVB(396.3,TMP,0)),"^",18)
 ..Q:((TMP'="C")&(TMP'="R")&(TMP'="CT"))
 ..;SET NODE ZERO OF OUTPUT
 ..D OUT0^DVBCHS1(EXAMPTR,ARRAY)
 ..;SET NODE 'RES' OF OUTPUT
 ..D OUTRES^DVBCHS1(EXAMPTR,ARRAY)
 ..Q:('OUTCODE)
 ..;SET NODE ONE OF OUTPUT (OPTIONAL)
 ..D:((OUTCODE=1)!(OUTCODE=3)) OUT1^DVBCHS2(EXAMPTR,ARRAY)
 ..;SET NODE TWO OF OUTPUT (OPTIONAL)
 ..D:((OUTCODE=2)!(OUTCODE=3)) OUT2^DVBCHS2(EXAMPTR,ARRAY)
 Q
