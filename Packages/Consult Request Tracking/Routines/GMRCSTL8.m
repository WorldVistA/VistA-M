GMRCSTL8 ;SLC/JFR/WAT - Totals format for CPM ;12/10/14  14:17
 ;;3.0;CONSULT/REQUEST TRACKING;**41,60,66,81**;DEC 27, 1997;Build 6
 ; This routine invokes ICRs
 ; 875 (file 100.01), 2638 (file 100.01),10104 (XLFSTR),10103 (XLFDT),3744 (VADPT)
 ;
 ; portions copied from GMRCSTL1 & GMRCSTL2
 ;patch 66 - CHKRNG updated location referenced for Clinically Indicated Date (formerly Earliest Appropriate Date) field; this was changed during v28 development.
 Q  ; can't start here
PRTTOT(GEN,INDEX,NAME,ARRN) ; totals for printed report
 N QUIT S QUIT=0 D NOACTVT Q:QUIT=1
 N GMRCPCT,LAYOUT,FRMT,ROWTEXT,CALC1,CALC2,CALC3,ROWTXT
 N COUNT,SVCUSG
 S COUNT=$O(^TMP("GMRCR",$J,ARRN," "),-1)
 I GEN=2 D
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)=""
 .S SVCUSG=$P(^GMR(123.5,INDEX,0),U,2) I $G(SVCUSG) S NAME=NAME_$S(SVCUSG=1:" <grouper only>",SVCUSG=2:"   <disabled>",1:"")
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)="     GROUPER: "_NAME_" Totals:"
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)=$J("WITHIN     IFC     IFC",75)
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)=$J("FACILITY   SENT    REC'D",77)
 I GEN=1 D
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)=" "
 .I $P(^GMR(123.5,INDEX,0),U,2)=9 S NAME=NAME_"   <disabled>"
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)="SERVICE: "_NAME
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)=$J("WITHIN     IFC      IFC",76)
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)=$J("FACILITY   SENT     REC'D",78)
 .S ROWTXT=$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U),8)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,7),10)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,13),9)
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)="All Requests in 30 Days Before Start/End of Qtr:"_ROWTXT
 .S ROWTXT=$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,2),8)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,8),10)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,14),9)
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)="All Requests in 60 Days Before Start/End of Qtr:"_ROWTXT
 I GEN=2 D
 .S ROWTXT=$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U),8)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,7),10)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,13),9)
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)="All Requests in 30 Days Before Start/End of Qtr:"_ROWTXT
 .S ROWTXT=$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,2),8)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,8),10)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,14),9)
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)="All Requests in 60 Days Before Start/End of Qtr:"_ROWTXT
 I GEN=1!(GEN=2) D
 .S ROWTXT=$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,3),12)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,9),10)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,15),9)
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)="Complete with Results in 30 Days of Request:"_ROWTXT
 .S ROWTXT=$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,4),12)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,10),10)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,16),9)
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)="Complete with Results 31-60 Days of Request:"_ROWTXT
 .S ROWTXT=$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,5),10)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,11),10)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,17),9)
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)="All Requests Created 60 Days Before Qtr Start:"_ROWTXT
 .S ROWTXT=$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,6),10)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,12),10)_$J($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,18),9)
 .S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)="All Requests Pending 60 Days Before Qtr Start:"_ROWTXT
 .;% complete in 30 days of request
 .I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U)>0 S CALC1=$J(($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,3)/$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U))*100,2,2)_"%"
 .S ROWTXT=$S($G(CALC1)="":$$REPEAT^XLFSTR(" ",10-$L("N / A"))_"N / A",1:$$REPEAT^XLFSTR(" ",10-$L(CALC1))_CALC1)
 .I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,7)>0 S CALC2=$J(($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,9)/$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,7))*100,2,2)_"%"
 .S ROWTXT=ROWTXT_$S('$D(CALC2):$$REPEAT^XLFSTR(" ",10-$L("N / A"))_"N / A",1:$$REPEAT^XLFSTR(" ",10-$L(CALC2))_CALC2)
 .I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,13)>0 S CALC3=$J(($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,15)/$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,13))*100,2,2)_"%"
 .S ROWTXT=ROWTXT_$S($G(CALC3)="":$$REPEAT^XLFSTR(" ",9-$L("N / A"))_"N / A",1:$$REPEAT^XLFSTR(" ",9-$L(CALC3))_CALC3)
 .S COUNT=COUNT+1
 .S ^TMP("GMRCR",$J,ARRN,COUNT,0)="Percent Complete w/Results in 30 Days of Request: "_ROWTXT
 .;% complete in 60 days of request
 .K CALC1,CALC2,CALC3
 .I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,2)>0 S CALC1=$J(($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,4)/$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,2))*100,2,2)_"%"
 .S ROWTXT=$S($G(CALC1)="":$$REPEAT^XLFSTR(" ",10-$L("N / A"))_"N / A",1:$$REPEAT^XLFSTR(" ",10-$L(CALC1))_CALC1)
 .I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,8)>0 S CALC2=$J(($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,10)/$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,8))*100,2,2)_"%"
 .S ROWTXT=ROWTXT_$S('$D(CALC2):$$REPEAT^XLFSTR(" ",10-$L("N / A"))_"N / A",1:$$REPEAT^XLFSTR(" ",10-$L(CALC2))_CALC2)
 .I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,14)>0 S CALC3=$J(($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,16)/$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,14))*100,2,2)_"%"
 .S ROWTXT=ROWTXT_$S($G(CALC3)="":$$REPEAT^XLFSTR(" ",9-$L("N / A"))_"N / A",1:$$REPEAT^XLFSTR(" ",9-$L(CALC3))_CALC3)
 .S COUNT=COUNT+1
 .S ^TMP("GMRCR",$J,ARRN,COUNT,0)="Percent Complete w/Results 31-60 Days of Request: "_ROWTXT
 .;% pending before quarter start
 .K CALC1,CALC2,CALC3
 .I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,5)>0 S CALC1=$J(($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,6)/$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,5))*100,2,2)_"%"
 .S ROWTXT=$S($G(CALC1)="":$$REPEAT^XLFSTR(" ",10-$L("N / A"))_"N / A",1:$$REPEAT^XLFSTR(" ",10-$L(CALC1))_CALC1)
 .I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,11)>0 S CALC2=$J(($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,12)/$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,11))*100,2,2)_"%"
 .S ROWTXT=ROWTXT_$S('$D(CALC2):$$REPEAT^XLFSTR(" ",10-$L("N / A"))_"N / A",1:$$REPEAT^XLFSTR(" ",10-$L(CALC2))_CALC2)
 .I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,17)>0 S CALC3=$J(($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,18)/$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,17))*100,2,2)_"%"
 .S ROWTXT=ROWTXT_$S($G(CALC3)="":$$REPEAT^XLFSTR(" ",9-$L("N / A"))_"N / A",1:$$REPEAT^XLFSTR(" ",9-$L(CALC3))_CALC3)
 .S COUNT=COUNT+1
 .S ^TMP("GMRCR",$J,ARRN,COUNT,0)="Percent Still Pending Created Before Qtr Start:   "_ROWTXT
 Q
DELTOT(GEN,INDEX,NAME,ARRN) ; format for delimited
 N QUIT S QUIT=0 D NOACTVT Q:QUIT=1
 N STRING,COUNT,PIECE,INCR,SVCUSG
 S SVCUSG=$P(^GMR(123.5,INDEX,0),U,2) I $G(SVCUSG) S NAME=NAME_$S(SVCUSG=1:" <grouper only>",SVCUSG=2:" <disabled>",1:"")
 S COUNT=$O(^TMP("GMRCR",$J,ARRN," "),-1),STRING=$S(GEN=2:"GROUPER: ",1:"")_NAME_";"
 F PIECE=1:1:18 D
 .S STRING=STRING_$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,PIECE)_";"
 .I PIECE=6!(PIECE=12)!(PIECE=18) D
 ..S INCR=$S(PIECE=6:0,PIECE=12:6,1:12)
 ..;percents
 ..I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,(1+INCR))=0 S STRING=STRING_"N/A;"
 ..E  S GMRCPCT=($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,(3+INCR))/$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,(1+INCR)))*100,STRING=STRING_$J(GMRCPCT,0,2)_";"
 ..I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,(2+INCR))=0 S STRING=STRING_"N/A;"
 ..E  S GMRCPCT=($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,(4+INCR))/$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,(2+INCR)))*100,STRING=STRING_$J(GMRCPCT,0,2)_";"
 ..I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,(5+INCR))=0 S STRING=STRING_"N/A;"
 ..E  S GMRCPCT=($P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,(6+INCR))/$P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,(5+INCR)))*100,STRING=STRING_$J(GMRCPCT,0,2)_";"
 S COUNT=COUNT+1,^TMP("GMRCR",$J,ARRN,COUNT,0)=STRING
 Q
NOACTVT ;services with no activity for the reporting period
 N CONT,PIECE S CONT=1
 I GEN=1&($P(^GMR(123.5,INDEX,0),U,2)=1) S QUIT=1 Q  ;;don't add to list if service is a grouper only...
 F PIECE=1:1:18 D  Q:CONT=0
 .I $P(^TMP("GMRCT",$J,GEN,INDEX,"DATA"),U,PIECE)>0 S CONT=0 Q
 S:CONT=1 ^TMP("GMRCT",$J,0,NAME)="",QUIT=1
 Q
ONESTAT(ARRN,SVCN,STAT,DT1,DT2,STR) ;Process one status
 ;Input -- ARRN  "CP"  - to be printed  or "DEL" - in delimited format
 ;SVCN = node in ^TMP("GMRCLIST,$J..STAT = status being worked on..DT1 = starting date..DT2 = ending date
 ;STR = string value used to store 30/60 day results in correct piece of ^tmp arrays
 ;Output - None
 N GMRCPT,GMRCXDT,TEMP,GMRCSVC,GMRCSVCG,GMRCSVCP,GMRCQT,FLG,TYPE
 S GMRCSVC=$P(^TMP("GMRCSLIST",$J,SVCN),"^",1)
 S GMRCSVCP=$P(^TMP("GMRCSLIST",$J,SVCN),"^",2)
 S GMRCSVCG=$P(^TMP("GMRCSLIST",$J,SVCN),"^",3)
 S GMRCXDT=9999999-DT2-.6  ;start searching the global at a date a fraction newer than DT2 (the end date for this search)
 F  S GMRCXDT=$O(^GMR(123,"AE",GMRCSVC,STAT,GMRCXDT)) Q:GMRCXDT=""!(GMRCXDT>(9999999-DT1))  D
 .S GMRCPT=0
 .;Loop for one consult at a time
 .F  S GMRCPT=$O(^GMR(123,"AE",GMRCSVC,STAT,GMRCXDT,GMRCPT)) Q:GMRCPT=""  D
 ..S FLG=0 D EXCLUDE Q:$G(FLG)=1
 ..S TYPE="" D REQTYPE
 ..I TYPE="LOCAL" D  ;set totals for 30 and 60 day range
 ...S:STR="30" $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U)=$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U)+1
 ...S:STR="60" $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,2)=$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,2)+1
 ...I STAT=2 D
 ....Q:'$O(^GMR(123,+$G(GMRCPT),50,0))  ;Q if no results
 ....D CHKRNG
 ..I TYPE="IFCP" D
 ...S:STR="30" $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,7)=$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,7)+1
 ...S:STR="60" $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,8)=$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,8)+1
 ...D:STAT=2 CHKRNG
 ..I TYPE="IFCF" D
 ...S:STR="30" $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,13)=$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,13)+1
 ...S:STR="60" $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,14)=$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,14)+1
 ...D:STAT=2 CHKRNG
 Q
 ;
ONESTAT2(ARRN,SVCN,STAT,DT1) ;all statuses, all requests, before quarter start
 ;Input -- ARRN  "CP"  - to be printed or "DEL" - in delimited format
 ;SVCN = node in ^TMP("GMRCLIST,$J..STAT = status being worked on..DT1 = 60 days before starting date of current quarter
 ;Output -- None
 N GMRCPT,GMRCXDT,TEMP,GMRCSVC,GMRCSVCG,GMRCSVCP,FLG,TYPE
 S GMRCSVC=$P(^TMP("GMRCSLIST",$J,SVCN),"^",1)
 S GMRCSVCP=$P(^TMP("GMRCSLIST",$J,SVCN),"^",2)
 S GMRCSVCG=$P(^TMP("GMRCSLIST",$J,SVCN),"^",3)
 S GMRCXDT=""
 F  S GMRCXDT=$O(^GMR(123,"AE",GMRCSVC,STAT,GMRCXDT)) Q:GMRCXDT=""  D
 .S GMRCPT=0
 .;Loop for one consult at a time
 .F  S GMRCPT=$O(^GMR(123,"AE",GMRCSVC,STAT,GMRCXDT,GMRCPT)) Q:GMRCPT=""  D
 ..Q:GMRCXDT<(9999999-DT1-.6)  ;
 ..S FLG=0 D EXCLUDE Q:$G(FLG)=1
 ..S TYPE="" D REQTYPE
 ..I TYPE="LOCAL" D
 ...S $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,5)=$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,5)+1
 ...; get unresolved requests for the period
 ...S:",3,4,5,6,8,9,11,99,"[(","_STAT_",") $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,6)=$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,6)+1
 ..I TYPE="IFCP" D
 ...S $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,11)=$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,11)+1
 ...S:",3,4,5,6,8,9,11,99,"[(","_STAT_",") $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,12)=$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,12)+1
 ..I TYPE="IFCF" D
 ...S $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,17)=$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,17)+1
 ...S:",3,4,5,6,8,9,11,99,"[(","_STAT_",") $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,18)=$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,18)+1
 Q
REQTYPE  ;If the request is being requested and performed locally, this field will be blank; Placer done elsewhere, Filler done locally
 I $P(^GMR(123,$G(GMRCPT),0),U,23)="" S TYPE="LOCAL" Q
 I $P(^GMR(123,$G(GMRCPT),0),U,23)'=""&($P($G(^GMR(123,GMRCPT,12)),U,5)="P") S TYPE="IFCP" Q
 I $P(^GMR(123,$G(GMRCPT),0),U,23)'=""&($P($G(^GMR(123,GMRCPT,12)),U,5)="F") S TYPE="IFCF" Q
 Q
EXCLUDE ;exclude these request types from the count
 N PROS
 ; Check for bad "AE" x-ref
 I '$D(^GMR(123,GMRCPT,0)) D  S FLG=1 Q
 .K ^GMR(123,"AE",GMRCSVC,STAT,GMRCXDT,GMRCPT)
 I $$TESTPAT^VADPT(+$P(^GMR(123,GMRCPT,0),U,2)) S FLG=1 Q  ; exclude test pats
 D  I $G(PROS) S FLG=1 Q
 .N SVC S SVC=$P(^GMR(123,GMRCPT,0),U,5)
 .I +$G(^GMR(123.5,SVC,"INT")) S PROS=1 ; exclude PROS consults
 I $P($G(^GMR(123,GMRCPT,0)),U,18)'="O" S FLG=1 Q  ; only getting outpat
 I $G(^GMR(123,GMRCPT,70))["Y" S FLG=1 Q  ; exclude admin requests
 Q
CHKRNG ;check if request is complete within 30/60 days of Desired Date or Date of Request
 N DTOR,DTCMPL S DTOR="",DTCMPL=""
 Q:'$O(^GMR(123,+$G(GMRCPT),50,0))&('$O(^GMR(123,+$G(GMRCPT),51,0)))
 I $P(^GMR(123,+$G(GMRCPT),0),U,24)>0 S DTOR=$P(^GMR(123,+$G(GMRCPT),0),U,24) ;check for desired date CPRS GUI v28
 S:$G(DTOR)="" DTOR=$P(^GMR(123,+$G(GMRCPT),0),U,7)
 ; if request is completed and has results, was it completed within 30 or 60 days of the Date of Request, field 3 in 123 [0;7]
 ;order through activity multiple (40) and find the entry for completed 40, [0:2] - value of 10 is complete/update
 N CHK S CHK=0
 F  S CHK=$O(^GMR(123,+$G(GMRCPT),40,CHK)) Q:CHK="B"  D
 .;get the date/time of completion 40, [0;3]
 .I $D(^GMR(123,+$G(GMRCPT),40,CHK,0)) S:($P(^GMR(123,GMRCPT,40,CHK,0),U,2)=10) DTCMPL=$P(^GMR(123,GMRCPT,40,CHK,0),U,3)
 I $G(DTCMPL) D
 .I (STR="30")&(DTCMPL<=$$FMADD^XLFDT(DTOR,30)) D
 ..S:TYPE="LOCAL" $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,3)=+$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,3)+1
 ..S:TYPE="IFCP" $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,9)=+$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,9)+1
 ..S:TYPE="IFCF" $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,15)=+$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,15)+1
 .I STR'="30"&(DTCMPL<=$$FMADD^XLFDT(DTOR,60))&(DTCMPL>$$FMADD^XLFDT(DTOR,30)) D
 ..S:TYPE="LOCAL" $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,4)=+$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,4)+1
 ..S:TYPE="IFCP" $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,10)=+$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,10)+1
 ..S:TYPE="IFCF" $P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,16)=+$P(^TMP("GMRCT",$J,1,GMRCSVC,"DATA"),U,16)+1
 Q
