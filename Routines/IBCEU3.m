IBCEU3 ;ALB/TMP - EDI UTILITIES FOR 1500 CLAIM FORM ;12/29/05 9:58am
 ;;2.0;INTEGRATED BILLING;**51,137,155,323,348,371,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
BOX19(IBIFN) ; Returns the text that should print in box 19 of the CMS-1500
 ;   for bill ien IBIFN
 ; Data is derived from a combo of data throughout
 ; the system and is limited to 80 characters.  The hierarchy for
 ; including data is as follows (until 80 characters have been used):
 ;   DATE LAST SEEN and REFERRING PHYSICIAN ID# (physical therapy)
 ;                      specialty codes = 025,065,073,067,048
 ;   LAST X-RAY DATE (chiropractic) specialty code = 35
 ;   HOMEBOUND INDICATOR (independent lab renders an EKG or obtains
 ;                        a specimen from a homebound patient)
 ;   NO ASSIGNMENT OF BENEFITS (if no assignment of benefits indicated)
 ;   Hearing aid testing (if applicable)
 ;   ATTENDING PHYSICIAN NOT HOSPICE EMPLOYEE (if applicable)
 ;   SPECIAL PROGRAM indicator if Medicare demonstration project for
 ;                   lung volume reduction surgery study is set
 ;   COMMENTS FOUND IN BOX 19 DATA FIELD FOR THE CLAIM
 ;   REMARKS FOUND IN BILL COMMENT FOR THE CLAIM, INCLUDING PROSTHETICS
 ;     DETAIL
 ;
 N IBGO,IBHOSP,IBID,IBLSDT,IBXDATA,IB19,IBHAID,IBXRAY,IBSPEC,Z,Z0,IBSUB,IBPRT,IBREM
 S IB19="",IBGO=1
 S IBSUB=$S('$G(^TMP("IBTX",$J,IBIFN)):"BOX24",1:"OUTPT")
 I $D(IBXSAVE(IBSUB)) N IBXSAVE
 S IBPRT=(IBSUB["24")
 ;
 S IBSPEC=$$BILLSPEC(IBIFN)
 G:'IBPRT NPRT
 ; Check for chiropractic services
 I $P($G(^DGCR(399,IBIFN,"U3")),U,5)'="" S:$P($G(^DGCR(399,IBIFN,"U3")),U,4)'="" IBGO=$$LENOK("Last X-ray: "_$TR($$DATE^IBCF2($P(^DGCR(399,IBIFN,"U3"),U,4))," ","/"),.IB19)
 G:'IBGO BOX19Q
 ;
 I "^25^65^73^67^48^"[(U_IBSPEC_U) D
 . K IBXDATA D F^IBCEF("N-DATE LAST SEEN",,,IBIFN)
 . I IBXDATA'="" S IBID="",IBLSDT=$$DATE^IBCF2(IBXDATA,0,1) D  I IBLSDT'="" S IBGO=$$LENOK("Date Last Seen:"_IBLSDT_IBID,.IB19)
 .. ; Only print if specialty is OT or PT or proc for routine foot care
 .. D F^IBCEF("N-REFERRING PROVIDER ID",,,IBIFN) I IBXDATA'="" S IBID=" By:"_IBXDATA
 ;
 G:'IBGO BOX19Q
 K IBXDATA D F^IBCEF("N-HOMEBOUND",,,IBIFN)
 I IBXDATA G:'$$LENOK("Homebound",.IB19) BOX19Q
 ;
 K IBXDATA D F^IBCEF("N-ASSIGN OF BENEFITS INDICATOR",,,IBIFN)
 I "Nn0"[IBXDATA&(IBXDATA'="") G:'$$LENOK("Patient refuses to assign benefits",.IB19) BOX19Q
 ;
 I '$D(IBXSAVE(IBSUB)) D B24^IBCEF3(.IBXSAVE,IBIFN,$S($G(IBNOSHOW)=0:0,1:1))
 ;
 S (IBHAID,IBHOSP,IBXRAY)=0
 ;
 S Z=0 F  S Z=$O(IBXSAVE(IBSUB,Z)) Q:'Z  D  G:'IBGO BOX19Q
 . I $D(IBXSAVE(IBSUB,Z,"RX")),$P(IBXSAVE(IBSUB,Z,"RX"),U,3)="" S IBGO=$$LENOK("NOC Drug:"_$P(IBXSAVE(IBSUB,Z,"RX"),U,2)_" Units:"_+$P(IBXSAVE(IBSUB,Z,"RX"),U,6),.IB19)
 . ;
 . Q:'IBGO
 . I 'IBHAID,$P(IBXSAVE(IBSUB,Z),U,5)="V5010",$$COBCT^IBCEF(IBIFN)>1 D  Q
 .. S IBHAID=1,IBGO=$$LENOK("Testing for hearing aid",.IB19) Q
 . ;
 . Q:'IBGO
 . I 'IBHOSP,$P($G(IBXSAVE(IBSUB,Z,"AUX")),U,3) S IBHOSP=1,IBGO=$$LENOK("Attending physician,not hospice employee",.IB19) Q
 G:'IBGO BOX19Q
 K IBXDATA D F^IBCEF("N-SPECIAL PROGRAM",,,IBIFN)
 I IBXDATA=30 G:'$$LENOK("Medicare demonstration project for lung volume reduction surgery study",.IB19) BOX19Q
 ;
 G:'IBGO BOX19Q
NPRT K IBXDATA D F^IBCEF("N-HCFA 1500 BOX 19 RAW DATA",,,IBIFN)
 S IBREM=0
 I IBXDATA'="" G:'$$LENOK("Remarks:"_IBXDATA,.IB19) BOX19Q S IBREM=1
 K IBXDATA D F^IBCEF("N-BILL REMARKS",,,IBIFN)
 I IBXDATA'="" G:'$$LENOK($S('IBREM:"Remarks:",1:"")_IBXDATA,.IB19) BOX19Q
 ;
BOX19Q Q IB19
 ;
LENOK(IBDATA,IB19) ; Add text IBDATA to box 19 string (IB19 passed by ref)
 ; Check length of box 19 data - truncate at 96 (max length)
 ; Returns 0 if max length reached or exceeded, otherwise, 1
 N OK
 S OK=1
 S IB19=IB19_$S(IB19'="":" ",1:"")_$G(IBDATA)
 I $L(IB19)'<96 S OK=0,IB19=$E(IB19,1,96) G LENOKQ
LENOKQ Q OK
 ;
ASK19(IBIFN) ; Ask to display CMS-1500 box 19 data for current IBIFN
 N DIR,DIC,X,Y,DIE,DR,Z
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="DISPLAY THE FULL CMS-1500 BOX 19?: "
 D ^DIR
 I Y=1 S Z=$$BOX19(IBIFN) W !!,?4,"19",?20,$E(Z,1,32) W:$L(Z)>32 !,?4,$E(Z,33,80),!
 Q
 ;
ONLAB(IBIFN) ; Functions returns 1 if the bill IBIFN is outside non-lab
 N IBP,IBPUR
 S IBP=0
 S IBPUR=$P($G(^DGCR(399,IBIFN,"U2")),U,11)
 I IBPUR,"13"[IBPUR S IBP=1
 Q IBP
 ;
TEXT24(FLD,IBXSAVE,IBXDATA,IBSUB) ; Format the text line of box 24 by fld
 ; INPUT:
 ;   FLD = the letter of the field in box 24 (A-J)
 ;   IBXSAVE = passed by reference = extracted data for the box 24 lines
 ;   IBSUB = the subscript of the IBXSAVE array to use.
 ;           If null, use "BOX24"
 ; OUTPUT:
 ;   IBXDATA = passed by reference, set to the correct part of the
 ;             text that will print in the field's positions
 ;
 ; esg - 8/14/06 - modified for the new cms-1500 form - IB*2*348
 ;
 N Z,IBLINE,IBVAL,IBS,IBE,IBTEXT,IBAUX,IBDAT,IBZ,IBREN,IBRENQ,IBRENNPI,IBRENSID
 K IBXDATA
 S (IBLINE,Z)=0 S:$G(IBSUB)="" IBSUB="BOX24"
 ;
 I FLD="I"!(FLD="J") D   ; extract the Rendering provider data
 . I '$G(IBXIEN) Q       ; assume that the claim# exists
 . S IBREN=$$CFIDS^IBCEF77(IBXIEN)
 . S IBRENQ=$P(IBREN,U,1)    ; qual
 . S IBRENSID=$P(IBREN,U,2)  ; id
 . S IBRENNPI=$P(IBREN,U,3)  ; npi
 . Q
 ;
 F  S Z=$O(IBXSAVE(IBSUB,Z)) Q:'Z  D
 . S IBDAT=$G(IBXSAVE(IBSUB,Z))
 . S IBAUX=$G(IBXSAVE(IBSUB,Z,"AUX"))
 . S IBTEXT=$G(IBXSAVE(IBSUB,Z,"TEXT"))
 . S IBZ=$P(IBAUX,U,9)
 . I IBZ="" S IBZ="  "
 . S IBTEXT=IBZ_IBTEXT
 . ;
 . I $S($G(IBAC)=4:$S($D(IBXSAVE(IBSUB,Z,"ARX")):1,1:$D(IBXSAVE(IBSUB,Z,"A"))),$D(IBXSAVE(IBSUB,Z,"RX")):0,1:$G(IBNOSHOW)) S IBTEXT=""
 . ;
 . I FLD="AF" S IBVAL=$P(IBDAT,U),IBS=1,IBE=9 D   ; From date of service
 .. S IBVAL=$E(IBVAL,1,2)_" "_$E(IBVAL,3,4)_" "_$E(IBVAL,7,8)
 .. Q
 . ;
 . I FLD="AT" S IBVAL=$S($P(IBDAT,U,2):$P(IBDAT,U,2),1:$P(IBDAT,U)),IBS=10,IBE=18 D    ; To date of service
 .. S IBVAL=$E(IBVAL,1,2)_" "_$E(IBVAL,3,4)_" "_$E(IBVAL,7,8)
 .. Q
 . ;
 . I FLD="B" S IBVAL=$P(IBDAT,U,3),IBS=19,IBE=21   ; place of service
 . I FLD="C" S IBVAL=$S($P(IBDAT,U,13)=1:"Y",1:""),IBS=22,IBE=24   ; emergency indicator
 . I FLD="D" S IBVAL=$P(IBDAT,U,5),IBS=25,IBE=44 D   ; procedures and modifiers
 .. N M S M=$$MODLST^IBEFUNC($P(IBDAT,U,10))       ; modifier list
 .. S IBVAL=$$FO^IBCNEUT1(IBVAL,6)_"  "            ; procedure code
 .. S IBVAL=IBVAL_$$FO^IBCNEUT1($P(M,",",1),3)     ; mod#1
 .. S IBVAL=IBVAL_$$FO^IBCNEUT1($P(M,",",2),3)     ; mod#2
 .. S IBVAL=IBVAL_$$FO^IBCNEUT1($P(M,",",3),3)     ; mod#3
 .. S IBVAL=IBVAL_$$FO^IBCNEUT1($P(M,",",4),3)     ; mod#4
 .. Q
 . ;
 . I FLD="E" S IBVAL=$TR($P(IBDAT,U,7),","),IBS=45,IBE=48  ; diagnosis pointer
 . I FLD="F" S IBVAL=$P(IBDAT,U,8)*$P(IBDAT,U,9),IBS=49,IBE=57 D
 .. ; total charges
 .. S IBVAL=$$DOL^IBCEF77(IBVAL,9)
 .. Q
 . ;
 . I FLD="G" S IBVAL=$S($P(IBDAT,U,12):$P(IBDAT,U,12),1:$P(IBDAT,U,9)),IBS=58,IBE=61 D
 .. ; days or units or anesthesia minutes
 .. S IBVAL=$J(+IBVAL,4)
 .. Q
 . ;
 . ; columns H,I,J don't have any free text supplemental information
 . ;
 . I FLD="H" D     ; epsdt family plan
 .. S IBVAL=$P(IBAUX,U,7),IBS=0,IBE=0,IBTEXT=""   ; line 1 blank
 .. I IBVAL S IBVAL="Y"
 .. Q
 . I FLD="I" D     ; ID qualifier for rendering provider
 .. S IBVAL="",IBS=1,IBE=2   ; line 2 blank
 .. S IBTEXT=$G(IBRENQ)      ; qualifier on line 1
 .. Q
 . I FLD="J" D     ; rendering provider ID and NPI
 .. S IBTEXT=$G(IBRENSID),IBS=1,IBE=11   ; secondary ID line 1
 .. S IBVAL=$G(IBRENNPI)                 ; NPI# line 2
 .. Q
 . ;
 . S IBLINE=IBLINE+1                      ; top line
 . S IBXDATA(IBLINE)=$E(IBTEXT,IBS,IBE)   ; text in shaded area (top)
 . S IBLINE=IBLINE+1             ; bottom line
 . S IBXDATA(IBLINE)=IBVAL       ; field value in unshaded area (bottom)
 . Q
 ;
 Q
 ;
BILLSPEC(IBIFN,IBPRV) ;  Returns the specialty of the provider on bill IBIFN
 ; If IBPRV is supplied, returns the data for that provider, otherwise,
 ;  returns the specialty of the 'main/required' provider on the bill.
 ;  Default = 99 if no valid code found
 ; IBPRV = vp of provider (file 200 or 355.93)
 N Z,IBSPEC,IBINS,IBDT
 S IBSPEC="",IBPRV=$G(IBPRV)
 S IBDT=$P($G(^DGCR(399,+IBIFN,"U")),U,1)  ; use statement from date
 ;
 I $G(IBPRV) D  G SPECQ
 . S IBSPEC=$$SPEC^IBCEU(IBPRV,IBDT)
 ;
 ;Get rendering for professional, attending for institutional,
 S IBINS=($$FT^IBCEF(IBIFN)=3)
 D GETPRV^IBCEU(IBIFN,"ALL",.IBPRV)
 S Z=$S('IBINS:3,1:4)
 I $G(IBPRV(Z,1))'="" D
 . I $P(IBPRV(Z,1),U,3) S IBSPEC=$$SPEC^IBCEU($P($G(IBPRV(Z,1)),U,3),IBDT) Q:IBSPEC'=""
 . S Z0=+$O(^DGCR(399,IBIFN,"PRV","B",Z,0))
 . I Z0,$P($G(^DGCR(399,IBIFN,"PRV",Z0,0)),U,8)'="" S IBSPEC=$P(^(0),U,8)
 ;
SPECQ I IBSPEC="" S IBSPEC="99"
 Q IBSPEC
 ;
CHAMPVA(IBIFN) ; Returns 1 if the bill IBIFN has a CHAMPVA rate type
 Q $E($P($G(^DGCR(399.3,+$P($G(^DGCR(399,IBIFN,0)),U,7),0)),U),1,7)="CHAMPVA"
 ;
FAC(IBIFN) ; Obsolete function.  Used by old output formatter field and data element N-RENDERING INSTITUTION
 Q ""
 ;
MCR24K(IBIFN) ;Function returns MEDICARE id# for professional (CMS-1500) box 24k for bill IBIFN if appropriate
 Q $S($$FT^IBCEF(IBIFN)=2&$$MCRONBIL^IBEFUNC(IBIFN):"V"_$$MCRSPEC^IBCEU4(IBIFN,1)_$P($$SITE^VASITE,U,3),1:"")
