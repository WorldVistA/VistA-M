IBDEI031 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,966,1,3,0)
 ;;=3^Intervertebral Disc Disorder Thoracic,Thoracolumbar & Lumbar
 ;;^UTILITY(U,$J,358.3,966,1,4,0)
 ;;=4^M51.9
 ;;^UTILITY(U,$J,358.3,966,2)
 ;;=^5012263
 ;;^UTILITY(U,$J,358.3,967,0)
 ;;=I30.0^^6^105^2
 ;;^UTILITY(U,$J,358.3,967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,967,1,3,0)
 ;;=3^Idiopathic Pericarditis Acute
 ;;^UTILITY(U,$J,358.3,967,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,967,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,968,0)
 ;;=N18.9^^6^106^3
 ;;^UTILITY(U,$J,358.3,968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,968,1,3,0)
 ;;=3^Kidney Disease,Chr,Unspec
 ;;^UTILITY(U,$J,358.3,968,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,968,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,969,0)
 ;;=J04.0^^6^106^6
 ;;^UTILITY(U,$J,358.3,969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,969,1,3,0)
 ;;=3^Laryngitis,Acute
 ;;^UTILITY(U,$J,358.3,969,1,4,0)
 ;;=4^J04.0
 ;;^UTILITY(U,$J,358.3,969,2)
 ;;=^5008137
 ;;^UTILITY(U,$J,358.3,970,0)
 ;;=J05.0^^6^106^7
 ;;^UTILITY(U,$J,358.3,970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,970,1,3,0)
 ;;=3^Laryngitis,Acute Obstructive (Croup)
 ;;^UTILITY(U,$J,358.3,970,1,4,0)
 ;;=4^J05.0
 ;;^UTILITY(U,$J,358.3,970,2)
 ;;=^5008141
 ;;^UTILITY(U,$J,358.3,971,0)
 ;;=R17.^^6^106^1
 ;;^UTILITY(U,$J,358.3,971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,971,1,3,0)
 ;;=3^Jaundice,Unspec
 ;;^UTILITY(U,$J,358.3,971,1,4,0)
 ;;=4^R17.
 ;;^UTILITY(U,$J,358.3,971,2)
 ;;=^5019251
 ;;^UTILITY(U,$J,358.3,972,0)
 ;;=N17.9^^6^106^4
 ;;^UTILITY(U,$J,358.3,972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,972,1,3,0)
 ;;=3^Kidney Failure,Acute
 ;;^UTILITY(U,$J,358.3,972,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,972,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,973,0)
 ;;=N18.9^^6^106^5
 ;;^UTILITY(U,$J,358.3,973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,973,1,3,0)
 ;;=3^Kidney Failure,Chronic
 ;;^UTILITY(U,$J,358.3,973,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,973,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,974,0)
 ;;=N28.9^^6^106^2
 ;;^UTILITY(U,$J,358.3,974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,974,1,3,0)
 ;;=3^Kidney & Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,974,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,974,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,975,0)
 ;;=R53.81^^6^107^1
 ;;^UTILITY(U,$J,358.3,975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,975,1,3,0)
 ;;=3^Malaise,Other
 ;;^UTILITY(U,$J,358.3,975,1,4,0)
 ;;=4^R53.81
 ;;^UTILITY(U,$J,358.3,975,2)
 ;;=^5019518
 ;;^UTILITY(U,$J,358.3,976,0)
 ;;=N52.9^^6^107^2
 ;;^UTILITY(U,$J,358.3,976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,976,1,3,0)
 ;;=3^Male Erectile Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,976,1,4,0)
 ;;=4^N52.9
 ;;^UTILITY(U,$J,358.3,976,2)
 ;;=^5015763
 ;;^UTILITY(U,$J,358.3,977,0)
 ;;=E46.^^6^107^3
 ;;^UTILITY(U,$J,358.3,977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,977,1,3,0)
 ;;=3^Malnutrition,Protein-Calorie,Unspec
 ;;^UTILITY(U,$J,358.3,977,1,4,0)
 ;;=4^E46.
 ;;^UTILITY(U,$J,358.3,977,2)
 ;;=^5002790
 ;;^UTILITY(U,$J,358.3,978,0)
 ;;=I21.3^^6^107^9
 ;;^UTILITY(U,$J,358.3,978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,978,1,3,0)
 ;;=3^Myocardial Infarction (STEMI) Unspec Site
 ;;^UTILITY(U,$J,358.3,978,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,978,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,979,0)
 ;;=G43.909^^6^107^6
 ;;^UTILITY(U,$J,358.3,979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,979,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus
 ;;^UTILITY(U,$J,358.3,979,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,979,2)
 ;;=^5003909
