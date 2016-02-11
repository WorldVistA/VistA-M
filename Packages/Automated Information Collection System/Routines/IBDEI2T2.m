IBDEI2T2 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47103,1,3,0)
 ;;=3^Brachytx Iso Pln-Simple 1-4
 ;;^UTILITY(U,$J,358.3,47104,0)
 ;;=77317^^208^2331^2^^^^1
 ;;^UTILITY(U,$J,358.3,47104,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,47104,1,1,0)
 ;;=1^77317
 ;;^UTILITY(U,$J,358.3,47104,1,3,0)
 ;;=3^Brachytx Iso Pln-Intmd 5-10
 ;;^UTILITY(U,$J,358.3,47105,0)
 ;;=77371^^208^2332^2^^^^1
 ;;^UTILITY(U,$J,358.3,47105,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,47105,1,1,0)
 ;;=1^77371
 ;;^UTILITY(U,$J,358.3,47105,1,3,0)
 ;;=3^SRS Cranial Lesion,Multi Source
 ;;^UTILITY(U,$J,358.3,47106,0)
 ;;=77372^^208^2332^3^^^^1
 ;;^UTILITY(U,$J,358.3,47106,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,47106,1,1,0)
 ;;=1^77372
 ;;^UTILITY(U,$J,358.3,47106,1,3,0)
 ;;=3^SRS Linear Accelerator Based
 ;;^UTILITY(U,$J,358.3,47107,0)
 ;;=77373^^208^2332^1^^^^1
 ;;^UTILITY(U,$J,358.3,47107,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,47107,1,1,0)
 ;;=1^77373
 ;;^UTILITY(U,$J,358.3,47107,1,3,0)
 ;;=3^SRS Body,1 or More Lesions
 ;;^UTILITY(U,$J,358.3,47108,0)
 ;;=G6001^^208^2333^1^^^^1
 ;;^UTILITY(U,$J,358.3,47108,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,47108,1,1,0)
 ;;=1^G6001
 ;;^UTILITY(U,$J,358.3,47108,1,3,0)
 ;;=3^Ultrasonic Guidance-Plmnt Rad Tx Fields
 ;;^UTILITY(U,$J,358.3,47109,0)
 ;;=G6002^^208^2333^2^^^^1
 ;;^UTILITY(U,$J,358.3,47109,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,47109,1,1,0)
 ;;=1^G6002
 ;;^UTILITY(U,$J,358.3,47109,1,3,0)
 ;;=3^Stereoscopic X-Ray Guidance-Delivery Rad Tx
 ;;^UTILITY(U,$J,358.3,47110,0)
 ;;=31575^^208^2334^1^^^^1
 ;;^UTILITY(U,$J,358.3,47110,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,47110,1,1,0)
 ;;=1^31575
 ;;^UTILITY(U,$J,358.3,47110,1,3,0)
 ;;=3^Laryngoscopy,Flexible Fiberoptic,Dx
 ;;^UTILITY(U,$J,358.3,47111,0)
 ;;=Z51.0^^209^2335^1
 ;;^UTILITY(U,$J,358.3,47111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47111,1,3,0)
 ;;=3^Antineoplastic Radiation Therapy
 ;;^UTILITY(U,$J,358.3,47111,1,4,0)
 ;;=4^Z51.0
 ;;^UTILITY(U,$J,358.3,47111,2)
 ;;=^5063060
 ;;^UTILITY(U,$J,358.3,47112,0)
 ;;=Z08.^^209^2336^2
 ;;^UTILITY(U,$J,358.3,47112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47112,1,3,0)
 ;;=3^Follow-up Exam After Treatment for Malig Neop
 ;;^UTILITY(U,$J,358.3,47112,1,4,0)
 ;;=4^Z08.
 ;;^UTILITY(U,$J,358.3,47112,2)
 ;;=^5062667
 ;;^UTILITY(U,$J,358.3,47113,0)
 ;;=Z09.^^209^2336^3
 ;;^UTILITY(U,$J,358.3,47113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47113,1,3,0)
 ;;=3^Follow-up Exam after Treatment for Condition Other Than Malig Neop
 ;;^UTILITY(U,$J,358.3,47113,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,47113,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,47114,0)
 ;;=Z00.6^^209^2336^1
 ;;^UTILITY(U,$J,358.3,47114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47114,1,3,0)
 ;;=3^Exam for Normal Comparison/Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,47114,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,47114,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,47115,0)
 ;;=Z41.8^^209^2336^5
 ;;^UTILITY(U,$J,358.3,47115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47115,1,3,0)
 ;;=3^Procedures for Purposes other than Remedying Health State
 ;;^UTILITY(U,$J,358.3,47115,1,4,0)
 ;;=4^Z41.8
 ;;^UTILITY(U,$J,358.3,47115,2)
 ;;=^5062954
 ;;^UTILITY(U,$J,358.3,47116,0)
 ;;=Z78.9^^209^2336^4
 ;;^UTILITY(U,$J,358.3,47116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47116,1,3,0)
 ;;=3^Health Status NEC
 ;;^UTILITY(U,$J,358.3,47116,1,4,0)
 ;;=4^Z78.9
 ;;^UTILITY(U,$J,358.3,47116,2)
 ;;=^5063329
 ;;^UTILITY(U,$J,358.3,47117,0)
 ;;=D33.2^^209^2337^1
 ;;^UTILITY(U,$J,358.3,47117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47117,1,3,0)
 ;;=3^Benign Neop of Brain,Unspec
