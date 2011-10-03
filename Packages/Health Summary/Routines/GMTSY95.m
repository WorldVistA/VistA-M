GMTSY95 ; SLC/jlc - Health Summary Patch 95 Post init ; 05/22/2010
 ;;2.7;Health Summary;**95**;Oct 20, 1995;Build 3
 ;
EN ; Rebuild the 'B' cross-reference for 142.5, after increasing length
 K ^GMT(142.5,"B")
 N DIK
 S DIK="^GMT(142.5,",DIK(1)=".01^B" D ENALL^DIK
 Q
