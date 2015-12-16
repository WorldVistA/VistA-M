IBDEI09P ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4113,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4113,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,4113,1,3,0)
 ;;=3^Ed/Training,Self-Mgmnt,5-8 Pts,Ea 15 min
 ;;^UTILITY(U,$J,358.3,4114,0)
 ;;=99366^^16^191^1^^^^1
 ;;^UTILITY(U,$J,358.3,4114,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4114,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,4114,1,3,0)
 ;;=3^Interdisc. Team Mtg. w/Pt w/o Physician
 ;;^UTILITY(U,$J,358.3,4115,0)
 ;;=99368^^16^191^3^^^^1
 ;;^UTILITY(U,$J,358.3,4115,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4115,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,4115,1,3,0)
 ;;=3^Interdisc. Team Mtg. w/o Pt w/o Phys
 ;;^UTILITY(U,$J,358.3,4116,0)
 ;;=99367^^16^191^2^^^^1
 ;;^UTILITY(U,$J,358.3,4116,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4116,1,2,0)
 ;;=2^99367
 ;;^UTILITY(U,$J,358.3,4116,1,3,0)
 ;;=3^Interdisc. Team Mtg. w/o Pt w/Phys
 ;;^UTILITY(U,$J,358.3,4117,0)
 ;;=99600^^16^192^2^^^^1
 ;;^UTILITY(U,$J,358.3,4117,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4117,1,2,0)
 ;;=2^99600
 ;;^UTILITY(U,$J,358.3,4117,1,3,0)
 ;;=3^Home Visit by Nonphysician
 ;;^UTILITY(U,$J,358.3,4118,0)
 ;;=G0155^^16^192^1^^^^1
 ;;^UTILITY(U,$J,358.3,4118,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4118,1,2,0)
 ;;=2^G0155
 ;;^UTILITY(U,$J,358.3,4118,1,3,0)
 ;;=3^Home Visit by CSW,ea 15 min
 ;;^UTILITY(U,$J,358.3,4119,0)
 ;;=92081^^16^193^5^^^^1
 ;;^UTILITY(U,$J,358.3,4119,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4119,1,2,0)
 ;;=2^92081
 ;;^UTILITY(U,$J,358.3,4119,1,3,0)
 ;;=3^Visual Field Exams
 ;;^UTILITY(U,$J,358.3,4120,0)
 ;;=99172^^16^193^2^^^^1
 ;;^UTILITY(U,$J,358.3,4120,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4120,1,2,0)
 ;;=2^99172
 ;;^UTILITY(U,$J,358.3,4120,1,3,0)
 ;;=3^Ocular Function Screen
 ;;^UTILITY(U,$J,358.3,4121,0)
 ;;=V2600^^16^193^1^^^^1
 ;;^UTILITY(U,$J,358.3,4121,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4121,1,2,0)
 ;;=2^V2600
 ;;^UTILITY(U,$J,358.3,4121,1,3,0)
 ;;=3^Hand Held Low Vision Aids
 ;;^UTILITY(U,$J,358.3,4122,0)
 ;;=V2610^^16^193^3^^^^1
 ;;^UTILITY(U,$J,358.3,4122,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4122,1,2,0)
 ;;=2^V2610
 ;;^UTILITY(U,$J,358.3,4122,1,3,0)
 ;;=3^Single Lens Spectacle Mount
 ;;^UTILITY(U,$J,358.3,4123,0)
 ;;=V2615^^16^193^4^^^^1
 ;;^UTILITY(U,$J,358.3,4123,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4123,1,2,0)
 ;;=2^V2615
 ;;^UTILITY(U,$J,358.3,4123,1,3,0)
 ;;=3^Telescope/Oth Compound Lens
 ;;^UTILITY(U,$J,358.3,4124,0)
 ;;=98969^^16^194^1^^^^1
 ;;^UTILITY(U,$J,358.3,4124,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4124,1,2,0)
 ;;=2^98969
 ;;^UTILITY(U,$J,358.3,4124,1,3,0)
 ;;=3^Online Service by HC Provider
 ;;^UTILITY(U,$J,358.3,4125,0)
 ;;=Q3014^^16^194^2^^^^1
 ;;^UTILITY(U,$J,358.3,4125,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4125,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,4125,1,3,0)
 ;;=3^Telehealth Originating Site Fee
 ;;^UTILITY(U,$J,358.3,4126,0)
 ;;=98960^^16^195^1^^^^1
 ;;^UTILITY(U,$J,358.3,4126,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4126,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,4126,1,3,0)
 ;;=3^Self-Mgmt Ed & Train 1 Pt
 ;;^UTILITY(U,$J,358.3,4127,0)
 ;;=98961^^16^195^2^^^^1
 ;;^UTILITY(U,$J,358.3,4127,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4127,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,4127,1,3,0)
 ;;=3^Self-Mgmt Ed & Train 2-4 Pts
 ;;^UTILITY(U,$J,358.3,4128,0)
 ;;=98962^^16^195^3^^^^1
 ;;^UTILITY(U,$J,358.3,4128,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4128,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,4128,1,3,0)
 ;;=3^Self-Mgmt Ed & Train 5-8 Pts
 ;;^UTILITY(U,$J,358.3,4129,0)
 ;;=V72.0^^17^196^2
