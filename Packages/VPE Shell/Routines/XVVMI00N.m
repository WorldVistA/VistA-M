XVVMI00N ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY",1,966,4,"N")
 ;;=3^0^0^3^0
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY",1,"FIRST")
 ;;=1,966
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","CAP","INITIALS",1,1,966,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","CAP","NAME",1,1,966,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","CAP","ROUTINE VERSIONING PROMPT",1,1,966,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","CAP","VPE ID",1,1,966,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","F19200.111",.01,"L",1,966,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","F19200.111",2,"L",1,966,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","F19200.111",3,"L",1,966,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","F19200.111",4,"L",1,966,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","X",1,0,33)
 ;;=Edit PERSON                       Page 1 of 1
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","X",1,1,0)
 ;;=------------------------------------------------------------------------------
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","X",1,3,22)
 ;;=NAME:
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","X",1,3,22,"A")
 ;;=1;4;U
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","X",1,4,18)
 ;;=INITIALS:
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","X",1,5,20)
 ;;=VPE ID:
 ;;^UTILITY(U,$J,"DIST(.403,",252,"AY","X",1,6,1)
 ;;=ROUTINE VERSIONING PROMPT:
 ;;^UTILITY(U,$J,"DIST(.404,",715,0)
 ;;=XVVM PGM EDIT HD^19200.113^
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,0)
 ;;=^.4044I^3^3
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,1,0)
 ;;=1^EDIT PROGRAM CALL^1
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,1,2)
 ;;=^^1,32
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,2,0)
 ;;=2^Page 1 of 1^1
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,2,2)
 ;;=^^1,68
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,3,0)
 ;;=3^-------------------------------------------------------------------------------^1
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,3,2)
 ;;=^^2,1
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,"B",2,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,"B",3,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,"C","---------------------------------------------------------------",3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,"C","EDIT PROGRAM CALL",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",715,40,"C","PAGE 1 OF 1",2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",716,0)
 ;;=XVVM PGM EDIT EDT^19200.113
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,0)
 ;;=^.4044I^19^19
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,1,0)
 ;;=1^NAME^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,1,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,1,2)
 ;;=2,15^30^2,9
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,2,0)
 ;;=2^ACTIVE^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,2,1)
 ;;=2
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,2,2)
 ;;=2,58^2^2,50
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,3,0)
 ;;=5^IDENTIFIER^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,3,1)
 ;;=3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,3,2)
 ;;=5,15^20^5,3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,4,0)
 ;;=4^TYPE^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,4,1)
 ;;=4
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,4,2)
 ;;=4,58^9^4,52
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,5,0)
 ;;=3^DESCRIPTION^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,5,1)
 ;;=5
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,5,2)
 ;;=4,15^30^4,2
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,6,0)
 ;;=6^ROUTINE^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,6,1)
 ;;=20
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,6,2)
 ;;=5,58^20^5,49
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,7,0)
 ;;=7^PARAM 1^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,7,1)
 ;;=21
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,7,2)
 ;;=7,15^25^7,6
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,8,0)
 ;;=8^PARAM 2^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,8,1)
 ;;=22
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,8,2)
 ;;=7,54^25^7,45
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,9,0)
 ;;=9^PARAM 3^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,9,1)
 ;;=23
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,9,2)
 ;;=8,15^25^8,6
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,10,0)
 ;;=10^PARAM 4^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,10,1)
 ;;=24
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,10,2)
 ;;=8,54^25^8,45
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,11,0)
 ;;=11^PARAM 5^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,11,1)
 ;;=25
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,11,2)
 ;;=9,15^25^9,6
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,12,0)
 ;;=12^PARAM 6^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,12,1)
 ;;=26
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,12,2)
 ;;=9,54^25^9,45
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,13,0)
 ;;=13^PARAM 7^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,13,1)
 ;;=27
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,13,2)
 ;;=10,15^25^10,6
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,14,0)
 ;;=14^PARAM 8^3
 ;;^UTILITY(U,$J,"DIST(.404,",716,40,14,1)
 ;;=28
