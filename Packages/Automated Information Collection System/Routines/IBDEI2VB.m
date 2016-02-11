IBDEI2VB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48127,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,48127,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,48128,0)
 ;;=F40.01^^211^2382^2
 ;;^UTILITY(U,$J,358.3,48128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48128,1,3,0)
 ;;=3^Agoraphobia w/ Panic Disorder
 ;;^UTILITY(U,$J,358.3,48128,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,48128,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,48129,0)
 ;;=F41.9^^211^2382^9
 ;;^UTILITY(U,$J,358.3,48129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48129,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,48129,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,48129,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,48130,0)
 ;;=F60.5^^211^2382^36
 ;;^UTILITY(U,$J,358.3,48130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48130,1,3,0)
 ;;=3^Obsessive-Compulsive Personality Disorder
 ;;^UTILITY(U,$J,358.3,48130,1,4,0)
 ;;=4^F60.5
 ;;^UTILITY(U,$J,358.3,48130,2)
 ;;=^331918
 ;;^UTILITY(U,$J,358.3,48131,0)
 ;;=F60.7^^211^2382^23
 ;;^UTILITY(U,$J,358.3,48131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48131,1,3,0)
 ;;=3^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,48131,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,48131,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,48132,0)
 ;;=F60.2^^211^2382^8
 ;;^UTILITY(U,$J,358.3,48132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48132,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,48132,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,48132,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,48133,0)
 ;;=F60.6^^211^2382^11
 ;;^UTILITY(U,$J,358.3,48133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48133,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,48133,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,48133,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,48134,0)
 ;;=F60.3^^211^2382^16
 ;;^UTILITY(U,$J,358.3,48134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48134,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,48134,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,48134,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,48135,0)
 ;;=F10.229^^211^2382^4
 ;;^UTILITY(U,$J,358.3,48135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48135,1,3,0)
 ;;=3^Alcohol Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,48135,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,48135,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,48136,0)
 ;;=F10.20^^211^2382^5
 ;;^UTILITY(U,$J,358.3,48136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48136,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,48136,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,48136,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,48137,0)
 ;;=F11.29^^211^2382^38
 ;;^UTILITY(U,$J,358.3,48137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48137,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,48137,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,48137,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,48138,0)
 ;;=F13.20^^211^2382^50
 ;;^UTILITY(U,$J,358.3,48138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48138,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,48138,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,48138,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,48139,0)
 ;;=F14.29^^211^2382^20
 ;;^UTILITY(U,$J,358.3,48139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48139,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,48139,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,48139,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,48140,0)
 ;;=F12.29^^211^2382^18
 ;;^UTILITY(U,$J,358.3,48140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48140,1,3,0)
 ;;=3^Cannabis Dependence w/ Unspec Cannabis-Induced Disorder
