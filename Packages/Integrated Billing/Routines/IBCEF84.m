IBCEF84 ;ALB/BI - GET PROVIDER FUNCTIONS ;26-OCT-2010
 ;;2.0;INTEGRATED BILLING;**432**;21-MAR-94;Build 192
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
CREATE(DA)    ; CREATE CONDITION ENTRY POINT.
 ; CALLED FROM DICT 399, FIELDS .21 & 101 TRIGGERS FOR FIELD 27.
 N TEST,X,INSDA,IBP
 S TEST=0
 ;
 ; Test for Medicare Secondary and CURRENT BILL PAYER SEQUENCE ="T"
 I $$GET1^DIQ(399,DA_",",.21,"I")="T",$$WNRBILL^IBEFUNC(DA,2) S TEST=1 Q TEST
 ;
 ; Test the CURRENT BILL PAYER SEQUENCE for "SECONDARY"
 I $$GET1^DIQ(399,DA_",",.21,"I")'="S" Q TEST
 ;
 ; Test the PRIMARY INSURANCE CARRIER for "MEDICARE (WNR)"
 I '$$WNRBILL^IBEFUNC(DA,1) Q TEST
 ;
 ; Set Primary Claim/Bill number.
 S IBP=$$GET1^DIQ(399,DA_",",125,"I")
 ; Test if the Primary Claim/Bill contains a MRA REQUESTED DATE.
 I IBP'="",$$GET1^DIQ(399,IBP_",",7,"I")'="" Q TEST
 ;
 ; Test the PRINT SEC MED CLAIMS W/O MRA flag in dictionary 36 for YES.
 S INSDA=$$GET1^DIQ(399,DA_",",102,"I")
 I $$GET1^DIQ(36,INSDA_",",6.1,"I")'=1 Q TEST
 ;
 S TEST=1
 Q TEST
 ;
DELETE(DA)    ; DELETE CONDITION ENTRY POINT.
 ; CALLED FROM DICT 399, FIELDS .21 & 101 TRIGGERS FOR FIELD 27.
 N TEST,X,INSDA
 S TEST=0
 ;
 ; Test for Medicare Secondary and CURRENT BILL PAYER SEQUENCE ="T"
 I $$GET1^DIQ(399,DA_",",.21,"I")="T",$$WNRBILL^IBEFUNC(DA,2) Q TEST
 ;
 ; Test the current value of FORCE CLAIM TO PRINT for "1"
 I $$GET1^DIQ(399,DA_",",27,"I")'="1" Q TEST
 ;
 S TEST=1
 ; 
 ; Test the CURRENT BILL PAYER SEQUENCE for "SECONDARY"
 I $$GET1^DIQ(399,DA_",",.21,"I")'="S" Q TEST
 ;
 ; Test the PRIMARY INSURANCE CARRIER for "MEDICARE (WNR)"
 I '$$WNRBILL^IBEFUNC(DA,1) Q TEST
 ;
 ; Set Primary Claim/Bill number.
 S IBP=$$GET1^DIQ(399,DA_",",125,"I")
 ; Test if the Primary Claim/Bill contains a MRA REQUESTED DATE.
 I IBP'="",$$GET1^DIQ(399,IBP_",",7,"I")'="" Q TEST
 ;
 ; Test the PRINT SEC MED CLAIMS W/O MRA flag in dictionary 36 for YES.
 S INSDA=$$GET1^DIQ(399,DA_",",102,"I")
 I $$GET1^DIQ(36,INSDA_",",6.1,"I")'=1 Q TEST
 ;
 S TEST=0
 Q TEST
 ;
TEST(DA)    ; Tag to be called by the input template.
 Q $$CREATE(DA)
 ;
MESSAGE    ; IF THE ABOVE TEST IS TRUE, THE FOLLOWING MESSAGE WILL BE DISPLAYED.
 N X,Y,DIR
 S DIR(0)="EA"
 S DIR("A",1)="THIS FIELD CAN'T BE CHANGE"
 S DIR("A")="PRESS RETURN TO CONTINUE: "
 D ^DIR
 Q
