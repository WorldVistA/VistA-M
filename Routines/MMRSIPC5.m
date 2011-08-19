MMRSIPC5 ;MIA/LMT - Auto-Extract MRSA IPEC Report ;08-20-09
 ;;1.0;MRSA PROGRAM TOOLS;;Aug 22, 2009;Build 35
 ;
 ;This routine will run the auto-extract for the MRSA IPEC Report.
 ;This routine uses functions contained in MMRSIPC, MMRSIPC2, MMRSIPC3, and MMRSIPC4.
TASK ;Entry for auto-extract to IPEC
 ;Extract prevalence and transmission data for all Acute Care and CLC units
 Q:'$$PROD^XUPROD
 N NOW,FIRST,STRTDT,ENDDT,MMRSDIV,TYPE,MMRSLOC,BYADM,PRTSUM,LOC,DATA,MMRSMSG
 N MAILTO,MONTH,YEAR,DIV,DIVNUM,SUBJECT,LOCIEN,IPECUID
 S NOW=$$NOW^XLFDT()
 S FIRST=$E(NOW,1,5)_"01"
 S ENDDT=$$FMADD^XLFDT(FIRST,-1,0,0,0)_".24"
 S STRTDT=$E(ENDDT,1,5)_"01"
 S MMRSDIV=0 F  S MMRSDIV=$O(^MMRS(104,MMRSDIV)) Q:'MMRSDIV  D
 .F TYPE="AC","CLC" D
 ..N MMRSLOC,BYADM
 ..S LOC=0 F  S LOC=$O(^MMRS(104.3,LOC)) Q:'LOC  D
 ...I $P($G(^MMRS(104.3,LOC,0)),U,2)=MMRSDIV,$P($G(^MMRS(104.3,LOC,0)),U,3)=TYPE S MMRSLOC(LOC)=""
 ..I '$O(MMRSLOC(0)) Q
 ..F BYADM=0,1 D
 ...D CLEAN^MMRSIPC ;Kill Temp Global
 ...D GETPARAM^MMRSIPC ; Load parameters in temp global
 ...D GETMOVE^MMRSIPC2 ;Get movements and store in temp global
 ...D GETLABS^MMRSIPC3 ;Get swabbing rates and MRSA history and store in temp global
 ...I 'BYADM D PATDAYS^MMRSIPC ;Get patient days of care
 ...I BYADM D
 ....S LOC="" F  S LOC=$O(^TMP($J,"MMRSIPC","DSUM",LOC)) Q:LOC=""  D
 .....S DATA=$G(^TMP($J,"MMRSIPC","DSUM",LOC))
 .....S $P(MMRSMSG(MMRSDIV,TYPE_"U",LOC),"~",1,5)=$TR($P(DATA,U,5,9),U,"~")
 ....S DATA=$G(^TMP($J,"MMRSIPC","DSUM"))
 ....S MMRSMSG(MMRSDIV,TYPE_"S","FACILITY")=$TR($P(DATA,U,1,4),U,"~")
 ...I 'BYADM D
 ....S LOC="" F  S LOC=$O(^TMP($J,"MMRSIPC","DSUM",LOC)) Q:LOC=""  D
 .....S DATA=$G(^TMP($J,"MMRSIPC","DSUM",LOC))
 .....S $P(MMRSMSG(MMRSDIV,TYPE_"U",LOC),"~",6,10)=$TR($P(DATA,U,1,5),U,"~")
 ...D CLEAN^MMRSIPC ;Kill Temp Global
MAIL ;Mail prevalence and transmission measures to IPEC
 S MAILTO="G.IPEC ACK MESSAGE@KANSAS-CITY.MED.VA.GOV"
 S MONTH=$E(STRTDT,4,5)
 S YEAR=$E(STRTDT,1,3)+1700
 S MMRSDIV=0 F  S MMRSDIV=$O(MMRSMSG(MMRSDIV)) Q:'MMRSDIV  D
 .S DIV=$P($G(^MMRS(104,MMRSDIV,0)),U,1)
 .S DIVNUM=$P($$SITE^VASITE(,DIV),U,3)
 .S SUBJECT=$S($$PROD^XUPROD:"",1:"TEST")_"MRSA~"_DIVNUM_"~"_MONTH_"-"_YEAR
 .I $D(MMRSMSG(MMRSDIV,"ACU")) D
 ..N TEXT,XMTEXT,XMDUZ,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,LINE,XMDUN,XMZ,XMSUB
 ..S XMSUB=SUBJECT_"~DU"
 ..S TEXT(1)="Type~VISN~Station~Unit~UnitID~Year~Month~PrevAdmissions~PrevScreensInd~PrevScreens~PrevScreensPos~PrevCulturesPos~TransBedDays~TransExits~TransSwabsInd~TransScreens~TransTrans"
 ..S LINE=2
 ..S LOC="" F  S LOC=$O(MMRSMSG(MMRSDIV,"ACU",LOC)) Q:LOC=""  D
 ...S LOCIEN=$O(^MMRS(104.3,"B",LOC,0))
 ...S IPECUID=$P($G(^MMRS(104.3,LOCIEN,0)),U,4)
 ...S TEXT(LINE)="DU~~"_DIVNUM_"~"_LOC_"~"_IPECUID_"~"_YEAR_"~"_+MONTH_"~"_$G(MMRSMSG(MMRSDIV,"ACU",LOC))
 ...S LINE=LINE+1
 ..S XMTEXT="TEXT("
 ..S XMY(MAILTO)=""
 ..D ^XMD
 .I $D(MMRSMSG(MMRSDIV,"ACS","FACILITY")) D
 ..N TEXT,XMTEXT,XMDUZ,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,LINE,XMDUN,XMZ,XMSUB
 ..S XMSUB=SUBJECT_"~DS"
 ..S TEXT(1)="Type~VISN~Station~Year~Month~PrevAdmissions~PrevScreens~PrevScreensPos~PrevCulturesPos"
 ..S TEXT(2)="DS~~"_DIVNUM_"~"_YEAR_"~"_+MONTH_"~"_$G(MMRSMSG(MMRSDIV,"ACS","FACILITY"))
 ..S XMTEXT="TEXT("
 ..S XMY(MAILTO)=""
 ..D ^XMD
 .I $D(MMRSMSG(MMRSDIV,"CLCU")) D
 ..N TEXT,XMTEXT,XMDUZ,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,LINE,XMDUN,XMZ,XMSUB
 ..S XMSUB=SUBJECT_"~CU"
 ..S TEXT(1)="Type~VISN~Station~Unit~UnitID~Year~Month~PrevAdmissions~PrevScreensInd~PrevScreens~PrevScreensPos~PrevCulturesPos~TransBedDays~TransExits~TransSwabsInd~TransScreens~TransTrans"
 ..S LINE=2
 ..S LOC="" F  S LOC=$O(MMRSMSG(MMRSDIV,"CLCU",LOC)) Q:LOC=""  D
 ...S LOCIEN=$O(^MMRS(104.3,"B",LOC,0))
 ...S IPECUID=$P($G(^MMRS(104.3,LOCIEN,0)),U,4)
 ...S TEXT(LINE)="CU~~"_DIVNUM_"~"_LOC_"~"_IPECUID_"~"_YEAR_"~"_+MONTH_"~"_$G(MMRSMSG(MMRSDIV,"CLCU",LOC))
 ...S LINE=LINE+1
 ..S XMTEXT="TEXT("
 ..S XMY(MAILTO)=""
 ..D ^XMD
 .I $D(MMRSMSG(MMRSDIV,"CLCS","FACILITY")) D
 ..N TEXT,XMTEXT,XMDUZ,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,LINE,XMDUN,XMZ,XMSUB
 ..S XMSUB=SUBJECT_"~CS"
 ..S TEXT(1)="Type~VISN~Station~Year~Month~PrevAdmissions~PrevScreens~PrevScreensPos~PrevCulturesPos"
 ..S TEXT(2)="CS~~"_DIVNUM_"~"_YEAR_"~"_+MONTH_"~"_$G(MMRSMSG(MMRSDIV,"CLCS","FACILITY"))
 ..S XMTEXT="TEXT("
 ..S XMY(MAILTO)=""
 ..D ^XMD
 Q
