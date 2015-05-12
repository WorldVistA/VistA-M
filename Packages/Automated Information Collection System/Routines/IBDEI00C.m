IBDEI00C ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,109,1,3,0)
 ;;=3^Chronic Osteomyelitis of Right Ankle/Foot
 ;;^UTILITY(U,$J,358.3,109,1,4,0)
 ;;=4^M86.671
 ;;^UTILITY(U,$J,358.3,109,2)
 ;;=^5014641
 ;;^UTILITY(U,$J,358.3,110,0)
 ;;=M79.89^^1^1^144
 ;;^UTILITY(U,$J,358.3,110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,110,1,3,0)
 ;;=3^Soft Tissue Disorders NEC
 ;;^UTILITY(U,$J,358.3,110,1,4,0)
 ;;=4^M79.89
 ;;^UTILITY(U,$J,358.3,110,2)
 ;;=^5013357
 ;;^UTILITY(U,$J,358.3,111,0)
 ;;=I73.9^^1^1^133
 ;;^UTILITY(U,$J,358.3,111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,111,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,111,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,111,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,112,0)
 ;;=I80.13^^1^1^134
 ;;^UTILITY(U,$J,358.3,112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,112,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Bilateral Femoral Vein
 ;;^UTILITY(U,$J,358.3,112,1,4,0)
 ;;=4^I80.13
 ;;^UTILITY(U,$J,358.3,112,2)
 ;;=^5007827
 ;;^UTILITY(U,$J,358.3,113,0)
 ;;=I80.213^^1^1^135
 ;;^UTILITY(U,$J,358.3,113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,113,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Bilateral Iliac Vein
 ;;^UTILITY(U,$J,358.3,113,1,4,0)
 ;;=4^I80.213
 ;;^UTILITY(U,$J,358.3,113,2)
 ;;=^5007833
 ;;^UTILITY(U,$J,358.3,114,0)
 ;;=I80.12^^1^1^137
 ;;^UTILITY(U,$J,358.3,114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,114,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Left Femoral Vein
 ;;^UTILITY(U,$J,358.3,114,1,4,0)
 ;;=4^I80.12
 ;;^UTILITY(U,$J,358.3,114,2)
 ;;=^5007826
 ;;^UTILITY(U,$J,358.3,115,0)
 ;;=I80.212^^1^1^138
 ;;^UTILITY(U,$J,358.3,115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,115,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Left Iliac Vein
 ;;^UTILITY(U,$J,358.3,115,1,4,0)
 ;;=4^I80.212
 ;;^UTILITY(U,$J,358.3,115,2)
 ;;=^5007832
 ;;^UTILITY(U,$J,358.3,116,0)
 ;;=I80.11^^1^1^140
 ;;^UTILITY(U,$J,358.3,116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,116,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,116,1,4,0)
 ;;=4^I80.11
 ;;^UTILITY(U,$J,358.3,116,2)
 ;;=^5007825
 ;;^UTILITY(U,$J,358.3,117,0)
 ;;=I80.211^^1^1^141
 ;;^UTILITY(U,$J,358.3,117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,117,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Right Iliac Vein
 ;;^UTILITY(U,$J,358.3,117,1,4,0)
 ;;=4^I80.211
 ;;^UTILITY(U,$J,358.3,117,2)
 ;;=^5007831
 ;;^UTILITY(U,$J,358.3,118,0)
 ;;=I80.203^^1^1^136
 ;;^UTILITY(U,$J,358.3,118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,118,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Bilateral Lower Extrem Deep Vessels
 ;;^UTILITY(U,$J,358.3,118,1,4,0)
 ;;=4^I80.203
 ;;^UTILITY(U,$J,358.3,118,2)
 ;;=^5007830
 ;;^UTILITY(U,$J,358.3,119,0)
 ;;=I80.202^^1^1^139
 ;;^UTILITY(U,$J,358.3,119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,119,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Left Lower Extrem Deep Vessels
 ;;^UTILITY(U,$J,358.3,119,1,4,0)
 ;;=4^I80.202
 ;;^UTILITY(U,$J,358.3,119,2)
 ;;=^5007829
 ;;^UTILITY(U,$J,358.3,120,0)
 ;;=I80.201^^1^1^142
 ;;^UTILITY(U,$J,358.3,120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,120,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Right Lower Extrem Deep Vessels
 ;;^UTILITY(U,$J,358.3,120,1,4,0)
 ;;=4^I80.201
 ;;^UTILITY(U,$J,358.3,120,2)
 ;;=^5007828
 ;;^UTILITY(U,$J,358.3,121,0)
 ;;=I73.00^^1^1^143
 ;;^UTILITY(U,$J,358.3,121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,121,1,3,0)
 ;;=3^Raynaud's Syndrome w/o Gangrene
 ;;^UTILITY(U,$J,358.3,121,1,4,0)
 ;;=4^I73.00
 ;;^UTILITY(U,$J,358.3,121,2)
 ;;=^5007796
 ;;^UTILITY(U,$J,358.3,122,0)
 ;;=I77.1^^1^1^145
 ;;^UTILITY(U,$J,358.3,122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,122,1,3,0)
 ;;=3^Stricture of Artery
 ;;^UTILITY(U,$J,358.3,122,1,4,0)
 ;;=4^I77.1
 ;;^UTILITY(U,$J,358.3,122,2)
 ;;=^114763
 ;;^UTILITY(U,$J,358.3,123,0)
 ;;=I71.2^^1^1^146
 ;;^UTILITY(U,$J,358.3,123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,123,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,123,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,123,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,124,0)
 ;;=I71.5^^1^1^147
 ;;^UTILITY(U,$J,358.3,124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,124,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/ Rupture
 ;;^UTILITY(U,$J,358.3,124,1,4,0)
 ;;=4^I71.5
 ;;^UTILITY(U,$J,358.3,124,2)
 ;;=^5007790
 ;;^UTILITY(U,$J,358.3,125,0)
 ;;=I71.6^^1^1^148
 ;;^UTILITY(U,$J,358.3,125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,125,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,125,1,4,0)
 ;;=4^I71.6
 ;;^UTILITY(U,$J,358.3,125,2)
 ;;=^5007791
 ;;^UTILITY(U,$J,358.3,126,0)
 ;;=E10.620^^1^1^56
 ;;^UTILITY(U,$J,358.3,126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,126,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,126,1,4,0)
 ;;=4^E10.620
 ;;^UTILITY(U,$J,358.3,126,2)
 ;;=^5002615
 ;;^UTILITY(U,$J,358.3,127,0)
 ;;=E10.40^^1^1^57
 ;;^UTILITY(U,$J,358.3,127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,127,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,127,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,127,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,128,0)
 ;;=E10.51^^1^1^58
 ;;^UTILITY(U,$J,358.3,128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,128,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,128,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,128,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,129,0)
 ;;=E10.621^^1^1^59
 ;;^UTILITY(U,$J,358.3,129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,129,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,129,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,129,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,130,0)
 ;;=E10.65^^1^1^60
 ;;^UTILITY(U,$J,358.3,130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,130,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,130,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,130,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,131,0)
 ;;=E10.649^^1^1^61
 ;;^UTILITY(U,$J,358.3,131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,131,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hypoglycemia w/o Coma
 ;;^UTILITY(U,$J,358.3,131,1,4,0)
 ;;=4^E10.649
 ;;^UTILITY(U,$J,358.3,131,2)
 ;;=^5002622
 ;;^UTILITY(U,$J,358.3,132,0)
 ;;=E10.618^^1^1^55
 ;;^UTILITY(U,$J,358.3,132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,132,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,132,1,4,0)
 ;;=4^E10.618
 ;;^UTILITY(U,$J,358.3,132,2)
 ;;=^5002614
 ;;^UTILITY(U,$J,358.3,133,0)
 ;;=E10.638^^1^1^62
 ;;^UTILITY(U,$J,358.3,133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,133,1,3,0)
 ;;=3^Diabetes Type 1 w/ Oral Complications
 ;;^UTILITY(U,$J,358.3,133,1,4,0)
 ;;=4^E10.638
 ;;^UTILITY(U,$J,358.3,133,2)
 ;;=^5002620
 ;;^UTILITY(U,$J,358.3,134,0)
 ;;=E10.628^^1^1^64
 ;;^UTILITY(U,$J,358.3,134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,134,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Complications
 ;;^UTILITY(U,$J,358.3,134,1,4,0)
 ;;=4^E10.628
 ;;^UTILITY(U,$J,358.3,134,2)
 ;;=^5002618
 ;;^UTILITY(U,$J,358.3,135,0)
 ;;=E10.622^^1^1^65
 ;;^UTILITY(U,$J,358.3,135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,135,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Ulcer
 ;;^UTILITY(U,$J,358.3,135,1,4,0)
 ;;=4^E10.622
 ;;^UTILITY(U,$J,358.3,135,2)
 ;;=^5002617
 ;;^UTILITY(U,$J,358.3,136,0)
 ;;=E10.69^^1^1^54
 ;;^UTILITY(U,$J,358.3,136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,136,1,3,0)
 ;;=3^Diabetes Type 1 w/ Complications NEC
 ;;^UTILITY(U,$J,358.3,136,1,4,0)
 ;;=4^E10.69
 ;;^UTILITY(U,$J,358.3,136,2)
 ;;=^5002624
 ;;^UTILITY(U,$J,358.3,137,0)
 ;;=E10.630^^1^1^63
 ;;^UTILITY(U,$J,358.3,137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,137,1,3,0)
 ;;=3^Diabetes Type 1 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,137,1,4,0)
 ;;=4^E10.630
 ;;^UTILITY(U,$J,358.3,137,2)
 ;;=^5002619
 ;;^UTILITY(U,$J,358.3,138,0)
 ;;=E11.620^^1^1^68
 ;;^UTILITY(U,$J,358.3,138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,138,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,138,1,4,0)
 ;;=4^E11.620
 ;;^UTILITY(U,$J,358.3,138,2)
 ;;=^5002655
 ;;^UTILITY(U,$J,358.3,139,0)
 ;;=E11.40^^1^1^69
 ;;^UTILITY(U,$J,358.3,139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,139,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,139,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,139,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,140,0)
 ;;=E11.51^^1^1^70
 ;;^UTILITY(U,$J,358.3,140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,140,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,140,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,140,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,141,0)
 ;;=E11.621^^1^1^71
 ;;^UTILITY(U,$J,358.3,141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,141,1,3,0)
 ;;=3^Diabetes Type 2 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,141,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,141,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,142,0)
 ;;=E11.65^^1^1^72
 ;;^UTILITY(U,$J,358.3,142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,142,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,142,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,142,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,143,0)
 ;;=E11.649^^1^1^73
 ;;^UTILITY(U,$J,358.3,143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,143,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hypoglycemia w/o Coma
 ;;^UTILITY(U,$J,358.3,143,1,4,0)
 ;;=4^E11.649
 ;;^UTILITY(U,$J,358.3,143,2)
 ;;=^5002662
 ;;^UTILITY(U,$J,358.3,144,0)
 ;;=E11.618^^1^1^67
 ;;^UTILITY(U,$J,358.3,144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,144,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,144,1,4,0)
 ;;=4^E11.618
 ;;^UTILITY(U,$J,358.3,144,2)
 ;;=^5002654
 ;;^UTILITY(U,$J,358.3,145,0)
 ;;=E11.638^^1^1^74
