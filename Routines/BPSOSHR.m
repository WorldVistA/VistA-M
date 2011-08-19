BPSOSHR ;BHAM ISC/SD/lwj/DLF - Format conversion for reversals ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine was originally used by IHS to reformat reversal claims
 ;   into version 5.1 if the original billing request was version 3x.
 ;   For that purpose, this routine is no longer needed.  However,
 ;   it also executes the special code fields so for that reason, it
 ;   has not been removed. We also may need to do this if we change
 ;   from version 5.1 to some other version, such as version 8, in the
 ;   future.
 ;
 ; NOTE: There is a problem with special code if it relies on BPS array
 ;   values, such as BPS("Site","NCPDP") since those variables will not
 ;   be defined at this point.  So, the only special code that will
 ;   work are hard-coded values or executes of a procedure.  If executing
 ;   a procedure, it also needs to not rely on BPS array elements or needs
 ;   to distinquish between billing requests and reversals.
 Q
 ;
 ; Input
 ;   BPSFORM  - Reversal payer sheet IEN
 ;   CLAIMIEN - Original claim IEN
 ;   POS      - Multiple from original claim
 ;
 ; Input/Output
 ;   TMP is the array originally created in BPSECA8.  Since it is quite
 ;     large, we are not passing it into here.  It will be modified by
 ;     this routine.
 ;
REFORM(BPSFORM,CLAIMIEN,POS) ;
 ;
 ; Validate parameters
 I $G(BPSFORM)="" Q
 I $G(CLAIMIEN)="" Q
 I $G(POS)="" Q
 ;
 ; Initialize variables
 N FLDIEN,PMODE,ORDER,RECMIEN,FIELD,NODE
 ;
 ; First go through the header fields.  The original IHS logic was only
 ;   checking four specific fields.  Of these, I removed:
 ;    109 (Transaction Count) - Always 1 for reversals and it does
 ;      not make sense for this to be determined by special code.
 ;    201 (Service Provider ID) - The logic currently implemented
 ;      relies on BPS array elements that are not defined here so this
 ;      was getting set to NULL when it needed to be set.  In addition
 ;      I compared reversal and request (11/30/2006) and this value is 
 ;      always the same for both so reversals will get the right value
 ;      from the request.
 ;    202 (Service Provider ID Qualifier) - It does not make sense
 ;      to do this field if we are not doing field 201.
 ;
 ; So that leaves 110 (Software Vendor/Certification ID), which is needed
 ;   by the WEBMD reversal test payer sheet.
 ;
 ; Kept looping structure in case other fields are added later
 ;     
 S NODE=100,ORDER=0
 F  S ORDER=$O(^BPSF(9002313.92,BPSFORM,NODE,"B",ORDER)) Q:'ORDER  D
 . S RECMIEN=$O(^BPSF(9002313.92,BPSFORM,NODE,"B",ORDER,0))
 . I 'RECMIEN Q
 . S FLDIEN=$P($G(^BPSF(9002313.92,BPSFORM,NODE,RECMIEN,0)),U,2)
 . S FIELD=$P($G(^BPSF(9002313.91,FLDIEN,0)),U)
 . I FIELD'=110 Q
 . ;
 . ; Check to see if the format has special code.  If not, quit
 . ;  If we change versions (5x to ??), we made need to execute FORMAT
 . ;    code no matter what, but for now, only do if there is special
 . ;    code.
 . S PMODE=$P($G(^BPSF(9002313.92,BPSFORM,NODE,RECMIEN,0)),U,3)
 . I PMODE'="X" Q
 . ;
 . ; If special code, get the value, format it and store it in TMP
 . D XSPCCODE^BPSOSCF(BPSFORM,NODE,RECMIEN)
 . D FORMAT(NODE,FLDIEN)
 . S TMP(9002313.02,CLAIMIEN,FIELD,"I")=BPS("X")
 ;
 ; Now reformat the "detail" portion of the claim. For now, the only
 ;   segment we are going to look at is 130, which is the claim segment
 ;   If other reversal formats become available, and they require other
 ;   segments - this section will have to change.  Since the claim
 ;   segment full of optional fields, we wil read through the format
 ;   and take it a field at a time.
 S NODE=130,ORDER=0
 F  S ORDER=$O(^BPSF(9002313.92,BPSFORM,NODE,"B",ORDER)) Q:'ORDER  D
 . S RECMIEN=$O(^BPSF(9002313.92,BPSFORM,NODE,"B",ORDER,0))
 . I 'RECMIEN Q
 . S FLDIEN=$P($G(^BPSF(9002313.92,BPSFORM,NODE,RECMIEN,0)),U,2)
 . S FIELD=$P($G(^BPSF(9002313.91,FLDIEN,0)),U)
 . I FIELD=111 Q    ; Never do Segment Indentifier
 . ;
 . ; Check to see if the format has special code.  If not, quit
 . ; If we change versions (5x to ??), we made need to execute FORMAT
 . ;   code no matter what, but for now, only do if there is special
 . ;   code.
 . S PMODE=$P($G(^BPSF(9002313.92,BPSFORM,NODE,RECMIEN,0)),U,3)
 . I PMODE'="X" Q
 . ;
 . ; If special code, get the value, format it and store it in TMP
 . D XSPCCODE^BPSOSCF(BPSFORM,NODE,RECMIEN)
 . D FORMAT(NODE,FLDIEN)
 . S TMP(9002313.0201,POS_","_CLAIMIEN,FIELD,"I")=BPS("X")
 Q
 ;
 ; FORMAT will format the data based on the FORMAT code in BPS NCPDP
 ;   FIELD DEFS
FORMAT(NODE,FLDIEN) ;
 N INDEX,MCODE,QUAL
 ;
 ; Loop through format code and format the data
 S INDEX=0
 F  S INDEX=$O(^BPSF(9002313.91,FLDIEN,25,INDEX))  Q:'+INDEX  D
 . S MCODE=$G(^BPSF(9002313.91,FLDIEN,25,INDEX,0))
 . I MCODE="" Q
 . I $E(MCODE,1)=";" Q
 . X MCODE
 ;
 ; If node not equal to 100, append qualifier
 I NODE'=100 D
 . S QUAL=$P(^BPSF(9002313.91,FLDIEN,5),"^",1)
 . S BPS("X")=QUAL_BPS("X")
 Q
