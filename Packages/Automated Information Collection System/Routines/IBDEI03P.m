IBDEI03P ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1022,0)
 ;;=E10.42^^12^123^10
 ;;^UTILITY(U,$J,358.3,1022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1022,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,1022,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,1022,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,1023,0)
 ;;=E11.42^^12^123^13
 ;;^UTILITY(U,$J,358.3,1023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1023,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,1023,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,1023,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,1024,0)
 ;;=E13.42^^12^123^9
 ;;^UTILITY(U,$J,358.3,1024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1024,1,3,0)
 ;;=3^Diabetes Other w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,1024,1,4,0)
 ;;=4^E13.42
 ;;^UTILITY(U,$J,358.3,1024,2)
 ;;=^5002686
 ;;^UTILITY(U,$J,358.3,1025,0)
 ;;=E08.42^^12^123^16
 ;;^UTILITY(U,$J,358.3,1025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1025,1,3,0)
 ;;=3^Diabetes d/t Underlying Condition w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,1025,1,4,0)
 ;;=4^E08.42
 ;;^UTILITY(U,$J,358.3,1025,2)
 ;;=^5002524
 ;;^UTILITY(U,$J,358.3,1026,0)
 ;;=E09.42^^12^123^8
 ;;^UTILITY(U,$J,358.3,1026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1026,1,3,0)
 ;;=3^Diabetes Drug-Induced w/ Neurological Compl w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,1026,1,4,0)
 ;;=4^E09.42
 ;;^UTILITY(U,$J,358.3,1026,2)
 ;;=^5002566
 ;;^UTILITY(U,$J,358.3,1027,0)
 ;;=M54.9^^12^123^21
 ;;^UTILITY(U,$J,358.3,1027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1027,1,3,0)
 ;;=3^Dorsalgia,Unspec
 ;;^UTILITY(U,$J,358.3,1027,1,4,0)
 ;;=4^M54.9
 ;;^UTILITY(U,$J,358.3,1027,2)
 ;;=^5012314
 ;;^UTILITY(U,$J,358.3,1028,0)
 ;;=K26.9^^12^123^22
 ;;^UTILITY(U,$J,358.3,1028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1028,1,3,0)
 ;;=3^Duodenal Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,1028,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,1028,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,1029,0)
 ;;=N40.0^^12^124^4
 ;;^UTILITY(U,$J,358.3,1029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1029,1,3,0)
 ;;=3^Enlarged Prostate w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,1029,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,1029,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,1030,0)
 ;;=N40.1^^12^124^3
 ;;^UTILITY(U,$J,358.3,1030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1030,1,3,0)
 ;;=3^Enlarged Prostate w/ Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,1030,1,4,0)
 ;;=4^N40.1
 ;;^UTILITY(U,$J,358.3,1030,2)
 ;;=^5015690
 ;;^UTILITY(U,$J,358.3,1031,0)
 ;;=E87.70^^12^124^15
 ;;^UTILITY(U,$J,358.3,1031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1031,1,3,0)
 ;;=3^Fluid Overload,Unspec
 ;;^UTILITY(U,$J,358.3,1031,1,4,0)
 ;;=4^E87.70
 ;;^UTILITY(U,$J,358.3,1031,2)
 ;;=^5003023
 ;;^UTILITY(U,$J,358.3,1032,0)
 ;;=J43.9^^12^124^2
 ;;^UTILITY(U,$J,358.3,1032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1032,1,3,0)
 ;;=3^Emphysema,Unspec
 ;;^UTILITY(U,$J,358.3,1032,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,1032,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,1033,0)
 ;;=K20.9^^12^124^9
 ;;^UTILITY(U,$J,358.3,1033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1033,1,3,0)
 ;;=3^Esophagitis,Unspec
 ;;^UTILITY(U,$J,358.3,1033,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,1033,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,1034,0)
 ;;=K22.10^^12^124^11
 ;;^UTILITY(U,$J,358.3,1034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1034,1,3,0)
 ;;=3^Esophagus Ulcer w/o Bleeding
 ;;^UTILITY(U,$J,358.3,1034,1,4,0)
 ;;=4^K22.10
 ;;^UTILITY(U,$J,358.3,1034,2)
 ;;=^329929
