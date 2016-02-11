IBDEI154 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19045,1,3,0)
 ;;=3^Environmental Exposure Tobacco Smoke/Second-Hand Smoke
 ;;^UTILITY(U,$J,358.3,19045,1,4,0)
 ;;=4^Z77.22
 ;;^UTILITY(U,$J,358.3,19045,2)
 ;;=^5063324
 ;;^UTILITY(U,$J,358.3,19046,0)
 ;;=Z80.0^^94^917^35
 ;;^UTILITY(U,$J,358.3,19046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19046,1,3,0)
 ;;=3^Family Hx of Malig Neop of Digestive Organs
 ;;^UTILITY(U,$J,358.3,19046,1,4,0)
 ;;=4^Z80.0
 ;;^UTILITY(U,$J,358.3,19046,2)
 ;;=^5063344
 ;;^UTILITY(U,$J,358.3,19047,0)
 ;;=Z80.1^^94^917^41
 ;;^UTILITY(U,$J,358.3,19047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19047,1,3,0)
 ;;=3^Family Hx of Malig Neop of Trachea,Bronc & Lung
 ;;^UTILITY(U,$J,358.3,19047,1,4,0)
 ;;=4^Z80.1
 ;;^UTILITY(U,$J,358.3,19047,2)
 ;;=^5063345
 ;;^UTILITY(U,$J,358.3,19048,0)
 ;;=Z80.3^^94^917^34
 ;;^UTILITY(U,$J,358.3,19048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19048,1,3,0)
 ;;=3^Family Hx of Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,19048,1,4,0)
 ;;=4^Z80.3
 ;;^UTILITY(U,$J,358.3,19048,2)
 ;;=^5063347
 ;;^UTILITY(U,$J,358.3,19049,0)
 ;;=Z80.41^^94^917^38
 ;;^UTILITY(U,$J,358.3,19049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19049,1,3,0)
 ;;=3^Family Hx of Malig Neop of Ovary
 ;;^UTILITY(U,$J,358.3,19049,1,4,0)
 ;;=4^Z80.41
 ;;^UTILITY(U,$J,358.3,19049,2)
 ;;=^5063348
 ;;^UTILITY(U,$J,358.3,19050,0)
 ;;=Z80.42^^94^917^39
 ;;^UTILITY(U,$J,358.3,19050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19050,1,3,0)
 ;;=3^Family Hx of Malig Neop of Prostate
 ;;^UTILITY(U,$J,358.3,19050,1,4,0)
 ;;=4^Z80.42
 ;;^UTILITY(U,$J,358.3,19050,2)
 ;;=^5063349
 ;;^UTILITY(U,$J,358.3,19051,0)
 ;;=Z80.43^^94^917^40
 ;;^UTILITY(U,$J,358.3,19051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19051,1,3,0)
 ;;=3^Family Hx of Malig Neop of Testis
 ;;^UTILITY(U,$J,358.3,19051,1,4,0)
 ;;=4^Z80.43
 ;;^UTILITY(U,$J,358.3,19051,2)
 ;;=^5063350
 ;;^UTILITY(U,$J,358.3,19052,0)
 ;;=Z80.6^^94^917^32
 ;;^UTILITY(U,$J,358.3,19052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19052,1,3,0)
 ;;=3^Family Hx of Leukemia
 ;;^UTILITY(U,$J,358.3,19052,1,4,0)
 ;;=4^Z80.6
 ;;^UTILITY(U,$J,358.3,19052,2)
 ;;=^5063354
 ;;^UTILITY(U,$J,358.3,19053,0)
 ;;=Z80.8^^94^917^37
 ;;^UTILITY(U,$J,358.3,19053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19053,1,3,0)
 ;;=3^Family Hx of Malig Neop of Organs/Systems
 ;;^UTILITY(U,$J,358.3,19053,1,4,0)
 ;;=4^Z80.8
 ;;^UTILITY(U,$J,358.3,19053,2)
 ;;=^5063356
 ;;^UTILITY(U,$J,358.3,19054,0)
 ;;=Z81.8^^94^917^42
 ;;^UTILITY(U,$J,358.3,19054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19054,1,3,0)
 ;;=3^Family Hx of Mental/Behavioral Disorders
 ;;^UTILITY(U,$J,358.3,19054,1,4,0)
 ;;=4^Z81.8
 ;;^UTILITY(U,$J,358.3,19054,2)
 ;;=^5063363
 ;;^UTILITY(U,$J,358.3,19055,0)
 ;;=Z82.3^^94^917^49
 ;;^UTILITY(U,$J,358.3,19055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19055,1,3,0)
 ;;=3^Family Hx of Stroke
 ;;^UTILITY(U,$J,358.3,19055,1,4,0)
 ;;=4^Z82.3
 ;;^UTILITY(U,$J,358.3,19055,2)
 ;;=^5063367
 ;;^UTILITY(U,$J,358.3,19056,0)
 ;;=Z82.49^^94^917^31
 ;;^UTILITY(U,$J,358.3,19056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19056,1,3,0)
 ;;=3^Family Hx of Ischemic Heart Disease/Circulatory System
 ;;^UTILITY(U,$J,358.3,19056,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,19056,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,19057,0)
 ;;=Z82.5^^94^917^22
 ;;^UTILITY(U,$J,358.3,19057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19057,1,3,0)
 ;;=3^Family Hx of Asthma/Chronic Lower Respiratory Diseases
 ;;^UTILITY(U,$J,358.3,19057,1,4,0)
 ;;=4^Z82.5
 ;;^UTILITY(U,$J,358.3,19057,2)
 ;;=^5063370
