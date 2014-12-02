IBDEI01M ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,278,0)
 ;;=V62.22^^2^19^14
 ;;^UTILITY(U,$J,358.3,278,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,278,1,2,0)
 ;;=2^V62.22
 ;;^UTILITY(U,$J,358.3,278,1,5,0)
 ;;=5^HX Retrn Military Deploy
 ;;^UTILITY(U,$J,358.3,278,2)
 ;;=^336807
 ;;^UTILITY(U,$J,358.3,279,0)
 ;;=V62.29^^2^19^26
 ;;^UTILITY(U,$J,358.3,279,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,279,1,2,0)
 ;;=2^V62.29
 ;;^UTILITY(U,$J,358.3,279,1,5,0)
 ;;=5^Occupationl Circumst NEC
 ;;^UTILITY(U,$J,358.3,279,2)
 ;;=^87746
 ;;^UTILITY(U,$J,358.3,280,0)
 ;;=V60.81^^2^19^12
 ;;^UTILITY(U,$J,358.3,280,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,280,1,2,0)
 ;;=2^V60.81
 ;;^UTILITY(U,$J,358.3,280,1,5,0)
 ;;=5^Foster Care (Status)
 ;;^UTILITY(U,$J,358.3,280,2)
 ;;=^338505
 ;;^UTILITY(U,$J,358.3,281,0)
 ;;=V60.89^^2^19^17
 ;;^UTILITY(U,$J,358.3,281,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,281,1,2,0)
 ;;=2^V60.89
 ;;^UTILITY(U,$J,358.3,281,1,5,0)
 ;;=5^Housing/Econom Circum NEC
 ;;^UTILITY(U,$J,358.3,281,2)
 ;;=^295545
 ;;^UTILITY(U,$J,358.3,282,0)
 ;;=V61.22^^2^19^34
 ;;^UTILITY(U,$J,358.3,282,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,282,1,2,0)
 ;;=2^V61.22
 ;;^UTILITY(U,$J,358.3,282,1,5,0)
 ;;=5^Perpetrator-Parental Child
 ;;^UTILITY(U,$J,358.3,282,2)
 ;;=^304358
 ;;^UTILITY(U,$J,358.3,283,0)
 ;;=V61.23^^2^19^30
 ;;^UTILITY(U,$J,358.3,283,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,283,1,2,0)
 ;;=2^V61.23
 ;;^UTILITY(U,$J,358.3,283,1,5,0)
 ;;=5^Parent-Biological Child Prob
 ;;^UTILITY(U,$J,358.3,283,2)
 ;;=^338508
 ;;^UTILITY(U,$J,358.3,284,0)
 ;;=V61.24^^2^19^29
 ;;^UTILITY(U,$J,358.3,284,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,284,1,2,0)
 ;;=2^V61.24
 ;;^UTILITY(U,$J,358.3,284,1,5,0)
 ;;=5^Parent-Adopted Child Prob
 ;;^UTILITY(U,$J,358.3,284,2)
 ;;=^338509
 ;;^UTILITY(U,$J,358.3,285,0)
 ;;=V61.25^^2^19^32
 ;;^UTILITY(U,$J,358.3,285,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,285,1,2,0)
 ;;=2^V61.25
 ;;^UTILITY(U,$J,358.3,285,1,5,0)
 ;;=5^Parent-Foster Child Prob
 ;;^UTILITY(U,$J,358.3,285,2)
 ;;=^338510
 ;;^UTILITY(U,$J,358.3,286,0)
 ;;=V40.31^^2^19^41
 ;;^UTILITY(U,$J,358.3,286,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,286,1,2,0)
 ;;=2^V40.31
 ;;^UTILITY(U,$J,358.3,286,1,5,0)
 ;;=5^Wandering-Dis Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,286,2)
 ;;=^340621
 ;;^UTILITY(U,$J,358.3,287,0)
 ;;=V40.39^^2^19^27
 ;;^UTILITY(U,$J,358.3,287,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,287,1,2,0)
 ;;=2^V40.39
 ;;^UTILITY(U,$J,358.3,287,1,5,0)
 ;;=5^Oth Specified Behavioral Problem
 ;;^UTILITY(U,$J,358.3,287,2)
 ;;=^340622
 ;;^UTILITY(U,$J,358.3,288,0)
 ;;=V65.19^^2^19^35
 ;;^UTILITY(U,$J,358.3,288,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,288,1,2,0)
 ;;=2^V65.19
 ;;^UTILITY(U,$J,358.3,288,1,5,0)
 ;;=5^Person Consulting on Behalf of Pt
 ;;^UTILITY(U,$J,358.3,288,2)
 ;;=^329985
 ;;^UTILITY(U,$J,358.3,289,0)
 ;;=V66.7^^2^19^5
 ;;^UTILITY(U,$J,358.3,289,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,289,1,2,0)
 ;;=2^V66.7
 ;;^UTILITY(U,$J,358.3,289,1,5,0)
 ;;=5^Encounter for Palliative Care
 ;;^UTILITY(U,$J,358.3,289,2)
 ;;=^89209
 ;;^UTILITY(U,$J,358.3,290,0)
 ;;=V11.4^^2^19^18
 ;;^UTILITY(U,$J,358.3,290,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,290,1,2,0)
 ;;=2^V11.4
 ;;^UTILITY(U,$J,358.3,290,1,5,0)
 ;;=5^Hx Combat/Operational Stress
 ;;^UTILITY(U,$J,358.3,290,2)
 ;;=^339674
 ;;^UTILITY(U,$J,358.3,291,0)
 ;;=V60.1^^2^19^20
 ;;^UTILITY(U,$J,358.3,291,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,291,1,2,0)
 ;;=2^V60.1
 ;;^UTILITY(U,$J,358.3,291,1,5,0)
 ;;=5^Inadequate Housing
 ;;^UTILITY(U,$J,358.3,291,2)
 ;;=^295540
