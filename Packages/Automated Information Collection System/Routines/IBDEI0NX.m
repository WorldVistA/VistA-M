IBDEI0NX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10937,1,3,0)
 ;;=3^Family Hx of Mental/Behavioral Disorders
 ;;^UTILITY(U,$J,358.3,10937,1,4,0)
 ;;=4^Z81.8
 ;;^UTILITY(U,$J,358.3,10937,2)
 ;;=^5063363
 ;;^UTILITY(U,$J,358.3,10938,0)
 ;;=Z82.3^^68^676^49
 ;;^UTILITY(U,$J,358.3,10938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10938,1,3,0)
 ;;=3^Family Hx of Stroke
 ;;^UTILITY(U,$J,358.3,10938,1,4,0)
 ;;=4^Z82.3
 ;;^UTILITY(U,$J,358.3,10938,2)
 ;;=^5063367
 ;;^UTILITY(U,$J,358.3,10939,0)
 ;;=Z82.49^^68^676^31
 ;;^UTILITY(U,$J,358.3,10939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10939,1,3,0)
 ;;=3^Family Hx of Ischemic Heart Disease/Circulatory System
 ;;^UTILITY(U,$J,358.3,10939,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,10939,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,10940,0)
 ;;=Z82.5^^68^676^22
 ;;^UTILITY(U,$J,358.3,10940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10940,1,3,0)
 ;;=3^Family Hx of Asthma/Chronic Lower Respiratory Diseases
 ;;^UTILITY(U,$J,358.3,10940,1,4,0)
 ;;=4^Z82.5
 ;;^UTILITY(U,$J,358.3,10940,2)
 ;;=^5063370
 ;;^UTILITY(U,$J,358.3,10941,0)
 ;;=Z82.61^^68^676^21
 ;;^UTILITY(U,$J,358.3,10941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10941,1,3,0)
 ;;=3^Family Hx of Arthritis
 ;;^UTILITY(U,$J,358.3,10941,1,4,0)
 ;;=4^Z82.61
 ;;^UTILITY(U,$J,358.3,10941,2)
 ;;=^5063371
 ;;^UTILITY(U,$J,358.3,10942,0)
 ;;=Z82.69^^68^676^44
 ;;^UTILITY(U,$J,358.3,10942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10942,1,3,0)
 ;;=3^Family Hx of Musculoskeletal System/Connective Tissue
 ;;^UTILITY(U,$J,358.3,10942,1,4,0)
 ;;=4^Z82.69
 ;;^UTILITY(U,$J,358.3,10942,2)
 ;;=^5063373
 ;;^UTILITY(U,$J,358.3,10943,0)
 ;;=Z83.3^^68^676^28
 ;;^UTILITY(U,$J,358.3,10943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10943,1,3,0)
 ;;=3^Family Hx of Diabetes Mellitus
 ;;^UTILITY(U,$J,358.3,10943,1,4,0)
 ;;=4^Z83.3
 ;;^UTILITY(U,$J,358.3,10943,2)
 ;;=^5063379
 ;;^UTILITY(U,$J,358.3,10944,0)
 ;;=Z83.2^^68^676^24
 ;;^UTILITY(U,$J,358.3,10944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10944,1,3,0)
 ;;=3^Family Hx of Blood/Immune Mechanism Diseases
 ;;^UTILITY(U,$J,358.3,10944,1,4,0)
 ;;=4^Z83.2
 ;;^UTILITY(U,$J,358.3,10944,2)
 ;;=^5063378
 ;;^UTILITY(U,$J,358.3,10945,0)
 ;;=Z82.71^^68^676^47
 ;;^UTILITY(U,$J,358.3,10945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10945,1,3,0)
 ;;=3^Family Hx of Polycystic Kidney
 ;;^UTILITY(U,$J,358.3,10945,1,4,0)
 ;;=4^Z82.71
 ;;^UTILITY(U,$J,358.3,10945,2)
 ;;=^321531
 ;;^UTILITY(U,$J,358.3,10946,0)
 ;;=Z82.1^^68^676^23
 ;;^UTILITY(U,$J,358.3,10946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10946,1,3,0)
 ;;=3^Family Hx of Blindness/Visual Loss
 ;;^UTILITY(U,$J,358.3,10946,1,4,0)
 ;;=4^Z82.1
 ;;^UTILITY(U,$J,358.3,10946,2)
 ;;=^5063365
 ;;^UTILITY(U,$J,358.3,10947,0)
 ;;=Z82.2^^68^676^27
 ;;^UTILITY(U,$J,358.3,10947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10947,1,3,0)
 ;;=3^Family Hx of Deafness/Hearing Loss
 ;;^UTILITY(U,$J,358.3,10947,1,4,0)
 ;;=4^Z82.2
 ;;^UTILITY(U,$J,358.3,10947,2)
 ;;=^5063366
 ;;^UTILITY(U,$J,358.3,10948,0)
 ;;=Z84.0^^68^676^48
 ;;^UTILITY(U,$J,358.3,10948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10948,1,3,0)
 ;;=3^Family Hx of Skin Diseases
 ;;^UTILITY(U,$J,358.3,10948,1,4,0)
 ;;=4^Z84.0
 ;;^UTILITY(U,$J,358.3,10948,2)
 ;;=^5063388
 ;;^UTILITY(U,$J,358.3,10949,0)
 ;;=Z82.79^^68^676^26
 ;;^UTILITY(U,$J,358.3,10949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10949,1,3,0)
 ;;=3^Family Hx of Congen Malform,Deformations & Chromsoml Abnlt
 ;;^UTILITY(U,$J,358.3,10949,1,4,0)
 ;;=4^Z82.79
 ;;^UTILITY(U,$J,358.3,10949,2)
 ;;=^5063374
