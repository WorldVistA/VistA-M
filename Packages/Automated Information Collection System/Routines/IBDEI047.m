IBDEI047 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5123,1,4,0)
 ;;=4^C10.2
 ;;^UTILITY(U,$J,358.3,5123,2)
 ;;=^267035
 ;;^UTILITY(U,$J,358.3,5124,0)
 ;;=C10.3^^22^220^6
 ;;^UTILITY(U,$J,358.3,5124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5124,1,3,0)
 ;;=3^Malig Neop of Posterior Wall of Oropharynx
 ;;^UTILITY(U,$J,358.3,5124,1,4,0)
 ;;=4^C10.3
 ;;^UTILITY(U,$J,358.3,5124,2)
 ;;=^267036
 ;;^UTILITY(U,$J,358.3,5125,0)
 ;;=C10.4^^22^220^2
 ;;^UTILITY(U,$J,358.3,5125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5125,1,3,0)
 ;;=3^Malig Neop of Branchial Cleft
 ;;^UTILITY(U,$J,358.3,5125,1,4,0)
 ;;=4^C10.4
 ;;^UTILITY(U,$J,358.3,5125,2)
 ;;=^5000907
 ;;^UTILITY(U,$J,358.3,5126,0)
 ;;=C10.8^^22^220^5
 ;;^UTILITY(U,$J,358.3,5126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5126,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Oropharynx
 ;;^UTILITY(U,$J,358.3,5126,1,4,0)
 ;;=4^C10.8
 ;;^UTILITY(U,$J,358.3,5126,2)
 ;;=^5000908
 ;;^UTILITY(U,$J,358.3,5127,0)
 ;;=C10.9^^22^220^4
 ;;^UTILITY(U,$J,358.3,5127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5127,1,3,0)
 ;;=3^Malig Neop of Oropharynx,Unspec
 ;;^UTILITY(U,$J,358.3,5127,1,4,0)
 ;;=4^C10.9
 ;;^UTILITY(U,$J,358.3,5127,2)
 ;;=^5000909
 ;;^UTILITY(U,$J,358.3,5128,0)
 ;;=C25.0^^22^221^3
 ;;^UTILITY(U,$J,358.3,5128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5128,1,3,0)
 ;;=3^Malig Neop of Head of Pancreas
 ;;^UTILITY(U,$J,358.3,5128,1,4,0)
 ;;=4^C25.0
 ;;^UTILITY(U,$J,358.3,5128,2)
 ;;=^267104
 ;;^UTILITY(U,$J,358.3,5129,0)
 ;;=C25.1^^22^221^1
 ;;^UTILITY(U,$J,358.3,5129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5129,1,3,0)
 ;;=3^Malig Neop of Body of Pancreas
 ;;^UTILITY(U,$J,358.3,5129,1,4,0)
 ;;=4^C25.1
 ;;^UTILITY(U,$J,358.3,5129,2)
 ;;=^267105
 ;;^UTILITY(U,$J,358.3,5130,0)
 ;;=C25.2^^22^221^8
 ;;^UTILITY(U,$J,358.3,5130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5130,1,3,0)
 ;;=3^Malig Neop of Tail of Pancreas
 ;;^UTILITY(U,$J,358.3,5130,1,4,0)
 ;;=4^C25.2
 ;;^UTILITY(U,$J,358.3,5130,2)
 ;;=^267106
 ;;^UTILITY(U,$J,358.3,5131,0)
 ;;=C25.3^^22^221^7
 ;;^UTILITY(U,$J,358.3,5131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5131,1,3,0)
 ;;=3^Malig Neop of Pancreatic Duct
 ;;^UTILITY(U,$J,358.3,5131,1,4,0)
 ;;=4^C25.3
 ;;^UTILITY(U,$J,358.3,5131,2)
 ;;=^267107
 ;;^UTILITY(U,$J,358.3,5132,0)
 ;;=C25.4^^22^221^2
 ;;^UTILITY(U,$J,358.3,5132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5132,1,3,0)
 ;;=3^Malig Neop of Endocrine Pancreas
 ;;^UTILITY(U,$J,358.3,5132,1,4,0)
 ;;=4^C25.4
 ;;^UTILITY(U,$J,358.3,5132,2)
 ;;=^5000943
 ;;^UTILITY(U,$J,358.3,5133,0)
 ;;=C25.8^^22^221^5
 ;;^UTILITY(U,$J,358.3,5133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5133,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Pancreas
 ;;^UTILITY(U,$J,358.3,5133,1,4,0)
 ;;=4^C25.8
 ;;^UTILITY(U,$J,358.3,5133,2)
 ;;=^5000945
 ;;^UTILITY(U,$J,358.3,5134,0)
 ;;=C25.7^^22^221^4
 ;;^UTILITY(U,$J,358.3,5134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5134,1,3,0)
 ;;=3^Malig Neop of Other Parts of Pancreas
 ;;^UTILITY(U,$J,358.3,5134,1,4,0)
 ;;=4^C25.7
 ;;^UTILITY(U,$J,358.3,5134,2)
 ;;=^5000944
 ;;^UTILITY(U,$J,358.3,5135,0)
 ;;=C25.9^^22^221^6
 ;;^UTILITY(U,$J,358.3,5135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5135,1,3,0)
 ;;=3^Malig Neop of Pancreas,Unspec
 ;;^UTILITY(U,$J,358.3,5135,1,4,0)
 ;;=4^C25.9
 ;;^UTILITY(U,$J,358.3,5135,2)
 ;;=^5000946
 ;;^UTILITY(U,$J,358.3,5136,0)
 ;;=C21.1^^22^222^1
 ;;^UTILITY(U,$J,358.3,5136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5136,1,3,0)
 ;;=3^Malig Neop of Anal Canal
 ;;^UTILITY(U,$J,358.3,5136,1,4,0)
 ;;=4^C21.1
 ;;^UTILITY(U,$J,358.3,5136,2)
 ;;=^267091
 ;;^UTILITY(U,$J,358.3,5137,0)
 ;;=C21.8^^22^222^3
 ;;^UTILITY(U,$J,358.3,5137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5137,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Rectum/Anus/Anal Canal
 ;;^UTILITY(U,$J,358.3,5137,1,4,0)
 ;;=4^C21.8
 ;;^UTILITY(U,$J,358.3,5137,2)
 ;;=^5000932
 ;;^UTILITY(U,$J,358.3,5138,0)
 ;;=C21.0^^22^222^2
 ;;^UTILITY(U,$J,358.3,5138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5138,1,3,0)
 ;;=3^Malig Neop of Anus,Unspec
 ;;^UTILITY(U,$J,358.3,5138,1,4,0)
 ;;=4^C21.0
 ;;^UTILITY(U,$J,358.3,5138,2)
 ;;=^5000930
 ;;^UTILITY(U,$J,358.3,5139,0)
 ;;=C07.^^22^223^2
 ;;^UTILITY(U,$J,358.3,5139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5139,1,3,0)
 ;;=3^Malig Neop of Parotid Gland
 ;;^UTILITY(U,$J,358.3,5139,1,4,0)
 ;;=4^C07.
 ;;^UTILITY(U,$J,358.3,5139,2)
 ;;=^267005
 ;;^UTILITY(U,$J,358.3,5140,0)
 ;;=C08.0^^22^223^4
 ;;^UTILITY(U,$J,358.3,5140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5140,1,3,0)
 ;;=3^Malig Neop of Submandibular Gland
 ;;^UTILITY(U,$J,358.3,5140,1,4,0)
 ;;=4^C08.0
 ;;^UTILITY(U,$J,358.3,5140,2)
 ;;=^267006
 ;;^UTILITY(U,$J,358.3,5141,0)
 ;;=C08.1^^22^223^3
 ;;^UTILITY(U,$J,358.3,5141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5141,1,3,0)
 ;;=3^Malig Neop of Sublingual Gland
 ;;^UTILITY(U,$J,358.3,5141,1,4,0)
 ;;=4^C08.1
 ;;^UTILITY(U,$J,358.3,5141,2)
 ;;=^267007
 ;;^UTILITY(U,$J,358.3,5142,0)
 ;;=C08.9^^22^223^1
 ;;^UTILITY(U,$J,358.3,5142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5142,1,3,0)
 ;;=3^Malig Neop of Major Salivary Gland,Unspec
 ;;^UTILITY(U,$J,358.3,5142,1,4,0)
 ;;=4^C08.9
 ;;^UTILITY(U,$J,358.3,5142,2)
 ;;=^5000902
 ;;^UTILITY(U,$J,358.3,5143,0)
 ;;=C09.0^^22^223^6
 ;;^UTILITY(U,$J,358.3,5143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5143,1,3,0)
 ;;=3^Malig Neop of Tonsillar Fossa
 ;;^UTILITY(U,$J,358.3,5143,1,4,0)
 ;;=4^C09.0
 ;;^UTILITY(U,$J,358.3,5143,2)
 ;;=^267030
 ;;^UTILITY(U,$J,358.3,5144,0)
 ;;=C09.1^^22^223^7
 ;;^UTILITY(U,$J,358.3,5144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5144,1,3,0)
 ;;=3^Malig Neop of Tonsillar Pillar
 ;;^UTILITY(U,$J,358.3,5144,1,4,0)
 ;;=4^C09.1
 ;;^UTILITY(U,$J,358.3,5144,2)
 ;;=^5000903
 ;;^UTILITY(U,$J,358.3,5145,0)
 ;;=C09.9^^22^223^5
 ;;^UTILITY(U,$J,358.3,5145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5145,1,3,0)
 ;;=3^Malig Neop of Tonsil,Unspec
 ;;^UTILITY(U,$J,358.3,5145,1,4,0)
 ;;=4^C09.9
 ;;^UTILITY(U,$J,358.3,5145,2)
 ;;=^5000905
 ;;^UTILITY(U,$J,358.3,5146,0)
 ;;=C79.11^^22^224^1
 ;;^UTILITY(U,$J,358.3,5146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5146,1,3,0)
 ;;=3^Secondary Malig Neop of Bladder
 ;;^UTILITY(U,$J,358.3,5146,1,4,0)
 ;;=4^C79.11
 ;;^UTILITY(U,$J,358.3,5146,2)
 ;;=^5001346
 ;;^UTILITY(U,$J,358.3,5147,0)
 ;;=C79.51^^22^224^2
 ;;^UTILITY(U,$J,358.3,5147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5147,1,3,0)
 ;;=3^Secondary Malig Neop of Bone
 ;;^UTILITY(U,$J,358.3,5147,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,5147,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,5148,0)
 ;;=C79.52^^22^224^3
 ;;^UTILITY(U,$J,358.3,5148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5148,1,3,0)
 ;;=3^Secondary Malig Neop of Bone Marrow
 ;;^UTILITY(U,$J,358.3,5148,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,5148,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,5149,0)
 ;;=C79.31^^22^224^4
 ;;^UTILITY(U,$J,358.3,5149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5149,1,3,0)
 ;;=3^Secondary Malig Neop of Brain
 ;;^UTILITY(U,$J,358.3,5149,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,5149,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,5150,0)
 ;;=C79.81^^22^224^5
 ;;^UTILITY(U,$J,358.3,5150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5150,1,3,0)
 ;;=3^Secondary Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,5150,1,4,0)
 ;;=4^C79.81
 ;;^UTILITY(U,$J,358.3,5150,2)
 ;;=^267338
 ;;^UTILITY(U,$J,358.3,5151,0)
 ;;=C79.32^^22^224^6
 ;;^UTILITY(U,$J,358.3,5151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5151,1,3,0)
 ;;=3^Secondary Malig Neop of Cerebral Meninges
 ;;^UTILITY(U,$J,358.3,5151,1,4,0)
 ;;=4^C79.32
 ;;^UTILITY(U,$J,358.3,5151,2)
 ;;=^5001348
 ;;^UTILITY(U,$J,358.3,5152,0)
 ;;=C79.82^^22^224^7
 ;;^UTILITY(U,$J,358.3,5152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5152,1,3,0)
 ;;=3^Secondary Malig Neop of Genital Organs
 ;;^UTILITY(U,$J,358.3,5152,1,4,0)
 ;;=4^C79.82
 ;;^UTILITY(U,$J,358.3,5152,2)
 ;;=^267339
 ;;^UTILITY(U,$J,358.3,5153,0)
 ;;=C79.00^^22^224^8
 ;;^UTILITY(U,$J,358.3,5153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5153,1,3,0)
 ;;=3^Secondary Malig Neop of Kidney/Renal Pelvis
 ;;^UTILITY(U,$J,358.3,5153,1,4,0)
 ;;=4^C79.00
 ;;^UTILITY(U,$J,358.3,5153,2)
 ;;=^5001342
 ;;^UTILITY(U,$J,358.3,5154,0)
 ;;=C79.72^^22^224^9
 ;;^UTILITY(U,$J,358.3,5154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5154,1,3,0)
 ;;=3^Secondary Malig Neop of Left Adrenal Gland
 ;;^UTILITY(U,$J,358.3,5154,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,5154,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,5155,0)
 ;;=C79.62^^22^224^10
 ;;^UTILITY(U,$J,358.3,5155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5155,1,3,0)
 ;;=3^Secondary Malig Neop of Left Ovary
 ;;^UTILITY(U,$J,358.3,5155,1,4,0)
 ;;=4^C79.62
 ;;^UTILITY(U,$J,358.3,5155,2)
 ;;=^5001354
 ;;^UTILITY(U,$J,358.3,5156,0)
 ;;=C79.49^^22^224^11
 ;;^UTILITY(U,$J,358.3,5156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5156,1,3,0)
 ;;=3^Secondary Malig Neop of Nervous System
 ;;^UTILITY(U,$J,358.3,5156,1,4,0)
 ;;=4^C79.49
 ;;^UTILITY(U,$J,358.3,5156,2)
 ;;=^267335
 ;;^UTILITY(U,$J,358.3,5157,0)
 ;;=C79.89^^22^224^12
 ;;^UTILITY(U,$J,358.3,5157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5157,1,3,0)
 ;;=3^Secondary Malig Neop of Other Spec Sites
 ;;^UTILITY(U,$J,358.3,5157,1,4,0)
 ;;=4^C79.89
 ;;^UTILITY(U,$J,358.3,5157,2)
 ;;=^267330
 ;;^UTILITY(U,$J,358.3,5158,0)
 ;;=C79.71^^22^224^13
 ;;^UTILITY(U,$J,358.3,5158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5158,1,3,0)
 ;;=3^Secondary Malig Neop of Right Adrenal Gland
 ;;^UTILITY(U,$J,358.3,5158,1,4,0)
 ;;=4^C79.71
 ;;^UTILITY(U,$J,358.3,5158,2)
 ;;=^5001356
 ;;^UTILITY(U,$J,358.3,5159,0)
 ;;=C79.61^^22^224^15
 ;;^UTILITY(U,$J,358.3,5159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5159,1,3,0)
 ;;=3^Secondary Malig Neop of Right Ovary
 ;;^UTILITY(U,$J,358.3,5159,1,4,0)
 ;;=4^C79.61
 ;;^UTILITY(U,$J,358.3,5159,2)
 ;;=^5001353
