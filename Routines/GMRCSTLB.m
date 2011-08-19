GMRCSTLB ;SLC/JFR,WAT - Totals format for LOCAL CSLT COMPL RATE ;
 ;;3.0;CONSULT/REQUEST TRACKING;**67**;DEC 27, 1997;Build 1
 ;;
 ;875 (file 100.01), 2638 (file 100.01), 3744 (VADPT)
 ; portions copied from GMRCSTL1 & GMRCSTL2
 ;
 Q  ; can't start here
 ;
PRTTOT(GEN,INDEX,NAME,ARRN) ; totals for printed report
 N COUNT,SVCUSG
 S COUNT=$O(^TMP("GMRCR",$J,ARRN," "),-1)
 I GEN=2 D
 . S COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,ARRN,COUNT,0)=""
 . S COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,ARRN,COUNT,0)=" GROUPER: "_NAME_" Totals:"
 I GEN=1 D
 . I ^TMP("GMRCTOT",$J,1,INDEX,"T")=0 D  Q  ;collect zero servs for summ
 .. Q:$P(^GMR(123.5,INDEX,0),U,2)=1
 .. S ^TMP("GMRCTOT",$J,0,NAME)=""
 . S COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,ARRN,COUNT,0)=" "
 . S COUNT=COUNT+1
 . S SVCUSG=$P(^GMR(123.5,INDEX,0),U,2),^TMP("GMRCR",$J,ARRN,COUNT,0)="SERVICE: "_NAME_$S($G(SVCUSG)=9:"   <disabled>",1:"")
 . S COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,ARRN,COUNT,0)="Total Requests To Service:"_$J(^TMP("GMRCTOT",$J,1,INDEX,"T"),30,0)
 I GEN=2,^TMP("GMRCTOT",$J,2,INDEX,"T")>0 D
 . S COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,ARRN,COUNT,0)="Total Requests To Grouper:"_$J(^TMP("GMRCTOT",$J,2,INDEX,"T"),30,0)
 I $G(^TMP("GMRCTOT",$J,GEN,INDEX,"T"))>0 D
 . S COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,ARRN,COUNT,0)="Total Requests Pending Resolution: "_$J(^TMP("GMRCTOT",$J,GEN,INDEX,"P"),21,0)
 . S COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,ARRN,COUNT,0)="Total Requests Completed: "_$J(^TMP("GMRCTOT",$J,GEN,INDEX,"C"),30,0)
 . S COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,ARRN,COUNT,0)="Total Requests Completed with Results: "_$J(^TMP("GMRCTOT",$J,GEN,INDEX,"R"),17,0)
 . N GMRCPCT
 . I ^TMP("GMRCTOT",$J,GEN,INDEX,"T")=0 S GMRCPCT="N/A"
 . I '$D(GMRCPCT) S GMRCPCT=(^TMP("GMRCTOT",$J,GEN,INDEX,"C")/^TMP("GMRCTOT",$J,GEN,INDEX,"T"))*100
 . S COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,ARRN,COUNT,0)="Percentage of Total Requests Completed: "_$S(+GMRCPCT'=GMRCPCT:$J(GMRCPCT,16),1:($J(GMRCPCT,19,2)_"%"))
 . K GMRCPCT
 . I ^TMP("GMRCTOT",$J,GEN,INDEX,"C")=0 S GMRCPCT="N/A"
 . I '$D(GMRCPCT) S GMRCPCT=(^TMP("GMRCTOT",$J,GEN,INDEX,"R")/^TMP("GMRCTOT",$J,GEN,INDEX,"C"))*100
 . S COUNT=COUNT+1
 . S ^TMP("GMRCR",$J,ARRN,COUNT,0)="Percentage of Total Completed Requests with Results: "_$S(+GMRCPCT'=GMRCPCT:GMRCPCT,1:($J(GMRCPCT,6,2)_"%"))
 Q
 ;
DELTOT(GEN,INDEX,NAME,ARRN) ; format for delimited
 ;
 I ^TMP("GMRCTOT",$J,GEN,INDEX,"T")=0 Q
 N STRING,COUNT,SVCUSG
 S COUNT=$O(^TMP("GMRCR",$J,ARRN," "),-1)
 S SVCUSG=$P(^GMR(123.5,INDEX,0),U,2),STRING=$S(GEN=2:"GROUPER: ",1:"")_NAME_$S($G(SVCUSG)=9:"   <disabled>",1:"")_";"
 S STRING=STRING_^TMP("GMRCTOT",$J,GEN,INDEX,"T")_";"
 S STRING=STRING_^TMP("GMRCTOT",$J,GEN,INDEX,"P")_";"
 S STRING=STRING_^TMP("GMRCTOT",$J,GEN,INDEX,"C")_";"
 S STRING=STRING_^TMP("GMRCTOT",$J,GEN,INDEX,"R")_";"
 D  ;get % completed
 . N GMRCPCT
 . S GMRCPCT=(^TMP("GMRCTOT",$J,GEN,INDEX,"C")/^TMP("GMRCTOT",$J,GEN,INDEX,"T"))*100
 . S STRING=STRING_$J(GMRCPCT,0,2)_";"
 . Q
 D  ; get % completed w/results
 . I ^TMP("GMRCTOT",$J,GEN,INDEX,"C")=0 S STRING=STRING_"N/A;" Q
 . N GMRCPCT
 . S GMRCPCT=(^TMP("GMRCTOT",$J,GEN,INDEX,"R")/^TMP("GMRCTOT",$J,GEN,INDEX,"C"))*100
 . S STRING=STRING_$J(GMRCPCT,0,2)
 . Q
 S COUNT=COUNT+1
 S ^TMP("GMRCR",$J,ARRN,COUNT,0)=STRING
 Q
 ;
ONESTAT(ARRN,SVCN,STAT,DT1,DT2) ;Process one status
 ; Input -- ARRN "CP" - to be printed
 ; "DEL" - in delimited format
 ; SVCN = node in ^TMP("GMRCLIST,$J
 ; STAT = status being worked on
 ; DT1 = starting date
 ; DT2 = ending date
 ;
 ; Output - None
 ;
 N GMRCPT,GMRCXDT,TEMP,GMRCSVC,GMRCSVCG,GMRCSVCP
 S GMRCSVC=$P(^TMP("GMRCSLIST",$J,SVCN),"^",1)
 S GMRCSVCP=$P(^TMP("GMRCSLIST",$J,SVCN),"^",2)
 S GMRCSVCG=$P(^TMP("GMRCSLIST",$J,SVCN),"^",3)
 S GMRCXDT=$S(DT1="ALL":0,1:9999999-DT2-.6)
 F  S GMRCXDT=$O(^GMR(123,"AE",GMRCSVC,STAT,GMRCXDT)) Q:GMRCXDT=""!(GMRCXDT>(9999999-DT1))  D
 .S GMRCPT=0
 .;Loop for one consult at a time
 .F  S GMRCPT=$O(^GMR(123,"AE",GMRCSVC,STAT,GMRCXDT,GMRCPT)) Q:GMRCPT=""  D
 .. N PROS
 ..; Check for bad "AE" x-ref
 ..I '$D(^GMR(123,GMRCPT,0)) D  Q
 ...K ^GMR(123,"AE",GMRCSVC,STAT,GMRCXDT,GMRCPT)
 .. I $$TESTPAT^VADPT(+$P(^GMR(123,GMRCPT,0),U,2)) Q  ; exclude test pats
 .. D  I $G(PROS) Q
 ... N SVC S SVC=$P(^GMR(123,GMRCPT,0),U,5)
 ... I +$G(^GMR(123.5,SVC,"INT")) S PROS=1 ; exclude PROS consults
 .. I $P($G(^GMR(123,GMRCPT,12)),U,5)="P" Q  ; exclude IFC placer
 ..; Add to totals
 ..; for all status for this service
 ..S ^TMP("GMRCTOT",$J,1,GMRCSVC,"T")=^TMP("GMRCTOT",$J,1,GMRCSVC,"T")+1
 ..; pending for this service
 ..S:",3,4,5,6,8,9,11,99,"[(","_STAT_",") ^TMP("GMRCTOT",$J,1,GMRCSVC,"P")=^TMP("GMRCTOT",$J,1,GMRCSVC,"P")+1
 .. I STAT=2 D
 ... S ^TMP("GMRCTOT",$J,1,GMRCSVC,"C")=+$G(^TMP("GMRCTOT",$J,1,GMRCSVC,"C"))+1
 ... Q:'$O(^GMR(123,+$G(GMRCPT),50,0))  ; Q if no results
 ... S ^TMP("GMRCTOT",$J,1,GMRCSVC,"R")=+$G(^TMP("GMRCTOT",$J,1,GMRCSVC,"R"))+1
 Q
 ;
