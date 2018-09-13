XU8P698 ;BP/BDT - POST ROUTINE 698 CLEAN UP; 07/26/18
 ;;8.0;KERNEL;**698**;Jul 10, 1995;Build 7
 ;;Per VHA Directive 6402, this routine should not be modified.
 Q
 ;
POST ;
 Q:$$KSP^XUPARAM("INST")=12000  ;Quit if Forum account
 ;I $$PATCH^XPDUTL("XU*8.0*684")=0 Q
 D CLEAN
 D LOOP
 Q
 ;
LIST ; List all duplicate PARENT FACILITY
 N XUI,XUY
 S XUI=0 F  S XUI=$O(^DIC(4,XUI)) Q:XUI'>0  D 
 . IF $D(^DIC(4,XUI,7,"B","PARENT FACILITY"))>0 S XUY=$O(^DIC(4,XUI,7,"B","PARENT FACILITY",0)) W !,"ENTRY#: "_XUI,"  SUB-ENTRY#: "_XUY
 Q
 ;
CLEAN ; Clean the dubplicate PARENT FACILITY
 N XUI,XUY,X,Y
 K ^XTMP("XU8P698")
 S X=$$DT^XLFDT,Y=$$FMADD^XLFDT(X,30)
 S ^XTMP("XU8P698",0)=Y_"^"_X_"^XU*8*698"
 M ^XTMP("XU8P698",$J,4)=^DIC(4)
 S XUI=0 F  S XUI=$O(^DIC(4,XUI)) Q:XUI'>0  D 
 . IF $D(^DIC(4,XUI,7,"B","PARENT FACILITY"))>0 S XUY=$O(^DIC(4,XUI,7,"B","PARENT FACILITY",0)) D CLEAN1(XUI,XUY),REINDEX(XUI)
 Q
 ;
CLEAN1(XUIEN,XUIEN1) ; delete one given entry in the subfile
 N DIK,DA
 S DA(1)=XUIEN,DA=XUIEN1,DIK="^DIC(4,"_DA(1)_",""7""," D ^DIK
 Q
 ;
REINDEX(XUIEN) ; delete x-refs in the subfile for an top entry
 N DIK,DA
 S DA(1)=XUIEN,DIK(1)=".01^1",DIK="^DIC(4,"_DA(1)_",""7""," D ENALL2^DIK
 S DA(1)=XUIEN,DIK(1)=".01^1",DIK="^DIC(4,"_DA(1)_",""7""," D ENALL^DIK
 Q
LOOP ; fix nodes of ASSOCIATION
 N XUI
 S XUI=0 F  S XUI=$O(^DIC(4,XUI)) Q:XUI'>0  D
 . I $D(^DIC(4,XUI,7,1,0)),+$G(^DIC(4,XUI,7,1,0))'=1 D CLEAN1(XUI,1)
 . I $D(^DIC(4,XUI,7,2,0)),+$G(^DIC(4,XUI,7,2,0))'=2 D CLEAN1(XUI,2)
 . Q 
 Q
