IBDEI0XM ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14972,1,3,0)
 ;;=3^Benign neoplasm,Duodenum
 ;;^UTILITY(U,$J,358.3,14972,1,4,0)
 ;;=4^D13.2
 ;;^UTILITY(U,$J,358.3,14972,2)
 ;;=^5001973
 ;;^UTILITY(U,$J,358.3,14973,0)
 ;;=D13.39^^85^838^6
 ;;^UTILITY(U,$J,358.3,14973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14973,1,3,0)
 ;;=3^Benign neoplasm,Other Sm Int
 ;;^UTILITY(U,$J,358.3,14973,1,4,0)
 ;;=4^D13.39
 ;;^UTILITY(U,$J,358.3,14973,2)
 ;;=^5001975
 ;;^UTILITY(U,$J,358.3,14974,0)
 ;;=D13.30^^85^838^7
 ;;^UTILITY(U,$J,358.3,14974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14974,1,3,0)
 ;;=3^Benign neoplasm,Unsp Sm Int
 ;;^UTILITY(U,$J,358.3,14974,1,4,0)
 ;;=4^D13.30
 ;;^UTILITY(U,$J,358.3,14974,2)
 ;;=^5001974
 ;;^UTILITY(U,$J,358.3,14975,0)
 ;;=K90.89^^85^838^8
 ;;^UTILITY(U,$J,358.3,14975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14975,1,3,0)
 ;;=3^Bile acid malabsorption
 ;;^UTILITY(U,$J,358.3,14975,1,4,0)
 ;;=4^K90.89
 ;;^UTILITY(U,$J,358.3,14975,2)
 ;;=^5008898
 ;;^UTILITY(U,$J,358.3,14976,0)
 ;;=D01.49^^85^838^9
 ;;^UTILITY(U,$J,358.3,14976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14976,1,3,0)
 ;;=3^Carcinoma in situ of Small Intestine
 ;;^UTILITY(U,$J,358.3,14976,1,4,0)
 ;;=4^D01.49
 ;;^UTILITY(U,$J,358.3,14976,2)
 ;;=^5001879
 ;;^UTILITY(U,$J,358.3,14977,0)
 ;;=K63.81^^85^838^11
 ;;^UTILITY(U,$J,358.3,14977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14977,1,3,0)
 ;;=3^Dieulafoy lesion of Duodenum
 ;;^UTILITY(U,$J,358.3,14977,1,4,0)
 ;;=4^K63.81
 ;;^UTILITY(U,$J,358.3,14977,2)
 ;;=^5008766
 ;;^UTILITY(U,$J,358.3,14978,0)
 ;;=K63.89^^85^838^12
 ;;^UTILITY(U,$J,358.3,14978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14978,1,3,0)
 ;;=3^Dieulafoy lesion of Intestine
 ;;^UTILITY(U,$J,358.3,14978,1,4,0)
 ;;=4^K63.89
 ;;^UTILITY(U,$J,358.3,14978,2)
 ;;=^5008767
 ;;^UTILITY(U,$J,358.3,14979,0)
 ;;=K57.11^^85^838^19
 ;;^UTILITY(U,$J,358.3,14979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14979,1,3,0)
 ;;=3^Diverticulosis Sm Int w/ Bleeding
 ;;^UTILITY(U,$J,358.3,14979,1,4,0)
 ;;=4^K57.11
 ;;^UTILITY(U,$J,358.3,14979,2)
 ;;=^5008718
 ;;^UTILITY(U,$J,358.3,14980,0)
 ;;=K57.10^^85^838^20
 ;;^UTILITY(U,$J,358.3,14980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14980,1,3,0)
 ;;=3^Diverticulosis Sm Int w/o perf,abscess,or bleed
 ;;^UTILITY(U,$J,358.3,14980,1,4,0)
 ;;=4^K57.10
 ;;^UTILITY(U,$J,358.3,14980,2)
 ;;=^5008717
 ;;^UTILITY(U,$J,358.3,14981,0)
 ;;=K57.13^^85^838^15
 ;;^UTILITY(U,$J,358.3,14981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14981,1,3,0)
 ;;=3^Diverticulitis Sm Int w/ Bleeding
 ;;^UTILITY(U,$J,358.3,14981,1,4,0)
 ;;=4^K57.13
 ;;^UTILITY(U,$J,358.3,14981,2)
 ;;=^5008720
 ;;^UTILITY(U,$J,358.3,14982,0)
 ;;=K57.00^^85^838^16
 ;;^UTILITY(U,$J,358.3,14982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14982,1,3,0)
 ;;=3^Diverticulitis Sm Int w/ Perf & Abscess
 ;;^UTILITY(U,$J,358.3,14982,1,4,0)
 ;;=4^K57.00
 ;;^UTILITY(U,$J,358.3,14982,2)
 ;;=^5008715
 ;;^UTILITY(U,$J,358.3,14983,0)
 ;;=K57.01^^85^838^17
 ;;^UTILITY(U,$J,358.3,14983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14983,1,3,0)
 ;;=3^Diverticulitis Sm Int w/ Perf,Abscess & Bleed
 ;;^UTILITY(U,$J,358.3,14983,1,4,0)
 ;;=4^K57.01
 ;;^UTILITY(U,$J,358.3,14983,2)
 ;;=^5008716
 ;;^UTILITY(U,$J,358.3,14984,0)
 ;;=K57.12^^85^838^18
 ;;^UTILITY(U,$J,358.3,14984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14984,1,3,0)
 ;;=3^Diverticulitis Sm Int w/o Perf,Abscess, or Bleed
