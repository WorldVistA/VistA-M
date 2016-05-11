IBDEI0QB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12331,1,4,0)
 ;;=4^D12.7
 ;;^UTILITY(U,$J,358.3,12331,2)
 ;;=^5001970
 ;;^UTILITY(U,$J,358.3,12332,0)
 ;;=D12.8^^50^559^15
 ;;^UTILITY(U,$J,358.3,12332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12332,1,3,0)
 ;;=3^Benign neoplasm of rectum
 ;;^UTILITY(U,$J,358.3,12332,1,4,0)
 ;;=4^D12.8
 ;;^UTILITY(U,$J,358.3,12332,2)
 ;;=^5001971
 ;;^UTILITY(U,$J,358.3,12333,0)
 ;;=D12.9^^50^559^8
 ;;^UTILITY(U,$J,358.3,12333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12333,1,3,0)
 ;;=3^Benign neoplasm of anus and anal canal
 ;;^UTILITY(U,$J,358.3,12333,1,4,0)
 ;;=4^D12.9
 ;;^UTILITY(U,$J,358.3,12333,2)
 ;;=^5001972
 ;;^UTILITY(U,$J,358.3,12334,0)
 ;;=E83.110^^50^559^38
 ;;^UTILITY(U,$J,358.3,12334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12334,1,3,0)
 ;;=3^Hereditary hemochromatosis
 ;;^UTILITY(U,$J,358.3,12334,1,4,0)
 ;;=4^E83.110
 ;;^UTILITY(U,$J,358.3,12334,2)
 ;;=^339602
 ;;^UTILITY(U,$J,358.3,12335,0)
 ;;=E83.111^^50^559^35
 ;;^UTILITY(U,$J,358.3,12335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12335,1,3,0)
 ;;=3^Hemochromatosis due to repeated red blood cell transfusions
 ;;^UTILITY(U,$J,358.3,12335,1,4,0)
 ;;=4^E83.111
 ;;^UTILITY(U,$J,358.3,12335,2)
 ;;=^5002994
 ;;^UTILITY(U,$J,358.3,12336,0)
 ;;=E83.10^^50^559^26
 ;;^UTILITY(U,$J,358.3,12336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12336,1,3,0)
 ;;=3^Disorder of iron metabolism, unspecified
 ;;^UTILITY(U,$J,358.3,12336,1,4,0)
 ;;=4^E83.10
 ;;^UTILITY(U,$J,358.3,12336,2)
 ;;=^5002993
 ;;^UTILITY(U,$J,358.3,12337,0)
 ;;=D64.9^^50^559^5
 ;;^UTILITY(U,$J,358.3,12337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12337,1,3,0)
 ;;=3^Anemia, unspecified
 ;;^UTILITY(U,$J,358.3,12337,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,12337,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,12338,0)
 ;;=K50.919^^50^559^24
 ;;^UTILITY(U,$J,358.3,12338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12338,1,3,0)
 ;;=3^Crohn's disease, unspecified, with unspecified complications
 ;;^UTILITY(U,$J,358.3,12338,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,12338,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,12339,0)
 ;;=K50.918^^50^559^22
 ;;^UTILITY(U,$J,358.3,12339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12339,1,3,0)
 ;;=3^Crohn's disease, unspecified, with other complication
 ;;^UTILITY(U,$J,358.3,12339,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,12339,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,12340,0)
 ;;=K50.914^^50^559^19
 ;;^UTILITY(U,$J,358.3,12340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12340,1,3,0)
 ;;=3^Crohn's disease, unspecified, with abscess
 ;;^UTILITY(U,$J,358.3,12340,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,12340,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,12341,0)
 ;;=K50.913^^50^559^20
 ;;^UTILITY(U,$J,358.3,12341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12341,1,3,0)
 ;;=3^Crohn's disease, unspecified, with fistula
 ;;^UTILITY(U,$J,358.3,12341,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,12341,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,12342,0)
 ;;=K50.912^^50^559^21
 ;;^UTILITY(U,$J,358.3,12342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12342,1,3,0)
 ;;=3^Crohn's disease, unspecified, with intestinal obstruction
 ;;^UTILITY(U,$J,358.3,12342,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,12342,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,12343,0)
 ;;=K50.90^^50^559^25
 ;;^UTILITY(U,$J,358.3,12343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12343,1,3,0)
 ;;=3^Crohn's disease, unspecified, without complications
 ;;^UTILITY(U,$J,358.3,12343,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,12343,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,12344,0)
 ;;=K50.911^^50^559^23
