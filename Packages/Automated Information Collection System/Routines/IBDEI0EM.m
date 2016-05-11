IBDEI0EM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6728,0)
 ;;=Z82.61^^30^397^21
 ;;^UTILITY(U,$J,358.3,6728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6728,1,3,0)
 ;;=3^Family Hx of Arthritis
 ;;^UTILITY(U,$J,358.3,6728,1,4,0)
 ;;=4^Z82.61
 ;;^UTILITY(U,$J,358.3,6728,2)
 ;;=^5063371
 ;;^UTILITY(U,$J,358.3,6729,0)
 ;;=Z82.69^^30^397^44
 ;;^UTILITY(U,$J,358.3,6729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6729,1,3,0)
 ;;=3^Family Hx of Musculoskeletal System/Connective Tissue
 ;;^UTILITY(U,$J,358.3,6729,1,4,0)
 ;;=4^Z82.69
 ;;^UTILITY(U,$J,358.3,6729,2)
 ;;=^5063373
 ;;^UTILITY(U,$J,358.3,6730,0)
 ;;=Z83.3^^30^397^28
 ;;^UTILITY(U,$J,358.3,6730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6730,1,3,0)
 ;;=3^Family Hx of Diabetes Mellitus
 ;;^UTILITY(U,$J,358.3,6730,1,4,0)
 ;;=4^Z83.3
 ;;^UTILITY(U,$J,358.3,6730,2)
 ;;=^5063379
 ;;^UTILITY(U,$J,358.3,6731,0)
 ;;=Z83.2^^30^397^24
 ;;^UTILITY(U,$J,358.3,6731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6731,1,3,0)
 ;;=3^Family Hx of Blood/Immune Mechanism Diseases
 ;;^UTILITY(U,$J,358.3,6731,1,4,0)
 ;;=4^Z83.2
 ;;^UTILITY(U,$J,358.3,6731,2)
 ;;=^5063378
 ;;^UTILITY(U,$J,358.3,6732,0)
 ;;=Z82.71^^30^397^47
 ;;^UTILITY(U,$J,358.3,6732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6732,1,3,0)
 ;;=3^Family Hx of Polycystic Kidney
 ;;^UTILITY(U,$J,358.3,6732,1,4,0)
 ;;=4^Z82.71
 ;;^UTILITY(U,$J,358.3,6732,2)
 ;;=^321531
 ;;^UTILITY(U,$J,358.3,6733,0)
 ;;=Z82.1^^30^397^23
 ;;^UTILITY(U,$J,358.3,6733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6733,1,3,0)
 ;;=3^Family Hx of Blindness/Visual Loss
 ;;^UTILITY(U,$J,358.3,6733,1,4,0)
 ;;=4^Z82.1
 ;;^UTILITY(U,$J,358.3,6733,2)
 ;;=^5063365
 ;;^UTILITY(U,$J,358.3,6734,0)
 ;;=Z82.2^^30^397^27
 ;;^UTILITY(U,$J,358.3,6734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6734,1,3,0)
 ;;=3^Family Hx of Deafness/Hearing Loss
 ;;^UTILITY(U,$J,358.3,6734,1,4,0)
 ;;=4^Z82.2
 ;;^UTILITY(U,$J,358.3,6734,2)
 ;;=^5063366
 ;;^UTILITY(U,$J,358.3,6735,0)
 ;;=Z84.0^^30^397^48
 ;;^UTILITY(U,$J,358.3,6735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6735,1,3,0)
 ;;=3^Family Hx of Skin Diseases
 ;;^UTILITY(U,$J,358.3,6735,1,4,0)
 ;;=4^Z84.0
 ;;^UTILITY(U,$J,358.3,6735,2)
 ;;=^5063388
 ;;^UTILITY(U,$J,358.3,6736,0)
 ;;=Z82.79^^30^397^26
 ;;^UTILITY(U,$J,358.3,6736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6736,1,3,0)
 ;;=3^Family Hx of Congen Malform,Deformations & Chromsoml Abnlt
 ;;^UTILITY(U,$J,358.3,6736,1,4,0)
 ;;=4^Z82.79
 ;;^UTILITY(U,$J,358.3,6736,2)
 ;;=^5063374
 ;;^UTILITY(U,$J,358.3,6737,0)
 ;;=Z84.89^^30^397^46
 ;;^UTILITY(U,$J,358.3,6737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6737,1,3,0)
 ;;=3^Family Hx of Other Spec Conditions
 ;;^UTILITY(U,$J,358.3,6737,1,4,0)
 ;;=4^Z84.89
 ;;^UTILITY(U,$J,358.3,6737,2)
 ;;=^5063393
 ;;^UTILITY(U,$J,358.3,6738,0)
 ;;=Z81.1^^30^397^20
 ;;^UTILITY(U,$J,358.3,6738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6738,1,3,0)
 ;;=3^Family Hx of Alcohol Abuse/Dependence
 ;;^UTILITY(U,$J,358.3,6738,1,4,0)
 ;;=4^Z81.1
 ;;^UTILITY(U,$J,358.3,6738,2)
 ;;=^5063359
 ;;^UTILITY(U,$J,358.3,6739,0)
 ;;=Z82.62^^30^397^45
 ;;^UTILITY(U,$J,358.3,6739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6739,1,3,0)
 ;;=3^Family Hx of Osteoporosis
 ;;^UTILITY(U,$J,358.3,6739,1,4,0)
 ;;=4^Z82.62
 ;;^UTILITY(U,$J,358.3,6739,2)
 ;;=^5063372
 ;;^UTILITY(U,$J,358.3,6740,0)
 ;;=Z83.71^^30^397^25
 ;;^UTILITY(U,$J,358.3,6740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6740,1,3,0)
 ;;=3^Family Hx of Colonic Polyps
 ;;^UTILITY(U,$J,358.3,6740,1,4,0)
 ;;=4^Z83.71
 ;;^UTILITY(U,$J,358.3,6740,2)
 ;;=^5063386
 ;;^UTILITY(U,$J,358.3,6741,0)
 ;;=Z84.81^^30^397^29
