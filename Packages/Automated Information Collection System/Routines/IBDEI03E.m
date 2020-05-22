IBDEI03E ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8043,1,3,0)
 ;;=3^Abnormal imaging Pancreas
 ;;^UTILITY(U,$J,358.3,8043,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,8043,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,8044,0)
 ;;=Q45.1^^45^446^2
 ;;^UTILITY(U,$J,358.3,8044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8044,1,3,0)
 ;;=3^Annular pancreas
 ;;^UTILITY(U,$J,358.3,8044,1,4,0)
 ;;=4^Q45.1
 ;;^UTILITY(U,$J,358.3,8044,2)
 ;;=^5018700
 ;;^UTILITY(U,$J,358.3,8045,0)
 ;;=K86.89^^45^446^3
 ;;^UTILITY(U,$J,358.3,8045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8045,1,3,0)
 ;;=3^Atrophy of Pancreas
 ;;^UTILITY(U,$J,358.3,8045,1,4,0)
 ;;=4^K86.89
 ;;^UTILITY(U,$J,358.3,8045,2)
 ;;=^87974
 ;;^UTILITY(U,$J,358.3,8046,0)
 ;;=D13.6^^45^446^4
 ;;^UTILITY(U,$J,358.3,8046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8046,1,3,0)
 ;;=3^Benign neoplasm of Pancreas
 ;;^UTILITY(U,$J,358.3,8046,1,4,0)
 ;;=4^D13.6
 ;;^UTILITY(U,$J,358.3,8046,2)
 ;;=^5001978
 ;;^UTILITY(U,$J,358.3,8047,0)
 ;;=K86.81^^45^446^15
 ;;^UTILITY(U,$J,358.3,8047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8047,1,3,0)
 ;;=3^Pancreatic insufficiency (Exocrine)
 ;;^UTILITY(U,$J,358.3,8047,1,4,0)
 ;;=4^K86.81
 ;;^UTILITY(U,$J,358.3,8047,2)
 ;;=^7084481
 ;;^UTILITY(U,$J,358.3,8048,0)
 ;;=K85.82^^45^446^28
 ;;^UTILITY(U,$J,358.3,8048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8048,1,3,0)
 ;;=3^Pancreatitis,Acute Other w/ Infected necrosis
 ;;^UTILITY(U,$J,358.3,8048,1,4,0)
 ;;=4^K85.82
 ;;^UTILITY(U,$J,358.3,8048,2)
 ;;=^5138760
 ;;^UTILITY(U,$J,358.3,8049,0)
 ;;=K90.3^^45^446^34
 ;;^UTILITY(U,$J,358.3,8049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8049,1,3,0)
 ;;=3^Steatorrhea,Pancreatic
 ;;^UTILITY(U,$J,358.3,8049,1,4,0)
 ;;=4^K90.3
 ;;^UTILITY(U,$J,358.3,8049,2)
 ;;=^265301
 ;;^UTILITY(U,$J,358.3,8050,0)
 ;;=K86.9^^45^446^35
 ;;^UTILITY(U,$J,358.3,8050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8050,1,3,0)
 ;;=3^Disease of Pancreas,Unsp
 ;;^UTILITY(U,$J,358.3,8050,1,4,0)
 ;;=4^K86.9
 ;;^UTILITY(U,$J,358.3,8050,2)
 ;;=^5008892
 ;;^UTILITY(U,$J,358.3,8051,0)
 ;;=K86.89^^45^446^5
 ;;^UTILITY(U,$J,358.3,8051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8051,1,3,0)
 ;;=3^Calculus of Pancreas
 ;;^UTILITY(U,$J,358.3,8051,1,4,0)
 ;;=4^K86.89
 ;;^UTILITY(U,$J,358.3,8051,2)
 ;;=^87974
 ;;^UTILITY(U,$J,358.3,8052,0)
 ;;=K90.0^^45^447^10
 ;;^UTILITY(U,$J,358.3,8052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8052,1,3,0)
 ;;=3^Celiac disease
 ;;^UTILITY(U,$J,358.3,8052,1,4,0)
 ;;=4^K90.0
 ;;^UTILITY(U,$J,358.3,8052,2)
 ;;=^20828
 ;;^UTILITY(U,$J,358.3,8053,0)
 ;;=R93.3^^45^447^1
 ;;^UTILITY(U,$J,358.3,8053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8053,1,3,0)
 ;;=3^Abnormal imaging Digestive tract
 ;;^UTILITY(U,$J,358.3,8053,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,8053,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,8054,0)
 ;;=K31.811^^45^447^2
 ;;^UTILITY(U,$J,358.3,8054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8054,1,3,0)
 ;;=3^Angiodysplasia of Duodenum w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8054,1,4,0)
 ;;=4^K31.811
 ;;^UTILITY(U,$J,358.3,8054,2)
 ;;=^5008567
 ;;^UTILITY(U,$J,358.3,8055,0)
 ;;=K31.819^^45^447^3
 ;;^UTILITY(U,$J,358.3,8055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8055,1,3,0)
 ;;=3^Angiodysplasia of Duodenum w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8055,1,4,0)
 ;;=4^K31.819
 ;;^UTILITY(U,$J,358.3,8055,2)
 ;;=^5008568
 ;;^UTILITY(U,$J,358.3,8056,0)
 ;;=K55.8^^45^447^4
 ;;^UTILITY(U,$J,358.3,8056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8056,1,3,0)
 ;;=3^Angiodysplasia of Jejunum/Ileum
 ;;^UTILITY(U,$J,358.3,8056,1,4,0)
 ;;=4^K55.8
 ;;^UTILITY(U,$J,358.3,8056,2)
 ;;=^5008709
 ;;^UTILITY(U,$J,358.3,8057,0)
 ;;=D13.2^^45^447^5
 ;;^UTILITY(U,$J,358.3,8057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8057,1,3,0)
 ;;=3^Benign neoplasm,Duodenum
 ;;^UTILITY(U,$J,358.3,8057,1,4,0)
 ;;=4^D13.2
 ;;^UTILITY(U,$J,358.3,8057,2)
 ;;=^5001973
 ;;^UTILITY(U,$J,358.3,8058,0)
 ;;=D13.39^^45^447^6
 ;;^UTILITY(U,$J,358.3,8058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8058,1,3,0)
 ;;=3^Benign neoplasm,Other Sm Int
 ;;^UTILITY(U,$J,358.3,8058,1,4,0)
 ;;=4^D13.39
 ;;^UTILITY(U,$J,358.3,8058,2)
 ;;=^5001975
 ;;^UTILITY(U,$J,358.3,8059,0)
 ;;=D13.30^^45^447^7
 ;;^UTILITY(U,$J,358.3,8059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8059,1,3,0)
 ;;=3^Benign neoplasm,Unsp Sm Int
 ;;^UTILITY(U,$J,358.3,8059,1,4,0)
 ;;=4^D13.30
 ;;^UTILITY(U,$J,358.3,8059,2)
 ;;=^5001974
 ;;^UTILITY(U,$J,358.3,8060,0)
 ;;=K90.89^^45^447^8
 ;;^UTILITY(U,$J,358.3,8060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8060,1,3,0)
 ;;=3^Bile acid malabsorption
 ;;^UTILITY(U,$J,358.3,8060,1,4,0)
 ;;=4^K90.89
 ;;^UTILITY(U,$J,358.3,8060,2)
 ;;=^5008898
 ;;^UTILITY(U,$J,358.3,8061,0)
 ;;=D01.49^^45^447^9
 ;;^UTILITY(U,$J,358.3,8061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8061,1,3,0)
 ;;=3^Carcinoma in situ of Small Intestine
 ;;^UTILITY(U,$J,358.3,8061,1,4,0)
 ;;=4^D01.49
 ;;^UTILITY(U,$J,358.3,8061,2)
 ;;=^5001879
 ;;^UTILITY(U,$J,358.3,8062,0)
 ;;=K63.81^^45^447^11
 ;;^UTILITY(U,$J,358.3,8062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8062,1,3,0)
 ;;=3^Dieulafoy lesion of Duodenum
 ;;^UTILITY(U,$J,358.3,8062,1,4,0)
 ;;=4^K63.81
 ;;^UTILITY(U,$J,358.3,8062,2)
 ;;=^5008766
 ;;^UTILITY(U,$J,358.3,8063,0)
 ;;=K63.89^^45^447^12
 ;;^UTILITY(U,$J,358.3,8063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8063,1,3,0)
 ;;=3^Dieulafoy lesion of Intestine
 ;;^UTILITY(U,$J,358.3,8063,1,4,0)
 ;;=4^K63.89
 ;;^UTILITY(U,$J,358.3,8063,2)
 ;;=^5008767
 ;;^UTILITY(U,$J,358.3,8064,0)
 ;;=K57.11^^45^447^19
 ;;^UTILITY(U,$J,358.3,8064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8064,1,3,0)
 ;;=3^Diverticulosis Sm Int w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8064,1,4,0)
 ;;=4^K57.11
 ;;^UTILITY(U,$J,358.3,8064,2)
 ;;=^5008718
 ;;^UTILITY(U,$J,358.3,8065,0)
 ;;=K57.10^^45^447^20
 ;;^UTILITY(U,$J,358.3,8065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8065,1,3,0)
 ;;=3^Diverticulosis Sm Int w/o perf,abscess,or bleed
 ;;^UTILITY(U,$J,358.3,8065,1,4,0)
 ;;=4^K57.10
 ;;^UTILITY(U,$J,358.3,8065,2)
 ;;=^5008717
 ;;^UTILITY(U,$J,358.3,8066,0)
 ;;=K57.13^^45^447^15
 ;;^UTILITY(U,$J,358.3,8066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8066,1,3,0)
 ;;=3^Diverticulitis Sm Int w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8066,1,4,0)
 ;;=4^K57.13
 ;;^UTILITY(U,$J,358.3,8066,2)
 ;;=^5008720
 ;;^UTILITY(U,$J,358.3,8067,0)
 ;;=K57.00^^45^447^16
 ;;^UTILITY(U,$J,358.3,8067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8067,1,3,0)
 ;;=3^Diverticulitis Sm Int w/ Perf & Abscess
 ;;^UTILITY(U,$J,358.3,8067,1,4,0)
 ;;=4^K57.00
 ;;^UTILITY(U,$J,358.3,8067,2)
 ;;=^5008715
 ;;^UTILITY(U,$J,358.3,8068,0)
 ;;=K57.01^^45^447^17
 ;;^UTILITY(U,$J,358.3,8068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8068,1,3,0)
 ;;=3^Diverticulitis Sm Int w/ Perf,Abscess & Bleed
 ;;^UTILITY(U,$J,358.3,8068,1,4,0)
 ;;=4^K57.01
 ;;^UTILITY(U,$J,358.3,8068,2)
 ;;=^5008716
 ;;^UTILITY(U,$J,358.3,8069,0)
 ;;=K57.12^^45^447^18
 ;;^UTILITY(U,$J,358.3,8069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8069,1,3,0)
 ;;=3^Diverticulitis Sm Int w/o Perf,Abscess, or Bleed
 ;;^UTILITY(U,$J,358.3,8069,1,4,0)
 ;;=4^K57.12
 ;;^UTILITY(U,$J,358.3,8069,2)
 ;;=^5008719
 ;;^UTILITY(U,$J,358.3,8070,0)
 ;;=K52.81^^45^447^23
 ;;^UTILITY(U,$J,358.3,8070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8070,1,3,0)
 ;;=3^Eosinohilic Gastroenteritis
 ;;^UTILITY(U,$J,358.3,8070,1,4,0)
 ;;=4^K52.81
 ;;^UTILITY(U,$J,358.3,8070,2)
 ;;=^5008702
 ;;^UTILITY(U,$J,358.3,8071,0)
 ;;=K31.6^^45^447^24
 ;;^UTILITY(U,$J,358.3,8071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8071,1,3,0)
 ;;=3^Fistula of Duodenum
 ;;^UTILITY(U,$J,358.3,8071,1,4,0)
 ;;=4^K31.6
 ;;^UTILITY(U,$J,358.3,8071,2)
 ;;=^5008565
 ;;^UTILITY(U,$J,358.3,8072,0)
 ;;=K63.2^^45^447^25
 ;;^UTILITY(U,$J,358.3,8072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8072,1,3,0)
 ;;=3^Fistula of Intestine
 ;;^UTILITY(U,$J,358.3,8072,1,4,0)
 ;;=4^K63.2
 ;;^UTILITY(U,$J,358.3,8072,2)
 ;;=^5008762
 ;;^UTILITY(U,$J,358.3,8073,0)
 ;;=K52.22^^45^447^26
 ;;^UTILITY(U,$J,358.3,8073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8073,1,3,0)
 ;;=3^Food-Protein induced enteropathy
 ;;^UTILITY(U,$J,358.3,8073,1,4,0)
 ;;=4^K52.22
 ;;^UTILITY(U,$J,358.3,8073,2)
 ;;=^5138714
 ;;^UTILITY(U,$J,358.3,8074,0)
 ;;=T18.3XXA^^45^447^27
 ;;^UTILITY(U,$J,358.3,8074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8074,1,3,0)
 ;;=3^Foreign body in Sm Int,Initial
 ;;^UTILITY(U,$J,358.3,8074,1,4,0)
 ;;=4^T18.3XXA
 ;;^UTILITY(U,$J,358.3,8074,2)
 ;;=^5046606
 ;;^UTILITY(U,$J,358.3,8075,0)
 ;;=T18.3XXD^^45^447^29
 ;;^UTILITY(U,$J,358.3,8075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8075,1,3,0)
 ;;=3^Foreign body in Sm Int,Subsequent
 ;;^UTILITY(U,$J,358.3,8075,1,4,0)
 ;;=4^T18.3XXD
 ;;^UTILITY(U,$J,358.3,8075,2)
 ;;=^5046607
 ;;^UTILITY(U,$J,358.3,8076,0)
 ;;=T18.3XXS^^45^447^28
 ;;^UTILITY(U,$J,358.3,8076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8076,1,3,0)
 ;;=3^Foreign body in Sm Int,Sequela
 ;;^UTILITY(U,$J,358.3,8076,1,4,0)
 ;;=4^T18.3XXS
 ;;^UTILITY(U,$J,358.3,8076,2)
 ;;=^5046608
 ;;^UTILITY(U,$J,358.3,8077,0)
 ;;=K56.3^^45^447^30
 ;;^UTILITY(U,$J,358.3,8077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8077,1,3,0)
 ;;=3^Gallstone ileus
 ;;^UTILITY(U,$J,358.3,8077,1,4,0)
 ;;=4^K56.3
 ;;^UTILITY(U,$J,358.3,8077,2)
 ;;=^270259
 ;;^UTILITY(U,$J,358.3,8078,0)
 ;;=E88.09^^45^447^31
 ;;^UTILITY(U,$J,358.3,8078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8078,1,3,0)
 ;;=3^Hypoalbuminemia
 ;;^UTILITY(U,$J,358.3,8078,1,4,0)
 ;;=4^E88.09
 ;;^UTILITY(U,$J,358.3,8078,2)
 ;;=^5003027
 ;;^UTILITY(U,$J,358.3,8079,0)
 ;;=K56.0^^45^447^32
 ;;^UTILITY(U,$J,358.3,8079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8079,1,3,0)
 ;;=3^Ileus
 ;;^UTILITY(U,$J,358.3,8079,1,4,0)
 ;;=4^K56.0
 ;;^UTILITY(U,$J,358.3,8079,2)
 ;;=^89879
 ;;^UTILITY(U,$J,358.3,8080,0)
 ;;=K56.1^^45^447^35
 ;;^UTILITY(U,$J,358.3,8080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8080,1,3,0)
 ;;=3^Intussusception
 ;;^UTILITY(U,$J,358.3,8080,1,4,0)
 ;;=4^K56.1
 ;;^UTILITY(U,$J,358.3,8080,2)
 ;;=^65213
 ;;^UTILITY(U,$J,358.3,8081,0)
 ;;=K55.021^^45^447^34
 ;;^UTILITY(U,$J,358.3,8081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8081,1,3,0)
 ;;=3^Infarction of Sm Int,Acute Segmental
 ;;^UTILITY(U,$J,358.3,8081,1,4,0)
 ;;=4^K55.021
 ;;^UTILITY(U,$J,358.3,8081,2)
 ;;=^5138722
 ;;^UTILITY(U,$J,358.3,8082,0)
 ;;=K55.022^^45^447^33
 ;;^UTILITY(U,$J,358.3,8082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8082,1,3,0)
 ;;=3^Infarction of Sm Int,Acute Diffused
 ;;^UTILITY(U,$J,358.3,8082,1,4,0)
 ;;=4^K55.022
 ;;^UTILITY(U,$J,358.3,8082,2)
 ;;=^5138723
 ;;^UTILITY(U,$J,358.3,8083,0)
 ;;=K55.011^^45^447^37
 ;;^UTILITY(U,$J,358.3,8083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8083,1,3,0)
 ;;=3^Ischemia of Sm Int,Acute Segmental
 ;;^UTILITY(U,$J,358.3,8083,1,4,0)
 ;;=4^K55.011
 ;;^UTILITY(U,$J,358.3,8083,2)
 ;;=^5138719
 ;;^UTILITY(U,$J,358.3,8084,0)
 ;;=K55.012^^45^447^36
 ;;^UTILITY(U,$J,358.3,8084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8084,1,3,0)
 ;;=3^Ischemia of Sm Int,Acute Diffuse
 ;;^UTILITY(U,$J,358.3,8084,1,4,0)
 ;;=4^K55.012
 ;;^UTILITY(U,$J,358.3,8084,2)
 ;;=^5138720
 ;;^UTILITY(U,$J,358.3,8085,0)
 ;;=K55.1^^45^447^38
 ;;^UTILITY(U,$J,358.3,8085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8085,1,3,0)
 ;;=3^Ischemic Sm Int,Chronic
 ;;^UTILITY(U,$J,358.3,8085,1,4,0)
 ;;=4^K55.1
 ;;^UTILITY(U,$J,358.3,8085,2)
 ;;=^5008706
 ;;^UTILITY(U,$J,358.3,8086,0)
 ;;=K90.49^^45^447^39
 ;;^UTILITY(U,$J,358.3,8086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8086,1,3,0)
 ;;=3^Malabsortion d/t intolerance NEC
 ;;^UTILITY(U,$J,358.3,8086,1,4,0)
 ;;=4^K90.49
 ;;^UTILITY(U,$J,358.3,8086,2)
 ;;=^5008896
 ;;^UTILITY(U,$J,358.3,8087,0)
 ;;=C17.0^^45^447^40
 ;;^UTILITY(U,$J,358.3,8087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8087,1,3,0)
 ;;=3^Malignant neoplasm,Duodenum
 ;;^UTILITY(U,$J,358.3,8087,1,4,0)
 ;;=4^C17.0
 ;;^UTILITY(U,$J,358.3,8087,2)
 ;;=^267072
 ;;^UTILITY(U,$J,358.3,8088,0)
 ;;=C17.1^^45^447^42
 ;;^UTILITY(U,$J,358.3,8088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8088,1,3,0)
 ;;=3^Malignant neoplasm,Jejunum
 ;;^UTILITY(U,$J,358.3,8088,1,4,0)
 ;;=4^C17.1
 ;;^UTILITY(U,$J,358.3,8088,2)
 ;;=^267073
 ;;^UTILITY(U,$J,358.3,8089,0)
 ;;=C17.2^^45^447^41
 ;;^UTILITY(U,$J,358.3,8089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8089,1,3,0)
 ;;=3^Malignant neoplasm,Ileum
 ;;^UTILITY(U,$J,358.3,8089,1,4,0)
 ;;=4^C17.2
 ;;^UTILITY(U,$J,358.3,8089,2)
 ;;=^267074
 ;;^UTILITY(U,$J,358.3,8090,0)
 ;;=C17.9^^45^447^43
 ;;^UTILITY(U,$J,358.3,8090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8090,1,3,0)
 ;;=3^Malignant neoplasm,Unsp Sm Int
 ;;^UTILITY(U,$J,358.3,8090,1,4,0)
 ;;=4^C17.9
 ;;^UTILITY(U,$J,358.3,8090,2)
 ;;=^5000926
 ;;^UTILITY(U,$J,358.3,8091,0)
 ;;=K31.5^^45^447^44
 ;;^UTILITY(U,$J,358.3,8091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8091,1,3,0)
 ;;=3^Obstruction of Duodenum
 ;;^UTILITY(U,$J,358.3,8091,1,4,0)
 ;;=4^K31.5
 ;;^UTILITY(U,$J,358.3,8091,2)
 ;;=^5008564
 ;;^UTILITY(U,$J,358.3,8092,0)
 ;;=K63.1^^45^447^51
 ;;^UTILITY(U,$J,358.3,8092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8092,1,3,0)
 ;;=3^Perforation of Intestine (non-traumatic)
 ;;^UTILITY(U,$J,358.3,8092,1,4,0)
 ;;=4^K63.1
 ;;^UTILITY(U,$J,358.3,8092,2)
 ;;=^5008761
 ;;^UTILITY(U,$J,358.3,8093,0)
 ;;=K31.7^^45^447^52
 ;;^UTILITY(U,$J,358.3,8093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8093,1,3,0)
 ;;=3^Polyp of Duodenum
 ;;^UTILITY(U,$J,358.3,8093,1,4,0)
 ;;=4^K31.7
 ;;^UTILITY(U,$J,358.3,8093,2)
 ;;=^5008566
 ;;^UTILITY(U,$J,358.3,8094,0)
 ;;=K52.0^^45^447^53
 ;;^UTILITY(U,$J,358.3,8094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8094,1,3,0)
 ;;=3^Radiation-induced gastroenteritis & Colitis
 ;;^UTILITY(U,$J,358.3,8094,1,4,0)
 ;;=4^K52.0
 ;;^UTILITY(U,$J,358.3,8094,2)
 ;;=^270254
 ;;^UTILITY(U,$J,358.3,8095,0)
 ;;=K63.89^^45^447^54
 ;;^UTILITY(U,$J,358.3,8095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8095,1,3,0)
 ;;=3^Small Intestine bacterial overgrowth
 ;;^UTILITY(U,$J,358.3,8095,1,4,0)
 ;;=4^K63.89
 ;;^UTILITY(U,$J,358.3,8095,2)
 ;;=^5008767
 ;;^UTILITY(U,$J,358.3,8096,0)
 ;;=K26.0^^45^447^57
 ;;^UTILITY(U,$J,358.3,8096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8096,1,3,0)
 ;;=3^Ulcer,Duodenal,Acute w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8096,1,4,0)
 ;;=4^K26.0
 ;;^UTILITY(U,$J,358.3,8096,2)
 ;;=^270089
 ;;^UTILITY(U,$J,358.3,8097,0)
 ;;=K26.1^^45^447^58
 ;;^UTILITY(U,$J,358.3,8097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8097,1,3,0)
 ;;=3^Ulcer,Duodenal,Acute w/ Perforation
 ;;^UTILITY(U,$J,358.3,8097,1,4,0)
 ;;=4^K26.1
 ;;^UTILITY(U,$J,358.3,8097,2)
 ;;=^270092
 ;;^UTILITY(U,$J,358.3,8098,0)
 ;;=K26.2^^45^447^56
 ;;^UTILITY(U,$J,358.3,8098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8098,1,3,0)
 ;;=3^Ulcer,Duodenal,Acute w/ Bleed & Perf
 ;;^UTILITY(U,$J,358.3,8098,1,4,0)
 ;;=4^K26.2
 ;;^UTILITY(U,$J,358.3,8098,2)
 ;;=^5008523
 ;;^UTILITY(U,$J,358.3,8099,0)
 ;;=K26.3^^45^447^59
 ;;^UTILITY(U,$J,358.3,8099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8099,1,3,0)
 ;;=3^Ulcer,Duodenal,Acute w/o Bleed or Perf
 ;;^UTILITY(U,$J,358.3,8099,1,4,0)
 ;;=4^K26.3
 ;;^UTILITY(U,$J,358.3,8099,2)
 ;;=^5008524
 ;;^UTILITY(U,$J,358.3,8100,0)
 ;;=K26.4^^45^447^61
 ;;^UTILITY(U,$J,358.3,8100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8100,1,3,0)
 ;;=3^Ulcer,Duodenal,Chronic w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8100,1,4,0)
 ;;=4^K26.4
 ;;^UTILITY(U,$J,358.3,8100,2)
 ;;=^270101
 ;;^UTILITY(U,$J,358.3,8101,0)
 ;;=K26.5^^45^447^62
 ;;^UTILITY(U,$J,358.3,8101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8101,1,3,0)
 ;;=3^Ulcer,Duodenal,Chronic w/ Perforation
 ;;^UTILITY(U,$J,358.3,8101,1,4,0)
 ;;=4^K26.5
 ;;^UTILITY(U,$J,358.3,8101,2)
 ;;=^270104
 ;;^UTILITY(U,$J,358.3,8102,0)
 ;;=K26.6^^45^447^60
 ;;^UTILITY(U,$J,358.3,8102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8102,1,3,0)
 ;;=3^Ulcer,Duodenal,Chronic w/ Bleed & Perf
 ;;^UTILITY(U,$J,358.3,8102,1,4,0)
 ;;=4^K26.6
 ;;^UTILITY(U,$J,358.3,8102,2)
 ;;=^5008525
 ;;^UTILITY(U,$J,358.3,8103,0)
 ;;=K28.0^^45^447^65
 ;;^UTILITY(U,$J,358.3,8103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8103,1,3,0)
 ;;=3^Ulcer,Jejunal,Acute w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8103,1,4,0)
 ;;=4^K28.0
 ;;^UTILITY(U,$J,358.3,8103,2)
 ;;=^270141
 ;;^UTILITY(U,$J,358.3,8104,0)
 ;;=K28.1^^45^447^66
 ;;^UTILITY(U,$J,358.3,8104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8104,1,3,0)
 ;;=3^Ulcer,Jejunal,Acute w/ Perforation
 ;;^UTILITY(U,$J,358.3,8104,1,4,0)
 ;;=4^K28.1
 ;;^UTILITY(U,$J,358.3,8104,2)
 ;;=^270144
 ;;^UTILITY(U,$J,358.3,8105,0)
 ;;=K28.2^^45^447^64
 ;;^UTILITY(U,$J,358.3,8105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8105,1,3,0)
 ;;=3^Ulcer,Jejunal,Acute w/ Bleed & Perf
 ;;^UTILITY(U,$J,358.3,8105,1,4,0)
 ;;=4^K28.2
 ;;^UTILITY(U,$J,358.3,8105,2)
 ;;=^5008537
 ;;^UTILITY(U,$J,358.3,8106,0)
 ;;=K28.3^^45^447^67
 ;;^UTILITY(U,$J,358.3,8106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8106,1,3,0)
 ;;=3^Ulcer,Jejunal,Acute w/o Bleed or Perf
 ;;^UTILITY(U,$J,358.3,8106,1,4,0)
 ;;=4^K28.3
 ;;^UTILITY(U,$J,358.3,8106,2)
 ;;=^5008538
 ;;^UTILITY(U,$J,358.3,8107,0)
 ;;=K28.4^^45^447^69
 ;;^UTILITY(U,$J,358.3,8107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8107,1,3,0)
 ;;=3^Ulcer,Jejunal,Chronic w/ Bleeding
 ;;^UTILITY(U,$J,358.3,8107,1,4,0)
 ;;=4^K28.4
 ;;^UTILITY(U,$J,358.3,8107,2)
 ;;=^270153
 ;;^UTILITY(U,$J,358.3,8108,0)
 ;;=K28.5^^45^447^70
 ;;^UTILITY(U,$J,358.3,8108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8108,1,3,0)
 ;;=3^Ulcer,Jejunal,Chronic w/ Perforation
 ;;^UTILITY(U,$J,358.3,8108,1,4,0)
 ;;=4^K28.5
 ;;^UTILITY(U,$J,358.3,8108,2)
 ;;=^270156
 ;;^UTILITY(U,$J,358.3,8109,0)
 ;;=K28.6^^45^447^68
 ;;^UTILITY(U,$J,358.3,8109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8109,1,3,0)
 ;;=3^Ulcer,Jejunal,Chronic w/ Bleed & Perf
 ;;^UTILITY(U,$J,358.3,8109,1,4,0)
 ;;=4^K28.6
 ;;^UTILITY(U,$J,358.3,8109,2)
 ;;=^5008539
 ;;^UTILITY(U,$J,358.3,8110,0)
 ;;=K28.7^^45^447^71
 ;;^UTILITY(U,$J,358.3,8110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8110,1,3,0)
 ;;=3^Ulcer,Jejunal,Chronic w/o Bleed or Perf
 ;;^UTILITY(U,$J,358.3,8110,1,4,0)
 ;;=4^K28.7
 ;;^UTILITY(U,$J,358.3,8110,2)
 ;;=^5008540
 ;;^UTILITY(U,$J,358.3,8111,0)
 ;;=K63.3^^45^447^55
 ;;^UTILITY(U,$J,358.3,8111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8111,1,3,0)
 ;;=3^Ulcer of Intestine w/o Perforation
 ;;^UTILITY(U,$J,358.3,8111,1,4,0)
 ;;=4^K63.3
 ;;^UTILITY(U,$J,358.3,8111,2)
 ;;=^5008763
 ;;^UTILITY(U,$J,358.3,8112,0)
 ;;=K55.8^^45^447^72
 ;;^UTILITY(U,$J,358.3,8112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8112,1,3,0)
 ;;=3^Vascular disorders of Intestine,Other
 ;;^UTILITY(U,$J,358.3,8112,1,4,0)
 ;;=4^K55.8
 ;;^UTILITY(U,$J,358.3,8112,2)
 ;;=^5008709
 ;;^UTILITY(U,$J,358.3,8113,0)
 ;;=K56.2^^45^447^73
 ;;^UTILITY(U,$J,358.3,8113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8113,1,3,0)
 ;;=3^Volvulus
 ;;^UTILITY(U,$J,358.3,8113,1,4,0)
 ;;=4^K56.2
