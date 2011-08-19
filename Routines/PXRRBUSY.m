PXRRBUSY ;ISL/PKR - For long interactive reports let the user know the computer is busy. ;9/18/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3**;Aug 12, 1996
 ;Based on initial spinner developed by JVS.
 ;=======================================================================
INIT(SPINCNT) ;Initialize the busy display components.
 S SPINCNT=0
 Q
 ;
 ;=======================================================================
DONE(DTEXT) ;Write out the done message.
 W @IOBS,DTEXT,!
 Q
 ;
 ;=======================================================================
SPIN(SPINTEXT,SPINCNT) ;Move the spinner.
 N QUAD
 I SPINCNT=0 W !!,SPINTEXT,"  "
 S SPINCNT=SPINCNT+1
 S QUAD=SPINCNT#8
 I QUAD=1 W @IOBS,"|"
 I QUAD=3 W @IOBS,"/"
 I QUAD=5 W @IOBS,"-"
 I QUAD=7 W @IOBS,"\"
 Q
