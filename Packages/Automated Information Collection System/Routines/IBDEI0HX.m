IBDEI0HX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8293,1,3,0)
 ;;=3^Chr Kidney Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8293,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,8293,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,8294,0)
 ;;=E11.36^^35^442^24
 ;;^UTILITY(U,$J,358.3,8294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8294,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,8294,1,4,0)
 ;;=4^E11.36
 ;;^UTILITY(U,$J,358.3,8294,2)
 ;;=^5002642
 ;;^UTILITY(U,$J,358.3,8295,0)
 ;;=E11.40^^35^442^25
 ;;^UTILITY(U,$J,358.3,8295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8295,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neurpathy,Unspec
 ;;^UTILITY(U,$J,358.3,8295,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,8295,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,8296,0)
 ;;=E11.51^^35^442^26
 ;;^UTILITY(U,$J,358.3,8296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8296,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Peripheral Angiopath w/o Gangrene
 ;;^UTILITY(U,$J,358.3,8296,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,8296,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,8297,0)
 ;;=E29.1^^35^442^84
 ;;^UTILITY(U,$J,358.3,8297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8297,1,3,0)
 ;;=3^Testicular Hypofunction
 ;;^UTILITY(U,$J,358.3,8297,1,4,0)
 ;;=4^E29.1
 ;;^UTILITY(U,$J,358.3,8297,2)
 ;;=^5002754
 ;;^UTILITY(U,$J,358.3,8298,0)
 ;;=E04.1^^35^442^85
 ;;^UTILITY(U,$J,358.3,8298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8298,1,3,0)
 ;;=3^Thyroid Nodule,Single,Nontoxic
 ;;^UTILITY(U,$J,358.3,8298,1,4,0)
 ;;=4^E04.1
 ;;^UTILITY(U,$J,358.3,8298,2)
 ;;=^5002478
 ;;^UTILITY(U,$J,358.3,8299,0)
 ;;=E03.9^^35^442^55
 ;;^UTILITY(U,$J,358.3,8299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8299,1,3,0)
 ;;=3^Hypothyroidism,Unspec
 ;;^UTILITY(U,$J,358.3,8299,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,8299,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,8300,0)
 ;;=M81.0^^35^442^82
 ;;^UTILITY(U,$J,358.3,8300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8300,1,3,0)
 ;;=3^Osteoporosis,Age-Related w/o Current Path Fracture
 ;;^UTILITY(U,$J,358.3,8300,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,8300,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,8301,0)
 ;;=E05.90^^35^442^47
 ;;^UTILITY(U,$J,358.3,8301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8301,1,3,0)
 ;;=3^Hyperthyroidism w/o Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,8301,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,8301,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,8302,0)
 ;;=C73.^^35^442^67
 ;;^UTILITY(U,$J,358.3,8302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8302,1,3,0)
 ;;=3^Malig Neop of Thyroid Gland
 ;;^UTILITY(U,$J,358.3,8302,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,8302,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,8303,0)
 ;;=E04.2^^35^442^35
 ;;^UTILITY(U,$J,358.3,8303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8303,1,3,0)
 ;;=3^Goiter,Multinodular,Nontoxic
 ;;^UTILITY(U,$J,358.3,8303,1,4,0)
 ;;=4^E04.2
 ;;^UTILITY(U,$J,358.3,8303,2)
 ;;=^267790
 ;;^UTILITY(U,$J,358.3,8304,0)
 ;;=E78.4^^35^442^41
 ;;^UTILITY(U,$J,358.3,8304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8304,1,3,0)
 ;;=3^Hyperlipidemia,Other
 ;;^UTILITY(U,$J,358.3,8304,1,4,0)
 ;;=4^E78.4
 ;;^UTILITY(U,$J,358.3,8304,2)
 ;;=^5002968
 ;;^UTILITY(U,$J,358.3,8305,0)
 ;;=E78.5^^35^442^42
 ;;^UTILITY(U,$J,358.3,8305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8305,1,3,0)
 ;;=3^Hyperlipidemia,Unspec
 ;;^UTILITY(U,$J,358.3,8305,1,4,0)
 ;;=4^E78.5
 ;;^UTILITY(U,$J,358.3,8305,2)
 ;;=^5002969
 ;;^UTILITY(U,$J,358.3,8306,0)
 ;;=D35.2^^35^442^13
 ;;^UTILITY(U,$J,358.3,8306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8306,1,3,0)
 ;;=3^Benign Neop of Pituitary Gland
