IBDEI0GL ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7189,1,3,0)
 ;;=3^BMI 50.0-59.9
 ;;^UTILITY(U,$J,358.3,7189,1,4,0)
 ;;=4^Z68.43
 ;;^UTILITY(U,$J,358.3,7189,2)
 ;;=^5063221
 ;;^UTILITY(U,$J,358.3,7190,0)
 ;;=Z68.44^^58^471^24
 ;;^UTILITY(U,$J,358.3,7190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7190,1,3,0)
 ;;=3^BMI 60.0-69.9
 ;;^UTILITY(U,$J,358.3,7190,1,4,0)
 ;;=4^Z68.44
 ;;^UTILITY(U,$J,358.3,7190,2)
 ;;=^5063222
 ;;^UTILITY(U,$J,358.3,7191,0)
 ;;=Z68.45^^58^471^25
 ;;^UTILITY(U,$J,358.3,7191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7191,1,3,0)
 ;;=3^BMI 70 or Over
 ;;^UTILITY(U,$J,358.3,7191,1,4,0)
 ;;=4^Z68.45
 ;;^UTILITY(U,$J,358.3,7191,2)
 ;;=^5063223
 ;;^UTILITY(U,$J,358.3,7192,0)
 ;;=Z71.82^^58^471^26
 ;;^UTILITY(U,$J,358.3,7192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7192,1,3,0)
 ;;=3^Exercise Counseling
 ;;^UTILITY(U,$J,358.3,7192,1,4,0)
 ;;=4^Z71.82
 ;;^UTILITY(U,$J,358.3,7192,2)
 ;;=^303466
 ;;^UTILITY(U,$J,358.3,7193,0)
 ;;=F20.3^^58^472^31
 ;;^UTILITY(U,$J,358.3,7193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7193,1,3,0)
 ;;=3^Undifferentiated/Atypical Schizophrenia
 ;;^UTILITY(U,$J,358.3,7193,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,7193,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,7194,0)
 ;;=F20.9^^58^472^27
 ;;^UTILITY(U,$J,358.3,7194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7194,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,7194,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,7194,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,7195,0)
 ;;=F31.9^^58^472^6
 ;;^UTILITY(U,$J,358.3,7195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7195,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,7195,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,7195,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,7196,0)
 ;;=F31.72^^58^472^7
 ;;^UTILITY(U,$J,358.3,7196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7196,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,7196,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,7196,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,7197,0)
 ;;=F31.71^^58^472^5
 ;;^UTILITY(U,$J,358.3,7197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7197,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,7197,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,7197,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,7198,0)
 ;;=F31.70^^58^472^4
 ;;^UTILITY(U,$J,358.3,7198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7198,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,7198,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,7198,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,7199,0)
 ;;=F29.^^58^472^25
 ;;^UTILITY(U,$J,358.3,7199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7199,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,7199,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,7199,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,7200,0)
 ;;=F28.^^58^472^26
 ;;^UTILITY(U,$J,358.3,7200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7200,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond NEC
 ;;^UTILITY(U,$J,358.3,7200,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,7200,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,7201,0)
 ;;=F41.9^^58^472^3
 ;;^UTILITY(U,$J,358.3,7201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7201,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,7201,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,7201,2)
 ;;=^5003567
