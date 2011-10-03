XPDIN00R ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,2,2)
 ;;=5,30^44^5,1
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,4,0)
 ;;=1^ Alpha/Beta Testing ^1^
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,4,2)
 ;;=^^1,26^1
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,5,0)
 ;;=4^Package Namespace or Prefix:^1
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,5,2)
 ;;=^^7,1
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,"B",1,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,"B",2,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,"B",3,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,"B",4,5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,"C"," ALPHA/BETA TESTING ",4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,"C","ADDRESS FOR USAGE REPORTING",2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,"C","INSTALLATION MESSAGE",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,"C","PACKAGE NAMESPACE OR PREFIX:",5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",56,0)
 ;;=XPD EDIT BUILD10^9.66
 ;;^UTILITY(U,$J,"DIST(.404,",56,40,0)
 ;;=^.4044I^1^1
 ;;^UTILITY(U,$J,"DIST(.404,",56,40,1,0)
 ;;=1^ Exclude Namespace or Prefix ^1
 ;;^UTILITY(U,$J,"DIST(.404,",56,40,1,2)
 ;;=^^1,20^1
 ;;^UTILITY(U,$J,"DIST(.404,",56,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",56,40,"C"," EXCLUDE NAMESPACE OR PREFIX ",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",57,0)
 ;;=XPD EDIT BUILD30^9.67
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,0)
 ;;=^.4044I^2^2
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,1,0)
 ;;=1^^3
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,1,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,1,2)
 ;;=2,1^24
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,1,4)
 ;;=^^^2
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,1,10)
 ;;=S DDSSTACK=3
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,1,14)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,2,0)
 ;;=2^^4
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,2,2)
 ;;=2,27^5
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,2,4)
 ;;=^^1
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,2,30)
 ;;=S Y="("_+$P($G(^XPD(9.6,DA(1),"KRN",DA,"NM",0)),U,4)_")"
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",57,40,"B",2,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",58,0)
 ;;=XPD EDIT BUILD40^9.64
 ;;^UTILITY(U,$J,"DIST(.404,",58,40,0)
 ;;=^.4044I^1^1
 ;;^UTILITY(U,$J,"DIST(.404,",58,40,1,0)
 ;;=1^^3
 ;;^UTILITY(U,$J,"DIST(.404,",58,40,1,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",58,40,1,2)
 ;;=2,7^45
 ;;^UTILITY(U,$J,"DIST(.404,",58,40,1,10)
 ;;=S DDSSTACK=7
 ;;^UTILITY(U,$J,"DIST(.404,",58,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",59,0)
 ;;=XPD EDIT BUILD41^9.6
 ;;^UTILITY(U,$J,"DIST(.404,",59,40,0)
 ;;=^.4044I^3^2
 ;;^UTILITY(U,$J,"DIST(.404,",59,40,1,0)
 ;;=1^2^1^
 ;;^UTILITY(U,$J,"DIST(.404,",59,40,1,2)
 ;;=^^1,71^
 ;;^UTILITY(U,$J,"DIST(.404,",59,40,3,0)
 ;;=2^File List  (Name or Number)^1
 ;;^UTILITY(U,$J,"DIST(.404,",59,40,3,2)
 ;;=^^4,28^1
 ;;^UTILITY(U,$J,"DIST(.404,",59,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",59,40,"B",2,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",59,40,"C",2,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",59,40,"C","FILE LIST  (NAME OR NUMBER)",3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",60,0)
 ;;=XPD EDIT BUILD42^9.641
 ;;^UTILITY(U,$J,"DIST(.404,",60,40,0)
 ;;=^.4044I^1^1
 ;;^UTILITY(U,$J,"DIST(.404,",60,40,1,0)
 ;;=1^^3
 ;;^UTILITY(U,$J,"DIST(.404,",60,40,1,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",60,40,1,2)
 ;;=1,1^45
 ;;^UTILITY(U,$J,"DIST(.404,",60,40,1,10)
 ;;=S DDSSTACK=12
 ;;^UTILITY(U,$J,"DIST(.404,",60,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",61,0)
 ;;=XPD EDIT BUILD43^9.6411
 ;;^UTILITY(U,$J,"DIST(.404,",61,40,0)
 ;;=^.4044I^1^1
 ;;^UTILITY(U,$J,"DIST(.404,",61,40,1,0)
 ;;=1^^3
 ;;^UTILITY(U,$J,"DIST(.404,",61,40,1,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",61,40,1,2)
 ;;=1,1^45
 ;;^UTILITY(U,$J,"DIST(.404,",61,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",62,0)
 ;;=XPD EDIT BUILD44^9.64
 ;;^UTILITY(U,$J,"DIST(.404,",62,40,0)
 ;;=^.4044I^1^1
 ;;^UTILITY(U,$J,"DIST(.404,",62,40,1,0)
 ;;=1^ Data Dictionary Number ^1^
 ;;^UTILITY(U,$J,"DIST(.404,",62,40,1,2)
 ;;=^^1,24^1
 ;;^UTILITY(U,$J,"DIST(.404,",62,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",62,40,"C"," DATA DICTIONARY NUMBER ",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",63,0)
 ;;=XPD EDIT BUILD45^9.641
 ;;^UTILITY(U,$J,"DIST(.404,",63,40,0)
 ;;=^.4044I^1^1
 ;;^UTILITY(U,$J,"DIST(.404,",63,40,1,0)
 ;;=1^ Field Number ^1^
 ;;^UTILITY(U,$J,"DIST(.404,",63,40,1,2)
 ;;=^^1,24^1
 ;;^UTILITY(U,$J,"DIST(.404,",63,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",63,40,"C"," FIELD NUMBER ",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",64,0)
 ;;=XPD EDIT BUILD46^9.64
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,0)
 ;;=^.4044I^7^6
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,1,0)
 ;;=1^ Data Export Options ^1^
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,1,2)
 ;;=^^1,29^1
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,2,0)
 ;;=2^Site's Data^3
