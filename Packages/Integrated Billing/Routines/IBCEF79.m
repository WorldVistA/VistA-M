IBCEF79 ;ALB/ESG - Billing Provider functions ;13-Aug-2008
 ;;2.0;INTEGRATED BILLING;**400,419,432,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
B(IBIFN,COB) ; Determine Billing Provider and Service Facility information
 ; This function returns a string in the following format:
 ;  [1] billing provider Institution file pointer (IEN to file 4) or "0"
 ;      if the billing provider cannot be determined
 ;  [2] billing provider name (.01 field in file 4) or Error reason why
 ;      the billing provider cannot be determined - used when piece [1]=0
 ;  [3] 0 if the service facility is a VA institution in file 4
 ;      1 if the service facility is a non-VA facility in file 355.93
 ;      "" if the service facility is blank - when there is no service facility
 ;  [4] service facility IEN - either an IEN to file 4 or to file 355.93
 ;      or "" if the service facility is blank
 ;
 ; Input parameters
 ;   IBIFN - claim# required
 ;     COB - payer sequence# - optional - defaults to current payer sequence# if not passed in
 ;
 NEW %,Z,IBU2,NVAFAC,BP,IB0,EVDT,IBDIV,BPDIV,BPDIVCHK,RXFLG,D,D0,DI,DIQ2,X,Y
 S Z=""
 S IBIFN=+$G(IBIFN)
 I 'IBIFN S Z="0^Invalid claim.^^" G BX
 I '$D(^DGCR(399,IBIFN,0)) S Z="0^Claim doesn't exist.^^" G BX
 I '$G(COB) S COB=$$COBN^IBCEF(IBIFN)    ; current payer sequence default
 I '$F(".1.2.3.","."_COB_".") S Z="0^Invalid Payer Sequence#: """_COB_"""^^" G BX
 ;
 ; set some initial variables for all claims
 S IB0=$G(^DGCR(399,IBIFN,0))
 S EVDT=$P(IB0,U,3)                      ; claim event date
 I 'EVDT S EVDT=DT                       ;   - default today if undefined
 S IBDIV=+$P(IB0,U,22)                   ; division ptr file 40.8
 I 'IBDIV S IBDIV=$$PRIM^VASITE(EVDT)    ;   - default primary division as of event date
 I IBDIV'>0 S $P(Z,U,1,2)="0^Invalid Division for Event Date "_$$FMTE^XLFDT(EVDT,"5Z")_"." G BX
 S BPDIV=+$$SITE^VASITE(EVDT,IBDIV)      ; division institution ptr file 4
 I BPDIV'>0 S $P(Z,U,1,2)="0^Invalid Institution for Event Date "_$$FMTE^XLFDT(EVDT,"5Z")_"." G BX
 ;
 ; MRD;IB*2.0*516 - The field used as the switchback flag is being
 ; marked for deletion, to be deleted after 3/15/2018.  That flag
 ; will now always be null.  The following section of code was
 ; commented out because of this.  This section can be deleted in
 ; the future.
 ;
 ;; check ins co switchback flag
 ;I $$INSFLGS(IBIFN,COB)>0 D  G BX
 ;. N IBZ,SVCIEN,SVCTYP
 ;. ; revert billing provider and service facility calculation to pre-patch 400 methods
 ;. ;
 ;. ; service facility is legacy N-RENDERING INSTITUTION data
 ;. D F^IBCEF("N-RENDERING INSTITUTION","IBZ",,IBIFN)
 ;. S SVCIEN=+IBZ              ; service facility ien
 ;. S SVCTYP=+$P(IBZ,U,2)      ; service facility type - 0=VA inst, 1=non-VA facility
 ;. ;
 ;. I 'SVCIEN S $P(Z,U,3)="",$P(Z,U,4)=""          ;  no svc fac
 ;. I SVCIEN S $P(Z,U,3)=SVCTYP,$P(Z,U,4)=SVCIEN   ; yes svc fac
 ;. ;
 ;. ; billing provider = institution of main division in the database
 ;. S BP=+$$SITE^VASITE
 ;. I BP,$$BPFACTYP(BP) S $P(Z,U,1,2)=$$CHK(BP) Q
 ;. S $P(Z,U,1,2)="0^Facility Type of Main Division Institution is invalid."
 ;. Q
 ;
 S IBU2=$G(^DGCR(399,IBIFN,"U2"))
 S NVAFAC=+$P(IBU2,U,10)          ; non-VA facility
 I NVAFAC D  G BX
 . S $P(Z,U,3)=1                  ; service facility is the non-VA facility
 . S $P(Z,U,4)=NVAFAC             ; ien to file 355.93
 . S BP=BPDIV                     ; institution of division on claim (IB*2*419)
 . I BP,$$BPFACTYP(BP) S $P(Z,U,1,2)=$$CHK(BP) Q
 . S $P(Z,U,1,2)="0^Facility Type of Claim's Division is invalid for the Billing Provider."
 . Q
 ;
 S BPDIVCHK=0                            ; flag indicating if the div inst has been checked
 S RXFLG=$$ISRX^IBCEF1(IBIFN)            ; pharmacy flag
 ;
 I RXFLG D
 . S BP=+$$RXSITE^IBCEF73A(IBIFN)        ; dispensing pharmacy ien for pharmacy claims
 . I 'BP S BP=BPDIV,BPDIVCHK=1           ; use division institution if pharmacy not found
 . Q
 ;
 I 'RXFLG S BP=BPDIV,BPDIVCHK=1          ; non-Rx claims use division institution
 ;
 I BP,$$BPFACTYP(BP) D  G BX             ; billing provider type is valid
 . S $P(Z,U,1,2)=$$CHK(BP)
 . ;
 . ; 3/27/09 - Special Case
 . ;   If we are printing the CMS-1500 claim form, then populate the service facility with the billing provider.
 . ;   For any other calculation, the service facility is blank here.
 . ;
 . I $G(^TMP("IB 1500 PRINT",$J,IBIFN)) D
 .. S $P(Z,U,3)=0           ; service facility is in file 4
 .. S $P(Z,U,4)=$P(Z,U,1)   ; move billing provider ien over
 .. Q
 . Q
 ;
 ; here, the BP has an invalid billing provider facility type
 ; move this BP over to the service facility
 S $P(Z,U,3)=0    ; service facility is in file 4
 S $P(Z,U,4)=BP   ; move this BP over to the service facility
 ;
 I BPDIVCHK G B1  ; the division institution has already been checked...skip down to tag B1 to check the parent
 ;
 ; check the division institution
 S BP=BPDIV,BPDIVCHK=1
 I BP,$$BPFACTYP(BP) S $P(Z,U,1,2)=$$CHK(BP) G BX
 ;
B1 ;
 ; check the parent
 S BP=$$BPPAR(BPDIV)    ; institution of the parent of the division
 I BP,$$BPFACTYP(BP) S $P(Z,U,1,2)=$$CHK(BP) G BX
 ;
 ; here, the facility type of the parent is also not valid, so it is an error
 S $P(Z,U,1,2)="0^Facility Type of Division and the Division's Parent Institution are Invalid."
BX ;
 Q Z
 ;
CHK(IEN) ; Perform final billing provider checks on passed in Institution
 ; file pointer - File 4 ien
 ; Function returns final pieces 1 and 2 of $$B function as described above
 NEW BP
 S IEN=+$G(IEN)
 I 'IEN S BP="0^Invalid Institution pointer IEN." G CHKX
 I '$$BPCHKN(IEN) S BP="0^Not a National Institution." G CHKX
 I '$$BPCHKA(IEN) S BP="0^Not an Active Institution." G CHKX
 ;
 S BP=IEN_U_$P($$NS^XUAF4(IEN),U,1)    ; ien^name  DBIA# 2171
CHKX ;
 Q BP
 ;
BPCHKN(IEN) ; Is this a national Institution?
 N Z S Z=0
 I $$STATUS^XUAF4(+IEN)="N" S Z=1    ; DBIA# 2171
BPCHKNX ;
 Q Z
 ;
BPCHKA(IEN) ; Is this an active Institution?
 N Z S Z=0
 I $$ACTIVE^XUAF4(+IEN) S Z=1        ; DBIA# 2171
BPCHKAX ;
 Q Z
 ;
BPFACTYP(IEN) ; Is the facility type of this Institution a valid Billing Provider facility type?
 N Z S Z=0
 I $D(^IBE(350.9,1,20,"B",+$$GET1^DIQ(4,+IEN_",",13,"I"))) S Z=1
BPFACTPX ;
 Q Z
 ;
BPPAR(IEN) ; Who is the parent for this Institution?
 ; Function returns the IEN to file 4 of the parent institution as defined in File 4
 N Z,PIA
 D PARENT^XUAF4($NA(PIA),("`"_+IEN),"PARENT FACILITY")    ; DBIA# 2171
 S Z=+$O(PIA("P",""))
BPPARX ;
 Q Z
 ;
TAX(IBIFN) ; Update default billing provider and service facility taxonomy codes
 ; and billing provider secondary IDs and Qualifiers.
 ; This is called via new style xrefs to update the default value of these fields
 ;
 N BPZ,BPTAX,SFTAX,IENS,IBTAXO,IBU3,IBM1,BPID1,BPQL1,BPID2,BPQL2,BPID3,BPQL3
 N D,D0,DI,DIQ2,X,Y
 ;
 I '$G(IBIFN) G TAXQ
 I $P($G(^DGCR(399,IBIFN,0)),U,13)'=1 G TAXQ      ; claim is not editable
 ;
 S BPZ=$$B(IBIFN)     ; billing provider/service facility string
 ;
 ; billing provider taxonomy
 S BPTAX=""
 I +BPZ S BPTAX=+$P($$TAXORG^XUSTAX(+BPZ),U,2)      ; ien to file 8932.1 for VA billing provider
 I 'BPTAX S BPTAX=""
 ;
 ; service facility taxonomy
 S SFTAX=""
 I $P(BPZ,U,3)=0,+$P(BPZ,U,4) S SFTAX=+$P($$TAXORG^XUSTAX(+$P(BPZ,U,4)),U,2)     ; ien to file 8932.1 for VA svc fac
 I $P(BPZ,U,3)=1,+$P(BPZ,U,4) S SFTAX=+$P($$TAXGET^IBCEP81(+$P(BPZ,U,4)),U,2)    ; ien to file 8932.1 for non-VA svc fac
 I 'SFTAX S SFTAX=""
 ;
 ; billing provider secondary ID#2 and qualifier#2 for each payer on the claim
 S BPID1=$$PRVNUM^IBCU(IBIFN,,1)    ; #122
 S BPQL1=$$PRVQUAL^IBCU(IBIFN,,1)   ; #128
 S BPID2=$$PRVNUM^IBCU(IBIFN,,2)    ; #123
 S BPQL2=$$PRVQUAL^IBCU(IBIFN,,2)   ; #129
 S BPID3=$$PRVNUM^IBCU(IBIFN,,3)    ; #124
 S BPQL3=$$PRVQUAL^IBCU(IBIFN,,3)   ; #130
 ;
 ; Use FileMan DBS call to update these fields if changes are necessary
 S IENS=IBIFN_","
 S IBU3=$G(^DGCR(399,IBIFN,"U3"))
 S IBM1=$G(^DGCR(399,IBIFN,"M1"))
 I SFTAX'=$P(IBU3,U,2) S IBTAXO(399,IENS,243)=SFTAX        ; service facility taxonomy
 I BPTAX'=$P(IBU3,U,11) S IBTAXO(399,IENS,252)=BPTAX       ; billing provider taxonomy
 I BPID1'=$P(IBM1,U,2) S IBTAXO(399,IENS,122)=BPID1        ; primary ID
 I BPQL1'=$P(IBM1,U,10) S IBTAXO(399,IENS,128)=BPQL1       ; primary Qual
 I BPID2'=$P(IBM1,U,3) S IBTAXO(399,IENS,123)=BPID2        ; secondary ID
 I BPQL2'=$P(IBM1,U,11) S IBTAXO(399,IENS,129)=BPQL2       ; secondary Qual
 I BPID3'=$P(IBM1,U,4) S IBTAXO(399,IENS,124)=BPID3        ; tertiary ID
 I BPQL3'=$P(IBM1,U,12) S IBTAXO(399,IENS,130)=BPQL3       ; tertiary Qual
 ;
 I '$D(IBTAXO) G TAXQ    ; no changes necessary
 ;
 D FILE^DIE(,"IBTAXO")   ; update fields
TAXQ ;
 Q
 ;
INSFLGS(IBIFN,COB) ; get insurance company flags for a given claim
 ; returns string of flags in the following format:
 ; switchback flag ^ send service facility flag ^ institution file address flag ^ error
 ; switchback flag: field 36/4.11 or 36/4.12, depending on form type. "-1" if error has occurred.
 ; send service facility flag: field 36/4.07, empty if error has occurred or switchback flag is not set.
 ; institution file address flag: field 36/4.13, empty if error has occurred or switchback flag is not set.
 ; 
 ; MRD;IB*2.0*516 - The four flag fields described above (File #36,
 ; Field #'s 4.07, 4.11, 4.12, 4.13) are all being marked for
 ; deletion.  All references to those fields are being removed
 ; as part of this patch.
 ;
 Q ""
 ; 
 ;N FLGS,FT,INSIEN,INS4
 ;S IBIFN=+$G(IBIFN) I 'IBIFN Q "-1^^^Invalid claim."
 ;I '$D(^DGCR(399,IBIFN,0)) Q "-1^^^Claim doesn't exist."
 ;I '$G(COB) S COB=$$COBN^IBCEF(IBIFN)    ; current payer sequence default
 ;I '(".1.2.3."[("."_COB_".")) Q "-1^^^Invalid Payer Sequence#: """_COB_"""."
 ;S INSIEN=$$POLICY^IBCEF(IBIFN,1,COB) I 'INSIEN Q "-1^^^No insurance company associated with the claim."
 ;S INS4=$G(^DIC(36,INSIEN,4)),FT=$$FT^IBCEF(IBIFN)
 ;S FLGS=$P(INS4,U,$S(FT=2:11,1:12)) I '+FLGS Q FLGS ; we are done if switchback flag is not set
 ;S $P(FLGS,U,2)=$P(INS4,U,7),$P(FLGS,U,3)=$P(INS4,U,13) ; if switchback is set, get the other 2 flags
 ;Q FLGS
 ;
GETBP(IBIFN,COB,INST,SUB,IBXSAVE) ; Get billing provider data for claim output
 ; Used to extract billing provider name, address, and phone# for PRV segment and for CMS-1500, Box 33
 ;   IBIFN - claim ien required
 ;     COB - payer sequence (optional, defaults to current payer seq)
 ;    INST - billing provider VA file 4 ien required
 ;     SUB - subscript to use in IBXSAVE local array required
 ; IBXSAVE - pass by reference
 ;           Returns IBXSAVE(SUB,"NAME")
 ;                   IBXSAVE(SUB,"ADDR1")
 ;                   IBXSAVE(SUB,"ADDR2")
 ;                   IBXSAVE(SUB,"CITY")
 ;                   IBXSAVE(SUB,"ST")
 ;                   IBXSAVE(SUB,"ZIP")
 ;                   IBXSAVE(SUB,"PHONE")
 ;
 ; MRD;IB*2.0*516 - The field used as the switchback flag is being
 ; marked for deletion, to be deleted after 3/15/2018.  That flag
 ; will now always be null.  Several sections of this procedure have
 ; been commented out because of this.  Those sections can be
 ; deleted in the future.
 ;
 NEW IBZ
 K IBXSAVE(SUB)
 I '$G(COB) S COB=$$COBN^IBCEF(IBIFN)
 ;
 ;S INSFLGS=$$INSFLGS(IBIFN,COB)           ; all ins co flags
 ;S SWBFLG=(+INSFLGS>0)                    ; main switchback flag
 ;S (BPTP,MAINPTP)=""                      ; initialize vars used only in switchback mode
 ;I SWBFLG D
 ;. S BPTP=$$MAINPRV^IBJPS3                ; main division pay-to provider data string
 ;. S MAINPTP=($P(BPTP,U,10)'["IB177")     ; flag that says whether main div exists as a pay-to
 ;. Q
 ;
 ; If Switchback is ON and the ins. company parameter Use billing provider VAMC address is not on and
 ; main div pay-to exists, then use the pay-to provider data for the main division in the database.
 ; This is the "normal" switchback data.
 ;I SWBFLG,'$P(INSFLGS,U,3),MAINPTP D  G GETBPX    ; switchback + billing provider address flag + main ptp exists
 ;. ; IB*2.0*432 - Retrieve the BP name from "gold standard" name field of file #4 and if not populated, retrieve from .01 field - IA#2171
 ;. ;S IBXSAVE(SUB,"NAME")=$P(BPTP,U,1)
 ;. S IBXSAVE(SUB,"NAME")=$$BNIEN^XUAF4(INST)
 ;. S:IBXSAVE(SUB,"NAME")="" IBXSAVE(SUB,"NAME")=$P(BPTP,U,1)
 ;. S IBXSAVE(SUB,"ADDR1")=$P(BPTP,U,5)
 ;. S IBXSAVE(SUB,"ADDR2")=$P(BPTP,U,6)
 ;. S IBXSAVE(SUB,"CITY")=$P(BPTP,U,7)
 ;. S IBXSAVE(SUB,"ST")=$P(BPTP,U,8)
 ;. S IBXSAVE(SUB,"ZIP")=$P(BPTP,U,9)
 ;. S IBXSAVE(SUB,"PHONE")=$P(BPTP,U,4)
 ;. Q
 ;
 ; Special Case:  Switchback is ON, the ins. company parameter Use billing provider VAMC address
 ; is not on, but the main division is NOT defined as a Pay-To provider.
 ; Get the name from the Institution File, but everything else from the claim's Pay-to provider
 ;I SWBFLG,'$P(INSFLGS,U,3),'MAINPTP D  G GETBPX
 ;. ; IB*2.0*432 - Retrieve the BP name from "gold standard" name field of file #4 and if not populated, retrieve from .01 field - IA#2171
 ;. ;S IBXSAVE(SUB,"NAME")=$$GETFAC^IBCEP8(INST,0,0)
 ;. S IBXSAVE(SUB,"NAME")=$$BNIEN^XUAF4(INST)
 ;. S:IBXSAVE(SUB,"NAME")="" IBXSAVE(SUB,"NAME")=$$GETFAC^IBCEP8(INST,0,0)   ; Inst name
 ;. S IBZ=$$PRVDATA^IBJPS3(IBIFN)
 ;. S IBXSAVE(SUB,"ADDR1")=$P(IBZ,U,5)
 ;. S IBXSAVE(SUB,"ADDR2")=$P(IBZ,U,6)
 ;. S IBXSAVE(SUB,"CITY")=$P(IBZ,U,7)
 ;. S IBXSAVE(SUB,"ST")=$P(IBZ,U,8)
 ;. S IBXSAVE(SUB,"ZIP")=$P(IBZ,U,9)
 ;. S IBXSAVE(SUB,"PHONE")=$P(IBZ,U,4)
 ;. Q
 ;
 ; At this point, we want to get the billing provider data from the Institution file
 ; IB*2.0*432 - Retrieve the BP name from "gold standard" name field of file #4 and if not populated, retrieve from .01 field - IA#2171
 ;S IBXSAVE(SUB,"NAME")=$$GETFAC^IBCEP8(INST,0,0)
 S IBXSAVE(SUB,"NAME")=$$BNIEN^XUAF4(INST)
 S:IBXSAVE(SUB,"NAME")="" IBXSAVE(SUB,"NAME")=$$GETFAC^IBCEP8(INST,0,0)
 S IBXSAVE(SUB,"ADDR1")=$$GETFAC^IBCEP8(INST,0,1)
 S IBXSAVE(SUB,"ADDR2")=$$GETFAC^IBCEP8(INST,0,2)
 S IBXSAVE(SUB,"CITY")=$$GETFAC^IBCEP8(INST,0,"3C")
 S IBXSAVE(SUB,"ST")=$$GETFAC^IBCEP8(INST,0,"3S")
 S IBXSAVE(SUB,"ZIP")=$$GETFAC^IBCEP8(INST,0,"3Z")
 S IBXSAVE(SUB,"PHONE")=$$PRVPHONE^IBJPS3(IBIFN)        ; pay-to phone for claim
 ;I SWBFLG,MAINPTP S IBXSAVE(SUB,"PHONE")=$P(BPTP,U,4)   ; switchback: pay-to phone for main division
 ;
 ; 3/30/09 - new requirement - for locally printed CMS-1500 claims, use the pay-to provider address information - Box 33
 ;I 'SWBFLG,SUB="BOX33" D
 I SUB="BOX33" D
 . S IBZ=$$PRVDATA^IBJPS3(IBIFN)
 . S IBXSAVE(SUB,"ADDR1")=$P(IBZ,U,5)
 . S IBXSAVE(SUB,"ADDR2")=$P(IBZ,U,6)
 . S IBXSAVE(SUB,"CITY")=$P(IBZ,U,7)
 . S IBXSAVE(SUB,"ST")=$P(IBZ,U,8)
 . S IBXSAVE(SUB,"ZIP")=$P(IBZ,U,9)
 . Q
 ;
GETBPX ;
 Q
 ;
SENDSF(IBIFN,COB) ; Send service facility information for the EDI claim?
 ; Function value returns 1 (send service facility information) or 0 (don't send it)
 ; The only time this function returns 0 is when the pre-patch 400 switchback flag is set, and
 ; care was provided at the main division (VAMC) in the database, and the 36,4.07 ins. co. flag is set to NO.
 ; This function is used in the EDI claim (segments SUB, SUB2, NPI-16, and NPI-17).
 ; IBIFN required
 ; COB optional, defaults to current payer sequence
 ;
 ; MRD;IB*2.0*516 - The field used as the switchback flag is being
 ; marked for deletion, to be deleted after 3/15/2018.  That flag
 ; will now always be null.  This function will now always return
 ; '1'.
 ;
 NEW SEND,IBDIV,MAIN
 S SEND=1
 I '$G(COB) S COB=$$COBN^IBCEF(IBIFN)       ; current payer sequence default
 ;S INSFLGS=$$INSFLGS(IBIFN,COB)             ; all ins co flags
 ;I +INSFLGS'>0 G SENDSFX                    ; switchback is OFF...get out
 G SENDSFX
 ;
 I $P($G(^DGCR(399,IBIFN,"U2")),U,10) G SENDSFX    ; if we have a non-VA facility on the claim, always send it
 ;
 S IBDIV=+$P($G(^DGCR(399,IBIFN,0)),U,22)   ; division on claim
 S MAIN=$$MAIN^IBCEP2B()                    ; main division in database
 I IBDIV'=MAIN G SENDSFX                    ; care was not provided at the main division - always send it
 ;
 ;I $P(INSFLGS,U,2) G SENDSFX                ; ins. co. flag is ON so send it
 ;
 S SEND=0                                   ; otherwise, do not send service facility data
 ;
SENDSFX ;
 Q SEND
 ;
SLPROV(IBXIEN,TYPE) ; return array of service line provider data
 ; IBXIEN - ien in file 399
 ; TYPE: O1 = operating physician, O2 = other operating physician, RE = rendering provider,
 ;       P = purchase service provider, S = supervising provider, RF = referring provider
 ;
 ; returns IBXSAVE("SLPRV", counter) = last name ^ first name ^ middle name ^ suffix
 ; ^ taxonomy code ^ primary id ^ secondary id (1) ^ secondary id qualifier (1) ^ ...
 ; ^ secondary id (n) ^ secondary id qualifier (n)
 ; IBXSAVE("SLPRV", counter,"SLC") = service line conter
 ;
 N DATA,IBN,IBX,IENS,MODE,NAME,PRNUM,PRTYPE,OUT,SLC,TMP,IBCNT
 I '+IBXIEN Q
 D ALLIDS^IBCEFP(IBXIEN,.IBX,1)
 S IBCNT=0
 ;
 S SLC="" F  S SLC=$O(IBX("L-PROV",IBXIEN,SLC)) Q:'SLC  D
 . I '$D(IBX("L-PROV",IBXIEN,SLC,"C",1,TYPE)) Q
 .I TYPE="O1",PRTYPE'=2 Q                ; not operating
 .I TYPE="O2",PRTYPE'=9 Q                ; not other operating
 .I TYPE="RE",PRTYPE'=3 Q                ; not rendering
 .I TYPE="S",PRTYPE'=5 Q                 ; not supervising
 .I TYPE="RF",PRTYPE'=1 Q                ; not referring
 .;
 .S DATA=$G(IBX("L-PROV",IBXIEN,SLC,"C",1,PRTYPE))
 .; name components
 .S IENS=$P($P(DATA,U),";")_","
 .I $P(DATA,U)["VA(200" S NAME=$$GET1^DIQ(200,IENS,.01)
 .I $P(DATA,U)["IBA(355.93" S NAME=$$GET1^DIQ(355.93,IENS,.01)
 .S TMP=$P(NAME,",",2),OUT=$P(NAME,",")_U_$P(TMP," ")_U_$P(TMP," ",2)_U_$P(TMP," ",3)
 .; taxonomy code
 .S $P(OUT,U,5)=$P($$GETTAX^IBCEF73A($P(DATA,U)),U)
 .S IBN="" F  S IBN=$O(IBX("L-PROV",IBXIEN,SLC,"C",1,PRTYPE,IBN)) Q:IBN=""  D
 ..S DATA=$G(IBX("L-PROV",IBXIEN,SLC,"C",1,PRTYPE,IBN))
 ..; primary id
 ..I IBN=0 S $P(OUT,U,6)=$P(DATA,U,4) Q
 ..;
 ..; secondary ids
 ..S OUT=OUT_U_$P(DATA,U,4)_U_$P(DATA,U,3)
 ..Q
 .Q
 S IBCNT=IBCNT+1
 S IBXSAVE("SLPRV",IBCNT)=OUT
 S IBXSAVE("SLPRV",IBCNT,"SLC")=SLC
 Q
