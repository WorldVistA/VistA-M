IBDEI09Q ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4015,2)
 ;;=^5063642
 ;;^UTILITY(U,$J,358.3,4016,0)
 ;;=J45.991^^28^261^2
 ;;^UTILITY(U,$J,358.3,4016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4016,1,3,0)
 ;;=3^Asthma,Cough Variant
 ;;^UTILITY(U,$J,358.3,4016,1,4,0)
 ;;=4^J45.991
 ;;^UTILITY(U,$J,358.3,4016,2)
 ;;=^329927
 ;;^UTILITY(U,$J,358.3,4017,0)
 ;;=J45.990^^28^261^3
 ;;^UTILITY(U,$J,358.3,4017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4017,1,3,0)
 ;;=3^Asthma,Exercise Induced Bronchospasm
 ;;^UTILITY(U,$J,358.3,4017,1,4,0)
 ;;=4^J45.990
 ;;^UTILITY(U,$J,358.3,4017,2)
 ;;=^329926
 ;;^UTILITY(U,$J,358.3,4018,0)
 ;;=J45.909^^28^261^6
 ;;^UTILITY(U,$J,358.3,4018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4018,1,3,0)
 ;;=3^Asthma,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,4018,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,4018,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,4019,0)
 ;;=J45.901^^28^261^4
 ;;^UTILITY(U,$J,358.3,4019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4019,1,3,0)
 ;;=3^Asthma,Unspec w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,4019,1,4,0)
 ;;=4^J45.901
 ;;^UTILITY(U,$J,358.3,4019,2)
 ;;=^5008254
 ;;^UTILITY(U,$J,358.3,4020,0)
 ;;=J45.902^^28^261^5
 ;;^UTILITY(U,$J,358.3,4020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4020,1,3,0)
 ;;=3^Asthma,Unspec w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,4020,1,4,0)
 ;;=4^J45.902
 ;;^UTILITY(U,$J,358.3,4020,2)
 ;;=^5008255
 ;;^UTILITY(U,$J,358.3,4021,0)
 ;;=J15.9^^28^261^7
 ;;^UTILITY(U,$J,358.3,4021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4021,1,3,0)
 ;;=3^Bacterial Pneumonia,Unspec
 ;;^UTILITY(U,$J,358.3,4021,1,4,0)
 ;;=4^J15.9
 ;;^UTILITY(U,$J,358.3,4021,2)
 ;;=^5008178
 ;;^UTILITY(U,$J,358.3,4022,0)
 ;;=R06.9^^28^261^11
 ;;^UTILITY(U,$J,358.3,4022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4022,1,3,0)
 ;;=3^Breathing Abnormalities,Unspec
 ;;^UTILITY(U,$J,358.3,4022,1,4,0)
 ;;=4^R06.9
 ;;^UTILITY(U,$J,358.3,4022,2)
 ;;=^5019194
 ;;^UTILITY(U,$J,358.3,4023,0)
 ;;=J47.1^^28^261^9
 ;;^UTILITY(U,$J,358.3,4023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4023,1,3,0)
 ;;=3^Branchietasis w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,4023,1,4,0)
 ;;=4^J47.1
 ;;^UTILITY(U,$J,358.3,4023,2)
 ;;=^5008259
 ;;^UTILITY(U,$J,358.3,4024,0)
 ;;=J47.0^^28^261^10
 ;;^UTILITY(U,$J,358.3,4024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4024,1,3,0)
 ;;=3^Branchietasis w/ Acute Lower Repiratory Infection
 ;;^UTILITY(U,$J,358.3,4024,1,4,0)
 ;;=4^J47.0
 ;;^UTILITY(U,$J,358.3,4024,2)
 ;;=^5008258
 ;;^UTILITY(U,$J,358.3,4025,0)
 ;;=J47.9^^28^261^8
 ;;^UTILITY(U,$J,358.3,4025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4025,1,3,0)
 ;;=3^Branchietasis Uncomplicated
 ;;^UTILITY(U,$J,358.3,4025,1,4,0)
 ;;=4^J47.9
 ;;^UTILITY(U,$J,358.3,4025,2)
 ;;=^5008260
 ;;^UTILITY(U,$J,358.3,4026,0)
 ;;=J21.9^^28^261^12
 ;;^UTILITY(U,$J,358.3,4026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4026,1,3,0)
 ;;=3^Bronchiolitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,4026,1,4,0)
 ;;=4^J21.9
 ;;^UTILITY(U,$J,358.3,4026,2)
 ;;=^5008199
 ;;^UTILITY(U,$J,358.3,4027,0)
 ;;=J20.9^^28^261^13
 ;;^UTILITY(U,$J,358.3,4027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4027,1,3,0)
 ;;=3^Bronchitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,4027,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,4027,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,4028,0)
 ;;=J41.1^^28^261^14
 ;;^UTILITY(U,$J,358.3,4028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4028,1,3,0)
 ;;=3^Bronchitis,Chronic,Mucopurulent
 ;;^UTILITY(U,$J,358.3,4028,1,4,0)
 ;;=4^J41.1
 ;;^UTILITY(U,$J,358.3,4028,2)
 ;;=^269949
 ;;^UTILITY(U,$J,358.3,4029,0)
 ;;=J41.0^^28^261^15
