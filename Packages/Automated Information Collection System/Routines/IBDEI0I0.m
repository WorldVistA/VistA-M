IBDEI0I0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8333,2)
 ;;=^5001320
 ;;^UTILITY(U,$J,358.3,8334,0)
 ;;=C75.2^^35^442^58
 ;;^UTILITY(U,$J,358.3,8334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8334,1,3,0)
 ;;=3^Malig Neop of Craniopharyngeal Duct
 ;;^UTILITY(U,$J,358.3,8334,1,4,0)
 ;;=4^C75.2
 ;;^UTILITY(U,$J,358.3,8334,2)
 ;;=^5001321
 ;;^UTILITY(U,$J,358.3,8335,0)
 ;;=C75.3^^35^442^63
 ;;^UTILITY(U,$J,358.3,8335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8335,1,3,0)
 ;;=3^Malig Neop of Pineal Gland
 ;;^UTILITY(U,$J,358.3,8335,1,4,0)
 ;;=4^C75.3
 ;;^UTILITY(U,$J,358.3,8335,2)
 ;;=^267301
 ;;^UTILITY(U,$J,358.3,8336,0)
 ;;=C75.4^^35^442^57
 ;;^UTILITY(U,$J,358.3,8336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8336,1,3,0)
 ;;=3^Malig Neop of Carotid Body
 ;;^UTILITY(U,$J,358.3,8336,1,4,0)
 ;;=4^C75.4
 ;;^UTILITY(U,$J,358.3,8336,2)
 ;;=^267302
 ;;^UTILITY(U,$J,358.3,8337,0)
 ;;=C75.5^^35^442^56
 ;;^UTILITY(U,$J,358.3,8337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8337,1,3,0)
 ;;=3^Malig Neop of Aortic Body/Oth Paraganglia
 ;;^UTILITY(U,$J,358.3,8337,1,4,0)
 ;;=4^C75.5
 ;;^UTILITY(U,$J,358.3,8337,2)
 ;;=^267303
 ;;^UTILITY(U,$J,358.3,8338,0)
 ;;=C75.8^^35^442^68
 ;;^UTILITY(U,$J,358.3,8338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8338,1,3,0)
 ;;=3^Malig Neop w/ Pluriglandular Involvement,Unspec
 ;;^UTILITY(U,$J,358.3,8338,1,4,0)
 ;;=4^C75.8
 ;;^UTILITY(U,$J,358.3,8338,2)
 ;;=^5001322
 ;;^UTILITY(U,$J,358.3,8339,0)
 ;;=C75.9^^35^442^59
 ;;^UTILITY(U,$J,358.3,8339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8339,1,3,0)
 ;;=3^Malig Neop of Endocrine Gland,Unspec
 ;;^UTILITY(U,$J,358.3,8339,1,4,0)
 ;;=4^C75.9
 ;;^UTILITY(U,$J,358.3,8339,2)
 ;;=^5001323
 ;;^UTILITY(U,$J,358.3,8340,0)
 ;;=E22.0^^35^442^2
 ;;^UTILITY(U,$J,358.3,8340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8340,1,3,0)
 ;;=3^Acromegaly and Pituitary Gigantism
 ;;^UTILITY(U,$J,358.3,8340,1,4,0)
 ;;=4^E22.0
 ;;^UTILITY(U,$J,358.3,8340,2)
 ;;=^5002717
 ;;^UTILITY(U,$J,358.3,8341,0)
 ;;=E24.0^^35^442^83
 ;;^UTILITY(U,$J,358.3,8341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8341,1,3,0)
 ;;=3^Pituitary-Dependent Cushing's Disease
 ;;^UTILITY(U,$J,358.3,8341,1,4,0)
 ;;=4^E24.0
 ;;^UTILITY(U,$J,358.3,8341,2)
 ;;=^5002725
 ;;^UTILITY(U,$J,358.3,8342,0)
 ;;=E24.1^^35^442^70
 ;;^UTILITY(U,$J,358.3,8342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8342,1,3,0)
 ;;=3^Nelson's Syndrome
 ;;^UTILITY(U,$J,358.3,8342,1,4,0)
 ;;=4^E24.1
 ;;^UTILITY(U,$J,358.3,8342,2)
 ;;=^5002726
 ;;^UTILITY(U,$J,358.3,8343,0)
 ;;=E24.2^^35^442^31
 ;;^UTILITY(U,$J,358.3,8343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8343,1,3,0)
 ;;=3^Drug-Induced Cushing's Syndrome
 ;;^UTILITY(U,$J,358.3,8343,1,4,0)
 ;;=4^E24.2
 ;;^UTILITY(U,$J,358.3,8343,2)
 ;;=^5002727
 ;;^UTILITY(U,$J,358.3,8344,0)
 ;;=E24.4^^35^442^5
 ;;^UTILITY(U,$J,358.3,8344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8344,1,3,0)
 ;;=3^Alcohol-Induced Pseudo-Cushing's Syndrome
 ;;^UTILITY(U,$J,358.3,8344,1,4,0)
 ;;=4^E24.4
 ;;^UTILITY(U,$J,358.3,8344,2)
 ;;=^5002729
 ;;^UTILITY(U,$J,358.3,8345,0)
 ;;=E24.8^^35^442^16
 ;;^UTILITY(U,$J,358.3,8345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8345,1,3,0)
 ;;=3^Cushing's Syndrome NEC
 ;;^UTILITY(U,$J,358.3,8345,1,4,0)
 ;;=4^E24.8
 ;;^UTILITY(U,$J,358.3,8345,2)
 ;;=^5002730
 ;;^UTILITY(U,$J,358.3,8346,0)
 ;;=E24.9^^35^442^17
 ;;^UTILITY(U,$J,358.3,8346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8346,1,3,0)
 ;;=3^Cushing's Syndrome,Unspec
 ;;^UTILITY(U,$J,358.3,8346,1,4,0)
 ;;=4^E24.9
 ;;^UTILITY(U,$J,358.3,8346,2)
 ;;=^5002731
 ;;^UTILITY(U,$J,358.3,8347,0)
 ;;=E05.00^^35^442^36
