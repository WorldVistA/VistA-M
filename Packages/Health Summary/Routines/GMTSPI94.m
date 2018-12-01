GMTSPI94 ;CIO/SLC - Post Install GMTS*2.7*94    ;May 15, 2018@07:50
 ;;2.7;Health Summary;**94**;Oct 20, 1995;Build 41
 Q
CI ; Component Install
 N GMTSIN,GMTSLIM,GMTSINST,GMTSTL,GMTSINST,GMTSTOT,GMTSBLD,GMTSCPS,GMTSCP,GMTSCI
 S GMTSCPS="MRT1;MRT4;MRT5;MRR1"
 F GMTSCI=1:1 Q:'$L($P(GMTSCPS,";",GMTSCI))  D
 . S GMTSCP=$P(GMTSCPS,";",GMTSCI) K GMTSIN
 . D ARRAY Q:'$D(GMTSIN)
 . I $L($G(GMTSIN("TIM"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"TIM")=$G(GMTSIN("TIM"))
 . I $L($G(GMTSIN("OCC"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"OCC")=$G(GMTSIN("OCC"))
 . S GMTSINST=$$ADD^GMTSXPD1(.GMTSIN),GMTSTOT=+($G(GMTSTOT))+($G(GMTSINST))
 ; Rebuild Ad Hoc Health Summary Type
 D:+($G(GMTSTOT))>0 BUILD^GMTSXPD3
 D LIM
 I +$$ROK("GMTSXPS1")>0 D
 . N GMTSHORT S GMTSHORT=1,GMTSINST="",GMTSBLD="GMTS*2.7*94" D SEND^GMTSXPS1
 Q
ARRAY ; Build Array
 K GMTSIN N GMTSI,GMTSTXT,GMTSEX,GMTSFLD,GMTSUB,GMTSVAL,GMTSPDX S GMTSPDX=1,GMTSCP=$G(GMTSCP) Q:'$L(GMTSCP)
 F GMTSI=1:1 D  Q:'$L(GMTSTXT)
 . S GMTSTXT="",GMTSEX="S GMTSTXT=$T("_GMTSCP_"+"_GMTSI_")" X GMTSEX S:$L(GMTSTXT,";")'>3 GMTSTXT="" Q:'$L(GMTSTXT)
 . S GMTSFLD=$P(GMTSTXT,";",2),GMTSUB=$P(GMTSTXT,";",3),GMTSVAL=$P(GMTSTXT,";",4)
 . S:$E(GMTSFLD,1)=1&(+GMTSFLD<2) GMTSVAL=$P(GMTSTXT,";",4,5)
 . S:$E(GMTSFLD,1)=" "!('$L(GMTSFLD)) GMTSTXT="" Q:GMTSTXT=""
 . S:$L(GMTSFLD)&('$L(GMTSUB)) GMTSIN(GMTSFLD)=GMTSVAL Q:$L(GMTSFLD)&('$L(GMTSUB))  S:$L(GMTSFLD)&($L(GMTSUB)) GMTSIN(GMTSFLD,GMTSUB)=GMTSVAL
 . S:$G(GMTSFLD)=7&(+($G(GMTSUB))>0) GMTSPDX=0
 K:+($G(GMTSPDX))=0 GMTSIN("PDX")
 Q
LIM ; Limits
 N GMTSI,GMTST,GMTSO,GMTSA S GMTSI=0 F  S GMTSI=$O(GMTSLIM(GMTSI)) Q:+GMTSI=0  D
 . S GMTSA=$P($G(^GMT(142.1,+($G(GMTSI)),0)),"^",3),GMTST=$G(GMTSLIM(+GMTSI,"TIM")) S:'$L(GMTST) GMTST=$S(GMTSA="Y ":"1Y ",1:"")
 . S GMTSA=$P($G(^GMT(142.1,+($G(GMTSI)),0)),"^",5),GMTSO=$G(GMTSLIM(+GMTSI,"OCC")) S:'$L(GMTSO) GMTSO=$S(GMTSA="Y ":"10 ",1:"")
 . D TO^GMTSXPD3(GMTSI,GMTST,GMTSO)
 Q
ROK(X) ; Routine OK
 S X=$G(X) Q:'$L(X) 0 N GMTSEX,GMTSTXT S GMTSEX="S GMTSTXT=$T(+1^"_X_")" X GMTSEX
 Q:'$L(GMTSTXT) 0  Q 1
 ;
MRT1 ; Med Reconciliation Component Data
 ;0;;258
 ;.01;;Med. Reconciliation (Tool #1)
 ;1;;TOOL1;GMTSPST1
 ;1.1;;0
 ;2;;
 ;3;;MRT1
 ;3.5;;5
 ;3.5;1;This component generates a list of the patient's complete medication
 ;3.5;2;profile, including Outpatient Rx's, Inpatient Medication Orders, Clinic
 ;3.5;3;Orders, Non-VA Medications, and Remote Active Medications.  It is sorted
 ;3.5;4;alphabetically by drug name, creating groups of outpatient/inpatient
 ;3.5;5;orders for the same item in order to facilitate medication reconciliation.
 ;4;;
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;Med Reconciliation
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 ;
 Q
 ;
MRT4 ; Remote Active Meds (Tool #4) Component Data
 ;0;;261
 ;.01;;Remote Active Meds (Tool #4)
 ;1;;ENHS;GMTSPST4
 ;1.1;;0
 ;2;;
 ;3;;MRT4
 ;3.5;;2
 ;3.5;1;This component will display the details of a patient's remote active
 ;3.5;2;outpatient medications using data from the Health Data Repository.
 ;4;;
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 ;
 Q
 ;
MRT5 ; Allergies/ADRs Component Data
 ;0;;262
 ;.01;;Allergies/ADRs (Tool #5)
 ;1;;ENHS;GMTSPST5
 ;1.1;;0
 ;2;;
 ;3;;MRT5
 ;3.5;;4
 ;3.5;1;This component displays local facility and remote facility allergy and
 ;3.5;2;adverse data information using the Remote Data Interoperability features
 ;3.5;3;of the Health Data Repository.  Data from the local facility is merged
 ;3.5;4;into a single table with remote facility allergy/adverse reaction data.
 ;4;;
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;Allergies/ADRs
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 ;
 Q
 ;
MRR1 ; Med Reconciliation Component Data
 ;0;;267
 ;.01;;Med Recon NoGlossary (Tool #1)
 ;1;;TOOL1;GMTSPSTN
 ;1.1;;0
 ;2;;
 ;3;;MRR1
 ;3.5;;5
 ;3.5;1;This component generates a list of the patient's complete medication
 ;3.5;2;profile, including Outpatient Rx's, Inpatient Medication Orders, Clinic
 ;3.5;3;Orders, Non-VA Medications, and Remote Active Medications.  It is sorted
 ;3.5;4;alphabetically by drug name, creating groups of outpatient/inpatient
 ;3.5;5;orders for the same item in order to facilitate medication reconciliation.
 ;4;;
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;Med Reconciliation
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 ;
 Q
 ;
