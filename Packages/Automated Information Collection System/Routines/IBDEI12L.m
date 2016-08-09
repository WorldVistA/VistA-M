IBDEI12L ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38854,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,38854,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,38855,0)
 ;;=D12.4^^148^1942^14
 ;;^UTILITY(U,$J,358.3,38855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38855,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,38855,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,38855,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,38856,0)
 ;;=D73.2^^148^1942^19
 ;;^UTILITY(U,$J,358.3,38856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38856,1,3,0)
 ;;=3^Congestive Splenomegaly,Chronic
 ;;^UTILITY(U,$J,358.3,38856,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,38856,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,38857,0)
 ;;=I85.00^^148^1942^46
 ;;^UTILITY(U,$J,358.3,38857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38857,1,3,0)
 ;;=3^Esophageal Varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,38857,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,38857,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,38858,0)
 ;;=K20.9^^148^1942^47
 ;;^UTILITY(U,$J,358.3,38858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38858,1,3,0)
 ;;=3^Esophagitis,Unspec
 ;;^UTILITY(U,$J,358.3,38858,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,38858,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,38859,0)
 ;;=K21.9^^148^1942^55
 ;;^UTILITY(U,$J,358.3,38859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38859,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,38859,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,38859,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,38860,0)
 ;;=K25.7^^148^1942^50
 ;;^UTILITY(U,$J,358.3,38860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38860,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,38860,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,38860,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,38861,0)
 ;;=K26.9^^148^1942^44
 ;;^UTILITY(U,$J,358.3,38861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38861,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,38861,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,38861,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,38862,0)
 ;;=K27.9^^148^1942^72
 ;;^UTILITY(U,$J,358.3,38862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38862,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,38862,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,38862,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,38863,0)
 ;;=K29.70^^148^1942^51
 ;;^UTILITY(U,$J,358.3,38863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38863,1,3,0)
 ;;=3^Gastritis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,38863,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,38863,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,38864,0)
 ;;=K29.90^^148^1942^52
 ;;^UTILITY(U,$J,358.3,38864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38864,1,3,0)
 ;;=3^Gastroduodenitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,38864,1,4,0)
 ;;=4^K29.90
 ;;^UTILITY(U,$J,358.3,38864,2)
 ;;=^5008556
 ;;^UTILITY(U,$J,358.3,38865,0)
 ;;=K30.^^148^1942^45
 ;;^UTILITY(U,$J,358.3,38865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38865,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,38865,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,38865,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,38866,0)
 ;;=K31.89^^148^1942^34
 ;;^UTILITY(U,$J,358.3,38866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38866,1,3,0)
 ;;=3^Diseases of Stomach & Duodenum,Other
 ;;^UTILITY(U,$J,358.3,38866,1,4,0)
 ;;=4^K31.89
 ;;^UTILITY(U,$J,358.3,38866,2)
 ;;=^5008569
 ;;^UTILITY(U,$J,358.3,38867,0)
 ;;=K31.9^^148^1942^33
 ;;^UTILITY(U,$J,358.3,38867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38867,1,3,0)
 ;;=3^Disease of Stomach & Duodenum,Unspec
 ;;^UTILITY(U,$J,358.3,38867,1,4,0)
 ;;=4^K31.9
 ;;^UTILITY(U,$J,358.3,38867,2)
 ;;=^5008570
 ;;^UTILITY(U,$J,358.3,38868,0)
 ;;=K40.90^^148^1942^68
 ;;^UTILITY(U,$J,358.3,38868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38868,1,3,0)
 ;;=3^Inguinal Hernia,Unilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,38868,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,38868,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,38869,0)
 ;;=K40.20^^148^1942^67
 ;;^UTILITY(U,$J,358.3,38869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38869,1,3,0)
 ;;=3^Inguinal Hernia,Bilat w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,38869,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,38869,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,38870,0)
 ;;=K44.9^^148^1942^31
 ;;^UTILITY(U,$J,358.3,38870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38870,1,3,0)
 ;;=3^Diaphragmatic Hernia w/o Obst or Gangrene
 ;;^UTILITY(U,$J,358.3,38870,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,38870,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,38871,0)
 ;;=K46.9^^148^1942^1
 ;;^UTILITY(U,$J,358.3,38871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38871,1,3,0)
 ;;=3^Abdominal Hernia w/o Obst or Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,38871,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,38871,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,38872,0)
 ;;=K50.90^^148^1942^29
 ;;^UTILITY(U,$J,358.3,38872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38872,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,38872,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,38872,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,38873,0)
 ;;=K50.911^^148^1942^27
 ;;^UTILITY(U,$J,358.3,38873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38873,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,38873,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,38873,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,38874,0)
 ;;=K50.912^^148^1942^25
 ;;^UTILITY(U,$J,358.3,38874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38874,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,38874,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,38874,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,38875,0)
 ;;=K50.919^^148^1942^28
 ;;^UTILITY(U,$J,358.3,38875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38875,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,38875,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,38875,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,38876,0)
 ;;=K50.914^^148^1942^23
 ;;^UTILITY(U,$J,358.3,38876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38876,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,38876,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,38876,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,38877,0)
 ;;=K50.913^^148^1942^24
 ;;^UTILITY(U,$J,358.3,38877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38877,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,38877,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,38877,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,38878,0)
 ;;=K50.918^^148^1942^26
 ;;^UTILITY(U,$J,358.3,38878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38878,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,38878,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,38878,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,38879,0)
 ;;=K51.90^^148^1942^80
 ;;^UTILITY(U,$J,358.3,38879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38879,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,38879,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,38879,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,38880,0)
 ;;=K51.919^^148^1942^79
 ;;^UTILITY(U,$J,358.3,38880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38880,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,38880,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,38880,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,38881,0)
 ;;=K51.918^^148^1942^77
 ;;^UTILITY(U,$J,358.3,38881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38881,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,38881,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,38881,2)
 ;;=^5008699
