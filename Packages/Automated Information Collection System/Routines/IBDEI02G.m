IBDEI02G ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1993,1,4,0)
 ;;=4^T86.21
 ;;^UTILITY(U,$J,358.3,1993,2)
 ;;=^5055714
 ;;^UTILITY(U,$J,358.3,1994,0)
 ;;=T86.22^^14^155^23
 ;;^UTILITY(U,$J,358.3,1994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1994,1,3,0)
 ;;=3^Heart Transplant Failure
 ;;^UTILITY(U,$J,358.3,1994,1,4,0)
 ;;=4^T86.22
 ;;^UTILITY(U,$J,358.3,1994,2)
 ;;=^5055715
 ;;^UTILITY(U,$J,358.3,1995,0)
 ;;=T86.23^^14^155^24
 ;;^UTILITY(U,$J,358.3,1995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1995,1,3,0)
 ;;=3^Heart Transplant Infection
 ;;^UTILITY(U,$J,358.3,1995,1,4,0)
 ;;=4^T86.23
 ;;^UTILITY(U,$J,358.3,1995,2)
 ;;=^5055716
 ;;^UTILITY(U,$J,358.3,1996,0)
 ;;=T86.290^^14^155^5
 ;;^UTILITY(U,$J,358.3,1996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1996,1,3,0)
 ;;=3^Cardiac Allograft Vasculopathy
 ;;^UTILITY(U,$J,358.3,1996,1,4,0)
 ;;=4^T86.290
 ;;^UTILITY(U,$J,358.3,1996,2)
 ;;=^5055717
 ;;^UTILITY(U,$J,358.3,1997,0)
 ;;=T86.298^^14^155^16
 ;;^UTILITY(U,$J,358.3,1997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1997,1,3,0)
 ;;=3^Complications of Heart Transplant NEC
 ;;^UTILITY(U,$J,358.3,1997,1,4,0)
 ;;=4^T86.298
 ;;^UTILITY(U,$J,358.3,1997,2)
 ;;=^5055718
 ;;^UTILITY(U,$J,358.3,1998,0)
 ;;=T86.30^^14^155^12
 ;;^UTILITY(U,$J,358.3,1998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1998,1,3,0)
 ;;=3^Complication of Heart-Lung Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,1998,1,4,0)
 ;;=4^T86.30
 ;;^UTILITY(U,$J,358.3,1998,2)
 ;;=^5055719
 ;;^UTILITY(U,$J,358.3,1999,0)
 ;;=T86.39^^14^155^17
 ;;^UTILITY(U,$J,358.3,1999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1999,1,3,0)
 ;;=3^Complications of Heart-Lung Transplant NEC
 ;;^UTILITY(U,$J,358.3,1999,1,4,0)
 ;;=4^T86.39
 ;;^UTILITY(U,$J,358.3,1999,2)
 ;;=^5055723
 ;;^UTILITY(U,$J,358.3,2000,0)
 ;;=T86.31^^14^155^30
 ;;^UTILITY(U,$J,358.3,2000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2000,1,3,0)
 ;;=3^Heart-Lung Transplant Rejection
 ;;^UTILITY(U,$J,358.3,2000,1,4,0)
 ;;=4^T86.31
 ;;^UTILITY(U,$J,358.3,2000,2)
 ;;=^5055720
 ;;^UTILITY(U,$J,358.3,2001,0)
 ;;=T86.32^^14^155^28
 ;;^UTILITY(U,$J,358.3,2001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2001,1,3,0)
 ;;=3^Heart-Lung Transplant Failure
 ;;^UTILITY(U,$J,358.3,2001,1,4,0)
 ;;=4^T86.32
 ;;^UTILITY(U,$J,358.3,2001,2)
 ;;=^5055721
 ;;^UTILITY(U,$J,358.3,2002,0)
 ;;=T86.33^^14^155^29
 ;;^UTILITY(U,$J,358.3,2002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2002,1,3,0)
 ;;=3^Heart-Lung Transplant Infection
 ;;^UTILITY(U,$J,358.3,2002,1,4,0)
 ;;=4^T86.33
 ;;^UTILITY(U,$J,358.3,2002,2)
 ;;=^5055722
 ;;^UTILITY(U,$J,358.3,2003,0)
 ;;=T86.810^^14^155^35
 ;;^UTILITY(U,$J,358.3,2003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2003,1,3,0)
 ;;=3^Lung Transplant Rejection
 ;;^UTILITY(U,$J,358.3,2003,1,4,0)
 ;;=4^T86.810
 ;;^UTILITY(U,$J,358.3,2003,2)
 ;;=^5055730
 ;;^UTILITY(U,$J,358.3,2004,0)
 ;;=T86.811^^14^155^34
 ;;^UTILITY(U,$J,358.3,2004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2004,1,3,0)
 ;;=3^Lung Transplant Failure
 ;;^UTILITY(U,$J,358.3,2004,1,4,0)
 ;;=4^T86.811
 ;;^UTILITY(U,$J,358.3,2004,2)
 ;;=^5055731
 ;;^UTILITY(U,$J,358.3,2005,0)
 ;;=T86.819^^14^155^14
 ;;^UTILITY(U,$J,358.3,2005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2005,1,3,0)
 ;;=3^Complication of Lung Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,2005,1,4,0)
 ;;=4^T86.819
 ;;^UTILITY(U,$J,358.3,2005,2)
 ;;=^5137975
 ;;^UTILITY(U,$J,358.3,2006,0)
 ;;=T86.818^^14^155^13
 ;;^UTILITY(U,$J,358.3,2006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2006,1,3,0)
 ;;=3^Complication of Lung Transplant NEC
 ;;^UTILITY(U,$J,358.3,2006,1,4,0)
 ;;=4^T86.818
 ;;^UTILITY(U,$J,358.3,2006,2)
 ;;=^5055733
 ;;^UTILITY(U,$J,358.3,2007,0)
 ;;=Z94.1^^14^155^26
 ;;^UTILITY(U,$J,358.3,2007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2007,1,3,0)
 ;;=3^Heart Transplant Status
 ;;^UTILITY(U,$J,358.3,2007,1,4,0)
 ;;=4^Z94.1
 ;;^UTILITY(U,$J,358.3,2007,2)
 ;;=^5063655
 ;;^UTILITY(U,$J,358.3,2008,0)
 ;;=Z94.3^^14^155^27
 ;;^UTILITY(U,$J,358.3,2008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2008,1,3,0)
 ;;=3^Heart and Lungs Transplant Status
 ;;^UTILITY(U,$J,358.3,2008,1,4,0)
 ;;=4^Z94.3
 ;;^UTILITY(U,$J,358.3,2008,2)
 ;;=^5063657
 ;;^UTILITY(U,$J,358.3,2009,0)
 ;;=Z48.21^^14^155^1
 ;;^UTILITY(U,$J,358.3,2009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2009,1,3,0)
 ;;=3^Aftercare Following Heart Transplant
 ;;^UTILITY(U,$J,358.3,2009,1,4,0)
 ;;=4^Z48.21
 ;;^UTILITY(U,$J,358.3,2009,2)
 ;;=^5063038
 ;;^UTILITY(U,$J,358.3,2010,0)
 ;;=Z48.280^^14^155^2
 ;;^UTILITY(U,$J,358.3,2010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2010,1,3,0)
 ;;=3^Aftercare Following Heart-Lung Transplant
 ;;^UTILITY(U,$J,358.3,2010,1,4,0)
 ;;=4^Z48.280
 ;;^UTILITY(U,$J,358.3,2010,2)
 ;;=^5063042
 ;;^UTILITY(U,$J,358.3,2011,0)
 ;;=I25.10^^14^156^2
 ;;^UTILITY(U,$J,358.3,2011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2011,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2011,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,2011,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,2012,0)
 ;;=I25.110^^14^156^3
 ;;^UTILITY(U,$J,358.3,2012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2012,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2012,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,2012,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,2013,0)
 ;;=I25.111^^14^156^4
 ;;^UTILITY(U,$J,358.3,2013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2013,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Ang Pctrs w/ Spasm
 ;;^UTILITY(U,$J,358.3,2013,1,4,0)
 ;;=4^I25.111
 ;;^UTILITY(U,$J,358.3,2013,2)
 ;;=^5007109
 ;;^UTILITY(U,$J,358.3,2014,0)
 ;;=I25.118^^14^156^5
 ;;^UTILITY(U,$J,358.3,2014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2014,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2014,1,4,0)
 ;;=4^I25.118
 ;;^UTILITY(U,$J,358.3,2014,2)
 ;;=^5007110
 ;;^UTILITY(U,$J,358.3,2015,0)
 ;;=I25.119^^14^156^6
 ;;^UTILITY(U,$J,358.3,2015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2015,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2015,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,2015,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,2016,0)
 ;;=I25.810^^14^156^1
 ;;^UTILITY(U,$J,358.3,2016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2016,1,3,0)
 ;;=3^Atherosclerosis of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,2016,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,2016,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,2017,0)
 ;;=I25.82^^14^156^10
 ;;^UTILITY(U,$J,358.3,2017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2017,1,3,0)
 ;;=3^Total Occlusion of Coronary Artery,Chronic
 ;;^UTILITY(U,$J,358.3,2017,1,4,0)
 ;;=4^I25.82
 ;;^UTILITY(U,$J,358.3,2017,2)
 ;;=^335262
 ;;^UTILITY(U,$J,358.3,2018,0)
 ;;=I25.83^^14^156^8
 ;;^UTILITY(U,$J,358.3,2018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2018,1,3,0)
 ;;=3^Coronary Atherosclerosis d/t Lipid Rich Plaque
 ;;^UTILITY(U,$J,358.3,2018,1,4,0)
 ;;=4^I25.83
 ;;^UTILITY(U,$J,358.3,2018,2)
 ;;=^336601
 ;;^UTILITY(U,$J,358.3,2019,0)
 ;;=I25.84^^14^156^7
 ;;^UTILITY(U,$J,358.3,2019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2019,1,3,0)
 ;;=3^Coronary Atherosclerosis d/t Calcified Coronary Lesion
 ;;^UTILITY(U,$J,358.3,2019,1,4,0)
 ;;=4^I25.84
 ;;^UTILITY(U,$J,358.3,2019,2)
 ;;=^340518
 ;;^UTILITY(U,$J,358.3,2020,0)
 ;;=I25.89^^14^156^9
 ;;^UTILITY(U,$J,358.3,2020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2020,1,3,0)
 ;;=3^Ischemic Heart Disease,Chronic NEC
 ;;^UTILITY(U,$J,358.3,2020,1,4,0)
 ;;=4^I25.89
 ;;^UTILITY(U,$J,358.3,2020,2)
 ;;=^269679
 ;;^UTILITY(U,$J,358.3,2021,0)
 ;;=E66.9^^14^157^17
 ;;^UTILITY(U,$J,358.3,2021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2021,1,3,0)
 ;;=3^Obesity,Unspec
