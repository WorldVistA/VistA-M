SPNJRPC3 ;BP/JAS - Returns Inpatient/Outpatient Activity for list of pats ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to API DEM^VADPT supported by IA #10061
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ; API GETNAME^SPNLRU is part of Spinal Cord version 2.0
 ; API ROLLUP^SPNLGROP is part of Spinal Cord version 2.0
 ; API ROLLUP^SPNLGRIP is part of Spinal Cord version 2.0
 ; API NAMEIT^SPNLGROP is part of Spinal Cord version 2.0
 ; API NAMEIT^SPNLGRIP is part of Spinal Cord version 2.0
 ;
 ; Parm values:
 ;     RETURN is the sorted data from the earliest date of listing
 ;     ICNLST is the list of patient ICNs to process
 ;     FDATE is the start date for period
 ;     TDATE is the end date for period
 ;     HIUSERS is the number of highest users to identify
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICNLST,FDATE,TDATE,HIUSERS) ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 S X=FDATE S %DT="T" D ^%DT S FDATE=Y
 S X=TDATE S %DT="T" D ^%DT S TDATE=Y
 ;***************************
 K ^TMP($J),^TMP("SPN",$J)
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 D OUTPAT,INPAT
 K %DT,AICN,DFN,ICN,ICNNM,PATLIST,RETCNT,SPN,X,Y
 Q
IN Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 D DEM^VADPT
 D ROLLUP^SPNLGROP(DFN,FDATE,TDATE,HIUSERS)
 D ROLLUP^SPNLGRIP(DFN,FDATE,TDATE,HIUSERS)
 D NAMEIT^SPNLGRIP
 D NAMEIT^SPNLGROP
 Q
OUTPAT ;
 D POP1,POP2
 D:HIUSERS POP3
 Q
POP1 ;
 ; VISITS    Number of visits
 N VISITS,OUT,LINE,STARTLIN,COL,STOPS,NPATS
 S NPATS=+$G(^TMP("SPN",$J,"OP","PAT"))
 S VISITS=+$G(^TMP("SPN",$J,"OP","VISITS"))
 S STOPS=+$G(^TMP("SPN",$J,"OP","STOPS"))
 S ^TMP($J,RETCNT)="PAT999^Outpatient Activity^EOL999"
 S RETCNT=RETCNT+1
 S ^TMP($J,RETCNT)="BOS999^Totals:  "_$FN(NPATS,",")_" patient"_$S(NPATS=1:"",1:"s")_" for "_$FN(VISITS,",")_" visit"_$S(VISITS=1:"",1:"s")_" ("_$FN(STOPS,",")_" stop"_$S(STOPS=1:"",1:"s")_")^EOL999"
 S RETCNT=RETCNT+1
 S VISITS=+$O(^TMP("SPN",$J,"OP","VISITS",""))
 F  D  Q:VISITS=""
 . S STARTLIN=1
 . F COL=1:1:3 D  Q:VISITS=""
 . . S OUT(STARTLIN)=$G(OUT(STARTLIN))_"HDR999^Patients^Visits^EOL999"
 . . F LINE=STARTLIN+2:1 D  Q:VISITS=""
 . . . S OUT(LINE)=$G(OUT(LINE))_$G(^TMP("SPN",$J,"OP","VISITS",VISITS))_"^"_-VISITS_"^EOL999"
 . . . S VISITS=$O(^TMP("SPN",$J,"OP","VISITS",VISITS))
 . S LINE=""
 . F  S LINE=$O(OUT(LINE)) Q:LINE=""  D
 . . S ^TMP($J,RETCNT)=OUT(LINE)
 . . S RETCNT=RETCNT+1
 Q
POP2 ;
 ; SCNUM     Clinic Stop Code Number
 ; SCNAME    Clinic Stop Code Name
 ; NPATS     Number of patients who stopped at this stop code
 ; VISITS    Number of visits made to this stop code
 ; STOPS     Number of stops made at this stop code
 N SCNUM,SCNAME,NPATS,STOPS,VISITS
 S ^TMP($J,RETCNT)="HDR999^Clinic^Patients^Visits^Stops^EOL999"
 S RETCNT=RETCNT+1
 S SCNUM=""
 F  S SCNUM=$O(^TMP("SPN",$J,"OP","SC",SCNUM)) Q:SCNUM=""  D
 . S NPATS=^TMP("SPN",$J,"OP","SC",SCNUM)
 . S STOPS=^TMP("SPN",$J,"OP","SC",SCNUM,"STOPS")
 . S VISITS=^TMP("SPN",$J,"OP","SC",SCNUM,"VISITS")
 . S SCNAME=^TMP("SPN",$J,"OP","SC",SCNUM,"NAME")
 . S ^TMP($J,RETCNT)=SCNUM_"^"_SCNAME_"^"_NPATS_"^"_$FN(VISITS,",",2)_"^"_STOPS_"^"_"EOL999"
 . S RETCNT=RETCNT+1
 Q
POP3 ;
 ; I         High user counter
 ; PID       Patient ID
 ; PNAME     Patient Name
 ; PSSN      Patient SSN
 ; VISITS    Number of visits made to this stop code
 ; NDSCNUMS  Number of different stop codes
 N VISITS,PID,PNAME,PSSN,I,NDSCNUMS
 S ^TMP($J,RETCNT)="BOS999^Highest Utilization of Visits^EOL999"
 S RETCNT=RETCNT+1
 S ^TMP($J,RETCNT)="HDR999^Patient Name^SSN^Visit^Different Stop Codes^EOL999"
 S RETCNT=RETCNT+1
 S VISITS=""
 F I=1:1:HIUSERS S VISITS=$O(^TMP("SPN",$J,"OP","HI","H1",VISITS)) Q:VISITS=""  D
 . S NDSCNUMS=""
 . F  S NDSCNUMS=$O(^TMP("SPN",$J,"OP","HI","H1",VISITS,NDSCNUMS)) Q:NDSCNUMS=""  D
 . . S PID=""
 . . F  S PID=$O(^TMP("SPN",$J,"OP","HI","H1",VISITS,NDSCNUMS,PID)) Q:PID=""  D
 . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . S ^TMP($J,RETCNT)=PNAME_"^"_PSSN_"^"_-VISITS_"^"_-NDSCNUMS_"^EOL999"
 . . . S RETCNT=RETCNT+1
 Q
INPAT ;
 D PIP1,PIP2
 I HIUSERS D PIP3,PIP4
 Q
PIP1 ;
 ; ADM       Number of admissions (stays)
 N ADM,OUT,LINE,STARTLIN,COL,NPATS,DAYS
 S NPATS=+$G(^TMP("SPN",$J,"IP","PAT"))
 S ADM=+$G(^TMP("SPN",$J,"IP","ADM"))
 S DAYS=+$G(^TMP("SPN",$J,"IP","DAYS"))
 S ^TMP($J,RETCNT)="PAT999^Inpatient Activity^EOL999"
 S RETCNT=RETCNT+1
 S ^TMP($J,RETCNT)="BOS999^Totals:  "_$FN(NPATS,",")_" patient"_$S(NPATS=1:"",1:"s")_" for "_$FN(ADM,",")_" stay"_$S(ADM=1:"",1:"s")_" and "_$FN(DAYS,",")_" day"_$S(DAYS=1:"",1:"s")_" inpatient care^EOL999"
 S RETCNT=RETCNT+1
 S ADM=+$O(^TMP("SPN",$J,"IP","ADM","PAT",""))
 F  D  Q:ADM=""
 . S STARTLIN=1
 . F COL=1:1:3 D  Q:ADM=""
 . . S OUT(STARTLIN)=$G(OUT(STARTLIN))_"HDR999^Patients^Stays^EOL999"
 . . F LINE=STARTLIN+2:1 D  Q:ADM=""
 . . . S OUT(LINE)=$G(OUT(LINE))_$G(^TMP("SPN",$J,"IP","ADM","PAT",ADM))_"^"_ADM_"^EOL999"
 . . . S ADM=$O(^TMP("SPN",$J,"IP","ADM","PAT",ADM))
 . S LINE=""
 . F  S LINE=$O(OUT(LINE)) Q:LINE=""  D
 . . S ^TMP($J,RETCNT)=OUT(LINE)
 . . S RETCNT=RETCNT+1
 Q
PIP2 ;
 ; BS        Bed Section Array
 ; BSNAME    Bed Section Name
 ; BSNR      Bed Section Number
 ; DAYS      Number of days spent in a bed section
 ; NPATS     Number of patients
 ; STAYS     Number of stays in a bed section
 N STAYS,BSNAME,NPATS,DAYS,BS,BSNR
 S ^TMP($J,RETCNT)="BOS999^Median Length of Stay (MLOS):  "_$FN($$MEDIAN^SPNLRU($G(^TMP("SPN",$J,"IP","ADM")),"^TMP(""SPN"","_$J_",""IP"",""ADM"",""DAYS"","),",",1)_" days^EOL999"
 S RETCNT=RETCNT+1
 S ^TMP($J,RETCNT)="HDR999^Specialty^Patients^Stays^Days^MLOS^EOL999"
 S RETCNT=RETCNT+1
 S BSNR="" ; set up to print bed sections in name order
 F  S BSNR=$O(^TMP("SPN",$J,"IP","BS",BSNR)) Q:BSNR=""  D
 . S BS(^TMP("SPN",$J,"IP","BS",BSNR,"NAME"))=BSNR
 S BSNAME=""
 F  S BSNAME=$O(BS(BSNAME)) Q:BSNAME=""  D
 . S BSNR=BS(BSNAME)
 . S NPATS=^TMP("SPN",$J,"IP","BS",BSNR)
 . S STAYS=^TMP("SPN",$J,"IP","BS",BSNR,"STAYS")
 . S DAYS=^TMP("SPN",$J,"IP","BS",BSNR,"DAYS")
 . S ^TMP($J,RETCNT)=BSNAME_"^"_NPATS_"^"_STAYS_"^"_DAYS_"^"_$FN($$MEDIAN^SPNLRU(STAYS,"^TMP(""SPN"","_$J_",""IP"",""BS"","""_BSNR_""",""DAYS"","),",",1)_"^EOL999"
 . S RETCNT=RETCNT+1
 Q
PIP3 ;
 ; ADM       Number of admissions (stays)
 ; DAYS      Number of days for these admissions
 ; I         High User Counter
 ; PID       Patient ID (Coded SSN)
 ; PNAME     Patient Name
 ; PSSN      Patient SSN
 N ADM,I,DAYS,PID,PNAME,PSSN
 S ^TMP($J,RETCNT)="BOS999^Highest Number of Stays^EOL999"
 S RETCNT=RETCNT+1
 S ^TMP($J,RETCNT)="HDR999^Patient Name^SSN^Stays^Days^EOL999"
 S RETCNT=RETCNT+1
 S ADM=""
 F I=1:1:HIUSERS S ADM=$O(^TMP("SPN",$J,"IP","HI","H1",ADM)) Q:ADM=""  D 
 . S DAYS=""
 . F  S DAYS=$O(^TMP("SPN",$J,"IP","HI","H1",ADM,DAYS)) Q:DAYS=""  D
 . . S PID=""
 . . F  S PID=$O(^TMP("SPN",$J,"IP","HI","H1",ADM,DAYS,PID)) Q:PID=""  D 
 . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . S ^TMP($J,RETCNT)=PNAME_"^"_PSSN_"^"_-ADM_"^"_-DAYS_"^EOL999"
 . . . S RETCNT=RETCNT+1
 Q
PIP4 ;
 N ADM,I,DAYS,PID,PNAME,PSSN
 S ^TMP($J,RETCNT)="BOS999^Highest Number of Days^EOL999"
 S RETCNT=RETCNT+1
 S ^TMP($J,RETCNT)="HDR999^Patient Name^SSN^Days^Stays^EOL999"
 S RETCNT=RETCNT+1
 S DAYS=""
 F I=1:1:HIUSERS S DAYS=$O(^TMP("SPN",$J,"IP","HI","H2",DAYS)) Q:DAYS=""  D
 . S ADM=""
 . F  S ADM=$O(^TMP("SPN",$J,"IP","HI","H2",DAYS,ADM)) Q:ADM=""  D
 . . S PID=""
 . . F  S PID=$O(^TMP("SPN",$J,"IP","HI","H2",DAYS,ADM,PID)) Q:PID=""  D 
 . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . S ^TMP($J,RETCNT)=PNAME_"^"_PSSN_"^"_-DAYS_"^"_-ADM_"^EOL999"
 . . . S RETCNT=RETCNT+1
 Q
