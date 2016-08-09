IBDEI0IE ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18531,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,18531,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,18531,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,18532,0)
 ;;=I65.21^^84^962^130
 ;;^UTILITY(U,$J,358.3,18532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18532,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,18532,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,18532,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,18533,0)
 ;;=I67.89^^84^962^45
 ;;^UTILITY(U,$J,358.3,18533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18533,1,3,0)
 ;;=3^Cerebrovascular Disease NEC
 ;;^UTILITY(U,$J,358.3,18533,1,4,0)
 ;;=4^I67.89
 ;;^UTILITY(U,$J,358.3,18533,2)
 ;;=^5007388
 ;;^UTILITY(U,$J,358.3,18534,0)
 ;;=M86.672^^84^962^47
 ;;^UTILITY(U,$J,358.3,18534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18534,1,3,0)
 ;;=3^Chronic Osteomyelitis of Left Ankle/Foot
 ;;^UTILITY(U,$J,358.3,18534,1,4,0)
 ;;=4^M86.672
 ;;^UTILITY(U,$J,358.3,18534,2)
 ;;=^5014642
 ;;^UTILITY(U,$J,358.3,18535,0)
 ;;=M86.671^^84^962^48
 ;;^UTILITY(U,$J,358.3,18535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18535,1,3,0)
 ;;=3^Chronic Osteomyelitis of Right Ankle/Foot
 ;;^UTILITY(U,$J,358.3,18535,1,4,0)
 ;;=4^M86.671
 ;;^UTILITY(U,$J,358.3,18535,2)
 ;;=^5014641
 ;;^UTILITY(U,$J,358.3,18536,0)
 ;;=M79.89^^84^962^142
 ;;^UTILITY(U,$J,358.3,18536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18536,1,3,0)
 ;;=3^Soft Tissue Disorders NEC
 ;;^UTILITY(U,$J,358.3,18536,1,4,0)
 ;;=4^M79.89
 ;;^UTILITY(U,$J,358.3,18536,2)
 ;;=^5013357
 ;;^UTILITY(U,$J,358.3,18537,0)
 ;;=I73.9^^84^962^131
 ;;^UTILITY(U,$J,358.3,18537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18537,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,18537,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,18537,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,18538,0)
 ;;=I80.13^^84^962^132
 ;;^UTILITY(U,$J,358.3,18538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18538,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Bilateral Femoral Vein
 ;;^UTILITY(U,$J,358.3,18538,1,4,0)
 ;;=4^I80.13
 ;;^UTILITY(U,$J,358.3,18538,2)
 ;;=^5007827
 ;;^UTILITY(U,$J,358.3,18539,0)
 ;;=I80.213^^84^962^133
 ;;^UTILITY(U,$J,358.3,18539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18539,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Bilateral Iliac Vein
 ;;^UTILITY(U,$J,358.3,18539,1,4,0)
 ;;=4^I80.213
 ;;^UTILITY(U,$J,358.3,18539,2)
 ;;=^5007833
 ;;^UTILITY(U,$J,358.3,18540,0)
 ;;=I80.12^^84^962^135
 ;;^UTILITY(U,$J,358.3,18540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18540,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Left Femoral Vein
 ;;^UTILITY(U,$J,358.3,18540,1,4,0)
 ;;=4^I80.12
 ;;^UTILITY(U,$J,358.3,18540,2)
 ;;=^5007826
 ;;^UTILITY(U,$J,358.3,18541,0)
 ;;=I80.212^^84^962^136
 ;;^UTILITY(U,$J,358.3,18541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18541,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Left Iliac Vein
 ;;^UTILITY(U,$J,358.3,18541,1,4,0)
 ;;=4^I80.212
 ;;^UTILITY(U,$J,358.3,18541,2)
 ;;=^5007832
 ;;^UTILITY(U,$J,358.3,18542,0)
 ;;=I80.11^^84^962^138
 ;;^UTILITY(U,$J,358.3,18542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18542,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Right Femoral Vein
 ;;^UTILITY(U,$J,358.3,18542,1,4,0)
 ;;=4^I80.11
 ;;^UTILITY(U,$J,358.3,18542,2)
 ;;=^5007825
 ;;^UTILITY(U,$J,358.3,18543,0)
 ;;=I80.211^^84^962^139
 ;;^UTILITY(U,$J,358.3,18543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18543,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Right Iliac Vein
 ;;^UTILITY(U,$J,358.3,18543,1,4,0)
 ;;=4^I80.211
 ;;^UTILITY(U,$J,358.3,18543,2)
 ;;=^5007831
 ;;^UTILITY(U,$J,358.3,18544,0)
 ;;=I80.203^^84^962^134
 ;;^UTILITY(U,$J,358.3,18544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18544,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Bilateral Lower Extrem Deep Vessels
 ;;^UTILITY(U,$J,358.3,18544,1,4,0)
 ;;=4^I80.203
 ;;^UTILITY(U,$J,358.3,18544,2)
 ;;=^5007830
 ;;^UTILITY(U,$J,358.3,18545,0)
 ;;=I80.202^^84^962^137
 ;;^UTILITY(U,$J,358.3,18545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18545,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Left Lower Extrem Deep Vessels
 ;;^UTILITY(U,$J,358.3,18545,1,4,0)
 ;;=4^I80.202
 ;;^UTILITY(U,$J,358.3,18545,2)
 ;;=^5007829
 ;;^UTILITY(U,$J,358.3,18546,0)
 ;;=I80.201^^84^962^140
 ;;^UTILITY(U,$J,358.3,18546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18546,1,3,0)
 ;;=3^Phlebitis/Thrombophlebitis of Right Lower Extrem Deep Vessels
 ;;^UTILITY(U,$J,358.3,18546,1,4,0)
 ;;=4^I80.201
 ;;^UTILITY(U,$J,358.3,18546,2)
 ;;=^5007828
 ;;^UTILITY(U,$J,358.3,18547,0)
 ;;=I73.00^^84^962^141
 ;;^UTILITY(U,$J,358.3,18547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18547,1,3,0)
 ;;=3^Raynaud's Syndrome w/o Gangrene
 ;;^UTILITY(U,$J,358.3,18547,1,4,0)
 ;;=4^I73.00
 ;;^UTILITY(U,$J,358.3,18547,2)
 ;;=^5007796
 ;;^UTILITY(U,$J,358.3,18548,0)
 ;;=I77.1^^84^962^143
 ;;^UTILITY(U,$J,358.3,18548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18548,1,3,0)
 ;;=3^Stricture of Artery
 ;;^UTILITY(U,$J,358.3,18548,1,4,0)
 ;;=4^I77.1
 ;;^UTILITY(U,$J,358.3,18548,2)
 ;;=^114763
 ;;^UTILITY(U,$J,358.3,18549,0)
 ;;=I71.2^^84^962^144
 ;;^UTILITY(U,$J,358.3,18549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18549,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,18549,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,18549,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,18550,0)
 ;;=I71.5^^84^962^145
 ;;^UTILITY(U,$J,358.3,18550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18550,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/ Rupture
 ;;^UTILITY(U,$J,358.3,18550,1,4,0)
 ;;=4^I71.5
 ;;^UTILITY(U,$J,358.3,18550,2)
 ;;=^5007790
 ;;^UTILITY(U,$J,358.3,18551,0)
 ;;=I71.6^^84^962^146
 ;;^UTILITY(U,$J,358.3,18551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18551,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,18551,1,4,0)
 ;;=4^I71.6
 ;;^UTILITY(U,$J,358.3,18551,2)
 ;;=^5007791
 ;;^UTILITY(U,$J,358.3,18552,0)
 ;;=E10.620^^84^962^52
 ;;^UTILITY(U,$J,358.3,18552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18552,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,18552,1,4,0)
 ;;=4^E10.620
 ;;^UTILITY(U,$J,358.3,18552,2)
 ;;=^5002615
 ;;^UTILITY(U,$J,358.3,18553,0)
 ;;=E10.40^^84^962^53
 ;;^UTILITY(U,$J,358.3,18553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18553,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,18553,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,18553,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,18554,0)
 ;;=E10.51^^84^962^54
 ;;^UTILITY(U,$J,358.3,18554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18554,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,18554,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,18554,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,18555,0)
 ;;=E10.621^^84^962^56
 ;;^UTILITY(U,$J,358.3,18555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18555,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,18555,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,18555,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,18556,0)
 ;;=E10.65^^84^962^57
 ;;^UTILITY(U,$J,358.3,18556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18556,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,18556,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,18556,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,18557,0)
 ;;=E10.649^^84^962^58
 ;;^UTILITY(U,$J,358.3,18557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18557,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hypoglycemia w/o Coma
 ;;^UTILITY(U,$J,358.3,18557,1,4,0)
 ;;=4^E10.649
 ;;^UTILITY(U,$J,358.3,18557,2)
 ;;=^5002622
 ;;^UTILITY(U,$J,358.3,18558,0)
 ;;=E10.618^^84^962^51
