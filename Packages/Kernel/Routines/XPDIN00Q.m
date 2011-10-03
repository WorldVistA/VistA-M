XPDIN00Q ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,2,10)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,5,0)
 ;;=1^Primary Help Frame^3
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,5,1)
 ;;=12
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,5,2)
 ;;=3,31^30^3,11
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,"B",1,5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,"B",2,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,"C","AFFECTS RECORD MERGE",2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,"C","PRIMARY HELP FRAME",5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,0)
 ;;=XPD EDIT BUILD7^9.62
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,0)
 ;;=^.4044I^10^10
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,1,0)
 ;;=2^Name^3^
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,1,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,1,2)
 ;;=2,12^30^2,6
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,2,0)
 ;;=3^DIR(0)^3^
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,2,1)
 ;;=1
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,2,2)
 ;;=4,12^65^4,4
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,3,0)
 ;;=4^DIR(A)^3^
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,3,1)
 ;;=2
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,3,2)
 ;;=6,12^65^6,4
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,4,0)
 ;;=5^DIR(A,#)^3^
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,4,1)
 ;;=3
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,4,2)
 ;;=7,12^1^7,2
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,5,0)
 ;;=6^DIR(B)^3^
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,5,1)
 ;;=4
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,5,2)
 ;;=9,12^65^9,4
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,6,0)
 ;;=7^DIR(?)^3^
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,6,1)
 ;;=5
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,6,2)
 ;;=11,12^65^11,4
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,7,0)
 ;;=8^DIR(?,#)^3^
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,7,1)
 ;;=6
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,7,2)
 ;;=12,12^1^12,2
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,8,0)
 ;;=9^DIR(??)^3^
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,8,1)
 ;;=7
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,8,2)
 ;;=13,12^64^13,3
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,9,0)
 ;;=10^M Code^3
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,9,1)
 ;;=10
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,9,2)
 ;;=15,12^65^15,4
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,10,0)
 ;;=1^ Install Questions ^1^
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,10,2)
 ;;=^^1,27^1
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"B",1,10)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"B",2,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"B",3,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"B",4,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"B",5,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"B",6,5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"B",7,6)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"B",8,7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"B",9,8)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"B",10,9)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"C"," INSTALL QUESTIONS ",10)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"C","DIR(0)",2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"C","DIR(?)",6)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"C","DIR(?,#)",7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"C","DIR(??)",8)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"C","DIR(A)",3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"C","DIR(A,#)",4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"C","DIR(B)",5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"C","M CODE",9)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",52,40,"C","NAME",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",53,0)
 ;;=XPD EDIT BUILD31^9.67
 ;;^UTILITY(U,$J,"DIST(.404,",53,40,0)
 ;;=^.4044I^1^1
 ;;^UTILITY(U,$J,"DIST(.404,",53,40,1,0)
 ;;=1^!M^1^
 ;;^UTILITY(U,$J,"DIST(.404,",53,40,1,.1)
 ;;=S Y=" "_$P($G(^DIC(D1,0)),U)_" "
 ;;^UTILITY(U,$J,"DIST(.404,",53,40,1,2)
 ;;=^^1,27^
 ;;^UTILITY(U,$J,"DIST(.404,",53,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",54,0)
 ;;=XPD EDIT BUILD8^9.6
 ;;^UTILITY(U,$J,"DIST(.404,",54,11)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",54,40,0)
 ;;=^.4044I^1^1
 ;;^UTILITY(U,$J,"DIST(.404,",54,40,1,0)
 ;;=1^Alpha/Beta Testing...^3
 ;;^UTILITY(U,$J,"DIST(.404,",54,40,1,1)
 ;;=20
 ;;^UTILITY(U,$J,"DIST(.404,",54,40,1,2)
 ;;=2,31^3^2,8
 ;;^UTILITY(U,$J,"DIST(.404,",54,40,1,3)
 ;;=NO
 ;;^UTILITY(U,$J,"DIST(.404,",54,40,1,10)
 ;;=S:X="y" DDSSTACK="9"
 ;;^UTILITY(U,$J,"DIST(.404,",54,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",54,40,"C","ALPHA/BETA TESTING...",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",55,0)
 ;;=XPD EDIT BUILD9^9.6
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,0)
 ;;=^.4044I^5^4
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,1,0)
 ;;=2^Installation Message^3
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,1,1)
 ;;=21
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,1,2)
 ;;=3,30^3^3,8
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,1,3)
 ;;=NO
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,2,0)
 ;;=3^Address for Usage Reporting^3
 ;;^UTILITY(U,$J,"DIST(.404,",55,40,2,1)
 ;;=22
