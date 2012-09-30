RCDPEDA1 ;ALB/TMK/PJH - ACTIVITY REPORT HEADER ;04-NOV-02
 ;;4.5;Accounts Receivable;**173,269,276,284,283**;Mar 20, 1995;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
HDR(RCCT,RCPG,RCSTOP,RCDT1,RCDT2,RCDET,RCNITE) ;Prints report heading
 ; Function returns RCPG = current page # and RCCT = running line count
 ;   and RCSTOP = 1 if user aborted print
 ; Parameters RCCT,RCPG,RCSTOP must be passed by reference
 ; RCDT1,RCDT2 = from,to date
 ; RCDET = flag = 1 if detail is desired
 N Z,Z0,Z1,X,Y
 Q:RCNITE&(RCPG)
 I RCPG!($E(IOST,1,2)="C-") D
 . Q:$G(RCNITE)
 . I RCPG&($E(IOST,1,2)="C-") D ASK(.RCSTOP) Q:RCSTOP
 . W @IOF,*13 ; Write form feed
 Q:RCSTOP
 S RCPG=RCPG+1
 I '$D(RCNP) N RCNP S RCNP=2  ; PRCA276 if coming from nightly job need to define payer selection variable
 I '$D(VAUTD) N VAUTD S VAUTD=1  ; PRCA276 if coming from nightly job need to define division selection variable
 S Z0="EDI LOCKBOX DAILY ACTIVITY "_$S($G(RCDET):"DETAIL",1:"SUMMARY")_" REPORT"
 S Z=$$SETSTR^VALM1($J("",80-$L(Z0)\2)_Z0,"",1,79)
 S Z=$$SETSTR^VALM1("Page: "_RCPG,Z,70,10)
 D SETLINE^RCDPEDAR(RCNITE,Z,.RCCT)
 S Z="RUN DATE: "_$$FMTE^XLFDT($$NOW^XLFDT(),2),Z=$J("",80-$L(Z)\2)_Z
 D SETLINE^RCDPEDAR(RCNITE,Z,.RCCT)
 ;prca276 add divisions to header
 S Z1="" I 'VAUTD S Z0=0 F  S Z0=$O(VAUTD(Z0)) Q:'Z0  S Z1=Z1_VAUTD(Z0)_", "
 S Z="DIVISIONS: "_$S(VAUTD:"ALL",1:$E(Z1,1,$L(Z1)-2)),Z=$J("",80-$L(Z)\2)_Z
 D SETLINE^RCDPEDAR(RCNITE,Z,.RCCT)
 ; prca 276 add payer selection list to header
 S Z1="" I RCNP'=2 S Z0=0 F  S Z0=$O(^TMP("RCSELPAY",$J,Z0)) Q:'Z0  S Z1=Z1_^TMP("RCSELPAY",$J,Z0)_", "
 S Z="PAYERS: "_$S(RCNP=2:"ALL",1:$E(Z1,1,$L(Z1)-2)),Z=$J("",80-$L(Z)\2)_Z
 D SETLINE^RCDPEDAR(RCNITE,Z,.RCCT)
 ;prca 276  add date filter to header
 S Z="DATE RANGE: "_$$FMTE^XLFDT(RCDT1,2)_" - "_$$FMTE^XLFDT(RCDT2,2)_" (Date Deposit Added)",Z=$J("",80-$L(Z)\2)_Z
 D SETLINE^RCDPEDAR(RCNITE,Z,.RCCT)
 D SETLINE^RCDPEDAR(RCNITE," ",.RCCT)
 I $G(RCDET) D
 . ; PRCA*4.5*283 - Add 3 more spaces between DEP # and DEPOSIT DT 
 . ; and remove 3 spaces between DEPOSIT DT and DEP AMOUNT to allow for 9 digit DEP #'s
 . S Z=$$SETSTR^VALM1("DEP #      DEPOSIT DT  "_$J("",19)_"DEP AMOUNT          FMS DEPOSIT STAT","",1,80)
 . D SETLINE^RCDPEDAR(RCNITE,Z,.RCCT)
 . D SETLINE^RCDPEDAR(RCNITE," ",.RCCT)
 . ; PRCA*4.5*284, Move Match Status to left 3 space to allow for 10 digit ERA #'s
 . S Z=$$SETSTR^VALM1($J("",3)_"EFT #"_$J("",23)_"DATE PD   PAYMENT AMOUNT  ERA MATCH STATUS","",1,80)
 . D SETLINE^RCDPEDAR(RCNITE,Z,.RCCT)
 . S Z=$$SETSTR^VALM1($J("",10)_"EFT PAYER TRACE #","",1,30)
 . D SETLINE^RCDPEDAR(RCNITE,Z,.RCCT)
 . S Z=$$SETSTR^VALM1($J("",14)_"PAYMENT FROM","",1,30)
 . D SETLINE^RCDPEDAR(RCNITE,Z,.RCCT)
 . S Z=$$SETSTR^VALM1($J("",45)_"DEP RECEIPT #","",1,60)
 . S Z=$$SETSTR^VALM1("DEP RECEIPT STATUS",Z,61,19)
 . D SETLINE^RCDPEDAR(RCNITE,Z,.RCCT)
 D SETLINE^RCDPEDAR(RCNITE,$TR($J("",IOM-1)," ","="),.RCCT)
 Q
 ;
ASK(RCSTOP) ; Ask to continue
 ; If passed by reference ,RCSTOP is returned as 1 if print is aborted
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S RCSTOP=1 Q
 Q
 ;
EFTDET(Z2,Z3,RCCT,RCPG,RCSTOP,RCDT1,RCDT2,RCDET,RCFMS1,RCNITE) ; Display EFT Detail
 N DATA,X
 S X=$$SETSTR^VALM1($P(Z3,U),"",4,6)
 S X=$$SETSTR^VALM1($$FMTE^XLFDT($P(Z3,U,12)\1,2),X,32,8)
 S X=$$SETSTR^VALM1($J($P(Z3,U,7),"",2),X,42,18)
 ; PRCA*4.5*284, Move to left 3 space (61 to 58) to allow for 10 digit ERA #'s
 S X=$$SETSTR^VALM1($$EXTERNAL^DILFD(344.31,.08,"",+$P(Z3,U,8))_$S($P(Z3,U,8)=1:"/ERA #"_$P(Z3,U,10),1:""),X,58,20)
 I '$G(RCNITE),($Y+5)>IOSL D HDR(.RCCT,.RCPG,.RCSTOP,RCDT1,RCDT2,RCDET,RCNITE) Q:RCSTOP
 D SETLINE^RCDPEDAR(RCNITE,X,.RCCT)
 S X=$$SETSTR^VALM1($P(Z3,U,4),"",11,61)
 D SETLINE^RCDPEDAR(RCNITE,X,.RCCT)
 S X=$$SETSTR^VALM1($P(Z3,U,2)_"/"_$P(Z3,U,3),"",15,65)
 D SETLINE^RCDPEDAR(RCNITE,X,.RCCT)
 S X=""
 I $P(Z3,U,9) S X=$$SETSTR^VALM1($P($G(^RCY(344,+$P(Z3,U,9),0)),U),X,46,10)
 S X=$$SETSTR^VALM1($G(RCFMS1(Z2)),X,61,19)
 I '$G(RCNITE),($Y+5)>IOSL D HDR(.RCCT,.RCPG,.RCSTOP,RCDT1,RCDT2,RCDET,RCNITE) Q:RCSTOP
 D SETLINE^RCDPEDAR(RCNITE,X,.RCCT)
 I $O(^RCY(344.31,Z2,2,0)) D  Q:RCSTOP
 . N V
 . I '$G(RCNITE),($Y+5)>IOSL D HDR(.RCCT,.RCPG,.RCSTOP,RCDT1,RCDT2,RCDET,RCNITE) Q:RCSTOP
 . D SETLINE^RCDPEDAR(RCNITE,$J("",10)_"ERROR MESSAGES FOR EFT DETAIL:",.RCCT)
 . S V=0 F  S V=$O(^RCY(344.31,Z2,2,V)) Q:'V  D  Q:RCSTOP
 .. I '$G(RCNITE),($Y+5)>IOSL D HDR(.RCCT,.RCPG,.RCSTOP,RCDT1,RCDT2,RCDET,RCNITE) Q:RCSTOP
 .. D SETLINE^RCDPEDAR(RCNITE,$J("",12)_$G(^RCY(344.31,Z2,2,V,0)),.RCCT)
 I $D(^RCY(344.31,Z2,3)) D
 .S DATA=$G(^RCY(344.31,Z2,3))
 .S X="   MARKED AS DUPLICATE: "_$$FMTE^XLFDT($P(DATA,U,2),5)_" "_$$EXTERNAL^DILFD(344.31,.17,,$P(DATA,U))
 .D SETLINE^RCDPEDAR(RCNITE,X,.RCCT)
 .D SETLINE^RCDPEDAR(RCNITE,"",.RCCT)
 .Q
 Q
 ;
 ; *** Begin PRCA*4.5*276 - RBN ***
TEXT ; Filtered by messages
 ;;No Filters Applied
 ;;Station/Division
 ;;
 ;;Date Range
 ;;Station/Division, Date Range
 ;;Payer
 ;;Station/Division, Payer
 ;;
 ;;Date Range, Payer
 ;;Station/Division, Date Range, Payer
 Q
 ;
 ; *** End PRCA*4.5*276 ***
