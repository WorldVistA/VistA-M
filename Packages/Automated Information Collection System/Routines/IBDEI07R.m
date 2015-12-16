IBDEI07R ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3129,1,4,0)
 ;;=4^G24.01
 ;;^UTILITY(U,$J,358.3,3129,2)
 ;;=^5003784
 ;;^UTILITY(U,$J,358.3,3130,0)
 ;;=G24.09^^8^96^8
 ;;^UTILITY(U,$J,358.3,3130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3130,1,3,0)
 ;;=3^Tardive Dystonia
 ;;^UTILITY(U,$J,358.3,3130,1,4,0)
 ;;=4^G24.09
 ;;^UTILITY(U,$J,358.3,3130,2)
 ;;=^5003786
 ;;^UTILITY(U,$J,358.3,3131,0)
 ;;=G25.1^^8^96^4
 ;;^UTILITY(U,$J,358.3,3131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3131,1,3,0)
 ;;=3^Medication-Induced Postural Tremor
 ;;^UTILITY(U,$J,358.3,3131,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,3131,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,3132,0)
 ;;=G25.71^^8^96^6
 ;;^UTILITY(U,$J,358.3,3132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3132,1,3,0)
 ;;=3^Tardive Akathisia/Medication-Induced Acute Akatisia
 ;;^UTILITY(U,$J,358.3,3132,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,3132,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,3133,0)
 ;;=G25.79^^8^96^2
 ;;^UTILITY(U,$J,358.3,3133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3133,1,3,0)
 ;;=3^Medication-Induced Movement Disorder NEC
 ;;^UTILITY(U,$J,358.3,3133,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,3133,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,3134,0)
 ;;=F42.^^8^97^5
 ;;^UTILITY(U,$J,358.3,3134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3134,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,3134,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,3134,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,3135,0)
 ;;=F45.22^^8^97^1
 ;;^UTILITY(U,$J,358.3,3135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3135,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,3135,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,3135,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,3136,0)
 ;;=F63.3^^8^97^6
 ;;^UTILITY(U,$J,358.3,3136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3136,1,3,0)
 ;;=3^Trichotillomania
 ;;^UTILITY(U,$J,358.3,3136,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,3136,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,3137,0)
 ;;=L98.1^^8^97^2
 ;;^UTILITY(U,$J,358.3,3137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3137,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,3137,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,3137,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,3138,0)
 ;;=F63.0^^8^97^4
 ;;^UTILITY(U,$J,358.3,3138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3138,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,3138,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,3138,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,3139,0)
 ;;=F68.10^^8^97^3
 ;;^UTILITY(U,$J,358.3,3139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3139,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,3139,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,3139,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,3140,0)
 ;;=F06.2^^8^98^5
 ;;^UTILITY(U,$J,358.3,3140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3140,1,3,0)
 ;;=3^Psychotic Disorder w/ Delusions d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,3140,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,3140,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,3141,0)
 ;;=F06.0^^8^98^6
 ;;^UTILITY(U,$J,358.3,3141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3141,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,3141,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,3141,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,3142,0)
 ;;=F06.4^^8^98^1
 ;;^UTILITY(U,$J,358.3,3142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3142,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,3142,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,3142,2)
 ;;=^5003061
