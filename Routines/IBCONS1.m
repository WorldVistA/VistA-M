IBCONS1 ;ALB/AAS - NSC PATIENTS W/ INS BACKGROUND PRINTS ;7 JUN 90
 ;;2.0;INTEGRATED BILLING;**66,80,137**;21-MAR-94
 ;
 ;MAP TO DGCRONS1
 ;
EN ; Inpatient Discharge entry to que background once weekly
 S IBINPT=2,IBSUB="AMV3" G QUEUE
 ;
EN1 ; Inpatient Admission entry to que background once weekly
 S IBINPT=1,IBSUB="AMV1" G QUEUE
 ;
EN2 ; Outpatient entry to que background once weekly
 S IBINPT=0,IBSUB=""
 ;
QUEUE ; Set up the background job to run for the previous week
 ;   o  For All Divisions
 ;   o  For Insured veterans with unbilled episodes of care
 ;   o  With the output sorted by Terminal Digit
 ;
 K ^TMP($J)
 S X="T",%DT="" D ^%DT S IBEND=+Y
 S X="T-7",%DT="" D ^%DT S IBBEG=+Y K %DT
 S (VAUTD,IBSELUBL,IBSELTRM,IBSELRNB)=1
 U IO G BEGIN^IBCONSC
 ;
 ;
LOOP25 ; Print all NSC w/Insurance reports.
 S IBQUIT=0,IBFL=1,IBHDRDV="",IBSUM=0 I +$G(IBSELCDV) D HDRDV^IBCONSC
 S IBDV="" F  S IBDV=$O(^TMP($J,IBDV)) Q:IBDV=""  I IBDV'="TOTAL" D LOOP3 Q:IBQUIT
 ;
 G:IBQUIT Q S IBSUM=1,IBPAGE=0 D HEAD Q:IBQUIT
 S IBDV="" F  S IBDV=$O(^TMP($J,"TOTAL",IBDV)) Q:IBDV=""  D PRNSUM
 D PAUSE
 ;
Q K %,%DT,B,I,J,K,L,M,X,X1,X2,Y,DFN,IBCNT,IBIFN,IBBILL,IBDATE,IBFLAG,IBI,IBDT,IBPAGE,IBL,IBHD,IBBEG1,IBHDRDV,IBSUM
 K IBBEG,IBEND,IBINPT,IBFLAG,IBNAME,IBAPPT,IBDC,IBDAT,IBDFN,POP,IBNEWPT,^TMP($J)
 ;I '$D(ZTQUEUED) D ^%ZISC
 Q
 ;
 ;
LOOP3 ; Loop through billed, unbilled, or both types of episodes of care.
 I +$G(IBSELUBL) S IBBILL=1,IBNAME="",IBPAGE=0 K IBFLAG D HEAD Q:IBQUIT  D LOOP31 Q:IBQUIT
 I +$G(IBSELBNA)!+$G(IBSELBIL) S IBBILL=2,IBNAME="",IBPAGE=0 K IBFLAG D HEAD Q:IBQUIT  D LOOP31 Q:IBQUIT
 Q
 ;
LOOP31 ; Loop through each name or terminal digit (and associated DFN).
 F  S IBNAME=$O(^TMP($J,IBDV,IBBILL,IBNAME)) D  Q:IBNAME=""!(IBQUIT)
 . I IBNAME="",'$D(IBFLAG) W !!,"No matches found.",!
 . Q:IBNAME=""
 . S DFN=0 F  S DFN=$O(^TMP($J,IBDV,IBBILL,IBNAME,DFN)) Q:'DFN  S IBNEWPT=1 D LOOP4 Q:IBQUIT
 Q
 ;
LOOP4 ; Loop through each episode of care for a patient.
 S IBDAT="" F I=0:0 S IBDAT=$O(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT)) Q:IBDAT=""!(IBQUIT)  D PRINT I $Y>$S($D(IOSL):(IOSL-6),1:6) W ! D HEAD Q:IBQUIT
 Q
 ;
PRINT ; Print each detail line.
 I '$G(IBSELRNB),$D(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT,2)) Q  ; exclude episodes with reason not billable
 I +$G(IBSELRNB)=2,'$D(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT,2)) Q  ; exclude episode w/o RNB ** PATCH 66
 I IBBILL=2,'$G(IBSELBNA),+$G(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT))=1 Q  ; non-auth episodes  ** PATCH 66
 I IBBILL=2,'$G(IBSELBIL),+$G(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT))=2 Q  ; auth episodes  ** PATCH 66
 ;
 I +$G(IBNEWPT) W ! D PTPRNT S IBNEWPT=0
 D SUMTOT S IBFLAG=1 D PID^VADPT6
 W !,VA("BID"),?6,$E($P(^DPT(DFN,0),"^"),1,20),?28,VA("PID"),?42,$E($P($G(^DIC(8,+$G(^(.36)),0)),"^",6),1,16) K VA,VAERR
 S Y=IBDAT X ^DD("DD") W ?60,Y
 ;
 ; -- print insurance, use ibcns1 calls
 S X=$$INSP(DFN,IBDAT) W ?82,X
 ;
 ;S IBCNT=0 F II=0:0 S II=$O(^DPT(DFN,.312,II)) Q:'II  S IBCNT=IBCNT+1,X=+^(II,0) D
 ;. I $D(^DIC(36,X,0)) W:IBCNT=2!(IBCNT=3) ", " W:IBCNT<4 $E($P(^(0),"^"),1,14) W:IBCNT=4 " " W:IBCNT>3 "*"
 ;
 ; -- print reason not billable
 I $G(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT,2))]"" W ?115,$E(^(2),1,16)
 ;
 S X=$G(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT,1))
 I X]"" W !?10,$P(X,"^") I $P(X,"^",2)]"" W " with " F IBDC=2:1 Q:$P(X,"^",IBDC)=""  W $P(X,"^",IBDC),", "
 S X=^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT) Q:'$L(X)  F K=2:1 S IBIFN=$P(X,"^",K) Q:IBIFN=""  D PRINT1
 Q
 ;
PRINT1 ; If an episode of care has been billed, display billing information.
 D GVAR^IBCBB
 W !?10,$P(^DGCR(399,IBIFN,0),"^"),?20,$P($G(^DGCR(399.3,+IBAT,0)),"^",4),"-",$S(IBCL<3:"INPT",IBCL>2:"OUTP",1:"")
 W ?37,$S(IBST=1:"Entered",IBST=2:"Request MRA",IBST=3:"Authorized",IBST=4:"Prnt/Trans",IBST=7:"Cancelled",IBST=0:"Closed",1:"")
 W ?50,"From: ",$E(IBFDT,4,5)_"/"_$E(IBFDT,6,7)_"/"_$E(IBFDT,2,3)
 W ?68,"To: ",$E(IBTDT,4,5)_"/"_$E(IBTDT,6,7)_"/"_$E(IBTDT,2,3)
 W ?88,$S($P(IBND0,U,21)="S":"s",$P(IBND0,U,21)="T":"t",1:"")
 W ?91,"Debtor: "
 I IBWHO="i",$D(^DIC(36,+IBNDMP,0)) W $P(^(0),"^")
 I IBWHO="o",$D(^DIC(4,+$P(IBNDM,"^",11),0)) W $P(^(0),"^")
 I IBWHO="p" W $P(^DPT(DFN,0),"^")
 D END^IBCBB1 Q
 ;
HEAD ; Print header; don't pause on first pass through.
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,IBQUIT)=1 Q
 D:'IBFL PAUSE Q:IBQUIT  S IBFL=0 N IBI
 S IBPAGE=IBPAGE+1
 ; -- ibformfd = skip only intial form feed, need ffs for each div.
 I $E(IOST,1,2)["C-"!(IBPAGE>1)!($G(IBFORMFD)) W @IOF
 S IBFORMFD=1
 S IBI=$S(IBBILL=2:"PREVIOUSLY ",1:"UN")_"BILLED PATIENTS"
 I '$G(IBSELCDV) S IBI=IBI_" for Division "_$P($G(^DG(40.8,+IBDV,0)),"^")
 I +$G(IBSELCDV) S IBI=IBI_IBHDRDV
 I +$G(IBSUM) S IBI="Summary"
 W IBHD,!,IBI W:$L(IBI)>78 ! W ?80,"Printed: ",IBDATE,?118,"Page: ",IBPAGE
 I +$G(IBSUM) W !,?40,"Unbilled",?53,"Unbilled w/RNB",?70,"Billed/Not Auth",?88,"Billed/Auth",?103,"# Visits",?117,"# Patients",!,IBL Q
 W !,"PT ID PATIENT",?28,"SSN",?42,"ELIGIBILITY",?60,"DATE OF ",$S(IBINPT=2:"DISCHARGE",1:"CARE"),?82,"INSURANCE COMPANIES"
 W:+$G(IBSELRNB) ?115,"NOT BILLABLE"
 W !,IBL
 Q
 ;
INSP(DFN,IBDAT) ; -- print ins. company on report logic
 N X,IBDD,IBDDINS,IBCNT
 S IBCNT=0,IBDDINS=""
 I '$G(DFN)!('$G(IBDAT)) G INSPQ
 S IBDD="" D ALL^IBCNS1(DFN,"IBDD",4,IBDAT)
 S X=0 F  S X=$O(IBDD(X)) Q:'X!(IBCNT>2)  D
 .S IBCNT=IBCNT+1
 .I IBCNT>1 S IBDDINS=IBDDINS_","
 .S IBDDINS=IBDDINS_$E($P($G(^DIC(36,+$G(IBDD(X,0)),0)),"^"),1,10)
 S IBDDINS=$E(IBDDINS,1,30)
 I $G(IBDD(0))>3 S IBDDINS=IBDDINS_"*"
INSPQ Q IBDDINS
 ;
PAUSE Q:$E(IOST,1,2)'="C-"
 F J=$Y:1:(IOSL-5) W !
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
PRNSUM ; print 1 line of the summary
 N IBSUM S IBSUM=$G(^TMP($J,"TOTAL",IBDV)) Q:IBSUM=""
 W !,$S(IBDV="TOTAL":IBDV,1:$P($G(^DG(40.8,+IBDV,0)),U,1))
 W ?40,$P(IBSUM,U,2),?58,$P(IBSUM,U,3),?75,$P(IBSUM,U,4),?91,$P(IBSUM,U,5),?105,$P(IBSUM,U,1),?120,$P(IBSUM,U,6)
 Q
DATE(X) ;
 N Y S Y="" I +$G(X) S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
 ;
SUMTOT ; total cnt of visits ^ cnt unbilled ^ cnt unbilled w/RNB ^ cnt billed/not auth ^ cnt billed/auth ^ cnt of pats
 N IBSUM,IBTOT,IBBILLED,IBRMARK
 S IBBILLED=$G(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT)),IBRMARK=$G(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT,2))
 S IBSUM=$G(^TMP($J,"TOTAL",+IBDV)),IBTOT=$G(^TMP($J,"TOTAL","TOTAL"))
 S $P(IBSUM,U,1)=+$P(IBSUM,U,1)+1,$P(IBTOT,U,1)=+$P(IBTOT,U,1)+1
 I 'IBBILLED,IBRMARK="" S $P(IBSUM,U,2)=$P(IBSUM,U,2)+1,$P(IBTOT,U,2)=$P(IBTOT,U,2)+1
 I 'IBBILLED,IBRMARK'="" S $P(IBSUM,U,3)=$P(IBSUM,U,3)+1,$P(IBTOT,U,3)=$P(IBTOT,U,3)+1
 I +IBBILLED=1 S $P(IBSUM,U,4)=$P(IBSUM,U,4)+1,$P(IBTOT,U,4)=$P(IBTOT,U,4)+1
 I +IBBILLED=2 S $P(IBSUM,U,5)=$P(IBSUM,U,5)+1,$P(IBTOT,U,5)=$P(IBTOT,U,5)+1
 I '$D(^TMP($J,"TOTAL",+IBDV,DFN)) S $P(IBSUM,U,6)=$P(IBSUM,U,6)+1
 I '$D(^TMP($J,"TOTAL","TOTAL",DFN)) S $P(IBTOT,U,6)=$P(IBTOT,U,6)+1
 I +IBDV S ^TMP($J,"TOTAL",+IBDV)=IBSUM,^TMP($J,"TOTAL",+IBDV,DFN)=""
 S ^TMP($J,"TOTAL","TOTAL")=IBTOT,^TMP($J,"TOTAL","TOTAL",DFN)=""
 Q
 ;
PTPRNT ; print patient specific data is requested:  Rate Disabilities and expanded insurance Info
 ;
 N IBLN1,IBI,IBX,IBY,IBD,IBLN2,IBLN3,IBY1,IBJ,IBY3,IBRIDE,IBPLAN,IBCVG
 S IBLN1=$P($G(^DPT(+DFN,0)),U,1) I $Y>(IOSL-6) W ! D HEAD Q:IBQUIT
 ;
 I +$G(IBPRTRDS) S IBLN2="Rated Disabilities:" D  Q:+$G(IBQUIT)  K IBX,IBY
 . I '$O(^DPT(DFN,.372,0)) W !,IBLN1,?33,IBLN2,"  None" S (IBLN1,IBLN2)="" Q
 . S IBI=0 F  S IBI=$O(^DPT(DFN,.372,IBI)) Q:'IBI  D  I $Y>(IOSL-6) W ! D HEAD Q:IBQUIT
 .. S IBX=$G(^DPT(DFN,.372,IBI,0)),IBY=$G(^DIC(31,+IBX,0))
 .. S IBD=$S($P(IBY,U,4)="":$P(IBY,U,1),1:$P(IBY,U,4))_" ("_$P(IBX,U,2)_"%-"_$S(+$P(IBX,U,3):"SC",1:"NSC")_")"
 .. W !,IBLN1,?33,IBLN2,?57,IBD S (IBLN1,IBLN2)=""
 ;
 I '$G(IBPRTIEX),'$G(IBPRTIPC),'$G(IBPRTIGC),'$G(IBPRTICR) Q
 ;
 W:IBLN1'="" !,IBLN1
 D ALL^IBCNS1(DFN,"IBX",4,IBBEG),ALL^IBCNS1(DFN,"IBX",4,IBEND)
 ;
 S IBI=0 F  S IBI=$O(IBX(IBI)) Q:'IBI  D  Q:+$G(IBQUIT)  I $Y>(IOSL-6) W ! D HEAD Q:IBQUIT
 . S IBY=IBX(IBI,0),IBY1=IBX(IBI,1)
 . S IBLN1=$E($P($G(^DIC(36,+IBY,0)),U,1),1,25),IBPLAN=+$P(IBY,U,18)
 . ;
 . I +$G(IBPRTIEX) W !,?5,IBLN1,?33,"Group #: ",$P($G(^IBA(355.3,+IBPLAN,0)),U,4),?65,"Effective: ",$$DATE(+$P(IBY,U,8))," - ",$$DATE(+$P(IBY,U,4)),?100,"Last Ver: ",$$DATE($P(IBY1,U,3)) S IBLN1=""
 . ;
 . I +$G(IBPRTIPC) S IBLN2="Policy Comment: " D  I $Y>(IOSL-6) W ! D HEAD Q:IBQUIT
 .. I $P(IBY1,U,8)'="" W !,?5,IBLN1,?33,IBLN2,?51,$P(IBY1,U,8) S (IBLN1,IBLN2)=""
 . ;
 . I +$G(IBPRTIGC) S IBLN2="Group Comments: " D
 .. S IBJ=0 F  S IBJ=$O(^IBA(355.3,+IBPLAN,11,IBJ)) Q:'IBJ  D  I $Y>(IOSL-6) W ! D HEAD Q:IBQUIT
 ... S IBY3=$G(^IBA(355.3,+IBPLAN,11,IBJ,0)) W !,?5,IBLN1,?33,IBLN2,?51,IBY3 S (IBLN1,IBLN2)=""
 . ;
 . I +$G(IBPRTICR) S IBLN2="Coverage Limits:" D
 .. S IBCVG=0 F  S IBCVG=$O(^IBA(355.32,"B",IBPLAN,IBCVG)) Q:'IBCVG  D  I $Y>(IOSL-6) W ! D HEAD Q:IBQUIT
 ... S IBY3=$G(^IBA(355.32,IBCVG,0)) Q:IBY3=""
 ... S IBLN3=$E($P($G(^IBE(355.31,+$P(IBY3,U,2),0)),U,1),1,20)_" "_$$DDSET(355.32,.04,+$P(IBY3,U,4))_"  "_$$DATE(+$P(IBY3,U,3))
 ... S IBJ=0 F  S IBJ=$O(^IBA(355.32,IBCVG,2,IBJ)) Q:'IBJ  D  I $Y>(IOSL-6) W ! D HEAD Q:IBQUIT
 .... W !,?5,IBLN1,?33,IBLN2,?51,IBLN3,?104,$G(^IBA(355.32,IBCVG,2,IBJ,0)) S (IBLN1,IBLN2,IBLN3)=""
 ... I IBLN3'="" W !,?5,IBLN1,?33,IBLN2,?51,IBLN3 S (IBLN1,IBLN2,IBLN3)=""
 . ;
 . I +$G(IBPRTICR) S IBLN2="Riders: " D
 .. S IBRIDE=0 F  S IBRIDE=$O(^IBA(355.7,"APP",DFN,IBI,IBRIDE)) Q:'IBRIDE  D  I $Y>(IOSL-6) W ! D HEAD Q:IBQUIT
 ... W !,?5,IBLN1,?33,IBLN2,?51,$P($G(^IBE(355.6,+IBRIDE,0)),U,1) S (IBLN1,IBLN2)=""
 ;
 W !
 Q
 ;
DDSET(FILE,FLD,X) ; returns external value for a set
 N Y,Z,T S Z="",Y=$G(^DD(+$G(FILE),+$G(FLD),0)) S T=$G(X)_":",Z=$P($P(Y,T,2),";",1)
 Q Z
