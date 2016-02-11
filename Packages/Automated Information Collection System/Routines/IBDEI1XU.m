IBDEI1XU ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32446,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,32446,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,32447,0)
 ;;=F06.0^^143^1530^6
 ;;^UTILITY(U,$J,358.3,32447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32447,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,32447,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,32447,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,32448,0)
 ;;=F06.4^^143^1530^1
 ;;^UTILITY(U,$J,358.3,32448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32448,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,32448,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,32448,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,32449,0)
 ;;=F06.1^^143^1530^2
 ;;^UTILITY(U,$J,358.3,32449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32449,1,3,0)
 ;;=3^Catatonia Associated w/ Schizophrenia
 ;;^UTILITY(U,$J,358.3,32449,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,32449,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,32450,0)
 ;;=R41.9^^143^1530^3
 ;;^UTILITY(U,$J,358.3,32450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32450,1,3,0)
 ;;=3^Neurocognitive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32450,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,32450,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,32451,0)
 ;;=F29.^^143^1530^7
 ;;^UTILITY(U,$J,358.3,32451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32451,1,3,0)
 ;;=3^Schizophrenia Spectrum/Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32451,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,32451,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,32452,0)
 ;;=F07.0^^143^1530^4
 ;;^UTILITY(U,$J,358.3,32452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32452,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,32452,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,32452,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,32453,0)
 ;;=Z91.49^^143^1531^9
 ;;^UTILITY(U,$J,358.3,32453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32453,1,3,0)
 ;;=3^Personal Hx of Psychological Trauma
 ;;^UTILITY(U,$J,358.3,32453,1,4,0)
 ;;=4^Z91.49
 ;;^UTILITY(U,$J,358.3,32453,2)
 ;;=^5063623
 ;;^UTILITY(U,$J,358.3,32454,0)
 ;;=Z91.5^^143^1531^10
 ;;^UTILITY(U,$J,358.3,32454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32454,1,3,0)
 ;;=3^Personal Hx of Self-Harm
 ;;^UTILITY(U,$J,358.3,32454,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,32454,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,32455,0)
 ;;=Z91.82^^143^1531^8
 ;;^UTILITY(U,$J,358.3,32455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32455,1,3,0)
 ;;=3^Personal Hx of Military Deployment
 ;;^UTILITY(U,$J,358.3,32455,1,4,0)
 ;;=4^Z91.82
 ;;^UTILITY(U,$J,358.3,32455,2)
 ;;=^5063626
 ;;^UTILITY(U,$J,358.3,32456,0)
 ;;=Z91.89^^143^1531^11
 ;;^UTILITY(U,$J,358.3,32456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32456,1,3,0)
 ;;=3^Personal Risk Factors
 ;;^UTILITY(U,$J,358.3,32456,1,4,0)
 ;;=4^Z91.89
 ;;^UTILITY(U,$J,358.3,32456,2)
 ;;=^5063628
 ;;^UTILITY(U,$J,358.3,32457,0)
 ;;=Z72.9^^143^1531^12
 ;;^UTILITY(U,$J,358.3,32457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32457,1,3,0)
 ;;=3^Problem Related to Lifestyle
 ;;^UTILITY(U,$J,358.3,32457,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,32457,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,32458,0)
 ;;=Z72.811^^143^1531^1
 ;;^UTILITY(U,$J,358.3,32458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32458,1,3,0)
 ;;=3^Adult Antisocial Behavior
 ;;^UTILITY(U,$J,358.3,32458,1,4,0)
 ;;=4^Z72.811
 ;;^UTILITY(U,$J,358.3,32458,2)
 ;;=^5063263
 ;;^UTILITY(U,$J,358.3,32459,0)
 ;;=Z91.19^^143^1531^5
 ;;^UTILITY(U,$J,358.3,32459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32459,1,3,0)
 ;;=3^Nonadherence to Medical Treatment
