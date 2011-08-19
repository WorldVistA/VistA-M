SPNLGIFU ; ISC-SF/GMB - SCD GATHER PATIENT FOLLOW-UP LOSS RISKS; 4 JUL 94 [ 07/11/94  8:43 AM ] ;6/23/95  11:30
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
GATHER(DFN,FDATE,TDATE,SINCE)  ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; Gathers patients who have not been seen since the SINCE date.
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"FU",
 ; with the following nodes:
 ; date last seen,name^ssn)    =""
 N VADM,VA,ISDEAD,SSNLAST4,SEEN,LASTSEEN,NAME
 ;N SEENIP,SEENOP,SEENCH,SEENRX,SEENRA
 D DEM^VADPT ; Get patient demographics
 ; We will ignore dead patients 
 S ISDEAD=+$P($G(VADM(6)),U,1)
 Q:ISDEAD
 S NAME=VADM(1)
 S SSNLAST4=VA("BID")
 D SEEN^SPNLGUSN(DFN,FDATE,TDATE,.SEEN,.LASTSEEN) ;,.SEENIP,.SEENOP,.SEENCH,.SEENRX,.SEENRA)
 I LASTSEEN<SINCE S ^TMP("SPN",$J,"FU",LASTSEEN,NAME_"^"_SSNLAST4)=""
 Q
