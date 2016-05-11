IBDEI1C1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22649,1,3,0)
 ;;=3^Family Hx of Mult Endocrine Neoplasia Syndrome
 ;;^UTILITY(U,$J,358.3,22649,1,4,0)
 ;;=4^Z83.41
 ;;^UTILITY(U,$J,358.3,22649,2)
 ;;=^5063380
 ;;^UTILITY(U,$J,358.3,22650,0)
 ;;=Z81.8^^87^982^50
 ;;^UTILITY(U,$J,358.3,22650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22650,1,3,0)
 ;;=3^Family Hx of Substance Abuse/Dependence,Psychoactive
 ;;^UTILITY(U,$J,358.3,22650,1,4,0)
 ;;=4^Z81.8
 ;;^UTILITY(U,$J,358.3,22650,2)
 ;;=^5063363
 ;;^UTILITY(U,$J,358.3,22651,0)
 ;;=Z81.4^^87^982^51
 ;;^UTILITY(U,$J,358.3,22651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22651,1,3,0)
 ;;=3^Family Hx of Substance Abuse/Dependence NEC
 ;;^UTILITY(U,$J,358.3,22651,1,4,0)
 ;;=4^Z81.4
 ;;^UTILITY(U,$J,358.3,22651,2)
 ;;=^5063362
 ;;^UTILITY(U,$J,358.3,22652,0)
 ;;=Z98.0^^87^982^62
 ;;^UTILITY(U,$J,358.3,22652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22652,1,3,0)
 ;;=3^Intestinal Bypass/Anastomosis Status
 ;;^UTILITY(U,$J,358.3,22652,1,4,0)
 ;;=4^Z98.0
 ;;^UTILITY(U,$J,358.3,22652,2)
 ;;=^5063733
 ;;^UTILITY(U,$J,358.3,22653,0)
 ;;=Z91.128^^87^982^61
 ;;^UTILITY(U,$J,358.3,22653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22653,1,3,0)
 ;;=3^Intentional Underdose of Meds d/t Other Reasons
 ;;^UTILITY(U,$J,358.3,22653,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,22653,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,22654,0)
 ;;=Z77.120^^87^982^67
 ;;^UTILITY(U,$J,358.3,22654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22654,1,3,0)
 ;;=3^Mold (Toxic) Contact/Exposure
 ;;^UTILITY(U,$J,358.3,22654,1,4,0)
 ;;=4^Z77.120
 ;;^UTILITY(U,$J,358.3,22654,2)
 ;;=^5063318
 ;;^UTILITY(U,$J,358.3,22655,0)
 ;;=Z86.74^^87^982^110
 ;;^UTILITY(U,$J,358.3,22655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22655,1,3,0)
 ;;=3^Personal Hx of Sudden Cardiac Arrest 
 ;;^UTILITY(U,$J,358.3,22655,1,4,0)
 ;;=4^Z86.74
 ;;^UTILITY(U,$J,358.3,22655,2)
 ;;=^5063478
 ;;^UTILITY(U,$J,358.3,22656,0)
 ;;=Z86.718^^87^982^117
 ;;^UTILITY(U,$J,358.3,22656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22656,1,3,0)
 ;;=3^Personal Hx of Venous Thrombosis/Embolism (DVT)
 ;;^UTILITY(U,$J,358.3,22656,1,4,0)
 ;;=4^Z86.718
 ;;^UTILITY(U,$J,358.3,22656,2)
 ;;=^5063475
 ;;^UTILITY(U,$J,358.3,22657,0)
 ;;=Z96.1^^87^982^127
 ;;^UTILITY(U,$J,358.3,22657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22657,1,3,0)
 ;;=3^Presence of Intraocular Lens
 ;;^UTILITY(U,$J,358.3,22657,1,4,0)
 ;;=4^Z96.1
 ;;^UTILITY(U,$J,358.3,22657,2)
 ;;=^5063682
 ;;^UTILITY(U,$J,358.3,22658,0)
 ;;=Z96.612^^87^982^132
 ;;^UTILITY(U,$J,358.3,22658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22658,1,3,0)
 ;;=3^Presence of Left Artificial Shoulder Joint
 ;;^UTILITY(U,$J,358.3,22658,1,4,0)
 ;;=4^Z96.612
 ;;^UTILITY(U,$J,358.3,22658,2)
 ;;=^5063693
 ;;^UTILITY(U,$J,358.3,22659,0)
 ;;=Z96.611^^87^982^137
 ;;^UTILITY(U,$J,358.3,22659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22659,1,3,0)
 ;;=3^Presence of Right Artificial Shoulder Joint
 ;;^UTILITY(U,$J,358.3,22659,1,4,0)
 ;;=4^Z96.611
 ;;^UTILITY(U,$J,358.3,22659,2)
 ;;=^5063692
 ;;^UTILITY(U,$J,358.3,22660,0)
 ;;=Z93.0^^87^982^145
 ;;^UTILITY(U,$J,358.3,22660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22660,1,3,0)
 ;;=3^Tracheostomy Status
 ;;^UTILITY(U,$J,358.3,22660,1,4,0)
 ;;=4^Z93.0
 ;;^UTILITY(U,$J,358.3,22660,2)
 ;;=^5063642
 ;;^UTILITY(U,$J,358.3,22661,0)
 ;;=Z99.3^^87^982^149
 ;;^UTILITY(U,$J,358.3,22661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22661,1,3,0)
 ;;=3^Wheelchair Dependence
 ;;^UTILITY(U,$J,358.3,22661,1,4,0)
 ;;=4^Z99.3
 ;;^UTILITY(U,$J,358.3,22661,2)
 ;;=^5063759
