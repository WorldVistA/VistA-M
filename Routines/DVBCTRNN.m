DVBCTRNN ;ALB ISC/THM-NOTIFY DOC OF REQUIRED TRANSFER DICTATION ; 5/23/91  11:04 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
EXIT D GO1 K DVBCCOPY,DVBCX Q
 ;
GO1 W:(IOST?1"C-".E) @IOF K ^UTILITY($J,"W") D X3^DVBCLTR W !!!!!!!
 F ZZI=0:1 S LY=$T(TXT+ZZI) Q:LY["END"  S X=$P(LY,";;",2),DIWF="R",DIWR=75,DIWL=5 D ^DIWP
 D ^DIWW
 K LY,TXT W @IOF Q
 ;
TXT ;;Notice to the physician: |BLANK(1)|
 ;;The attached examination(s) have been transferred to this medical center
 ;;from another center.  It will be required, therefore, that all laboratory
 ;;and X-Ray results be dictated for transcription and return to the
 ;;originating medical center.
 ;;
 ;;END
