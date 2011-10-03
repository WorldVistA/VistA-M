VBECPOST ;HIOFO;BNT VBECS 1.0 Post Install Routine ; 01/28/05 11:17
 ;;1.0;VBECS;;Apr 14, 2005;Build 35
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Call to XPDUTL is supported by IA: #10141
 ; Call to FILE^DICN is supported by IA: #10009
 ; Call to FIND1^DIC is supported by IA: #
 ; Reference to File 60 supported by IA: #10054
 ; Reference to File 61 supported by IA: #10055
 ; Reference to File 62 supported by IA: #
 ; Reference to File 4  supported by IA: #10090
 ;
EN ;
 ; Add 'OTHER' TOPOGRAPHY FIELD if it doesn't exist.
 I '$$TOPOG() Q
 ; Add 'VBECS - NO SPECIMEN REQUIRED' COLLECTION SAMPLE if it doesn't exist.
 I '$$COLSAMP() Q
 ; Add 'VBECS...' LABORATORY TESTS if they don't exist.
 D LABTSTS
 ; Add PARAMETERS
 D XPAR
 ; Add Generic Blood Inventory for Lab workload processing
 D BLDINV
 ;
 Q
 ;
TOPOG() ; Make sure the 'OTHER' TOPOGRAPHY FIELD file 61 entry exists.
 D BMES^XPDUTL("Adding 'OTHER' TOPOGRAPHY FIELD.")
 D FIND^DIC(61,"","","","OTHER","","","","","OUT","ERR")
 I $D(OUT("DILIST",1,1)) D  Q 1
 . D MES^XPDUTL("   'OTHER' TOPOGRAPHY FIELD already exists.")
 N VBECFDA
 S VBECFDA(1,61,"+1,",.01)="OTHER"
 S VBECFDA(1,61,"+1,",2)="OTHER"
 D UPDATE^DIE("E","VBECFDA(1)","","OUT")
 I $D(OUT("ERROR")) D  Q 0
 . D MES^XPDUTL("   ***Error adding 'OTHER' TOPOGRAPHY FIELD.***")
 D MES^XPDUTL("   'OTHER' TOPOGRAPHY FIELD added successfully.")
 Q $S($D(OUT("ERROR")):0,1:1)
 ;
COLSAMP() ; Add the VBECS NO SPECIMEN REQUIRED entry to file 62
 D BMES^XPDUTL("Adding 'VBECS - NO SPECIMEN REQUIRED' COLLECTION SAMPLE.")
 N VBIENS,VBECFDA,CNT,OUT
 D FIND^DIC(62,"","","","VBECS - NO SPECIMEN REQUIRED","","","","","OUT","ERR")
 I $D(OUT("DILIST",1,1)) D  Q OUT("DILIST",2,1)
 . D MES^XPDUTL("   'VBECS - NO SPECIMEN REQUIRED' COLLECTION SAMPLE already exists.")
 S CNT=2
 S VBECFDA(1,62,"+1,",.01)="VBECS - NO SPECIMEN REQUIRED"
 S VBECFDA(1,62,"+1,",2)="OTHER"
 S VBECFDA(1,62,"+1,",6)="BLOOD BANK"
 S VBECFDA(1,62,"+1,",7)="NO"
 S VBECFDA(1,62.01,"+"_CNT_",+1,",.01)="NRQ"
 ;D ACNAREA(.VBECARY)
 ;F VBECI=1:1 S VBECX=$G(VBECARY(VBECI)) Q:VBECX=""  D
 ;. S CNT=CNT+1
 ;. S VBECFDA(1,62.02,"+"_CNT_",+1,",.01)=$P(VBECX,"^")
 D UPDATE^DIE("E","VBECFDA(1)","VBIENS","OUT")
 I $D(OUT("DIERR")) D  Q 0
 . D MES^XPDUTL("   ***Error adding 'VBECS - NO SPECIMEN REQUIRED' COLLECTION SAMPLE.***")
 I $D(VBIENS(1)) S VBECARY="" D ACNAREA(.VBECARY) F VBECI=1:1 S VBECARY=$O(VBECARY(VBECARY)) Q:VBECARY=""  D
  . S ^LAB(62,VBIENS(1),9,0)="^62.02PA^"_VBECARY_"^"_VBECI
  . S ^LAB(62,VBIENS(1),9,$P(VBECARY(VBECARY),"^",3),0)=$P(VBECARY(VBECARY),"^",3)
 D MES^XPDUTL("   'VBECS - NO SPECIMEN REQUIRED' COLLECTION SAMPLE added successfully.")
 Q VBIENS(1)
 ;
LABTSTS ; Add the VBECS Lab Tests to file 60
 ; Input: VBSAMP = IEN of the VBECS - NO SPECIMEN REQUIRED
 ;                 Collection Sample file #62 entry.
 D BMES^XPDUTL("Adding 'VBECS...' LABORATORY TESTS.")
 N VBECFDA,CNT,OUT,VBECLIEN
 D ACNAREA(.VBECARY)
 ;
 S CNT=2
 F VBECI=2:1  S VBDATA=$P($T(LST+VBECI),";;",2) Q:VBDATA["***"  D
 . D FIND^DIC(60,"","","",$P(VBDATA,"^",1),"","","","","OUT","ERR")
 . I $D(OUT("DILIST",1,1)) D  Q
 . . D MES^XPDUTL("'"_$P(VBDATA,"^",1)_"' LABORATORY TEST already exists.")
 . D MES^XPDUTL("---Adding '"_$P(VBDATA,"^",1)_"' LABORATORY TEST.")
 . ;
 . N VBECLIEN,VBECFDA,VBIENS,OUT
 . S VBECFDA(1,60,"+1,",.01)=$P(VBDATA,"^",1)
 . S VBECFDA(1,60,"+1,",3)="O"
 . S VBECFDA(1,60,"+1,",17)=$O(^LAB(62.05,"B","STAT",0))
 . S VBECFDA(1,60,"+1,",51)=$P(VBDATA,"^",4)
 . S VBECFDA(1,60,"+1,",4)="BB"
 . S VBECFDA(1,60,"+1,",8)=$P(VBDATA,"^",7)
 . ;
 . I $P(VBDATA,"^",6)="NRQ" D
 . . S VBECFDA(1,60.03,"+"_CNT_",+1,",.01)=$O(^LAB(62,"B","VBECS - NO SPECIMEN REQUIRED",0))
 . I $P(VBDATA,"^",6)="" D
 . . S VBCOL=$$DIR($P(VBDATA,"^",1))
 . . I +VBCOL S VBECFDA(1,60.03,"+"_CNT_",+1,",.01)=+VBCOL
 . D UPDATE^DIE("","VBECFDA(1)","VBIENS","OUT")
 . I $D(OUT("DIERR")) D  Q
 . . D MES^XPDUTL("   ***Error adding '"_$P(VBDATA,"^",1)_"' LABORATORY TEST***.")
 . . I $D(^LAB(60,"B",$P(VBDATA,"^",1))) D
 . . . D MES^XPDUTL("   Deleting entry...")
 . . . S DA=$O(^LAB(60,"B",$P(VBDATA,"^",1),0)) K DO
 . . . S DIE="^LAB(60,",DR=".01///@",DIDEL=60
 . . . D ^DIE
 . I $D(VBECARY),VBIENS(1),'$D(OUT("DIERR")) D
 . . S I="" F CNT=1:1 S I=$O(VBECARY(I)) Q:I=""  D
 . . . S X=VBECARY(I)
 . . . S ^LAB(60,VBIENS(1),8,0)="^60.11PA^"_$P(X,"^",4)_"^"_CNT
 . . . S ^LAB(60,VBIENS(1),8,I,0)=$P(X,"^",4)_"^"_$P(X,"^",3)
 . D MES^XPDUTL("   '"_$P(VBDATA,"^",1)_"' added successfully.")
 . Q
 Q
DIR(LABTST) ; Ask user for Collection Sample for Lab Test
 ;
 S DIR("A")="Select COLLECTION SAMPLE for Lab Test "_LABTST
 S DIR(0)="P^62:EMZ"
 D ^DIR
 Q Y
 ;
XPAR ;Main entry point
 ;
 D BMES^XPDUTL("Adding VBECS VISTALINK PARAMETERS.")
 N VBDATA
 F VBECI=1:1 S VBDATA=$P($T(PARMS+VBECI),";;",2) Q:VBDATA["***"  D
 . D MES^XPDUTL("---Adding '"_VBDATA_"' PARAMETER.")
 . I $$CONTEXT^VBECRPCC(VBDATA,$$ENCRYP^XUSRB1("VBECS RPC Security")) D
 . . D MES^XPDUTL("   ***Error adding '"_VBDATA_"' PARAMETER.***")
 . E  D MES^XPDUTL("   '"_VBDATA_"' PARAMETER added successfully.")
 ; Check Post Install questions and create VistALink IP Address and Port parameters.
 I $D(XPDQUES("POSVLIPADDRESS"))&($D(XPDQUES("POSVLPORT"))) D
 . D MES^XPDUTL("---Adding 'VISTALINK IP ADDRESS' and 'VISTALINK PORT NUMBER' PARAMETERS.")
 . I '$$CHGADPRT^VBECRPCC(XPDQUES("POSVLIPADDRESS"),XPDQUES("POSVLPORT")) D  Q
 . . D MES^XPDUTL("   'VISTALINK IP ADDRESS' and 'VISTALINK PORT NUMBER' PARAMETERS added successfully.")
 . D MES^XPDUTL("   ***Error adding 'VISTALINK IP ADDRESS' and 'VISTALINK PORT NUMBER' PARAMETERS.***")
 Q
 ;
ACNAREA(VBECARY) ; Return Lab Blood Bank Accession Areas
 N CNT
 S (X,CNT)=0
 F  S X=$O(^LRO(68,X)) Q:X'?1N.N  D
 . Q:$P(^LRO(68,X,0),"^",2)'="BB"
 . S DIV=$O(^LRO(68,X,3,0))_","
 . D GETS^DIQ(4,DIV,".01",,"OUT","ERR")
 . S INST=$G(OUT(4,DIV,.01))
 . S CNT=CNT+1 S VBECARY(+DIV)=$P(^LRO(68,X,0),"^")_"^"_INST_"^"_X_"^"_$O(^LRO(68,X,3,0))
 . Q
 Q
 ;
BLDINV ; Add Generic VBECS Blood Inventory for Lab Workload Reporting
 D BMES^XPDUTL("Adding generic VBECS BLOOD INVENTORY")
 N VBECFDA
 I $$FIND1^DIC(65,"","MX","VBECS1","","","ERR") D  Q
 . D MES^XPDUTL("   'VBECS1' BLOOD INVENTORY already exists.")
 D MES^XPDUTL("---Adding 'VBECS1' BLOOD INVENTORY.")
 S VBECFDA(1,65,"+1,",.01)="VBECS1"
 S VBECFDA(1,65,"+1,",.02)="VBECS SYSTEM"
 S VBECFDA(1,65,"+1,",.03)="1.0"
 S VBECFDA(1,65,"+1,",.04)="VBECS PRODUCT"
 S VBECFDA(1,65,"+1,",.05)=$$NOW^XLFDT()
 S VBECFDA(1,65,"+1,",.06)="3100101"
 S VBECFDA(1,65,"+1,",.07)="N/A"
 S VBECFDA(1,65,"+1,",.08)="N/A"
 ; Need to determine primary division
 S VBECFDA(1,65,"+1,",.16)="589"
 S VBECFDA(1,65,"+1,",4.2)=$$NOW^XLFDT()
 D UPDATE^DIE("","VBECFDA(1)","VBIENS","OUT")
 I $D(OUT("DIERR")) D  Q
 . D MES^XPDUTL("   ***Error adding 'VBECS1' BLOOD INVENTORY.***")
 D MES^XPDUTL("   'VBECS1' BLOOD INVENTORY added successfully.")
 Q
 ;
BLDDONOR ; Add Generic VBECS BLOOD DONOR for Lab Workload Reporting
 N VBECFDA
 Q
 ;
DEL ; Delete entries for testing
 N DA,DR,DIE,DIDEL,VBDATA,VBIEN,X
 D FIND^DIC(61,"","","","OTHER","","","","","OUT","ERR")
 I $D(OUT("DILIST",1,1)) D
 . D MES^XPDUTL("Deleting 'OTHER' TOPOGRAPHY FILE Entry")
 . S X=0
 . F I=0:1 S X=$O(OUT("DILIST",1,I)) Q:X=""  D
 . . S DA=OUT("DILIST",2,X),DIE="^LAB(61,",DR=".01///@",DIDEL=61 D ^DIE
 K DA,DR,DIE,DIDEL,VBIEN
 ;
 D FIND^DIC(62,"","","","VBECS - NO SPECIMEN REQUIRED","","","","","OUT","ERR")
 I $D(OUT("DILIST",1,1)) D
 . D MES^XPDUTL("Deleting 'VBECS - NO SPECIMEN REQUIRED' COLLECTION SAMPLE")
 . S X=0
 . F I=0:1 S X=$O(OUT("DILIST",1,I)) Q:X=""  D
 . . S DA=OUT("DILIST",2,X),DIE="^LAB(62,",DR=".01///@",DIDEL=62 D ^DIE
 K DA,DR,DIE,DIDEL,VBIEN
 ;
 S VBIEN=$$FIND1^DIC(65,"","MX","VBECS1","","","ERR")
 I +VBIEN D
 . D MES^XPDUTL("Deleting 'VBECS1' BLOOD DONOR")
 . S DA=VBIEN,DIE="^LRD(65,",DR=".01///@",DIDEL=65 D ^DIE
 K DA,DR,DIE,DIDEL,VBIEN
 ;
 F VBECI=2:1  S VBDATA=$P($T(LST+VBECI),";;",2) K DO Q:$P(VBDATA,"^",1)="***"  D
 . D FIND^DIC(60,"","","",$P(VBDATA,"^",1),"","","","","OUT","ERR")
 . I $D(OUT("DILIST",1,1)) D  Q
 . . D MES^XPDUTL("Deleting '"_$P(VBDATA,"^",1)_"' LABORATORY TEST")
 . . S X=0
 . . F I=0:1 S X=$O(OUT("DILIST",1,I)) Q:X=""  D
 . . . S DA=OUT("DILIST",2,X),DIE="^LAB(60,",DR=".01///@",DIDEL=60 D ^DIE
 Q
 ;
LST ;;NAME^TYPE^HIGHEST URGENCY ALLOWED^PRINT NAME^SUBSCRIPT^COLLECTION SAMPLE^UNIQUE COLLECTION SAMPLE
 ;;.01 ^3   ^17                      ^51        ^4        ^60.03,.01        ^8
 ;;ABO/RH - LAB^O^STAT^ABO RH^BB^^1
 ;;ANTIBODY SCREEN - LAB^O^STAT^AB SCRN^BB^^1
 ;;DIRECT ANTIGLOBULIN TEST - LAB^O^STAT^DAT^BB^^1
 ;;TRANSFUSION REACTION WORKUP - LAB^O^STAT^TRW^BB^^1
 ;;TYPE & SCREEN - LAB^O^STAT^T&S^BB^^1
 ;;CRYOPRECIPITATE - LAB^O^STAT^CRYOPRE^BB^NRQ^1
 ;;FRESH FROZEN PLASMA - LAB^O^STAT^FFP^BB^NRQ^1
 ;;OTHER - LAB^O^STAT^VBOTHER^BB^NRQ^1
 ;;PLATELETS - LAB^O^STAT^PLTLTS^BB^NRQ^1
 ;;RED BLOOD CELLS - LAB^O^STAT^RED BLD^BB^NRQ^1
 ;;WHOLE BLOOD - LAB^O^STAT^WB^BB^NRQ^1
 ;;***^Add new entries above this line
 Q
 ;
PARMS ; Build VBECS PARAMETERS
 ;;VBECS Order Entry
 ;;VBECS Workload
 ;;VBECS Update Workload Event
 ;;VBECS Patient ABO_RH
 ;;VBECS Patient TRRX
 ;;VBECS Patient ABID
 ;;VBECS Patient Available Units
 ;;VBECS Blood Products
 ;;VBECS Patient Transfusion History
 ;;VBECS Patient Report
 ;;VBECS DSS Extract
 ;;***^Add new entries above this line
 Q
 ;
BI ;;UNIT ID^SOURCE^INVOICE#^COMPONENT^DATE/TIME RECEIVED^EXP DATE/TIME^ABO GROUP^RH TYPE^DIVISION^DISP DATE
 ;;.01    ^.02   ^.03     ^.04      ^.05               ^.06          ^.07      ^.08    ^.16     ^4.2
 ;;VBECS GENERIC UNIT^VBECS SYSTEM^1.0^VBECS PRODUCT^^^N/A^N/A^^
 Q
