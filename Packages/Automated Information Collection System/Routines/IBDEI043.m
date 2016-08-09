IBDEI043 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3819,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,3819,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,3819,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,3820,0)
 ;;=I82.401^^30^295^20
 ;;^UTILITY(U,$J,358.3,3820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3820,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,3820,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,3820,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,3821,0)
 ;;=I82.403^^30^295^17
 ;;^UTILITY(U,$J,358.3,3821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3821,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,3821,1,4,0)
 ;;=4^I82.403
 ;;^UTILITY(U,$J,358.3,3821,2)
 ;;=^5007856
 ;;^UTILITY(U,$J,358.3,3822,0)
 ;;=K70.30^^30^296^2
 ;;^UTILITY(U,$J,358.3,3822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3822,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,3822,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,3822,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,3823,0)
 ;;=K70.31^^30^296^1
 ;;^UTILITY(U,$J,358.3,3823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3823,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/ Ascites
 ;;^UTILITY(U,$J,358.3,3823,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,3823,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,3824,0)
 ;;=K74.60^^30^296^5
 ;;^UTILITY(U,$J,358.3,3824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3824,1,3,0)
 ;;=3^Cirrhosis of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,3824,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,3824,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,3825,0)
 ;;=K74.69^^30^296^4
 ;;^UTILITY(U,$J,358.3,3825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3825,1,3,0)
 ;;=3^Cirrhosis of Liver NEC
 ;;^UTILITY(U,$J,358.3,3825,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,3825,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,3826,0)
 ;;=K70.2^^30^296^3
 ;;^UTILITY(U,$J,358.3,3826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3826,1,3,0)
 ;;=3^Alcoholic Fibrosis/Sclerosis of Liver
 ;;^UTILITY(U,$J,358.3,3826,1,4,0)
 ;;=4^K70.2
 ;;^UTILITY(U,$J,358.3,3826,2)
 ;;=^5008787
 ;;^UTILITY(U,$J,358.3,3827,0)
 ;;=K74.0^^30^296^6
 ;;^UTILITY(U,$J,358.3,3827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3827,1,3,0)
 ;;=3^Hepatic Fibrosis
 ;;^UTILITY(U,$J,358.3,3827,1,4,0)
 ;;=4^K74.0
 ;;^UTILITY(U,$J,358.3,3827,2)
 ;;=^5008816
 ;;^UTILITY(U,$J,358.3,3828,0)
 ;;=K74.2^^30^296^7
 ;;^UTILITY(U,$J,358.3,3828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3828,1,3,0)
 ;;=3^Hepatic Fibrosis w/ Hepatic Sclerosis
 ;;^UTILITY(U,$J,358.3,3828,1,4,0)
 ;;=4^K74.2
 ;;^UTILITY(U,$J,358.3,3828,2)
 ;;=^5008818
 ;;^UTILITY(U,$J,358.3,3829,0)
 ;;=K74.1^^30^296^8
 ;;^UTILITY(U,$J,358.3,3829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3829,1,3,0)
 ;;=3^Hepatic Sclerosis
 ;;^UTILITY(U,$J,358.3,3829,1,4,0)
 ;;=4^K74.1
 ;;^UTILITY(U,$J,358.3,3829,2)
 ;;=^5008817
 ;;^UTILITY(U,$J,358.3,3830,0)
 ;;=K52.2^^30^297^1
 ;;^UTILITY(U,$J,358.3,3830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3830,1,3,0)
 ;;=3^Allergic/Dietetic Gastroenteritis/Colitis
 ;;^UTILITY(U,$J,358.3,3830,1,4,0)
 ;;=4^K52.2
 ;;^UTILITY(U,$J,358.3,3830,2)
 ;;=^5008701
 ;;^UTILITY(U,$J,358.3,3831,0)
 ;;=K52.89^^30^297^2
 ;;^UTILITY(U,$J,358.3,3831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3831,1,3,0)
 ;;=3^Noninfective Gastroenteritis/Colitis NEC
 ;;^UTILITY(U,$J,358.3,3831,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,3831,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,3832,0)
 ;;=K51.90^^30^297^9
 ;;^UTILITY(U,$J,358.3,3832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3832,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,3832,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,3832,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,3833,0)
 ;;=K51.919^^30^297^8
 ;;^UTILITY(U,$J,358.3,3833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3833,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,3833,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,3833,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,3834,0)
 ;;=K51.912^^30^297^5
 ;;^UTILITY(U,$J,358.3,3834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3834,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,3834,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,3834,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,3835,0)
 ;;=K51.913^^30^297^4
 ;;^UTILITY(U,$J,358.3,3835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3835,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,3835,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,3835,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,3836,0)
 ;;=K51.914^^30^297^3
 ;;^UTILITY(U,$J,358.3,3836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3836,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,3836,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,3836,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,3837,0)
 ;;=K51.918^^30^297^6
 ;;^UTILITY(U,$J,358.3,3837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3837,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complications,Unspec
 ;;^UTILITY(U,$J,358.3,3837,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,3837,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,3838,0)
 ;;=K51.911^^30^297^7
 ;;^UTILITY(U,$J,358.3,3838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3838,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,3838,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,3838,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,3839,0)
 ;;=K50.00^^30^298^11
 ;;^UTILITY(U,$J,358.3,3839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3839,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/o Complications
 ;;^UTILITY(U,$J,358.3,3839,1,4,0)
 ;;=4^K50.00
 ;;^UTILITY(U,$J,358.3,3839,2)
 ;;=^5008624
 ;;^UTILITY(U,$J,358.3,3840,0)
 ;;=K50.011^^30^298^9
 ;;^UTILITY(U,$J,358.3,3840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3840,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Rectal Bleeding
 ;;^UTILITY(U,$J,358.3,3840,1,4,0)
 ;;=4^K50.011
 ;;^UTILITY(U,$J,358.3,3840,2)
 ;;=^5008625
 ;;^UTILITY(U,$J,358.3,3841,0)
 ;;=K50.012^^30^298^7
 ;;^UTILITY(U,$J,358.3,3841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3841,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Intestinal Obstruction
 ;;^UTILITY(U,$J,358.3,3841,1,4,0)
 ;;=4^K50.012
 ;;^UTILITY(U,$J,358.3,3841,2)
 ;;=^5008626
 ;;^UTILITY(U,$J,358.3,3842,0)
 ;;=K50.013^^30^298^6
 ;;^UTILITY(U,$J,358.3,3842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3842,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Fistula
 ;;^UTILITY(U,$J,358.3,3842,1,4,0)
 ;;=4^K50.013
 ;;^UTILITY(U,$J,358.3,3842,2)
 ;;=^5008627
 ;;^UTILITY(U,$J,358.3,3843,0)
 ;;=K50.014^^30^298^5
 ;;^UTILITY(U,$J,358.3,3843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3843,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Abscess
 ;;^UTILITY(U,$J,358.3,3843,1,4,0)
 ;;=4^K50.014
 ;;^UTILITY(U,$J,358.3,3843,2)
 ;;=^5008628
 ;;^UTILITY(U,$J,358.3,3844,0)
 ;;=K50.018^^30^298^8
 ;;^UTILITY(U,$J,358.3,3844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3844,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Oth Complications
 ;;^UTILITY(U,$J,358.3,3844,1,4,0)
 ;;=4^K50.018
 ;;^UTILITY(U,$J,358.3,3844,2)
 ;;=^5008629
 ;;^UTILITY(U,$J,358.3,3845,0)
 ;;=K50.019^^30^298^10
 ;;^UTILITY(U,$J,358.3,3845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3845,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,3845,1,4,0)
 ;;=4^K50.019
 ;;^UTILITY(U,$J,358.3,3845,2)
 ;;=^5008630
 ;;^UTILITY(U,$J,358.3,3846,0)
 ;;=K50.10^^30^298^4
 ;;^UTILITY(U,$J,358.3,3846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3846,1,3,0)
 ;;=3^Crohn's Disease of Large Intestine w/o Complications
 ;;^UTILITY(U,$J,358.3,3846,1,4,0)
 ;;=4^K50.10
