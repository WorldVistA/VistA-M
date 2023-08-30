IBY727PO ;EDE/TPF - POST INSTALL ROUTINE FOR IB*2.0*727
 ;;2.0;INTEGRATED BILLING;**727**;;Build 34
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
POST ;EP - POST INSTALL TO REMOVE EOB CLAIMS WITH MSE ERRORS FROM WORKLIST
 Q:(($P($$SITE^VASITE,U,3)=683)!(($P($$SITE^VASITE,U,3)=684)))&'($$PROD^XUPROD(1))
 N IBIENS,IBFDA,IBIFN
 S IBIFN=0
 F  S IBIFN=$O(^DGCR(399,"CAP",1,IBIFN)) Q:'IBIFN  D
 .;Q:'($$GET1^DIQ(399,IBIFN_",",36,"","","")="IB803")  ;TPF;EBILL-;IB*2.0*727 V14
 .Q:$$MELG(IBIFN,1)                    ;IF TRUE CLAIM SHOULD BE ON THE WORKLIST;TPF;EBILL-3054;IB*2.0*727 v15
 .S X=$$WLRMVF^IBCECOB1(IBIFN,"RM",1)
 Q
 ;
 ;This is the original MELG without the quit commented out in p727
MELG(IBIFN,IBMRADUP) ; function to check all EOBs for a claim and determine if they are
 ; eligible for inclusion on the COB management worklist, uses both B & C x-ref
 ; IBIFN - claim ien (required)
 ; IBMRADUP - indicates user said NO to "include denied for duplicate" prompt
 ;
 ; Returns EOB ien to use for display, if at least 1 EOB passed all checks
 ; if multiple EOBs passed but some have filing errors, returns the 1st EOB found that does NOT have filing errors
 ; if all EOBs have filing errors, tries to find one that is a PROCESSED status and return that one for CBW display
 ; Returns -1 if claim should appear on the worklist with no EOB
 ; Returns 0 if no EOBs passed the checks and claim should not appear on the worklist, also removes it
 ;
 ; IBCK = Total number of EOBs found for this claim ien
 ; IBECT = Total number of EOBs that failed the EOB TYPE check
 ; IBCT = Total number of EOBs for a claim that passed ALL the checks
 ;
 N IBDA,IBCT,IBEOBNDX,IBEOB,IB3611,IBCK,IBETC
 S IBCT=0,IBCK=0,IBETC=0
 F IBEOBNDX="B","C" D
 .S IBDA=0 F  S IBDA=$O(^IBM(361.1,IBEOBNDX,IBIFN,IBDA)) Q:'+IBDA  D
 ..Q:$D(IBEOB(IBDA))
 ..S IB3611=$G(^IBM(361.1,IBDA,0)),IBCK=IBCK+1
 ..Q:$D(^IBM(361.1,IBDA,"ERR"))    ;TPF;EBILL-3054;IB*2.0*727 v15
 ..; if this is a denied EOB and user does NOT want to include denied as duplicates and this EOB was denied as duplicate, don't include
 ..I $P(IB3611,U,13)=2,'$G(IBMRADUP),$$DENDUP^IBCEMU4(IBDA,1) Q
 ..; eob type must be correct for this worklist
 ..I $P(IB3611,U,4)=1 S IBETC=IBETC+1 Q
 ..; allow filing errors on worklist, but try to find at least 1 Processed EOB w/out errors
 ..I $D(^IBM(361.1,IBDA,"ERR")) S:$P($G(^IBM(361.1,IBDA,0)),U,13)'=1 IBEOB("DER",IBDA)="" S:$P($G(^IBM(361.1,IBDA,0)),U,13)=1 IBEOB("PER",IBDA)="" Q
 ..S IBEOB(IBDA)="",IBCT=IBCT+1
 ; if no EOB was found to check, return -1 to process as no EOB
 Q:IBCK=0 -1
 ; if no EOB passed, check to see if the EOBs were all MRA primaries that failed the EOB type check (2ndary/tertiaries were paper)
 I IBCT=0,$$WNRBILL^IBEFUNC(IBIFN,1),$$COBN^IBCEF(IBIFN)>1,(IBCK=IBETC) Q -1
 ; if no EOB's passed, check for filing errors and use that EOB, with Processed EOB's taking priority over denied
 I IBCT=0,$D(IBEOB("PER")) Q $O(IBEOB("PER",0))
 I IBCT=0,$D(IBEOB("DER")) Q $O(IBEOB("DER",0))
 ; if no EOB passed and not MRA primary w/subsequent paper EOB's or filing errors, do not put on CBW
 Q:IBCT=0 0
 ; if one or more EOBs passed, return the 1st one that passed the checks as the one to use for CBW display
 Q $O(IBEOB(0))
