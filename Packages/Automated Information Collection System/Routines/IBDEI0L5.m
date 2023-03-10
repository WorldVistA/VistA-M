IBDEI0L5 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9520,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,9520,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,9520,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,9521,0)
 ;;=R93.2^^39^413^9
 ;;^UTILITY(U,$J,358.3,9521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9521,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,9521,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,9521,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,9522,0)
 ;;=R93.3^^39^413^7
 ;;^UTILITY(U,$J,358.3,9522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9522,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,9522,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,9522,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,9523,0)
 ;;=R93.5^^39^413^6
 ;;^UTILITY(U,$J,358.3,9523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9523,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,9523,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,9523,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,9524,0)
 ;;=R93.6^^39^413^8
 ;;^UTILITY(U,$J,358.3,9524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9524,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,9524,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,9524,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,9525,0)
 ;;=R94.4^^39^413^19
 ;;^UTILITY(U,$J,358.3,9525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9525,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
 ;;^UTILITY(U,$J,358.3,9525,1,4,0)
 ;;=4^R94.4
 ;;^UTILITY(U,$J,358.3,9525,2)
 ;;=^5019741
 ;;^UTILITY(U,$J,358.3,9526,0)
 ;;=R94.5^^39^413^20
 ;;^UTILITY(U,$J,358.3,9526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9526,1,3,0)
 ;;=3^Abnormal Liver Function Studies
 ;;^UTILITY(U,$J,358.3,9526,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,9526,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,9527,0)
 ;;=R94.6^^39^413^24
 ;;^UTILITY(U,$J,358.3,9527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9527,1,3,0)
 ;;=3^Abnormal Thyroid Function Studies
 ;;^UTILITY(U,$J,358.3,9527,1,4,0)
 ;;=4^R94.6
 ;;^UTILITY(U,$J,358.3,9527,2)
 ;;=^5019743
 ;;^UTILITY(U,$J,358.3,9528,0)
 ;;=R94.7^^39^413^5
 ;;^UTILITY(U,$J,358.3,9528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9528,1,3,0)
 ;;=3^Abnormal Endocrine Function Studies NEC
 ;;^UTILITY(U,$J,358.3,9528,1,4,0)
 ;;=4^R94.7
 ;;^UTILITY(U,$J,358.3,9528,2)
 ;;=^5019744
 ;;^UTILITY(U,$J,358.3,9529,0)
 ;;=R94.31^^39^413^4
 ;;^UTILITY(U,$J,358.3,9529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9529,1,3,0)
 ;;=3^Abnormal EKG
 ;;^UTILITY(U,$J,358.3,9529,1,4,0)
 ;;=4^R94.31
 ;;^UTILITY(U,$J,358.3,9529,2)
 ;;=^5019739
 ;;^UTILITY(U,$J,358.3,9530,0)
 ;;=R97.0^^39^413^71
 ;;^UTILITY(U,$J,358.3,9530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9530,1,3,0)
 ;;=3^Elevated Carcinoembryonic Antigen 
 ;;^UTILITY(U,$J,358.3,9530,1,4,0)
 ;;=4^R97.0
 ;;^UTILITY(U,$J,358.3,9530,2)
 ;;=^5019746
 ;;^UTILITY(U,$J,358.3,9531,0)
 ;;=R97.1^^39^413^70
 ;;^UTILITY(U,$J,358.3,9531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9531,1,3,0)
 ;;=3^Elevated Cancer Antigen 125
 ;;^UTILITY(U,$J,358.3,9531,1,4,0)
 ;;=4^R97.1
 ;;^UTILITY(U,$J,358.3,9531,2)
 ;;=^5019747
 ;;^UTILITY(U,$J,358.3,9532,0)
 ;;=R97.8^^39^413^25
 ;;^UTILITY(U,$J,358.3,9532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9532,1,3,0)
 ;;=3^Abnormal Tumor Markers NEC
 ;;^UTILITY(U,$J,358.3,9532,1,4,0)
 ;;=4^R97.8
