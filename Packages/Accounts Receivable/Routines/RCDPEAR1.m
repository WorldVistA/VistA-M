RCDPEAR1 ;ALB/TMK/PJH - ELECTRONIC ERA AGING REPORT - FILE 344.4 ;31-OCT-02
 ;;4.5;Accounts Receivable;**173,269,276,284**;Mar 20, 1995;Build 35
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
EN1 ; Entry from option - run on the fly
 N RCIND,RCDISPTY,RCEND,RCRANGE,RCNP,RCJOB,RCSTART,RCJOB1
 N %ZIS,ZTSK,ZTSTOP,ZTDESC,ZTSAVE,ZTQUEUED,ZTRTN,POP,VAUTD,RCBAL,RCNP1
 S RCIND=1
 D DIVISION^VAUTOMA
 I 'VAUTD&($D(VAUTD)'=11) G EN1Q
 S RCRANGE=$$DTRNG^RCDPEM4()
 I RCRANGE=0 G EN1Q
 I $P(RCRANGE,U,1) S RCSTART=$P(RCRANGE,U,2),RCEND=$P(RCRANGE,U,3)
 ;Get insurance company to be used as filter
 ; PRCA*4.5*284 - RCDPEM9 now return a stack in RCNP (Type of Response(1=Range,2=All,3=Specific)^From Range^Thru Range)
 S RCNP=$$GETPAY^RCDPEM9(344.4)
 I +RCNP=-1 G EN1Q
 ; Get Zero Balance Filter
 S RCBAL=$$RCBAL() I RCBAL=-1 G EN1Q
 S RCDISPTY=$$DISPTY^RCDPEM3() I RCDISPTY=-1 G EN1Q
 I RCDISPTY D INFO^RCDPEM6
 S:$D(VAUTD)=11&(VAUTD'=1) RCIND=RCIND+1
 S:$P($G(RCRANGE),U)>0 RCIND=RCIND+3
 S:$D(^TMP("RCSELPAY",$J))&(+RCNP=1) RCIND=RCIND+5
 I $D(DUOUT)!$D(DTOUT) G EN1Q
 S RCJOB=$J
 ; Ask device
 S %ZIS="QM" D ^%ZIS G:POP EN1Q
 I $D(IO("Q")) D  Q
 .S ZTRTN="RPTOUT^RCDPEAR1",ZTDESC="AR - EDI LOCKBOX ERA AGING REPORT"
 .S ZTSAVE("*")=""
 .; PRCA*4.5*284 - Because TMP global may be on another server, save off specific payers in local
 .I +RCNP=3 M RCNP1=^TMP("RCSELPAY",$J)
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this $J.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 D RPTOUT
EN1Q K ^TMP("RCSELPAY",$J),^TMP("RCPAYER",$J)
 Q
 ;
RPTOUT(RCPRT) ; Entrypoint for queued job, nightly job
 ; RCPRT = name of the subscript for ^TMP to use to return all lines
 ;        (for bulletin).  If undefined or null, output is printed
 ; Return global if RCPRT not null: ^TMP($J,RCPRT,line#)=line text
 N ERAIEN,RCCT,RCPG,RCSTOP,RCNT,RCDATA,RCOUT,RCEDT,RC0,RC7,RCZ,RCZ0,RCZ1,RC00,RCTOT,Z,Z0,RCPAY
 N STA,STNUM,STNAM
 S RCPRT=$G(RCPRT),(RCCT,RCSTOP,RCPG,RCNT,RCTOT)=0
 K ^TMP($J,"RCERA_AGED"),^TMP($J,"RCERA_ADJ")
 ; PRCA*4.5*284 - Queued job needs to reload payer selection list
 I $G(RCJOB)'="",RCJOB'=$J D
 . K ^TMP("RCSELPAY",$J)
 . D RLOAD(344.4)
 . S RCJOB=$J
 S RCNP=+RCNP
 I RCPRT'="" K ^TMP($J,RCPRT)
 S RCZ0=0 F  S RCZ0=$O(^RCY(344.4,"AMATCH",0,RCZ0)) Q:'RCZ0  D
 .S RC7=$P($G(^RCY(344.4,RCZ0,0)),U,7)\1  ; era file date/time
 .; Check Station/Division
 .;I '$$CHKDIV^RCDPEDAR(RCZ0,1,.VAUTD) Q
 . I 'VAUTD D ERASTA^RCDPEM4(RCZ0,.STA,.STNUM,.STNAM) I '$D(VAUTD(STA)) Q
 .; Check for payer match
 .I '$$CHKPYR^RCDPEDAR(RCZ0,1,RCJOB) Q
 .; Check date range
 .I $P(RCRANGE,U,1) D  Q:'ERAIEN
 ..S ERAIEN=$P($G(^RCY(344.4,RCZ0,0)),U,7)\1
 .I $P(RCRANGE,U,1) Q:(RCSTART>RC7)!(RC7>RCEND)
 .; Check for Zero Bal
 . I 'RCBAL,'+$P($G(^RCY(344.4,RCZ0,0)),U,5) Q
 .;  - include on report
 .S ^TMP($J,"RCERA_AGED",$$FMDIFF^XLFDT(RC7,DT),RCZ0)=0,RCNT=RCNT+1
 ;
 ; build local payer array here
 D SELPAY(RCNP,RCJOB,.RCPAY)
 ; Calculate total amount for ERA
 ;
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCERA_AGED",RCZ)) Q:RCZ=""  S RCZ0=0 F  S RCZ0=$O(^TMP($J,"RCERA_AGED",RCZ,RCZ0)) Q:'RCZ0  D
 .S RC0=$G(^RCY(344.4,RCZ0,0)),RCTOT=RCTOT+$P(RC0,U,5)
 I RCDISPTY  D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCRANGE,.VAUTD,.RCPAY),EXCEL Q  ; prca 276  
 ;
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCERA_AGED",RCZ)) Q:RCZ=""  S RCZ0=0 F  S RCZ0=$O(^TMP($J,"RCERA_AGED",RCZ,RCZ0)) Q:'RCZ0  D  G:RCSTOP PRTQ
 .I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPG) W:RCPRT="" !!,"***TASK STOPPED BY USER***" Q
 .I RCPG D SETLINE(" ",.RCCT,.RCPRT) ; On detail list, skip line
 .I 'RCPG!(($Y+5)>IOSL) D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCRANGE,.VAUTD,.RCPAY) Q:RCSTOP
 .S RC0=$G(^RCY(344.4,RCZ0,0)),RCTOT=RCTOT+$P(RC0,U,5)
 .S Z=$$SETSTR^VALM1($J(-RCZ,4),"",1,4)
 .S Z=$$SETSTR^VALM1("  "_$P(RC0,U,2),Z,5,50)
 .D SETLINE(Z,.RCCT,RCPRT)
 .S Z=$$SETSTR^VALM1($P(RC0,U,6)_"/"_$P(RC0,U,3),"",11,69)
 .S Z=$$SETSTR^VALM1("  "_$$FMTE^XLFDT($P(RC0,U,4),2),Z,70,10)
 .D SETLINE(Z,.RCCT,RCPRT)
 .S Z=$$SETSTR^VALM1($J("",16)_$S($P(RC0,U,7):$$FMTE^XLFDT($P(RC0,U,7)\1,2),1:""),"",1,25)
 .S Z=$$SETSTR^VALM1("  "_$J($P(RC0,U,5),15,2),Z,26,17)
 .S Z=$$SETSTR^VALM1("  "_+$P(RC0,U,11),Z,43,11)
 .S Z=$$SETSTR^VALM1("  "_$P(RC0,U),Z_$S('$$HACERA^RCDPEU(RCZ0):"",1:" (HAC ERA)"),54,26)
 .D SETLINE(Z,.RCCT,RCPRT)
 .I "23"[$$ADJ^RCDPEU(RCZ0) D SETLINE($J("",9)_"** CLAIM LEVEL ADJUSTMENTS EXIST FOR THIS ERA ***",.RCCT,RCPRT)
 .I $O(^RCY(344.4,RCZ0,2,0)) D  ; ERA level adjustments exist
 ..N Q
 ..D DISPADJ^RCDPESR8(RCZ0,"^TMP("_$J_",""RCERA_ADJ"")")
 ..I $O(^TMP($J,"RCERA_ADJ",0)) D SETLINE($J("",9)_"** GENERAL ADJUSTMENT DATA EXISTS FOR ERA **",.RCCT,RCPRT)
 ..S Q=0 F  S Q=$O(^TMP($J,"RCERA_ADJ",Q)) Q:'Q  D SETLINE($J("",9)_$G(^TMP($J,"RCERA_ADJ",Q)),.RCCT,RCPRT)
 .;
 .S RCZ1=0 F  S RCZ1=$O(^RCY(344.4,RCZ0,1,RCZ1)) Q:'RCZ1  S RC00=$G(^(RCZ1,0)) D  Q:RCSTOP
 ..N D
 ..K RCDATA,RCOUT
 ..I ($Y+5)>IOSL D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCRANGE,.VAUTD,.RCPAY) Q:RCSTOP
 ..S D=$J("",7)_" EEOB Seq #: "_$P(RC00,U)_$S($D(^RCY(344.4,RCZ0,1,"ATB",1,RCZ1)):" (REVERSAL)",1:"")_"  EEOB "
 ..S D=D_$S('$P(RC00,U,2):"not on file",1:"on file for "_$P($G(^DGCR(399,+$G(^IBM(361.1,+$P(RC00,U,2),0)),0)),U))_"  "_$J(+$P(RC00,U,3),"",2)
 ..D SETLINE(D,.RCCT,RCPRT)
 ..Q:$P(RC00,U,2)
 ..D DISP^RCDPESR0("^RCY(344.4,"_RCZ0_",1,"_RCZ1_",1)","RCDATA",1,"RCOUT",68,1)
 ..I '$O(RCOUT(0)) D SETLINE($J("",9)_" NO DETAIL FOUND",.RCCT,RCPRT) Q
 ..S Z=0 F  S Z=$O(RCOUT(Z)) Q:'Z  D  Q:RCSTOP
 ... I ($Y+5)>IOSL D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCRANGE,.VAUTD,.RCPAY) Q:RCSTOP
 ... D SETLINE($J("",9)_"*"_RCOUT(Z),.RCCT,RCPRT)
 ;
 F Z0=1:1:2 D SETLINE(" ",.RCCT,RCPRT)
 I ($Y+7)>IOSL!'RCPG D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCRANGE,.VAUTD,.RCPAY)
 ;
 W !,"******** END OF REPORT ********",!
PRTQ I '$D(ZTQUEUED),'RCSTOP,RCPG,RCPRT="" D ASK()
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCERA_AGED"),^TMP("RCSELPAY",$J)
 Q
 ;
HDR(RCCT,RCPG,RCSTOP,RCPRT,RCRANGE,VAUTD,RCPAY) ;Prints report heading
 ; Function returns RCPG = current page # and RCCT = running line count
 ;   and RCSTOP = 1 if user aborted print 
 ; Parameters must be passed by reference
 ; RCPRT = name of the subscript for ^TMP to use to return all lines
 ;        (for bulletin).  If undefined or null, output is printed
 ; RCRANGE - date range filter value to be printed as part of the header
 ; VAUTD (required/pass-by-ref) - Division filter value(s)
 ; RCPAY (required/pass-by-ref) - Payer filter value(s)
 ;
 N Z,Z0,START,END,SUB,%,CNT
 Q:$G(RCSTOP)
 I RCPG!($E(IOST,1,2)="C-") D  Q:$G(RCSTOP)
 .I RCPG&($E(IOST,1,2)="C-")&(RCPRT="") D ASK(.RCSTOP) Q:RCSTOP
 .I RCPRT="" W @IOF,*13 Q  ; Write form feed for report
 S RCPG=RCPG+1,Z0="ERA UNMATCHED AGING REPORT"
 S Z=$$SETSTR^VALM1($J("",80-$L(Z0)\2)_Z0,"",1,79)
 S:'RCDISPTY Z=$$SETSTR^VALM1("Page: "_RCPG,Z,64,17)
 D SETLINE(Z,.RCCT,RCPRT)
 D NOW^%DTC
 S Z="RUN DATE/TIME: "_$$FMTE^XLFDT(%,2),Z=$J("",80-$L(Z)\2)_Z
 D SETLINE(Z,.RCCT,RCPRT)
 S END=$P(RCRANGE,U,3)
 ; divisions
 S Z="DIVISIONS: "
 I $D(VAUTD)=1 D
 .S Z=Z_"ALL",Z=$J("",80-$L(Z)\2)_Z
 .D SETLINE(Z,.RCCT,RCPRT)
 .S Z=""
 I $D(VAUTD)>1,'VAUTD D
 .S SUB=VAUTD
 .F  S SUB=$O(VAUTD(SUB)) Q:'SUB  D
 ..I Z="DIVISIONS: " S Z=Z_VAUTD(SUB) Q
 ..S Z=Z_$S(Z]"":",",1:"")_VAUTD(SUB)
 ..I $L(Z)>50 D
 ...S Z=$J("",80-$L(Z)\2)_Z
 ...D SETLINE(Z,.RCCT,RCPRT)
 ...S Z=""
 I Z]"" D
 .S Z=$J("",80-$L(Z)\2)_Z
 .D SETLINE(Z,.RCCT,RCPRT)
 ;
 ; Payers
 S Z="PAYERS: "
 I $D(RCPAY)=1 S Z=Z_RCPAY
 I $D(RCPAY)=10 D
 .S CNT=0
 .F  S CNT=$O(RCPAY(CNT)) Q:'CNT  D
 ..I Z="PAYERS: " S Z=Z_RCPAY(CNT) Q
 ..S Z=Z_$S(Z]"":",",1:"")_RCPAY(CNT)
 ..I $L(Z)>50 D
 ...S Z=$J("",80-$L(Z)\2)_Z
 ...D SETLINE(Z,.RCCT,RCPRT)
 ...S Z=""
 I Z]"" D
 .S Z=$J("",80-$L(Z)\2)_Z
 .D SETLINE(Z,.RCCT,RCPRT)
 S START=$P(RCRANGE,U,2)
 S Z="DATE RANGE: "_$P($$FMTE^XLFDT(START,2),"@")_" - "_$P($$FMTE^XLFDT(END,2),"@")_" (ERA FILE DATE)",Z=$J("",80-$L(Z)\2)_Z
 D SETLINE(Z,.RCCT,RCPRT)
 Q:RCDISPTY  ; prca 276 - do not print column headers for excel format
 D SETLINE(" ",.RCCT,RCPRT)
 D SETLINE("AGED",.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1("DAYS"_$J("",2)_"TRACE #","",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1($J("",10)_"PAYMENT FROM/ID"_$J("",46)_"ERA DATE","",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1($J("",16)_"FILE DATE"_$J("",6)_"AMOUNT PAID"_$J("",2)_"EEOB CNT "_$J("",2)_"ERA #",Z,1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 D SETLINE($TR($J("",IOM-1)," ","="),.RCCT,RCPRT)
 I RCPG=1 D
 .D SETLINE("TOTALS:",.RCCT,RCPRT)
 .S Z=$$SETSTR^VALM1(" NUMBER AGED ELECTRONIC ERA MESSAGES FOUND: "_RCNT,"",1,79)
 .D SETLINE(Z,.RCCT,RCPRT)
 .S Z=$$SETSTR^VALM1(" AMOUNT AGED ELECTRONIC ERA MESSAGES FOUND: $"_$FN(+RCTOT,",",2),"",1,79)
 .D SETLINE(Z,.RCCT,RCPRT)
 .D SETLINE($TR($J("",IOM-1)," ","="),.RCCT,RCPRT)
 Q
 ;
EXCEL ; Print report to screen, one record per line for export to MS Excel.
 N RCLFLG,RCZ,RCZ0,RC00,Z,D,RCZ1,RZ,RZ1
 W !!,"Aged Days^Trace #^Payment From/ID^ERA Date^File Date^Amount Paid^EEOB Cnt^ERA #^EEOB Detail"
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCERA_AGED",RCZ)) Q:RCZ=""  S RCZ0=0 F  S RCZ0=$O(^TMP($J,"RCERA_AGED",RCZ,RCZ0)) Q:'RCZ0  D  G:RCSTOP PRTQ2
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPG) W:RCPRT="" !!,"***TASK STOPPED BY USER***" Q
 . S RC0=$G(^RCY(344.4,RCZ0,0))
 . S Z=$J(-RCZ,4)_U_$P(RC0,U,2)_U_$P(RC0,U,6)_"/"_$P(RC0,U,3)_U_$$FMTE^XLFDT($P(RC0,U,4),2)_U_$$FMTE^XLFDT($P(RC0,U,7),2)_U
 . S Z=Z_$P(RC0,U,5)_U_$P(RC0,U,11)_U_$P(RC0,U)
 . W !,Z
 . S RZ=Z,RZ1=0
 . K Z
 .;;;
 . I "23"[$$ADJ^RCDPEU(RCZ0) D EXCEL1 W "^** CLAIM LEVEL ADJUSTMENTS EXIST FOR THIS ERA ***"
 . I $O(^RCY(344.4,RCZ0,2,0)) D  ; ERA level adjustments exist
 . . N Q
 . . D DISPADJ^RCDPESR8(RCZ0,"^TMP("_$J_",""RCERA_ADJ"")")
 . . I $O(^TMP($J,"RCERA_ADJ",0)) D EXCEL1 W "^** GENERAL ADJUSTMENT DATA EXISTS FOR ERA **"
 . . S Q=0 F  S Q=$O(^TMP($J,"RCERA_ADJ",Q)) Q:'Q  D EXCEL1 W "^"_$G(^TMP($J,"RCERA_ADJ",Q))
 .;
 . S RCZ1=0 F  S RCZ1=$O(^RCY(344.4,RCZ0,1,RCZ1)) Q:'RCZ1  S RC00=$G(^(RCZ1,0)) D  Q:RCSTOP
 . . N D
 . . K RCDATA,RCOUT
 . . S D=" EEOB Seq #: "_$P(RC00,U)_$S($D(^RCY(344.4,RCZ0,1,"ATB",1,RCZ1)):" (REVERSAL)",1:"")_"  EEOB "
 . . S D=D_$S('$P(RC00,U,2):"not on file",1:"on file for "_$P($G(^DGCR(399,+$G(^IBM(361.1,+$P(RC00,U,2),0)),0)),U))_"  "_$J(+$P(RC00,U,3),"",2)
 . . D EXCEL1 W "^",D
 . . Q:$P(RC00,U,2)
 . . D DISP^RCDPESR0("^RCY(344.4,"_RCZ0_",1,"_RCZ1_",1)","RCDATA",1,"RCOUT",68,1)
 . . I '$O(RCOUT(0)) D EXCEL1 W "^NO DETAIL FOUND" Q
 . . S Z=0 F  S Z=$O(RCOUT(Z)) Q:'Z  D  Q:RCSTOP
 . . . D EXCEL1 W "^*"_RCOUT(Z)
 W !,"******** END OF REPORT ********",!
 Q
 ;
EXCEL1 ; Display repeat info line before each EEOB detail section.
 ; First detail line does not need it
 I RZ1 W !,RZ Q
 S RZ1=1 Q
 ;
PRTQ2 I '$D(ZTQUEUED),'RCSTOP,RCPG,RCPRT="" D ASK()
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCEFT_AGED")
 Q
 ;
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
SETLINE(Z,RCCT,RCPRT) ; Sets line into print global or writes line
 ; Z = txt to output
 ; RCCT = if defined = line counter
 ; RCPRT = if defined = flag if 1, indicates output to global, no writes 
 I $G(RCPRT)="" W !,Z Q
 S RCCT=RCCT+1
 S ^TMP($J,RCPRT,RCCT)=Z
 Q
 ;
ASK(RCSTOP) ; Ask to continue
 ; If passed by reference ,RCSTOP is returned as 1 if print is aborted
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" W ! D ^DIR K DIR
 I ($D(DIRUT))!($D(DUOUT)) S RCSTOP=1 Q
 Q
 ;
SELPAY(RCNP,RCJOB,RCPAY) ;localize the payer filters for header display
 ; Input:
 ;   RCNP (pass-by-val/required) - payer filter response indicator (2=ALL, 3=SPECIFIC)
 ;   RCJOB - job number to access the populated temporary global array in case report was tasked to run
 ; Output:
 ;   RCPAY (pass-by-ref/required) - local array of payers e.g. RCPAY="ALL", RCPAY(1)="Aetna",
 ;                                  or RCPAY="start payer = end payer"
 ;
 N CNT,I
 I RCNP=2 S RCPAY="ALL" Q
 S:RCJOB="" RCJOB=$J   ; RCJOB should not be null
 I RCNP=3 D  Q
 .S CNT=0
 .F  S CNT=$O(^TMP("RCSELPAY",RCJOB,CNT)) Q:'CNT  D
 ..S RCPAY(CNT)=^TMP("RCSELPAY",RCJOB,CNT)
 ;RCNP indicates a range of payers
 S I=$O(^TMP("RCSELPAY",RCJOB,"")),RCPAY=^(I)_" - "
 S I=$O(^TMP("RCSELPAY",RCJOB,""),-1),RCPAY=RCPAY_^(I)
 Q
RCBAL() ; Get Zero Payment Filter
 ; INPUTS   : User input from keyboard
 ; RETURNS  : Output destination (0=Display; 1=MS Excel)
 ; LOCAL VARIABLES :
 ; DIR,DUOUT - Standard FileMan variables
 ; Y         - User input
 N DIR,DUOUT,Y
 S DIR(0)="Y"
 S DIR("A")="INCLUDE ZERO PAYMENT AMOUNTS (Y/N): "
 S DIR("B")="Y"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DIRUT) S Y=-1
 Q Y
 ;
RLOAD(FILE) ; PRCA*4.5*284 - Load Payer temp global AFTER queued job starts
 ; Load Selected payers from local saved
 I +RCNP=3 M ^TMP("RCSELPAY",$J)=RCNP1 Q
 N CNT,RCPAY,RCINSF,RCINST,NUM,INDX
 ;
 ; Load ALL payers
 I +RCNP=2 D  Q
 .S CNT=0,RCPAY="" F  S RCPAY=$O(^RCY(FILE,"C",RCPAY)) Q:RCPAY=""  S CNT=CNT+1,^TMP("RCSELPAY",$J,CNT)=RCPAY
 ;
 ; Range of Payers
 ; Build list of available stations
 ; Clear workfile
 K ^TMP("RCPAYER",$J)
 S CNT=0,RCPAY=""
 F  S RCPAY=$O(^RCY(FILE,"C",RCPAY)) Q:RCPAY=""  S CNT=CNT+1,^TMP("RCPAYER",$J,CNT)=RCPAY,^TMP("RCPAYER",$J,"B",RCPAY,CNT)=""
 ;
 S RCINSF=$P(RCNP,"^",2),RCINST=$P(RCNP,"^",3),INDX=1
 F  S RCINSF=$O(^TMP("RCPAYER",$J,"B",RCINSF)) Q:RCINSF=""  Q:RCINSF]RCINST  D
 . S NUM=$O(^TMP("RCPAYER",$J,"B",RCINSF,""))
 . S ^TMP("RCSELPAY",$J,INDX)=$G(^TMP("RCPAYER",$J,NUM)),INDX=INDX+1
 Q
