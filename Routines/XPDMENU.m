XPDMENU ;SFISC/RWF,RSD - Manage Menu items ;07/03/2003  09:12
 ;;8.0;KERNEL;**21,302**;Jul 10, 1995
 Q
 ;
 ;MENU=option to add to,  OPT=option to add to MENU, SYN=synonym
 ;ORD=display order
ADD(MENU,OPT,SYN,ORD) ;EF. Add options to a menu or extended action
 Q:$G(MENU)']"" 0 Q:$G(OPT)']"" 0
 N X,XPD1,XPD2,XPD3,DIC,DA,D0,DR,DLAYGO
 S XPD1=$$LKOPT(MENU) Q:XPD1'>0 "0^no menu"
 ;quit if type is not menu or extended action
 I "MX"'[$E($$TYPE(XPD1)_"~",1) Q "0^wrong type"
 S XPD2=$$LKOPT(OPT) Q:XPD2'>0 "0^option not found"
 ;if OPTion is not in menu, add it
 I '$D(^DIC(19,XPD1,10,"B",XPD2)) D
 .S X=XPD2,(D0,DA(1))=XPD1,DIC(0)="MLF",DIC("P")=$P(^DD(19,10,0),"^",2),DLAYGO=19,DIC="^DIC(19,"_XPD1_",10,"
 .D FILE^DICN
 S XPD3=$O(^DIC(19,XPD1,10,"B",XPD2,0))
 I XPD3>0 S DR="" S:$G(SYN)]"" DR="2///"_SYN_";" S:$G(ORD)]"" DR=DR_"3///"_ORD I DR]"" S DIE="^DIC(19,"_XPD1_",10,",DA=XPD3,DA(1)=XPD1 D ^DIE
 Q XPD3>0
 ;
LKOPT(X) ;EF.  To lookup on "B"
 Q $O(^DIC(19,"B",X,0))
 ;
TYPE(X) ;EF. Return option type, Pass IFN.
 Q:X'>0 "" Q $P($G(^DIC(19,X,0)),"^",4)
 ;
 ;MENU=option to delete from,  OPT=option to delete
DELETE(MENU,OPT) ;EF. Delete item from menu or extended action.
 Q:$G(MENU)']"" 0 Q:$G(OPT)']"" 0
 N XPD1,XPD2,DIK,DA,X
 S XPD1=$$LKOPT(MENU) Q:XPD1'>0 0
 I "MX"'[$E($$TYPE(XPD1)_"~",1) Q 0
 S XPD2=$$LKOPT(OPT) Q:XPD2'>0 0
 S DA=$O(^DIC(19,XPD1,10,"B",XPD2,0)) Q:DA'>0 0
 S DA(1)=XPD1,DIK="^DIC(19,XPD1,10," D ^DIK
 Q 1
 ;
 ;OPT=option to set out of order,  TXT=message
OUT(OPT,TXT) ;Set option out of order
 Q:$G(OPT)']""
 N XPD,XPD1
 S XPD1=$$LKOPT(OPT) Q:XPD1'>0
 S XPD(19,XPD1_",",2)=$G(TXT) D FILE^DIE("","XPD")
 Q
 ;
 ;OLD=old name, NEW=new name
RENAME(OLD,NEW) ;Rename option
 Q:$G(OLD)']""  Q:$G(NEW)']""
 N XPD,XPD1
 S XPD1=$$LKOPT(OLD) Q:XPD1'>0
 S XPD(19,XPD1_",",.01)=NEW D FILE^DIE("","XPD")
 Q
