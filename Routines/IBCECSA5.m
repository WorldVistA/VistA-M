IBCECSA5 ;ALB/CXW - VIEW EOB SCREEN ;01-OCT-1999
 ;;2.0;INTEGRATED BILLING;**137,135,263,280,155,349**;21-MAR-1994;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; -- main entry point for VIEW EOB
 N VALMCNT,VALMBG,VALMHDR
 S VALMCNT=0,VALMBG=1
 D EN^VALM("IBCEM VIEW EOB")
 Q
 ;
INIT ; -- init variables and list array
 I '$G(IBIFN) S VALMQUIT="" G INITQ    ; bill# is required
 D HDR^IBCEOB2                         ; build the VALMHDR array
 K IBCNT,IBONE,^TMP("IBCECSD",$J)      ; kill vars and scratch global
 ;
 ; 8/13/03 - If variable IBEOBIFN is set, then this is the 361.1 ien
 ;           that the user selected from a list.  Build the detail.
 I $G(IBEOBIFN) S IBCNT=IBEOBIFN,IBONE=1 D BLD^IBCECSA6 G INITQ
 ;
 D BLD^IBCEOB2   ; build ^TMP("IBCEOB",$J) containing MRA/EOB lister
 S IBONE=0
 M ^TMP("IBCECSD",$J)=^TMP("IBCEOB",$J)
 ;
 ; 4/7/03 - If only 1 EOB record found for this bill, then set the
 ;          IBCNT variable, the IBONE one-time flag, and build the
 ;          detail sections of this list.
 I $G(VALMCNT)=1 S IBCNT=$P($G(^TMP("IBCECSD",$J,1)),U,2),IBONE=1 I IBCNT D BLD^IBCECSA6
 ;
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCECSD",$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
MIN ;
 N IBREC1,IBRM1,IBRM2,IBRM3,IBRM4,IBRM5,IBRL,IBTYPE,IBT,IBTX,IBD
 ; flag for inpatient mra
 S IBTYPE=$S($G(IBSRC):1,$$INPAT^IBCEF(+IBREC):1,1:0)
 ;
 S IB=$$SETSTR^VALM1("MEDICARE INFORMATION:","",1,50)
 D SET(IB)
 I '$G(IBSRC) D
 . D CNTRL^VALM10(VALMCNT,1,21,IORVON,IORVOFF)
 . S ^TMP("IBCECSD",$J,"X",5)=VALMCNT
 I $G(IBSRC),'$D(^IBM(361.1,IBCNT,4)) Q
 I '$G(IBSRC),'$$INPAT^IBCEF(+IBREC) Q
 D SET(" INPATIENT:")
 S IBREC1=$G(^IBM(361.1,IBCNT,4)),(IB,IBRL)=""
 ;
 F IBT=2:1 S IBTX=$P($T(MINDAT+IBT),";",3) Q:IBTX=""  D
 . S IBD=$P(IBREC1,"^",+IBTX)
 . I $L($P(IBTX,"^",4)) X $P(IBTX,"^",4) E  N IBFULL S IBFULL=1
 . I $S(IBFULL:1,1:IBD) D
 .. I $L($P(IBTX,"^",4)) X $P(IBTX,"^",4) I  Q
 .. X "S IBD="_$S($L($P(IBTX,"^",3)):$P(IBTX,"^",3),1:"$$A10(IBD)")
 .. S IB=$$SETSTR^VALM1($P(IBTX,"^",2)_IBD,IB,$S('IBRL:4,1:37),$S('IBRL:41,1:38))
 .. S IBRL=$S(IBRL:0,1:1)
 .. I 'IBRL D SET(IB,IBRL) S IB=""
 ;
 D:IBRL'="" SET(IB)
 D REMARK
 Q
 ;
MINDAT ; data for MIN tag
 ; format:  piece^lable^special format code^special decision for disp
 ;;1^Cov Days/Visit Ct  : ^$$RJ(+IBD)^I $G(IBSRC)
 ;;3^Claim DRG Amt      : 
 ;;2^Lifetm Psych Dy Ct : ^$$RJ(IBD)
 ;;5^Disprop Share Amt  : ^^I IBTYPE
 ;;4^Cap Exception Amt  : 
 ;;7^PPS Capital Amt    : ^^I IBTYPE
 ;;6^MSP Pass Thru Amt  : 
 ;;9^PPS Cap HSP-DRG Amt: ^^I IBTYPE
 ;;8^PPS Cap FSP-DRG Amt: ^^I IBTYPE
 ;;11^Old Capital Amt    : ^^I IBTYPE
 ;;10^PPS Cap DSH-DRG Amt: ^^I IBTYPE
 ;;13^PPS Op Hos DRG Amt : 
 ;;12^PPS Capital IME Amt: ^^I IBTYPE
 ;;15^PPS Op Fed DRG Amt : ^^I IBTYPE
 ;;14^Cost Report Day Ct : ^$$RJ(IBD)^I IBTYPE
 ;;17^Indirect Teach Amt : ^^I IBTYPE
 ;;16^PPS Cap Outlier Amt: ^^I IBTYPE
 ;;18^Non-Pay Prof Comp  : ^$$RJ(IBD)
 ;;19^Non-Covered Days Ct: ^$$RJ(+IBD)^I IBTYPE
 ;;
 ;
REMARK ; set up remarks and line level details
 N IBREC1,IBP,IBT,IBX,RCODE,RDESC,REXIST
 Q:$G(IBREM)  S IBREM=1
 D SET(" ")
 D SET(" Claim Level Remark Information")
 D SET("   Code     Description")
 I '$G(IBSRC) D
 . D CNTRL^VALM10(VALMCNT,4,4,IOUON,IOUOFF)
 . D CNTRL^VALM10(VALMCNT,13,11,IOUON,IOUOFF)
 . Q
 ;
 S IBREC1=$P($G(^IBM(361.1,IBCNT,3)),U,3,7)
 I $P(IBREC1,U,1)="" S IBREC1=$P($G(^IBM(361.1,IBCNT,5)),U,1,5)
 S REXIST=0
 ;
 F IBP=1:1:5 D
 . S RCODE=$P(IBREC1,U,IBP)
 . S RDESC=$G(^IBM(361.1,IBCNT,"RM"_IBP))
 . I RCODE="",RDESC="" Q
 . S REXIST=1
 . K IBT
 . S IBT(IBP)=RDESC
 . D TXT1(.IBT,0,60)
 . D SET("   "_$$LJ^XLFSTR(RCODE,6)_"-  "_$G(IBT(1)))
 . S IBX=1
 . F  S IBX=$O(IBT(IBX)) Q:'IBX  D SET($J("",12)_IBT(IBX))
 . Q
 ;
 I 'REXIST D SET("   No claim level remarks on file")
 D SET(" ")
 Q:$G(IBSRC)  ; MRA Only
 ;
MRALLA S IB=$$SETSTR^VALM1("LINE LEVEL ADJUSTMENTS:","",1,50)
 D SET(IB)
 I '$G(IBSRC) D
 . D CNTRL^VALM10(VALMCNT,1,23,IORVON,IORVOFF)
 . S ^TMP("IBCECSD",$J,"X",7)=VALMCNT
 I '$D(^IBM(361.1,IBCNT,15,0)) D SET("NONE") Q  ; only if there is info
 ;
 ; look up all billed data
 N IBZDATA,IBFORM,IBX2,IBX3,IBREC2,IBREC3,IBTX,IBT,IBRC,IBZ,IBTXL
 S IBFORM=0                             ; cms-1500
 I $$FT^IBCEF(+IBREC)=3 S IBFORM=1      ; UB-04
 D F^IBCEF("N-"_$S(IBFORM:"UB-04",1:"HCFA 1500")_" SERVICE LINE (EDI)","IBZDATA",,+IBREC)
 ;
 S IBX=0 F  S IBX=$O(^IBM(361.1,IBCNT,15,IBX)) Q:IBX<1  S IBREC1=^IBM(361.1,IBCNT,15,IBX,0) D
 . NEW RVL
 . D SET("  #   SV DT   REVCD  PROC  MOD  UNITS  BILLED  DEDUCT  COINS    ALLOW     PYMT")
 . S RVL=+$P(IBREC1,U,12)       ; referenced Vista line#
 . I 'RVL S RVL=IBX             ; use the EOB line# if not there
 . S IBT=$$RJ($P(IBREC1,"^"),3) ;             line number
 . S IBT=IBT_" "_$$DAT1^IBOUTL($P($P(IBREC1,"^",16),".")) ; service date
 . S IBT=IBT_" "_$$RJ($$EXTERNAL^DILFD(361.115,.1,"",$P(IBREC1,"^",10)),6) ;                                                revcd
 . S IBT=IBT_" "_$$RJ($P(IBREC1,"^",4),5) ;   procedure
 . S IBT=IBT_" "_$$RJ($P($G(^IBM(361.1,IBCNT,15,IBX,2,1,0)),"^"),3)_$S($D(^IBM(361.1,IBCNT,15,IBX,2,2,0)):"+",1:" ") ;      modifiers
 . S IBT=IBT_" "_$$RJ($FN($P(IBREC1,"^",11),"",0),5) ; units
 . S IBT=IBT_" "_$$RJ($FN($S(IBFORM:$P($G(IBZDATA(RVL)),"^",5),1:$P($G(IBZDATA(RVL)),"^",8)*$P($G(IBZDATA(RVL)),"^",9)),"",2),8) ;    billed
 . S IBT=IBT_" "_$$RJ($FN($P($G(^IBM(361.1,IBCNT,15,IBX,1,+$O(^IBM(361.1,IBCNT,15,IBX,1,"B","PR",0)),1,+$O(^IBM(361.1,IBCNT,15,IBX,1,+$O(^IBM(361.1,IBCNT,15,IBX,1,"B","PR",0)),1,"B",1,0)),0)),"^",2),"",2),7) ;  deduct
 . S IBT=IBT_" "_$$RJ($FN($P($G(^IBM(361.1,IBCNT,15,IBX,1,+$O(^IBM(361.1,IBCNT,15,IBX,1,"B","PR",0)),1,+$O(^IBM(361.1,IBCNT,15,IBX,1,+$O(^IBM(361.1,IBCNT,15,IBX,1,"B","PR",0)),1,"B",2,0)),0)),"^",2),"",2),6) ;   coins
 . S IBT=IBT_" "_$$RJ($FN($P(IBREC1,"^",13),"",2),8) ; allow
 . S IBT=IBT_" "_$$RJ($FN($P(IBREC1,"^",3),"",2),8) ;  payment
 . D SET(IBT)
 . S IBX2=0 F  S IBX2=$O(^IBM(361.1,IBCNT,15,IBX,1,IBX2)) Q:IBX2<1  D
 .. S IBREC2=^IBM(361.1,IBCNT,15,IBX,1,IBX2,0),IBX3=0
 .. F  S IBX3=$O(^IBM(361.1,IBCNT,15,IBX,1,IBX2,1,IBX3)) Q:IBX3<1  D
 ... S IBREC3=^IBM(361.1,IBCNT,15,IBX,1,IBX2,1,IBX3,0)
 ... ; line level adjustments; don't display kludges (esg 10/23/03)
 ... I $P(IBREC2,U,1)="PR",$P(IBREC3,U,1)="AAA" Q
 ... I $P(IBREC2,U,1)="OA",$P(IBREC3,U,1)="AB3" Q
 ... I $P(IBREC2,U,1)="LQ" Q
 ... S IBTX(1)="ADJ: "_$P(IBREC2,"^")_"  "_$P(IBREC3,"^")_"  "_$P(IBREC3,"^",4) D TXT1(.IBTX,0,79) S IBT=0 F  S IBT=$O(IBTX(IBT)) Q:IBT<1  D SET(IBTX(IBT))
 ... K IBTX
 ... D SET("ADJ AMT: "_$FN($P(IBREC3,"^",2),"",2))
 . S IBRC=0
 . F  S IBRC=$O(^IBM(361.1,IBCNT,15,IBX,4,IBRC)) Q:'IBRC  S IBREC2=$G(^(IBRC,0)) I IBREC2 K IBTX,IBZ S IBTX(1)="  -REMARK CODE("_+IBREC2_"): ",IBTXL=$L(IBTX(1)) D
 .. S IBTX(1)=IBTX(1)_$P(IBREC2,U,2)_"  "_$P(IBREC2,U,3)
 .. I $L(IBTX(1))>79 D
 ... D TXT1(.IBTX,0,79) D SET(IBTX(1)) M IBZ=IBTX K IBTX S IBTX(1)="",IBT=1 F  S IBT=$O(IBZ(IBT)) Q:'IBT  S IBTX(1)=IBTX(1)_IBZ(IBT)_" "
 .. E  D
 ... S IBTXL=0
 .. D TXT1(.IBTX,IBTXL,79) S IBT=0 F  S IBT=$O(IBTX(IBT)) Q:IBT<1  D SET(IBTX(IBT))
 . D SET(" ")
 D SET(" ")
 Q
 ;
TXT(IBRM,IBLN,IBXY) ;display text over 79 chars
 ;IBRM - text, IBLN - length, IBXY - position
 S IBRM=$E(IBRM,IBLN+1,999)
REP I $E(IBRM,1,IBLN)'="" S IB=$$SETSTR^VALM1($E(IBRM,1,IBLN),"",IBXY,IBLN) D SET(IB) S IBRM=$E(IBRM,IBLN+1,999) G REP
 Q
 ;
SET(IB,IBSAV) ;
 I '$G(IBSAV) D SET^IBCECSA6($G(IBSRC),IB,CNT,IBCNT)
 Q
 ;
A10(X) ;
 Q $$A10^IBCECSA6(X)
 ;
A7(X) ; returns a dollar amount right justified to 7 characters
 Q $$RJ($FN(X,"",2),7)
 ;
TXT1(IBT,DIWL,DIWR) ; sets up text for over 79 chars
 ; IBT - pass by ref, array of text to be formatted back in array
 ; DIWL - left margin, DIWR = right margin
 N IBX,X,DIWF,IBS K ^UTILITY($J,"W")
 S DIWF="|I"_DIWL
 S IBX=0 F  S IBX=$O(IBT(IBX)) Q:IBX<1  S X=IBT(IBX) D ^DIWP
 K IBT F  S IBX=$O(^UTILITY($J,"W",DIWL,IBX)) Q:IBX<1  S IBT(IBX)=^UTILITY($J,"W",DIWL,IBX,0)
 K ^UTILITY($J,"W")
 Q
 ;
RJ(X,Y) ; right just, default is 10
 Q $$RJ^XLFSTR(X,$G(Y,10)," ")
 ;
