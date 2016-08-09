IBDEI0H8 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17307,0)
 ;;=F40.01^^76^885^1
 ;;^UTILITY(U,$J,358.3,17307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17307,1,3,0)
 ;;=3^Agoraphobia w/ panic disorder
 ;;^UTILITY(U,$J,358.3,17307,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,17307,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,17308,0)
 ;;=F40.02^^76^885^2
 ;;^UTILITY(U,$J,358.3,17308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17308,1,3,0)
 ;;=3^Agoraphobia w/o panic disorder
 ;;^UTILITY(U,$J,358.3,17308,1,4,0)
 ;;=4^F40.02
 ;;^UTILITY(U,$J,358.3,17308,2)
 ;;=^5003543
 ;;^UTILITY(U,$J,358.3,17309,0)
 ;;=F42.^^76^885^5
 ;;^UTILITY(U,$J,358.3,17309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17309,1,3,0)
 ;;=3^Obsessive-compulsive disorder
 ;;^UTILITY(U,$J,358.3,17309,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,17309,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,17310,0)
 ;;=F43.10^^76^885^8
 ;;^UTILITY(U,$J,358.3,17310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17310,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspec
 ;;^UTILITY(U,$J,358.3,17310,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,17310,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,17311,0)
 ;;=F43.12^^76^885^7
 ;;^UTILITY(U,$J,358.3,17311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17311,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,17311,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,17311,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,17312,0)
 ;;=E53.8^^76^886^1
 ;;^UTILITY(U,$J,358.3,17312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17312,1,3,0)
 ;;=3^B Vitamin Deficiency
 ;;^UTILITY(U,$J,358.3,17312,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,17312,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,17313,0)
 ;;=R00.1^^76^886^8
 ;;^UTILITY(U,$J,358.3,17313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17313,1,3,0)
 ;;=3^Bradycardia, unspec
 ;;^UTILITY(U,$J,358.3,17313,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,17313,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,17314,0)
 ;;=J20.9^^76^886^9
 ;;^UTILITY(U,$J,358.3,17314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17314,1,3,0)
 ;;=3^Bronchitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,17314,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,17314,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,17315,0)
 ;;=N32.0^^76^886^7
 ;;^UTILITY(U,$J,358.3,17315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17315,1,3,0)
 ;;=3^Bladder-neck obstruction
 ;;^UTILITY(U,$J,358.3,17315,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,17315,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,17316,0)
 ;;=N40.0^^76^886^3
 ;;^UTILITY(U,$J,358.3,17316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17316,1,3,0)
 ;;=3^BPH w/o lower urinary tract symptoms
 ;;^UTILITY(U,$J,358.3,17316,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,17316,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,17317,0)
 ;;=N40.1^^76^886^2
 ;;^UTILITY(U,$J,358.3,17317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17317,1,3,0)
 ;;=3^BPH w/ lower urinary tract symptoms
 ;;^UTILITY(U,$J,358.3,17317,1,4,0)
 ;;=4^N40.1
 ;;^UTILITY(U,$J,358.3,17317,2)
 ;;=^5015690
 ;;^UTILITY(U,$J,358.3,17318,0)
 ;;=M71.50^^76^886^10
 ;;^UTILITY(U,$J,358.3,17318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17318,1,3,0)
 ;;=3^Bursitis, Site Unspec NEC
 ;;^UTILITY(U,$J,358.3,17318,1,4,0)
 ;;=4^M71.50
 ;;^UTILITY(U,$J,358.3,17318,2)
 ;;=^5013190
 ;;^UTILITY(U,$J,358.3,17319,0)
 ;;=S39.012A^^76^886^6
 ;;^UTILITY(U,$J,358.3,17319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17319,1,3,0)
 ;;=3^Back strain, lower, unspec, init encntr
 ;;^UTILITY(U,$J,358.3,17319,1,4,0)
 ;;=4^S39.012A
 ;;^UTILITY(U,$J,358.3,17319,2)
 ;;=^5026102
 ;;^UTILITY(U,$J,358.3,17320,0)
 ;;=M54.9^^76^886^4
 ;;^UTILITY(U,$J,358.3,17320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17320,1,3,0)
 ;;=3^Back Pain,Generalized
 ;;^UTILITY(U,$J,358.3,17320,1,4,0)
 ;;=4^M54.9
 ;;^UTILITY(U,$J,358.3,17320,2)
 ;;=^5012314
 ;;^UTILITY(U,$J,358.3,17321,0)
 ;;=M54.5^^76^886^5
 ;;^UTILITY(U,$J,358.3,17321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17321,1,3,0)
 ;;=3^Back Pain,Lower
 ;;^UTILITY(U,$J,358.3,17321,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,17321,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,17322,0)
 ;;=F31.10^^76^887^1
 ;;^UTILITY(U,$J,358.3,17322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17322,1,3,0)
 ;;=3^Bipolar disord, crnt episode manic w/o psych features, unspec
 ;;^UTILITY(U,$J,358.3,17322,1,4,0)
 ;;=4^F31.10
 ;;^UTILITY(U,$J,358.3,17322,2)
 ;;=^5003495
 ;;^UTILITY(U,$J,358.3,17323,0)
 ;;=F31.30^^76^887^2
 ;;^UTILITY(U,$J,358.3,17323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17323,1,3,0)
 ;;=3^Bipolar disord, crnt epsd depress, mild or mod severt, unspec
 ;;^UTILITY(U,$J,358.3,17323,1,4,0)
 ;;=4^F31.30
 ;;^UTILITY(U,$J,358.3,17323,2)
 ;;=^5003500
 ;;^UTILITY(U,$J,358.3,17324,0)
 ;;=F31.60^^76^887^3
 ;;^UTILITY(U,$J,358.3,17324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17324,1,3,0)
 ;;=3^Bipolar disorder, current episode mixed, unspec
 ;;^UTILITY(U,$J,358.3,17324,1,4,0)
 ;;=4^F31.60
 ;;^UTILITY(U,$J,358.3,17324,2)
 ;;=^5003505
 ;;^UTILITY(U,$J,358.3,17325,0)
 ;;=F31.9^^76^887^4
 ;;^UTILITY(U,$J,358.3,17325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17325,1,3,0)
 ;;=3^Bipolar disorder, unspec
 ;;^UTILITY(U,$J,358.3,17325,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,17325,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,17326,0)
 ;;=C15.9^^76^888^6
 ;;^UTILITY(U,$J,358.3,17326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17326,1,3,0)
 ;;=3^Malig Neop of esophagus, unspec
 ;;^UTILITY(U,$J,358.3,17326,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,17326,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,17327,0)
 ;;=C18.9^^76^888^5
 ;;^UTILITY(U,$J,358.3,17327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17327,1,3,0)
 ;;=3^Malig Neop of colon, unspec
 ;;^UTILITY(U,$J,358.3,17327,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,17327,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,17328,0)
 ;;=C32.9^^76^888^7
 ;;^UTILITY(U,$J,358.3,17328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17328,1,3,0)
 ;;=3^Malig Neop of larynx, unspec
 ;;^UTILITY(U,$J,358.3,17328,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,17328,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,17329,0)
 ;;=C34.91^^76^888^13
 ;;^UTILITY(U,$J,358.3,17329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17329,1,3,0)
 ;;=3^Malig Neop of rt bronchus or lung, unsp part
 ;;^UTILITY(U,$J,358.3,17329,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,17329,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,17330,0)
 ;;=C34.92^^76^888^9
 ;;^UTILITY(U,$J,358.3,17330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17330,1,3,0)
 ;;=3^Malig Neop of lft bronchus or lung, unsp part
 ;;^UTILITY(U,$J,358.3,17330,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,17330,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,17331,0)
 ;;=C44.91^^76^888^1
 ;;^UTILITY(U,$J,358.3,17331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17331,1,3,0)
 ;;=3^Basal cell carcinoma of skin, unspec
 ;;^UTILITY(U,$J,358.3,17331,1,4,0)
 ;;=4^C44.91
 ;;^UTILITY(U,$J,358.3,17331,2)
 ;;=^5001092
 ;;^UTILITY(U,$J,358.3,17332,0)
 ;;=C44.99^^76^888^15
 ;;^UTILITY(U,$J,358.3,17332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17332,1,3,0)
 ;;=3^Malig Neop of skin, oth spec, unspec
 ;;^UTILITY(U,$J,358.3,17332,1,4,0)
 ;;=4^C44.99
 ;;^UTILITY(U,$J,358.3,17332,2)
 ;;=^5001094
 ;;^UTILITY(U,$J,358.3,17333,0)
 ;;=C50.912^^76^888^8
 ;;^UTILITY(U,$J,358.3,17333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17333,1,3,0)
 ;;=3^Malig Neop of lft breast, female, unspec site
 ;;^UTILITY(U,$J,358.3,17333,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,17333,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,17334,0)
 ;;=C50.911^^76^888^12
 ;;^UTILITY(U,$J,358.3,17334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17334,1,3,0)
 ;;=3^Malig Neop of rt breast, female, unspec site
 ;;^UTILITY(U,$J,358.3,17334,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,17334,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,17335,0)
 ;;=C61.^^76^888^11
