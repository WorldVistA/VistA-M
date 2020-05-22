IBDEI2U4 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45217,1,3,0)
 ;;=3^Lupus,Erythematosus,Systemic
 ;;^UTILITY(U,$J,358.3,45217,1,4,0)
 ;;=4^M32.10
 ;;^UTILITY(U,$J,358.3,45217,2)
 ;;=^5011753
 ;;^UTILITY(U,$J,358.3,45218,0)
 ;;=M32.19^^170^2254^24
 ;;^UTILITY(U,$J,358.3,45218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45218,1,3,0)
 ;;=3^Lupus,Erythematosus,Systemic,Skin Involvmnt
 ;;^UTILITY(U,$J,358.3,45218,1,4,0)
 ;;=4^M32.19
 ;;^UTILITY(U,$J,358.3,45218,2)
 ;;=^5011759
 ;;^UTILITY(U,$J,358.3,45219,0)
 ;;=M32.9^^170^2254^23
 ;;^UTILITY(U,$J,358.3,45219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45219,1,3,0)
 ;;=3^Lupus,Erythematosus,Systemic w/o Organ Involvmnt
 ;;^UTILITY(U,$J,358.3,45219,1,4,0)
 ;;=4^M32.9
 ;;^UTILITY(U,$J,358.3,45219,2)
 ;;=^5011761
 ;;^UTILITY(U,$J,358.3,45220,0)
 ;;=E88.1^^170^2254^17
 ;;^UTILITY(U,$J,358.3,45220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45220,1,3,0)
 ;;=3^Lipodystrophy NOS
 ;;^UTILITY(U,$J,358.3,45220,1,4,0)
 ;;=4^E88.1
 ;;^UTILITY(U,$J,358.3,45220,2)
 ;;=^5003028
 ;;^UTILITY(U,$J,358.3,45221,0)
 ;;=C85.19^^170^2254^2
 ;;^UTILITY(U,$J,358.3,45221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45221,1,3,0)
 ;;=3^B-Cell Lymphoma,Unspec,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,45221,1,4,0)
 ;;=4^C85.19
 ;;^UTILITY(U,$J,358.3,45221,2)
 ;;=^5001710
 ;;^UTILITY(U,$J,358.3,45222,0)
 ;;=C85.13^^170^2254^5
 ;;^UTILITY(U,$J,358.3,45222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45222,1,3,0)
 ;;=3^B-Cell Lymphoma,Unspec,Intra-Abdominal Lymph Nodes
 ;;^UTILITY(U,$J,358.3,45222,1,4,0)
 ;;=4^C85.13
 ;;^UTILITY(U,$J,358.3,45222,2)
 ;;=^5001704
 ;;^UTILITY(U,$J,358.3,45223,0)
 ;;=C85.16^^170^2254^6
 ;;^UTILITY(U,$J,358.3,45223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45223,1,3,0)
 ;;=3^B-Cell Lymphoma,Unspec,Intrapelvic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,45223,1,4,0)
 ;;=4^C85.16
 ;;^UTILITY(U,$J,358.3,45223,2)
 ;;=^5001707
 ;;^UTILITY(U,$J,358.3,45224,0)
 ;;=C85.12^^170^2254^7
 ;;^UTILITY(U,$J,358.3,45224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45224,1,3,0)
 ;;=3^B-Cell Lymphoma,Unspec,Intrathoracic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,45224,1,4,0)
 ;;=4^C85.12
 ;;^UTILITY(U,$J,358.3,45224,2)
 ;;=^5001703
 ;;^UTILITY(U,$J,358.3,45225,0)
 ;;=C85.14^^170^2254^1
 ;;^UTILITY(U,$J,358.3,45225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45225,1,3,0)
 ;;=3^B-Cell Lymphoma,Unspec,Axilla/Upper Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,45225,1,4,0)
 ;;=4^C85.14
 ;;^UTILITY(U,$J,358.3,45225,2)
 ;;=^5001705
 ;;^UTILITY(U,$J,358.3,45226,0)
 ;;=C85.11^^170^2254^3
 ;;^UTILITY(U,$J,358.3,45226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45226,1,3,0)
 ;;=3^B-Cell Lymphoma,Unspec,Head/Face/Neck Lymph Nodes
 ;;^UTILITY(U,$J,358.3,45226,1,4,0)
 ;;=4^C85.11
 ;;^UTILITY(U,$J,358.3,45226,2)
 ;;=^5001702
 ;;^UTILITY(U,$J,358.3,45227,0)
 ;;=C85.15^^170^2254^4
 ;;^UTILITY(U,$J,358.3,45227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45227,1,3,0)
 ;;=3^B-Cell Lymphoma,Unspec,Inguinal Region/LE Lymph Nodes
 ;;^UTILITY(U,$J,358.3,45227,1,4,0)
 ;;=4^C85.15
 ;;^UTILITY(U,$J,358.3,45227,2)
 ;;=^5001706
 ;;^UTILITY(U,$J,358.3,45228,0)
 ;;=C85.18^^170^2254^8
 ;;^UTILITY(U,$J,358.3,45228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45228,1,3,0)
 ;;=3^B-Cell Lymphoma,Unspec,Multiple Site Lymph Nodes
 ;;^UTILITY(U,$J,358.3,45228,1,4,0)
 ;;=4^C85.18
 ;;^UTILITY(U,$J,358.3,45228,2)
 ;;=^5001709
