GMRCYP5 ;SLC/DLT - Consult patch 5 pre-init ;9/8/98  03:52
 ;;3.0;CONSULT/REQUEST TRACKING;**5**;DEC 27, 1997
 ;
EN ;Load protocols in GMRCR namespace into the PROCEDURE TYPE multiple
 D BMES^XPDUTL("** Begin loading GMRCR Protocols into File 123 PROCEDURE TYPE multiple based on the FILE LINK service **")
 N DA,PNM,PCNT,LCNT,OCNT,SNM,FL,DIC
 S PNM="GMRCR",(LCNT,PCNT,OCNT,BCNT)=0
 S GMRCPKG=$$FIND1^DIC(9.4,,"X","CONSULT/REQUEST TRACKING") I 'GMRCPKG D
 . D BMES^XPDUTL("Unable to find entry for CONSULT/REQUEST TRACKING in PACKAGE (#9.4) file")
 F  S PNM=$O(^ORD(101,"B",PNM)) Q:$E(PNM,1,5)'="GMRCR"  D
 . S PIEN=$O(^ORD(101,"B",PNM,0)) Q:'PIEN  D
 .. D SETFL
 .. D SETPKG
 .. D DISABLD
 D BMES^XPDUTL("Total # of GMRCR protocols reviewed in protocol file: "_PCNT)
 D BMES^XPDUTL("Total # of GMRCR protocols already added to a service in file 123.5: "_OCNT)
 D BMES^XPDUTL("Total # of GMRCR protocols successfully added to a service in file 123.5: "_LCNT)
 D BMES^XPDUTL("** Total # of GMRCR protocols Needing Review: "_BCNT)
 D BMES^XPDUTL("** Finished GMRCR Protocol File Link Processing **")
 D DELDUPS
 Q
SETFL ;Setup the protocol procedures in the service file based on FILE LINK
 S PCNT=PCNT+1
 S FL=$P($G(^ORD(101,+PIEN,5)),U,1)
 I +$O(^GMR(123.5,"APR",+PIEN,+FL,0)) S OCNT=OCNT+1 Q
 I '$D(^GMR(123.5,+FL,0)) D  Q
 . I $E(PNM,1,7)="GMRCRM " D BMES^XPDUTL("Protocol menu "_PNM_" ignored - OK") Q
 . D BMES^XPDUTL("Protocol "_PNM_" contains an invalid service (FILE LINK "_$S($L(FL):FL,1:"not defined")_") - ** needs review") S BCNT=BCNT+1 Q
 S SNM=$P($G(^GMR(123.5,+FL,0)),U,1)
 S Y=$$FILE101(+FL,PIEN)
 I +$G(Y)'>0 D BMES^XPDUTL("Unsuccessful add of Procedure "_PNM_" to file123.5") S BCNT=BCNT+1 Q
 D BMES^XPDUTL("Procedure "_PNM_" successfully added to "_SNM_" service in file 123.5")
 S LCNT=LCNT+1
 Q
FILE101(SVC,X) ;load the protocol entry as a PROCEDURE TYPE for the service
 N DA,DIC,DLAYGO,Y
 K DD,DO
 S DA(1)=+SVC
 S DIC="^GMR(123.5,"_DA(1)_",101,"
 S DIC(0)="FL",X="`"_X
 S DIC("P")=$P(^DD(123.5,101,0),U,2)
 D ^DIC
 Q $G(Y)
 ;
DELPROC ;Delete protocols from 123.5 and start over.
 S PIEN=0
 F  S PIEN=$O(^GMR(123.5,"APR",PIEN)) Q:'PIEN  S DA(1)=0 F  S DA(1)=$O(^GMR(123.5,"APR",PIEN,DA(1))) Q:'DA(1)  D
 . S DA=0
 . F  S DA=$O(^GMR(123.5,"APR",PIEN,DA(1),0)) Q:'DA  D
 . . S DIK="^GMR(123.5,"_DA(1)_",101,"
 . . D ^DIK
 Q
SETPKG ;reset PACKAGE field if not set
 I $D(^ORD(101,PIEN,0)) D
 . Q:$P(^ORD(101,PIEN,0),U,12)=GMRCPKG
 . S $P(^ORD(101,PIEN,0),U,12)=GMRCPKG
 Q
DISABLD ;clear inadvertant DISABLE flag
 I $D(^ORD(101,PIEN,0)) D
 . I $P(^ORD(101,PIEN,0),U,3)=0 S $P(^(0),U,3)=""
 Q
DELDUPS ;clean up duplicate entries in PROCEDURE TYPE multiple
 N SERV,IEN,DUP,PROC
 D BMES^XPDUTL("Checking services for duplicate PROCEDURE TYPES")
 S SERV=0 F  S SERV=$O(^GMR(123.5,SERV)) Q:'SERV  D
 . Q:'$D(^GMR(123.5,SERV,101))
 . S PROC=0 F  S PROC=$O(^GMR(123.5,SERV,101,"B",PROC)) Q:'PROC  D
 .. S IEN=$O(^GMR(123.5,SERV,101,"B",PROC,0)) D
 ... Q:'$O(^GMR(123.5,SERV,101,"B",PROC,IEN))
 ... D BMES^XPDUTL(".")
 ... S DUP=IEN F  S DUP=$O(^GMR(123.5,SERV,101,"B",PROC,DUP)) Q:'DUP  D
 .... N DIK,DA,DA1
 .... S DA(1)=SERV,DA=DUP,DIK="^GMR(123.5,"_DA(1)_",101,"
 .... D ^DIK
 Q
