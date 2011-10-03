RGRSPAR2 ;ALB/RJS-SENSITIVITY MESSAGE PARSER FOR CIRN ;1/8/98
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;;30 Apr 99
EN(ARRAY) ;
 ;This procedure returns specific patient information into a supplied
 ;variable
 ;
 ;Input: Required Variable
 ;
 ;  ARRAY - Supplied array variable (Passed by reference)
 ;
 ;Output: from segments built from the PATIENT file (#2) of sending site
 ;
 ;  ARRAY(.01) - .01 field in PATIENT file (#2)
 ;  ARRAY(.02) - .02 field in PATIENT file (#2)
 ;  ARRAY(.03) - .03 field in PATIENT file (#2)
 ;  ARRAY(.09) - .09 field in PATIENT file (#2)
 ;  ARRAY(991.01) - 991.01 field in PATIENT file (#2)
 ;  ARRAY(991.02) - 991.02 field in PATIENT file (#2)
 ;  ARRAY(991.03) - 991.03 field in PATIENT file (#2)
 ;  ARRAY("SENDING SITE") - sending sites station number
 ;  ARRAY("SENSITIVITY") - sensitivity of the patient at sending site
 ;  ARRAY("SENSITIVITY USER") - user at sending site that make patient
 ;  ARRAY("SENSITIVITY DATE") - date when patient was marked sensitive
 ;
 N RGRSPID,RGC,RGRSPD1,SUBCOMP
 S RGC=$E(HL("ECH")),SUBCOMP=$E(HL("ECH"),2)
 S RGRSMSH=$$SEG1^RGRSUTIL("MSH",1,"MSH")
 S RGRSPID=$$SEG1^RGRSUTIL("PID",1,"PID")
 S RGRSPD1=$$SEG1^RGRSUTIL("PD1",1,"PD1")
 S RGRSZSN=$$SEG1^RGRSUTIL("ZSN",1,"ZSN")
 S @ARRAY@(.01)=$$FREE($$FMNAME^HLFNC($P(RGRSPID,HL("FS"),6),HL("ECH"))) ;NAME
 S @ARRAY@(.02)=$$SEX($P(RGRSPID,HL("FS"),9)) ;SEX
 S @ARRAY@(.03)=$$FREE($$FMDATE^HLFNC($P(RGRSPID,HL("FS"),8))) ;DOB
 S @ARRAY@(.09)=$$FREE($P(RGRSPID,HL("FS"),20)) ;SOCIAL SECURITY #
 S @ARRAY@(991.01)=$$FREE($P($P(RGRSPID,HL("FS"),3),"V",1)) ;INTEG CONTROL #
 S @ARRAY@(991.02)=$$FREE($P($P(RGRSPID,HL("FS"),3),"V",2)) ;CHECKSUM
 S @ARRAY@(991.03)=$$FREE($P($P(RGRSPD1,HL("FS"),4),RGC,1)) ;VCCI
 S @ARRAY@("SITENUM")=$$FREE($P($P(RGRSPD1,HL("FS"),4),RGC,3)) ;VCCI SITENUM
 S @ARRAY@("SENDING SITE")=$$FREE($P(RGRSMSH,HL("FS"),4)) ;SENDING SITE
 S @ARRAY@("SENSITIVITY")=$$FREE($P(RGRSZSN,HL("FS"),2)) ;SENSTIVITY
 S @ARRAY@("SENSITIVITY USER")=$$FREE($P(RGRSZSN,HL("FS"),3)) ;REMOTE PERSON WHO MADE PT. SENSITIVE
 S @ARRAY@("SENSITIVITY DATE")=$$FREE($$FMDATE^HLFNC($P(RGRSZSN,HL("FS"),4))) ;DATE/TIME PERSON MADE PT. SENSITIVE AT REMOTE SITE
 Q
 ;
KILL ;
 K @ARRAY
 Q
 ;
FREE(DATA) ;
 Q:$G(DATA)="" ""
 Q:DATA=HL("Q") """@"""
 Q $G(DATA)
 ;
SEX(DATA) ;
 Q:$$FREE(DATA)="" ""
 Q:$$FREE(DATA)="""@""" """@"""
 I DATA="M" Q "MALE"
 I DATA="F" Q "FEMALE"
 Q "^<UNRESOLVED>"
 ;
