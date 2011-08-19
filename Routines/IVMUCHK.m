IVMUCHK ;ALB/MLI - Filter routine to validate MT transmission before filing ; August 31,1994
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will perform edit checks to validate the means test data
 ; before it is uploaded into the MAS Means Test files.  Any errors will
 ; be recorded and will be sent automatically to the IVM Center for
 ; processing.
 ;
 ; called from IVMUM1 before upload routine is invoked
 ;
 ; input:
 ;   HLDA as IEN of the HL7 file entry
 ;   HL* - all other HL7 variables expected
 ;
 ; output:
 ;   IVMMTERR as error condition found (free text)
 ;
EN() ; entry point to create temp array and begin filter checks
 ;
 ;
 ;
 N ARRAY,DEP,ERROR,I,IEN,STRING,TYPE,X
 S ERROR=""
 F IEN=1:0 S IEN=$O(^HL(772,HLDA,"IN",IEN)) Q:'IEN!(ERROR]"")  I $E($G(^(IEN,0)),1,3)="PID" D
 . K ARRAY S (DEP,SPOUSE)=0
 . S ARRAY("PID")=$P($G(^HL(772,HLDA,"IN",IEN,0)),HLFS,2,999) ; pid segment
 . S ARRAY("ZIC")=$$ORDER(HLDA,.IEN),$P(ARRAY("ZIC"),HLFS,21)=$$TOTAL(ARRAY("ZIC"))
 . S ARRAY("ZIR")=$$ORDER(HLDA,.IEN)
 . F IEN=IEN:0 S IEN=$O(^HL(772,HLDA,"IN",IEN)) Q:'IEN!($E($G(^(IEN,0)),1,3)="ZMT")  D
 . . S DEP=DEP+1
 . . S ARRAY(DEP,"ZDP")=$$CLEAR($P($G(^HL(772,HLDA,"IN",IEN,0)),HLFS,2,999))
 . . S ARRAY(DEP,"ZIC")=$$ORDER(HLDA,.IEN)
 . . S ARRAY(DEP,"ZIR")=$$ORDER(HLDA,.IEN)
 . . I $P(ARRAY(DEP,"ZDP"),HLFS,6)=2,$P(ARRAY(DEP,"ZDP"),HLFS,2,4)'="^^" S SPOUSE=DEP
 . . I $P(ARRAY(DEP,"ZDP"),HLFS,6)=2,$P(ARRAY(DEP,"ZDP"),HLFS,2,4)="^^" K ARRAY(DEP) S DEP=DEP-1
 . . I DEP S $P(ARRAY(DEP,"ZIC"),HLFS,21)=$$TOTAL(ARRAY(DEP,"ZIC"),ARRAY(DEP,"ZIR"),ARRAY(DEP,"ZDP"))
 . S ARRAY("ZMT")=$$CLEAR($P($G(^HL(772,HLDA,"IN",IEN,0)),HLFS,2,999))
 . S ERROR=$$CHECK()
 Q ERROR
 ;
 ;
CHECK() ; check validity of transmission data
 ;
 ; Output:  error message (first one found)
 ;
 N ERROR,IEN
 S ERROR=$$ZIC^IVMUCHK2(ARRAY("ZIC"))
 I ERROR']"" S ERROR=$$ZIR^IVMUCHK1(ARRAY("ZIR"))
 I ERROR']"" S ERROR=$$ZMT^IVMUCHK4(ARRAY("ZMT"))
 I ERROR']"" F IEN=0:0 S IEN=$O(ARRAY(IEN)) Q:'IEN  D  I ERROR]"" G CHECKQ ; check dependent segments
 . S ERROR=$$ZDP^IVMUCHK3(ARRAY(IEN,"ZDP"),IEN)
 . I ERROR']"" S ERROR=$$ZIC^IVMUCHK2(ARRAY(IEN,"ZIC"),IEN)
 . I ERROR']"" S ERROR=$$ZIR^IVMUCHK1(ARRAY(IEN,"ZIR"),IEN)
CHECKQ Q $G(ERROR)
 ;
 ;
ORDER(HLDA,IEN) ; get next node
 S IEN=$O(^HL(772,HLDA,"IN",IEN))
 Q $$CLEAR($P($G(^HL(772,HLDA,"IN",IEN,0)),HLFS,2,999))
 ;
 ;
CLEAR(NODE) ; convert HLQ to null
 N I
 F I=1:1:25 I $P(NODE,HLFS,I)=HLQ S $P(NODE,HLFS,I)=""
 Q NODE
 ;
 ;
TOTAL(STRING,INCR,DEP) ; append total on the end
 N I,D,N,INC,DEB,NET S (INC,DEB,NET)=""
INC ; income
 I $D(INCR),$P($G(DEP),HLFS,6)'=2,'$P(INCR,HLFS,9) S INC=0 G DEBT
 F I=3:1:12 S INC=$G(INC)+$P(STRING,HLFS,I)
DEBT ; debts
 F I=13:1:15 S DEB=$G(DEB)+$P(STRING,HLFS,I)
NET ; net worth
 F I=16:1:19 I $P(STRING,HLFS,I)]"" S NET=$G(NET)+$P(STRING,HLFS,I)
 I NET]"" S NET=NET-$P(STRING,HLFS,20)
 Q INC_HLFS_DEB_HLFS_NET
