IBDEI0OW ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11630,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,11630,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,11630,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,11631,0)
 ;;=G40.909^^47^534^60
 ;;^UTILITY(U,$J,358.3,11631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11631,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,11631,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,11631,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,11632,0)
 ;;=G25.0^^47^534^61
 ;;^UTILITY(U,$J,358.3,11632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11632,1,3,0)
 ;;=3^Essential Tremor
 ;;^UTILITY(U,$J,358.3,11632,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,11632,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,11633,0)
 ;;=G25.9^^47^534^62
 ;;^UTILITY(U,$J,358.3,11633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11633,1,3,0)
 ;;=3^Extrapyramidal/Movement Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11633,1,4,0)
 ;;=4^G25.9
 ;;^UTILITY(U,$J,358.3,11633,2)
 ;;=^5003803
 ;;^UTILITY(U,$J,358.3,11634,0)
 ;;=R29.810^^47^534^63
 ;;^UTILITY(U,$J,358.3,11634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11634,1,3,0)
 ;;=3^Facial Weakness
 ;;^UTILITY(U,$J,358.3,11634,1,4,0)
 ;;=4^R29.810
 ;;^UTILITY(U,$J,358.3,11634,2)
 ;;=^329954
 ;;^UTILITY(U,$J,358.3,11635,0)
 ;;=R25.3^^47^534^64
 ;;^UTILITY(U,$J,358.3,11635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11635,1,3,0)
 ;;=3^Fasciculation
 ;;^UTILITY(U,$J,358.3,11635,1,4,0)
 ;;=4^R25.3
 ;;^UTILITY(U,$J,358.3,11635,2)
 ;;=^44985
 ;;^UTILITY(U,$J,358.3,11636,0)
 ;;=R26.9^^47^534^65
 ;;^UTILITY(U,$J,358.3,11636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11636,1,3,0)
 ;;=3^Gait/Mobility Abnormalities,Unspec
 ;;^UTILITY(U,$J,358.3,11636,1,4,0)
 ;;=4^R26.9
 ;;^UTILITY(U,$J,358.3,11636,2)
 ;;=^5019309
 ;;^UTILITY(U,$J,358.3,11637,0)
 ;;=R51.^^47^534^66
 ;;^UTILITY(U,$J,358.3,11637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11637,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,11637,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,11637,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,11638,0)
 ;;=G81.92^^47^534^67
 ;;^UTILITY(U,$J,358.3,11638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11638,1,3,0)
 ;;=3^Hemiplegia,Affecting Lt Dominant Side,Unspec
 ;;^UTILITY(U,$J,358.3,11638,1,4,0)
 ;;=4^G81.92
 ;;^UTILITY(U,$J,358.3,11638,2)
 ;;=^5004122
 ;;^UTILITY(U,$J,358.3,11639,0)
 ;;=G81.94^^47^534^68
 ;;^UTILITY(U,$J,358.3,11639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11639,1,3,0)
 ;;=3^Hemiplegia,Affecting Lt Nondominant Side
 ;;^UTILITY(U,$J,358.3,11639,1,4,0)
 ;;=4^G81.94
 ;;^UTILITY(U,$J,358.3,11639,2)
 ;;=^5004124
 ;;^UTILITY(U,$J,358.3,11640,0)
 ;;=G81.91^^47^534^69
 ;;^UTILITY(U,$J,358.3,11640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11640,1,3,0)
 ;;=3^Hemiplegia,Affecting Rt Dominant Side,Unspec
 ;;^UTILITY(U,$J,358.3,11640,1,4,0)
 ;;=4^G81.91
 ;;^UTILITY(U,$J,358.3,11640,2)
 ;;=^5004121
 ;;^UTILITY(U,$J,358.3,11641,0)
 ;;=G81.93^^47^534^70
 ;;^UTILITY(U,$J,358.3,11641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11641,1,3,0)
 ;;=3^Hemiplegia,Affecting Rt Nondominant Side
 ;;^UTILITY(U,$J,358.3,11641,1,4,0)
 ;;=4^G81.93
 ;;^UTILITY(U,$J,358.3,11641,2)
 ;;=^5004123
 ;;^UTILITY(U,$J,358.3,11642,0)
 ;;=G10.^^47^534^71
 ;;^UTILITY(U,$J,358.3,11642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11642,1,3,0)
 ;;=3^Huntington's Disease
 ;;^UTILITY(U,$J,358.3,11642,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,11642,2)
 ;;=^5003751
 ;;^UTILITY(U,$J,358.3,11643,0)
 ;;=G91.2^^47^534^72
 ;;^UTILITY(U,$J,358.3,11643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11643,1,3,0)
 ;;=3^Hydrocephalus,Idiopathic,Normal Pressure
