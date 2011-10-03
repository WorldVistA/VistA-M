IBJDI7 ;ALB/CPM - OUTPATIENT WORKLOAD REPORT ; 19-DEC-96
 ;;2.0;INTEGRATED BILLING;**69,91,98,100,118,133,339**;21-MAR-94;Build 2
 ;
EN ; - Option entry point.
 ;
 W !!,"This report provides a measure of the number and types of"
 W !,"Outpatient Services that are provided in the Medical Center.",!
 ;
DATE D DATE^IBOUTL I IBBDT=""!(IBEDT="") G ENQ
 ;
 ; - Sort by division?
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you wish to sort this report by division"
 S DIR("?")="^D DHLP^IBJDI7" W !
 D ^DIR S IBSORT=+Y I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
 ; - Select division(s).
 I IBSORT D PSDR^IBODIV G:Y<0 ENQ
 ;
 W !!,"This report only requires an 80 column printer."
 ;
 W !!,"Note: This report may take a while to run."
 W !?6,"You should queue this report to run after normal business hours.",!
 ;
 ; - Select a device.
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDI7",ZTDESC="IB - OUTPATIENT WORKLOAD REPORT"
 .F I="IBBDT","IBEDT","IBSORT","VAUTD","VAUTD(" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"This job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; - Tasked entry point.
 ;
 I $G(IBXTRACT) D E^IBJDE(7,1) ; Change extract status.
 ;
 N IBQUERY K IB
 S IBC="TOT^NSC^SC^SCS^SCN",IBQ=0
 I IBSORT D
 .S I=0 F  S I=$S(VAUTD:$O(^DG(40.8,I)),1:$O(VAUTD(I))) Q:'I  D
 ..S J=$P(^DG(40.8,I,0),U),IB(J,"GTOT")=0
 ..F K=1:1:5 S IB(J,$P(IBC,U,K)_"-A")=0 S:K<4 IB(J,$P(IBC,U,K)_"-I")=0
 S IB("ZZALL","GTOT")=0
 F I=1:1:5 D
 .S IB("ZZALL",$P(IBC,U,I)_"-A")=0 S:I<4 IB("ZZALL",$P(IBC,U,I)_"-I")=0
 ;
 ; - Find outpatient encounters within the user-specified date range.
 D OUTPT^IBJDI21("",IBBDT,IBEDT,"S:IBQ SDSTOP=1 D:'IBQ ENC^IBJDI7(Y,Y0)","Outpatient Workload Report",.IBQ,"",.IBQUERY)
 D CLOSE^IBSDU(.IBQUERY)
 ;
 I IBQ G ENQ
 ;
 I $G(IBXTRACT) D E^IBJDE(7,0) G ENQ ; Extract summary data.
 ;
 ; - Print the report.
 S (IBPAG,IBQ)=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 S IBDIV="" F  S IBDIV=$O(IB(IBDIV)) Q:IBDIV=""  D SUM Q:IBQ
 ;
ENQ I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IBC,IBH,IBQ,IBBDT,IBEDT,IBD,IBDIV,IBOE,IBOED,IBPAG,IBRUN,IBSORT
 K IBPER,IBINS,IBSC,%,%ZIS,DFN,POP,I,J,K,X,Y,VA,VAEL,VAERR,VAUTD
 K ZTDESC,ZTRTN,ZTSAVE
 Q
 ;
ENC(IBOE,IBOED) ; - Extract encounter - must be called from DQ above.
 I $$TESTP^IBJDI1(+$P(IBOED,U,2)) G ENCQ  ; Test patient.
 ;
 I IBSORT D  G:'$D(IB(IBDIV,"TOT-A")) ENCQ
 .S IBDIV=+$P(IBOED,U,11)
 .S IBDIV=$P($G(^DG(40.8,$S('IBDIV:+$$PRIM^VASITE(),1:IBDIV),0)),U)
 ;
 S IBINS=$$INS(IBOE,IBOED) ; Check if insured encounter.
 ;
 ; - Set main totals.
 S IB("ZZALL","GTOT")=IB("ZZALL","GTOT")+1
 S IB("ZZALL","TOT-A")=IB("ZZALL","TOT-A")+1
 I IBINS S IB("ZZALL","TOT-I")=IB("ZZALL","TOT-I")+1
 I IBSORT D
 .S IB(IBDIV,"GTOT")=IB(IBDIV,"GTOT")+1
 .S IB(IBDIV,"TOT-A")=IB(IBDIV,"TOT-A")+1
 .I IBINS S IB(IBDIV,"TOT-I")=IB(IBDIV,"TOT-I")+1
 ;
 ; - Set NSC totals.
 S DFN=+$P(IBOED,U,2) D ELIG^VADPT S IBSC=+VAEL(3)
 I 'IBSC D  G ENCQ
 .S IB("ZZALL","NSC-A")=IB("ZZALL","NSC-A")+1
 .I IBINS S IB("ZZALL","NSC-I")=IB("ZZALL","NSC-I")+1
 .I IBSORT D
 ..S IB(IBDIV,"NSC-A")=IB(IBDIV,"NSC-A")+1
 ..I IBINS S IB(IBDIV,"NSC-I")=IB(IBDIV,"NSC-I")+1
 ;
 ; - Set SC totals.
 S IB("ZZALL","SC-A")=IB("ZZALL","SC-A")+1
 I IBINS S IB("ZZALL","SC-I")=IB("ZZALL","SC-I")+1
 I IBSORT D
 .S IB(IBDIV,"SC-A")=IB(IBDIV,"SC-A")+1
 .I IBINS S IB(IBDIV,"SC-I")=IB(IBDIV,"SC-I")+1
 ;
 ; - If care related to an SC condition, set SCS totals.
 I $$SC(IBOE) D  G ENCQ
 .S IB("ZZALL","SCS-A")=IB("ZZALL","SCS-A")+1
 .I IBSORT S IB(IBDIV,"SCS-A")=IB(IBDIV,"SCS-A")+1
 ;
 ; - Set SCN totals.
 S IB("ZZALL","SCN-A")=IB("ZZALL","SCN-A")+1
 I IBSORT S IB(IBDIV,"SCN-A")=IB(IBDIV,"SCN-A")+1
 ;
ENCQ Q
 ;
SUM ; - Print the summary report.
 F X="-A","-I" D  Q:IBQ
 .I X["A" W @IOF,*13
 .I X["I",$E(IOST,1,2)="C-" W @IOF,*13
 .E  W:X["I" !!
 .;
 .; - Print summary header.
 .W !!?$S(X["A":17,1:12),"OUTPATIENT ENCOUNTER WORKLOAD - "
 .W $S(X["A":"ALL ENCOUNTERS",1:"INSURED ENCOUNTERS ONLY")
 .S IBH="SUMMARY REPORT FOR "_$S(IBDIV="ZZALL":"ALL DIVISIONS",1:IBDIV)
 .S IBC=(80-$L(IBH)/2)\1 W !?IBC,IBH
 .W !!?$S(X["A":15,1:11),"For ",$S(X["I":"Insured ",1:""),"Outpatient Encounters from ",$$DAT1^IBOUTL(IBBDT)," - ",$$DAT1^IBOUTL(IBEDT)
 .I $E(IOST,1,2)="C-" W !!?24,"Run Date: ",IBRUN
 .S IBC=$S(X["A":"17^46",1:"12^55") W !?+IBC,$$DASH($P(IBC,U,2)),!!
 .;
 .; - Print summary statistics.
 .S IBPER(1)=$J($S('IB(IBDIV,"TOT"_X):0,1:IB(IBDIV,"NSC"_X)/IB(IBDIV,"TOT"_X)*100),0,2),IBPER(2)=$J($S('IB(IBDIV,"TOT"_X):0,1:100-IBPER(1)),0,2)
 .W ?$S(X["A":27,1:21),"Number of Outpatient Encounters:",?$S(X["A":60,1:54),$J(IB(IBDIV,"TOT"_X),7)
 .W !?$S(X["A":21,1:15),"Number of Encounters for NSC Veterans:",?$S(X["A":60,1:54),$J(IB(IBDIV,"NSC"_X),7),"  (",IBPER(1),"%)"
 .W !?$S(X["A":22,1:16),"Number of Encounters for SC Veterans:",?$S(X["A":60,1:54),$J(IB(IBDIV,"SC"_X),7),"  (",IBPER(2),"%)"
 .I X["A" D
 ..S IBPER(3)=$J($S('IB(IBDIV,"SC-A"):0,1:IB(IBDIV,"SCS-A")/IB(IBDIV,"SC-A")*100),0,2),IBPER(4)=$J($S('IB(IBDIV,"SC-A"):0,1:100-IBPER(3)),0,2)
 ..W !?4,"Number of Service Connected Encounters for SC Veterans:",?60,$J(IB(IBDIV,"SCS-A"),7),"  (",IBPER(3),"%)"
 ..W !?3,"Number of Non-Svc. Connected Encounters for SC Veterans:",?60,$J(IB(IBDIV,"SCN-A"),7),"  (",IBPER(4),"%)"
 .E  D
 ..S IBPER(5)=$J($S('IB(IBDIV,"GTOT"):0,1:IB(IBDIV,"TOT-I")/IB(IBDIV,"GTOT")*100),0,2)
 ..W !!?5,"Percentage of Insured Outpatient Encounters for ",$S(IBDIV="ZZALL":"All Divisions",1:"This Division"),": ",IBPER(5),"%"
 .D PAUSE
 Q
 ;
DASH(X) ; - Return a dashed line.
 Q $TR($J("",X)," ","=")
 ;
PAUSE ; - Page break.
 I $E(IOST,1,2)'="C-" Q
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
 ;
INS(IBOE,IBOED) ; - Is this an insured encounter?
 ;  Input:  IBOE = IEN of outpatient encounter in file #409.68
 ;         IBOED = Outpatient encounter in file #409.68
 ; Output: 1 = Insured encounter
 ;         0 = Not an insured encounter
 ;
 N DFN,IBCK,IBPB,VA,VAEL,VAERR,X0
 S DFN=+$P(IBOED,U,2)
 I $G(^DPT(DFN,"VET"))'="Y" G INSQ ;        Patient not a veteran.
 I '$$INSURED^IBCNS1(DFN,+IBOED\1) G INSQ ; Patient not insured.
 ;
 ; - Check if encounter was made non-billable in Claims Tracking.
 I $P($G(^IBT(356,+$O(^IBT(356,"ASCE",IBOE,0)),0)),U,19) G INSQ
 ;
 ; - Check encounter for non-billable appt. type (1), non-count
 ;   clinic (2), non-billable clinic (3,12), admission by 11:59pm of
 ;   encounter date (5), non-billable stop code (7,8), non-billable
 ;   disposition (10), and parent encounter (11). If IBPB equals one
 ;   of these numbers, Y will be set to 0 (Not an insured encounter).
 F X0=1,2,3,5,7,8,10,11,12 S IBCK(X0)=""
 S X0=$$BILLCK^IBAMTEDU(IBOE,IBOED,.IBCK,.IBPB)
 I $G(IBPB) G INSQ
 ;
 I $$ENCL^IBAMTS2(IBOE)[1 G INSQ ; Care is related to AO/IR/SWA/SC/MST/HNC/CV/SHAD.
 ;
 S Y=1 Q Y
INSQ S Y=0 Q Y
 ;
SC(OE) ; - Is the encounter related to the veteran's SC condition?
 ;  Input: OE = IEN of outpatient encounter in file #409.68
 ; Output: SC = 1 (Encounter related to SC condition)
 ;              0 (Encounter NOT related to SC condition)
 ;
 N CL,CLD,SC
 S (CL,SC)=0 F  S CL=$O(^SDD(409.42,"OE",+$G(OE),CL)) Q:'CL  D  Q:SC
 .S CLD=$G(^SDD(409.42,CL,0)) I +CLD=3,$P(CLD,U,3) S SC=1
 Q SC
 ;
DHLP ; - Display 'Sort by division' help.
 W !,"Enter RETURN to summarize all outpt. encounters without regard to"
 W !,"division, or 'Yes' to select those divisions for which a separate"
 W !,"summary report should be created."
 Q
