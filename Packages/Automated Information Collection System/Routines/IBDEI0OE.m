IBDEI0OE ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11957,1,5,0)
 ;;=5^Bipolar Disorder,NOS
 ;;^UTILITY(U,$J,358.3,11957,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,11958,0)
 ;;=296.89^^66^722^10
 ;;^UTILITY(U,$J,358.3,11958,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11958,1,2,0)
 ;;=2^296.89
 ;;^UTILITY(U,$J,358.3,11958,1,5,0)
 ;;=5^Bipolar II Disorder,NOS
 ;;^UTILITY(U,$J,358.3,11958,2)
 ;;=^331893
 ;;^UTILITY(U,$J,358.3,11959,0)
 ;;=297.0^^66^723^3
 ;;^UTILITY(U,$J,358.3,11959,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11959,1,2,0)
 ;;=2^297.0
 ;;^UTILITY(U,$J,358.3,11959,1,5,0)
 ;;=5^Paranoid State, Simple
 ;;^UTILITY(U,$J,358.3,11959,2)
 ;;=^268149
 ;;^UTILITY(U,$J,358.3,11960,0)
 ;;=298.9^^66^723^4
 ;;^UTILITY(U,$J,358.3,11960,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11960,1,2,0)
 ;;=2^298.9
 ;;^UTILITY(U,$J,358.3,11960,1,5,0)
 ;;=5^Psychosis, NOS
 ;;^UTILITY(U,$J,358.3,11960,2)
 ;;=^259059
 ;;^UTILITY(U,$J,358.3,11961,0)
 ;;=298.8^^66^723^5
 ;;^UTILITY(U,$J,358.3,11961,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11961,1,2,0)
 ;;=2^298.8
 ;;^UTILITY(U,$J,358.3,11961,1,5,0)
 ;;=5^Psychosis, Reactive
 ;;^UTILITY(U,$J,358.3,11961,2)
 ;;=^87326
 ;;^UTILITY(U,$J,358.3,11962,0)
 ;;=297.9^^66^723^2
 ;;^UTILITY(U,$J,358.3,11962,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11962,1,2,0)
 ;;=2^297.9
 ;;^UTILITY(U,$J,358.3,11962,1,5,0)
 ;;=5^Paranoia
 ;;^UTILITY(U,$J,358.3,11962,2)
 ;;=^123970
 ;;^UTILITY(U,$J,358.3,11963,0)
 ;;=297.1^^66^723^1
 ;;^UTILITY(U,$J,358.3,11963,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11963,1,2,0)
 ;;=2^297.1
 ;;^UTILITY(U,$J,358.3,11963,1,5,0)
 ;;=5^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,11963,2)
 ;;=^331896
 ;;^UTILITY(U,$J,358.3,11964,0)
 ;;=301.7^^66^724^1
 ;;^UTILITY(U,$J,358.3,11964,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11964,1,2,0)
 ;;=2^301.7
 ;;^UTILITY(U,$J,358.3,11964,1,5,0)
 ;;=5^Antisocial Personality Dis
 ;;^UTILITY(U,$J,358.3,11964,2)
 ;;=Antisocial Personality Dis^9066
 ;;^UTILITY(U,$J,358.3,11965,0)
 ;;=301.82^^66^724^2
 ;;^UTILITY(U,$J,358.3,11965,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11965,1,2,0)
 ;;=2^301.82
 ;;^UTILITY(U,$J,358.3,11965,1,5,0)
 ;;=5^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,11965,2)
 ;;=Avoidant Personality Disorder^265347
 ;;^UTILITY(U,$J,358.3,11966,0)
 ;;=301.83^^66^724^3
 ;;^UTILITY(U,$J,358.3,11966,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11966,1,2,0)
 ;;=2^301.83
 ;;^UTILITY(U,$J,358.3,11966,1,5,0)
 ;;=5^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,11966,2)
 ;;=Borderline Personality Disorder^16372
 ;;^UTILITY(U,$J,358.3,11967,0)
 ;;=301.6^^66^724^6
 ;;^UTILITY(U,$J,358.3,11967,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11967,1,2,0)
 ;;=2^301.6
 ;;^UTILITY(U,$J,358.3,11967,1,5,0)
 ;;=5^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,11967,2)
 ;;=Dependent Personality Disorder^32860
 ;;^UTILITY(U,$J,358.3,11968,0)
 ;;=301.50^^66^724^8
 ;;^UTILITY(U,$J,358.3,11968,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11968,1,2,0)
 ;;=2^301.50
 ;;^UTILITY(U,$J,358.3,11968,1,5,0)
 ;;=5^Histrionic Personality Disorder
 ;;^UTILITY(U,$J,358.3,11968,2)
 ;;=Histrionic Personality Disorder^57763
 ;;^UTILITY(U,$J,358.3,11969,0)
 ;;=301.81^^66^724^11
 ;;^UTILITY(U,$J,358.3,11969,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11969,1,2,0)
 ;;=2^301.81
 ;;^UTILITY(U,$J,358.3,11969,1,5,0)
 ;;=5^Narcissistic Personality Disorder
 ;;^UTILITY(U,$J,358.3,11969,2)
 ;;=Narcissistic Personality Disorder^265353
 ;;^UTILITY(U,$J,358.3,11970,0)
 ;;=301.0^^66^724^12
 ;;^UTILITY(U,$J,358.3,11970,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,11970,1,2,0)
 ;;=2^301.0
