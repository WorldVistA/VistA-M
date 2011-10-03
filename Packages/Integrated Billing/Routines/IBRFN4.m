IBRFN4 ;ALB/TMK - Supported functions for AR/IB DATA EXTRACT ;15-FEB-2005
 ;;2.0;INTEGRATED BILLING;**301,305,389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
IBAREXT(IBIFN,IBD) ; Returns data for claim IBIFN for IB/AR Extract
 ; Data returned (pieces):
 ; 1-MEDICARE Status (0=not MRA secondary, 1=MRA secondary)
 ; 2-Last MRA requested date "S";7 (7 - INTERNAL)
 ; 3-Last Electronic extract date  "TX";2 (21 - INTERNAL)
 ; 4-Printed via EDI  "TX";7  (26 - EXTERNAL)
 ; 5-Force Claim to Print  "TX";8  (27 - EXTERNAL)
 ; 6-Claim MRA Status  "TX";5  (24 - EXTERNAL)
 ; 7-MRA recorded date  "TX";3  (22 - INTERNAL)
 ; 8-Bill cancelled date  "S";17  (17 - INTERNAL)
 ; 9-form type  0;19   (.19 - EXTERNAL)
 ; 10-Current Payer  $$CURR^IBCEF2(IBIFN) returns IEN;NAME (file 36)
 ; 11-DRG 0;8==> file 45 (9 - EXTERNAL)
 ; 12-ECME #  "M1";8 (460 - EXTERNAL)
 ; 13-NON-VA Facility
 ; 14-#Days Site Not Responsible for MRA ($$DAYS(IBIFN))
 ; 15-National VA id number for Ins Verification (365.12;.02 - INTERNAL)
 ; 16-Payer name (file 365.12;.01)
 ; 17-Offset Amount (202-INTERNAL)
 ;
 ; IBD("PRD",seq #)=prosthetic item name^date^bill ien
 ; IBD("IN")= TYPE OF PLAN NAME ^ GROUP NUMBER ^ RELATIONSHIP TO INSURED
 ;   ^ SOURCE OF INFO ^ EDI ID NUMBER - INST ^ EDI ID NUMBER - PROF
 ;   ^ INSURANCE REIMBURSE
 ; IBD("IN","MMA")= MAILING STREET ADDRESS [LINE 1] ^
 ;   ^ MAILING STREET ADDRESS [LINE 2] ^ CITY ^ STATE NAME  ^  ZIP
 ;
 N IB,IBI,IBJ,IBK,IBX,IBNODE,IBTMP,IBIN,Z
 F IBNODE=0,"S","TX","M","U1" S IB(IBNODE)=$G(^DGCR(399,IBIFN,IBNODE))
 S IBD=$S($$MRASEC^IBCEF4(IBIFN):1,1:0)
 S $P(IBD,U,2)=$P(IB("S"),U,7),$P(IBD,U,3)=$P(IB("TX"),U,2)
 S $P(IBD,U,4)=$$GET1^DIQ(399,IBIFN_",",26,"E"),$P(IBD,U,5)=$$GET1^DIQ(399,IBIFN_",",27,"E")
 S $P(IBD,U,6)=$$GET1^DIQ(399,IBIFN_",",24,"E"),$P(IBD,U,7)=$P(IB("TX"),U,3)
 S $P(IBD,U,8)=$P(IB("S"),U,17),$P(IBD,U,9)=$$GET1^DIQ(399,IBIFN_",",.19,"E")
 S Z=$$CURR^IBCEF2(IBIFN),$P(IBD,U,10)=Z_$S(Z:";"_$P($G(^DIC(36,Z,0)),U),1:"")
 S Z=$P($G(^DIC(36,+Z,3)),U,10),$P(IBD,U,15)=$P($G(^IBE(365.12,+Z,0)),U,2),$P(IBD,U,16)=$P($G(^(0)),U)
 S Z=$P(IB(0),U,8),$P(IBD,U,11)=$S(Z:$$GET1^DIQ(45,Z_",",9,"E"),1:"")
 S $P(IBD,U,12)=$$GET1^DIQ(399,IBIFN_",",460,"E")
 S Z=$P($G(^DGCR(399,IBIFN,"U2")),U,10),$P(IBD,U,13)=$S(Z:$P($G(^IBA(355.93,Z,0)),U,1),1:"")
 ;
 S $P(IBD,U,14)=$$DAYS(IBIFN)
 S $P(IBD,U,17)=$P(IB("U1"),U,2)
 ;
 K IBTMP D SET^IBCSC5B(IBIFN,.IBTMP)
 S (IBI,IBJ)=0 F  S IBI=$O(IBTMP(IBI)) Q:'IBI  D
 . S IBK=0 F  S IBK=$O(IBTMP(IBI,IBK)) Q:'IBK  D
 .. S IBX=IBTMP(IBI,IBK)
 .. S IBJ=IBJ+1
 .. S IBD("PRD",IBJ)=$$PINB^IBCSC5B(+IBX)_U_IBI_U_+IBTMP
 ;
 S Z=" ",IBD("IN")="",DFN=+$P(IB(0),U,2)
 F  S Z=$O(^DPT(DFN,.312,Z),-1) Q:Z=""  D  Q:Z=""
 . S IBIN=$G(^DPT(DFN,.312,Z,0))
 . I +IB("M")=+IBIN D
 .. N IBQ,IBP
 .. S IBP=+$P(IBIN,U,18),IBQ=$G(^IBA(355.3,+IBP,0))
 .. S IBD("IN")=$S($P(IBQ,U,9):$$GET1^DIQ(355.3,IBP_",",.09,"E"),1:"")_U_$P(IBQ,U,4)_U_$P(IBIN,U,6)_U_$P($G(^DPT(DFN,.312,Z,1)),U,9)
 .. S Z=""
 ;
 S Z=$G(^DIC(36,+IB("M"),3))
 S $P(IBD("IN"),U,5)=$P(Z,U,4),$P(IBD("IN"),U,6)=$P(Z,U,2)
 S $P(IBD("IN"),U,7)=$$GET1^DIQ(36,+IB("M")_",",1,"I")
 S Z=$G(^DIC(36,+IB("M"),.11))
 S IBD("IN","MMA")=$P(Z,U,1)_U_$P(Z,U,2)_U_$P(Z,U,4)_U_$S($P(Z,U,5):$P($G(^DIC(5,$P(Z,U,5),0)),U,1),1:"")_U_$P(Z,U,6)
 ;
 Q IBD
 ;
IBACT(IBIFN,IBARRY) ; Returns IB actions for bill ien IBIFN
 ;IBARRY should be passed by reference and returns:
 ;
 ; IBARRY(seq)=AR bill #^reference #^external STATUS^IB ACTION TYPE NAME
 ;             ^UNITS^TOTAL CHARGE^DT BILLD FROM^DT BILLD TO^AR BILL IEN
 ;             ^DT ENTRY ADDED^PATIENT SSN^EVENT DATE^RESULTING FROM
 ;             ^INSTITUTION IEN
 ;
 N IBNA,IB,IB0,DFN,IBCT,Z
 S IBNA=$$BN1^PRCAFN(IBIFN),IB="",IBCT=0
 F  S IB=$O(^IB("ABIL",IBNA,IB)) Q:IB=""  D
 . S IBCT=IBCT+1
 . S IB0=$G(^IB(IB,0))
 . I $G(DFN)="" S DFN=$P(IB0,U,2)
 . ;
 . S IBARRY=IBNA_U_$P(IB0,U,1)_U_$$GET1^DIQ(350,IB_",",.05,"E")
 . S Z=$P(IB0,U,3)
 . S IBARRY=IBARRY_U_$S(Z'="":$P($G(^IBE(350.1,Z,0)),U,1),1:"")
 . S IBARRY=IBARRY_U_$P(IB0,U,6) ; UNITS
 . S IBARRY=IBARRY_U_$P(IB0,U,7) ; TOTAL CHARGE
 . S IBARRY=IBARRY_U_$P(IB0,U,14) ; DT BILLD FROM
 . S IBARRY=IBARRY_U_$P(IB0,U,15) ; DT BILLD TO
 . S IBARRY=IBARRY_U_$P(IB0,U,11) ; AR BILL #
 . S IBARRY=IBARRY_U_$P($P($G(^IB(IB,1)),U,2),".",1) ; DT ENTRY ADDED
 . S IBARRY=IBARRY_U_$P(^DPT(DFN,0),U,9) ; SSN
 . S IBARRY=IBARRY_U_$P(IB0,U,17) ; EVENT DT
 . S IBARRY=IBARRY_U_$P(IB0,U,4) ;RESULTING FROM
 . S IBARRY=IBARRY_U_$P(IB0,U,13) ; Institution
 . S IBARRY(IBCT)=IBARRY,IBARRY=""
 Q
 ;
PREREG(IBBDT,IBEDT) ;Returns Pre-registration data
 N IBDATA
 S IBDATA=$$IBAR^IBJDIPR(IBBDT,IBEDT)
 Q IBDATA
 ;
BUFFER(IBBDT,IBEDT) ;Returns Buffer data
 N IBDATA
 S IBDATA=$$IBAR^IBCNBOA(IBBDT,IBEDT)
 Q IBDATA
 ;
DAYS(IBIFN) ; Returns # days site not responsible for MRA
 N X,X1,X2,D0
 S X="" ;No. of days
 G:'$P(IBD,U,2) DAYSQ
 S X2=$P(IBD,U,2) ;MRA Request Date
 S X1=$P(IBD,U,7) ;MRA Recorded Date
 G:'$$MRASEC^IBCEF4(IBIFN) DAYSQ ; Not MEDICARE secondary
 I 'X1!(X1<X2) S X1=DT
 D ^%DTC
DAYSQ Q X
 ;
REJ(IBIFN) ; Returns 1 if any rejects found for MRA secondary claim or for
 ; any preceding claims it was cancelled/cloned from
 N X,Y,I,X1,X2,X3,D0,CURSEQ
 S Y=0 ;Y=REJECT FLAG
 G:'$$MRASEC^IBCEF4(IBIFN) REJQ ; Not MEDICARE secondary
 S CURSEQ=$$COBN^IBCEF(IBIFN),X1=+$P($G(^DGCR(399,IBIFN,0)),U,15)
 S D0=IBIFN
 F  D  Q:'D0!Y
 . ; claim copied from not cancelled and not MRA secondary claim
 . I X1,$P($G(^DGCR(399,X1,0)),U,13)'=7,X1'=IBIFN S D0="" Q
 . I X1,$P($G(^DGCR(399,X1,0)),U,19)'=$P($G(^DGCR(399,D0,0)),U,19) S D0="" Q
 . S I=0 F  S I=$O(^IBM(361,"B",D0,I)) Q:'I  D  Q:Y
 .. S X2=$G(^IBM(361,I,0))
 .. Q:$P(X2,U,3)'="R"!'$P(X2,U,11)  ;No reject or no transmit bill
 .. S X3=$TR($P($G(^IBA(364,+$P(X2,U,11),0)),U,8),"PST","123") ;status msg seq
 .. Q:X3'=(CURSEQ-1)
 .. S Y=1
 . I 'Y S D0=X1,X1=+$P($G(^DGCR(399,X1,0)),U,15) S:X1=D0 D0="" Q
REJQ Q Y
