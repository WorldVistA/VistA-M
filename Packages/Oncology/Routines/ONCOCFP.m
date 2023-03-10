ONCOCFP ;HINES OIFO/GWB - [PT Automatic Casefinding-PTF Search] ;05/03/12
 ;;2.2;ONCOLOGY;**1,7,5,13**;Jul 31, 2013;Build 7
 ;
 ; rvd - 0403/12 p56. Use ICD API (#3990) instead of direct global call
 ; P2.2*7 - icd10 CASEFINDING
 W @IOF
 W !!!?10,"****************** PTF CASEFINDING ******************",!
 W !?10,"This option will search the PRINCIPLE DIAGNOSIS and"
 W !?10,"SECONDARY DIAGNOSIS fields of the PTF file for ICD"
 W !?10,"codes which identify cases to be added to the Suspense"
 W !?10,"list."
 ;
T ;Start Date/End Date
 N SDDEF
 W !
 S OSP=$O(^ONCO(160.1,"C",DUZ(2),0))
 I OSP="" D  Q
 .W !?10,"Casefinding requires an ONCOLOGY SITE PARAMETER"
 .W !?10,"entry which matches the user's login DIVISION."
 .W !?10,"There is no ONCOLOGY SITE PARAMETER for DIVISION:"
 .W !?10,$P($G(^DIC(4,DUZ(2),0)),U,1)
 S SDDEF=$P(^ONCO(160.1,OSP,0),U,7)
 I SDDEF="" S SDDEF=DT
 S SDDEF=$E(SDDEF,4,5)_"-"_$E(SDDEF,6,7)_"-"_($E(SDDEF,1,3)+1700)
SD K DIR
 S DIR(0)="D"
 S DIR("A")="          Start Date"
 S DIR("B")=SDDEF
 D ^DIR
 G EX:(Y="")!(Y[U)
 I (Y>DT) W "  Future dates not allowed" G SD
 S (SD,X)=Y D DD^%DT W "  ",Y
ED K DIR
 S DIR(0)="D"
 S DIR("A")="            End Date"
 D ^DIR
 G EX:(Y="")!(Y[U)
 I (Y<SD) W "  Invalid date sequence" G T
 I (Y>DT) W "  Future dates not allowed" G ED
 S $P(^ONCO(160.1,OSP,0),U,7)=Y
 S (ED,X)=Y D DD^%DT W "  ",Y
 W !
 K DIR
 S DIR(0)="Y"
 S DIR("A")="          Dates OK"
 S DIR("B")="Y"
 D ^DIR
 G EX:(Y="")!(Y[U)
 G T:'Y
 S ONCO("SD")=SD,ONCO("ED")=ED
 ;
 ;Include Squamous and Basal cell neoplasms (Y/N?)
 W !
 ;S SBCIND="NO"
 ;K DIR
 ;S DIR(0)="Y"
 ;S DIR("A")="          Include Squamous and Basal cell neoplasms"
 ;S DIR("B")="Yes"
 ;S DIR("?")=" "
 ;S DIR("?",1)=" Answer 'YES' if you want to include squamous and basal cell neoplasms."
 ;S DIR("?",2)=" Answer  'NO' if you want to exclude these neoplasms."
 ;D ^DIR
 ;G EX:(Y="")!(Y[U)
 ;S:Y=1 SBCIND="YES"
 ;K DIR
 ;
 W !!?3,"The following ICD codes will be searched for:"
 W !
 W !?3,"140-239        NEOPLASMS"
 W !?3,"               (excluding benign neoplasms 210-229 unless listed below)"
 W !?3,"042.2          HIV WITH SPECIFIED MALIGNANT NEOPLASMS"
 W !?3,"225.0-225.9    BENIGN NEOPLASMS OF BRAIN AND OTHER PARTS OF NERVOUS SYSTEM"
 W !?3,"227.3          BENIGN NEOPLASM OF PITUITARY GLAND AND CRANIOPHARYNGEAL DUCT"
 W !?3,"227.4          BENIGN NEOPLASM OF PINEAL GLAND"
 W !?3,"228.02         HEMANGIOMA INTRACRANIAL"
 W !?3,"259.2          CARCINOID SYNDROME"
 W !?3,"273.1-273.9    DISORDERS OF PLASMA PROTEIN METABOLISM"
 W !?3,"284.9          ANAPLASTIC ANEMIA, UNSPECIFIED"
 W !?3,"285.0          SIDEROBLASTIC ANEMIA"
 W !?3,"288.3          EOSINOPHILIA"
 W !?3,"288.4          HEMOPHAGOCYTIC SYNDROMES"
 W !?3,"289.6          FAMILIAL POLYCYTHEMIA"
 W !?3,"289.8          OTHER SPECIFIED DISEASES OF BLOOD AND BLOOD-FORMING ORGANS"
 W !?3,"289.83         MYELOFIBROSIS"
 W !?3,"795.06         PAPANICOLAOU SMEAR OF CERVIX WITH CYTOLOGIC EVIDENCE OF"
 W !?3,"               MALIGNANCY"
 W !?3,"795.16         PAP SMR VAG-CYTOL MALIG"
 W !?3,"796.76         PAP SMR ANUS-CYTOL MALIG"
 ;
 ;NOTE: Code 795.76 is incorrect in the ICD DIAGNOSIS (80) file.
 ;      It is appears as 796.76.  PTF casefinding will look for both
 ;      795.76 and 796.76.
 ;
 W !?3,"V07.3          NEED FOR OTHER PROPHYLACTIC CHEMOTHERAPY"
 W !?3,"V07.8          NEED FOR OTHER SPECIFIED PROPHYLACTIC MEASURE"
 W !?3,"V10.00-V10.09  GASTROINTESINAL TRACT"
 W !?3,"V12.41         PERS HX BENIGN NEOPL OF BRAIN"
 W !?3,"V58.0          ENCOUNTER FOR RADIOTHERAPY"
 W !?3,"V58.1          ENCOUNTER FOR CHEMOTHERAPY"
 W !?3,"V58.11         ANTINEOPLASTIC CHEMO ENC"
 W !?3,"V58.12         IMMUNOTHERAPY ENCOUNTER"
 W !?3,"V66.1-V66.2    CONVALESCENCE FOLLOWING RADIOTHERAPY/CHEMOTHERAPY"
 W !?3,"V67.1-V67.2    FOLLOW-UP EXAMINATION FOLLOWING RADIOTHERAPY/CHEMOTHERAPY"
 W !?3,"V71.1          OBSV-SUSPCT MAL NEOPLASM"
 W !?3,"V76.0-V76.9    SPECIAL SCREENING FOR MALIGNANT NEOPLASMS"
 W !
 ;List of ICD10
 D L10^ONCOCFP1
 W !
 ;
 S %ZIS="Q" D ^%ZIS I POP G EX
 I '$D(IO("Q")) D SER^ONCOCFP G EX
 S ZTRTN="SER^ONCOCFP",ZTSAVE("ONCO*")="",ZTSAVE("SBCIND")="",ZTDESC="ONCOLOGY PTF SEARCH"
 D ^%ZTLOAD
 G EX
 ;
SER ;Search PTF file (#45) file
 ;Supported by IA #418
 S AFFDIV=$G(DUZ(2)),ONCDIVSP=$O(^ONCO(160.1,"C",AFFDIV,""))
 I ONCDIVSP="" W !!,"User does not have an associated DIVISION",!! G EX
 F Z=0:0 S Z=$O(^ONCO(160.1,ONCDIVSP,6,Z)) Q:Z'>0  S AFFDIV=AFFDIV_U_$G(^ONCO(160.1,ONCDIVSP,6,Z,0))
 K ^TMP("ONCO",$J)
 S XDT=ONCO("SD")-.1111111
 S XED=ONCO("ED")+.9999999
 S ^TMP("ONCO",$J,0)=0
 F  S XDT=$O(^DGPT("ADS",XDT)) Q:(XDT>XED)!(XDT="")  S D0=$O(^(XDT,0)),X70=$G(^DGPT(D0,70)),X71=$G(^DGPT(D0,71)) I X70'="" D IC
 I $G(^TMP("ONCO",$J,0))=0 G WP
 E  D
 .S DIC="^ONCO(160,"
 .S BY="@75,INTERNAL(#3),75,.01"
 .S FR=DUZ(2)_","_ONCO("SD"),TO=DUZ(2)_","_ONCO("ED")
 .S FLDS="[ONCO PTF-CASEFINDING RPT]"
 S L=0,IOP=ION,DIOEND="D WP^ONCOCFP"
 D EN1^DIP Q
 ;
WP ;Wrap-up report
 W !?3,$G(^TMP("ONCO",$J,0))_" PTF cases added to Suspense"
 Q
 ;
IC ;Search for ICD codes
 K HT,IC9,IC,ICD,ICP,CI10
 S P="",CI=0,CI10=0
 F F=10,16:1:24 S ICP=+$P(X70,U,F) I ICP>0 S IC9=$$GET1^DIQ(80,ICP,.01,"I") D FD Q:(CI=1)!(CI10=1)
 I (X71'=""),(CI=0),(CI10=0) F F=1:1:15 S ICP=+$P(X71,U,F) I ICP>0 S IC9=$$GET1^DIQ(80,ICP,.01,"I") D FD Q:(CI=1)!(CI10=1)
 ;I CI=0 D IC10^ONCOCFP1
 I (CI=0),(CI10=0) Q
 G CK
 ;
FD I ((IC9>139.9)&(IC9<210)) S CI=1 Q
 I ((IC9>224.9)&(IC9<226)) S CI=1 Q
 I (IC9=227.3)!(IC9=227.4)!(IC9=228.02) S CI=1 Q
 I ((IC9>229.9)&(IC9<240)) S CI=1 Q
 I (IC9=259.2)!(IC9=273.1)!(IC9=273.2)!(IC9=273.3)!(IC9=273.9)!(IC9=284.9)!(IC9=288.3)!(IC9=288.4)!(IC9=289.6)!(IC9=289.8)!(IC9=289.83)!(IC9=795.06)!(IC9=795.16)!(IC9=795.76)!(IC9=796.76)!(IC9="042.2")!(IC9="285.0") S CI=1 Q
 I $E(IC9)="V" S CD=$E(IC9,2,5) I ((CD>9)&(CD<11))!(CD=12.41)!(CD="58.0")!(CD=58.1)!(CD=66.1)!(CD=66.2)!(CD=67.1)!(CD=67.2)!(CD=71.1)!(CD="07.3")!(CD="07.8")!($E(CD,1,2)=76) S CI=1 Q
 S IC10=IC9 D FD10^ONCOCFP1
 Q
 ;
CK ;Check ONCOLOGY PATIENT (160) file
 ;Supported by IA #418
 I ($G(IC9)=""),($G(IC10)="") Q
 D DIV Q:DVMTCH=0
 S X=^DGPT(D0,0),ADT=$P($P(X,U,2),"."),X=$P(X,U)_";DPT("
 S XD0=$O(^ONCO(160,"B",X,0)),ONCIEN=XD0 I XD0="" G MR
 I XD0'="" S ONCDIVS="",ONCS="" F  S ONCS=$O(^ONCO(160,XD0,"SUS","C",ONCS)) Q:ONCS'>0  S ONCDIVS=ONCDIVS_U_ONCS
 I ONCDIVS[DUZ(2) Q
 S DA=XD0 I '$D(^ONCO(165.5,"C",XD0)) G N2
 ;
CKP ;Check ONCOLOGY PRIMARY (165.5) file
 S XD1=0 F  S XD1=$O(^ONCO(165.5,"C",XD0,XD1)) Q:XD1'>0  I $$DIV^ONCFUNC(XD1)=DUZ(2) D
 .S XDX=$P($G(^ONCO(165.5,XD1,0)),U,16) I XDT>(ADT-1)&(XDX<($P(XDT,".")+1)) S HT=1 Q
 .S XDX=$P($G(^ONCO(165.5,XD1,1)),U,10) I XDX=XDT S HT=1 Q
 Q
 ;
MR ;Create ONCOLOGY PATIENT (160) record
 Q:$D(HT)
 K DO S DIC="^ONCO(160,",DIC(0)="Z" D FILE^DICN K DO
 S (ONCIEN,XD0,DA)=+Y
 ;
N2 ;Create SUSPENSE (160.075) record
 N DD,PTFDT,X1,X2
 S X1=ADT,X2=1 D C^%DTC S SDT=X
 S X1=ONCO("SD"),X2=1 D C^%DTC S WSD=X
 S DA(1)=ONCIEN,DIC="^ONCO(160,"_DA(1)_",""SUS"","
 K DO S DIC(0)="L",DIC("P")=$P(^DD(160,75,0),U,2),X=$S(SDT<WSD:WSD,1:SDT)
 D FILE^DICN K DO
 K DIE S DA(1)=ONCIEN,DIE="^ONCO(160,"_DA(1)_",""SUS"","
 S (ONCSUB,DA)=+Y,PTFDT=$P(XDT,".")
 S DR="1///^S X=DT;2///^S X=""PT"";3////^S X=DUZ(2);7///^S X=PTFDT;8////^S X=ICP"
 D ^DIE
 S ^TMP("ONCO",$J,0)=^TMP("ONCO",$J,0)+1
 Q
 ;
DIV ;DIVISION match
 ;Supported by IAs #417 and #1378
 N PTFD0,PTMV,WL
 S DVMTCH=1,INST=""
 S PTFD0=D0,PTMV=$O(^DGPM("APTF",PTFD0,"")) I PTMV="" Q
 S WL=$P($G(^DGPM(PTMV,0)),U,6) I WL="" Q
 S MCDV=$P($G(^DIC(42,WL,0)),U,11) I MCDV="" Q
 S INST=$P($G(^DG(40.8,MCDV,0)),U,7) I INST="" Q
 I AFFDIV'[INST S DVMTCH=0 Q
 Q
 ;
EX ;KILL variables
 K %DT,%T,%ZIS,ADT,AFFDIV,BY,CD,CI,D0,DA,DD,DIC,DIE,DIOEND,DIR,DO,DR
 K DVMTCH,ED,F,FLDS,FR,GLO,HT,IC,IC9,ICD,ICP,INST,IOP,L,MCDV,NM,O2,CI10,IC10,SBCIND
 K ONCDIVS,ONCDIVSP,ONCIEN,ONCO,ONCS,ONCSUB,OSP,P,POP,PTFD0,PTFDT,PTMV
 K SD,SDDEF,SDT,TO,WED,WSD,X,X1,X2,X70,X71,XD0,XD1,XDT,XDX,XED,Y,Z
 K ZTDESC,ZTRTN,ZTSAVE
 K ^TMP("ONCO",$J)
 D ^%ZISC
 Q
