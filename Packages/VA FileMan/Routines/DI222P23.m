DI222P23 ;OAKFO/RSD - Post Install for patch 23 ; Jul 05, 2022@13:20:47
 ;;22.2;VA FileMan;**23**;Jan 05, 2016;Build 2
 ; 
EN ; clean up ^DIC(subDD,"%MSC") nodes
 N X,C
 S (X,C)=0
 F  S X=$O(^DIC(X)) Q:'X  I '$D(^DIC(X,0)),$D(^("%MSC")) K ^DIC(X,"%MSC") S C=C+1
 D BMES^XPDUTL("Number of %MSC nodes removed: "_C)
 Q
