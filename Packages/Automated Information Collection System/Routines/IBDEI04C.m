IBDEI04C ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5304,1,3,0)
 ;;=3^Malig Neop of Soft Palate
 ;;^UTILITY(U,$J,358.3,5304,1,4,0)
 ;;=4^C05.1
 ;;^UTILITY(U,$J,358.3,5304,2)
 ;;=^267022
 ;;^UTILITY(U,$J,358.3,5305,0)
 ;;=C05.2^^22^233^5
 ;;^UTILITY(U,$J,358.3,5305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5305,1,3,0)
 ;;=3^Malig Neop of Uvula
 ;;^UTILITY(U,$J,358.3,5305,1,4,0)
 ;;=4^C05.2
 ;;^UTILITY(U,$J,358.3,5305,2)
 ;;=^267023
 ;;^UTILITY(U,$J,358.3,5306,0)
 ;;=C05.8^^22^233^2
 ;;^UTILITY(U,$J,358.3,5306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5306,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Palate
 ;;^UTILITY(U,$J,358.3,5306,1,4,0)
 ;;=4^C05.8
 ;;^UTILITY(U,$J,358.3,5306,2)
 ;;=^5000897
 ;;^UTILITY(U,$J,358.3,5307,0)
 ;;=C05.9^^22^233^3
 ;;^UTILITY(U,$J,358.3,5307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5307,1,3,0)
 ;;=3^Malig Neop of Palate,Unspec
 ;;^UTILITY(U,$J,358.3,5307,1,4,0)
 ;;=4^C05.9
 ;;^UTILITY(U,$J,358.3,5307,2)
 ;;=^5000898
 ;;^UTILITY(U,$J,358.3,5308,0)
 ;;=C16.0^^22^234^2
 ;;^UTILITY(U,$J,358.3,5308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5308,1,3,0)
 ;;=3^Malig Neop of Cardia
 ;;^UTILITY(U,$J,358.3,5308,1,4,0)
 ;;=4^C16.0
 ;;^UTILITY(U,$J,358.3,5308,2)
 ;;=^267063
 ;;^UTILITY(U,$J,358.3,5309,0)
 ;;=C16.1^^22^234^3
 ;;^UTILITY(U,$J,358.3,5309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5309,1,3,0)
 ;;=3^Malig Neop of Fundus of Stomach
 ;;^UTILITY(U,$J,358.3,5309,1,4,0)
 ;;=4^C16.1
 ;;^UTILITY(U,$J,358.3,5309,2)
 ;;=^267066
 ;;^UTILITY(U,$J,358.3,5310,0)
 ;;=C16.2^^22^234^1
 ;;^UTILITY(U,$J,358.3,5310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5310,1,3,0)
 ;;=3^Malig Neop of Body of Stomach
 ;;^UTILITY(U,$J,358.3,5310,1,4,0)
 ;;=4^C16.2
 ;;^UTILITY(U,$J,358.3,5310,2)
 ;;=^267067
 ;;^UTILITY(U,$J,358.3,5311,0)
 ;;=C16.3^^22^234^4
 ;;^UTILITY(U,$J,358.3,5311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5311,1,3,0)
 ;;=3^Malig Neop of Pyloric Antrum
 ;;^UTILITY(U,$J,358.3,5311,1,4,0)
 ;;=4^C16.3
 ;;^UTILITY(U,$J,358.3,5311,2)
 ;;=^267065
 ;;^UTILITY(U,$J,358.3,5312,0)
 ;;=C16.4^^22^234^5
 ;;^UTILITY(U,$J,358.3,5312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5312,1,3,0)
 ;;=3^Malig Neop of Pylorus
 ;;^UTILITY(U,$J,358.3,5312,1,4,0)
 ;;=4^C16.4
 ;;^UTILITY(U,$J,358.3,5312,2)
 ;;=^267064
 ;;^UTILITY(U,$J,358.3,5313,0)
 ;;=C16.9^^22^234^6
 ;;^UTILITY(U,$J,358.3,5313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5313,1,3,0)
 ;;=3^Malig Neop of Stomach,Unspec
 ;;^UTILITY(U,$J,358.3,5313,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,5313,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,5314,0)
 ;;=C17.0^^22^235^2
 ;;^UTILITY(U,$J,358.3,5314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5314,1,3,0)
 ;;=3^Malig Neop of Duodenum
 ;;^UTILITY(U,$J,358.3,5314,1,4,0)
 ;;=4^C17.0
 ;;^UTILITY(U,$J,358.3,5314,2)
 ;;=^267072
 ;;^UTILITY(U,$J,358.3,5315,0)
 ;;=C17.1^^22^235^4
 ;;^UTILITY(U,$J,358.3,5315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5315,1,3,0)
 ;;=3^Malig Neop of Jejunum
 ;;^UTILITY(U,$J,358.3,5315,1,4,0)
 ;;=4^C17.1
 ;;^UTILITY(U,$J,358.3,5315,2)
 ;;=^267073
 ;;^UTILITY(U,$J,358.3,5316,0)
 ;;=C17.2^^22^235^3
 ;;^UTILITY(U,$J,358.3,5316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5316,1,3,0)
 ;;=3^Malig Neop of Ileum
 ;;^UTILITY(U,$J,358.3,5316,1,4,0)
 ;;=4^C17.2
 ;;^UTILITY(U,$J,358.3,5316,2)
 ;;=^267074
 ;;^UTILITY(U,$J,358.3,5317,0)
 ;;=C17.3^^22^235^1
 ;;^UTILITY(U,$J,358.3,5317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5317,1,3,0)
 ;;=3^Malig Meckel's Diverticulum
 ;;^UTILITY(U,$J,358.3,5317,1,4,0)
 ;;=4^C17.3
 ;;^UTILITY(U,$J,358.3,5317,2)
 ;;=^5000924
 ;;^UTILITY(U,$J,358.3,5318,0)
 ;;=C17.8^^22^235^5
 ;;^UTILITY(U,$J,358.3,5318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5318,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Small Intestine
 ;;^UTILITY(U,$J,358.3,5318,1,4,0)
 ;;=4^C17.8
 ;;^UTILITY(U,$J,358.3,5318,2)
 ;;=^5000925
 ;;^UTILITY(U,$J,358.3,5319,0)
 ;;=C17.9^^22^235^6
 ;;^UTILITY(U,$J,358.3,5319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5319,1,3,0)
 ;;=3^Malig Neop of Small Intestine,Unspec
 ;;^UTILITY(U,$J,358.3,5319,1,4,0)
 ;;=4^C17.9
 ;;^UTILITY(U,$J,358.3,5319,2)
 ;;=^5000926
 ;;^UTILITY(U,$J,358.3,5320,0)
 ;;=C22.0^^22^236^5
 ;;^UTILITY(U,$J,358.3,5320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5320,1,3,0)
 ;;=3^Liver Cell Carcinoma
 ;;^UTILITY(U,$J,358.3,5320,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,5320,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,5321,0)
 ;;=C22.1^^22^236^3
 ;;^UTILITY(U,$J,358.3,5321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5321,1,3,0)
 ;;=3^Intrahepatic Bile Duct Carcinoma
 ;;^UTILITY(U,$J,358.3,5321,1,4,0)
 ;;=4^C22.1
 ;;^UTILITY(U,$J,358.3,5321,2)
 ;;=^5000934
 ;;^UTILITY(U,$J,358.3,5322,0)
 ;;=C22.2^^22^236^2
 ;;^UTILITY(U,$J,358.3,5322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5322,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,5322,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,5322,2)
 ;;=^5000935
 ;;^UTILITY(U,$J,358.3,5323,0)
 ;;=C22.3^^22^236^1
 ;;^UTILITY(U,$J,358.3,5323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5323,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,5323,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,5323,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,5324,0)
 ;;=C22.4^^22^236^6
 ;;^UTILITY(U,$J,358.3,5324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5324,1,3,0)
 ;;=3^Liver Sarcomas NEC
 ;;^UTILITY(U,$J,358.3,5324,1,4,0)
 ;;=4^C22.4
 ;;^UTILITY(U,$J,358.3,5324,2)
 ;;=^5000937
 ;;^UTILITY(U,$J,358.3,5325,0)
 ;;=C22.7^^22^236^4
 ;;^UTILITY(U,$J,358.3,5325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5325,1,3,0)
 ;;=3^Liver Carcinomas NEC
 ;;^UTILITY(U,$J,358.3,5325,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,5325,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,5326,0)
 ;;=C22.8^^22^236^8
 ;;^UTILITY(U,$J,358.3,5326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5326,1,3,0)
 ;;=3^Malig Neop of Liver,Primary
 ;;^UTILITY(U,$J,358.3,5326,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,5326,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,5327,0)
 ;;=C22.9^^22^236^9
 ;;^UTILITY(U,$J,358.3,5327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5327,1,3,0)
 ;;=3^Malig Neop of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,5327,1,4,0)
 ;;=4^C22.9
 ;;^UTILITY(U,$J,358.3,5327,2)
 ;;=^267096
 ;;^UTILITY(U,$J,358.3,5328,0)
 ;;=C23.^^22^236^7
 ;;^UTILITY(U,$J,358.3,5328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5328,1,3,0)
 ;;=3^Malig Neop of Gallbladder
 ;;^UTILITY(U,$J,358.3,5328,1,4,0)
 ;;=4^C23.
 ;;^UTILITY(U,$J,358.3,5328,2)
 ;;=^267098
 ;;^UTILITY(U,$J,358.3,5329,0)
 ;;=C24.0^^22^237^3
 ;;^UTILITY(U,$J,358.3,5329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5329,1,3,0)
 ;;=3^Malig Neop of Extrahepatic Bile Duct
 ;;^UTILITY(U,$J,358.3,5329,1,4,0)
 ;;=4^C24.0
 ;;^UTILITY(U,$J,358.3,5329,2)
 ;;=^5000940
 ;;^UTILITY(U,$J,358.3,5330,0)
 ;;=C24.1^^22^237^1
 ;;^UTILITY(U,$J,358.3,5330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5330,1,3,0)
 ;;=3^Malig Neop of Ampulla of Vater
 ;;^UTILITY(U,$J,358.3,5330,1,4,0)
 ;;=4^C24.1
 ;;^UTILITY(U,$J,358.3,5330,2)
 ;;=^267100
 ;;^UTILITY(U,$J,358.3,5331,0)
 ;;=C24.9^^22^237^2
 ;;^UTILITY(U,$J,358.3,5331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5331,1,3,0)
 ;;=3^Malig Neop of Biliary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,5331,1,4,0)
 ;;=4^C24.9
 ;;^UTILITY(U,$J,358.3,5331,2)
 ;;=^5000942
 ;;^UTILITY(U,$J,358.3,5332,0)
 ;;=C26.0^^22^238^2
 ;;^UTILITY(U,$J,358.3,5332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5332,1,3,0)
 ;;=3^Malig Neop of Intestinal Tract,Unspec Part
 ;;^UTILITY(U,$J,358.3,5332,1,4,0)
 ;;=4^C26.0
 ;;^UTILITY(U,$J,358.3,5332,2)
 ;;=^5000947
 ;;^UTILITY(U,$J,358.3,5333,0)
 ;;=C26.1^^22^238^3
 ;;^UTILITY(U,$J,358.3,5333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5333,1,3,0)
 ;;=3^Malig Neop of Spleen
 ;;^UTILITY(U,$J,358.3,5333,1,4,0)
 ;;=4^C26.1
 ;;^UTILITY(U,$J,358.3,5333,2)
 ;;=^267116
 ;;^UTILITY(U,$J,358.3,5334,0)
 ;;=C26.9^^22^238^1
 ;;^UTILITY(U,$J,358.3,5334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5334,1,3,0)
 ;;=3^Malig Neop of Digestive System,Ill-Defined Sites
 ;;^UTILITY(U,$J,358.3,5334,1,4,0)
 ;;=4^C26.9
 ;;^UTILITY(U,$J,358.3,5334,2)
 ;;=^5000948
 ;;^UTILITY(U,$J,358.3,5335,0)
 ;;=C30.0^^22^239^6
 ;;^UTILITY(U,$J,358.3,5335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5335,1,3,0)
 ;;=3^Malig Neop of Nasal Cavity
 ;;^UTILITY(U,$J,358.3,5335,1,4,0)
 ;;=4^C30.0
 ;;^UTILITY(U,$J,358.3,5335,2)
 ;;=^5000949
 ;;^UTILITY(U,$J,358.3,5336,0)
 ;;=C30.1^^22^239^5
 ;;^UTILITY(U,$J,358.3,5336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5336,1,3,0)
 ;;=3^Malig Neop of Middle Ear
 ;;^UTILITY(U,$J,358.3,5336,1,4,0)
 ;;=4^C30.1
 ;;^UTILITY(U,$J,358.3,5336,2)
 ;;=^5000950
 ;;^UTILITY(U,$J,358.3,5337,0)
 ;;=C31.0^^22^239^4
 ;;^UTILITY(U,$J,358.3,5337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5337,1,3,0)
 ;;=3^Malig Neop of Maxillary Sinus
 ;;^UTILITY(U,$J,358.3,5337,1,4,0)
 ;;=4^C31.0
 ;;^UTILITY(U,$J,358.3,5337,2)
 ;;=^267122
 ;;^UTILITY(U,$J,358.3,5338,0)
 ;;=C31.1^^22^239^2
 ;;^UTILITY(U,$J,358.3,5338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5338,1,3,0)
 ;;=3^Malig Neop of Ethmoidal Sinus
 ;;^UTILITY(U,$J,358.3,5338,1,4,0)
 ;;=4^C31.1
 ;;^UTILITY(U,$J,358.3,5338,2)
 ;;=^267123
 ;;^UTILITY(U,$J,358.3,5339,0)
 ;;=C31.2^^22^239^3
 ;;^UTILITY(U,$J,358.3,5339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5339,1,3,0)
 ;;=3^Malig Neop of Frontal Sinus
 ;;^UTILITY(U,$J,358.3,5339,1,4,0)
 ;;=4^C31.2
 ;;^UTILITY(U,$J,358.3,5339,2)
 ;;=^267124
 ;;^UTILITY(U,$J,358.3,5340,0)
 ;;=C31.3^^22^239^7
 ;;^UTILITY(U,$J,358.3,5340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5340,1,3,0)
 ;;=3^Malig Neop of Sphenoid Sinus
 ;;^UTILITY(U,$J,358.3,5340,1,4,0)
 ;;=4^C31.3
 ;;^UTILITY(U,$J,358.3,5340,2)
 ;;=^5000951
 ;;^UTILITY(U,$J,358.3,5341,0)
 ;;=C31.9^^22^239^1
 ;;^UTILITY(U,$J,358.3,5341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5341,1,3,0)
 ;;=3^Malig Neop of Accessory Sinus,Unspec
 ;;^UTILITY(U,$J,358.3,5341,1,4,0)
 ;;=4^C31.9
