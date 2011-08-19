IBCF2 ;ALB/ARH - HCFA 1500 19-90 DATA (gather demographics) ;12-JUN-93
 ;;2.0;INTEGRATED BILLING;**17,52,88,122,51,137**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DEV ; IBIFN required
 N IBF
 S IBFT=$$FTN^IBCU3(2),IBF=$P($G(^IBE(353,+IB,2)),U,8)
 S:IBF="" IBF=2 ;Forces the use of the output formatter to print bills
 D ENFMT^IBCF(IBIFN,2,IBF)
 K IBFT
 Q
 ; Obsolete calls to print bill routines follows
 S %ZIS="Q",%ZIS("A")="Output Device: "
 S %ZIS("B")=$P($G(^IBE(353,+$P($G(^DGCR(399,IBIFN,0)),"^",19),0)),"^",2)
 D ^%ZIS G:POP Q
 I $D(IO("Q")) S ZTRTN="EN^IBCF2",ZTDESC="PRINT HCFA1500",ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q") D HOME^%ZIS G Q
 U IO D EN
Q I '$D(ZTQUEUED) D ^%ZISC
 Q
 ;
EN ;begin gathering data for printing of HCFA 1500
 ;IBIFN must be defined
 K IBFLD,IBZ
 S IB(0)=$G(^DGCR(399,IBIFN,0)) Q:IB(0)=""
 S DFN=+$P(IB(0),U,2) Q:'$D(^DPT(DFN,0))  D ARRAY
 S IBJ=1 S:'$D(IBPNT) IBPNT=0 S IBXIEN=IBIFN D F^IBCEF("N-PRINT BILL SUBMIT STATUS","IBZ") S IBFLD(0,1)=IBZ,IBJ=IBJ+1
MAIL F IBI="M","M1" S IB(IBI)=$G(^DGCR(399,IBIFN,IBI))
 S IBFLD(0,IBJ)=$P(IB("M"),U,4),IBJ=IBJ+1
 F IBI=$P(IB("M"),U,5),$P(IB("M"),U,6),$P(IB("M1"),U,1) I IBI'="" S IBFLD(0,IBJ)=IBI S IBJ=IBJ+1
 K Y S Y=$P(IB("M"),U,9) D ZIPOUT^VAFADDR
 S IBFLD(0,IBJ)=$P(IB("M"),U,7)_", "_$$STATE(+$P(IB("M"),U,8))_" "_Y
 K Y
 ;
PAT D DEM^VADPT
 S IBFLD("1A")=$P(VADM(2),U,2) ; ssn
 S IBFLD(2)=VADM(1) ; patient name
 S IBFLD("3D")=$$DATE(+VADM(3),1) ; date of birth
 S IBFLD("3X")=$P(VADM(5),U,1) ; sex (m/f)
 S IBFLD("8M")=$S("146"[+VADM(10):"S","25"[+VADM(10):"M",1:"O") ;marital status
 K VADM,VA
 S X=+$P($G(^DPT(DFN,.311)),U,15),IBFLD("8E")=$S(",1,2,4,6,"[X:"E",1:"") ;employed?
 S IBSPE=+$P($G(^DPT(DFN,.25)),U,15),IBSPE=$S(",1,2,4,6,"[IBSPE:"E",1:"") ; spouse employed?
 ;
PATADD D ADD^VADPT
 S IBFLD(5,1)=VAPA(1)_" "_VAPA(2)_" "_VAPA(3) ;patient's street address
 S IBFLD(5,2)=VAPA(4),IBFLD(5,3)=$P(VAPA(11),U,2) ;patient's city, zip
 S IBFLD("5S")=$$STATE(+VAPA(5)) ; patient's state
 S IBFLD("5T")=VAPA(8) ; patients phone number
 K VAPA
 ;
NEXT D ^IBCF21 ; gather remaining data
 ;
PRINT D ^IBCF2P ; print
 ;
END ;set print status
 I $G(IBXERR)="",'$G(IBXPARM("TEST")),'$$NEEDMRA^IBEFUNC(IBIFN) D
 .S (DIC,DIE)=399,DA=IBIFN,DR="[IB STATUS]",IBYY=$S($P($G(^DGCR(399,IBIFN,"S")),U,12)="":"@92",1:"@94") D ^DIE K DIC,DIE,IBYY,DA,DR
 .D BSTAT^IBCDC(IBIFN) ; remove from AB list
 ;
 K DFN,IB,IBI,IBJ,IBK,IBX,IBY,IBSPE,IBFLD,IBFL,IBDXI,X,Y,VAERR
 Q
 ;
ARRAY ;
 F IBI=1:1:6 S IBFLD(0,IBI)=""
 F IBI=1:1:21,23:1:26,28:1:33 S IBFLD(IBI)=""
 F IBI=10,16,18 F IBJ="A","B" S IBFLD(IBI_IBJ)=""
 F IBI="10BS","10C","11AX","11B","11C","11D","1A","3D","3X","5S","5T","8E","8M","9A","9BD","9BX","9C","9D","17A" S IBFLD(IBI)=""
 Q
 ;
DATE(X,Y2K,NULL) ; returns date in form format
 ; X = date in FM format,  Y2K = 1 if 4 digit year required
 ; If NULL = 1, then the delimiter should be null, not space
 ; Format is MM DD YY or MMDDYY or MM DD YYYY or MMDDYYYY
 N IBDELIM
 S Y2K=+$G(Y2K) S:Y2K>1 Y2K=1
 S IBDELIM=$S('$G(NULL):" ",1:"")
 Q $S(X:$E(X,4,5)_IBDELIM_$E(X,6,7)_IBDELIM_$S($G(Y2K):$E(X,1,3)+(Y2K*1700),1:$E(X,2,3)),1:X)
 ;
STATE(X) ; returns 2 letter abbreviation for state pointer
 Q $P($G(^DIC(5,+X,0)),U,2)
 ;
ENF ;Output the bill via formatter
 N Z
 S Z=$$EXTRACT^IBCEFG(2,IBIFN)
 Q
 ;
NAME31(IBIFN,IBZNM) ; Returns the name of the provider
 ;   formatted to print in Box 31 on the HCFA 1500.  Max length is 21
 ; IBZNM = PROVIDER NAME in last,first<space>middle^file 200 ien^cred
 N IBXDATA,IBZ,IBNM,IBMID,IBMIDI,IB1,IB2
 I '$D(^DGCR(399,IBIFN,"PRV",0)) S IBNM=$E($P($G(IBZNM),U),1,21) G NAMEQ
 I $G(IBZNM)="" D  ;
 . D F^IBCEF("N-ATT/REND PHYSICIAN NAME","IBZNM",,IBIFN)
 S IBNM=$$NAME^IBCEFG1($P(IBZNM,U,1,2)) ;returns last^first^middle
 S IB1=$P(IBNM,U,2),IB2=$P(IBNM,U),IBMID=$S($P(IBNM,U,3)'="":" "_$P(IBNM,U,3)_" ",1:" "),IBMIDI=$E($P(IBNM,U,3))_" "
 ;
 I $L(IB2)>21 S IBNM=$E(IB2,1,21) G NAMEQ ; Last name truncated
 S IBNM=IB1_IBMID_IB2 ; First-name middle-name last-name
 ; Trim it to 21 characters according to formula
 I $L(IBNM)'>21 G NAMEQ ; First-init middle-init last-name
 S IBNM=$E(IB1)_IBMIDI_IB2
 I $L(IBNM)'>21 G NAMEQ ; Last-name only
 S IBNM=IB2
 ;
NAMEQ Q IBNM
 ;
DATE31(IBDT,IBIFN) ; Returns date to print in box 31 of HCFA 1500
 ;  Either first print date (IBDT) or today's date if never printed
 I $G(IBIFN),'$D(^DGCR(399,IBIFN,"PRV",0)) Q ""
 I IBDT="" S IBDT=DT
 Q $$FMTE^XLFDT(IBDT,"5D")
 ;
