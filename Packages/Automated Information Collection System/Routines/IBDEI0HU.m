IBDEI0HU ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7770,0)
 ;;=M17.0^^63^501^1
 ;;^UTILITY(U,$J,358.3,7770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7770,1,3,0)
 ;;=3^Osteoarthritis of Knee,Primary Bilateral
 ;;^UTILITY(U,$J,358.3,7770,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,7770,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,7771,0)
 ;;=M17.11^^63^501^3
 ;;^UTILITY(U,$J,358.3,7771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7771,1,3,0)
 ;;=3^Osteoarthritis of Knee,Primary Right
 ;;^UTILITY(U,$J,358.3,7771,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,7771,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,7772,0)
 ;;=M17.12^^63^501^2
 ;;^UTILITY(U,$J,358.3,7772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7772,1,3,0)
 ;;=3^Osteoarthritis of Knee,Primary Left
 ;;^UTILITY(U,$J,358.3,7772,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,7772,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,7773,0)
 ;;=M48.061^^63^501^6
 ;;^UTILITY(U,$J,358.3,7773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7773,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/o Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,7773,1,4,0)
 ;;=4^M48.061
 ;;^UTILITY(U,$J,358.3,7773,2)
 ;;=^5151513
 ;;^UTILITY(U,$J,358.3,7774,0)
 ;;=M48.062^^63^501^5
 ;;^UTILITY(U,$J,358.3,7774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7774,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/ Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,7774,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,7774,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,7775,0)
 ;;=E87.5^^63^502^11
 ;;^UTILITY(U,$J,358.3,7775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7775,1,3,0)
 ;;=3^Hyperkalemia
 ;;^UTILITY(U,$J,358.3,7775,1,4,0)
 ;;=4^E87.5
 ;;^UTILITY(U,$J,358.3,7775,2)
 ;;=^60041
 ;;^UTILITY(U,$J,358.3,7776,0)
 ;;=E87.1^^63^502^12
 ;;^UTILITY(U,$J,358.3,7776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7776,1,3,0)
 ;;=3^Hypo-osmolality and Hyponatremia
 ;;^UTILITY(U,$J,358.3,7776,1,4,0)
 ;;=4^E87.1
 ;;^UTILITY(U,$J,358.3,7776,2)
 ;;=^5003019
 ;;^UTILITY(U,$J,358.3,7777,0)
 ;;=R42.^^63^502^7
 ;;^UTILITY(U,$J,358.3,7777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7777,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,7777,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,7777,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,7778,0)
 ;;=R41.82^^63^502^3
 ;;^UTILITY(U,$J,358.3,7778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7778,1,3,0)
 ;;=3^Altered Mental Status,Unspec
 ;;^UTILITY(U,$J,358.3,7778,1,4,0)
 ;;=4^R41.82
 ;;^UTILITY(U,$J,358.3,7778,2)
 ;;=^5019441
 ;;^UTILITY(U,$J,358.3,7779,0)
 ;;=T78.3XXA^^63^502^4
 ;;^UTILITY(U,$J,358.3,7779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7779,1,3,0)
 ;;=3^Angioneurotic Edema,Init Encntr
 ;;^UTILITY(U,$J,358.3,7779,1,4,0)
 ;;=4^T78.3XXA
 ;;^UTILITY(U,$J,358.3,7779,2)
 ;;=^5054281
 ;;^UTILITY(U,$J,358.3,7780,0)
 ;;=E11.69^^63^502^6
 ;;^UTILITY(U,$J,358.3,7780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7780,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oth Spec Complications
 ;;^UTILITY(U,$J,358.3,7780,1,4,0)
 ;;=4^E11.69
 ;;^UTILITY(U,$J,358.3,7780,2)
 ;;=^5002664
 ;;^UTILITY(U,$J,358.3,7781,0)
 ;;=R55.^^63^502^15
 ;;^UTILITY(U,$J,358.3,7781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7781,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,7781,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,7781,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,7782,0)
 ;;=E87.70^^63^502^9
 ;;^UTILITY(U,$J,358.3,7782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7782,1,3,0)
 ;;=3^Fluid Overload,Unspec
