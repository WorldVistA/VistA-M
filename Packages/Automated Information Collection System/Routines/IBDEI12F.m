IBDEI12F ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17773,0)
 ;;=D12.7^^91^882^14
 ;;^UTILITY(U,$J,358.3,17773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17773,1,3,0)
 ;;=3^Benign neoplasm of rectosigmoid junction
 ;;^UTILITY(U,$J,358.3,17773,1,4,0)
 ;;=4^D12.7
 ;;^UTILITY(U,$J,358.3,17773,2)
 ;;=^5001970
 ;;^UTILITY(U,$J,358.3,17774,0)
 ;;=D12.8^^91^882^15
 ;;^UTILITY(U,$J,358.3,17774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17774,1,3,0)
 ;;=3^Benign neoplasm of rectum
 ;;^UTILITY(U,$J,358.3,17774,1,4,0)
 ;;=4^D12.8
 ;;^UTILITY(U,$J,358.3,17774,2)
 ;;=^5001971
 ;;^UTILITY(U,$J,358.3,17775,0)
 ;;=D12.9^^91^882^8
 ;;^UTILITY(U,$J,358.3,17775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17775,1,3,0)
 ;;=3^Benign neoplasm of anus and anal canal
 ;;^UTILITY(U,$J,358.3,17775,1,4,0)
 ;;=4^D12.9
 ;;^UTILITY(U,$J,358.3,17775,2)
 ;;=^5001972
 ;;^UTILITY(U,$J,358.3,17776,0)
 ;;=E83.110^^91^882^38
 ;;^UTILITY(U,$J,358.3,17776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17776,1,3,0)
 ;;=3^Hereditary hemochromatosis
 ;;^UTILITY(U,$J,358.3,17776,1,4,0)
 ;;=4^E83.110
 ;;^UTILITY(U,$J,358.3,17776,2)
 ;;=^339602
 ;;^UTILITY(U,$J,358.3,17777,0)
 ;;=E83.111^^91^882^35
 ;;^UTILITY(U,$J,358.3,17777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17777,1,3,0)
 ;;=3^Hemochromatosis due to repeated red blood cell transfusions
 ;;^UTILITY(U,$J,358.3,17777,1,4,0)
 ;;=4^E83.111
 ;;^UTILITY(U,$J,358.3,17777,2)
 ;;=^5002994
 ;;^UTILITY(U,$J,358.3,17778,0)
 ;;=E83.10^^91^882^26
 ;;^UTILITY(U,$J,358.3,17778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17778,1,3,0)
 ;;=3^Disorder of iron metabolism, unspecified
 ;;^UTILITY(U,$J,358.3,17778,1,4,0)
 ;;=4^E83.10
 ;;^UTILITY(U,$J,358.3,17778,2)
 ;;=^5002993
 ;;^UTILITY(U,$J,358.3,17779,0)
 ;;=D64.9^^91^882^5
 ;;^UTILITY(U,$J,358.3,17779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17779,1,3,0)
 ;;=3^Anemia, unspecified
 ;;^UTILITY(U,$J,358.3,17779,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,17779,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,17780,0)
 ;;=K50.919^^91^882^24
 ;;^UTILITY(U,$J,358.3,17780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17780,1,3,0)
 ;;=3^Crohn's disease, unspecified, with unspecified complications
 ;;^UTILITY(U,$J,358.3,17780,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,17780,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,17781,0)
 ;;=K50.918^^91^882^22
 ;;^UTILITY(U,$J,358.3,17781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17781,1,3,0)
 ;;=3^Crohn's disease, unspecified, with other complication
 ;;^UTILITY(U,$J,358.3,17781,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,17781,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,17782,0)
 ;;=K50.914^^91^882^19
 ;;^UTILITY(U,$J,358.3,17782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17782,1,3,0)
 ;;=3^Crohn's disease, unspecified, with abscess
 ;;^UTILITY(U,$J,358.3,17782,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,17782,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,17783,0)
 ;;=K50.913^^91^882^20
 ;;^UTILITY(U,$J,358.3,17783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17783,1,3,0)
 ;;=3^Crohn's disease, unspecified, with fistula
 ;;^UTILITY(U,$J,358.3,17783,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,17783,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,17784,0)
 ;;=K50.912^^91^882^21
 ;;^UTILITY(U,$J,358.3,17784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17784,1,3,0)
 ;;=3^Crohn's disease, unspecified, with intestinal obstruction
 ;;^UTILITY(U,$J,358.3,17784,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,17784,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,17785,0)
 ;;=K50.90^^91^882^25
 ;;^UTILITY(U,$J,358.3,17785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17785,1,3,0)
 ;;=3^Crohn's disease, unspecified, without complications
