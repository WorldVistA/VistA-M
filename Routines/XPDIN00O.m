XPDIN00O ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",15,6,3)
 ;;=DIR(A):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",15,7,1)
 ;;=DIR(A,#):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",15,9,3)
 ;;=DIR(B):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",15,11,3)
 ;;=DIR(?):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",15,12,1)
 ;;=DIR(?,#):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",15,13,2)
 ;;=DIR(??):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",15,15,3)
 ;;=M Code:
 ;;^UTILITY(U,$J,"DIST(.404,",45,0)
 ;;=XPD EDIT BUILD HDR^9.6
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,0)
 ;;=^.4044I^4^4
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,1,0)
 ;;=1^Edit a Build^1^
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,1,2)
 ;;=^^1,28^
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,2,0)
 ;;=2^Name^3^
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,2,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,2,2)
 ;;=2,7^30^2,1
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,2,4)
 ;;=^^^1
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,3,0)
 ;;=3^PAGE   OF 4^1^
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,3,2)
 ;;=^^1,66^
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,4,0)
 ;;=4^!M^1^
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,4,.1)
 ;;=S $P(Y,"-",80)=""
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,4,2)
 ;;=^^3,1^
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,"B",2,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,"B",3,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,"B",4,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,"C","EDIT A BUILD",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,"C","NAME",2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",45,40,"C","PAGE   OF 4",3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,0)
 ;;=XPD EDIT BUILD1^9.6
 ;;^UTILITY(U,$J,"DIST(.404,",46,12)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,0)
 ;;=^.4044I^13^7
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,1,0)
 ;;=2^Name^3^
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,1,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,1,2)
 ;;=6,28^50^6,22
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,5,0)
 ;;=5^Environment Check Routine^3^
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,5,1)
 ;;=913
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,5,2)
 ;;=12,28^8^12,1
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,6,0)
 ;;=7^Post-Install Routine^3^
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,6,1)
 ;;=914
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,6,2)
 ;;=16,28^17^16,6
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,7,0)
 ;;=6^Pre-Install Routine^3^
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,7,1)
 ;;=916
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,7,2)
 ;;=14,28^17^14,7
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,11,0)
 ;;=4^Description^3^
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,11,1)
 ;;=3
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,11,2)
 ;;=10,28^1^10,15
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,12,0)
 ;;=1^1^1^
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,12,2)
 ;;=^^1,71^
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,13,0)
 ;;=3^Date Distributed^3
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,13,1)
 ;;=.02
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,13,2)
 ;;=8,28^11^8,10
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"B",1,12)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"B",2,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"B",3,13)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"B",4,11)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"B",5,5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"B",6,7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"B",7,6)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"C",1,12)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"C","DATE DISTRIBUTED",13)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"C","DESCRIPTION",11)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"C","ENVIRONMENT CHECK ROUTINE",5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"C","NAME",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"C","POST-INSTALL ROUTINE",6)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",46,40,"C","PRE-INSTALL ROUTINE",7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",47,0)
 ;;=XPD EDIT BUILD2^9.6
 ;;^UTILITY(U,$J,"DIST(.404,",47,12)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",47,40,0)
 ;;=^.4044I^2^2
 ;;^UTILITY(U,$J,"DIST(.404,",47,40,1,0)
 ;;=99^3^1^
 ;;^UTILITY(U,$J,"DIST(.404,",47,40,1,2)
 ;;=^^1,71^
 ;;^UTILITY(U,$J,"DIST(.404,",47,40,2,0)
 ;;=2^Build Components^1^
 ;;^UTILITY(U,$J,"DIST(.404,",47,40,2,2)
 ;;=^^4,28^1
 ;;^UTILITY(U,$J,"DIST(.404,",47,40,"B",2,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",47,40,"B",99,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",47,40,"C",3,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",47,40,"C","BUILD COMPONENTS",2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",48,0)
 ;;=XPD EDIT BUILD3^9.68
 ;;^UTILITY(U,$J,"DIST(.404,",48,40,0)
 ;;=^.4044I^2^2
 ;;^UTILITY(U,$J,"DIST(.404,",48,40,1,0)
 ;;=1^^3^
 ;;^UTILITY(U,$J,"DIST(.404,",48,40,1,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",48,40,1,2)
 ;;=1,2^45
 ;;^UTILITY(U,$J,"DIST(.404,",48,40,2,0)
 ;;=2^^3
 ;;^UTILITY(U,$J,"DIST(.404,",48,40,2,1)
 ;;=.03
