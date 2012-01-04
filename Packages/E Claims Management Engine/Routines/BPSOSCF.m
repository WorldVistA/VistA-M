BPSOSCF ;BHAM ISC/FCS/DRS/DLF - Low-level format of .02 ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,8,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 ; 100  (Transaction Header Segment)
 ; 110  (Patient Segment)
 ; 120  (Insurance Segment)
 ; 130  (Claim Segment)
 ; 140  (Pharmacy Provider Segment)
 ; 150  (Prescriber Segment)
 ; 160  (COB/Other Payments Segment)
 ; 170  (Worker's Compensation Segment)
 ; 180  (DUR/PPS Segment)
 ; 190  (Pricing Segment)
 ; 200  (Coupon Segment)
 ; 210  (Compound Segment)
 ; 220  (Prior Authorization Segment)
 ; 230  (Clinical Segment)
 ; 240  (Additional Documentation Segment)
 ; 250  (Facility Segment)
 ; 260  (Narrative Segment)
 ;
 ; FORMAT = IEN in BPS NCPDP FORMATS (#9002313.92)
 ; NODE = Segment Node
 ; MEDN = Transaction multiple in BPS Claims
XLOOP(FORMAT,NODE,MEDN) ; format claim record
 ;
 Q:$G(FORMAT)=""  Q:$G(NODE)=""  ; FORMAT, NODE required
 ;
 N FLAG,FLDIEN,FLDINFO,MDATA,NCPVERS,ORDER,OVERRIDE,PMODE,RECMIEN,X
 ; quit If the payer sheet doesn't have the segment
 I '$D(^BPSF(9002313.92,FORMAT,NODE,0)) Q
 ;
 ; VA doesn't do these segments
 I ",260,250,240,230,220,210,200,170,140,"[(","_NODE_",") Q
 ;
 ; Per NCPDP standard, eligibility doesn't support segments listed below
 I BPS("Transaction Code")="E1",",260,250,230,220,210,200,190,180,170,160,130,"[(","_NODE_",") Q
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
 . ; Get the pointer to the BPS NCPDP FIELD DEFS table
 . S RECMIEN=$O(^BPSF(9002313.92,FORMAT,NODE,"B",ORDER,0))
 . I 'RECMIEN D IMPOSS^BPSOSUE("DB","TI","NODE="_NODE,"ORDER="_ORDER,2,$T(+0)) Q
 . S MDATA=^BPSF(9002313.92,FORMAT,NODE,RECMIEN,0),FLDIEN=$P(MDATA,U,2)
 .; Corrupt or erroneous format file
 . I 'FLDIEN Q
 . S FLDINFO=$G(^BPSF(9002313.91,FLDIEN,0))  ; BPS NCPDP FIELD DEFS (#9002313.91)
 . I FLDINFO="" D IMPOSS^BPSOSUE("DB,P","TI","FLDIEN="_FLDIEN,,"XLOOP",$T(+0)) Q
 .; Quit for 111-AM Segment Identification
 .;           478-H7 Other Amount Claimed Submitted Count
 .;           479-H8 Other Amount Claimed Submitted Qualifier
 .; 478 and 479 are handled by 480 and 111 is standard field for each segment
 . S X=$P(FLDINFO,U) I ",111,478,479,"[(","_X_",") Q
 .;
 .; Set override value (may not be defined so override will be null)
 . I $D(MEDN) S OVERRIDE=$G(BPS("OVERRIDE","RX",MEDN,FLDIEN))
 . E  S OVERRIDE=$G(BPS("OVERRIDE",FLDIEN))
 .;
 .; Get processing mode (S-Standard (default), X-Special Code)
 . S PMODE=$P(MDATA,U,3)
 . I PMODE="" S PMODE="S" ;default it
 .;
 .; Default FLAG and value being computed
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
 ;
 Q
 ;
 ;
 ; Execute Get, Format and/or Set MUMPS code for NCPDP Field
 ;
 ; Parameters:   NODE    -  Segment Node
 ;               FLDIEN  -  NCPDP Field Definitions IEN
 ;               FLAG    -  If variable contains:
 ;                          "G" - Execute Get Code
 ;                          "F" - Execute Format Code
 ;                          "S" - Execute S Code
 ;
 ;  When called by the DURPPS^BPSOSHF, DUR is also set and used
 ;   by the SET logic for the DUR fields.  This variable is newed
 ;   by the calling routine
XFLDCODE(NODE,FLDIEN,FLAG) ;EP
 ; 5.1 loops through the 10, 25, 30 nodes
 ;
 N FNODE,INDEX,MCODE,NCPVERS,X
 ;
 ; Check if record exists and FLAG variable is set correctly
 ; Changed from Q: to give fatal error - 10/18/2000
 I 'FLDIEN D IMPOSS^BPSOSUE("DB,P","TI","FLDIEN="_FLDIEN,,"XFLDCODE",$T(+0)) Q
 I FLAG="" D IMPOSS^BPSOSUE("DB,P","TI","FLAG null",,"XFLDCODE",$T(+0)) Q
 ; get NCPDP version, default to vD.0
 S NCPVERS=$G(BPS("NCPDP","Version")) S:NCPVERS="" NCPVERS="D0"
 ; Loop through GET CODE, D0 FORMAT (or FORMAT), SET CODE w-p fields and execute code
 F FNODE=10,20,25,30 D
 .I FNODE=25,NCPVERS="D0" Q  ; node 25 is FORMAT CODE for versions before D.0
 .I FNODE=20,NCPVERS'="D0" Q  ; node 20 is FORMAT CODE for vD.0
 .I FLAG'[$S(FNODE=10:"G",FNODE=25!(FNODE=20):"F",FNODE=30:"S",1:"") Q
 .I '$D(^BPSF(9002313.91,FLDIEN,FNODE,0)) D IMPOSS^BPSOSUE("DB","TI","FLDIEN="_FLDIEN,"FNODE="_FNODE,"XFLDCODE",$T(+0))
 .; Loop through the W-P field and execute each line
 .S INDEX=0
 .F  S INDEX=$O(^BPSF(9002313.91,FLDIEN,FNODE,INDEX)) Q:'INDEX  D
 ..; If doing SET code and if this is not the header segment, add the ID prefix
 ..I FNODE=30,NODE'=100 S BPS("X")=$P($G(^BPSF(9002313.91,FLDIEN,5)),U,1)_BPS("X")
 ..; Get the code and xecute
 ..S MCODE=$G(^BPSF(9002313.91,FLDIEN,FNODE,INDEX,0))
 ..Q:MCODE=""  Q:$E(MCODE,1)=";"  ; no M code or comment
 ..X MCODE
 ;
 Q
 ;
 ;
 ; Execute Special Code (for NCPDP Field within NCPDP Record)
 ; FORMAT = NCPDP Record Format IEN (9002313.92)
 ; NODE = Global node value (100,110,120,130,140)
 ; RECMIEN = Field Multiple IEN
XSPCCODE(FORMAT,NODE,RECMIEN) ;EP - Above and BPSOSHR
 ; BPS NCPDP FORMATS (#9002313.92)
 I '$D(^BPSF(9002313.92,FORMAT,NODE,RECMIEN,0)) D IMPOSS^BPSOSUE("DB,P","TI","no special code there to XECUTE","FORMAT="_FORMAT,"XSPCCODE",$T(+0)) Q
 N INDEX,MCODE
 S INDEX=0
 F  S INDEX=$O(^BPSF(9002313.92,FORMAT,NODE,RECMIEN,1,INDEX)) Q:'INDEX  D
 . S MCODE=$G(^BPSF(9002313.92,FORMAT,NODE,RECMIEN,1,INDEX,0))
 . Q:MCODE=""
 . Q:$E(MCODE,1)=";"
 . X MCODE
 Q
 ;
