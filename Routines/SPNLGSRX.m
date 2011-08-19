SPNLGSRX ; ISC-SF/GMB - SCD GATHER (SPECIFIC) OUTPATIENT PHARMACY DATA;16 JUN 94 [ 07/02/94  4:24 PM ] ;6/23/95  11:49
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
SELECT(DFN,FDATE,TDATE,HI,QLIST) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; HI        1=keep track of individual patient usage
 ;           0=don't keep track
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"RX",
 ; with the following nodes:
 ; "DRUG",drugnr)        # fills for this drug
 ; "DRUG",drugnr,"NAME") name of this drug
 ; "DRUG",drugnr,"PAT")  # patients who had this drug
 ; "DRUG",drugnr,"PRICE")  current unit price (cost) of this drug
 ; "DRUG",drugnr,"QTY")  total quantity of all fills for this drug
 ; "DRUG",drugnr,"PID",patient name^SSN)  fills^qty
 N EXPDATE,RECNR,ZEROREC,TWOREC,ZDRUGNR,FILLS,UNITVAL,PNAME,PSSN
 N FILLDATE,QTY,SUBRECNR
 I '$D(TDATE) S TDATE=DT
 ; We are interested in any drug whose prescription 'expiration' or
 ; 'cancel' date falls on or after the 'from' date.
 ; We are going to take only the fills or refills which occurred
 ; during the 'from'-'thru' date range.
 S EXPDATE=FDATE-.000001 ; for each expiration date
 F  S EXPDATE=$O(^PS(55,DFN,"P","A",EXPDATE)) Q:EXPDATE'>0  D
 . S RECNR=0 ; for each prescription on that date
 . F  S RECNR=$O(^PS(55,DFN,"P","A",EXPDATE,RECNR)) Q:RECNR'>0  D
 . . S TWOREC=$G(^PSRX(RECNR,2)) ; follow ptr to get prescripton info
 . . Q:TWOREC=""
 . . S FILLDATE=$P(TWOREC,U,2)
 . . Q:FILLDATE>TDATE
 . . S ZEROREC=$G(^PSRX(RECNR,0))
 . . Q:ZEROREC=""
 . . S ZDRUGNR=+$P(ZEROREC,U,6)
 . . Q:'$D(QLIST(ZDRUGNR))
 . . S (FILLS,QTY)=0
 . . I FILLDATE'<FDATE,FILLDATE'>TDATE D TRACKIT(.FILLS,.QTY,$P(ZEROREC,U,7))
 . . S SUBRECNR=0 ; for each refill of the drug
 . . F  S SUBRECNR=$O(^PSRX(RECNR,1,SUBRECNR)) Q:SUBRECNR'>0  D
 . . . S ZEROREC=$G(^PSRX(RECNR,1,SUBRECNR,0))
 . . . S FILLDATE=$P(ZEROREC,U,1)
 . . . Q:FILLDATE<FDATE!(FILLDATE>TDATE)
 . . . D TRACKIT(.FILLS,.QTY,$P(ZEROREC,U,4))
 . . Q:'FILLS
 . . S FILLS(ZDRUGNR)=$G(FILLS(ZDRUGNR))+FILLS
 . . S QTY(ZDRUGNR)=$G(QTY(ZDRUGNR))+QTY
 Q:$D(FILLS)<10  ; make sure this array has descendants
 D:HI GETNAME^SPNLRU(DFN,.PNAME,.PSSN)
 S ZDRUGNR="" ; for each drug
 F  S ZDRUGNR=$O(FILLS(ZDRUGNR)) Q:ZDRUGNR=""  D
 . S ^("PAT")=$G(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"PAT"))+1
 . S FILLS=FILLS(ZDRUGNR)
 . S ^(ZDRUGNR)=$G(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR))+FILLS
 . S ^("QTY")=$G(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"QTY"))+QTY(ZDRUGNR)
 . S:HI ^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"PID",PNAME_U_PSSN)=FILLS_U_QTY
 Q
TRACKIT(FILLS,QTY,FILLQTY) ;
 S FILLS=FILLS+1
 S QTY=QTY+FILLQTY
 Q
PRICEIT ; gets the current unit price (cost) of each of the drugs
 N ZDRUGNR,UNITVAL
 S ZDRUGNR="" ; We might have a drug number which is zero...
 F  S ZDRUGNR=$O(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR)) Q:ZDRUGNR=""  D
 . S UNITVAL=+$P($G(^PSDRUG(ZDRUGNR,660)),U,6) ; current price
 . S ^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"PRICE")=UNITVAL
 Q
