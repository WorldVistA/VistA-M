IBDEI0XW ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15097,0)
 ;;=Z93.4^^85^840^13
 ;;^UTILITY(U,$J,358.3,15097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15097,1,3,0)
 ;;=3^Jejunostomy status
 ;;^UTILITY(U,$J,358.3,15097,1,4,0)
 ;;=4^Z93.4
 ;;^UTILITY(U,$J,358.3,15097,2)
 ;;=^5063646
 ;;^UTILITY(U,$J,358.3,15098,0)
 ;;=K94.29^^85^840^7
 ;;^UTILITY(U,$J,358.3,15098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15098,1,3,0)
 ;;=3^Gastrostomy Complications,Other
 ;;^UTILITY(U,$J,358.3,15098,1,4,0)
 ;;=4^K94.29
 ;;^UTILITY(U,$J,358.3,15098,2)
 ;;=^5008932
 ;;^UTILITY(U,$J,358.3,15099,0)
 ;;=K91.858^^85^840^12
 ;;^UTILITY(U,$J,358.3,15099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15099,1,3,0)
 ;;=3^Intestinal Pouch Complications,Other
 ;;^UTILITY(U,$J,358.3,15099,1,4,0)
 ;;=4^K91.858
 ;;^UTILITY(U,$J,358.3,15099,2)
 ;;=^338262
 ;;^UTILITY(U,$J,358.3,15100,0)
 ;;=K91.2^^85^840^15
 ;;^UTILITY(U,$J,358.3,15100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15100,1,3,0)
 ;;=3^Postsurgical malabsorption incl. Short bowel syndrome
 ;;^UTILITY(U,$J,358.3,15100,1,4,0)
 ;;=4^K91.2
 ;;^UTILITY(U,$J,358.3,15100,2)
 ;;=^5008901
 ;;^UTILITY(U,$J,358.3,15101,0)
 ;;=K91.850^^85^840^16
 ;;^UTILITY(U,$J,358.3,15101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15101,1,3,0)
 ;;=3^Pouchitis
 ;;^UTILITY(U,$J,358.3,15101,1,4,0)
 ;;=4^K91.850
 ;;^UTILITY(U,$J,358.3,15101,2)
 ;;=^338261
 ;;^UTILITY(U,$J,358.3,15102,0)
 ;;=K91.89^^85^840^17
 ;;^UTILITY(U,$J,358.3,15102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15102,1,3,0)
 ;;=3^Stricture,Postprocedural incl. radiation
 ;;^UTILITY(U,$J,358.3,15102,1,4,0)
 ;;=4^K91.89
 ;;^UTILITY(U,$J,358.3,15102,2)
 ;;=^5008912
 ;;^UTILITY(U,$J,358.3,15103,0)
 ;;=K28.0^^85^840^19
 ;;^UTILITY(U,$J,358.3,15103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15103,1,3,0)
 ;;=3^Ulcer,Gastrojejunal,Acute w/ Bleeding
 ;;^UTILITY(U,$J,358.3,15103,1,4,0)
 ;;=4^K28.0
 ;;^UTILITY(U,$J,358.3,15103,2)
 ;;=^270141
 ;;^UTILITY(U,$J,358.3,15104,0)
 ;;=K28.1^^85^840^20
 ;;^UTILITY(U,$J,358.3,15104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15104,1,3,0)
 ;;=3^Ulcer,Gastrojejunal,Acute w/ Perforation
 ;;^UTILITY(U,$J,358.3,15104,1,4,0)
 ;;=4^K28.1
 ;;^UTILITY(U,$J,358.3,15104,2)
 ;;=^270144
 ;;^UTILITY(U,$J,358.3,15105,0)
 ;;=K28.2^^85^840^18
 ;;^UTILITY(U,$J,358.3,15105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15105,1,3,0)
 ;;=3^Ulcer,Gastrojejunal,Acute w/ Bleed & Perf
 ;;^UTILITY(U,$J,358.3,15105,1,4,0)
 ;;=4^K28.2
 ;;^UTILITY(U,$J,358.3,15105,2)
 ;;=^5008537
 ;;^UTILITY(U,$J,358.3,15106,0)
 ;;=K28.3^^85^840^21
 ;;^UTILITY(U,$J,358.3,15106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15106,1,3,0)
 ;;=3^Ulcer,Gastrojejunal,Acute w/o Bleed or Perf
 ;;^UTILITY(U,$J,358.3,15106,1,4,0)
 ;;=4^K28.3
 ;;^UTILITY(U,$J,358.3,15106,2)
 ;;=^5008538
 ;;^UTILITY(U,$J,358.3,15107,0)
 ;;=K28.4^^85^840^23
 ;;^UTILITY(U,$J,358.3,15107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15107,1,3,0)
 ;;=3^Ulcer,Gastrojejunal,Chronic w/ Bleeding
 ;;^UTILITY(U,$J,358.3,15107,1,4,0)
 ;;=4^K28.4
 ;;^UTILITY(U,$J,358.3,15107,2)
 ;;=^270153
 ;;^UTILITY(U,$J,358.3,15108,0)
 ;;=K28.5^^85^840^24
 ;;^UTILITY(U,$J,358.3,15108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15108,1,3,0)
 ;;=3^Ulcer,Gastrojejunal,Chronic w/ Perforation
 ;;^UTILITY(U,$J,358.3,15108,1,4,0)
 ;;=4^K28.5
 ;;^UTILITY(U,$J,358.3,15108,2)
 ;;=^270156
 ;;^UTILITY(U,$J,358.3,15109,0)
 ;;=K28.6^^85^840^22
