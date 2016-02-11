IBDEI10X ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17035,1,3,0)
 ;;=3^Cerebrovascular Disease,Dysphasia
 ;;^UTILITY(U,$J,358.3,17035,1,4,0)
 ;;=4^I69.921
 ;;^UTILITY(U,$J,358.3,17035,2)
 ;;=^5007554
 ;;^UTILITY(U,$J,358.3,17036,0)
 ;;=I69.992^^88^857^22
 ;;^UTILITY(U,$J,358.3,17036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17036,1,3,0)
 ;;=3^Cerebrovascular Disease,Facial Weakness
 ;;^UTILITY(U,$J,358.3,17036,1,4,0)
 ;;=4^I69.992
 ;;^UTILITY(U,$J,358.3,17036,2)
 ;;=^5007570
 ;;^UTILITY(U,$J,358.3,17037,0)
 ;;=I69.923^^88^857^23
 ;;^UTILITY(U,$J,358.3,17037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17037,1,3,0)
 ;;=3^Cerebrovascular Disease,Fluency Disorder
 ;;^UTILITY(U,$J,358.3,17037,1,4,0)
 ;;=4^I69.923
 ;;^UTILITY(U,$J,358.3,17037,2)
 ;;=^5007556
 ;;^UTILITY(U,$J,358.3,17038,0)
 ;;=I69.952^^88^857^24
 ;;^UTILITY(U,$J,358.3,17038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17038,1,3,0)
 ;;=3^Cerebrovascular Disease,Hemiplegia/Hemiparesis,Left Dominant Side
 ;;^UTILITY(U,$J,358.3,17038,1,4,0)
 ;;=4^I69.952
 ;;^UTILITY(U,$J,358.3,17038,2)
 ;;=^5133586
 ;;^UTILITY(U,$J,358.3,17039,0)
 ;;=I69.954^^88^857^25
 ;;^UTILITY(U,$J,358.3,17039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17039,1,3,0)
 ;;=3^Cerebrovascular Disease,Hemiplegia/Hemiparesis,Left Nondominant Side
 ;;^UTILITY(U,$J,358.3,17039,1,4,0)
 ;;=4^I69.954
 ;;^UTILITY(U,$J,358.3,17039,2)
 ;;=^5133587
 ;;^UTILITY(U,$J,358.3,17040,0)
 ;;=I69.951^^88^857^26
 ;;^UTILITY(U,$J,358.3,17040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17040,1,3,0)
 ;;=3^Cerebrovascular Disease,Hemiplegia/Hemiparesis,Right Dominant Side
 ;;^UTILITY(U,$J,358.3,17040,1,4,0)
 ;;=4^I69.951
 ;;^UTILITY(U,$J,358.3,17040,2)
 ;;=^5007561
 ;;^UTILITY(U,$J,358.3,17041,0)
 ;;=I69.953^^88^857^27
 ;;^UTILITY(U,$J,358.3,17041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17041,1,3,0)
 ;;=3^Cerebrovascular Disease,Hemiplegia/Hemiparesis,Right Nondominant Side
 ;;^UTILITY(U,$J,358.3,17041,1,4,0)
 ;;=4^I69.953
 ;;^UTILITY(U,$J,358.3,17041,2)
 ;;=^5007562
 ;;^UTILITY(U,$J,358.3,17042,0)
 ;;=I69.942^^88^857^28
 ;;^UTILITY(U,$J,358.3,17042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17042,1,3,0)
 ;;=3^Cerebrovascular Disease,Monoplegia,Lt Lower Dominant Side
 ;;^UTILITY(U,$J,358.3,17042,1,4,0)
 ;;=4^I69.942
 ;;^UTILITY(U,$J,358.3,17042,2)
 ;;=^5133582
 ;;^UTILITY(U,$J,358.3,17043,0)
 ;;=I69.944^^88^857^29
 ;;^UTILITY(U,$J,358.3,17043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17043,1,3,0)
 ;;=3^Cerebrovascular Disease,Monoplegia,Lt Lower Nondominant Side
 ;;^UTILITY(U,$J,358.3,17043,1,4,0)
 ;;=4^I69.944
 ;;^UTILITY(U,$J,358.3,17043,2)
 ;;=^5133585
 ;;^UTILITY(U,$J,358.3,17044,0)
 ;;=I69.932^^88^857^30
 ;;^UTILITY(U,$J,358.3,17044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17044,1,3,0)
 ;;=3^Cerebrovascular Disease,Monoplegia,Lt Upper Dominant Side
 ;;^UTILITY(U,$J,358.3,17044,1,4,0)
 ;;=4^I69.932
 ;;^UTILITY(U,$J,358.3,17044,2)
 ;;=^5133580
 ;;^UTILITY(U,$J,358.3,17045,0)
 ;;=I69.934^^88^857^31
 ;;^UTILITY(U,$J,358.3,17045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17045,1,3,0)
 ;;=3^Cerebrovascular Disease,Monoplegia,Lt Upper Nondominant Side
 ;;^UTILITY(U,$J,358.3,17045,1,4,0)
 ;;=4^I69.934
 ;;^UTILITY(U,$J,358.3,17045,2)
 ;;=^5133583
 ;;^UTILITY(U,$J,358.3,17046,0)
 ;;=I69.941^^88^857^32
 ;;^UTILITY(U,$J,358.3,17046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17046,1,3,0)
 ;;=3^Cerebrovascular Disease,Monoplegia,Rt Lower Dominant Side
 ;;^UTILITY(U,$J,358.3,17046,1,4,0)
 ;;=4^I69.941
 ;;^UTILITY(U,$J,358.3,17046,2)
 ;;=^5133581
