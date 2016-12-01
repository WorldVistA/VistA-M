IBDEI0GU ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21331,0)
 ;;=B17.8^^58^835^66
 ;;^UTILITY(U,$J,358.3,21331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21331,1,3,0)
 ;;=3^Hepatitis,Oth Spec Acute Viral
 ;;^UTILITY(U,$J,358.3,21331,1,4,0)
 ;;=4^B17.8
 ;;^UTILITY(U,$J,358.3,21331,2)
 ;;=^5000544
 ;;^UTILITY(U,$J,358.3,21332,0)
 ;;=B18.9^^58^835^64
 ;;^UTILITY(U,$J,358.3,21332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21332,1,3,0)
 ;;=3^Hepatitis,Chronic Viral Unspec
 ;;^UTILITY(U,$J,358.3,21332,1,4,0)
 ;;=4^B18.9
 ;;^UTILITY(U,$J,358.3,21332,2)
 ;;=^5000550
 ;;^UTILITY(U,$J,358.3,21333,0)
 ;;=B37.81^^58^835^18
 ;;^UTILITY(U,$J,358.3,21333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21333,1,3,0)
 ;;=3^Candidal Esophagitis
 ;;^UTILITY(U,$J,358.3,21333,1,4,0)
 ;;=4^B37.81
 ;;^UTILITY(U,$J,358.3,21333,2)
 ;;=^5000620
 ;;^UTILITY(U,$J,358.3,21334,0)
 ;;=D12.0^^58^835^12
 ;;^UTILITY(U,$J,358.3,21334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21334,1,3,0)
 ;;=3^Benign Neop of Cecum
 ;;^UTILITY(U,$J,358.3,21334,1,4,0)
 ;;=4^D12.0
 ;;^UTILITY(U,$J,358.3,21334,2)
 ;;=^5001963
 ;;^UTILITY(U,$J,358.3,21335,0)
 ;;=D12.6^^58^835^13
 ;;^UTILITY(U,$J,358.3,21335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21335,1,3,0)
 ;;=3^Benign Neop of Colon,Unspec
 ;;^UTILITY(U,$J,358.3,21335,1,4,0)
 ;;=4^D12.6
 ;;^UTILITY(U,$J,358.3,21335,2)
 ;;=^5001969
 ;;^UTILITY(U,$J,358.3,21336,0)
 ;;=D12.1^^58^835^10
 ;;^UTILITY(U,$J,358.3,21336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21336,1,3,0)
 ;;=3^Benign Neop of Appendix
 ;;^UTILITY(U,$J,358.3,21336,1,4,0)
 ;;=4^D12.1
 ;;^UTILITY(U,$J,358.3,21336,2)
 ;;=^5001964
 ;;^UTILITY(U,$J,358.3,21337,0)
 ;;=K63.5^^58^835^73
 ;;^UTILITY(U,$J,358.3,21337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21337,1,3,0)
 ;;=3^Polyp of Colon
 ;;^UTILITY(U,$J,358.3,21337,1,4,0)
 ;;=4^K63.5
 ;;^UTILITY(U,$J,358.3,21337,2)
 ;;=^5008765
 ;;^UTILITY(U,$J,358.3,21338,0)
 ;;=D12.3^^58^835^17
 ;;^UTILITY(U,$J,358.3,21338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21338,1,3,0)
 ;;=3^Benign Neop of Transverse Colon
 ;;^UTILITY(U,$J,358.3,21338,1,4,0)
 ;;=4^D12.3
 ;;^UTILITY(U,$J,358.3,21338,2)
 ;;=^5001966
 ;;^UTILITY(U,$J,358.3,21339,0)
 ;;=D12.2^^58^835^11
 ;;^UTILITY(U,$J,358.3,21339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21339,1,3,0)
 ;;=3^Benign Neop of Ascending Colon
 ;;^UTILITY(U,$J,358.3,21339,1,4,0)
 ;;=4^D12.2
 ;;^UTILITY(U,$J,358.3,21339,2)
 ;;=^5001965
 ;;^UTILITY(U,$J,358.3,21340,0)
 ;;=D12.5^^58^835^16
 ;;^UTILITY(U,$J,358.3,21340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21340,1,3,0)
 ;;=3^Benign Neop of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,21340,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,21340,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,21341,0)
 ;;=D12.4^^58^835^14
 ;;^UTILITY(U,$J,358.3,21341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21341,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,21341,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,21341,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,21342,0)
 ;;=D73.2^^58^835^19
 ;;^UTILITY(U,$J,358.3,21342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21342,1,3,0)
 ;;=3^Congestive Splenomegaly,Chronic
 ;;^UTILITY(U,$J,358.3,21342,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,21342,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,21343,0)
 ;;=I85.00^^58^835^46
 ;;^UTILITY(U,$J,358.3,21343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21343,1,3,0)
 ;;=3^Esophageal Varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,21343,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,21343,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,21344,0)
 ;;=K20.9^^58^835^47
 ;;^UTILITY(U,$J,358.3,21344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21344,1,3,0)
 ;;=3^Esophagitis,Unspec
 ;;^UTILITY(U,$J,358.3,21344,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,21344,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,21345,0)
 ;;=K21.9^^58^835^55
 ;;^UTILITY(U,$J,358.3,21345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21345,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,21345,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,21345,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,21346,0)
 ;;=K25.7^^58^835^50
 ;;^UTILITY(U,$J,358.3,21346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21346,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,21346,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,21346,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,21347,0)
 ;;=K26.9^^58^835^44
 ;;^UTILITY(U,$J,358.3,21347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21347,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,21347,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,21347,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,21348,0)
 ;;=K27.9^^58^835^72
 ;;^UTILITY(U,$J,358.3,21348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21348,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,21348,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,21348,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,21349,0)
 ;;=K29.70^^58^835^51
 ;;^UTILITY(U,$J,358.3,21349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21349,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,21349,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,21349,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,21350,0)
 ;;=K29.90^^58^835^52
 ;;^UTILITY(U,$J,358.3,21350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21350,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,21350,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,21350,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,21351,0)
 ;;=K30.^^58^835^45
 ;;^UTILITY(U,$J,358.3,21351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21351,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,21351,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,21351,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,21352,0)
 ;;=K31.89^^58^835^34
 ;;^UTILITY(U,$J,358.3,21352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21352,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,21352,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,21352,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,21353,0)
 ;;=K31.9^^58^835^33
 ;;^UTILITY(U,$J,358.3,21353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21353,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,21353,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,21353,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,21354,0)
 ;;=K40.90^^58^835^68
 ;;^UTILITY(U,$J,358.3,21354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21354,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,21354,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,21354,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,21355,0)
 ;;=K40.20^^58^835^67
 ;;^UTILITY(U,$J,358.3,21355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21355,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,21355,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,21355,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,21356,0)
 ;;=K44.9^^58^835^31
 ;;^UTILITY(U,$J,358.3,21356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21356,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,21356,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,21356,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,21357,0)
 ;;=K46.9^^58^835^1
 ;;^UTILITY(U,$J,358.3,21357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21357,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,21357,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,21357,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,21358,0)
 ;;=K50.90^^58^835^29
 ;;^UTILITY(U,$J,358.3,21358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21358,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,21358,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,21358,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,21359,0)
 ;;=K50.911^^58^835^27
 ;;^UTILITY(U,$J,358.3,21359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21359,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,21359,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,21359,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,21360,0)
 ;;=K50.912^^58^835^25
 ;;^UTILITY(U,$J,358.3,21360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21360,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,21360,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,21360,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,21361,0)
 ;;=K50.919^^58^835^28
 ;;^UTILITY(U,$J,358.3,21361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21361,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,21361,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,21361,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,21362,0)
 ;;=K50.914^^58^835^23
 ;;^UTILITY(U,$J,358.3,21362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21362,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,21362,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,21362,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,21363,0)
 ;;=K50.913^^58^835^24
 ;;^UTILITY(U,$J,358.3,21363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21363,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,21363,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,21363,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,21364,0)
 ;;=K50.918^^58^835^26
 ;;^UTILITY(U,$J,358.3,21364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21364,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,21364,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,21364,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,21365,0)
 ;;=K51.90^^58^835^80
 ;;^UTILITY(U,$J,358.3,21365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21365,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,21365,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,21365,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,21366,0)
 ;;=K51.919^^58^835^79
 ;;^UTILITY(U,$J,358.3,21366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21366,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
