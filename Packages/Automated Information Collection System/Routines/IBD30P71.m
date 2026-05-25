IBD30P71 ;MNTVBB/KXL - UPDATE TYPE OF VISIT FILE ; 03/14/2025
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**71**;APR 24, 1997;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to FILE^DICN in ICR #10009
 ; Reference to ^DIE in ICR #10018
 ; Reference to FMADD^XLFDT in ICR #10103
 ; Reference to MES^XPDUTL in ICR #10141
 ;
 Q
 ;
EN ; Backup 357.69 Type of Visit File
 N I71FILE,I71FILES,IBCNT
 S I71FILE=""
 S I71FILES="357.69"
 S IBCNT=0
 F IBCNT=1:1:$L(I71FILES,"^") D
 . S I71FILE=$P(I71FILES,"^",IBCNT)
 . D GLBBKUP
 . Q
 ; Begin Update
 D POST
 Q
 ;
POST ; Update Type of Visit Codes
 N IBA,U S U="^"
 D MSG("IBD*3.0*71 Post-Install starts.....")
 D UPD35769
 D MSG("IBD*3.0*71 Post-Install is complete.")
 Q
 ;
UPD35769 ;update type of visit codes to file (#357.69)
 N DLAYGO,DINUM,DIC,DA,DR,DIE,X,Y,IBA,IBEX,IBU,IBX,IBT,IBCODE,IBCM,IBTXT,IBTXT2,IBHD,IBNECO
 S (IBA,IBEX,IBU)=0
 F IBX=1:1 S IBT=$P($T(NCODE+IBX),";",3) Q:'$L(IBT)  D
 . S IBCODE=$P(IBT,U,1)
 . S IBTXT=$P(IBT,U,2),IBTXT2=IBCODE_" "_IBTXT
 . S IBNECO=$P(IBT,U,3)
 . S IBHD=$P(IBT,U,4)
 . I $D(^IBE(357.69,IBCODE,0)) D  Q
 .. ;If exists and update code header is null, quit and don't update
 .. I IBHD="" S IBEX=IBEX+1 D MES^XPDUTL("  >>> "_IBTXT2_" - exists") Q
 .. S IBCM=IBCODE_U_IBHD_U_IBTXT_U_U_IBNECO
 .. I $G(^IBE(357.69,IBCODE,0))=IBCM S IBEX=IBEX+1 D MES^XPDUTL("  >>> "_IBTXT2_" - exists") Q
 .. S DA=+IBCODE,DIE="^IBE(357.69,",DR=".02///"_IBHD_";.03///"_IBTXT_";.05///"_IBNECO D ^DIE
 .. S IBU=IBU+1 D MSG("  >>> Updating "_IBTXT2)
 . ;
 . ; add a new entry if not exist
 . S (X,DINUM)=+IBCODE,DLAYGO=357.69,DIC="^IBE(357.69,",DIC(0)="L"
 . S DIC("DR")=".02///"_IBHD_";.03///"_IBTXT_";.05///"_IBNECO D FILE^DICN
 . I Y<1 D MSG("  >>> ERROR when adding "_IBCODE_" to the Type ofVisit file, Log a Remedy ticket!") Q
 . S IBA=IBA+1 D MSG("  >>> Adding "_IBTXT2)
 D MSG("")
 D MSG(" Total "_IBA_$S(IBA=1:" entry",1:" entries")_" added and "_IBU_$S(IBU=1:" entry",1:" entries")_" updated in the file #357.69")
 D MSG(" "_IBEX_$S(IBEX=1:" entry",1:" entries")_" had no changes")
 D MSG("")
 Q
 ;
MSG(IBA) ;
 D MES^XPDUTL(IBA)
 Q
 ;
GLBBKUP  ; XTMP Backup of file(s)
 N IBBKNDE
 S IBBKNDE="IBD*3.0*71-TYPE OF VISIT file updates (#357.69)"
 S ^XTMP("IBD30P71",0)=$$FMADD^XLFDT(DT,120)_"^"_DT_"^"_IBBKNDE
 M ^XTMP("IBD30P71",I71FILE,$H)=^IBE(I71FILE)
 Q
 ;
 ; type of visit codes - 133
NCODE ;;code^recommended text^new(1)/established(2)/consult(3)/other(9)^recommended header
 ;;98000^^^
 ;;98001^^^
 ;;98002^^^
 ;;98003^^^
 ;;98004^^^
 ;;98005^^^
 ;;98006^^^
 ;;98007^^^
 ;;98008^^^
 ;;98009^^^
 ;;98010^^^
 ;;98011^^^
 ;;98012^^^
 ;;98013^^^
 ;;98014^^^
 ;;98015^^^
 ;;98016^^^
 ;;98960^^^
 ;;98961^^^
 ;;98962^^^
 ;;98966^^^
 ;;98967^^^
 ;;98968^^^
 ;;98970^^^
 ;;98971^^^
 ;;98972^^^
 ;;98975^^^
 ;;98976^^^
 ;;98977^^^
 ;;98978^^^
 ;;99000^^^
 ;;99001^^^
 ;;99002^^^
 ;;99026^^^
 ;;99027^^^
 ;;99051^^^
 ;;99053^^^
 ;;99060^^^
 ;;99070^^^
 ;;99071^^^
 ;;99075^^^
 ;;99078^^^
 ;;99080^^^
 ;;99082^^^
 ;;99091^^^
 ;;99415^^^
 ;;99416^^^
 ;;99417^^^
 ;;99421^^^
 ;;99422^^^
 ;;99423^^^
 ;;99439^^^
 ;;99446^^^
 ;;99447^^^
 ;;99448^^^
 ;;99449^^^
 ;;99451^^^
 ;;99452^^^
 ;;99453^^^
 ;;99454^^^
 ;;99457^^^
 ;;99458^^^
 ;;99459^^^
 ;;99473^^^
 ;;99474^^^
 ;;99483^^^
 ;;99484^^^
 ;;99490^^^
 ;;99491^^^
 ;;99492^^^
 ;;99493^^^
 ;;99494^^^
 ;;99497^^^
 ;;99498^^^
 ;;99500^^^
 ;;99501^^^
 ;;99502^^^
 ;;99503^^^
 ;;99504^^^
 ;;99505^^^
 ;;99506^^^
 ;;99507^^^
 ;;99509^^^
 ;;99510^^^
 ;;99511^^^
 ;;99512^^^
 ;;99600^^^
 ;;99601^^^
 ;;99602^^^
 ;;99605^^^
 ;;99606^^^
 ;;99607^^^
 ;;77425^Weekly Radiation Therapy^9^Radiation Therapy
 ;;77431^Radiation Therapy Management^9^Radiation Therapy
 ;;77432^Stereotactic Radiation Trmt^9^Radiation Therapy
 ;;90845^Medical Psychoanalysis^9^Psychiatry
 ;;90847^Special Family Therapy^9^Psychiatry
 ;;90849^Special Family Therapy^9^Psychiatry
 ;;90853^Special Group Therapy^9^Psychiatry
 ;;92002^Eye Exam, New Patient^1^Eye
 ;;92004^Eye Exam, New Patient^1^Eye
 ;;92012^Eye Exam, Established Patient^2^Eye
 ;;92014^Eye Exam, Established Patient^2^Eye
 ;;99024^Post-Op Follow-up Visit^9^Post-op
 ;;99050^Post-Op Follow-up Visit^9^Post-Op
 ;;99056^Non-Office Medical Services^9^Other
 ;;99058^Office Emergency Care^9^Other
 ;;99202^Limited Exam (16-25 Min)^1^NEW PATIENT
 ;;99203^Intermediate Exam (26-35 Min)^1^NEW PATIENT
 ;;99204^Extended Exam (36-50 Min)^1^NEW PATIENT
 ;;99205^Comprehensive Exam (51-60+ Min)^1^NEW PATIENT
 ;;99211^Brief Exam (1-5 Min)^2^ESTABLISHED PATIENT
 ;;99212^Limited Exam (6-10 Min)^2^ESTABLISHED PATIENT
 ;;99213^Intermediate Exam (11-19 Min)^2^ESTABLISHED PATIENT
 ;;99214^Extended Exam (20-30 Min)^2^ESTABLISHED PATIENT
 ;;99215^Comprehensive Exam (31-40+ Min)^2^ESTABLISHED PATIENT
 ;;99221^Brief Admission Care (1-30 Min)^9^Hospital Admission
 ;;99222^Intermediate Admit Care (31-50 Min)^9^Hospital Admission
 ;;99223^Comprehensive Admit Care (51-70 Min)^9^Hospital Admission
 ;;99231^Brief Hosp. Care (1-15 Min)^9^Subsequent Hospital Care
 ;;99232^Intermediate Hosp. Care (16-25 Min)^9^Subsequent Hospital Care
 ;;99233^Comprehensive Hosp. Care (26-35 Min)^9^Subsequent Hospital Care
 ;;99234^Detailed Observ or Inpt hospital care^9^DET OBSERV/HOSP SAME DATE
 ;;99235^Comp Observ or Inpt hospital care^9^COMP OBSERV/HOSP SAME DATE
 ;;99236^Hi Comp Observ or Inpt hospital care^9^HI COMP OBSERV/HOSP SAME DATE
 ;;99238^Discharge Day Mgmt.^9^Hospital Discharge
 ;;99239^Hospital D/C Day Mgmt->30 min^2^Hospital D/C Svc->30 MIN
 ;;99242^Limited Exam (21-35 Min)^3^CONSULT
 ;;99243^Intermediate Exam (36-50 Min)^3^CONSULT
 ;;99244^Extended Exam (51-60 Min)^3^CONSULT
 ;;99245^Comprehensive Exam (71-80+ Min)^3^CONSULT
 ;;99252^Limited Exam (21-40 Min)^3^Initial Inpatient Consult
 ;;99253^Intermediate Exam (41-55 Min)^3^Initial Inpatient Consult
 ;;99254^Extended Exam (56-80 Min)^3^Initial Inpatient Consult
 ;;99255^Comprehensive Exam (81-110 Min)^3^Initial Inpatient Consult
 ;;99281^Brief Exam^9^Emergency Room Visit
 ;;99282^Limited Exam^9^Emergency Room Visit
 ;;99283^Intermediate Exam^9^Emergency Room Visit
 ;;99284^Extended Exam^9^Emergency Room Visit
 ;;99285^Comprehensive Exam^9^Emergency Room Visit
 ;;99288^Advanced Life Support^9^Emergency Room Visit
 ;;99291^First Hour^9^Critical Care
 ;;99292^Each Additional 30 Min.^9^Critical Care
 ;;99304^Initial Nursing Facility Care-Detailed^1^Init Nurs Fac Care-Detailed
 ;;99305^Initial Nursing Facility Care-Comp^1^Init Nurs Fac Care-Comp
 ;;99306^Initial Nursing Facility Care-Hi Comp^1^Init Nurs Fac Care-Hi Comp
 ;;99307^Subseq Nursing Facility Care-Prob Focus^2^SUBSEQ Nurs Fac Care-Prob Foc
 ;;99308^Subseq Nurs Facility Care-Ex Prob Focus^2^SUBSEQ NURS FAC CARE-EXP PF
 ;;99309^Subseq Nursing Facility Care-Detailed^2^SUBSEQ NURS FAC CARE-DET
 ;;99310^Subseq Nursing Facility Care-Comp^2^SUBSEQ Nurs Fac Care-COMP
 ;;99315^Nursing Facility D/C Day Mgmt-30 min^9^NURS FAC D/C Svc-30 MIN
 ;;99316^Nursing Facility D/C Day Mgmt->30 min^9^NURS FAC D/C Svc->30 MIN
 ;;99341^Low Severity Problem^1^Home Visit, New Patient
 ;;99342^Moderate Severity Problem^1^Home Visit, New Patient
 ;;99344^Home Visit,New Pt,Comp Mod Complex^1^Home
 ;;99345^Home Visit,New Pt,Comp High Complex^1^Home
 ;;99347^Home Visit-Problem Focused^2^Home
 ;;99348^Home Visit-Expanded Problem Focused^2^Home
 ;;99349^Home Visit-Detailed^2^Home
 ;;99350^Home Visit,Est Pt,Mod Complex^2^Home
 ;;99358^First Hour^9^Prolonged Service w/o Contact
 ;;99359^Additional 30 Min^9^Prolonged Service w/o Contact
 ;;99360^Each 30 Min.^9^Physician Standby Services
 ;;99366^Team Conf,HCP,Pt Present,> 29 Min^9^TeamConf_Non-Physician w/pt
 ;;99367^Team Conf,Phys,Pt Not Present,> 29 Min^9^TeamConf w/o pt
 ;;99368^Team Conf,HCP,Pt Not Present,> 29 Min^9^TeamConf_Non-Physician w/o pt
 ;;99374^Care Plan Svc,Home Hlth,15-29 Min^9^Plan Oversight
 ;;99375^30-60 minutes^9^Care Plan Oversight
 ;;99377^Care Plan Oversight-Hospice^2^Care Plan Oversight-HOSPICE
 ;;99378^Care Plan Oversight-Nursing Facility^2^Care Plan Oversight-NURS FAC
 ;;99379^Care Plan Svc,Nurs Fac,15-29 Min^9^Plan Oversight
 ;;99380^Care Plan Svc,Nurs Fac,> 29 Min^9^Plan Oversight
 ;;99381^Infant Under 1 year^1^Preventive Care, New Patient
 ;;99382^Age 1-4^1^Preventive Care, New Patient
 ;;99383^Age 5-11^1^Preventive Care, New Patient
 ;;99384^Age 12-17^1^Preventive Care, New Patient
 ;;99385^Age 18-39^1^Preventive Care, New Patient
 ;;99386^Age 40-64^1^Preventive Care, New Patient
 ;;99387^Age 65 and over^1^Preventive Care, New Patient
 ;;99391^Infant Under 1 year^2^Preventive Visit, Est. Patient
 ;;99392^Age 1-4^2^Preventive Visit, Est. Patient
 ;;99393^Age 5-11^2^Preventive Visit, Est. Patient
 ;;99394^Age 12-17^2^Preventive Visit, Est. Patient
 ;;99395^Age 18-39^2^Preventive Visit, Est. Patient
 ;;99396^Age 40-64^2^Preventive Visit, Est. Patient
 ;;99397^Age 65 and over^2^Preventive Visit, Est. Patient
 ;;99401^Brief (15 min)^9^Individual Preventive Counsel
 ;;99402^Intermediate (30 Min)^9^Individual Preventive Counsel
 ;;99403^Extended (45 Min)^9^Individual Preventive Counsel
 ;;99404^Comprehensive (60 Min)^9^Individual Preventive Counsel
 ;;99406^Tobacco Cessation Counseling,3-10 Min^9^Counseling
 ;;99407^Tobacco Cessation Counseling > 10 Min^9^Counseling
 ;;99408^Alc/Subs Abuse Counseling,15-30 Min^9^Counseling
 ;;99409^Alc/Subs Abuse Counseling > 30 Min^9^Counseling
 ;;99411^Brief (30 Min)^9^Group Preventive Counseling
 ;;99412^Intermediate (60 Min)^9^Group Preventive Counseling
 ;;99429^Preventive Medicine^9^Unlisted Services
 ;;99450^Life/Health Insurance Exam^9^Life/Health Insurance Exam
 ;;99455^By treating physician^9^Disability Exam
 ;;99456^By other than treating physician^9^Disability Exam
 ;;99460^Newborn Care Svc,Init,Per Day,Hosp^1^Newborn Care
 ;;99461^Newborn Care Svc,Init,Per Day,Not Hosp^1^Newborn Care
 ;;99462^Newborn Care Svc,Subsq,Per Day,Hosp^2^Newborn Care
 ;;99463^Newborn Care Svc,Init,Adm/DC Same Day^1^Newborn Care
 ;;99464^Attendance at Delivery^9^delivery
 ;;99465^Delivery/Birthing Room Resuscitation^9^delivery
 ;;99466^Crit Care Intrfac Trf,0-24 Mon,30-74 Min^9^CCU Peds
 ;;99467^Critcare Intrfac Trf,0-24 Mon,Add 30 Min^9^CCU Peds
 ;;99468^Init Neontl Crit Care,0-28 days^1^NeoNate CCU
 ;;99469^Subsq Neontl Crit Care,0-28 days^2^NeoNate CCU
 ;;99471^Init Ped Crit Care,29 days-24 Months^1^Peds CCU
 ;;99472^Subsq Ped Crit Care,29 days-24 Months^2^Peds CCU
 ;;99475^Init Ped Crit Care,2-5 years^1^Peds CCU
 ;;99476^Subsq Ped Crit Care,2-5 years^2^Peds CCU
 ;;99477^Init Hosp Care,Per Day,0-28 days^1^HospCareNeoNate
 ;;99478^Subsq Int Care,Per Day,Low Brth Wgt Inf^2^NeoNate ICU
 ;;99479^Subsq Int Care,Per Day,Low Brth Wgt Inf^2^NeoNate ICU
 ;;99480^Subsq Int Care,Per Day,Low Brth Wgt Inf^2^NeoNate ICU
 ;;99485^Phys Supvsn Intrfac Trf,0-24 Mon,30 Min^9^transfer Peds
 ;;99486^Phy Svsn Intrfac Trf,0-24 Mon,Add 30 Min^9^transfer Peds
 ;;99487^Comp Chr Care Coor,No FTF,Per Calr Month^9^CareCoord NF2F
 ;;99489^Comp Chr Care Coor,FTF,Ea Addl 30 Min^9^CareCoord F2F
 ;;99495^Trans Care Mgmt Svc,FTF w/in 14 days D/C^9^TransCare F2F
 ;;99496^Trans Care Mgmt Svc,FTF w/in 7 days D/C^9^TransCare F2F
 ;;99499^Evaluation and Management^9^Unlisted Services
 ;
