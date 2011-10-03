IBCEF74A ;ALB/ESG - Provider ID maint ?ID continuation ;7 Mar 2006
 ;;2.0;INTEGRATED BILLING;**320,343,349,395,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EN(IBIFN,IBQUIT) ; Display billing provider and service provider IDs as part
 ; of the ?ID display/help in the billing screens.
 ; Called from DISPID^IBCEF74.
 NEW IBID,IBX,Z,ZI,ZN,SEQ,PSIN,DATA,QUALNM,IDNUM,FACNAME,IBZ,ORGNPI,BPZ,BPNAME,BPNPI,BPTAX,SFNPI,SFTAX
 ;
 D ALLIDS^IBCEF75(IBIFN,.IBID)
 ;
 ; Re-sort array by insurance sequence (P/S/T)
 K IBX
 F Z="BILLING PRV","LAB/FAC" F ZI="C","O" S ZN=0 F  S ZN=$O(IBID(Z,IBIFN,ZI,ZN)) Q:'ZN  D
 . S SEQ=$P($G(IBID(Z,IBIFN,ZI,ZN)),U,1) Q:SEQ=""
 . S IBX(Z,SEQ,ZI,ZN)=""
 . Q
 ;
 ; Display billing provider information - IB*2*400
 S BPZ=$$B^IBCEF79(IBIFN)
 D GETBP^IBCEF79(IBIFN,"",+BPZ,"?ID",.IBZ)
 S ORGNPI=$$ORGNPI^IBCEF73A(IBIFN)
 I ($Y+5)>IOSL S IBQUIT=$$NOMORE^IBCEF74() I IBQUIT G EX
 W !!,"Billing Provider Name and ID Information"
 S BPNAME=$G(IBZ("?ID","NAME"))
 I BPNAME="" S BPNAME="***MISSING***"
 I ($Y+5)>IOSL S IBQUIT=$$NOMORE^IBCEF74() I IBQUIT G EX
 W !,"Billing Provider:  ",BPNAME
 ;
 S BPNPI=$P(ORGNPI,U,3)
 I BPNPI="" S BPNPI="***MISSING***"
 I ($Y+5)>IOSL S IBQUIT=$$NOMORE^IBCEF74() I IBQUIT G EX
 W !?5,"Billing Provider NPI:  ",BPNPI
 ;
 S BPTAX=$$NOPUNCT^IBCEF($P($G(^IBE(350.9,1,1)),U,5),1)
 I BPTAX="" S BPTAX="***MISSING***"
 I ($Y+5)>IOSL S IBQUIT=$$NOMORE^IBCEF74() I IBQUIT G EX
 W !?5,"Billing Provider Tax ID (VistA Record PRV):  ",BPTAX
 ;
 ; Display billing provider secondary ID's (current ins only)
 I ($Y+5)>IOSL S IBQUIT=$$NOMORE^IBCEF74() I IBQUIT G EX
 W !?5,"Billing Provider Secondary IDs (VistA Record CI1A):"
 S Z="BILLING PRV"
 D SECID(Z,.IBQUIT)
 I IBQUIT G EX
 ;
 ; Now display the lab or facility primary and secondary IDs
 ; This is the service facility information
 ; IB*2*400 - check to make sure there is a service facility
 ;
 I $P(BPZ,U,3)="" G EX     ; no service facility information to display
 ;
 ; Service facility name, similar code as found in SUB-2
 I ($Y+5)>IOSL S IBQUIT=$$NOMORE^IBCEF74() I IBQUIT G EX
 W !!,"Service Facility Name and ID Information"
 ;
 ; Display note if ins co flag to suppress lab/fac data is set (only applies in switchback mode)
 I '$$SENDSF^IBCEF79(IBIFN) D  I IBQUIT G EX
 . I ($Y+5)>IOSL S IBQUIT=$$NOMORE^IBCEF74() Q:IBQUIT
 . W !!,"Note:  Service Facility Data not sent for Current Insurance"
 . W !,"       'Send VA Lab/Facility IDs or Facility Data for VAMC?' is set to NO",!
 . Q
 ;
 S FACNAME=$$GETFAC^IBCEP8(+$P(BPZ,U,4),$P(BPZ,U,3),0)
 I FACNAME="" S FACNAME="***MISSING***"
 I ($Y+5)>IOSL S IBQUIT=$$NOMORE^IBCEF74() I IBQUIT G EX
 W !?5,"Facility:  ",FACNAME
 ;
 S SFNPI=$P(ORGNPI,U,1)
 I SFNPI="" S SFNPI="***MISSING***"
 I ($Y+5)>IOSL S IBQUIT=$$NOMORE^IBCEF74() I IBQUIT G EX
 W !?5,"Lab or Facility NPI:  ",SFNPI
 ;
 S SFTAX=$$NOPUNCT^IBCEF($$EIN^IBCEP8A(IBIFN),1)
 I SFTAX="" S SFTAX="***MISSING***"
 I ($Y+5)>IOSL S IBQUIT=$$NOMORE^IBCEF74() I IBQUIT G EX
 W !?5,"Lab or Facility Tax ID (VistA Record SUB):  ",SFTAX
 ;
 ; lab/fac secondary IDs
 I ($Y+5)>IOSL S IBQUIT=$$NOMORE^IBCEF74() I IBQUIT G EX
 W !?5,"Lab or Facility Secondary IDs (VistA Records SUB1,SUB2,OP3,OP6,OP7):"
 S Z="LAB/FAC"
 D SECID(Z,.IBQUIT)
 I IBQUIT G EX
 ;
EX ;
 Q
 ;
QUAL(Z,FORMTYPE) ; turn the qualifier code into a qualifier description
 NEW QUAL,IEN
 S QUAL=""
 I $G(Z)="" G QUALX
 I Z="1C" D  G QUALX   ; qualifier for Medicare Part ?
 . I $G(FORMTYPE)=2 S QUAL="MEDICARE PART B"   ; 1500
 . I $G(FORMTYPE)=3 S QUAL="MEDICARE PART A"   ; ub
 . Q
 I Z=34 S Z="SY"       ; qualifier for SSN
 S IEN=+$O(^IBE(355.97,"C",Z,"")) I 'IEN G QUALX
 S QUAL=$P($G(^IBE(355.97,IEN,0)),U,1)
QUALX ;
 Q QUAL
 ;
SECID(Z,IBQUIT) ; Display secondary ID and qualifier information
 ; Z is the type of IDs passed in; either BILLING PRV or LAB/FAC
 ; IBQUIT is returned if passed by reference
 NEW SEQ,ZI,ZN,PSIN,DATA,QUALNM,IDNUM,NODATA
 S IBQUIT=0,NODATA=1
 F SEQ="P","S","T" D  Q:IBQUIT
 . ;
 . ; current ins only for billing provider secondary IDs
 . I Z="BILLING PRV",SEQ'=$$COB^IBCEF(IBIFN) Q
 . S ZI=""
 . F  S ZI=$O(IBX(Z,SEQ,ZI)) Q:ZI=""  D  Q:IBQUIT
 .. S ZN=0
 .. F  S ZN=$O(IBX(Z,SEQ,ZI,ZN)) Q:'ZN  D  Q:IBQUIT
 ... S PSIN=0   ; start at 0 to skip primary IDs
 ... F  S PSIN=$O(IBID(Z,IBIFN,ZI,ZN,PSIN)) Q:PSIN=""  D  Q:IBQUIT
 .... S DATA=$G(IBID(Z,IBIFN,ZI,ZN,PSIN))
 .... S QUALNM=$$QUAL($P(DATA,U,1),$$FT^IBCEF(IBIFN))
 .... S IDNUM=$P(DATA,U,2)
 .... I ($Y+5)>IOSL S IBQUIT=$$NOMORE^IBCEF74() Q:IBQUIT
 .... S NODATA=0
 .... W !?8,"(",SEQ,") ",QUALNM,?40,IDNUM
 .... I Z="LAB/FAC",$D(^DGCR(399,IBIFN,"I2")),SEQ=$$COB^IBCEF(IBIFN) W ?54,"<<<Current Ins"
 .... I Z="BILLING PRV",PSIN=1 W ?54,"<<<System Generated ID"
 .... Q
 ... Q
 .. Q
 . Q
 I NODATA,'IBQUIT W !?8,"(-) None Found"
SECIDX ;
 Q
 ;
