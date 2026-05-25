TIUMSER ; NA/AJB - PERSIAN GULF UPDATE;Nov 06, 2024@12:58:52
 ;;1.0;TEXT INTEGRATION UTILITIES;**370**;Jun 20, 1997;Build 14
 ;
 ; Reference to KVAR^VADPT in ICR #10061
 ; Reference to SVC^VADPT in ICR #10061
 ;
 Q
PGULF(DFN) ; persian gulf indicator
 N OUT,VAERR,VAROOT,X,Y
 I '$D(^TMP($J,"SVC",DFN)) S VAROOT="^TMP($J,""SVC"",DFN)" D SVC^VADPT,KVAR^VADPT
 S OUT=$G(^TMP($J,"SVC",DFN,16)),OUT="Persian Gulf Indicator:  "_$S(OUT="":"<no data>",1:$P(OUT,U,2))
 Q OUT
