IBDEI08Q ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11019,1,3,0)
 ;;=3^Hepatic Liver Disease,Alcoholic,Unspec
 ;;^UTILITY(U,$J,358.3,11019,1,4,0)
 ;;=4^K70.9
 ;;^UTILITY(U,$J,358.3,11019,2)
 ;;=^5008792
 ;;^UTILITY(U,$J,358.3,11020,0)
 ;;=K75.9^^40^576^47
 ;;^UTILITY(U,$J,358.3,11020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11020,1,3,0)
 ;;=3^Hepatic Liver Disease,Inflammatory,Unspec
 ;;^UTILITY(U,$J,358.3,11020,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,11020,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,11021,0)
 ;;=K71.9^^40^576^48
 ;;^UTILITY(U,$J,358.3,11021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11021,1,3,0)
 ;;=3^Hepatic Liver Disease,Toxic,Unspec
 ;;^UTILITY(U,$J,358.3,11021,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,11021,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,11022,0)
 ;;=K76.9^^40^576^49
 ;;^UTILITY(U,$J,358.3,11022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11022,1,3,0)
 ;;=3^Hepatic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,11022,1,4,0)
 ;;=4^K76.9
 ;;^UTILITY(U,$J,358.3,11022,2)
 ;;=^5008836
 ;;^UTILITY(U,$J,358.3,11023,0)
 ;;=K74.60^^40^576^39
 ;;^UTILITY(U,$J,358.3,11023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11023,1,3,0)
 ;;=3^Hepatic Cirrhosis,Unspec
 ;;^UTILITY(U,$J,358.3,11023,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,11023,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,11024,0)
 ;;=K72.01^^40^576^40
 ;;^UTILITY(U,$J,358.3,11024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11024,1,3,0)
 ;;=3^Hepatic Failure,Acute/Subacute w/ Coma
 ;;^UTILITY(U,$J,358.3,11024,1,4,0)
 ;;=4^K72.01
 ;;^UTILITY(U,$J,358.3,11024,2)
 ;;=^5008806
 ;;^UTILITY(U,$J,358.3,11025,0)
 ;;=K72.00^^40^576^41
 ;;^UTILITY(U,$J,358.3,11025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11025,1,3,0)
 ;;=3^Hepatic Failure,Acute/Subacute w/o Coma
 ;;^UTILITY(U,$J,358.3,11025,1,4,0)
 ;;=4^K72.00
 ;;^UTILITY(U,$J,358.3,11025,2)
 ;;=^5008805
 ;;^UTILITY(U,$J,358.3,11026,0)
 ;;=K72.11^^40^576^42
 ;;^UTILITY(U,$J,358.3,11026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11026,1,3,0)
 ;;=3^Hepatic Failure,Chronic w/ Coma
 ;;^UTILITY(U,$J,358.3,11026,1,4,0)
 ;;=4^K72.11
 ;;^UTILITY(U,$J,358.3,11026,2)
 ;;=^5008808
 ;;^UTILITY(U,$J,358.3,11027,0)
 ;;=K72.10^^40^576^43
 ;;^UTILITY(U,$J,358.3,11027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11027,1,3,0)
 ;;=3^Hepatic Failure,Chronic w/o Coma
 ;;^UTILITY(U,$J,358.3,11027,1,4,0)
 ;;=4^K72.10
 ;;^UTILITY(U,$J,358.3,11027,2)
 ;;=^5008807
 ;;^UTILITY(U,$J,358.3,11028,0)
 ;;=K72.91^^40^576^44
 ;;^UTILITY(U,$J,358.3,11028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11028,1,3,0)
 ;;=3^Hepatic Failure,Unspec w/ Coma
 ;;^UTILITY(U,$J,358.3,11028,1,4,0)
 ;;=4^K72.91
 ;;^UTILITY(U,$J,358.3,11028,2)
 ;;=^5008810
 ;;^UTILITY(U,$J,358.3,11029,0)
 ;;=K72.90^^40^576^45
 ;;^UTILITY(U,$J,358.3,11029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11029,1,3,0)
 ;;=3^Hepatic Failure,Unspec w/o Coma
 ;;^UTILITY(U,$J,358.3,11029,1,4,0)
 ;;=4^K72.90
 ;;^UTILITY(U,$J,358.3,11029,2)
 ;;=^5008809
 ;;^UTILITY(U,$J,358.3,11030,0)
 ;;=K73.9^^40^576^50
 ;;^UTILITY(U,$J,358.3,11030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11030,1,3,0)
 ;;=3^Hepatitis,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,11030,1,4,0)
 ;;=4^K73.9
 ;;^UTILITY(U,$J,358.3,11030,2)
 ;;=^5008815
 ;;^UTILITY(U,$J,358.3,11031,0)
 ;;=K45.8^^40^576^52
 ;;^UTILITY(U,$J,358.3,11031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11031,1,3,0)
 ;;=3^Hernia,Abdominal w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,11031,1,4,0)
 ;;=4^K45.8
 ;;^UTILITY(U,$J,358.3,11031,2)
 ;;=^5008620
 ;;^UTILITY(U,$J,358.3,11032,0)
 ;;=K45.0^^40^576^51
 ;;^UTILITY(U,$J,358.3,11032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11032,1,3,0)
 ;;=3^Hernia,Abdominal w/ Obstruction w/o Gangrene
 ;;^UTILITY(U,$J,358.3,11032,1,4,0)
 ;;=4^K45.0
 ;;^UTILITY(U,$J,358.3,11032,2)
 ;;=^5008618
 ;;^UTILITY(U,$J,358.3,11033,0)
 ;;=K41.00^^40^576^53
 ;;^UTILITY(U,$J,358.3,11033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11033,1,3,0)
 ;;=3^Hernia,Bilat Femoral w/ Obstructions w/o Gangrene
 ;;^UTILITY(U,$J,358.3,11033,1,4,0)
 ;;=4^K41.00
 ;;^UTILITY(U,$J,358.3,11033,2)
 ;;=^5008593
 ;;^UTILITY(U,$J,358.3,11034,0)
 ;;=K40.20^^40^576^54
 ;;^UTILITY(U,$J,358.3,11034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11034,1,3,0)
 ;;=3^Hernia,Bilat Femoral w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,11034,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,11034,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,11035,0)
 ;;=K42.0^^40^576^55
 ;;^UTILITY(U,$J,358.3,11035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11035,1,3,0)
 ;;=3^Hernia,Umbilical w/ Obstruction w/o Gangrene
 ;;^UTILITY(U,$J,358.3,11035,1,4,0)
 ;;=4^K42.0
 ;;^UTILITY(U,$J,358.3,11035,2)
 ;;=^5008605
 ;;^UTILITY(U,$J,358.3,11036,0)
 ;;=K42.9^^40^576^56
 ;;^UTILITY(U,$J,358.3,11036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11036,1,3,0)
 ;;=3^Hernia,Umbilical w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,11036,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,11036,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,11037,0)
 ;;=K41.30^^40^576^57
 ;;^UTILITY(U,$J,358.3,11037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11037,1,3,0)
 ;;=3^Hernia,Unil Femoral w/ Obstruction w/o Gangrene
 ;;^UTILITY(U,$J,358.3,11037,1,4,0)
 ;;=4^K41.30
 ;;^UTILITY(U,$J,358.3,11037,2)
 ;;=^5008599
 ;;^UTILITY(U,$J,358.3,11038,0)
 ;;=K41.90^^40^576^58
 ;;^UTILITY(U,$J,358.3,11038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11038,1,3,0)
 ;;=3^Hernia,Unil Femoral w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,11038,1,4,0)
 ;;=4^K41.90
 ;;^UTILITY(U,$J,358.3,11038,2)
 ;;=^5008603
 ;;^UTILITY(U,$J,358.3,11039,0)
 ;;=K40.30^^40^576^59
 ;;^UTILITY(U,$J,358.3,11039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11039,1,3,0)
 ;;=3^Hernia,Unil Inguinal w/ Obstruction w/o Gangrene
 ;;^UTILITY(U,$J,358.3,11039,1,4,0)
 ;;=4^K40.30
 ;;^UTILITY(U,$J,358.3,11039,2)
 ;;=^5008587
 ;;^UTILITY(U,$J,358.3,11040,0)
 ;;=K40.90^^40^576^60
 ;;^UTILITY(U,$J,358.3,11040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11040,1,3,0)
 ;;=3^Hernia,Unil Inguinal w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,11040,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,11040,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,11041,0)
 ;;=K43.9^^40^576^61
 ;;^UTILITY(U,$J,358.3,11041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11041,1,3,0)
 ;;=3^Hernia,Ventral w/o Obstruction/Gangrene
 ;;^UTILITY(U,$J,358.3,11041,1,4,0)
 ;;=4^K43.9
 ;;^UTILITY(U,$J,358.3,11041,2)
 ;;=^5008615
 ;;^UTILITY(U,$J,358.3,11042,0)
 ;;=K59.9^^40^576^65
 ;;^UTILITY(U,$J,358.3,11042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11042,1,3,0)
 ;;=3^Intestinal Disorder,Functional,Unspec
 ;;^UTILITY(U,$J,358.3,11042,1,4,0)
 ;;=4^K59.9
 ;;^UTILITY(U,$J,358.3,11042,2)
 ;;=^5008744
 ;;^UTILITY(U,$J,358.3,11043,0)
 ;;=K63.9^^40^576^64
 ;;^UTILITY(U,$J,358.3,11043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11043,1,3,0)
 ;;=3^Intestinal Disease,Unspec
 ;;^UTILITY(U,$J,358.3,11043,1,4,0)
 ;;=4^K63.9
 ;;^UTILITY(U,$J,358.3,11043,2)
 ;;=^5008768
 ;;^UTILITY(U,$J,358.3,11044,0)
 ;;=K58.0^^40^576^62
 ;;^UTILITY(U,$J,358.3,11044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11044,1,3,0)
 ;;=3^IBS w/ Diarrhea
 ;;^UTILITY(U,$J,358.3,11044,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,11044,2)
 ;;=^5008739
 ;;^UTILITY(U,$J,358.3,11045,0)
 ;;=K58.9^^40^576^63
 ;;^UTILITY(U,$J,358.3,11045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11045,1,3,0)
 ;;=3^IBS w/o Diarrhea
 ;;^UTILITY(U,$J,358.3,11045,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,11045,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,11046,0)
 ;;=K90.9^^40^576^66
 ;;^UTILITY(U,$J,358.3,11046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11046,1,3,0)
 ;;=3^Malabsorption,Intestinal,Unspec
 ;;^UTILITY(U,$J,358.3,11046,1,4,0)
 ;;=4^K90.9
 ;;^UTILITY(U,$J,358.3,11046,2)
 ;;=^5008899
 ;;^UTILITY(U,$J,358.3,11047,0)
 ;;=K86.9^^40^576^67
 ;;^UTILITY(U,$J,358.3,11047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11047,1,3,0)
 ;;=3^Pancreas Disease,Unspec
 ;;^UTILITY(U,$J,358.3,11047,1,4,0)
 ;;=4^K86.9
 ;;^UTILITY(U,$J,358.3,11047,2)
 ;;=^5008892
 ;;^UTILITY(U,$J,358.3,11048,0)
 ;;=K85.9^^40^576^68
 ;;^UTILITY(U,$J,358.3,11048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11048,1,3,0)
 ;;=3^Pancreatitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,11048,1,4,0)
 ;;=4^K85.9
 ;;^UTILITY(U,$J,358.3,11048,2)
 ;;=^5008887
 ;;^UTILITY(U,$J,358.3,11049,0)
 ;;=Z87.11^^40^576^69
 ;;^UTILITY(U,$J,358.3,11049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11049,1,3,0)
 ;;=3^Personal Hx of PUD
 ;;^UTILITY(U,$J,358.3,11049,1,4,0)
 ;;=4^Z87.11
 ;;^UTILITY(U,$J,358.3,11049,2)
 ;;=^5063482
 ;;^UTILITY(U,$J,358.3,11050,0)
 ;;=D73.9^^40^576^70
 ;;^UTILITY(U,$J,358.3,11050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11050,1,3,0)
 ;;=3^Spleen Disease,Unspec
 ;;^UTILITY(U,$J,358.3,11050,1,4,0)
 ;;=4^D73.9
 ;;^UTILITY(U,$J,358.3,11050,2)
 ;;=^5002386
 ;;^UTILITY(U,$J,358.3,11051,0)
 ;;=K26.7^^40^576^71
 ;;^UTILITY(U,$J,358.3,11051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11051,1,3,0)
 ;;=3^Ulcer,Chronic Duodenal w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,11051,1,4,0)
 ;;=4^K26.7
 ;;^UTILITY(U,$J,358.3,11051,2)
 ;;=^5008526
 ;;^UTILITY(U,$J,358.3,11052,0)
 ;;=K25.7^^40^576^72
 ;;^UTILITY(U,$J,358.3,11052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11052,1,3,0)
 ;;=3^Ulcer,Chronic Gastric w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,11052,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,11052,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,11053,0)
 ;;=K27.7^^40^576^73
 ;;^UTILITY(U,$J,358.3,11053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11053,1,3,0)
 ;;=3^Ulcer,Chronic Peptic w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,11053,1,4,0)
 ;;=4^K27.7
 ;;^UTILITY(U,$J,358.3,11053,2)
 ;;=^5008535
 ;;^UTILITY(U,$J,358.3,11054,0)
 ;;=D55.9^^40^577^1
 ;;^UTILITY(U,$J,358.3,11054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11054,1,3,0)
 ;;=3^Anemia d/t Enzyme Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11054,1,4,0)
 ;;=4^D55.9
