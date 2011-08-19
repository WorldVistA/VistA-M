SPNLGEDM ; ISC-SF/GMB - SCD GATHER DEMOGRAPHICS DATA;23 MAY 94 [ 07/11/94  8:18 AM ] ;6/23/95  12:09
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
EXTRACT(DFN,FDATE,TDATE,CLEARTXT,ABORT) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; CLEARTXT  1=translate all codes to their meaning,
 ;           0=don't translate codes (default=0)
 N VADM,VAEL,VASV,VASE,VAPA,SSN,DEMDATA,ELIGDATA,SVCDATA,ADDRDATA
 Q:'$D(^DPT(DFN,0))
 D DEM^VADPT ; DOB,Sex,Date of Death
 ;           ; (DOB has 00 for days)
 S DEMDATA=$E($P(VADM(3),U,1),1,5)_"00^"_$P(VADM(5),U,1)_"^"_$P(VADM(6),U,1)
 D ELIG^VADPT ; External, not code:  Eligibility,Period of Service,Means Test Status
 S ELIGDATA=$P(VAEL(1),U,2)_"^"_$P(VAEL(2),U,2)_"^"_$P(VAEL(9),U,2)
 D SVC^VADPT
 S SVCDATA=$P(VASV(6,5),U,1) ; Service Separation Date
 D ADD^VADPT ; line1,line2,line3,city,state,zip,phone
 ;           ; (state is ptr to STATE file)
 S ADDRDATA=VAPA(1)_"^"_VAPA(2)_"^"_VAPA(3)_"^"_VAPA(4)_"^"_$P(VAPA(5),U,1)_"^"_VAPA(6)_"^"_VAPA(8)
 D ADDREC^SPNLGE("DM",DEMDATA_"^"_ELIGDATA_"^"_SVCDATA_"^"_ADDRDATA)
 Q
