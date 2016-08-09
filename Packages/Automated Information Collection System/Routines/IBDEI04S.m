IBDEI04S ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4526,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Bilateral Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,4526,1,4,0)
 ;;=4^H59.323
 ;;^UTILITY(U,$J,358.3,4526,2)
 ;;=^5006423
 ;;^UTILITY(U,$J,358.3,4527,0)
 ;;=H59.322^^30^318^16
 ;;^UTILITY(U,$J,358.3,4527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4527,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Left Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,4527,1,4,0)
 ;;=4^H59.322
 ;;^UTILITY(U,$J,358.3,4527,2)
 ;;=^5006422
 ;;^UTILITY(U,$J,358.3,4528,0)
 ;;=H59.321^^30^318^19
 ;;^UTILITY(U,$J,358.3,4528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4528,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Right Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,4528,1,4,0)
 ;;=4^H59.321
 ;;^UTILITY(U,$J,358.3,4528,2)
 ;;=^5006421
 ;;^UTILITY(U,$J,358.3,4529,0)
 ;;=L76.22^^30^318^20
 ;;^UTILITY(U,$J,358.3,4529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4529,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Skin
 ;;^UTILITY(U,$J,358.3,4529,1,4,0)
 ;;=4^L76.22
 ;;^UTILITY(U,$J,358.3,4529,2)
 ;;=^5009307
 ;;^UTILITY(U,$J,358.3,4530,0)
 ;;=D78.22^^30^318^21
 ;;^UTILITY(U,$J,358.3,4530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4530,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Spleen
 ;;^UTILITY(U,$J,358.3,4530,1,4,0)
 ;;=4^D78.22
 ;;^UTILITY(U,$J,358.3,4530,2)
 ;;=^5002402
 ;;^UTILITY(U,$J,358.3,4531,0)
 ;;=K91.82^^30^318^22
 ;;^UTILITY(U,$J,358.3,4531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4531,1,3,0)
 ;;=3^Postprocedural Hepatic Failure
 ;;^UTILITY(U,$J,358.3,4531,1,4,0)
 ;;=4^K91.82
 ;;^UTILITY(U,$J,358.3,4531,2)
 ;;=^5008908
 ;;^UTILITY(U,$J,358.3,4532,0)
 ;;=K91.83^^30^318^23
 ;;^UTILITY(U,$J,358.3,4532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4532,1,3,0)
 ;;=3^Postprocedural Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,4532,1,4,0)
 ;;=4^K91.83
 ;;^UTILITY(U,$J,358.3,4532,2)
 ;;=^5008909
 ;;^UTILITY(U,$J,358.3,4533,0)
 ;;=K91.3^^30^318^24
 ;;^UTILITY(U,$J,358.3,4533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4533,1,3,0)
 ;;=3^Postprocedural Intestinal Obstruction
 ;;^UTILITY(U,$J,358.3,4533,1,4,0)
 ;;=4^K91.3
 ;;^UTILITY(U,$J,358.3,4533,2)
 ;;=^5008902
 ;;^UTILITY(U,$J,358.3,4534,0)
 ;;=K68.11^^30^318^25
 ;;^UTILITY(U,$J,358.3,4534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4534,1,3,0)
 ;;=3^Postprocedural Retroperitoneal Abscess
 ;;^UTILITY(U,$J,358.3,4534,1,4,0)
 ;;=4^K68.11
 ;;^UTILITY(U,$J,358.3,4534,2)
 ;;=^5008782
 ;;^UTILITY(U,$J,358.3,4535,0)
 ;;=K91.850^^30^318^26
 ;;^UTILITY(U,$J,358.3,4535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4535,1,3,0)
 ;;=3^Pouchitis
 ;;^UTILITY(U,$J,358.3,4535,1,4,0)
 ;;=4^K91.850
 ;;^UTILITY(U,$J,358.3,4535,2)
 ;;=^338261
 ;;^UTILITY(U,$J,358.3,4536,0)
 ;;=C34.91^^30^319^22
 ;;^UTILITY(U,$J,358.3,4536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4536,1,3,0)
 ;;=3^Malig Neop of Right Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,4536,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,4536,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,4537,0)
 ;;=C34.92^^30^319^21
 ;;^UTILITY(U,$J,358.3,4537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4537,1,3,0)
 ;;=3^Malig Neop of Left Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,4537,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,4537,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,4538,0)
 ;;=J20.9^^30^319^10
 ;;^UTILITY(U,$J,358.3,4538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4538,1,3,0)
 ;;=3^Acute Bronchitis,Unspec
 ;;^UTILITY(U,$J,358.3,4538,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,4538,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,4539,0)
 ;;=J20.8^^30^319^5
 ;;^UTILITY(U,$J,358.3,4539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4539,1,3,0)
 ;;=3^Acute Bronchitis d/t Organisms NEC
 ;;^UTILITY(U,$J,358.3,4539,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,4539,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,4540,0)
 ;;=J20.5^^30^319^7
 ;;^UTILITY(U,$J,358.3,4540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4540,1,3,0)
 ;;=3^Acute Bronchitis d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,4540,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,4540,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,4541,0)
 ;;=J20.6^^30^319^8
 ;;^UTILITY(U,$J,358.3,4541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4541,1,3,0)
 ;;=3^Acute Bronchitis d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,4541,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,4541,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,4542,0)
 ;;=J20.2^^30^319^9
 ;;^UTILITY(U,$J,358.3,4542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4542,1,3,0)
 ;;=3^Acute Bronchitis d/t Streptococcus
 ;;^UTILITY(U,$J,358.3,4542,1,4,0)
 ;;=4^J20.2
 ;;^UTILITY(U,$J,358.3,4542,2)
 ;;=^5008188
 ;;^UTILITY(U,$J,358.3,4543,0)
 ;;=J20.4^^30^319^6
 ;;^UTILITY(U,$J,358.3,4543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4543,1,3,0)
 ;;=3^Acute Bronchitis d/t Parainfluenza Virus
 ;;^UTILITY(U,$J,358.3,4543,1,4,0)
 ;;=4^J20.4
 ;;^UTILITY(U,$J,358.3,4543,2)
 ;;=^5008190
 ;;^UTILITY(U,$J,358.3,4544,0)
 ;;=J20.3^^30^319^2
 ;;^UTILITY(U,$J,358.3,4544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4544,1,3,0)
 ;;=3^Acute Bronchitis d/t Coxsackievirus
 ;;^UTILITY(U,$J,358.3,4544,1,4,0)
 ;;=4^J20.3
 ;;^UTILITY(U,$J,358.3,4544,2)
 ;;=^5008189
 ;;^UTILITY(U,$J,358.3,4545,0)
 ;;=J20.1^^30^319^3
 ;;^UTILITY(U,$J,358.3,4545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4545,1,3,0)
 ;;=3^Acute Bronchitis d/t Hemophilus Influenzae
 ;;^UTILITY(U,$J,358.3,4545,1,4,0)
 ;;=4^J20.1
 ;;^UTILITY(U,$J,358.3,4545,2)
 ;;=^5008187
 ;;^UTILITY(U,$J,358.3,4546,0)
 ;;=J20.0^^30^319^4
 ;;^UTILITY(U,$J,358.3,4546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4546,1,3,0)
 ;;=3^Acute Bronchitis d/t Mycoplasma Pneumoniae
 ;;^UTILITY(U,$J,358.3,4546,1,4,0)
 ;;=4^J20.0
 ;;^UTILITY(U,$J,358.3,4546,2)
 ;;=^5008186
 ;;^UTILITY(U,$J,358.3,4547,0)
 ;;=J42.^^30^319^16
 ;;^UTILITY(U,$J,358.3,4547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4547,1,3,0)
 ;;=3^Chronic Bronchitis,Unspec
 ;;^UTILITY(U,$J,358.3,4547,1,4,0)
 ;;=4^J42.
 ;;^UTILITY(U,$J,358.3,4547,2)
 ;;=^5008234
 ;;^UTILITY(U,$J,358.3,4548,0)
 ;;=J45.998^^30^319^11
 ;;^UTILITY(U,$J,358.3,4548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4548,1,3,0)
 ;;=3^Asthma NEC
 ;;^UTILITY(U,$J,358.3,4548,1,4,0)
 ;;=4^J45.998
 ;;^UTILITY(U,$J,358.3,4548,2)
 ;;=^5008257
 ;;^UTILITY(U,$J,358.3,4549,0)
 ;;=J45.909^^30^319^13
 ;;^UTILITY(U,$J,358.3,4549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4549,1,3,0)
 ;;=3^Asthma,Uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,4549,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,4549,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,4550,0)
 ;;=J45.902^^30^319^12
 ;;^UTILITY(U,$J,358.3,4550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4550,1,3,0)
 ;;=3^Asthma w/ Status Asthmaticus,Unspec
 ;;^UTILITY(U,$J,358.3,4550,1,4,0)
 ;;=4^J45.902
 ;;^UTILITY(U,$J,358.3,4550,2)
 ;;=^5008255
 ;;^UTILITY(U,$J,358.3,4551,0)
 ;;=J44.9^^30^319^15
 ;;^UTILITY(U,$J,358.3,4551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4551,1,3,0)
 ;;=3^COPD,Unspec
 ;;^UTILITY(U,$J,358.3,4551,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,4551,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,4552,0)
 ;;=J61.^^30^319^24
 ;;^UTILITY(U,$J,358.3,4552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4552,1,3,0)
 ;;=3^Pneumoconiosis d/t Asbestos/Oth Mineral Fibers
 ;;^UTILITY(U,$J,358.3,4552,1,4,0)
 ;;=4^J61.
 ;;^UTILITY(U,$J,358.3,4552,2)
 ;;=^5008262
 ;;^UTILITY(U,$J,358.3,4553,0)
 ;;=R09.1^^30^319^23
 ;;^UTILITY(U,$J,358.3,4553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4553,1,3,0)
 ;;=3^Pleurisy
 ;;^UTILITY(U,$J,358.3,4553,1,4,0)
 ;;=4^R09.1
 ;;^UTILITY(U,$J,358.3,4553,2)
 ;;=^95428
 ;;^UTILITY(U,$J,358.3,4554,0)
 ;;=J84.17^^30^319^19
 ;;^UTILITY(U,$J,358.3,4554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4554,1,3,0)
 ;;=3^Interstitial Pulmonary Disease w/ Fibrosis NEC
