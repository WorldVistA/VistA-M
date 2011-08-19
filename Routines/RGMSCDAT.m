RGMSCDAT ;CAIRO/DKM - Date range input;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Prompt for date range (normal format)
NORMAL D NORMAL^RGUTDAT
 Q
 ; Prompt for date range (inverse format)
INVRSE D INVRSE^RGUTDAT
 Q
 ; Prompt for starting date
D1(RGOPT) ;
 D D1^RGUTDAT(.RGOPT)
 Q
 ; Prompt for ending date
D2(RGOPT) ;
 D D2^RGUTDAT(.RGOPT)
 Q
 ; Prompt for a date
ENTRY(%RGP,%RGOPT,%RGDAT,%RGX,%RGY,%RGTRP,%RGHLP) ;
 Q $$ENTRY^RGUTDAT(.%RGP,.%RGOPT,.%RGDAT,.%RGX,.%RGY,.%RGTRP,.%RGHLP)
