IBCONS1 ;ALB/AAS - NSC PATIENTS W/ INS BACKGROUND PRINTS ;7 JUN 90
 ;;2.0;INTEGRATED BILLING;**66,80,137,516,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
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
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 S IBQUIT=0,IBFL=1,IBHDRDV="",IBSUM=0,IBPTINFO="" I +$G(IBSELCDV),IBOUT="R" D HDRDV^IBCONSC
 I IBOUT="E" D PHDL
 S IBDV="" F  S IBDV=$O(^TMP($J,IBDV)) Q:IBDV=""  I IBDV'="TOTAL" D LOOP3 Q:IBQUIT
 ;
 G:IBQUIT Q S IBSUM=1,IBPAGE=0 D:IBOUT="R" HEAD Q:IBQUIT
 S IBDV="" F  S IBDV=$O(^TMP($J,"TOTAL",IBDV)) Q:IBDV=""  D PRNSUM
 D PAUSE
 ;
Q K %,%DT,B,I,J,K,L,M,X,X1,X2,Y,DFN,IBCNT,IBIFN,IBBILL,IBDATE,IBFLAG,IBI,IBDT,IBPAGE,IBL,IBHD,IBBEG1,IBHDRDV,IBSUM
 K IBBEG,IBEND,IBOUT,IBINPT,IBFLAG,IBNAME,IBAPPT,IBDC,IBDAT,IBDFN,POP,IBNEWPT,IBPTINFO,^TMP($J)
 Q
 ;
 ;
LOOP3 ; Loop through billed, unbilled, or both types of episodes of care.
 I +$G(IBSELUBL) S IBBILL=1,IBNAME="",IBPAGE=0 K IBFLAG D:IBOUT="R" HEAD Q:IBQUIT  D LOOP31 Q:IBQUIT
 I +$G(IBSELBNA)!+$G(IBSELBIL) S IBBILL=2,IBNAME="",IBPAGE=0 K IBFLAG D:IBOUT="R" HEAD Q:IBQUIT  D LOOP31 Q:IBQUIT
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
 S IBDAT="" F I=0:0 S IBDAT=$O(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT)) Q:IBDAT=""!(IBQUIT)  D PRINT I $Y>$S($D(IOSL):(IOSL-6),1:6),IBOUT="R" W ! D HEAD Q:IBQUIT
 Q
 ;
PRINT ; Print each detail line.
 I '$G(IBSELRNB),$D(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT,2)) Q  ; exclude episodes with reason not billable
 I +$G(IBSELRNB)=2,'$D(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT,2)) Q  ; exclude episode w/o RNB ** PATCH 66
 I IBBILL=2,'$G(IBSELBNA),+$G(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT))=1 Q  ; non-auth episodes  ** PATCH 66
 I IBBILL=2,'$G(IBSELBIL),+$G(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT))=2 Q  ; auth episodes  ** PATCH 66
 ;
 D SUMTOT S IBFLAG=1 D PID^VADPT6
 I IBOUT="E" S IBPTINFO=$P($G(^DG(40.8,+IBDV,0)),"^")_U_VA("BID")_U_$P(^DPT(DFN,0),"^")_U_VA("PID")_U_$P($G(^DIC(8,+$G(^DPT(DFN,.36)),0)),"^",6)
 ;
 I +$G(IBNEWPT) W:IBOUT="R" ! D PTPRNT S IBNEWPT=0
 W:IBOUT="R" !,VA("BID"),?6,$E($P(^DPT(DFN,0),"^"),1,20),?28,VA("PID"),?42,$E($P($G(^DIC(8,+$G(^DPT(DFN,.36)),0)),"^",6),1,16) K VA,VAERR
 S Y=IBDAT X ^DD("DD") W:IBOUT="R" ?60 W:IBOUT="E" U W Y
 ;
 ; -- print insurance, use ibcns1 calls
 S X=$$INSP(DFN,IBDAT) W:IBOUT="R" ?82 W:IBOUT="E" U W X
 ;
 ; -- print reason not billable
 I $G(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT,2))]"" W:IBOUT="R" ?115,$E(^(2),1,16) W:IBOUT="E" U_^(2)
 ;
 I IBOUT="E",'IBINPT W U
 S X=$G(^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT,1))
 I X]"" W:IBOUT="R" !?10 W $P(X,"^") I $P(X,"^",2)]"" W " with " F IBDC=2:1 Q:$P(X,"^",IBDC)=""  W $P(X,"^",IBDC),", "
 S X=^TMP($J,IBDV,IBBILL,IBNAME,DFN,IBDAT) Q:'$L(X)  F K=2:1 S IBIFN=$P(X,"^",K) Q:IBIFN=""  D PRINT1
 Q
 ;
PRINT1 ; If an episode of care has been billed, display billing information.
 D GVAR^IBCBB
 I IBOUT="E" D
 . I K>2 D XLCOLS(4,"")
 . W U_$P(^DGCR(399,IBIFN,0),"^")_U_$P($G(^DGCR(399.3,+IBAT,0)),"^",4),"-",$S(IBCL<3:"INPT",IBCL>2:"OUTP",1:"")
 . W U_$S(IBST=1:"Entered",IBST=2:"Request MRA",IBST=3:"Authorized",IBST=4:"Prnt/Trans",IBST=7:"Cancelled",IBST=0:"Closed",1:"")
 . W U_$E(IBFDT,4,5)_"/"_$E(IBFDT,6,7)_"/"_$E(IBFDT,2,3)_U_$E(IBTDT,4,5)_"/"_$E(IBTDT,6,7)_"/"_$E(IBTDT,2,3)
 . W U_$S($P(IBND0,U,21)="S":"s",$P(IBND0,U,21)="T":"t",1:"")_U
 I IBOUT="R" D
 . W !?10,$P(^DGCR(399,IBIFN,0),"^"),?20,$P($G(^DGCR(399.3,+IBAT,0)),"^",4),"-",$S(IBCL<3:"INPT",IBCL>2:"OUTP",1:"")
 . W ?37,$S(IBST=1:"Entered",IBST=2:"Request MRA",IBST=3:"Authorized",IBST=4:"Prnt/Trans",IBST=7:"Cancelled",IBST=0:"Closed",1:"")
 . W ?50,"From: ",$E(IBFDT,4,5)_"/"_$E(IBFDT,6,7)_"/"_$E(IBFDT,2,3)
 . W ?68,"To: ",$E(IBTDT,4,5)_"/"_$E(IBTDT,6,7)_"/"_$E(IBTDT,2,3)
 . W ?88,$S($P(IBND0,U,21)="S":"s",$P(IBND0,U,21)="T":"t",1:"")
 . W ?91,"Debtor: "
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
 W:IBOUT="R" !
 I IBOUT="E" D XLCOLS(5,"")
 W $S(IBDV="TOTAL":IBDV,1:$P($G(^DG(40.8,+IBDV,0)),U,1))
 I IBOUT="E" W U_$P(IBSUM,U,2,5)_U_$P(IBSUM,U,1)_U_$P(IBSUM,U,6) Q
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
 N IBLN1,IBI,IBX,IBY,IBD,IBLN2,IBLN3,IBY1,IBJ,IBY3,IBRIDE,IBPLAN,IBCVG,IBGC1,IBCR1,IBCOMFL
 S IBLN1=$P($G(^DPT(+DFN,0)),U,1) I $Y>(IOSL-6),IBOUT="R" W ! D HEAD Q:IBQUIT
 ;
 I '$G(IBPRTRDS),IBOUT="E" W !,IBPTINFO
 I +$G(IBPRTRDS) S IBLN2="Rated Disabilities:" D  Q:+$G(IBQUIT)  K IBX,IBY
 . I '$O(^DPT(DFN,.372,0)) W:IBOUT="R" !,IBLN1,?33,IBLN2,"  None" W:IBOUT="E" !,IBPTINFO_"^None" S (IBLN1,IBLN2)="" Q
 . S IBI=0 F  S IBI=$O(^DPT(DFN,.372,IBI)) Q:'IBI  D  I $Y>(IOSL-6),IBOUT="R" W ! D HEAD Q:IBQUIT
 .. S IBX=$G(^DPT(DFN,.372,IBI,0)),IBY=$G(^DIC(31,+IBX,0))
 .. S IBD=$S($P(IBY,U,4)="":$P(IBY,U,1),1:$P(IBY,U,4))_" ("_$P(IBX,U,2)_"%-"_$S(+$P(IBX,U,3):"SC",1:"NSC")_")"
 .. W:IBOUT="R" !,IBLN1,?33,IBLN2,?57,IBD W:IBOUT="E" !,IBPTINFO_U_IBD S (IBLN1,IBLN2)=""
 ;
 I '$G(IBPRTIEX),'$G(IBPRTIPC),'$G(IBPRTIGC),'$G(IBPRTICR),IBOUT="R" Q
 ;
 I IBOUT="R" W:IBLN1'="" !,IBLN1
 D ALL^IBCNS1(DFN,"IBX",4,IBBEG),ALL^IBCNS1(DFN,"IBX",4,IBEND)
 ;
 I IBOUT="E",'$O(IBX(0)) D XLCOLS(0,"")
 S IBI=0 F  S IBI=$O(IBX(IBI)) Q:'IBI  D  Q:+$G(IBQUIT)  I $Y>(IOSL-6),IBOUT="R" W ! D HEAD Q:IBQUIT
 . S IBY=IBX(IBI,0),IBY1=IBX(IBI,1)
 . S IBLN1=$P($G(^DIC(36,+IBY,0)),U,1),IBPLAN=+$P(IBY,U,18) S:IBOUT="R" IBLN1=$E(IBLN1,1,25)
 . ;
 . ;IB*2.0*516/DRF - Retrieve HIPAA compliant Group #
 . ;I +$G(IBPRTIEX) W !,?5,IBLN1,?33,"Group #: ",$P($G(^IBA(355.3,+IBPLAN,0)),U,4),?65,"Effective: ",$$DATE(+$P(IBY,U,8))," - ",$$DATE(+$P(IBY,U,4)),?100,"Last Ver: ",$$DATE($P(IBY1,U,3)) S IBLN1=""
 . I +$G(IBPRTIEX) D
 .. I IBOUT="E" W U_IBLN1_U_$P(IBY,U,3)_U_$$DATE(+$P(IBY,U,8))_U_$$DATE(+$P(IBY,U,4))_U_$$DATE($P(IBY1,U,3)) Q
 .. W !,?5,IBLN1,?33,"Group #: ",$P(IBY,U,3)
 .. W !,?33,"Effective: ",$$DATE(+$P(IBY,U,8))," - ",$$DATE(+$P(IBY,U,4)),?68,"Last Ver: ",$$DATE($P(IBY1,U,3)) S IBLN1=""
 . ;
 . I +$G(IBPRTIPC) S IBLN2="Policy Comment: " D  I $Y>(IOSL-6),IBOUT="R" W ! D HEAD Q:IBQUIT
 .. I IBOUT="E" W U_$P(IBY1,U,8) Q
 .. I $P(IBY1,U,8)'="" W !,?5,IBLN1,?33,IBLN2,?51,$P(IBY1,U,8) S (IBLN1,IBLN2)=""
 . ;
 . I +$G(IBPRTIGC) S IBLN2="Group Comments: " D  I IBOUT="E",+$G(IBGC1) W U
 .. S IBJ=0,IBGC1=1 F  S IBJ=$O(^IBA(355.3,+IBPLAN,11,IBJ)) Q:'IBJ  D  I $Y>(IOSL-6),IBOUT="R" W ! D HEAD Q:IBQUIT
 ... S IBY3=$G(^IBA(355.3,+IBPLAN,11,IBJ,0)) D
 .... I IBOUT="E" D:'IBGC1 XLCOLS(1,IBLN1) W U_IBY3 S IBGC1=0 Q
 .... W !,?5,IBLN1,?33,IBLN2,?51,IBY3 S (IBLN1,IBLN2)=""
 . ;
 . I +$G(IBPRTICR) S IBLN2="Coverage Limits:" D  I IBOUT="E",+$G(IBCR1) W "^^"
 .. S IBCVG=0,IBCR1=1 F  S IBCVG=$O(^IBA(355.32,"B",IBPLAN,IBCVG)) Q:'IBCVG  D  I $Y>(IOSL-6),IBOUT="R" W ! D HEAD Q:IBQUIT
 ... S IBY3=$G(^IBA(355.32,IBCVG,0)) Q:IBY3=""
 ... S IBLN3=$P($G(^IBE(355.31,+$P(IBY3,U,2),0)),U,1) I IBOUT="R" S IBLN3=$E(IBLN3,1,20)
 ... S IBLN3=IBLN3_" "_$$DDSET(355.32,.04,+$P(IBY3,U,4))_"  "_$$DATE(+$P(IBY3,U,3))
 ... S (IBJ,IBCOMFL)=0 F  S IBJ=$O(^IBA(355.32,IBCVG,2,IBJ)) Q:'IBJ  D  I $Y>(IOSL-6),IBOUT="R" W ! D HEAD Q:IBQUIT
 .... I IBOUT="E" D:'IBCR1 XLCOLS(2,IBLN1) W U_IBLN3_U_$G(^IBA(355.32,IBCVG,2,IBJ,0)) S IBCR1=0,IBCOMFL=1 Q
 .... W !,?5,IBLN1,?33,IBLN2,?51,IBLN3,?104,$G(^IBA(355.32,IBCVG,2,IBJ,0)) S (IBLN1,IBLN2,IBLN3)=""
 ... I IBLN3'="",IBOUT="R" W !,?5,IBLN1,?33,IBLN2,?51,IBLN3 S (IBLN1,IBLN2,IBLN3)=""
 ... I 'IBCOMFL,IBOUT="E" D:'IBCR1 XLCOLS(2,IBLN1) W U_IBLN3_U S IBCR1=0
 . ;
 . I +$G(IBPRTICR) S IBLN2="Riders: " D  I IBOUT="E",+$G(IBCR1) W U
 .. S IBRIDE=0,IBCR1=1 F  S IBRIDE=$O(^IBA(355.7,"APP",DFN,IBI,IBRIDE)) Q:'IBRIDE  D  I $Y>(IOSL-6),IBOUT="R" W ! D HEAD Q:IBQUIT
 ... I IBOUT="E" D:'IBCR1 XLCOLS(3,IBLN1) W U_$P($G(^IBE(355.6,+IBRIDE,0)),U,1) S IBCR1=0 Q
 ... W !,?5,IBLN1,?33,IBLN2,?51,$P($G(^IBE(355.6,+IBRIDE,0)),U,1) S (IBLN1,IBLN2)=""
 ;
 I IBOUT="R" W !
 Q
 ;
DDSET(FILE,FLD,X) ; returns external value for a set
 N Y,Z,T S Z="",Y=$G(^DD(+$G(FILE),+$G(FLD),0)) S T=$G(X)_":",Z=$P($P(Y,T,2),";",1)
 Q Z
 ;
PHDL ; Print header for Excel format
 W "DIV^PT ID^PATIENT^SSN^ELIGIBILITY"
 I +$G(IBPRTRDS) W "^Rated Disabilities"
 I +$G(IBPRTIEX) W "^Insurance^Group #^Effective Begin Date^Effective End Date^Last Ver"
 I +$G(IBPRTIPC) W "^Policy Comment"
 I +$G(IBPRTIGC) W "^Group Comments"
 I +$G(IBPRTICR) W "^Coverage Limits^Limitation Comments^Riders"
 ;
 W "^DATE OF "_$S(IBINPT=2:"DISCHARGE",1:"CARE")_"^INSURANCE COMPANIES"
 I +$G(IBSELRNB) W "^NOT BILLABLE"
 I 'IBINPT W "^Encounter Add/Edits"
 ;
 W "^BILL NUMBER^LOCATION OF CARE^STATUS^From^To^Current Bill Payer Sequence^Debtor"
 W "^DIV TOTALS^Unbilled^Unbilled w/RNB^Billed/Not Auth^Billed/Auth^# Visits^# Patients"
 Q
 ;
XLCOLS(PLACE,INS) ; Print spacers for Excel columns
 I +PLACE W !,IBPTINFO
 I +$G(IBPRTRDS),+PLACE W U
 I +$G(IBPRTIEX) W U_INS_"^^^^"
 I +$G(IBPRTIPC) W U Q:PLACE=1
 I +$G(IBPRTIGC) W U Q:PLACE=2
 I +$G(IBPRTICR) W "^^" Q:PLACE=3
 I +$G(IBPRTICR) W U
 Q:'PLACE
 ;
 W "^^"
 I +$G(IBSELRNB) W U
 I 'IBINPT W U Q:PLACE=4
 W "^^^^^^^^"
 Q
