BPSOSCF ;BHAM ISC/FCS/DRS/DLF - Low-level format of .02 ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; XLOOP - Build claim record
 ; Inputs:
 ;   BPS    - This is shared among the BPSOSC* routines
 ;   FORMAT - Pointer to 9002313.92
 ;   NODE   - Segment Node
 ;            100  (5.1 Transaction Header Segment)
 ;            110  (5.1 Patient Segment)
 ;            120  (5.1 Insurance Segment)
 ;            130  (5.1 Claim Segment)
 ;            140  (5.1 Pharmacy Provider Segment)
 ;            150  (5.1 Prescriber Segment)
 ;            160  (5.1 COB/Other Payments Segment)
 ;            170  (5.1 Worker's Compensation Segment)
 ;            180  (5.1 DUR/PPS Segment)
 ;            190  (5.1 Pricing Segment)
 ;            200  (5.1 Coupon Segment)
 ;            210  (5.1 Compound Segment)
 ;            220  (5.1 Prior Authorization Segment)
 ;            230  (5.1 Clinical Segment)
 ;   MEDN   - Prescription multiple in BPS Claims
 ;
XLOOP(FORMAT,NODE,MEDN) ;EP
 N ORDER,RECMIEN,MDATA,FLDIEN,PMODE,FLAG,OVERRIDE
 ;
 ; Check parameters
 I $G(FORMAT)="" Q
 I $G(NODE)="" Q
 ;
 ; If the payer sheet does have a particular segment quit
 I '$D(^BPSF(9002313.92,FORMAT,NODE,0)) Q
 ;
 ; VA does not currently do these segments
 I ",230,220,210,200,170,"[(","_NODE_",") Q
 ;
 ; For COB, if the payer sequence is primary, then quit and don't output the COB fields
 I NODE=160,$$COB59^BPSUTIL2(+$G(BPS("RX",BPS(9002313.0201),"IEN59")))=1 Q
 ;
 ; COB processing is handled differently
 I NODE=160 D COB^BPSOSHF(FORMAT,NODE,MEDN) Q
 ;
 ; DUR is handled differently since it is repeating
 I NODE=180 D DURPPS^BPSOSHF(FORMAT,NODE,MEDN) Q
 ;
 ; Loop through the fields in the segment
 S ORDER=0
 F  S ORDER=$O(^BPSF(9002313.92,FORMAT,NODE,"B",ORDER)) Q:'ORDER  D
 . ;
 . ; Get the pointer to the BPS NCPDP FIELD DEFS table
 . S RECMIEN=$O(^BPSF(9002313.92,FORMAT,NODE,"B",ORDER,0))
 . I 'RECMIEN D IMPOSS^BPSOSUE("DB","TI","NODE="_NODE,"ORDER="_ORDER,2,$T(+0))
 . S MDATA=^BPSF(9002313.92,FORMAT,NODE,RECMIEN,0)
 . S FLDIEN=$P(MDATA,U,2)
 . ;
 . ; Quit for 111-AM (Segment ID), 478-H7 (Other Amt Claimed Sub Count), and
 . ;   479-H8 (Other Amt Claimed Sub Qual)
 . ; 478 and 479 are handled by 480 and 111 is standard field for each segment
 . Q:FLDIEN=241!(FLDIEN=240)!(FLDIEN=93)
 . ;
 . ; Corrupt or erroneous format file
 . I 'FLDIEN Q
 . ;
 . ; Set override value (may not be defined so override will be null)
 . I $D(MEDN) S OVERRIDE=$G(BPS("OVERRIDE","RX",MEDN,FLDIEN))
 . E  S OVERRIDE=$G(BPS("OVERRIDE",FLDIEN))
 . ;
 . ; Get processing mode (S-Standard (default), X-Special Code)
 . S PMODE=$P(MDATA,U,3)
 . I PMODE="" S PMODE="S" ;default it
 . ;
 . ; Default FLAG and value being computed
 . S FLAG="GFS"
 . S BPS("X")=""
 . ;
 . ; If there is an override, set BPS("X") to it and
 . ;   only do Format and Set code
 . I OVERRIDE]"" S FLAG="FS",BPS("X")=OVERRIDE
 . ;
 . ; If Special Code mode is set, execute special code instead
 . ;   of field's Get code and change Flag to FS so Format and
 . ;   Set code is still done but not GET code
 . I PMODE="X",OVERRIDE="" D
 .. S FLAG="FS"
 .. D XSPCCODE(FORMAT,NODE,RECMIEN)
 . ;
 . ; Call XFLDCODE to do processing based on FLAG setting
 . D XFLDCODE(NODE,FLDIEN,FLAG)
 Q
 ;
 ; Execute Get, Format and/or Set MUMPS code for a NCPDP Field
 ;
 ; Parameters:   NODE    -  Segment Node
 ;               FLDIEN  -  NCPDP Field Definitions IEN
 ;               FLAG    -  If variable contains:
 ;                          "G" - Execute Get Code
 ;                          "F" - Execute Format Code
 ;                          "S" - Execute S Code
 ;---------------------------------------------------------------------
XFLDCODE(NODE,FLDIEN,FLAG) ;EP
 ; 5.1 loops through the 10, 25, 30 nodes
 ;
 N FNODE,INDEX,MCODE
 ;
 ; Check if record exists and FLAG variable is set correctly
 ; Changed from Q: to give fatal error - 10/18/2000
 I 'FLDIEN D IMPOSS^BPSOSUE("DB,P","TI","FLDIEN="_FLDIEN,,"XFLDCODE",$T(+0))
 I '$D(^BPSF(9002313.91,FLDIEN,0)) D IMPOSS^BPSOSUE("DB,P","TI","FLDIEN="_FLDIEN,,"XFLDCODE",$T(+0))
 I FLAG="" D IMPOSS^BPSOSUE("DB,P","TI","FLAG null",,"XFLDCODE",$T(+0))
 ;
 ; Loop through Get, Format and Set Code fields and execute code
 F FNODE=10,25,30 D
 . I FLAG'[$S(FNODE=10:"G",FNODE=25:"F",FNODE=30:"S",1:"") Q
 . ;
 . ; Quit for 111-AM (Segment ID), 478-H7 (Other Amt Claimed Sub Count), and
 . ;   479-H8 (Other Amt Claimed Sub Qual)
 . ; 478 and 479 are handled by 480 and 111 is standard field for each segment
 . I FLDIEN=241!(FLDIEN=240)!(FLDIEN=93) Q
 . I '$D(^BPSF(9002313.91,FLDIEN,FNODE,0)) D IMPOSS^BPSOSUE("DB","TI","FLDIEN="_FLDIEN,"FNODE="_FNODE,"XFLDCODE",$T(+0))
 . ;
 . ; Loop through the multiple and execute each line
 . S INDEX=0
 . F  S INDEX=$O(^BPSF(9002313.91,FLDIEN,FNODE,INDEX)) Q:'+INDEX  D
 .. ;
 .. ; If doing SET code and if this is not the header segment, add the ID prefix
 .. I FNODE=30,NODE'=100 S BPS("X")=$P($G(^BPSF(9002313.91,FLDIEN,5)),U,1)_BPS("X")
 .. ;
 .. ; Get the code and xecute
 .. S MCODE=$G(^BPSF(9002313.91,FLDIEN,FNODE,INDEX,0))
 .. Q:MCODE=""
 .. Q:$E(MCODE,1)=";"
 .. X MCODE
 Q
 ;----------------------------------------------------------------------
 ;Execute Special Code (for a NCPDP Field within a NCPDP Record)
 ;
 ;Parameters:    FORMAT   - NCPDP Record Format IEN (9002313.92)
 ;               NODE     - Global node value (100,110,120,130,140)
 ;               RECMIEN  - Field Multiple IEN
 ;---------------------------------------------------------------------
XSPCCODE(FORMAT,NODE,RECMIEN) ;EP - Above and BPSOSHR
 ;
 N INDEX,MCODE
 I '$D(^BPSF(9002313.92,FORMAT,NODE,RECMIEN,0)) D IMPOSS^BPSOSUE("DB,P","TI","no special code there to XECUTE","FORMAT="_FORMAT,"XSPCCODE",$T(+0))
 ;
 S INDEX=0
 F  S INDEX=$O(^BPSF(9002313.92,FORMAT,NODE,RECMIEN,1,INDEX)) Q:'+INDEX  D
 . S MCODE=$G(^BPSF(9002313.92,FORMAT,NODE,RECMIEN,1,INDEX,0))
 . Q:MCODE=""
 . Q:$E(MCODE,1)=";"
 . X MCODE
 Q
