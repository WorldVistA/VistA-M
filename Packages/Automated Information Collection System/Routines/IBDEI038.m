IBDEI038 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1062,0)
 ;;=S23.9XXA^^6^111^18
 ;;^UTILITY(U,$J,358.3,1062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1062,1,3,0)
 ;;=3^Sprain Thorax,Unspec Part,Initial Encounter
 ;;^UTILITY(U,$J,358.3,1062,1,4,0)
 ;;=4^S23.9XXA
 ;;^UTILITY(U,$J,358.3,1062,2)
 ;;=^5023267
 ;;^UTILITY(U,$J,358.3,1063,0)
 ;;=I69.928^^6^111^13
 ;;^UTILITY(U,$J,358.3,1063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1063,1,3,0)
 ;;=3^Speech/Lang Deficits Following Unspec Cerebrovascular Disease
 ;;^UTILITY(U,$J,358.3,1063,1,4,0)
 ;;=4^I69.928
 ;;^UTILITY(U,$J,358.3,1063,2)
 ;;=^5007557
 ;;^UTILITY(U,$J,358.3,1064,0)
 ;;=S13.4XXA^^6^111^17
 ;;^UTILITY(U,$J,358.3,1064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1064,1,3,0)
 ;;=3^Sprain Ligaments Cervical Spine,Initial Encounter
 ;;^UTILITY(U,$J,358.3,1064,1,4,0)
 ;;=4^S13.4XXA
 ;;^UTILITY(U,$J,358.3,1064,2)
 ;;=^5022028
 ;;^UTILITY(U,$J,358.3,1065,0)
 ;;=M15.3^^6^111^5
 ;;^UTILITY(U,$J,358.3,1065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1065,1,3,0)
 ;;=3^Secondary Multiple Arthritis
 ;;^UTILITY(U,$J,358.3,1065,1,4,0)
 ;;=4^M15.3
 ;;^UTILITY(U,$J,358.3,1065,2)
 ;;=^5010765
 ;;^UTILITY(U,$J,358.3,1066,0)
 ;;=L08.9^^6^111^9
 ;;^UTILITY(U,$J,358.3,1066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1066,1,3,0)
 ;;=3^Skin Infection,Unspec
 ;;^UTILITY(U,$J,358.3,1066,1,4,0)
 ;;=4^L08.9
 ;;^UTILITY(U,$J,358.3,1066,2)
 ;;=^5009082
 ;;^UTILITY(U,$J,358.3,1067,0)
 ;;=L98.9^^6^111^10
 ;;^UTILITY(U,$J,358.3,1067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1067,1,3,0)
 ;;=3^Skin/Subcutaneous Tissue Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1067,1,4,0)
 ;;=4^L98.9
 ;;^UTILITY(U,$J,358.3,1067,2)
 ;;=^5009595
 ;;^UTILITY(U,$J,358.3,1068,0)
 ;;=M48.06^^6^111^14
 ;;^UTILITY(U,$J,358.3,1068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1068,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region
 ;;^UTILITY(U,$J,358.3,1068,1,4,0)
 ;;=4^M48.06
 ;;^UTILITY(U,$J,358.3,1068,2)
 ;;=^5012093
 ;;^UTILITY(U,$J,358.3,1069,0)
 ;;=R22.2^^6^111^19
 ;;^UTILITY(U,$J,358.3,1069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1069,1,3,0)
 ;;=3^Swelling,Mass & Lump,Trunk
 ;;^UTILITY(U,$J,358.3,1069,1,4,0)
 ;;=4^R22.2
 ;;^UTILITY(U,$J,358.3,1069,2)
 ;;=^5019286
 ;;^UTILITY(U,$J,358.3,1070,0)
 ;;=M54.31^^6^111^3
 ;;^UTILITY(U,$J,358.3,1070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1070,1,3,0)
 ;;=3^Sciatica,Right Side
 ;;^UTILITY(U,$J,358.3,1070,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,1070,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,1071,0)
 ;;=M54.32^^6^111^2
 ;;^UTILITY(U,$J,358.3,1071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1071,1,3,0)
 ;;=3^Sciatica,Left Side
 ;;^UTILITY(U,$J,358.3,1071,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,1071,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,1072,0)
 ;;=F20.5^^6^111^1
 ;;^UTILITY(U,$J,358.3,1072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1072,1,3,0)
 ;;=3^Schizophrenia,Residual
 ;;^UTILITY(U,$J,358.3,1072,1,4,0)
 ;;=4^F20.5
 ;;^UTILITY(U,$J,358.3,1072,2)
 ;;=^5003473
 ;;^UTILITY(U,$J,358.3,1073,0)
 ;;=J01.90^^6^111^7
 ;;^UTILITY(U,$J,358.3,1073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1073,1,3,0)
 ;;=3^Sinusitis Acute,Unspec
 ;;^UTILITY(U,$J,358.3,1073,1,4,0)
 ;;=4^J01.90
 ;;^UTILITY(U,$J,358.3,1073,2)
 ;;=^5008127
 ;;^UTILITY(U,$J,358.3,1074,0)
 ;;=J32.9^^6^111^8
 ;;^UTILITY(U,$J,358.3,1074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1074,1,3,0)
 ;;=3^Sinusitis,Chronic Unspec
 ;;^UTILITY(U,$J,358.3,1074,1,4,0)
 ;;=4^J32.9
 ;;^UTILITY(U,$J,358.3,1074,2)
 ;;=^5008207
 ;;^UTILITY(U,$J,358.3,1075,0)
 ;;=L72.3^^6^111^4
 ;;^UTILITY(U,$J,358.3,1075,1,0)
 ;;=^358.31IA^4^2
