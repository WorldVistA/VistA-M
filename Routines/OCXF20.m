OCXF20 ;SLC/RJS,CLA - GENERATES CODE FOR 'Numeric' OPERATORS ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 Q
 ;
 ;
GRT(DATA,CVAL) ; GREATER THAN
 ;
 Q:'$L($G(DATA)) "" Q:'$L($G(CVAL)) "" Q "("_DATA_">"_CVAL_")"
 ;
LESS(DATA,CVAL) ; LESS THAN
 ;
 Q:'$L($G(DATA)) "" Q:'$L($G(CVAL)) "" Q "("_DATA_"<"_CVAL_")"
 ;
EQ(DATA,CVAL) ; EQUALS
 ;
 Q:'$L($G(DATA)) "" Q:'$L($G(CVAL)) "" Q "("_DATA_"="_CVAL_")"
 ;
INCL(DATA,CVAL1,CVAL2) ; INCLUSIVE BETWEEN
 ;
 Q:'$L($G(DATA)) "" Q:'$L($G(CVAL1)) "" Q:'$L($G(CVAL2)) ""
 ;
 Q "'("_$$LESS(DATA,CVAL1)_"!"_$$GRT(DATA,CVAL2)_")"
 ;
EXCL(DATA,CVAL1,CVAL2) ; EXCLUSIVE BETWEEN
 ;
 Q:'$L($G(DATA)) "" Q:'$L($G(CVAL1)) "" Q:'$L($G(CVAL2)) ""
 ;
 Q "("_$$GRT(DATA,CVAL1)_"&"_$$LESS(DATA,CVAL2)_")"
 ;
