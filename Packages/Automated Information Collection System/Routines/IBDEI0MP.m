IBDEI0MP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10364,0)
 ;;=J01.00^^68^666^5
 ;;^UTILITY(U,$J,358.3,10364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10364,1,3,0)
 ;;=3^Acute Maxillary Sinusitis,Unspec
 ;;^UTILITY(U,$J,358.3,10364,1,4,0)
 ;;=4^J01.00
 ;;^UTILITY(U,$J,358.3,10364,2)
 ;;=^5008116
 ;;^UTILITY(U,$J,358.3,10365,0)
 ;;=J01.10^^68^666^1
 ;;^UTILITY(U,$J,358.3,10365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10365,1,3,0)
 ;;=3^Acute Frontal Sinusitis,Unspec
 ;;^UTILITY(U,$J,358.3,10365,1,4,0)
 ;;=4^J01.10
 ;;^UTILITY(U,$J,358.3,10365,2)
 ;;=^5008118
 ;;^UTILITY(U,$J,358.3,10366,0)
 ;;=J02.9^^68^666^7
 ;;^UTILITY(U,$J,358.3,10366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10366,1,3,0)
 ;;=3^Acute Pharyngitis,Unspec
 ;;^UTILITY(U,$J,358.3,10366,1,4,0)
 ;;=4^J02.9
 ;;^UTILITY(U,$J,358.3,10366,2)
 ;;=^5008130
 ;;^UTILITY(U,$J,358.3,10367,0)
 ;;=J03.91^^68^666^8
 ;;^UTILITY(U,$J,358.3,10367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10367,1,3,0)
 ;;=3^Acute Recurrent Tonsillitis,Unspec
 ;;^UTILITY(U,$J,358.3,10367,1,4,0)
 ;;=4^J03.91
 ;;^UTILITY(U,$J,358.3,10367,2)
 ;;=^5008136
 ;;^UTILITY(U,$J,358.3,10368,0)
 ;;=J04.0^^68^666^3
 ;;^UTILITY(U,$J,358.3,10368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10368,1,3,0)
 ;;=3^Acute Laryngitis
 ;;^UTILITY(U,$J,358.3,10368,1,4,0)
 ;;=4^J04.0
 ;;^UTILITY(U,$J,358.3,10368,2)
 ;;=^5008137
 ;;^UTILITY(U,$J,358.3,10369,0)
 ;;=J06.0^^68^666^4
 ;;^UTILITY(U,$J,358.3,10369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10369,1,3,0)
 ;;=3^Acute Laryngopharyngitis
 ;;^UTILITY(U,$J,358.3,10369,1,4,0)
 ;;=4^J06.0
 ;;^UTILITY(U,$J,358.3,10369,2)
 ;;=^269876
 ;;^UTILITY(U,$J,358.3,10370,0)
 ;;=J06.9^^68^666^9
 ;;^UTILITY(U,$J,358.3,10370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10370,1,3,0)
 ;;=3^Acute Upper Respiratory Infection,Unspec
 ;;^UTILITY(U,$J,358.3,10370,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,10370,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,10371,0)
 ;;=J33.9^^68^666^19
 ;;^UTILITY(U,$J,358.3,10371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10371,1,3,0)
 ;;=3^Nasal Polyp,Unspec
 ;;^UTILITY(U,$J,358.3,10371,1,4,0)
 ;;=4^J33.9
 ;;^UTILITY(U,$J,358.3,10371,2)
 ;;=^5008208
 ;;^UTILITY(U,$J,358.3,10372,0)
 ;;=J32.0^^68^666^15
 ;;^UTILITY(U,$J,358.3,10372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10372,1,3,0)
 ;;=3^Chronic Maxillary Sinusitis
 ;;^UTILITY(U,$J,358.3,10372,1,4,0)
 ;;=4^J32.0
 ;;^UTILITY(U,$J,358.3,10372,2)
 ;;=^24407
 ;;^UTILITY(U,$J,358.3,10373,0)
 ;;=J32.1^^68^666^14
 ;;^UTILITY(U,$J,358.3,10373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10373,1,3,0)
 ;;=3^Chronic Frontal Sinusitis
 ;;^UTILITY(U,$J,358.3,10373,1,4,0)
 ;;=4^J32.1
 ;;^UTILITY(U,$J,358.3,10373,2)
 ;;=^24380
 ;;^UTILITY(U,$J,358.3,10374,0)
 ;;=J32.9^^68^666^16
 ;;^UTILITY(U,$J,358.3,10374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10374,1,3,0)
 ;;=3^Chronic Sinusitis,Unspec
 ;;^UTILITY(U,$J,358.3,10374,1,4,0)
 ;;=4^J32.9
 ;;^UTILITY(U,$J,358.3,10374,2)
 ;;=^5008207
 ;;^UTILITY(U,$J,358.3,10375,0)
 ;;=J30.9^^68^666^11
 ;;^UTILITY(U,$J,358.3,10375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10375,1,3,0)
 ;;=3^Allergic Rhinitis,Unspec
 ;;^UTILITY(U,$J,358.3,10375,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,10375,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,10376,0)
 ;;=J30.0^^68^666^22
 ;;^UTILITY(U,$J,358.3,10376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10376,1,3,0)
 ;;=3^Vasomotor Rhinitis
 ;;^UTILITY(U,$J,358.3,10376,1,4,0)
 ;;=4^J30.0
 ;;^UTILITY(U,$J,358.3,10376,2)
 ;;=^5008201
 ;;^UTILITY(U,$J,358.3,10377,0)
 ;;=K05.00^^68^666^2
 ;;^UTILITY(U,$J,358.3,10377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10377,1,3,0)
 ;;=3^Acute Gingivitis,Plaque Induced
