IBDEI02Y ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1008,1,3,0)
 ;;=3^Tinnitus Assessment
 ;;^UTILITY(U,$J,358.3,1009,0)
 ;;=410.01^^13^111^1
 ;;^UTILITY(U,$J,358.3,1009,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1009,1,4,0)
 ;;=4^410.01
 ;;^UTILITY(U,$J,358.3,1009,1,5,0)
 ;;=5^Acute MI, Anterolateral, Initial
 ;;^UTILITY(U,$J,358.3,1009,2)
 ;;=Acute MI, Anterolateral, Initial^269639
 ;;^UTILITY(U,$J,358.3,1010,0)
 ;;=410.02^^13^111^2
 ;;^UTILITY(U,$J,358.3,1010,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1010,1,4,0)
 ;;=4^410.02
 ;;^UTILITY(U,$J,358.3,1010,1,5,0)
 ;;=5^Acute MI Anterolateral, Subsequent
 ;;^UTILITY(U,$J,358.3,1010,2)
 ;;=Acute MI Anterolateral, Subsequent^269640
 ;;^UTILITY(U,$J,358.3,1011,0)
 ;;=410.11^^13^111^3
 ;;^UTILITY(U,$J,358.3,1011,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1011,1,4,0)
 ;;=4^410.11
 ;;^UTILITY(U,$J,358.3,1011,1,5,0)
 ;;=5^Acute MI, Anterior, Initial
 ;;^UTILITY(U,$J,358.3,1011,2)
 ;;=Acute MI, Anterior, Initial^269643
 ;;^UTILITY(U,$J,358.3,1012,0)
 ;;=410.12^^13^111^4
 ;;^UTILITY(U,$J,358.3,1012,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1012,1,4,0)
 ;;=4^410.12
 ;;^UTILITY(U,$J,358.3,1012,1,5,0)
 ;;=5^Acute MI, Anterior, Subsequent
 ;;^UTILITY(U,$J,358.3,1012,2)
 ;;=Acute MI, Anterior, Subsequent^269644
 ;;^UTILITY(U,$J,358.3,1013,0)
 ;;=410.21^^13^111^5
 ;;^UTILITY(U,$J,358.3,1013,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1013,1,4,0)
 ;;=4^410.21
 ;;^UTILITY(U,$J,358.3,1013,1,5,0)
 ;;=5^Acute MI, Inferolateral, Initial
 ;;^UTILITY(U,$J,358.3,1013,2)
 ;;=Acute MI, Inferolateral, Initial^269647
 ;;^UTILITY(U,$J,358.3,1014,0)
 ;;=410.22^^13^111^6
 ;;^UTILITY(U,$J,358.3,1014,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1014,1,4,0)
 ;;=4^410.22
 ;;^UTILITY(U,$J,358.3,1014,1,5,0)
 ;;=5^Acute MI, Inferior, Subsequent
 ;;^UTILITY(U,$J,358.3,1014,2)
 ;;=Acute MI, Inferior, Subsequent^269648
 ;;^UTILITY(U,$J,358.3,1015,0)
 ;;=410.31^^13^111^7
 ;;^UTILITY(U,$J,358.3,1015,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1015,1,4,0)
 ;;=4^410.31
 ;;^UTILITY(U,$J,358.3,1015,1,5,0)
 ;;=5^Acute MI, Inferopostior, Initial
 ;;^UTILITY(U,$J,358.3,1015,2)
 ;;=Acute MI, Inferopostior, Initial^269651
 ;;^UTILITY(U,$J,358.3,1016,0)
 ;;=410.32^^13^111^8
 ;;^UTILITY(U,$J,358.3,1016,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1016,1,4,0)
 ;;=4^410.32
 ;;^UTILITY(U,$J,358.3,1016,1,5,0)
 ;;=5^Acute MI, Inferoposterior, Subsequent
 ;;^UTILITY(U,$J,358.3,1016,2)
 ;;=Acute MI, Inferoposterior, Subsequent^269652
 ;;^UTILITY(U,$J,358.3,1017,0)
 ;;=410.41^^13^111^9
 ;;^UTILITY(U,$J,358.3,1017,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1017,1,4,0)
 ;;=4^410.41
 ;;^UTILITY(U,$J,358.3,1017,1,5,0)
 ;;=5^Acute MI, Inferorposterior, Initial
 ;;^UTILITY(U,$J,358.3,1017,2)
 ;;=Acute MI, Inferorposterior, Initial^269655
 ;;^UTILITY(U,$J,358.3,1018,0)
 ;;=410.42^^13^111^10
 ;;^UTILITY(U,$J,358.3,1018,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1018,1,4,0)
 ;;=4^410.42
 ;;^UTILITY(U,$J,358.3,1018,1,5,0)
 ;;=5^Acute MI Inferior, Subsequent
 ;;^UTILITY(U,$J,358.3,1018,2)
 ;;=Acute MI Inferior, Subsequent^269656
 ;;^UTILITY(U,$J,358.3,1019,0)
 ;;=410.51^^13^111^11
 ;;^UTILITY(U,$J,358.3,1019,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1019,1,4,0)
 ;;=4^410.51
 ;;^UTILITY(U,$J,358.3,1019,1,5,0)
 ;;=5^Acute MI, Lateral, Initial
 ;;^UTILITY(U,$J,358.3,1019,2)
 ;;=Acute MI, Lateral, Initial^269659
 ;;^UTILITY(U,$J,358.3,1020,0)
 ;;=410.52^^13^111^12
 ;;^UTILITY(U,$J,358.3,1020,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1020,1,4,0)
 ;;=4^410.52
 ;;^UTILITY(U,$J,358.3,1020,1,5,0)
 ;;=5^Acute MI, Lateral, Subsequent
