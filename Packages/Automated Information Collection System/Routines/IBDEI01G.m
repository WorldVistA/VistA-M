IBDEI01G ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,147,0)
 ;;=294.11^^3^27^10
 ;;^UTILITY(U,$J,358.3,147,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,147,1,2,0)
 ;;=2^294.11
 ;;^UTILITY(U,$J,358.3,147,1,5,0)
 ;;=5^Dementia d/t HIV w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,147,2)
 ;;=^321982^042.
 ;;^UTILITY(U,$J,358.3,148,0)
 ;;=294.20^^3^27^8
 ;;^UTILITY(U,$J,358.3,148,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,148,1,2,0)
 ;;=2^294.20
 ;;^UTILITY(U,$J,358.3,148,1,5,0)
 ;;=5^Dementia NOS w/o Behv Dstrb
 ;;^UTILITY(U,$J,358.3,148,2)
 ;;=^340607
 ;;^UTILITY(U,$J,358.3,149,0)
 ;;=294.21^^3^27^7
 ;;^UTILITY(U,$J,358.3,149,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,149,1,2,0)
 ;;=2^294.21
 ;;^UTILITY(U,$J,358.3,149,1,5,0)
 ;;=5^Dementia NOS w/Behav Distrb
 ;;^UTILITY(U,$J,358.3,149,2)
 ;;=^340505
 ;;^UTILITY(U,$J,358.3,150,0)
 ;;=331.83^^3^27^18
 ;;^UTILITY(U,$J,358.3,150,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,150,1,2,0)
 ;;=2^331.83
 ;;^UTILITY(U,$J,358.3,150,1,5,0)
 ;;=5^Mild Cognitive Impairment
 ;;^UTILITY(U,$J,358.3,150,2)
 ;;=^334065
 ;;^UTILITY(U,$J,358.3,151,0)
 ;;=294.8^^3^27^9
 ;;^UTILITY(U,$J,358.3,151,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,151,1,2,0)
 ;;=2^294.8
 ;;^UTILITY(U,$J,358.3,151,1,5,0)
 ;;=5^Dementia d/t Brain Tumor
 ;;^UTILITY(U,$J,358.3,151,2)
 ;;=^331843
 ;;^UTILITY(U,$J,358.3,152,0)
 ;;=294.10^^3^27^11
 ;;^UTILITY(U,$J,358.3,152,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,152,1,2,0)
 ;;=2^294.10
 ;;^UTILITY(U,$J,358.3,152,1,5,0)
 ;;=5^Dementia d/t HIV w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,152,2)
 ;;=^321980^042.
 ;;^UTILITY(U,$J,358.3,153,0)
 ;;=294.11^^3^27^3
 ;;^UTILITY(U,$J,358.3,153,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,153,1,2,0)
 ;;=2^294.11
 ;;^UTILITY(U,$J,358.3,153,1,5,0)
 ;;=5^Alzheimers Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,153,2)
 ;;=^321982^331.0
 ;;^UTILITY(U,$J,358.3,154,0)
 ;;=294.10^^3^27^5
 ;;^UTILITY(U,$J,358.3,154,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,154,1,2,0)
 ;;=2^294.10
 ;;^UTILITY(U,$J,358.3,154,1,5,0)
 ;;=5^Alzheimers Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,154,2)
 ;;=^321980^331.0
 ;;^UTILITY(U,$J,358.3,155,0)
 ;;=294.10^^3^27^15
 ;;^UTILITY(U,$J,358.3,155,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,155,1,2,0)
 ;;=2^294.10
 ;;^UTILITY(U,$J,358.3,155,1,5,0)
 ;;=5^Dementia d/t Parkinson w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,155,2)
 ;;=^321980^332.0
 ;;^UTILITY(U,$J,358.3,156,0)
 ;;=294.11^^3^27^14
 ;;^UTILITY(U,$J,358.3,156,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,156,1,2,0)
 ;;=2^294.11
 ;;^UTILITY(U,$J,358.3,156,1,5,0)
 ;;=5^Dementia d/t Parkinson w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,156,2)
 ;;=^321982^332.0
 ;;^UTILITY(U,$J,358.3,157,0)
 ;;=294.11^^3^27^12
 ;;^UTILITY(U,$J,358.3,157,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,157,1,2,0)
 ;;=2^294.11
 ;;^UTILITY(U,$J,358.3,157,1,5,0)
 ;;=5^Dementia d/t MS w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,157,2)
 ;;=^321982^340.
 ;;^UTILITY(U,$J,358.3,158,0)
 ;;=294.10^^3^27^13
 ;;^UTILITY(U,$J,358.3,158,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,158,1,2,0)
 ;;=2^294.10
 ;;^UTILITY(U,$J,358.3,158,1,5,0)
 ;;=5^Dementia d/t MS w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,158,2)
 ;;=^321980^340.
 ;;^UTILITY(U,$J,358.3,159,0)
 ;;=293.0^^3^28^1
 ;;^UTILITY(U,$J,358.3,159,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,159,1,2,0)
 ;;=2^293.0
 ;;^UTILITY(U,$J,358.3,159,1,5,0)
 ;;=5^Acute Delirium
 ;;^UTILITY(U,$J,358.3,159,2)
 ;;=Acute Delirium^268035
 ;;^UTILITY(U,$J,358.3,160,0)
 ;;=291.0^^3^28^3
 ;;^UTILITY(U,$J,358.3,160,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,160,1,2,0)
 ;;=2^291.0
