BPSOSH2 ;BHAM ISC/SD/lwj/DLF - Assemble formatted claim ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,8,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Changes for NCPDP 5.1
 ;    5.1 has 14 claim segments (header, patient, insurance, claim
 ;                                pharmacy provider, prescriber,
 ;                                COB, workers comp, DUR, Pricing,
 ;                                coupon, compound, prior auth,
 ;                                clinical)
 ;    5.1 requires field identifiers and separators on all fields
 ;        other than the header
 ;    5.1 segment separators are required prior to each segment
 ;        following the header
 ;    5.1  Group separators appear at the end of each
 ;        transaction (prescription)
 ;    5.1 we only want to send segments that have data - a new
 ;        segment record will hold the data until we are sure
 ;        we have something to send
 ;
 ; Changes for NCPDP D.0
 ;    D.0 added 3 new request segments (additional documentation,
 ;                                      facility, narrative)
 ;
 ;
 ;Put together ascii formatted record via NCPDP Record definition
 ;
 ; Input:  
 ;   NODES  = "100^110^120" or "130^140^150^160^170^180^190^200^210^220^230^240^250^260"
 ; passed by Ref:
 ;  .IEN = Internal Entry Number array
 ;  .BPS = Formatted Data Array with claim and transaction data
 ;  .REC      - Formatted Ascii record (result)
XLOOP(NODES,IEN,BPS,REC) ;EP - from BPSECA1
 ;
 N DATAFND,FDATA,FLAG,FLDDATA,FLDID,FLDIEN,FLDNUM,INDEX,MDATA,NODE,ORDER,PMODE,RECMIEN,SEGREC
 N VER,TYPE
 ;
 ; Get payer sheet version and transaction type
 S VER=$P($G(^BPSF(9002313.92,+$G(IEN(9002313.92)),1)),U,2)
 S TYPE=$G(BPS(9002313.02,+$G(IEN(9002313.02)),103,"I"))
 ;
 ; Loop through the NODES variable delimited by U
 F INDEX=1:1:$L(NODES,U) D
 . S NODE=$P(NODES,U,INDEX) Q:NODE=""
 . ;
 . ; VA does not support these nodes
 . Q:",260,250,240,230,220,210,200,170,140,"[NODE
 . ;
 . ; Quit if the payer sheet does not have the node
 . Q:'$D(^BPSF(9002313.92,+IEN(9002313.92),NODE,0))
 . ;
 . ; Per NCPDP standard, reversals do not support segments listed below
 . I TYPE="B2",",260,250,240,230,220,210,200,170,150,140,"[NODE Q
 . I TYPE="B2",VER=51,NODE=160 Q  ;COB segment not supported in a 51 reversal
 . I TYPE="B2",VER="D0",NODE=110 Q  ;Patient segment not supported in a D0 reversal
 . ;
 . ; Per NCPDP standard, eligibility does not support segments listed below
 . I TYPE="E1",",260,250,230,220,210,200,190,180,170,160,130,"[NODE Q
 . ;
 . S DATAFND=0  ; indicates if data is on the segment for us to send
 . S SEGREC=""  ; segment's information
 . ;
 . D:NODE=180 PROCDUR
 . ;
 . ;COB fields
 . D:NODE=160 PROCCOB
 . ;
 . S ORDER=""
 . F  D  Q:'ORDER
 .. ;
 .. Q:NODE=180  ; DUR/PPS section (repeating), already processed
 .. Q:NODE=160  ; COB data processed earlier
 .. S ORDER=$O(^BPSF(9002313.92,+IEN(9002313.92),NODE,"B",ORDER))
 .. Q:'ORDER
 .. S RECMIEN=""
 .. S RECMIEN=$O(^BPSF(9002313.92,+IEN(9002313.92),NODE,"B",ORDER,RECMIEN))
 .. Q:RECMIEN=""
 .. ;
 .. S MDATA=$G(^BPSF(9002313.92,+IEN(9002313.92),NODE,RECMIEN,0))
 .. Q:MDATA=""
 .. ;
 .. S FLDIEN=$P(MDATA,U,2)
 .. Q:FLDIEN=""
 .. ;
 .. S FDATA=$G(^BPSF(9002313.91,FLDIEN,0))
 .. Q:FDATA=""
 .. S FLDNUM=$P(FDATA,U,1)
 .. Q:FLDNUM=""
 .. ;
 .. S FLDID=$P($G(^BPSF(9002313.91,FLDIEN,5)),U)  ; BPS NCPDP FIELD DEFS, (#.06) ID
 .. ;
 .. ;header data
 .. S:NODE<130 FLDDATA=$G(BPS(9002313.02,IEN(9002313.02),FLDNUM,"I"))
 .. ;
 .. ;transaction data
 .. S:NODE>120 FLDDATA=$G(BPS(9002313.0201,IEN(9002313.0201),FLDNUM,"I"))
 .. ;
 .. I FLDID'=$TR(FLDDATA,"0 {}") S DATAFND=1 ;fld chk-is the field empty?
 .. ;
 .. ;check if this is the seg id - call this after fld chk since
 .. ;we don't want to send the segment if this is all there is
 .. I (NODE>100)&(FLDNUM=111) S FLDDATA=$$SEGID(NODE)
 .. ;
 .. ; Special code to handle the Submission Clarification Code (420),
 .. ; which is a repeating group in version D.0
 .. I FLDNUM=420 D SUBCLAR(.DATAFND,.IEN,.SEGREC) Q
 .. ;
 .. ; Special code to handle the Other Amount Claimed repeating group
 .. I FLDNUM=480 D OAMTCLMD(.DATAFND,.IEN,.SEGREC) Q
 .. I FLDNUM=479 Q  ; fields 479 & 480 handled as a pair in OAMTCLMD
 .. ;
 .. Q:FLDDATA=""   ;lje;7/23/03; don't want extra field separators when field is blank for testing for WebMD.
 .. ;
 .. S:NODE=100 SEGREC=SEGREC_FLDDATA  ;no FS on the header rec
 .. S:NODE>100 SEGREC=SEGREC_$C(28)_FLDDATA  ;FS always proceeds fld
 ..;
 . I (DATAFND)&(NODE=100) S REC(NODE)=SEGREC   ;no SS when it's the header
 . I (DATAFND)&(NODE>100) D
 .. I '$D(REC(NODE)) S REC(NODE)=REC I REC[$C(29) S REC=""
 .. S REC(NODE)=REC(NODE)_$C(30)_SEGREC  ;SS before the seg
 ;
 Q
 ;
SEGID(ND) ; function, returns Segment ID
 ; Field 111 is the Segment Identifier - for each segment, other than
 ; the header, a unique value must be sent in this field
 ; to identify which segment is being sent.  This value is not stored
 ; in the claim - as it changes with each of the 13 segments. The
 ; field does appear as part of the NCPDP Format, but is simply not stored.
 ;    01 = Patient   02 = Pharmacy Provider    03 = Prescriber
 ;    04 = Insurance 05 = COB/Other Payment    06 = Workers' Comp
 ;    07 = Claim     08 = DUR/PPS              09 = Coupon
 ;    10 = Compound  11 = Pricing              12 = Prior Auth
 ;    13 = Clinical  14 = Additional Doc       15 = Facility
 ;    16 = Narrative
 ;
 N FLD
 ;
 S FLD=$S(ND=110:"01",ND=120:"04",ND=130:"07",ND=140:"02",ND=150:"03",ND=160:"05",ND=170:"06",ND=180:"08",ND=190:11,ND=200:"09",ND=210:10,ND=220:12,ND=230:13,ND=240:14,ND=250:15,ND=260:16,1:"00")
 S FLD="AM"_$$NFF^BPSECFM(FLD,2)
 ;
 Q FLD
 ;
PROCDUR ; The DUR/PPS segment can repeat itself for any given
 ; transaction within a claim.  This means we have to have special
 ; programming to handle the repeating fields.
 ;
 ; Input Data
 ;   BPS array - Set in BPSOSC* routines
 ;   IEN array - Contain IEN information for the BPS NCPDP FORMAT file
 ;   NODE - Multiple of the BPS NCPDP FORMAT file
 ; Input/Output Data
 ;   SEGREC - This is data for the segment being created
 ;   DATAFND - Flag indicating if there is legitimate data for the segment
 ;
 N FIELD,DUR,FLD,ORD,FLDIEN,FLDID,FLDDATA
 ;
 ; If there isn't any data in this segment then quit
 Q:'$D(BPS(9002313.1001))
 ;
 ; Second thing - create the 111 field entry as it is not repeating
 S FLDDATA=$$SEGID(NODE)
 S SEGREC=SEGREC_$C(28)_FLDDATA  ;FS always proceeds fld
 ;
 ; Next- let's look to the format to see which DUR/PPS fields are
 ; needed (remember - ALL fields on the DUR/PPS segment are optional)
 D GETFLDS^BPSOSHF(+IEN(9002313.92),NODE,.FIELD)
 ;
 ; Finally -loop through and process the fields for as many times
 ; as they appear
 S DUR=0
 F  S DUR=$O(BPS(9002313.1001,DUR)) Q:DUR=""  D
 . S ORD=0
 . F  S ORD=$O(FIELD(ORD)) Q:ORD=""  D
 .. S FLDIEN=$P(FIELD(ORD),U)
 .. S FLD=$P(FIELD(ORD),U,2)
 .. S:FLD=473 FLD=.01   ;473 value stored in the .01 field
 .. S FLDID=$P($G(^BPSF(9002313.91,FLDIEN,5)),U)  ; BPS NCPDP FIELD DEFS, (#.06) ID
 .. ; Transaction data
 .. S FLDDATA=$G(BPS(9002313.1001,DUR,FLD,"I"))
 .. I FLDDATA="" Q
 .. ;
 .. I FLDID'=$TR(FLDDATA,"0 {}") S DATAFND=1 ;fld chk-is the fld empty?
 .. ;
 .. S SEGREC=SEGREC_$C(28)_FLDDATA  ;FS always proceeds fld
 ;
 Q
 ;
PROCCOB ;The COB OTHER PAYMENTS segment can repeat itself for any given
 ; transaction within a claim.  This means we have to have special
 ; programming to handle the repeating fields.
 ;
 ; Note that BPS array is set in BPSOSC* routines
 ;
 N FIELD,BPCOB,FLD,ORD
 ;
 ; If there isn't any data in this segment quit
 Q:'$D(BPS(9002313.0401))
 ;
 ; create the 111 field entry as it is not repeating
 S FLDDATA=$$SEGID(NODE)
 S SEGREC=SEGREC_$C(28)_FLDDATA  ; FS always proceeds fld
 ;
 ; look to the format to see which COB fields are needed 
 D GETFLDS^BPSOSHF(+IEN(9002313.92),NODE,.FIELD)
 ;
 ; loop through and process fields for as many times as they appear
 S BPCOB=0
 F  S BPCOB=$O(BPS(9002313.0401,BPCOB)) Q:BPCOB=""  D
 . S ORD=0
 . F  S ORD=$O(FIELD(ORD)) Q:ORD=""  D
 .. S FLDIEN=$P(FIELD(ORD),U)
 .. S FLD=$P(FIELD(ORD),U,2)
 .. S:FLD=337 FLD=.01   ; 473-7E value stored in the .01 field
 .. S FLDID=$P($G(^BPSF(9002313.91,FLDIEN,5)),U)  ; BPS NCPDP FIELD DEFS, (#.06) ID
 .. ; Transaction data
 .. S FLDDATA=$G(BPS(9002313.0401,BPCOB,FLD,"I"))
 .. ;
 .. Q:FLDDATA=""
 .. I $TR(FLDDATA,"0 {}")="HB" Q
 .. I $TR(FLDDATA,"0 {}")="5E" Q
 ..;
 ..I FLDID'=$TR(FLDDATA,"0 {}") S DATAFND=1 ;fld chk-is the fld empty?
 ..S SEGREC=SEGREC_$C(28)_FLDDATA  ;FS always proceeds fld
 ..; handle repeating fields
 ..I FLD=471 D REJCODES ; (#471) OTHER PAYER REJECT COUNT
 ..I FLD=341 D AMTPAID  ; (#341) OTHER PAYER AMOUNT PAID COUNT
 ..I FLD=353 D PATPAID  ; (#353) OTHER PAYER-PATIENT RESPONSIBILITY COUNT
 ..I FLD=392 D BENSTAGE ; (#392) BENEFIT STAGE COUNT
 ;
 Q
 ;
AMTPAID ; (#342) OTHER PAYER AMT PAID QUALIFIER multiple
 N BPCOB,ORD,FLD,FLDID,FLDIEN,FLDDATA
 S BPCOB=0
 F  S BPCOB=$O(BPS(9002313.401342,BPCOB)) Q:BPCOB=""  D
 . S ORD=0
 . F  S ORD=$O(FIELD(ORD)) Q:ORD=""  D
 .. S FLDIEN=$P(FIELD(ORD),U)
 .. S FLD=$P(FIELD(ORD),U,2)
 .. S:FLD=342 FLD=.01   ;342 value stored in the .01 field
 .. S FLDID=$P($G(^BPSF(9002313.91,FLDIEN,5)),U)  ; BPS NCPDP FIELD DEFS, (#.06) ID
 .. ; Transaction data
 .. S FLDDATA=$G(BPS(9002313.401342,BPCOB,FLD,"I"))
 .. ;
 .. ;quit if null or blank
 .. Q:FLDDATA=""
 .. I FLDID'="HC",FLDID=$TR(FLDDATA," ") Q  ; blanks are ok for 342-HC, but not for 431-DV
 .. ;
 .. S DATAFND=1
 .. S SEGREC=SEGREC_$C(28)_FLDDATA  ;FS always proceeds fld
 Q
 ; 
REJCODES ; (#472) OTHER PAYER REJECT CODE
 N BPCOB,ORD,FLD,FLDID,FLDIEN,FLDDATA
 S BPCOB=0
 F  S BPCOB=$O(BPS(9002313.401472,BPCOB)) Q:BPCOB=""  D
 . S ORD=0
 . F  S ORD=$O(FIELD(ORD)) Q:ORD=""  D
 .. S FLDIEN=$P(FIELD(ORD),U)
 .. S FLD=$P(FIELD(ORD),U,2)
 .. S:FLD=472 FLD=.01   ;472 value stored in the .01 field
 .. S FLDID=$P($G(^BPSF(9002313.91,FLDIEN,5)),U)  ; BPS NCPDP FIELD DEFS, (#.06) ID
 .. ; Transaction data
 .. S FLDDATA=$G(BPS(9002313.401472,BPCOB,FLD,"I"))
 .. ;
 .. ;quit if null or blank
 .. Q:FLDDATA=""
 .. I FLDID=$TR(FLDDATA,"0 {}") Q
 .. ;
 .. I FLDID'=$TR(FLDDATA,"0 {}") S DATAFND=1 ;fld chk-is the fld empty?
 .. ;
 .. S SEGREC=SEGREC_$C(28)_FLDDATA  ;FS always proceeds fld
 Q
 ;
PATPAID ; (#353.01) OTHER PAYER-PATIENT RESPONSIBILITY multiple
 N BPCOB,ORD,FLD,FLDID,FLDIEN,FLDDATA
 S BPCOB=0
 F  S BPCOB=$O(BPS(9002313.401353,BPCOB)) Q:BPCOB=""  D
 . S ORD=0
 . F  S ORD=$O(FIELD(ORD)) Q:ORD=""  D
 .. S FLDIEN=$P(FIELD(ORD),U)
 .. S FLD=$P(FIELD(ORD),U,2)
 .. S FLDID=$P($G(^BPSF(9002313.91,FLDIEN,5)),U)  ; BPS NCPDP FIELD DEFS, (#.06) ID
 .. ; Transaction data
 .. S FLDDATA=$G(BPS(9002313.401353,BPCOB,FLD,"I"))
 .. ;
 .. ;quit if null or blank
 .. I FLDDATA=""!(FLDID=$TR(FLDDATA," ")) Q  ; Check for missing data or only field ID
 .. ;
 .. S DATAFND=1
 .. S SEGREC=SEGREC_$C(28)_FLDDATA  ;FS always proceeds fld
 Q
 ;
BENSTAGE ; (#392.01) BENEFIT STAGE MLTPL multiple
 ;
 N BPCOB,ORD,FLD,FLDID,FLDIEN,FLDDATA
 S BPCOB=0
 F  S BPCOB=$O(BPS(9002313.401392,BPCOB)) Q:BPCOB=""  D
 . S ORD=0
 . F  S ORD=$O(FIELD(ORD)) Q:ORD=""  D
 .. S FLDIEN=$P(FIELD(ORD),U)
 .. S FLD=$P(FIELD(ORD),U,2)
 .. S FLDID=$P($G(^BPSF(9002313.91,FLDIEN,5)),U)  ; BPS NCPDP FIELD DEFS, (#.06) ID
 .. ; Transaction data
 .. S FLDDATA=$G(BPS(9002313.401392,BPCOB,FLD,"I"))
 .. ;
 .. ;quit if null or blank
 .. I FLDDATA=""!(FLDID=$TR(FLDDATA," ")) Q  ; Check for missing data or only field ID
 .. ;
 .. S DATAFND=1
 .. S SEGREC=SEGREC_$C(28)_FLDDATA  ;FS always proceeds fld
 Q
 ;
SUBCLAR(DATAFND,BPSIEN,SEGREC) ;
 ; BPSIEN, SEGREC passed by ref., SEGREC is updated with repeating fields
 ; 420-DK Submission Clarification Code, a repeating group in D.0
 ; For 5.1, we are storing the data in the subfile even though it is a single value field in 5.1
 ;
 Q:'$G(BPSIEN(9002313.02))  ; BPS CLAIMS ien
 Q:'$G(BPSIEN(9002313.0201))  ; TRANSACTIONS ien (sub-file 9002313.0201)
 ;
 N BPSD0,BPSD1,BPSD2,X1,X4
 ;
 S BPSD0=BPSIEN(9002313.02),BPSD1=BPSIEN(9002313.0201),BPSD2=0
 ;
 S X4=$P($G(^BPSC(BPSD0,400,BPSD1,350)),U,4)  ; (#354) SUBM CLARIFICATION CODE COUNT
 ;
 I X4=""!($TR(X4,"0 {}")="NX") Q  ; Quit if the count is missing is only the ID
 ;
 F  S BPSD2=$O(^BPSC(BPSD0,400,BPSD1,354.01,BPSD2)) Q:'BPSD2  D
 .S X1=$P($G(^BPSC(BPSD0,400,BPSD1,354.01,BPSD2,1)),U,1)
 .I X1=""!($TR(X1," {}")="DK") Q  ; Quit if the code is missing or only the ID
 .S SEGREC=SEGREC_$C(28)_X1  ; FS always proceeds fld
 .S DATAFND=1  ; data found, result is true
 ;
 Q
 ;
OAMTCLMD(DATAFND,BPSIEN,SEGREC) ;
 ; BPSIEN, SEGREC passed by ref., SEGREC updated with pairs of repeating fields
 ; (#478.01) OTHER AMT CLAIMED MULTIPLE (sub-file 9002313.0601)
 ;
 Q:'$G(BPSIEN(9002313.02))  ; BPS CLAIMS ien
 Q:'$G(BPSIEN(9002313.0201))  ; TRANSACTIONS ien (sub-file 9002313.0201)
 ;
 N BPSD0,BPSD1,BPSD2,X,X2,X3
 ;
 S BPSD0=BPSIEN(9002313.02),BPSD1=BPSIEN(9002313.0201),BPSD2=0
 ;
 F  S BPSD2=$O(^BPSC(BPSD0,400,BPSD1,478.01,BPSD2)) Q:'BPSD2  D
 .S X=$G(^BPSC(BPSD0,400,BPSD1,478.01,BPSD2,0))
 .I X="" Q  ; Quit if the node is missing
 .S X2=$P(X,U,2)  ; (#479) OTHER AMT CLAIMED SUBMTTD QLFR
 .S X3=$P(X,U,3)  ; (#480) OTHER AMOUNT CLAIMED SUBMITTED
 .I X2=""!($TR(X2,"0 {}")="H8") Q  ; Quit if the qualifier is missing or just the ID
 .I X3=""!($TR(X3,"0 {}")="H9") Q  ; Quit if the amount is missing or just the ID
 .S SEGREC=SEGREC_$C(28)_X2_$C(28)_X3  ; FS always proceeds fld
 .S DATAFND=1  ; data found, result is true
 ;
 Q
 ;
