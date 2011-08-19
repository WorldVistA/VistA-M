IBCFP1 ;ALB/ARH - PRINT AUTHORIZED BILLS IN ORDER ;6-DEC-94
 ;;2.0;INTEGRATED BILLING;**54,52,80,121,51,137,155,320,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
QTASK ; 1st part sorts authorized bills into order requested by bill form type then queues off 1 job for each type to print bills
 ;
 D GCLEAN S IBXP=$$FMADD^XLFDT(DT,1)_"^"_DT_"^BATCH PRINT BILLS "_$$HTE^XLFDT($H)_" by "_$S($D(^VA(200,+$G(DUZ),0)):$P(^(0),"^"),1:"Unknown User")
SORT ;sort authorized bills by form type and requested sort order (notice bill addendums only print for 1500's)
 S (IBQ,IBIFN)=0 F  S IBIFN=$O(^DGCR(399,"AST",3,IBIFN)) Q:'IBIFN!IBQ  D  I $$STOP S IBQ=1 Q
 . Q:+$$TXMT^IBCEF4(IBIFN)=1  ;Exclude transmittable bills
 . S IBFT=$$FT^IBCU3(IBIFN) Q:$P($G(^IBE(353,+IBFT,0)),U,2)=""  I IBFT'?1N Q  ;No device for form type
 . S IBX=$G(^DGCR(399,IBIFN,0)),IBPAT=$P($G(^DPT(+$P(IBX,U,2),0)),U,1) Q:$P(IBX,U,13)'=3
 . S IBZIP=$P($G(^DGCR(399,IBIFN,"M")),U,9),IBINS=$P($G(^DIC(36,+$G(^DGCR(399,IBIFN,"MP")),0)),U,1)
 . S IBX=IBZIP_U_IBINS_U_IBPAT,IBS1=$P(IBX,U,$E(IBS,1))_" ",IBS2=$P(IBX,U,$E(IBS,2))_" ",IBS3=$P(IBX,U,$E(IBS,3))_" "
 . S ^XTMP("IBCFP"_IBFT,0)=IBXP,^XTMP("IBCFP"_IBFT,$J,IBS1,IBS2,IBS3,IBIFN)=""
 . S XIBFT=IBFT  ;save off curent value of IBFT
 . ;
 . ; set MRA queue to print
 . S IBFT=$$FNT^IBCU3("MRA")
 . ; Merge the data from ^XTMP("IBCFP" queue, into "IBMRA" queue
 . I +IBFT,$P($G(^IBE(353,+IBFT,0)),U,2)'="" S ^XTMP("IBMRA"_IBFT,0)=IBXP M ^XTMP("IBMRA"_IBFT,$J)=^XTMP("IBCFP"_XIBFT,$J)
 . ;
 . ; Print Bill Addendums only for 1500's
 . I $$FTN^IBCU3(XIBFT)'["CMS-1500" Q
 . S IBFT=$$FNT^IBCU3("BILL ADDENDUM")
 . I +IBFT,$P($G(^IBE(353,+IBFT,0)),U,2)'="" S ^XTMP("IBCFP"_IBFT,0)=IBXP,^XTMP("IBCFP"_IBFT,$J,IBS1,IBS2,IBS3,IBIFN)=""
 . Q
 K IBIFN,IBFT,XIBFT,IBX,IBY,IBPAT,IBZIP,IBINS,IBS1,IBS2,IBS3,IBS,IBXP
 ;
QUEUE ; starts a queued job for each form type that an authorized bill was found for
 ; no form types without defined device
 I IBQ D GCLEAN ;queued job stopped
 I 'IBQ D
 . ; queue a job for each form type
 . S IBIX="IBCFP" F  S IBIX=$O(^XTMP(IBIX)) Q:(IBIX'?1"IBCFP"1N)  I $D(^XTMP(IBIX,$J)) S IBFT=$E(IBIX,6) D
 . . S ZTIO=$P($G(^IBE(353,+IBFT,0)),U,2),IBFTP=IBIX,IBJ=$J
 . . S ZTDTH=$H,ZTSAVE("IBFTP")="",ZTSAVE("IBFT")="",ZTSAVE("IBJ")=""
 . . S ZTDESC="BATCH PRINTING "_$$FTN^IBCU3(+IBFT),ZTRTN="QBILL^IBCFP1" D ^%ZTLOAD
 . ; Also queue a job to print MRA's, if any, for each bill
 . S IBIX="IBMRA" F  S IBIX=$O(^XTMP(IBIX)) Q:(IBIX'?1"IBMRA"1N)  I $D(^XTMP(IBIX,$J)) S IBFT=$E(IBIX,6) D
 . . S ZTIO=$P($G(^IBE(353,+IBFT,0)),U,2),IBFTP=IBIX,IBJ=$J
 . . S ZTDTH=$H,ZTSAVE("IBFTP")="",ZTSAVE("IBFT")="",ZTSAVE("IBJ")=""
 . . S ZTDESC="BATCH PRINTING MRA'S",ZTRTN="QMRA^IBCEMU2" D ^%ZTLOAD
 K IBIX,IBY,IBFTP,IBJ ; end of first queued part
 Q
 ;
GCLEAN ; Clean up XTMP global for $J of IBCFP and IBMRA entries
 N I
 S I="IBCFP" F  S I=$O(^XTMP(I)) Q:I'?1"IBCFP"1N.N  K ^XTMP(I)
 S I="IBMRA" F  S I=$O(^XTMP(I)) Q:I'?1"IBMRA"1N.N  K ^XTMP(I)
 Q
 ;
QBILL ; 2nd queued part will print all authorized bills for a specific form type
 N IBF,IBFORM,IBPNT
 S IBF=$P($G(^IBE(353,+IBFT,2)),U,8),IBPNT=1
 I $D(IBMCSPNT) S IBPNT=IBMCSPNT    ; IB*320 - MCS resubmit by print
 I IBF'="" S IBFORM=IBF D FORMOUT^IBCEFG7 Q  ;call formatter
 ;
QB1 ; Entrypoint for output logic of formatter
 ; pass in "^XTMP(IBFTP,IBJ)" sorted array of bills to print
 ;         IBFTP = "IBCFP"_(form type) subscript indicating which part of array to print
 ;         IBPNT = reprint status of bill (1-original, 0-copy, etc)
 ;         IBFT  = IFN of bill form type to be printed
 ;         IBJ   = $J of starting job (for when multiple print jobs might be queued)
 ;                 if a single bill printed and queued, IBJ will be null
 S:$G(IBJ)="" IBJ=$J
 S:'$D(IBPNT) IBPNT=1
 N IBCT,IBBN,IBS1,IBS2,IBS3,IBQ,IBIFN
 S (IBCT,IBQ,IBS1)=0
 S ZTREQ="@"
 F  S IBS1=$O(^XTMP(IBFTP,IBJ,IBS1)) Q:IBS1=""!IBQ  D
 . S IBS2=0 F  S IBS2=$O(^XTMP(IBFTP,IBJ,IBS1,IBS2)) Q:IBS2=""!IBQ  D
 .. S IBS3=0 F  S IBS3=$O(^XTMP(IBFTP,IBJ,IBS1,IBS2,IBS3)) Q:IBS3=""!IBQ  D
 ... S IBBN=0 F  S IBBN=$O(^XTMP(IBFTP,IBJ,IBS1,IBS2,IBS3,IBBN)) Q:IBBN=""  D  I $$STOP S IBQ=1 Q
 .... D ROUT(IBFT,IBPNT,IBBN,.IBCT)
 K ^XTMP(IBFTP,IBJ) ; end of last queued part
 Q
 ;
ROUT(IBFT,IBPNT,IBIFN,IBCT,IBF) ; sub procedure to protect variables with new
 N IBBN,IBS1,IBS2,IBS3,IBQ,IBFTP,IBJ,IBXPARM,Z
 D BILLPARM^IBCEFG0(IBIFN,.IBXPARM)
 S IBF=$S($G(IBF)'="":IBF,1:$P($G(^IBE(353,+IBFT,2)),U,8))
 S IBCT=$G(IBCT)+1
 ;
 ; IBF exists - use the Output Formatter for printing
 ;     2.08 field in file 353 - PRINT FORM NAME
 I IBF'="" S Z=$$EXTRACT^IBCEFG(IBF,IBIFN,.IBCT,.IBXPARM) G REX
 ;
 ; IBF does not exist - Obsolete VistA extract/print routines
 I IBFT=1 S DFN=$P($G(^DGCR(399,+IBIFN,0)),U,2) D ENP^IBCF1 W @IOF G REX
 I $$FTN^IBCU3(+IBFT)="HCFA 1500" D EN^IBCF2 W @IOF G REX
 I $$FTN^IBCU3(+IBFT)="UB-92" D EN^IBCF3 W @IOF G REX
 ;
 ; print bill addendums
 I $$FTN^IBCU3(+IBFT)="BILL ADDENDUM" I +$$BILLAD^IBCF4(IBIFN) D EN^IBCF4 W @IOF G REX
 ;
REX Q
 ;
DATE(X) Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
STOP() ;determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
 ;
FORMPRE ; Set up environment for bill message
 K ^TMP("IBXMSG",$J),^TMP("IBXERR",$J),IBXERR,^TMP("IBXDATA",$J)
 Q
 ;
FORMPOST ; Clean up
 I $O(^TMP("IBXERR",$J,"")) D  ;Error messages to mail group
 .N XMTO,XMBODY,XMDUZ,XMSUBJ,IBCT,IBERR
 .K ^TMP("IBXMSG",$J)
 .S ^TMP("IBXMSG",$J,1)="The following bill(s) were not printed due to errors indicated.",^(2)="Once the errors are corrected, the bill(s) can be printed again.",^(3)=" "
 .;
 .S IBERR=0,IBCT=3
 .F  S IBERR=$O(^TMP("IBXERR",$J,IBERR)) Q:'IBERR  S IBCT=IBCT+1,^TMP("IBXMSG",$J,IBCT)="Bill #: "_$P($G(^DGCR(399,IBERR,0)),U),IBCT=IBCT+1,^TMP("IBXMSG",$J,IBCT)=$J("",5)_^TMP("IBXERR",$J,IBERR)
 .S XMBODY="^TMP(""IBXMSG"","_$J_")" D ERRMSG(XMBODY)
 .K ^TMP("IBXMSG",$J),^TMP($J,"IBICT")
 ;
 K ^TMP("IBXERR",$J),IBXERR
 D CLEAN^DILF
 Q
 ;
ENTPRE ; Run before processing a bill entry
 K IBXSAVE,IBXERR,^UTILITY("VAPA",$J),^TMP("IBXSAVE",$J),^TMP($J),^TMP("DIERR",$J)
 Q
 ;
ENTPOST ; Run after processing a bill entry
 N IBIFN
 I $G(IBXERR)'="" S ^TMP("IBXERR",$J,IBXIEN)=IBXERR K ^TMP("IBXDATA",$J)
 S IBIFN=IBXIEN D END^IBCF2
 K IBXSAVE,^UTILITY("VAPA",$J),^TMP($J),^TMP("IBXSAVE",$J)
 D CLEAN^DILF
 Q
 ;
ERRMSG(XMBODY) ; Send bulletin for error message
 N XMTO,XMSUBJ
 S XMTO($G(DUZ))="",XMSUBJ="PRINT BILL ERRORS"
 ;
 D SENDMSG^XMXAPI(,XMSUBJ,XMBODY,.XMTO)
 D ALERT("One or more bills were not printed.  Check your mail for details",$G(DUZ))
 Q
 ;
ALERT(XQAMSG,IBGRP) ; Send alert message
 N XQA
 S XQA(IBGRP)=""
 D SETUP^XQALERT
 Q
