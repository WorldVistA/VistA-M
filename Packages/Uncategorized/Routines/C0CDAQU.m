C0CDAQU ; GPL - QRDA Utility Routines ;6/24/17  17:05
 ;;0.1;C0CDAQ;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 Q
 ;
ADDTEMP(TEMPOID,VSOID,DOMAIN) ; add a Template OID and ValueSet OID to the C0CDAQ XML TEMPLATE file (176.901)
 ;
 ; gpl astro
 q
 ;
 N FN S FN=176.901
 N FDA
 S FDA(FN,"?+1,",.01)=TEMPOID
 I $G(DOMAIN)'="" S FDA(FN,"?+1,",.03)=DOMAIN
 D UPDIE^C0CDAC0(.FDA)
 N IEN S IEN=$O(^C0CDA(176.901,"B",TEMPOID,""))
 I IEN="" D  Q  ;
 . W !,"ERROR CREATE TEMPLATE RECORD"
 K FDA
 S FDA(176.9011,"?+1,"_IEN_",",.01)=VSOID
 D UPDIE^C0CDAC0(.FDA)
 Q
 ;
wsCQMGEN(RTN,FILTER) ; return the completed template for the code if used in the cqm
 ; FILTER("code")= the code that drives the generation
 ; FILTER("cqm")= the quality measure to filter by
 ; FILTER("date")= the date/time associated with the code
 ;
 
CDATRTN(VSOID) ; extrinsic returns the routine to call to generate the correct
 ; template for the valueset with OID VSOID
 ;
 N FN S FN=176.901 ; file number of the template file
 N IEN
 S IEN=$O(^C0CDA(176.901,"VSOID",VSOID,""))
 I IEN="" Q ""
 N RTN S RTN=$$GET1^DIQ(FN,IEN_",",2.5)
 S RTN=$TR(RTN,"|","^")
 Q RTN
 ;
