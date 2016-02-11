IBDEI3FO ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,57765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57765,1,3,0)
 ;;=3^Artificial Opening Urinary Tract Status
 ;;^UTILITY(U,$J,358.3,57765,1,4,0)
 ;;=4^Z93.6
 ;;^UTILITY(U,$J,358.3,57765,2)
 ;;=^5063651
 ;;^UTILITY(U,$J,358.3,57766,0)
 ;;=Z93.0^^270^2895^17
 ;;^UTILITY(U,$J,358.3,57766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57766,1,3,0)
 ;;=3^Tracheostomy Status
 ;;^UTILITY(U,$J,358.3,57766,1,4,0)
 ;;=4^Z93.0
 ;;^UTILITY(U,$J,358.3,57766,2)
 ;;=^5063642
 ;;^UTILITY(U,$J,358.3,57767,0)
 ;;=E10.620^^270^2896^1
 ;;^UTILITY(U,$J,358.3,57767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57767,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,57767,1,4,0)
 ;;=4^E10.620
 ;;^UTILITY(U,$J,358.3,57767,2)
 ;;=^5002615
 ;;^UTILITY(U,$J,358.3,57768,0)
 ;;=E10.40^^270^2896^2
 ;;^UTILITY(U,$J,358.3,57768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57768,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,57768,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,57768,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,57769,0)
 ;;=E10.51^^270^2896^3
 ;;^UTILITY(U,$J,358.3,57769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57769,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopath w/o Gangrene
 ;;^UTILITY(U,$J,358.3,57769,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,57769,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,57770,0)
 ;;=E10.621^^270^2896^4
 ;;^UTILITY(U,$J,358.3,57770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57770,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,57770,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,57770,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,57771,0)
 ;;=E10.628^^270^2896^5
 ;;^UTILITY(U,$J,358.3,57771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57771,1,3,0)
 ;;=3^Diabetes Type 1 w/ Oth Skin Complications
 ;;^UTILITY(U,$J,358.3,57771,1,4,0)
 ;;=4^E10.628
 ;;^UTILITY(U,$J,358.3,57771,2)
 ;;=^5002618
 ;;^UTILITY(U,$J,358.3,57772,0)
 ;;=E10.622^^270^2896^6
 ;;^UTILITY(U,$J,358.3,57772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57772,1,3,0)
 ;;=3^Diabetes Type 1 w/ Oth Skin Ulcer
 ;;^UTILITY(U,$J,358.3,57772,1,4,0)
 ;;=4^E10.622
 ;;^UTILITY(U,$J,358.3,57772,2)
 ;;=^5002617
 ;;^UTILITY(U,$J,358.3,57773,0)
 ;;=E11.620^^270^2896^7
 ;;^UTILITY(U,$J,358.3,57773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57773,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,57773,1,4,0)
 ;;=4^E11.620
 ;;^UTILITY(U,$J,358.3,57773,2)
 ;;=^5002655
 ;;^UTILITY(U,$J,358.3,57774,0)
 ;;=E11.40^^270^2896^8
 ;;^UTILITY(U,$J,358.3,57774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57774,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,57774,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,57774,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,57775,0)
 ;;=E11.51^^270^2896^9
 ;;^UTILITY(U,$J,358.3,57775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57775,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Peripheral Angiopath w/o Gangrene
 ;;^UTILITY(U,$J,358.3,57775,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,57775,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,57776,0)
 ;;=E11.621^^270^2896^10
 ;;^UTILITY(U,$J,358.3,57776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57776,1,3,0)
 ;;=3^Diabetes Type 2 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,57776,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,57776,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,57777,0)
 ;;=E11.618^^270^2896^11
 ;;^UTILITY(U,$J,358.3,57777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57777,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oth Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,57777,1,4,0)
 ;;=4^E11.618
