IBDEI1TI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30881,1,3,0)
 ;;=3^Impulse Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30881,1,4,0)
 ;;=4^F63.9
 ;;^UTILITY(U,$J,358.3,30881,2)
 ;;=^5003646
 ;;^UTILITY(U,$J,358.3,30882,0)
 ;;=F42.^^123^1541^4
 ;;^UTILITY(U,$J,358.3,30882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30882,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,30882,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,30882,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,30883,0)
 ;;=F06.8^^123^1541^6
 ;;^UTILITY(U,$J,358.3,30883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30883,1,3,0)
 ;;=3^Obsessive-Compulsive & Related Disorder d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,30883,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,30883,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,30884,0)
 ;;=F06.2^^123^1542^5
 ;;^UTILITY(U,$J,358.3,30884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30884,1,3,0)
 ;;=3^Psychotic Disorder w/ Delusions d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,30884,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,30884,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,30885,0)
 ;;=F06.0^^123^1542^6
 ;;^UTILITY(U,$J,358.3,30885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30885,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,30885,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,30885,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,30886,0)
 ;;=F06.4^^123^1542^1
 ;;^UTILITY(U,$J,358.3,30886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30886,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,30886,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,30886,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,30887,0)
 ;;=F06.1^^123^1542^2
 ;;^UTILITY(U,$J,358.3,30887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30887,1,3,0)
 ;;=3^Catatonia Associated w/ Schizophrenia
 ;;^UTILITY(U,$J,358.3,30887,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,30887,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,30888,0)
 ;;=R41.9^^123^1542^3
 ;;^UTILITY(U,$J,358.3,30888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30888,1,3,0)
 ;;=3^Neurocognitive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30888,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,30888,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,30889,0)
 ;;=F29.^^123^1542^7
 ;;^UTILITY(U,$J,358.3,30889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30889,1,3,0)
 ;;=3^Schizophrenia Spectrum/Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30889,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,30889,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,30890,0)
 ;;=F07.0^^123^1542^4
 ;;^UTILITY(U,$J,358.3,30890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30890,1,3,0)
 ;;=3^Personality Change d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,30890,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,30890,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,30891,0)
 ;;=Z91.49^^123^1543^12
 ;;^UTILITY(U,$J,358.3,30891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30891,1,3,0)
 ;;=3^Personal Hx of Psychological Trauma
 ;;^UTILITY(U,$J,358.3,30891,1,4,0)
 ;;=4^Z91.49
 ;;^UTILITY(U,$J,358.3,30891,2)
 ;;=^5063623
 ;;^UTILITY(U,$J,358.3,30892,0)
 ;;=Z91.5^^123^1543^13
 ;;^UTILITY(U,$J,358.3,30892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30892,1,3,0)
 ;;=3^Personal Hx of Self-Harm
 ;;^UTILITY(U,$J,358.3,30892,1,4,0)
 ;;=4^Z91.5
 ;;^UTILITY(U,$J,358.3,30892,2)
 ;;=^5063624
 ;;^UTILITY(U,$J,358.3,30893,0)
 ;;=Z91.82^^123^1543^11
 ;;^UTILITY(U,$J,358.3,30893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30893,1,3,0)
 ;;=3^Personal Hx of Military Deployment
 ;;^UTILITY(U,$J,358.3,30893,1,4,0)
 ;;=4^Z91.82
