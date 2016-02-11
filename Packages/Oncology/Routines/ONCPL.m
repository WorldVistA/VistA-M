ONCPL ;Hines OIFO/GWB - ONCOLOGY PROBLEM LIST ;07/14/04
 ;;2.2;ONCOLOGY;**1,7**;Jul 31, 2013;Build 5
 ;
 K ONCPL,PL
 N DIR,DPTIEN,ICD,ONS,ONSDT,SAVEY,SUB,X
 S SAVEY=Y
 W !
 W !," Would you like to see a PROBLEM LIST for this patient to assist"
 W !," you in entering the COMORBIDITY/COMPLICATION #1-10"
 W !," Secondary Diagnosis #1-10 prompts"
 W !
 S DIR(0)="Y",DIR("B")="Yes" D ^DIR
 I (Y=0)!(Y="") W ! S Y=SAVEY Q
 I Y[U S Y=SAVEY Q
 I $P(^ONCO(160,D0,0),U,1)["LRT" W !!," No PROBLEM LIST for this patient." W ! S Y=SAVEY Q
 S DPTIEN=$P(^ONCO(160,D0,0),";",1)
 ;Supported by IA #928
 D ACTIVE^GMPLUTL(DPTIEN,.ONCPL)
 I ONCPL(0)=0 W !!," No PROBLEM LIST for this patient." W ! S Y=SAVEY Q
 S SUB=0 F  S SUB=$O(ONCPL(SUB)) Q:SUB'>0  D
 .S ONS=$P(ONCPL(SUB,3),U,1) S:ONS="" ONS="UNKNOWN"_SUB
 .S PL(ONS)=$P(ONCPL(SUB,2),U,2)_U_$P(ONCPL(SUB,1),U,2)
 I '$D(PL) W !!," No PROBLEM LIST for this patient." W ! S Y=SAVEY Q
 W !
 W !,"DATE OF ONSET","  ","ICD DIAGNOSIS"
 W !,"-------------  -------------------------------------------"
 S ONS=0 F  S ONS=$O(PL(ONS)) Q:ONS=""  D
 .I ONS["UNKNOWN" S ONSDT="UNKNOWN"
 .I ONS'["UNKNOWN" S Y=ONS D DD^%DT S ONSDT=Y
 .W !,ONSDT,?15,$P(PL(ONS),U,1),?24,$P(PL(ONS),U,2)
 W !
 S Y=SAVEY Q
