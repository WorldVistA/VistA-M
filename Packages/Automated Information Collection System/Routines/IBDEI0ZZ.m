IBDEI0ZZ ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16229,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,16229,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,16230,0)
 ;;=D12.4^^61^771^14
 ;;^UTILITY(U,$J,358.3,16230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16230,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,16230,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,16230,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,16231,0)
 ;;=D73.2^^61^771^19
 ;;^UTILITY(U,$J,358.3,16231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16231,1,3,0)
 ;;=3^Congestive Splenomegaly,Chronic
 ;;^UTILITY(U,$J,358.3,16231,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,16231,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,16232,0)
 ;;=I85.00^^61^771^53
 ;;^UTILITY(U,$J,358.3,16232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16232,1,3,0)
 ;;=3^Esophageal Varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,16232,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,16232,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,16233,0)
 ;;=K21.9^^61^771^63
 ;;^UTILITY(U,$J,358.3,16233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16233,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,16233,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,16233,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,16234,0)
 ;;=K25.7^^61^771^58
 ;;^UTILITY(U,$J,358.3,16234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16234,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,16234,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,16234,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,16235,0)
 ;;=K26.9^^61^771^49
 ;;^UTILITY(U,$J,358.3,16235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16235,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,16235,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,16235,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,16236,0)
 ;;=K27.9^^61^771^83
 ;;^UTILITY(U,$J,358.3,16236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16236,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,16236,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,16236,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,16237,0)
 ;;=K29.70^^61^771^59
 ;;^UTILITY(U,$J,358.3,16237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16237,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,16237,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,16237,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,16238,0)
 ;;=K29.90^^61^771^60
 ;;^UTILITY(U,$J,358.3,16238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16238,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,16238,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,16238,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,16239,0)
 ;;=K30.^^61^771^50
 ;;^UTILITY(U,$J,358.3,16239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16239,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,16239,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,16239,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,16240,0)
 ;;=K31.89^^61^771^39
 ;;^UTILITY(U,$J,358.3,16240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16240,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,16240,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,16240,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,16241,0)
 ;;=K31.9^^61^771^38
 ;;^UTILITY(U,$J,358.3,16241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16241,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,16241,1,4,0)
 ;;=4^K31.9
