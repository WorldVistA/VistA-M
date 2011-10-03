VAQDIS40 ;ALB/JFP - PDX, BUILDS DISPLAY ARRAY FOR PHA DATA ;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
DISPMP(XTRCT,SEGPTR,ROOT,OFFSET,DSP) ;SAMPLE DISPLAY METHOD
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
 N X,VAQSEGND,VALMCNT
 ;
 S VAQSEGND=$G(^VAT(394.71,SEGPTR,0))
 S VAQSEGNM=$P(VAQSEGND,U,2)
 Q:(VAQSEGNM="") "-1^Invalid segment"
 S VALMCNT=$S(DSP=1:OFFSET-1,1:0)
 I DSP=1 S ROOT=$$ROOT^VAQDIS20(ROOT)
 ;
 ; -- Build display segment
 S FORMTYPE=$S(VAQSEGNM="PDX*MPS":0,1:1)
 S X=$$PRINT^VAQDIS41(FORMTYPE)
 ; -- Clean up variables
 K X,VAQSEGND,VAQSEGNM,TMP,ROOT,FORMTYPE
 ; -- End
 QUIT VALMCNT-OFFSET
 ;
END ; -- End of code
 QUIT
