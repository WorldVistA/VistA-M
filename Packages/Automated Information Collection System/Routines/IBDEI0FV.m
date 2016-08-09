IBDEI0FV ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15876,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15876,1,4,0)
 ;;=4^W18.12XD
 ;;^UTILITY(U,$J,358.3,15876,2)
 ;;=^5137984
 ;;^UTILITY(U,$J,358.3,15877,0)
 ;;=W18.2XXA^^61^759^73
 ;;^UTILITY(U,$J,358.3,15877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15877,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Init Encntr
 ;;^UTILITY(U,$J,358.3,15877,1,4,0)
 ;;=4^W18.2XXA
 ;;^UTILITY(U,$J,358.3,15877,2)
 ;;=^5059806
 ;;^UTILITY(U,$J,358.3,15878,0)
 ;;=W18.2XXD^^61^759^74
 ;;^UTILITY(U,$J,358.3,15878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15878,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15878,1,4,0)
 ;;=4^W18.2XXD
 ;;^UTILITY(U,$J,358.3,15878,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,15879,0)
 ;;=W18.40XA^^61^759^105
 ;;^UTILITY(U,$J,358.3,15879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15879,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,15879,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,15879,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,15880,0)
 ;;=W18.40XD^^61^759^106
 ;;^UTILITY(U,$J,358.3,15880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15880,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15880,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,15880,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,15881,0)
 ;;=W18.41XA^^61^759^107
 ;;^UTILITY(U,$J,358.3,15881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15881,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,15881,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,15881,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,15882,0)
 ;;=W18.41XD^^61^759^108
 ;;^UTILITY(U,$J,358.3,15882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15882,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15882,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,15882,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,15883,0)
 ;;=W18.42XA^^61^759^109
 ;;^UTILITY(U,$J,358.3,15883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15883,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,15883,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,15883,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,15884,0)
 ;;=W18.42XD^^61^759^110
 ;;^UTILITY(U,$J,358.3,15884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15884,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15884,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,15884,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,15885,0)
 ;;=W18.43XA^^61^759^103
 ;;^UTILITY(U,$J,358.3,15885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15885,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,15885,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,15885,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,15886,0)
 ;;=W18.43XD^^61^759^104
 ;;^UTILITY(U,$J,358.3,15886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15886,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15886,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,15886,2)
 ;;=^5059828
 ;;^UTILITY(U,$J,358.3,15887,0)
 ;;=W18.49XA^^61^759^111
 ;;^UTILITY(U,$J,358.3,15887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15887,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,15887,1,4,0)
 ;;=4^W18.49XA
 ;;^UTILITY(U,$J,358.3,15887,2)
 ;;=^5059830
 ;;^UTILITY(U,$J,358.3,15888,0)
 ;;=W18.49XD^^61^759^112
 ;;^UTILITY(U,$J,358.3,15888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15888,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15888,1,4,0)
 ;;=4^W18.49XD
 ;;^UTILITY(U,$J,358.3,15888,2)
 ;;=^5059831
 ;;^UTILITY(U,$J,358.3,15889,0)
 ;;=W19.XXXA^^61^759^89
 ;;^UTILITY(U,$J,358.3,15889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15889,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,15889,1,4,0)
 ;;=4^W19.XXXA
 ;;^UTILITY(U,$J,358.3,15889,2)
 ;;=^5059833
 ;;^UTILITY(U,$J,358.3,15890,0)
 ;;=W19.XXXD^^61^759^90
 ;;^UTILITY(U,$J,358.3,15890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15890,1,3,0)
 ;;=3^Fall,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15890,1,4,0)
 ;;=4^W19.XXXD
 ;;^UTILITY(U,$J,358.3,15890,2)
 ;;=^5059834
 ;;^UTILITY(U,$J,358.3,15891,0)
 ;;=W54.0XXA^^61^759^11
 ;;^UTILITY(U,$J,358.3,15891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15891,1,3,0)
 ;;=3^Bitten by Dog,Init Encntr
 ;;^UTILITY(U,$J,358.3,15891,1,4,0)
 ;;=4^W54.0XXA
 ;;^UTILITY(U,$J,358.3,15891,2)
 ;;=^5060256
 ;;^UTILITY(U,$J,358.3,15892,0)
 ;;=W54.0XXD^^61^759^12
 ;;^UTILITY(U,$J,358.3,15892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15892,1,3,0)
 ;;=3^Bitten by Dog,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15892,1,4,0)
 ;;=4^W54.0XXD
 ;;^UTILITY(U,$J,358.3,15892,2)
 ;;=^5060257
 ;;^UTILITY(U,$J,358.3,15893,0)
 ;;=W55.01XA^^61^759^9
 ;;^UTILITY(U,$J,358.3,15893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15893,1,3,0)
 ;;=3^Bitten by Cat,Init Encntr
 ;;^UTILITY(U,$J,358.3,15893,1,4,0)
 ;;=4^W55.01XA
 ;;^UTILITY(U,$J,358.3,15893,2)
 ;;=^5060265
 ;;^UTILITY(U,$J,358.3,15894,0)
 ;;=W55.01XD^^61^759^10
 ;;^UTILITY(U,$J,358.3,15894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15894,1,3,0)
 ;;=3^Bitten by Cat,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15894,1,4,0)
 ;;=4^W55.01XD
 ;;^UTILITY(U,$J,358.3,15894,2)
 ;;=^5060266
 ;;^UTILITY(U,$J,358.3,15895,0)
 ;;=W55.03XA^^61^759^101
 ;;^UTILITY(U,$J,358.3,15895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15895,1,3,0)
 ;;=3^Scratched by Cat,Init Encntr
 ;;^UTILITY(U,$J,358.3,15895,1,4,0)
 ;;=4^W55.03XA
 ;;^UTILITY(U,$J,358.3,15895,2)
 ;;=^5060268
 ;;^UTILITY(U,$J,358.3,15896,0)
 ;;=W55.03XD^^61^759^102
 ;;^UTILITY(U,$J,358.3,15896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15896,1,3,0)
 ;;=3^Scratched by Cat,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15896,1,4,0)
 ;;=4^W55.03XD
 ;;^UTILITY(U,$J,358.3,15896,2)
 ;;=^5060269
 ;;^UTILITY(U,$J,358.3,15897,0)
 ;;=X00.8XXA^^61^759^17
 ;;^UTILITY(U,$J,358.3,15897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15897,1,3,0)
 ;;=3^Exp to Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,15897,1,4,0)
 ;;=4^X00.8XXA
 ;;^UTILITY(U,$J,358.3,15897,2)
 ;;=^5060679
 ;;^UTILITY(U,$J,358.3,15898,0)
 ;;=X00.8XXD^^61^759^18
 ;;^UTILITY(U,$J,358.3,15898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15898,1,3,0)
 ;;=3^Exp to Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15898,1,4,0)
 ;;=4^X00.8XXD
 ;;^UTILITY(U,$J,358.3,15898,2)
 ;;=^5060680
 ;;^UTILITY(U,$J,358.3,15899,0)
 ;;=X32.XXXA^^61^759^15
 ;;^UTILITY(U,$J,358.3,15899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15899,1,3,0)
 ;;=3^Exp to Sunlight,Init Encntr
 ;;^UTILITY(U,$J,358.3,15899,1,4,0)
 ;;=4^X32.XXXA
 ;;^UTILITY(U,$J,358.3,15899,2)
 ;;=^5060847
 ;;^UTILITY(U,$J,358.3,15900,0)
 ;;=X32.XXXD^^61^759^16
 ;;^UTILITY(U,$J,358.3,15900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15900,1,3,0)
 ;;=3^Exp to Sunlight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15900,1,4,0)
 ;;=4^X32.XXXD
 ;;^UTILITY(U,$J,358.3,15900,2)
 ;;=^5060848
 ;;^UTILITY(U,$J,358.3,15901,0)
 ;;=Y04.0XXA^^61^759^7
 ;;^UTILITY(U,$J,358.3,15901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15901,1,3,0)
 ;;=3^Assault by Unarmed Fight,Init Encntr
 ;;^UTILITY(U,$J,358.3,15901,1,4,0)
 ;;=4^Y04.0XXA
 ;;^UTILITY(U,$J,358.3,15901,2)
 ;;=^5061165
 ;;^UTILITY(U,$J,358.3,15902,0)
 ;;=Y04.0XXD^^61^759^8
 ;;^UTILITY(U,$J,358.3,15902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15902,1,3,0)
 ;;=3^Assault by Unarmed Fight,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15902,1,4,0)
 ;;=4^Y04.0XXD
