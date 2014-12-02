LRJUTL3 ;ALB/TMK - Topography/Collection sample/Etiology inactivate dates and file 60 audit utilities ;09/15/2010 10:42:52
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 Q
ACTV61(LRIEN,LRDT) ; Return active status of entry in file 61 as of date in LRDT 
 ; Returns 1 if active, 0 if not active 
 I '$G(LRDT) S LRDT=DT  ; assume current date if no date passed 
 Q $S($P($G(^LAB(61,LRIEN,64.91)),U,3):$P(^(64.91),U,3)>LRDT,1:1)
 ;
ACTV62(LRIEN,LRDT) ; Return active status of entry in file 62 as of date in LRDT 
 ; Returns 1 if active, 0 if not active 
 I '$G(LRDT) S LRDT=DT  ; assume current date if no date passed 
 Q $S($P($G(^LAB(62,LRIEN,64.91)),U,1):$P(^(64.91),U,1)>LRDT,1:1)
 ;
