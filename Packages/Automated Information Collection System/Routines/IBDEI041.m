IBDEI041 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1185,1,4,0)
 ;;=4^I80.202
 ;;^UTILITY(U,$J,358.3,1185,2)
 ;;=^5007829
 ;;^UTILITY(U,$J,358.3,1186,0)
 ;;=I80.203^^12^131^27
 ;;^UTILITY(U,$J,358.3,1186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1186,1,3,0)
 ;;=3^Phlebitis & Thrombophlebitis Deep Vessels Bilateral Lower Extremity
 ;;^UTILITY(U,$J,358.3,1186,1,4,0)
 ;;=4^I80.203
 ;;^UTILITY(U,$J,358.3,1186,2)
 ;;=^5007830
 ;;^UTILITY(U,$J,358.3,1187,0)
 ;;=K27.9^^12^131^21
 ;;^UTILITY(U,$J,358.3,1187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1187,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,1187,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,1187,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,1188,0)
 ;;=J31.0^^12^132^4
 ;;^UTILITY(U,$J,358.3,1188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1188,1,3,0)
 ;;=3^Rhinitis,Chronic
 ;;^UTILITY(U,$J,358.3,1188,1,4,0)
 ;;=4^J31.0
 ;;^UTILITY(U,$J,358.3,1188,2)
 ;;=^24434
 ;;^UTILITY(U,$J,358.3,1189,0)
 ;;=M06.9^^12^132^3
 ;;^UTILITY(U,$J,358.3,1189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1189,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,1189,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,1189,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,1190,0)
 ;;=M54.10^^12^132^1
 ;;^UTILITY(U,$J,358.3,1190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1190,1,3,0)
 ;;=3^Radiculopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,1190,1,4,0)
 ;;=4^M54.10
 ;;^UTILITY(U,$J,358.3,1190,2)
 ;;=^5012295
 ;;^UTILITY(U,$J,358.3,1191,0)
 ;;=R21.^^12^132^2
 ;;^UTILITY(U,$J,358.3,1191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1191,1,3,0)
 ;;=3^Rash & Oth Nonspecific Skin Eruption
 ;;^UTILITY(U,$J,358.3,1191,1,4,0)
 ;;=4^R21.
 ;;^UTILITY(U,$J,358.3,1191,2)
 ;;=^5019283
 ;;^UTILITY(U,$J,358.3,1192,0)
 ;;=S23.9XXA^^12^133^18
 ;;^UTILITY(U,$J,358.3,1192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1192,1,3,0)
 ;;=3^Sprain Thorax,Unspec Part,Initial Encounter
 ;;^UTILITY(U,$J,358.3,1192,1,4,0)
 ;;=4^S23.9XXA
 ;;^UTILITY(U,$J,358.3,1192,2)
 ;;=^5023267
 ;;^UTILITY(U,$J,358.3,1193,0)
 ;;=I69.928^^12^133^13
 ;;^UTILITY(U,$J,358.3,1193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1193,1,3,0)
 ;;=3^Speech/Lang Deficits Following Unspec Cerebrovascular Disease
 ;;^UTILITY(U,$J,358.3,1193,1,4,0)
 ;;=4^I69.928
 ;;^UTILITY(U,$J,358.3,1193,2)
 ;;=^5007557
 ;;^UTILITY(U,$J,358.3,1194,0)
 ;;=S13.4XXA^^12^133^17
 ;;^UTILITY(U,$J,358.3,1194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1194,1,3,0)
 ;;=3^Sprain Ligaments Cervical Spine,Initial Encounter
 ;;^UTILITY(U,$J,358.3,1194,1,4,0)
 ;;=4^S13.4XXA
 ;;^UTILITY(U,$J,358.3,1194,2)
 ;;=^5022028
 ;;^UTILITY(U,$J,358.3,1195,0)
 ;;=M15.3^^12^133^5
 ;;^UTILITY(U,$J,358.3,1195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1195,1,3,0)
 ;;=3^Secondary Multiple Arthritis
 ;;^UTILITY(U,$J,358.3,1195,1,4,0)
 ;;=4^M15.3
 ;;^UTILITY(U,$J,358.3,1195,2)
 ;;=^5010765
 ;;^UTILITY(U,$J,358.3,1196,0)
 ;;=L08.9^^12^133^9
 ;;^UTILITY(U,$J,358.3,1196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1196,1,3,0)
 ;;=3^Skin Infection,Unspec
 ;;^UTILITY(U,$J,358.3,1196,1,4,0)
 ;;=4^L08.9
 ;;^UTILITY(U,$J,358.3,1196,2)
 ;;=^5009082
 ;;^UTILITY(U,$J,358.3,1197,0)
 ;;=L98.9^^12^133^10
 ;;^UTILITY(U,$J,358.3,1197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1197,1,3,0)
 ;;=3^Skin/Subcutaneous Tissue Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1197,1,4,0)
 ;;=4^L98.9
 ;;^UTILITY(U,$J,358.3,1197,2)
 ;;=^5009595
 ;;^UTILITY(U,$J,358.3,1198,0)
 ;;=M48.06^^12^133^14
 ;;^UTILITY(U,$J,358.3,1198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1198,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region
 ;;^UTILITY(U,$J,358.3,1198,1,4,0)
 ;;=4^M48.06
