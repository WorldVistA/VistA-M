IBDEI1CS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23000,1,3,0)
 ;;=3^Osteopenia,Unspec Site
 ;;^UTILITY(U,$J,358.3,23000,1,4,0)
 ;;=4^M85.80
 ;;^UTILITY(U,$J,358.3,23000,2)
 ;;=^5014473
 ;;^UTILITY(U,$J,358.3,23001,0)
 ;;=B02.0^^87^988^46
 ;;^UTILITY(U,$J,358.3,23001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23001,1,3,0)
 ;;=3^Zoster Encephalitis
 ;;^UTILITY(U,$J,358.3,23001,1,4,0)
 ;;=4^B02.0
 ;;^UTILITY(U,$J,358.3,23001,2)
 ;;=^5000488
 ;;^UTILITY(U,$J,358.3,23002,0)
 ;;=B02.29^^87^988^36
 ;;^UTILITY(U,$J,358.3,23002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23002,1,3,0)
 ;;=3^Postherpetic Nervous System Involvement,Other
 ;;^UTILITY(U,$J,358.3,23002,1,4,0)
 ;;=4^B02.29
 ;;^UTILITY(U,$J,358.3,23002,2)
 ;;=^5000492
 ;;^UTILITY(U,$J,358.3,23003,0)
 ;;=F03.90^^87^988^10
 ;;^UTILITY(U,$J,358.3,23003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23003,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,23003,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,23003,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,23004,0)
 ;;=F03.91^^87^988^9
 ;;^UTILITY(U,$J,358.3,23004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23004,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,23004,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,23004,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,23005,0)
 ;;=F01.50^^87^988^12
 ;;^UTILITY(U,$J,358.3,23005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23005,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,23005,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,23005,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,23006,0)
 ;;=F10.27^^87^988^11
 ;;^UTILITY(U,$J,358.3,23006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23006,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,23006,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,23006,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,23007,0)
 ;;=F06.1^^87^988^6
 ;;^UTILITY(U,$J,358.3,23007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23007,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,23007,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,23007,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,23008,0)
 ;;=F06.8^^87^988^21
 ;;^UTILITY(U,$J,358.3,23008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23008,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,23008,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,23008,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,23009,0)
 ;;=F06.0^^87^988^37
 ;;^UTILITY(U,$J,358.3,23009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23009,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucin d/t Known Physiol Condition
 ;;^UTILITY(U,$J,358.3,23009,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,23009,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,23010,0)
 ;;=G44.209^^87^988^42
 ;;^UTILITY(U,$J,358.3,23010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23010,1,3,0)
 ;;=3^Tension-Type Headache,Not Intractable,Unspec
 ;;^UTILITY(U,$J,358.3,23010,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,23010,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,23011,0)
 ;;=F09.^^87^988^20
 ;;^UTILITY(U,$J,358.3,23011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23011,1,3,0)
 ;;=3^Mental Disorder d/t Known Physiological Condition,Unspec
 ;;^UTILITY(U,$J,358.3,23011,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,23011,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,23012,0)
 ;;=F07.9^^87^988^35
 ;;^UTILITY(U,$J,358.3,23012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23012,1,3,0)
 ;;=3^Personality & Behavrl Disorder d/t Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,23012,1,4,0)
 ;;=4^F07.9
