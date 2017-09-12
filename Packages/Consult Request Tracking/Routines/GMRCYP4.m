GMRCYP4 ;SLC/DLT - Consult patch 4 pre-init ;7/16/98  09:52
 ;;3.0;CONSULT/REQUEST TRACKING;**4**;DEC 27, 1997
 ;   (Sub-sections copied from GMRCPRE for GMRC*3.0)
EN ;entry point for patch 4 clean-up
 ; -- Start over with Request Action Types in 123.1
 S $P(^GMR(123.5,0),"^",2)="123.5"
 N DIU
 ;
 D STATUS(1,100)
 S DIU=123.1 S DIU(0)="DT" D EN^DIU2
 ;
 D STATUS(25,100)
 S DIU=123 S DIU(0)="" D EN^DIU2
 ;
 D STATUS(50,100)
 S DIU=123.5 S DIU(0)="" D EN^DIU2
 ;
 ; -- Remove the menu items on the protocol menus
 D RMVITEMS("GMRCACTM SERVICE ACTION MENU")
 ;
 ; -- remove data in 6th piece of zero node in ^GMR(123.5,
 D OLDATA
 Q
 ;
CHGNAME(GMRCOLD,GMRCNEW) ;Use the old name to find the protocol and update its name.
 N DA,DIE,X,Y,DR
 S DA=$O(^ORD(101,"B",GMRCOLD,"")) Q:'DA
 I $O(^ORD(101,"B",GMRCNEW,0)) D BMES^XPDUTL("Protocol exists: "_$G(GMRCNEW)) Q
 D BMES^XPDUTL("Change Protocol Name from: "_$G(GMRCOLD)_" to: "_$G(GMRCNEW))
 S DIE="^ORD(101,",DR=".01///^S X=GMRCNEW"
 D ^DIE
 Q
RMVITEMS(GMRCMENU) ; -- Remove the menu items on the protocol menus
 N DA,X,Y,DIE,DIC,DIK,GMRCD0
 ;
 S GMRCD0=$O(^ORD(101,"B",GMRCMENU,"")) Q:'GMRCD0
 D BMES^XPDUTL("Remove menu from: "_$G(GMRCMENU))
 S DA=0 F TOTL=0:1 S DA=$O(^ORD(101,GMRCD0,10,DA)) Q:'DA
 S DA=0 F CURR=0:1 S DA=$O(^ORD(101,GMRCD0,10,DA)) Q:'DA  D
 . S DA(0)=GMRCD0,DIK="^ORD(101,"_GMRCD0_",10," D ^DIK
 . D:TOTL STATUS(((CURR/TOTL)*50)+50,100)
 Q
 ;
STATUS(CURRENT,XPDIDTOT) ;
 ;
 I '$D(XPDIDVT) N XPDIDVT
 S XPDIDVT=$G(XPDIDVT)
 D UPDATE^XPDID(CURRENT)
 ;
 Q
 ;
OLDATA ; get rid of data from previous version field
 N IEN
 S IEN=0 F  S IEN=$O(^GMR(123.5,IEN)) Q:'IEN  D
 . S $P(^GMR(123.5,IEN,0),U,6)=""
 Q
