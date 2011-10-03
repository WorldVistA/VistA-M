RGRSPAR1 ;ALB/RJS-REGISTRATION MESSAGE PARSER FOR CIRN TFU ;6/9/97
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;;30 Apr 99
EN(ARRAY) ;
 ;This procedure call updates a given array with CMOR site number and ICN
 ;
 ;Input: Required Variable
 ;
 ;  ARRAY - Supplied array variable (Passed by reference)
 ;
 ;Output:
 ;
 ;  ARRAY("SITENUM") - Patient's CMOR site number
 ;  ARRAY("ICN") - Patient's ICN 
 ;
 N RGRSMFI,RGRSMFE,RGC,SUBCOMP
 S RGC=$E(HL("ECH")),SUBCOMP=$E(HL("ECH"),2)
 S RGRSMFI=$$SEG1^RGRSUTIL("MFI",1,"MFI")
 S RGRSMFE=$$SEG1^RGRSUTIL("MFE",1,"MFE")
 S @ARRAY@("SITENUM")=$$FREE($P($P(RGRSMFE,HL("FS"),5),RGC,1)) ;VCCI SITENUM
 S @ARRAY@("ICN")=$$FREE($P($P(RGRSMFE,HL("FS"),5),RGC,4)) ;ICN
 Q
FREE(DATA)      ;
 Q:$G(DATA)="" ""
 Q:DATA=HL("Q") """@"""
 Q $G(DATA)
 Q
