ICDDRGX3 ;MKN - GROUPER PROCESS continued from ICDDRGX2;06/04/12 3:45pm
 ;;18.0;DRG Grouper;**64,82**;Oct 20, 2000;Build 21
 ;
VARIABLS ;Apply Variables for MDC 1-22
 ;
 I $D(ICD10OR(80)) S ICDRG=$S(ICDMCC>0:707,1:708),ICDFI=1 G EXIT ;80=Major Male Pelvic
 I ICDMDC=12,$D(ICD10OR(119)) S ICDRG=$S(ICDMCC>0:709,1:710),ICDFI=1 G EXIT ;119=Penis Procedures
 I $D(ICD10OR(147)) S ICDRG=$S(ICDMCC>0:711,1:712),ICDFI=1 G EXIT ;147=Testes Procedures
 I ICDMDC=12,$D(ICD10OR(153)) S ICDRG=$S(ICDMCC>0:713,1:714),ICDFI=1 G EXIT ;153=Transurethral Prostatectomy
 I SEX="M",ICDMDC=12,$D(ICD10OR(108)) D  ;108=Other Male Reproductive System O.R. Procedures
 . I $D(ICD10PD(98)) S ICDRG=$S(ICDMCC>0:715,1:716),ICDFI=1 Q  ;98=Malignancy
 . S ICDRG=$S(ICDMCC>0:717,1:718),ICDFI=1 Q
 G:ICDFI EXIT
 I ICDMDC=12,SEX="M",$D(ICD10PD(98)) S ICDRG=$S(ICDMCC=2:722,ICDMCC=1:723,1:724),ICDFI=1 G EXIT
 I SEX="F",$D(ICD10OR(235)) S ICDRG=$S(ICDMCC>0:734,1:735),ICDFI=1 G EXIT ;235=Pelvic Evisceration, Radical Hysterectomy and Radical Vulvectomy
 I $D(ICD10OR(158)),$D(ICD10PD(143)) S ICDRG=$S(ICDMCC=2:739,ICDMCC=1:740,1:741),ICDFI=1 G EXIT ;158=Uterine and Adnexal Procedures 143=Non-ovarian/adnexal Malignancy
 I $D(ICD10OR(158)),$D(ICD10PD(168)) S ICDRG=$S(ICDMCC=2:736,ICDMCC=1:737,1:738),ICDFI=1 G EXIT ;168=Ovarian or Adnexal Malignancy
 I SEX="F" D
 . I ICDMDC=13 D
 . . I $D(ICD10OR(253)) S ICDRG=$S(ICDMCC>0:742,1:743),ICDFI=1 Q  ;253=Uterine and Adnexal Procedures for Non-Malignancy
 . . I $D(ICD10OR(208)) S ICDRG=$S(ICDMCC>0:744,1:745),ICDFI=1 Q  ;208=D&C, Conization, Laparoscopy and Tubal Interruption
 . Q:ICDFI
 . I ICDMDC=14,$D(ICD10OR(181)) D  ;181=Delivery procedures
 . . I $D(ICD10OR(183)) S ICDRG=767,ICDFI=1 Q  ;183=Sterilization and/or D&C
 . . I $D(ICD10OR(182)) S ICDRG=768,ICDFI=1 Q  ;182=Not Sterilization and/or D&C
 G:ICDFI=1 EXIT
 I $D(ICD10OR(254)) S ICDRG=$S(ICDMCC>0:746,1:747),ICDFI=1 G EXIT ;254=Vagina, Cervix and Vulva Procedures
 I $D(ICD10OR(47)) S ICDRG=748,ICDFI=1 G EXIT ;47=Female Reproductive System Reconstructive Procedures
 I SEX="F",$D(ICD10OR(104)) S ICDRG=$S(ICDMCC>0:749,1:750),ICDFI=1 G EXIT ;104=Other Female Reproductive System O.R. Procedures
 I SEX="F",$D(ICD10PD(100)) S ICDRG=$S(ICDMCC=2:754,ICDMCC=1:755,1:756),ICDFI=1 G EXIT ;100=Malignancy, Female Reproductive System
 I SEX="F",$D(ICD10PD(81)) S ICDRG=$S(ICDMCC=2:757,ICDMCC=1:758,1:759),ICDFI=1 G EXIT ;81=Infections, Female Reproductive System
 I $D(ICD10PD(272)) S ICDRG=$S(ICDMCC>0:760,1:761),ICDFI=1,ICDFI=1 G EXIT ;272=Menstrual and Other Female Reproductive System Disorders
 I $D(ICD10OR("c")) S ICDRG=$S(ICDMCC>0:765,1:766),ICDFI=1 G EXIT ;"c"=Cesarean Sec
 I $D(ICD10OR(312)) S ICDRG=$S($D(ICD10OR(183)):767,1:768),ICDFI=1 G EXIT ;312=Vaginal Delivery 183=Sterilization and/or D&C
 I $D(ICD10PD(294)),$D(ICD10OR) S ICDRG=769,ICDFI=1 G EXIT ;294=Postpartum and Post Abortion Diagnoses with O.R. Procedure
 I $D(ICD10PD(294)),'$D(ICD10OR) S ICDRG=776,ICDFI=1 G EXIT
 I $D(ICD10PD(227)) S ICDRG=779,ICDFI=1 G EXIT ;Abortion without D&C
 I $D(ICD10OR(145)) S ICDRG=$S(ICDMCC=2:799,ICDMCC=1:800,1:801),ICDFI=1 G EXIT ;145=Splenectomy
 I ICDMDC=16,$D(ICD10OR(231)) S ICDRG=$S(ICDMCC=2:802,ICDMCC=1:803,1:804),ICDFI=1 G EXIT ;231=Other O.R. Procedures of the Blood and Blood Forming Organs
 I $D(ICD10PD(265)) S ICDRG=$S(ICDMCC=2:808,ICDMCC=1:809,1:810),ICDFI=1 G EXIT ;265=Major Hematological/Immunological Diagnoses Except Sickle Cell Crisis and Coagulation
 I $D(ICD10PD(261)),$D(ICD10OR(81)) S ICDRG=$S(ICDMCC=2:820,ICDMCC=1:821,1:822),ICDFI=1 G EXIT ;261=Lymphoma and Leukemia with Major O.R. Procedure
 I $D(ICD10PD(263)),$D(ICD10OR),'$D(ICD10OR(81)) S ICDRG=$S(ICDMCC=2:823,ICDMCC=1:824,1:825),ICDFI=1 G EXIT ;263=Lymphoma and Non-Acute Leukemia with Other O.R. Procedure
 I $D(ICD10PD(231)),'$D(ICD10OR(81)) S ICDRG=$S(ICDMCC=2:834,ICDMCC=1:835,1:836),ICDFI=1 G EXIT ;231=Acute Leukemia without Major O.R. Procedure
 I $D(ICD10PD(262)) S ICDRG=$S(ICDMCC=2:840,ICDMCC=1:841,1:842),ICDFI=1 G EXIT ;Lymphoma and Non-Acute Leukemia
 I $D(ICD10PD(181)) S ICDRG=849,ICDFI=1 G EXIT ;Radiotherapy
 I $D(ICD10PD(134)),'$D(ICD10PD(35)) D  ;134=Myeloproliferative Disorders or Poorly Differentiated Neoplasms
 . I $D(ICD10OR(81)) S ICDRG=$S(ICDMCC=2:826,ICDMCC=1:827,1:828),ICDFI=1 Q
 . I $D(ICD10OR) S ICDRG=$S(ICDMCC>0:829,1:830),ICDFI=1 Q
 I $D(ICD10OR(111)) S ICDRG=$S(ICDMCC=2:907,ICDMCC=1:908,1:909),ICDFI=1 G EXIT ;Other O.R. Procedures for Injuries
 G:ICDFI EXIT
 I ICDMDC=17,$D(ICD10PD(35)) D  ;134=Myeloproliferative Disorders or Poorly Differentiated Neoplasms  35=Chemotherapy Implant
 . I $D(ICD10SD(15)),ICDMCC=2 S ICDRG=837,ICDFI=1 Q  ;15=SDX Acute Leukemia  56=High Dose Chemo Agent
 . I $D(ICD10SD(15)),'$D(ICD10OR(56)) S ICDRGT=$S(ICDMCC=2:837,ICDMCC=1:838,ICDMCC=0:839,1:0) I ICDRGT>0 S ICDRG=ICDRGT,ICDFI=1 Q
 . I '$D(ICD10SD(15)),$D(ICD10OR(56)),ICDMCC=2 S ICDRG=837,ICDFI=1 Q
 . I '$D(ICD10SD(15)),$D(ICD10OR(56)),ICDMCC'=2 S ICDRG=838,ICDFI=1 Q
 G:ICDFI EXIT
 I $D(ICD10PD(288)) S ICDRG=$S(ICDMCC=2:843,ICDMCC=1:844,1:845),ICDFI=1 G EXIT ;288=Other Myeloproliferative Disorders or Poorly Differentiated Neoplasm Diagnoses
 I $D(ICD10PD(240)) S ICDRG=$S(ICDMCC=2:846,ICDMCC=1:847,1:848),ICDFI=1 G EXIT ;240=Chemotherapy without Acute Leukemia as Secondary Diagnosis
 I ICDMDC=18,$D(ICD10OR("O")) D  ;82=infectious & Parasitic Diseases, Systemic or Unspecified Sites
 . S ICDX=$$ICDXEXPT^ICDRGAPI(ICDDX(1),"^K68.11^N98.0^T80.22XA^T80.29XA^T81.4XXA^T88.0XXA^")
 . I ICDX=0 S ICDRG=$S(ICDMCC=2:853,ICDMCC=1:854,1:855),ICDFI=1 Q
 . I ICDX S ICDRG=$S(ICDMCC=2:856,ICDMCC=1:857,1:858),ICDFI=1 Q
 I ICDMDC=18,'$D(ICD10OR("O")) D
 . S ICDX=$$ICDXEXPT^ICDRGAPI(ICDDX(1),"^K68.11^T81.4XXA^")
 . I ICDX S ICDRG=$S(ICDMCC=2:862,1:863),ICDFI=1 Q 
 G:ICDFI EXIT
 ;I $D(ICD10PD(175)),$D(ICD10OR("O")) S ICDRG=$S(ICDMCC=2:856,ICDMCC=1:857,1:858),ICDFI=1 G EXIT ;175=Postoperative or Post-Traumatic Infections with O.R. Procedure
 I $D(ICD10PD(190))!($D(ICD10PD("W"))) D  ;190=Septicemia or Severe Sepsis  "W"=Severe Sepsis
 . I $D(ICD10OR(225)) S ICDRG=870,ICDFI=1 Q
 . S ICDRG=$S(ICDMCC=2:871,1:872),ICDFI=1 Q
 G:ICDFI EXIT
 I ICDMDC=19,$D(ICD10OR("O")) S ICDRG=876,ICDFI=1 G EXIT ;Mental Illness
 I ICDMDC=20 D
 . I ICDDMS=1 S ICDRG=894,ICDFI=1 Q  ;Left against medical advice (AMA)
 . I $D(ICD10PD(270)),$D(ICD10OR(132)) S ICDRG=895,ICDFI=1 Q  ;270=MDC 20 Alcohol/Drug Use & Alcohol/Drug Induced Organic Mental Disorders  132=Rehabilitation Therapy
 . I $D(ICD10PD(270)),'$D(ICD10OR(132)),'$D(ICD10OR("x")) S ICDRG=$S(ICDMCC=2:896,1:897),ICDFI=1 Q  ;132=Rehabilitation Therapy
 G:ICDFI EXIT
 I $D(ICD10OR(166)),$D(ICD10OR("O")) S ICDRG=$S(ICDMCC=2:901,ICDMCC=1:902,1:903),ICDFI=1 G EXIT ;Wound Debridements for Injuries
 I ICDMDC=21,$D(ICD10OR(139)) S ICDRG=$S(ICDMCC>0:904,1:905),ICDFI=1 G EXIT ;139=Skin Grafts for Injuries
 I ICDMDC=21,$D(ICD10OR(52)) S ICDRG=906,ICDFI=1 G EXIT
 I $D(ICD10PD(42)) S ICDRG=$S(ICDMCC=2:919,ICDMCC=1:920,1:921),ICDFI=1 G EXIT ;42=Complications of Treatment
 I $D(ICD10PD("*"))!($D(ICD10PD("b"))&($D(ICD10OR(225)))) S ICDRG=$S($D(ICD10OR("k")):927,1:933),ICDFI=1 G EXIT ;*=Extensive Burns or b=Full Thickness Burns with 225=MV 96+Hours k=Skin Graft
 I $D(ICD10PD("b")) D  ;Full Thickness Burns
 . I $D(ICD10OR("k"))!($D(ICD10SD("j"))) S ICDRG=$S(ICDMCC>0:928,1:929),ICDFI=1 Q  ;k=Skin Graft  j=Inhalation Injury
 . S ICDRG=934,ICDFI=1 Q
 G:ICDFI EXIT
 I ICDMDC=22,$D(ICD10PD(141)) S ICDRG=935,ICDFI=1 G EXIT ;141=Non-extensive Burns
 I ICDMDC=23,$D(ICD10OR("O")),$D(ICD10PD(119)) S ICDRG=$S(ICDMCC=2:939,ICDMCC=1:940,1:941),ICDFI=1 G EXIT ;O.R. Procedures with 119=Diagnosis of Other Contact with Health Services
 I ICDMDC=23 D
 .I $D(ICD10OR(131)) S ICDRG=$S(ICDMCC>0:945,1:946),ICDFI=1 ;131=Rehabilitation
 .I $D(ICD10PD(299)) S ICDRG=$S(ICDMCC>0:947,1:948),ICDFI=1
 .I $D(ICD10PD(20)) S ICDRG=$S(ICDMCC>0:949,1:950),ICDFI=1
EXIT ;
 I $D(ICD10OR("y")) D
 . I $D(ICD10OR),ICDREL=0 S ICDRG=$S(ICDMCC=2:984,ICDMCC=1:985,1:986),ICDFI=1 Q
 I $D(ICD10OR("z")) D
 . I $D(ICD10OR),ICDREL=0 S ICDRG=$S(ICDMCC=2:987,ICDMCC=1:988,1:989),ICDFI=1 Q
 I ICDFI S ICDFOUND=1
 Q
