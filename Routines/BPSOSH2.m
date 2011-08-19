BPSOSH2 ;BHAM ISC/SD/lwj/DLF - Assemble formatted claim for 5.1 ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;----------------------------------------------------------------------
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
 ;
 ;----------------------------------------------------------------------
 ;Put together ascii formatted record via NCPDP Record definition
 ;
 ;Input Variables:  NODES     - (100^110^120 or
 ;                               130^140^150^160^170^180^190^
 ;                               200^210^220^230)
 ;                  .IEN      - Internal Entry Number array
 ;                  .BPS     - Formatted Data Array with claim and
 ;                              prescription data
 ;                  .REC      - Formatted Ascii record (result)
 ;----------------------------------------------------------------------
XLOOP(NODES,IEN,BPS,REC) ;EP - from BPSECA1
 ;
 ; Manage local variables
 N ORDER,RECMIEN,MDATA,FLDIEN,PMODE,FLAG,NODE,FDATA,FLDNUM,FLDDATA
 N INDEX,FLDID
 N SEGREC,DATAFND,FDATA5
 ;
 ;Loop through the NODES defined in NODES variable parsed by U
 F INDEX=1:1:$L(NODES,U) D
 . S NODE=$P(NODES,U,INDEX)
 . Q:NODE=""
 . ;
 . ; VA does not support these nodes
 . Q:",230,220,210,200,170,"[NODE
 . ;
 . ; Quit if the payer sheet does not have the node
 . Q:'$D(^BPSF(9002313.92,+IEN(9002313.92),NODE,0))
 . ;
 . ; Per NCPDP standard, reversals do not support segments listed below - DMB 5/2/2005
 . I $G(BPS(9002313.02,+$G(IEN(9002313.02)),103,"I"))="B2",",230,220,210,200,170,160,150,140,"[NODE Q
 . ;
 . S DATAFND=0  ;indicates if data is on the segment for us to send
 . S SEGREC=""  ;holds the segment's information
 . ;
 . D:NODE=180 PROCDUR
 . ;
 . ;COB fields
 . D:NODE=160 PROCCOB
 . ;
 . S ORDER=""
 . F  D  Q:'ORDER
 .. ;
 .. Q:NODE=180    ;already had to process the DUR/PPS section (repeating)
 .. Q:NODE=160  ;was processed earlier
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
 .. S FDATA5=$G(^BPSF(9002313.91,FLDIEN,5))   ;5.1 id and length
 .. S FLDID=$P(FDATA5,U,1)         ;5.1 ID
 .. ;
 .. ;header data
 .. S:NODE<130 FLDDATA=$G(BPS(9002313.02,IEN(9002313.02),FLDNUM,"I"))
 .. ;
 .. ;transaction data
 .. S:NODE>120 FLDDATA=$G(BPS(9002313.0201,IEN(9002313.01),FLDNUM,"I"))
 .. ;
 .. I FLDID'=$TR(FLDDATA,"0 {}") S DATAFND=1 ;fld chk-is the field empty?
 .. ;
 .. ;check if this is the seg id - call this after fld chk since
 .. ;we don't want to send the segment if this is all there is
 .. I (NODE>100)&(FLDNUM=111) S FLDDATA=$$SEGID(NODE)
 .. ;
 .. Q:FLDDATA=""   ;lje;7/23/03; don't want extra field separators when field is blank for testing for WebMD.
 .. ;
 .. S:NODE=100 SEGREC=SEGREC_FLDDATA  ;no FS on the header rec
 .. S:NODE>100 SEGREC=SEGREC_$C(28)_FLDDATA  ;FS always proceeds fld
 .. ;
 . ;
 . I (DATAFND)&(NODE=100) S REC(NODE)=SEGREC   ;no SS when it's the header
 . I (DATAFND)&(NODE>100) D
 .. I '$D(REC(NODE)) S REC(NODE)=REC I REC[$C(29) S REC=""
 .. S REC(NODE)=REC(NODE)_$C(30)_SEGREC  ;SS before the seg
 ;
 Q
 ;
SEGID(ND) ; Field 111 is the Segment Identifier - for each segment, other than
 ; the header, a pre-defined, unique value must be sent in this field
 ; to identify which segment is being sent.  This value is not stored
 ; in the claim - as it changes with each of the 13 segments. The
 ; field does appear as part of the NCPCP Format, put is simply not
 ; stored.
 ;    01 = Patient   02 = Pharmacy Provider    03 = Prescriber
 ;    04 = Insurance 05 = COB/Other Payment    06 = Workers Comp
 ;    07 = Claim     08 = DUR/PPS              09 = Coupon
 ;    10 = Compound  11 = Pricing              12 = Prior Auth
 ;    13 = Clinical
 ;
 N FLD
 ;
 S FLD=$S(ND=110:"01",ND=120:"04",ND=130:"07",ND=140:"02",ND=150:"03",ND=160:"05",ND=170:"06",ND=180:"08",ND=190:11,ND=200:"09",ND=210:10,ND=220:12,ND=230:13,1:"00")
 S FLD="AM"_$$NFF^BPSECFM(FLD,2)
 ;
 Q FLD
 ;
PROCDUR ;NCPDP 5.1 - The DUR/PPS segment can repeat itself for any given
 ; transaction within a claim.  This means we have to have special
 ; programming to handle the repeating fields.
 ;
 ; Note that BPS array is set in BPSOSC* routines
 ;
 N FIELD,DUR,FLD,ORD
 ;
 ; If there isn't any data in this segment, then lets quit
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
 .. S FDATA5=$G(^BPSF(9002313.91,FLDIEN,5))   ;5.1 id and length
 .. S FLDID=$P(FDATA5,U,1)         ;5.1 ID
 .. ;
 .. ; Transaction data
 .. S FLDDATA=$G(BPS(9002313.1001,DUR,FLD,"I"))
 .. ;
 .. I FLDID'=$TR(FLDDATA,"0 {}") S DATAFND=1 ;fld chk-is the fld empty?
 .. ;
 .. S SEGREC=SEGREC_$C(28)_FLDDATA  ;FS always proceeds fld
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
 ; If there isn't any data in this segment, then lets quit
 Q:'$D(BPS(9002313.0401))
 ;
 ; Second thing - create the 111 field entry as it is not repeating
 S FLDDATA=$$SEGID(NODE)
 S SEGREC=SEGREC_$C(28)_FLDDATA  ;FS always proceeds fld
 ;
 ; Next- let's look to the format to see which COB fields are
 ; needed 
 D GETFLDS^BPSOSHF(+IEN(9002313.92),NODE,.FIELD)
 ;
 ; Finally -loop through and process the fields for as many times
 ; as they appear
 S BPCOB=0
 F  S BPCOB=$O(BPS(9002313.0401,BPCOB)) Q:BPCOB=""  D
 . S ORD=0
 . F  S ORD=$O(FIELD(ORD)) Q:ORD=""  D
 .. S FLDIEN=$P(FIELD(ORD),U)
 .. S FLD=$P(FIELD(ORD),U,2)
 .. S:FLD=337 FLD=.01   ;473 value stored in the .01 field
 .. S FDATA5=$G(^BPSF(9002313.91,FLDIEN,5))   ;5.1 id and length
 .. S FLDID=$P(FDATA5,U,1)         ;5.1 ID
 .. ;
 .. ; Transaction data
 .. S FLDDATA=$G(BPS(9002313.0401,BPCOB,FLD,"I"))
 .. ;
 .. Q:FLDDATA=""
 .. I $TR(FLDDATA,"0 {}")="HB" Q
 .. I $TR(FLDDATA,"0 {}")="5E" Q
 .. ;
 .. I FLDID'=$TR(FLDDATA,"0 {}") S DATAFND=1 ;fld chk-is the fld empty?
 .. ;
 .. S SEGREC=SEGREC_$C(28)_FLDDATA  ;FS always proceeds fld
 .. I FLD=471 D REJCODES
 .. I FLD=341 D AMTPAID
 ;
 Q
 ;
AMTPAID ; (#342) OTHER PAYER AMT PAID QUALIFIER multiple
 ;
 ; NOTE: The claim is not formatted properly with multiple other payers.
 ;       So this will have to be modified for tertiary claims processing.
 ;
 N BPCOB,ORD,FLD,FDATA5,FLDID,FLDIEN,FLDDATA
 S BPCOB=0
 F  S BPCOB=$O(BPS(9002313.401342,BPCOB)) Q:BPCOB=""  D
 . S ORD=0
 . F  S ORD=$O(FIELD(ORD)) Q:ORD=""  D
 .. S FLDIEN=$P(FIELD(ORD),U)
 .. S FLD=$P(FIELD(ORD),U,2)
 .. S:FLD=342 FLD=.01   ;342 value stored in the .01 field
 .. S FDATA5=$G(^BPSF(9002313.91,FLDIEN,5))   ;5.1 id and length
 .. S FLDID=$P(FDATA5,U,1)         ;5.1 ID
 .. ;
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
 ;
 ; NOTE: The claim is not formatted properly with multiple other payers.
 ;       So this will have to be modified for tertiary claims processing.
 ;
 N BPCOB,ORD,FLD,FDATA5,FLDID,FLDIEN,FLDDATA
 S BPCOB=0
 F  S BPCOB=$O(BPS(9002313.401472,BPCOB)) Q:BPCOB=""  D
 . S ORD=0
 . F  S ORD=$O(FIELD(ORD)) Q:ORD=""  D
 .. S FLDIEN=$P(FIELD(ORD),U)
 .. S FLD=$P(FIELD(ORD),U,2)
 .. S:FLD=472 FLD=.01   ;472 value stored in the .01 field
 .. S FDATA5=$G(^BPSF(9002313.91,FLDIEN,5))   ;5.1 id and length
 .. S FLDID=$P(FDATA5,U,1)         ;5.1 ID
 .. ;
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
