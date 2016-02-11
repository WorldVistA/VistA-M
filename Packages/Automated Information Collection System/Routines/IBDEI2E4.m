IBDEI2E4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40159,1,3,0)
 ;;=3^Injury Ulnar Nerve Right Upper Arm,Init Encntr
 ;;^UTILITY(U,$J,358.3,40159,1,4,0)
 ;;=4^S44.01XA
 ;;^UTILITY(U,$J,358.3,40159,2)
 ;;=^5027939
 ;;^UTILITY(U,$J,358.3,40160,0)
 ;;=S64.01XA^^186^2076^257
 ;;^UTILITY(U,$J,358.3,40160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40160,1,3,0)
 ;;=3^Injury Ulnar Nerve Right Wrist/Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,40160,1,4,0)
 ;;=4^S64.01XA
 ;;^UTILITY(U,$J,358.3,40160,2)
 ;;=^5035763
 ;;^UTILITY(U,$J,358.3,40161,0)
 ;;=S01.322A^^186^2076^261
 ;;^UTILITY(U,$J,358.3,40161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40161,1,3,0)
 ;;=3^Laceration w/ FB Left Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,40161,1,4,0)
 ;;=4^S01.322A
 ;;^UTILITY(U,$J,358.3,40161,2)
 ;;=^5134205
 ;;^UTILITY(U,$J,358.3,40162,0)
 ;;=S51.822A^^186^2076^263
 ;;^UTILITY(U,$J,358.3,40162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40162,1,3,0)
 ;;=3^Laceration w/ FB Left Forearm,Init Encntr
 ;;^UTILITY(U,$J,358.3,40162,1,4,0)
 ;;=4^S51.822A
 ;;^UTILITY(U,$J,358.3,40162,2)
 ;;=^5135026
 ;;^UTILITY(U,$J,358.3,40163,0)
 ;;=S21.122A^^186^2076^264
 ;;^UTILITY(U,$J,358.3,40163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40163,1,3,0)
 ;;=3^Laceration w/ FB Left Front Thorax Wall w/o Penet of Thorax Cavity,Init Encntr
 ;;^UTILITY(U,$J,358.3,40163,1,4,0)
 ;;=4^S21.122A
 ;;^UTILITY(U,$J,358.3,40163,2)
 ;;=^5134289
 ;;^UTILITY(U,$J,358.3,40164,0)
 ;;=S91.122A^^186^2076^265
 ;;^UTILITY(U,$J,358.3,40164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40164,1,3,0)
 ;;=3^Laceration w/ FB Left Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,40164,1,4,0)
 ;;=4^S91.122A
 ;;^UTILITY(U,$J,358.3,40164,2)
 ;;=^5137436
 ;;^UTILITY(U,$J,358.3,40165,0)
 ;;=S61.422A^^186^2076^266
 ;;^UTILITY(U,$J,358.3,40165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40165,1,3,0)
 ;;=3^Laceration w/ FB Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,40165,1,4,0)
 ;;=4^S61.422A
 ;;^UTILITY(U,$J,358.3,40165,2)
 ;;=^5135858
 ;;^UTILITY(U,$J,358.3,40166,0)
 ;;=S61.221A^^186^2076^268
 ;;^UTILITY(U,$J,358.3,40166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40166,1,3,0)
 ;;=3^Laceration w/ FB Left Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,40166,1,4,0)
 ;;=4^S61.221A
 ;;^UTILITY(U,$J,358.3,40166,2)
 ;;=^5135750
 ;;^UTILITY(U,$J,358.3,40167,0)
 ;;=S91.125A^^186^2076^269
 ;;^UTILITY(U,$J,358.3,40167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40167,1,3,0)
 ;;=3^Laceration w/ FB Left Lesser Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,40167,1,4,0)
 ;;=4^S91.125A
 ;;^UTILITY(U,$J,358.3,40167,2)
 ;;=^5137448
 ;;^UTILITY(U,$J,358.3,40168,0)
 ;;=S61.227A^^186^2076^270
 ;;^UTILITY(U,$J,358.3,40168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40168,1,3,0)
 ;;=3^Laceration w/ FB Left Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,40168,1,4,0)
 ;;=4^S61.227A
 ;;^UTILITY(U,$J,358.3,40168,2)
 ;;=^5135759
 ;;^UTILITY(U,$J,358.3,40169,0)
 ;;=S61.223A^^186^2076^271
 ;;^UTILITY(U,$J,358.3,40169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40169,1,3,0)
 ;;=3^Laceration w/ FB Left Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,40169,1,4,0)
 ;;=4^S61.223A
 ;;^UTILITY(U,$J,358.3,40169,2)
 ;;=^5135753
 ;;^UTILITY(U,$J,358.3,40170,0)
 ;;=S61.225A^^186^2076^272
 ;;^UTILITY(U,$J,358.3,40170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40170,1,3,0)
 ;;=3^Laceration w/ FB Left Ring Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,40170,1,4,0)
 ;;=4^S61.225A
 ;;^UTILITY(U,$J,358.3,40170,2)
 ;;=^5135756
 ;;^UTILITY(U,$J,358.3,40171,0)
 ;;=S41.022A^^186^2076^273
