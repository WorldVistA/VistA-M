IBDEI0G4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7452,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,7452,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,7453,0)
 ;;=R93.3^^30^408^7
 ;;^UTILITY(U,$J,358.3,7453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7453,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,7453,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,7453,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,7454,0)
 ;;=R93.4^^30^408^11
 ;;^UTILITY(U,$J,358.3,7454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7454,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Urinary Organs
 ;;^UTILITY(U,$J,358.3,7454,1,4,0)
 ;;=4^R93.4
 ;;^UTILITY(U,$J,358.3,7454,2)
 ;;=^5019717
 ;;^UTILITY(U,$J,358.3,7455,0)
 ;;=R93.5^^30^408^6
 ;;^UTILITY(U,$J,358.3,7455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7455,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,7455,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,7455,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,7456,0)
 ;;=R93.6^^30^408^8
 ;;^UTILITY(U,$J,358.3,7456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7456,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,7456,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,7456,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,7457,0)
 ;;=R94.4^^30^408^16
 ;;^UTILITY(U,$J,358.3,7457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7457,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
 ;;^UTILITY(U,$J,358.3,7457,1,4,0)
 ;;=4^R94.4
 ;;^UTILITY(U,$J,358.3,7457,2)
 ;;=^5019741
 ;;^UTILITY(U,$J,358.3,7458,0)
 ;;=R94.5^^30^408^17
 ;;^UTILITY(U,$J,358.3,7458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7458,1,3,0)
 ;;=3^Abnormal Liver Function Studies
 ;;^UTILITY(U,$J,358.3,7458,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,7458,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,7459,0)
 ;;=R94.6^^30^408^21
 ;;^UTILITY(U,$J,358.3,7459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7459,1,3,0)
 ;;=3^Abnormal Thyroid Function Studies
 ;;^UTILITY(U,$J,358.3,7459,1,4,0)
 ;;=4^R94.6
 ;;^UTILITY(U,$J,358.3,7459,2)
 ;;=^5019743
 ;;^UTILITY(U,$J,358.3,7460,0)
 ;;=R94.7^^30^408^5
 ;;^UTILITY(U,$J,358.3,7460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7460,1,3,0)
 ;;=3^Abnormal Endocrine Function Sutdies NEC
 ;;^UTILITY(U,$J,358.3,7460,1,4,0)
 ;;=4^R94.7
 ;;^UTILITY(U,$J,358.3,7460,2)
 ;;=^5019744
 ;;^UTILITY(U,$J,358.3,7461,0)
 ;;=R94.31^^30^408^4
 ;;^UTILITY(U,$J,358.3,7461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7461,1,3,0)
 ;;=3^Abnormal EKG
 ;;^UTILITY(U,$J,358.3,7461,1,4,0)
 ;;=4^R94.31
 ;;^UTILITY(U,$J,358.3,7461,2)
 ;;=^5019739
 ;;^UTILITY(U,$J,358.3,7462,0)
 ;;=R97.0^^30^408^71
 ;;^UTILITY(U,$J,358.3,7462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7462,1,3,0)
 ;;=3^Elevated Carcinoembryonic Antigen 
 ;;^UTILITY(U,$J,358.3,7462,1,4,0)
 ;;=4^R97.0
 ;;^UTILITY(U,$J,358.3,7462,2)
 ;;=^5019746
 ;;^UTILITY(U,$J,358.3,7463,0)
 ;;=R97.1^^30^408^70
 ;;^UTILITY(U,$J,358.3,7463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7463,1,3,0)
 ;;=3^Elevated Cancer Antigen 125
 ;;^UTILITY(U,$J,358.3,7463,1,4,0)
 ;;=4^R97.1
 ;;^UTILITY(U,$J,358.3,7463,2)
 ;;=^5019747
 ;;^UTILITY(U,$J,358.3,7464,0)
 ;;=R97.2^^30^408^72
 ;;^UTILITY(U,$J,358.3,7464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7464,1,3,0)
 ;;=3^Elevated PSA
 ;;^UTILITY(U,$J,358.3,7464,1,4,0)
 ;;=4^R97.2
 ;;^UTILITY(U,$J,358.3,7464,2)
 ;;=^5019748
 ;;^UTILITY(U,$J,358.3,7465,0)
 ;;=R97.8^^30^408^22
 ;;^UTILITY(U,$J,358.3,7465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7465,1,3,0)
 ;;=3^Abnormal Tumor Markers NEC
 ;;^UTILITY(U,$J,358.3,7465,1,4,0)
 ;;=4^R97.8
 ;;^UTILITY(U,$J,358.3,7465,2)
 ;;=^5019749
