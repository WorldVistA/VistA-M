IBCEFG70 ; ALB/TMP - OUTPUT FORMATTER GENERIC SCREEN PROCESSING; 02-APR-96
 ;;Version 2.0 ; INTEGRATED BILLING ;**52**; 21-MAR-94
 ;
SCRN(IBFORM,IBXIEN) ; Build screen display for form IBFORM and entry IBXIEN
 N Z,Z0,Z1,Z2,LAST,IBGRP
 D CLEAR^VALM1
 S LAST=$O(^TMP("IBXEDIT",$J,""),-1),IBGRP=""
 F  D  Q:IBGRP=""
 .F Z=1:1 Q:$O(^TMP("IBXDATA",$J,1,1,Z-1))=""  W ! D:$D(^TMP("IBXDATA",$J,1,1,Z))
 ..S Z0="" F  S Z0=$O(^TMP("IBXDATA",$J,1,1,Z,Z0)) Q:Z0=""  W ?Z0,^(Z0)
 .F Z=Z:1:$S($P($G(^IBE(353,IBFORM,2)),U,3):$P(^(2),U,3)-1,1:19) W !
 .W !,"<RET> or '^' to QUIT  or 1-",LAST," to EDIT: "
 .R IBGRP:DTIME
 .I "^"[IBGRP S IBGRP="" Q
 .I 'IBGRP!(IBGRP>LAST) W:IBGRP'="?" *7 D HELP S IBGRP="REASK" Q
 .D EDIT(IBGRP,IBFORM,IBXIEN)
 Q
 ;
EDIT(IBGRP,IBFORM,IBXIEN) ; Generic edit fields on a screen form IBFORM
 ;Loop here to read the group to edit (IBGRP)
 ; IBXIEN = entry number
 N Z,DR,DA,DIE,FLDS,Z0
 F Z=1:1:$L(IBGRP,",") S Z0=$P(IBGRP,",",Z) D:IBGRP'=""
 .I IBGRP'["-" S FLDS(+IBGRP)="" Q
 .F Z1=+IBGRP:1:$P(IBGRP,"-",2) S FLDS(Z1)=""
 S DR=""
 S IBGRP="" F  S IBGRP=$O(FLDS(IBGRP)) Q:'IBGRP  S Z=0 F  S Z=$O(^TMP("IBXEDIT",$J,IBGRP,Z)) Q:'Z  S DR=DR_$S($L(DR):";",1:"")_^(Z)
 I $L(DR) S DIE=+$G(^IBE(353,IBFORM,2)),DA=IBXIEN D ^DIE
 D CLEAR^VALM1
 Q
 ;
HELP ; Help for group prompt
 N X,I
 W !,"Enter '^' to stop the display and edit of data, or enter"
 W !,"the field group number(s) you wish to edit using commas and dashes as",!,"delimiters.  The elements that are editable are assigned a group number",!,"enclosed in brackets ""[]"" while those without group numbers are not."
 W ! F I=$Y:1:20 W !
 S Z="PRESS <RETURN> KEY to RETURN to SCREEN " R X:DTIME
 Q
