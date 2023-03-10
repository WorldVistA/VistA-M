IBDEI0JP ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8863,1,3,0)
 ;;=3^Presence of Artificial Wrist Joint,Right
 ;;^UTILITY(U,$J,358.3,8863,1,4,0)
 ;;=4^Z96.631
 ;;^UTILITY(U,$J,358.3,8863,2)
 ;;=^5063698
 ;;^UTILITY(U,$J,358.3,8864,0)
 ;;=Z93.6^^39^402^154
 ;;^UTILITY(U,$J,358.3,8864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8864,1,3,0)
 ;;=3^Urostomy Status
 ;;^UTILITY(U,$J,358.3,8864,1,4,0)
 ;;=4^Z93.6
 ;;^UTILITY(U,$J,358.3,8864,2)
 ;;=^5063651
 ;;^UTILITY(U,$J,358.3,8865,0)
 ;;=Z95.820^^39^402^67
 ;;^UTILITY(U,$J,358.3,8865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8865,1,3,0)
 ;;=3^Peripheral Vascular Angioplasty Status w/ Graft
 ;;^UTILITY(U,$J,358.3,8865,1,4,0)
 ;;=4^Z95.820
 ;;^UTILITY(U,$J,358.3,8865,2)
 ;;=^5063678
 ;;^UTILITY(U,$J,358.3,8866,0)
 ;;=Z95.0^^39^402^126
 ;;^UTILITY(U,$J,358.3,8866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8866,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,8866,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,8866,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,8867,0)
 ;;=Z95.810^^39^402^124
 ;;^UTILITY(U,$J,358.3,8867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8867,1,3,0)
 ;;=3^Presence of Automatic Cardiac Debribrillator
 ;;^UTILITY(U,$J,358.3,8867,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,8867,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,8868,0)
 ;;=Z91.51^^39^402^104
 ;;^UTILITY(U,$J,358.3,8868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8868,1,3,0)
 ;;=3^Personal Hx of Suicidal Behavior
 ;;^UTILITY(U,$J,358.3,8868,1,4,0)
 ;;=4^Z91.51
 ;;^UTILITY(U,$J,358.3,8868,2)
 ;;=^5161317
 ;;^UTILITY(U,$J,358.3,8869,0)
 ;;=A15.0^^39^403^91
 ;;^UTILITY(U,$J,358.3,8869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8869,1,3,0)
 ;;=3^Tuberculosis of Lung
 ;;^UTILITY(U,$J,358.3,8869,1,4,0)
 ;;=4^A15.0
 ;;^UTILITY(U,$J,358.3,8869,2)
 ;;=^5000062
 ;;^UTILITY(U,$J,358.3,8870,0)
 ;;=B20.^^39^403^34
 ;;^UTILITY(U,$J,358.3,8870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8870,1,3,0)
 ;;=3^HIV Disease
 ;;^UTILITY(U,$J,358.3,8870,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,8870,2)
 ;;=^5000555
 ;;^UTILITY(U,$J,358.3,8871,0)
 ;;=B02.9^^39^403^100
 ;;^UTILITY(U,$J,358.3,8871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8871,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,8871,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,8871,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,8872,0)
 ;;=A60.9^^39^403^2
 ;;^UTILITY(U,$J,358.3,8872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8872,1,3,0)
 ;;=3^Anogenital Herpesviral Infection,Unspec
 ;;^UTILITY(U,$J,358.3,8872,1,4,0)
 ;;=4^A60.9
 ;;^UTILITY(U,$J,358.3,8872,2)
 ;;=^5000359
 ;;^UTILITY(U,$J,358.3,8873,0)
 ;;=A60.04^^39^403^37
 ;;^UTILITY(U,$J,358.3,8873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8873,1,3,0)
 ;;=3^Herpesviral Vulvovaginitis
 ;;^UTILITY(U,$J,358.3,8873,1,4,0)
 ;;=4^A60.04
 ;;^UTILITY(U,$J,358.3,8873,2)
 ;;=^5000356
 ;;^UTILITY(U,$J,358.3,8874,0)
 ;;=A60.01^^39^403^35
 ;;^UTILITY(U,$J,358.3,8874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8874,1,3,0)
 ;;=3^Herpesviral Infection of Penis
 ;;^UTILITY(U,$J,358.3,8874,1,4,0)
 ;;=4^A60.01
 ;;^UTILITY(U,$J,358.3,8874,2)
 ;;=^5000353
 ;;^UTILITY(U,$J,358.3,8875,0)
 ;;=B00.1^^39^403^36
 ;;^UTILITY(U,$J,358.3,8875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8875,1,3,0)
 ;;=3^Herpesviral Vesicular Dermatitis
 ;;^UTILITY(U,$J,358.3,8875,1,4,0)
 ;;=4^B00.1
 ;;^UTILITY(U,$J,358.3,8875,2)
 ;;=^5000468
