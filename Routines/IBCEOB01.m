IBCEOB01 ;ALB/ESG - 835 EDI EOB MSG PROCESSING CONT ;16-JAN-2008
 ;;2.0;INTEGRATED BILLING;**377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ; This routine processes the "06" record on the incoming 835 and
 ; updates the patient insurance files with the corrected name and/or
 ; subscriber ID# data.
 ;
UPD(IB0,IBEOB,IBIFN,DFN,SEQ) ; update pat ins policy data
 ; IB0   - This is the full "06" record data
 ; IBEOB - ien# to file 361.1
 ; IBIFN - ien# to file 399
 ; DFN   - patient ien# to file 2
 ; SEQ   - payer sequence number
 ;
 NEW CORRID,IBIT,IBZ,IBZ1,IDCHG,INS,MAX,NAMECHG,NNM,NNM1,PD,POL,X,MCRSFX,MCRLEN,LN
 ;
 ; patient ID# processing
 S IDCHG=0   ; flag indicating an ID# change
 S CORRID=$P(IB0,U,6)   ; corrected patient ID#
 S CORRID=$TR(CORRID,"-","")
 I CORRID'="" D
 . I $$VALHIC^IBCNSMM(CORRID) S IDCHG=1   ; valid HIC#
 . E  D MSG^IBCEOB(IBEOB,"The corrected ID# "_CORRID_" is not a valid Medicare HIC#.  No ID# correction done.")
 . Q
 ;
 ; corrected name processing
 S NAMECHG=0   ; flag indicating a name change
 I $P(IB0,U,3)="",$P(IB0,U,4)="",$P(IB0,U,5)="" G UPD1    ; no corrected name components indicated
 ;
 D F^IBCEF("N-CURR INSURED FULL NAME","IBZ",,IBIFN)   ; get the existing name in standard format (see CI2-2.9)
 I IBZ="" D MSG^IBCEOB(IBEOB,"Unable to determine the existing subscriber name.") G UPD1
 S IBZ1=$$NAME^IBCEFG1(IBZ)   ; parse existing name into component pieces (see CI2-2.9)
 ;
 ; Determine if Medicare sent the suffix in the last name field
 S MCRSFX=""                              ; default Medicare suffix found in last name
 S LN=$P(IB0,U,3)                         ; last name
 S MCRLEN=$L(LN," ")                      ; how many " " pieces there are in the Medicare last name
 I MCRLEN>1 D
 . S MCRSFX=$$CHKSUF($P(LN," ",MCRLEN))   ; check the last piece to see if it is a common suffix
 . Q
 ;
 ; build new name components
 S NNM("FAMILY")=$S($P(IB0,U,3)'="":$P(IB0,U,3),1:$P(IBZ1,U,1))
 S NNM("GIVEN")=$S($P(IB0,U,4)'="":$P(IB0,U,4),1:$P(IBZ1,U,2))
 S NNM("MIDDLE")=$S($P(IB0,U,5)'="":$P(IB0,U,5),1:$P(IBZ1,U,3))
 S NNM("SUFFIX")=$S(MCRSFX'="":"",1:$P(IBZ1,U,5))     ; if suffix is in the Medicare last name, blank it out here
 ;
 I NNM("FAMILY")="" D MSG^IBCEOB(IBEOB,"Last name is nil.") G UPD1
 I NNM("GIVEN")="" D MSG^IBCEOB(IBEOB,"First name is nil.") G UPD1
 ;
 K MAX D FIELD^DID(2.312,17,,"FIELD LENGTH","MAX") S MAX=$G(MAX("FIELD LENGTH"))
 I 'MAX D MSG^IBCEOB(IBEOB,"Unable to determine the maximum field length for 2.312,17.") G UPD1
 S NNM1=$$NAMEFMT^XLFNAME(.NNM,"F","CL"_MAX)     ; construct the new name
 K IBIT D FIELD^DID(2.312,17,,"INPUT TRANSFORM","IBIT") S IBIT=$G(IBIT("INPUT TRANSFORM"))
 S X=NNM1 X IBIT        ; invoke the input transform on the field to see if it is valid
 I '$D(X) D MSG^IBCEOB(IBEOB,"New name '"_NNM1_"' failed the input transform for field 2.312,17.") G UPD1
 ;
 ; at this point, all name checks have passed and we have a valid, new, corrected name in NNM1
 S NAMECHG=1
 ;
UPD1 ;
 ;
 I 'NAMECHG,'IDCHG D MSG^IBCEOB(IBEOB,"No changes made.") G UPDX
 ;
 I NAMECHG D
 . N DIE,DA,DR
 . D MSG^IBCEOB(IBEOB,"Name corrected from "_IBZ_" to "_NNM1_".")
 . S DIE=361.1,DA=IBEOB,DR="6.01////^S X=NNM1" D ^DIE
 . Q
 ;
 I IDCHG D
 . N DIE,DA,DR
 . D MSG^IBCEOB(IBEOB,"ID# corrected from "_$$POLICY^IBCEF(IBIFN,2,SEQ)_" to "_CORRID_".")
 . S DIE=361.1,DA=IBEOB,DR="6.02////^S X=CORRID" D ^DIE
 . Q
 ;
 ; Loop thru patient policies looking to update all Medicare entries
 S POL=0
 F  S POL=$O(^DPT(DFN,.312,POL)) Q:'POL  D
 . S PD=$G(^DPT(DFN,.312,POL,0))   ; policy data on the 0 node
 . S INS=+PD
 . I '$$MCRWNR^IBEFUNC(INS) Q      ; quit if ins co isn't Medicare
 . I IDCHG,CORRID'=$P(PD,U,2) D UPDID(DFN,POL,CORRID)   ; ID# change
 . I NAMECHG,NNM1'=$P(PD,U,17) D UPDNM(DFN,POL,NNM1)    ; name change
 . Q
UPDX ;
 Q
 ;
UPDID(DFN,DA,ID) ; update the subscriber ID# field
 N DR,DIE,DIC
 S DIE="^DPT("_DFN_",.312,",DA(1)=DFN
 S DR="1///^S X=ID"
 D ^DIE
 D UPDAUD(DFN,DA)           ; audit info
 Q
 ;
UPDNM(DFN,DA,NM) ; update the subscriber name field
 N DR,DIE,DIC
 S DIE="^DPT("_DFN_",.312,",DA(1)=DFN
 S DR="17///^S X=NM"
 D ^DIE
 D UPDAUD(DFN,DA)           ; audit info
 Q
 ;
UPDAUD(DFN,DA) ; update the audit information for this patient insurance policy
 N DR,DIE,DIC
 D UPDATPT^IBCNSP3(DFN,DA)   ; date and time last edited and by whom
 S DIE="^DPT("_DFN_",.312,",DA(1)=DFN
 S DR="1.09///MEDICARE"      ; source of information is MEDICARE
 D ^DIE
 D UPDCLM^IBCNSP1(DFN,DA)    ; update editable claims
 Q
 ;
CHKSUF(X) ; Return X if it looks like a suffix; otherwise, return null
 Q:"^I^II^III^IV^V^VI^VII^VIII^IX^X^JR^SR^DR^MD^ESQ^DDS^RN^"[(U_X_U) X
 Q:"^1ST^2ND^3RD^4TH^5TH^6TH^7TH^8TH^9TH^10TH^"[(U_X_U) X
 Q ""
 ;
