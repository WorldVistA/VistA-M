PXRRPCR2 ;HIN/MjK - Clinic Specfic Workload Reports ;6/7/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
ACTIVTY ;:_._._._._._._._._._._._.Caseload Activity_._._._._._._._._._._._.
 S PXRRQ=1 D HDR^PXRRPCR W ?11,"Report Date Range: ",$$FMTE^XLFDT($P(PXRRBDT,"."))," through ",$$FMTE^XLFDT($P(PXRREDT,"."))
 I $D(PXRSTPNM)  W !?22,"Clinic Stop: ",PXRSTPNM G HDR
 W !?2,"Clinic(s): ",$P($G(PXRRCLIN(1)),U) F I=2:1 Q:'$D(PXRRCLIN(I))  D
 . I ($L($P(PXRRCLIN(I),U))+$X+3)<IOM W ", ",$P(PXRRCLIN(I),U) Q
 . W !?13,$P($G(PXRRCLIN(I)),U)
HDR W !?2,"CASELOAD ACTIVITY...patients' hospital admissions/discharges, emergency room",!?2,"visits and critical lab values ;address,phone,future appts",!
NONE ;_._._.If no Pateint Activity_._._.
 I '$D(^TMP($J,"PATIENT")) W !,"No patients were recorded to have these actitvites within the",!,"selected date range." Q
ADM ;A = Patient DFN ;B/C = Admission Date ;E=Discharge Date ;T = Line Tag
 W !,"____________________________ADMISSIONS/DISCHARGES____________________________",! S T="ADMH^PXRRPCR"
 I '$D(^TMP($J,"ADM")) W !?5,"o There were no ADMISSIONS for these patients during this date range.",! G ER
 D @T S A=0 F  S A=$O(^TMP($J,"ADM",A)) Q:'A!('PXRRQ)  S B=0 F  S B=$O(^TMP($J,"ADM",A,B)) Q:'B!('PXRRQ)  S C=$$FMTE^XLFDT(B),E=$$FMTE^XLFDT($P($P(^TMP($J,"ADM",A,B),U),".")) D CHK:$Y>(IOSL-12) Q:'PXRRQ  D
 .  W !,$P(C,"@"),?13,E,?30,$E($P(^DPT(A,0),U),1,25)
 .  W ?57,$P(^DPT(A,0),U,9)
 .  W ?69,$P(^TMP($J,"ADM",A,B),U,2) W:'$O(^(B)) !
 .  I '$O(^TMP($J,"ADM",A,B)) D
 .. W ?2,"Addr: ",$S($P($G(^(B)),U,3)'="":$P($G(^(B)),U,3)_" "_$P($G(^(B)),U,4),1:"Not Available")_" / "
 .. W $S($P($G(^(B)),U,5)'="":$E($P($G(^(B)),U,5),1,20),1:"No TOWN")_"  "
 .. W $P($G(^(B)),U,6)_" "
 .. W $S($P($G(^(B)),U,7)'="":$P($G(^(B)),U,7),1:"No ZIP")_" / "
 .. W "Ph: "_$S($P($G(^(B)),U,8)'="":$P($G(^(B)),U,8),1:"No PHONE"),!
 .. D CHK:$Y>(IOSL-11) Q:'PXRRQ
 .. D FUT W !?32,"~~~~~~~~~~~~"
 Q:'PXRRQ
ER ;A = Patient DFN ;B/C = Visit Date ;T = Line Tag
 W !,"_____________________________EMERGENCY ROOM VISITS_____________________________",! S T="ERH^PXRRPCR"
 I '$D(^TMP($J,"ER")) W !?5,"o There were no ER VISITS for these patients during this date range.",! G LAB
 D @T S A=0 F  S A=$O(^TMP($J,"ER",A)) Q:'A!('PXRRQ)  S B=0 F  S B=$O(^TMP($J,"ER",A,B)) Q:'B  S C=$$FMTE^XLFDT(B) D CHK:$Y>(IOSL-6) Q:'PXRRQ  D
 .  W !,C,?27,$E($P(^DPT(A,0),U),1,27),?57,$P(^DPT(A,0),U,9)
 .  I '$O(^TMP($J,"ER",A,B)) D
 .. W !?2,"Addr: ",$S($P($G(^TMP($J,"ER",A,B)),U)'="":$P($G(^(B)),U)_$P($G(^(B)),U,2),1:"No Address")_" / "
 .. W $S($P($G(^TMP($J,"ER",A,B)),U,3)'="":$P($G(^(B)),U,3),1:"No TOWN")_"  "
 .. W $P($G(^TMP($J,"ER",A,B)),U,4)_" "
 .. W $S($P($G(^TMP($J,"ER",A,B)),U,5)'="":$P($G(^(B)),U,5),1:"No ZIP")_"  "
 .. W "PH: "_$S($P($G(^(B)),U,6)'="":$P($G(^(B)),U,6),1:"No Phone"),!
 .. D CHK:$Y>(IOSL-6) Q:'PXRRQ  D FUT W !?32,"~~~~~~~~~~~~"
 Q:'PXRRQ
LAB ;A = Patient DFN ;B/C = Lab Date ;E =Lab Test Field No. ;T =Line Tag
 W !,"____________________________CRITICAL LAB VALUES____________________________",! S T="LABH^PXRRPCR"
 I '$D(^TMP($J,"LAB")) W !?5,"o There were no CRITICAL LABS for these patients during this date range. ",! G Q
 D @T S A=0 F  S A=$O(^TMP($J,"LAB",A)) Q:'A!('PXRRQ)  S B=0 F  S B=$O(^TMP($J,"LAB",A,B)) Q:'B  S C=$$FMTE^XLFDT(B),E=0 F  S E=$O(^TMP($J,"LAB",A,B,E)) Q:'E  D CHK:$Y>(IOSL-6) Q:'PXRRQ  D
 .  W !,$P(C,"@"),?13,$E($P(^DPT(A,0),U),1,20),?35,$P(^DPT(A,0),U,9)
 .  W ?48,$P($G(^TMP($J,"LAB",A,B,E)),U)
 .  W ?75,$P($G(^TMP($J,"LAB",A,B,E)),U,8)
 .  I '$O(^TMP($J,"LAB",A,B))&('$O(^TMP($J,"LAB",A,B,E))) D
 .. W !?2,"Addr. ",$S($P($G(^TMP($J,"LAB",A,B,E)),U,2)'="":$P($G(^(E)),U,2),1:"No Address")_" / "
 .. W $S($P($G(^TMP($J,"LAB",A,B,E)),U,4)'="":$P($G(^(E)),U,4),1:"No TOWN")_"  "
 .. W $P($G(^TMP($J,"LAB",A,B,E)),U,5)_" "
 .. W $S($P($G(^TMP($J,"LAB",A,B,E)),U,6)'="":$P($G(^(E)),U,6),1:"No ZIP")_" / "
 .. W "Ph: ",$S($P($G(^TMP($J,"LAB",A,B,E)),U,7)'="":$P($G(^(E)),U,7),1:"Not Avail."),!
 .. D CHK:$Y>(IOSL-6) Q:'PXRRQ
 .. D FUT W !?32,"~~~~~~~~~~~~"
Q W !,"______________________________________________________________________________",! ;?2,"TOTAL UNIQUE PATIENTS: ",PXRRTPAT,?50,"TOTAL VISITS: ",PXRRTVS
 Q
FUT ;Z/Q = Fut Appointment Date ;A = Patient DFN
 I '$D(^TMP($J,"FUT",A)) W !?2,"Future Appt. Dt:  ",?22,"NONE" Q
 S Z=0 F  S Z=$O(^TMP($J,"FUT",A,Z)) Q:'Z  S Q=$$FMTE^XLFDT(Z) D
 . W !?8,"Fut. Appt. Dt:  ",Q,?41," - CL: ",$E($G(^TMP($J,"FUT",A,Z)),1,30)
 D CHK:$Y>(IOSL-4) Q:'PXRRQ
 Q
CHK ;Hold Screen, Format for Home Device Viewing
 I IOST?1"C-".E S DIR(0)="E" D ^DIR S PXRRQ=$S(Y:1,1:0) K DIR
 I +PXRRQ D HDR^PXRRPCR,@T
 Q
