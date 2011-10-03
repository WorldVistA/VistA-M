SPNLGRRX ; ISC-SF/GMB - SCD GATHER OUTPATIENT PHARMACY DATA;11 MAY 94 [ 08/08/94  1:26 PM ] ;6/23/95  11:42
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
ROLLUP(DFN,FDATE,TDATE,HI) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; HI        1=keep track of individual patient usage
 ;           0=don't keep track
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"RX",
 ; with the following nodes:
 ; "PAT")                # patients with at least 1 fill
 ; "FILLS")              # fills of all drugs
 ; "FILLS",-fills)       # patients with this many fills of all drugs
 ; "COST",-cost)         # patients whose total drug cost is in this
 ;                       dollar range (cost thru cost+99)
 ; "VAL",-value)         # patients whose total drug value is in this
 ;                       dollar range (value thru value+99)
 ; "DRUG",drugnr)        # fills for this drug
 ; "DRUG",drugnr,"NAME") name of this drug
 ; "DRUG",drugnr,"PAT")  # patients who had this drug
 ; "DRUG",drugnr,"COST") actual cost of all fills for this drug
 ; "DRUG",drugnr,"VAL")  current value of all fills for this drug
 ; "DRUG",drugnr,"QTY")  total quantity of all fills for this drug
 ; "DRUG",drugnr,"FILLS",-fills)  # patients who had this many fills of this drug
 ; ...and track usage by individual patient ranked by:
 ; "HI","H1",-fills,-diff drugs,-cost,DFN)
 ; "HI","H2",-cost,-fills,-diff drugs,DFN)
 ; "HI","H3",-fills,-diff drugs,-value,DFN)
 ; "HI","H4",-value,-fills,-diff drugs,DFN)
 N EXPDATE,RECNR,ZEROREC,TWOREC,ZDRUGNR,FILLS,COST,RANGE,UNITVAL
 N FILLDATE,QTY,SUBRECNR,TOTFILLS,TOTCOST,TOTVAL,NDDRUGS
 I '$D(TDATE) S TDATE=DT
 ; We are interested in any drug whose prescription 'expiration' or
 ; 'cancel' date falls on or after the 'from' date.
 ; We are going to take only the fills or refills which occurred
 ; during the 'from'-'thru' date range.
 S (TOTFILLS,TOTCOST)=0
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
 . . S (FILLS,COST,QTY)=0
 . . I FILLDATE'<FDATE,FILLDATE'>TDATE D TRACKIT(.FILLS,.COST,.QTY,$P(ZEROREC,U,7),$P(ZEROREC,U,17))
 . . S SUBRECNR=0 ; for each refill of the drug
 . . F  S SUBRECNR=$O(^PSRX(RECNR,1,SUBRECNR)) Q:SUBRECNR'>0  D
 . . . S ZEROREC=$G(^PSRX(RECNR,1,SUBRECNR,0))
 . . . S FILLDATE=$P(ZEROREC,U,1)
 . . . Q:FILLDATE<FDATE!(FILLDATE>TDATE)
 . . . D TRACKIT(.FILLS,.COST,.QTY,$P(ZEROREC,U,4),$P(ZEROREC,U,11))
 . . Q:'FILLS
 . . S TOTFILLS=TOTFILLS+FILLS
 . . S TOTCOST=TOTCOST+COST
 . . S FILLS(ZDRUGNR)=$G(FILLS(ZDRUGNR))+FILLS
 . . S QTY(ZDRUGNR)=$G(QTY(ZDRUGNR))+QTY
 . . S ^("COST")=$G(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"COST"))+COST
 Q:TOTFILLS=0
 S ^("PAT")=$G(^TMP("SPN",$J,"RX","PAT"))+1
 S ^("FILLS")=$G(^TMP("SPN",$J,"RX","FILLS"))+TOTFILLS
 S ^(-TOTFILLS)=$G(^TMP("SPN",$J,"RX","FILLS",-TOTFILLS))+1
 S RANGE=TOTCOST\100*100
 S ^(-RANGE)=$G(^TMP("SPN",$J,"RX","COST",-RANGE))+1
 S (TOTVAL,NDDRUGS)=0,ZDRUGNR="" ; for each drug
 F  S ZDRUGNR=$O(FILLS(ZDRUGNR)) Q:ZDRUGNR=""  D
 . S NDDRUGS=NDDRUGS+1 ; number of different drugs
 . S ^("PAT")=$G(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"PAT"))+1
 . S FILLS=FILLS(ZDRUGNR)
 . S ^(ZDRUGNR)=$G(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR))+FILLS
 . S ^(-FILLS)=$G(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"FILLS",-FILLS))+1
 . S ^("QTY")=$G(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"QTY"))+QTY(ZDRUGNR)
 . S UNITVAL=+$P($G(^PSDRUG(ZDRUGNR,660)),U,6) ; current price
 . S TOTVAL=QTY(ZDRUGNR)*UNITVAL+TOTVAL
 S RANGE=TOTVAL\100*100
 S ^(-RANGE)=$G(^TMP("SPN",$J,"RX","VAL",-RANGE))+1
 Q:'HI
 S ^TMP("SPN",$J,"RX","HI","H1",-TOTFILLS,-NDDRUGS,-TOTCOST,DFN)=""
 S ^TMP("SPN",$J,"RX","HI","H2",-TOTCOST,-TOTFILLS,-NDDRUGS,DFN)=""
 S ^TMP("SPN",$J,"RX","HI","H3",-TOTFILLS,-NDDRUGS,-TOTVAL,DFN)=""
 S ^TMP("SPN",$J,"RX","HI","H4",-TOTVAL,-TOTFILLS,-NDDRUGS,DFN)=""
 Q
TRACKIT(FILLS,COST,QTY,FILLQTY,UNITCOST) ;
 S FILLS=FILLS+1
 S COST=UNITCOST*FILLQTY+COST
 S QTY=QTY+FILLQTY
 Q
NAMEIT ; names the drugs and gives current value of dispensed quantities
 N ZDRUGNR,UNITVAL,ZDRUGNAM
 S ZDRUGNR="" ; We might have a drug number which is zero...
 F  S ZDRUGNR=$O(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR)) Q:ZDRUGNR=""  D
 . S ZDRUGNAM=$P($G(^PSDRUG(ZDRUGNR,0)),U,1)
 . I ZDRUGNAM="" S ZDRUGNAM="Not Identified"
 . S ^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"NAME")=ZDRUGNAM
 . S UNITVAL=+$P($G(^PSDRUG(ZDRUGNR,660)),U,6) ; current price
 . S ^("VAL")=$G(^TMP("SPN",$J,"RX","DRUG",ZDRUGNR,"QTY"))*UNITVAL
 Q
