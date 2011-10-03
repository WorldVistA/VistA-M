GMRYXPOS ;HIRMFO/YH,FT-Post-initialization for INTAKE/OUTPUT ;1/22/97
 ;;4.0;Intake/Output;;Apr 25, 1997
 ; set GMRY ON/OFF LINE value to 0 (on)
 S ^GMRD(126.95,1,"OFF")=0
 D POST1^GMRYFILE
 Q
