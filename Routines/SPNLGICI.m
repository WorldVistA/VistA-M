SPNLGICI ; ISC-SF/GMB - SCD GATHER CURRENT INPATIENT DATA; 4 JUL 94 [ 09/21/94  9:48 AM ] ;6/23/95  11:29
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
GATHER(DFN,FDATE) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date                (IGNORED)
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"CI",   (The node at this level has the total inpatient count)
 ; with the following nodes:
 ; ward,name^ssn)        admit date^curr los^fytd los^room bed^diagnosos
 N VADM,VA,NAME,SSNLAST4,WARD,VAIP,CURRLOS,FYTDLOS,CURRADM,ROOMBED,DIAG
 D IN5^VADPT ; Is patient an inpatient right now?
 S WARD=$P($G(VAIP(5)),U,2)
 Q:WARD=""
 S ROOMBED=$P($G(VAIP(6)),U,2) ; Room Bed
 S DIAG=$G(VAIP(9)) ; Diagnosis
 S FDATE=$E(DT,1,3)_"1001" ; Set FDATE to the start of the FY
 I FDATE>DT S FDATE=FDATE-10000
 D DEM^VADPT ; Get patient demographics
 S NAME=VADM(1)
 S SSNLAST4=VA("BID")
 D ADMIT
 S ^TMP("SPN",$J,"CI",WARD,NAME_"^"_SSNLAST4)=CURRADM_"^"_CURRLOS_"^"_FYTDLOS_"^"_ROOMBED_"^"_DIAG
 S ^("CI")=$G(^TMP("SPN",$J,"CI"))+1 ; count of current inpatients
 Q
ADMIT ;
 N RECNR,NODE0,NODE70,ZDD,ZAD,X,X1,X2
 S (CURRADM,CURRLOS,FYTDLOS,RECNR)=0
 F  S RECNR=$O(^DGPT("B",DFN,RECNR)) Q:RECNR=""  D
 . S NODE0=$G(^DGPT(RECNR,0))
 . Q:$P(NODE0,U,11)'=1  ; 1=PTF record, 2=census record
 . S NODE70=$G(^DGPT(RECNR,70))
 . S ZDD=$P(NODE70,U,1) ; Discharge date
 . Q:ZDD'=""&(ZDD<FDATE)
 . S ZAD=$P(NODE0,U,2) ; Admit date
 . S X2=$S(ZAD<FDATE:FDATE,1:ZAD)
 . S X1=$S(ZDD="":DT,1:ZDD)
 . D ^%DTC
 . S FYTDLOS=FYTDLOS+X+1
 . Q:ZDD'=""
 . S CURRADM=ZAD
 . I ZAD<FDATE D  ;If current admission date is prior to this FY,
 . . S X1=DT,X2=ZAD ;then redo the calculation to get the full number
 . . D ^%DTC ;of admit days.
 . S CURRLOS=X+1
 Q
