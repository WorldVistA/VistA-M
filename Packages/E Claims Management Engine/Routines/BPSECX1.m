BPSECX1 ;BHAM ISC/FCS/DRS/VA/DLF - Create new Claim ID for Claim Submission file ;05/17/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,5,33,38,40**;JUN 2004;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;----------------------------------------------------------------------
 ;Create new Claim ID for Claim Submission file (9002313.02)
 ;
 ;Function Returns:  VA<YYYY>=<Pharmacy ID>=<Plan ID>=<Sequence Number>
 ;                   Where: <YYYY> is the year
 ;                          <Pharmacy ID> NPI of the BPS Pharmacy
 ;                          <Plan ID> is the VA National Plan ID w/o leading alphas
 ;                          <Sequence #> is a unique counter stored in BPS SETUP
 ;----------------------------------------------------------------------
 ;
CLAIMID(IEN59) ;EP - Called from BPSOSCE (billing requests) and BPSECA8 (reversals)
 ; Check parameters
 I '$G(IEN59) Q ""
 ;
 ; Initialization
 N BPSCS,FIRST,FOURTH,I,PHARMACY,PLAN,RFL,RX,SECOND,THIRD
 ;
 ; First piece of Transmission ID = "VA"_Year
 ; Length=6
 ;
 S FIRST="VA"_($E(DT,1,3)+1700)
 ;
 ; Second piece of Transmission ID = NPI
 ;
 S PHARMACY=+$P($G(^BPST(IEN59,1)),U,7)
 S SECOND=$P($G(^BPS(9002313.56,PHARMACY,"NPI")),U,1)
 ;
 ; Check for Controlled Substance Drug and if BPS Pharmacy for CS
 ; has been defined.  If so, use NPI for the CS Pharmacy.
 S RX=$$GET1^DIQ(9002313.59,IEN59,1.11,"I")
 S RFL=$$GET1^DIQ(9002313.59,IEN59,9)
 S BPSCS=$$CSNPI^BPSUTIL(RX,RFL)
 I $P(BPSCS,"^")'="-1" S SECOND=$P(BPSCS,"^",2)
 ;
 I SECOND="" S SECOND="0000000000"
 ;
 ; Third piece of Transmission ID = National Plan ID
 ; Left-padded with zeros
 ; Length = 6
 ;
 S THIRD="",PLAN=$$GET1^DIQ(9002313.59902,"1,"_IEN59_",","902.27")
 I PLAN]"" D
 . F I=1:1:$L(PLAN) I $E(PLAN,I)?1N Q
 . S PLAN=$E(PLAN,I,$L(PLAN))
 . S THIRD=PLAN
 ;
 S THIRD=$TR($J("",6-$L(THIRD))," ","0")_THIRD
 ;
 ; Fourth piece of Transmission ID = Sequence Number
 ; Left-padded with zeros
 ; Length = 7
 ;
 L +^BPS(9002313.99,1,3):15
 I '$T D IMPOSS^BPSOSUE("DB,P","TI","",,"Can't lock BPS(9002313.99,1,3)",$T(+0))
 S FOURTH=+$G(^BPS(9002313.99,1,3)),^BPS(9002313.99,1,3)=FOURTH+1
 I $L(FOURTH<7) S FOURTH=$E($TR($J("",7-$L(FOURTH))," ","0")_FOURTH,1,7)
 L -^BPS(9002313.99,1,3)
 ;
 ; Create the Transmission ID
 Q FIRST_"="_SECOND_"="_THIRD_"="_FOURTH
