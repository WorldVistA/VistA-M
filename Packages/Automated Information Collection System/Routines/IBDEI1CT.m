IBDEI1CT ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21637,1,3,0)
 ;;=3^Malig Neop of colon, unspec
 ;;^UTILITY(U,$J,358.3,21637,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,21637,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,21638,0)
 ;;=C32.9^^99^1101^7
 ;;^UTILITY(U,$J,358.3,21638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21638,1,3,0)
 ;;=3^Malig Neop of larynx, unspec
 ;;^UTILITY(U,$J,358.3,21638,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,21638,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,21639,0)
 ;;=C34.91^^99^1101^13
 ;;^UTILITY(U,$J,358.3,21639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21639,1,3,0)
 ;;=3^Malig Neop of rt bronchus or lung, unsp part
 ;;^UTILITY(U,$J,358.3,21639,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,21639,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,21640,0)
 ;;=C34.92^^99^1101^9
 ;;^UTILITY(U,$J,358.3,21640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21640,1,3,0)
 ;;=3^Malig Neop of lft bronchus or lung, unsp part
 ;;^UTILITY(U,$J,358.3,21640,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,21640,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,21641,0)
 ;;=C44.91^^99^1101^1
 ;;^UTILITY(U,$J,358.3,21641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21641,1,3,0)
 ;;=3^Basal cell carcinoma of skin, unspec
 ;;^UTILITY(U,$J,358.3,21641,1,4,0)
 ;;=4^C44.91
 ;;^UTILITY(U,$J,358.3,21641,2)
 ;;=^5001092
 ;;^UTILITY(U,$J,358.3,21642,0)
 ;;=C44.99^^99^1101^15
 ;;^UTILITY(U,$J,358.3,21642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21642,1,3,0)
 ;;=3^Malig Neop of skin, oth spec, unspec
 ;;^UTILITY(U,$J,358.3,21642,1,4,0)
 ;;=4^C44.99
 ;;^UTILITY(U,$J,358.3,21642,2)
 ;;=^5001094
 ;;^UTILITY(U,$J,358.3,21643,0)
 ;;=C50.912^^99^1101^8
 ;;^UTILITY(U,$J,358.3,21643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21643,1,3,0)
 ;;=3^Malig Neop of lft breast, female, unspec site
 ;;^UTILITY(U,$J,358.3,21643,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,21643,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,21644,0)
 ;;=C50.911^^99^1101^12
 ;;^UTILITY(U,$J,358.3,21644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21644,1,3,0)
 ;;=3^Malig Neop of rt breast, female, unspec site
 ;;^UTILITY(U,$J,358.3,21644,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,21644,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,21645,0)
 ;;=C61.^^99^1101^11
 ;;^UTILITY(U,$J,358.3,21645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21645,1,3,0)
 ;;=3^Malig Neop of prostate
 ;;^UTILITY(U,$J,358.3,21645,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,21645,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,21646,0)
 ;;=C67.9^^99^1101^2
 ;;^UTILITY(U,$J,358.3,21646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21646,1,3,0)
 ;;=3^Malig Neop of bladder, unspec
 ;;^UTILITY(U,$J,358.3,21646,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,21646,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,21647,0)
 ;;=C64.2^^99^1101^10
 ;;^UTILITY(U,$J,358.3,21647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21647,1,3,0)
 ;;=3^Malig Neop of lft kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,21647,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,21647,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,21648,0)
 ;;=C64.1^^99^1101^14
 ;;^UTILITY(U,$J,358.3,21648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21648,1,3,0)
 ;;=3^Malig Neop of rt kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,21648,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,21648,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,21649,0)
 ;;=C79.51^^99^1101^4
 ;;^UTILITY(U,$J,358.3,21649,1,0)
 ;;=^358.31IA^4^2
