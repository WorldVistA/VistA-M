SPNJRPCX ;BP/JAS - CPTS/ICDS CODES & DESCRIPTS ;Jun 17, 2009
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; References to file #45/^DGPT supported by IA #92 and IA #4945
 ; RETIRED AND REPLACED WITH IA# 3990 [Reference to ^ICD0 supported by IA #10083]
 ; Reference to API ICDOP^ICDCODE supported by IA #3990
 ; RETIRED AND REPLACED WITH IA# 3990 [Reference to ^ICD9 supported by IA #10082]
 ; Reference to API ICDDX^ICDCODE supported by IA #3990
 ; Reference to API ICDD^ICDCODE supported by IA# 3990
 ; Reference to API VISIT^PXRHS01 supported by IA #1238
 ; Reference to ^ICPT supported by IA #2815
 ; Reference to API CPT^ICPTCOD supported by IA #1995
 ; Reference to API CPTD^ICPTCOD supported by IA #1995
 ; References to ^SRF supported by IA #3615
 ; Reference to ^SRO supported by IA #4872
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
COL(ROOT,ICN,SPNCUTDT) ;
 ; return is TMP($J)
 K ^TMP($J)  ;This is the return file
 S ROOT=$NA(^TMP($J))
 ;*********************************************
 ;  convert icn to dfn
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:DFN=""
 ;*********************************************
 I '$D(^DPT(+$G(DFN))) Q
 ;             1825= 5 years
 S X=SPNCUTDT D ^%DT S SPNCUTDT=Y
JUMPIN1 ;CALLED FROM SPNRPC8 WITH TODAY AS THE CUT DATE
 S CNT=0  ;used to order the icd9's and icd0's
 S CPTCNT=0  ;used to order the cpt's
 S SPNPTFIE=0
 F  S SPNPTFIE=$O(^DGPT("B",DFN,SPNPTFIE)) Q:(SPNPTFIE="")!('+SPNPTFIE)  D SET45
 ;
 D VCPT  ;Build visit file cpt's
 D SURG
 D ENTER^SPNJRPX2
 D CREATE
 D CLNUP
 Q
SET45 ;loop thgough PTF file and set up in rev date order
 S SPNPTADM=$$GET1^DIQ(45,SPNPTFIE_",",2,"I")
 Q:SPNPTADM<SPNCUTDT
 S SPNREV=9999999.9999-SPNPTADM
 S SPNPTRDT=$$GET1^DIQ(45,SPNPTFIE_",",2,"E")
 D BLD
 Q
BLD ;codes from ptf file
 ;get icdo's from pft file
 F SPNFLD=45.01,45.02,45.03,45.04,45.05 D
 . S XYZ=$$GET1^DIQ(45,SPNPTFIE_",",SPNFLD,"I")
 . Q:XYZ=""
 . ;JAS 6/17/09 - DEFECT 1137 - Removed direct reads of CPT/ICD files to API usage
 . ;S XYZZ=$P($G(^ICD0(XYZ,0)),U,4)
 . S SPNARY=$$ICDOP^ICDCODE(XYZ,"","","")
 . S XYZZ=$P(SPNARY,"^",5)
 . S CNT=CNT+1
 . ;S ^TMP($J,"UTIL","ICD",SPNREV,CNT)=$P($G(^ICD0(XYZ,0)),U,4)_U_$P($G(^ICD0(XYZ,0)),U,1)_U_SPNPTRDT_U
 . S ^TMP($J,"UTIL","ICD",SPNREV,CNT)=XYZZ_U_$P(SPNARY,U,2)_U_SPNPTRDT_U
 K SPNARY
 ;---------------------------------------------
 ;get icd9's from pft file
 F SPNFLD=79,79.16,79.17,79.18,79.19,79.201,79.21,79.22,79.23,79.24,80 D
 . S XYZ=$$GET1^DIQ(45,SPNPTFIE_",",SPNFLD,"I")
 . Q:XYZ=""
 . ;JAS 6/17/09 - DEFECT 1137 - Removed direct reads of CPT/ICD files to API usage
 . ;S XYZZ=$P($G(^ICD9(XYZ,0)),U,3)
 . S SPNARY=$$ICDDX^ICDCODE(XYZ,"","","")
 . S XYZZ=$P(SPNARY,"^",4)
 . S CNT=CNT+1
 . ;S ^TMP($J,"UTIL","ICD",SPNREV,CNT)=$P($G(^ICD9(XYZ,0)),U,3)_U_$P($G(^ICD9(XYZ,0)),U,1)_U_SPNPTRDT_U
 . S ^TMP($J,"UTIL","ICD",SPNREV,CNT)=XYZZ_U_$P(SPNARY,U,2)_U_SPNPTRDT_U
 K SPNARY
BLD2 ;get 40 subscript
 S SPNXY=0 F  S SPNXY=$O(^DGPT(SPNPTFIE,"S",SPNXY)) Q:(SPNXY=0)!('+SPNXY)  D
 . S SPNSUDT=$$GET1^DIQ(45.01,SPNXY_","_SPNPTFIE_",",.01,"I")
 . Q:SPNSUDT=""
 . S Y=SPNSUDT X ^DD("DD") S SPNXXYZ=Y  ;date time
 . S SPNSUDT=9999999.9999-SPNSUDT  ;rev date time
 . F SPNFLD=8,9,10,11,12 D
 . . S XYZ=$$GET1^DIQ(45.01,SPNXY_","_SPNPTFIE_",",SPNFLD,"I")
 . . Q:XYZ=""
 . . ;JAS 6/17/09 - DEFECT 1137 - Removed direct reads of CPT/ICD files to API usage
 . . S SPNARY=$$ICDOP^ICDCODE(XYZ,"","","")
 . . S CNT=CNT+1
 . . ;S ^TMP($J,"UTIL","ICD",SPNSUDT,CNT)=$P($G(^ICD0(XYZ,0)),U,4)_U_$P($G(^ICD0(XYZ,0)),U,1)_U_SPNXXYZ_U
 . . S ^TMP($J,"UTIL","ICD",SPNSUDT,CNT)=$P(SPNARY,U,5)_U_$P(SPNARY,U,2)_U_SPNXXYZ_U
 . Q
 K SPNARY
 ;get the 60's now
 S SPNXY=0 F  S SPNXY=$O(^DGPT(SPNPTFIE,"P",SPNXY)) Q:(SPNXY=0)!('+SPNXY)  D
 . S SPNSUDT=$$GET1^DIQ(45.05,SPNXY_","_SPNPTFIE_",",.01,"I")
 . Q:SPNSUDT=""
 . S Y=SPNSUDT X ^DD("DD") S SPNXXYZ=Y  ;date time
 . S SPNSUDT=9999999.9999-SPNSUDT
 . F SPNFLD=5,6,7,8,9 D
 . . S XYZ=$$GET1^DIQ(45.05,SPNXY_","_SPNPTFIE_",",SPNFLD,"I")
 . . Q:XYZ=""
 . . ;JAS 6/17/09 - DEFECT 1137 - Removed direct reads of CPT/ICD files to API usage
 . . S SPNARY=$$ICDOP^ICDCODE(XYZ,"","","")
 . . S CNT=CNT+1
 . . ;S ^TMP($J,"UTIL","ICD",SPNSUDT,CNT)=$P($G(^ICD0(XYZ,0)),U,4)_U_$P($G(^ICD0(XYZ,0)),U,1)_U_SPNXXYZ_U
 . . S ^TMP($J,"UTIL","ICD",SPNSUDT,CNT)=$P(SPNARY,U,5)_U_$P(SPNARY,U,2)_U_SPNXXYZ_U
 K SPNARY
 Q
VCPT ;------------------------------------------------------------------
 ;visit file cpt's
 K ^TMP("PXHSV",$J)
 ;02/26/08 JAS DEFECTS 188,191&192 - MODIFIED VCPT/VCPT2 TO INCLUDE ICDS ALONG WITH CPTS
 ;D VISIT^PXRHS01(DFN,"",SPNCUTDT,"","AHICTNSOERDX","C",1)
 D VISIT^PXRHS01(DFN,"",SPNCUTDT,"","AHICTNSOERDX","CD",1)
 F CDTYP="C","D" D VCPT2
 K RVDT,COUNT,X,VTMSTMP,MDT,XSTRING,ICPTIEN,CDTYP,CDTYP2
 K ^TMP("PXHSV",$J)
 Q
VCPT2 ;
 S RVDT=""
 F  S RVDT=$O(^TMP("PXHSV",$J,RVDT)) Q:RVDT=""  D
 .S COUNT=""
 .F  S COUNT=$O(^TMP("PXHSV",$J,RVDT,COUNT)) Q:COUNT=""  D
 ..;Q:'$D(^TMP("PXHSV",$J,RVDT,COUNT,"C"))
 ..Q:'$D(^TMP("PXHSV",$J,RVDT,COUNT,CDTYP))
 ..S X=""
 ..;F  S X=$O(^TMP("PXHSV",$J,RVDT,COUNT,"C",X)) Q:X=""  D
 ..F  S X=$O(^TMP("PXHSV",$J,RVDT,COUNT,CDTYP,X)) Q:X=""  D
 ...;S ICPTIEN=$P(^TMP("PXHSV",$J,RVDT,COUNT,"C",X),"^",1)
 ...S ICPTIEN=$P(^TMP("PXHSV",$J,RVDT,COUNT,CDTYP,X),"^",1)
 ...S MDT=9999999-$P(RVDT,".",1)
 ...S TMSTMP=MDT_"."_$P(RVDT,".",2)
 ...S Y=TMSTMP X ^DD("DD") S VTMSTMP=Y  ;date time
 ...I MDT<2890101 S MDT=2890101
 ...;S XSTRING=$$CPT^ICPTCOD(ICPTIEN,MDT,"")
 ...;S XYZZ=$P(XSTRING,"^",2)
 ...;S XYZ=$P(XSTRING,"^",3)
 ...I CDTYP="C" D
 ....S XSTRING=$$CPT^ICPTCOD(ICPTIEN,MDT,"")
 ....S XYZZ=$P(XSTRING,"^",2)
 ....S XYZ=$P(XSTRING,"^",3)
 ....S CDTYP2="CPT"
 ...I CDTYP="D" D
 ....;JAS 6/17/09 - DEFECT 1137 - Removed direct reads of CPT/ICD files to API usage
 ....S SPNARY=$$ICDDX^ICDCODE(ICPTIEN,"","","")
 ....;S XYZZ=$P($G(^ICD9(ICPTIEN,0)),U,1)
 ....S XYZZ=$P(SPNARY,"^",2)
 ....;S XYZ=$P($G(^ICD9(ICPTIEN,0)),U,3)
 ....S XYZ=$P(SPNARY,"^",4)
 ....S CDTYP2="ICD"
 ...S CPTCNT=CPTCNT+1
 ...;S ^TMP($J,"UTIL","CPT",RVDT,CPTCNT)=XYZ_U_XYZZ_U_VTMSTMP_U
 ...S ^TMP($J,"UTIL",CDTYP2,RVDT,CPTCNT)=XYZ_U_XYZZ_U_VTMSTMP_U
 ;K RVDT,COUNT,X,VTMSTMP,MDT,XSTRING,ICPTIEN
 ;K ^TMP("PXHSV",$J)
 K SPNARY
 Q
SURG ;------------------------------------------------------------
 ;get surgery icd's
 S X=0 F  S X=$O(^SRF("B",DFN,X)) Q:(X="")!('+X)  D
 . S SPNSRDT=$P($G(^SRF(X,0)),U,9)
 . Q:SPNSRDT=""
 . Q:SPNSRDT<SPNCUTDT
 . S SPNSRDT=9999999.9999-SPNSRDT
 . ;S FIELD=14 D CHKSUR  ;Rob requested not to include pre op codes
 . S FIELD=4 D CHKSUR
 . D SURCPT
 . Q
 ;PUGET ERROR TRAP DEFECT 12/21/07 - ADDED NEXT LINE
 K SPNSRDT
 Q
CHKSUR ;
 S SPNX1=0 F  S SPNX1=$O(^SRO(136,X,FIELD,SPNX1)) Q:(SPNX1="")!('+SPNX1)  D
 . S SPNXCODE=$P($G(^SRO(136,X,FIELD,SPNX1,0)),U,1) Q:SPNXCODE=""
 . ;JAS 6/17/09 - DEFECT 1137 - Removed direct reads of CPT/ICD files to API usage
 . S SPNARY=$$ICDDX^ICDCODE(SPNXCODE,"","","")
 . ;S SPNCNUM=$P($G(^ICD9(SPNXCODE,0)),U,1)
 . S SPNCNUM=$P(SPNARY,"^",2)
 . ;S SPNXCODE=$P($G(^ICD9(SPNXCODE,0)),U,3)
 . S SPNXCODE=$P(SPNARY,"^",4)
 . ;PUGET ERROR TRAP 12/21/07
 . ;S SPNSRDT=$P($G(^SRF(X,0)),U,9)
 . ;Q:SPNSRDT=""
 . ;Q:SPNSRDT<SPNCUTDT
 . ;S SPNSRDT=9999999.9999-SPNSRDT
 . S CNT=CNT+1
 . S ^TMP($J,"UTIL","ICD",SPNSRDT,CNT)=SPNXCODE_U_SPNCNUM_U_$$GET1^DIQ(130,X_",",.09,"E")_U
 . ;PUGET ERROR TRAP DEFECT 11/13/07
 . ;K SPNSRDT,SPNXCODE
 . K SPNXCODE
 . Q
 K SPNARY
 ;SURG CPTS
 Q
SURCPT ;
 S SURX=0 F  S SURX=$O(^SRO(136,X,3,SURX)) Q:(SURX="")!('+SURX)  D
 . S SURCPT=$P($G(^SRO(136,X,3,SURX,0)),U,1)
 . ;JAS 6/17/09 - DEFECT 1137 - Removed direct reads of CPT/ICD files to API usage
 . S SPNARY=$$CPT^ICPTCOD(SURCPT,"","")
 . ;S SURCPTN=$P($G(^ICPT(SURCPT,0)),U,1)  ;NUMBER
 . S SURCPTN=$P(SPNARY,"^",2)
 . ;S SURCPTX=$P($G(^ICPT(SURCPT,0)),U,2)  ;TEXT
 . S SURCPTX=$P(SPNARY,"^",3)
 . S CPTCNT=CPTCNT+1
 . S ^TMP($J,"UTIL","CPT",SPNSRDT,CPTCNT)=SURCPTX_U_SURCPTN_U_$$GET1^DIQ(130,X_",",.09,"E")_U
 . ;PUGET ERROR TRAP DEFECT 12/21/07
 . ;K SPNSRDT
 K SPNARY
 Q
CREATE ;
 S (X,CNT,OLDCNT)=0
 S CNT=CNT+1,^TMP($J,CNT)="CPTBREAK^EOL999"
 S SUB="CPT" F  S X=$O(^TMP($J,"UTIL",SUB,X)) Q:(X="")!('+X)  S OLDCNT=0 F  S OLDCNT=$O(^TMP($J,"UTIL",SUB,X,OLDCNT)) Q:(OLDCNT="")!('+OLDCNT)  D
 . S CNT=CNT+1
 . S ^TMP($J,CNT)=$G(^TMP($J,"UTIL",SUB,X,OLDCNT))
 . S CODE=$P(^TMP($J,CNT),"^",2)
 . D CPT Q
 S CNT=CNT+1,^TMP($J,CNT)="ICDBREAK^EOL999"
 S SUB="ICD" F  S X=$O(^TMP($J,"UTIL",SUB,X)) Q:(X="")!('+X)  S OLDCNT=0 F  S OLDCNT=$O(^TMP($J,"UTIL",SUB,X,OLDCNT)) Q:(OLDCNT="")!('+OLDCNT)  D
 . S CNT=CNT+1
 . S ^TMP($J,CNT)=$G(^TMP($J,"UTIL",SUB,X,OLDCNT))
 . S CODE=$P(^TMP($J,CNT),"^",2)
 . D ICD Q
 K ^TMP($J,"UTIL")
 Q
ICD ;
 ;JAS 6/15/09 - DEFECT 1137 - Removed direct reads of CPT/ICD files to API usage
 S CNT=CNT+1
 ;I $D(^ICD0("AB",CODE)) D  Q
 ;. ;JAS - 05/15/08 - DEFECT 1090
 ;. ;S IEN="" S IEN=$O(^ICD0("AB",CODE,IEN))
 ;. S IEN=0 S IEN=$O(^ICD0("AB",CODE,IEN))
 ;. I IEN=""  D  Q
 ;. . S ^TMP($J,CNT)="No "_CODE_" Code on file^EOL999"
 ;. Q:IEN=""
 ;. S TXT=$G(^ICD0(IEN,1))
 ;. I TXT="" D  Q
 ;. . S ^TMP($J,CNT)="No description on file^EOL999"
 ;. S ^TMP($J,CNT)=TXT_"^EOL999"
 ;. Q
 ;S CODE=CODE_" "  ;needed to use the "AB" cross ref
 ;I '$D(^ICD9("AB",CODE)) D  Q
 ;. S ^TMP($J,CNT)="No "_CODE_" Code on file^EOL999"
 ;;JAS - 05/15/08 - DEFECT 1090
 ;;S IEN="" S IEN=$O(^ICD9("AB",CODE,IEN))
 ;S IEN=0 S IEN=$O(^ICD9("AB",CODE,IEN))
 ;I IEN=""  D  Q
 ;. S ^TMP($J,CNT)="No "_CODE_" Code on file^EOL999"
 ;Q:IEN=""
 ;S TXT=$G(^ICD9(IEN,1))
 ;I TXT="" D  Q
 ;. S ^TMP($J,CNT)="No description on file^EOL999"
 S ICDD=$$ICDD^ICDCODE(CODE,"SPNARY","")
 I $P(ICDD,"^")=-1 S ^TMP($J,CNT)="No "_CODE_" Code on file"_U_"EOL999" Q
 I SPNARY(1)="" S ^TMP($J,CNT)="No description on file"_U_"EOL999" Q
 ;S ^TMP($J,CNT)=TXT_"^EOL999"
 S ^TMP($J,CNT)=SPNARY(1)_"^EOL999"
 ;Note that even though this is a single line of text the CPTS 
 ;description is a mult.  And this call brings back either one.
 K SPNARY,ICDD
 Q
CPT ;
 D CPTD^ICPTCOD(CODE,"SPNARRAY")
 I '$D(SPNARRAY) D  Q
 . S CNT=CNT+1
 . S ^TMP($J,CNT)="No CPT "_CODE_" on file^EOL999"
 ;JAS - 05/15/08 - DEFECT 1090
 ;S LINE=""
 S LINE=0
 F  S LINE=$O(SPNARRAY(LINE)) Q:LINE=""  D
 . S TXT=SPNARRAY(LINE)
 . Q:TXT=""!(TXT=" ")
 . S CNT=CNT+1
 . S ^TMP($J,CNT)=TXT
 . Q
 S ^TMP($J,CNT)=^TMP($J,CNT)_"^EOL999"
 K SPNARRAY
 Q
CLNUP ;
 K CNT,CODE,CPTCNT,DFN,FIELD,IEN,LINE,OLDCNT,SPNCNUM
 K SPNFLD,SPNPTADM,SPNPTFIE,SPNPTRDT,SPNREV,SPNSUDT
 K SPNX1,SPNXXYZ,SPNXY,SUB,SURCPT,SURCPTN,SURCPTX,SURX
 K TXT,X,XY,XYZ,XYZZ,Y
 K TMSTMP  ;WDE
 Q
