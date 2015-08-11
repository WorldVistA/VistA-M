IBDEI01F ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,132,1,5,0)
 ;;=5^Alc Ind Psych d/o w/ Delusions
 ;;^UTILITY(U,$J,358.3,132,2)
 ;;=^331826
 ;;^UTILITY(U,$J,358.3,133,0)
 ;;=291.81^^3^25^4
 ;;^UTILITY(U,$J,358.3,133,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,133,1,2,0)
 ;;=2^291.81
 ;;^UTILITY(U,$J,358.3,133,1,5,0)
 ;;=5^Alcohol Withdrawal
 ;;^UTILITY(U,$J,358.3,133,2)
 ;;=^123498
 ;;^UTILITY(U,$J,358.3,134,0)
 ;;=310.1^^3^26^7
 ;;^UTILITY(U,$J,358.3,134,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,134,1,2,0)
 ;;=2^310.1
 ;;^UTILITY(U,$J,358.3,134,1,5,0)
 ;;=5^Personality Syndrome
 ;;^UTILITY(U,$J,358.3,134,2)
 ;;=^268318
 ;;^UTILITY(U,$J,358.3,135,0)
 ;;=293.81^^3^26^4
 ;;^UTILITY(U,$J,358.3,135,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,135,1,2,0)
 ;;=2^293.81
 ;;^UTILITY(U,$J,358.3,135,1,5,0)
 ;;=5^Delusional Syndrome
 ;;^UTILITY(U,$J,358.3,135,2)
 ;;=^259055
 ;;^UTILITY(U,$J,358.3,136,0)
 ;;=294.9^^3^26^3
 ;;^UTILITY(U,$J,358.3,136,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,136,1,2,0)
 ;;=2^294.9
 ;;^UTILITY(U,$J,358.3,136,1,5,0)
 ;;=5^Cognitive Disorder, NOS
 ;;^UTILITY(U,$J,358.3,136,2)
 ;;=^123962
 ;;^UTILITY(U,$J,358.3,137,0)
 ;;=293.84^^3^26^2
 ;;^UTILITY(U,$J,358.3,137,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,137,1,2,0)
 ;;=2^293.84
 ;;^UTILITY(U,$J,358.3,137,1,5,0)
 ;;=5^Anxiety Syndrome
 ;;^UTILITY(U,$J,358.3,137,2)
 ;;=^304299
 ;;^UTILITY(U,$J,358.3,138,0)
 ;;=293.89^^3^26^1
 ;;^UTILITY(U,$J,358.3,138,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,138,1,2,0)
 ;;=2^293.89
 ;;^UTILITY(U,$J,358.3,138,1,5,0)
 ;;=5^Affective Syndrome
 ;;^UTILITY(U,$J,358.3,138,2)
 ;;=^331840
 ;;^UTILITY(U,$J,358.3,139,0)
 ;;=310.89^^3^26^6
 ;;^UTILITY(U,$J,358.3,139,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,139,1,2,0)
 ;;=2^310.89
 ;;^UTILITY(U,$J,358.3,139,1,5,0)
 ;;=5^Oth Non Psychotic Mental Disord NEC
 ;;^UTILITY(U,$J,358.3,139,2)
 ;;=^268320
 ;;^UTILITY(U,$J,358.3,140,0)
 ;;=293.82^^3^26^5
 ;;^UTILITY(U,$J,358.3,140,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,140,1,2,0)
 ;;=2^293.82
 ;;^UTILITY(U,$J,358.3,140,1,5,0)
 ;;=5^Hallucinosis
 ;;^UTILITY(U,$J,358.3,140,2)
 ;;=^331837
 ;;^UTILITY(U,$J,358.3,141,0)
 ;;=290.20^^3^27^17
 ;;^UTILITY(U,$J,358.3,141,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,141,1,2,0)
 ;;=2^290.20
 ;;^UTILITY(U,$J,358.3,141,1,5,0)
 ;;=5^Dementia w/Delusion
 ;;^UTILITY(U,$J,358.3,141,2)
 ;;=^303486
 ;;^UTILITY(U,$J,358.3,142,0)
 ;;=290.40^^3^27^20
 ;;^UTILITY(U,$J,358.3,142,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,142,1,2,0)
 ;;=2^290.40
 ;;^UTILITY(U,$J,358.3,142,1,5,0)
 ;;=5^Vascular Dementia
 ;;^UTILITY(U,$J,358.3,142,2)
 ;;=^303487
 ;;^UTILITY(U,$J,358.3,143,0)
 ;;=291.2^^3^27^1
 ;;^UTILITY(U,$J,358.3,143,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,143,1,2,0)
 ;;=2^291.2
 ;;^UTILITY(U,$J,358.3,143,1,5,0)
 ;;=5^Alcoholic Dementia
 ;;^UTILITY(U,$J,358.3,143,2)
 ;;=Alcoholic Dementia^268015
 ;;^UTILITY(U,$J,358.3,144,0)
 ;;=290.0^^3^27^19
 ;;^UTILITY(U,$J,358.3,144,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,144,1,2,0)
 ;;=2^290.0
 ;;^UTILITY(U,$J,358.3,144,1,5,0)
 ;;=5^Senile Dementia, Uncomplicated
 ;;^UTILITY(U,$J,358.3,144,2)
 ;;=^31700
 ;;^UTILITY(U,$J,358.3,145,0)
 ;;=290.3^^3^27^16
 ;;^UTILITY(U,$J,358.3,145,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,145,1,2,0)
 ;;=2^290.3
 ;;^UTILITY(U,$J,358.3,145,1,5,0)
 ;;=5^Dementia w/Delirium
 ;;^UTILITY(U,$J,358.3,145,2)
 ;;=^268009
 ;;^UTILITY(U,$J,358.3,146,0)
 ;;=294.8^^3^27^6
 ;;^UTILITY(U,$J,358.3,146,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,146,1,2,0)
 ;;=2^294.8
 ;;^UTILITY(U,$J,358.3,146,1,5,0)
 ;;=5^Dementia NOS
 ;;^UTILITY(U,$J,358.3,146,2)
 ;;=^331843
