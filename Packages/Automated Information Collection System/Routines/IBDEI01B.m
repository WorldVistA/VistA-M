IBDEI01B ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,56,1,3,0)
 ;;=3^Peripheral vertigo, bilateral NEC
 ;;^UTILITY(U,$J,358.3,56,1,4,0)
 ;;=4^H81.393
 ;;^UTILITY(U,$J,358.3,56,2)
 ;;=^5006878
 ;;^UTILITY(U,$J,358.3,57,0)
 ;;=H81.392^^1^3^16
 ;;^UTILITY(U,$J,358.3,57,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57,1,3,0)
 ;;=3^Peripheral vertigo, left ear NEC
 ;;^UTILITY(U,$J,358.3,57,1,4,0)
 ;;=4^H81.392
 ;;^UTILITY(U,$J,358.3,57,2)
 ;;=^5006877
 ;;^UTILITY(U,$J,358.3,58,0)
 ;;=H81.391^^1^3^17
 ;;^UTILITY(U,$J,358.3,58,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58,1,3,0)
 ;;=3^Peripheral vertigo, right ear NEC
 ;;^UTILITY(U,$J,358.3,58,1,4,0)
 ;;=4^H81.391
 ;;^UTILITY(U,$J,358.3,58,2)
 ;;=^5006876
 ;;^UTILITY(U,$J,358.3,59,0)
 ;;=H71.93^^1^3^10
 ;;^UTILITY(U,$J,358.3,59,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,59,1,3,0)
 ;;=3^Cholesteatoma,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,59,1,4,0)
 ;;=4^H71.93
 ;;^UTILITY(U,$J,358.3,59,2)
 ;;=^5006741
 ;;^UTILITY(U,$J,358.3,60,0)
 ;;=H81.43^^1^3^7
 ;;^UTILITY(U,$J,358.3,60,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,60,1,3,0)
 ;;=3^Central Origin Vertigo,Bilateral
 ;;^UTILITY(U,$J,358.3,60,1,4,0)
 ;;=4^H81.43
 ;;^UTILITY(U,$J,358.3,60,2)
 ;;=^5006882
 ;;^UTILITY(U,$J,358.3,61,0)
 ;;=H81.42^^1^3^8
 ;;^UTILITY(U,$J,358.3,61,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,61,1,3,0)
 ;;=3^Central Origin Vertigo,Left Ear
 ;;^UTILITY(U,$J,358.3,61,1,4,0)
 ;;=4^H81.42
 ;;^UTILITY(U,$J,358.3,61,2)
 ;;=^5006881
 ;;^UTILITY(U,$J,358.3,62,0)
 ;;=H81.41^^1^3^9
 ;;^UTILITY(U,$J,358.3,62,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,62,1,3,0)
 ;;=3^Central Origin Vertigo,Right Ear
 ;;^UTILITY(U,$J,358.3,62,1,4,0)
 ;;=4^H81.41
 ;;^UTILITY(U,$J,358.3,62,2)
 ;;=^5006880
 ;;^UTILITY(U,$J,358.3,63,0)
 ;;=H81.23^^1^3^18
 ;;^UTILITY(U,$J,358.3,63,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,63,1,3,0)
 ;;=3^Vestibular neuronitis, bilateral
 ;;^UTILITY(U,$J,358.3,63,1,4,0)
 ;;=4^H81.23
 ;;^UTILITY(U,$J,358.3,63,2)
 ;;=^5006871
 ;;^UTILITY(U,$J,358.3,64,0)
 ;;=T70.0XXA^^1^4^1
 ;;^UTILITY(U,$J,358.3,64,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,64,1,3,0)
 ;;=3^Otitic barotrauma, initial encounter
 ;;^UTILITY(U,$J,358.3,64,1,4,0)
 ;;=4^T70.0XXA
 ;;^UTILITY(U,$J,358.3,64,2)
 ;;=^5053981
 ;;^UTILITY(U,$J,358.3,65,0)
 ;;=T70.0XXD^^1^4^3
 ;;^UTILITY(U,$J,358.3,65,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,65,1,3,0)
 ;;=3^Otitic barotrauma, subsequent encounter
 ;;^UTILITY(U,$J,358.3,65,1,4,0)
 ;;=4^T70.0XXD
 ;;^UTILITY(U,$J,358.3,65,2)
 ;;=^5053982
 ;;^UTILITY(U,$J,358.3,66,0)
 ;;=T70.0XXS^^1^4^2
 ;;^UTILITY(U,$J,358.3,66,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,66,1,3,0)
 ;;=3^Otitic barotrauma, sequela
 ;;^UTILITY(U,$J,358.3,66,1,4,0)
 ;;=4^T70.0XXS
 ;;^UTILITY(U,$J,358.3,66,2)
 ;;=^5053983
 ;;^UTILITY(U,$J,358.3,67,0)
 ;;=H73.813^^1^5^1
 ;;^UTILITY(U,$J,358.3,67,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,67,1,3,0)
 ;;=3^Atrophic flaccid tympanic membrane, bilateral
 ;;^UTILITY(U,$J,358.3,67,1,4,0)
 ;;=4^H73.813
 ;;^UTILITY(U,$J,358.3,67,2)
 ;;=^5006782
 ;;^UTILITY(U,$J,358.3,68,0)
 ;;=H73.812^^1^5^2
 ;;^UTILITY(U,$J,358.3,68,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,68,1,3,0)
 ;;=3^Atrophic flaccid tympanic membrane, left ear
 ;;^UTILITY(U,$J,358.3,68,1,4,0)
 ;;=4^H73.812
 ;;^UTILITY(U,$J,358.3,68,2)
 ;;=^5006781
 ;;^UTILITY(U,$J,358.3,69,0)
 ;;=H73.811^^1^5^3
 ;;^UTILITY(U,$J,358.3,69,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,69,1,3,0)
 ;;=3^Atrophic flaccid tympanic membrane, right ear
 ;;^UTILITY(U,$J,358.3,69,1,4,0)
 ;;=4^H73.811
 ;;^UTILITY(U,$J,358.3,69,2)
 ;;=^5006780
 ;;^UTILITY(U,$J,358.3,70,0)
 ;;=H73.823^^1^5^4
