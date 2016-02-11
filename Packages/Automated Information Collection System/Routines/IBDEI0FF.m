IBDEI0FF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6800,1,3,0)
 ;;=3^Malig Neop Skin of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,6800,1,4,0)
 ;;=4^C44.692
 ;;^UTILITY(U,$J,358.3,6800,2)
 ;;=^5001073
 ;;^UTILITY(U,$J,358.3,6801,0)
 ;;=C44.699^^46^451^22
 ;;^UTILITY(U,$J,358.3,6801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6801,1,3,0)
 ;;=3^Malig Neop Skin of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,6801,1,4,0)
 ;;=4^C44.699
 ;;^UTILITY(U,$J,358.3,6801,2)
 ;;=^5001074
 ;;^UTILITY(U,$J,358.3,6802,0)
 ;;=C44.99^^46^451^33
 ;;^UTILITY(U,$J,358.3,6802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6802,1,3,0)
 ;;=3^Malig Neop Skin,Unspec Site
 ;;^UTILITY(U,$J,358.3,6802,1,4,0)
 ;;=4^C44.99
 ;;^UTILITY(U,$J,358.3,6802,2)
 ;;=^5001094
 ;;^UTILITY(U,$J,358.3,6803,0)
 ;;=C44.792^^46^451^28
 ;;^UTILITY(U,$J,358.3,6803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6803,1,3,0)
 ;;=3^Malig Neop Skin of Right Lower Limb
 ;;^UTILITY(U,$J,358.3,6803,1,4,0)
 ;;=4^C44.792
 ;;^UTILITY(U,$J,358.3,6803,2)
 ;;=^5001085
 ;;^UTILITY(U,$J,358.3,6804,0)
 ;;=C44.799^^46^451^21
 ;;^UTILITY(U,$J,358.3,6804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6804,1,3,0)
 ;;=3^Malig Neop Skin of Left Lower Limb
 ;;^UTILITY(U,$J,358.3,6804,1,4,0)
 ;;=4^C44.799
 ;;^UTILITY(U,$J,358.3,6804,2)
 ;;=^5001086
 ;;^UTILITY(U,$J,358.3,6805,0)
 ;;=C44.89^^46^451^25
 ;;^UTILITY(U,$J,358.3,6805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6805,1,3,0)
 ;;=3^Malig Neop Skin of Overlapping Sites
 ;;^UTILITY(U,$J,358.3,6805,1,4,0)
 ;;=4^C44.89
 ;;^UTILITY(U,$J,358.3,6805,2)
 ;;=^5001090
 ;;^UTILITY(U,$J,358.3,6806,0)
 ;;=C43.0^^46^451^7
 ;;^UTILITY(U,$J,358.3,6806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6806,1,3,0)
 ;;=3^Malig Melanoma of Lip
 ;;^UTILITY(U,$J,358.3,6806,1,4,0)
 ;;=4^C43.0
 ;;^UTILITY(U,$J,358.3,6806,2)
 ;;=^5000994
 ;;^UTILITY(U,$J,358.3,6807,0)
 ;;=C43.12^^46^451^4
 ;;^UTILITY(U,$J,358.3,6807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6807,1,3,0)
 ;;=3^Malig Melanoma of Left Eyelid
 ;;^UTILITY(U,$J,358.3,6807,1,4,0)
 ;;=4^C43.12
 ;;^UTILITY(U,$J,358.3,6807,2)
 ;;=^5000997
 ;;^UTILITY(U,$J,358.3,6808,0)
 ;;=C43.11^^46^451^11
 ;;^UTILITY(U,$J,358.3,6808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6808,1,3,0)
 ;;=3^Malig Melanoma of Right Eyelid
 ;;^UTILITY(U,$J,358.3,6808,1,4,0)
 ;;=4^C43.11
 ;;^UTILITY(U,$J,358.3,6808,2)
 ;;=^5000996
 ;;^UTILITY(U,$J,358.3,6809,0)
 ;;=C43.21^^46^451^10
 ;;^UTILITY(U,$J,358.3,6809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6809,1,3,0)
 ;;=3^Malig Melanoma of Right Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,6809,1,4,0)
 ;;=4^C43.21
 ;;^UTILITY(U,$J,358.3,6809,2)
 ;;=^5000999
 ;;^UTILITY(U,$J,358.3,6810,0)
 ;;=C43.22^^46^451^3
 ;;^UTILITY(U,$J,358.3,6810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6810,1,3,0)
 ;;=3^Malig Melanoma of Left Ear/External Auricular Canal
 ;;^UTILITY(U,$J,358.3,6810,1,4,0)
 ;;=4^C43.22
 ;;^UTILITY(U,$J,358.3,6810,2)
 ;;=^5001000
 ;;^UTILITY(U,$J,358.3,6811,0)
 ;;=C43.31^^46^451^8
 ;;^UTILITY(U,$J,358.3,6811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6811,1,3,0)
 ;;=3^Malig Melanoma of Nose
 ;;^UTILITY(U,$J,358.3,6811,1,4,0)
 ;;=4^C43.31
 ;;^UTILITY(U,$J,358.3,6811,2)
 ;;=^5001002
 ;;^UTILITY(U,$J,358.3,6812,0)
 ;;=C43.39^^46^451^2
 ;;^UTILITY(U,$J,358.3,6812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6812,1,3,0)
 ;;=3^Malig Melanoma of Face,Other Parts
 ;;^UTILITY(U,$J,358.3,6812,1,4,0)
 ;;=4^C43.39
 ;;^UTILITY(U,$J,358.3,6812,2)
 ;;=^5001003
 ;;^UTILITY(U,$J,358.3,6813,0)
 ;;=C43.4^^46^451^14
 ;;^UTILITY(U,$J,358.3,6813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6813,1,3,0)
 ;;=3^Malig Melanoma of Scalp/Neck
