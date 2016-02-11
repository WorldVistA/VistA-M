IBDEI2W6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48556,0)
 ;;=I42.5^^216^2408^32
 ;;^UTILITY(U,$J,358.3,48556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48556,1,3,0)
 ;;=3^Restrictive cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,48556,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,48556,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,48557,0)
 ;;=Z95.1^^216^2408^29
 ;;^UTILITY(U,$J,358.3,48557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48557,1,3,0)
 ;;=3^Presence of aortocoronary bypass graft
 ;;^UTILITY(U,$J,358.3,48557,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,48557,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,48558,0)
 ;;=Z95.0^^216^2408^30
 ;;^UTILITY(U,$J,358.3,48558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48558,1,3,0)
 ;;=3^Presence of cardiac pacemaker
 ;;^UTILITY(U,$J,358.3,48558,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,48558,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,48559,0)
 ;;=Z95.5^^216^2408^31
 ;;^UTILITY(U,$J,358.3,48559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48559,1,3,0)
 ;;=3^Presence of coronary angioplasty implant and graft
 ;;^UTILITY(U,$J,358.3,48559,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,48559,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,48560,0)
 ;;=I21.3^^216^2408^33
 ;;^UTILITY(U,$J,358.3,48560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48560,1,3,0)
 ;;=3^ST elevation (STEMI) myocardial infarction of unsp site
 ;;^UTILITY(U,$J,358.3,48560,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,48560,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,48561,0)
 ;;=J43.0^^216^2408^35
 ;;^UTILITY(U,$J,358.3,48561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48561,1,3,0)
 ;;=3^Unilateral pulmonary emphysema [MacLeod's syndrome]
 ;;^UTILITY(U,$J,358.3,48561,1,4,0)
 ;;=4^J43.0
 ;;^UTILITY(U,$J,358.3,48561,2)
 ;;=^5008235
 ;;^UTILITY(U,$J,358.3,48562,0)
 ;;=I50.40^^216^2408^19
 ;;^UTILITY(U,$J,358.3,48562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48562,1,3,0)
 ;;=3^Combined systolic and diastolic (congestive) hrt fail,Unspec
 ;;^UTILITY(U,$J,358.3,48562,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,48562,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,48563,0)
 ;;=I50.30^^216^2408^21
 ;;^UTILITY(U,$J,358.3,48563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48563,1,3,0)
 ;;=3^Diastolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,48563,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,48563,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,48564,0)
 ;;=I50.20^^216^2408^34
 ;;^UTILITY(U,$J,358.3,48564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48564,1,3,0)
 ;;=3^Systolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,48564,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,48564,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,48565,0)
 ;;=T84.81XA^^216^2409^4
 ;;^UTILITY(U,$J,358.3,48565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48565,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,48565,1,4,0)
 ;;=4^T84.81XA
 ;;^UTILITY(U,$J,358.3,48565,2)
 ;;=^5055454
 ;;^UTILITY(U,$J,358.3,48566,0)
 ;;=T84.81XS^^216^2409^5
 ;;^UTILITY(U,$J,358.3,48566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48566,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,48566,1,4,0)
 ;;=4^T84.81XS
 ;;^UTILITY(U,$J,358.3,48566,2)
 ;;=^5055456
 ;;^UTILITY(U,$J,358.3,48567,0)
 ;;=T84.81XD^^216^2409^6
 ;;^UTILITY(U,$J,358.3,48567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48567,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,48567,1,4,0)
 ;;=4^T84.81XD
 ;;^UTILITY(U,$J,358.3,48567,2)
 ;;=^5055455
 ;;^UTILITY(U,$J,358.3,48568,0)
 ;;=T84.82XA^^216^2409^7
