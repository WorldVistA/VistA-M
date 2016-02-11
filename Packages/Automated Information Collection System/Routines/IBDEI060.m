IBDEI060 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2211,1,4,0)
 ;;=4^I25.111
 ;;^UTILITY(U,$J,358.3,2211,2)
 ;;=^5007109
 ;;^UTILITY(U,$J,358.3,2212,0)
 ;;=I25.118^^19^191^17
 ;;^UTILITY(U,$J,358.3,2212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2212,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2212,1,4,0)
 ;;=4^I25.118
 ;;^UTILITY(U,$J,358.3,2212,2)
 ;;=^5007110
 ;;^UTILITY(U,$J,358.3,2213,0)
 ;;=I25.119^^19^191^18
 ;;^UTILITY(U,$J,358.3,2213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2213,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2213,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,2213,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,2214,0)
 ;;=I25.701^^19^191^29
 ;;^UTILITY(U,$J,358.3,2214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2214,1,3,0)
 ;;=3^Athscl of CABG w/ Ang Pctrs w/ Documented Spasm,Unspec
 ;;^UTILITY(U,$J,358.3,2214,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,2214,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,2215,0)
 ;;=I25.708^^19^191^31
 ;;^UTILITY(U,$J,358.3,2215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2215,1,3,0)
 ;;=3^Athscl of CABG w/ Oth Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,2215,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,2215,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,2216,0)
 ;;=I25.709^^19^191^33
 ;;^UTILITY(U,$J,358.3,2216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2216,1,3,0)
 ;;=3^Athscl of CABG w/ Unspec Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,2216,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,2216,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,2217,0)
 ;;=I25.711^^19^191^7
 ;;^UTILITY(U,$J,358.3,2217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2217,1,3,0)
 ;;=3^Athscl Autologous Vein CABG w/ Ang Pctrs w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,2217,1,4,0)
 ;;=4^I25.711
 ;;^UTILITY(U,$J,358.3,2217,2)
 ;;=^5007122
 ;;^UTILITY(U,$J,358.3,2218,0)
 ;;=I25.718^^19^191^8
 ;;^UTILITY(U,$J,358.3,2218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2218,1,3,0)
 ;;=3^Athscl Autologous Vein CABG w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2218,1,4,0)
 ;;=4^I25.718
 ;;^UTILITY(U,$J,358.3,2218,2)
 ;;=^5007123
 ;;^UTILITY(U,$J,358.3,2219,0)
 ;;=I25.719^^19^191^9
 ;;^UTILITY(U,$J,358.3,2219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2219,1,3,0)
 ;;=3^Athscl Autologous Vein CABG w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2219,1,4,0)
 ;;=4^I25.719
 ;;^UTILITY(U,$J,358.3,2219,2)
 ;;=^5007124
 ;;^UTILITY(U,$J,358.3,2220,0)
 ;;=I25.721^^19^191^3
 ;;^UTILITY(U,$J,358.3,2220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2220,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Ang Pctrs w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,2220,1,4,0)
 ;;=4^I25.721
 ;;^UTILITY(U,$J,358.3,2220,2)
 ;;=^5007126
 ;;^UTILITY(U,$J,358.3,2221,0)
 ;;=I25.728^^19^191^4
 ;;^UTILITY(U,$J,358.3,2221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2221,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2221,1,4,0)
 ;;=4^I25.728
 ;;^UTILITY(U,$J,358.3,2221,2)
 ;;=^5133560
 ;;^UTILITY(U,$J,358.3,2222,0)
 ;;=I25.729^^19^191^5
 ;;^UTILITY(U,$J,358.3,2222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2222,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2222,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,2222,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,2223,0)
 ;;=I25.731^^19^191^25
 ;;^UTILITY(U,$J,358.3,2223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2223,1,3,0)
 ;;=3^Athscl Nonautologous Biological CABG w/ Ang Pctrs w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,2223,1,4,0)
 ;;=4^I25.731
 ;;^UTILITY(U,$J,358.3,2223,2)
 ;;=^5007128
