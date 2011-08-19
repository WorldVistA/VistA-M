PRCHLO1A ;WOIFO/RLL-EXTRACT ROUTINE (cont.)CLO REPORT SERVER ;5/22/09  14:11
 ;;5.1;IFCAP;**83,130**;Oct 20, 2000;Build 25
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ; DBIA 10093 - Read file 49 via FileMan.
 ; Continuation of PRCHLO1. This program builds the extracts for
 ; the Master PO Table and the associated multiples
POMAST ; PoMaster Table
 Q
PODISCW ; Write PO Discount table data
 N GPOID,GPOND
 S GPOID=0,GPOND=""
 F  S GPOID=$O(^TMP($J,"PODISC",GPOID)) Q:GPOID=""  D
 . F  S GPOND=$O(^TMP($J,"PODISC",GPOID,GPOND)) Q:GPOND=""  D
 . . W $G(^TMP($J,"PODISC",GPOID,GPOND))
 . . W !
 . . Q
 . Q
 W !
 Q
PODISC ;
 ;PoDiscount Table 442.03A (multiple)
 ; ^PRC(442,POID,3,0)=^442.03A
 N CKDS,PPO,PPOVAL,CKDS1,V1,V2,V3,V4,V5,V6
 S CKDS=$G(^PRC(442,POID,3,0)),PPO=0
 S CKDS1=$P(CKDS,U,3)
 I +CKDS1>0  D  ; Contains at least one discount, create rec.
 . D LPPODIS
 . Q
 Q
PO2237 ; 2237RefNum Table
 N CK2237,PPO,PPOVAL,CK2237A,PPV4E1,PPV4E2
 S CK2237=$G(^PRC(442,POID,13,0)),PPO=0
 S CK2237A=$P(CK2237,U,3)
 I +CK2237A>0  D  ; Contains at least one 2237#, create rec
 . D LP2237
 Q
POBOC ; PoBoc Table
 N CKBS,PPO,PPOVAL,PPOVAL1,CKBS1
 S CKBS=$G(^PRC(442,POID,22,0)),PPO=0
 S CKBS1=$P(CKBS,U,3)
 I +CKBS1>0  D  ; Contains at lease one BOC, create rec.
 . D LPPOBC
 Q
POAMT ; PO Amount table (multiple)
 N POAMT,POAMT1,POAMT2,POAMT3,POAMT4,V1,V2,V3
 N V1E,V1E1,V1E2,V2E,V2E1,V2E2,VE,VE1,VE2
 S POAMT=$G(^PRC(442,POID,9,0))
 S POAMT1=$P(POAMT,U,3)
 I +POAMT1>0  D
 . S POAMT2=0
 . F  S POAMT2=$O(^PRC(442,POID,9,POAMT2)) Q:POAMT2=""  D
 . . Q:+POAMT2<0
 . . S POAMT3=$G(^PRC(442,POID,9,POAMT2,0))
 . . Q:POAMT3=""
 . . ; For V1-V3, Get the node, $P the data, pad with "^" delimiters
 . . ; get external value for TypeCode
 . . S VE=$P(POAMT3,U,2)
 . . I VE'="" S VE1=$G(^PRCD(420.6,+VE,0)),VE2=$P(VE1,U,1)
 . . I VE="" S VE2=""
 . . ; get external value for CompStatus Business
 . . S V1E=$P(POAMT3,U,4)
 . . I V1E'="" S V1E1=$G(^PRCD(420.6,+V1E,0)),V1E2=$P(V1E1,U,1)
 . . I V1E="" S V1E2=""
 . . ;
 . . S V1=$P(POAMT3,U,1)_U_VE2_U_V1E2_U
 . . ; Get external value for PrefProgram
 . . S V2E=$P(POAMT3,U,5)
 . . I V2E'="" S V2E1=$G(^PRCD(420.6,+V2E,0)),V2E2=$P(V2E1,U,1)
 . . I V2E="" S V2E2=""
 . . S V2=V2E2_U_$P(POAMT3,U,3),V3=V1_V2
 . . S POAMT4=PPOKEY_U_POAMT2_U_V3
 . . I +POAMT2>0 S ^TMP($J,"POAMT",POID,POAMT2,0)=POAMT4
 . . D PAMBCD  ; Po Amount Breakout code
 . . Q
 . Q
 Q
PAMBCD ; PO Amount Breakout code
 N PAMBC,PAMBC1,PAMBC2,PAMBC3,PAMBC4,VBCE,VBCE1,VBCE2
 S PAMBC=0,PAMBC1=0,PAMBC2=0,PAMBC3=0
 S PAMBC=$G(^PRC(442,POID,9,POAMT2,1,0))
 S PAMBC1=$P(PAMBC,U,3)
 I +PAMBC1>0  D
 . F  S PAMBC2=$O(^PRC(442,POID,9,POAMT2,1,PAMBC2)) Q:PAMBC2=""  D
 . . Q:+PAMBC2<0
 . . S PAMBC3=$G(^PRC(442,POID,9,POAMT2,1,PAMBC2,0))
 . . ;
 . . ; get external value for breakout code
 . . S VBCE=$P(PAMBC3,U,1)
 . . I VBCE'="" S VBCE1=$G(^PRCD(420.6,+VBCE,0)),VBCE2=$P(VBCE1,U,1)
 . . I VBCE="" S VBCE2=""
 . . S PAMBC4=PPOKEY_U_POAMT2_U_PAMBC2_U_VBCE2
 . . I +PAMBC2>0 S ^TMP($J,"POBKCOD",POID,POAMT2,PAMBC2,0)=PAMBC4
 . . Q
 . Q
 Q
POAMMD ; PO Amendment Table (multiple)
 N POAMD,POAMD1,POAMD2,POAMD3,POAMD3A,POAMD4,V1,V2,V3,V2E,V2E1,V2E2
 N V3E,V3E1,V3E2,V1E,V1E1,V1E2,VL6,VL7,VL8,VL9
 S POAMD=$G(^PRC(442,POID,6,0))
 S POAMD1=$P(POAMD,U,3)
 S POAMD2=0
 F  S POAMD2=$O(^PRC(442,POID,6,POAMD2)) Q:+POAMD2'>0  D
 . S POAMD3=$G(^PRC(442,POID,6,POAMD2,0))
 . S POAMD3A=$G(^PRC(442,POID,6,POAMD2,1))
 . ; V1-V3, $Get the data, $P the values, pad with "^" delimiters
 . ; get external date for EffectiveDate
 . S V1E=$P(POAMD3,U,2),V1E1=$P(V1E,".",1)
 . I V1E'="" S V1E2=$$FMTE^XLFDT(V1E1)
 . I V1E="" S V1E2=""
 . S V1=$P(POAMD3,U,1)_U_V1E2_U_$P(POAMD3,U,3)_U
 . ; get external value for pAPPMaUthorizedBuyer
 . S V2E=$P(POAMD3A,U,1)
 . I V2E'="" S V2E1=$G(^VA(200,+V2E,0)),V2E2=$P(V2E1,U,1)
 . I V2E="" S V2E2=""
 . S VL8=$P($G(^VA(200,+V2E,5)),U)           ;SERVICE - pAPPMaUthorizedBuyer
 . S VL9=$S(VL8="":"",1:$$GET1^DIQ(49,+VL8_",",.01))  ;SVC ext - pAPPMaUthorizedBuyer
 . ; get external value for AmendmentAdjustment
 . S V3E=$P(POAMD3A,U,4)
 . I V3E'="" S V3E1=$G(^PRCD(442.3,+V3E,0)),V3E2=$P(V3E1,U,1)
 . I V3E="" S V3E2=""
 . S VL6=$P(POAMD3A,U,5),VL7=$P($G(^VA(200,+VL6,0)),U)  ;Fiscal Approv
 . S V2=V2E2_U_V3E2,V3=V1_V2_U_V2E_U_VL6_U_VL7
 . S V1=$P($G(^VA(200,+VL6,5)),U)  ;SERVICE - Fiscal Approv
 . S V2=$S(V1="":"",1:$$GET1^DIQ(49,+V1_",",.01))   ;SVC ext - Fiscal Approv
 . S POAMD4=PPOKEY_U_POAMD2_U_V3_U_VL8_U_VL9_U_V1_U_V2
 . S ^TMP($J,"POAMMD",POID,POAMD2,0)=POAMD4
 . D POAMCH  ; Check for Amendment Changes
 . D POAMDS  ; Check for Amendment Description
 . Q
 Q
POAMCH ; PO Amendment Changes Table (mulitple)
 N POAMC,POAMC1,POAMC2,POAMC3,POAMC4,POAMC5,POAMC6
 S POAMC=$G(^PRC(442,POID,6,POAMD2,3,0))
 S POAMC1=$P(POAMC,U,3)
 S POAMC2=0
 F  S POAMC2=$O(^PRC(442,POID,6,POAMD2,3,POAMC2)) Q:+POAMC2'>0  D
 . S POAMC3=$G(^PRC(442,POID,6,POAMD2,3,POAMC2,0))
 . S POAMC4=$P(POAMC3,U,1),POAMC5=$P(POAMC3,U,2)
 . S POAMC6=PPOKEY_U_POAMD2_U_POAMC2_U_POAMC4_U_POAMC5
 . S ^TMP($J,"POAMMDCH",POID,POAMD2,POAMC2,0)=POAMC6
 . Q
 Q
POAMDS ; PO Amendment Description Table
 N POADD,POADD1,POADD2,POADD3,POADD4
 S POADD=$G(^PRC(442,POID,6,POAMD2,2,0))
 I $D(POADD)  D
 . S POADD1=0
 . F  S POADD1=$O(^PRC(442,POID,6,POAMD2,2,POADD1)) Q:POADD1=""  D
 . . S POADD2=$G(^PRC(442,POID,6,POAMD2,2,POADD1,0))  ;  mult
 . . S POADD3=PPOKEY_U_POAMD2_U_POADD1_U_POADD2
 . . Q:+POADD1>1  ; Get the 1st "1"
 . . I +POAMD2>0 S ^TMP($J,"POAMMDDES",POID,POAMD2,POADD1,0)=POADD3
 . . Q
 . Q
 Q
POCMTS ; PocommentsTable
 N POCMTS,POCMTS1
 S POCMTS=$G(^PRC(442,POID,4,1,0))  ; 1st line
 S POCMTS1=$E(POCMTS,1,175)  ; Get the 1st 175 Chars
 ; Get the 1st 175 Char of 1st comment only
 I POCMTS'="" S ^TMP($J,"POCOMMENTS",POID)=PPOKEY_U_1_U_POCMTS1
 Q
PORMKS ; PoRemarks Table
 N PORMKS,PORMKS1
 S PORMKS=$G(^PRC(442,POID,16,1,0))  ; 1st Line, 1st Comment
 S PORMKS1=$E(PORMKS,1,175)  ; Get the 1st 175 Chars
 ; gET 1st 175 Characters of 1st remark
 I PORMKS'="" S ^TMP($J,"POREMARKS",POID)=PPOKEY_U_1_U_PORMKS1
 Q
LPPODIS ; Loop on PO Discount
 I CKDS1>0  D
 . F  S PPO=$O(^PRC(442,POID,3,PPO)) Q:PPO=""  D
 . . S PPOVAL=$G(^PRC(442,POID,3,PPO,0))
 . . S V1=$P(PPOVAL,U,1)_U_$P(PPOVAL,U,2)_U  ; disc itm & %$tot
 . . S V2=$P(PPOVAL,U,3)_U_$P(PPOVAL,U,4)_U  ; DiscAmt & ItmCt
 . . S V3=$P(PPOVAL,U,5)_U_$P(PPOVAL,U,6)  ; contract & lineItem
 . . S V4=V1_V2_V3  ; all data
 . . S PPOVAL1=PPOKEY_U_PPO_U_V4
 . . S ^TMP($J,"PODISC",POID,PPO)=PPOVAL1
 . . Q
 . Q
 Q
LPPOBC ; Loop PoBoc Table
 F  S PPO=$O(^PRC(442,POID,22,PPO)) Q:PPO=""  D
 . Q:PPO="B"  ; don't want B index
 . S PPOVAL=$G(^PRC(442,POID,22,PPO,0))
 . S PPOVAL1=$P(PPOVAL,U,1)_U_$P(PPOVAL,U,2)
 . S PPOVAL1=PPOVAL1_U_$P(PPOVAL,U,3)        ;FMS LINE
 . S PPOVAL2=PPOKEY_U_PPO_U_PPOVAL1
 . S ^TMP($J,"POBOC",POID,PPO)=PPOVAL2
 . Q
 Q
LP2237 ; Loop 2237
 N PPOVAL,PPV1,PPV2,PPV3,PPV4,PPV5,PPV6,PPV7,PPVALL,POKEY,PPOVAL2
 N PPV1E,PPV1E1,PPV2E,PPV2E1,PPV4E1,PPV4E2,PPV7E,PPV7E1,PPV7E2
 N PPV3E,PPV3E1,VL6,VL7,VL8,VL9
 F  S PPO=$O(^PRC(442,POID,13,PPO)) Q:PPO=""  D
 . S PPOVAL=$G(^PRC(442,POID,13,PPO,0))
 . S PPV1=$P(PPOVAL,U,1),PPV2=$P(PPOVAL,U,2),PPV3=$P(PPOVAL,U,4)
 . ; external value for 2237 PPV1
 . I PPV1'="" S PPV1E=$G(^PRCS(410,+PPV1,0)),PPV1E1=$P(PPV1E,U,1)
 . I PPV1="" S PPV1E1=""
 . ; external value for Accountable Officer PPV2
 . I PPV2'="" S PPV2E=$G(^VA(200,+PPV2,0)),PPV2E1=$P(PPV2E,U,1)
 . I PPV2="" S PPV2E1=""
 . S VL6=$P($G(^VA(200,+PPV2,5)),"^")      ;Service - Acc Office
 . S VL7=$S(VL6="":"",1:$$GET1^DIQ(49,+VL6_",",.01)) ;SVC ext - Acc Office
 . ; ext. date value for Date Signed
 . I PPV3'="" S PPV3E=$P(PPV3,".",1),PPV3E1=$$FMTE^XLFDT(PPV3E)
 . I PPV3="" S PPV3E1=""
 . S PPV4=$P(PPOVAL,U,5),PPV5=$P(PPOVAL,U,9),PPV6=$P(PPOVAL,U,10)
 . ; external for Purchasing agent PPV4
 . ;
 . I PPV4'="" S PPV4E1=$G(^VA(200,+PPV4,0)),PPV4E2=$P(PPV4E1,U,1)
 . I PPV4="" S PPV4E2=""
 . S VL8=$P($G(^VA(200,+PPV4,5)),"^")      ;Service - Purchase Agent
 . S VL9=$S(VL8="":"",1:$$GET1^DIQ(49,+VL8_",",.01)) ;SVC ext - Purchase Agent
 . ; get external value for InvDistPoint
 . S PPV7E=$P(PPOVAL,U,11)
 . I PPV7E'="" S PPV7E1=$G(^PRCP(445,+PPV7E,0)),PPV7E2=$P(PPV7E1,U,1)
 . I PPV7E="" S PPV7E2=""
 . S PPV7=PPV7E2
 . S PPVALL=PPV1E1_U_PPV2E1_U_PPV3E1_U_PPV4E2_U_PPV5_U_PPV6_U_PPV7_U_$P(PPOVAL,U,5)_U_$P(PPOVAL,U,2)
 . ;
 . S PPOVAL2=PPOKEY_U_PPO_U_PPVALL
 . S ^TMP($J,"PO2237",POID,PPO)=PPOVAL2_U_VL8_U_VL9_U_VL6_U_VL7
 . Q
 Q
PODISCH ; PO Discount Header File
 ; Header file for PO Discount Multiple
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "DiscountIdNum^DiscountItem^PercentDollarAmount^"
 W "DiscountAmount^ItemCount^Contract^LineItem",!
 Q
