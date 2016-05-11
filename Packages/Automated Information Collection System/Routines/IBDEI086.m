IBDEI086 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3526,1,3,0)
 ;;=3^Cerebrovascular Disease,Apraxia,Unspec
 ;;^UTILITY(U,$J,358.3,3526,1,4,0)
 ;;=4^I69.990
 ;;^UTILITY(U,$J,358.3,3526,2)
 ;;=^5007568
 ;;^UTILITY(U,$J,358.3,3527,0)
 ;;=I69.993^^18^220^17
 ;;^UTILITY(U,$J,358.3,3527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3527,1,3,0)
 ;;=3^Cerebrovascular Disease,Ataxia,Unspec
 ;;^UTILITY(U,$J,358.3,3527,1,4,0)
 ;;=4^I69.993
 ;;^UTILITY(U,$J,358.3,3527,2)
 ;;=^5007571
 ;;^UTILITY(U,$J,358.3,3528,0)
 ;;=I69.91^^18^220^18
 ;;^UTILITY(U,$J,358.3,3528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3528,1,3,0)
 ;;=3^Cerebrovascular Disease,Cognitive Deficits,Unspec
 ;;^UTILITY(U,$J,358.3,3528,1,4,0)
 ;;=4^I69.91
 ;;^UTILITY(U,$J,358.3,3528,2)
 ;;=^5007552
 ;;^UTILITY(U,$J,358.3,3529,0)
 ;;=I69.922^^18^220^19
 ;;^UTILITY(U,$J,358.3,3529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3529,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysarthria,Unspec
 ;;^UTILITY(U,$J,358.3,3529,1,4,0)
 ;;=4^I69.922
 ;;^UTILITY(U,$J,358.3,3529,2)
 ;;=^5007555
 ;;^UTILITY(U,$J,358.3,3530,0)
 ;;=I69.991^^18^220^20
 ;;^UTILITY(U,$J,358.3,3530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3530,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysphagia
 ;;^UTILITY(U,$J,358.3,3530,1,4,0)
 ;;=4^I69.991
 ;;^UTILITY(U,$J,358.3,3530,2)
 ;;=^5007569
 ;;^UTILITY(U,$J,358.3,3531,0)
 ;;=I69.921^^18^220^21
 ;;^UTILITY(U,$J,358.3,3531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3531,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysphasia
 ;;^UTILITY(U,$J,358.3,3531,1,4,0)
 ;;=4^I69.921
 ;;^UTILITY(U,$J,358.3,3531,2)
 ;;=^5007554
 ;;^UTILITY(U,$J,358.3,3532,0)
 ;;=I69.992^^18^220^22
 ;;^UTILITY(U,$J,358.3,3532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3532,1,3,0)
 ;;=3^Cerebrovascular Disease,Facial Weakness
 ;;^UTILITY(U,$J,358.3,3532,1,4,0)
 ;;=4^I69.992
 ;;^UTILITY(U,$J,358.3,3532,2)
 ;;=^5007570
 ;;^UTILITY(U,$J,358.3,3533,0)
 ;;=I69.923^^18^220^23
 ;;^UTILITY(U,$J,358.3,3533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3533,1,3,0)
 ;;=3^Cerebrovascular Disease,Fluency Disorder
 ;;^UTILITY(U,$J,358.3,3533,1,4,0)
 ;;=4^I69.923
 ;;^UTILITY(U,$J,358.3,3533,2)
 ;;=^5007556
 ;;^UTILITY(U,$J,358.3,3534,0)
 ;;=I69.952^^18^220^24
 ;;^UTILITY(U,$J,358.3,3534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3534,1,3,0)
 ;;=3^Cerebrovascular Disease,Hemiplegia/Hemiparesis,Left Dominant Side
 ;;^UTILITY(U,$J,358.3,3534,1,4,0)
 ;;=4^I69.952
 ;;^UTILITY(U,$J,358.3,3534,2)
 ;;=^5133586
 ;;^UTILITY(U,$J,358.3,3535,0)
 ;;=I69.954^^18^220^25
 ;;^UTILITY(U,$J,358.3,3535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3535,1,3,0)
 ;;=3^Cerebrovascular Disease,Hemiplegia/Hemiparesis,Left Nondominant Side
 ;;^UTILITY(U,$J,358.3,3535,1,4,0)
 ;;=4^I69.954
 ;;^UTILITY(U,$J,358.3,3535,2)
 ;;=^5133587
 ;;^UTILITY(U,$J,358.3,3536,0)
 ;;=I69.951^^18^220^26
 ;;^UTILITY(U,$J,358.3,3536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3536,1,3,0)
 ;;=3^Cerebrovascular Disease,Hemiplegia/Hemiparesis,Right Dominant Side
 ;;^UTILITY(U,$J,358.3,3536,1,4,0)
 ;;=4^I69.951
 ;;^UTILITY(U,$J,358.3,3536,2)
 ;;=^5007561
 ;;^UTILITY(U,$J,358.3,3537,0)
 ;;=I69.953^^18^220^27
 ;;^UTILITY(U,$J,358.3,3537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3537,1,3,0)
 ;;=3^Cerebrovascular Disease,Hemiplegia/Hemiparesis,Right Nondominant Side
 ;;^UTILITY(U,$J,358.3,3537,1,4,0)
 ;;=4^I69.953
 ;;^UTILITY(U,$J,358.3,3537,2)
 ;;=^5007562
 ;;^UTILITY(U,$J,358.3,3538,0)
 ;;=I69.942^^18^220^28
 ;;^UTILITY(U,$J,358.3,3538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3538,1,3,0)
 ;;=3^Cerebrovascular Disease,Monoplegia,Lt Lower Dominant Side
 ;;^UTILITY(U,$J,358.3,3538,1,4,0)
 ;;=4^I69.942
