IBDEI0I1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8347,1,3,0)
 ;;=3^Graves Disease
 ;;^UTILITY(U,$J,358.3,8347,1,4,0)
 ;;=4^E05.00
 ;;^UTILITY(U,$J,358.3,8347,2)
 ;;=^5002481
 ;;^UTILITY(U,$J,358.3,8348,0)
 ;;=D44.0^^35^442^79
 ;;^UTILITY(U,$J,358.3,8348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8348,1,3,0)
 ;;=3^Neoplasm of Thyroid Gland,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,8348,1,4,0)
 ;;=4^D44.0
 ;;^UTILITY(U,$J,358.3,8348,2)
 ;;=^5002235
 ;;^UTILITY(U,$J,358.3,8349,0)
 ;;=D44.11^^35^442^78
 ;;^UTILITY(U,$J,358.3,8349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8349,1,3,0)
 ;;=3^Neoplasm of Right Adrenal Gland,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,8349,1,4,0)
 ;;=4^D44.11
 ;;^UTILITY(U,$J,358.3,8349,2)
 ;;=^5002237
 ;;^UTILITY(U,$J,358.3,8350,0)
 ;;=D44.12^^35^442^74
 ;;^UTILITY(U,$J,358.3,8350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8350,1,3,0)
 ;;=3^Neoplasm of Left Adrenal Gland,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,8350,1,4,0)
 ;;=4^D44.12
 ;;^UTILITY(U,$J,358.3,8350,2)
 ;;=^5002238
 ;;^UTILITY(U,$J,358.3,8351,0)
 ;;=D44.2^^35^442^75
 ;;^UTILITY(U,$J,358.3,8351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8351,1,3,0)
 ;;=3^Neoplasm of Parathyroid Gland,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,8351,1,4,0)
 ;;=4^D44.2
 ;;^UTILITY(U,$J,358.3,8351,2)
 ;;=^5002239
 ;;^UTILITY(U,$J,358.3,8352,0)
 ;;=D44.3^^35^442^77
 ;;^UTILITY(U,$J,358.3,8352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8352,1,3,0)
 ;;=3^Neoplasm of Pituitary Gland,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,8352,1,4,0)
 ;;=4^D44.3
 ;;^UTILITY(U,$J,358.3,8352,2)
 ;;=^5002240
 ;;^UTILITY(U,$J,358.3,8353,0)
 ;;=D44.4^^35^442^73
 ;;^UTILITY(U,$J,358.3,8353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8353,1,3,0)
 ;;=3^Neoplasm of Craniopharyngeal Duct,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,8353,1,4,0)
 ;;=4^D44.4
 ;;^UTILITY(U,$J,358.3,8353,2)
 ;;=^5002241
 ;;^UTILITY(U,$J,358.3,8354,0)
 ;;=D44.5^^35^442^76
 ;;^UTILITY(U,$J,358.3,8354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8354,1,3,0)
 ;;=3^Neoplasm of Pineal Gland,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,8354,1,4,0)
 ;;=4^D44.5
 ;;^UTILITY(U,$J,358.3,8354,2)
 ;;=^81967
 ;;^UTILITY(U,$J,358.3,8355,0)
 ;;=D44.6^^35^442^72
 ;;^UTILITY(U,$J,358.3,8355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8355,1,3,0)
 ;;=3^Neoplasm of Carotid Body,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,8355,1,4,0)
 ;;=4^D44.6
 ;;^UTILITY(U,$J,358.3,8355,2)
 ;;=^5002242
 ;;^UTILITY(U,$J,358.3,8356,0)
 ;;=D44.7^^35^442^71
 ;;^UTILITY(U,$J,358.3,8356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8356,1,3,0)
 ;;=3^Neoplasm of Aortic Body/Oth Paraganglia,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,8356,1,4,0)
 ;;=4^D44.7
 ;;^UTILITY(U,$J,358.3,8356,2)
 ;;=^5002243
 ;;^UTILITY(U,$J,358.3,8357,0)
 ;;=E01.8^^35^442^52
 ;;^UTILITY(U,$J,358.3,8357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8357,1,3,0)
 ;;=3^Hypothyroidism,Acquired Iodine-Deficiency
 ;;^UTILITY(U,$J,358.3,8357,1,4,0)
 ;;=4^E01.8
 ;;^UTILITY(U,$J,358.3,8357,2)
 ;;=^5002467
 ;;^UTILITY(U,$J,358.3,8358,0)
 ;;=E02.^^35^442^54
 ;;^UTILITY(U,$J,358.3,8358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8358,1,3,0)
 ;;=3^Hypothyroidism,Subclinical Iodine-Deficiency
 ;;^UTILITY(U,$J,358.3,8358,1,4,0)
 ;;=4^E02.
 ;;^UTILITY(U,$J,358.3,8358,2)
 ;;=^5002468
 ;;^UTILITY(U,$J,358.3,8359,0)
 ;;=E21.1^^35^442^38
 ;;^UTILITY(U,$J,358.3,8359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8359,1,3,0)
 ;;=3^Heyperparathyroidism,Secondary to Non Renal
 ;;^UTILITY(U,$J,358.3,8359,1,4,0)
 ;;=4^E21.1
 ;;^UTILITY(U,$J,358.3,8359,2)
 ;;=^5002715
