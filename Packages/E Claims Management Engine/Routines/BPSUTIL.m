BPSUTIL ;BHAM ISC/FLS/SS - General Utility functions ;3/27/08  13:18
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,2,5,6**;JUN 2004;Build 10
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; ECMEON
 ;   Input:
 ;      SITE - Pointer to Outpatient Site file (#59)
 ;   Output
 ;      1 - ECME is turned ON for the Outpatient Site
 ;      0 - ECME is not turned ON for the Outpatient Site.
 ;   Note that ON means that the Outpatient site is linked to an active
 ;     BPS Pharmacy that has a Pharmacy ID AND IB has ncpdp flagged as
 ;     turned on.
ECMEON(SITE) ;
 I '$$EPHON^IBNCPDPI Q 0
 I '$G(SITE) Q 0
 N BPSPHARM,FACID
 S FACID=0
 S BPSPHARM=$$GETPHARM(SITE)
 I BPSPHARM="" Q 0
 S FACID=$$GET1^DIQ(9002313.56,BPSPHARM_",",41.01)
 I FACID="",'$$NPIREQ^BPSNPI(DT) S FACID=$$GET1^DIQ(9002313.56,BPSPHARM_",",.02)
 Q $S(FACID:1,1:0)
 ;
CMOPON(SITE) ; - Returns 1 if CMOP is turned ON for ECME or 0 if not
 ; SITE - Pointer to #59 (OUTPATIENT SITE)
 Q:'$G(SITE) 0
 N PHRM S PHRM=$O(^BPS(9002313.56,"C",SITE,0)) I 'PHRM Q 0
 Q $$GET1^DIQ(9002313.56,PHRM,1,"I")
 ;
 ;Function returns STATUS flag from BPS PHARMACIES (file #56)
 ; Returns '1' for active or '0' for inactive BPS Pharmacy
BPSACTV(BPSPHARM) ;
 Q:'$G(BPSPHARM) 0
 Q +$P($G(^BPS(9002313.56,BPSPHARM,0)),U,10)
 ;
BPSPLN(RXI,RXR) ; - Returns the insurance PLAN NAME (902.24) field from BPS TRANSACTION
 ;
 ; Input variables -> RXI - Internal Prescription File IEN
 ;                    RXR - Refill Number
 ;
 I '$G(RXI) Q ""
 I '$G(RXR) S RXR=0
 N IEN59 S IEN59=$$IEN59^BPSOSRX(RXI,RXR) Q:IEN59="" ""
 N CINS S CINS=$$GET1^DIQ(9002313.59,IEN59,901) Q:'CINS ""
 Q $$GET1^DIQ(9002313.59902,CINS_","_IEN59,902.24)
 ;
 ;API for IB (IA #4146) to select BPS PHARMACY
 ;returns results as a local array BPPHARM
 ; Select the ECME Pharmacy or Pharmacies
 ;
 ; Input Variable -> BPSPHAR is passed by reference to get the result of user's selection
 ; BPPHARM = 1 One or More Pharmacies Selected
 ;    = 0 User Entered 'ALL'
 ; If BPSPHAR = 1 then the BPSPHAR array will be defined where:
 ;    BPSPHAR(ptr) = ptr ^ BPS PHARMACY NAME and
 ;    ptr = Internal Pointer to BPS PHARMACIES file (#9002313.56)
 ;
 ; Return Value ->   "" = Valid Entry or Entries Selected
 ;                                        ^ = Exit
SELPHARM(BPSPHAR) ;
 N BPRET,BPPHARM
 S BPRET=$$SELPHARM^BPSRPT3()
 M BPSPHAR=BPPHARM
 Q BPRET
 ;
 ;
 ;API for IB (IA #4146) to determine whether is one or more BPS PHARMACIES in the system
 ;Function returns
 ;1 - if the site has more than one record in the file #9002313.56
 ;0 - if there are no any divisions
 ;0^NAME OF THE EPHARM - if only one division return 0 and its name
 ;  to use in the header of the report
MULTPHRM() ;
 N IBX
 S IBX=+$O(^BPS(9002313.56,0))
 I IBX=0 Q 0
 I $O(^BPS(9002313.56,IBX))>0 Q 1
 Q "0^"_$$GET1^DIQ(9002313.56,IBX,.01,"E")
 ;
 ; Function for IB (IA #4146) to return site linked to pharmacy
 ; Input
 ;   BPSDIV - Outpatient Site
 ; Returns
 ;   BPSPHARM - BPS Pharmacy IEN
GETPHARM(BPSDIV) ;
 N BPSPHARM
 I $G(BPSDIV)="" Q ""
 S BPSPHARM=$O(^BPS(9002313.56,"C",BPSDIV,0)) I 'BPSPHARM Q ""
 Q:'$$BPSACTV^BPSUTIL(BPSPHARM) ""
 Q BPSPHARM
 ;
 ;API  for the IB package (IA#4146)
 ;Input parameters:
 ; BPSRX  - Rx ien (file #52)
 ; BPSREFNO - refill number
 ;Returned value:
 ; 1st piece:
 ;  0 - status "non-payable" OR there is no response from the payer for whatever reason OR wasn't submitted OR invalid parameters
 ;  1- status "payable"
 ; 2nd piece:
 ;  amount the payer agreed to pay
 ; 3rd piece:
 ;  Date of Service
 ;
PAIDAMNT(BPSRX,BPSREFNO) ;
 I ($G(BPSRX)="")!($G(BPSREFNO)="") Q "0^"
 N BPSTAT,BPSRET,IEN59,BPSRESP,BPDOS
 S BPSTAT=$$STATUS^BPSOSRX(BPSRX,BPSREFNO)
 ;The status of the claim should be "payable" in order to get amount of the 3rd party payment
 ;If it was an attempt to reverse the payable claim AND reversal was rejected
 ;then the claim still is considered as "payable" and we still can get the amount paid by the 3rd party.
 ;In this case we return 1 (payable) in first piece and the amount paid in the 2nd piece of the returned value.
 ;All other statuses mean that we cannot get amount paid so we return 0 = "non payable"
 I $P(BPSTAT,U)'="E PAYABLE",$P(BPSTAT,U)'="E REVERSAL REJECTED",$P(BPSTAT,U)'="E DUPLICATE" Q "0^"
 ;get ien for BPS TRANSACTION file
 S IEN59=+$$IEN59^BPSOSRX(BPSRX,BPSREFNO)
 I IEN59="" Q "0^"  ;BPS Transaction IEN could not be calculated
 S BPSRESP=+$P($G(^BPST(IEN59,0)),U,5)
 ;response from the payer was not found  - either claim was never submitted OR there
 ;is no response for some reason - either way - we cannot provide the amount paid, so return "0"
 I BPSRESP=0 Q "0^"
 S BPDOS=+$P($G(^BPST(IEN59,12)),U,2)
 S BPSRET=+$$INSPAID^BPSOS03(BPSRESP)
 Q "1^"_BPSRET_U_BPDOS
 ;
 ; NPIEXTR
 ;   This API was written for the NPI extract (XUSNPIX2) and returns
 ;    the NCPDP and STATUS of the associated BPS Pharmacy
 ;   Input:
 ;      SITE - Pointer to Outpatient Site file (#59)
 ;   Output
 ;      NCPDP^STATUS (0 - inactive, 1 - active)
 ;      "" if no SITE passed in or no linkage
NPIEXTR(SITE) ;
 I '$G(SITE) Q ""
 N BPSPHARM,NCPDP,STATUS
 S BPSPHARM=$O(^BPS(9002313.56,"C",SITE,0))
 I 'BPSPHARM Q ""
 S STATUS=$$BPSACTV^BPSUTIL(BPSPHARM)
 S NCPDP=$$GET1^DIQ(9002313.56,BPSPHARM_",",.02)
 Q NCPDP_"^"_STATUS
