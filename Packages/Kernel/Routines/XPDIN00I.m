XPDIN00I ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,13,40,"AC",1,64)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,13,40,"B",64,64)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,0)
 ;;=14^^1,1^^2
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,1)
 ;;=Page 14
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,40,0)
 ;;=^.4032PI^66^3
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,40,45,0)
 ;;=XPD EDIT BUILD HDR^1^1,1^d
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,40,65,0)
 ;;=XPD EDIT BUILD11^4^1,1^e
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,40,66,0)
 ;;=XPD EDIT BUILD12^2^5,1^e
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,40,66,2)
 ;;=6^^n
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,40,"AC",1,45)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,40,"AC",2,66)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,40,"AC",4,65)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,40,"B",45,45)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,40,"B",65,65)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,14,40,"B",66,66)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,15,0)
 ;;=15^^2,1^^^1^17,79
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,15,1)
 ;;=Install questions
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,15,40,0)
 ;;=^.4032PI^52^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,15,40,52,0)
 ;;=XPD EDIT BUILD7^1^1,1^e
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,15,40,"AC",1,52)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,15,40,"B",52,52)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",2,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",3,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",4,4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",5,5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",6,6)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",7,7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",8,8)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",9,9)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",10,10)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",11,11)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",12,12)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",13,13)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",14,14)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"B",15,15)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","A/B NAMESPACE",10)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","ENTRIES",7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","FILE",4)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","INSTALL QUESTIONS",6)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","INSTALL QUESTIONS",15)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","KERNEL FILE",3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","PACKAGE FILE",8)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","PAGE 1",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","PAGE 13",13)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","PAGE 14",14)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","PAGE 2",2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","PAGE 9",9)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","RECORD MERGE",5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","SUB DD",11)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,40,"C","SUB FIELD",12)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,0,0,"N")
 ;;=6,46^1,46^1,46^6,46^1,46
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,45)
 ;;=0^0^9.6^^d^^^^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,45,2,"D")
 ;;=1^6^30^.01
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,45,4,"D")
 ;;=^^^^2^0^^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46)
 ;;=0^0^9.6^^e^^^^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46,1,"D")
 ;;=5^27^50^.01
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46,1,"N")
 ;;=0^13^13^0^13
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46,5,"D")
 ;;=11^27^8^913
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46,5,"N")
 ;;=11^7^7^11^7
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46,6,"D")
 ;;=15^27^17^914
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46,6,"N")
 ;;=7^0^0^7^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46,7,"D")
 ;;=13^27^17^916
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46,7,"N")
 ;;=5^6^6^5^6
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46,11,"D")
 ;;=9^27^1^3
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46,11,"N")
 ;;=13^5^5^13^5^^^^^^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46,13,"D")
 ;;=7^27^11^.02
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,46,13,"N")
 ;;=1^11^11^1^11
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",1,"FIRST")
 ;;=1,46
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",2,0,0,"N")
 ;;=1,57^1,57^1,57^1,57^1,57
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",2,45)
 ;;=0^0^9.6^^d^^^^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",2,45,2,"D")
 ;;=1^6^30^.01
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",2,45,4,"D")
 ;;=^^^^2^0^^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",2,47)
 ;;=0^0^9.6^^e^^^^0
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",2,57)
 ;;=4^0^9.67^^e^^12^^1^1
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ",2,57,1,"D")
 ;;=5^0^24^.01
