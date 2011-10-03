VAQUTL4 ;ALB/JRP - UTILITY ROUTINES;10-JUN-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
MAILGRP(NAME,TYPE,SELF,RESTRICT,DESCRIBE) ;ADD/EDIT BASIC MAIL GROUP INFO
 ;INPUT  : NAME - Name of new mail group
 ;         TYPE - Flag indicating type of mail group
 ;                0 = public (default)
 ;                1 = private
 ;         SELF - Flag indicating if self enrollment is allowed
 ;                0 = no
 ;                1 = yes (default)
 ;         RESTRICT - Flag indicating restriction of mail group
 ;                    0 to 7 - refer to data dictionary for definitions
 ;                    0 (unrestricted) is default
 ;         DESCRIBE - Array containing description (full global ref)
 ;                    (optional)
 ;         DUZ - Current user
 ;OUTPUT : IFN^0 - Entry number of mail group edited
 ;         IFN^1 - Entry number of mail group added
 ;         -1^ErrorText - Error
 ;NOTES  : If editing an existing mail group, the basic information
 ;         already defined in the mail group will be overwritten.  The
 ;         current description will be deleted before the new
 ;         description is added.  If a new description is not passed,
 ;         the current description will not be deleted.
 ;       : The organizer of the mail group will be the current user.
 ;
 ;CHECK INPUT
 Q:($G(NAME)="") "-1^Did not pass name of mail group to create"
 Q:(($L(NAME)<3)!($L(NAME)>30)) "-1^Did not pass valid mail group name"
 S TYPE=+$G(TYPE)
 S:($G(SELF)="") SELF=1
 S:(SELF'=1) SELF=0
 S RESTRICT=+$G(RESTRICT)
 S:((RESTRICT<0)!(RESTRICT>7)) RESTRICT=0
 Q:('$G(DUZ)) "-1^You are not identified (NO DUZ)"
 ;DECLARE VARIABLES
 N DIC,X,Y,LINE,ADDED,IFN,DIE,DA,DR,DIK,DA
 ;SEE IF MAIL GROUP ALREADY EXISTS
 S ADDED=0
 S DIC="^XMB(3.8,"
 S DIC(0)="MX"
 S X=NAME
 D ^DIC K DIC
 S IFN=+Y
 ;CREATE STUB MAIL GROUP
 I (IFN<0) D  Q:(IFN<0) IFN
 .S ADDED=1
 .S DIC="^XMB(3.8,"
 .S DIC(0)="L"
 .S X=NAME
 .K DD,DO
 .D FILE^DICN K DIC
 .S IFN=+Y
 .S:(IFN<0) IFN="-1^Unable to create mail group"
 ;LOCK ENTRY
 S X=0
 L +^XMB(3.8,IFN):60 S:('$T) X=1
 ;COULDN'T LOCK (ERROR)
 I (X) D  Q Y
 .;ENTRY NOT CREATED
 .I ('ADDED) S Y="-1^Mail group was being edited by another user" Q
 .;DELETE ENTRY CREATED
 .S DIK="^XMB(3.8,"
 .S DA=IFN
 .D ^DIK
 .;COULDN'T DELETE NEW ENTRY
 .I ($D(^XMB(3.8,IFN))) S Y="-1^Error creating mail group; unable to delete (IFN:"_IFN_")" Q
 .;NEW ENTRY DELETED
 .S Y="-1^Error creating mail group; entry deleted"
 ;EDIT ENTRY
 S DIE="^XMB(3.8,"
 S DA=IFN
 S DR="4///"_$S(TYPE:"private",1:"public")
 S DR(1,3.8,5)="5////"_DUZ
 S DR(1,3.8,7)="7///"_$S(SELF:"YES",1:"NO")
 S X="UNRESTRICTED^ORGANIZER ONLY^LOCAL^ORGANIZER/LOCAL^INDIVIDUALS^INDIV/ORGANIZER^INDIV/LOCAL^INDIV/LOCAL/ORGANIZER"
 S Y=$P(X,"^",(RESTRICT+1))
 S:(Y="") Y=$P(X,"^",1)
 S DR(1,3.8,10)="10///"_Y
 I ($G(DESCRIBE)'="") I ($D(@DESCRIBE)) D
 .;DELETES CURRENT DESCRIPTION
 .S DR(1,3.8,3)="3///@"
 .;ADDS NEW DESCRIPTION
 .S LINE=""
 .F X=1:1 S LINE=$O(@DESCRIBE@(LINE)) Q:(LINE="")  D
 ..S Y=$G(@DESCRIBE@(LINE))
 ..S:(Y="") Y=" "
 ..S DR(1,3.8,(300+X))="3///+"_Y
 K X,Y D ^DIE
 ;UNLOCK ENTRY AND QUIT
 L -^XMB(3.8,IFN)
 Q IFN_"^"_ADDED
