IBDEI0X6 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14948,1,4,0)
 ;;=4^S02.111S
 ;;^UTILITY(U,$J,358.3,14948,2)
 ;;=^5020275
 ;;^UTILITY(U,$J,358.3,14949,0)
 ;;=S02.112S^^58^712^46
 ;;^UTILITY(U,$J,358.3,14949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14949,1,3,0)
 ;;=3^Type III occipital condyle fracture, sequela
 ;;^UTILITY(U,$J,358.3,14949,1,4,0)
 ;;=4^S02.112S
 ;;^UTILITY(U,$J,358.3,14949,2)
 ;;=^5020281
 ;;^UTILITY(U,$J,358.3,14950,0)
 ;;=S02.402S^^58^712^47
 ;;^UTILITY(U,$J,358.3,14950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14950,1,3,0)
 ;;=3^Zygomatic fracture, unspecified, sequela
 ;;^UTILITY(U,$J,358.3,14950,1,4,0)
 ;;=4^S02.402S
 ;;^UTILITY(U,$J,358.3,14950,2)
 ;;=^5020335
 ;;^UTILITY(U,$J,358.3,14951,0)
 ;;=F10.20^^58^713^1
 ;;^UTILITY(U,$J,358.3,14951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14951,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,14951,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,14951,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,14952,0)
 ;;=F31.10^^58^713^2
 ;;^UTILITY(U,$J,358.3,14952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14952,1,3,0)
 ;;=3^Bipolar disord, crnt episode manic w/o psych features, unsp
 ;;^UTILITY(U,$J,358.3,14952,1,4,0)
 ;;=4^F31.10
 ;;^UTILITY(U,$J,358.3,14952,2)
 ;;=^5003495
 ;;^UTILITY(U,$J,358.3,14953,0)
 ;;=F32.9^^58^713^14
 ;;^UTILITY(U,$J,358.3,14953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14953,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,14953,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,14953,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,14954,0)
 ;;=F20.0^^58^713^15
 ;;^UTILITY(U,$J,358.3,14954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14954,1,3,0)
 ;;=3^Paranoid schizophrenia
 ;;^UTILITY(U,$J,358.3,14954,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,14954,2)
 ;;=^5003469
 ;;^UTILITY(U,$J,358.3,14955,0)
 ;;=F06.0^^58^713^16
 ;;^UTILITY(U,$J,358.3,14955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14955,1,3,0)
 ;;=3^Psychotic disorder w hallucin due to known physiol condition
 ;;^UTILITY(U,$J,358.3,14955,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,14955,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,14956,0)
 ;;=F20.9^^58^713^20
 ;;^UTILITY(U,$J,358.3,14956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14956,1,3,0)
 ;;=3^Schizophrenia, unspecified
 ;;^UTILITY(U,$J,358.3,14956,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,14956,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,14957,0)
 ;;=F03.91^^58^713^3
 ;;^UTILITY(U,$J,358.3,14957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14957,1,3,0)
 ;;=3^Dementia with behavioral disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,14957,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,14957,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,14958,0)
 ;;=F03.90^^58^713^4
 ;;^UTILITY(U,$J,358.3,14958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14958,1,3,0)
 ;;=3^Dementia without behavioral disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,14958,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,14958,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,14959,0)
 ;;=F33.0^^58^713^6
 ;;^UTILITY(U,$J,358.3,14959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14959,1,3,0)
 ;;=3^MDD,Recurrent,Mild
 ;;^UTILITY(U,$J,358.3,14959,1,4,0)
 ;;=4^F33.0
 ;;^UTILITY(U,$J,358.3,14959,2)
 ;;=^5003529
 ;;^UTILITY(U,$J,358.3,14960,0)
 ;;=F33.1^^58^713^7
 ;;^UTILITY(U,$J,358.3,14960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14960,1,3,0)
 ;;=3^MDD,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,14960,1,4,0)
 ;;=4^F33.1
