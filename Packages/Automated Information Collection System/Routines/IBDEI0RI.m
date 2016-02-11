IBDEI0RI ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12622,1,3,0)
 ;;=3^Dysphagia, pharyngeal phase
 ;;^UTILITY(U,$J,358.3,12622,1,4,0)
 ;;=4^R13.13
 ;;^UTILITY(U,$J,358.3,12622,2)
 ;;=^335278
 ;;^UTILITY(U,$J,358.3,12623,0)
 ;;=R13.14^^77^733^4
 ;;^UTILITY(U,$J,358.3,12623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12623,1,3,0)
 ;;=3^Dysphagia, pharyngoesophageal phase
 ;;^UTILITY(U,$J,358.3,12623,1,4,0)
 ;;=4^R13.14
 ;;^UTILITY(U,$J,358.3,12623,2)
 ;;=^335279
 ;;^UTILITY(U,$J,358.3,12624,0)
 ;;=S02.2XXA^^77^734^2
 ;;^UTILITY(U,$J,358.3,12624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12624,1,3,0)
 ;;=3^Fracture of nasal bones, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,12624,1,4,0)
 ;;=4^S02.2XXA
 ;;^UTILITY(U,$J,358.3,12624,2)
 ;;=^5020306
 ;;^UTILITY(U,$J,358.3,12625,0)
 ;;=S02.609A^^77^734^1
 ;;^UTILITY(U,$J,358.3,12625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12625,1,3,0)
 ;;=3^Fracture of mandible, unsp, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,12625,1,4,0)
 ;;=4^S02.609A
 ;;^UTILITY(U,$J,358.3,12625,2)
 ;;=^5020372
 ;;^UTILITY(U,$J,358.3,12626,0)
 ;;=S02.92XA^^77^734^4
 ;;^UTILITY(U,$J,358.3,12626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12626,1,3,0)
 ;;=3^Fracture of unsp facial bones, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,12626,1,4,0)
 ;;=4^S02.92XA
 ;;^UTILITY(U,$J,358.3,12626,2)
 ;;=^5020438
 ;;^UTILITY(U,$J,358.3,12627,0)
 ;;=S02.3XXA^^77^734^3
 ;;^UTILITY(U,$J,358.3,12627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12627,1,3,0)
 ;;=3^Fracture of orbital floor, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,12627,1,4,0)
 ;;=4^S02.3XXA
 ;;^UTILITY(U,$J,358.3,12627,2)
 ;;=^5020312
 ;;^UTILITY(U,$J,358.3,12628,0)
 ;;=S02.92XB^^77^734^5
 ;;^UTILITY(U,$J,358.3,12628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12628,1,3,0)
 ;;=3^Fracture of unsp facial bones, init encntr for open fracture
 ;;^UTILITY(U,$J,358.3,12628,1,4,0)
 ;;=4^S02.92XB
 ;;^UTILITY(U,$J,358.3,12628,2)
 ;;=^5020439
 ;;^UTILITY(U,$J,358.3,12629,0)
 ;;=C00.2^^77^735^13
 ;;^UTILITY(U,$J,358.3,12629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12629,1,3,0)
 ;;=3^Malignant neoplasm of external lip, unspecified
 ;;^UTILITY(U,$J,358.3,12629,1,4,0)
 ;;=4^C00.2
 ;;^UTILITY(U,$J,358.3,12629,2)
 ;;=^5000884
 ;;^UTILITY(U,$J,358.3,12630,0)
 ;;=C02.9^^77^735^30
 ;;^UTILITY(U,$J,358.3,12630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12630,1,3,0)
 ;;=3^Malignant neoplasm of tongue, unspecified
 ;;^UTILITY(U,$J,358.3,12630,1,4,0)
 ;;=4^C02.9
 ;;^UTILITY(U,$J,358.3,12630,2)
 ;;=^5000891
 ;;^UTILITY(U,$J,358.3,12631,0)
 ;;=C07.^^77^735^24
 ;;^UTILITY(U,$J,358.3,12631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12631,1,3,0)
 ;;=3^Malignant neoplasm of parotid gland
 ;;^UTILITY(U,$J,358.3,12631,1,4,0)
 ;;=4^C07.
 ;;^UTILITY(U,$J,358.3,12631,2)
 ;;=^267005
 ;;^UTILITY(U,$J,358.3,12632,0)
 ;;=C08.0^^77^735^27
 ;;^UTILITY(U,$J,358.3,12632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12632,1,3,0)
 ;;=3^Malignant neoplasm of submandibular gland
 ;;^UTILITY(U,$J,358.3,12632,1,4,0)
 ;;=4^C08.0
 ;;^UTILITY(U,$J,358.3,12632,2)
 ;;=^267006
 ;;^UTILITY(U,$J,358.3,12633,0)
 ;;=C03.9^^77^735^16
 ;;^UTILITY(U,$J,358.3,12633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12633,1,3,0)
 ;;=3^Malignant neoplasm of gum, unspecified
 ;;^UTILITY(U,$J,358.3,12633,1,4,0)
 ;;=4^C03.9
 ;;^UTILITY(U,$J,358.3,12633,2)
 ;;=^5000892
 ;;^UTILITY(U,$J,358.3,12634,0)
 ;;=C04.9^^77^735^14
 ;;^UTILITY(U,$J,358.3,12634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12634,1,3,0)
 ;;=3^Malignant neoplasm of floor of mouth, unspecified
