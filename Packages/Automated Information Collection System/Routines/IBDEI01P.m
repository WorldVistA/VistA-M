IBDEI01P ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1897,0)
 ;;=S54.02XA^^8^91^230
 ;;^UTILITY(U,$J,358.3,1897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1897,1,3,0)
 ;;=3^Injury Ulnar Nerve Left Forearm,Init Encntr
 ;;^UTILITY(U,$J,358.3,1897,1,4,0)
 ;;=4^S54.02XA
 ;;^UTILITY(U,$J,358.3,1897,2)
 ;;=^5031412
 ;;^UTILITY(U,$J,358.3,1898,0)
 ;;=S44.02XA^^8^91^231
 ;;^UTILITY(U,$J,358.3,1898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1898,1,3,0)
 ;;=3^Injury Ulnar Nerve Left Upper Arm,Init Encntr
 ;;^UTILITY(U,$J,358.3,1898,1,4,0)
 ;;=4^S44.02XA
 ;;^UTILITY(U,$J,358.3,1898,2)
 ;;=^5027942
 ;;^UTILITY(U,$J,358.3,1899,0)
 ;;=S64.02XA^^8^91^232
 ;;^UTILITY(U,$J,358.3,1899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1899,1,3,0)
 ;;=3^Injury Ulnar Nerve Left Wrist/Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,1899,1,4,0)
 ;;=4^S64.02XA
 ;;^UTILITY(U,$J,358.3,1899,2)
 ;;=^5035766
 ;;^UTILITY(U,$J,358.3,1900,0)
 ;;=S54.01XA^^8^91^233
 ;;^UTILITY(U,$J,358.3,1900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1900,1,3,0)
 ;;=3^Injury Ulnar Nerve Right Forearm,Init Encntr
 ;;^UTILITY(U,$J,358.3,1900,1,4,0)
 ;;=4^S54.01XA
 ;;^UTILITY(U,$J,358.3,1900,2)
 ;;=^5031409
 ;;^UTILITY(U,$J,358.3,1901,0)
 ;;=S44.01XA^^8^91^234
 ;;^UTILITY(U,$J,358.3,1901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1901,1,3,0)
 ;;=3^Injury Ulnar Nerve Right Upper Arm,Init Encntr
 ;;^UTILITY(U,$J,358.3,1901,1,4,0)
 ;;=4^S44.01XA
 ;;^UTILITY(U,$J,358.3,1901,2)
 ;;=^5027939
 ;;^UTILITY(U,$J,358.3,1902,0)
 ;;=S64.01XA^^8^91^235
 ;;^UTILITY(U,$J,358.3,1902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1902,1,3,0)
 ;;=3^Injury Ulnar Nerve Right Wrist/Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,1902,1,4,0)
 ;;=4^S64.01XA
 ;;^UTILITY(U,$J,358.3,1902,2)
 ;;=^5035763
 ;;^UTILITY(U,$J,358.3,1903,0)
 ;;=S01.322A^^8^91^239
 ;;^UTILITY(U,$J,358.3,1903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1903,1,3,0)
 ;;=3^Laceration w/ FB Left Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,1903,1,4,0)
 ;;=4^S01.322A
 ;;^UTILITY(U,$J,358.3,1903,2)
 ;;=^5134205
 ;;^UTILITY(U,$J,358.3,1904,0)
 ;;=S51.822A^^8^91^241
 ;;^UTILITY(U,$J,358.3,1904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1904,1,3,0)
 ;;=3^Laceration w/ FB Left Forearm,Init Encntr
 ;;^UTILITY(U,$J,358.3,1904,1,4,0)
 ;;=4^S51.822A
 ;;^UTILITY(U,$J,358.3,1904,2)
 ;;=^5135026
 ;;^UTILITY(U,$J,358.3,1905,0)
 ;;=S21.122A^^8^91^242
 ;;^UTILITY(U,$J,358.3,1905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1905,1,3,0)
 ;;=3^Laceration w/ FB Left Front Thorax Wall w/o Penet of Thorax Cavity,Init Encntr
 ;;^UTILITY(U,$J,358.3,1905,1,4,0)
 ;;=4^S21.122A
 ;;^UTILITY(U,$J,358.3,1905,2)
 ;;=^5134289
 ;;^UTILITY(U,$J,358.3,1906,0)
 ;;=S91.122A^^8^91^243
 ;;^UTILITY(U,$J,358.3,1906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1906,1,3,0)
 ;;=3^Laceration w/ FB Left Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,1906,1,4,0)
 ;;=4^S91.122A
 ;;^UTILITY(U,$J,358.3,1906,2)
 ;;=^5137436
 ;;^UTILITY(U,$J,358.3,1907,0)
 ;;=S61.422A^^8^91^244
 ;;^UTILITY(U,$J,358.3,1907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1907,1,3,0)
 ;;=3^Laceration w/ FB Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,1907,1,4,0)
 ;;=4^S61.422A
 ;;^UTILITY(U,$J,358.3,1907,2)
 ;;=^5135858
 ;;^UTILITY(U,$J,358.3,1908,0)
 ;;=S61.221A^^8^91^246
 ;;^UTILITY(U,$J,358.3,1908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1908,1,3,0)
 ;;=3^Laceration w/ FB Left Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,1908,1,4,0)
 ;;=4^S61.221A
 ;;^UTILITY(U,$J,358.3,1908,2)
 ;;=^5135750
 ;;^UTILITY(U,$J,358.3,1909,0)
 ;;=S91.125A^^8^91^247
 ;;^UTILITY(U,$J,358.3,1909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1909,1,3,0)
 ;;=3^Laceration w/ FB Left Lesser Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,1909,1,4,0)
 ;;=4^S91.125A
 ;;^UTILITY(U,$J,358.3,1909,2)
 ;;=^5137448
 ;;^UTILITY(U,$J,358.3,1910,0)
 ;;=S61.227A^^8^91^248
 ;;^UTILITY(U,$J,358.3,1910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1910,1,3,0)
 ;;=3^Laceration w/ FB Left Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,1910,1,4,0)
 ;;=4^S61.227A
 ;;^UTILITY(U,$J,358.3,1910,2)
 ;;=^5135759
 ;;^UTILITY(U,$J,358.3,1911,0)
 ;;=S61.223A^^8^91^249
 ;;^UTILITY(U,$J,358.3,1911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1911,1,3,0)
 ;;=3^Laceration w/ FB Left Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,1911,1,4,0)
 ;;=4^S61.223A
 ;;^UTILITY(U,$J,358.3,1911,2)
 ;;=^5135753
 ;;^UTILITY(U,$J,358.3,1912,0)
 ;;=S61.225A^^8^91^250
 ;;^UTILITY(U,$J,358.3,1912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1912,1,3,0)
 ;;=3^Laceration w/ FB Left Ring Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,1912,1,4,0)
 ;;=4^S61.225A
 ;;^UTILITY(U,$J,358.3,1912,2)
 ;;=^5135756
 ;;^UTILITY(U,$J,358.3,1913,0)
 ;;=S41.022A^^8^91^251
 ;;^UTILITY(U,$J,358.3,1913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1913,1,3,0)
 ;;=3^Laceration w/ FB Left Shoulder,Init Encntr
 ;;^UTILITY(U,$J,358.3,1913,1,4,0)
 ;;=4^S41.022A
 ;;^UTILITY(U,$J,358.3,1913,2)
 ;;=^5134610
 ;;^UTILITY(U,$J,358.3,1914,0)
 ;;=S61.522A^^8^91^253
 ;;^UTILITY(U,$J,358.3,1914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1914,1,3,0)
 ;;=3^Laceration w/ FB Left Wrist,Init Encntr
 ;;^UTILITY(U,$J,358.3,1914,1,4,0)
 ;;=4^S61.522A
 ;;^UTILITY(U,$J,358.3,1914,2)
 ;;=^5135873
 ;;^UTILITY(U,$J,358.3,1915,0)
 ;;=S31.020A^^8^91^254
 ;;^UTILITY(U,$J,358.3,1915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1915,1,3,0)
 ;;=3^Laceration w/ FB Low Back/Pelvis w/o Retroperiton Penet,Init Encntr
 ;;^UTILITY(U,$J,358.3,1915,1,4,0)
 ;;=4^S31.020A
 ;;^UTILITY(U,$J,358.3,1915,2)
 ;;=^5134406
 ;;^UTILITY(U,$J,358.3,1916,0)
 ;;=S01.82XA^^8^91^238
 ;;^UTILITY(U,$J,358.3,1916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1916,1,3,0)
 ;;=3^Laceration w/ FB Head,Init Encntr
 ;;^UTILITY(U,$J,358.3,1916,1,4,0)
 ;;=4^S01.82XA
 ;;^UTILITY(U,$J,358.3,1916,2)
 ;;=^5020228
 ;;^UTILITY(U,$J,358.3,1917,0)
 ;;=S01.321A^^8^91^255
 ;;^UTILITY(U,$J,358.3,1917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1917,1,3,0)
 ;;=3^Laceration w/ FB Right Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,1917,1,4,0)
 ;;=4^S01.321A
 ;;^UTILITY(U,$J,358.3,1917,2)
 ;;=^5020123
 ;;^UTILITY(U,$J,358.3,1918,0)
 ;;=S51.821A^^8^91^257
 ;;^UTILITY(U,$J,358.3,1918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1918,1,3,0)
 ;;=3^Laceration w/ FB Right Forearm,Init Encntr
 ;;^UTILITY(U,$J,358.3,1918,1,4,0)
 ;;=4^S51.821A
 ;;^UTILITY(U,$J,358.3,1918,2)
 ;;=^5028674
 ;;^UTILITY(U,$J,358.3,1919,0)
 ;;=S21.121A^^8^91^268
 ;;^UTILITY(U,$J,358.3,1919,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1919,1,3,0)
 ;;=3^Laceration w/ FB Right Thorax Wall w/o Thoracic Cavity Penetration,Init Encntr
 ;;^UTILITY(U,$J,358.3,1919,1,4,0)
 ;;=4^S21.121A
 ;;^UTILITY(U,$J,358.3,1919,2)
 ;;=^5022688
 ;;^UTILITY(U,$J,358.3,1920,0)
 ;;=S91.121A^^8^91^258
 ;;^UTILITY(U,$J,358.3,1920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1920,1,3,0)
 ;;=3^Laceration w/ FB Right Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,1920,1,4,0)
 ;;=4^S91.121A
 ;;^UTILITY(U,$J,358.3,1920,2)
 ;;=^5044204
 ;;^UTILITY(U,$J,358.3,1921,0)
 ;;=S61.421A^^8^91^259
 ;;^UTILITY(U,$J,358.3,1921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1921,1,3,0)
 ;;=3^Laceration w/ FB Right Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,1921,1,4,0)
 ;;=4^S61.421A
 ;;^UTILITY(U,$J,358.3,1921,2)
 ;;=^5032996
 ;;^UTILITY(U,$J,358.3,1922,0)
 ;;=S61.220A^^8^91^261
 ;;^UTILITY(U,$J,358.3,1922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1922,1,3,0)
 ;;=3^Laceration w/ FB Right Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,1922,1,4,0)
 ;;=4^S61.220A
 ;;^UTILITY(U,$J,358.3,1922,2)
 ;;=^5032801
 ;;^UTILITY(U,$J,358.3,1923,0)
 ;;=S91.124A^^8^91^262
 ;;^UTILITY(U,$J,358.3,1923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1923,1,3,0)
 ;;=3^Laceration w/ FB Right Lesser Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,1923,1,4,0)
 ;;=4^S91.124A
 ;;^UTILITY(U,$J,358.3,1923,2)
 ;;=^5044207
 ;;^UTILITY(U,$J,358.3,1924,0)
 ;;=S61.226A^^8^91^263
 ;;^UTILITY(U,$J,358.3,1924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1924,1,3,0)
 ;;=3^Laceration w/ FB Right Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,1924,1,4,0)
 ;;=4^S61.226A
 ;;^UTILITY(U,$J,358.3,1924,2)
 ;;=^5032810
 ;;^UTILITY(U,$J,358.3,1925,0)
 ;;=S61.222A^^8^91^264
 ;;^UTILITY(U,$J,358.3,1925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1925,1,3,0)
 ;;=3^Laceration w/ FB Right Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,1925,1,4,0)
 ;;=4^S61.222A
 ;;^UTILITY(U,$J,358.3,1925,2)
 ;;=^5032804
 ;;^UTILITY(U,$J,358.3,1926,0)
 ;;=S61.224A^^8^91^265
 ;;^UTILITY(U,$J,358.3,1926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1926,1,3,0)
 ;;=3^Laceration w/ FB Right Ring Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,1926,1,4,0)
 ;;=4^S61.224A
 ;;^UTILITY(U,$J,358.3,1926,2)
 ;;=^5032807
 ;;^UTILITY(U,$J,358.3,1927,0)
 ;;=S41.021A^^8^91^266
 ;;^UTILITY(U,$J,358.3,1927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1927,1,3,0)
 ;;=3^Laceration w/ FB Right Shoulder,Init Encntr
 ;;^UTILITY(U,$J,358.3,1927,1,4,0)
 ;;=4^S41.021A
 ;;^UTILITY(U,$J,358.3,1927,2)
 ;;=^5026306
 ;;^UTILITY(U,$J,358.3,1928,0)
 ;;=S61.521A^^8^91^269
 ;;^UTILITY(U,$J,358.3,1928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1928,1,3,0)
 ;;=3^Laceration w/ FB Right Wrist,Init Encntr
 ;;^UTILITY(U,$J,358.3,1928,1,4,0)
 ;;=4^S61.521A
 ;;^UTILITY(U,$J,358.3,1928,2)
 ;;=^5033035
 ;;^UTILITY(U,$J,358.3,1929,0)
 ;;=S01.02XA^^8^91^270
 ;;^UTILITY(U,$J,358.3,1929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1929,1,3,0)
 ;;=3^Laceration w/ FB Scalp,Init Encntr
 ;;^UTILITY(U,$J,358.3,1929,1,4,0)
 ;;=4^S01.02XA
 ;;^UTILITY(U,$J,358.3,1929,2)
 ;;=^5020039
 ;;^UTILITY(U,$J,358.3,1930,0)
 ;;=S01.429A^^8^91^271
 ;;^UTILITY(U,$J,358.3,1930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1930,1,3,0)
 ;;=3^Laceration w/ FB Unspec Cheek/TMJ Area,Init Encntr
