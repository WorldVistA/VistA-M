IBDEI04B ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4050,0)
 ;;=C25.3^^30^305^73
 ;;^UTILITY(U,$J,358.3,4050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4050,1,3,0)
 ;;=3^Malig Neop of Pancreatic Duct
 ;;^UTILITY(U,$J,358.3,4050,1,4,0)
 ;;=4^C25.3
 ;;^UTILITY(U,$J,358.3,4050,2)
 ;;=^267107
 ;;^UTILITY(U,$J,358.3,4051,0)
 ;;=C25.4^^30^305^58
 ;;^UTILITY(U,$J,358.3,4051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4051,1,3,0)
 ;;=3^Malig Neop of Endocrine Pancreas
 ;;^UTILITY(U,$J,358.3,4051,1,4,0)
 ;;=4^C25.4
 ;;^UTILITY(U,$J,358.3,4051,2)
 ;;=^5000943
 ;;^UTILITY(U,$J,358.3,4052,0)
 ;;=C25.7^^30^305^71
 ;;^UTILITY(U,$J,358.3,4052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4052,1,3,0)
 ;;=3^Malig Neop of Pancreas NEC
 ;;^UTILITY(U,$J,358.3,4052,1,4,0)
 ;;=4^C25.7
 ;;^UTILITY(U,$J,358.3,4052,2)
 ;;=^5000944
 ;;^UTILITY(U,$J,358.3,4053,0)
 ;;=C25.8^^30^305^69
 ;;^UTILITY(U,$J,358.3,4053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4053,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Pancreas
 ;;^UTILITY(U,$J,358.3,4053,1,4,0)
 ;;=4^C25.8
 ;;^UTILITY(U,$J,358.3,4053,2)
 ;;=^5000945
 ;;^UTILITY(U,$J,358.3,4054,0)
 ;;=C25.9^^30^305^72
 ;;^UTILITY(U,$J,358.3,4054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4054,1,3,0)
 ;;=3^Malig Neop of Pancreas,Unspec
 ;;^UTILITY(U,$J,358.3,4054,1,4,0)
 ;;=4^C25.9
 ;;^UTILITY(U,$J,358.3,4054,2)
 ;;=^5000946
 ;;^UTILITY(U,$J,358.3,4055,0)
 ;;=D12.0^^30^305^8
 ;;^UTILITY(U,$J,358.3,4055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4055,1,3,0)
 ;;=3^Benign Neop of Cecum
 ;;^UTILITY(U,$J,358.3,4055,1,4,0)
 ;;=4^D12.0
 ;;^UTILITY(U,$J,358.3,4055,2)
 ;;=^5001963
 ;;^UTILITY(U,$J,358.3,4056,0)
 ;;=D12.1^^30^305^6
 ;;^UTILITY(U,$J,358.3,4056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4056,1,3,0)
 ;;=3^Benign Neop of Appendix
 ;;^UTILITY(U,$J,358.3,4056,1,4,0)
 ;;=4^D12.1
 ;;^UTILITY(U,$J,358.3,4056,2)
 ;;=^5001964
 ;;^UTILITY(U,$J,358.3,4057,0)
 ;;=D12.2^^30^305^7
 ;;^UTILITY(U,$J,358.3,4057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4057,1,3,0)
 ;;=3^Benign Neop of Ascending Colon
 ;;^UTILITY(U,$J,358.3,4057,1,4,0)
 ;;=4^D12.2
 ;;^UTILITY(U,$J,358.3,4057,2)
 ;;=^5001965
 ;;^UTILITY(U,$J,358.3,4058,0)
 ;;=D12.3^^30^305^12
 ;;^UTILITY(U,$J,358.3,4058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4058,1,3,0)
 ;;=3^Benign Neop of Transverse Colon
 ;;^UTILITY(U,$J,358.3,4058,1,4,0)
 ;;=4^D12.3
 ;;^UTILITY(U,$J,358.3,4058,2)
 ;;=^5001966
 ;;^UTILITY(U,$J,358.3,4059,0)
 ;;=D12.4^^30^305^10
 ;;^UTILITY(U,$J,358.3,4059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4059,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,4059,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,4059,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,4060,0)
 ;;=D12.5^^30^305^11
 ;;^UTILITY(U,$J,358.3,4060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4060,1,3,0)
 ;;=3^Benign Neop of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,4060,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,4060,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,4061,0)
 ;;=D12.6^^30^305^9
 ;;^UTILITY(U,$J,358.3,4061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4061,1,3,0)
 ;;=3^Benign Neop of Colon,Unspec
 ;;^UTILITY(U,$J,358.3,4061,1,4,0)
 ;;=4^D12.6
 ;;^UTILITY(U,$J,358.3,4061,2)
 ;;=^5001969
 ;;^UTILITY(U,$J,358.3,4062,0)
 ;;=E66.01^^30^305^85
 ;;^UTILITY(U,$J,358.3,4062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4062,1,3,0)
 ;;=3^Morbid Obesity d/t Excess Calories
 ;;^UTILITY(U,$J,358.3,4062,1,4,0)
 ;;=4^E66.01
 ;;^UTILITY(U,$J,358.3,4062,2)
 ;;=^5002826
 ;;^UTILITY(U,$J,358.3,4063,0)
 ;;=E66.9^^30^305^86
 ;;^UTILITY(U,$J,358.3,4063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4063,1,3,0)
 ;;=3^Obesity,Unspec
 ;;^UTILITY(U,$J,358.3,4063,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,4063,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,4064,0)
 ;;=K21.9^^30^305^35
 ;;^UTILITY(U,$J,358.3,4064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4064,1,3,0)
 ;;=3^Gastro-Esophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,4064,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,4064,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,4065,0)
 ;;=K22.10^^30^305^32
 ;;^UTILITY(U,$J,358.3,4065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4065,1,3,0)
 ;;=3^Esophagus Ulcer w/o Bleeding
 ;;^UTILITY(U,$J,358.3,4065,1,4,0)
 ;;=4^K22.10
 ;;^UTILITY(U,$J,358.3,4065,2)
 ;;=^329929
 ;;^UTILITY(U,$J,358.3,4066,0)
 ;;=K22.2^^30^305^31
 ;;^UTILITY(U,$J,358.3,4066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4066,1,3,0)
 ;;=3^Esophageal Obstruction
 ;;^UTILITY(U,$J,358.3,4066,1,4,0)
 ;;=4^K22.2
 ;;^UTILITY(U,$J,358.3,4066,2)
 ;;=^5008507
 ;;^UTILITY(U,$J,358.3,4067,0)
 ;;=K25.9^^30^305^34
 ;;^UTILITY(U,$J,358.3,4067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4067,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,4067,1,4,0)
 ;;=4^K25.9
 ;;^UTILITY(U,$J,358.3,4067,2)
 ;;=^5008522
 ;;^UTILITY(U,$J,358.3,4068,0)
 ;;=K27.9^^30^305^87
 ;;^UTILITY(U,$J,358.3,4068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4068,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,4068,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,4068,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,4069,0)
 ;;=K40.20^^30^305^13
 ;;^UTILITY(U,$J,358.3,4069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4069,1,3,0)
 ;;=3^Bilateral Inguinal Hernia
 ;;^UTILITY(U,$J,358.3,4069,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,4069,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,4070,0)
 ;;=K40.90^^30^305^94
 ;;^UTILITY(U,$J,358.3,4070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4070,1,3,0)
 ;;=3^Unilateral Inguinal Hernia
 ;;^UTILITY(U,$J,358.3,4070,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,4070,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,4071,0)
 ;;=K42.9^^30^305^93
 ;;^UTILITY(U,$J,358.3,4071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4071,1,3,0)
 ;;=3^Umbilical Hernia w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,4071,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,4071,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,4072,0)
 ;;=K43.9^^30^305^95
 ;;^UTILITY(U,$J,358.3,4072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4072,1,3,0)
 ;;=3^Ventral Hernia w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,4072,1,4,0)
 ;;=4^K43.9
 ;;^UTILITY(U,$J,358.3,4072,2)
 ;;=^5008615
 ;;^UTILITY(U,$J,358.3,4073,0)
 ;;=K44.9^^30^305^24
 ;;^UTILITY(U,$J,358.3,4073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4073,1,3,0)
 ;;=3^Diaphragmatic Hernia
 ;;^UTILITY(U,$J,358.3,4073,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,4073,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,4074,0)
 ;;=K56.49^^30^305^43
 ;;^UTILITY(U,$J,358.3,4074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4074,1,3,0)
 ;;=3^Impaction of Intestine NEC
 ;;^UTILITY(U,$J,358.3,4074,1,4,0)
 ;;=4^K56.49
 ;;^UTILITY(U,$J,358.3,4074,2)
 ;;=^87650
 ;;^UTILITY(U,$J,358.3,4075,0)
 ;;=K58.0^^30^305^46
 ;;^UTILITY(U,$J,358.3,4075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4075,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/ Diarrhea
 ;;^UTILITY(U,$J,358.3,4075,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,4075,2)
 ;;=^5008739
 ;;^UTILITY(U,$J,358.3,4076,0)
 ;;=K58.9^^30^305^47
 ;;^UTILITY(U,$J,358.3,4076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4076,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/o Diarrhea
 ;;^UTILITY(U,$J,358.3,4076,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,4076,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,4077,0)
 ;;=K59.00^^30^305^22
 ;;^UTILITY(U,$J,358.3,4077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4077,1,3,0)
 ;;=3^Constipation,Unspec
 ;;^UTILITY(U,$J,358.3,4077,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,4077,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,4078,0)
 ;;=K61.0^^30^305^4
 ;;^UTILITY(U,$J,358.3,4078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4078,1,3,0)
 ;;=3^Anal Abscess
 ;;^UTILITY(U,$J,358.3,4078,1,4,0)
 ;;=4^K61.0
 ;;^UTILITY(U,$J,358.3,4078,2)
 ;;=^5008749
 ;;^UTILITY(U,$J,358.3,4079,0)
 ;;=K61.1^^30^305^88
