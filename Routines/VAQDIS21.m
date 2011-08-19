VAQDIS21 ;ALB/JFP - PDX, BUILDS DISPLAY ARRAY FOR MINIMAL DATA ;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;**13**;NOV 17, 1993
DISPMIN(XTRCT,SEGPTR,ROOT,OFFSET,DSP) ;SAMPLE DISPLAY METHOD
 ;INPUT : XTRCT  - Input array (full global reference)
 ;        SEGPTR - Segment to extract (ptr to file #394.71)
 ;        ROOT   - Output array (full global reference)
 ;        OFFSET - Starting line for display
 ;        DSP    - Flag to set display option (1-on,0-off)
 ;OUTPUT: n      - Number of lines added to display
 ;       -1^ErrorText - Error
 ;
 ; -- Check input
 Q:('$D(XTRCT)) "-1^Input array not passed on input"
 Q:('$D(SEGPTR)) "-1^Segment not passed on input"
 Q:('$D(ROOT)) "-1^Output array not passed on input"
 Q:('$D(OFFSET)) "-1^Starting line for display not passed on input"
 ;
 S:('$D(DSP)) DSP=1
 ; -- Declare variables
 N X,SEGMENT,VAQPTAGE,VAQCNTY,STDA,CTDA,VAQST,VALMCNT,SSN
 N COUNTY,CNTYNUM,CNTYINFO
 ;
 S VAQSEGND=$G(^VAT(394.71,SEGPTR,0))
 Q:($P(VAQSEGND,U,2)="") "-1^Invalid segment"
 S VALMCNT=$S(DSP=1:OFFSET-1,1:0)
 I DSP=1 S ROOT=$$ROOT^VAQDIS20(ROOT)
 I DSP=0 G ROW1
 ;
 ; -- Build display segment
ROW0 ; -- Header line for display, only
 S VAQLN=$$REPEAT^VAQUTL1("-",79)
 S VAQCTR="< "_$S($P(VAQSEGND,"^",1)'="":$P(VAQSEGND,"^",1),1:"Segment  Description Missing")_" >"
 S X=$$CENTER^VAQDIS20(VAQLN,VAQCTR) D TMP,BLANK
 K VAQLN,VAQCTR,VAQSEGND
 ;
ROW1 S X=$$SETSTR^VALM1("PAT Name: "_$G(@XTRCT@("VALUE",2,.01,0)),"",1,40)
 S X=$$SETSTR^VALM1("DOB: "_$G(@XTRCT@("VALUE",2,.03,0)),X,43,22)
 S VAQPTAGE=$S($G(@XTRCT@("VALUE",2,.03,0))'="":$$AGE^VAQUTL99($$DATE^VAQUTL99($G(@XTRCT@("VALUE",2,.03,0)))),1:" ")
 S X=$$SETSTR^VALM1("AGE: "_VAQPTAGE,X,64,14)
 D TMP K VAQPTAGE
 ;
ROW2 S X=$$SETSTR^VALM1("    Addr: "_$G(@XTRCT@("VALUE",2,.111,0)),"",1,40)
 S SSN=$$DASHSSN^VAQUTL99($G(@XTRCT@("VALUE",2,.09,0)))
 S X=$$SETSTR^VALM1("SSN: "_SSN,X,43,16)
 D TMP
 ;
ROW3 S X=$$SETSTR^VALM1("        : "_$G(@XTRCT@("VALUE",2,.112,0)),"",1,40)
 S X=$$SETSTR^VALM1("Sex: "_$G(@XTRCT@("VALUE",2,.02,0)),X,43,12)
 S X=$$SETSTR^VALM1("MS: "_$G(@XTRCT@("VALUE",2,.05,0)),X,65,14)
 D TMP
 ;
ROW4 S X=$$SETSTR^VALM1("        : "_$G(@XTRCT@("VALUE",2,.113,0)),"",1,40)
 S X=$$SETSTR^VALM1("Religion: "_$G(@XTRCT@("VALUE",2,.08,0)),X,43,30)
 D TMP
 ;
ROW5 S STDA="",ST=$G(@XTRCT@("VALUE",2,.115,0))
 S:ST'="" STDA=$O(^DIC(5,"B",$G(@XTRCT@("VALUE",2,.115,0)),STDA))
 S VAQST=$S(STDA'="":$P(^DIC(5,STDA,0),U,2),1:" ")
 S CTDA="",CT=$G(@XTRCT@("VALUE",2,.117,0))
 I (CT'="")&(STDA'="") S CTDA=$O(^DIC(5,STDA,1,"C",$G(@XTRCT@("VALUE",2,.117,0)),CTDA))
 S X=$$SETSTR^VALM1("City/ST: "_$G(@XTRCT@("VALUE",2,.114,0))_$S(ST="":" ",1:", ")_VAQST,"",2,39)
 D TMP K STDA,ST,VAQST,CTDA,CT
 ;
ROW6 S X=$$SETSTR^VALM1("Zip: "_$G(@XTRCT@("VALUE",2,.1112,0)),"",6,15)
 S X=$$SETSTR^VALM1("County: ",X,43,8)
 S CNTYNUM=$G(@XTRCT@("VALUE",2,.117,0))
 S COUNTY=$$COUNTY^VAQDIS20($G(@XTRCT@("VALUE",2,.115,0)),CNTYNUM)
 S CNTYINFO=COUNTY_"  ("_CNTYNUM_")"
 S:(COUNTY="") CNTYINFO="UNKNOWN  ("_CNTYNUM_")"
 S:((COUNTY="")&(CNTYNUM="")) CNTYINFO="UNANSWERED"
 S X=X_CNTYINFO
 D TMP
 ;
ROW7 S X=$$SETSTR^VALM1(" ","",1,80) D TMP ; -- null line
ROW8 S X=$$SETSTR^VALM1("     Patient Type: "_$G(@XTRCT@("VALUE",2,391,0)),"",1,40)
 S X=$$SETSTR^VALM1("Veteran: "_$G(@XTRCT@("VALUE",2,1901,0)),X,43,13) D TMP
ROW9 S X=$$SETSTR^VALM1("Period of Service: "_$G(@XTRCT@("VALUE",2,.323,0)),"",1,40) D TMP
ROW10 S X=$$SETSTR^VALM1("Service Connected: "_$G(@XTRCT@("VALUE",2,.301,0)),"",1,40)
 S X=$$SETSTR^VALM1("Percentage: "_$G(@XTRCT@("VALUE",2,.302,0))_"%",X,43,36) D TMP
ROW11 S X=$$SETSTR^VALM1("      Eligibility: "_$G(@XTRCT@("VALUE",2,.361,0)),"",1,40) D TMP,BLANK
 D BLANK
 ; -- Sets number of lines in display
 QUIT VALMCNT-OFFSET
 ;
BLANK ; -- Sets up blank line
 S X=$$SETSTR^VALM1(" ","",1,80) D TMP ; -- null line
 QUIT
 ;
TMP ; -- Sets up display array
 S VALMCNT=VALMCNT+1
 S @ROOT@(VALMCNT,0)=$E(X,1,79)
 QUIT
 ;
END ; -- End of code
 QUIT
