IBDEI09X ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4401,1,4,0)
 ;;=4^C43.61
 ;;^UTILITY(U,$J,358.3,4401,2)
 ;;=^5001009
 ;;^UTILITY(U,$J,358.3,4402,0)
 ;;=C43.62^^21^277^6
 ;;^UTILITY(U,$J,358.3,4402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4402,1,3,0)
 ;;=3^Malig Melanoma of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,4402,1,4,0)
 ;;=4^C43.62
 ;;^UTILITY(U,$J,358.3,4402,2)
 ;;=^5001010
 ;;^UTILITY(U,$J,358.3,4403,0)
 ;;=C43.71^^21^277^12
 ;;^UTILITY(U,$J,358.3,4403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4403,1,3,0)
 ;;=3^Malig Melanoma of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,4403,1,4,0)
 ;;=4^C43.71
 ;;^UTILITY(U,$J,358.3,4403,2)
 ;;=^5001012
 ;;^UTILITY(U,$J,358.3,4404,0)
 ;;=C43.72^^21^277^5
 ;;^UTILITY(U,$J,358.3,4404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4404,1,3,0)
 ;;=3^Malig Melanoma of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,4404,1,4,0)
 ;;=4^C43.72
 ;;^UTILITY(U,$J,358.3,4404,2)
 ;;=^5001013
 ;;^UTILITY(U,$J,358.3,4405,0)
 ;;=C43.8^^21^277^9
 ;;^UTILITY(U,$J,358.3,4405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4405,1,3,0)
 ;;=3^Malig Melanoma of Overlapping Sites of Skin
 ;;^UTILITY(U,$J,358.3,4405,1,4,0)
 ;;=4^C43.8
 ;;^UTILITY(U,$J,358.3,4405,2)
 ;;=^5001014
 ;;^UTILITY(U,$J,358.3,4406,0)
 ;;=D03.0^^21^277^60
 ;;^UTILITY(U,$J,358.3,4406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4406,1,3,0)
 ;;=3^Melanoma in Situ of Lip
 ;;^UTILITY(U,$J,358.3,4406,1,4,0)
 ;;=4^D03.0
 ;;^UTILITY(U,$J,358.3,4406,2)
 ;;=^5001888
 ;;^UTILITY(U,$J,358.3,4407,0)
 ;;=D03.11^^21^277^54
 ;;^UTILITY(U,$J,358.3,4407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4407,1,3,0)
 ;;=3^Melanoma in Situ Right Eyelid
 ;;^UTILITY(U,$J,358.3,4407,1,4,0)
 ;;=4^D03.11
 ;;^UTILITY(U,$J,358.3,4407,2)
 ;;=^5001890
 ;;^UTILITY(U,$J,358.3,4408,0)
 ;;=D03.12^^21^277^50
 ;;^UTILITY(U,$J,358.3,4408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4408,1,3,0)
 ;;=3^Melanoma in Situ Left Eyelid
 ;;^UTILITY(U,$J,358.3,4408,1,4,0)
 ;;=4^D03.12
 ;;^UTILITY(U,$J,358.3,4408,2)
 ;;=^5001891
 ;;^UTILITY(U,$J,358.3,4409,0)
 ;;=D03.21^^21^277^53
 ;;^UTILITY(U,$J,358.3,4409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4409,1,3,0)
 ;;=3^Melanoma in Situ Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,4409,1,4,0)
 ;;=4^D03.21
 ;;^UTILITY(U,$J,358.3,4409,2)
 ;;=^5001893
 ;;^UTILITY(U,$J,358.3,4410,0)
 ;;=D03.22^^21^277^49
 ;;^UTILITY(U,$J,358.3,4410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4410,1,3,0)
 ;;=3^Melanoma in Situ Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,4410,1,4,0)
 ;;=4^D03.22
 ;;^UTILITY(U,$J,358.3,4410,2)
 ;;=^5001894
 ;;^UTILITY(U,$J,358.3,4411,0)
 ;;=D03.30^^21^277^59
 ;;^UTILITY(U,$J,358.3,4411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4411,1,3,0)
 ;;=3^Melanoma in Situ Unspec Part of Face
 ;;^UTILITY(U,$J,358.3,4411,1,4,0)
 ;;=4^D03.30
 ;;^UTILITY(U,$J,358.3,4411,2)
 ;;=^5001895
 ;;^UTILITY(U,$J,358.3,4412,0)
 ;;=D03.4^^21^277^57
 ;;^UTILITY(U,$J,358.3,4412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4412,1,3,0)
 ;;=3^Melanoma in Situ Scalp/Neck
 ;;^UTILITY(U,$J,358.3,4412,1,4,0)
 ;;=4^D03.4
 ;;^UTILITY(U,$J,358.3,4412,2)
 ;;=^5001897
 ;;^UTILITY(U,$J,358.3,4413,0)
 ;;=D03.59^^21^277^58
 ;;^UTILITY(U,$J,358.3,4413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4413,1,3,0)
 ;;=3^Melanoma in Situ Trunk,Other Part
 ;;^UTILITY(U,$J,358.3,4413,1,4,0)
 ;;=4^D03.59
 ;;^UTILITY(U,$J,358.3,4413,2)
 ;;=^5001900
 ;;^UTILITY(U,$J,358.3,4414,0)
 ;;=D03.51^^21^277^47
 ;;^UTILITY(U,$J,358.3,4414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4414,1,3,0)
 ;;=3^Melanoma in Situ Anal Skin
 ;;^UTILITY(U,$J,358.3,4414,1,4,0)
 ;;=4^D03.51
