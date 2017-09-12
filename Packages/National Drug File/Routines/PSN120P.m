PSN120P ;BIR/DMA-FIX CROSS REFERENCES ; 02 May 2006  12:43 PM
 ;;4.0; NATIONAL DRUG FILE;**120**; 30 Oct 98
 ;
 N X
 S X="^PS(56,""AE"")" F  S X=$Q(@X) Q:$QS(X,2)'="AE"  I '$D(^PS(56,$QS(X,5),0)) K @X
 S X="^PS(56,""AI1"")" F  S X=$Q(@X) Q:$QS(X,2)'="AI1"  I '$D(^PS(56,$QS(X,4),0)) K @X
 S X="^PS(56,""AI2"")" F  S X=$Q(@X) Q:$QS(X,2)'="AI2"  I '$D(^PS(56,$QS(X,4),0)) K @X
 S X="^PS(56,""APD"")" F  S X=$Q(@X) Q:$QS(X,2)'="APD"  I '$D(^PS(56,$QS(X,5),0)) K @X
 K X Q
