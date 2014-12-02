IBDEI0DO ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6579,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6579,1,4,0)
 ;;=4^245.0
 ;;^UTILITY(U,$J,358.3,6579,1,5,0)
 ;;=5^Thyroiditis, Acute
 ;;^UTILITY(U,$J,358.3,6579,2)
 ;;=^2692
 ;;^UTILITY(U,$J,358.3,6580,0)
 ;;=245.1^^55^568^52
 ;;^UTILITY(U,$J,358.3,6580,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6580,1,4,0)
 ;;=4^245.1
 ;;^UTILITY(U,$J,358.3,6580,1,5,0)
 ;;=5^Thyroiditis, Subacute
 ;;^UTILITY(U,$J,358.3,6580,2)
 ;;=^119376
 ;;^UTILITY(U,$J,358.3,6581,0)
 ;;=733.01^^55^568^45
 ;;^UTILITY(U,$J,358.3,6581,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6581,1,4,0)
 ;;=4^733.01
 ;;^UTILITY(U,$J,358.3,6581,1,5,0)
 ;;=5^Osteoporosis, Senile
 ;;^UTILITY(U,$J,358.3,6581,2)
 ;;=Osteoporosis, Senile^87188
 ;;^UTILITY(U,$J,358.3,6582,0)
 ;;=733.02^^55^568^44
 ;;^UTILITY(U,$J,358.3,6582,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6582,1,4,0)
 ;;=4^733.02
 ;;^UTILITY(U,$J,358.3,6582,1,5,0)
 ;;=5^Osteoporosis, Idiopathic
 ;;^UTILITY(U,$J,358.3,6582,2)
 ;;=Osteoporosis, Idiopathic^272692
 ;;^UTILITY(U,$J,358.3,6583,0)
 ;;=268.2^^55^568^41
 ;;^UTILITY(U,$J,358.3,6583,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6583,1,4,0)
 ;;=4^268.2
 ;;^UTILITY(U,$J,358.3,6583,1,5,0)
 ;;=5^Osteomalacia
 ;;^UTILITY(U,$J,358.3,6583,2)
 ;;=Osteomalacia^87103
 ;;^UTILITY(U,$J,358.3,6584,0)
 ;;=733.90^^55^568^42
 ;;^UTILITY(U,$J,358.3,6584,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6584,1,4,0)
 ;;=4^733.90
 ;;^UTILITY(U,$J,358.3,6584,1,5,0)
 ;;=5^Osteopenia
 ;;^UTILITY(U,$J,358.3,6584,2)
 ;;=Osteopenia^35593
 ;;^UTILITY(U,$J,358.3,6585,0)
 ;;=275.49^^55^568^46
 ;;^UTILITY(U,$J,358.3,6585,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6585,1,4,0)
 ;;=4^275.49
 ;;^UTILITY(U,$J,358.3,6585,1,5,0)
 ;;=5^Pseudohypoparathyroidism
 ;;^UTILITY(U,$J,358.3,6585,2)
 ;;=Pseudohypparathyroidism^317904
 ;;^UTILITY(U,$J,358.3,6586,0)
 ;;=266.2^^55^568^53
 ;;^UTILITY(U,$J,358.3,6586,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6586,1,4,0)
 ;;=4^266.2
 ;;^UTILITY(U,$J,358.3,6586,1,5,0)
 ;;=5^Vitamin B12 Deficiency
 ;;^UTILITY(U,$J,358.3,6586,2)
 ;;=Vitamin B12 Deficiency^87347
 ;;^UTILITY(U,$J,358.3,6587,0)
 ;;=268.9^^55^568^55
 ;;^UTILITY(U,$J,358.3,6587,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6587,1,4,0)
 ;;=4^268.9
 ;;^UTILITY(U,$J,358.3,6587,1,5,0)
 ;;=5^Vitamin D Deficiency
 ;;^UTILITY(U,$J,358.3,6587,2)
 ;;=Vitamin D Deficiency^126968
 ;;^UTILITY(U,$J,358.3,6588,0)
 ;;=266.1^^55^568^54
 ;;^UTILITY(U,$J,358.3,6588,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6588,1,4,0)
 ;;=4^266.1
 ;;^UTILITY(U,$J,358.3,6588,1,5,0)
 ;;=5^Vitamin B6 Deficiency
 ;;^UTILITY(U,$J,358.3,6588,2)
 ;;=^101683
 ;;^UTILITY(U,$J,358.3,6589,0)
 ;;=780.99^^55^568^3
 ;;^UTILITY(U,$J,358.3,6589,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6589,1,4,0)
 ;;=4^780.99
 ;;^UTILITY(U,$J,358.3,6589,1,5,0)
 ;;=5^Cold Intolerance
 ;;^UTILITY(U,$J,358.3,6589,2)
 ;;=Cold Intolerance^328568
 ;;^UTILITY(U,$J,358.3,6590,0)
 ;;=255.41^^55^568^1
 ;;^UTILITY(U,$J,358.3,6590,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6590,1,4,0)
 ;;=4^255.41
 ;;^UTILITY(U,$J,358.3,6590,1,5,0)
 ;;=5^Adrenal Insuff
 ;;^UTILITY(U,$J,358.3,6590,2)
 ;;=^335240
 ;;^UTILITY(U,$J,358.3,6591,0)
 ;;=249.00^^55^568^49
 ;;^UTILITY(U,$J,358.3,6591,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6591,1,4,0)
 ;;=4^249.00
 ;;^UTILITY(U,$J,358.3,6591,1,5,0)
 ;;=5^Secondary DM w/o Complication
 ;;^UTILITY(U,$J,358.3,6591,2)
 ;;=^336728
 ;;^UTILITY(U,$J,358.3,6592,0)
 ;;=249.40^^55^568^48
 ;;^UTILITY(U,$J,358.3,6592,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6592,1,4,0)
 ;;=4^249.40
 ;;^UTILITY(U,$J,358.3,6592,1,5,0)
 ;;=5^Secondary DM w/ Renal Complications
