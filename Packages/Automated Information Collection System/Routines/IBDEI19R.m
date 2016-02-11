IBDEI19R ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21219,1,3,0)
 ;;=3^Monoplg low lmb fol oth ntrm intcrn hemor aff l nondom side
 ;;^UTILITY(U,$J,358.3,21219,1,4,0)
 ;;=4^I69.244
 ;;^UTILITY(U,$J,358.3,21219,2)
 ;;=^5007471
 ;;^UTILITY(U,$J,358.3,21220,0)
 ;;=G35.^^101^1027^78
 ;;^UTILITY(U,$J,358.3,21220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21220,1,3,0)
 ;;=3^Multiple sclerosis
 ;;^UTILITY(U,$J,358.3,21220,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,21220,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,21221,0)
 ;;=G20.^^101^1027^79
 ;;^UTILITY(U,$J,358.3,21221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21221,1,3,0)
 ;;=3^Parkinson's disease
 ;;^UTILITY(U,$J,358.3,21221,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,21221,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,21222,0)
 ;;=G21.4^^101^1027^80
 ;;^UTILITY(U,$J,358.3,21222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21222,1,3,0)
 ;;=3^Vascular parkinsonism
 ;;^UTILITY(U,$J,358.3,21222,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,21222,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,21223,0)
 ;;=I69.051^^101^1027^48
 ;;^UTILITY(U,$J,358.3,21223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21223,1,3,0)
 ;;=3^Hemiplga fol ntrm subarach hemor aff right dominant side
 ;;^UTILITY(U,$J,358.3,21223,1,4,0)
 ;;=4^I69.051
 ;;^UTILITY(U,$J,358.3,21223,2)
 ;;=^5007409
 ;;^UTILITY(U,$J,358.3,21224,0)
 ;;=I69.052^^101^1027^46
 ;;^UTILITY(U,$J,358.3,21224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21224,1,3,0)
 ;;=3^Hemiplga fol ntrm subarach hemor aff left dominant side
 ;;^UTILITY(U,$J,358.3,21224,1,4,0)
 ;;=4^I69.052
 ;;^UTILITY(U,$J,358.3,21224,2)
 ;;=^5007410
 ;;^UTILITY(U,$J,358.3,21225,0)
 ;;=I69.053^^101^1027^49
 ;;^UTILITY(U,$J,358.3,21225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21225,1,3,0)
 ;;=3^Hemiplga fol ntrm subarach hemor aff right nondom side
 ;;^UTILITY(U,$J,358.3,21225,1,4,0)
 ;;=4^I69.053
 ;;^UTILITY(U,$J,358.3,21225,2)
 ;;=^5007411
 ;;^UTILITY(U,$J,358.3,21226,0)
 ;;=I69.054^^101^1027^47
 ;;^UTILITY(U,$J,358.3,21226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21226,1,3,0)
 ;;=3^Hemiplga fol ntrm subarach hemor aff left nondom side
 ;;^UTILITY(U,$J,358.3,21226,1,4,0)
 ;;=4^I69.054
 ;;^UTILITY(U,$J,358.3,21226,2)
 ;;=^5007412
 ;;^UTILITY(U,$J,358.3,21227,0)
 ;;=I50.41^^101^1028^1
 ;;^UTILITY(U,$J,358.3,21227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21227,1,3,0)
 ;;=3^Acute combined systolic and diastolic (congestive) hrt fail
 ;;^UTILITY(U,$J,358.3,21227,1,4,0)
 ;;=4^I50.41
 ;;^UTILITY(U,$J,358.3,21227,2)
 ;;=^5007248
 ;;^UTILITY(U,$J,358.3,21228,0)
 ;;=I50.31^^101^1028^2
 ;;^UTILITY(U,$J,358.3,21228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21228,1,3,0)
 ;;=3^Acute diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,21228,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,21228,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,21229,0)
 ;;=I50.43^^101^1028^3
 ;;^UTILITY(U,$J,358.3,21229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21229,1,3,0)
 ;;=3^Acute on chronic combined systolic and diastolic hrt fail
 ;;^UTILITY(U,$J,358.3,21229,1,4,0)
 ;;=4^I50.43
 ;;^UTILITY(U,$J,358.3,21229,2)
 ;;=^5007250
 ;;^UTILITY(U,$J,358.3,21230,0)
 ;;=I50.33^^101^1028^4
 ;;^UTILITY(U,$J,358.3,21230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21230,1,3,0)
 ;;=3^Acute on chronic diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,21230,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,21230,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,21231,0)
 ;;=I50.23^^101^1028^5
 ;;^UTILITY(U,$J,358.3,21231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21231,1,3,0)
 ;;=3^Acute on chronic systolic (congestive) heart failure
