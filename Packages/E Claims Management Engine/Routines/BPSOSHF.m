BPSOSHF ;BHAM ISC/SD/lwj/DLF - Get/Format/Set value for repeating segments ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine is an addendum to BPSOSCF.  Its purpose is to handle
 ; some of the repeating fields that now exist in NCPDP 5.1.
 ; The logic was put in here rather than BPSOSCF to keep the original
 ; routine (BPSOSCF) from growing too large and too cumbersome to
 ; maintain.
 ;
DURPPS(FORMAT,NODE,MEDN) ;EP called from BPSOSCF
 ;---------------------------------------------------------------
 ;NCPDP 5.1 changes
 ; Processing of the 5.1 DUR/PPS segment is much different than the
 ; conventional segments of 3.2, simply because all of its fields
 ; are optional, and repeating.  The repeating portion of this
 ; causes us to have yet another index we have to account for, and
 ; we must be able to tell which of the fields really needs to be
 ; populated.  The population of this segment is based on those
 ; values found for the prescription or refill in the BPS DUR/PPS
 ; file.  The file's values are temporarily stored in the
 ; BPS("RX",MEDN,DUR....) array for easy access and reference.
 ; (Special note - Overrides are not allowed on this multiple since
 ; they can simply update the DUR/PPS filed directly. For the same
 ; reason, "special" code is not accounted for either.
 ;---------------------------------------------------------------
 ;
 ; first order of business - check the BPS("RX",MEDN,"DUR") array
 ; for values - if there aren't any, we don't need to write this
 ; segment
 ;
 N FIELD,RECCNT,DUR,FLD,OVERRIDE,FLAG,ORD,FLDIEN,FLDNUM,FLDNUMB,FOUND
 S FLAG="FS"
 I ^BPS(9002313.99,1,"CERTIFIER")=DUZ S FLAG="GFS"
 ;
 Q:'$D(BPS("RX",MEDN,"DUR"))
 ;
 ;next we need to figure out which fields on this format are really
 ; needed, then we will loop through and populate them
 ;
 D GETFLDS(FORMAT,NODE,.FIELD)
 ;
 ; now lets get, format and set the field
 S (ORD,RECCNT,DUR)=0
 S RECCNT=RECCNT+1
 F  S DUR=$O(BPS("RX",MEDN,"DUR",DUR)) Q:DUR=""  D
 . S FLDNUM="" F  S FLDNUM=$O(BPS("RX",MEDN,"DUR",DUR,FLDNUM)) Q:FLDNUM=""  D
 .. S ORD="",FOUND=0
 .. F  S ORD=$O(FIELD(ORD)) Q:ORD=""  D  Q:FOUND
 ... S FLDNUMB="",FLDNUMB=$P(FIELD(ORD),U,2) Q:FLDNUMB'=FLDNUM
 ... S FLDIEN="",FLDIEN=$P(FIELD(ORD),U)
 ... S BPS("X")=BPS("RX",MEDN,"DUR",DUR,FLDNUM)
 ... S FOUND=1
 ... D XFLDCODE^BPSOSCF(NODE,FLDIEN,FLAG)  ;format/set
 ;
 ; this sets the record count and last record on the subfile
 S ^BPSC(BPS(9002313.02),400,BPS(9002313.0201),473.01,0)="^9002313.1001A^"_RECCNT_"^"_RECCNT
 ;
 Q
 ;
COB(FORMAT,NODE,MEDN) ; COB fields processing, NODE=160
 ;---------------------------------------------------------------
 ; The COB data is stored in the following local array:
 ;
 ;      BPS("RX",MEDN,"OTHER PAYER",.....
 ;
 ; Array built in routine BPSOSCD.
 ; Special note - Overrides are not allowed on this multiple.
 ;    "Special" code is not accounted for either.
 ;---------------------------------------------------------------
 ;
 N FIELD,FLD,OVERRIDE,FLAG,ORD,NCPFLD,BPD,BPD1,BPD2,PCE,BPSOPIEN,BPSOAIEN,BPSORIEN
 S FLAG="FS"
 I ^BPS(9002313.99,1,"CERTIFIER")=DUZ S FLAG="GFS"
 ;
 ; Quit if there is no data in the array
 Q:'$D(BPS("RX",MEDN,"OTHER PAYER"))
 ;
 ; next we need to figure out which fields on this format are really
 ; needed, then we will loop through and populate them
 ;
 D GETFLDS(FORMAT,NODE,.FIELD)
 ;
 ; re-sort this list by the NCPDP field#
 ; NCPFLD(NCPDP FIELD#) = internal field#
 K NCPFLD S ORD=0 F  S ORD=$O(FIELD(ORD)) Q:'ORD  S FLD=$P(FIELD(ORD),U,2) I FLD'="" S NCPFLD(FLD)=+FIELD(ORD)
 ;
 ; see if 337-4C is needed
 S FLD=337
 I $D(NCPFLD(FLD)) D
 . S BPS("X")=$P($G(BPS("RX",MEDN,"OTHER PAYER",0)),U,1)     ; get
 . I BPS("X")="" Q
 . D XFLDCODE^BPSOSCF(NODE,NCPFLD(FLD),FLAG)                 ; format/set
 . Q
 ;
 ; now lets get, format and set the rest of the COB fields
 S BPSOPIEN=0 F  S BPSOPIEN=$O(BPS("RX",MEDN,"OTHER PAYER",BPSOPIEN)) Q:'BPSOPIEN  D
 . S BPD=$G(BPS("RX",MEDN,"OTHER PAYER",BPSOPIEN,0))
 . F PCE=1:1:7 D
 .. S FLD=$S(PCE=1:337,PCE=2:338,PCE=3:339,PCE=4:340,PCE=5:443,PCE=6:341,PCE=7:471,1:0) Q:'FLD
 .. I '$D(NCPFLD(FLD)) Q                          ; field not needed
 .. I $P(BPD,U,PCE)="" Q                          ; data is nil
 .. S BPS("X")=$P(BPD,U,PCE)                      ; get
 .. D XFLDCODE^BPSOSCF(NODE,NCPFLD(FLD),FLAG)     ; format/set
 .. Q
 . ;
 . ; now look at the other payer amount paid fields
 . S BPSOAIEN=0 F  S BPSOAIEN=$O(BPS("RX",MEDN,"OTHER PAYER",BPSOPIEN,"P",BPSOAIEN)) Q:'BPSOAIEN  D
 .. S BPD1=$G(BPS("RX",MEDN,"OTHER PAYER",BPSOPIEN,"P",BPSOAIEN,0))
 .. F PCE=1,2 D
 ... S FLD=$S(PCE=1:431,PCE=2:342,1:0) Q:'FLD
 ... I '$D(NCPFLD(FLD)) Q                          ; field not needed
 ... I $P(BPD1,U,PCE)="" Q                         ; data is nil
 ... S BPS("X")=$P(BPD1,U,PCE)                     ; get
 ... D XFLDCODE^BPSOSCF(NODE,NCPFLD(FLD),FLAG)     ; format/set
 .. Q
 . ;
 . ; now look at the other payer reject code fields
 . S BPSORIEN=0 F  S BPSORIEN=$O(BPS("RX",MEDN,"OTHER PAYER",BPSOPIEN,"R",BPSORIEN)) Q:'BPSORIEN  D
 .. S BPD2=$G(BPS("RX",MEDN,"OTHER PAYER",BPSOPIEN,"R",BPSORIEN,0))
 .. S FLD=472
 .. I '$D(NCPFLD(FLD)) Q                          ; field not needed
 .. I BPD2="" Q                                   ; data is nil
 .. S BPS("X")=BPD2                               ; get
 .. D XFLDCODE^BPSOSCF(NODE,NCPFLD(FLD),FLAG)     ; format/set
 .. Q
 . Q
 ;
COBX ;
 Q
 ;
GETFLDS(FORMAT,NODE,FIELD) ;EP NCPDP 5.1
 ;---------------------------------------------------------------
 ;This routine will get the list of repeating fields that must be
 ; be worked with separately
 ; (This was originally coded for the DUR/PPS segment - I'm not
 ; 100% sure how and if it will work for the other repeating
 ; fields that exist within a segment.)
 ;---------------------------------------------------------------
 ; Coming in:
 ;   FORMAT = BPSF(9002313.92 's format IEN
 ;   NODE   = which segment we are processing (i.e. 180 - DUR/PPS)
 ;  .FIELD  = array to store the values in
 ;
 ; Exitting:
 ;  .FIELD array will look like:
 ;     FIELD(ord)=int^ext
 ;  Where:   ext = external field number from BPSF(9002313.91
 ;           int = internal field number from BPSF(9002313.91
 ;           ord = the order of the field - used in creating clm
 ;---------------------------------------------------------------
 ;
 N ORDER,RECMIEN,MDATA,FLDIEN,FLDNUM,DUR
 ;
 S ORDER=0
 ;
 F  D  Q:'ORDER
 . ;
 . ; let's order through the format file for this node
 . ;
 . S ORDER=$O(^BPSF(9002313.92,FORMAT,NODE,"B",ORDER)) Q:'ORDER
 . S RECMIEN=$O(^BPSF(9002313.92,FORMAT,NODE,"B",ORDER,0))
 . I 'RECMIEN D IMPOSS^BPSOSUE("DB","TI","NODE="_NODE,"ORDER="_ORDER,2,$T(+0))
 . S MDATA=^BPSF(9002313.92,FORMAT,NODE,RECMIEN,0)
 . S FLDIEN=$P(MDATA,U,2)
 . I 'FLDIEN D IMPOSS^BPSOSUE("DB","TI","NODE="_NODE,"RECMIEN="_RECMIEN,3,$T(+0)) ; corrupt or erroneous format file
 . I '$D(^BPSF(9002313.91,FLDIEN,0)) D IMPOSS^BPSOSUE("DB,P","TI","FLDIEN="_FLDIEN,,"DURPPS",$T(+0))  ;incomplete field definition
 . ;
 . ;lets create a list of fields we need
 . S FLDNUM=$P($G(^BPSF(9002313.91,FLDIEN,0)),U)
 . S:FLDNUM'=111 FIELD(ORDER)=FLDIEN_"^"_FLDNUM
 ;
 ;
 Q
