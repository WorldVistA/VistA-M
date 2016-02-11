IBDEI12N ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17875,1,3,0)
 ;;=3^Celiac disease
 ;;^UTILITY(U,$J,358.3,17875,1,4,0)
 ;;=4^K90.0
 ;;^UTILITY(U,$J,358.3,17875,2)
 ;;=^20828
 ;;^UTILITY(U,$J,358.3,17876,0)
 ;;=B96.81^^91^886^22
 ;;^UTILITY(U,$J,358.3,17876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17876,1,3,0)
 ;;=3^Helicobacter pylori as the cause of diseases classd elswhr
 ;;^UTILITY(U,$J,358.3,17876,1,4,0)
 ;;=4^B96.81
 ;;^UTILITY(U,$J,358.3,17876,2)
 ;;=^5000857
 ;;^UTILITY(U,$J,358.3,17877,0)
 ;;=C16.9^^91^886^23
 ;;^UTILITY(U,$J,358.3,17877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17877,1,3,0)
 ;;=3^Malignant neoplasm of stomach, unspecified
 ;;^UTILITY(U,$J,358.3,17877,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,17877,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,17878,0)
 ;;=I86.4^^91^886^15
 ;;^UTILITY(U,$J,358.3,17878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17878,1,3,0)
 ;;=3^Gastric varices
 ;;^UTILITY(U,$J,358.3,17878,1,4,0)
 ;;=4^I86.4
 ;;^UTILITY(U,$J,358.3,17878,2)
 ;;=^49382
 ;;^UTILITY(U,$J,358.3,17879,0)
 ;;=K25.0^^91^886^2
 ;;^UTILITY(U,$J,358.3,17879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17879,1,3,0)
 ;;=3^Acute gastric ulcer with hemorrhage
 ;;^UTILITY(U,$J,358.3,17879,1,4,0)
 ;;=4^K25.0
 ;;^UTILITY(U,$J,358.3,17879,2)
 ;;=^270064
 ;;^UTILITY(U,$J,358.3,17880,0)
 ;;=K25.9^^91^886^14
 ;;^UTILITY(U,$J,358.3,17880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17880,1,3,0)
 ;;=3^Gastric ulcer, unsp as acute or chronic, w/o hemor or perf
 ;;^UTILITY(U,$J,358.3,17880,1,4,0)
 ;;=4^K25.9
 ;;^UTILITY(U,$J,358.3,17880,2)
 ;;=^5008522
 ;;^UTILITY(U,$J,358.3,17881,0)
 ;;=K26.0^^91^886^1
 ;;^UTILITY(U,$J,358.3,17881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17881,1,3,0)
 ;;=3^Acute duodenal ulcer with hemorrhage
 ;;^UTILITY(U,$J,358.3,17881,1,4,0)
 ;;=4^K26.0
 ;;^UTILITY(U,$J,358.3,17881,2)
 ;;=^270089
 ;;^UTILITY(U,$J,358.3,17882,0)
 ;;=K26.9^^91^886^12
 ;;^UTILITY(U,$J,358.3,17882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17882,1,3,0)
 ;;=3^Duodenal ulcer, unsp as acute or chronic, w/o hemor or perf
 ;;^UTILITY(U,$J,358.3,17882,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,17882,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,17883,0)
 ;;=K27.9^^91^886^25
 ;;^UTILITY(U,$J,358.3,17883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17883,1,3,0)
 ;;=3^Peptic ulc, site unsp, unsp as ac or chr, w/o hemor or perf
 ;;^UTILITY(U,$J,358.3,17883,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,17883,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,17884,0)
 ;;=K29.40^^91^886^7
 ;;^UTILITY(U,$J,358.3,17884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17884,1,3,0)
 ;;=3^Chronic atrophic gastritis without bleeding
 ;;^UTILITY(U,$J,358.3,17884,1,4,0)
 ;;=4^K29.40
 ;;^UTILITY(U,$J,358.3,17884,2)
 ;;=^5008548
 ;;^UTILITY(U,$J,358.3,17885,0)
 ;;=K29.50^^91^886^6
 ;;^UTILITY(U,$J,358.3,17885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17885,1,3,0)
 ;;=3^Chronic Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,17885,1,4,0)
 ;;=4^K29.50
 ;;^UTILITY(U,$J,358.3,17885,2)
 ;;=^5008550
 ;;^UTILITY(U,$J,358.3,17886,0)
 ;;=K29.30^^91^886^8
 ;;^UTILITY(U,$J,358.3,17886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17886,1,3,0)
 ;;=3^Chronic superficial gastritis without bleeding
 ;;^UTILITY(U,$J,358.3,17886,1,4,0)
 ;;=4^K29.30
 ;;^UTILITY(U,$J,358.3,17886,2)
 ;;=^5008546
 ;;^UTILITY(U,$J,358.3,17887,0)
 ;;=K29.20^^91^886^3
 ;;^UTILITY(U,$J,358.3,17887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17887,1,3,0)
 ;;=3^Alcoholic gastritis without bleeding
 ;;^UTILITY(U,$J,358.3,17887,1,4,0)
 ;;=4^K29.20
