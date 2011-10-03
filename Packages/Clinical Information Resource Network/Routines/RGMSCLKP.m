RGMSCLKP ;CAIRO/DKM - File lookup utility;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Old entry point
ENTRY(%RGDIC,%RGOPT,%RGPRMPT,%RGXRFS,%RGDATA,%RGSCN,%RGMUL,%RGX,%RGY,%RGSID,%RGTRP,%RGHLP) ;
 Q $$ENTRY^RGUTLKP(.%RGDIC,.%RGOPT,.%RGPRMPT,.%RGXRFS,.%RGDATA,.%RGSCN,.%RGMUL,.%RGX,.%RGY,.%RGSID,.%RGTRP,.%RGHLP)
