GMRYXPRE ;HIRMFO/YH,FT-Pre-initialization for INTAKE/OUTPUT ;1/22/97
 ;;4.0;Intake/Output;;Apr 25, 1997
EN1 ; set GMRY ON/OFF LINE value to 1 (off)
 I $D(^GMRD(126.95,0)) S ^GMRD(126.95,1,"OFF")=1
 Q
