RGMSCEDT ;CAIRO/DKM - Screen-oriented line editor;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Old entry point
ENTRY(RGDATA,RGLEN,RGX,RGY,RGVALD,RGOPT,RGDISV,RGTERM,RGABRT,RGRM,RGQUIT) ;
 Q $$ENTRY^RGUTEDT(.RGDATA,.RGLEN,.RGX,.RGY,.RGVALD,.RGOPT,.RGDISV,.RGTERM,.RGABRT,.RGRM,.RGQUIT)
