IBDEI1EF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23342,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,23342,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,23343,0)
 ;;=C15.9^^113^1123^6
 ;;^UTILITY(U,$J,358.3,23343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23343,1,3,0)
 ;;=3^Malig Neop of esophagus, unspec
 ;;^UTILITY(U,$J,358.3,23343,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,23343,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,23344,0)
 ;;=C18.9^^113^1123^5
 ;;^UTILITY(U,$J,358.3,23344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23344,1,3,0)
 ;;=3^Malig Neop of colon, unspec
 ;;^UTILITY(U,$J,358.3,23344,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,23344,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,23345,0)
 ;;=C32.9^^113^1123^7
 ;;^UTILITY(U,$J,358.3,23345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23345,1,3,0)
 ;;=3^Malig Neop of larynx, unspec
 ;;^UTILITY(U,$J,358.3,23345,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,23345,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,23346,0)
 ;;=C34.91^^113^1123^13
 ;;^UTILITY(U,$J,358.3,23346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23346,1,3,0)
 ;;=3^Malig Neop of rt bronchus or lung, unsp part
 ;;^UTILITY(U,$J,358.3,23346,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,23346,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,23347,0)
 ;;=C34.92^^113^1123^9
 ;;^UTILITY(U,$J,358.3,23347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23347,1,3,0)
 ;;=3^Malig Neop of lft bronchus or lung, unsp part
 ;;^UTILITY(U,$J,358.3,23347,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,23347,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,23348,0)
 ;;=C44.91^^113^1123^1
 ;;^UTILITY(U,$J,358.3,23348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23348,1,3,0)
 ;;=3^Basal cell carcinoma of skin, unspec
 ;;^UTILITY(U,$J,358.3,23348,1,4,0)
 ;;=4^C44.91
 ;;^UTILITY(U,$J,358.3,23348,2)
 ;;=^5001092
 ;;^UTILITY(U,$J,358.3,23349,0)
 ;;=C44.99^^113^1123^15
 ;;^UTILITY(U,$J,358.3,23349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23349,1,3,0)
 ;;=3^Malig Neop of skin, oth spec, unspec
 ;;^UTILITY(U,$J,358.3,23349,1,4,0)
 ;;=4^C44.99
 ;;^UTILITY(U,$J,358.3,23349,2)
 ;;=^5001094
 ;;^UTILITY(U,$J,358.3,23350,0)
 ;;=C50.912^^113^1123^8
 ;;^UTILITY(U,$J,358.3,23350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23350,1,3,0)
 ;;=3^Malig Neop of lft breast, female, unspec site
 ;;^UTILITY(U,$J,358.3,23350,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,23350,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,23351,0)
 ;;=C50.911^^113^1123^12
 ;;^UTILITY(U,$J,358.3,23351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23351,1,3,0)
 ;;=3^Malig Neop of rt breast, female, unspec site
 ;;^UTILITY(U,$J,358.3,23351,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,23351,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,23352,0)
 ;;=C61.^^113^1123^11
 ;;^UTILITY(U,$J,358.3,23352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23352,1,3,0)
 ;;=3^Malig Neop of prostate
 ;;^UTILITY(U,$J,358.3,23352,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,23352,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,23353,0)
 ;;=C67.9^^113^1123^2
 ;;^UTILITY(U,$J,358.3,23353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23353,1,3,0)
 ;;=3^Malig Neop of bladder, unspec
 ;;^UTILITY(U,$J,358.3,23353,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,23353,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,23354,0)
 ;;=C64.2^^113^1123^10
 ;;^UTILITY(U,$J,358.3,23354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23354,1,3,0)
 ;;=3^Malig Neop of lft kidney, except renal pelvis
 ;;^UTILITY(U,$J,358.3,23354,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,23354,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,23355,0)
 ;;=C64.1^^113^1123^14
 ;;^UTILITY(U,$J,358.3,23355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23355,1,3,0)
 ;;=3^Malig Neop of rt kidney, except renal pelvis
