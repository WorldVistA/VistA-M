IBDEI01B ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,121,2)
 ;;=^303633
 ;;^UTILITY(U,$J,358.3,122,0)
 ;;=296.80^^2^12^8
 ;;^UTILITY(U,$J,358.3,122,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,122,1,2,0)
 ;;=2^296.80
 ;;^UTILITY(U,$J,358.3,122,1,5,0)
 ;;=5^Bipolar Disorder,NOS
 ;;^UTILITY(U,$J,358.3,122,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,123,0)
 ;;=296.89^^2^12^10
 ;;^UTILITY(U,$J,358.3,123,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,123,1,2,0)
 ;;=2^296.89
 ;;^UTILITY(U,$J,358.3,123,1,5,0)
 ;;=5^Bipolar II Disorder,NOS
 ;;^UTILITY(U,$J,358.3,123,2)
 ;;=^331893
 ;;^UTILITY(U,$J,358.3,124,0)
 ;;=297.0^^2^13^3
 ;;^UTILITY(U,$J,358.3,124,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,124,1,2,0)
 ;;=2^297.0
 ;;^UTILITY(U,$J,358.3,124,1,5,0)
 ;;=5^Paranoid State, Simple
 ;;^UTILITY(U,$J,358.3,124,2)
 ;;=^268149
 ;;^UTILITY(U,$J,358.3,125,0)
 ;;=298.9^^2^13^4
 ;;^UTILITY(U,$J,358.3,125,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,125,1,2,0)
 ;;=2^298.9
 ;;^UTILITY(U,$J,358.3,125,1,5,0)
 ;;=5^Psychosis, NOS
 ;;^UTILITY(U,$J,358.3,125,2)
 ;;=^259059
 ;;^UTILITY(U,$J,358.3,126,0)
 ;;=298.8^^2^13^5
 ;;^UTILITY(U,$J,358.3,126,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,126,1,2,0)
 ;;=2^298.8
 ;;^UTILITY(U,$J,358.3,126,1,5,0)
 ;;=5^Psychosis, Reactive
 ;;^UTILITY(U,$J,358.3,126,2)
 ;;=^87326
 ;;^UTILITY(U,$J,358.3,127,0)
 ;;=297.9^^2^13^2
 ;;^UTILITY(U,$J,358.3,127,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,127,1,2,0)
 ;;=2^297.9
 ;;^UTILITY(U,$J,358.3,127,1,5,0)
 ;;=5^Paranoia
 ;;^UTILITY(U,$J,358.3,127,2)
 ;;=^123970
 ;;^UTILITY(U,$J,358.3,128,0)
 ;;=297.1^^2^13^1
 ;;^UTILITY(U,$J,358.3,128,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,128,1,2,0)
 ;;=2^297.1
 ;;^UTILITY(U,$J,358.3,128,1,5,0)
 ;;=5^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,128,2)
 ;;=^331896
 ;;^UTILITY(U,$J,358.3,129,0)
 ;;=301.7^^2^14^1
 ;;^UTILITY(U,$J,358.3,129,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,129,1,2,0)
 ;;=2^301.7
 ;;^UTILITY(U,$J,358.3,129,1,5,0)
 ;;=5^Antisocial Personality Dis
 ;;^UTILITY(U,$J,358.3,129,2)
 ;;=Antisocial Personality Dis^9066
 ;;^UTILITY(U,$J,358.3,130,0)
 ;;=301.82^^2^14^2
 ;;^UTILITY(U,$J,358.3,130,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,130,1,2,0)
 ;;=2^301.82
 ;;^UTILITY(U,$J,358.3,130,1,5,0)
 ;;=5^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,130,2)
 ;;=Avoidant Personality Disorder^265347
 ;;^UTILITY(U,$J,358.3,131,0)
 ;;=301.83^^2^14^3
 ;;^UTILITY(U,$J,358.3,131,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,131,1,2,0)
 ;;=2^301.83
 ;;^UTILITY(U,$J,358.3,131,1,5,0)
 ;;=5^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,131,2)
 ;;=Borderline Personality Disorder^16372
 ;;^UTILITY(U,$J,358.3,132,0)
 ;;=301.6^^2^14^6
 ;;^UTILITY(U,$J,358.3,132,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,132,1,2,0)
 ;;=2^301.6
 ;;^UTILITY(U,$J,358.3,132,1,5,0)
 ;;=5^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,132,2)
 ;;=Dependent Personality Disorder^32860
 ;;^UTILITY(U,$J,358.3,133,0)
 ;;=301.50^^2^14^8
 ;;^UTILITY(U,$J,358.3,133,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,133,1,2,0)
 ;;=2^301.50
 ;;^UTILITY(U,$J,358.3,133,1,5,0)
 ;;=5^Histrionic Personality Disorder
 ;;^UTILITY(U,$J,358.3,133,2)
 ;;=Histrionic Personality Disorder^57763
 ;;^UTILITY(U,$J,358.3,134,0)
 ;;=301.81^^2^14^11
 ;;^UTILITY(U,$J,358.3,134,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,134,1,2,0)
 ;;=2^301.81
 ;;^UTILITY(U,$J,358.3,134,1,5,0)
 ;;=5^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,134,2)
 ;;=Narcissistic Personality Disorder^265353
 ;;^UTILITY(U,$J,358.3,135,0)
 ;;=301.0^^2^14^12
 ;;^UTILITY(U,$J,358.3,135,1,0)
 ;;=^358.31IA^5^2
