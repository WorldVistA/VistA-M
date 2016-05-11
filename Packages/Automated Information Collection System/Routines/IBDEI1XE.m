IBDEI1XE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32662,1,4,0)
 ;;=4^I83.224
 ;;^UTILITY(U,$J,358.3,32662,2)
 ;;=^5008007
 ;;^UTILITY(U,$J,358.3,32663,0)
 ;;=I83.225^^126^1622^7
 ;;^UTILITY(U,$J,358.3,32663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32663,1,3,0)
 ;;=3^Varicose veins lft lwr extrem w/ ulc oth prt ft & inflam
 ;;^UTILITY(U,$J,358.3,32663,1,4,0)
 ;;=4^I83.225
 ;;^UTILITY(U,$J,358.3,32663,2)
 ;;=^5008008
 ;;^UTILITY(U,$J,358.3,32664,0)
 ;;=B07.9^^126^1622^23
 ;;^UTILITY(U,$J,358.3,32664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32664,1,3,0)
 ;;=3^Viral wart, unspecified
 ;;^UTILITY(U,$J,358.3,32664,1,4,0)
 ;;=4^B07.9
 ;;^UTILITY(U,$J,358.3,32664,2)
 ;;=^5000519
 ;;^UTILITY(U,$J,358.3,32665,0)
 ;;=I87.2^^126^1622^22
 ;;^UTILITY(U,$J,358.3,32665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32665,1,3,0)
 ;;=3^Venous insufficiency (chronic) (peripheral)
 ;;^UTILITY(U,$J,358.3,32665,1,4,0)
 ;;=4^I87.2
 ;;^UTILITY(U,$J,358.3,32665,2)
 ;;=^5008047
 ;;^UTILITY(U,$J,358.3,32666,0)
 ;;=I87.9^^126^1622^21
 ;;^UTILITY(U,$J,358.3,32666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32666,1,3,0)
 ;;=3^Vein Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,32666,1,4,0)
 ;;=4^I87.9
 ;;^UTILITY(U,$J,358.3,32666,2)
 ;;=^5008069
 ;;^UTILITY(U,$J,358.3,32667,0)
 ;;=Q66.2^^126^1622^20
 ;;^UTILITY(U,$J,358.3,32667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32667,1,3,0)
 ;;=3^Varus,Metatarsus,Congenital
 ;;^UTILITY(U,$J,358.3,32667,1,4,0)
 ;;=4^Q66.2
 ;;^UTILITY(U,$J,358.3,32667,2)
 ;;=^5018863
 ;;^UTILITY(U,$J,358.3,32668,0)
 ;;=S91.001A^^126^1623^7
 ;;^UTILITY(U,$J,358.3,32668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32668,1,3,0)
 ;;=3^Open wound, rt ankl, unspec, init enc
 ;;^UTILITY(U,$J,358.3,32668,1,4,0)
 ;;=4^S91.001A
 ;;^UTILITY(U,$J,358.3,32668,2)
 ;;=^5044129
 ;;^UTILITY(U,$J,358.3,32669,0)
 ;;=S91.002A^^126^1623^1
 ;;^UTILITY(U,$J,358.3,32669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32669,1,3,0)
 ;;=3^Open wound, lft ankl, unspec, init enc
 ;;^UTILITY(U,$J,358.3,32669,1,4,0)
 ;;=4^S91.002A
 ;;^UTILITY(U,$J,358.3,32669,2)
 ;;=^5044132
 ;;^UTILITY(U,$J,358.3,32670,0)
 ;;=S91.301A^^126^1623^8
 ;;^UTILITY(U,$J,358.3,32670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32670,1,3,0)
 ;;=3^Open wound, rt foot, unspec, init enc
 ;;^UTILITY(U,$J,358.3,32670,1,4,0)
 ;;=4^S91.301A
 ;;^UTILITY(U,$J,358.3,32670,2)
 ;;=^5044314
 ;;^UTILITY(U,$J,358.3,32671,0)
 ;;=S91.302A^^126^1623^2
 ;;^UTILITY(U,$J,358.3,32671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32671,1,3,0)
 ;;=3^Open wound, lft foot, unspec, init enc
 ;;^UTILITY(U,$J,358.3,32671,1,4,0)
 ;;=4^S91.302A
 ;;^UTILITY(U,$J,358.3,32671,2)
 ;;=^5044317
 ;;^UTILITY(U,$J,358.3,32672,0)
 ;;=S91.101A^^126^1623^10
 ;;^UTILITY(U,$J,358.3,32672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32672,1,3,0)
 ;;=3^Open wound, rt grt toe w/o nail dmg, unspec, init enc
 ;;^UTILITY(U,$J,358.3,32672,1,4,0)
 ;;=4^S91.101A
 ;;^UTILITY(U,$J,358.3,32672,2)
 ;;=^5044168
 ;;^UTILITY(U,$J,358.3,32673,0)
 ;;=S91.102A^^126^1623^4
 ;;^UTILITY(U,$J,358.3,32673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32673,1,3,0)
 ;;=3^Open wound, lft grt toe w/o nail dmg, unspec, init enc
 ;;^UTILITY(U,$J,358.3,32673,1,4,0)
 ;;=4^S91.102A
 ;;^UTILITY(U,$J,358.3,32673,2)
 ;;=^5044171
 ;;^UTILITY(U,$J,358.3,32674,0)
 ;;=S91.104A^^126^1623^12
 ;;^UTILITY(U,$J,358.3,32674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32674,1,3,0)
 ;;=3^Open wound, rt lsr toe(s) w/o nail dmg, unspec, init enc
 ;;^UTILITY(U,$J,358.3,32674,1,4,0)
 ;;=4^S91.104A
 ;;^UTILITY(U,$J,358.3,32674,2)
 ;;=^5044174
 ;;^UTILITY(U,$J,358.3,32675,0)
 ;;=S91.105A^^126^1623^6
