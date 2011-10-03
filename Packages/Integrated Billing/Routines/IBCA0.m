IBCA0 ;ALB/AAS - ADD NEW BILLING RECORD-CONT. ;01 JUN 88 12:00
 ;;2.0;INTEGRATED BILLING;**51**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; DBIA REFERENCE TO ^DGPM("ATID1") = DBIA419
 ;
 ;MAP TO DGCRA0
 ;
 ;moved from IBA (4.5) to split routine
 ;
CEOC1 W !!,"ARE YOU BILLING FOR A CONTINUING EPISODE OF CARE" S %=2 D YN^DICN G CHKINQ:%=2,NREC^IBCA:%=-1
 I '% W !!?4,"YES - If this bill is for continuing care which has already been partially",!?9,"billed for on another bill.",!?4,"NO  - If this is the initial bill for an episode of care." G CEOC1
 W ! D EN4^IBCA3 I '$D(IBIDS(.17)) G CEOC1
CHKINQ Q
 ;
IP W !!?4,"ARE YOU BILLING FOR AN UNDISPLAYED EPISODE OF CARE" S %=2 D YN^DICN
 I '% W !!?4,"YES - If this bill is for an episode of care at a Non-VA facility",!?4,"      for which no PTF record exists.",!?4,"NO - If for VA care or you just made a mistake." G IP
 W ! S DGPERCNT=% I DGPERCNT=1 S IBIDS(162)=$O(^DGCR(399.1,"B","STILL PATIENT",0))
IP1 Q:DGPERCNT'=1  S %DT="AEXP",%DT(0)=IBX,%DT("A")="       NON-VA DISCHARGE DATE: " D ^%DT K %DT Q:X=""  I Y<1!(Y>DT) W !!,"Enter a DISCHARGE DATE after the admission date and not greater than today!",! G IP1
 S IBIDS(.16)=Y,IBIDS(162)=$O(^DGCR(399.1,"B",$E("DISCHARGED TO HOME OR SELF CARE",1,30),0))
 Q
DISPAD ;display admissions
 K IBIDS(.03),IBIDS(.08),IBI,IBJ,IBDSDT S (IBI,IBJ)="",IBCNT=0
 F I=0:0 S IBI=$O(^DGPM("ATID1",DFN,IBI)) Q:IBI=""  S IBCNT=IBCNT+1,IBI1=9999999.9999999-IBI,IBI(IBCNT)=IBI1,IBI(IBI1\1)=IBI1
 F J=0:0 S IBJ=$O(^DGPT("AFEE",DFN,IBJ)) Q:IBJ=""  S IBCNT=IBCNT+1,IBJ(IBCNT)=IBJ,IBJ(IBJ)=IBJ
 I 'IBCNT W !!,"Patient has no admissions on file."
 ;
 W !?4,$S($O(IBI(0))="":"THERE ARE NO INPATIENT EVENT (ADMISSION) DATES.",1:"Select INPATIENT EVENT (ADMISSION) DATE:")
 F I=1:2 Q:'$D(IBI(I))  S Y=IBI(I) X ^DD("DD") W !?8,I_"   ",Y I $D(IBI(I+1)) S Y=IBI(I+1) X ^DD("DD") W ?40,I+1,"   ",Y
 S J=$O(IBJ(0)) I J]"" W !?4,"OR",!?4,"Select NON-VA INPATIENT EVENT (ADMISSION) DATE:" F J=J:2 Q:'$D(IBJ(J))  S Y=IBJ(J) X ^DD("DD") W !?8,J_"   ",Y I $D(IBJ(J+1)) S Y=IBJ(J+1) X ^DD("DD") W ?40,J+1,"   ",Y
 W !!?4,$S(IBCNT:"CHOOSE 1-"_IBCNT_" or ",1:""),"Enter DATE:  " R IBX:DTIME G:IBX="^"!(IBX="")!('$T) ENDDIS
 I IBX'?.N!(IBX<1)!(IBX>IBCNT) S X=IBX,%DT="EXP",%DT(0)="-NOW" D ^%DT S IBX=Y I Y<1 D HELPAD G DISPAD
 I IBX?7N.N D IP I DGPERCNT=1 S IBIDS(.03)=IBX,IBDSDT=$S($D(IBIDS(.16)):IBIDS(.16),1:""),IBIDS(159)=2,IBIDS(158)=2 G ENDDIS
 I $D(IBI(IBX)) S IBIDS(.03)=IBI(IBX),IBIDS(.08)=$O(^DGPM("ATID1",DFN,9999999.9999999-IBI(IBX),0))
 I $D(IBIDS(.08)),$D(^DGPM(IBIDS(.08),0)) S IBIDS(.08)=$P(^(0),"^",16) S:$P(^(0),"^",17)]"" IBDSDT=+^DGPM($P(^(0),"^",17),0) D NOPTF G:'$D(IBIDS(.08)) DISPAD G ENDDIS
 I $D(IBJ(IBX)) S IBIDS(.03)=IBJ(IBX),IBIDS(.08)=$O(^DGPT("AFEE",DFN,IBJ(IBX),0)) S:$D(^DGPT(IBIDS(.08),70)) IBDSDT=+^(70) D NOPTF G:'$D(IBIDS(.08)) DISPAD G ENDDIS
 D HELPAD G DISPAD
 ;
ENDDIS I $G(IBIDS(.08)) D
 .N PTF Q:'$D(^DGPT(IBIDS(.08),"M"))
 .S PTF=IBIDS(.08) D SC1^IBCSC6
 .W !?4,"PTF record indicates ",IBSCM," of ",IBM," movements are for Service Connected Care."
 .I IBSCM,IBSCM=IBM W !?4,*7,"Warning, PTF record indicates all movements are for Service Connected Care.",*7
 ;
 K IBCNT,IBI,IBJ,DGPERCNT,IBX,%,%DT Q
 ;
NOPTF I $S(IBIDS(.08)="":1,'$D(^DGPT(IBIDS(.08),0)):1,1:0) K IBIDS(.08) W !!?4,*7,"PTF Record for this Admission is Missing",! Q
 Q
HELPAD I IBCNT D
 . W !!?4,"Enter a number from 1 to ",IBCNT," to select the EVENT DATE.  Inpatient",!?4,"admission dates are admissions for this VA Facility.  Non-VA admissions",!?4,"are for Fee Basis admissions with associated PTF records."
 . W !!?4,"Or you may enter a DATE in the past for which there is a Non-VA Admission",!?4,"without an associated PTF record",!
 E  D
 . W !!?4,"Enter a DATE in the past for which there is a Non-VA Admission",!?4,"without an associated PTF record",!
 Q
