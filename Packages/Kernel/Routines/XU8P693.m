XU8P693 ;OAK_BP/BDT - POST ROUTINE 693 create a email group; 11/14/18
 ;;8.0;KERNEL;**693**;Jul 10, 1995;Build 13
 ;;Per VHA Directive 6402, this routine should not be modified.
 ; 
 Q
 ;
PRE ;
 I $D(^DD(200,7,1,2,0)) D DELIX^DDMOD(200,7,2)
 Q
 ;
POST ;
 N XUI,XUY,XUZ
 S XUY=$$MGTOBULL("ISO SECURITY","XUSERDIS") ;add a new mail group to a bulletin
 S XUZ=$$MGTOBULL("ISO SECURITY","XUSERDEAC") ;add a new mail group to a bulletin
 Q
 ;
END K DLAYGO,DA
 Q
 ;
MGTOBULL(XUMAIL,XUBULL) ; ADD A MAIL GROUP TO A BULLETIN
 N FDA,XUI,IENS,XUI
 S XUI=+$O(^XMB(3.6,"B",XUBULL,0))
 I XUI'>0 Q 0
 I +$O(^XMB(3.8,"B",XUMAIL,0))'>0 Q 0
 S IENS="?+1,"_XUI_","
 S FDA(3.62,IENS,.01)=XUMAIL
 D UPDATE^DIE("E","FDA",,"ERR")
 I $D(ERR) Q 0
 Q 1
 ;
