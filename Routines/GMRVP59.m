GMRVP59 ;BAY/KAM-Patch GMRV*5*9 Install Utility Routine ; 8/5/05 7:14am
 ;;5.0;GEN. MED. REC. - VITALS;**9**;Apr 15, 2003
 ;
ENV ;Main Entry point for Environment Check
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
PROGCHK(XPDABORT) ; checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^")  D
 . D BMES^XPDUTL("****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("*****")
 . S XPDABORT=2
 Q
PRE ;Add 1 second to all entries in File 120.5 that do not contain a time
 ;entry in piece one
 N GMRIEN,DATETIME,X1,X2
 K ^XTMP("GMRVP59",$J)
 I '$G(DT) S DT=$$DT^XLFDT
 I '$D(^XTMP("GMRVP59")) S X1=DT,X2=+90 D C^%DTC S ^XTMP("GMRVP59",0)=$G(X)_"^"_DT
 S GMRIEN=""
 F  S GMRIEN=$O(^GMR(120.5,GMRIEN)) Q:GMRIEN=""!(GMRIEN'?1.N)  D
 . S DATETIME=$P($G(^GMR(120.5,GMRIEN,0)),"^")
 . I +$P(DATETIME,".",2)'>0 D
 .. S $P(^XTMP("GMRVP59",$J,120.5,GMRIEN),"^")=$G(DATETIME) ; Before
 .. N GMRFDA
 .. S DATETIME=$$FMADD^XLFDT(DATETIME,"","","",1)
 .. S $P(^XTMP("GMRVP59",$J,120.5,GMRIEN),"^",2)=$G(DATETIME) ; After
 .. S GMRFDA(120.5,GMRIEN_",",.01)=DATETIME
 .. D UPDATE^DIE("","GMRFDA")
 Q
