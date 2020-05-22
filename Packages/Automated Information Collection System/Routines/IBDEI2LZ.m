IBDEI2LZ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41661,1,3,0)
 ;;=3^Parkinson's disease
 ;;^UTILITY(U,$J,358.3,41661,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,41661,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,41662,0)
 ;;=G21.4^^155^2061^75
 ;;^UTILITY(U,$J,358.3,41662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41662,1,3,0)
 ;;=3^Vascular parkinsonism
 ;;^UTILITY(U,$J,358.3,41662,1,4,0)
 ;;=4^G21.4
 ;;^UTILITY(U,$J,358.3,41662,2)
 ;;=^5003776
 ;;^UTILITY(U,$J,358.3,41663,0)
 ;;=I69.051^^155^2061^43
 ;;^UTILITY(U,$J,358.3,41663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41663,1,3,0)
 ;;=3^Hemiplga fol ntrm subarach hemor aff right dominant side
 ;;^UTILITY(U,$J,358.3,41663,1,4,0)
 ;;=4^I69.051
 ;;^UTILITY(U,$J,358.3,41663,2)
 ;;=^5007409
 ;;^UTILITY(U,$J,358.3,41664,0)
 ;;=I69.052^^155^2061^41
 ;;^UTILITY(U,$J,358.3,41664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41664,1,3,0)
 ;;=3^Hemiplga fol ntrm subarach hemor aff left dominant side
 ;;^UTILITY(U,$J,358.3,41664,1,4,0)
 ;;=4^I69.052
 ;;^UTILITY(U,$J,358.3,41664,2)
 ;;=^5007410
 ;;^UTILITY(U,$J,358.3,41665,0)
 ;;=I69.053^^155^2061^44
 ;;^UTILITY(U,$J,358.3,41665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41665,1,3,0)
 ;;=3^Hemiplga fol ntrm subarach hemor aff right nondom side
 ;;^UTILITY(U,$J,358.3,41665,1,4,0)
 ;;=4^I69.053
 ;;^UTILITY(U,$J,358.3,41665,2)
 ;;=^5007411
 ;;^UTILITY(U,$J,358.3,41666,0)
 ;;=I69.054^^155^2061^42
 ;;^UTILITY(U,$J,358.3,41666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41666,1,3,0)
 ;;=3^Hemiplga fol ntrm subarach hemor aff left nondom side
 ;;^UTILITY(U,$J,358.3,41666,1,4,0)
 ;;=4^I69.054
 ;;^UTILITY(U,$J,358.3,41666,2)
 ;;=^5007412
 ;;^UTILITY(U,$J,358.3,41667,0)
 ;;=I50.41^^155^2062^1
 ;;^UTILITY(U,$J,358.3,41667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41667,1,3,0)
 ;;=3^Acute combined systolic and diastolic (congestive) hrt fail
 ;;^UTILITY(U,$J,358.3,41667,1,4,0)
 ;;=4^I50.41
 ;;^UTILITY(U,$J,358.3,41667,2)
 ;;=^5007248
 ;;^UTILITY(U,$J,358.3,41668,0)
 ;;=I50.31^^155^2062^2
 ;;^UTILITY(U,$J,358.3,41668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41668,1,3,0)
 ;;=3^Acute diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,41668,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,41668,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,41669,0)
 ;;=I50.43^^155^2062^3
 ;;^UTILITY(U,$J,358.3,41669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41669,1,3,0)
 ;;=3^Acute on chronic combined systolic and diastolic hrt fail
 ;;^UTILITY(U,$J,358.3,41669,1,4,0)
 ;;=4^I50.43
 ;;^UTILITY(U,$J,358.3,41669,2)
 ;;=^5007250
 ;;^UTILITY(U,$J,358.3,41670,0)
 ;;=I50.33^^155^2062^4
 ;;^UTILITY(U,$J,358.3,41670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41670,1,3,0)
 ;;=3^Acute on chronic diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,41670,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,41670,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,41671,0)
 ;;=I50.23^^155^2062^5
 ;;^UTILITY(U,$J,358.3,41671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41671,1,3,0)
 ;;=3^Acute on chronic systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,41671,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,41671,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,41672,0)
 ;;=I50.21^^155^2062^6
 ;;^UTILITY(U,$J,358.3,41672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41672,1,3,0)
 ;;=3^Acute systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,41672,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,41672,2)
 ;;=^5007240
