SYNDHP89 ; HC/art/fjf - HealthConcourse - DHP REST handlers
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 Q
 ;  ------------------------------------------------------------
 ;  Patient Text Integration Utility Notes by ICN bridge routine
 ;  ------------------------------------------------------------
 ;
PATTIUI ; get patient conditions for one patient by ICN
 ; ** to be retired
 ;
 ;   DHPPATTIUICN
 ;
 ;D PARSEICN
 ;D PATTIUI^SYNDHP67(.RETSTA,DHPICN)
 ;D ADD^RGNETWWW(RETSTA_$C(13,10))
 Q
