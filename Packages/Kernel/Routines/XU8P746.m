XU8P746 ;OAK/JLG - POST ROUTINE FOR PATCH XU*8*746; Feb 12, 2021@14:15
 ;;8.0;KERNEL;**746**;Jul 10, 1995;Build 7
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST    ; POST routine
 D ADDOP
 Q
 ;
ADDOP   ; Add a new option under the XUSER SEC OFCR menu option.
 N XUA,XUB,XUC
 S XUA="XUSER SEC OFCR"
 S XUB="XUSER REMOTE"
 IF $$FIND1^DIC(19,,"X",XUA,,,),$$FIND1^DIC(19,,"X",XUB,,,) S XUC=$$ADD^XPDMENU(XUA,XUB,,)
 Q
 ;
