IBDEI0BE ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4849,1,3,0)
 ;;=3^Spinal Stenosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,4849,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,4849,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,4850,0)
 ;;=E87.5^^37^322^11
 ;;^UTILITY(U,$J,358.3,4850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4850,1,3,0)
 ;;=3^Hyperkalemia
 ;;^UTILITY(U,$J,358.3,4850,1,4,0)
 ;;=4^E87.5
 ;;^UTILITY(U,$J,358.3,4850,2)
 ;;=^60041
 ;;^UTILITY(U,$J,358.3,4851,0)
 ;;=E87.1^^37^322^12
 ;;^UTILITY(U,$J,358.3,4851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4851,1,3,0)
 ;;=3^Hypo-osmolality and Hyponatremia
 ;;^UTILITY(U,$J,358.3,4851,1,4,0)
 ;;=4^E87.1
 ;;^UTILITY(U,$J,358.3,4851,2)
 ;;=^5003019
 ;;^UTILITY(U,$J,358.3,4852,0)
 ;;=R42.^^37^322^7
 ;;^UTILITY(U,$J,358.3,4852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4852,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,4852,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,4852,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,4853,0)
 ;;=R41.82^^37^322^3
 ;;^UTILITY(U,$J,358.3,4853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4853,1,3,0)
 ;;=3^Altered Mental Status,Unspec
 ;;^UTILITY(U,$J,358.3,4853,1,4,0)
 ;;=4^R41.82
 ;;^UTILITY(U,$J,358.3,4853,2)
 ;;=^5019441
 ;;^UTILITY(U,$J,358.3,4854,0)
 ;;=T78.3XXA^^37^322^4
 ;;^UTILITY(U,$J,358.3,4854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4854,1,3,0)
 ;;=3^Angioneurotic Edema,Init Encntr
 ;;^UTILITY(U,$J,358.3,4854,1,4,0)
 ;;=4^T78.3XXA
 ;;^UTILITY(U,$J,358.3,4854,2)
 ;;=^5054281
 ;;^UTILITY(U,$J,358.3,4855,0)
 ;;=E11.69^^37^322^6
 ;;^UTILITY(U,$J,358.3,4855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4855,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oth Spec Complications
 ;;^UTILITY(U,$J,358.3,4855,1,4,0)
 ;;=4^E11.69
 ;;^UTILITY(U,$J,358.3,4855,2)
 ;;=^5002664
 ;;^UTILITY(U,$J,358.3,4856,0)
 ;;=R55.^^37^322^15
 ;;^UTILITY(U,$J,358.3,4856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4856,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,4856,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,4856,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,4857,0)
 ;;=E87.70^^37^322^9
 ;;^UTILITY(U,$J,358.3,4857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4857,1,3,0)
 ;;=3^Fluid Overload,Unspec
 ;;^UTILITY(U,$J,358.3,4857,1,4,0)
 ;;=4^E87.70
 ;;^UTILITY(U,$J,358.3,4857,2)
 ;;=^5003023
 ;;^UTILITY(U,$J,358.3,4858,0)
 ;;=E87.79^^37^322^8
 ;;^UTILITY(U,$J,358.3,4858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4858,1,3,0)
 ;;=3^Fluid Overload,Other
 ;;^UTILITY(U,$J,358.3,4858,1,4,0)
 ;;=4^E87.79
 ;;^UTILITY(U,$J,358.3,4858,2)
 ;;=^5003025
 ;;^UTILITY(U,$J,358.3,4859,0)
 ;;=R73.09^^37^322^1
 ;;^UTILITY(U,$J,358.3,4859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4859,1,3,0)
 ;;=3^Abnormal Glucose
 ;;^UTILITY(U,$J,358.3,4859,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,4859,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,4860,0)
 ;;=D62.^^37^322^2
 ;;^UTILITY(U,$J,358.3,4860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4860,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,4860,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,4860,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,4861,0)
 ;;=F06.8^^37^322^13
 ;;^UTILITY(U,$J,358.3,4861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4861,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition NEC
 ;;^UTILITY(U,$J,358.3,4861,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,4861,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,4862,0)
 ;;=F05.^^37^322^5
 ;;^UTILITY(U,$J,358.3,4862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4862,1,3,0)
 ;;=3^Delirium d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,4862,1,4,0)
 ;;=4^F05.
