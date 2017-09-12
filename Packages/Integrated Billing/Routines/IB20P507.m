IB20P507 ;ALB/CXW - IB*2.0*507; TYPE OF VISIT UPDATES; 07/29/13
 ;;2.0;INTEGRATED BILLING;**507**;21-MAR-94;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
POST ;
 S U="^"
 D MES^XPDUTL("Type of Visit Codes, Patch Post-Install starts...")
 D UPD35769
 D MES^XPDUTL("Type of Visit Codes, Patch Post-Install is complete.")
 Q
 ;
UPD35769 ;update type of visit codes to file (#357.69)
 N DLAYGO,DINUM,DIC,DA,DR,DIE,X,Y,IBA,IBU,IBX,IBT,IBCODE,IBCM,IBTXT,IBTXT2,IBHD,IBNECO
 S (IBA,IBU)=0
 F IBX=1:1 S IBT=$P($T(NCODE+IBX),";",3) Q:'$L(IBT)  D
 . S IBCODE=$P(IBT,U,1)
 . S IBTXT=$P(IBT,U,2),IBTXT2=IBCODE_" "_IBTXT
 . S IBNECO=$P(IBT,U,3)
 . S IBHD=$P(IBT,U,4)
 . I $D(^IBE(357.69,IBCODE,0)) D  Q
 .. S IBCM=IBCODE_U_IBHD_U_IBTXT_U_U_IBNECO
 .. I $G(^IBE(357.69,IBCODE,0))=IBCM D MES^XPDUTL("  >>> "_IBTXT2_" - exists") Q
 .. S DA=+IBCODE,DIE="^IBE(357.69,",DR=".02///"_IBHD_";.03///"_IBTXT_";.05///"_IBNECO D ^DIE
 .. S IBU=IBU+1 D MES^XPDUTL("  >>> Updating "_IBTXT2)
 . ;
 . ; add a new entry if not exist
 . S (X,DINUM)=+IBCODE,DLAYGO=357.69,DIC="^IBE(357.69,",DIC(0)="L"
 . S DIC("DR")=".02///"_IBHD_";.03///"_IBTXT_";.05///"_IBNECO D FILE^DICN
 . I Y<1 D MES^XPDUTL("  >>> ERROR when adding "_IBCODE_" to the Type ofVisit file, Log a Remedy ticket!") Q
 . S IBA=IBA+1 D MES^XPDUTL("  >>> Adding "_IBTXT2)
 D BMES^XPDUTL(" Total "_IBA_$S(IBA=1:" entry",1:" entries")_" added and "_IBU_$S(IBU=1:" entry",1:" entries")_" updated in the file #357.69")
 Q
 ;
 ; type of visit codes - 57
NCODE ;;code^recommended text^new(1)/established(2)/consult(3)/other(9)^recommended header
 ;;99224^Subsq Observation Care-Prob Focused^2^Observation
 ;;99225^Subsq Observation Care-Exp Prob Focused^2^Observation
 ;;99226^Subsequent Observation Care - Detailed^2^Observation
 ;;99324^Domiciliary Visit-Problem Focused^1^Domiciliary
 ;;99325^Dom Visit-New Pt,Exp Prob Focused^1^Domiciliary
 ;;99326^Domiciliary Visit-Detailed^1^Domiciliary
 ;;99327^Dom Visit-New Pt,Comp,Mod Complex^1^Domiciliary
 ;;99328^Dom Visit-New Pt,Comp,High Complex^1^Domiciliary
 ;;99334^Domiciliary Visit-Problem Focused^2^Domiciliary
 ;;99335^Dom Visit-Est Pt,Exp Prob Focused^2^Domiciliary
 ;;99336^Domiciliary Visit-Detailed^2^Domiciliary
 ;;99337^Dom Visit-Est Pt,Comp,Mod Complex^2^Domiciliary
 ;;99339^Phys Suprv Dom Pt,15-29 Min^9^Domiciliary
 ;;99340^Phys Suprv Dom Pt,> 29 Min^9^Domiciliary
 ;;99344^Home Visit,New Pt,Comp Mod Complex^1^Home
 ;;99345^Home Visit,New Pt,Comp High Complex^1^Home
 ;;99347^Home Visit-Problem Focused^2^Home
 ;;99348^Home Visit-Expanded Problem Focused^2^Home
 ;;99349^Home Visit-Detailed^2^Home
 ;;99350^Home Visit,Est Pt,Mod Complex^2^Home
 ;;99363^Anticoag Mgmt,Init 90 day of tx^9^MedMgmt
 ;;99364^Anticoag Mgmt,Each Subseqt 90 day of tx^9^MedMgmt
 ;;99366^Team Conf,HCP,Pt Present,> 29 Min^9^TeamConf_Non-Physician w/pt
 ;;99367^Team Conf,Phys,Pt Not Present,> 29 Min^9^TeamConf w/o pt
 ;;99368^Team Conf,HCP,Pt Not Present,> 29 Min^9^TeamConf_Non-Physician w/o pt
 ;;99374^Care Plan Svc,Home Hlth,15-29 Min^9^Plan Oversight
 ;;99379^Care Plan Svc,Nurs Fac,15-29 Min^9^Plan Oversight
 ;;99380^Care Plan Svc,Nurs Fac,> 29 Min^9^Plan Oversight
 ;;99406^Tobacco Cessation Counseling,3-10 Min^9^Counseling
 ;;99407^Tobacco Cessation Counseling > 10 Min^9^Counseling
 ;;99408^Alc/Subs Abuse Counseling,15-30 Min^9^Counseling
 ;;99409^Alc/Subs Abuse Counseling > 30 Min^9^Counseling
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
 ;;99488^Comp Chr Care Coor,FTF,Per Calr Month^9^CareCoord F2F
 ;;99489^Comp Chr Care Coor,FTF,Ea Addl 30 Min^9^CareCoord F2F
 ;;99495^Trans Care Mgmt Svc,FTF w/in 14 days D/C^9^TransCare F2F
 ;;99496^Trans Care Mgmt Svc,FTF w/in 7 days D/C^9^TransCare F2F
 ;
