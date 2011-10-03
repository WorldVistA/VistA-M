VAQPST05 ;ALB/JFP - PDX, POST INIT ROUTINE ;01JUN93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
TERMTYP ; -- Displays a table to show what terminal attributes must be defined
 W !!,"In order to effectively use PDX, the following terminal type attributes"
 W !,"must be defined for each terminal type used.  Please verify these attributes"
 W !,"against the TERMINAL TYPE file at your facility."
 W !!,?5,"Attribute",?35,"Value for a VT series terminal"
 W !,?5,"---------",?35,"------------------------------"
 F I=1:1 S VAQND=$T(ATT+I)  Q:($P(VAQND,";;",2)="")  D
 .W !,?5,$P(VAQND,U,2),?35,$P(VAQND,U,3)
 W !!
 K VAQND,I
ATT ;
 ;;   ^Form Feed^#,$C(27,91,50,74,27,91,72)
 ;;   ^XY CRT^W $C(27,91)_(DY+1)_$C(59)_(DX+1)_$C(72)
 ;;   ^Erase to End of Page^$C(27,91,74)
 ;;   ^Insert Line^$C(27)_"[1L"
 ;;   ^Underline On^$C(27,91,52,109)
 ;;   ^Underline Off^$C(27,91,109)
 ;;   ^High Intensity^$C(27,91,49,109)
 ;;   ^Normal Intensity^$C(27,91,109)
 ;;   ^Save Cursor Position^$C(27,55)
 ;;   ^Restore Cursor Position^$C(27,56)
 ;;   ^Set Top/Bottom Margin^$C(27,91)_(+IOTM)_$C(59)_(+IOBM)_$C(114)
 ;;
END ; -- End of code
 QUIT
