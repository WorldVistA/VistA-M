GMRCSUBS ;SLC/dee - Routine to check if a Service has more that one parient service ;1/18/00
 ;;3.0;CONSULT/REQUEST TRACKING;**7**;DEC 27, 1997
 ;
 Q
EN ;Check the service hierarchy (file #123.5) for services
 ; that have more than are in more than one grouper.
 N SERVICE,PARENT,COUNT,NUMBER
 S NUMBER=0
 ;$Order though all Services
 S SERVICE=0
 F  S SERVICE=$O(^GMR(123.5,SERVICE)) Q:'+SERVICE  D
 . S PARENT=0
 . ;Check if they are a subservice to more than one service.
 . F COUNT=0:1 S PARENT=$O(^GMR(123.5,"APC",SERVICE,PARENT)) Q:'+PARENT  D
 .. ;
 . ;Print message about which services this service is a subservice of.
 . I COUNT>1 D
 .. W !,"Service ",$P(^GMR(123.5,SERVICE,0),"^",1)," is a sub service of:"
 .. S PARENT=0
 .. F  S PARENT=$O(^GMR(123.5,"APC",SERVICE,PARENT)) Q:'+PARENT  W !,"   ",$P(^GMR(123.5,PARENT,0),"^",1)
 .. S NUMBER=NUMBER+1
 ;Print totals.
 I NUMBER=0 W !!,"No Services are sub-services for more than one service."
 E  I NUMBER=1 W !!,"There is ",NUMBER," service that is a sub-service for more than one service."
 E  W !!,"There are ",NUMBER," services that are sub-services for more than one service."
 Q
 ;
CLEANAE ;Post-init for patch GMRC*3*7
 ;This will delete the AE cross-reference and then rebuild it.
 ;This is to make sure that the AE cross-reference does not contain
 ; any bad entries.
 N DIK
 K ^GMR(123,"AE")
 S DIK="^GMR(123,",DIK(1)="1^AE"
 D ENALL^DIK
 Q
 ;
POST ;Post install routine for patch 7
 D BMES^XPDUTL("Running POST^GMRCSUBS")
 D CLEANAE
 Q
 ;
