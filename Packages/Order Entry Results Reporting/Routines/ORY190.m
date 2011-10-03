ORY190 ; slc/CLA - Pre and Post-init for patch OR*3*190 ; Aug 6, 2003@11:02:31 [6/17/04 12:59pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**190**;Dec 17, 1997
 ;
PRE ;initiate pre-init processes
 ;
 Q
 ;
POST ;initiate post-init processes
 ;
 N VER
 ;
 S VER=$P($T(VERSION^ORY190),";",3)
 I +$$PATCH^XPDUTL("TIU*1.0*112") D SURGREG
 D SETVAL
 D SORTCHG
 D PSIV
 D MAIL
 ;
 Q
 ;
SURGREG ; Register TIU SURGERY RPCs if TIU*1.0*112 present
 N MENU,RPC
 S MENU="OR CPRS GUI CHART"
 F RPC="TIU IS THIS A SURGERY?","TIU IDENTIFY SURGERY CLASS","TIU LONG LIST SURGERY TITLES","TIU GET DOCUMENTS FOR REQUEST" D INSERT(MENU,RPC)
 Q
 ;
INSERT(OPTION,RPC) ; Call FM Updater with each RPC
 ; Input  -- OPTION   Option file (#19) Name field (#.01)
 ;           RPC      RPC sub-file (#19.05) RPC field (#.01)
 ; Output -- None
 N FDA,FDAIEN,ERR,DIERR
 S FDA(19,"?1,",.01)=OPTION
 S FDA(19.05,"?+2,?1,",.01)=RPC
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 Q
 ;
SETVAL ; Set package-level values for params
 N X
 S X=0,X=$O(^ORD(100.98,"B","NON-VA MEDICATIONS",X)) Q:'X  D 
 . D PUT^XPAR("PKG","ORWOR CATEGORY SEQUENCE",68,X)
 S X=0,X=$O(^ORD(101.41,"B","PSH OERR",X)) Q:'X  D 
 . D PUT^XPAR("PKG","ORWOR WRITE ORDERS LIST",53,X)
 D PUT^XPAR("PKG","ORWD NONVA REASON",1,"Non-VA medication not recommended by VA provider.")
 D PUT^XPAR("PKG","ORWD NONVA REASON",2,"Non-VA medication recommended by VA provider.")
 D PUT^XPAR("PKG","ORWD NONVA REASON",3,"Patient wants to buy from Non-VA pharmacy.")
 D PUT^XPAR("PKG","ORWD NONVA REASON",4,"Medication prescribed by Non-VA provider.")
 ;
 D PUT^XPAR("PKG","ORB SORT METHOD",1,"D")  ; Date/Time
 Q
 ;
SORTCHG ; conver "T" sort method values to "M"
 N ORLST,ORERR,ORBX,ORBE,ORBERR
 S ORBE=0,ORBX=0
 D ENVAL^XPAR(.ORLST,"ORB SORT METHOD",1,.ORERR)
 I 'ORERR,$G(ORLST)>0 D
 .F ORBX=1:1:ORLST S ORBE=$O(ORLST(ORBE)) I ORLST(ORBE,1)="T" D
 ..D EN^XPAR(ORBE,"ORB SORT METHOD",1,"M",.ORBERR)
 ..I +ORBERR>0 D
 ...S X="Error: "_ORBERR_" converting ORB SORT METHOD value 'T' to 'M' for entity "_ORBE
 ...D BMES^XPDUTL(X)
 Q
 ;
PSIV ; convert package ptrs in #101.41 from PSIV to PSJ
 N ORPSIV,ORPSJ,ORI,X
 S ORPSIV=+$$PKG^ORMPS1("PSIV"),ORPSJ=+$$PKG^ORMPS1("PSJ") Q:ORPSJ<1
 S ORI=$O(^ORD(101.41,"B","PSJI OR PAT FLUID OE",0)) I ORI,$D(^ORD(101.41,ORI,0)) S X=$P(^(0),U,7),$P(^(0),U,7)=ORPSJ K ^ORD(101.41,"APKG",X,ORI) S ^ORD(101.41,"APKG",ORPSJ,ORI)="" ;ensure IV dlg is correct
 I ORPSIV S ORI=0 F  S ORI=$O(^ORD(101.41,"APKG",ORPSIV,ORI)) Q:ORI<1  D
 . K ^ORD(101.41,"APKG",ORPSIV,ORI)
 . S $P(^ORD(101.41,ORI,0),U,7)=ORPSJ,^ORD(101.41,"APKG",ORPSJ,ORI)=""
 Q
 ;
MAIL ; send bulletin of installation time
 N COUNT,DIFROM,I,START,TEXT,XMDUZ,XMSUB,XMTEXT,XMY
 S COUNT=0
 S XMSUB="Version "_$P($T(VERSION),";;",2)_" Installed"
 S XMDUZ="CPRS PACKAGE"
 F I="G.CPRS GUI INSTALL@ISC-SLC.VA.GOV",DUZ S XMY(I)=""
 S XMTEXT="TEXT("
 ;
 S X=$P($T(VERSION),";;",2)
 D LINE("Version "_X_" has been installed.")
 D LINE(" ")
 D LINE("Install complete:  "_$$FMTE^XLFDT($$NOW^XLFDT()))
 ;
 D ^XMD
 Q
 ;
LINE(DATA) ; set text into array
 S COUNT=COUNT+1
 S TEXT(COUNT)=DATA
 Q
 ;
VERSION ;;24.26
