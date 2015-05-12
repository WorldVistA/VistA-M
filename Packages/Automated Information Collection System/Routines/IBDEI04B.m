IBDEI04B ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5267,1,4,0)
 ;;=4^C50.522
 ;;^UTILITY(U,$J,358.3,5267,2)
 ;;=^5133338
 ;;^UTILITY(U,$J,358.3,5268,0)
 ;;=C50.921^^22^230^7
 ;;^UTILITY(U,$J,358.3,5268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5268,1,3,0)
 ;;=3^Malig Neop of Right Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,5268,1,4,0)
 ;;=4^C50.921
 ;;^UTILITY(U,$J,358.3,5268,2)
 ;;=^5001198
 ;;^UTILITY(U,$J,358.3,5269,0)
 ;;=C50.922^^22^230^1
 ;;^UTILITY(U,$J,358.3,5269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5269,1,3,0)
 ;;=3^Malig Neop of Left Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,5269,1,4,0)
 ;;=4^C50.922
 ;;^UTILITY(U,$J,358.3,5269,2)
 ;;=^5133340
 ;;^UTILITY(U,$J,358.3,5270,0)
 ;;=C60.9^^22^231^5
 ;;^UTILITY(U,$J,358.3,5270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5270,1,3,0)
 ;;=3^Malig Neop of Penis,Unspec
 ;;^UTILITY(U,$J,358.3,5270,1,4,0)
 ;;=4^C60.9
 ;;^UTILITY(U,$J,358.3,5270,2)
 ;;=^5001229
 ;;^UTILITY(U,$J,358.3,5271,0)
 ;;=C61.^^22^231^6
 ;;^UTILITY(U,$J,358.3,5271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5271,1,3,0)
 ;;=3^Malig Neop of Prostate
 ;;^UTILITY(U,$J,358.3,5271,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,5271,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,5272,0)
 ;;=C62.01^^22^231^9
 ;;^UTILITY(U,$J,358.3,5272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5272,1,3,0)
 ;;=3^Malig Neop of Right Undescended Testis
 ;;^UTILITY(U,$J,358.3,5272,1,4,0)
 ;;=4^C62.01
 ;;^UTILITY(U,$J,358.3,5272,2)
 ;;=^5001231
 ;;^UTILITY(U,$J,358.3,5273,0)
 ;;=C62.02^^22^231^3
 ;;^UTILITY(U,$J,358.3,5273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5273,1,3,0)
 ;;=3^Malig Neop of Left Undescended Testis
 ;;^UTILITY(U,$J,358.3,5273,1,4,0)
 ;;=4^C62.02
 ;;^UTILITY(U,$J,358.3,5273,2)
 ;;=^5001232
 ;;^UTILITY(U,$J,358.3,5274,0)
 ;;=C62.11^^22^231^7
 ;;^UTILITY(U,$J,358.3,5274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5274,1,3,0)
 ;;=3^Malig Neop of Right Descended Testis
 ;;^UTILITY(U,$J,358.3,5274,1,4,0)
 ;;=4^C62.11
 ;;^UTILITY(U,$J,358.3,5274,2)
 ;;=^5001234
 ;;^UTILITY(U,$J,358.3,5275,0)
 ;;=C62.12^^22^231^1
 ;;^UTILITY(U,$J,358.3,5275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5275,1,3,0)
 ;;=3^Malig Neop of Left Descended Testis
 ;;^UTILITY(U,$J,358.3,5275,1,4,0)
 ;;=4^C62.12
 ;;^UTILITY(U,$J,358.3,5275,2)
 ;;=^5001235
 ;;^UTILITY(U,$J,358.3,5276,0)
 ;;=C62.91^^22^231^8
 ;;^UTILITY(U,$J,358.3,5276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5276,1,3,0)
 ;;=3^Malig Neop of Right Testis,Unspec
 ;;^UTILITY(U,$J,358.3,5276,1,4,0)
 ;;=4^C62.91
 ;;^UTILITY(U,$J,358.3,5276,2)
 ;;=^5001237
 ;;^UTILITY(U,$J,358.3,5277,0)
 ;;=C62.92^^22^231^2
 ;;^UTILITY(U,$J,358.3,5277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5277,1,3,0)
 ;;=3^Malig Neop of Left Testis,Unspec
 ;;^UTILITY(U,$J,358.3,5277,1,4,0)
 ;;=4^C62.92
 ;;^UTILITY(U,$J,358.3,5277,2)
 ;;=^5001238
 ;;^UTILITY(U,$J,358.3,5278,0)
 ;;=C63.2^^22^231^10
 ;;^UTILITY(U,$J,358.3,5278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5278,1,3,0)
 ;;=3^Malig Neop of Scrotum
 ;;^UTILITY(U,$J,358.3,5278,1,4,0)
 ;;=4^C63.2
 ;;^UTILITY(U,$J,358.3,5278,2)
 ;;=^267250
 ;;^UTILITY(U,$J,358.3,5279,0)
 ;;=C63.9^^22^231^4
 ;;^UTILITY(U,$J,358.3,5279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5279,1,3,0)
 ;;=3^Malig Neop of Male Genital Organ,Unspec
 ;;^UTILITY(U,$J,358.3,5279,1,4,0)
 ;;=4^C63.9
 ;;^UTILITY(U,$J,358.3,5279,2)
 ;;=^5001247
 ;;^UTILITY(U,$J,358.3,5280,0)
 ;;=C51.9^^22^232^23
 ;;^UTILITY(U,$J,358.3,5280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5280,1,3,0)
 ;;=3^Malig Neop of Vulva,Unspec
 ;;^UTILITY(U,$J,358.3,5280,1,4,0)
 ;;=4^C51.9
 ;;^UTILITY(U,$J,358.3,5280,2)
 ;;=^5001202
 ;;^UTILITY(U,$J,358.3,5281,0)
 ;;=C52.^^22^232^22
 ;;^UTILITY(U,$J,358.3,5281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5281,1,3,0)
 ;;=3^Malig Neop of Vagina
 ;;^UTILITY(U,$J,358.3,5281,1,4,0)
 ;;=4^C52.
 ;;^UTILITY(U,$J,358.3,5281,2)
 ;;=^267232
 ;;^UTILITY(U,$J,358.3,5282,0)
 ;;=D07.2^^22^232^1
 ;;^UTILITY(U,$J,358.3,5282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5282,1,3,0)
 ;;=3^Carcinoma in Situ of Vagina
 ;;^UTILITY(U,$J,358.3,5282,1,4,0)
 ;;=4^D07.2
 ;;^UTILITY(U,$J,358.3,5282,2)
 ;;=^5001944
 ;;^UTILITY(U,$J,358.3,5283,0)
 ;;=C53.0^^22^232^4
 ;;^UTILITY(U,$J,358.3,5283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5283,1,3,0)
 ;;=3^Malig Neop of Endocervix
 ;;^UTILITY(U,$J,358.3,5283,1,4,0)
 ;;=4^C53.0
 ;;^UTILITY(U,$J,358.3,5283,2)
 ;;=^267215
 ;;^UTILITY(U,$J,358.3,5284,0)
 ;;=C53.1^^22^232^6
 ;;^UTILITY(U,$J,358.3,5284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5284,1,3,0)
 ;;=3^Malig Neop of Exocervix
 ;;^UTILITY(U,$J,358.3,5284,1,4,0)
 ;;=4^C53.1
 ;;^UTILITY(U,$J,358.3,5284,2)
 ;;=^267216
 ;;^UTILITY(U,$J,358.3,5285,0)
 ;;=C53.8^^22^232^15
 ;;^UTILITY(U,$J,358.3,5285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5285,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Cervix Uteri
 ;;^UTILITY(U,$J,358.3,5285,1,4,0)
 ;;=4^C53.8
 ;;^UTILITY(U,$J,358.3,5285,2)
 ;;=^5001203
 ;;^UTILITY(U,$J,358.3,5286,0)
 ;;=C53.9^^22^232^2
 ;;^UTILITY(U,$J,358.3,5286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5286,1,3,0)
 ;;=3^Malig Neop of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,5286,1,4,0)
 ;;=4^C53.9
 ;;^UTILITY(U,$J,358.3,5286,2)
 ;;=^5001204
 ;;^UTILITY(U,$J,358.3,5287,0)
 ;;=C54.0^^22^232^10
 ;;^UTILITY(U,$J,358.3,5287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5287,1,3,0)
 ;;=3^Malig Neop of Isthmus Uteri
 ;;^UTILITY(U,$J,358.3,5287,1,4,0)
 ;;=4^C54.0
 ;;^UTILITY(U,$J,358.3,5287,2)
 ;;=^5001205
 ;;^UTILITY(U,$J,358.3,5288,0)
 ;;=C54.1^^22^232^5
 ;;^UTILITY(U,$J,358.3,5288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5288,1,3,0)
 ;;=3^Malig Neop of Endometrium
 ;;^UTILITY(U,$J,358.3,5288,1,4,0)
 ;;=4^C54.1
 ;;^UTILITY(U,$J,358.3,5288,2)
 ;;=^5001206
 ;;^UTILITY(U,$J,358.3,5289,0)
 ;;=C54.2^^22^232^14
 ;;^UTILITY(U,$J,358.3,5289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5289,1,3,0)
 ;;=3^Malig Neop of Myometrium
 ;;^UTILITY(U,$J,358.3,5289,1,4,0)
 ;;=4^C54.2
 ;;^UTILITY(U,$J,358.3,5289,2)
 ;;=^5001207
 ;;^UTILITY(U,$J,358.3,5290,0)
 ;;=C54.3^^22^232^9
 ;;^UTILITY(U,$J,358.3,5290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5290,1,3,0)
 ;;=3^Malig Neop of Fundus Uteri
 ;;^UTILITY(U,$J,358.3,5290,1,4,0)
 ;;=4^C54.3
 ;;^UTILITY(U,$J,358.3,5290,2)
 ;;=^5001208
 ;;^UTILITY(U,$J,358.3,5291,0)
 ;;=C54.8^^22^232^16
 ;;^UTILITY(U,$J,358.3,5291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5291,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Corpus Uteri
 ;;^UTILITY(U,$J,358.3,5291,1,4,0)
 ;;=4^C54.8
 ;;^UTILITY(U,$J,358.3,5291,2)
 ;;=^5001209
 ;;^UTILITY(U,$J,358.3,5292,0)
 ;;=C54.9^^22^232^3
 ;;^UTILITY(U,$J,358.3,5292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5292,1,3,0)
 ;;=3^Malig Neop of Corpus Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,5292,1,4,0)
 ;;=4^C54.9
 ;;^UTILITY(U,$J,358.3,5292,2)
 ;;=^5001210
 ;;^UTILITY(U,$J,358.3,5293,0)
 ;;=C55.^^22^232^21
 ;;^UTILITY(U,$J,358.3,5293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5293,1,3,0)
 ;;=3^Malig Neop of Uterus,Part Unspec
 ;;^UTILITY(U,$J,358.3,5293,1,4,0)
 ;;=4^C55.
 ;;^UTILITY(U,$J,358.3,5293,2)
 ;;=^5001211
 ;;^UTILITY(U,$J,358.3,5294,0)
 ;;=C56.1^^22^232^19
 ;;^UTILITY(U,$J,358.3,5294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5294,1,3,0)
 ;;=3^Malig Neop of Right Ovary
 ;;^UTILITY(U,$J,358.3,5294,1,4,0)
 ;;=4^C56.1
 ;;^UTILITY(U,$J,358.3,5294,2)
 ;;=^5001212
 ;;^UTILITY(U,$J,358.3,5295,0)
 ;;=C56.2^^22^232^13
 ;;^UTILITY(U,$J,358.3,5295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5295,1,3,0)
 ;;=3^Malig Neop of Left Ovary
 ;;^UTILITY(U,$J,358.3,5295,1,4,0)
 ;;=4^C56.2
 ;;^UTILITY(U,$J,358.3,5295,2)
 ;;=^5001213
 ;;^UTILITY(U,$J,358.3,5296,0)
 ;;=C57.01^^22^232^18
 ;;^UTILITY(U,$J,358.3,5296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5296,1,3,0)
 ;;=3^Malig Neop of Right Fallopian Tube
 ;;^UTILITY(U,$J,358.3,5296,1,4,0)
 ;;=4^C57.01
 ;;^UTILITY(U,$J,358.3,5296,2)
 ;;=^5001216
 ;;^UTILITY(U,$J,358.3,5297,0)
 ;;=C57.02^^22^232^12
 ;;^UTILITY(U,$J,358.3,5297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5297,1,3,0)
 ;;=3^Malig Neop of Left Fallopian Tube
 ;;^UTILITY(U,$J,358.3,5297,1,4,0)
 ;;=4^C57.02
 ;;^UTILITY(U,$J,358.3,5297,2)
 ;;=^5001217
 ;;^UTILITY(U,$J,358.3,5298,0)
 ;;=C57.11^^22^232^17
 ;;^UTILITY(U,$J,358.3,5298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5298,1,3,0)
 ;;=3^Malig Neop of Right Broad Ligament
 ;;^UTILITY(U,$J,358.3,5298,1,4,0)
 ;;=4^C57.11
 ;;^UTILITY(U,$J,358.3,5298,2)
 ;;=^5001219
 ;;^UTILITY(U,$J,358.3,5299,0)
 ;;=C57.12^^22^232^11
 ;;^UTILITY(U,$J,358.3,5299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5299,1,3,0)
 ;;=3^Malig Neop of Left Broad Ligament
 ;;^UTILITY(U,$J,358.3,5299,1,4,0)
 ;;=4^C57.12
 ;;^UTILITY(U,$J,358.3,5299,2)
 ;;=^5001220
 ;;^UTILITY(U,$J,358.3,5300,0)
 ;;=C57.4^^22^232^20
 ;;^UTILITY(U,$J,358.3,5300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5300,1,3,0)
 ;;=3^Malig Neop of Uterine Adnexa,Unspec
 ;;^UTILITY(U,$J,358.3,5300,1,4,0)
 ;;=4^C57.4
 ;;^UTILITY(U,$J,358.3,5300,2)
 ;;=^5001224
 ;;^UTILITY(U,$J,358.3,5301,0)
 ;;=C57.7^^22^232^8
 ;;^UTILITY(U,$J,358.3,5301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5301,1,3,0)
 ;;=3^Malig Neop of Female Genital Organs NEC
 ;;^UTILITY(U,$J,358.3,5301,1,4,0)
 ;;=4^C57.7
 ;;^UTILITY(U,$J,358.3,5301,2)
 ;;=^5001225
 ;;^UTILITY(U,$J,358.3,5302,0)
 ;;=C57.9^^22^232^7
 ;;^UTILITY(U,$J,358.3,5302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5302,1,3,0)
 ;;=3^Malig Neop of Female Genital Organ,Unspec
 ;;^UTILITY(U,$J,358.3,5302,1,4,0)
 ;;=4^C57.9
 ;;^UTILITY(U,$J,358.3,5302,2)
 ;;=^5001227
 ;;^UTILITY(U,$J,358.3,5303,0)
 ;;=C05.0^^22^233^1
 ;;^UTILITY(U,$J,358.3,5303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5303,1,3,0)
 ;;=3^Malig Neop of Hard Palate
 ;;^UTILITY(U,$J,358.3,5303,1,4,0)
 ;;=4^C05.0
 ;;^UTILITY(U,$J,358.3,5303,2)
 ;;=^267021
 ;;^UTILITY(U,$J,358.3,5304,0)
 ;;=C05.1^^22^233^4
 ;;^UTILITY(U,$J,358.3,5304,1,0)
 ;;=^358.31IA^4^2
