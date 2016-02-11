IBDEI29X ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38184,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,38184,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,38185,0)
 ;;=F45.22^^177^1926^1
 ;;^UTILITY(U,$J,358.3,38185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38185,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,38185,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,38185,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,38186,0)
 ;;=F63.3^^177^1926^7
 ;;^UTILITY(U,$J,358.3,38186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38186,1,3,0)
 ;;=3^Trichotillomania
 ;;^UTILITY(U,$J,358.3,38186,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,38186,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,38187,0)
 ;;=L98.1^^177^1926^2
 ;;^UTILITY(U,$J,358.3,38187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38187,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,38187,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,38187,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,38188,0)
 ;;=F63.0^^177^1926^4
 ;;^UTILITY(U,$J,358.3,38188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38188,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,38188,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,38188,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,38189,0)
 ;;=F68.10^^177^1926^3
 ;;^UTILITY(U,$J,358.3,38189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38189,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,38189,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,38189,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,38190,0)
 ;;=F63.9^^177^1926^5
 ;;^UTILITY(U,$J,358.3,38190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38190,1,3,0)
 ;;=3^Impulse Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38190,1,4,0)
 ;;=4^F63.9
 ;;^UTILITY(U,$J,358.3,38190,2)
 ;;=^5003646
 ;;^UTILITY(U,$J,358.3,38191,0)
 ;;=F06.2^^177^1927^5
 ;;^UTILITY(U,$J,358.3,38191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38191,1,3,0)
 ;;=3^Psychotic Disorder w/ Delusions d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,38191,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,38191,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,38192,0)
 ;;=F06.0^^177^1927^6
 ;;^UTILITY(U,$J,358.3,38192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38192,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,38192,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,38192,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,38193,0)
 ;;=F06.4^^177^1927^1
 ;;^UTILITY(U,$J,358.3,38193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38193,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,38193,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,38193,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,38194,0)
 ;;=F06.1^^177^1927^2
 ;;^UTILITY(U,$J,358.3,38194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38194,1,3,0)
 ;;=3^Catatonia Associated w/ Schizophrenia
 ;;^UTILITY(U,$J,358.3,38194,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,38194,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,38195,0)
 ;;=R41.9^^177^1927^3
 ;;^UTILITY(U,$J,358.3,38195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38195,1,3,0)
 ;;=3^Neurocognitive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38195,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,38195,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,38196,0)
 ;;=F29.^^177^1927^7
 ;;^UTILITY(U,$J,358.3,38196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38196,1,3,0)
 ;;=3^Schizophrenia Spectrum/Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38196,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,38196,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,38197,0)
 ;;=F07.0^^177^1927^4
 ;;^UTILITY(U,$J,358.3,38197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38197,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
