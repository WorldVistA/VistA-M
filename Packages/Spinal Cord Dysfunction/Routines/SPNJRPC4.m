SPNJRPC4 ;BP/JAS - Returns Inpatient/Outpatient Specific for list of pats ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DIC(40.7,"B" supported by IA #4929
 ; Reference to ^DIC(40.7,D0,0 supported by IA #557
 ; Reference to ^DIC(42.4,"B" supported by IA #4946
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ; API SELECT^SPNLGSOP is part of Spinal Cord version 2.0
 ; API SELECT^SPNLGSIP is part of Spinal Cord version 2.0
 ;
 ; Parm values:
 ;     RETURN is the sorted data from the earliest date of listing
 ;     ICNLST is the list of patient ICNs to process
 ;     FDATE is the start date for period
 ;     TDATE is the end date for period
 ;     CLINSTP is a list of clinic stops to search for
 ;     SPECLTY is the type of specialties to search for
 ;     HIUSERS determines whether patient usage data will be sent
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICNLST,FDATE,TDATE,CLINSTP,SPECLTY,HIUSERS)  ;
 ;***************************
 K ^TMP($J),^TMP("SPN",$J),QLIST
 S RETURN=$NA(^TMP($J)),RETCNT=1
 S X=FDATE S %DT="T" D ^%DT S FDATE=Y
 S X=TDATE S %DT="T" D ^%DT S TDATE=Y
 ;***************************
 F CLNNM=1:1:$L(CLINSTP,"^") D
 . S CLIN=$P($P(CLINSTP,"^",CLNNM),";;",1),CLINNM=$P($P(CLINSTP,"^",CLNNM),";;",2)
 . ;JAS - 05/14/08 - DEFECT 1090
 . ;I CLIN'="",$D(^DIC(40.7,"B",CLIN)) S CLINDA="" F  S CLINDA=$O(^DIC(40.7,"B",CLIN,CLINDA)) Q:CLINDA=""  D
 . I CLIN'="",$D(^DIC(40.7,"B",CLIN)) S CLINDA=0 F  S CLINDA=$O(^DIC(40.7,"B",CLIN,CLINDA)) Q:CLINDA=""  D
 . . Q:'$D(^DIC(40.7,CLINDA))
 . . Q:CLINNM'=$P(^DIC(40.7,CLINDA,0),"^",2)
 . . S QLIST("SC",CLINNM)=CLIN
 F SPCNM=1:1:$L(SPECLTY,"^") S SPEC=$P(SPECLTY,"^",SPCNM) D
 . ;JAS - 05/14/08 - DEFECT 1090
 . ;I SPEC'="",$D(^DIC(42.4,"B",SPEC)) S SPECDA=$O(^DIC(42.4,"B",SPEC,"")) D
 . I SPEC'="",$D(^DIC(42.4,"B",SPEC)) S SPECDA=$O(^DIC(42.4,"B",SPEC,0)) D
 . . S QLIST("BS",SPECDA)=SPEC
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 I HIUSERS D
 . I $D(QLIST("SC")) D OUTPAT
 . I $D(QLIST("BS")) D INPAT
 E  D
 . I $D(QLIST("SC")) D OUTPAT2
 . I $D(QLIST("BS")) D INPAT2
 D CLNUP
 Q
IN Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 D SELECT^SPNLGSOP(DFN,FDATE,TDATE,HIUSERS,.QLIST)
 D SELECT^SPNLGSIP(DFN,FDATE,TDATE,HIUSERS,.QLIST)
 Q
OUTPAT ;
 ; SCNAME    Clinic Stop Name
 ; SCNUM     Clinic Stop Number
 ; STOPS     Number of stops at a Clinic Stop
 ; NPATS     Number of patients
 ; VISITS    Number of visits to a Clinic Stop
 N VISITS,SCNAME,NPATS,STOPS,SCNUM,PNAME,PSSN,PID,PDATA
 S ^TMP($J,RETCNT)="PAT999^Selected Outpatient Activity^EOL999"
 S RETCNT=RETCNT+1
 S SCNUM="" ; list clinics in stop code number order
 F  S SCNUM=$O(QLIST("SC",SCNUM)) Q:SCNUM=""  D
 . S SCNAME=QLIST("SC",SCNUM)
 . S NPATS=+$G(^TMP("SPN",$J,"OP","SC",SCNUM))
 . S VISITS=+$G(^TMP("SPN",$J,"OP","SC",SCNUM,"VISITS"))
 . S STOPS=+$G(^TMP("SPN",$J,"OP","SC",SCNUM,"STOPS"))
 . S ^TMP($J,RETCNT)="BOS999^"_SCNUM_"^"_SCNAME_"^EOL999"
 . S RETCNT=RETCNT+1
 . S ^TMP($J,RETCNT)="TOT999^Totals:  "_$FN(NPATS,",")_" patient"_$S(NPATS=1:"",1:"s")_"^"_$FN(VISITS,",",2)_"^"_STOPS_"^EOL999"
 . S RETCNT=RETCNT+1
 . S ^TMP($J,RETCNT)="HDR999^Patient Name^SSN^Visits^Stops^EOL999"
 . S RETCNT=RETCNT+1
 . S PID=""
 . F  S PID=$O(^TMP("SPN",$J,"OP","SC",SCNUM,"PID",PID)) Q:PID=""  D
 . . S PNAME=$P(PID,U,1),PSSN=$P(PID,U,2)
 . . S PDATA=^TMP("SPN",$J,"OP","SC",SCNUM,"PID",PID)
 . . S VISITS=+$P(PDATA,U,1),STOPS=+$P(PDATA,U,2)
 . . S ^TMP($J,RETCNT)="PATDETAIL999^"_PNAME_"^"_PSSN_"^"_$FN(VISITS,",",2)_"^"_STOPS_"^EOL999"
 . . S RETCNT=RETCNT+1
 Q
INPAT ;
 ; BS        Bed Section Array
 ; BSNAME    Bed Section Name
 ; BSNR      Bed Section Number
 ; DAYS      Number of days spent in a bed section
 ; NPATS     Number of patients
 ; STAYS     Number of stays in a bed section
 N STAYS,BSNAME,NPATS,DAYS,BS,BSNR,PNAME,PSSN,PID,PDATA
 S ^TMP($J,RETCNT)="PAT999^Selected Inpatient Activity^EOL999"
 S RETCNT=RETCNT+1
 S BSNR="" ; create list in bed section name order
 F  S BSNR=$O(QLIST("BS",BSNR)) Q:BSNR=""  D
 . S BS(QLIST("BS",BSNR))=BSNR
 S BSNAME=""
 F  S BSNAME=$O(BS(BSNAME)) Q:BSNAME=""  D
 . S BSNR=BS(BSNAME)
 . S NPATS=+$G(^TMP("SPN",$J,"IP","BS",BSNR))
 . S STAYS=+$G(^TMP("SPN",$J,"IP","BS",BSNR,"STAYS"))
 . S DAYS=+$G(^TMP("SPN",$J,"IP","BS",BSNR,"DAYS"))
 . S ^TMP($J,RETCNT)="BOS999^"_BSNAME_"^EOL999"
 . S RETCNT=RETCNT+1
 . S ^TMP($J,RETCNT)="TOT999^Totals:  "_$FN(NPATS,",")_" patient"_$S(NPATS=1:"",1:"s")_"^"_STAYS_"^"_DAYS_"^EOL999"
 . S RETCNT=RETCNT+1
 . S ^TMP($J,RETCNT)="HDR999^Patient Name^SSN^Stay^Days^EOL999"
 . S RETCNT=RETCNT+1
 . S PID=""
 . F  S PID=$O(^TMP("SPN",$J,"IP","BS",BSNR,"PID",PID)) Q:PID=""  D
 . . S PNAME=$P(PID,U,1),PSSN=$P(PID,U,2)
 . . S PDATA=^TMP("SPN",$J,"IP","BS",BSNR,"PID",PID)
 . . S STAYS=$P(PDATA,U,1),DAYS=$P(PDATA,U,2)
 . . S ^TMP($J,RETCNT)="PATDETAIL999^"_PNAME_"^"_PSSN_"^"_STAYS_"^"_DAYS_"^EOL999"
 . . S RETCNT=RETCNT+1
 Q
OUTPAT2 ;
 ; SCNAME    Clinic Stop Name
 ; SCNUM     Clinic Stop Number
 ; STOPS     Number of stops at a Clinic Stop
 ; NPATS     Number of patients
 ; VISITS    Number of visits to a Clinic Stop
 N VISITS,SCNAME,NPATS,STOPS,SC,SCNUM
 S ^TMP($J,RETCNT)="PAT999^Selected Outpatient Activity^EOL999"
 S RETCNT=RETCNT+1
 S ^TMP($J,RETCNT)="HDR999^Clinic^Patients^Visits^Stops^EOL999"
 S RETCNT=RETCNT+1
 S SCNUM="" ; list clinics in stop code number order
 F  S SCNUM=$O(QLIST("SC",SCNUM)) Q:SCNUM=""  D
 . S SCNAME=QLIST("SC",SCNUM)
 . S NPATS=+$G(^TMP("SPN",$J,"OP","SC",SCNUM))
 . S VISITS=+$G(^TMP("SPN",$J,"OP","SC",SCNUM,"VISITS"))
 . S STOPS=+$G(^TMP("SPN",$J,"OP","SC",SCNUM,"STOPS"))
 . S ^TMP($J,RETCNT)="TOT999^"_SCNUM_"^"_SCNAME_"^"_NPATS_"^"_$FN(VISITS,",",2)_"^"_STOPS_"^EOL999"
 . S RETCNT=RETCNT+1
 Q
INPAT2 ;
 ; BS        Bed Section Array
 ; BSNAME    Bed Section Name
 ; BSNR      Bed Section Number
 ; DAYS      Number of days spent in a bed section
 ; NPATS     Number of patients
 ; STAYS     Number of stays in a bed section
 N STAYS,BSNAME,NPATS,DAYS,BS,BSNR
 S ^TMP($J,RETCNT)="PAT999^Selected Inpatient Activity^EOL999"
 S RETCNT=RETCNT+1
 S ^TMP($J,RETCNT)="HDR999^Specialty^Patients^Stays^Days^EOL999"
 S RETCNT=RETCNT+1
 S BSNR="" ; create list in bed section name order
 F  S BSNR=$O(QLIST("BS",BSNR)) Q:BSNR=""  D
 . S BS(QLIST("BS",BSNR))=BSNR
 S BSNAME=""
 F  S BSNAME=$O(BS(BSNAME)) Q:BSNAME=""  D
 . S BSNR=BS(BSNAME)
 . S NPATS=+$G(^TMP("SPN",$J,"IP","BS",BSNR))
 . S STAYS=+$G(^TMP("SPN",$J,"IP","BS",BSNR,"STAYS"))
 . S DAYS=+$G(^TMP("SPN",$J,"IP","BS",BSNR,"DAYS"))
 . S ^TMP($J,RETCNT)="TOT999^"_BSNAME_"^"_NPATS_"^"_STAYS_"^"_DAYS_"^EOL999"
 . S RETCNT=RETCNT+1
 Q
CLNUP ;
 K %DT,AICN,CLIN,CLINDA,CLINNM,CLNNM,DFN,ICN,ICNNM,PATLIST,RETCNT
 K SPCNM,SPEC,SPECDA,SPN,X,Y
 Q
