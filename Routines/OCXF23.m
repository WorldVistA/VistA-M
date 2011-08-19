OCXF23 ;SLC/RJS,CLA - GENERATES CODE FOR 'Boolean' OPERATORS ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 Q
 ;
 ;
AND(OP1,OP2) ;
 ;
 Q:'$L($G(OP1)) "" Q:'$L($G(OP2)) "" Q "("_OP1_"&"_OP2_")"
 ;
OR(OP1,OP2) ;
 ;
 Q:'$L($G(OP1)) "" Q:'$L($G(OP2)) "" Q "("_OP1_"!"_OP2_")"
 ;
NOT(OP1) ;
 ;
 Q:'$L($G(OP1)) "" Q "'("_OP1_")"
 ;
TRUE(OP1) ;
 ;
 Q:'$L($G(OP1)) "" Q "("_OP1_")"
 ;
FALSE(OP1) ;
 ;
 Q:'$L($G(OP1)) "" Q "'("_OP1_")"
 ;
