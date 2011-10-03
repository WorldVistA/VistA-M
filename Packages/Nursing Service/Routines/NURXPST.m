NURXPST ;HIRMFO/FT-Nursing Service v4.0 Post-Initialization Routine ;1/21/97  14:27
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
 ;
 ; This routine contains the post-initialization code for Nursing
 ; Service package v4.0.
 ;
 D MAILGRP,POST1^NURSFILE,MASMSG
 Q
MAILGRP ; Remind IRM to check for members in NURS-ADP mail group
 D BMES^XPDUTL("Reminder: Make certain the NURS-ADP mail group has at least one member.")
 Q
ONLINE ; Set Nursing software switch back to On-Line
 S $P(^DIC(213.9,1,"OFF"),U,1)=0
 D BMES^XPDUTL("Setting Nursing software switch back to ON-LINE")
 Q
MAS ; post-init ward deactivation/activation to update mas movements
 S (NURSTUS)="I",(NURSBAD,NURSEND,OUTSW)=0 D DATACK^NURSCPLU D:'NURSDATA FIRSTIME^NURSCPLU I NURSEND K NURSEND D ONLINE Q
 F NURS1=0:0 S NURS1=$O(^NURSF(211.4,"D","A",NURS1)) Q:NURS1'>0  S NURSWRD(NURS1)=NURS1
 D ACTINAC
 S (NURSTUS)="A" D ACTINAC
 D ONLINE
 K NURS,DA,DIC,X,Y,NURSTUS,SSTAT,NURS1,NURSBAD,NURSEND,OUTSW,NURSWRD
 Q
ACTINAC D ACTWARD^NURSCPLU
 I $D(NURSWRD) D INIT214^NURSCPLU K NURSEND
 Q
MASMSG ;
 K NURMSG
 S NURMSG(1)=" "
 S NURMSG(2)="Before setting the Nursing software back on-line, I need"
 S NURMSG(3)="to update the NURS Patient file (#214) with any MAS patient"
 S NURMSG(4)="movements that took place while this software was installed."
 S NURMSG(5)="At the programmers prompt please do the following:"
 S NURMSG(6)=""
 S NURMSG(7)=" D MAS^NURXPST"
 S NURMSG(8)=" "
 D BMES^XPDUTL(.NURMSG)
 K NURMSG
 Q
