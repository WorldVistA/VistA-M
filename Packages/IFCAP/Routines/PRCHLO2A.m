PRCHLO2A ;WOIFO/RLL/DAP-EXTRACT ROUTINE (cont.)CLO REPORT SERVER ;5/22/09  14:12
 ;;5.1;IFCAP;**83,130**;Oct 20, 2000;Build 25
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ; DBIA 10093 - Read file 49 via FileMan.
 ; Continuation of PRCHLO2. This program includes the extract
 ; logic for each of the identified tables.
 ;
 Q
 ;
POOBL ; PO Obligation data
 ;PoObligationData Table 442.09 (multiple)
 ; ^PRC(442,POID,10,0)=^442.09
 ;
 N CKOB,PPO,PPOVAL,CKOB1,PP1,PP2,PP3,PP4,PP5,PP5E1,PP5E2,PP1A,PPALL
 N PP2E1,PP2E2
 S CKOB=$G(^PRC(442,POID,10,0)),PPO=0
 ;
 S CKOB1=$P(CKOB,U,3)
 ;
 I +CKOB1>0  D  ; Contains at least one Obligation, create rec.
 . ;
 . D LPPOOB
 . Q
 Q
POPART ; PO Partial
 ;
 N CKPT,PPO,CKPT1,CKPT2
 S CKPT=$G(^PRC(442,POID,11,0)),PPO=0
 S CKPT2=$P(CKPT,U,3)
 I +CKPT2>0  D  ; Contains at least one PARTIAL, create rec
 . D LPPART
 Q
POPMET ; PoPurchaseMethod Table
 N CKPM,PPO,PPOVAL,CKPM1,PPOVAL1E,PPOVAL2E
 S CKPM=$G(^PRC(442,POID,14,0)),PPO=0
 S CKPM1=$P(CKPM,U,3)
 I +CKPM1>0  D  ; Contains at lease one Purchase Method, create rec.
 . D LPPM
 Q
POPPTER ; PopromptpaymentTermsTable
 N POPPT,POPPT1,PPO,PPOVAL,PPOVAL1
 S POPPT=$G(^PRC(442,POID,5,0))
 S POPPT1=$P(POPPT,U,3)
 I +POPPT1>0  D  ;Contains at least one PromptPayment Term, create rec
 . D LPPOPTR
 Q
 ;
 Q
LPPOPTR ; Loop on Prompt Payment Terms
 S PPO=0
 F  S PPO=$O(^PRC(442,POID,5,PPO)) Q:PPO=""  D
 . S PPOVAL=$G(^PRC(442,POID,5,PPO,0))
 . S PP1=$P(PPOVAL,U,1),PP2=$P(PPOVAL,U,2),PP3=$P(PPOVAL,U,3)
 . S PP4=$P(PPOVAL,U,4)
 . S PPOVAL1=PP1_U_PP2_U_PP3_U_PP4
 . ; add key to data
 . I PPOVAL'="" S ^TMP($J,"POPROMPT",POID,PPO,0)=PPOKEY_U_PPO_U_PPOVAL1
 . Q
 Q
LPPOOB ; Loop on PO Obligation
 N X
 I CKOB1>0  D
 . S PPO=0
 . F  S PPO=$O(^PRC(442,POID,10,PPO)) Q:PPO=""  D
 . . S PPOVAL=$G(^PRC(442,POID,10,PPO,0))
 . . S PP1=$P(PPOVAL,U,1),PP2=$P(PPOVAL,U,2),PP3=$P(PPOVAL,U,3)
 . . ; get external for PP2, Obligated by
 . . I PP2'="" S PP2E1=$G(^VA(200,+PP2,0)),PP2E2=$P(PP2E1,U,1)
 . . I PP2="" S PP2E2=""
 . . S PP4=$P(PPOVAL,U,10),PP5=$P(PPOVAL,U,11)
 . . I PP5'="" S PP5E1=$G(^PRCS(410,+PP5,0)),PP5E2=$P(PP5E1,U,1)
 . . I PP5="" S PP5E2=""
 . . I PP1'="" S PP1A=$P(PP1,".",5),PP1=$P(PP1A,"@",1)
 . . S PPALL=PP1_U_PP2E2_U_PP3_U_PP4_U_PP5E2
 . . S PPALL=PPALL_U_PP2                      ;DUZ Obligated By
 . . S PPALL=PPALL_U_PP5                      ;IEN 1358 Adjustment
 . . S X=$P(PPOVAL,U,6) S:X'="" X=$$FMTE^XLFDT($P(X,"."))
 . . S PPALL=PPALL_U_X           ;Date Signed
 . . S X=$P(PPOVAL,U,12) S:X'="" X=$$FMTE^XLFDT(X)
 . . S PPALL=PPALL_U_X          ;Obligation Process Date
 . . S X=$P(PPOVAL,U,13) S:X'="" X=$P("JAN;FEB;MAR;APR;MAY;JUN;JUL;AUG;SEP;OCT;NOV;DEC",";",+$E(X,4,5))_" "_(1700+$E(X,1,3))
 . . S PPALL=PPALL_U_X          ;Accounting Period
 . . ;
 . . S PP2=$P($G(^VA(200,+PP2,5)),U)
 . . S PP3=$S(PP2="":"",1:$$GET1^DIQ(49,+PP2_",",.01))
 . . S PPALL=PPALL_U_PP2_U_PP3                ;OBL BY SERVICE INT/EXT
 . . ;
 . . S ^TMP($J,"POOBLG",POID,PPO)=PPOKEY_U_PPO_U_PPALL
 . . Q
 . Q
 Q
LPPM ; Loop PoPoPurchaseMethod Table
 F  S PPO=$O(^PRC(442,POID,14,PPO)) Q:PPO=""  D
 . Q:PPO="B"  ; don't want B index
 . S PPOVAL=$G(^PRC(442,POID,14,PPO,0))
 . ;
 . S PPOVAL1=$P(PPOVAL,U,1)
 . ; Get external value of PPOVAL1
 . I PPOVAL1'="" S PPOVAL1E=$G(^PRC(442.4,+PPOVAL1,0)),PPOVAL2E=$P(PPOVAL1E,U,3)
 . I PPOVAL1="" S PPOVAL2E=""
 . S PPOVAL2=PPOKEY_U_PPO_U_PPOVAL2E
 . S ^TMP($J,"POPMETH",POID,PPO)=PPOVAL2
 . Q
 Q
 ;
LPPART ; Loop on Partial
 N PPOVAL,PPV1,PPV2,PPV3,PPV4,PPV5,PPV6,PPV7,PPVALL,POKEY,PPOVAL2
 N PPOVAL1,PPV8,PPV9,PPV10,PPV11,PPV12,PPV13,PPVALL1
 N PPV3E1,PPV3E2,PPV5E1,PPV5E2,PPV1E,PPV1E1,PPV2E,PPV2E1
 F  S PPO=$O(^PRC(442,POID,11,PPO)) Q:PPO=""  D
 . S PPOVAL=$G(^PRC(442,POID,11,PPO,0))
 . S PPOVAL1=$G(^PRC(442,POID,11,PPO,1))
 . S PPV1=$P(PPOVAL,U,1),PPV2=$P(PPOVAL1,U,8),PPV3=$P(PPOVAL,U,2)
 . ; get external date value for Date
 . I PPV1'="" S PPV1E=$P(PPV1,".",1),PPV1E1=$$FMTE^XLFDT(PPV1E)
 . I PPV1="" S PPV1E1=""
 . ; get external date value for Scheduled delivery date
 . I PPV2'="" S PPV2E=$P(PPV2,".",1),PPV2E1=$$FMTE^XLFDT(PPV2E)
 . I PPV2="" S PPV2E1=""
 . ; get external value for PPV3
 . I PPV3'="" S PPV3E1=$G(^PRCD(420.2,+PPV3,0)),PPV3E2=$P(PPV3E1,U,1)
 . I PPV3="" S PPV3E2=""
 . S PPV4=$P(PPOVAL,U,3),PPV5=$P(PPOVAL,U,4),PPV6=$P(PPOVAL,U,5)
 . ; get external value for PPV5
 . I PPV5'="" S PPV5E1=$G(^PRCD(420.2,+PPV5,0)),PPV5E2=$P(PPV5E1,U,1)
 . I PPV5="" S PPV5E2=""
 . S PPV7=$P(PPOVAL,U,9),PPV8=$P(PPOVAL,U,10),PPV9=$P(PPOVAL,U,12)
 . S PPV10=$P(PPOVAL,U,13),PPV11=$P(PPOVAL,U,14),PPV12=$P(PPOVAL1,U,16)
 . S PPV13=$P(PPOVAL,U,21)
 . S PPVALL=PPV1E1_U_PPV2E1_U_PPV3E2_U_PPV4_U_PPV5E2_U_PPV6_U_PPV7
 . S PPVALL1=PPVALL_U_PPV8_U_PPV9_U_PPV10_U_PPV11_U_PPV12_U_PPV13
 . ;
 . S PPOVAL2=PPOKEY_U_PPO_U_PPVALL1
 . S ^TMP($J,"POPART",POID,PPO)=PPOVAL2
 . Q
 Q
