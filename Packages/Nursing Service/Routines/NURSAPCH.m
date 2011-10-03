NURSAPCH ;HIRMFO/JH,RM,FT-CHECKS FOR PATIENTS ON ABSENCE ;4/30/96  16:37
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
 ;
 ; DFN is defined before entering the routine.
 ; Routine checks patients on absence from the hospital.
 ; NURSX is the result of this function.
 ;
 D IN5^VADPT I 'VAERR S:VAIP(10)="" NURSX="ERROR" S:VAIP(10)'="" NURSUB=$S(VAIP(10):0,1:+VAIP(4)) G X:VAIP(10)'="",QUIT
 S NURSX="ERROR" G QUIT
X S NURSX=$S("^1^2^"[("^"_NURSUB_"^"):"LEAVE","^3^"[("^"_NURSUB_"^"):"AWOL","^43^45^"[("^"_NURSUB_"^"):"OTH. FAC.",1:"N/A")
QUIT ; KILL LOCAL VARIABLES
 K NURSA,NURSUB,NURSUB1,NURSTRAN,NS1,VAIP,VAERR
 Q
