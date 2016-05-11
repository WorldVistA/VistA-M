IBDEI1ZX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33867,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,33867,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,33867,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,33868,0)
 ;;=D56.2^^131^1680^54
 ;;^UTILITY(U,$J,358.3,33868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33868,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,33868,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,33868,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,33869,0)
 ;;=D75.9^^131^1680^55
 ;;^UTILITY(U,$J,358.3,33869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33869,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,33869,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,33869,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,33870,0)
 ;;=D59.0^^131^1680^58
 ;;^UTILITY(U,$J,358.3,33870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33870,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,33870,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,33870,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,33871,0)
 ;;=D59.2^^131^1680^59
 ;;^UTILITY(U,$J,358.3,33871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33871,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,33871,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,33871,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,33872,0)
 ;;=R59.9^^131^1680^62
 ;;^UTILITY(U,$J,358.3,33872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33872,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,33872,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,33872,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,33873,0)
 ;;=D47.3^^131^1680^63
 ;;^UTILITY(U,$J,358.3,33873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33873,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,33873,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,33873,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,33874,0)
 ;;=C82.09^^131^1680^64
 ;;^UTILITY(U,$J,358.3,33874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33874,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,33874,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,33874,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,33875,0)
 ;;=C82.00^^131^1680^65
 ;;^UTILITY(U,$J,358.3,33875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33875,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,33875,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,33875,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,33876,0)
 ;;=C82.19^^131^1680^66
 ;;^UTILITY(U,$J,358.3,33876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33876,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,33876,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,33876,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,33877,0)
 ;;=C82.10^^131^1680^67
 ;;^UTILITY(U,$J,358.3,33877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33877,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,33877,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,33877,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,33878,0)
 ;;=C82.29^^131^1680^68
 ;;^UTILITY(U,$J,358.3,33878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33878,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,33878,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,33878,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,33879,0)
 ;;=C82.20^^131^1680^69
 ;;^UTILITY(U,$J,358.3,33879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33879,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,33879,1,4,0)
 ;;=4^C82.20
