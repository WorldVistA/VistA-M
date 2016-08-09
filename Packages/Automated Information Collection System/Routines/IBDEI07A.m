IBDEI07A ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7194,1,3,0)
 ;;=3^Hepatitis,Chronic Viral Unspec
 ;;^UTILITY(U,$J,358.3,7194,1,4,0)
 ;;=4^B18.9
 ;;^UTILITY(U,$J,358.3,7194,2)
 ;;=^5000550
 ;;^UTILITY(U,$J,358.3,7195,0)
 ;;=B37.81^^42^493^18
 ;;^UTILITY(U,$J,358.3,7195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7195,1,3,0)
 ;;=3^Candidal Esophagitis
 ;;^UTILITY(U,$J,358.3,7195,1,4,0)
 ;;=4^B37.81
 ;;^UTILITY(U,$J,358.3,7195,2)
 ;;=^5000620
 ;;^UTILITY(U,$J,358.3,7196,0)
 ;;=D12.0^^42^493^12
 ;;^UTILITY(U,$J,358.3,7196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7196,1,3,0)
 ;;=3^Benign Neop of Cecum
 ;;^UTILITY(U,$J,358.3,7196,1,4,0)
 ;;=4^D12.0
 ;;^UTILITY(U,$J,358.3,7196,2)
 ;;=^5001963
 ;;^UTILITY(U,$J,358.3,7197,0)
 ;;=D12.6^^42^493^13
 ;;^UTILITY(U,$J,358.3,7197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7197,1,3,0)
 ;;=3^Benign Neop of Colon,Unspec
 ;;^UTILITY(U,$J,358.3,7197,1,4,0)
 ;;=4^D12.6
 ;;^UTILITY(U,$J,358.3,7197,2)
 ;;=^5001969
 ;;^UTILITY(U,$J,358.3,7198,0)
 ;;=D12.1^^42^493^10
 ;;^UTILITY(U,$J,358.3,7198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7198,1,3,0)
 ;;=3^Benign Neop of Appendix
 ;;^UTILITY(U,$J,358.3,7198,1,4,0)
 ;;=4^D12.1
 ;;^UTILITY(U,$J,358.3,7198,2)
 ;;=^5001964
 ;;^UTILITY(U,$J,358.3,7199,0)
 ;;=K63.5^^42^493^76
 ;;^UTILITY(U,$J,358.3,7199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7199,1,3,0)
 ;;=3^Polyp of Colon
 ;;^UTILITY(U,$J,358.3,7199,1,4,0)
 ;;=4^K63.5
 ;;^UTILITY(U,$J,358.3,7199,2)
 ;;=^5008765
 ;;^UTILITY(U,$J,358.3,7200,0)
 ;;=D12.3^^42^493^17
 ;;^UTILITY(U,$J,358.3,7200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7200,1,3,0)
 ;;=3^Benign Neop of Transverse Colon
 ;;^UTILITY(U,$J,358.3,7200,1,4,0)
 ;;=4^D12.3
 ;;^UTILITY(U,$J,358.3,7200,2)
 ;;=^5001966
 ;;^UTILITY(U,$J,358.3,7201,0)
 ;;=D12.2^^42^493^11
 ;;^UTILITY(U,$J,358.3,7201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7201,1,3,0)
 ;;=3^Benign Neop of Ascending Colon
 ;;^UTILITY(U,$J,358.3,7201,1,4,0)
 ;;=4^D12.2
 ;;^UTILITY(U,$J,358.3,7201,2)
 ;;=^5001965
 ;;^UTILITY(U,$J,358.3,7202,0)
 ;;=D12.5^^42^493^16
 ;;^UTILITY(U,$J,358.3,7202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7202,1,3,0)
 ;;=3^Benign Neop of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,7202,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,7202,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,7203,0)
 ;;=D12.4^^42^493^14
 ;;^UTILITY(U,$J,358.3,7203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7203,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,7203,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,7203,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,7204,0)
 ;;=D73.2^^42^493^19
 ;;^UTILITY(U,$J,358.3,7204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7204,1,3,0)
 ;;=3^Congestive Splenomegaly,Chronic
 ;;^UTILITY(U,$J,358.3,7204,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,7204,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,7205,0)
 ;;=I85.00^^42^493^47
 ;;^UTILITY(U,$J,358.3,7205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7205,1,3,0)
 ;;=3^Esophageal Varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,7205,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,7205,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,7206,0)
 ;;=K20.9^^42^493^48
 ;;^UTILITY(U,$J,358.3,7206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7206,1,3,0)
 ;;=3^Esophagitis,Unspec
 ;;^UTILITY(U,$J,358.3,7206,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,7206,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,7207,0)
 ;;=K21.9^^42^493^56
 ;;^UTILITY(U,$J,358.3,7207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7207,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,7207,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,7207,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,7208,0)
 ;;=K25.7^^42^493^51
 ;;^UTILITY(U,$J,358.3,7208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7208,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,7208,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,7208,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,7209,0)
 ;;=K26.9^^42^493^44
 ;;^UTILITY(U,$J,358.3,7209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7209,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,7209,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,7209,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,7210,0)
 ;;=K27.9^^42^493^74
 ;;^UTILITY(U,$J,358.3,7210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7210,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,7210,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,7210,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,7211,0)
 ;;=K29.70^^42^493^52
 ;;^UTILITY(U,$J,358.3,7211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7211,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,7211,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,7211,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,7212,0)
 ;;=K29.90^^42^493^53
 ;;^UTILITY(U,$J,358.3,7212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7212,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,7212,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,7212,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,7213,0)
 ;;=K30.^^42^493^45
 ;;^UTILITY(U,$J,358.3,7213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7213,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,7213,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,7213,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,7214,0)
 ;;=K31.89^^42^493^34
 ;;^UTILITY(U,$J,358.3,7214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7214,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,7214,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,7214,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,7215,0)
 ;;=K31.9^^42^493^33
 ;;^UTILITY(U,$J,358.3,7215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7215,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,7215,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,7215,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,7216,0)
 ;;=K40.90^^42^493^69
 ;;^UTILITY(U,$J,358.3,7216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7216,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,7216,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,7216,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,7217,0)
 ;;=K40.20^^42^493^68
 ;;^UTILITY(U,$J,358.3,7217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7217,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,7217,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,7217,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,7218,0)
 ;;=K44.9^^42^493^31
 ;;^UTILITY(U,$J,358.3,7218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7218,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,7218,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,7218,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,7219,0)
 ;;=K46.9^^42^493^1
 ;;^UTILITY(U,$J,358.3,7219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7219,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,7219,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,7219,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,7220,0)
 ;;=K50.90^^42^493^29
 ;;^UTILITY(U,$J,358.3,7220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7220,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,7220,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,7220,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,7221,0)
 ;;=K50.911^^42^493^27
 ;;^UTILITY(U,$J,358.3,7221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7221,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,7221,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,7221,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,7222,0)
 ;;=K50.912^^42^493^25
 ;;^UTILITY(U,$J,358.3,7222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7222,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,7222,1,4,0)
 ;;=4^K50.912
