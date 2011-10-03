ECX357PT ;ALB/JAM - Restricting Stop Code Post-Init Rtn; 0707/03
 ;;3.0;DSS EXTRACTS;**57**;Dec 22,1997
 ;
POST ; entry point
 ;* Check #728.44 for appropriate Stop Code type
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTREQ,ZTSAVE
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("This post install process does the following:-")
 D BMES^XPDUTL("  1. Checks clinics in file #728.44 for invalid Stop Codes and produces")
 D MES^XPDUTL("     a MailMan message.")
 D MES^XPDUTL(" ")
 ;check file #44 and #728.44 for non-conforming restriction type
 S ZTRTN="PROCESS^ECX357PT"
 S ZTDESC="DSS Identifier Non-conforming Clinics Report"
 S ZTIO="",ZTDTH=$H,ZTREQ="@" D ^%ZTLOAD
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("completed...")
 D MES^XPDUTL(" ")
 Q
 ;
PROCESS ;background entry point
 ; Locate invalid Stop Code in file #728.44 and put in a mail message
 N ECX,IEN,BLN,COUNT,TXTVAR,I,LNS,CNT,STR,ECXJ,PSC,SSC,DPC,DSC,CNTX,NAM
 N SCN,PSCN,SSCN,DPCN,DSCN,IDT,HTYP
 S COUNT=0,$P(BLN," ",60)="",$P(LNS,"-",80)=""
 S ECXJ=$J K ^TMP($J,"ECX353PT")
 F I=1:1 S TXTVAR=$P($T(MSGTXT+I),";;",2) Q:TXTVAR="QUIT"  D LINE(TXTVAR)
 D CK72844
 D MAIL
 K ^TMP(ECXJ,"ECX353PT"),TEXT,TYP
 Q
 ;
CK72844 ;Check file 728.44 for invalid stop codes.
 S CNTX=0
 D HDR1
 ;search file #728.44 for invalid entries
 S IEN=0 F  S IEN=$O(^ECX(728.44,IEN)) Q:'IEN  K STR D
 .S ECX=$G(^ECX(728.44,IEN,0)),PSC=$P(ECX,U,2),SSC=$P(ECX,U,3)
 .S DPC=$P(ECX,U,4),DSC=$P(ECX,U,5),NAM=$$GET1^DIQ(44,$P(ECX,U),.01)
 .S IDT=$P(ECX,U,10),CNT=1,HTYP=$$GET1^DIQ(44,$P(ECX,U),2,"I")
 .I IDT'="" S NAM="*"_NAM
 .S (PSCN,SSCN,DPCN,DSCN)="" D
 ..I PSC="" S STR(CNT)="Missing primary code",CNT=CNT+1 Q
 ..S PSCN=$$SCIEN(PSC)
 ..I PSCN="" S STR(CNT)=PSC_" Invalid Code",CNT=CNT+1 Q
 ..D SCCHK(PSCN,"P")
 .I SSC'="" S SSCN=$$SCIEN(SSC) D 
 ..I SSCN="" D  Q
 ...Q:PSC=SSC  S STR(CNT)=SSC_" Invalid Code",CNT=CNT+1
 ..D SCCHK(SSCN,"S")
 .D
 ..I DPC="" S STR(CNT)="No DSS primary code",CNT=CNT+1 Q
 ..S DPCN=$$SCIEN(DPC) Q:DPC=PSC
 ..I DPCN="" D  Q
 ...S STR(CNT)=DPC_" Invalid Code",CNT=CNT+1
 ..D SCCHK(DPCN,"P")
 .I DSC'="",DSC'=SSC S DSCN=$$SCIEN(DSC) D
 ..I DSCN="" D  Q
 ...Q:DSC=DPC  Q:DSC=SSC  Q:DSC=DPC
 ...S STR(CNT)=DSC_" Invalid Code",CNT=CNT+1
 ..D SCCHK(DSCN,"S")
 .I $O(STR(0))'="" D
 ..I HTYP'="C" K STR S STR(1)="Not a Clinic"
 ..D LINE(.STR,"S") S CNTX=CNTX+1
 D LINE(" ")
 S STR=$E(BLN,1,25)_$S(CNTX:CNTX,1:"NO")_" PROBLEM CLINICS FOUND."
 D LINE(STR)
 Q
 ;
SCNUM(SCIEN) ;Get stop code Number
 I SCIEN="" Q ""
 S SCN=$P($G(^DIC(40.7,SCIEN,0)),U,2)
 Q SCN
 ;
SCIEN(SCN) ;Get stop code IEN
 I SCN="" Q ""
 S SCIEN=$O(^DIC(40.7,"C",SCN,0))
 Q SCIEN
 ;
SCCHK(SCIEN,TYP) ;check stop code against file 40.7
 N SCN,RTY,CTY
 S CTY=$S(TYP="P":"^P^E^",1:"^S^E^")
 S SCN=$G(^DIC(40.7,SCIEN,0)),RTY=$P(SCN,U,6),SCN=$P(SCN,U,2)
 I SCN="" D  Q
 .I TYP="S" Q:SSC=PSC  Q:DSC=DPC
 .S STR(CNT)=SCIEN_" Invalid pointer."
 .D CNTR
 I RTY="" S STR(CNT)=SCN_" No restriction type" D CNTR Q
 I CTY'[("^"_RTY_"^") D
 .S STR(CNT)=SCN_" cannot be "_$S(TYP="P":"prim",1:"second")_"ary"
CNTR ;counter
 S CNT=CNT+1
 Q
 ;
HDR1 ;header for data from file #728.44
 D LINE(" ")
 D LINE(" ")
 S STR="CLINICS AND STOP CODES File (#728.44) - (Use 'Enter/Edit DSS "
 S STR=STR_"Stop Codes for"
 D LINE(STR)
 S STR=$E(BLN,1,25)_"Clinics' [ECXSCEDIT] menu option to "
 S STR=STR_"make corrections)"
 D LINE(STR)
 D LINE(" ")
 S STR=$E(BLN,1,39)_$E("DSS"_BLN,1,9)_$E("DSS"_BLN,1,9)
 D LINE(STR)
 S STR=$E(BLN,1,21)_$E("PRIMARY"_BLN,1,9)_$E("2NDARY/"_BLN,1,9)
 S STR=STR_$E("PRIMARY"_BLN,1,9)_$E("2NDARY/"_BLN,1,9)
 D LINE(STR)
 S STR=$E("CLINIC NAME"_BLN,1,21)_$E("STOP"_BLN,1,9)_$E("CREDIT"_BLN,1,9)
 S STR=STR_$E("STOP"_BLN,1,9)_$E("CREDIT"_BLN,1,8)_"REASON FOR NON-"
 D LINE(STR)
 S STR=$E("*currently inactive"_BLN,1,21)_$E("CODE"_BLN,1,9)
 S STR=STR_$E("CODE"_BLN,1,9)_$E("CODE"_BLN,1,9)_$E("CODE"_BLN,1,8)
 S STR=STR_"CONFORMANCE"
 D LINE(STR)
 S STR=$E(LNS,1,80)
 D LINE(STR)
 Q
MSGTXT ; Message intro
 ;; Please forward this message to your local DSS Site Manager/ADPAC.
 ;;
 ;; A review of the Primary and Secondary Stop Codes in the CLINICS AND
 ;; STOP CODES file (#728.44) was completed against the Restriction Type
 ;; field (#5) of the CLINIC STOP file (#40.7) for nonconforming clinics.
 ;;
 ;;    
 ;;QUIT
 ;
 ;
LINE(TEXT,TYP) ; Add line to message global
 N FLN,STR,XI
 ;build 1st line with name, codes, etc.
 I $O(TEXT(0))'="" D  Q
 .S STR=$E(NAM_BLN,1,$S(TYP="P":35,1:21))
 .S STR=STR_$E(PSC_BLN,1,$S(TYP="P":10,1:9))
 .S STR=STR_$E(SSC_BLN,1,$S(TYP="P":12,1:9))
 .I TYP="S" S STR=STR_$E(DPC_BLN,1,9)_$E(DSC_BLN,1,8)
 .;set line in ^tmp global
 .S XI=0 F  S XI=$O(TEXT(XI)) Q:'XI  D
 ..S TEXT(XI)=STR_TEXT(XI)
 ..S COUNT=COUNT+1,^TMP(ECXJ,"ECX353PT",COUNT)=TEXT(XI)
 S COUNT=COUNT+1,^TMP(ECXJ,"ECX353PT",COUNT)=TEXT
 Q
 ;
MAIL ; Send message
 N XMDUZ,XMY,XMTEXT,XMSUB
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="DSS Identifier Non-Conforming Clinics"
 S XMTEXT="^TMP(ECXJ,""ECX353PT"","
 D ^XMD
 Q
