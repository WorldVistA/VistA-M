IBDEI05E ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5131,1,4,0)
 ;;=4^C43.31
 ;;^UTILITY(U,$J,358.3,5131,2)
 ;;=^5001002
 ;;^UTILITY(U,$J,358.3,5132,0)
 ;;=C43.39^^32^339^2
 ;;^UTILITY(U,$J,358.3,5132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5132,1,3,0)
 ;;=3^Malig Melanoma of Face,Other Parts
 ;;^UTILITY(U,$J,358.3,5132,1,4,0)
 ;;=4^C43.39
 ;;^UTILITY(U,$J,358.3,5132,2)
 ;;=^5001003
 ;;^UTILITY(U,$J,358.3,5133,0)
 ;;=C43.4^^32^339^14
 ;;^UTILITY(U,$J,358.3,5133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5133,1,3,0)
 ;;=3^Malig Melanoma of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,5133,1,4,0)
 ;;=4^C43.4
 ;;^UTILITY(U,$J,358.3,5133,2)
 ;;=^5001004
 ;;^UTILITY(U,$J,358.3,5134,0)
 ;;=C43.59^^32^339^16
 ;;^UTILITY(U,$J,358.3,5134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5134,1,3,0)
 ;;=3^Malig Melanoma of Trunk,Other Part
 ;;^UTILITY(U,$J,358.3,5134,1,4,0)
 ;;=4^C43.59
 ;;^UTILITY(U,$J,358.3,5134,2)
 ;;=^5001007
 ;;^UTILITY(U,$J,358.3,5135,0)
 ;;=C43.51^^32^339^1
 ;;^UTILITY(U,$J,358.3,5135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5135,1,3,0)
 ;;=3^Malig Melanoma of Anal Skin
 ;;^UTILITY(U,$J,358.3,5135,1,4,0)
 ;;=4^C43.51
 ;;^UTILITY(U,$J,358.3,5135,2)
 ;;=^5001005
 ;;^UTILITY(U,$J,358.3,5136,0)
 ;;=C43.52^^32^339^15
 ;;^UTILITY(U,$J,358.3,5136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5136,1,3,0)
 ;;=3^Malig Melanoma of Skin of Breast
 ;;^UTILITY(U,$J,358.3,5136,1,4,0)
 ;;=4^C43.52
 ;;^UTILITY(U,$J,358.3,5136,2)
 ;;=^5001006
 ;;^UTILITY(U,$J,358.3,5137,0)
 ;;=C43.61^^32^339^13
 ;;^UTILITY(U,$J,358.3,5137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5137,1,3,0)
 ;;=3^Malig Melanoma of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,5137,1,4,0)
 ;;=4^C43.61
 ;;^UTILITY(U,$J,358.3,5137,2)
 ;;=^5001009
 ;;^UTILITY(U,$J,358.3,5138,0)
 ;;=C43.62^^32^339^6
 ;;^UTILITY(U,$J,358.3,5138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5138,1,3,0)
 ;;=3^Malig Melanoma of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,5138,1,4,0)
 ;;=4^C43.62
 ;;^UTILITY(U,$J,358.3,5138,2)
 ;;=^5001010
 ;;^UTILITY(U,$J,358.3,5139,0)
 ;;=C43.71^^32^339^12
 ;;^UTILITY(U,$J,358.3,5139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5139,1,3,0)
 ;;=3^Malig Melanoma of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,5139,1,4,0)
 ;;=4^C43.71
 ;;^UTILITY(U,$J,358.3,5139,2)
 ;;=^5001012
 ;;^UTILITY(U,$J,358.3,5140,0)
 ;;=C43.72^^32^339^5
 ;;^UTILITY(U,$J,358.3,5140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5140,1,3,0)
 ;;=3^Malig Melanoma of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,5140,1,4,0)
 ;;=4^C43.72
 ;;^UTILITY(U,$J,358.3,5140,2)
 ;;=^5001013
 ;;^UTILITY(U,$J,358.3,5141,0)
 ;;=C43.8^^32^339^9
 ;;^UTILITY(U,$J,358.3,5141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5141,1,3,0)
 ;;=3^Malig Melanoma of Overlapping Sites of Skin
 ;;^UTILITY(U,$J,358.3,5141,1,4,0)
 ;;=4^C43.8
 ;;^UTILITY(U,$J,358.3,5141,2)
 ;;=^5001014
 ;;^UTILITY(U,$J,358.3,5142,0)
 ;;=D03.0^^32^339^60
 ;;^UTILITY(U,$J,358.3,5142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5142,1,3,0)
 ;;=3^Melanoma in Situ of Lip
 ;;^UTILITY(U,$J,358.3,5142,1,4,0)
 ;;=4^D03.0
 ;;^UTILITY(U,$J,358.3,5142,2)
 ;;=^5001888
 ;;^UTILITY(U,$J,358.3,5143,0)
 ;;=D03.11^^32^339^54
 ;;^UTILITY(U,$J,358.3,5143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5143,1,3,0)
 ;;=3^Melanoma in Situ Right Eyelid
 ;;^UTILITY(U,$J,358.3,5143,1,4,0)
 ;;=4^D03.11
 ;;^UTILITY(U,$J,358.3,5143,2)
 ;;=^5001890
 ;;^UTILITY(U,$J,358.3,5144,0)
 ;;=D03.12^^32^339^50
 ;;^UTILITY(U,$J,358.3,5144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5144,1,3,0)
 ;;=3^Melanoma in Situ Left Eyelid
 ;;^UTILITY(U,$J,358.3,5144,1,4,0)
 ;;=4^D03.12
 ;;^UTILITY(U,$J,358.3,5144,2)
 ;;=^5001891
 ;;^UTILITY(U,$J,358.3,5145,0)
 ;;=D03.21^^32^339^53
 ;;^UTILITY(U,$J,358.3,5145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5145,1,3,0)
 ;;=3^Melanoma in Situ Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,5145,1,4,0)
 ;;=4^D03.21
 ;;^UTILITY(U,$J,358.3,5145,2)
 ;;=^5001893
 ;;^UTILITY(U,$J,358.3,5146,0)
 ;;=D03.22^^32^339^49
 ;;^UTILITY(U,$J,358.3,5146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5146,1,3,0)
 ;;=3^Melanoma in Situ Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,5146,1,4,0)
 ;;=4^D03.22
 ;;^UTILITY(U,$J,358.3,5146,2)
 ;;=^5001894
 ;;^UTILITY(U,$J,358.3,5147,0)
 ;;=D03.30^^32^339^59
 ;;^UTILITY(U,$J,358.3,5147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5147,1,3,0)
 ;;=3^Melanoma in Situ Unspec Part of Face
 ;;^UTILITY(U,$J,358.3,5147,1,4,0)
 ;;=4^D03.30
 ;;^UTILITY(U,$J,358.3,5147,2)
 ;;=^5001895
 ;;^UTILITY(U,$J,358.3,5148,0)
 ;;=D03.4^^32^339^57
 ;;^UTILITY(U,$J,358.3,5148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5148,1,3,0)
 ;;=3^Melanoma in Situ Scalp/Neck
 ;;^UTILITY(U,$J,358.3,5148,1,4,0)
 ;;=4^D03.4
 ;;^UTILITY(U,$J,358.3,5148,2)
 ;;=^5001897
 ;;^UTILITY(U,$J,358.3,5149,0)
 ;;=D03.59^^32^339^58
 ;;^UTILITY(U,$J,358.3,5149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5149,1,3,0)
 ;;=3^Melanoma in Situ Trunk,Other Part
 ;;^UTILITY(U,$J,358.3,5149,1,4,0)
 ;;=4^D03.59
 ;;^UTILITY(U,$J,358.3,5149,2)
 ;;=^5001900
 ;;^UTILITY(U,$J,358.3,5150,0)
 ;;=D03.51^^32^339^47
 ;;^UTILITY(U,$J,358.3,5150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5150,1,3,0)
 ;;=3^Melanoma in Situ Anal Skin
 ;;^UTILITY(U,$J,358.3,5150,1,4,0)
 ;;=4^D03.51
 ;;^UTILITY(U,$J,358.3,5150,2)
 ;;=^5001898
 ;;^UTILITY(U,$J,358.3,5151,0)
 ;;=D03.52^^32^339^48
 ;;^UTILITY(U,$J,358.3,5151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5151,1,3,0)
 ;;=3^Melanoma in Situ Breast,Skin/Soft Tissue
 ;;^UTILITY(U,$J,358.3,5151,1,4,0)
 ;;=4^D03.52
 ;;^UTILITY(U,$J,358.3,5151,2)
 ;;=^5001899
 ;;^UTILITY(U,$J,358.3,5152,0)
 ;;=D03.61^^32^339^56
 ;;^UTILITY(U,$J,358.3,5152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5152,1,3,0)
 ;;=3^Melanoma in Situ Right Upper Limb
 ;;^UTILITY(U,$J,358.3,5152,1,4,0)
 ;;=4^D03.61
 ;;^UTILITY(U,$J,358.3,5152,2)
 ;;=^5001902
 ;;^UTILITY(U,$J,358.3,5153,0)
 ;;=D03.62^^32^339^52
 ;;^UTILITY(U,$J,358.3,5153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5153,1,3,0)
 ;;=3^Melanoma in Situ Left Upper Limb
 ;;^UTILITY(U,$J,358.3,5153,1,4,0)
 ;;=4^D03.62
 ;;^UTILITY(U,$J,358.3,5153,2)
 ;;=^5001903
 ;;^UTILITY(U,$J,358.3,5154,0)
 ;;=D03.71^^32^339^55
 ;;^UTILITY(U,$J,358.3,5154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5154,1,3,0)
 ;;=3^Melanoma in Situ Right Lower Limb
 ;;^UTILITY(U,$J,358.3,5154,1,4,0)
 ;;=4^D03.71
 ;;^UTILITY(U,$J,358.3,5154,2)
 ;;=^5001905
 ;;^UTILITY(U,$J,358.3,5155,0)
 ;;=D03.72^^32^339^51
 ;;^UTILITY(U,$J,358.3,5155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5155,1,3,0)
 ;;=3^Melanoma in Situ Left Lower Limb
 ;;^UTILITY(U,$J,358.3,5155,1,4,0)
 ;;=4^D03.72
 ;;^UTILITY(U,$J,358.3,5155,2)
 ;;=^5001906
 ;;^UTILITY(U,$J,358.3,5156,0)
 ;;=D03.8^^32^339^61
 ;;^UTILITY(U,$J,358.3,5156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5156,1,3,0)
 ;;=3^Melanoma in Situ of Other Sites
 ;;^UTILITY(U,$J,358.3,5156,1,4,0)
 ;;=4^D03.8
 ;;^UTILITY(U,$J,358.3,5156,2)
 ;;=^5001907
 ;;^UTILITY(U,$J,358.3,5157,0)
 ;;=D22.0^^32^339^38
 ;;^UTILITY(U,$J,358.3,5157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5157,1,3,0)
 ;;=3^Melanocytic Nevi of Lip
 ;;^UTILITY(U,$J,358.3,5157,1,4,0)
 ;;=4^D22.0
 ;;^UTILITY(U,$J,358.3,5157,2)
 ;;=^5002041
 ;;^UTILITY(U,$J,358.3,5158,0)
 ;;=D22.12^^32^339^35
 ;;^UTILITY(U,$J,358.3,5158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5158,1,3,0)
 ;;=3^Melanocytic Nevi of Left Eyelid
 ;;^UTILITY(U,$J,358.3,5158,1,4,0)
 ;;=4^D22.12
 ;;^UTILITY(U,$J,358.3,5158,2)
 ;;=^5002044
 ;;^UTILITY(U,$J,358.3,5159,0)
 ;;=D22.11^^32^339^40
 ;;^UTILITY(U,$J,358.3,5159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5159,1,3,0)
 ;;=3^Melanocytic Nevi of Right Eyelid
 ;;^UTILITY(U,$J,358.3,5159,1,4,0)
 ;;=4^D22.11
 ;;^UTILITY(U,$J,358.3,5159,2)
 ;;=^5002043
 ;;^UTILITY(U,$J,358.3,5160,0)
 ;;=D22.21^^32^339^39
 ;;^UTILITY(U,$J,358.3,5160,1,0)
 ;;=^358.31IA^4^2
