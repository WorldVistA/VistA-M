IBDEI1FF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23818,0)
 ;;=C50.911^^116^1163^12
 ;;^UTILITY(U,$J,358.3,23818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23818,1,3,0)
 ;;=3^Malig Neop of rt breast, female, unspec site
 ;;^UTILITY(U,$J,358.3,23818,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,23818,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,23819,0)
 ;;=C61.^^116^1163^11
 ;;^UTILITY(U,$J,358.3,23819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23819,1,3,0)
 ;;=3^Malig Neop of prostate
 ;;^UTILITY(U,$J,358.3,23819,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,23819,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,23820,0)
 ;;=C67.9^^116^1163^2
 ;;^UTILITY(U,$J,358.3,23820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23820,1,3,0)
 ;;=3^Malig Neop of bladder, unspec
 ;;^UTILITY(U,$J,358.3,23820,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,23820,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,23821,0)
 ;;=C64.2^^116^1163^10
 ;;^UTILITY(U,$J,358.3,23821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23821,1,3,0)
 ;;=3^Malig Neop of lft kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,23821,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,23821,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,23822,0)
 ;;=C64.1^^116^1163^14
 ;;^UTILITY(U,$J,358.3,23822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23822,1,3,0)
 ;;=3^Malig Neop of rt kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,23822,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,23822,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,23823,0)
 ;;=C79.51^^116^1163^4
 ;;^UTILITY(U,$J,358.3,23823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23823,1,3,0)
 ;;=3^Malig Neop of bone, secondary
 ;;^UTILITY(U,$J,358.3,23823,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,23823,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,23824,0)
 ;;=C79.52^^116^1163^3
 ;;^UTILITY(U,$J,358.3,23824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23824,1,3,0)
 ;;=3^Malig Neop of bone marrow, secondary
 ;;^UTILITY(U,$J,358.3,23824,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,23824,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,23825,0)
 ;;=C44.92^^116^1163^16
 ;;^UTILITY(U,$J,358.3,23825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23825,1,3,0)
 ;;=3^Squamous Cell Carcinoma of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,23825,1,4,0)
 ;;=4^C44.92
 ;;^UTILITY(U,$J,358.3,23825,2)
 ;;=^5001093
 ;;^UTILITY(U,$J,358.3,23826,0)
 ;;=K63.5^^116^1164^17
 ;;^UTILITY(U,$J,358.3,23826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23826,1,3,0)
 ;;=3^Colon polyp
 ;;^UTILITY(U,$J,358.3,23826,1,4,0)
 ;;=4^K63.5
 ;;^UTILITY(U,$J,358.3,23826,2)
 ;;=^5008765
 ;;^UTILITY(U,$J,358.3,23827,0)
 ;;=G56.01^^116^1164^7
 ;;^UTILITY(U,$J,358.3,23827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23827,1,3,0)
 ;;=3^Carpal tunnel syndrome, right upper limb
 ;;^UTILITY(U,$J,358.3,23827,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,23827,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,23828,0)
 ;;=G56.02^^116^1164^6
 ;;^UTILITY(U,$J,358.3,23828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23828,1,3,0)
 ;;=3^Carpal tunnel syndrome, left upper limb
 ;;^UTILITY(U,$J,358.3,23828,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,23828,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,23829,0)
 ;;=H26.9^^116^1164^8
 ;;^UTILITY(U,$J,358.3,23829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23829,1,3,0)
 ;;=3^Cataract, unspec
 ;;^UTILITY(U,$J,358.3,23829,1,4,0)
 ;;=4^H26.9
 ;;^UTILITY(U,$J,358.3,23829,2)
 ;;=^5005363
 ;;^UTILITY(U,$J,358.3,23830,0)
 ;;=I25.10^^116^1164^1
 ;;^UTILITY(U,$J,358.3,23830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23830,1,3,0)
 ;;=3^CAD of native coronary artery w/o ang pctrs
 ;;^UTILITY(U,$J,358.3,23830,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,23830,2)
 ;;=^5007107
