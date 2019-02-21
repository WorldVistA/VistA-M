RCDPEV0 ;ALB/TMK - EDI LOCKBOX WORKLIST VERIFY PAYMENTS ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**208,261,298,326**;Mar 20, 1995;Build 26
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
RPT(RCSCR) ; Print/display discrepancy report
 D FULL^VALM1
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC,POP
 S %ZIS="QM" D ^%ZIS G:POP RPTQ
 I $D(IO("Q")) D  G RPTQ
 . S ZTRTN="DISRPT^RCDPEV0("_RCSCR_","_+$G(^TMP("RCBATCH_SELECTED",$J))_")",ZTDESC="AR - Print ERA Discrepancy Report From Worklist"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 D DISRPT(RCSCR,+$G(^TMP("RCBATCH_SELECTED",$J)))
RPTQ Q
 ;
 ; BEGIN EPRCA*4.5*326
RPT1(RCSCR) ; Print/display discrepancy report - Auto-post ERA
 D FULL^VALM1
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC,POP
 S %ZIS="QM" D ^%ZIS G:POP RPTQ
 I $D(IO("Q")) D  G RPTQ
 . S ZTRTN="DISRPT^RCDPEV0("_RCSCR_","_+$G(^TMP("RCBATCH_SELECTED",$J))_")",ZTDESC="AR - Print Auto-post ERA Discrepancy Report From Worklist"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 D DISRPT1(RCSCR,+$G(^TMP("RCBATCH_SELECTED",$J)))
RPT1Q Q
 ; END PRCA*4.5*326
 ;
DISRPT(RCSCR,RCBATCH) ; Queued job entrypoint
 ; RCSCR = the ien of the entry in file 344.49
 ; RCBATCH = the # of the batch within the ERA.  If all batches, this is null
 N X,Z,Z0,RC3444,RCSTOP,RCPG,RCANY,RCZ,RCZ0,RCZ1,SPLIT,SSN,AMT1,AMT2,RCBILL,RESULT,DTFR1,DTFR2,DTTO1,DTTO2
 S (RCSTOP,RCPG,RCANY)=0
 S RCZ=0 F  S RCZ=$O(^RCY(344.49,RCSCR,1,"ANV",0,RCZ)) Q:'RCZ  D  Q:RCSTOP
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ W:+$G(RCPG) !,"***TASK STOPPED BY USER***" Q
 . S RCZ0=$G(^RCY(344.49,RCSCR,1,RCZ,0))
 . Q:'$D(^RCY(344.49,RCSCR,1,"ASEQ",+RCZ0,RCZ))  ; Not top level
 . Q:RCZ0=""
 . I $G(RCBATCH),$P(RCZ0,U,14)'=RCBATCH Q  ; Not in the batch
 . S SPLIT=(+$O(^RCY(344.49,RCSCR,1,"B",+RCZ0_".9999"),-1)'=(+RCZ0_".001"))
 . S RC3444=$G(^RCY(344.4,RCSCR,1,+$P(RCZ0,U,9),0))
 . S RCBILL=+$G(^IBM(361.1,+$P(RC3444,U,2),0))
 . I 'RCBILL Q  ; PRCA*4.5*326
 . S RCANY=1 ; PRCA*4.5*326
 . S RESULT=$$VER^RCDPEV(RCSCR,RCBILL,+$P(RCZ0,U,9),1)
 . S AMT1=$S($E($P(RESULT,U,5))="*":"*",1:"")_$S($TR($P(RESULT,U,5),"*")="":"NO DATA",1:$J($TR($P(RESULT,U,5),"*"),"",2))
 . S AMT2=$S($E($P(RESULT,U,4))="*":"*",1:"")_$S($TR($P(RESULT,U,4),"*")="":"NO DATA",1:$J($TR($P(RESULT,U,4),"*"),"",2))
 . S DTFR1=$S($TR($P(RESULT,U,7),"*")="":"",1:$S($E($P(RESULT,U,7))="*":"*",1:"")_$$FMTE^XLFDT($TR($P(RESULT,U,7),"*"),"2D"))
 . S DTFR2=$S($TR($P(RESULT,U,6),"*")="":"",1:$S($E($P(RESULT,U,6))="*":"*",1:"")_$$FMTE^XLFDT($TR($P(RESULT,U,6),"*"),"2D"))
 . S DTTO1=$S($TR($P(RESULT,U,9),"*")="":"",1:$S($E($P(RESULT,U,9))="*":"*",1:"")_$$FMTE^XLFDT($TR($P(RESULT,U,9),"*"),"2D"))
 . S DTTO2=$S($TR($P(RESULT,U,8),"*")="":"",1:$S($E($P(RESULT,U,8))="*":"*",1:"")_$$FMTE^XLFDT($TR($P(RESULT,U,8),"*"),"2D"))
 . S X="EEOB Sequence #(s) on the ERA: "_$P(RCZ0,U,9)_"  "_$S($P(RC3444,U,5)'="":$P(RC3444,U,5),$P(RC3444,U,17)'="":$P(RC3444,U,17),$G(RCBILL):$P($G(^DGCR(399,+RCBILL,0)),U),1:"")
 . I ($Y+7)>IOSL!'RCPG D HDR(.RCPG,RCSCR,$G(RCBATCH),.RCSTOP,"U") Q:RCSTOP  ; PRCA*4.5*326
 . W !!,X
 . I ($Y+5)>IOSL D HDR(.RCPG,RCSCR,$G(RCBATCH),.RCSTOP,"U") Q:RCSTOP  ; PRCA*4.5*326
 . S X="VistA: ",SSN=$P(RESULT,U,10),SSN=$E($E(SSN,$L(SSN)-3,$L(SSN))_$J("",4),1,4)
 . S X=X_$S('RCBILL:"NOT RELATED TO A VistA BILL",1:$E($P(RESULT,U,2)_$J("",30),1,30)_" "_SSN_"  "_$E(AMT2_$J("",15),1,15)_"  "_$E($S(DTFR2="":"NO DATA",1:DTFR2)_$J("",9),1,9)_"- "_$S(DTTO2'="":DTTO2,1:"NO DATA"))
 . W !,X
 . S X="  ERA: "_$E($P(RESULT,U,3)_$J("",30),1,30)_$J("",7)_$E(AMT1_$J("",15),1,15)_"  "_$E($S(DTFR1="":"NO DATA",1:DTFR1)_$J("",9),1,9)_"- "_$S(DTTO1'="":DTTO1,1:"NO DATA")
 . W !,X
 . Q:'SPLIT
 . W !,?9,"<<< THIS EEOB HAS BEEN SPLIT >>>"
 . S RCZ1=+RCZ0 F  S RCZ1=$O(^RCY(344.49,RCSCR,1,"B",RCZ1)) Q:(RCZ1\1)'=+RCZ0!RCSTOP  D
 .. S Z=+$O(^RCY(344.49,RCSCR,1,"B",RCZ1,0))
 .. S Z0=$G(^RCY(344.49,RCSCR,1,Z,0))
 .. I ($Y+5)>IOSL D HDR(.RCPG,RCSCR,$G(RCBATCH),.RCSTOP,"U") Q:RCSTOP  ; PRCA*4.5*326
 .. W !,?15,$S($P(Z0,U,7):"",1:"BILL NOT IN VISTA: "),$P(Z0,U,2)_"  "_$J($P(Z0,U,5),"",2)
 . W !
 ;
 I 'RCANY D:'RCPG HDR(.RCPG,RCSCR,$G(RCBATCH),.RCSTOP,"U") W !,"THERE ARE NO UNVERIFIED LINES WITH DISCREPANCIES IN THIS ERA"_$S($G(RCBATCH):" BATCH",1:"") ; PRCA*4.5*326
 I '$D(ZTQUEUED),'RCSTOP,RCPG D ASK()
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 Q
 ;
 ; BEGIN PRCA*4.5*326
DISRPT1(RCSCR,RCBATCH) ; Queued job entrypoint - Auto-post ERA
 ; RCSCR = the ien of the entry in file 344.49
 ; RCBATCH = the # of the batch within the ERA. If all batches, this is null
 ;
 ; Sort verified status into scratchpad sequence
 N ARR,RCZ,RCVER
 F RCVER=0,1 D
 .S RCZ=0
 .F  S RCZ=$O(^RCY(344.49,RCSCR,1,"ANV",RCVER,RCZ)) Q:'RCZ  D
 . . S ARR(RCZ)=RCVER
 ;
 N AMT1,AMT2,DTFR1,DTFR2,DTTO1,DTTO2,RCANY,RCSTOP,RCPG,RCZ0,RCZ1,RCBILL,RCEOB,RCLINE,RESULT
 N SPLIT,SSN,X,Z,Z0
 S (RCSTOP,RCPG,RCANY,RCZ)=0
 F  S RCZ=$O(ARR(RCZ)) Q:'RCZ  D  Q:RCSTOP
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ W:+$G(RCPG) !,"***TASK STOPPED BY USER***" Q
 . S RCZ0=$G(^RCY(344.49,RCSCR,1,RCZ,0))
 . Q:'$D(^RCY(344.49,RCSCR,1,"ASEQ",+RCZ0,RCZ))  ; Not top level
 . Q:RCZ0=""
 . I $G(RCBATCH),$$GET1^DIQ(344.491,RCZ_","_RCSCR_",",.14)'=RCBATCH Q  ; Not in the batch
 . S SPLIT=(+$O(^RCY(344.49,RCSCR,1,"B",+RCZ0_".9999"),-1)'=(+RCZ0_".001"))
 . S RC3444=$G(^RCY(344.4,RCSCR,1,+$P(RCZ0,U,9),0))
 . S RCLINE=+$$GET1^DIQ(344.491,RCZ_","_RCSCR_",",.09)
 . S RCEOB=+$$GET1^DIQ(344.41,RCLINE_","_RCSCR_",",.02,"I")
 . S RCBILL=+$$GET1^DIQ(361.1,RCEOB_",",.01,"I")
 . S RESULT=$$VER^RCDPEV(RCSCR,RCBILL,+RC3444,1)
 . ; Ignore lines with no discrepancies
 . Q:'$F(RESULT,"^*")
 . S RCANY=1
 . S RCVER=ARR(RCZ) ; Verification status
 . S AMT1=$S($E($P(RESULT,U,5))="*":"*",1:"")_$S($TR($P(RESULT,U,5),"*")="":"NO DATA",1:$J($TR($P(RESULT,U,5),"*"),"",2))
 . S AMT2=$S($E($P(RESULT,U,4))="*":"*",1:"")_$S($TR($P(RESULT,U,4),"*")="":"NO DATA",1:$J($TR($P(RESULT,U,4),"*"),"",2))
 . S DTFR1=$S($TR($P(RESULT,U,7),"*")="":"",1:$S($E($P(RESULT,U,7))="*":"*",1:"")_$$FMTE^XLFDT($TR($P(RESULT,U,7),"*"),"2D"))
 . S DTFR2=$S($TR($P(RESULT,U,6),"*")="":"",1:$S($E($P(RESULT,U,6))="*":"*",1:"")_$$FMTE^XLFDT($TR($P(RESULT,U,6),"*"),"2D"))
 . S DTTO1=$S($TR($P(RESULT,U,9),"*")="":"",1:$S($E($P(RESULT,U,9))="*":"*",1:"")_$$FMTE^XLFDT($TR($P(RESULT,U,9),"*"),"2D"))
 . S DTTO2=$S($TR($P(RESULT,U,8),"*")="":"",1:$S($E($P(RESULT,U,8))="*":"*",1:"")_$$FMTE^XLFDT($TR($P(RESULT,U,8),"*"),"2D"))
 . S X="EEOB Sequence #(s) on the ERA: "_$P(RCZ0,U,9)_" "_$S($P(RC3444,U,5)'="":$P(RC3444,U,5),$P(RC3444,U,17)'="":$P(RC3444,U,17),$G(RCBILL):$P($G(^DGCR(399,+RCBILL,0)),U),1:"")
 . W " ("_$S(RCVER:"Verified",1:"Unverified")
 . I ($Y+7)>IOSL!'RCPG D HDR(.RCPG,RCSCR,$G(RCBATCH),.RCSTOP,"A") Q:RCSTOP
 . W !!,X
 . I ($Y+5)>IOSL D HDR(.RCPG,RCSCR,$G(RCBATCH),.RCSTOP,"A") Q:RCSTOP
 . S X="VistA: ",SSN=$P(RESULT,U,10),SSN=$E($E(SSN,$L(SSN)-3,$L(SSN))_$J("",4),1,4)
 . S X=X_$S('RCBILL:"NOT RELATED TO A VistA BILL",1:$E($P(RESULT,U,2)_$J("",30),1,30)_" "_SSN_" "_$E(AMT2_$J("",15),1,15)_" "_$E($S(DTFR2="":"NO DATA",1:DTFR2)_$J("",9),1,9)_"- "_$S(DTTO2'="":DTTO2,1:"NO DATA"))
 . W !,X
 . S X=" ERA: "_$E($P(RESULT,U,3)_$J("",30),1,30)_$J("",7)_$E(AMT1_$J("",15),1,15)_" "_$E($S(DTFR1="":"NO DATA",1:DTFR1)_$J("",9),1,9)_"- "_$S(DTTO1'="":DTTO1,1:"NO DATA")
 . W !,X
 . Q:'SPLIT
 . W !,?9,"<<< THIS EEOB HAS BEEN SPLIT >>>"
 . S RCZ1=+RCZ0 F  S RCZ1=$O(^RCY(344.49,RCSCR,1,"B",RCZ1)) Q:(RCZ1\1)'=+RCZ0!RCSTOP  D
 .. S Z=+$O(^RCY(344.49,RCSCR,1,"B",RCZ1,0))
 .. S Z0=$G(^RCY(344.49,RCSCR,1,Z,0))
 .. I ($Y+5)>IOSL D HDR(.RCPG,RCSCR,$G(RCBATCH),.RCSTOP,"A") Q:RCSTOP
 .. W !,?15,$S($P(Z0,U,7):"",1:"BILL NOT IN VISTA: "),$P(Z0,U,2)_" "_$J($P(Z0,U,5),"",2)
 . W !
 ;
 I 'RCANY D
 .D:'RCPG HDR(.RCPG,RCSCR,$G(RCBATCH),.RCSTOP,"A")
 .W !,"THERE ARE NO AUTO-POST LINES WITH DISCREPANCIES IN THIS ERA"
 .W $S($G(RCBATCH):" BATCH",1:"")
 I '$D(ZTQUEUED),'RCSTOP,RCPG D ASK()
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 Q
 ; END PRCA*4.5*326
 ;
HDR(RCPG,RCSCR,RCBATCH,RCSTOP,RCTYP) ;Print header - RCTYP added - PRCA*4.5*326
 ; RCPG = last page #
 ; RCSCR = the entry # in file 344.49
 ; RCSTOP = returned as 1 if abort is detected
 ; RCTYP = 'A' for all verification discrepancies, 'U' for unverified discrepancies only
 N RCDAT,RCPAY,RCTRACE ; PRCA*4.5*326
 I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ W:+$G(RCPG) !,"***TASK STOPPED BY USER***" Q
 I RCPG&($E(IOST,1,2)="C-") D ASK(.RCSTOP) Q:RCSTOP
 S RCDAT=$$GET1^DIQ(344.4,RCSCR_",",.04,"I") ; PRCA*4.5*326
 S RCPAY=$$GET1^DIQ(344.4,RCSCR_",",.06,"I") ; PRCA*4.5*326
 S RCTRACE=$$GET1^DIQ(344.4,RCSCR_",",.02,"I") ; PRCA*4.5*326
 W !,@IOF,*13
 S RCPG=$G(RCPG)+1
 ; BEGIN PRCA*4.5*326
 I RCTYP="U" W !,"EDI LBOX WORKLIST - UNVERIFIED LINES DISCREPANCIES REPORT",?59
 E   W !,"EDI LBOX WORKLIST - AUTOPOST ERA LINES DISCREPANCIES REPORT",?61
 W $$FMTE^XLFDT(DT,2),?70,"Page: ",RCPG,!
 W !,"ERA #: ",RCSCR,?20
 W $S($O(^RCY(344.49,RCSCR,3,0)):"BATCH: "_$E($S($G(RCBATCH):+RCBATCH,1:"ALL")_$J("",11),1,11),1:$J("",18))
 W "TRACE #: "_RCTRACE
 W !,"PAYER: "_$E(RCPAY_$J("",30),1,30)_"  ERA DT: "_$$FMTE^XLFDT(RCDAT,"2D")
 ; END PRCA*4.5*326
 W !!,?7,"PATIENT NAME"_$J("",25)_"SUBMITTED AMT    SVC DATE(S)"
 W !,"* preceding data = data has discrepancy"
 W !,$TR($J("",IOM)," ","=")
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
