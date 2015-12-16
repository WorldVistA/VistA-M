IBDEI0GE ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7604,1,4,0)
 ;;=4^242.00
 ;;^UTILITY(U,$J,358.3,7604,1,5,0)
 ;;=5^Graves' Disease
 ;;^UTILITY(U,$J,358.3,7604,2)
 ;;=^267793
 ;;^UTILITY(U,$J,358.3,7605,0)
 ;;=242.01^^35^473^12
 ;;^UTILITY(U,$J,358.3,7605,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7605,1,4,0)
 ;;=4^242.01
 ;;^UTILITY(U,$J,358.3,7605,1,5,0)
 ;;=5^Goiter Diff Tox W Strm
 ;;^UTILITY(U,$J,358.3,7605,2)
 ;;=^267794
 ;;^UTILITY(U,$J,358.3,7606,0)
 ;;=252.1^^35^473^33
 ;;^UTILITY(U,$J,358.3,7606,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7606,1,4,0)
 ;;=4^252.1
 ;;^UTILITY(U,$J,358.3,7606,1,5,0)
 ;;=5^Hypoparathyroidism
 ;;^UTILITY(U,$J,358.3,7606,2)
 ;;=^60635
 ;;^UTILITY(U,$J,358.3,7607,0)
 ;;=242.90^^35^473^27
 ;;^UTILITY(U,$J,358.3,7607,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7607,1,4,0)
 ;;=4^242.90
 ;;^UTILITY(U,$J,358.3,7607,1,5,0)
 ;;=5^Hyperthyroidism w/o Goiter/Storm
 ;;^UTILITY(U,$J,358.3,7607,2)
 ;;=^267811
 ;;^UTILITY(U,$J,358.3,7608,0)
 ;;=242.91^^35^473^26
 ;;^UTILITY(U,$J,358.3,7608,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7608,1,4,0)
 ;;=4^242.91
 ;;^UTILITY(U,$J,358.3,7608,1,5,0)
 ;;=5^Hyperthyroidism w/o Goit w/ Storm
 ;;^UTILITY(U,$J,358.3,7608,2)
 ;;=^267812
 ;;^UTILITY(U,$J,358.3,7609,0)
 ;;=244.0^^35^473^36
 ;;^UTILITY(U,$J,358.3,7609,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7609,1,4,0)
 ;;=4^244.0
 ;;^UTILITY(U,$J,358.3,7609,1,5,0)
 ;;=5^Hypothyroid, Postsurgical
 ;;^UTILITY(U,$J,358.3,7609,2)
 ;;=^267814
 ;;^UTILITY(U,$J,358.3,7610,0)
 ;;=244.2^^35^473^35
 ;;^UTILITY(U,$J,358.3,7610,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7610,1,4,0)
 ;;=4^244.2
 ;;^UTILITY(U,$J,358.3,7610,1,5,0)
 ;;=5^Hypothyroid d/t Iodine Rx
 ;;^UTILITY(U,$J,358.3,7610,2)
 ;;=^267817
 ;;^UTILITY(U,$J,358.3,7611,0)
 ;;=244.9^^35^473^37
 ;;^UTILITY(U,$J,358.3,7611,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7611,1,4,0)
 ;;=4^244.9
 ;;^UTILITY(U,$J,358.3,7611,1,5,0)
 ;;=5^Hypothyroid, Unspec Cause
 ;;^UTILITY(U,$J,358.3,7611,2)
 ;;=^123752
 ;;^UTILITY(U,$J,358.3,7612,0)
 ;;=245.0^^35^473^51
 ;;^UTILITY(U,$J,358.3,7612,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7612,1,4,0)
 ;;=4^245.0
 ;;^UTILITY(U,$J,358.3,7612,1,5,0)
 ;;=5^Thyroiditis, Acute
 ;;^UTILITY(U,$J,358.3,7612,2)
 ;;=^2692
 ;;^UTILITY(U,$J,358.3,7613,0)
 ;;=245.1^^35^473^52
 ;;^UTILITY(U,$J,358.3,7613,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7613,1,4,0)
 ;;=4^245.1
 ;;^UTILITY(U,$J,358.3,7613,1,5,0)
 ;;=5^Thyroiditis, Subacute
 ;;^UTILITY(U,$J,358.3,7613,2)
 ;;=^119376
 ;;^UTILITY(U,$J,358.3,7614,0)
 ;;=733.01^^35^473^45
 ;;^UTILITY(U,$J,358.3,7614,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7614,1,4,0)
 ;;=4^733.01
 ;;^UTILITY(U,$J,358.3,7614,1,5,0)
 ;;=5^Osteoporosis, Senile
 ;;^UTILITY(U,$J,358.3,7614,2)
 ;;=Osteoporosis, Senile^87188
 ;;^UTILITY(U,$J,358.3,7615,0)
 ;;=733.02^^35^473^44
 ;;^UTILITY(U,$J,358.3,7615,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7615,1,4,0)
 ;;=4^733.02
 ;;^UTILITY(U,$J,358.3,7615,1,5,0)
 ;;=5^Osteoporosis, Idiopathic
 ;;^UTILITY(U,$J,358.3,7615,2)
 ;;=Osteoporosis, Idiopathic^272692
 ;;^UTILITY(U,$J,358.3,7616,0)
 ;;=268.2^^35^473^41
 ;;^UTILITY(U,$J,358.3,7616,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7616,1,4,0)
 ;;=4^268.2
 ;;^UTILITY(U,$J,358.3,7616,1,5,0)
 ;;=5^Osteomalacia
 ;;^UTILITY(U,$J,358.3,7616,2)
 ;;=Osteomalacia^87103
 ;;^UTILITY(U,$J,358.3,7617,0)
 ;;=733.90^^35^473^42
 ;;^UTILITY(U,$J,358.3,7617,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7617,1,4,0)
 ;;=4^733.90
 ;;^UTILITY(U,$J,358.3,7617,1,5,0)
 ;;=5^Osteopenia
 ;;^UTILITY(U,$J,358.3,7617,2)
 ;;=Osteopenia^35593
 ;;^UTILITY(U,$J,358.3,7618,0)
 ;;=275.49^^35^473^46
