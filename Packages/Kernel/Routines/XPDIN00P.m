XPDIN00P ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"DIST(.404,",48,40,2,2)
 ;;=1,50^26
 ;;^UTILITY(U,$J,"DIST(.404,",48,40,2,3)
 ;;=SEND TO SITE
 ;;^UTILITY(U,$J,"DIST(.404,",48,40,2,4)
 ;;=1
 ;;^UTILITY(U,$J,"DIST(.404,",48,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",48,40,"B",2,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,0)
 ;;=XPD EDIT BUILD4^9.64
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,0)
 ;;=^.4044I^18^7
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,1,0)
 ;;=1^ DD Export Options ^1^
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,1,2)
 ;;=^^1,27^1
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,2,0)
 ;;=2^File^3^
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,2,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,2,2)
 ;;=3,30^45^3,24
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,7,0)
 ;;=7^Data Comes With File...^3^
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,7,1)
 ;;=222.7
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,7,2)
 ;;=12,33^3^12,8
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,7,3)
 ;;=NO
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,7,10)
 ;;=S:X="y" DDSSTACK=13
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,7,13)
 ;;=D:X="y" PUT^DDSVAL(DIE,.DA,222.3,"f","","I")
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,13,0)
 ;;=6^Screen to Determine DD Update^3
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,13,1)
 ;;=223
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,13,2)
 ;;=10,2^76^9,2^1
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,14,0)
 ;;=5^Send Security Code^3
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,14,1)
 ;;=222.2
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,14,2)
 ;;=7,62^3^7,42
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,14,3)
 ;;=YES
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,16,0)
 ;;=4^Update the Data Dictionary^3
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,16,1)
 ;;=222.1
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,16,2)
 ;;=7,30^3^7,2
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,16,3)
 ;;=YES
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,18,0)
 ;;=3^Send Full or Partial DD...^3
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,18,1)
 ;;=222.3
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,18,2)
 ;;=5,33^7^5,5
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,18,3)
 ;;=FULL
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,18,10)
 ;;=S:X="p" DDSSTACK=11
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,18,13)
 ;;=D:X="p" PUT^DDSVAL(DIE,.DA,222.7,"n","","I")
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"B",2,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"B",3,18)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"B",4,16)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"B",5,14)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"B",6,13)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"B",7,7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"C"," DD EXPORT OPTIONS ",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"C","DATA COMES WITH FILE...",7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"C","FILE",2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"C","SCREEN TO DETERMINE DD UPDATE",13)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"C","SEND FULL OR PARTIAL DD...",18)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"C","SEND SECURITY CODE",14)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",49,40,"C","UPDATE THE DATA DICTIONARY",16)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",50,0)
 ;;=XPD EDIT BUILD5^9.402
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,0)
 ;;=^.4044I^4^4
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,1,0)
 ;;=1^ Affects Record Merge ^1^
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,1,2)
 ;;=^^1,23^1
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,2,0)
 ;;=2^File Affected^3^
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,2,1)
 ;;=.01
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,2,2)
 ;;=3,16^45^3,1
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,3,0)
 ;;=3^Name of Merge Routine^3^
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,3,1)
 ;;=3
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,3,2)
 ;;=5,24^8^5,1
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,4,0)
 ;;=4^Record has Package Data^3^
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,4,1)
 ;;=4
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,4,2)
 ;;=10,1^70^8,21^1
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,"B",2,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,"B",3,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,"B",4,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,"C"," AFFECTS RECORD MERGE ",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,"C","FILE AFFECTED",2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,"C","NAME OF MERGE ROUTINE",3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",50,40,"C","RECORD HAS PACKAGE DATA",4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.404,",51,0)
 ;;=XPD EDIT BUILD6^9.4
 ;;^UTILITY(U,$J,"DIST(.404,",51,11)
 ;;=I $G(XPDBR) S DDSBR="COM" K XPDBR
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,0)
 ;;=^.4044I^5^2
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,2,0)
 ;;=2^Select Affects Record Merge^3^
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,2,1)
 ;;=20
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,2,2)
 ;;=5,31^30^5,2
 ;;^UTILITY(U,$J,"DIST(.404,",51,40,2,7)
 ;;=^
