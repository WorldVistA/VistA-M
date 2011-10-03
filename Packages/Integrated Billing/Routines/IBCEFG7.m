IBCEFG7 ;ALB/TMP - OUTPUT FORMATTER GENERIC FORM PROCESSING ;06-MAR-96
 ;;2.0;INTEGRATED BILLING;**52,84,96,51,137,191,320**;21-MAR-94
 ;
 Q
 ;
FORM(IBFORM,IBQUE,IBNOASK,IBQDT,ZTSK,IBABORT) ;For ien IBFORM, extract data using
 ;    output generater
 ; IBQUE = the output queue for transmitted forms or the printer queue
 ;          for printed output
 ; IBNOASK = flag that says user interaction for queuing is not needed
 ;           0 or null = ask, 1 = don't ask
 ; IBQDT = the date/time to queue the job (optional)
 ;
 ; Sets ZTSK only if job is queued
 ;
 ; IBABORT = output parameter which says user aborted forms output.
 ;           Pass by reference.  The $$QUEUE function returned false.
 ;
 N IBF2,IBTYP,POP,ZTIO,ZTRTN,ZTDESC,ZTSAVE,ZTREQ,ZTDTH,ZTREQ
 S IBTYP=$P($G(^IBE(353,IBFORM,2)),U,2),IBQUE=$G(IBQUE),IBABORT=0
 G:$S(IBTYP'="S":$G(^IBE(353,IBFORM,"EXT"))=""&($G(^IBE(353,+$P($G(^IBE(353,IBFORM,2)),U,5),"EXT"))=""),1:'$G(IBIFN)) FORMQ
 I IBTYP="P",IBQUE="" D DEV(IBFORM) G:$G(POP) FORMQ
 I IBTYP="T" D:$G(IBNOASK)  Q:$G(IBNOASK)  I '$$QUEUE(IBFORM) S:$O(^TMP("IBRESUBMIT",$J,0)) ^TMP("IBRESUBMIT",$J)="ABORT" S IBABORT=1 Q
 . S ZTRTN="FORMOUT^IBCEFG7",ZTIO="",ZTDESC="OUTPUT FORMATTER - FORM: "_$P($G(^IBE(353,IBFORM,0)),U),ZTSAVE("IB*")="",ZTDTH=$S($G(IBQDT):IBQDT,1:$$NOW^XLFDT())
 . S:$D(^TMP("IBRESUBMIT",$J)) ZTSAVE("^TMP(""IBRESUBMIT"",$J)")="",ZTSAVE("^TMP(""IBNOT"",$J)")="",ZTSAVE("^TMP(""IBRESUBMIT"",$J,")="",ZTSAVE("^TMP(""IBNOT"",$J,")=""
 . I $D(^TMP("IBSELX",$J)) S ZTSAVE("^TMP(""IBSELX"",$J,")="",ZTSAVE("^TMP(""IBSELX"",$J)")=""
 . S:'$G(DUZ) DUZ=.5
 . D ^%ZTLOAD
 I '$G(ZTSK) D FORMOUT
FORMQ Q
 ;
FORMOUT ; Queued job entrypoint - IBFORM needs to be defined
 ; IBQUE needs to be defined if using default transmission output
 N IB2,IBTYP,IBPAR
 K ^TMP("IBXDATA",$J)
 S ZTREQ="@"
 S IB2=$G(^IBE(353,IBFORM,2)),IBPAR=+$P(IB2,U,5),IBTYP=$P(IB2,U,2)
 ;
 ; Execute PRE-PROCESSOR
 I IBTYP'="S" D FPRE(IBFORM,IBPAR,.IBXERR)
 G:$G(IBXERR)'="" FOUTQ
 ;
 ; Extract records - this should include call(s) to $$EXTRACT^IBCEFG()
 I IBTYP'="S" D
 .I $G(^IBE(353,IBFORM,"EXT"))'="" X ^("EXT") ;Form extract
 .I $G(^IBE(353,IBFORM,"EXT"))="",$G(^IBE(353,IBPAR,"EXT"))'="" X ^("EXT") ;Parent form extract
 I IBTYP="S" D  G Q1
 .N PARAM,Z,Z0
 .S PARAM(1)="BILL-SEARCH",Z0=$G(^DGCR(399,IBIFN,0))
 .S Z=$P(Z0,U,21) S:Z="" Z="P" S PARAM(2)=$P($G(^DGCR(399,IBIFN,"I"_($F("PST",Z)-1))),U),PARAM(3)=$S($P(Z0,U,5)<3:"I",1:"O")
 .S Z=$$EXTRACT^IBCEFG(IBFORM,IBIFN,1,.PARAM)
 ;
 G:'$D(^TMP("IBXDATA",$J)) FOUTQ
 ;
 ; If an output routine exists, use it, otherwise use the generic ones
 I $G(^IBE(353,IBFORM,"OUT"))'="" X ^("OUT") G FOUTQ
 I $G(^IBE(353,IBFORM,"OUT"))="",$G(^IBE(353,IBPAR,"OUT"))'="" X ^("OUT") G FOUTQ
 ;
 I IBTYP="P" D PRINT(IBFORM) D:'$D(ZTQUEUED) ^%ZISC G FOUTQ
 I IBTYP="T" D:$G(IBQUE)'="" TRANSMIT(IBFORM,IBQUE) G FOUTQ
 ;
FOUTQ D FPOST(IBFORM,IBPAR,.IBXERR) ; Execute POST-PROCESSOR, if any
 K ^TMP("IBXDATA",$J),^TMP("IBXEDIT",$J)
Q1 Q
 ;
PRINT(IBFORM) ; Print data from extract global for form IBFORM
 ; Extract records - this should include call(s) to $$EXTRACT^IBCEFG()
 N IB1,IB2,IB3,IBREC
 ;LOOP THROUGH RECORD/PAGE/LINE/COL
 S IBREC="" F  S IBREC=$O(^TMP("IBXDATA",$J,IBREC)) Q:IBREC=""  D  ;Rec
 . ;Page/line
 . F IB1=1:1:+$O(^TMP("IBXDATA",$J,IBREC,""),-1) W:IB1>1 @IOF W ?0 F IB2=1:1:+$O(^TMP("IBXDATA",$J,IBREC,IB1,""),-1) W:IB2>1 ! S IB3="" D
 .. ; Column
 .. F  S IB3=$O(^TMP("IBXDATA",$J,IBREC,IB1,IB2,IB3)) Q:IB3=""  W ?(IB3-1),^(IB3)
 . ;Only print form feed if more records to print - not on last record
 . I $O(^TMP("IBXDATA",$J,IBREC))'="" W @IOF
 Q
 ;
TRANSMIT(IBFORM,IBQUE) ; Send data from extract global to queue IBQUE
 ;IBFORM = ien of the form to be transmitted (required)
 N IB1,IB2,IB3,IBREC,IBOUT,IBCT,IBSUB,Z,XMDUZ,XMSUBJ,XMBODY,XMTO
 K ^TMP("IBXTXMT",$J),^TMP("IBX",$J)
 Q:$G(IBQUE)=""
 ;
 S IBDELIM=$P($G(^IBE(353,+$S($P($G(^IBE(353,IBFORM,2)),U,5):$P(^(2),U,5),1:IBFORM),2)),U,7)
 S:IBDELIM="" IBDELIM="^"
 ;Loop through record/page/line/column
 S IBREC="",(IBSIZE,IBCT)=0,IBMSG=1
 F  S IBREC=$O(^TMP("IBXDATA",$J,IBREC)) Q:IBREC=""  D
 .S ^TMP("IBX",$J,IBREC)=IBCT
 .S IB1="" F  S IB1=$O(^TMP("IBXDATA",$J,IBREC,IB1)) Q:IB1=""  D
 ..S (IB2,IBOUT)=""
 ..F  S IB2=$O(^TMP("IBXDATA",$J,IBREC,IB1,IB2)) D:IB2=""&$L(IBOUT) MSG(IBREC,IBOUT,.IBMSG,.IBSIZE,.IBCT) Q:IB2=""  D
 ...S IB3="" F  S IB3=$O(^TMP("IBXDATA",$J,IBREC,IB1,IB2,IB3)) Q:IB3=""  S IBP=^(IB3) S:IBP?.E1L.E IBP=$$UP^XLFSTR(IBP) S $P(IBOUT,IBDELIM,IB3)=IBP
 ;
 ;Send mail message(s) for extract
 S XMDUZ=DUZ,XMTO(IBQUE)="",IBSUB="OUTPUT FORMATTER: "_$P($G(^IBE(353,IBFORM,0)),U)
 S Z="" F  S Z=$O(^TMP("IBXTXMT",$J,Z)) Q:'Z  S XMBODY="^TMP(""IBXTXMT"","_$J_","_Z_")",XMSUBJ=IBSUB_" ("_Z_")" D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 ;
 K ^TMP("IBXTXMT",$J),^TMP("IBX",$J)
 Q
 ;
MSG(IBREC,LINE,MSG,SIZE,CT) ; Set up global for transmission line
 ; IBREC = record number being processed
 ; LINE = actual text to be output in mail message line
 ; MSG  = the message seq # to output this record in (pass by reference)
 ; SIZE = current size of the message (pass by reference)
 ; CT   = the last line # in message for the text (pass by reference)
 N Z,Z0,LLEN
 S LLEN=$L(LINE)
 I (LLEN+SIZE)>30000 D
 .Q:'$G(^TMP("IBX",$J,IBREC))  ;Record itself is > 30000 - let it go
 .S (SIZE,CT)=0,Z=$G(^TMP("IBX",$J,IBREC)),^(IBREC)=0
 .F  S Z=$O(^TMP("IBXTXMT",$J,MSG,Z)) Q:'Z  S CT=CT+1,Z0=^(Z),^TMP("IBXTXMT",$J,MSG+1,CT)=Z0,SIZE=SIZE+$L(Z0) K ^TMP("IBXTXMT",$J,MSG,Z)
 .S MSG=MSG+1
 S CT=CT+1,^TMP("IBXTXMT",$J,MSG,CT)=LINE,SIZE=SIZE+LLEN
 Q
 ;
DEV(IBFORM,NOQ) ;
 N IBFTYPE
 S:'$G(NOQ) %ZIS="Q" S %ZIS("A")="Output Device: "
 S %ZIS("B")=$P($G(^IBE(353,IBFORM,0)),"^",2)
 D ^%ZIS
 G:POP DEVQ
 I $D(IO("Q")) D  G DEVQ
 .S ZTRTN="FORMOUT^IBCEFG7",ZTDESC="PRINT FORM: "_$P($G(^IBE(353,IBFORM,0)),U),ZTSAVE("IB*")="" K ZTIO
 .I $D(^TMP("IBQONE",$J)) D
 ..S IBJ="",IBFTYPE="IBCFP"_$S($P($G(^IBE(353,IBFORM,2)),U,5):$P(^(2),U,5),1:IBFORM)
 ..S ZTSAVE("^XTMP(IBFTYPE,$J,")=""
 .D ^%ZTLOAD K IO("Q") D HOME^%ZIS
 .I $G(IBFTYPE)'="" K ^XTMP(IBFTYPE,$J)
 .I $D(ZTSK) W !!,"This job has been queued.  The task number is "_ZTSK_"."
 U IO
DEVQ Q
 ;
QUEUE(IBFORM) ; Ask to queue transmission
 N Y,DIR,OKAY
 S OKAY=1
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to queue this transmission" W !
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S OKAY=0 G QUEQ
 I 'Y D  G QUEQ
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to run this job without queuing it now"
 .W ! D ^DIR K DIR
 .I 'Y S OKAY=0
 ; - queue job to run
 W !!,"Please enter the date and time to execute this job...",!
 S ZTRTN="FORMOUT^IBCEFG7",ZTIO="",ZTDESC="OUTPUT FORMATTER - FORM: "_$P($G(^IBE(353,IBFORM,0)),U),ZTSAVE("IB*")=""
 S:$D(^TMP("IBRESUBMIT",$J)) ZTSAVE("^TMP(""IBRESUBMIT"",$J)")="",ZTSAVE("^TMP(""IBNOT"",$J)")="",ZTSAVE("^TMP(""IBRESUBMIT"",$J,")="",ZTSAVE("^TMP(""IBNOT"",$J,")=""
 I $D(^TMP("IBSELX",$J)) S ZTSAVE("^TMP(""IBSELX"",$J,")="",ZTSAVE("^TMP(""IBSELX"",$J)")=""
 D ^%ZTLOAD
 I $G(ZTSK) W !!,"This job has been queued.  The task number is "_ZTSK_"."
QUEQ Q OKAY
 ;
FPRE(IBFORM,IBPAR,IBXERR) ; Executes pre-processor
 I $G(^IBE(353,IBFORM,"FPRE"))'="" X ^("FPRE") ;Form pre-processor
 I $G(^IBE(353,IBFORM,"FPRE"))="",$G(^IBE(353,IBPAR,"FPRE"))'="" X ^("FPRE") ;Parent form pre-processor
 Q
 ;
FPOST(IBFORM,IBPAR,IBXERR) ; Executes post-processor
 I $G(^IBE(353,IBFORM,"FPOST"))'="" X ^("FPOST") ;Form post-processor
 I $G(^IBE(353,IBFORM,"FPOST"))="",$G(^IBE(353,IBPAR,"FPOST"))'="" X ^("FPOST") ;Parent form post-processor
 Q
 ;
FMFLD(IBDA) ;Return the file#field for fileman field referenced as a data
 ; element in file 364.7's IBDA entry.
 N Z,Z0,ND0
 S Z0=+$P($G(^IBA(364.7,IBDA,0)),U,3),ND0=$G(^IBA(364.5,+Z0,0))
 I $P(ND0,U,3)'="F"!($P(ND0,U,6)="") S Z="" G FLDQ
 S Z=$P(ND0,U,5),Z1=$P(ND0,U,6)
 I Z1[":" D  ;Navigation
 . S Z2=$O(^DD(+Z,"B",$P(Z1,":"),"")) Q:'Z2
 . S Z=+$P($P($G(^DD(399,Z2,0)),U,2),"P",2)
 . I Z S Z1=$P(Z1,":",2)
 I Z S Z=Z_"#"_$O(^DD(+Z,"B",Z1,""))
FLDQ Q Z
 ;
