IBDEI0TT ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39210,1,4,0)
 ;;=4^M86.261
 ;;^UTILITY(U,$J,358.3,39210,2)
 ;;=^5014551
 ;;^UTILITY(U,$J,358.3,39211,0)
 ;;=M86.262^^109^1618^40
 ;;^UTILITY(U,$J,358.3,39211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39211,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft tib/fib
 ;;^UTILITY(U,$J,358.3,39211,1,4,0)
 ;;=4^M86.262
 ;;^UTILITY(U,$J,358.3,39211,2)
 ;;=^5014552
 ;;^UTILITY(U,$J,358.3,39212,0)
 ;;=M86.171^^109^1618^11
 ;;^UTILITY(U,$J,358.3,39212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39212,1,3,0)
 ;;=3^Osteomyelitis, acute, rt ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,39212,1,4,0)
 ;;=4^M86.171
 ;;^UTILITY(U,$J,358.3,39212,2)
 ;;=^5014530
 ;;^UTILITY(U,$J,358.3,39213,0)
 ;;=M86.172^^109^1618^1
 ;;^UTILITY(U,$J,358.3,39213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39213,1,3,0)
 ;;=3^Osteomyelitis, acute, lft ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,39213,1,4,0)
 ;;=4^M86.172
 ;;^UTILITY(U,$J,358.3,39213,2)
 ;;=^5014531
 ;;^UTILITY(U,$J,358.3,39214,0)
 ;;=M86.271^^109^1618^43
 ;;^UTILITY(U,$J,358.3,39214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39214,1,3,0)
 ;;=3^Osteomyelitis, subacute, rt ankle & foot
 ;;^UTILITY(U,$J,358.3,39214,1,4,0)
 ;;=4^M86.271
 ;;^UTILITY(U,$J,358.3,39214,2)
 ;;=^5014554
 ;;^UTILITY(U,$J,358.3,39215,0)
 ;;=M86.272^^109^1618^36
 ;;^UTILITY(U,$J,358.3,39215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39215,1,3,0)
 ;;=3^Osteomyelitis, subacute, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,39215,1,4,0)
 ;;=4^M86.272
 ;;^UTILITY(U,$J,358.3,39215,2)
 ;;=^5014555
 ;;^UTILITY(U,$J,358.3,39216,0)
 ;;=M86.18^^109^1618^10
 ;;^UTILITY(U,$J,358.3,39216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39216,1,3,0)
 ;;=3^Osteomyelitis, acute, oth site, oth
 ;;^UTILITY(U,$J,358.3,39216,1,4,0)
 ;;=4^M86.18
 ;;^UTILITY(U,$J,358.3,39216,2)
 ;;=^5014533
 ;;^UTILITY(U,$J,358.3,39217,0)
 ;;=M86.28^^109^1618^42
 ;;^UTILITY(U,$J,358.3,39217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39217,1,3,0)
 ;;=3^Osteomyelitis, subacute, oth site
 ;;^UTILITY(U,$J,358.3,39217,1,4,0)
 ;;=4^M86.28
 ;;^UTILITY(U,$J,358.3,39217,2)
 ;;=^5014557
 ;;^UTILITY(U,$J,358.3,39218,0)
 ;;=M86.19^^109^1618^9
 ;;^UTILITY(U,$J,358.3,39218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39218,1,3,0)
 ;;=3^Osteomyelitis, acute, mult sites, oth
 ;;^UTILITY(U,$J,358.3,39218,1,4,0)
 ;;=4^M86.19
 ;;^UTILITY(U,$J,358.3,39218,2)
 ;;=^5014534
 ;;^UTILITY(U,$J,358.3,39219,0)
 ;;=M86.29^^109^1618^41
 ;;^UTILITY(U,$J,358.3,39219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39219,1,3,0)
 ;;=3^Osteomyelitis, subacute, mult sites
 ;;^UTILITY(U,$J,358.3,39219,1,4,0)
 ;;=4^M86.29
 ;;^UTILITY(U,$J,358.3,39219,2)
 ;;=^5014558
 ;;^UTILITY(U,$J,358.3,39220,0)
 ;;=M86.60^^109^1618^35
 ;;^UTILITY(U,$J,358.3,39220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39220,1,3,0)
 ;;=3^Osteomyelitis, chron, unspec site, oth
 ;;^UTILITY(U,$J,358.3,39220,1,4,0)
 ;;=4^M86.60
 ;;^UTILITY(U,$J,358.3,39220,2)
 ;;=^5014630
 ;;^UTILITY(U,$J,358.3,39221,0)
 ;;=M86.611^^109^1618^32
 ;;^UTILITY(U,$J,358.3,39221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39221,1,3,0)
 ;;=3^Osteomyelitis, chron, rt shldr, oth
 ;;^UTILITY(U,$J,358.3,39221,1,4,0)
 ;;=4^M86.611
 ;;^UTILITY(U,$J,358.3,39221,2)
 ;;=^5014631
 ;;^UTILITY(U,$J,358.3,39222,0)
 ;;=M86.612^^109^1618^23
 ;;^UTILITY(U,$J,358.3,39222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39222,1,3,0)
 ;;=3^Osteomyelitis, chron, lft shldr, oth
 ;;^UTILITY(U,$J,358.3,39222,1,4,0)
 ;;=4^M86.612
 ;;^UTILITY(U,$J,358.3,39222,2)
 ;;=^5014632
 ;;^UTILITY(U,$J,358.3,39223,0)
 ;;=M86.621^^109^1618^30
 ;;^UTILITY(U,$J,358.3,39223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39223,1,3,0)
 ;;=3^Osteomyelitis, chron, rt humerus, oth
 ;;^UTILITY(U,$J,358.3,39223,1,4,0)
 ;;=4^M86.621
 ;;^UTILITY(U,$J,358.3,39223,2)
 ;;=^5014634
 ;;^UTILITY(U,$J,358.3,39224,0)
 ;;=M86.622^^109^1618^21
 ;;^UTILITY(U,$J,358.3,39224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39224,1,3,0)
 ;;=3^Osteomyelitis, chron, lft numerus, oth
 ;;^UTILITY(U,$J,358.3,39224,1,4,0)
 ;;=4^M86.622
 ;;^UTILITY(U,$J,358.3,39224,2)
 ;;=^5134070
 ;;^UTILITY(U,$J,358.3,39225,0)
 ;;=M86.631^^109^1618^31
 ;;^UTILITY(U,$J,358.3,39225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39225,1,3,0)
 ;;=3^Osteomyelitis, chron, rt radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,39225,1,4,0)
 ;;=4^M86.631
 ;;^UTILITY(U,$J,358.3,39225,2)
 ;;=^5014635
 ;;^UTILITY(U,$J,358.3,39226,0)
 ;;=M86.632^^109^1618^22
 ;;^UTILITY(U,$J,358.3,39226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39226,1,3,0)
 ;;=3^Osteomyelitis, chron, lft radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,39226,1,4,0)
 ;;=4^M86.632
 ;;^UTILITY(U,$J,358.3,39226,2)
 ;;=^5134072
 ;;^UTILITY(U,$J,358.3,39227,0)
 ;;=M86.641^^109^1618^29
 ;;^UTILITY(U,$J,358.3,39227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39227,1,3,0)
 ;;=3^Osteomyelitis, chron, rt hand, oth
 ;;^UTILITY(U,$J,358.3,39227,1,4,0)
 ;;=4^M86.641
 ;;^UTILITY(U,$J,358.3,39227,2)
 ;;=^5014636
 ;;^UTILITY(U,$J,358.3,39228,0)
 ;;=M86.642^^109^1618^20
 ;;^UTILITY(U,$J,358.3,39228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39228,1,3,0)
 ;;=3^Osteomyelitis, chron, lft hand, oth
 ;;^UTILITY(U,$J,358.3,39228,1,4,0)
 ;;=4^M86.642
 ;;^UTILITY(U,$J,358.3,39228,2)
 ;;=^5134074
 ;;^UTILITY(U,$J,358.3,39229,0)
 ;;=M86.651^^109^1618^33
 ;;^UTILITY(U,$J,358.3,39229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39229,1,3,0)
 ;;=3^Osteomyelitis, chron, rt thigh, oth
 ;;^UTILITY(U,$J,358.3,39229,1,4,0)
 ;;=4^M86.651
 ;;^UTILITY(U,$J,358.3,39229,2)
 ;;=^5014637
 ;;^UTILITY(U,$J,358.3,39230,0)
 ;;=M86.652^^109^1618^24
 ;;^UTILITY(U,$J,358.3,39230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39230,1,3,0)
 ;;=3^Osteomyelitis, chron, lft thigh, oth
 ;;^UTILITY(U,$J,358.3,39230,1,4,0)
 ;;=4^M86.652
 ;;^UTILITY(U,$J,358.3,39230,2)
 ;;=^5014638
 ;;^UTILITY(U,$J,358.3,39231,0)
 ;;=M86.661^^109^1618^34
 ;;^UTILITY(U,$J,358.3,39231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39231,1,3,0)
 ;;=3^Osteomyelitis, chron, rt tib/fib, oth
 ;;^UTILITY(U,$J,358.3,39231,1,4,0)
 ;;=4^M86.661
 ;;^UTILITY(U,$J,358.3,39231,2)
 ;;=^5014640
 ;;^UTILITY(U,$J,358.3,39232,0)
 ;;=M86.662^^109^1618^25
 ;;^UTILITY(U,$J,358.3,39232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39232,1,3,0)
 ;;=3^Osteomyelitis, chron, lft tib/fib, oth
 ;;^UTILITY(U,$J,358.3,39232,1,4,0)
 ;;=4^M86.662
 ;;^UTILITY(U,$J,358.3,39232,2)
 ;;=^5134076
 ;;^UTILITY(U,$J,358.3,39233,0)
 ;;=M86.671^^109^1618^28
 ;;^UTILITY(U,$J,358.3,39233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39233,1,3,0)
 ;;=3^Osteomyelitis, chron, rt ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,39233,1,4,0)
 ;;=4^M86.671
 ;;^UTILITY(U,$J,358.3,39233,2)
 ;;=^5014641
 ;;^UTILITY(U,$J,358.3,39234,0)
 ;;=M86.672^^109^1618^19
 ;;^UTILITY(U,$J,358.3,39234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39234,1,3,0)
 ;;=3^Osteomyelitis, chron, lft ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,39234,1,4,0)
 ;;=4^M86.672
 ;;^UTILITY(U,$J,358.3,39234,2)
 ;;=^5014642
 ;;^UTILITY(U,$J,358.3,39235,0)
 ;;=M86.68^^109^1618^27
 ;;^UTILITY(U,$J,358.3,39235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39235,1,3,0)
 ;;=3^Osteomyelitis, chron, oth, oth site
 ;;^UTILITY(U,$J,358.3,39235,1,4,0)
 ;;=4^M86.68
 ;;^UTILITY(U,$J,358.3,39235,2)
 ;;=^5014644
 ;;^UTILITY(U,$J,358.3,39236,0)
 ;;=M86.69^^109^1618^26
 ;;^UTILITY(U,$J,358.3,39236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39236,1,3,0)
 ;;=3^Osteomyelitis, chron, mult sites, oth
 ;;^UTILITY(U,$J,358.3,39236,1,4,0)
 ;;=4^M86.69
 ;;^UTILITY(U,$J,358.3,39236,2)
 ;;=^5014645
 ;;^UTILITY(U,$J,358.3,39237,0)
 ;;=M86.9^^109^1618^49
 ;;^UTILITY(U,$J,358.3,39237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39237,1,3,0)
 ;;=3^Osteomyelitis, unspec
 ;;^UTILITY(U,$J,358.3,39237,1,4,0)
 ;;=4^M86.9
 ;;^UTILITY(U,$J,358.3,39237,2)
 ;;=^5014656
 ;;^UTILITY(U,$J,358.3,39238,0)
 ;;=M90.80^^109^1618^66
 ;;^UTILITY(U,$J,358.3,39238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39238,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, unsp site
 ;;^UTILITY(U,$J,358.3,39238,1,4,0)
 ;;=4^M90.80
 ;;^UTILITY(U,$J,358.3,39238,2)
 ;;=^5015168
 ;;^UTILITY(U,$J,358.3,39239,0)
 ;;=M90.811^^109^1618^63
 ;;^UTILITY(U,$J,358.3,39239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39239,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, rt shldr
 ;;^UTILITY(U,$J,358.3,39239,1,4,0)
 ;;=4^M90.811
 ;;^UTILITY(U,$J,358.3,39239,2)
 ;;=^5015169
 ;;^UTILITY(U,$J,358.3,39240,0)
 ;;=M90.812^^109^1618^54
 ;;^UTILITY(U,$J,358.3,39240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39240,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, lft shldr
 ;;^UTILITY(U,$J,358.3,39240,1,4,0)
 ;;=4^M90.812
 ;;^UTILITY(U,$J,358.3,39240,2)
 ;;=^5015170
 ;;^UTILITY(U,$J,358.3,39241,0)
 ;;=M90.821^^109^1618^65
 ;;^UTILITY(U,$J,358.3,39241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39241,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, rt upper arm
 ;;^UTILITY(U,$J,358.3,39241,1,4,0)
 ;;=4^M90.821
 ;;^UTILITY(U,$J,358.3,39241,2)
 ;;=^5015172
 ;;^UTILITY(U,$J,358.3,39242,0)
 ;;=M90.822^^109^1618^56
 ;;^UTILITY(U,$J,358.3,39242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39242,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, lft upper arm
 ;;^UTILITY(U,$J,358.3,39242,1,4,0)
 ;;=4^M90.822
 ;;^UTILITY(U,$J,358.3,39242,2)
 ;;=^5015173
 ;;^UTILITY(U,$J,358.3,39243,0)
 ;;=M90.831^^109^1618^60
 ;;^UTILITY(U,$J,358.3,39243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39243,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, rt forearm
 ;;^UTILITY(U,$J,358.3,39243,1,4,0)
 ;;=4^M90.831
 ;;^UTILITY(U,$J,358.3,39243,2)
 ;;=^5015175
 ;;^UTILITY(U,$J,358.3,39244,0)
 ;;=M90.832^^109^1618^51
 ;;^UTILITY(U,$J,358.3,39244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39244,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, lft forearm
 ;;^UTILITY(U,$J,358.3,39244,1,4,0)
 ;;=4^M90.832
 ;;^UTILITY(U,$J,358.3,39244,2)
 ;;=^5015176
 ;;^UTILITY(U,$J,358.3,39245,0)
 ;;=M90.841^^109^1618^61
