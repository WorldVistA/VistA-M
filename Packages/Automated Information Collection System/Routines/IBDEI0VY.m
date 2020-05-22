IBDEI0VY ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14223,1,3,0)
 ;;=3^Fasciculation
 ;;^UTILITY(U,$J,358.3,14223,1,4,0)
 ;;=4^R25.3
 ;;^UTILITY(U,$J,358.3,14223,2)
 ;;=^44985
 ;;^UTILITY(U,$J,358.3,14224,0)
 ;;=R26.9^^83^822^76
 ;;^UTILITY(U,$J,358.3,14224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14224,1,3,0)
 ;;=3^Gait/Mobility Abnormalities,Unspec
 ;;^UTILITY(U,$J,358.3,14224,1,4,0)
 ;;=4^R26.9
 ;;^UTILITY(U,$J,358.3,14224,2)
 ;;=^5019309
 ;;^UTILITY(U,$J,358.3,14225,0)
 ;;=R51.^^83^822^77
 ;;^UTILITY(U,$J,358.3,14225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14225,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,14225,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,14225,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,14226,0)
 ;;=G81.92^^83^822^78
 ;;^UTILITY(U,$J,358.3,14226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14226,1,3,0)
 ;;=3^Hemiplegia,Affecting Lt Dominant Side,Unspec
 ;;^UTILITY(U,$J,358.3,14226,1,4,0)
 ;;=4^G81.92
 ;;^UTILITY(U,$J,358.3,14226,2)
 ;;=^5004122
 ;;^UTILITY(U,$J,358.3,14227,0)
 ;;=G81.94^^83^822^79
 ;;^UTILITY(U,$J,358.3,14227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14227,1,3,0)
 ;;=3^Hemiplegia,Affecting Lt Nondominant Side
 ;;^UTILITY(U,$J,358.3,14227,1,4,0)
 ;;=4^G81.94
 ;;^UTILITY(U,$J,358.3,14227,2)
 ;;=^5004124
 ;;^UTILITY(U,$J,358.3,14228,0)
 ;;=G81.91^^83^822^80
 ;;^UTILITY(U,$J,358.3,14228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14228,1,3,0)
 ;;=3^Hemiplegia,Affecting Rt Dominant Side,Unspec
 ;;^UTILITY(U,$J,358.3,14228,1,4,0)
 ;;=4^G81.91
 ;;^UTILITY(U,$J,358.3,14228,2)
 ;;=^5004121
 ;;^UTILITY(U,$J,358.3,14229,0)
 ;;=G81.93^^83^822^81
 ;;^UTILITY(U,$J,358.3,14229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14229,1,3,0)
 ;;=3^Hemiplegia,Affecting Rt Nondominant Side
 ;;^UTILITY(U,$J,358.3,14229,1,4,0)
 ;;=4^G81.93
 ;;^UTILITY(U,$J,358.3,14229,2)
 ;;=^5004123
 ;;^UTILITY(U,$J,358.3,14230,0)
 ;;=G10.^^83^822^82
 ;;^UTILITY(U,$J,358.3,14230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14230,1,3,0)
 ;;=3^Huntington's Disease
 ;;^UTILITY(U,$J,358.3,14230,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,14230,2)
 ;;=^5003751
 ;;^UTILITY(U,$J,358.3,14231,0)
 ;;=G91.2^^83^822^83
 ;;^UTILITY(U,$J,358.3,14231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14231,1,3,0)
 ;;=3^Hydrocephalus,Idiopathic,Normal Pressure
 ;;^UTILITY(U,$J,358.3,14231,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,14231,2)
 ;;=^5004174
 ;;^UTILITY(U,$J,358.3,14232,0)
 ;;=G91.9^^83^822^84
 ;;^UTILITY(U,$J,358.3,14232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14232,1,3,0)
 ;;=3^Hydrocephalus,Unspec
 ;;^UTILITY(U,$J,358.3,14232,1,4,0)
 ;;=4^G91.9
 ;;^UTILITY(U,$J,358.3,14232,2)
 ;;=^5004178
 ;;^UTILITY(U,$J,358.3,14233,0)
 ;;=R25.9^^83^822^85
 ;;^UTILITY(U,$J,358.3,14233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14233,1,3,0)
 ;;=3^Involuntary Movements,Abnormal,Unspec
 ;;^UTILITY(U,$J,358.3,14233,1,4,0)
 ;;=4^R25.9
 ;;^UTILITY(U,$J,358.3,14233,2)
 ;;=^5019303
 ;;^UTILITY(U,$J,358.3,14234,0)
 ;;=G43.911^^83^822^89
 ;;^UTILITY(U,$J,358.3,14234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14234,1,3,0)
 ;;=3^Migraine,Intractable w/ Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,14234,1,4,0)
 ;;=4^G43.911
 ;;^UTILITY(U,$J,358.3,14234,2)
 ;;=^5003910
 ;;^UTILITY(U,$J,358.3,14235,0)
 ;;=G43.919^^83^822^90
 ;;^UTILITY(U,$J,358.3,14235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14235,1,3,0)
 ;;=3^Migraine,Intractable w/o Status Migrainosus,Unspec
