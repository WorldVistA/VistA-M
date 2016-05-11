IBDEI1X3 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32527,0)
 ;;=L40.4^^126^1617^18
 ;;^UTILITY(U,$J,358.3,32527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32527,1,3,0)
 ;;=3^Psoriasis,Guttate
 ;;^UTILITY(U,$J,358.3,32527,1,4,0)
 ;;=4^L40.4
 ;;^UTILITY(U,$J,358.3,32527,2)
 ;;=^5009164
 ;;^UTILITY(U,$J,358.3,32528,0)
 ;;=M72.2^^126^1617^9
 ;;^UTILITY(U,$J,358.3,32528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32528,1,3,0)
 ;;=3^Plantar fascial fibromatosis
 ;;^UTILITY(U,$J,358.3,32528,1,4,0)
 ;;=4^M72.2
 ;;^UTILITY(U,$J,358.3,32528,2)
 ;;=^272598
 ;;^UTILITY(U,$J,358.3,32529,0)
 ;;=M15.9^^126^1617^10
 ;;^UTILITY(U,$J,358.3,32529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32529,1,3,0)
 ;;=3^Polyosteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,32529,1,4,0)
 ;;=4^M15.9
 ;;^UTILITY(U,$J,358.3,32529,2)
 ;;=^5010768
 ;;^UTILITY(U,$J,358.3,32530,0)
 ;;=I87.002^^126^1617^13
 ;;^UTILITY(U,$J,358.3,32530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32530,1,3,0)
 ;;=3^Postthrom syndr w/o compl of lft lwr extrem
 ;;^UTILITY(U,$J,358.3,32530,1,4,0)
 ;;=4^I87.002
 ;;^UTILITY(U,$J,358.3,32530,2)
 ;;=^5008028
 ;;^UTILITY(U,$J,358.3,32531,0)
 ;;=I73.9^^126^1617^2
 ;;^UTILITY(U,$J,358.3,32531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32531,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,32531,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,32531,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,32532,0)
 ;;=M06.372^^126^1618^12
 ;;^UTILITY(U,$J,358.3,32532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32532,1,3,0)
 ;;=3^Rheumatoid nodule, left Ankle/Foot
 ;;^UTILITY(U,$J,358.3,32532,1,4,0)
 ;;=4^M06.372
 ;;^UTILITY(U,$J,358.3,32532,2)
 ;;=^5010116
 ;;^UTILITY(U,$J,358.3,32533,0)
 ;;=M06.371^^126^1618^13
 ;;^UTILITY(U,$J,358.3,32533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32533,1,3,0)
 ;;=3^Rheumatoid nodule, right Ankle/Foot
 ;;^UTILITY(U,$J,358.3,32533,1,4,0)
 ;;=4^M06.371
 ;;^UTILITY(U,$J,358.3,32533,2)
 ;;=^5010115
 ;;^UTILITY(U,$J,358.3,32534,0)
 ;;=M05.59^^126^1618^8
 ;;^UTILITY(U,$J,358.3,32534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32534,1,3,0)
 ;;=3^Rheum polyneuropathy w/ rheum arthr mult site
 ;;^UTILITY(U,$J,358.3,32534,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,32534,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,32535,0)
 ;;=M05.572^^126^1618^7
 ;;^UTILITY(U,$J,358.3,32535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32535,1,3,0)
 ;;=3^Rheum polyneuropathy w/ rheum arthr lft ank/ft
 ;;^UTILITY(U,$J,358.3,32535,1,4,0)
 ;;=4^M05.572
 ;;^UTILITY(U,$J,358.3,32535,2)
 ;;=^5009974
 ;;^UTILITY(U,$J,358.3,32536,0)
 ;;=M05.571^^126^1618^9
 ;;^UTILITY(U,$J,358.3,32536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32536,1,3,0)
 ;;=3^Rheum polyneuropathy w/ rheum arthr rt ank/ft
 ;;^UTILITY(U,$J,358.3,32536,1,4,0)
 ;;=4^M05.571
 ;;^UTILITY(U,$J,358.3,32536,2)
 ;;=^5009973
 ;;^UTILITY(U,$J,358.3,32537,0)
 ;;=M05.471^^126^1618^6
 ;;^UTILITY(U,$J,358.3,32537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32537,1,3,0)
 ;;=3^Rheum myopathy w/ rheum arthr rt ank/ft
 ;;^UTILITY(U,$J,358.3,32537,1,4,0)
 ;;=4^M05.471
 ;;^UTILITY(U,$J,358.3,32537,2)
 ;;=^5009950
 ;;^UTILITY(U,$J,358.3,32538,0)
 ;;=M05.472^^126^1618^5
 ;;^UTILITY(U,$J,358.3,32538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32538,1,3,0)
 ;;=3^Rheum myopathy w/ rheum arthr lft ank/ft
 ;;^UTILITY(U,$J,358.3,32538,1,4,0)
 ;;=4^M05.472
 ;;^UTILITY(U,$J,358.3,32538,2)
 ;;=^5009951
 ;;^UTILITY(U,$J,358.3,32539,0)
 ;;=G90.523^^126^1618^1
 ;;^UTILITY(U,$J,358.3,32539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32539,1,3,0)
 ;;=3^Regional Pain Syndrome,Bliateral Lower Limbs,Complex
