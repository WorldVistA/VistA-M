IBDEI0HI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7620,0)
 ;;=D12.4^^63^496^6
 ;;^UTILITY(U,$J,358.3,7620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7620,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,7620,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,7620,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,7621,0)
 ;;=D12.5^^63^496^9
 ;;^UTILITY(U,$J,358.3,7621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7621,1,3,0)
 ;;=3^Benign Neop of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,7621,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,7621,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,7622,0)
 ;;=D12.7^^63^496^7
 ;;^UTILITY(U,$J,358.3,7622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7622,1,3,0)
 ;;=3^Benign Neop of Rectosigmoid Junction
 ;;^UTILITY(U,$J,358.3,7622,1,4,0)
 ;;=4^D12.7
 ;;^UTILITY(U,$J,358.3,7622,2)
 ;;=^5001970
 ;;^UTILITY(U,$J,358.3,7623,0)
 ;;=D12.8^^63^496^8
 ;;^UTILITY(U,$J,358.3,7623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7623,1,3,0)
 ;;=3^Benign Neop of Rectum
 ;;^UTILITY(U,$J,358.3,7623,1,4,0)
 ;;=4^D12.8
 ;;^UTILITY(U,$J,358.3,7623,2)
 ;;=^5001971
 ;;^UTILITY(U,$J,358.3,7624,0)
 ;;=K81.2^^63^496^1
 ;;^UTILITY(U,$J,358.3,7624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7624,1,3,0)
 ;;=3^Acute Cholecystitis w/ Chronic Cholecystitis
 ;;^UTILITY(U,$J,358.3,7624,1,4,0)
 ;;=4^K81.2
 ;;^UTILITY(U,$J,358.3,7624,2)
 ;;=^5008872
 ;;^UTILITY(U,$J,358.3,7625,0)
 ;;=K25.5^^63^496^18
 ;;^UTILITY(U,$J,358.3,7625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7625,1,3,0)
 ;;=3^Gastric Ulcer w/ Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,7625,1,4,0)
 ;;=4^K25.5
 ;;^UTILITY(U,$J,358.3,7625,2)
 ;;=^270079
 ;;^UTILITY(U,$J,358.3,7626,0)
 ;;=K25.6^^63^496^16
 ;;^UTILITY(U,$J,358.3,7626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7626,1,3,0)
 ;;=3^Gastric Ulcer w/ Hemorrhage & Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,7626,1,4,0)
 ;;=4^K25.6
 ;;^UTILITY(U,$J,358.3,7626,2)
 ;;=^5008520
 ;;^UTILITY(U,$J,358.3,7627,0)
 ;;=C18.3^^63^496^33
 ;;^UTILITY(U,$J,358.3,7627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7627,1,3,0)
 ;;=3^Malig Neop of Hepatic Flexure
 ;;^UTILITY(U,$J,358.3,7627,1,4,0)
 ;;=4^C18.3
 ;;^UTILITY(U,$J,358.3,7627,2)
 ;;=^267079
 ;;^UTILITY(U,$J,358.3,7628,0)
 ;;=C18.4^^63^496^39
 ;;^UTILITY(U,$J,358.3,7628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7628,1,3,0)
 ;;=3^Malig Neop of Transverse Colon
 ;;^UTILITY(U,$J,358.3,7628,1,4,0)
 ;;=4^C18.4
 ;;^UTILITY(U,$J,358.3,7628,2)
 ;;=^267080
 ;;^UTILITY(U,$J,358.3,7629,0)
 ;;=C18.5^^63^496^38
 ;;^UTILITY(U,$J,358.3,7629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7629,1,3,0)
 ;;=3^Malig Neop of Splenic Flexure
 ;;^UTILITY(U,$J,358.3,7629,1,4,0)
 ;;=4^C18.5
 ;;^UTILITY(U,$J,358.3,7629,2)
 ;;=^267086
 ;;^UTILITY(U,$J,358.3,7630,0)
 ;;=C18.6^^63^496^32
 ;;^UTILITY(U,$J,358.3,7630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7630,1,3,0)
 ;;=3^Malig Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,7630,1,4,0)
 ;;=4^C18.6
 ;;^UTILITY(U,$J,358.3,7630,2)
 ;;=^267081
 ;;^UTILITY(U,$J,358.3,7631,0)
 ;;=C18.8^^63^496^34
 ;;^UTILITY(U,$J,358.3,7631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7631,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Colon
 ;;^UTILITY(U,$J,358.3,7631,1,4,0)
 ;;=4^C18.8
 ;;^UTILITY(U,$J,358.3,7631,2)
 ;;=^5000928
 ;;^UTILITY(U,$J,358.3,7632,0)
 ;;=A04.71^^63^496^14
 ;;^UTILITY(U,$J,358.3,7632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7632,1,3,0)
 ;;=3^Enterocolitis d/t Clostridium Difficile,Recurrent
