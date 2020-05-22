IBDEI1JE ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24568,0)
 ;;=K59.03^^107^1207^21
 ;;^UTILITY(U,$J,358.3,24568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24568,1,3,0)
 ;;=3^Constipation,Drug Induced
 ;;^UTILITY(U,$J,358.3,24568,1,4,0)
 ;;=4^K59.03
 ;;^UTILITY(U,$J,358.3,24568,2)
 ;;=^5138744
 ;;^UTILITY(U,$J,358.3,24569,0)
 ;;=K52.21^^107^1207^51
 ;;^UTILITY(U,$J,358.3,24569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24569,1,3,0)
 ;;=3^Enterocolitis Synd Induced by Food Protein
 ;;^UTILITY(U,$J,358.3,24569,1,4,0)
 ;;=4^K52.21
 ;;^UTILITY(U,$J,358.3,24569,2)
 ;;=^5138713
 ;;^UTILITY(U,$J,358.3,24570,0)
 ;;=K52.22^^107^1207^52
 ;;^UTILITY(U,$J,358.3,24570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24570,1,3,0)
 ;;=3^Enterocolopathy Induced by Food Protein
 ;;^UTILITY(U,$J,358.3,24570,1,4,0)
 ;;=4^K52.22
 ;;^UTILITY(U,$J,358.3,24570,2)
 ;;=^5138714
 ;;^UTILITY(U,$J,358.3,24571,0)
 ;;=K58.2^^107^1207^79
 ;;^UTILITY(U,$J,358.3,24571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24571,1,3,0)
 ;;=3^Irritable Bowel Syndrome,Mixed
 ;;^UTILITY(U,$J,358.3,24571,1,4,0)
 ;;=4^K58.2
 ;;^UTILITY(U,$J,358.3,24571,2)
 ;;=^5138742
 ;;^UTILITY(U,$J,358.3,24572,0)
 ;;=K58.8^^107^1207^80
 ;;^UTILITY(U,$J,358.3,24572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24572,1,3,0)
 ;;=3^Irritable Bowel Syndrome,Other
 ;;^UTILITY(U,$J,358.3,24572,1,4,0)
 ;;=4^K58.8
 ;;^UTILITY(U,$J,358.3,24572,2)
 ;;=^5138743
 ;;^UTILITY(U,$J,358.3,24573,0)
 ;;=K58.1^^107^1207^76
 ;;^UTILITY(U,$J,358.3,24573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24573,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/ Constipation
 ;;^UTILITY(U,$J,358.3,24573,1,4,0)
 ;;=4^K58.1
 ;;^UTILITY(U,$J,358.3,24573,2)
 ;;=^5138741
 ;;^UTILITY(U,$J,358.3,24574,0)
 ;;=K61.39^^107^1207^5
 ;;^UTILITY(U,$J,358.3,24574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24574,1,3,0)
 ;;=3^Abscess,Ischiorectal NOS
 ;;^UTILITY(U,$J,358.3,24574,1,4,0)
 ;;=4^K61.39
 ;;^UTILITY(U,$J,358.3,24574,2)
 ;;=^5157385
 ;;^UTILITY(U,$J,358.3,24575,0)
 ;;=G43.A1^^107^1207^34
 ;;^UTILITY(U,$J,358.3,24575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24575,1,3,0)
 ;;=3^Cyclical Vomiting,In Migraine,Intractable
 ;;^UTILITY(U,$J,358.3,24575,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,24575,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,24576,0)
 ;;=G43.A0^^107^1207^35
 ;;^UTILITY(U,$J,358.3,24576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24576,1,3,0)
 ;;=3^Cyclical Vomiting,In Migraine,Not intractable
 ;;^UTILITY(U,$J,358.3,24576,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,24576,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,24577,0)
 ;;=R11.15^^107^1207^33
 ;;^UTILITY(U,$J,358.3,24577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24577,1,3,0)
 ;;=3^Cyclical Vomiting Syndrome,Unrelated to Migraine
 ;;^UTILITY(U,$J,358.3,24577,1,4,0)
 ;;=4^R11.15
 ;;^UTILITY(U,$J,358.3,24577,2)
 ;;=^5158141
 ;;^UTILITY(U,$J,358.3,24578,0)
 ;;=A54.00^^107^1208^50
 ;;^UTILITY(U,$J,358.3,24578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24578,1,3,0)
 ;;=3^Gonococcal Infection Lower Genitourinary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,24578,1,4,0)
 ;;=4^A54.00
 ;;^UTILITY(U,$J,358.3,24578,2)
 ;;=^5000311
 ;;^UTILITY(U,$J,358.3,24579,0)
 ;;=A54.09^^107^1208^51
 ;;^UTILITY(U,$J,358.3,24579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24579,1,3,0)
 ;;=3^Gonococcal Infection Lower Genitourinary Tract,Other
 ;;^UTILITY(U,$J,358.3,24579,1,4,0)
 ;;=4^A54.09
 ;;^UTILITY(U,$J,358.3,24579,2)
 ;;=^5000315
