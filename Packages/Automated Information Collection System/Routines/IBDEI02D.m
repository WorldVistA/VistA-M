IBDEI02D ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1911,1,3,0)
 ;;=3^Atrial Flutter,Atypical
 ;;^UTILITY(U,$J,358.3,1911,1,4,0)
 ;;=4^I48.4
 ;;^UTILITY(U,$J,358.3,1911,2)
 ;;=^5007228
 ;;^UTILITY(U,$J,358.3,1912,0)
 ;;=I25.5^^14^153^19
 ;;^UTILITY(U,$J,358.3,1912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1912,1,3,0)
 ;;=3^Cardiomyopathy,Ischemic
 ;;^UTILITY(U,$J,358.3,1912,1,4,0)
 ;;=4^I25.5
 ;;^UTILITY(U,$J,358.3,1912,2)
 ;;=^5007115
 ;;^UTILITY(U,$J,358.3,1913,0)
 ;;=I42.0^^14^153^18
 ;;^UTILITY(U,$J,358.3,1913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1913,1,3,0)
 ;;=3^Cardiomyopathy,Dilated
 ;;^UTILITY(U,$J,358.3,1913,1,4,0)
 ;;=4^I42.0
 ;;^UTILITY(U,$J,358.3,1913,2)
 ;;=^5007194
 ;;^UTILITY(U,$J,358.3,1914,0)
 ;;=I25.110^^14^154^15
 ;;^UTILITY(U,$J,358.3,1914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1914,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1914,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,1914,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,1915,0)
 ;;=I25.700^^14^154^34
 ;;^UTILITY(U,$J,358.3,1915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1915,1,3,0)
 ;;=3^Athscl of CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1915,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,1915,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,1916,0)
 ;;=I25.710^^14^154^10
 ;;^UTILITY(U,$J,358.3,1916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1916,1,3,0)
 ;;=3^Athscl Autologous Vein CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1916,1,4,0)
 ;;=4^I25.710
 ;;^UTILITY(U,$J,358.3,1916,2)
 ;;=^5007121
 ;;^UTILITY(U,$J,358.3,1917,0)
 ;;=I25.720^^14^154^6
 ;;^UTILITY(U,$J,358.3,1917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1917,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1917,1,4,0)
 ;;=4^I25.720
 ;;^UTILITY(U,$J,358.3,1917,2)
 ;;=^5007125
 ;;^UTILITY(U,$J,358.3,1918,0)
 ;;=I25.730^^14^154^24
 ;;^UTILITY(U,$J,358.3,1918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1918,1,3,0)
 ;;=3^Athscl Nonautologous Biological CABG w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,1918,1,4,0)
 ;;=4^I25.730
 ;;^UTILITY(U,$J,358.3,1918,2)
 ;;=^5007127
 ;;^UTILITY(U,$J,358.3,1919,0)
 ;;=I25.750^^14^154^19
 ;;^UTILITY(U,$J,358.3,1919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1919,1,3,0)
 ;;=3^Athscl Native Cor Art of Transplanted Hrt w/ Unstable Angina
 ;;^UTILITY(U,$J,358.3,1919,1,4,0)
 ;;=4^I25.750
 ;;^UTILITY(U,$J,358.3,1919,2)
 ;;=^5007131
 ;;^UTILITY(U,$J,358.3,1920,0)
 ;;=I25.760^^14^154^11
 ;;^UTILITY(U,$J,358.3,1920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1920,1,3,0)
 ;;=3^Athscl Bypass of Cor Art of Transplanted Hrt w/ Unstable Angina
 ;;^UTILITY(U,$J,358.3,1920,1,4,0)
 ;;=4^I25.760
 ;;^UTILITY(U,$J,358.3,1920,2)
 ;;=^5007135
 ;;^UTILITY(U,$J,358.3,1921,0)
 ;;=I25.790^^14^154^35
 ;;^UTILITY(U,$J,358.3,1921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1921,1,3,0)
 ;;=3^Athscl of CABG w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1921,1,4,0)
 ;;=4^I25.790
 ;;^UTILITY(U,$J,358.3,1921,2)
 ;;=^5007139
 ;;^UTILITY(U,$J,358.3,1922,0)
 ;;=I20.0^^14^154^42
 ;;^UTILITY(U,$J,358.3,1922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1922,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,1922,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,1922,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,1923,0)
 ;;=I25.759^^14^154^20
 ;;^UTILITY(U,$J,358.3,1923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1923,1,3,0)
 ;;=3^Athscl Native Cor Art of Transplanted Hrt w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,1923,1,4,0)
 ;;=4^I25.759
 ;;^UTILITY(U,$J,358.3,1923,2)
 ;;=^5007134
 ;;^UTILITY(U,$J,358.3,1924,0)
 ;;=I25.761^^14^154^12
 ;;^UTILITY(U,$J,358.3,1924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1924,1,3,0)
 ;;=3^Athscl Bypass of Cor Art of Transplanted Hrt w/ Ang Pctrs w/ Spasm
 ;;^UTILITY(U,$J,358.3,1924,1,4,0)
 ;;=4^I25.761
 ;;^UTILITY(U,$J,358.3,1924,2)
 ;;=^5007136
 ;;^UTILITY(U,$J,358.3,1925,0)
 ;;=I25.768^^14^154^13
 ;;^UTILITY(U,$J,358.3,1925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1925,1,3,0)
 ;;=3^Athscl Bypass of Cor Art of Transplanted Hrt w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1925,1,4,0)
 ;;=4^I25.768
 ;;^UTILITY(U,$J,358.3,1925,2)
 ;;=^5007137
 ;;^UTILITY(U,$J,358.3,1926,0)
 ;;=I25.769^^14^154^14
 ;;^UTILITY(U,$J,358.3,1926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1926,1,3,0)
 ;;=3^Athscl Bypass of Cor Art of Transplanted Hrt w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1926,1,4,0)
 ;;=4^I25.769
 ;;^UTILITY(U,$J,358.3,1926,2)
 ;;=^5007138
 ;;^UTILITY(U,$J,358.3,1927,0)
 ;;=I25.791^^14^154^28
 ;;^UTILITY(U,$J,358.3,1927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1927,1,3,0)
 ;;=3^Athscl of CABG w/ Ang Pctrs w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,1927,1,4,0)
 ;;=4^I25.791
 ;;^UTILITY(U,$J,358.3,1927,2)
 ;;=^5007140
 ;;^UTILITY(U,$J,358.3,1928,0)
 ;;=I25.798^^14^154^30
 ;;^UTILITY(U,$J,358.3,1928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1928,1,3,0)
 ;;=3^Athscl of CABG w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1928,1,4,0)
 ;;=4^I25.798
 ;;^UTILITY(U,$J,358.3,1928,2)
 ;;=^5133558
 ;;^UTILITY(U,$J,358.3,1929,0)
 ;;=I25.799^^14^154^32
 ;;^UTILITY(U,$J,358.3,1929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1929,1,3,0)
 ;;=3^Athscl of CABG w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1929,1,4,0)
 ;;=4^I25.799
 ;;^UTILITY(U,$J,358.3,1929,2)
 ;;=^5133559
 ;;^UTILITY(U,$J,358.3,1930,0)
 ;;=I25.111^^14^154^16
 ;;^UTILITY(U,$J,358.3,1930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1930,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Ang Pctrs w/ Spasm
 ;;^UTILITY(U,$J,358.3,1930,1,4,0)
 ;;=4^I25.111
 ;;^UTILITY(U,$J,358.3,1930,2)
 ;;=^5007109
 ;;^UTILITY(U,$J,358.3,1931,0)
 ;;=I25.118^^14^154^17
 ;;^UTILITY(U,$J,358.3,1931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1931,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1931,1,4,0)
 ;;=4^I25.118
 ;;^UTILITY(U,$J,358.3,1931,2)
 ;;=^5007110
 ;;^UTILITY(U,$J,358.3,1932,0)
 ;;=I25.119^^14^154^18
 ;;^UTILITY(U,$J,358.3,1932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1932,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1932,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,1932,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,1933,0)
 ;;=I25.701^^14^154^29
 ;;^UTILITY(U,$J,358.3,1933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1933,1,3,0)
 ;;=3^Athscl of CABG w/ Ang Pctrs w/ Documented Spasm,Unspec
 ;;^UTILITY(U,$J,358.3,1933,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,1933,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,1934,0)
 ;;=I25.708^^14^154^31
 ;;^UTILITY(U,$J,358.3,1934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1934,1,3,0)
 ;;=3^Athscl of CABG w/ Oth Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,1934,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,1934,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,1935,0)
 ;;=I25.709^^14^154^33
 ;;^UTILITY(U,$J,358.3,1935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1935,1,3,0)
 ;;=3^Athscl of CABG w/ Unspec Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,1935,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,1935,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,1936,0)
 ;;=I25.711^^14^154^7
 ;;^UTILITY(U,$J,358.3,1936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1936,1,3,0)
 ;;=3^Athscl Autologous Vein CABG w/ Ang Pctrs w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,1936,1,4,0)
 ;;=4^I25.711
 ;;^UTILITY(U,$J,358.3,1936,2)
 ;;=^5007122
 ;;^UTILITY(U,$J,358.3,1937,0)
 ;;=I25.718^^14^154^8
 ;;^UTILITY(U,$J,358.3,1937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1937,1,3,0)
 ;;=3^Athscl Autologous Vein CABG w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,1937,1,4,0)
 ;;=4^I25.718
 ;;^UTILITY(U,$J,358.3,1937,2)
 ;;=^5007123
 ;;^UTILITY(U,$J,358.3,1938,0)
 ;;=I25.719^^14^154^9
