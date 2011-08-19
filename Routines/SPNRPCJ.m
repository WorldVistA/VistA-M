SPNRPCJ ;SD/WDE - Returns Discharge date and location ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; References to ^DGPT("B" supported by IA# 92
 ; References to file 45 supported by IA# 92
 ; References to ^DGPT(D0,0 & ^DGPT(D0,70 supported by IA# 4945
 ; Reference to ^DIC(45.6 supported by IA# 4018
 ; References to ^DGPM supported by IA# 4942
 ; Reference to ^DIC(42 supported by IA# 10039
 ; Reference to ^DG(405.4 supported by IA# 1380
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ;   1 sort data by most recent Admission
 ;   3 sort data by most recent Discharge
 ;
 ; Returns:
 ; TMP($J,x) sorted by most recent first.
 ; if 1
 ;    Admission Location  ^ Admission Date ^ dgpt(ien
 ; if 3
 ;    Discharge Location  ^ Discharge Date ^ dgpt(ien
 ;
COL(ROOT,ICN,CUTDATE,TYPE) ;
 S X=CUTDATE S %DT="T" D ^%DT S CUTDATE=Y
 K ^TMP($J)
 S ROOT=$NA(^TMP($J))
 ;*************************************
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:DFN=""
 ;*************************************
 D BLD
 D RESORT
 K %DT,ADMBED,ADMDT,ADMIEN,ADMLOC
 K CNT,DFN,DISDT,DISLOC,ICN,IEN,REVDT
 K SHWADM,SHWDIS,SORTBY,X,Y
 K DXLS,ICD1,ICD2,ICD3,ICD4,ICD5,ICD6,ICD7,ICD8,ICD9,ICD10
 Q
 ;
 ;
BLD ;
 ;JAS - 05/15/08 - DEFECT 1090
 ;S IEN="" F  S IEN=$O(^DGPT("B",DFN,IEN)) Q:(IEN="")!('+IEN)  D
 S IEN=0 F  S IEN=$O(^DGPT("B",DFN,IEN)) Q:(IEN="")!('+IEN)  D
 .I $P($G(^DGPT(IEN,0)),U,4)=1 Q  ;FEE BASIS RECORD
 .;JAS 2/20/07 - DBIA Modifications
 .;S ADMDT=$P($G(^DGPT(IEN,0)),U,2)
 .S ADMDT=$$GET1^DIQ(45,IEN_",",2,"I")
 .;JAS 2/20/07 - DBIA Modifications
 .;S DISDT=$P($G(^DGPT(IEN,70)),U,1)
 .S DISDT=$$GET1^DIQ(45,IEN_",",70,"I")
 .S DISLOC=$P($G(^DGPT(IEN,70)),U,6)
 .I +DISLOC S DISLOC=$P($G(^DIC(45.6,DISLOC,0)),U,1)
 .I DISLOC="" S DISLOC="-----------"
 .;GET adm location and bed from DGPM
 .D DGPM
 .D BLDUTIL
 Q
DGPM ;get adm location and bed
 ;JAS - 05/15/08 - DEFECT 1090
 ;S ADMIEN="" F  S ADMIEN=$O(^DGPM("B",ADMDT,ADMIEN)) Q:(ADMIEN="")!('+ADMIEN)  D
 S ADMIEN=0 F  S ADMIEN=$O(^DGPM("B",ADMDT,ADMIEN)) Q:(ADMIEN="")!('+ADMIEN)  D
 .I $P($G(^DGPM(ADMIEN,0)),U,3)'=DFN Q  ;safty check for same patient
 .I $P($G(^DGPM(ADMIEN,0)),U,2)'=1 Q  ;not an admission movement
 .S ADMLOC=$P($G(^DGPM(ADMIEN,0)),U,6)  ;ward pointer value
 .I +ADMLOC S ADMLOC=$P($G(^DIC(42,ADMLOC,0)),U,1)  ;ward
 .S ADMBED=$P($G(^DGPM(ADMIEN,0)),U,7)  ;Bed pointer value
 .I +ADMBED S ADMBED=$P($G(^DG(405.4,ADMBED,0)),U,1)  ;Bed
 .Q
 Q
 ;
 ;
BLDUTIL ;build TMP in Rev date order based on sort type
 I TYPE="" S TYPE=1  ;sort by admission dt if null
 I TYPE=2 Q:$G(DISDT)=""  ;sorted by discharge and not discharge date
 S SORTBY=$S(TYPE=1:ADMDT,1:DISDT)
 S REVDT=9999999.9999-SORTBY  ;Set the sort date up in rev order
 I CUTDATE>SORTBY Q
 S Y=ADMDT D DD^%DT S SHWADM=Y  ;adm dt in human format
 S Y=DISDT D DD^%DT S SHWDIS=Y  ;dis dt in human format
 S ^TMP($J,"UTIL",REVDT)=SHWADM_U_ADMLOC_U_ADMBED_U_SHWDIS_U_DISLOC_U_"DGPT("_IEN
 S DXLS=$$GET1^DIQ(45,IEN_",",79)
 S ICD2=$$GET1^DIQ(45,IEN_",",79.16)
 S ICD3=$$GET1^DIQ(45,IEN_",",79.17)
 S ICD4=$$GET1^DIQ(45,IEN_",",79.18)
 S ICD5=$$GET1^DIQ(45,IEN_",",79.19)
 S ^TMP($J,"UTIL",REVDT,1)="ICD1^"_DXLS_"^"_ICD2_"^"_ICD3_"^"_ICD4_"^"_ICD5
 S ICD6=$$GET1^DIQ(45,IEN_",",79.201)
 S ICD7=$$GET1^DIQ(45,IEN_",",79.21)
 S ICD8=$$GET1^DIQ(45,IEN_",",79.22)
 S ICD9=$$GET1^DIQ(45,IEN_",",79.23)
 S ICD10=$$GET1^DIQ(45,IEN_",",79.24)
 S ^TMP($J,"UTIL",REVDT,2)="ICD2^"_ICD6_"^"_ICD7_"^"_ICD8_"^"_ICD9_"^"_ICD10
 S (SHWADM,ADMLOC,ADMBED,SHWDIS,DISLOC)=""
 Q
 ;.Q:DESPDT<CUTDATE
 ;.S Y=DESPDT D DD^%DT S SHOWDT=Y
 ;.S REVDT=9999999-DESPDT
 ;.S CNT=CNT+1
 ;.S ^TMP($J,"UTIL",REVDT,CNT)=VACLASNA_U_VACLASDS_U_SHOWDT_U_"PSRX("_RXNUM
 Q
 ;
 ;
RESORT ;
 S CNT=""
 S REVDT=""
 F  S REVDT=$O(^TMP($J,"UTIL",REVDT)) Q:(REVDT="")!('+REVDT)  D
 .S CNT=CNT+1
 .S ^TMP($J,CNT)=$G(^TMP($J,"UTIL",REVDT))_"^EOL999"
 .S CNT=CNT+1
 .S ^TMP($J,CNT)=$G(^TMP($J,"UTIL",REVDT,1))_"^EOL999"
 .S CNT=CNT+1
 .S ^TMP($J,CNT)=$G(^TMP($J,"UTIL",REVDT,2))_"^EOL999"
 .Q
 K ^TMP($J,"UTIL")  ;CLEAN OUT THE TEMP GLOBAL
 Q
