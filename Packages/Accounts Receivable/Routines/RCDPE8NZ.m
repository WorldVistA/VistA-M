RCDPE8NZ ;ALB/TMK/KML - Unapplied EFT Deposits report ;19 MAR 2003
 ;;4.5;Accounts Receivable;**173,212,208,269,276,283**;Mar 20, 1995;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; entrypoint for stand-alone report option
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC,POP,ZTSK,DIR,X,Y,RCDISPTY,RCSTDT,RCENDT
 S DIR("A")="START DATE: "
 S DIR(0)="DOA^:"_DT_":AEP" W ! D ^DIR K DIR
 Q:Y=""  Q:$D(DUOUT)!$D(DTOUT)
 S RCSTDT=+Y
 S DIR("A")="END DATE: "
 S DIR("B")=Y(0)
 S DIR(0)="DAO^"_RCSTDT_":"_DT_":APE" W ! D ^DIR K DIR
 Q:$D(DUOUT)!$D(DTOUT)
 S RCENDT=+Y
 ; ask if export to excel format is wanted
 S RCDISPTY=$$DISPTY^RCDPEM3()
 I RCDISPTY=-1 Q
 I RCDISPTY D INFO^RCDPEM6
 ; Ask device
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="PR^RCDPE8NZ",ZTDESC="AR - List of unlinked EFT deposit payments"
 . S ZTSAVE("RC*")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 D PR
 Q
 ;
PR ; Entrypoint for queued job
 N RCCT,RCPG,RCEFT,RCEFT1,RCDATA,RCDATA0,RCDA,RCREC,RCSTAT,RCDT,RCTOT,RCEFTD,RCSTOP,RCRDT
 N Z,RCSUM,RCUNAP,RCPOST,RCTR,RCCR,ZTSTOP,RECEXT
 ;
 ;  get list of unlinked EFT deposit data
 K ^TMP("RCDPE8NZZ_EFT",$J) ; subscripts: dep date,EFT ien,EFT det ien
 ;  Data is FMS doc indicator^FMS doc #^FMS Doc Status
 ;    FMS doc indicator = -1:no receipt  -2:no FMS doc  1:FMS doc exists
 ;
 S (RCCT,RCSTOP,RCSUM,RCUNAP)=0
 S RCEFT1="" F  S RCEFT1=$O(^RCY(344.3,"ARDEP",RCEFT1)) Q:RCEFT1=""!RCSTOP  S RCDA=0 F  S RCDA=$O(^RCY(344.3,"ARDEP",RCEFT1,RCDA)) Q:'RCDA  D  Q:RCSTOP
 . S RCDATA=$G(^RCY(344.3,RCDA,0)),RCDT=$P(RCDATA,U,7),RCTOT=0
 . Q:RCDT<RCSTDT  ; Before start date
 . Q:RCDT>(RCENDT+.999999)  ; After the end date
 . Q:'$P(RCDATA,"^",8)  ; no payment amt
 . S RCEFT=0 F  S RCEFT=$O(^RCY(344.31,"B",RCDA,RCEFT)) Q:'RCEFT!RCSTOP  S RCDATA0=$G(^RCY(344.31,RCEFT,0)) D  Q:RCSTOP
 . . S RCCT=RCCT+1
 . . I '(RCCT#100),$D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ Q
 . . S RCREC=$$GETREC(RCEFT,RCDATA0,.RECEXT)
 . . Q:RCREC="PURGED"  ; need to prevent processed EFTs that had receipts purged from being generated on the report
 . . ;; PRCA276 - need to add EFT entries without a receipt to the total number of unapplied deposits
 . . I 'RCREC S RCUNAP=RCUNAP+1,^TMP("RCDPE8NZZ_EFT",$J,RCDT,RCDA,RCEFT)=-1,RCTOT=RCTOT+$P(RCDATA0,U,7) Q  ; No receipt therefore no FMS document
 . . S RCSTAT=$$FMSSTAT^RCDPUREC(RCREC)
 . . I $E($P(RCSTAT,U),1,2)="TR",$P(RCSTAT,U,2)["ACCEPTED" Q
 . . S RCUNAP=RCUNAP+1,RCTOT=RCTOT+$P(RCDATA0,U,7)  ; total unapplied deposits and total dollar amount of unapplied deposits
 . . I $P(RCSTAT,U,2)="NOT ENTERED" S ^TMP("RCDPE8NZZ_EFT",$J,RCDT,RCDA,RCEFT)="-2^^"_$P(RCSTAT,U) Q  ; No FMS doc
 . . S ^TMP("RCDPE8NZZ_EFT",$J,RCDT,RCDA,RCEFT)="1^"_$P(RCSTAT,U,1,2)_"^"_RECEXT
 . S:RCTOT ^TMP("RCDPE8NZZ_EFT",$J,RCDT,RCDA)=RCTOT,RCSUM=RCSUM+RCTOT
 I RCDISPTY D EXCEL Q
 D RPT
 Q
 ;
RPT ;  display/print the report using data populated in temporary global array
 S (RCPG,RCDT)=0,RCRDT=$$FMTE^XLFDT($$NOW^XLFDT(),2)
 F  S RCDT=$O(^TMP("RCDPE8NZZ_EFT",$J,RCDT)) Q:'RCDT  D  Q:RCSTOP
 . I 'RCPG!(($Y+5)>IOSL) D HDR(RCRDT,.RCPG,.RCSTOP) Q:RCSTOP
 . W ! S Z="DEPOSIT DATE: "_$$FMTE^XLFDT(RCDT,1) W ?(80-$L(Z)\2),Z,!
 . S RCEFT1=0 F  S RCEFT1=$O(^TMP("RCDPE8NZZ_EFT",$J,RCDT,RCEFT1)) Q:'RCEFT1  D
 . . S RCCT=RCCT+1
 . . I '(RCCT#100),$D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 W:$G(RCPG) !!,"TASK STOPPED BY USER!!" K ZTREQ Q
 . . S RCDATA0=$G(^RCY(344.3,RCEFT1,0))
 . . I ($Y+5)>IOSL D HDR(RCRDT,.RCPG,.RCSTOP) Q:RCSTOP
 . . ; PRCA*4.5*283 - Change the spaces for DEP # from 10 to 13 to allow 9 digit DEP #
 . . W !,$J("",4),$E($P(RCDATA0,U,6)_$S('$$HACEFT^RCDPEU(RCEFT1):"",1:"-HAC")_$J("",13),1,13)_"  "_$E($$FMTE^XLFDT($P(RCDATA0,U,7),2)_$J("",16),1,16)_"  "_$E($J(+$P(RCDATA0,U,8),"",2)_$J("",20),1,20)
 . . W "  "_$J(+$G(^TMP("RCDPE8NZZ_EFT",$J,RCDT,RCEFT1)),"",2)
 . . S RCEFT=0 F  S RCEFT=$O(^TMP("RCDPE8NZZ_EFT",$J,RCDT,RCEFT1,RCEFT)) Q:'RCEFT  S RCDATA=$G(^(RCEFT)),RCEFTD=$G(^RCY(344.31,RCEFT,0)) D
 . . . I ($Y+5)>IOSL D HDR(RCRDT,.RCPG,.RCSTOP) Q:RCSTOP
 . . . W !,$J("",5)_$P(RCEFTD,U,2)_"/"_$P(RCEFTD,U,3),!,$J("",6)_$E($P(RCEFTD,U,4)_$J("",50),1,50)_" "
 . . . W $E($J(+$P(RCEFTD,U,7),"",2)_$J("",12),1,12)_" "_$S($P(RCDATA,U,4)'="":$P(RCDATA,U,4),1:"NO RECEIPT")
 . . . S Z=$P(RCEFTD,U,8)
 . . . W !,$J("",8)_$E($S('Z:"UNMATCHED",Z=2:"PAPER EOB",1:"MATCHED TO ERA #: "_$P(RCEFTD,U,10)_$S(Z=-1:" (TOTALS MISMATCH)",1:""))_$J("",40),1,40)_"  "
 . . . W $S($P(RCDATA,U)=-1:"NO RECEIPT",$P(RCDATA,U)=-2:"NO FMS DOCUMENT",1:$E($P(RCDATA,U,2)_" - "_$P(RCDATA,U,3),1,30)),!
 I '$D(^TMP("RCDPE8NZZ_EFT",$J)) D HDR(RCRDT,.RCPG,.RCSTOP) W !!!,?26,"*** NO RECORDS TO PRINT ***"
 I $D(^TMP("RCDPE8NZZ_EFT",$J)) W !,"******** END OF REPORT ********",!
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 G:RCSTOP RPTQ
 I $E(IOST,1,2)="C-" D ASK(.RCSTOP)
 ;
RPTQ K ^TMP("RCDPE8NZZ_EFT",$J)
 Q
 ;
GETREC(EFTDA,EFTDET,RECEXT) ;  prca276
 ; input - EFTDA - IEN OF 344.31
 ; input - EFTDET - data stored at the 0 subscript of the THIRD PARTY EFT DETAIL file (344.31)
 ; input - RECEXT passed by reference
 ; output - RECEXT populated with the external receipt value that gets generated on the report
 ; output - RECEIPT - returns internal value of the receipt that either comes from the EFT file (344.31) or the ERA file (344.4) 
 N RECEIPT
 S RECEXT=0
 S RECEIPT=+$P($G(^RCY(344.4,+$P(EFTDET,U,10),0)),U,8)  ; get receipt off the ERA record
 I 'RECEIPT,$P(EFTDET,U,8)=2 S RECEIPT=+$O(^RCY(344,"AEFT",EFTDA,0))  ; EFT processed against paper EOB
 I 'RECEIPT S RECEIPT=$P(EFTDET,U,9) ; receipt not posted in payment file so get from EFT detail (unprocessed EFT)
 I +RECEIPT,'$D(^RCY(344,RECEIPT)) Q "PURGED"  ; handle purged receipts but broken pointer exists in 344.31; need to handle as a processed EFT 
 I +RECEIPT S RECEXT=$P(^RCY(344,RECEIPT,0),U)
 Q +RECEIPT
 ;
HDR(RCRDT,RCPG,RCSTOP) ; Print header data
 N Z0
 I 'RCSTOP,RCPG D ASK(.RCSTOP) Q:RCSTOP
 I RCPG!($E(IOST,1,2)="C-") W @IOF,*13
 S RCPG=RCPG+1
 S Z0="Unapplied EFT Deposits Report",Z0=$J("",80-$L(Z0)\2)_Z0 W !,Z0 W ?70,"Page: ",RCPG
 S Z0="Run Date: "_RCRDT,Z0=$J("",80-$L(Z0)\2)_Z0 W !,Z0
 S Z0="Date Range: "_$$FMTE^XLFDT(RCSTDT,2)_" - "_$$FMTE^XLFDT(RCENDT,2)_" (Deposit Date)",Z0=$J("",80-$L(Z0)\2)_Z0 W !,Z0
 I RCPG=1 D
 . S Z0="TOTAL NUMBER OF UNAPPLIED DEPOSITS: "_RCUNAP,Z0=$J("",80-$L(Z0)\2)_Z0 W !,Z0
 . S Z0="TOTAL AMOUNT OF UNAPPLIED DEPOSITS: $"_$FN(RCSUM,",",2),Z0=$J("",80-$L(Z0)\2)_Z0 W !,Z0,!
 ; PRCA*4.5*283 - Add 3 more spaces between DEPOSIT # and DEPOSIT DATE
 ; to allow for 9 digit DEPOSIT #'s
 W !!,"    DEPOSIT #      DEPOSIT DATE      TOT AMT OF DEPOSIT    TOT AMT UNPOSTED"
 W !,"     PAYER/ID",!,$J("",6)_"TRACE #"_$J("",44)_"PAYMENT AMT  RECEIPT #",!,$J("",8)_$E("ERA MATCHED"_$J("",40),1,40)_"  FMS DOC #/STATUS"
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
EXCEL ; Print report formatted for export to Excel
 N STR1
 W !,"DEPOSIT #^DEPOSIT DATE^TOT AMT DEPOSIT^TOT AMT UNPOSTED^PAYER ID^TRACE #^PAYMENT AMT^RECEIPT #^ERA MATCHED^FMS DOC #/STATUS",!
 S RCDT=0 F  S RCDT=$O(^TMP("RCDPE8NZZ_EFT",$J,RCDT)) Q:'RCDT  D  Q:RCSTOP
 .S RCEFT1=0 F  S RCEFT1=$O(^TMP("RCDPE8NZZ_EFT",$J,RCDT,RCEFT1)) Q:'RCEFT1  D
 ..S RCDATA0=$G(^RCY(344.3,RCEFT1,0))
 ..S STR1=$P(RCDATA0,U,6)_$S('$$HACEFT^RCDPEU(RCEFT1):"",1:"-HAC")_U_$$FMTE^XLFDT($P(RCDATA0,U,7))_U_$P(RCDATA0,U,8)_U
 ..S STR1=STR1_+$G(^TMP("RCDPE8NZZ_EFT",$J,RCDT,RCEFT1))_U
 ..;
 ..S RCEFT=0 F  S RCEFT=$O(^TMP("RCDPE8NZZ_EFT",$J,RCDT,RCEFT1,RCEFT)) Q:'RCEFT  S RCDATA=$G(^(RCEFT)),RCEFTD=$G(^RCY(344.31,RCEFT,0)) D
 ...W STR1
 ...W $P(RCEFTD,U,2)_"/"_$P(RCEFTD,U,3)_U_$P(RCEFTD,U,4)_U
 ...W +$P(RCEFTD,U,7)_U_$S($P(RCDATA,U,4)'="":$P(RCDATA,U,4),1:"NO RECEIPT")_U
 ...W $P(RCEFTD,U,10)_U
 ...W $S($P(RCDATA,U)=-1:"NO RECEIPT",$P(RCDATA,U)=-2:"NO FMS DOCUMENT",1:$P(RCDATA,U,2)_" - "_$P(RCDATA,U,3))
 ...W !
 Q
