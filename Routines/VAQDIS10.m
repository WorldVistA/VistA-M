VAQDIS10 ;ALB/JFP - DISPLAY,REQUEST PDX BY PATIENT;01APR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
INIT ; -- Intialization
 D ^VAQUTL98
 ;
 N POP,DFN,VAQIN,VAQDFN,X,Y
 ;
 S:'$D(VAQOPT) VAQOPT="" ; -- should be set from menu option
MAIN ; -- Main entry point
 K BADSSN,FLE,FLD ; -- table entries
 K DIROUT,DIRUT,DTOUT,DUOUT
 S POP=0
 ;
 ; -- Call to Dir to request patient from patient file (2)
 S DIR("A")="Identify PDX: "
 S DIR(0)="FAO^1:30^K:(X'=$C(32)&($L(X)<3)) X"
 S DIR("?")="Enter Patient's Name (Last,First Middle) or SSN or Transaction #"
 S DIR("??")="^D HLPTRN1^VAQLED09"
 W !! D ^DIR K DIR G:$D(DIRUT) EXIT
 S (X,VAQIN)=Y
 ;
 ; -- Function call to get patient from transaction file (DIC)
 D:$D(XRTL) T0^%ZOSV ; -- Capacity start
 S VAQDFN=$$GETTRN^VAQUTL96(X)
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; -- Capacity stop
 D:VAQDFN=-1 PTNFND ; -- patient not in transaction file
 G:POP MLOOP
 D EP^VAQDIS11 ; -- Call to list processor (selection screen)
MLOOP G MAIN ; -- loop back until no more patient added
 ;
PTNFND ; -- Requested PDX not found
 W !,"Patient not found in PDX transaction file..."
 S POP=1
 QUIT
 ;
EXIT ; -- Cleanup and exit routine
 K BADSSN,FLE,FLD ; -- table entries
 K DIROUT,DIRUT,DTOUT,DUOUT
 K VAQOPT
 QUIT
 ;
END ; -- End of code
 QUIT
