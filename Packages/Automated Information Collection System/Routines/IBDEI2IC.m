IBDEI2IC ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40039,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,40040,0)
 ;;=F31.9^^152^2004^6
 ;;^UTILITY(U,$J,358.3,40040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40040,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40040,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,40040,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,40041,0)
 ;;=F31.72^^152^2004^7
 ;;^UTILITY(U,$J,358.3,40041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40041,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,40041,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,40041,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,40042,0)
 ;;=F31.71^^152^2004^5
 ;;^UTILITY(U,$J,358.3,40042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40042,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,40042,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,40042,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,40043,0)
 ;;=F31.70^^152^2004^4
 ;;^UTILITY(U,$J,358.3,40043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40043,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,40043,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,40043,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,40044,0)
 ;;=F29.^^152^2004^25
 ;;^UTILITY(U,$J,358.3,40044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40044,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,40044,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,40044,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,40045,0)
 ;;=F28.^^152^2004^26
 ;;^UTILITY(U,$J,358.3,40045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40045,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond NEC
 ;;^UTILITY(U,$J,358.3,40045,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,40045,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,40046,0)
 ;;=F41.9^^152^2004^3
 ;;^UTILITY(U,$J,358.3,40046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40046,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40046,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,40046,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,40047,0)
 ;;=F45.0^^152^2004^29
 ;;^UTILITY(U,$J,358.3,40047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40047,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,40047,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,40047,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,40048,0)
 ;;=F69.^^152^2004^2
 ;;^UTILITY(U,$J,358.3,40048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40048,1,3,0)
 ;;=3^Adult Personality and Behavior Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40048,1,4,0)
 ;;=4^F69.
 ;;^UTILITY(U,$J,358.3,40048,2)
 ;;=^5003667
 ;;^UTILITY(U,$J,358.3,40049,0)
 ;;=F60.9^^152^2004^23
 ;;^UTILITY(U,$J,358.3,40049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40049,1,3,0)
 ;;=3^Personality Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40049,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,40049,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,40050,0)
 ;;=F32.9^^152^2004^16
 ;;^UTILITY(U,$J,358.3,40050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40050,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,40050,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,40050,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,40051,0)
 ;;=F40.231^^152^2004^12
 ;;^UTILITY(U,$J,358.3,40051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40051,1,3,0)
 ;;=3^Fear of Injections/Transfusions
 ;;^UTILITY(U,$J,358.3,40051,1,4,0)
 ;;=4^F40.231
