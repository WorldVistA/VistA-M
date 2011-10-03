HLEMSE1 ;ALB/CJM,ALB/BRM - Actions for an individual event; 10/23/00 9:49am ; 2/27/01 1:25pm
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
EDIT(EVENT) ;
 ;Allows the user to edit the notes and review status of an event
 I '$G(EVENT) S VALMBCK="" Q
 K DIE,DR,DA
 S DIE=776.4
 S DA=EVENT
 S DR="1;.06"
 D ^DIE
 K DIE,DR
 D INIT^HLEMSE
 Q
HELP(TYPE) ;
 ;Displays the full description of the event type
 D EN^HLEMSH($G(TYPE))
 Q
 ;
APPDATA(EVENT) ;
 ;Displays the application-specific data that was stored with the event
 D EN^HLEMSA($G(EVENT))
 Q
