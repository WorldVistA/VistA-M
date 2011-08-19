BPSECX1 ;BHAM ISC/FCS/DRS/VA/DLF - Create new Claim ID for Claim Submission file ;05/17/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;----------------------------------------------------------------------
 ;Create new Claim ID for Claim Submission file (9002313.02)
 ;
 ;Function Returns:  VA<YYYY>=<Pharmacy ID>=<Plan ID>=<Sequence Number>
 ;                   Where: <YYYY> is the year
 ;                          <Pharmacy ID> NPI or NCPDPP of the BPS Pharmacy
 ;                          <Plan ID> is the VA National Plan ID w/o leading alphas
 ;                          <Sequence #> is a unique counter stored in BPS SETUP
 ;----------------------------------------------------------------------
 ;
CLAIMID(IEN59) ;EP - Called from BPSOSCE (billing requests) and BPSECA8 (reversals)
 ; Check parameters
 I '$G(IEN59) Q ""
 ;
 ; Initialization
 N PHARMACY,FACID,THIRD,DEL,PLAN,I,SEQNUM
 ;
 ; Get and format the Facility ID (second piece of the transmission ID)
 ;   1. Try to get NPI first.
 ;   2. If we do not get the NPI, get the NCPDP and left-pad it with zeros
 ;      up to seven characters.
 ;   3. Right-pad the final ID with spaces up to 10 characters
 S PHARMACY=+$P($G(^BPST(IEN59,1)),U,7)
 S FACID=$P($G(^BPS(9002313.56,PHARMACY,"NPI")),U,1)
 I FACID="" D
 . S FACID=$P($G(^BPS(9002313.56,PHARMACY,0)),U,2)
 . S FACID=$TR($J("",7-$L(FACID))," ","0")_FACID
 S FACID=$RE($J($RE(FACID),10))
 ;
 ; Get the third piece of the transmission ID
 ;  If the National Plan ID is available, use it with '=' delimiter (new format)
 ;  If not, it will need to be the BIN with the '-' delimiter (old format)
 S THIRD="",PLAN=$$GET1^DIQ(9002313.59902,"1,"_IEN59_",","902.27")
 I PLAN]"" D
 . F I=1:1:$L(PLAN) I $E(PLAN,I)?1N Q
 . S PLAN=$E(PLAN,I,$L(PLAN))
 . S THIRD=PLAN,DEL="="
 ;
 ; If no plan, get BIN and use '-' delimiter (old format)
 I THIRD="" S DEL="-",THIRD=$$GET1^DIQ(9002313.59902,"1,"_IEN59_",","902.03")
 ;
 ; Pad third piece with zeros
 S THIRD=$TR($J("",6-$L(THIRD))," ","0")_THIRD
 ;
 ; Get and format the sequence number (fourth piece)
 L +^BPS(9002313.99,1,3):15
 I '$T D IMPOSS^BPSOSUE("DB,P","TI","",,"Can't lock BPS(9002313.99,1,3)",$T(+0))
 S SEQNUM=+$G(^BPS(9002313.99,1,3)),^BPS(9002313.99,1,3)=SEQNUM+1
 I $L(SEQNUM<7) S SEQNUM=$E($TR($J("",7-$L(SEQNUM))," ","0")_SEQNUM,1,7)
 L -^BPS(9002313.99,1,3)
 ;
 ; Create the Transmission ID
 Q "VA"_($E(DT,1,3)+1700)_DEL_FACID_DEL_THIRD_DEL_SEQNUM
