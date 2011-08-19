ESP116PT ;ALB/MLI - Add a mailgroup for Q-VAP confirmations ; 23 Apr 96
 ;;1.0;POLICE & SECURITY;**16**;Mar 31, 1994
 ;
 ; This post-installation routine will add the VAP mailgroup to
 ; receive confirmation messages from Q-VAP.
 ;
EN ; begin processing
 D MG
 Q
 ;
MG ; add mail group
 N DESC,XMY,X
 ;
 S X=$O(^XMB(3.8,"B","VAP",0))
 I $D(^XMB(3.8,+X,0)) D BMES^XPDUTL(">>> Mailgroup already exists...nothing added") Q
 ;
 S XMY(DUZ)="" ; put person running this patch in group initially
 S DESC(1)="This mail group was added for use in the Police and Security package."
 S DESC(2)="It will receive confirmation messages from Q-VAP where the crime"
 S DESC(3)="reports are sent."
 ;
 S X=$$MG^XMBGRP("VAP",0,0,0,.XMY,.DESC,1)
 ;
 I X D  Q  ; successful addition of mail group
 . D BMES^XPDUTL(">>> VAP mail group added successfully!")
 . D BMES^XPDUTL(">>> You have been added as a member of this mail group.")
 . D MES^XPDUTL("    Please add members or remove yourself as appropriate.")
 ;
 I 'X  D  Q  ; not successful...write message, instruct to try again
 . D BMES^XPDUTL(">>> NOTE:   Mail group not added!!!")
 . D MES^XPDUTL("    ERROR:  "_X)
 . D MES^XPDUTL("   ")
 . D MES^XPDUTL("    Please check your file and type D EN^ESP116PT to try again.")
 Q
