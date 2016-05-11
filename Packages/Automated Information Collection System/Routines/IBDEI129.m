IBDEI129 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18021,1,2,0)
 ;;=2^Perc Angioplasty,Brachioceph Trunk/Bran
 ;;^UTILITY(U,$J,358.3,18021,1,4,0)
 ;;=4^35475
 ;;^UTILITY(U,$J,358.3,18022,0)
 ;;=36011^^77^863^43^^^^1
 ;;^UTILITY(U,$J,358.3,18022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18022,1,2,0)
 ;;=2^Select Cath Venous 1st Order
 ;;^UTILITY(U,$J,358.3,18022,1,4,0)
 ;;=4^36011
 ;;^UTILITY(U,$J,358.3,18023,0)
 ;;=36246^^77^863^40^^^^1
 ;;^UTILITY(U,$J,358.3,18023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18023,1,2,0)
 ;;=2^Select Cath 2nd Order Abd/Pelv/Le Artery
 ;;^UTILITY(U,$J,358.3,18023,1,4,0)
 ;;=4^36246
 ;;^UTILITY(U,$J,358.3,18024,0)
 ;;=36215^^77^863^42^^^^1
 ;;^UTILITY(U,$J,358.3,18024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18024,1,2,0)
 ;;=2^Select Cath Arterial 1st Order Thor/Brac
 ;;^UTILITY(U,$J,358.3,18024,1,4,0)
 ;;=4^36215
 ;;^UTILITY(U,$J,358.3,18025,0)
 ;;=36245^^77^863^39^^^^1
 ;;^UTILITY(U,$J,358.3,18025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18025,1,2,0)
 ;;=2^Select Cath 1st Order Abd/Pelv/Le Artery
 ;;^UTILITY(U,$J,358.3,18025,1,4,0)
 ;;=4^36245
 ;;^UTILITY(U,$J,358.3,18026,0)
 ;;=36247^^77^863^41^^^^1
 ;;^UTILITY(U,$J,358.3,18026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18026,1,2,0)
 ;;=2^Select Cath 3rd Order Abd/Pelv/Le Artery
 ;;^UTILITY(U,$J,358.3,18026,1,4,0)
 ;;=4^36247
 ;;^UTILITY(U,$J,358.3,18027,0)
 ;;=36251^^77^863^38^^^^1
 ;;^UTILITY(U,$J,358.3,18027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18027,1,2,0)
 ;;=2^Select Cath 1st Main Ren&Access Art
 ;;^UTILITY(U,$J,358.3,18027,1,4,0)
 ;;=4^36251
 ;;^UTILITY(U,$J,358.3,18028,0)
 ;;=36252^^77^863^37^^^^1
 ;;^UTILITY(U,$J,358.3,18028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18028,1,2,0)
 ;;=2^Select Cath 1st Main Ren&Acc Art,Bilat
 ;;^UTILITY(U,$J,358.3,18028,1,4,0)
 ;;=4^36252
 ;;^UTILITY(U,$J,358.3,18029,0)
 ;;=36254^^77^863^48^^^^1
 ;;^UTILITY(U,$J,358.3,18029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18029,1,2,0)
 ;;=2^Superselect Cath Ren Art&Access Art,Bilateral
 ;;^UTILITY(U,$J,358.3,18029,1,4,0)
 ;;=4^36254
 ;;^UTILITY(U,$J,358.3,18030,0)
 ;;=37191^^77^863^31^^^^1
 ;;^UTILITY(U,$J,358.3,18030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18030,1,2,0)
 ;;=2^Insert Intravas Vena Cava Filter,Endovas
 ;;^UTILITY(U,$J,358.3,18030,1,4,0)
 ;;=4^37191
 ;;^UTILITY(U,$J,358.3,18031,0)
 ;;=37220^^77^863^30^^^^1
 ;;^UTILITY(U,$J,358.3,18031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18031,1,2,0)
 ;;=2^Iliac Revasc,Unilat,1st Vessel
 ;;^UTILITY(U,$J,358.3,18031,1,4,0)
 ;;=4^37220
 ;;^UTILITY(U,$J,358.3,18032,0)
 ;;=37221^^77^863^27^^^^1
 ;;^UTILITY(U,$J,358.3,18032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18032,1,2,0)
 ;;=2^Iliac Revasc w/ Stent
 ;;^UTILITY(U,$J,358.3,18032,1,4,0)
 ;;=4^37221
 ;;^UTILITY(U,$J,358.3,18033,0)
 ;;=37223^^77^863^28^^^^1
 ;;^UTILITY(U,$J,358.3,18033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18033,1,2,0)
 ;;=2^Iliac Revasc w/ Stent,Add-on
 ;;^UTILITY(U,$J,358.3,18033,1,4,0)
 ;;=4^37223
 ;;^UTILITY(U,$J,358.3,18034,0)
 ;;=37222^^77^863^29^^^^1
 ;;^UTILITY(U,$J,358.3,18034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18034,1,2,0)
 ;;=2^Iliac Revasc,Ea Addl Vessel
 ;;^UTILITY(U,$J,358.3,18034,1,4,0)
 ;;=4^37222
 ;;^UTILITY(U,$J,358.3,18035,0)
 ;;=37224^^77^863^24^^^^1
 ;;^UTILITY(U,$J,358.3,18035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18035,1,2,0)
 ;;=2^Fem/Popl Revas w/ TLA 1st Vessel
 ;;^UTILITY(U,$J,358.3,18035,1,4,0)
 ;;=4^37224
 ;;^UTILITY(U,$J,358.3,18036,0)
 ;;=37225^^77^863^23^^^^1
 ;;^UTILITY(U,$J,358.3,18036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18036,1,2,0)
 ;;=2^Fem/Popl Revas w/ Ather
