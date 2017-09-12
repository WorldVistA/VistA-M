NUR35PST ;HCIOFO/FT-NUR*4*35 Post Install Routine ;5/15/01  09:12
 ;;4.0;NURSING SERVICE;**35**;Apr 25, 1997
EN1 ; Post install for NUR*4*35.
 ; Loop through the FILE 211.3, find duplicates and rename them.
 N NURABB,NURCNT,NURIEN
 D BMES^XPDUTL("Checking FILE 211.3 for duplicate .01 values...")
 S NURABB=""
 F  S NURABB=$O(^NURSF(211.3,"B",NURABB)) Q:NURABB=""  D
 .S (NURCNT,NURIEN)=0
 .F  S NURIEN=$O(^NURSF(211.3,"B",NURABB,NURIEN)) Q:'NURIEN  D
 ..S NURCNT=NURCNT+1
 ..Q:NURCNT<2
 ..D RENAME(NURIEN,NURABB)
 ..Q
 .Q
 Q
RENAME(IEN,ABB) ; Rename FILE 211.3 entry by appending IEN to .01 value
 N DA,DIE,DR,MESSAGE,OLD
 Q:'IEN
 S OLD=ABB
 I $L(ABB_IEN)<11 S ABB=ABB_IEN
 E  S ABB=$E(ABB,1,(10-$L(IEN)))_IEN
 S DA=IEN,DIE="^NURSF(211.3,",DR=".01///"_ABB
 D ^DIE
 S MESSAGE="   Renamed entry #"_IEN_" from "_OLD_" to "_ABB
 D BMES^XPDUTL(MESSAGE)
 Q
