RGRSPARM ;ALB/RJS-EDIT SEND/STOP/SUSPEND PARAMETER ;2/10/97
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**19**;30 Apr 99
 ;
 ;Reference to $$SEND^VAFHUTL supported by IA #2624
EN ;
 ;This routine is used to edit the STOP MPI/PD MESSAGING field (#16)
 ;in the CIRN SITE PARAMETER file (#991.8), to STOP/SEND/SUSPEND
 ;messages.
 ;
 N DA,DIE,DR,RGMAS,X
 S DA=$O(^RGSITE(991.8,0))
 I +DA'>0 Q
 S DR="16",DIE="991.8"
 D ^DIE
 S RGMAS=$P($$SEND^VAFHUTL,"^",2)
 I X'=RGMAS W !?5,"Does not match MAS parameter."
 E  W !?5,"In sync with MAS parameter."
 Q
