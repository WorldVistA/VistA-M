IBDEI0EF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6296,2)
 ;;=^5021542
 ;;^UTILITY(U,$J,358.3,6297,0)
 ;;=S01.03XA^^40^388^64
 ;;^UTILITY(U,$J,358.3,6297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6297,1,3,0)
 ;;=3^Puncture Wound w/o FB of Scalp,Init Encntr
 ;;^UTILITY(U,$J,358.3,6297,1,4,0)
 ;;=4^S01.03XA
 ;;^UTILITY(U,$J,358.3,6297,2)
 ;;=^5020042
 ;;^UTILITY(U,$J,358.3,6298,0)
 ;;=S01.331A^^40^388^40
 ;;^UTILITY(U,$J,358.3,6298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6298,1,3,0)
 ;;=3^Puncture Wound w/o FB of Right Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,6298,1,4,0)
 ;;=4^S01.331A
 ;;^UTILITY(U,$J,358.3,6298,2)
 ;;=^5020126
 ;;^UTILITY(U,$J,358.3,6299,0)
 ;;=S01.332A^^40^388^8
 ;;^UTILITY(U,$J,358.3,6299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6299,1,3,0)
 ;;=3^Puncture Wound w/o FB of Left Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,6299,1,4,0)
 ;;=4^S01.332A
 ;;^UTILITY(U,$J,358.3,6299,2)
 ;;=^5020129
 ;;^UTILITY(U,$J,358.3,6300,0)
 ;;=S01.23XA^^40^388^34
 ;;^UTILITY(U,$J,358.3,6300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6300,1,3,0)
 ;;=3^Puncture Wound w/o FB of Nose,Init Encntr
 ;;^UTILITY(U,$J,358.3,6300,1,4,0)
 ;;=4^S01.23XA
 ;;^UTILITY(U,$J,358.3,6300,2)
 ;;=^5020099
 ;;^UTILITY(U,$J,358.3,6301,0)
 ;;=S01.432A^^40^388^7
 ;;^UTILITY(U,$J,358.3,6301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6301,1,3,0)
 ;;=3^Puncture Wound w/o FB of Left Cheek/TMJ Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,6301,1,4,0)
 ;;=4^S01.432A
 ;;^UTILITY(U,$J,358.3,6301,2)
 ;;=^5020168
 ;;^UTILITY(U,$J,358.3,6302,0)
 ;;=S01.431A^^40^388^39
 ;;^UTILITY(U,$J,358.3,6302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6302,1,3,0)
 ;;=3^Puncture Wound w/o FB of Right Cheek/TMJ Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,6302,1,4,0)
 ;;=4^S01.431A
 ;;^UTILITY(U,$J,358.3,6302,2)
 ;;=^5020165
 ;;^UTILITY(U,$J,358.3,6303,0)
 ;;=S01.83XA^^40^388^1
 ;;^UTILITY(U,$J,358.3,6303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6303,1,3,0)
 ;;=3^Puncture Wound w/o FB of Head,Oth Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,6303,1,4,0)
 ;;=4^S01.83XA
 ;;^UTILITY(U,$J,358.3,6303,2)
 ;;=^5020231
 ;;^UTILITY(U,$J,358.3,6304,0)
 ;;=S01.93XA^^40^388^2
 ;;^UTILITY(U,$J,358.3,6304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6304,1,3,0)
 ;;=3^Puncture Wound w/o FB of Head,Unspec Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,6304,1,4,0)
 ;;=4^S01.93XA
 ;;^UTILITY(U,$J,358.3,6304,2)
 ;;=^5020246
 ;;^UTILITY(U,$J,358.3,6305,0)
 ;;=S11.83XA^^40^388^32
 ;;^UTILITY(U,$J,358.3,6305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6305,1,3,0)
 ;;=3^Puncture Wound w/o FB of Neck,Oth Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,6305,1,4,0)
 ;;=4^S11.83XA
 ;;^UTILITY(U,$J,358.3,6305,2)
 ;;=^5021515
 ;;^UTILITY(U,$J,358.3,6306,0)
 ;;=S11.93XA^^40^388^33
 ;;^UTILITY(U,$J,358.3,6306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6306,1,3,0)
 ;;=3^Puncture Wound w/o FB of Neck,Unspec Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,6306,1,4,0)
 ;;=4^S11.93XA
 ;;^UTILITY(U,$J,358.3,6306,2)
 ;;=^5021536
 ;;^UTILITY(U,$J,358.3,6307,0)
 ;;=S31.813A^^40^388^38
 ;;^UTILITY(U,$J,358.3,6307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6307,1,3,0)
 ;;=3^Puncture Wound w/o FB of Right Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,6307,1,4,0)
 ;;=4^S31.813A
 ;;^UTILITY(U,$J,358.3,6307,2)
 ;;=^5024302
 ;;^UTILITY(U,$J,358.3,6308,0)
 ;;=S31.133A^^40^388^35
 ;;^UTILITY(U,$J,358.3,6308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6308,1,3,0)
 ;;=3^Puncture Wound w/o FB of RLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,6308,1,4,0)
 ;;=4^S31.133A
 ;;^UTILITY(U,$J,358.3,6308,2)
 ;;=^5024080
