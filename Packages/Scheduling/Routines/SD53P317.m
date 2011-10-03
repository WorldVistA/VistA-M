SD53P317 ;ALB/JAM - Restricting Stop Code Post-Init Rtn ; 0707/03
 ;;5.3;Scheduling;**317**;AUG 13, 1993
 ;
POST ; entry point
 ;* Appropriating Stop Code fl #40.7 entries with restriction type & date
 N SDJ,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTREQ,ZTSAVE
 I $D(^UTL("STPCODE")) K ^UTL("STPCODE")
 S SDJ=$J
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("This post install process does the following:-")
 D BMES^XPDUTL("  1. Appropriates Stop Code entries in CLINIC STOP file (#40.7) with a ")
 D MES^XPDUTL("     Restriction Type and Date.")
 D BMES^XPDUTL("  2. Check clinics in file #44 for nonconforming Stop Codes and produces")
 D MES^XPDUTL("     a MailMan message.")
 D MES^XPDUTL(" ")
 ;read and store stop codes in ^UTILITY("STPCODE",SDJ,
 D ^SDSTPD1
 ;assign stop code restriction type and restriction date
 D STPMOD
 ;check file #44 for non-conforming restriction type
 S ZTRTN="PROCESS^SD53P317"
 S ZTDESC="Non-Conforming Clinics Restricted Stop Code Report"
 S ZTIO="",ZTDTH=$H,ZTREQ="@" D ^%ZTLOAD
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("completed...")
 D MES^XPDUTL(" ")
 K ^UTILITY("STPCODE")
 Q
STPMOD ;* designate stop codes in file 40.7 as primary, secondary or either
 ;
 ;  SDXX is in format:
 ;   STOP CODE^NAME^RESTRICTION TYPE^RESTRICTION DATE^INACTIVE DATE
 ;
 N SDX,SDXX,NAME,CODE,RESTY,RESDT,X,Y,DIC,DIE,DA,DR,IEN,INACT
 D BMES^XPDUTL("Adding Restricted Type and Restricted Date to CLINIC STOP File (#40.7)...")
 D MES^XPDUTL(" ")
 S SDX=0 F  S SDX=$O(^UTILITY("STPCODE",SDJ,SDX)) Q:'SDX  S SDXX=^(SDX) D
 .S CODE=$P(SDXX,U),NAME=$P(SDXX,U,2),RESTY=$P(SDXX,U,3)
 .S RESDT=$P(SDXX,U,4),INACT=$P(SDXX,U,5)
 .I '$D(^DIC(40.7,"C",CODE)) S ^TMP("STPCD",$J,CODE)=SDXX Q
 .S IEN=$O(^DIC(40.7,"C",CODE,0)) I 'IEN Q
 .I '$D(^DIC(40.7,IEN,0)) S ^TMP("STPCD",$J,CODE)=SDXX Q
 .S IEN=0 F  S IEN=$O(^DIC(40.7,"C",CODE,IEN)) Q:'IEN  D FILSC
 .W !,?2,CODE,?7,NAME,?40,"National Code Updated...."
 D MES^XPDUTL(" ")
 S RESTY="S" F SDX=450:1:485 D
 .Q:'$D(^DIC(40.7,"C",SDX))  S IEN=$O(^DIC(40.7,"C",SDX,0)) I 'IEN Q
 .Q:'$D(^DIC(40.7,IEN,0))  S SDXX=^(0) S RESDT="10/1/2003"
 .S IEN=0 F  S IEN=$O(^DIC(40.7,"C",SDX,IEN)) Q:'IEN  D FILSC
 .W !,?2,SDX,?7,$P(SDXX,U),?40,"Local Code Updated...."
 D MES^XPDUTL(" ")
 S CODE="" F  S CODE=$O(^TMP("STPCD",$J,CODE)) Q:CODE=""  D
 .S SDX=^TMP("STPCD",$J,CODE),NAME=$P(SDX,U,2)
 .S RESTY=$P(SDXX,U,3),RESDT=$P(SDXX,U,4),INACT=$P(SDXX,U,5)
 .W !,?2,CODE,?7,NAME,?40,"Problematic....code not in file 40.7"
 D MES^XPDUTL(" ")
 S IEN=0 F  S IEN=$O(^DIC(40.7,IEN)) Q:'IEN  D
 .S SDXX=$G(^DIC(40.7,IEN,0)) Q:SDXX=""  Q:$P(SDXX,U,6)'=""
 .W !,?2,$P(SDXX,U,2),?7,$E($P(SDXX,U),1,30),?40,"Missing Restriction Type."
 Q
 ;
FILSC ;Update stop code in file 40.7
 S DIE="^DIC(40.7,"
 S DA=IEN,DR="5////"_RESTY_";6///"_RESDT D ^DIE
 Q
 ;
PROCESS ;background entry point
 ; Locate invalid Stop Code in file 44 & 728.44 and put in a mail message
 N SDX,IEN,BLN,COUNT,TXTVAR,I,LNS,CNT,STR,SDJ,PSC,SSC,DPC,DSC,CNTX,NAM
 N SCN,PSCN,SSCN,DPCN,DSCN,IDT
 S COUNT=0,$P(BLN," ",60)="",$P(LNS,"-",80)=""
 S SDJ=$J K ^TMP(SDJ,"SD53P309")
 F I=1:1 S TXTVAR=$P($T(MSGTXT+I),";;",2) Q:TXTVAR="QUIT"  D LINE(TXTVAR)
 D CK44
 D MAIL
 K ^TMP(SDJ,"SD53P309"),TEXT,TYP
 Q
 ;
CK44 ;Check file 44 for invalid stop codes.
 N RDT,IDAT
 S (CNTX,IEN)=0
 D HDR
 ;search file #44 for invalid entries
 F  S IEN=$O(^SC(IEN)) Q:'IEN  D
 .K STR S SDX=$G(^SC(IEN,0)),PSC=$P(SDX,U,7),SSC=$P(SDX,U,18),CNT=1
 .I $P(SDX,U,3)'="C" Q
 .S NAM=$P(SDX,U),IDAT=$G(^SC(IEN,"I")) I IDAT'="" D
 ..S IDT=$P(IDAT,U),RDT=$P(IDAT,U,2) Q:IDT=""  I RDT="" S NAM="*"_NAM Q
 ..I RDT>IDT S NAM="*"_NAM
 .S (PSCN,SSCN)="" D
 ..I PSC="" S STR(CNT)="Missing primary code",CNT=CNT+1 Q
 ..S PSCN=$$SCNUM(PSC)
 ..I PSCN="" S STR(CNT)=PSC_" has Inv pri ptr",CNT=CNT+1 Q
 ..D SCCHK(PSC,"P")
 .I SSC'="" D
 ..S SSCN=$$SCNUM(SSC)
 ..I SSCN="" S STR(CNT)=SSC_" has Inv 2nd ptr",CNT=CNT+1 Q
 ..D SCCHK(SSC,"S")
 .I $O(STR(0))'="" D LINE(.STR,"P") S CNTX=CNTX+1
 D LINE(" ")
 S STR=$E(BLN,1,25)_$S(CNTX:CNTX,1:"NO")_" PROBLEM CLINICS FOUND."
 D LINE(STR)
 D LINE(" ")
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
 I SCN="" D  D CNTR Q
 .S STR(CNT)=SCIEN_" Invalid pointer."
 I RTY="" S STR(CNT)=SCN_" No restriction type" D CNTR Q
 I CTY'[("^"_RTY_"^") D
 .S STR(CNT)=SCN_" cannot be "_$S(TYP="P":"prim",1:"second")_"ary"
CNTR ;counter
 S CNT=CNT+1
 Q
 ;
HDR ;Header for data from file #44
 D LINE(" ")
 S STR="HOSPITAL LOCATION FILE (#44) - (Use Set up a Clinic [SDBUILD]"
 S STR=STR_" menu option to"
 D LINE(STR)
 S STR=$E(BLN,1,32)_"make corrections)"
 D LINE(STR)
 D LINE(" ")
 S STR=$E(BLN,1,35)_$E("PRIMARY"_BLN,1,10)
 S STR=STR_$E("SECONDARY/"_BLN,1,11)_"REASON FOR"
 D LINE(STR)
 S STR=$E("CLINIC NAME"_BLN,1,35)_$E("STOP"_BLN,1,10)
 S STR=STR_$E("CREDIT"_BLN,1,11)_"NON"
 D LINE(STR)
 S STR=$E("(* - currently inactive)"_BLN,1,35)_$E("CODE"_BLN,1,10)
 S STR=STR_$E("STOP CODE"_BLN,1,11)_"CONFORMANCE"
 D LINE(STR)
 S STR=$E(LNS,1,80)
 D LINE(STR)
 Q
 ;
MSGTXT ; Message intro
 ;; Please forward this message to your local MAS ADPAC.
 ;;
 ;; A review of the Primary and Secondary Stop Codes in the HOSPITAL 
 ;; LOCATION file (#44) was completed against the Restriction Type
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
 .S STR=STR_$E($$SCNUM(PSC)_BLN,1,$S(TYP="P":10,1:9))
 .S STR=STR_$E($$SCNUM(SSC)_BLN,1,$S(TYP="P":11,1:9))
 .I TYP="S" S STR=STR_$E($$SCNUM(DPC)_BLN,1,9)_$E($$SCNUM(DSC)_BLN,1,9)
 .;set line in ^tmp global
 .S XI=0 F  S XI=$O(TEXT(XI)) Q:'XI  D
 ..;I XI'=FLN S TEXT(XI)=$E(BLN,1,57)_TEXT(XI)
 ..S TEXT(XI)=STR_TEXT(XI)
 ..S COUNT=COUNT+1,^TMP(SDJ,"SD53P309",COUNT)=TEXT(XI)
 S COUNT=COUNT+1,^TMP(SDJ,"SD53P309",COUNT)=TEXT
 Q
 ;
MAIL ; Send message
 N XMDUZ,XMY,XMTEXT,XMSUB
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Non-Conforming Clinics Restricted Stop Codes"
 S XMTEXT="^TMP(SDJ,""SD53P309"","
 D ^XMD
 Q
