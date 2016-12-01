IBDEI0PD ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32156,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,32156,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,32157,0)
 ;;=R20.3^^94^1413^13
 ;;^UTILITY(U,$J,358.3,32157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32157,1,3,0)
 ;;=3^Hyperesthesia
 ;;^UTILITY(U,$J,358.3,32157,1,4,0)
 ;;=4^R20.3
 ;;^UTILITY(U,$J,358.3,32157,2)
 ;;=^60011
 ;;^UTILITY(U,$J,358.3,32158,0)
 ;;=G47.00^^94^1413^14
 ;;^UTILITY(U,$J,358.3,32158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32158,1,3,0)
 ;;=3^Insomnia, unspecified
 ;;^UTILITY(U,$J,358.3,32158,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,32158,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,32159,0)
 ;;=G43.909^^94^1413^16
 ;;^UTILITY(U,$J,358.3,32159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32159,1,3,0)
 ;;=3^Migraine, unsp, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,32159,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,32159,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,32160,0)
 ;;=M79.2^^94^1413^20
 ;;^UTILITY(U,$J,358.3,32160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32160,1,3,0)
 ;;=3^Neuralgia and neuritis, unspecified
 ;;^UTILITY(U,$J,358.3,32160,1,4,0)
 ;;=4^M79.2
 ;;^UTILITY(U,$J,358.3,32160,2)
 ;;=^5013322
 ;;^UTILITY(U,$J,358.3,32161,0)
 ;;=E66.9^^94^1413^22
 ;;^UTILITY(U,$J,358.3,32161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32161,1,3,0)
 ;;=3^Obesity, unspecified
 ;;^UTILITY(U,$J,358.3,32161,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,32161,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,32162,0)
 ;;=M72.2^^94^1413^30
 ;;^UTILITY(U,$J,358.3,32162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32162,1,3,0)
 ;;=3^Plantar fascial fibromatosis
 ;;^UTILITY(U,$J,358.3,32162,1,4,0)
 ;;=4^M72.2
 ;;^UTILITY(U,$J,358.3,32162,2)
 ;;=^272598
 ;;^UTILITY(U,$J,358.3,32163,0)
 ;;=R20.9^^94^1413^33
 ;;^UTILITY(U,$J,358.3,32163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32163,1,3,0)
 ;;=3^Skin sensation disturbances,unspec
 ;;^UTILITY(U,$J,358.3,32163,1,4,0)
 ;;=4^R20.9
 ;;^UTILITY(U,$J,358.3,32163,2)
 ;;=^5019282
 ;;^UTILITY(U,$J,358.3,32164,0)
 ;;=G82.50^^94^1413^31
 ;;^UTILITY(U,$J,358.3,32164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32164,1,3,0)
 ;;=3^Quadriplegia, unspecified
 ;;^UTILITY(U,$J,358.3,32164,1,4,0)
 ;;=4^G82.50
 ;;^UTILITY(U,$J,358.3,32164,2)
 ;;=^5004128
 ;;^UTILITY(U,$J,358.3,32165,0)
 ;;=G47.9^^94^1413^34
 ;;^UTILITY(U,$J,358.3,32165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32165,1,3,0)
 ;;=3^Sleep disorder, unspecified
 ;;^UTILITY(U,$J,358.3,32165,1,4,0)
 ;;=4^G47.9
 ;;^UTILITY(U,$J,358.3,32165,2)
 ;;=^5003990
 ;;^UTILITY(U,$J,358.3,32166,0)
 ;;=G44.209^^94^1413^35
 ;;^UTILITY(U,$J,358.3,32166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32166,1,3,0)
 ;;=3^Tension-type headache, unspecified, not intractable
 ;;^UTILITY(U,$J,358.3,32166,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,32166,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,32167,0)
 ;;=R32.^^94^1413^40
 ;;^UTILITY(U,$J,358.3,32167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32167,1,3,0)
 ;;=3^Urinary incontinence,unspec
 ;;^UTILITY(U,$J,358.3,32167,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,32167,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,32168,0)
 ;;=R53.1^^94^1413^41
 ;;^UTILITY(U,$J,358.3,32168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32168,1,3,0)
 ;;=3^Weakness
 ;;^UTILITY(U,$J,358.3,32168,1,4,0)
 ;;=4^R53.1
 ;;^UTILITY(U,$J,358.3,32168,2)
 ;;=^5019516
 ;;^UTILITY(U,$J,358.3,32169,0)
 ;;=Z47.1^^94^1414^1
 ;;^UTILITY(U,$J,358.3,32169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32169,1,3,0)
 ;;=3^Aftercare following joint replacement surgery
 ;;^UTILITY(U,$J,358.3,32169,1,4,0)
 ;;=4^Z47.1
 ;;^UTILITY(U,$J,358.3,32169,2)
 ;;=^5063025
 ;;^UTILITY(U,$J,358.3,32170,0)
 ;;=Z96.662^^94^1414^2
 ;;^UTILITY(U,$J,358.3,32170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32170,1,3,0)
 ;;=3^Presence of left artificial ankle joint
 ;;^UTILITY(U,$J,358.3,32170,1,4,0)
 ;;=4^Z96.662
 ;;^UTILITY(U,$J,358.3,32170,2)
 ;;=^5063710
 ;;^UTILITY(U,$J,358.3,32171,0)
 ;;=Z96.622^^94^1414^3
 ;;^UTILITY(U,$J,358.3,32171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32171,1,3,0)
 ;;=3^Presence of left artificial elbow joint
 ;;^UTILITY(U,$J,358.3,32171,1,4,0)
 ;;=4^Z96.622
 ;;^UTILITY(U,$J,358.3,32171,2)
 ;;=^5063696
 ;;^UTILITY(U,$J,358.3,32172,0)
 ;;=Z96.642^^94^1414^4
 ;;^UTILITY(U,$J,358.3,32172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32172,1,3,0)
 ;;=3^Presence of left artificial hip joint
 ;;^UTILITY(U,$J,358.3,32172,1,4,0)
 ;;=4^Z96.642
 ;;^UTILITY(U,$J,358.3,32172,2)
 ;;=^5063702
 ;;^UTILITY(U,$J,358.3,32173,0)
 ;;=Z96.652^^94^1414^5
 ;;^UTILITY(U,$J,358.3,32173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32173,1,3,0)
 ;;=3^Presence of left artificial knee joint
 ;;^UTILITY(U,$J,358.3,32173,1,4,0)
 ;;=4^Z96.652
 ;;^UTILITY(U,$J,358.3,32173,2)
 ;;=^5063706
 ;;^UTILITY(U,$J,358.3,32174,0)
 ;;=Z96.612^^94^1414^6
 ;;^UTILITY(U,$J,358.3,32174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32174,1,3,0)
 ;;=3^Presence of left artificial shoulder joint
 ;;^UTILITY(U,$J,358.3,32174,1,4,0)
 ;;=4^Z96.612
 ;;^UTILITY(U,$J,358.3,32174,2)
 ;;=^5063693
 ;;^UTILITY(U,$J,358.3,32175,0)
 ;;=Z96.632^^94^1414^7
 ;;^UTILITY(U,$J,358.3,32175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32175,1,3,0)
 ;;=3^Presence of left artificial wrist joint
 ;;^UTILITY(U,$J,358.3,32175,1,4,0)
 ;;=4^Z96.632
 ;;^UTILITY(U,$J,358.3,32175,2)
 ;;=^5063699
 ;;^UTILITY(U,$J,358.3,32176,0)
 ;;=Z96.60^^94^1414^14
 ;;^UTILITY(U,$J,358.3,32176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32176,1,3,0)
 ;;=3^Presence of unspecified orthopedic joint implant
 ;;^UTILITY(U,$J,358.3,32176,1,4,0)
 ;;=4^Z96.60
 ;;^UTILITY(U,$J,358.3,32176,2)
 ;;=^5063691
 ;;^UTILITY(U,$J,358.3,32177,0)
 ;;=Z96.661^^94^1414^8
 ;;^UTILITY(U,$J,358.3,32177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32177,1,3,0)
 ;;=3^Presence of right artificial ankle joint
 ;;^UTILITY(U,$J,358.3,32177,1,4,0)
 ;;=4^Z96.661
 ;;^UTILITY(U,$J,358.3,32177,2)
 ;;=^5063709
 ;;^UTILITY(U,$J,358.3,32178,0)
 ;;=Z96.621^^94^1414^9
 ;;^UTILITY(U,$J,358.3,32178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32178,1,3,0)
 ;;=3^Presence of right artificial elbow joint
 ;;^UTILITY(U,$J,358.3,32178,1,4,0)
 ;;=4^Z96.621
 ;;^UTILITY(U,$J,358.3,32178,2)
 ;;=^5063695
 ;;^UTILITY(U,$J,358.3,32179,0)
 ;;=Z96.641^^94^1414^10
 ;;^UTILITY(U,$J,358.3,32179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32179,1,3,0)
 ;;=3^Presence of right artificial hip joint
 ;;^UTILITY(U,$J,358.3,32179,1,4,0)
 ;;=4^Z96.641
 ;;^UTILITY(U,$J,358.3,32179,2)
 ;;=^5063701
 ;;^UTILITY(U,$J,358.3,32180,0)
 ;;=Z96.651^^94^1414^11
 ;;^UTILITY(U,$J,358.3,32180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32180,1,3,0)
 ;;=3^Presence of right artificial knee joint
 ;;^UTILITY(U,$J,358.3,32180,1,4,0)
 ;;=4^Z96.651
 ;;^UTILITY(U,$J,358.3,32180,2)
 ;;=^5063705
 ;;^UTILITY(U,$J,358.3,32181,0)
 ;;=Z96.611^^94^1414^12
 ;;^UTILITY(U,$J,358.3,32181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32181,1,3,0)
 ;;=3^Presence of right artificial shoulder joint
 ;;^UTILITY(U,$J,358.3,32181,1,4,0)
 ;;=4^Z96.611
 ;;^UTILITY(U,$J,358.3,32181,2)
 ;;=^5063692
 ;;^UTILITY(U,$J,358.3,32182,0)
 ;;=Z96.631^^94^1414^13
 ;;^UTILITY(U,$J,358.3,32182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32182,1,3,0)
 ;;=3^Presence of right artificial wrist joint
 ;;^UTILITY(U,$J,358.3,32182,1,4,0)
 ;;=4^Z96.631
 ;;^UTILITY(U,$J,358.3,32182,2)
 ;;=^5063698
 ;;^UTILITY(U,$J,358.3,32183,0)
 ;;=M05.772^^94^1415^1
 ;;^UTILITY(U,$J,358.3,32183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32183,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left ank/ft w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32183,1,4,0)
 ;;=4^M05.772
 ;;^UTILITY(U,$J,358.3,32183,2)
 ;;=^5010020
 ;;^UTILITY(U,$J,358.3,32184,0)
 ;;=M05.722^^94^1415^2
 ;;^UTILITY(U,$J,358.3,32184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32184,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left elbow w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32184,1,4,0)
 ;;=4^M05.722
 ;;^UTILITY(U,$J,358.3,32184,2)
 ;;=^5010005
 ;;^UTILITY(U,$J,358.3,32185,0)
 ;;=M05.742^^94^1415^3
 ;;^UTILITY(U,$J,358.3,32185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32185,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left hand w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32185,1,4,0)
 ;;=4^M05.742
 ;;^UTILITY(U,$J,358.3,32185,2)
 ;;=^5010011
 ;;^UTILITY(U,$J,358.3,32186,0)
 ;;=M05.752^^94^1415^4
 ;;^UTILITY(U,$J,358.3,32186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32186,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left hip w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32186,1,4,0)
 ;;=4^M05.752
 ;;^UTILITY(U,$J,358.3,32186,2)
 ;;=^5010014
 ;;^UTILITY(U,$J,358.3,32187,0)
 ;;=M05.752^^94^1415^5
 ;;^UTILITY(U,$J,358.3,32187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32187,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left hip w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32187,1,4,0)
 ;;=4^M05.752
 ;;^UTILITY(U,$J,358.3,32187,2)
 ;;=^5010014
 ;;^UTILITY(U,$J,358.3,32188,0)
 ;;=M05.762^^94^1415^6
 ;;^UTILITY(U,$J,358.3,32188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32188,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left knee w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32188,1,4,0)
 ;;=4^M05.762
 ;;^UTILITY(U,$J,358.3,32188,2)
 ;;=^5010017
 ;;^UTILITY(U,$J,358.3,32189,0)
 ;;=M05.712^^94^1415^7
 ;;^UTILITY(U,$J,358.3,32189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32189,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left shoulder w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32189,1,4,0)
 ;;=4^M05.712
 ;;^UTILITY(U,$J,358.3,32189,2)
 ;;=^5010002
 ;;^UTILITY(U,$J,358.3,32190,0)
 ;;=M05.732^^94^1415^8
 ;;^UTILITY(U,$J,358.3,32190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32190,1,3,0)
 ;;=3^Rheu arthritis w rheu factor of left wrist w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,32190,1,4,0)
 ;;=4^M05.732
 ;;^UTILITY(U,$J,358.3,32190,2)
 ;;=^5010008
