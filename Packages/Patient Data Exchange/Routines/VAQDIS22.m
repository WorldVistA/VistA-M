VAQDIS22 ;ALB/JFP - PDX, BUILDS DISPLAY ARRAY FOR MAS DATA ;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
DISPMAS(XTRCT,SEGPTR,ROOT,OFFSET,DSP) ;SAMPLE DISPLAY METHOD
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
 Q:($P(VAQSEGND,U,2)="") "-1^Invalid segment"
 S VALMCNT=$S(DSP=1:OFFSET-1,1:0)
 I DSP=1 S ROOT=$$ROOT^VAQDIS20(ROOT)
 ;
 ; -- Build display segment
 D SCR1^VAQDIS23 ; -- MAS Screen 1
 D SCR2^VAQDIS24 ; -- MAS Screen 2
 D SCR3^VAQDIS25 ; -- MAS Screen 3
 D SCR3^VAQDIS26 ; -- MAS Screen 3
 D SCR4^VAQDIS27 ; -- MAS Screen 4
 D SCR5^VAQDIS28 ; -- MAS Screen 5
 D SCR6^VAQDIS29 ; -- MAS Screen 6
 D SCR7^VAQDIS31 ; -- MAS Screen 7
 D SCR10^VAQDIS32 ; -- MAS Screen 10
 D SCR11^VAQDIS33 ; -- MAS Screen 11
 D BLANK^VAQDIS20
 D BLANK^VAQDIS20
 ;
 K X
 QUIT VALMCNT-OFFSET
 ;
END ; -- End of code
 QUIT
