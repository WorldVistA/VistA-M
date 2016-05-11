IBDEI037 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1048,2)
 ;;=^5011618
 ;;^UTILITY(U,$J,358.3,1049,0)
 ;;=R10.2^^6^109^20
 ;;^UTILITY(U,$J,358.3,1049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1049,1,3,0)
 ;;=3^Pelvic & Perineal Pain
 ;;^UTILITY(U,$J,358.3,1049,1,4,0)
 ;;=4^R10.2
 ;;^UTILITY(U,$J,358.3,1049,2)
 ;;=^5019209
 ;;^UTILITY(U,$J,358.3,1050,0)
 ;;=Z51.5^^6^109^17
 ;;^UTILITY(U,$J,358.3,1050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1050,1,3,0)
 ;;=3^Palliative Care Encounter
 ;;^UTILITY(U,$J,358.3,1050,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,1050,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,1051,0)
 ;;=Z95.3^^6^109^36
 ;;^UTILITY(U,$J,358.3,1051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1051,1,3,0)
 ;;=3^Presence of Xenogenic Heart Valve
 ;;^UTILITY(U,$J,358.3,1051,1,4,0)
 ;;=4^Z95.3
 ;;^UTILITY(U,$J,358.3,1051,2)
 ;;=^5063671
 ;;^UTILITY(U,$J,358.3,1052,0)
 ;;=Z95.1^^6^109^35
 ;;^UTILITY(U,$J,358.3,1052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1052,1,3,0)
 ;;=3^Presence of Aortocoronary Bypass Graft
 ;;^UTILITY(U,$J,358.3,1052,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,1052,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,1053,0)
 ;;=Z98.89^^6^109^34
 ;;^UTILITY(U,$J,358.3,1053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1053,1,3,0)
 ;;=3^Postprocedural States,Other Specified
 ;;^UTILITY(U,$J,358.3,1053,1,4,0)
 ;;=4^Z98.89
 ;;^UTILITY(U,$J,358.3,1053,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,1054,0)
 ;;=I80.201^^6^109^25
 ;;^UTILITY(U,$J,358.3,1054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1054,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Deep Vessels Right Lower Extremity
 ;;^UTILITY(U,$J,358.3,1054,1,4,0)
 ;;=4^I80.201
 ;;^UTILITY(U,$J,358.3,1054,2)
 ;;=^5007828
 ;;^UTILITY(U,$J,358.3,1055,0)
 ;;=I80.202^^6^109^26
 ;;^UTILITY(U,$J,358.3,1055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1055,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Deep Vessels Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,1055,1,4,0)
 ;;=4^I80.202
 ;;^UTILITY(U,$J,358.3,1055,2)
 ;;=^5007829
 ;;^UTILITY(U,$J,358.3,1056,0)
 ;;=I80.203^^6^109^27
 ;;^UTILITY(U,$J,358.3,1056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1056,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Deep Vessels Bilateral Lower Extremity
 ;;^UTILITY(U,$J,358.3,1056,1,4,0)
 ;;=4^I80.203
 ;;^UTILITY(U,$J,358.3,1056,2)
 ;;=^5007830
 ;;^UTILITY(U,$J,358.3,1057,0)
 ;;=K27.9^^6^109^21
 ;;^UTILITY(U,$J,358.3,1057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1057,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,1057,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,1057,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,1058,0)
 ;;=J31.0^^6^110^4
 ;;^UTILITY(U,$J,358.3,1058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1058,1,3,0)
 ;;=3^Rhinitis,Chronic
 ;;^UTILITY(U,$J,358.3,1058,1,4,0)
 ;;=4^J31.0
 ;;^UTILITY(U,$J,358.3,1058,2)
 ;;=^24434
 ;;^UTILITY(U,$J,358.3,1059,0)
 ;;=M06.9^^6^110^3
 ;;^UTILITY(U,$J,358.3,1059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1059,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,1059,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,1059,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,1060,0)
 ;;=M54.10^^6^110^1
 ;;^UTILITY(U,$J,358.3,1060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1060,1,3,0)
 ;;=3^Radiculopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,1060,1,4,0)
 ;;=4^M54.10
 ;;^UTILITY(U,$J,358.3,1060,2)
 ;;=^5012295
 ;;^UTILITY(U,$J,358.3,1061,0)
 ;;=R21.^^6^110^2
 ;;^UTILITY(U,$J,358.3,1061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1061,1,3,0)
 ;;=3^Rash & Oth Nonspecific Skin Eruption
 ;;^UTILITY(U,$J,358.3,1061,1,4,0)
 ;;=4^R21.
 ;;^UTILITY(U,$J,358.3,1061,2)
 ;;=^5019283
