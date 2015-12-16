DGENCDU ;ALB/CJM,Zoltan,TGH - Catastrophic Disability Utilities;May 24, 1999
 ;;5.3;Registration;**121,232,894**;Aug 13,1993;Build 48
 ;
 ; DG*5.3*894 - Enhance Catastrophic Disability to use Descriptors rather than Diagnoses/Procedures/Conditions.
 ;
EXT(SUB,VAL) ;
 ;Description: Given the subscript used in the Catastrophic Disability
 ;   array and a field value, returns the external representation of the
 ;     value, as defined in the fields output transform of the PATIENT
 ;     file.
 ;Input: 
 ;  SUB - array subscript defined for the Catastrophic Disability object
 ;  VAL - field value
 ;Output:
 ;  Function Value - returns the external value of the field
 ;
 Q:$G(SUB)=""!($G(VAL)="")!($G(SUB)[";") ""
 ;
 N FLD,FILE
 S FLD=$$FLD(SUB)
 Q:FLD="" ""
 S FILE=$$FILE(SUB)
 Q:FILE="" ""
 Q $$EXTERNAL^DILFD(FILE,FLD,"F",VAL)
FILE(SUB) ; Return file/subfile number associated with this subscript.
 ; SUB = text subscript (such as VCD, BY, DATE, FACDET, etc.)
 N SUBLST,FLDLST,FILELST,FILE,PC
 D SETVARS
 S SUB=";"_SUB_";"
 I SUBLST'[SUB Q ""
 S PC=$L($P(SUBLST,SUB),";")
 S FILE=$P(FILELST,";",PC)
 Q FILE
FLD(SUB) ; Return field/subfield number associated with this subscript.
 ; SUB = text subscript (such as VCD, BY, DATE, FACDET, etc.)
 N SUBLST,FLDLST,FILELST,FLD,PC
 D SETVARS
 S SUB=";"_SUB_";"
 I SUBLST'[SUB Q ""
 S PC=$L($P(SUBLST,SUB),";")
 S FLD=$P(FLDLST,";",PC)
 Q FLD
SUB(FLD,FILE) ; Return subscript for this field (and file) number.
 S:'$G(FILE) FILE=2
 N SUBLST,FLDLST,FILELST,PC,SUB
 D SETVARS
 F PC=1:1:$L(FLDLST,";") I $P(FLDLST,";",PC)=FLD,$P(FILELST,";",PC)=FILE S SUB=$P(SUBLST,";",PC+1) Q
 Q SUB
SETVARS ; NOTE -- for easy future maintenance, just modify the following 3 variables.
 S SUBLST=";VCD;BY;DATE;FACDET;REVDTE;METDET;DESCR;"
 S FILELST="2;2;2;2;2;2;2.401"
 S FLDLST=".39;.391;.392;.393;.394;.395;.01"
 Q
