IBTODD ;ALB/AAS - CLAIMS TRACKING DENIED DAYS REPORT ; 27-OCT-93
 ;;2.0;INTEGRATED BILLING;**32,458**;21-MAR-94;Build 4
 ;
% I '$D(DT) D DT^DICRW
 W !!,"Denied Days Report",!!
 ;
 S IBSORT="P",IBSELECT="1,2,3,4,"
 N DIR
 S DIR("?")="Answer YES if you only want to print a summary or answer NO if you want a detailed listing plus the summary."
 S DIR(0)="Y",DIR("A")="Print Summary Only",DIR("B")="YES" D ^DIR K DIR
 I $D(DIRUT) G END
 S IBSUM=Y
 G:IBSUM DATE
 ;
 ; -- ask what types of care to include
 D TYPE^IBTODD2 I IBSELECT<1 G END
 ;
 ; -- ask how they want inpatient sorted
 I IBSELECT[1 D SORT^IBTODD2 I IBSORT<0 G END
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
 K IBAPL,IBBBS,IBBDT,IBC,IBCDT,IBCNT,IBDT,IBD,IBDATA,IBEDT,IBNAM,IBPRIM,IBPROV,IBRATE,IBSECN,IBSERV,IBSORT,IBSPEC,IBSUM,IBSUBT,IBTOTL,IBCNTO,IBEVNTYP,IBISV,IBSELECT
 D KVAR^VADPT
 Q
DQ ; -- entry print from taskman
 K ^TMP($J,"IBTODD") F I=1:1 S J=$P(IBSELECT,",",I) Q:'J  S ^TMP($J,"IBTODD",J)=""
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
 .S IBEVNTYP=$P(IBTRND,U,18) S:IBEVNTYP=5 IBEVNTYP=1
 . ;
 .I IBEVNTYP=1,IBSELECT[1 D  Q
 ..S IBDDB=$P(IBTRCD,"^",15),IBDDE=$P(IBTRCD,"^",16)
 ..S IBTALL=$P($G(^IBT(356.2,+IBTRC,1)),"^",7)
 ..S IBLOSI=$$LOS(IBTRN) ; admissions length of stay
 ..I IBDDB,IBDDE Q:(IBDDB>IBEDT)!(IBDDE<IBBDT)  D
 ...I IBDDB<IBBDT S IBDDB=IBBDT ; chk days denied in correct range
 ...I IBDDE>IBEDT S IBDDE=IBEDT
 ...S IBDAY=$$FMDIFF^XLFDT(IBDDE,IBDDB)+1 ; cals total denied days
 ..; if no days denied "to" and "from" and episode in range
 ..I (IBTALL),('$D(IBDAY)) S IBCDT=$$CDT^IBTODD1(IBTRN) D STRIP Q:('+IBCDT!(+IBCDT>IBEDT))  D
 ...;Q:'$P(IBTRND,U,5)  ; quit if no link between ct and dgpm
 ...I '$P(IBCDT,U,2) S $P(IBCDT,U,2)=$$FMADD^XLFDT($P(IBCDT,U,1),1) ; unlinked all to event dt+1 los
 ...; if the care date is >the report range there is no discharge add 1
 ...I '$P(IBCDT,U,2)!($P(IBCDT,U,2)>IBEDT) S $P(IBCDT,U,2)=$$FMADD^XLFDT(IBEDT,1)
 ...I +IBCDT<IBBDT S $P(IBCDT,U,1)=IBBDT
 ...S IBDAY=$$FMDIFF^XLFDT($P(IBCDT,U,2),$P(IBCDT,U,1))
 ..I IBLOSI=1,IBDAY=0 S IBDAY=1 ; get one day stays
 ..Q:$G(IBDAY)<1
 ..S DFN=$P(IBTRCD,"^",5),IBNAM=$P($G(^DPT(+DFN,0)),"^") Q:IBNAM=""
 ..S IBD=$$PROV(DFN,IBTRCD,IBTRND,IBTALL),IBPROV=+IBD,IBSPEC=$P(IBD,"^",2),IBSERV=$P(IBD,"^",3)
 ..;S IBBBS=$$BBS^IBTOSUM1($P(IBD,"^",2))
 ..;S IBRATE=$$RATE^IBTOSUM1(IBBBS,+IBTRCD)
 ..S IBRATE=$$AMOUNT^IBJDB21(1,IBTRN) ; get events charge
 ..I +IBLOSI,+IBRATE S IBRATE=(IBRATE/IBLOSI)*IBDAY ; calculate amount for days denied
 ..D SET
 .;
 .I IBEVNTYP'=1,IBSELECT[IBEVNTYP D  Q
 ..S IBDDB=$P(IBTRND,"^",6)
 ..Q:(IBDDB<IBBDT)!(IBDDB>IBEDT)
 ..S DFN=$P(IBTRCD,"^",5),IBNAM=$P($G(^DPT(+DFN,0)),"^") Q:IBNAM=""
 ..S IBPROV=0,IBSPEC=0,IBSERV=$S(IBEVNTYP=2:"OUTPATIENT",IBEVNTYP=3:"PROSTHETICS",IBEVNTYP=4:"PRESCRIPTION",1:"UNKNOWN")
 ..S IBDAY=1,IBRATE=$$AMOUNT^IBJDB21(IBEVNTYP,IBTRN) ; get events charge
 ..D SET
 K IBTRN,IBTRND,IBTRCD,DFN,IBDDB,IBDDE,IBCDT,IBLOSI
 Q
 ;
SET ; -- set array to print from
 ; -- ^tmp($j,"ibtodd",evnt typ,primary sort,secondary sort,ibtrc)=DFN ^ attending ^ treating specialty ^ service ^  ^ billing rate^ no. days denied
 S IBPRIM=$S(IBSORT="P":IBNAM,IBSORT="A":IBPROV,1:IBSERV)
 S IBSECN=$S(IBSORT="P":IBPROV,1:IBNAM)
 I IBEVNTYP'=1 S IBPRIM=IBNAM,IBSECN=IBDDB
 S:IBPRIM="" IBPRIM="UNKNOWN" S:IBSECN="" IBSECN="UNKNOWN"
 S ^TMP($J,"IBTODD",IBEVNTYP,IBPRIM,IBSECN,IBTRC)=DFN_"^"_IBPROV_"^"_IBSPEC_"^"_IBSERV_"^^"_IBRATE_"^"_IBDAY
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
 ;
LOS(IBTRN) ; compute admissions length of stay
 N X,Y,DGPM,BEG,END,LOS S X=$G(^IBT(356,+$G(IBTRN),0)),LOS=0,Y=0
 I $P(X,"^",5) S DGPM=$G(^DGPM($P(X,"^",5),0)) D
 . S BEG=+DGPM,END=DT
 . I $P(DGPM,"^",17) S END=+$G(^DGPM($P(DGPM,"^",17),0))
 . S LOS=$$FMDIFF^XLFDT(END,BEG)
 . I (BEG\1)=(END\1) S LOS=1
 I +LOS S Y=+LOS
 Q Y
