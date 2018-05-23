IB20P478 ;ALB/RDK - IB*2.0*478; TYPE OF VISIT UPDATE ; 6/13/12 10:44am
 ;;2.0;INTEGRATED BILLING;**478**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
EN ;
 N Y,IBC,IBT,IBX,CODE,HDR,TEXT,INACT,NEC,NCODE,NHDR,NTEXT,NINACT,NNEC,OCODE,OHDR,OTEXT,OINACT,ONEC,DA,DR,DIE
 D START,GETCODE,FINISH
 Q
 ;
START D BMES^XPDUTL("Type of Visit Codes, Post-Install Starting")
 Q
 ;
FINISH D BMES^XPDUTL("Type of Visit Codes, Post-Install Complete")
 Q
 ;
 ;
GETCODE ; get codes to add to table
 S IBC=0
 D BMES^XPDUTL("   NOTE: If a Type of Visit Code already exists in file 357.69")
 D BMES^XPDUTL("   values approved for national release will replace current values.")
 D BMES^XPDUTL(" Adding or Updating type of visit codes to file 357.69")
 F IBX=1:1 S IBT=$P($T(NCODE+IBX),";",3) Q:'$L(IBT)  D
 . S CODE=+$P(IBT,U)
 . S HDR=$P(IBT,U,2)
 . S TEXT=$P(IBT,U,3)
 . S INACT=$P(IBT,U,4)
 . S NEC=$P(IBT,U,5)
 . I $D(^IBE(357.69,CODE,0)) S Y=+$$UPD35769(CODE,HDR,TEXT,INACT,NEC) S:Y>0 IBC=IBC+1 Q
 . S Y=+$$ADD35769(CODE,HDR,TEXT,INACT,NEC) S:Y>0 IBC=IBC+1
 D BMES^XPDUTL("     "_IBC_$S(IBC=1:" entry",1:" entries")_" added or updated in file 357.69")
 Q
 ;
ADD35769(NCODE,NHDR,NTEXT,NINACT,NNEC) ;
 ;add a new entry into file <#357.69>
 N X,DLAYGO,DINUM,DIC
 S DLAYGO="357.69",(X,DINUM)=NCODE,DIC="^IBE(357.69,",DIC(0)="KLM"
 S DIC("DR")=".02///^S X=NHDR;.03///^S X=NTEXT;.04///^S X=NINACT;.05///^S X=NNEC"
 D ^DIC
 I (+Y=-1) D BMES^XPDUTL("*** ERROR ON CODE "_NCODE_" ***") Q (+Y)
 I (+Y=NCODE) D BMES^XPDUTL("   Adding  "_NCODE_"  "_NTEXT)
 Q (+Y)
 ;
UPD35769(OCODE,OHDR,OTEXT,OINACT,ONEC) ;
 ;update an existing entry in file <#357.69>
 S:OINACT="" OINACT="@" ; If inactive flag is supposed to be null make sure that field is nulled out in the existing record.
 S DIE="^IBE(357.69,",DA=OCODE,DR=".02///^S X=OHDR;.03///^S X=OTEXT;.04///^S X=OINACT;.05///^S X=ONEC"
 D ^DIE
 S Y=0 I $P(^IBE(357.69,OCODE,0),U,3)=OTEXT S Y=1 D BMES^XPDUTL("   Update  "_OCODE_"  "_OTEXT)
 Q (+Y)
 ;type of visit codes to load into file (#357.69)
NCODE ;;code^header^text^inactive flag^new/established/consult flag (nec)
 ;;99234^DET OBSERV/HOSP SAME DATE^Detailed Observ or Inpt hospital care^^9
 ;;99235^COMP OBSERV/HOSP SAME DATE^Comp Observ or Inpt hospital care^^9
 ;;99236^HI COMP OBSERV/HOSP SAME DATE^Hi Comp Observ or Inpt hospital care^^9
 ;;99239^Hospital D/C Svc->30 MIN^Hospital D/C Day Mgmt->30 min^^2
 ;;99304^Init Nurs Fac Care-Detailed^Initial Nursing Facility Care-Detailed^^1
 ;;99305^Init Nurs Fac Care-Comp^Initial Nursing Facility Care-Comp^^1
 ;;99306^Init Nurs Fac Care-Hi Comp^Initial Nursing Facility Care-Hi Comp^^1
 ;;99307^SUBSEQ Nurs Fac Care-Prob Foc^Subseq Nursing Facility Care-Prob Focus^^2
 ;;99308^SUBSEQ NURS FAC CARE-EXP PF^Subseq Nurs Facility Care-Ex Prob Focus^^2
 ;;99309^SUBSEQ NURS FAC CARE-DET^Subseq Nursing Facility Care-Detailed ^^2
 ;;99310^SUBSEQ Nurs Fac Care-COMP^Subseq Nursing Facility Care-Comp^^2
 ;;99315^NURS FAC D/C Svc-30 MIN^Nursing Facility D/C Day Mgmt-30 min^^9
 ;;99316^NURS FAC D/C Svc->30 MIN^Nursing Facility D/C Day Mgmt->30 min^^9
 ;;99318^Nurs Fac Svc-ANNUAL ASSESS^Nursing Facility Care-Annual Assessment^^2
 ;;99377^Care Plan Oversight-HOSPICE^Care Plan Oversight-Hospice^^2
 ;;99378^Care Plan Oversight-NURS FAC^Care Plan Oversight-Nursing Facility^^2
 ;
