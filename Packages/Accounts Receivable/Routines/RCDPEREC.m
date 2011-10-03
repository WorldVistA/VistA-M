RCDPEREC ;ALB/TMK - RECONCILIATION REPORT FOR EDI LOCKBOX FMS DOCS  ;19-APR-2004
 ;;4.5;Accounts Receivable;**208,244**;Mar 20, 1995
 ;
EN ; Entrypoint for producing the report
 N RCDDT,RCSEL,ZTRTN,ZTDESC,ZTSAVE,ZTSK,%ZIS,POP,DIR,DTOUT,DUOUT
 S DIR(0)="DA^3000101:"_DT_":AEPX",DIR("A")="SELECT THE EFT DEPOSIT DATE TO START WITH: " W ! D ^DIR K DIR
 S RCDDT=$S($D(DTOUT)!$D(DUOUT):"",1:Y)
 Q:'RCDDT
 S DIR("B")="ALL"
 S DIR(0)="SA^A:ALL;N:NOT FULLY TRANSFERRED",DIR("A")="DO YOU WANT (A)LL DEPOSITS OR ONLY THOSE (N)OT FULLY TRANSFERRED?: " W ! D ^DIR K DIR
 S RCSEL=$S($D(DTOUT)!$D(DUOUT):"",1:Y)
 Q:RCSEL=""
 W !
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="ENQUE^RCDPEREC",ZTDESC="AR - CR/TR RELATED DOCUMENTS FOR e-PAYMENTS"
 . S ZTSAVE("RCDDT")="",ZTSAVE("RCSEL")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 D ENQUE
 Q
 ;
ENQUE ; Queued entrypoint for the report
 ; RCDDT = starting EFT deposit date
 ; RCSEL = 'A' if all deposits included ... 'N' if only those not fully
 ;         transferred out of 8NZZ
 ;
 N Z,Z0,RCSTOP,RCD,RCR,RCSTAT,RCDEP,RCEFT,RCEFT1,RCT,RC0,RC00,RC000,RCTOT,RCTOT1,RCTRANS
 K ^TMP($J,"RCDEP")
 ;
 S (RCSTOP,RCT)=0,RCDDT=RCDDT-.1
 F  S RCDDT=$O(^RCY(344.3,"ADEP",RCDDT)) Q:'RCDDT!RCSTOP  S RCDEP=0 F  S RCDEP=$O(^RCY(344.3,"ADEP",RCDDT,RCDEP)) Q:'RCDEP  S RCEFT=0 F  S RCEFT=$O(^RCY(344.3,"ADEP",RCDDT,RCDEP,RCEFT)) Q:'RCEFT!RCSTOP  D
 . S RCTOT=0,RC0=$G(^RCY(344.3,RCEFT,0))
 . S RCD=$E(RCDDT_$J("",8),1,8)_RCDEP
 . S RCEFT1=0 F  S RCEFT1=$O(^RCY(344.31,"B",RCEFT,RCEFT1)) Q:'RCEFT1!RCSTOP  S RC00=$G(^RCY(344.31,RCEFT1,0)) D
 .. ;
 .. I $D(ZTQUEUED) S RCT=RCT+1 I '(RCT#100),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ Q
 .. ;
 .. I '$D(^TMP($J,"RCDEP",RCD)) S ^TMP($J,"RCDEP",RCD)=$P(RC0,U,6,11),^TMP($J,"RCDEP",RCD,0)=$S($P(RC00,U,9):$$FMSSTAT^RCDPUREC($P(RC00,U,9)),1:"NO CR DOCUMENT"),^TMP($J,"RCDEP",RCD,"EFT")=RCEFT
 .. S RCTRANS=+$P(RC00,U,14) S:'RCTRANS RCTRANS=1
 .. ;
 .. I '$P(RC00,U,8) S ^TMP($J,"RCDEP",RCD,RCTRANS,"RCUNM")=RCEFT1 Q  ; Not matched
 .. ;
 .. I '$O(^RCY(344,"AEFT",RCEFT1,0)) D  Q  ; No receipt
 ... I $P(RC00,U,16)'="" D  Q  ; EFT detail entered on-line
 .... S ^TMP($J,"RCDEP",RCD,RCTRANS)=RCEFT1_U_"ENTERED ON-LINE"_U_$S($P(RC000,U,18):"ERA #"_$P($G(^RCY(344.4,+$P(RC00,U,10),0)),U),1:"PAPER EOB")_U_$P(RC00,U,16)_U_"NO RECEIPT",RCTOT=RCTOT+$P(RC00,U,7)
 ... S ^TMP($J,"RCDEP",RCD,RCTRANS)=RCEFT1_U_"NO TR DOC"_U_$S($P(RC00,U,10):"ERA #"_$P($G(^RCY(344.4,+$P(RC00,U,10),0)),U),1:"PAPER EOB")_"^^NO RECEIPT"
 .. ;
 .. S RCR=0 F  S RCR=$O(^RCY(344,"AEFT",RCEFT1,RCR)) Q:'RCR  S RC000=$G(^RCY(344,RCR,0)) D
 ... S RCTOT=RCTOT+$$PAYTOTAL^RCDPURED(RCR)
 ... S RCSTAT=$$FMSSTAT^RCDPUREC(RCR) S:$P(RCSTAT,U)="" RCSTAT="NO TR DOC"
 ... S ^TMP($J,"RCDEP",RCD,RCTRANS)=RCEFT1_U_$P(RCSTAT,U)_U_$S($P(RC000,U,18):"ERA #"_$P($G(^RCY(344.4,+$P(RC000,U,18),0)),U),1:"PAPER EOB")_U_$P(RCSTAT,U,2)_U_RCR
 . Q:RCSTOP
 . I RCSEL="N",+RCTOT=+$P(RC0,U,8) K ^TMP($J,"RCDEP",RCD) Q
 . S ^TMP($J,"RCDEP",RCD,"TOT")=RCTOT_U_$P(RC0,U,8)
 ;
 ; Output the report
 S RCD="",RCPG=0
 I RCSTOP K ^TMP($J,"RCDEP")
 F  S RCD=$O(^TMP($J,"RCDEP",RCD)) Q:RCD=""!RCSTOP  D  Q:RCSTOP  D TOT(RCD,.RCSTOP,.RCPG)
 . S RC0=$G(^TMP($J,"RCDEP",RCD)) D EFTDEP(RCD,.RCSTOP,.RCPG) ; EFT dep
 . Q:RCSTOP
 . S RCTRANS=0 F  S RCTRANS=$O(^TMP($J,"RCDEP",RCD,RCTRANS)) Q:'RCTRANS!RCSTOP  S RC00=$G(^(RCTRANS)) D  ; EFT detail deposits
 .. S RCSTOP=$$NEWPG(.RCPG) Q:RCSTOP
 .. I RC00="",$D(^TMP($J,"RCDEP",RCD,RCTRANS,"RCUNM")) S Z=$G(^("RCUNM")) D  Q  ; Unmatched
 ... W !,?3,$J("",6),"  UNMATCHED   ",$E($P(Z,U,2)_$J("",30),1,30)_"  "_$E($P(Z,U,3)_$J("",20),1,20)
 ... W !,?13,$P(Z,U,4)
 .. ;
 .. I RC00="" W !,?3,"ERROR IN EFT DETAIL LINE #: ",RCTRANS Q  ; Error
 .. ;
 .. S Z=$G(^RCY(344.31,+RC00,0))
 .. W !,?3,$E(+RC00_$J("",6),1,6)_"  "_$E($P(RC00,U,3)_$J("",10),1,10)_"  "_$E($P(Z,U,2)_$J("",30),1,30)_"  "_$E($P(Z,U,3)_$J("",20),1,20)
 .. W !,?13,$E($P(Z,U,4)_$J("",30),1,30)_"  "_$E($P(RC00,U,5)_$J("",10),1,10),!,?15,$E($P(RC00,U,2)_$J("",10),1,10)_"  "_$E($P(RC00,U,4)_$J("",15),1,15)
 ;
 I 'RCSTOP,RCPG D ASK(.RCSTOP)
 ;
 I $D(ZTQUEUED) D
 . I $G(RCSTOP) D HDR1(0) W !,"TASK STOPPED BY USER" Q
 . S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCDEP")
 Q
 ;
EFTDEP(RCD,RCSTOP,RCPG) ;
 ; RCD = deposit date (FM) concatenated with the deposit #
 N Z,Z0
 I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ Q
 S Z=$G(^TMP($J,"RCDEP",RCD)),Z0=$G(^(RCD,0))
 S RCSTOP=$$NEWPG(.RCPG) Q:RCSTOP
 I $Y+7>IOSL W !! S RCSTOP=$$NEWPG(.RCPG) Q:RCSTOP
 W:'$P(RCPG,U,2) !!
 W !,$E($$FMTE^XLFDT($P(Z,U,2),"2D")_$J("",8),1,8),"  ",$E(+$G(^TMP($J,"RCDEP",RCD,"EFT"))_$J("",6),1,6),"  ",$E($P(Z,U)_$J("",6),1,6),"  ",$J($P(Z,U,3),13,2),"  ",$E($S($P(Z,U,6):$$FMTE^XLFDT($P(Z,U,6),"2D"),1:"UNPOSTED")_$J("",8),1,8)
 W !,?5,$E($P(Z0,U)_$J("",20),1,20),"  ",$P(Z0,U,2)
 Q
 ;
TOT(RCD,RCSTOP,RCPG) ; Output the total lines for the deposit
 S RCSTOP=$$NEWPG(.RCPG) Q:RCSTOP
 W !,$J("",26),"TOTAL AMOUNT SENT VIA 'TR' DOCUMENTS: ",$J($G(^TMP($J,"RCDEP",RCD,"TOT")),15,2)
 W !,$J("",26),"TOTAL AMOUNT STILL TO BE TRANSFERRED: ",$J($P($G(^TMP($J,"RCDEP",RCD,"TOT")),U,2)-$G(^TMP($J,"RCD",RCD,"TOT")),15,2)
 Q
 ;
NEWPG(RCPG) ; Check for new page needed, output header
 ; Function returns 1 if user chooses to stop output
 N RCX,RCZ
 S RCZ=0,RCX=$P(RCPG,U,2)
 I 'RCPG!(($Y+5)>IOSL) D
 . D:RCPG ASK(.RCZ) I RCZ Q
 . D HDR1(.RCPG)
 I RCX S $P(RCPG,U,2)=0
 Q RCZ
 ;
SELECT() ; Select first deposit #
 ; Function returns values selected for first deposit #
 ;
 N DIR,X,Y,DTOUT,DUOUT
 ;
HDR1(RCPG) ;Print report hdr
 ; RCPG = last page #^0/1 for top of page indicator
 N Z,Z0,X
 I RCPG!($E(IOST,1,2)="C-") W @IOF,*13
 S RCPG=$G(RCPG)+1_U_1
 W !,"EDI LOCKBOX FUND 5287.4/8NZZ RECONCILIATION REPORT",?55,$$FMTE^XLFDT(DT,2),?70,"Page: ",+RCPG
 W !!,"DEP DATE  ENTRY#  DEP #   TOTAL DEP AMT  POST DT   RECEIPT #",!,?5,"CR DOCUMENT           CR DOC STATUS"
 W !,?3,"EFT #   MATCHED TO  PAYER NAME                      PAYER ID            ",!,?13,"TRACE #                         RECEIPT #"
 W !,?15,"TR DOCUMENT           TR DOC STATUS"
 W !,$TR($J("",IOM)," ","=")
 Q
 ;
ASK(RCSTOP) ;
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S RCSTOP=1 Q
 Q
 ;
