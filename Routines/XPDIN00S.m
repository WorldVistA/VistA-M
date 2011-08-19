XPDIN00S ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,2,1)
 ;;=222.8
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,2,2)
 ;;=3,21^15^3,8
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,2,3)
 ;;=OVERWRITE
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,3,0)
 ;;=5^Data List^3
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,3,1)
 ;;=222.6
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,3,2)
 ;;=7,21^30^7,10
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,4,0)
 ;;=3^Resolve Pointers^3
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,4,1)
 ;;=222.5
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,4,2)
 ;;=5,21^3^5,3
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,4,3)
 ;;=NO
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,5,0)
 ;;=4^May User Override Data Update^3
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,5,1)
 ;;=222.9
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,5,2)
 ;;=5,68^3^5,37
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,5,3)
 ;;=NO
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,7,0)
 ;;=6^Screen to Select Data^3
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,7,1)
 ;;=224
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,7,2)
 ;;=10,3^72^9,3^1
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,"B",2,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,"B",3,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,"B",4,5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,"B",5,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,"B",6,7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,"C"," DATA EXPORT OPTIONS ",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,"C","DATA LIST",3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,"C","MAY USER OVERRIDE DATA UPDATE",5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,"C","RESOLVE POINTERS",4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,"C","SCREEN TO SELECT DATA",7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",64,40,"C","SITE'S DATA",2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",65,0)
 ;;=XPD EDIT BUILD11^9.6
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,0)
 ;;=^.4044I^4^4
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,1,0)
 ;;=1^4^1^
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,1,2)
 ;;=^^1,71^
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,2,0)
 ;;=3^Package File Link...^3
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,2,1)
 ;;=1
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,2,2)
 ;;=15,27^30^15,5
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,2,10)
 ;;=S:X]"" DDSSTACK=8
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,3,0)
 ;;=4^Track Package Nationally^3
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,3,1)
 ;;=5
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,3,2)
 ;;=17,27^3^17,1
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,3,3)
 ;;=NO
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,3,10)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,3,11)
 ;;=S:$$GET^DDSVAL(DIE,.DA,1)="" DDSBR="^^COM"
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,4,0)
 ;;=2^Install Questions^1^
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,4,2)
 ;;=^^4,28^1
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,"B",2,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,"B",3,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,"B",4,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,"C",4,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,"C","INSTALL QUESTIONS",4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,"C","PACKAGE FILE LINK...",2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",65,40,"C","TRACK PACKAGE NATIONALLY",3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",66,0)
 ;;=XPD EDIT BUILD12^9.62
 ;;^UTILITY(U,$J,"DIST(.404,",66,40,0)
 ;;=^.4044I^1^1
 ;;^UTILITY(U,$J,"DIST(.404,",66,40,1,0)
 ;;=1^^3
 ;;^UTILITY(U,$J,"DIST(.404,",66,40,1,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",66,40,1,2)
 ;;=2,3^30
 ;;^UTILITY(U,$J,"DIST(.404,",66,40,1,10)
 ;;=S DDSSTACK=15
 ;;^UTILITY(U,$J,"DIST(.404,",66,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",67,0)
 ;;=XPD EDIT BUILD60^9.6
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,0)
 ;;=^.4044I^3^3
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,1,0)
 ;;=1^ Edit PACKAGE File ^1^
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,1,2)
 ;;=^^1,26^1
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,2,0)
 ;;=2^Name^3
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,2,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,2,2)
 ;;=2,8^30^2,2
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,3,0)
 ;;=3^!M^1^
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,3,.1)
 ;;=S $P(Y,"-",76)=""
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,3,2)
 ;;=^^3,1^
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,"B",2,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,"B",3,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,"C"," EDIT PACKAGE FILE ",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",67,40,"C","NAME",2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",84,0)
 ;;=XPD EDIT BUILD9A^9.66
 ;;^UTILITY(U,$J,"DIST(.404,",84,40,0)
 ;;=^.4044I^1^1
 ;;^UTILITY(U,$J,"DIST(.404,",84,40,1,0)
 ;;=1^^3
 ;;^UTILITY(U,$J,"DIST(.404,",84,40,1,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",84,40,1,2)
 ;;=2,2^4
 ;;^UTILITY(U,$J,"DIST(.404,",84,40,1,10)
 ;;=S DDSSTACK=10
