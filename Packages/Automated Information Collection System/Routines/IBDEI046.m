IBDEI046 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5087,1,3,0)
 ;;=3^Malig Neop of Lymphoid/Hematopoietic/Related Tissue NEC
 ;;^UTILITY(U,$J,358.3,5087,1,4,0)
 ;;=4^C96.Z
 ;;^UTILITY(U,$J,358.3,5087,2)
 ;;=^5001866
 ;;^UTILITY(U,$J,358.3,5088,0)
 ;;=C96.9^^22^216^285
 ;;^UTILITY(U,$J,358.3,5088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5088,1,3,0)
 ;;=3^Malig Neop of Lymphoid/Hematopoietic/Related Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,5088,1,4,0)
 ;;=4^C96.9
 ;;^UTILITY(U,$J,358.3,5088,2)
 ;;=^5001864
 ;;^UTILITY(U,$J,358.3,5089,0)
 ;;=C43.51^^22^217^1
 ;;^UTILITY(U,$J,358.3,5089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5089,1,3,0)
 ;;=3^Malig Melanoma of Anal Skin
 ;;^UTILITY(U,$J,358.3,5089,1,4,0)
 ;;=4^C43.51
 ;;^UTILITY(U,$J,358.3,5089,2)
 ;;=^5001005
 ;;^UTILITY(U,$J,358.3,5090,0)
 ;;=C43.52^^22^217^2
 ;;^UTILITY(U,$J,358.3,5090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5090,1,3,0)
 ;;=3^Malig Melanoma of Breast Skin
 ;;^UTILITY(U,$J,358.3,5090,1,4,0)
 ;;=4^C43.52
 ;;^UTILITY(U,$J,358.3,5090,2)
 ;;=^5001006
 ;;^UTILITY(U,$J,358.3,5091,0)
 ;;=C43.30^^22^217^4
 ;;^UTILITY(U,$J,358.3,5091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5091,1,3,0)
 ;;=3^Malig Melanoma of Face,Unspec
 ;;^UTILITY(U,$J,358.3,5091,1,4,0)
 ;;=4^C43.30
 ;;^UTILITY(U,$J,358.3,5091,2)
 ;;=^5001001
 ;;^UTILITY(U,$J,358.3,5092,0)
 ;;=C43.22^^22^217^5
 ;;^UTILITY(U,$J,358.3,5092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5092,1,3,0)
 ;;=3^Malig Melanoma of Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,5092,1,4,0)
 ;;=4^C43.22
 ;;^UTILITY(U,$J,358.3,5092,2)
 ;;=^5001000
 ;;^UTILITY(U,$J,358.3,5093,0)
 ;;=C43.12^^22^217^6
 ;;^UTILITY(U,$J,358.3,5093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5093,1,3,0)
 ;;=3^Malig Melanoma of Left Eyelid
 ;;^UTILITY(U,$J,358.3,5093,1,4,0)
 ;;=4^C43.12
 ;;^UTILITY(U,$J,358.3,5093,2)
 ;;=^5000997
 ;;^UTILITY(U,$J,358.3,5094,0)
 ;;=C43.72^^22^217^7
 ;;^UTILITY(U,$J,358.3,5094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5094,1,3,0)
 ;;=3^Malig Melanoma of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,5094,1,4,0)
 ;;=4^C43.72
 ;;^UTILITY(U,$J,358.3,5094,2)
 ;;=^5001013
 ;;^UTILITY(U,$J,358.3,5095,0)
 ;;=C43.62^^22^217^8
 ;;^UTILITY(U,$J,358.3,5095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5095,1,3,0)
 ;;=3^Malig Melanoma of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,5095,1,4,0)
 ;;=4^C43.62
 ;;^UTILITY(U,$J,358.3,5095,2)
 ;;=^5001010
 ;;^UTILITY(U,$J,358.3,5096,0)
 ;;=C43.0^^22^217^9
 ;;^UTILITY(U,$J,358.3,5096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5096,1,3,0)
 ;;=3^Malig Melanoma of Lip
 ;;^UTILITY(U,$J,358.3,5096,1,4,0)
 ;;=4^C43.0
 ;;^UTILITY(U,$J,358.3,5096,2)
 ;;=^5000994
 ;;^UTILITY(U,$J,358.3,5097,0)
 ;;=C43.31^^22^217^10
 ;;^UTILITY(U,$J,358.3,5097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5097,1,3,0)
 ;;=3^Malig Melanoma of Nose
 ;;^UTILITY(U,$J,358.3,5097,1,4,0)
 ;;=4^C43.31
 ;;^UTILITY(U,$J,358.3,5097,2)
 ;;=^5001002
 ;;^UTILITY(U,$J,358.3,5098,0)
 ;;=C43.21^^22^217^12
 ;;^UTILITY(U,$J,358.3,5098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5098,1,3,0)
 ;;=3^Malig Melanoma of Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,5098,1,4,0)
 ;;=4^C43.21
 ;;^UTILITY(U,$J,358.3,5098,2)
 ;;=^5000999
 ;;^UTILITY(U,$J,358.3,5099,0)
 ;;=C43.11^^22^217^13
 ;;^UTILITY(U,$J,358.3,5099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5099,1,3,0)
 ;;=3^Malig Melanoma of Right Eyelid
 ;;^UTILITY(U,$J,358.3,5099,1,4,0)
 ;;=4^C43.11
 ;;^UTILITY(U,$J,358.3,5099,2)
 ;;=^5000996
 ;;^UTILITY(U,$J,358.3,5100,0)
 ;;=C43.71^^22^217^14
 ;;^UTILITY(U,$J,358.3,5100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5100,1,3,0)
 ;;=3^Malig Melanoma of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,5100,1,4,0)
 ;;=4^C43.71
 ;;^UTILITY(U,$J,358.3,5100,2)
 ;;=^5001012
 ;;^UTILITY(U,$J,358.3,5101,0)
 ;;=C43.61^^22^217^15
 ;;^UTILITY(U,$J,358.3,5101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5101,1,3,0)
 ;;=3^Malig Melanoma of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,5101,1,4,0)
 ;;=4^C43.61
 ;;^UTILITY(U,$J,358.3,5101,2)
 ;;=^5001009
 ;;^UTILITY(U,$J,358.3,5102,0)
 ;;=C43.4^^22^217^16
 ;;^UTILITY(U,$J,358.3,5102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5102,1,3,0)
 ;;=3^Malig Melanoma of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,5102,1,4,0)
 ;;=4^C43.4
 ;;^UTILITY(U,$J,358.3,5102,2)
 ;;=^5001004
 ;;^UTILITY(U,$J,358.3,5103,0)
 ;;=C43.59^^22^217^18
 ;;^UTILITY(U,$J,358.3,5103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5103,1,3,0)
 ;;=3^Malig Melanoma of Trunk,Oth Part
 ;;^UTILITY(U,$J,358.3,5103,1,4,0)
 ;;=4^C43.59
 ;;^UTILITY(U,$J,358.3,5103,2)
 ;;=^5001007
 ;;^UTILITY(U,$J,358.3,5104,0)
 ;;=C43.39^^22^217^3
 ;;^UTILITY(U,$J,358.3,5104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5104,1,3,0)
 ;;=3^Malig Melanoma of Face NEC
 ;;^UTILITY(U,$J,358.3,5104,1,4,0)
 ;;=4^C43.39
 ;;^UTILITY(U,$J,358.3,5104,2)
 ;;=^5001003
 ;;^UTILITY(U,$J,358.3,5105,0)
 ;;=C43.8^^22^217^11
 ;;^UTILITY(U,$J,358.3,5105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5105,1,3,0)
 ;;=3^Malig Melanoma of Overlapping Sites of Skin
 ;;^UTILITY(U,$J,358.3,5105,1,4,0)
 ;;=4^C43.8
 ;;^UTILITY(U,$J,358.3,5105,2)
 ;;=^5001014
 ;;^UTILITY(U,$J,358.3,5106,0)
 ;;=C43.9^^22^217^17
 ;;^UTILITY(U,$J,358.3,5106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5106,1,3,0)
 ;;=3^Malig Melanoma of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,5106,1,4,0)
 ;;=4^C43.9
 ;;^UTILITY(U,$J,358.3,5106,2)
 ;;=^5001015
 ;;^UTILITY(U,$J,358.3,5107,0)
 ;;=C06.0^^22^218^1
 ;;^UTILITY(U,$J,358.3,5107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5107,1,3,0)
 ;;=3^Malig Neop of Cheek Mucosa
 ;;^UTILITY(U,$J,358.3,5107,1,4,0)
 ;;=4^C06.0
 ;;^UTILITY(U,$J,358.3,5107,2)
 ;;=^267019
 ;;^UTILITY(U,$J,358.3,5108,0)
 ;;=C06.1^^22^218^7
 ;;^UTILITY(U,$J,358.3,5108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5108,1,3,0)
 ;;=3^Malig Neop of Vestibule of Mouth
 ;;^UTILITY(U,$J,358.3,5108,1,4,0)
 ;;=4^C06.1
 ;;^UTILITY(U,$J,358.3,5108,2)
 ;;=^267020
 ;;^UTILITY(U,$J,358.3,5109,0)
 ;;=C06.2^^22^218^6
 ;;^UTILITY(U,$J,358.3,5109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5109,1,3,0)
 ;;=3^Malig Neop of Retromolar Area
 ;;^UTILITY(U,$J,358.3,5109,1,4,0)
 ;;=4^C06.2
 ;;^UTILITY(U,$J,358.3,5109,2)
 ;;=^267025
 ;;^UTILITY(U,$J,358.3,5110,0)
 ;;=C06.80^^22^218^3
 ;;^UTILITY(U,$J,358.3,5110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5110,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Mouth,Unspec Parts
 ;;^UTILITY(U,$J,358.3,5110,1,4,0)
 ;;=4^C06.80
 ;;^UTILITY(U,$J,358.3,5110,2)
 ;;=^5000899
 ;;^UTILITY(U,$J,358.3,5111,0)
 ;;=C06.89^^22^218^4
 ;;^UTILITY(U,$J,358.3,5111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5111,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Mouth NEC
 ;;^UTILITY(U,$J,358.3,5111,1,4,0)
 ;;=4^C06.89
 ;;^UTILITY(U,$J,358.3,5111,2)
 ;;=^5000900
 ;;^UTILITY(U,$J,358.3,5112,0)
 ;;=C06.9^^22^218^2
 ;;^UTILITY(U,$J,358.3,5112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5112,1,3,0)
 ;;=3^Malig Neop of Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,5112,1,4,0)
 ;;=4^C06.9
 ;;^UTILITY(U,$J,358.3,5112,2)
 ;;=^5000901
 ;;^UTILITY(U,$J,358.3,5113,0)
 ;;=C07.^^22^218^5
 ;;^UTILITY(U,$J,358.3,5113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5113,1,3,0)
 ;;=3^Malig Neop of Parotid Gland
 ;;^UTILITY(U,$J,358.3,5113,1,4,0)
 ;;=4^C07.
 ;;^UTILITY(U,$J,358.3,5113,2)
 ;;=^267005
 ;;^UTILITY(U,$J,358.3,5114,0)
 ;;=C11.0^^22^219^7
 ;;^UTILITY(U,$J,358.3,5114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5114,1,3,0)
 ;;=3^Malig Neop of Superior Wall of Nasopharynx
 ;;^UTILITY(U,$J,358.3,5114,1,4,0)
 ;;=4^C11.0
 ;;^UTILITY(U,$J,358.3,5114,2)
 ;;=^267039
 ;;^UTILITY(U,$J,358.3,5115,0)
 ;;=C11.1^^22^219^5
 ;;^UTILITY(U,$J,358.3,5115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5115,1,3,0)
 ;;=3^Malig Neop of Posterior Wall of Nasopharynx
 ;;^UTILITY(U,$J,358.3,5115,1,4,0)
 ;;=4^C11.1
 ;;^UTILITY(U,$J,358.3,5115,2)
 ;;=^267040
 ;;^UTILITY(U,$J,358.3,5116,0)
 ;;=C11.2^^22^219^2
 ;;^UTILITY(U,$J,358.3,5116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5116,1,3,0)
 ;;=3^Malig Neop of Lateral Wall of Nasopharynx
 ;;^UTILITY(U,$J,358.3,5116,1,4,0)
 ;;=4^C11.2
 ;;^UTILITY(U,$J,358.3,5116,2)
 ;;=^267041
 ;;^UTILITY(U,$J,358.3,5117,0)
 ;;=C11.3^^22^219^1
 ;;^UTILITY(U,$J,358.3,5117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5117,1,3,0)
 ;;=3^Malig Neop of Anterior Wall of Nasopharynx
 ;;^UTILITY(U,$J,358.3,5117,1,4,0)
 ;;=4^C11.3
 ;;^UTILITY(U,$J,358.3,5117,2)
 ;;=^267042
 ;;^UTILITY(U,$J,358.3,5118,0)
 ;;=C11.8^^22^219^4
 ;;^UTILITY(U,$J,358.3,5118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5118,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Nasopharynx
 ;;^UTILITY(U,$J,358.3,5118,1,4,0)
 ;;=4^C11.8
 ;;^UTILITY(U,$J,358.3,5118,2)
 ;;=^5000910
 ;;^UTILITY(U,$J,358.3,5119,0)
 ;;=C11.9^^22^219^3
 ;;^UTILITY(U,$J,358.3,5119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5119,1,3,0)
 ;;=3^Malig Neop of Nasopharynx,Unspec
 ;;^UTILITY(U,$J,358.3,5119,1,4,0)
 ;;=4^C11.9
 ;;^UTILITY(U,$J,358.3,5119,2)
 ;;=^5000911
 ;;^UTILITY(U,$J,358.3,5120,0)
 ;;=C12.^^22^219^6
 ;;^UTILITY(U,$J,358.3,5120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5120,1,3,0)
 ;;=3^Malig Neop of Pyriform Sinus
 ;;^UTILITY(U,$J,358.3,5120,1,4,0)
 ;;=4^C12.
 ;;^UTILITY(U,$J,358.3,5120,2)
 ;;=^267046
 ;;^UTILITY(U,$J,358.3,5121,0)
 ;;=C10.1^^22^220^1
 ;;^UTILITY(U,$J,358.3,5121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5121,1,3,0)
 ;;=3^Malig Neop of Anterior Surface of Epiglottis
 ;;^UTILITY(U,$J,358.3,5121,1,4,0)
 ;;=4^C10.1
 ;;^UTILITY(U,$J,358.3,5121,2)
 ;;=^5000906
 ;;^UTILITY(U,$J,358.3,5122,0)
 ;;=C10.0^^22^220^7
 ;;^UTILITY(U,$J,358.3,5122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5122,1,3,0)
 ;;=3^Malig Neop of Vallecula
 ;;^UTILITY(U,$J,358.3,5122,1,4,0)
 ;;=4^C10.0
 ;;^UTILITY(U,$J,358.3,5122,2)
 ;;=^267032
 ;;^UTILITY(U,$J,358.3,5123,0)
 ;;=C10.2^^22^220^3
 ;;^UTILITY(U,$J,358.3,5123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5123,1,3,0)
 ;;=3^Malig Neop of Lateral Wall of Oropharynx
