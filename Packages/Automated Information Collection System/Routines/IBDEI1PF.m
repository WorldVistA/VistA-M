IBDEI1PF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28523,1,3,0)
 ;;=3^Elevated Urine Levels of Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,28523,1,4,0)
 ;;=4^R82.5
 ;;^UTILITY(U,$J,358.3,28523,2)
 ;;=^5019605
 ;;^UTILITY(U,$J,358.3,28524,0)
 ;;=R82.6^^132^1332^26
 ;;^UTILITY(U,$J,358.3,28524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28524,1,3,0)
 ;;=3^Abnormal Urine Levels of Subst of Nonmed Source
 ;;^UTILITY(U,$J,358.3,28524,1,4,0)
 ;;=4^R82.6
 ;;^UTILITY(U,$J,358.3,28524,2)
 ;;=^5019606
 ;;^UTILITY(U,$J,358.3,28525,0)
 ;;=R82.7^^132^1332^27
 ;;^UTILITY(U,$J,358.3,28525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28525,1,3,0)
 ;;=3^Abnormal Urine Microbiological Findings
 ;;^UTILITY(U,$J,358.3,28525,1,4,0)
 ;;=4^R82.7
 ;;^UTILITY(U,$J,358.3,28525,2)
 ;;=^5019607
 ;;^UTILITY(U,$J,358.3,28526,0)
 ;;=R82.8^^132^1332^23
 ;;^UTILITY(U,$J,358.3,28526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28526,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings
 ;;^UTILITY(U,$J,358.3,28526,1,4,0)
 ;;=4^R82.8
 ;;^UTILITY(U,$J,358.3,28526,2)
 ;;=^5019608
 ;;^UTILITY(U,$J,358.3,28527,0)
 ;;=R82.90^^132^1332^25
 ;;^UTILITY(U,$J,358.3,28527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28527,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,28527,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,28527,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,28528,0)
 ;;=R82.91^^132^1332^49
 ;;^UTILITY(U,$J,358.3,28528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28528,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,28528,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,28528,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,28529,0)
 ;;=R82.99^^132^1332^24
 ;;^UTILITY(U,$J,358.3,28529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28529,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,28529,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,28529,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,28530,0)
 ;;=R89.9^^132^1332^19
 ;;^UTILITY(U,$J,358.3,28530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28530,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,28530,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,28530,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,28531,0)
 ;;=R90.0^^132^1332^98
 ;;^UTILITY(U,$J,358.3,28531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28531,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,28531,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,28531,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,28532,0)
 ;;=R90.89^^132^1332^13
 ;;^UTILITY(U,$J,358.3,28532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28532,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,28532,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,28532,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,28533,0)
 ;;=R91.8^^132^1332^18
 ;;^UTILITY(U,$J,358.3,28533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28533,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,28533,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,28533,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,28534,0)
 ;;=R92.0^^132^1332^117
 ;;^UTILITY(U,$J,358.3,28534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28534,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,28534,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,28534,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,28535,0)
 ;;=R92.1^^132^1332^116
 ;;^UTILITY(U,$J,358.3,28535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28535,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,28535,1,4,0)
 ;;=4^R92.1
