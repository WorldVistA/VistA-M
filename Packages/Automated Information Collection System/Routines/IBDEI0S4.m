IBDEI0S4 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28272,1,3,0)
 ;;=3^Sickle-Cell Disorders w/ Splenic Sequestration
 ;;^UTILITY(U,$J,358.3,28272,1,4,0)
 ;;=4^D57.812
 ;;^UTILITY(U,$J,358.3,28272,2)
 ;;=^5002319
 ;;^UTILITY(U,$J,358.3,28273,0)
 ;;=D57.819^^105^1377^12
 ;;^UTILITY(U,$J,358.3,28273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28273,1,3,0)
 ;;=3^Sickle-Cell Disorders w/ Unspec Crisis NEC
 ;;^UTILITY(U,$J,358.3,28273,1,4,0)
 ;;=4^D57.819
 ;;^UTILITY(U,$J,358.3,28273,2)
 ;;=^5002320
 ;;^UTILITY(U,$J,358.3,28274,0)
 ;;=D58.8^^105^1377^9
 ;;^UTILITY(U,$J,358.3,28274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28274,1,3,0)
 ;;=3^Hereditary Hemolytic Anemias NEC
 ;;^UTILITY(U,$J,358.3,28274,1,4,0)
 ;;=4^D58.8
 ;;^UTILITY(U,$J,358.3,28274,2)
 ;;=^267984
 ;;^UTILITY(U,$J,358.3,28275,0)
 ;;=D58.2^^105^1377^8
 ;;^UTILITY(U,$J,358.3,28275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28275,1,3,0)
 ;;=3^Hemoglobinopathies NEC
 ;;^UTILITY(U,$J,358.3,28275,1,4,0)
 ;;=4^D58.2
 ;;^UTILITY(U,$J,358.3,28275,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,28276,0)
 ;;=C83.10^^105^1378^52
 ;;^UTILITY(U,$J,358.3,28276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28276,1,3,0)
 ;;=3^Mantle cell lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,28276,1,4,0)
 ;;=4^C83.10
 ;;^UTILITY(U,$J,358.3,28276,2)
 ;;=^5001561
 ;;^UTILITY(U,$J,358.3,28277,0)
 ;;=C83.19^^105^1378^51
 ;;^UTILITY(U,$J,358.3,28277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28277,1,3,0)
 ;;=3^Mantle cell lymphoma, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,28277,1,4,0)
 ;;=4^C83.19
 ;;^UTILITY(U,$J,358.3,28277,2)
 ;;=^5001570
 ;;^UTILITY(U,$J,358.3,28278,0)
 ;;=C83.50^^105^1378^45
 ;;^UTILITY(U,$J,358.3,28278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28278,1,3,0)
 ;;=3^Lymphoblastic (diffuse) lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,28278,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,28278,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,28279,0)
 ;;=C83.59^^105^1378^46
 ;;^UTILITY(U,$J,358.3,28279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28279,1,3,0)
 ;;=3^Lymphoblastic lymphoma, extrnod and solid organ sites
 ;;^UTILITY(U,$J,358.3,28279,1,4,0)
 ;;=4^C83.59
 ;;^UTILITY(U,$J,358.3,28279,2)
 ;;=^5001590
 ;;^UTILITY(U,$J,358.3,28280,0)
 ;;=C83.70^^105^1378^12
 ;;^UTILITY(U,$J,358.3,28280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28280,1,3,0)
 ;;=3^Burkitt lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,28280,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,28280,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,28281,0)
 ;;=C83.79^^105^1378^11
 ;;^UTILITY(U,$J,358.3,28281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28281,1,3,0)
 ;;=3^Burkitt lymphoma, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,28281,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,28281,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,28282,0)
 ;;=C81.00^^105^1378^61
 ;;^UTILITY(U,$J,358.3,28282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28282,1,3,0)
 ;;=3^Nodular lymphocyte predominant Hodgkin lymphoma, unsp site
 ;;^UTILITY(U,$J,358.3,28282,1,4,0)
 ;;=4^C81.00
 ;;^UTILITY(U,$J,358.3,28282,2)
 ;;=^5001391
 ;;^UTILITY(U,$J,358.3,28283,0)
 ;;=C83.39^^105^1378^22
 ;;^UTILITY(U,$J,358.3,28283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28283,1,3,0)
 ;;=3^Diffuse large B-cell lymphoma, extrnod and solid organ sites
 ;;^UTILITY(U,$J,358.3,28283,1,4,0)
 ;;=4^C83.39
 ;;^UTILITY(U,$J,358.3,28283,2)
 ;;=^5001580
 ;;^UTILITY(U,$J,358.3,28284,0)
 ;;=C81.09^^105^1378^62
 ;;^UTILITY(U,$J,358.3,28284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28284,1,3,0)
 ;;=3^Nodular lymphocyte predominant Hodgkin lymphoma, extrnod & solid org site
 ;;^UTILITY(U,$J,358.3,28284,1,4,0)
 ;;=4^C81.09
 ;;^UTILITY(U,$J,358.3,28284,2)
 ;;=^5001400
 ;;^UTILITY(U,$J,358.3,28285,0)
 ;;=C81.10^^105^1378^63
 ;;^UTILITY(U,$J,358.3,28285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28285,1,3,0)
 ;;=3^Nodular sclerosis classical Hodgkin lymphoma, unsp site
 ;;^UTILITY(U,$J,358.3,28285,1,4,0)
 ;;=4^C81.10
 ;;^UTILITY(U,$J,358.3,28285,2)
 ;;=^5001401
 ;;^UTILITY(U,$J,358.3,28286,0)
 ;;=C81.19^^105^1378^64
 ;;^UTILITY(U,$J,358.3,28286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28286,1,3,0)
 ;;=3^Nodular sclerosis classical Hodgkin lymphoma,extrnod and solid organ sites
 ;;^UTILITY(U,$J,358.3,28286,1,4,0)
 ;;=4^C81.19
 ;;^UTILITY(U,$J,358.3,28286,2)
 ;;=^5001410
 ;;^UTILITY(U,$J,358.3,28287,0)
 ;;=C81.20^^105^1378^54
 ;;^UTILITY(U,$J,358.3,28287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28287,1,3,0)
 ;;=3^Mixed cellularity classical Hodgkin lymphoma, unsp site
 ;;^UTILITY(U,$J,358.3,28287,1,4,0)
 ;;=4^C81.20
 ;;^UTILITY(U,$J,358.3,28287,2)
 ;;=^5001411
 ;;^UTILITY(U,$J,358.3,28288,0)
 ;;=C81.29^^105^1378^53
 ;;^UTILITY(U,$J,358.3,28288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28288,1,3,0)
 ;;=3^Mix cellular class Hdgkn lymph, extrnod and solid org sites
 ;;^UTILITY(U,$J,358.3,28288,1,4,0)
 ;;=4^C81.29
 ;;^UTILITY(U,$J,358.3,28288,2)
 ;;=^5001420
 ;;^UTILITY(U,$J,358.3,28289,0)
 ;;=C81.30^^105^1378^48
 ;;^UTILITY(U,$J,358.3,28289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28289,1,3,0)
 ;;=3^Lymphocyte depleted classical Hodgkin lymphoma, unsp site
 ;;^UTILITY(U,$J,358.3,28289,1,4,0)
 ;;=4^C81.30
 ;;^UTILITY(U,$J,358.3,28289,2)
 ;;=^5001421
 ;;^UTILITY(U,$J,358.3,28290,0)
 ;;=C81.39^^105^1378^47
 ;;^UTILITY(U,$J,358.3,28290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28290,1,3,0)
 ;;=3^Lymphocy deplet class Hdgkn lymph, extrnod & solid org site
 ;;^UTILITY(U,$J,358.3,28290,1,4,0)
 ;;=4^C81.39
 ;;^UTILITY(U,$J,358.3,28290,2)
 ;;=^5001430
 ;;^UTILITY(U,$J,358.3,28291,0)
 ;;=C81.40^^105^1378^49
 ;;^UTILITY(U,$J,358.3,28291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28291,1,3,0)
 ;;=3^Lymphocyte-rich classical Hodgkin lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,28291,1,4,0)
 ;;=4^C81.40
 ;;^UTILITY(U,$J,358.3,28291,2)
 ;;=^5001431
 ;;^UTILITY(U,$J,358.3,28292,0)
 ;;=C81.49^^105^1378^44
 ;;^UTILITY(U,$J,358.3,28292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28292,1,3,0)
 ;;=3^Lymp-rich class Hodgkin lymph, extrnod and solid organ sites
 ;;^UTILITY(U,$J,358.3,28292,1,4,0)
 ;;=4^C81.49
 ;;^UTILITY(U,$J,358.3,28292,2)
 ;;=^5001440
 ;;^UTILITY(U,$J,358.3,28293,0)
 ;;=C81.99^^105^1378^42
 ;;^UTILITY(U,$J,358.3,28293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28293,1,3,0)
 ;;=3^Hodgkin lymphoma, unsp, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,28293,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,28293,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,28294,0)
 ;;=C81.90^^105^1378^43
 ;;^UTILITY(U,$J,358.3,28294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28294,1,3,0)
 ;;=3^Hodgkin lymphoma, unspecified, unspecified site
 ;;^UTILITY(U,$J,358.3,28294,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,28294,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,28295,0)
 ;;=C82.69^^105^1378^17
 ;;^UTILITY(U,$J,358.3,28295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28295,1,3,0)
 ;;=3^Cutan folicl center lymphoma, extrnod and solid organ sites
 ;;^UTILITY(U,$J,358.3,28295,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,28295,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,28296,0)
 ;;=C82.60^^105^1378^18
 ;;^UTILITY(U,$J,358.3,28296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28296,1,3,0)
 ;;=3^Cutaneous follicle center lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,28296,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,28296,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,28297,0)
 ;;=C82.49^^105^1378^33
 ;;^UTILITY(U,$J,358.3,28297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28297,1,3,0)
 ;;=3^Follicular lymphoma grade IIIb, extrnod and solid organ sites
 ;;^UTILITY(U,$J,358.3,28297,1,4,0)
 ;;=4^C82.49
 ;;^UTILITY(U,$J,358.3,28297,2)
 ;;=^5001510
 ;;^UTILITY(U,$J,358.3,28298,0)
 ;;=C82.40^^105^1378^34
