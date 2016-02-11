IBDEI02U ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,566,1,4,0)
 ;;=4^E11.36
 ;;^UTILITY(U,$J,358.3,566,2)
 ;;=^5002642
 ;;^UTILITY(U,$J,358.3,567,0)
 ;;=E11.39^^6^69^49
 ;;^UTILITY(U,$J,358.3,567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,567,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Ophthalmic Complication
 ;;^UTILITY(U,$J,358.3,567,1,4,0)
 ;;=4^E11.39
 ;;^UTILITY(U,$J,358.3,567,2)
 ;;=^5002643
 ;;^UTILITY(U,$J,358.3,568,0)
 ;;=E11.40^^6^69^48
 ;;^UTILITY(U,$J,358.3,568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,568,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy
 ;;^UTILITY(U,$J,358.3,568,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,568,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,569,0)
 ;;=E11.49^^6^69^46
 ;;^UTILITY(U,$J,358.3,569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,569,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neurological Complication
 ;;^UTILITY(U,$J,358.3,569,1,4,0)
 ;;=4^E11.49
 ;;^UTILITY(U,$J,358.3,569,2)
 ;;=^5002649
 ;;^UTILITY(U,$J,358.3,570,0)
 ;;=E11.41^^6^69^44
 ;;^UTILITY(U,$J,358.3,570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,570,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Mononeuropathy
 ;;^UTILITY(U,$J,358.3,570,1,4,0)
 ;;=4^E11.41
 ;;^UTILITY(U,$J,358.3,570,2)
 ;;=^5002645
 ;;^UTILITY(U,$J,358.3,571,0)
 ;;=E11.42^^6^69^51
 ;;^UTILITY(U,$J,358.3,571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,571,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,571,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,571,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,572,0)
 ;;=E11.43^^6^69^39
 ;;^UTILITY(U,$J,358.3,572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,572,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,572,1,4,0)
 ;;=4^E11.43
 ;;^UTILITY(U,$J,358.3,572,2)
 ;;=^5002647
 ;;^UTILITY(U,$J,358.3,573,0)
 ;;=E11.44^^6^69^37
 ;;^UTILITY(U,$J,358.3,573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,573,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Amyotrophy
 ;;^UTILITY(U,$J,358.3,573,1,4,0)
 ;;=4^E11.44
 ;;^UTILITY(U,$J,358.3,573,2)
 ;;=^5002648
 ;;^UTILITY(U,$J,358.3,574,0)
 ;;=E11.51^^6^69^50
 ;;^UTILITY(U,$J,358.3,574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,574,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,574,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,574,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,575,0)
 ;;=E11.59^^6^69^36
 ;;^UTILITY(U,$J,358.3,575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,575,1,3,0)
 ;;=3^Diabetes Type 2 w/ Circulatory Complications
 ;;^UTILITY(U,$J,358.3,575,1,4,0)
 ;;=4^E11.59
 ;;^UTILITY(U,$J,358.3,575,2)
 ;;=^5002652
 ;;^UTILITY(U,$J,358.3,576,0)
 ;;=E11.610^^6^69^47
 ;;^UTILITY(U,$J,358.3,576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,576,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,576,1,4,0)
 ;;=4^E11.610
 ;;^UTILITY(U,$J,358.3,576,2)
 ;;=^5002653
 ;;^UTILITY(U,$J,358.3,577,0)
 ;;=E11.618^^6^69^38
 ;;^UTILITY(U,$J,358.3,577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,577,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,577,1,4,0)
 ;;=4^E11.618
 ;;^UTILITY(U,$J,358.3,577,2)
 ;;=^5002654
 ;;^UTILITY(U,$J,358.3,578,0)
 ;;=E11.620^^6^69^42
 ;;^UTILITY(U,$J,358.3,578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,578,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,578,1,4,0)
 ;;=4^E11.620
 ;;^UTILITY(U,$J,358.3,578,2)
 ;;=^5002655
 ;;^UTILITY(U,$J,358.3,579,0)
 ;;=E11.621^^6^69^54
 ;;^UTILITY(U,$J,358.3,579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,579,1,3,0)
 ;;=3^Diabetes Type 2 w/ Foot Ulcer
