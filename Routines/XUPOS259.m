XUPOS259 ;SFISC/SO- Correct DISABLE field in Protocols exported in 236 ;10:32 AM  10 Oct 2002
 ;;8.0;KERNEL;**259**;Jul 10, 1995
 ; Get domain pointer for site
 N XUX
 S XUX=$$GET1^DIQ(8989.3,"1,",.01)
 ; If Hoholulu then take no action
 I XUX["HONOLULU" D  Q
 . N X
 . S X="Site Honolulu - no action taken."
 . D MES^XPDUTL(X)
 ; Set DISABLE field for Protocols
 D
 . N DA,DIERR,ERR
 . S DA=$$FIND1^DIC(101,"","X","XUHUI FIELD CHANGE EVENT","B","","ERR")
 . I 'DA D  Q  ;Problem with lookup
 . . N X
 . . S X="Unable to lookup protocol 'XUHUI FIELD CHANGE EVENT' - no action taken."
 . . D MES^XPDUTL(X)
 . . Q
 . N DIE,DR
 . S DIE=101
 . S DR="2///*Do NOT remove this message"
 . D ^DIE
 . N X
 . S X="Protocol 'XUHUI FIELD CHANGE EVENT' has been DISABLED."
 . D MES^XPDUTL(X)
 . Q
 D
 . N DA,DIERR,ERR
 . S DA=$$FIND1^DIC(101,"","X","XUHUI SEND MESSAGE","B","","ERR")
 . I 'DA D  Q  ;Problem with lookup
 . . N X
 . . S X="Unable to lookup protocol 'XUHUI SEND MESSAGE' - no action taken."
 . . D MES^XPDUTL(X)
 . . Q
 . N DIE,DR
 . S DIE=101
 . S DR="2///*Do NOT remove this message"
 . D ^DIE
 . N X
 . S X="Protocol 'XUHUI SEND MESSAGE' has been DISABLED."
 . D MES^XPDUTL(X)
 . Q
 Q
