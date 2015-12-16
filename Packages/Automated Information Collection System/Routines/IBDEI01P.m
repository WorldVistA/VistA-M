IBDEI01P ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,238,1,3,0)
 ;;=3^Adjust/Mgmt of Bone Conduction Device
 ;;^UTILITY(U,$J,358.3,238,1,4,0)
 ;;=4^Z45.320
 ;;^UTILITY(U,$J,358.3,238,2)
 ;;=^5063001
 ;;^UTILITY(U,$J,358.3,239,0)
 ;;=Z45.321^^1^11^2
 ;;^UTILITY(U,$J,358.3,239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,239,1,3,0)
 ;;=3^Adjust/Mgmt of Cochlear Device
 ;;^UTILITY(U,$J,358.3,239,1,4,0)
 ;;=4^Z45.321
 ;;^UTILITY(U,$J,358.3,239,2)
 ;;=^5063002
 ;;^UTILITY(U,$J,358.3,240,0)
 ;;=Z45.328^^1^11^3
 ;;^UTILITY(U,$J,358.3,240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,240,1,3,0)
 ;;=3^Adjust/Mgmt of Implanted Hearing Device
 ;;^UTILITY(U,$J,358.3,240,1,4,0)
 ;;=4^Z45.328
 ;;^UTILITY(U,$J,358.3,240,2)
 ;;=^5063003
 ;;^UTILITY(U,$J,358.3,241,0)
 ;;=Z02.71^^1^11^4
 ;;^UTILITY(U,$J,358.3,241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,241,1,3,0)
 ;;=3^Disability Determination Exam
 ;;^UTILITY(U,$J,358.3,241,1,4,0)
 ;;=4^Z02.71
 ;;^UTILITY(U,$J,358.3,241,2)
 ;;=^5062640
 ;;^UTILITY(U,$J,358.3,242,0)
 ;;=Z02.0^^1^11^7
 ;;^UTILITY(U,$J,358.3,242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,242,1,3,0)
 ;;=3^Exam for Admission to Educational Institution
 ;;^UTILITY(U,$J,358.3,242,1,4,0)
 ;;=4^Z02.0
 ;;^UTILITY(U,$J,358.3,242,2)
 ;;=^5062633
 ;;^UTILITY(U,$J,358.3,243,0)
 ;;=Z02.2^^1^11^8
 ;;^UTILITY(U,$J,358.3,243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,243,1,3,0)
 ;;=3^Exam for Admission to Residential Institution
 ;;^UTILITY(U,$J,358.3,243,1,4,0)
 ;;=4^Z02.2
 ;;^UTILITY(U,$J,358.3,243,2)
 ;;=^5062635
 ;;^UTILITY(U,$J,358.3,244,0)
 ;;=Z02.4^^1^11^9
 ;;^UTILITY(U,$J,358.3,244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,244,1,3,0)
 ;;=3^Exam for Driving License
 ;;^UTILITY(U,$J,358.3,244,1,4,0)
 ;;=4^Z02.4
 ;;^UTILITY(U,$J,358.3,244,2)
 ;;=^5062637
 ;;^UTILITY(U,$J,358.3,245,0)
 ;;=Z02.6^^1^11^11
 ;;^UTILITY(U,$J,358.3,245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,245,1,3,0)
 ;;=3^Exam for Insurance Purposes
 ;;^UTILITY(U,$J,358.3,245,1,4,0)
 ;;=4^Z02.6
 ;;^UTILITY(U,$J,358.3,245,2)
 ;;=^5062639
 ;;^UTILITY(U,$J,358.3,246,0)
 ;;=Z02.5^^1^11^13
 ;;^UTILITY(U,$J,358.3,246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,246,1,3,0)
 ;;=3^Exam for Sport Participation
 ;;^UTILITY(U,$J,358.3,246,1,4,0)
 ;;=4^Z02.5
 ;;^UTILITY(U,$J,358.3,246,2)
 ;;=^5062638
 ;;^UTILITY(U,$J,358.3,247,0)
 ;;=Z02.3^^1^11^12
 ;;^UTILITY(U,$J,358.3,247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,247,1,3,0)
 ;;=3^Exam for Recruitment to Armed Forces
 ;;^UTILITY(U,$J,358.3,247,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,247,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,248,0)
 ;;=Z01.118^^1^11^5
 ;;^UTILITY(U,$J,358.3,248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,248,1,3,0)
 ;;=3^Ears/Hearing Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,248,1,4,0)
 ;;=4^Z01.118
 ;;^UTILITY(U,$J,358.3,248,2)
 ;;=^5062616
 ;;^UTILITY(U,$J,358.3,249,0)
 ;;=Z01.10^^1^11^6
 ;;^UTILITY(U,$J,358.3,249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,249,1,3,0)
 ;;=3^Ears/Hearing Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,249,1,4,0)
 ;;=4^Z01.10
 ;;^UTILITY(U,$J,358.3,249,2)
 ;;=^5062614
 ;;^UTILITY(U,$J,358.3,250,0)
 ;;=Z46.1^^1^11^18
 ;;^UTILITY(U,$J,358.3,250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,250,1,3,0)
 ;;=3^Fitting/Adjustment of Hearing Aid
 ;;^UTILITY(U,$J,358.3,250,1,4,0)
 ;;=4^Z46.1
 ;;^UTILITY(U,$J,358.3,250,2)
 ;;=^5063014
 ;;^UTILITY(U,$J,358.3,251,0)
 ;;=Z09.^^1^11^15
 ;;^UTILITY(U,$J,358.3,251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,251,1,3,0)
 ;;=3^F/U Exam After Trtmt for Cond Oth Than Malig Neop
 ;;^UTILITY(U,$J,358.3,251,1,4,0)
 ;;=4^Z09.
