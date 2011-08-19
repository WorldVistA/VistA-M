IBTODD ;ALB/AAS - CLAIMS TRACKING DENIED DAYS REPORT ; 27-OCT-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**32**; 21-MAR-94
 ;
% I '$D(DT) D DT^DICRW
 W !!,"Denied Days Report",!!
 ;
 S IBSORT="P"
 N DIR
 S DIR("?")="Answer YES if you only want to print a summary or answer NO if you want a detailed listing plus the summary."
 S DIR(0)="Y",DIR("A")="Print Summary Only",DIR("B")="YES" D ^DIR K DIR
 I $D(DIRUT) G END
 S IBSUM=Y
 G:IBSUM DATE
 ;
 ; -- ask how they want it sorted
 D SORT^IBTODD2 I IBSORT<0 G END
 ;
DATE ; -- select date range
 W ! D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") G END
 ;
DEV ; -- select device, run option
 W !
 I 'IBSUM W !!,"You will need a 132 column printer for this report!",!
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBTODD",ZTSAVE("IB*")="",ZTDESC="IB - Denied Days Report" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G END
 ;
 U IO
 D DQ G END
 Q
 ;
END ; -- Clean up
 W ! K ^TMP($J,"IBTODD")
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K I,J,X,X2,Y,DFN,%ZIS,DGPM,VA,IBI,IBJ,IBTRN,IBTRND,IBTRND1,IBPAG,IBHDT,IBDISDT,IBETYP,IBQUIT,IBTAG,IBTRC,IBTRCD,IBDEN,IBDAY,IBTALL,IBADM,IBDISCH,IBMAX
 K IBAPL,IBBBS,IBBDT,IBC,IBCDT,IBCNT,IBDT,IBD,IBDATA,IBEDT,IBNAM,IBPRIM,IBPROV,IBRATE,IBSECN,IBSERV,IBSORT,IBSPEC,IBSUM,IBSUBT,IBTOTL
 D KVAR^VADPT
 Q
DQ ; -- entry print from taskman
 K ^TMP($J,"IBTODD")
 S X=132 X ^%ZOSF("RM")
 S IBPAG=0,IBHDT=$$HTE^XLFDT($H,1),IBQUIT=0
 S IBDEN=$O(^IBE(356.7,"ACODE",20,0))
 D BLD,PRINT^IBTODD1
 I $D(ZTQUEUED) G END
 Q
 ;
BLD ; -- sort through data and build array to print from
 ;
 S IBTRC=0
 F  S IBTRC=$O(^IBT(356.2,"ACT",IBDEN,IBTRC)) Q:'IBTRC  D
 .N IBDAY S IBTRCD=$G(^IBT(356.2,+IBTRC,0))
 .S IBTRN=$P(IBTRCD,"^",2),IBTRND=$G(^IBT(356,+IBTRN,0))
 .Q:'$P(IBTRCD,"^",19)  ; review is inactive
 .Q:'$P(IBTRND,"^",20)  ; parent CT entry is inactive
 .S IBDDB=$P(IBTRCD,"^",15),IBDDE=$P(IBTRCD,"^",16)
 .S IBTALL=$P($G(^IBT(356.2,+IBTRC,1)),"^",7)
 .I IBDDB,IBDDE Q:(IBDDB>IBEDT)!(IBDDE<IBBDT)  D
 ..I IBDDB<IBBDT S IBDDB=IBBDT ; chk days denied in correct range
 ..I IBDDE>IBEDT S IBDDE=IBEDT
 ..S IBDAY=$$FMDIFF^XLFDT(IBDDE,IBDDB)+1 ; cals total denied days
 .; if no days denied "to" and "from" and episode in range
 .I (IBTALL),('$D(IBDAY)) S IBCDT=$$CDT^IBTODD1(IBTRN) D STRIP Q:('+IBCDT!(+IBCDT>IBEDT))  D
 ..Q:'$P(IBTRND,U,5)  ; quit if no link between ct and dgpm
 ..; if the care date is >the report range there is no discharge add 1
 ..I '$P(IBCDT,U,2)!($P(IBCDT,U,2)>IBEDT) S $P(IBCDT,U,2)=$$FMADD^XLFDT(IBEDT,1)
 ..I +IBCDT<IBBDT S $P(IBCDT,U,1)=IBBDT
 ..S IBDAY=$$FMDIFF^XLFDT($P(IBCDT,U,2),$P(IBCDT,U,1))
 .Q:$G(IBDAY)<1
 .S DFN=$P(IBTRCD,"^",5),IBNAM=$P($G(^DPT(+DFN,0)),"^") Q:IBNAM=""
 .S IBD=$$PROV(DFN,IBTRCD,IBTRND,IBTALL),IBPROV=+IBD,IBSPEC=$P(IBD,"^",2),IBSERV=$P(IBD,"^",3)
 .S IBBBS=$$BBS^IBTOSUM1($P(IBD,"^",2))
 .S IBRATE=$$RATE^IBTOSUM1(IBBBS,+IBTRCD)
 .D SET
 K IBTRN,IBTRND,IBTRCD,DFN,IBDDB,IBDDE,IBCDT
 Q
 ;
SET ; -- set array to print from
 ; -- ^tmp($j,"ibtodd",primary sort,secondary sort,ibtrc)=DFN ^ attending ^ treating specialty ^ service ^ billing bed section ^ billing rate^ no. days denied
 S IBPRIM=$S(IBSORT="P":IBNAM,IBSORT="A":IBPROV,1:IBSERV)
 S IBSECN=$S(IBSORT="P":IBPROV,1:IBNAM)
 S:IBPRIM="" IBPRIM="UNKNOWN" S:IBSECN="" IBSECN="UNKNOWN"
 S ^TMP($J,"IBTODD",IBPRIM,IBSECN,IBTRC)=DFN_"^"_IBPROV_"^"_IBSPEC_"^"_IBSERV_"^"_IBBBS_"^"_IBRATE_"^"_IBDAY
 Q
 ;
PROV(DFN,IBTRCD,IBTRND,IBTALL) ; Find attending/serv/spec during the denied period
 ;  Input:    DFN  --  Pointer to the patient in file #2
 ;         IBTRCD  --  Zeroth node of insurance review in file #356.2
 ;         IBTRND  --  Zeroth node of parent CT entry in file #356
 ;         IBTALL  --  1=> deny entire admission
 ; Output:  1^2^3, where   1 => pointer to attending in file #200
 ;                         2 => pointer to treating spec. in file #45.7
 ;                         3 => service abbr. code
 ;
 N I,J,X,Y,DGPM,IBD,VA200,VAIN,VAIP,VAERR
 ;
 ; - determine date/time to calculate attending/serv/spec
 S DGPM=+$P(IBTRND,"^",5),IBD=+$G(^DGPM(DGPM,0))
 S:'IBD IBD=$P(IBTRND,"^",6)
 I IBTALL S Y=IBD
 I 'IBTALL D
 .I $P(IBTRCD,"^",16)>$P(IBTRCD,"^",15) S Y=$P(IBTRCD,"^",15)_.2359 Q
 .I $P(IBTRCD,"^",15)=(IBD\1) S Y=IBD Q
 .S VAIP("D")=$P(IBTRCD,"^",15) D IN5^VADPT
 .I +VAIP(16,1)\1=$P(IBTRCD,"^",15) S Y=+VAIP(16,1) Q
 .S Y=$P(IBTRCD,"^",15)
 S VA200="",VAINDT=Y D INP^VADPT
 ;
 S X=+VAIN(11)
 S Y=$G(^IBT(356.94,+$O(^IBT(356.94,"ATP",+DGPM,1,0)),0))
 S:$P(Y,"^",3) X=$P(Y,"^",3)
PROVQ Q X_"^"_+VAIN(3)_"^"_$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+$G(VAIN(3)),0)),"^",2),0)),"^",3)
 ;
STRIP ; -- strip time from dates (if report run same day time could produce incorrect results)
 S $P(IBCDT,U,1)=$P(IBCDT,".",1),$P(IBCDT,U,2)=$P($P(IBCDT,U,2),".",1) Q
