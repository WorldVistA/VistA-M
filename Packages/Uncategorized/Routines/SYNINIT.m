SYNINIT ;OSEHRA/SMH - Initilization Code for Synthetic Data Loader;May 23 2018 ;Aug 15, 2019@16:15:31
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; (c) Sam Habiel 2018-2019
 ; Licensed under Apache 2.0.
 ;
EN ; [Public; called by KIDS; do everything in this file]
 ;D LOADHAND
 D MES^XPDUTL("")
 D MES^XPDUTL("Syn Patients Importer Init")
 D MES^XPDUTL("Provider "_$$PROV(1))
 D MES^XPDUTL("Pharmacist "_$$PHARM(1))
 D MES^XPDUTL("Hospital Location "_$$HL())
 D MES^XPDUTL("Fixing AMIE thingy") D AMIE
 D MES^XPDUTL("Fixing IB ACTION TYPE file") D IBACTION
 D MES^XPDUTL("Setting up Outpatient Pharmacy "_$$PHRSS())
 D MES^XPDUTL("Disabling Allergy Bulletins") D ALBUL
 QUIT
 ;
 ;
PROV(rePopulate) ;[Public $$] Create Generic Provider for Synthetic Patients
 ; ASSUMPTION: DUZ MUST HAVE XUMGR OTHERWISE FILEMAN WILL BLOCK YOU!
 N NAME S NAME="PROVIDER,UNKNOWN SYNTHEA" ; Constant
 n C0XIEN s C0XIEN=$O(^VA(200,"B",NAME,0))
 if C0XIEN,'$get(rePopulate) quit C0XIEN
 if C0XIEN,$get(rePopulate) do
 . new DA,DIK
 . set DA=C0XIEN
 . set DIK="^VA(200,"
 . do ^DIK
 . kill C0XIEN
 . set C0XIEN(1)=DA
 ;
 N C0XFDA,C0XERR,DIERR
 S C0XFDA(200,"?+1,",.01)=NAME
 S C0XFDA(200,"?+1,",1)="USP" ; Initials
 S C0XFDA(200,"?+1,",28)=100 ; Mail Code
 S C0XFDA(200,"?+1,",53.1)=1 ; Authorized to write meds
 S C0XFDA(200.05,"?+2,?+1,",.01)="`144" ; Person Class - Allopathic docs.
 S C0XFDA(200.05,"?+2,?+1,",2)=2000101 ; Date active
 ;
 ; Security keys
 S C0XFDA(200.051,"?+3,?+1,",.01)="PROVIDER"
 S C0XFDA(200.051,"?+4,?+1,",.01)="ORES"
 S C0XFDA(200.051,"?+10,?+1,",.01)="LRLAB"
 S C0XFDA(200.051,"?+11,?+1,",.01)="LRVERIFY"
 ;
 ; Access and Verify Codes so we can log in as the provider if we want to
 ; We must pre-hash them as that's not in the IT
 S C0XFDA(200,"?+1,",2)=$$EN^XUSHSH("SYNPROV123") ; ac
 S C0XFDA(200,"?+1,",11)=$$EN^XUSHSH("SYNPROV123!!") ; vc
 S C0XFDA(200,"?+1,",7.2)=1 ; verify code never expires
 ;
 ; Electronic Signature
 ; Input transform hashes this guy
 S C0XFDA(200,"?+1,",20.4)="123456"
 ;
 ; Primary Menu
 S C0XFDA(200,"?+1,",201)="`"_$$FIND1^DIC(19,,"QX","XUCORE","B")
 ;
 ; Secondary Menu (CPRS, etc)
 S C0XFDA(200.03,"?+5,?+1,",.01)="`"_$$FIND1^DIC(19,,"QX","OR CPRS GUI CHART","B")
 ;
 ; Restrict Patient Selection
 S C0XFDA(200,"?+1,",101.01)="NO"
 ;
 ; CPRS Tabs
 S C0XFDA(200.010113,"?+6,?+1,",.01)="COR"
 S C0XFDA(200.010113,"?+6,?+1,",.02)="T-1"
 ;
 ; Service/Section
 S C0XFDA(200,"?+1,",29)="`"_$$MEDSS()
 ;
 ; NPI - Ferdi made this one up.
 S C0XFDA(200,"?+1,",41.99)="9990000348"
 ;
 N DIC S DIC(0)="" ; An XREF in File 200 requires this.
 D UPDATE^DIE("E",$NA(C0XFDA),$NA(C0XIEN),$NA(C0XERR)) ; Typical UPDATE
 I $D(DIERR) S $EC=",U1,"
 ;
 ; Fix verify code change date to the far future
 N FDA
 S FDA(200,C0XIEN(1)_",",11.2)=$$FMTH^XLFDT($$FMADD^XLFDT(DT,3000))
 ;
 ; Signature block. Do this as internal values to prevent name check in 20.2.
 S FDA(200,C0XIEN(1)_",",20.2)="SYNTHETIC PROVIDER, MD"
 S FDA(200,C0XIEN(1)_",",20.3)="Staff Physician"
 ;
 D FILE^DIE(,$NA(FDA))
 I $D(DIERR) S $EC=",U1,"
 ;
 Q C0XIEN(1) ;Provider IEN
 ;
PHARM(rePopulate) ;[Public $$] Create Generic Provider for Synthetic Patients
 ; ASSUMPTION: DUZ MUST HAVE XUMGR OTHERWISE FILEMAN WILL BLOCK YOU!
 N NAME S NAME="PHARMACIST,UNKNOWN SYNTHEA" ; Constant
 n C0XIEN s C0XIEN=$O(^VA(200,"B",NAME,0))
 if C0XIEN,'$get(rePopulate) quit C0XIEN
 if C0XIEN,$get(rePopulate) do
 . new DA,DIK
 . set DA=C0XIEN
 . set DIK="^VA(200,"
 . do ^DIK
 . kill C0XIEN
 . set C0XIEN(1)=DA
 ;
 N C0XFDA,C0XERR,DIERR
 S C0XFDA(200,"?+1,",.01)=NAME
 S C0XFDA(200,"?+1,",1)="UST" ; Initials
 S C0XFDA(200,"?+1,",28)=111 ; Mail Code
 S C0XFDA(200.05,"?+2,?+1,",.01)="`246" ; Person Class - Pharmacist
 S C0XFDA(200.05,"?+2,?+1,",2)=2000101 ; Date active
 ;
 ; Security keys
 S C0XFDA(200.051,"?+3,?+1,",.01)="PSORPH"
 S C0XFDA(200.051,"?+4,?+1,",.01)="ORELSE"
 ;
 ; Access and Verify Codes so we can log in as the provider if we want to
 ; We must pre-hash them as that's not in the IT
 S C0XFDA(200,"?+1,",2)=$$EN^XUSHSH("SYNPHARM123") ; ac
 S C0XFDA(200,"?+1,",11)=$$EN^XUSHSH("SYNPHARM123!!") ; vc
 S C0XFDA(200,"?+1,",7.2)=1 ; verify code never expires
 ;
 ; Electronic Signature
 ; Input transform hashes this guy
 S C0XFDA(200,"?+1,",20.4)="123456"
 ;
 ; Primary Menu
 S C0XFDA(200,"?+1,",201)="`"_$$FIND1^DIC(19,,"QX","XUCORE","B")
 ;
 ; Secondary Menu (CPRS, etc)
 S C0XFDA(200.03,"?+5,?+1,",.01)="`"_$$FIND1^DIC(19,,"QX","OR CPRS GUI CHART","B")
 ;
 ; Restrict Patient Selection
 S C0XFDA(200,"?+1,",101.01)="NO"
 ;
 ; CPRS Tabs
 S C0XFDA(200.010113,"?+6,?+1,",.01)="COR"
 S C0XFDA(200.010113,"?+6,?+1,",.02)="T-1"
 ;
 ; Service/Section
 S C0XFDA(200,"?+1,",29)="`"_$$PHRSS()
 ;
 N DIC S DIC(0)="" ; An XREF in File 200 requires this.
 D UPDATE^DIE("E",$NA(C0XFDA),$NA(C0XIEN),$NA(C0XERR)) ; Typical UPDATE
 I $D(DIERR) S $EC=",U1,"
 ;
 ; Fix verify code change date to the far future
 N FDA
 S FDA(200,C0XIEN(1)_",",11.2)=$$FMTH^XLFDT($$FMADD^XLFDT(DT,3000))
 ;
 ; Signature block. Do this as internal values to prevent name check in 20.2.
 S FDA(200,C0XIEN(1)_",",20.2)="SYNTHETIC PHARMACIST, RPH"
 S FDA(200,C0XIEN(1)_",",20.3)="Staff Pharmacist"
 ;
 D FILE^DIE(,$NA(FDA))
 I $D(DIERR) S $EC=",U1,"
 ;
 Q C0XIEN(1) ;Provider IEN
 ;
MEDSS() ; [Public $$] Create Medical Service/Section
 N NAME S NAME="MEDICINE"
 Q:$O(^DIC(49,"B",NAME,0)) $O(^(0))
 ;
 N FDA,IEN,DIERR
 S FDA(49,"?+1,",.01)=NAME
 S FDA(49,"?+1,",1)="MED"
 S FDA(49,"?+1,",1.5)="MED"
 S FDA(49,"?+1,",1.7)="PATIENT CARE"
 D UPDATE^DIE("E",$NA(FDA),$NA(IEN))
 I $D(DIERR) S $EC=",U1,"
 QUIT IEN(1)
 ;
PHRSS() ; [Public $$] Create Pharmacy Service/Section
 N NAME S NAME="PHARMACY"
 Q:$O(^DIC(49,"B",NAME,0)) $O(^(0))
 ;
 N FDA,IEN,DIERR
 S FDA(49,"?+1,",.01)=NAME
 S FDA(49,"?+1,",1)="PHR"
 S FDA(49,"?+1,",1.5)="PHR"
 S FDA(49,"?+1,",1.6)="`"_$$MEDSS()
 S FDA(49,"?+1,",1.7)="PATIENT CARE"
 D UPDATE^DIE("E",$NA(FDA),$NA(IEN))
 I $D(DIERR) S $EC=",U1,"
 QUIT IEN(1)
 ;
IBACTION ; [Public] Fix IB ACTION TYPE file (350.1) PSO entries to point to PHARMACY service/section
 ; Required in order to be able to set-up pharmacy site parameters
 ;
 N FDA,IEN
 ;
 ; Get Pharmacy SS entry
 N PHRSS S PHRSS=$$PHRSS()
 ;
 ; Get PSO entries
 D FIND^DIC(350.1,,"@","PQE","PSO","*","B")
 ;
 ; Create FDA and file
 N SYNI F SYNI=0:0 S SYNI=$O(^TMP("DILIST",$J,SYNI)) Q:'SYNI  S IEN=^(SYNI,0) S FDA(350.1,IEN_",",.04)=PHRSS
 D FILE^DIE("",$NA(FDA))
 ;
 QUIT
 ;
HL() ; [Public $$] Generic Hospital Location Entry
 N NAME S NAME="GENERAL MEDICINE" ; Constant
 Q:$O(^SC("B",NAME,0)) $O(^(0)) ; Quit if the entry exists with the entry
 ;
 N C0XFDA,C0XIEN,C0XERR,DIERR
 S C0XFDA(44,"?+1,",.01)=NAME
 S C0XFDA(44,"?+1,",2)="C" ; Type - Clinic
 S C0XFDA(44,"?+1,",2.1)=1 ; Type Extension - Clinic
 S C0XFDA(44,"?+1,",3)=+$$SITE^VASITE() ; Institution - Default institution
 S C0XFDA(44,"?+1,",8)=295 ; STOP CODE NUMBER - Primary Care
 S C0XFDA(44,"?+1,",9)="M" ; SERVICE
 S C0XFDA(44,"?+1,",2502)="N" ; NON-COUNT CLINIC
 D UPDATE^DIE("",$NA(C0XFDA),$NA(C0XIEN),$NA(C0XERR))
 I $D(DIERR) S $EC=",U1,"
 Q C0XIEN(1) ; HL IEN
 ;
AMIE ; [Public] Fix "AMIE LINK OUT OF ORDER" message
 N IEN S IEN=$$FIND1^DIC(101,,"QX","DVBA C&P SCHD EVENT","B")
 Q:'IEN
 N FDA,DIERR
 S FDA(101,IEN_",",2)="@" ; DISABLE field
 D FILE^DIE("",$NA(FDA))
 I $D(DIERR) S $EC=",U1,"
 QUIT
 ;
PSOSITE() ; [Public $$] Add a default pharmacy site
 N NAME S NAME="SYNTHETIC PATIENTS"
 I $O(^PS(59,"B",NAME,0)) Q $O(^(0))
 ;
 N SITENUMBER
 N SITEIEN
 N % S %=$$SITE^VASITE()
 S SITEIEN=$P(%,U)
 S SITENUMBER=$P(%,U,3)
 ;
 N FDA,DIERR,IEN
 S FDA(59,"?+1,",.01)=NAME
 S FDA(59,"?+1,",.02)="1934 OLD GALLOWS ROAD" ; MAILING FRANK STREET ADDRESS
 S FDA(59,"?+1,",.03)=571 ; AREA CODE
 S FDA(59,"?+1,",.04)="999-9999" ; PHONE NUMBER
 S FDA(59,"?+1,",.05)=22182 ; Zip code
 S FDA(59,"?+1,",.06)=SITENUMBER ; Site Number
 S FDA(59,"?+1,",.07)="VIENNA" ; CITY
 S FDA(59,"?+1,",.17)=1 ; SHALL COMPUTER ASSIGN RX #S
 S FDA(59,"?+1,",4)=1   ; NEW LABEL STOCK
 S FDA(59,"?+1,",100)="`"_SITEIEN ; RELATED INSTITUTION
 S FDA(59,"?+1,",101)="`"_SITEIEN ; NPI INSTITUTION
 S FDA(59,"?+1,",1000)=0 ; NARCOTICS NUMBERED DIFFERENTLY
 S FDA(59,"?+1,",1001)=1 ; NARCOTIC LOWER BOUND
 S FDA(59,"?+1,",1002)=1 ; NARCOTIC UPPER BOUND
 S FDA(59,"?+1,",1003)="`"_$$PHRSS() ; IB SERVICE/SECTION
 S FDA(59,"?+1,",2001)=100000000 ; PRESCRIPTION # LOWER BOUND
 S FDA(59,"?+1,",2002)=999999999 ; PRESCRIPTION # UPPER BOUND
 S FDA(59.08,"?+2,?+1,",.01)="`"_SITEIEN ; CPRS ORDERING INSTITUTION
 D UPDATE^DIE("E",$NA(FDA),$NA(IEN))
 I $D(DIERR) S $EC=",U1,"
 Q IEN(1)
 ;
ALBUL ; [Public] Disable Allergy Bulletin
 N FDA,DIERR
 S FDA(120.84,"1,",7.1)=2
 D FILE^DIE("","FDA")
 I $D(DIERR) S $EC=",U1,"
 QUIT
 ;
TEST D EN^%ut($T(+0),3) QUIT
 ;
TESTPROV ; @TEST Test adding a provider
 N NAME S NAME="PROVIDER,UNKNOWN SYNTHEA" ; Constant
 N PROV S PROV=$$FIND1^DIC(200,,"QX",NAME,"B")
 I PROV N DA,DIK S DA=PROV,DIK="^VA(200," D ^DIK
 S PROV=$$PROV()
 D CHKTF^%ut(PROV>0)
 N OLDPROV S OLDPROV=PROV
 S PROV=$$PROV(1)
 D CHKTF^%ut(OLDPROV=PROV)
 QUIT
 ;
TESTPHARM ; @TEST Test adding a pharmacist
 N NAME S NAME="PHARMACIST,UNKNOWN SYNTHEA" ; Constant
 N PHARM S PHARM=$$FIND1^DIC(200,,"QX",NAME,"B")
 I PHARM N DA,DIK S DA=PHARM,DIK="^VA(200," D ^DIK
 S PHARM=$$PHARM()
 N OLDPHARM S OLDPHARM=PHARM
 S PHARM=$$PHARM(1)
 D CHKTF^%ut(OLDPHARM=PHARM)
 QUIT
 ;
TESTHL ; @TEST Test adding a clinic
 N NAME S NAME="GENERAL MEDICINE" ; Constant
 N HL S HL=$$FIND1^DIC(44,,"QX",NAME,"B")
 I HL N DA,DIK S DA=HL,DIK="^SC(" D ^DIK
 S HL=$$HL()
 D CHKTF^%ut(HL>0)
 QUIT
 ;
TESTLH ; @Test Load Handlers
 D DELHAND
 D LOADHAND
 ;
 N IEN
 S IEN=$O(^%web(17.6001,"B","POST","addpatient","wsPostFHIR^SYNFHIR",""))
 D CHKTF^%ut(IEN)
 K IEN
 S IEN=$O(^%web(17.6001,"B","GET","showfhir","wsShow^SYNFHIR",""))
 D CHKTF^%ut(IEN)
 K IEN
 S IEN=$O(^%web(17.6001,"B","GET","vpr/{dfn}","wsVPR^SYNVPR",""))
 D CHKTF^%ut(IEN)
 K IEN
 S IEN=$O(^%web(17.6001,"B","GET","global/{root}","wsGLOBAL^SYNVPR",""))
 D CHKTF^%ut(IEN)
 QUIT
 ;
TESTAMIE ; @TEST AMIE
 N IEN S IEN=$$FIND1^DIC(101,,"QX","DVBA C&P SCHD EVENT","B")
 N FDA
 S FDA(101,IEN_",",2)="AMIE LINK OUT OF ORDER" ; DISABLE field
 D FILE^DIE("",$NA(FDA))
 D AMIE
 D CHKTF^%ut($P(^ORD(101,IEN,0),U,3)="")
 QUIT
 ;
TESTIBACT ; @TEST IB Action Fix
 D IBACTION
 N PHRSS S PHRSS=$$PHRSS()
 ;
 ; We confirm through the index that we have six entries pointing to pharmacy
 N CNT S CNT=0
 N I F I=0:0 S I=$O(^IBE(350.1,"C",PHRSS,I)) Q:'I  S CNT=CNT+1
 D CHKTF^%ut(CNT=6)
 QUIT
 ;
TESTPSOSITE ; @TEST Adding Outpatient Site
 N DA,DIK S DA=1,DIK="^PS(59," D ^DIK
 N % S %=$$PSOSITE()
 D CHKTF^%ut(%=1)
 QUIT
 ;
