IBDEI0IC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8232,1,3,0)
 ;;=3^Hepatomegaly, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,8232,1,4,0)
 ;;=4^R16.0
 ;;^UTILITY(U,$J,358.3,8232,2)
 ;;=^5019248
 ;;^UTILITY(U,$J,358.3,8233,0)
 ;;=R16.1^^55^536^94
 ;;^UTILITY(U,$J,358.3,8233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8233,1,3,0)
 ;;=3^Splenomegaly, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,8233,1,4,0)
 ;;=4^R16.1
 ;;^UTILITY(U,$J,358.3,8233,2)
 ;;=^5019249
 ;;^UTILITY(U,$J,358.3,8234,0)
 ;;=R19.00^^55^536^65
 ;;^UTILITY(U,$J,358.3,8234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8234,1,3,0)
 ;;=3^Intra-abd and pelvic swelling, mass and lump, unsp site
 ;;^UTILITY(U,$J,358.3,8234,1,4,0)
 ;;=4^R19.00
 ;;^UTILITY(U,$J,358.3,8234,2)
 ;;=^5019254
 ;;^UTILITY(U,$J,358.3,8235,0)
 ;;=R10.811^^55^536^91
 ;;^UTILITY(U,$J,358.3,8235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8235,1,3,0)
 ;;=3^Right upper quadrant abdominal tenderness
 ;;^UTILITY(U,$J,358.3,8235,1,4,0)
 ;;=4^R10.811
 ;;^UTILITY(U,$J,358.3,8235,2)
 ;;=^5019214
 ;;^UTILITY(U,$J,358.3,8236,0)
 ;;=R10.821^^55^536^93
 ;;^UTILITY(U,$J,358.3,8236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8236,1,3,0)
 ;;=3^Right upper quadrant rebound abdominal tenderness
 ;;^UTILITY(U,$J,358.3,8236,1,4,0)
 ;;=4^R10.821
 ;;^UTILITY(U,$J,358.3,8236,2)
 ;;=^5019221
 ;;^UTILITY(U,$J,358.3,8237,0)
 ;;=R10.812^^55^536^71
 ;;^UTILITY(U,$J,358.3,8237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8237,1,3,0)
 ;;=3^Left upper quadrant abdominal tenderness
 ;;^UTILITY(U,$J,358.3,8237,1,4,0)
 ;;=4^R10.812
 ;;^UTILITY(U,$J,358.3,8237,2)
 ;;=^5019215
 ;;^UTILITY(U,$J,358.3,8238,0)
 ;;=R10.822^^55^536^73
 ;;^UTILITY(U,$J,358.3,8238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8238,1,3,0)
 ;;=3^Left upper quadrant rebound abdominal tenderness
 ;;^UTILITY(U,$J,358.3,8238,1,4,0)
 ;;=4^R10.822
 ;;^UTILITY(U,$J,358.3,8238,2)
 ;;=^5019222
 ;;^UTILITY(U,$J,358.3,8239,0)
 ;;=R10.813^^55^536^88
 ;;^UTILITY(U,$J,358.3,8239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8239,1,3,0)
 ;;=3^Right lower quadrant abdominal tenderness
 ;;^UTILITY(U,$J,358.3,8239,1,4,0)
 ;;=4^R10.813
 ;;^UTILITY(U,$J,358.3,8239,2)
 ;;=^5019216
 ;;^UTILITY(U,$J,358.3,8240,0)
 ;;=R10.823^^55^536^90
 ;;^UTILITY(U,$J,358.3,8240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8240,1,3,0)
 ;;=3^Right lower quadrant rebound abdominal tenderness
 ;;^UTILITY(U,$J,358.3,8240,1,4,0)
 ;;=4^R10.823
 ;;^UTILITY(U,$J,358.3,8240,2)
 ;;=^5019223
 ;;^UTILITY(U,$J,358.3,8241,0)
 ;;=R10.814^^55^536^68
 ;;^UTILITY(U,$J,358.3,8241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8241,1,3,0)
 ;;=3^Left lower quadrant abdominal tenderness
 ;;^UTILITY(U,$J,358.3,8241,1,4,0)
 ;;=4^R10.814
 ;;^UTILITY(U,$J,358.3,8241,2)
 ;;=^5134173
 ;;^UTILITY(U,$J,358.3,8242,0)
 ;;=R10.824^^55^536^70
 ;;^UTILITY(U,$J,358.3,8242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8242,1,3,0)
 ;;=3^Left lower quadrant rebound abdominal tenderness
 ;;^UTILITY(U,$J,358.3,8242,1,4,0)
 ;;=4^R10.824
 ;;^UTILITY(U,$J,358.3,8242,2)
 ;;=^5134174
 ;;^UTILITY(U,$J,358.3,8243,0)
 ;;=R10.815^^55^536^79
 ;;^UTILITY(U,$J,358.3,8243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8243,1,3,0)
 ;;=3^Periumbilic abdominal tenderness
 ;;^UTILITY(U,$J,358.3,8243,1,4,0)
 ;;=4^R10.815
 ;;^UTILITY(U,$J,358.3,8243,2)
 ;;=^5019217
 ;;^UTILITY(U,$J,358.3,8244,0)
 ;;=R10.825^^55^536^80
 ;;^UTILITY(U,$J,358.3,8244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8244,1,3,0)
 ;;=3^Periumbilic rebound abdominal tenderness
 ;;^UTILITY(U,$J,358.3,8244,1,4,0)
 ;;=4^R10.825
