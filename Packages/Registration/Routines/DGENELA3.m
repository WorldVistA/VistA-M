DGENELA3 ;ALB/CJM - Patient Eligibility API ; 13 JUN 1997
 ;;5.3;Registration;**147**;08/13/93
 ;
FILE(SUB) ;
 ;Description: Given a subscript from the ELIGIBILITY object array, 
 ;returns the corresponding file number.
 ;
 ;Input:
 ;  SUB - subscript from the ELIGIBILITY object array
 ;
 ;Output:
 ;  FUNCTION RETURN VALUE - the file the array subscript is mapped to, or NULL if mapping not found
 ;
 Q:SUB="MTSTA" ""  ;don't map Means Test Category
 Q:SUB="RD" 2.04
 Q:SUB="PER" 2.04
 Q:SUB="RDSC" 2.04
 ;
 Q 2
EXT(SUB,VAL) ;
 ;Description: Given the subscript used in the ELIGIBILITY object array,
 ;     and a field value, returns the external representation of the
 ;     value.
 ;Input: 
 ;  SUB - subscript in the array defined by the ELIGIBILTY object array
 ;  VAL - field value
 ;
 ;Output:
 ;  Function Value - returns the external value of the attribute
 ;
 Q:(($G(SUB)="")!($G(VAL)="")) ""
 ;
 N FLD,FILE
 S FILE=$$FILE(SUB)
 S FLD=$$FIELD^DGENELA1(SUB)
 ;
 Q:(FLD="") ""
 Q $$EXTERNAL^DILFD(FILE,FLD,"F",VAL)
