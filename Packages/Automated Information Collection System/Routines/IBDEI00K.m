IBDEI00K ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,755,2)
 ;;=^5000940
 ;;^UTILITY(U,$J,358.3,756,0)
 ;;=C18.9^^12^83^7
 ;;^UTILITY(U,$J,358.3,756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,756,1,3,0)
 ;;=3^Malig Neop Colon,Unspec
 ;;^UTILITY(U,$J,358.3,756,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,756,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,757,0)
 ;;=C15.9^^12^83^8
 ;;^UTILITY(U,$J,358.3,757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,757,1,3,0)
 ;;=3^Malig Neop Esophagus,Unspec
 ;;^UTILITY(U,$J,358.3,757,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,757,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,758,0)
 ;;=C23.^^12^83^10
 ;;^UTILITY(U,$J,358.3,758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,758,1,3,0)
 ;;=3^Malig Neop Gallbladder
 ;;^UTILITY(U,$J,358.3,758,1,4,0)
 ;;=4^C23.
 ;;^UTILITY(U,$J,358.3,758,2)
 ;;=^267098
 ;;^UTILITY(U,$J,358.3,759,0)
 ;;=C22.8^^12^83^11
 ;;^UTILITY(U,$J,358.3,759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,759,1,3,0)
 ;;=3^Malig Neop Liver,Primary,Unspec Type
 ;;^UTILITY(U,$J,358.3,759,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,759,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,760,0)
 ;;=C22.7^^12^83^1
 ;;^UTILITY(U,$J,358.3,760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,760,1,3,0)
 ;;=3^Carcinoma of Liver,Other Spec
 ;;^UTILITY(U,$J,358.3,760,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,760,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,761,0)
 ;;=C22.2^^12^83^2
 ;;^UTILITY(U,$J,358.3,761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,761,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,761,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,761,2)
 ;;=^5000935
 ;;^UTILITY(U,$J,358.3,762,0)
 ;;=C22.0^^12^83^4
 ;;^UTILITY(U,$J,358.3,762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,762,1,3,0)
 ;;=3^Liver Cell Carcinoma
 ;;^UTILITY(U,$J,358.3,762,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,762,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,763,0)
 ;;=C22.4^^12^83^5
 ;;^UTILITY(U,$J,358.3,763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,763,1,3,0)
 ;;=3^Liver Sarcoma
 ;;^UTILITY(U,$J,358.3,763,1,4,0)
 ;;=4^C22.4
 ;;^UTILITY(U,$J,358.3,763,2)
 ;;=^5000937
 ;;^UTILITY(U,$J,358.3,764,0)
 ;;=C22.3^^12^83^3
 ;;^UTILITY(U,$J,358.3,764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,764,1,3,0)
 ;;=3^Liver Angiosarcoma
 ;;^UTILITY(U,$J,358.3,764,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,764,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,765,0)
 ;;=C25.9^^12^83^12
 ;;^UTILITY(U,$J,358.3,765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,765,1,3,0)
 ;;=3^Malig Neop Pancreas,Unspec
 ;;^UTILITY(U,$J,358.3,765,1,4,0)
 ;;=4^C25.9
 ;;^UTILITY(U,$J,358.3,765,2)
 ;;=^5000946
 ;;^UTILITY(U,$J,358.3,766,0)
 ;;=C20.^^12^83^13
 ;;^UTILITY(U,$J,358.3,766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,766,1,3,0)
 ;;=3^Malig Neop Rectum
 ;;^UTILITY(U,$J,358.3,766,1,4,0)
 ;;=4^C20.
 ;;^UTILITY(U,$J,358.3,766,2)
 ;;=^267090
 ;;^UTILITY(U,$J,358.3,767,0)
 ;;=C17.9^^12^83^14
 ;;^UTILITY(U,$J,358.3,767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,767,1,3,0)
 ;;=3^Malig Neop Small Intestine,Unspec
 ;;^UTILITY(U,$J,358.3,767,1,4,0)
 ;;=4^C17.9
 ;;^UTILITY(U,$J,358.3,767,2)
 ;;=^5000926
 ;;^UTILITY(U,$J,358.3,768,0)
 ;;=C16.9^^12^83^15
 ;;^UTILITY(U,$J,358.3,768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,768,1,3,0)
 ;;=3^Malig Neop Stomach,Unspec
 ;;^UTILITY(U,$J,358.3,768,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,768,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,769,0)
 ;;=C31.9^^12^84^10
 ;;^UTILITY(U,$J,358.3,769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,769,1,3,0)
 ;;=3^Malig Neop Sinus,Accessory,Unspec
 ;;^UTILITY(U,$J,358.3,769,1,4,0)
 ;;=4^C31.9
 ;;^UTILITY(U,$J,358.3,769,2)
 ;;=^5000953
 ;;^UTILITY(U,$J,358.3,770,0)
 ;;=C01.^^12^84^12
 ;;^UTILITY(U,$J,358.3,770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,770,1,3,0)
 ;;=3^Malig Neop Tongue,Base
 ;;^UTILITY(U,$J,358.3,770,1,4,0)
 ;;=4^C01.
 ;;^UTILITY(U,$J,358.3,770,2)
 ;;=^266996
 ;;^UTILITY(U,$J,358.3,771,0)
 ;;=C04.9^^12^84^5
 ;;^UTILITY(U,$J,358.3,771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,771,1,3,0)
 ;;=3^Malig Neop Mouth,Floor,Unspec
 ;;^UTILITY(U,$J,358.3,771,1,4,0)
 ;;=4^C04.9
 ;;^UTILITY(U,$J,358.3,771,2)
 ;;=^5000896
 ;;^UTILITY(U,$J,358.3,772,0)
 ;;=C32.9^^12^84^4
 ;;^UTILITY(U,$J,358.3,772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,772,1,3,0)
 ;;=3^Malig Neop Larynx,Unspec
 ;;^UTILITY(U,$J,358.3,772,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,772,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,773,0)
 ;;=C34.91^^12^84^2
 ;;^UTILITY(U,$J,358.3,773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,773,1,3,0)
 ;;=3^Malig Neop Bronchus/Lung,Right,Unspec Part
 ;;^UTILITY(U,$J,358.3,773,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,773,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,774,0)
 ;;=C34.92^^12^84^1
 ;;^UTILITY(U,$J,358.3,774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,774,1,3,0)
 ;;=3^Malig Neop Bronchus/Lung,Left,Unspec Part
 ;;^UTILITY(U,$J,358.3,774,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,774,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,775,0)
 ;;=C76.0^^12^84^3
 ;;^UTILITY(U,$J,358.3,775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,775,1,3,0)
 ;;=3^Malig Neop Head/Face/Neck
 ;;^UTILITY(U,$J,358.3,775,1,4,0)
 ;;=4^C76.0
 ;;^UTILITY(U,$J,358.3,775,2)
 ;;=^5001324
 ;;^UTILITY(U,$J,358.3,776,0)
 ;;=C06.9^^12^84^6
 ;;^UTILITY(U,$J,358.3,776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,776,1,3,0)
 ;;=3^Malig Neop Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,776,1,4,0)
 ;;=4^C06.9
 ;;^UTILITY(U,$J,358.3,776,2)
 ;;=^5000901
 ;;^UTILITY(U,$J,358.3,777,0)
 ;;=C11.9^^12^84^7
 ;;^UTILITY(U,$J,358.3,777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,777,1,3,0)
 ;;=3^Malig Neop Nasopharynx,Unspec
 ;;^UTILITY(U,$J,358.3,777,1,4,0)
 ;;=4^C11.9
 ;;^UTILITY(U,$J,358.3,777,2)
 ;;=^5000911
 ;;^UTILITY(U,$J,358.3,778,0)
 ;;=C10.9^^12^84^8
 ;;^UTILITY(U,$J,358.3,778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,778,1,3,0)
 ;;=3^Malig Neop Oropharynx,Unspec
 ;;^UTILITY(U,$J,358.3,778,1,4,0)
 ;;=4^C10.9
 ;;^UTILITY(U,$J,358.3,778,2)
 ;;=^5000909
 ;;^UTILITY(U,$J,358.3,779,0)
 ;;=C38.4^^12^84^9
 ;;^UTILITY(U,$J,358.3,779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,779,1,3,0)
 ;;=3^Malig Neop Pleura
 ;;^UTILITY(U,$J,358.3,779,1,4,0)
 ;;=4^C38.4
 ;;^UTILITY(U,$J,358.3,779,2)
 ;;=^267140
 ;;^UTILITY(U,$J,358.3,780,0)
 ;;=C45.0^^12^84^15
 ;;^UTILITY(U,$J,358.3,780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,780,1,3,0)
 ;;=3^Mesothelioma of Pleura
 ;;^UTILITY(U,$J,358.3,780,1,4,0)
 ;;=4^C45.0
 ;;^UTILITY(U,$J,358.3,780,2)
 ;;=^5001095
 ;;^UTILITY(U,$J,358.3,781,0)
 ;;=C73.^^12^84^11
 ;;^UTILITY(U,$J,358.3,781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,781,1,3,0)
 ;;=3^Malig Neop Thyroid Gland
 ;;^UTILITY(U,$J,358.3,781,1,4,0)
 ;;=4^C73.
 ;;^UTILITY(U,$J,358.3,781,2)
 ;;=^267296
 ;;^UTILITY(U,$J,358.3,782,0)
 ;;=C02.9^^12^84^13
 ;;^UTILITY(U,$J,358.3,782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,782,1,3,0)
 ;;=3^Malig Neop Tongue,Unspec
 ;;^UTILITY(U,$J,358.3,782,1,4,0)
 ;;=4^C02.9
 ;;^UTILITY(U,$J,358.3,782,2)
 ;;=^5000891
 ;;^UTILITY(U,$J,358.3,783,0)
 ;;=C33.^^12^84^14
 ;;^UTILITY(U,$J,358.3,783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,783,1,3,0)
 ;;=3^Malig Neop Trachea
 ;;^UTILITY(U,$J,358.3,783,1,4,0)
 ;;=4^C33.
 ;;^UTILITY(U,$J,358.3,783,2)
 ;;=^267135
 ;;^UTILITY(U,$J,358.3,784,0)
 ;;=D70.9^^12^85^3
 ;;^UTILITY(U,$J,358.3,784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,784,1,3,0)
 ;;=3^Neutropenia,Unspec
 ;;^UTILITY(U,$J,358.3,784,1,4,0)
 ;;=4^D70.9
 ;;^UTILITY(U,$J,358.3,784,2)
 ;;=^334186
 ;;^UTILITY(U,$J,358.3,785,0)
 ;;=D57.1^^12^85^4
 ;;^UTILITY(U,$J,358.3,785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,785,1,3,0)
 ;;=3^Sickle-Cell Disease w/o Crisis
 ;;^UTILITY(U,$J,358.3,785,1,4,0)
 ;;=4^D57.1
 ;;^UTILITY(U,$J,358.3,785,2)
 ;;=^5002309
 ;;^UTILITY(U,$J,358.3,786,0)
 ;;=D57.00^^12^85^1
 ;;^UTILITY(U,$J,358.3,786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,786,1,3,0)
 ;;=3^Hb-SS Disease w/ Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,786,1,4,0)
 ;;=4^D57.00
 ;;^UTILITY(U,$J,358.3,786,2)
 ;;=^5002306
 ;;^UTILITY(U,$J,358.3,787,0)
 ;;=D73.1^^12^85^2
 ;;^UTILITY(U,$J,358.3,787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,787,1,3,0)
 ;;=3^Hypersplenism
 ;;^UTILITY(U,$J,358.3,787,1,4,0)
 ;;=4^D73.1
 ;;^UTILITY(U,$J,358.3,787,2)
 ;;=^60330
 ;;^UTILITY(U,$J,358.3,788,0)
 ;;=D57.819^^12^85^5
 ;;^UTILITY(U,$J,358.3,788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,788,1,3,0)
 ;;=3^Sickle-Cell Disorders w/ Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,788,1,4,0)
 ;;=4^D57.819
 ;;^UTILITY(U,$J,358.3,788,2)
 ;;=^5002320
 ;;^UTILITY(U,$J,358.3,789,0)
 ;;=D57.3^^12^85^7
 ;;^UTILITY(U,$J,358.3,789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,789,1,3,0)
 ;;=3^Sickle-Cell Trait
 ;;^UTILITY(U,$J,358.3,789,1,4,0)
 ;;=4^D57.3
 ;;^UTILITY(U,$J,358.3,789,2)
 ;;=^5002313
 ;;^UTILITY(U,$J,358.3,790,0)
 ;;=D57.20^^12^85^8
 ;;^UTILITY(U,$J,358.3,790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,790,1,3,0)
 ;;=3^Sickle-Cell/Hb-C Disease w/o Crisis
 ;;^UTILITY(U,$J,358.3,790,1,4,0)
 ;;=4^D57.20
 ;;^UTILITY(U,$J,358.3,790,2)
 ;;=^330080
 ;;^UTILITY(U,$J,358.3,791,0)
 ;;=D56.8^^12^85^9
 ;;^UTILITY(U,$J,358.3,791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,791,1,3,0)
 ;;=3^Thalassemias,Other
 ;;^UTILITY(U,$J,358.3,791,1,4,0)
 ;;=4^D56.8
 ;;^UTILITY(U,$J,358.3,791,2)
 ;;=^5002305
 ;;^UTILITY(U,$J,358.3,792,0)
 ;;=D57.40^^12^85^6
 ;;^UTILITY(U,$J,358.3,792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,792,1,3,0)
 ;;=3^Sickle-Cell Thalassemia w/o Crisis
 ;;^UTILITY(U,$J,358.3,792,1,4,0)
 ;;=4^D57.40
 ;;^UTILITY(U,$J,358.3,792,2)
 ;;=^329908
 ;;^UTILITY(U,$J,358.3,793,0)
 ;;=C91.01^^12^86^20
 ;;^UTILITY(U,$J,358.3,793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,793,1,3,0)
 ;;=3^Lymphoblastic Leukemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,793,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,793,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,794,0)
 ;;=C91.00^^12^86^21
 ;;^UTILITY(U,$J,358.3,794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,794,1,3,0)
 ;;=3^Lymphoblastic Leukemia,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,794,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,794,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,795,0)
 ;;=C92.41^^12^86^41
 ;;^UTILITY(U,$J,358.3,795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,795,1,3,0)
 ;;=3^Promyleocytic Leukemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,795,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,795,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,796,0)
 ;;=C92.01^^12^86^32
 ;;^UTILITY(U,$J,358.3,796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,796,1,3,0)
 ;;=3^Myeloblastic Leukemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,796,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,796,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,797,0)
 ;;=C92.51^^12^86^35
 ;;^UTILITY(U,$J,358.3,797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,797,1,3,0)
 ;;=3^Myelomonocytic Leukemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,797,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,797,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,798,0)
 ;;=C91.11^^12^86^24
 ;;^UTILITY(U,$J,358.3,798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,798,1,3,0)
 ;;=3^Lymphocytic B-Cell Type Leukemia,Chr,In Remission
 ;;^UTILITY(U,$J,358.3,798,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,798,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,799,0)
 ;;=C91.10^^12^86^25
 ;;^UTILITY(U,$J,358.3,799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,799,1,3,0)
 ;;=3^Lymphocytic B-Cell Type Leukemia,Chr,Not in Remission
 ;;^UTILITY(U,$J,358.3,799,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,799,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,800,0)
 ;;=C92.11^^12^86^33
 ;;^UTILITY(U,$J,358.3,800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,800,1,3,0)
 ;;=3^Myeloid Leukemia,BCR/ABL-Positive,Chr,In Remission
 ;;^UTILITY(U,$J,358.3,800,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,800,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,801,0)
 ;;=C92.10^^12^86^34
 ;;^UTILITY(U,$J,358.3,801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,801,1,3,0)
 ;;=3^Myeloid Leukemia,BCR/ABL-Positive,Chr,Not in Remission
 ;;^UTILITY(U,$J,358.3,801,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,801,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,802,0)
 ;;=C91.40^^12^86^7
 ;;^UTILITY(U,$J,358.3,802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,802,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,802,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,802,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,803,0)
 ;;=C81.90^^12^86^19
 ;;^UTILITY(U,$J,358.3,803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,803,1,3,0)
 ;;=3^Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,803,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,803,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,804,0)
 ;;=C81.99^^12^86^26
 ;;^UTILITY(U,$J,358.3,804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,804,1,3,0)
 ;;=3^Lymphoma,Extrnod & Solid Org Sites,Unspec
 ;;^UTILITY(U,$J,358.3,804,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,804,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,805,0)
 ;;=C81.00^^12^86^16
 ;;^UTILITY(U,$J,358.3,805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,805,1,3,0)
 ;;=3^Hodgkin Lymphoma,Nodular Lymphocyte,Unspec Site
 ;;^UTILITY(U,$J,358.3,805,1,4,0)
 ;;=4^C81.00
 ;;^UTILITY(U,$J,358.3,805,2)
 ;;=^5001391
 ;;^UTILITY(U,$J,358.3,806,0)
 ;;=C81.09^^12^86^15
 ;;^UTILITY(U,$J,358.3,806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,806,1,3,0)
 ;;=3^Hodgkin Lymphoma,Nodular Lymphocyte,Extrnod & Solid Org Site
 ;;^UTILITY(U,$J,358.3,806,1,4,0)
 ;;=4^C81.09
 ;;^UTILITY(U,$J,358.3,806,2)
 ;;=^5001400
 ;;^UTILITY(U,$J,358.3,807,0)
 ;;=C81.40^^12^86^12
 ;;^UTILITY(U,$J,358.3,807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,807,1,3,0)
 ;;=3^Hodgkin Lymphoma,Lymphocyte-Rich,Unspec Site
 ;;^UTILITY(U,$J,358.3,807,1,4,0)
 ;;=4^C81.40
 ;;^UTILITY(U,$J,358.3,807,2)
 ;;=^5001431
 ;;^UTILITY(U,$J,358.3,808,0)
 ;;=C81.49^^12^86^11
 ;;^UTILITY(U,$J,358.3,808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,808,1,3,0)
 ;;=3^Hodgkin Lymphoma,Lymphocyte-Rich,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,808,1,4,0)
 ;;=4^C81.49
 ;;^UTILITY(U,$J,358.3,808,2)
 ;;=^5001440
 ;;^UTILITY(U,$J,358.3,809,0)
 ;;=C81.30^^12^86^10
 ;;^UTILITY(U,$J,358.3,809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,809,1,3,0)
 ;;=3^Hodgkin Lymphoma,Lymphocyte Depleted,Unspec Site
 ;;^UTILITY(U,$J,358.3,809,1,4,0)
 ;;=4^C81.30
 ;;^UTILITY(U,$J,358.3,809,2)
 ;;=^5001421
 ;;^UTILITY(U,$J,358.3,810,0)
 ;;=C81.39^^12^86^9
 ;;^UTILITY(U,$J,358.3,810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,810,1,3,0)
 ;;=3^Hodgkin Lymphoma,Lymphocyte Depleted,Extrnod & Solid Org Site
 ;;^UTILITY(U,$J,358.3,810,1,4,0)
 ;;=4^C81.39
 ;;^UTILITY(U,$J,358.3,810,2)
 ;;=^5001430
 ;;^UTILITY(U,$J,358.3,811,0)
 ;;=C81.20^^12^86^14
 ;;^UTILITY(U,$J,358.3,811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,811,1,3,0)
 ;;=3^Hodgkin Lymphoma,Mixed Cellularity,Unspec Site
 ;;^UTILITY(U,$J,358.3,811,1,4,0)
 ;;=4^C81.20
 ;;^UTILITY(U,$J,358.3,811,2)
 ;;=^5001411
 ;;^UTILITY(U,$J,358.3,812,0)
 ;;=C81.29^^12^86^13
 ;;^UTILITY(U,$J,358.3,812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,812,1,3,0)
 ;;=3^Hodgkin Lymphoma,Mixed Cellularity,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,812,1,4,0)
 ;;=4^C81.29
 ;;^UTILITY(U,$J,358.3,812,2)
 ;;=^5001420
 ;;^UTILITY(U,$J,358.3,813,0)
 ;;=C81.10^^12^86^18
 ;;^UTILITY(U,$J,358.3,813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,813,1,3,0)
 ;;=3^Hodgkin Lymphoma,Nodular Sclerosis,Unspec Site
 ;;^UTILITY(U,$J,358.3,813,1,4,0)
 ;;=4^C81.10
 ;;^UTILITY(U,$J,358.3,813,2)
 ;;=^5001401
 ;;^UTILITY(U,$J,358.3,814,0)
 ;;=C81.19^^12^86^17
 ;;^UTILITY(U,$J,358.3,814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,814,1,3,0)
 ;;=3^Hodgkin Lymphoma,Nodular Sclerosis,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,814,1,4,0)
 ;;=4^C81.19
 ;;^UTILITY(U,$J,358.3,814,2)
 ;;=^5001410
 ;;^UTILITY(U,$J,358.3,815,0)
 ;;=C81.99^^12^86^8
 ;;^UTILITY(U,$J,358.3,815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,815,1,3,0)
 ;;=3^Hodgkin Lymphoma,Extrnod & Solid Org Sites,Unspec
 ;;^UTILITY(U,$J,358.3,815,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,815,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,816,0)
 ;;=C82.90^^12^86^6
 ;;^UTILITY(U,$J,358.3,816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,816,1,3,0)
 ;;=3^Follicular Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,816,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,816,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,817,0)
 ;;=C82.99^^12^86^5
 ;;^UTILITY(U,$J,358.3,817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,817,1,3,0)
 ;;=3^Follicular Lymphoma,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,817,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,817,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,818,0)
 ;;=C83.70^^12^86^2
 ;;^UTILITY(U,$J,358.3,818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,818,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,818,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,818,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,819,0)
 ;;=C83.79^^12^86^1
 ;;^UTILITY(U,$J,358.3,819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,819,1,3,0)
 ;;=3^Burkitt Lymphoma,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,819,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,819,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,820,0)
 ;;=C96.9^^12^86^27
 ;;^UTILITY(U,$J,358.3,820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,820,1,3,0)
 ;;=3^Malig Neop Lymphoid/Hematopoietic/Related Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,820,1,4,0)
 ;;=4^C96.9
 ;;^UTILITY(U,$J,358.3,820,2)
 ;;=^5001864
 ;;^UTILITY(U,$J,358.3,821,0)
 ;;=C96.4^^12^86^3
 ;;^UTILITY(U,$J,358.3,821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,821,1,3,0)
 ;;=3^Dendritic Cells Sarcoma
 ;;^UTILITY(U,$J,358.3,821,1,4,0)
 ;;=4^C96.4
 ;;^UTILITY(U,$J,358.3,821,2)
 ;;=^5001861
 ;;^UTILITY(U,$J,358.3,822,0)
 ;;=C83.50^^12^86^23
 ;;^UTILITY(U,$J,358.3,822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,822,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,822,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,822,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,823,0)
 ;;=C83.59^^12^86^22
 ;;^UTILITY(U,$J,358.3,823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,823,1,3,0)
 ;;=3^Lymphoblastic Lymphoma,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,823,1,4,0)
 ;;=4^C83.59
 ;;^UTILITY(U,$J,358.3,823,2)
 ;;=^5001590
 ;;^UTILITY(U,$J,358.3,824,0)
 ;;=C94.40^^12^86^40
 ;;^UTILITY(U,$J,358.3,824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,824,1,3,0)
 ;;=3^Panmyelosis w/ Myelofibrosis,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,824,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,824,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,825,0)
 ;;=C94.41^^12^86^38
 ;;^UTILITY(U,$J,358.3,825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,825,1,3,0)
 ;;=3^Panmyelosis w/ Myelofibrosis,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,825,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,825,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,826,0)
 ;;=C94.42^^12^86^39
 ;;^UTILITY(U,$J,358.3,826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,826,1,3,0)
 ;;=3^Panmyelosis w/ Myelofibrosis,Acute,In Relapse
