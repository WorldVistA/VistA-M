IBDEI1FF ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23075,0)
 ;;=K52.9^^78^999^20
 ;;^UTILITY(U,$J,358.3,23075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23075,1,3,0)
 ;;=3^Gastroenteritis & Colitis Noninfective,Unspec
 ;;^UTILITY(U,$J,358.3,23075,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,23075,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,23076,0)
 ;;=K82.9^^78^999^17
 ;;^UTILITY(U,$J,358.3,23076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23076,1,3,0)
 ;;=3^Gallbladder Disease,Unspec
 ;;^UTILITY(U,$J,358.3,23076,1,4,0)
 ;;=4^K82.9
 ;;^UTILITY(U,$J,358.3,23076,2)
 ;;=^5008875
 ;;^UTILITY(U,$J,358.3,23077,0)
 ;;=K92.2^^78^999^21
 ;;^UTILITY(U,$J,358.3,23077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23077,1,3,0)
 ;;=3^Gastrointestinal Hemorrhage,Unspec
 ;;^UTILITY(U,$J,358.3,23077,1,4,0)
 ;;=4^K92.2
 ;;^UTILITY(U,$J,358.3,23077,2)
 ;;=^5008915
 ;;^UTILITY(U,$J,358.3,23078,0)
 ;;=K25.9^^78^999^18
 ;;^UTILITY(U,$J,358.3,23078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23078,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,23078,1,4,0)
 ;;=4^K25.9
 ;;^UTILITY(U,$J,358.3,23078,2)
 ;;=^5008522
 ;;^UTILITY(U,$J,358.3,23079,0)
 ;;=K22.10^^78^999^13
 ;;^UTILITY(U,$J,358.3,23079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23079,1,3,0)
 ;;=3^Esophagus ulcer w/o bleeding
 ;;^UTILITY(U,$J,358.3,23079,1,4,0)
 ;;=4^K22.10
 ;;^UTILITY(U,$J,358.3,23079,2)
 ;;=^329929
 ;;^UTILITY(U,$J,358.3,23080,0)
 ;;=K22.11^^78^999^12
 ;;^UTILITY(U,$J,358.3,23080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23080,1,3,0)
 ;;=3^Esophagus ulcer w/ bleeding
 ;;^UTILITY(U,$J,358.3,23080,1,4,0)
 ;;=4^K22.11
 ;;^UTILITY(U,$J,358.3,23080,2)
 ;;=^329930
 ;;^UTILITY(U,$J,358.3,23081,0)
 ;;=K22.2^^78^999^9
 ;;^UTILITY(U,$J,358.3,23081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23081,1,3,0)
 ;;=3^Esophageal obstruction
 ;;^UTILITY(U,$J,358.3,23081,1,4,0)
 ;;=4^K22.2
 ;;^UTILITY(U,$J,358.3,23081,2)
 ;;=^5008507
 ;;^UTILITY(U,$J,358.3,23082,0)
 ;;=K26.9^^78^999^5
 ;;^UTILITY(U,$J,358.3,23082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23082,1,3,0)
 ;;=3^Duodenal ulcer w/o hemorrhage/perforation
 ;;^UTILITY(U,$J,358.3,23082,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,23082,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,23083,0)
 ;;=K27.9^^78^999^31
 ;;^UTILITY(U,$J,358.3,23083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23083,1,3,0)
 ;;=3^Peptic ulcer w/o hemorrhage/perforation
 ;;^UTILITY(U,$J,358.3,23083,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,23083,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,23084,0)
 ;;=K57.30^^78^999^4
 ;;^UTILITY(U,$J,358.3,23084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23084,1,3,0)
 ;;=3^Diverticulosis lg intest w/o perforation/abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,23084,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,23084,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,23085,0)
 ;;=K58.9^^78^999^26
 ;;^UTILITY(U,$J,358.3,23085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23085,1,3,0)
 ;;=3^IBS w/o diarrhea
 ;;^UTILITY(U,$J,358.3,23085,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,23085,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,23086,0)
 ;;=K59.09^^78^999^3
 ;;^UTILITY(U,$J,358.3,23086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23086,1,3,0)
 ;;=3^Constipation, other
 ;;^UTILITY(U,$J,358.3,23086,1,4,0)
 ;;=4^K59.09
 ;;^UTILITY(U,$J,358.3,23086,2)
 ;;=^323540
 ;;^UTILITY(U,$J,358.3,23087,0)
 ;;=K62.5^^78^999^22
 ;;^UTILITY(U,$J,358.3,23087,1,0)
 ;;=^358.31IA^4^2
