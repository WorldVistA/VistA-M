IBDEI10R ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17291,0)
 ;;=G81.92^^73^832^9
 ;;^UTILITY(U,$J,358.3,17291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17291,1,3,0)
 ;;=3^Hemiplegia affecting lft dominant side, unspec
 ;;^UTILITY(U,$J,358.3,17291,1,4,0)
 ;;=4^G81.92
 ;;^UTILITY(U,$J,358.3,17291,2)
 ;;=^5004122
 ;;^UTILITY(U,$J,358.3,17292,0)
 ;;=G81.93^^73^832^12
 ;;^UTILITY(U,$J,358.3,17292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17292,1,3,0)
 ;;=3^Hemiplegia affecting rt nondom side, unspec
 ;;^UTILITY(U,$J,358.3,17292,1,4,0)
 ;;=4^G81.93
 ;;^UTILITY(U,$J,358.3,17292,2)
 ;;=^5004123
 ;;^UTILITY(U,$J,358.3,17293,0)
 ;;=G81.94^^73^832^10
 ;;^UTILITY(U,$J,358.3,17293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17293,1,3,0)
 ;;=3^Hemiplegia affecting lft nondom side, unspec
 ;;^UTILITY(U,$J,358.3,17293,1,4,0)
 ;;=4^G81.94
 ;;^UTILITY(U,$J,358.3,17293,2)
 ;;=^5004124
 ;;^UTILITY(U,$J,358.3,17294,0)
 ;;=H91.90^^73^832^7
 ;;^UTILITY(U,$J,358.3,17294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17294,1,3,0)
 ;;=3^Hearing loss, unspec ear, unspec
 ;;^UTILITY(U,$J,358.3,17294,1,4,0)
 ;;=4^H91.90
 ;;^UTILITY(U,$J,358.3,17294,2)
 ;;=^5006943
 ;;^UTILITY(U,$J,358.3,17295,0)
 ;;=I10.^^73^832^27
 ;;^UTILITY(U,$J,358.3,17295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17295,1,3,0)
 ;;=3^Hypertension, essential (primary)
 ;;^UTILITY(U,$J,358.3,17295,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,17295,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,17296,0)
 ;;=K64.8^^73^832^15
 ;;^UTILITY(U,$J,358.3,17296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17296,1,3,0)
 ;;=3^Hemorrhoids, oth
 ;;^UTILITY(U,$J,358.3,17296,1,4,0)
 ;;=4^K64.8
 ;;^UTILITY(U,$J,358.3,17296,2)
 ;;=^5008774
 ;;^UTILITY(U,$J,358.3,17297,0)
 ;;=K64.4^^73^832^14
 ;;^UTILITY(U,$J,358.3,17297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17297,1,3,0)
 ;;=3^Hemorrhoidal Skin Tags,Residual
 ;;^UTILITY(U,$J,358.3,17297,1,4,0)
 ;;=4^K64.4
 ;;^UTILITY(U,$J,358.3,17297,2)
 ;;=^269834
 ;;^UTILITY(U,$J,358.3,17298,0)
 ;;=I95.9^^73^832^33
 ;;^UTILITY(U,$J,358.3,17298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17298,1,3,0)
 ;;=3^Hypotension, unspec
 ;;^UTILITY(U,$J,358.3,17298,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,17298,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,17299,0)
 ;;=K40.90^^73^832^37
 ;;^UTILITY(U,$J,358.3,17299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17299,1,3,0)
 ;;=3^Uniltrl Ing hernia, w/o obst/ganr, not spcf as recur
 ;;^UTILITY(U,$J,358.3,17299,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,17299,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,17300,0)
 ;;=K40.20^^73^832^4
 ;;^UTILITY(U,$J,358.3,17300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17300,1,3,0)
 ;;=3^Biltrl Ing hernia, w/o obst/ganr, not spcf as recur
 ;;^UTILITY(U,$J,358.3,17300,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,17300,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,17301,0)
 ;;=K42.9^^73^832^36
 ;;^UTILITY(U,$J,358.3,17301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17301,1,3,0)
 ;;=3^Umbilical hernia w/o obst/gangr or gangrene
 ;;^UTILITY(U,$J,358.3,17301,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,17301,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,17302,0)
 ;;=K43.2^^73^832^35
 ;;^UTILITY(U,$J,358.3,17302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17302,1,3,0)
 ;;=3^Incisional hernia w/o obstr/gangr
 ;;^UTILITY(U,$J,358.3,17302,1,4,0)
 ;;=4^K43.2
 ;;^UTILITY(U,$J,358.3,17302,2)
 ;;=^5008609
 ;;^UTILITY(U,$J,358.3,17303,0)
 ;;=K44.9^^73^832^5
 ;;^UTILITY(U,$J,358.3,17303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17303,1,3,0)
 ;;=3^Diaphragmatic hernia w/o obstr/gangr
 ;;^UTILITY(U,$J,358.3,17303,1,4,0)
 ;;=4^K44.9
