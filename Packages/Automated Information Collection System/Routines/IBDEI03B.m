IBDEI03B ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3906,1,4,0)
 ;;=4^C44.90
 ;;^UTILITY(U,$J,358.3,3906,2)
 ;;=^5001091
 ;;^UTILITY(U,$J,358.3,3907,0)
 ;;=C43.9^^20^271^16
 ;;^UTILITY(U,$J,358.3,3907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3907,1,3,0)
 ;;=3^Malig Melanoma of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,3907,1,4,0)
 ;;=4^C43.9
 ;;^UTILITY(U,$J,358.3,3907,2)
 ;;=^5001015
 ;;^UTILITY(U,$J,358.3,3908,0)
 ;;=C43.0^^20^271^7
 ;;^UTILITY(U,$J,358.3,3908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3908,1,3,0)
 ;;=3^Malig Melanoma of Lip
 ;;^UTILITY(U,$J,358.3,3908,1,4,0)
 ;;=4^C43.0
 ;;^UTILITY(U,$J,358.3,3908,2)
 ;;=^5000994
 ;;^UTILITY(U,$J,358.3,3909,0)
 ;;=C43.11^^20^271^11
 ;;^UTILITY(U,$J,358.3,3909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3909,1,3,0)
 ;;=3^Malig Melanoma of Right Eyelid
 ;;^UTILITY(U,$J,358.3,3909,1,4,0)
 ;;=4^C43.11
 ;;^UTILITY(U,$J,358.3,3909,2)
 ;;=^5000996
 ;;^UTILITY(U,$J,358.3,3910,0)
 ;;=C43.12^^20^271^4
 ;;^UTILITY(U,$J,358.3,3910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3910,1,3,0)
 ;;=3^Malig Melanoma of Left Eyelid
 ;;^UTILITY(U,$J,358.3,3910,1,4,0)
 ;;=4^C43.12
 ;;^UTILITY(U,$J,358.3,3910,2)
 ;;=^5000997
 ;;^UTILITY(U,$J,358.3,3911,0)
 ;;=C43.21^^20^271^10
 ;;^UTILITY(U,$J,358.3,3911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3911,1,3,0)
 ;;=3^Malig Melanoma of Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,3911,1,4,0)
 ;;=4^C43.21
 ;;^UTILITY(U,$J,358.3,3911,2)
 ;;=^5000999
 ;;^UTILITY(U,$J,358.3,3912,0)
 ;;=C43.22^^20^271^3
 ;;^UTILITY(U,$J,358.3,3912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3912,1,3,0)
 ;;=3^Malig Melanoma of Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,3912,1,4,0)
 ;;=4^C43.22
 ;;^UTILITY(U,$J,358.3,3912,2)
 ;;=^5001000
 ;;^UTILITY(U,$J,358.3,3913,0)
 ;;=C43.31^^20^271^8
 ;;^UTILITY(U,$J,358.3,3913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3913,1,3,0)
 ;;=3^Malig Melanoma of Nose
 ;;^UTILITY(U,$J,358.3,3913,1,4,0)
 ;;=4^C43.31
 ;;^UTILITY(U,$J,358.3,3913,2)
 ;;=^5001002
 ;;^UTILITY(U,$J,358.3,3914,0)
 ;;=C43.39^^20^271^2
 ;;^UTILITY(U,$J,358.3,3914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3914,1,3,0)
 ;;=3^Malig Melanoma of Face NEC
 ;;^UTILITY(U,$J,358.3,3914,1,4,0)
 ;;=4^C43.39
 ;;^UTILITY(U,$J,358.3,3914,2)
 ;;=^5001003
 ;;^UTILITY(U,$J,358.3,3915,0)
 ;;=C43.4^^20^271^14
 ;;^UTILITY(U,$J,358.3,3915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3915,1,3,0)
 ;;=3^Malig Melanoma of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,3915,1,4,0)
 ;;=4^C43.4
 ;;^UTILITY(U,$J,358.3,3915,2)
 ;;=^5001004
 ;;^UTILITY(U,$J,358.3,3916,0)
 ;;=C43.51^^20^271^1
 ;;^UTILITY(U,$J,358.3,3916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3916,1,3,0)
 ;;=3^Malig Melanoma of Anal Skin
 ;;^UTILITY(U,$J,358.3,3916,1,4,0)
 ;;=4^C43.51
 ;;^UTILITY(U,$J,358.3,3916,2)
 ;;=^5001005
 ;;^UTILITY(U,$J,358.3,3917,0)
 ;;=C43.52^^20^271^15
 ;;^UTILITY(U,$J,358.3,3917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3917,1,3,0)
 ;;=3^Malig Melanoma of Skin of Breast
 ;;^UTILITY(U,$J,358.3,3917,1,4,0)
 ;;=4^C43.52
 ;;^UTILITY(U,$J,358.3,3917,2)
 ;;=^5001006
 ;;^UTILITY(U,$J,358.3,3918,0)
 ;;=C43.59^^20^271^17
 ;;^UTILITY(U,$J,358.3,3918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3918,1,3,0)
 ;;=3^Malig Melanoma of Trunk NEC
 ;;^UTILITY(U,$J,358.3,3918,1,4,0)
 ;;=4^C43.59
 ;;^UTILITY(U,$J,358.3,3918,2)
 ;;=^5001007
 ;;^UTILITY(U,$J,358.3,3919,0)
 ;;=C43.61^^20^271^13
 ;;^UTILITY(U,$J,358.3,3919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3919,1,3,0)
 ;;=3^Malig Melanoma of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,3919,1,4,0)
 ;;=4^C43.61
 ;;^UTILITY(U,$J,358.3,3919,2)
 ;;=^5001009
 ;;^UTILITY(U,$J,358.3,3920,0)
 ;;=C43.62^^20^271^6
 ;;^UTILITY(U,$J,358.3,3920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3920,1,3,0)
 ;;=3^Malig Melanoma of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,3920,1,4,0)
 ;;=4^C43.62
 ;;^UTILITY(U,$J,358.3,3920,2)
 ;;=^5001010
 ;;^UTILITY(U,$J,358.3,3921,0)
 ;;=C43.71^^20^271^12
 ;;^UTILITY(U,$J,358.3,3921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3921,1,3,0)
 ;;=3^Malig Melanoma of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,3921,1,4,0)
 ;;=4^C43.71
 ;;^UTILITY(U,$J,358.3,3921,2)
 ;;=^5001012
 ;;^UTILITY(U,$J,358.3,3922,0)
 ;;=C43.72^^20^271^5
 ;;^UTILITY(U,$J,358.3,3922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3922,1,3,0)
 ;;=3^Malig Melanoma of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,3922,1,4,0)
 ;;=4^C43.72
 ;;^UTILITY(U,$J,358.3,3922,2)
 ;;=^5001013
 ;;^UTILITY(U,$J,358.3,3923,0)
 ;;=C43.8^^20^271^9
 ;;^UTILITY(U,$J,358.3,3923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3923,1,3,0)
 ;;=3^Malig Melanoma of Overlapping Sites of Skin
 ;;^UTILITY(U,$J,358.3,3923,1,4,0)
 ;;=4^C43.8
 ;;^UTILITY(U,$J,358.3,3923,2)
 ;;=^5001014
 ;;^UTILITY(U,$J,358.3,3924,0)
 ;;=D03.0^^20^271^26
 ;;^UTILITY(U,$J,358.3,3924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3924,1,3,0)
 ;;=3^Melanoma in Situ of Lip
 ;;^UTILITY(U,$J,358.3,3924,1,4,0)
 ;;=4^D03.0
 ;;^UTILITY(U,$J,358.3,3924,2)
 ;;=^5001888
 ;;^UTILITY(U,$J,358.3,3925,0)
 ;;=D03.11^^20^271^29
 ;;^UTILITY(U,$J,358.3,3925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3925,1,3,0)
 ;;=3^Melanoma in Situ of Right Eyelid
 ;;^UTILITY(U,$J,358.3,3925,1,4,0)
 ;;=4^D03.11
 ;;^UTILITY(U,$J,358.3,3925,2)
 ;;=^5001890
 ;;^UTILITY(U,$J,358.3,3926,0)
 ;;=D03.12^^20^271^23
 ;;^UTILITY(U,$J,358.3,3926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3926,1,3,0)
 ;;=3^Melanoma in Situ of Left Eyelid
 ;;^UTILITY(U,$J,358.3,3926,1,4,0)
 ;;=4^D03.12
 ;;^UTILITY(U,$J,358.3,3926,2)
 ;;=^5001891
 ;;^UTILITY(U,$J,358.3,3927,0)
 ;;=D03.21^^20^271^28
 ;;^UTILITY(U,$J,358.3,3927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3927,1,3,0)
 ;;=3^Melanoma in Situ of Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,3927,1,4,0)
 ;;=4^D03.21
 ;;^UTILITY(U,$J,358.3,3927,2)
 ;;=^5001893
 ;;^UTILITY(U,$J,358.3,3928,0)
 ;;=D03.22^^20^271^22
 ;;^UTILITY(U,$J,358.3,3928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3928,1,3,0)
 ;;=3^Melanoma in Situ of Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,3928,1,4,0)
 ;;=4^D03.22
 ;;^UTILITY(U,$J,358.3,3928,2)
 ;;=^5001894
 ;;^UTILITY(U,$J,358.3,3929,0)
 ;;=D03.30^^20^271^21
 ;;^UTILITY(U,$J,358.3,3929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3929,1,3,0)
 ;;=3^Melanoma in Situ of Face,Unspec
 ;;^UTILITY(U,$J,358.3,3929,1,4,0)
 ;;=4^D03.30
 ;;^UTILITY(U,$J,358.3,3929,2)
 ;;=^5001895
 ;;^UTILITY(U,$J,358.3,3930,0)
 ;;=D03.39^^20^271^20
 ;;^UTILITY(U,$J,358.3,3930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3930,1,3,0)
 ;;=3^Melanoma in Situ of Face NEC
 ;;^UTILITY(U,$J,358.3,3930,1,4,0)
 ;;=4^D03.39
 ;;^UTILITY(U,$J,358.3,3930,2)
 ;;=^5001896
 ;;^UTILITY(U,$J,358.3,3931,0)
 ;;=D03.4^^20^271^32
 ;;^UTILITY(U,$J,358.3,3931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3931,1,3,0)
 ;;=3^Melanoma in Situ of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,3931,1,4,0)
 ;;=4^D03.4
 ;;^UTILITY(U,$J,358.3,3931,2)
 ;;=^5001897
 ;;^UTILITY(U,$J,358.3,3932,0)
 ;;=D03.51^^20^271^18
 ;;^UTILITY(U,$J,358.3,3932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3932,1,3,0)
 ;;=3^Melanoma in Situ of Anal Skin
 ;;^UTILITY(U,$J,358.3,3932,1,4,0)
 ;;=4^D03.51
 ;;^UTILITY(U,$J,358.3,3932,2)
 ;;=^5001898
 ;;^UTILITY(U,$J,358.3,3933,0)
 ;;=D03.52^^20^271^19
 ;;^UTILITY(U,$J,358.3,3933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3933,1,3,0)
 ;;=3^Melanoma in Situ of Breast
 ;;^UTILITY(U,$J,358.3,3933,1,4,0)
 ;;=4^D03.52
 ;;^UTILITY(U,$J,358.3,3933,2)
 ;;=^5001899
 ;;^UTILITY(U,$J,358.3,3934,0)
 ;;=D03.59^^20^271^33
 ;;^UTILITY(U,$J,358.3,3934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3934,1,3,0)
 ;;=3^Melanoma in Situ of Trunk NEC
 ;;^UTILITY(U,$J,358.3,3934,1,4,0)
 ;;=4^D03.59
 ;;^UTILITY(U,$J,358.3,3934,2)
 ;;=^5001900
 ;;^UTILITY(U,$J,358.3,3935,0)
 ;;=D03.61^^20^271^31
 ;;^UTILITY(U,$J,358.3,3935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3935,1,3,0)
 ;;=3^Melanoma in Situ of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,3935,1,4,0)
 ;;=4^D03.61
 ;;^UTILITY(U,$J,358.3,3935,2)
 ;;=^5001902
 ;;^UTILITY(U,$J,358.3,3936,0)
 ;;=D03.62^^20^271^25
 ;;^UTILITY(U,$J,358.3,3936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3936,1,3,0)
 ;;=3^Melanoma in Situ of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,3936,1,4,0)
 ;;=4^D03.62
 ;;^UTILITY(U,$J,358.3,3936,2)
 ;;=^5001903
 ;;^UTILITY(U,$J,358.3,3937,0)
 ;;=D03.71^^20^271^30
 ;;^UTILITY(U,$J,358.3,3937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3937,1,3,0)
 ;;=3^Melanoma in Situ of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,3937,1,4,0)
 ;;=4^D03.71
 ;;^UTILITY(U,$J,358.3,3937,2)
 ;;=^5001905
 ;;^UTILITY(U,$J,358.3,3938,0)
 ;;=D03.72^^20^271^24
 ;;^UTILITY(U,$J,358.3,3938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3938,1,3,0)
 ;;=3^Melanoma in Situ of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,3938,1,4,0)
 ;;=4^D03.72
 ;;^UTILITY(U,$J,358.3,3938,2)
 ;;=^5001906
 ;;^UTILITY(U,$J,358.3,3939,0)
 ;;=D03.8^^20^271^27
 ;;^UTILITY(U,$J,358.3,3939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3939,1,3,0)
 ;;=3^Melanoma in Situ of Other Sites
 ;;^UTILITY(U,$J,358.3,3939,1,4,0)
 ;;=4^D03.8
 ;;^UTILITY(U,$J,358.3,3939,2)
 ;;=^5001907
 ;;^UTILITY(U,$J,358.3,3940,0)
 ;;=C4A.0^^20^272^8
 ;;^UTILITY(U,$J,358.3,3940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3940,1,3,0)
 ;;=3^Merkel Cell Carcinoma of Lip
 ;;^UTILITY(U,$J,358.3,3940,1,4,0)
 ;;=4^C4A.0
 ;;^UTILITY(U,$J,358.3,3940,2)
 ;;=^5001137
 ;;^UTILITY(U,$J,358.3,3941,0)
 ;;=C4A.11^^20^272^12
 ;;^UTILITY(U,$J,358.3,3941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3941,1,3,0)
 ;;=3^Merkel Cell Carcinoma of Right Eyelid
 ;;^UTILITY(U,$J,358.3,3941,1,4,0)
 ;;=4^C4A.11
 ;;^UTILITY(U,$J,358.3,3941,2)
 ;;=^5001139
 ;;^UTILITY(U,$J,358.3,3942,0)
 ;;=C4A.12^^20^272^5
 ;;^UTILITY(U,$J,358.3,3942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3942,1,3,0)
 ;;=3^Merkel Cell Carcinoma of Left Eyelid
 ;;^UTILITY(U,$J,358.3,3942,1,4,0)
 ;;=4^C4A.12
 ;;^UTILITY(U,$J,358.3,3942,2)
 ;;=^5001140
