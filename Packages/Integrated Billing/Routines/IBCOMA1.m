IBCOMA1 ;ALB/CMS - IDENTIFY ACTIVE POLICIES W/NO EFFECTIVE DATE (CON'T); 08-03-98
 ;;2.0;INTEGRATED BILLING;**103**;21-MAR-94
 Q
BEG ; Entry to run Active Policies w/no Effective Date Report
 ; Input variables:
 ; IBAIB - Required.    How to sort
 ;         1= Patient Name Range      2= Termianl Digit Range
 ;
 ; IBSIN - Required.   Include Active Policies with
 ;         1= Verification Date  2= No Verification Date 3= Both
 ;
 ; IBRF  - Required.  Name or Terminal Digit Range Start value
 ; IBRL  - Required.  Name or Terminal Digit Range Go to value
 ; IBBDT - Optional.  Begining Verification Date Range
 ; IBEDT - Optional.  Ending Verification Date Range
 ;
 N DFN,IBC,IBC0,IBCDA,IBCDA0,IBCDA1,IBC11,IBC13,IBGP,IBI,IBPAGE,IBTMP
 N IBQUIT,IBTD,IBX,VA,VADM,VAERR,X,Y
 K ^TMP("IBCOMA",$J) S IBPAGE=0,IBQUIT=0
 S IBC=0 F  S IBC=$O(^DPT("AB",IBC)) Q:'IBC  D
 .S IBC0=$G(^DIC(36,IBC,0))
 .;
 .;   If company inactive quit
 .I $P(IBC0,U)="" Q
 .I $P(IBC0,U,5)=1 Q
 .S DFN=0 F  S DFN=$O(^DPT("AB",IBC,DFN)) Q:'DFN  D
 ..K VA,VADM,VAERR,VAPA
 ..D DEM^VADPT,ADD^VADPT
 ..;
 ..;  I Pt. deceased quit I $G(VADM(6))>0 Q
 ..;  I Pt. name out of range quit
 ..S VADM(1)=$P($G(VADM(1)),U,1) I VADM(1)="" Q
 ..I IBAIB=1,VADM(1)]IBRL Q
 ..I IBAIB=1,IBRF]VADM(1) Q
 ..;
 ..;  I Terminal Digit out of range quit
 ..I IBAIB=2 S IBTD=$$TERMDG^IBCONS2(DFN) S:IBTD="" IBTD="000000000" I (+IBTD>IBRL)!(IBRF>+IBTD) Q
 ..S IBCDA=0 F  S IBCDA=$O(^DPT("AB",IBC,DFN,IBCDA)) Q:'IBCDA  D
 ...S IBCDA0=$G(^DPT(DFN,.312,IBCDA,0))
 ...;
 ...;  I Effective Date populated quit
 ...I $P(IBCDA0,U,8) Q
 ...;
 ...;  I Expiration Date entered and expired quit
 ...I $P(IBCDA0,U,4),$P(IBCDA0,U,4)'>DT Q
 ...;
 ...;  Sorting by verification date or no date check
 ...S IBCDA1=$G(^DPT(DFN,.312,IBCDA,1))
 ...I IBSIN=1,'$P(IBCDA1,U,3) Q
 ...S $P(IBCDA1,U,3)=$P($P(IBCDA1,U,3),".",1)
 ...I IBSIN=1,+$P(IBCDA1,U,3)>IBEDT Q
 ...I IBSIN=1,+$P(IBCDA1,U,3)<IBBDT Q
 ...I IBSIN=2,$P(IBCDA1,U,3) Q
 ...I IBSIN=3 I +$P(IBCDA1,U,3)>0 I +$P(IBCDA1,U,3)<IBBDT!(+$P(IBCDA1,U,3)>IBEDT) Q
 ...S IBC11=$G(^DIC(36,IBC,.11))
 ...S IBC13=$G(^DIC(36,IBC,.13))
 ...;
 ...;   set data line for global
 ...;S IBTMP(1)=PT NAME^SSN^AGE^HOME PHONE^DATE OF DEATH
 ...;S IBTMP(2)=INSURANCE NAME^REIMBURSE?^PHONE^ADD LINE 1
 ...;S IBTMP(3)=GROUP PLAN^SUBSCRIBER ID^WHOSE INS.^VERIFICATION DATE
 ...;
 ...S IBGP=$P($G(^IBA(355.3,+$P(IBCDA0,U,18),0)),U,3)
 ...S IBTMP(1)=VADM(1)_U_$P(VADM(2),U,2)_U_+VADM(4)_U_$P(VAPA(8),U,1)_U_$$FMTE^XLFDT($P(VADM(6),U,1),"5ZD")
 ...S IBTMP(2)=$P(IBC0,U,1)_U_$P(IBC0,U,2)_U_$P(IBC13,U,1)_U_$P(IBC11,U,1)
 ...S IBTMP(3)=$S(IBGP]"":IBGP,1:"(No Plan Name)")_U_$P(IBCDA0,U,2)_U_$P(IBCDA0,U,6)_U_$$FMTE^XLFDT($P(IBCDA1,U,3),"5ZD")
 ...;
 ...;   set variable IBI for Verified=1 or Non verified=2 
 ...S IBI=$S(+$P(IBCDA1,U,3):1,1:2)
 ...;
 ...;   Set Global array
 ...S ^TMP("IBCOMA",$J,IBI,$S(IBAIB=2:+IBTD,1:VADM(1)),DFN)=IBTMP(1)
 ...S ^TMP("IBCOMA",$J,IBI,$S(IBAIB=2:+IBTD,1:VADM(1)),DFN,IBC)=IBTMP(2)
 ...S ^TMP("IBCOMA",$J,IBI,$S(IBAIB=2:+IBTD,1:VADM(1)),DFN,IBC,IBCDA)=IBTMP(3)
 ...;
 ;
 I '$D(^TMP("IBCOMA",$J)) D HD W !!,"** NO RECORDS FOUND **" G QUEQ
 D WRT
 ;
QUEQ ; Exit clean-UP
 W ! D ^%ZISC K IBTMP,IBAIB,IBRF,IBRL,IBSIN,IBSTR,VA,VAERR,VADM,VAPA,^TMP("IBCOMA",$J)
 Q
 ;
HD ;Write Heading
 S IBPAGE=IBPAGE+1
 W @IOF,"Active Policies with no Effective Date Report    ",$$FMTE^XLFDT($$NOW^XLFDT,"Z")," Page: ",IBPAGE
 W !,?5,"Sorted by: "_$S(IBAIB=1:"Patient Name",1:"Terminal Digit")_"  Range: "_$S(IBRF="A":"FIRST",1:IBRF)_" to "_$S(IBRL="zzzzzz":"LAST",1:IBRL)
 W !,?5,"  Include: "_$S(IBSIN=1:"Verification Date Range: "_$$FMTE^XLFDT(IBBDT,"Z")_" to "_$$FMTE^XLFDT(IBEDT,"Z"),IBSIN=2:"No Verification Date Entered",1:"with or without Verification Date")
 W !!,"Patient Name",?32,"SSN",?44,"Age",?50,"Phone",?66,"Date of Death"
 W ! F IBX=1:1:79 W "="
 Q
 ;
WRT ;Write data lines
 N IBA,IBCDA,IBDA,IBDFN,IBINS,IBNA,IBPOL,IBPT,X,Y S IBQUIT=0
 S IBA=0 F  S IBA=$O(^TMP("IBCOMA",$J,IBA)) Q:('IBA)!(IBQUIT=1)  D
 .I IBPAGE D ASK^IBCOMC2 I IBQUIT=1 Q
 .D HD W !,$S(IBA=1:"Verified",1:"Non-Verified")
 .S IBNA="" F  S IBNA=$O(^TMP("IBCOMA",$J,IBA,IBNA)) Q:(IBNA="")!(IBQUIT=1)  D
 ..S IBDFN=0 F  S IBDFN=$O(^TMP("IBCOMA",$J,IBA,IBNA,IBDFN)) Q:('IBDFN)!(IBQUIT=1)  D
 ...S IBPT=$G(^TMP("IBCOMA",$J,IBA,IBNA,IBDFN))
 ...;
 ...I ($Y+6)>IOSL D  I IBQUIT=1 Q
 ....D ASK^IBCOMC2 I IBQUIT=1 Q
 ....D HD
 ...;
 ...W !!,$E($P(IBPT,U,1),1,30),?32,$E($P(IBPT,U,2),1,12),?44,$J($P(IBPT,U,3),3),?50,$E($P(IBPT,U,4),1,20),?70,$P(IBPT,U,5)
 ...;
 ...S IBDA=0 F  S IBDA=$O(^TMP("IBCOMA",$J,IBA,IBNA,IBDFN,IBDA)) Q:('IBDA)!(IBQUIT=1)  D
 ....S IBINS=$G(^TMP("IBCOMA",$J,IBA,IBNA,IBDFN,IBDA))
 ....W !?3,$E($P(IBINS,U,1),1,30),?35,"Reimb VA? ",$P(IBINS,U,2),?50,$E($P(IBINS,U,3),1,20) ; ?70,$E($P(IBINS,U,4),1,10)
 ....;
 ....S IBCDA=0 F  S IBCDA=$O(^TMP("IBCOMA",$J,IBA,IBNA,IBDFN,IBDA,IBCDA)) Q:('IBCDA)!(IBQUIT=1)   D
 .....S IBPOL=$G(^TMP("IBCOMA",$J,IBA,IBNA,IBDFN,IBDA,IBCDA))
 .....W !?5,$E($P(IBPOL,U,1),1,20),?26,"Sub ID: ",$E($P(IBPOL,U,2),1,20),?55,"Whose: ",$P(IBPOL,U,3)
 .....I IBA=1 W ?64,"Verif:",$P(IBPOL,U,4)
 Q
 ;IBCOMA1
