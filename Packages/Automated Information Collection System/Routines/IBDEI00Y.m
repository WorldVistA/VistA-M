IBDEI00Y ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1778,1,3,0)
 ;;=3^Unspec Sequelae of Other Cerebrovascular Disease
 ;;^UTILITY(U,$J,358.3,1778,1,4,0)
 ;;=4^I69.80
 ;;^UTILITY(U,$J,358.3,1778,2)
 ;;=^5007520
 ;;^UTILITY(U,$J,358.3,1779,0)
 ;;=I69.90^^13^118^6
 ;;^UTILITY(U,$J,358.3,1779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1779,1,3,0)
 ;;=3^Unspec Sequelae of Unspec Cerebrovascular Disease
 ;;^UTILITY(U,$J,358.3,1779,1,4,0)
 ;;=4^I69.90
 ;;^UTILITY(U,$J,358.3,1779,2)
 ;;=^5007551
 ;;^UTILITY(U,$J,358.3,1780,0)
 ;;=99211^^14^119^1
 ;;^UTILITY(U,$J,358.3,1780,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1780,1,1,0)
 ;;=1^Face-to-Face Visit
 ;;^UTILITY(U,$J,358.3,1780,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,1781,0)
 ;;=99377^^15^120^3^^^^1
 ;;^UTILITY(U,$J,358.3,1781,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1781,1,2,0)
 ;;=2^Hospice Care 15-29min
 ;;^UTILITY(U,$J,358.3,1781,1,3,0)
 ;;=3^99377
 ;;^UTILITY(U,$J,358.3,1782,0)
 ;;=99378^^15^120^4^^^^1
 ;;^UTILITY(U,$J,358.3,1782,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1782,1,2,0)
 ;;=2^Hospice Care 30 min or >
 ;;^UTILITY(U,$J,358.3,1782,1,3,0)
 ;;=3^99378
 ;;^UTILITY(U,$J,358.3,1783,0)
 ;;=99374^^15^120^1^^^^1
 ;;^UTILITY(U,$J,358.3,1783,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1783,1,2,0)
 ;;=2^Home Health Agency 15-29min
 ;;^UTILITY(U,$J,358.3,1783,1,3,0)
 ;;=3^99374
 ;;^UTILITY(U,$J,358.3,1784,0)
 ;;=99375^^15^120^2^^^^1
 ;;^UTILITY(U,$J,358.3,1784,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1784,1,2,0)
 ;;=2^Home Health Agency 30 min or >
 ;;^UTILITY(U,$J,358.3,1784,1,3,0)
 ;;=3^99375
 ;;^UTILITY(U,$J,358.3,1785,0)
 ;;=S5100^^15^121^2^^^^1
 ;;^UTILITY(U,$J,358.3,1785,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1785,1,2,0)
 ;;=2^Day Care Svcs,per 15min
 ;;^UTILITY(U,$J,358.3,1785,1,3,0)
 ;;=3^S5100
 ;;^UTILITY(U,$J,358.3,1786,0)
 ;;=S5101^^15^121^4^^^^1
 ;;^UTILITY(U,$J,358.3,1786,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1786,1,2,0)
 ;;=2^Day Care Svcs,per half day
 ;;^UTILITY(U,$J,358.3,1786,1,3,0)
 ;;=3^S5101
 ;;^UTILITY(U,$J,358.3,1787,0)
 ;;=S5102^^15^121^3^^^^1
 ;;^UTILITY(U,$J,358.3,1787,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1787,1,2,0)
 ;;=2^Day Care Svcs,per diem
 ;;^UTILITY(U,$J,358.3,1787,1,3,0)
 ;;=3^S5102
 ;;^UTILITY(U,$J,358.3,1788,0)
 ;;=S5105^^15^121^1^^^^1
 ;;^UTILITY(U,$J,358.3,1788,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1788,1,2,0)
 ;;=2^Day Care Svcs,Center-Based,per diem
 ;;^UTILITY(U,$J,358.3,1788,1,3,0)
 ;;=3^S5105
 ;;^UTILITY(U,$J,358.3,1789,0)
 ;;=T1016^^15^122^8^^^^1
 ;;^UTILITY(U,$J,358.3,1789,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1789,1,2,0)
 ;;=2^Case Management,ea 15 min
 ;;^UTILITY(U,$J,358.3,1789,1,3,0)
 ;;=3^T1016
 ;;^UTILITY(U,$J,358.3,1790,0)
 ;;=98961^^15^123^2^^^^1
 ;;^UTILITY(U,$J,358.3,1790,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1790,1,2,0)
 ;;=2^Self-Mgmt Educ/Train,2-4 Pts,30 min
 ;;^UTILITY(U,$J,358.3,1790,1,3,0)
 ;;=3^98961
 ;;^UTILITY(U,$J,358.3,1791,0)
 ;;=98962^^15^123^3^^^^1
 ;;^UTILITY(U,$J,358.3,1791,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1791,1,2,0)
 ;;=2^Self-Mgmt Educ/Train,5-8 Pts,30 mins
 ;;^UTILITY(U,$J,358.3,1791,1,3,0)
 ;;=3^98962
 ;;^UTILITY(U,$J,358.3,1792,0)
 ;;=98960^^15^123^1^^^^1
 ;;^UTILITY(U,$J,358.3,1792,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1792,1,2,0)
 ;;=2^Self-Mgmt Educ/Train,1 Pt,30 min
 ;;^UTILITY(U,$J,358.3,1792,1,3,0)
 ;;=3^98960
 ;;^UTILITY(U,$J,358.3,1793,0)
 ;;=I50.9^^16^124^11
 ;;^UTILITY(U,$J,358.3,1793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1793,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1793,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,1793,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,1794,0)
 ;;=I10.^^16^124^2
 ;;^UTILITY(U,$J,358.3,1794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1794,1,3,0)
 ;;=3^HTN,Essential
 ;;^UTILITY(U,$J,358.3,1794,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,1794,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,1795,0)
 ;;=E78.5^^16^124^15
 ;;^UTILITY(U,$J,358.3,1795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1795,1,3,0)
 ;;=3^Hyperlipidemia,Unspec
 ;;^UTILITY(U,$J,358.3,1795,1,4,0)
 ;;=4^E78.5
 ;;^UTILITY(U,$J,358.3,1795,2)
 ;;=^5002969
 ;;^UTILITY(U,$J,358.3,1796,0)
 ;;=E78.00^^16^124^13
 ;;^UTILITY(U,$J,358.3,1796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1796,1,3,0)
 ;;=3^Hypercholesterolemia,Pure
 ;;^UTILITY(U,$J,358.3,1796,1,4,0)
 ;;=4^E78.00
 ;;^UTILITY(U,$J,358.3,1796,2)
 ;;=^5138435
 ;;^UTILITY(U,$J,358.3,1797,0)
 ;;=E78.01^^16^124^12
 ;;^UTILITY(U,$J,358.3,1797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1797,1,3,0)
 ;;=3^Hypercholesterolemia,Familial
 ;;^UTILITY(U,$J,358.3,1797,1,4,0)
 ;;=4^E78.01
 ;;^UTILITY(U,$J,358.3,1797,2)
 ;;=^7570555
 ;;^UTILITY(U,$J,358.3,1798,0)
 ;;=I16.0^^16^124^17
 ;;^UTILITY(U,$J,358.3,1798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1798,1,3,0)
 ;;=3^Hypertensive Urgency
 ;;^UTILITY(U,$J,358.3,1798,1,4,0)
 ;;=4^I16.0
 ;;^UTILITY(U,$J,358.3,1798,2)
 ;;=^8133013
 ;;^UTILITY(U,$J,358.3,1799,0)
 ;;=I16.1^^16^124^16
 ;;^UTILITY(U,$J,358.3,1799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1799,1,3,0)
 ;;=3^Hypertensive Emergency
 ;;^UTILITY(U,$J,358.3,1799,1,4,0)
 ;;=4^I16.1
 ;;^UTILITY(U,$J,358.3,1799,2)
 ;;=^8204721
 ;;^UTILITY(U,$J,358.3,1800,0)
 ;;=I50.82^^16^124^3
 ;;^UTILITY(U,$J,358.3,1800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1800,1,3,0)
 ;;=3^Heart Failure,Biventricular
 ;;^UTILITY(U,$J,358.3,1800,1,4,0)
 ;;=4^I50.82
 ;;^UTILITY(U,$J,358.3,1800,2)
 ;;=^5151389
 ;;^UTILITY(U,$J,358.3,1801,0)
 ;;=I50.84^^16^124^4
 ;;^UTILITY(U,$J,358.3,1801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1801,1,3,0)
 ;;=3^Heart Failure,End Stage
 ;;^UTILITY(U,$J,358.3,1801,1,4,0)
 ;;=4^I50.84
 ;;^UTILITY(U,$J,358.3,1801,2)
 ;;=^5151391
 ;;^UTILITY(U,$J,358.3,1802,0)
 ;;=I50.83^^16^124^5
 ;;^UTILITY(U,$J,358.3,1802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1802,1,3,0)
 ;;=3^Heart Failure,High Output
 ;;^UTILITY(U,$J,358.3,1802,1,4,0)
 ;;=4^I50.83
 ;;^UTILITY(U,$J,358.3,1802,2)
 ;;=^5151390
 ;;^UTILITY(U,$J,358.3,1803,0)
 ;;=I50.89^^16^124^6
 ;;^UTILITY(U,$J,358.3,1803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1803,1,3,0)
 ;;=3^Heart Failure,Other
 ;;^UTILITY(U,$J,358.3,1803,1,4,0)
 ;;=4^I50.89
 ;;^UTILITY(U,$J,358.3,1803,2)
 ;;=^5151392
 ;;^UTILITY(U,$J,358.3,1804,0)
 ;;=I50.813^^16^124^9
 ;;^UTILITY(U,$J,358.3,1804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1804,1,3,0)
 ;;=3^Heart Failure,Right,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,1804,1,4,0)
 ;;=4^I50.813
 ;;^UTILITY(U,$J,358.3,1804,2)
 ;;=^5151387
 ;;^UTILITY(U,$J,358.3,1805,0)
 ;;=I50.811^^16^124^8
 ;;^UTILITY(U,$J,358.3,1805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1805,1,3,0)
 ;;=3^Heart Failure,Right,Acute
 ;;^UTILITY(U,$J,358.3,1805,1,4,0)
 ;;=4^I50.811
 ;;^UTILITY(U,$J,358.3,1805,2)
 ;;=^5151385
 ;;^UTILITY(U,$J,358.3,1806,0)
 ;;=I50.812^^16^124^10
 ;;^UTILITY(U,$J,358.3,1806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1806,1,3,0)
 ;;=3^Heart Failure,Right,Chronic
 ;;^UTILITY(U,$J,358.3,1806,1,4,0)
 ;;=4^I50.812
 ;;^UTILITY(U,$J,358.3,1806,2)
 ;;=^5151386
 ;;^UTILITY(U,$J,358.3,1807,0)
 ;;=I50.814^^16^124^7
 ;;^UTILITY(U,$J,358.3,1807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1807,1,3,0)
 ;;=3^Heart Failure,Right d/t Left Heart Failure
 ;;^UTILITY(U,$J,358.3,1807,1,4,0)
 ;;=4^I50.814
 ;;^UTILITY(U,$J,358.3,1807,2)
 ;;=^5151388
 ;;^UTILITY(U,$J,358.3,1808,0)
 ;;=E78.41^^16^124^1
 ;;^UTILITY(U,$J,358.3,1808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1808,1,3,0)
 ;;=3^Elevated Lipoprotein(a)
 ;;^UTILITY(U,$J,358.3,1808,1,4,0)
 ;;=4^E78.41
 ;;^UTILITY(U,$J,358.3,1808,2)
 ;;=^5157298
 ;;^UTILITY(U,$J,358.3,1809,0)
 ;;=E78.49^^16^124^14
 ;;^UTILITY(U,$J,358.3,1809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1809,1,3,0)
 ;;=3^Hyperlipidemia,Other
 ;;^UTILITY(U,$J,358.3,1809,1,4,0)
 ;;=4^E78.49
 ;;^UTILITY(U,$J,358.3,1809,2)
 ;;=^5157299
 ;;^UTILITY(U,$J,358.3,1810,0)
 ;;=Z51.5^^16^125^7
 ;;^UTILITY(U,$J,358.3,1810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1810,1,3,0)
 ;;=3^Palliative Care Encounter
 ;;^UTILITY(U,$J,358.3,1810,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,1810,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,1811,0)
 ;;=Z99.81^^16^125^4
 ;;^UTILITY(U,$J,358.3,1811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1811,1,3,0)
 ;;=3^Dependence on Supplemental Oxygen
 ;;^UTILITY(U,$J,358.3,1811,1,4,0)
 ;;=4^Z99.81
 ;;^UTILITY(U,$J,358.3,1811,2)
 ;;=^5063760
 ;;^UTILITY(U,$J,358.3,1812,0)
 ;;=Z71.89^^16^125^2
 ;;^UTILITY(U,$J,358.3,1812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1812,1,3,0)
 ;;=3^Counseling,Other Specified
 ;;^UTILITY(U,$J,358.3,1812,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,1812,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,1813,0)
 ;;=Z65.9^^16^125^8
 ;;^UTILITY(U,$J,358.3,1813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1813,1,3,0)
 ;;=3^Problem Related to Unspec Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,1813,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,1813,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,1814,0)
 ;;=Z23.^^16^125^6
 ;;^UTILITY(U,$J,358.3,1814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1814,1,3,0)
 ;;=3^Immunization Encounter
 ;;^UTILITY(U,$J,358.3,1814,1,4,0)
 ;;=4^Z23.
 ;;^UTILITY(U,$J,358.3,1814,2)
 ;;=^5062795
 ;;^UTILITY(U,$J,358.3,1815,0)
 ;;=Z51.89^^16^125^9
 ;;^UTILITY(U,$J,358.3,1815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1815,1,3,0)
 ;;=3^Specified Aftercare Encounter
 ;;^UTILITY(U,$J,358.3,1815,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,1815,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,1816,0)
 ;;=Z71.9^^16^125^3
 ;;^UTILITY(U,$J,358.3,1816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1816,1,3,0)
 ;;=3^Counseling,Unspec
 ;;^UTILITY(U,$J,358.3,1816,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,1816,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,1817,0)
 ;;=Z51.81^^16^125^10
 ;;^UTILITY(U,$J,358.3,1817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1817,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,1817,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,1817,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,1818,0)
 ;;=Z02.89^^16^125^1
 ;;^UTILITY(U,$J,358.3,1818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1818,1,3,0)
 ;;=3^Administrative Examination Encounter
 ;;^UTILITY(U,$J,358.3,1818,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,1818,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,1819,0)
 ;;=Z71.3^^16^125^5
 ;;^UTILITY(U,$J,358.3,1819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1819,1,3,0)
 ;;=3^Dietary Counseling & Surveillance
 ;;^UTILITY(U,$J,358.3,1819,1,4,0)
 ;;=4^Z71.3
 ;;^UTILITY(U,$J,358.3,1819,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,1820,0)
 ;;=E10.9^^16^126^63
 ;;^UTILITY(U,$J,358.3,1820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1820,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,1820,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,1820,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,1821,0)
 ;;=E10.65^^16^126^18
 ;;^UTILITY(U,$J,358.3,1821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1821,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,1821,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,1821,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,1822,0)
 ;;=E10.21^^16^126^10
 ;;^UTILITY(U,$J,358.3,1822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1822,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,1822,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,1822,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,1823,0)
 ;;=E10.22^^16^126^4
 ;;^UTILITY(U,$J,358.3,1823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1823,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Chr Kidney Disease
 ;;^UTILITY(U,$J,358.3,1823,1,4,0)
 ;;=4^E10.22
 ;;^UTILITY(U,$J,358.3,1823,2)
 ;;=^5002590
 ;;^UTILITY(U,$J,358.3,1824,0)
 ;;=E10.29^^16^126^34
 ;;^UTILITY(U,$J,358.3,1824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1824,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Diabetic Kidney Complication
 ;;^UTILITY(U,$J,358.3,1824,1,4,0)
 ;;=4^E10.29
 ;;^UTILITY(U,$J,358.3,1824,2)
 ;;=^5002591
 ;;^UTILITY(U,$J,358.3,1825,0)
 ;;=E10.311^^16^126^15
 ;;^UTILITY(U,$J,358.3,1825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1825,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,1825,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,1825,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,1826,0)
 ;;=E10.319^^16^126^16
 ;;^UTILITY(U,$J,358.3,1826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1826,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,1826,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,1826,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,1827,0)
 ;;=E10.36^^16^126^3
 ;;^UTILITY(U,$J,358.3,1827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1827,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,1827,1,4,0)
 ;;=4^E10.36
 ;;^UTILITY(U,$J,358.3,1827,2)
 ;;=^5002602
 ;;^UTILITY(U,$J,358.3,1828,0)
 ;;=E10.39^^16^126^36
 ;;^UTILITY(U,$J,358.3,1828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1828,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Diabetic Ophthalmic Complications
 ;;^UTILITY(U,$J,358.3,1828,1,4,0)
 ;;=4^E10.39
 ;;^UTILITY(U,$J,358.3,1828,2)
 ;;=^5002603
 ;;^UTILITY(U,$J,358.3,1829,0)
 ;;=E10.40^^16^126^12
 ;;^UTILITY(U,$J,358.3,1829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1829,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,1829,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,1829,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,1830,0)
 ;;=E10.41^^16^126^9
 ;;^UTILITY(U,$J,358.3,1830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1830,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Mononeuropathy
 ;;^UTILITY(U,$J,358.3,1830,1,4,0)
 ;;=4^E10.41
 ;;^UTILITY(U,$J,358.3,1830,2)
 ;;=^5002605
 ;;^UTILITY(U,$J,358.3,1831,0)
 ;;=E10.42^^16^126^14
 ;;^UTILITY(U,$J,358.3,1831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1831,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,1831,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,1831,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,1832,0)
 ;;=E10.43^^16^126^2
 ;;^UTILITY(U,$J,358.3,1832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1832,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,1832,1,4,0)
 ;;=4^E10.43
 ;;^UTILITY(U,$J,358.3,1832,2)
 ;;=^5002607
 ;;^UTILITY(U,$J,358.3,1833,0)
 ;;=E10.44^^16^126^1
 ;;^UTILITY(U,$J,358.3,1833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1833,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Amyotrophy
 ;;^UTILITY(U,$J,358.3,1833,1,4,0)
 ;;=4^E10.44
 ;;^UTILITY(U,$J,358.3,1833,2)
 ;;=^5002608
 ;;^UTILITY(U,$J,358.3,1834,0)
 ;;=E10.49^^16^126^35
 ;;^UTILITY(U,$J,358.3,1834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1834,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Diabetic Neurological Complication
 ;;^UTILITY(U,$J,358.3,1834,1,4,0)
 ;;=4^E10.49
 ;;^UTILITY(U,$J,358.3,1834,2)
 ;;=^5002609
 ;;^UTILITY(U,$J,358.3,1835,0)
 ;;=E10.51^^16^126^13
 ;;^UTILITY(U,$J,358.3,1835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1835,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,1835,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,1835,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,1836,0)
 ;;=E10.59^^16^126^32
 ;;^UTILITY(U,$J,358.3,1836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1836,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Circulatory Complications
 ;;^UTILITY(U,$J,358.3,1836,1,4,0)
 ;;=4^E10.59
 ;;^UTILITY(U,$J,358.3,1836,2)
 ;;=^5002612
 ;;^UTILITY(U,$J,358.3,1837,0)
 ;;=E10.610^^16^126^11
 ;;^UTILITY(U,$J,358.3,1837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1837,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,1837,1,4,0)
 ;;=4^E10.610
 ;;^UTILITY(U,$J,358.3,1837,2)
 ;;=^5002613
 ;;^UTILITY(U,$J,358.3,1838,0)
 ;;=E10.618^^16^126^33
 ;;^UTILITY(U,$J,358.3,1838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1838,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,1838,1,4,0)
 ;;=4^E10.618
 ;;^UTILITY(U,$J,358.3,1838,2)
 ;;=^5002614
 ;;^UTILITY(U,$J,358.3,1839,0)
 ;;=E10.620^^16^126^5
 ;;^UTILITY(U,$J,358.3,1839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1839,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,1839,1,4,0)
 ;;=4^E10.620
 ;;^UTILITY(U,$J,358.3,1839,2)
 ;;=^5002615
 ;;^UTILITY(U,$J,358.3,1840,0)
 ;;=E10.621^^16^126^17
 ;;^UTILITY(U,$J,358.3,1840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1840,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,1840,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,1840,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,1841,0)
 ;;=E10.622^^16^126^38
 ;;^UTILITY(U,$J,358.3,1841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1841,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Skin Ulcer
 ;;^UTILITY(U,$J,358.3,1841,1,4,0)
 ;;=4^E10.622
 ;;^UTILITY(U,$J,358.3,1841,2)
 ;;=^5002617
 ;;^UTILITY(U,$J,358.3,1842,0)
 ;;=E10.628^^16^126^37
 ;;^UTILITY(U,$J,358.3,1842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1842,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Skin Complications
 ;;^UTILITY(U,$J,358.3,1842,1,4,0)
 ;;=4^E10.628
 ;;^UTILITY(U,$J,358.3,1842,2)
 ;;=^5002618
 ;;^UTILITY(U,$J,358.3,1843,0)
 ;;=E10.630^^16^126^40
 ;;^UTILITY(U,$J,358.3,1843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1843,1,3,0)
 ;;=3^Diabetes Type 1 w/ Peridontal Disease
 ;;^UTILITY(U,$J,358.3,1843,1,4,0)
 ;;=4^E10.630
 ;;^UTILITY(U,$J,358.3,1843,2)
 ;;=^5002619
 ;;^UTILITY(U,$J,358.3,1844,0)
 ;;=E10.638^^16^126^31
 ;;^UTILITY(U,$J,358.3,1844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1844,1,3,0)
 ;;=3^Diabetes Type 1 w/ Oral Complications
 ;;^UTILITY(U,$J,358.3,1844,1,4,0)
 ;;=4^E10.638
 ;;^UTILITY(U,$J,358.3,1844,2)
 ;;=^5002620
 ;;^UTILITY(U,$J,358.3,1845,0)
 ;;=E10.69^^16^126^39
 ;;^UTILITY(U,$J,358.3,1845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1845,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Specified Complication
 ;;^UTILITY(U,$J,358.3,1845,1,4,0)
 ;;=4^E10.69
 ;;^UTILITY(U,$J,358.3,1845,2)
 ;;=^5002624
 ;;^UTILITY(U,$J,358.3,1846,0)
 ;;=E10.8^^16^126^62
 ;;^UTILITY(U,$J,358.3,1846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1846,1,3,0)
 ;;=3^Diabetes Type 1 w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,1846,1,4,0)
 ;;=4^E10.8
 ;;^UTILITY(U,$J,358.3,1846,2)
 ;;=^5002625
 ;;^UTILITY(U,$J,358.3,1847,0)
 ;;=E11.9^^16^126^120
 ;;^UTILITY(U,$J,358.3,1847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1847,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,1847,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,1847,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,1848,0)
 ;;=E11.65^^16^126^76
 ;;^UTILITY(U,$J,358.3,1848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1848,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,1848,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,1848,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,1849,0)
 ;;=E11.21^^16^126^70
 ;;^UTILITY(U,$J,358.3,1849,1,0)
 ;;=^358.31IA^4^2
