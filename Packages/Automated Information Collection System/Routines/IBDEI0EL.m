IBDEI0EL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6715,0)
 ;;=Z77.22^^30^397^18
 ;;^UTILITY(U,$J,358.3,6715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6715,1,3,0)
 ;;=3^Environmental Exposure Tobacco Smoke/Second-Hand Smoke
 ;;^UTILITY(U,$J,358.3,6715,1,4,0)
 ;;=4^Z77.22
 ;;^UTILITY(U,$J,358.3,6715,2)
 ;;=^5063324
 ;;^UTILITY(U,$J,358.3,6716,0)
 ;;=Z80.0^^30^397^35
 ;;^UTILITY(U,$J,358.3,6716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6716,1,3,0)
 ;;=3^Family Hx of Malig Neop of Digestive Organs
 ;;^UTILITY(U,$J,358.3,6716,1,4,0)
 ;;=4^Z80.0
 ;;^UTILITY(U,$J,358.3,6716,2)
 ;;=^5063344
 ;;^UTILITY(U,$J,358.3,6717,0)
 ;;=Z80.1^^30^397^41
 ;;^UTILITY(U,$J,358.3,6717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6717,1,3,0)
 ;;=3^Family Hx of Malig Neop of Trachea,Bronc & Lung
 ;;^UTILITY(U,$J,358.3,6717,1,4,0)
 ;;=4^Z80.1
 ;;^UTILITY(U,$J,358.3,6717,2)
 ;;=^5063345
 ;;^UTILITY(U,$J,358.3,6718,0)
 ;;=Z80.3^^30^397^34
 ;;^UTILITY(U,$J,358.3,6718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6718,1,3,0)
 ;;=3^Family Hx of Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,6718,1,4,0)
 ;;=4^Z80.3
 ;;^UTILITY(U,$J,358.3,6718,2)
 ;;=^5063347
 ;;^UTILITY(U,$J,358.3,6719,0)
 ;;=Z80.41^^30^397^38
 ;;^UTILITY(U,$J,358.3,6719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6719,1,3,0)
 ;;=3^Family Hx of Malig Neop of Ovary
 ;;^UTILITY(U,$J,358.3,6719,1,4,0)
 ;;=4^Z80.41
 ;;^UTILITY(U,$J,358.3,6719,2)
 ;;=^5063348
 ;;^UTILITY(U,$J,358.3,6720,0)
 ;;=Z80.42^^30^397^39
 ;;^UTILITY(U,$J,358.3,6720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6720,1,3,0)
 ;;=3^Family Hx of Malig Neop of Prostate
 ;;^UTILITY(U,$J,358.3,6720,1,4,0)
 ;;=4^Z80.42
 ;;^UTILITY(U,$J,358.3,6720,2)
 ;;=^5063349
 ;;^UTILITY(U,$J,358.3,6721,0)
 ;;=Z80.43^^30^397^40
 ;;^UTILITY(U,$J,358.3,6721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6721,1,3,0)
 ;;=3^Family Hx of Malig Neop of Testis
 ;;^UTILITY(U,$J,358.3,6721,1,4,0)
 ;;=4^Z80.43
 ;;^UTILITY(U,$J,358.3,6721,2)
 ;;=^5063350
 ;;^UTILITY(U,$J,358.3,6722,0)
 ;;=Z80.6^^30^397^32
 ;;^UTILITY(U,$J,358.3,6722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6722,1,3,0)
 ;;=3^Family Hx of Leukemia
 ;;^UTILITY(U,$J,358.3,6722,1,4,0)
 ;;=4^Z80.6
 ;;^UTILITY(U,$J,358.3,6722,2)
 ;;=^5063354
 ;;^UTILITY(U,$J,358.3,6723,0)
 ;;=Z80.8^^30^397^37
 ;;^UTILITY(U,$J,358.3,6723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6723,1,3,0)
 ;;=3^Family Hx of Malig Neop of Organs/Systems
 ;;^UTILITY(U,$J,358.3,6723,1,4,0)
 ;;=4^Z80.8
 ;;^UTILITY(U,$J,358.3,6723,2)
 ;;=^5063356
 ;;^UTILITY(U,$J,358.3,6724,0)
 ;;=Z81.8^^30^397^42
 ;;^UTILITY(U,$J,358.3,6724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6724,1,3,0)
 ;;=3^Family Hx of Mental/Behavioral Disorders
 ;;^UTILITY(U,$J,358.3,6724,1,4,0)
 ;;=4^Z81.8
 ;;^UTILITY(U,$J,358.3,6724,2)
 ;;=^5063363
 ;;^UTILITY(U,$J,358.3,6725,0)
 ;;=Z82.3^^30^397^49
 ;;^UTILITY(U,$J,358.3,6725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6725,1,3,0)
 ;;=3^Family Hx of Stroke
 ;;^UTILITY(U,$J,358.3,6725,1,4,0)
 ;;=4^Z82.3
 ;;^UTILITY(U,$J,358.3,6725,2)
 ;;=^5063367
 ;;^UTILITY(U,$J,358.3,6726,0)
 ;;=Z82.49^^30^397^31
 ;;^UTILITY(U,$J,358.3,6726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6726,1,3,0)
 ;;=3^Family Hx of Ischemic Heart Disease/Circulatory System
 ;;^UTILITY(U,$J,358.3,6726,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,6726,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,6727,0)
 ;;=Z82.5^^30^397^22
 ;;^UTILITY(U,$J,358.3,6727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6727,1,3,0)
 ;;=3^Family Hx of Asthma/Chronic Lower Respiratory Diseases
 ;;^UTILITY(U,$J,358.3,6727,1,4,0)
 ;;=4^Z82.5
 ;;^UTILITY(U,$J,358.3,6727,2)
 ;;=^5063370
