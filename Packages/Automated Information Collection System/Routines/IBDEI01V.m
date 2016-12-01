IBDEI01V ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1923,1,3,0)
 ;;=3^Cor Angio, RHC/LHC, V-Gram, incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1924,0)
 ;;=93461^^9^138^19^^^^1
 ;;^UTILITY(U,$J,358.3,1924,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1924,1,2,0)
 ;;=2^93461
 ;;^UTILITY(U,$J,358.3,1924,1,3,0)
 ;;=3^R&L Hrt Angio,V-Gram,Bypass,incl inj & S&I
 ;;^UTILITY(U,$J,358.3,1925,0)
 ;;=93462^^9^138^14^^^^1
 ;;^UTILITY(U,$J,358.3,1925,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1925,1,2,0)
 ;;=2^93462
 ;;^UTILITY(U,$J,358.3,1925,1,3,0)
 ;;=3^Lt Hrt Cath Trnsptl Puncture
 ;;^UTILITY(U,$J,358.3,1926,0)
 ;;=93561^^9^138^7^^^^1
 ;;^UTILITY(U,$J,358.3,1926,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1926,1,2,0)
 ;;=2^93561
 ;;^UTILITY(U,$J,358.3,1926,1,3,0)
 ;;=3^Indicator Dilution Study-Arterial/Ven
 ;;^UTILITY(U,$J,358.3,1927,0)
 ;;=93562^^9^138^22^^^^1
 ;;^UTILITY(U,$J,358.3,1927,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1927,1,2,0)
 ;;=2^93562
 ;;^UTILITY(U,$J,358.3,1927,1,3,0)
 ;;=3^Subsq Measure of Cardiac Output
 ;;^UTILITY(U,$J,358.3,1928,0)
 ;;=93463^^9^138^15^^^^1
 ;;^UTILITY(U,$J,358.3,1928,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1928,1,2,0)
 ;;=2^93463
 ;;^UTILITY(U,$J,358.3,1928,1,3,0)
 ;;=3^Pharm agent admin, when performed
 ;;^UTILITY(U,$J,358.3,1929,0)
 ;;=93505^^9^138^6^^^^1
 ;;^UTILITY(U,$J,358.3,1929,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1929,1,2,0)
 ;;=2^93505
 ;;^UTILITY(U,$J,358.3,1929,1,3,0)
 ;;=3^Endomyocardial Biopsy
 ;;^UTILITY(U,$J,358.3,1930,0)
 ;;=93464^^9^138^16^^^^1
 ;;^UTILITY(U,$J,358.3,1930,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1930,1,2,0)
 ;;=2^93464
 ;;^UTILITY(U,$J,358.3,1930,1,3,0)
 ;;=3^Phys Exercise Tst w/Hemodynamic Meas
 ;;^UTILITY(U,$J,358.3,1931,0)
 ;;=93564^^9^138^8^^^^1
 ;;^UTILITY(U,$J,358.3,1931,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1931,1,2,0)
 ;;=2^93564
 ;;^UTILITY(U,$J,358.3,1931,1,3,0)
 ;;=3^Inject Hrt Cong Cath Art/Grft
 ;;^UTILITY(U,$J,358.3,1932,0)
 ;;=93568^^9^138^9^^^^1
 ;;^UTILITY(U,$J,358.3,1932,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1932,1,2,0)
 ;;=2^93568
 ;;^UTILITY(U,$J,358.3,1932,1,3,0)
 ;;=3^Inject Pulm Art Hrt Cath
 ;;^UTILITY(U,$J,358.3,1933,0)
 ;;=93566^^9^138^10^^^^1
 ;;^UTILITY(U,$J,358.3,1933,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1933,1,2,0)
 ;;=2^93566
 ;;^UTILITY(U,$J,358.3,1933,1,3,0)
 ;;=3^Inject R Ventr/Atrial Angio
 ;;^UTILITY(U,$J,358.3,1934,0)
 ;;=93567^^9^138^11^^^^1
 ;;^UTILITY(U,$J,358.3,1934,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1934,1,2,0)
 ;;=2^93567
 ;;^UTILITY(U,$J,358.3,1934,1,3,0)
 ;;=3^Inject Suprvlv Aortography
 ;;^UTILITY(U,$J,358.3,1935,0)
 ;;=93532^^9^138^17^^^^1
 ;;^UTILITY(U,$J,358.3,1935,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1935,1,2,0)
 ;;=2^93532
 ;;^UTILITY(U,$J,358.3,1935,1,3,0)
 ;;=3^R&L HC for Congenital Card Anomalies
 ;;^UTILITY(U,$J,358.3,1936,0)
 ;;=93580^^9^138^24^^^^1
 ;;^UTILITY(U,$J,358.3,1936,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1936,1,2,0)
 ;;=2^93580
 ;;^UTILITY(U,$J,358.3,1936,1,3,0)
 ;;=3^Transcath Closure of ASD
 ;;^UTILITY(U,$J,358.3,1937,0)
 ;;=36100^^9^139^11^^^^1
 ;;^UTILITY(U,$J,358.3,1937,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1937,1,2,0)
 ;;=2^36100
 ;;^UTILITY(U,$J,358.3,1937,1,3,0)
 ;;=3^Intro Needle Or Cath Carotid Or Vert. Artery
 ;;^UTILITY(U,$J,358.3,1938,0)
 ;;=36120^^9^139^10^^^^1
 ;;^UTILITY(U,$J,358.3,1938,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1938,1,2,0)
 ;;=2^36120
 ;;^UTILITY(U,$J,358.3,1938,1,3,0)
 ;;=3^Intro Needle Or Cath Brachial Artery
 ;;^UTILITY(U,$J,358.3,1939,0)
 ;;=36140^^9^139^12^^^^1
 ;;^UTILITY(U,$J,358.3,1939,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1939,1,2,0)
 ;;=2^36140
 ;;^UTILITY(U,$J,358.3,1939,1,3,0)
 ;;=3^Intro Needle Or Cath Ext Artery
 ;;^UTILITY(U,$J,358.3,1940,0)
 ;;=36215^^9^139^40^^^^1
 ;;^UTILITY(U,$J,358.3,1940,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1940,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,1940,1,3,0)
 ;;=3^Select Cath Arterial 1st Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,1941,0)
 ;;=36011^^9^139^41^^^^1
 ;;^UTILITY(U,$J,358.3,1941,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1941,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,1941,1,3,0)
 ;;=3^Select Cath Venous 1st Order (Renal Jug)
 ;;^UTILITY(U,$J,358.3,1942,0)
 ;;=36245^^9^139^35^^^^1
 ;;^UTILITY(U,$J,358.3,1942,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1942,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,1942,1,3,0)
 ;;=3^Select Cath 1st Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1943,0)
 ;;=36246^^9^139^36^^^^1
 ;;^UTILITY(U,$J,358.3,1943,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1943,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,1943,1,3,0)
 ;;=3^Select Cath 2nd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1944,0)
 ;;=36247^^9^139^38^^^^1
 ;;^UTILITY(U,$J,358.3,1944,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1944,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,1944,1,3,0)
 ;;=3^Select Cath 3rd Order Abd/Pelvic/Le Artery
 ;;^UTILITY(U,$J,358.3,1945,0)
 ;;=36216^^9^139^37^^^^1
 ;;^UTILITY(U,$J,358.3,1945,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1945,1,2,0)
 ;;=2^36216
 ;;^UTILITY(U,$J,358.3,1945,1,3,0)
 ;;=3^Select Cath 2nd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,1946,0)
 ;;=36217^^9^139^39^^^^1
 ;;^UTILITY(U,$J,358.3,1946,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1946,1,2,0)
 ;;=2^36217
 ;;^UTILITY(U,$J,358.3,1946,1,3,0)
 ;;=3^Select Cath 3rd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,1947,0)
 ;;=36218^^9^139^5^^^^1
 ;;^UTILITY(U,$J,358.3,1947,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1947,1,2,0)
 ;;=2^36218
 ;;^UTILITY(U,$J,358.3,1947,1,3,0)
 ;;=3^Each Addl 2nd/3rd Order Thor/Ue/Head
 ;;^UTILITY(U,$J,358.3,1948,0)
 ;;=36248^^9^139^4^^^^1
 ;;^UTILITY(U,$J,358.3,1948,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1948,1,2,0)
 ;;=2^36248
 ;;^UTILITY(U,$J,358.3,1948,1,3,0)
 ;;=3^Each Addl 2nd/3rd Order Pelvic/Le
 ;;^UTILITY(U,$J,358.3,1949,0)
 ;;=36200^^9^139^13^^^^1
 ;;^UTILITY(U,$J,358.3,1949,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1949,1,2,0)
 ;;=2^36200
 ;;^UTILITY(U,$J,358.3,1949,1,3,0)
 ;;=3^Non-Select Cath, Aorta
 ;;^UTILITY(U,$J,358.3,1950,0)
 ;;=33010^^9^139^56^^^^1
 ;;^UTILITY(U,$J,358.3,1950,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1950,1,2,0)
 ;;=2^33010
 ;;^UTILITY(U,$J,358.3,1950,1,3,0)
 ;;=3^Visceral Selective
 ;;^UTILITY(U,$J,358.3,1951,0)
 ;;=35471^^9^139^31^^^^1
 ;;^UTILITY(U,$J,358.3,1951,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1951,1,2,0)
 ;;=2^35471
 ;;^UTILITY(U,$J,358.3,1951,1,3,0)
 ;;=3^Repair Arterial Blockage
 ;;^UTILITY(U,$J,358.3,1952,0)
 ;;=35475^^9^139^15^^^^1
 ;;^UTILITY(U,$J,358.3,1952,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1952,1,2,0)
 ;;=2^35475
 ;;^UTILITY(U,$J,358.3,1952,1,3,0)
 ;;=3^Pelvic Selective
 ;;^UTILITY(U,$J,358.3,1953,0)
 ;;=36005^^9^139^6^^^^1
 ;;^UTILITY(U,$J,358.3,1953,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1953,1,2,0)
 ;;=2^36005
 ;;^UTILITY(U,$J,358.3,1953,1,3,0)
 ;;=3^Injection Ext Venography
 ;;^UTILITY(U,$J,358.3,1954,0)
 ;;=36147^^9^139^1^^^^1
 ;;^UTILITY(U,$J,358.3,1954,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1954,1,2,0)
 ;;=2^36147
 ;;^UTILITY(U,$J,358.3,1954,1,3,0)
 ;;=3^Access AV Dial Grft for Eval
 ;;^UTILITY(U,$J,358.3,1955,0)
 ;;=36148^^9^139^2^^^^1
 ;;^UTILITY(U,$J,358.3,1955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1955,1,2,0)
 ;;=2^36148
 ;;^UTILITY(U,$J,358.3,1955,1,3,0)
 ;;=3^Access AV Dial Grft for Eval,Ea Addl
 ;;^UTILITY(U,$J,358.3,1956,0)
 ;;=36251^^9^139^33^^^^1
 ;;^UTILITY(U,$J,358.3,1956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1956,1,2,0)
 ;;=2^36251
 ;;^UTILITY(U,$J,358.3,1956,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art
 ;;^UTILITY(U,$J,358.3,1957,0)
 ;;=36252^^9^139^34^^^^1
 ;;^UTILITY(U,$J,358.3,1957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1957,1,2,0)
 ;;=2^36252
 ;;^UTILITY(U,$J,358.3,1957,1,3,0)
 ;;=3^Select Cath 1st Main Ren&Acc Art Bilat
 ;;^UTILITY(U,$J,358.3,1958,0)
 ;;=36254^^9^139^7^^^^1
 ;;^UTILITY(U,$J,358.3,1958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1958,1,2,0)
 ;;=2^36254
 ;;^UTILITY(U,$J,358.3,1958,1,3,0)
 ;;=3^Ins Cath Ren Art 2nd+ Bilat
 ;;^UTILITY(U,$J,358.3,1959,0)
 ;;=36253^^9^139^8^^^^1
 ;;^UTILITY(U,$J,358.3,1959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1959,1,2,0)
 ;;=2^36253
 ;;^UTILITY(U,$J,358.3,1959,1,3,0)
 ;;=3^Ins Cath Ren Art 2nd+ Unilat
 ;;^UTILITY(U,$J,358.3,1960,0)
 ;;=37191^^9^139^9^^^^1
 ;;^UTILITY(U,$J,358.3,1960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1960,1,2,0)
 ;;=2^37191
 ;;^UTILITY(U,$J,358.3,1960,1,3,0)
 ;;=3^Ins Intravas Vena Cava Filter,Endovas
 ;;^UTILITY(U,$J,358.3,1961,0)
 ;;=36222^^9^139^18^^^^1
 ;;^UTILITY(U,$J,358.3,1961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1961,1,2,0)
 ;;=2^36222
 ;;^UTILITY(U,$J,358.3,1961,1,3,0)
 ;;=3^Place Cath Carotid/Inom Art
 ;;^UTILITY(U,$J,358.3,1962,0)
 ;;=36223^^9^139^17^^^^1
 ;;^UTILITY(U,$J,358.3,1962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1962,1,2,0)
 ;;=2^36223
 ;;^UTILITY(U,$J,358.3,1962,1,3,0)
 ;;=3^Place Cath Carotid Inc Extracranial
 ;;^UTILITY(U,$J,358.3,1963,0)
 ;;=36224^^9^139^16^^^^1
 ;;^UTILITY(U,$J,358.3,1963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1963,1,2,0)
 ;;=2^36224
 ;;^UTILITY(U,$J,358.3,1963,1,3,0)
 ;;=3^Place Cath Carotid Art
 ;;^UTILITY(U,$J,358.3,1964,0)
 ;;=36225^^9^139^20^^^^1
 ;;^UTILITY(U,$J,358.3,1964,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1964,1,2,0)
 ;;=2^36225
 ;;^UTILITY(U,$J,358.3,1964,1,3,0)
 ;;=3^Place Cath Subclavian Art
 ;;^UTILITY(U,$J,358.3,1965,0)
 ;;=36226^^9^139^22^^^^1
 ;;^UTILITY(U,$J,358.3,1965,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1965,1,2,0)
 ;;=2^36226
 ;;^UTILITY(U,$J,358.3,1965,1,3,0)
 ;;=3^Place Cath Vertebral Art
 ;;^UTILITY(U,$J,358.3,1966,0)
 ;;=36227^^9^139^23^^^^1
 ;;^UTILITY(U,$J,358.3,1966,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1966,1,2,0)
 ;;=2^36227
