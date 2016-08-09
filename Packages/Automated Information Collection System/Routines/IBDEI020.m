IBDEI020 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1538,1,3,0)
 ;;=3^Education & Training,5-8 Patients
 ;;^UTILITY(U,$J,358.3,1539,0)
 ;;=V5299^^10^129^15^^^^1
 ;;^UTILITY(U,$J,358.3,1539,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1539,1,2,0)
 ;;=2^V5299
 ;;^UTILITY(U,$J,358.3,1539,1,3,0)
 ;;=3^Hearing Services 
 ;;^UTILITY(U,$J,358.3,1540,0)
 ;;=V5011^^10^129^14^^^^1
 ;;^UTILITY(U,$J,358.3,1540,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1540,1,2,0)
 ;;=2^V5011
 ;;^UTILITY(U,$J,358.3,1540,1,3,0)
 ;;=3^Hearing Aid Fitting/Checking
 ;;^UTILITY(U,$J,358.3,1541,0)
 ;;=69200^^10^130^1^^^^1
 ;;^UTILITY(U,$J,358.3,1541,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1541,1,2,0)
 ;;=2^69200
 ;;^UTILITY(U,$J,358.3,1541,1,3,0)
 ;;=3^Remove Foreign Body, External Canal
 ;;^UTILITY(U,$J,358.3,1542,0)
 ;;=69210^^10^130^3^^^^1
 ;;^UTILITY(U,$J,358.3,1542,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1542,1,2,0)
 ;;=2^69210
 ;;^UTILITY(U,$J,358.3,1542,1,3,0)
 ;;=3^Remove Impacted Cerumen,Req Instrument,Unilateral
 ;;^UTILITY(U,$J,358.3,1543,0)
 ;;=69209^^10^130^2^^^^1
 ;;^UTILITY(U,$J,358.3,1543,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1543,1,2,0)
 ;;=2^69209
 ;;^UTILITY(U,$J,358.3,1543,1,3,0)
 ;;=3^Remove Impacted Cerumen,Lavage,Unilateral
 ;;^UTILITY(U,$J,358.3,1544,0)
 ;;=92548^^10^131^4^^^^1
 ;;^UTILITY(U,$J,358.3,1544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1544,1,2,0)
 ;;=2^92548
 ;;^UTILITY(U,$J,358.3,1544,1,3,0)
 ;;=3^Computerized Dynamic Posturography
 ;;^UTILITY(U,$J,358.3,1545,0)
 ;;=92544^^10^131^5^^^^1
 ;;^UTILITY(U,$J,358.3,1545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1545,1,2,0)
 ;;=2^92544
 ;;^UTILITY(U,$J,358.3,1545,1,3,0)
 ;;=3^Optokinetic Nystagmus Test Bidirec,w/Recording
 ;;^UTILITY(U,$J,358.3,1546,0)
 ;;=92545^^10^131^6^^^^1
 ;;^UTILITY(U,$J,358.3,1546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1546,1,2,0)
 ;;=2^92545
 ;;^UTILITY(U,$J,358.3,1546,1,3,0)
 ;;=3^Oscillating Tracking Test W/Recording
 ;;^UTILITY(U,$J,358.3,1547,0)
 ;;=92542^^10^131^7^^^^1
 ;;^UTILITY(U,$J,358.3,1547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1547,1,2,0)
 ;;=2^92542
 ;;^UTILITY(U,$J,358.3,1547,1,3,0)
 ;;=3^Positional Nystagmus Test min 4 pos w/Recording
 ;;^UTILITY(U,$J,358.3,1548,0)
 ;;=92546^^10^131^8^^^^1
 ;;^UTILITY(U,$J,358.3,1548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1548,1,2,0)
 ;;=2^92546
 ;;^UTILITY(U,$J,358.3,1548,1,3,0)
 ;;=3^Sinusiodal Vertical Axis Rotation
 ;;^UTILITY(U,$J,358.3,1549,0)
 ;;=92547^^10^131^10^^^^1
 ;;^UTILITY(U,$J,358.3,1549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1549,1,2,0)
 ;;=2^92547
 ;;^UTILITY(U,$J,358.3,1549,1,3,0)
 ;;=3^Vertical Channel (Add On To Each Eng Code)
 ;;^UTILITY(U,$J,358.3,1550,0)
 ;;=92541^^10^131^9^^^^1
 ;;^UTILITY(U,$J,358.3,1550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1550,1,2,0)
 ;;=2^92541
 ;;^UTILITY(U,$J,358.3,1550,1,3,0)
 ;;=3^Spontaneous Nystagmus Test W/Recording
 ;;^UTILITY(U,$J,358.3,1551,0)
 ;;=92540^^10^131^1^^^^1
 ;;^UTILITY(U,$J,358.3,1551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1551,1,2,0)
 ;;=2^92540
 ;;^UTILITY(U,$J,358.3,1551,1,3,0)
 ;;=3^Basic Vestibular Eval w/Recordings
 ;;^UTILITY(U,$J,358.3,1552,0)
 ;;=92537^^10^131^2^^^^1
 ;;^UTILITY(U,$J,358.3,1552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1552,1,2,0)
 ;;=2^92537
 ;;^UTILITY(U,$J,358.3,1552,1,3,0)
 ;;=3^Caloric Vstblr Test w/ Rec,Bilat;Bithermal
 ;;^UTILITY(U,$J,358.3,1553,0)
 ;;=92538^^10^131^3^^^^1
 ;;^UTILITY(U,$J,358.3,1553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1553,1,2,0)
 ;;=2^92538
 ;;^UTILITY(U,$J,358.3,1553,1,3,0)
 ;;=3^Caloric Vstblr Test w/ Rec,Bilat;Monothermal
 ;;^UTILITY(U,$J,358.3,1554,0)
 ;;=92531^^10^132^1^^^^1
 ;;^UTILITY(U,$J,358.3,1554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1554,1,2,0)
 ;;=2^92531
 ;;^UTILITY(U,$J,358.3,1554,1,3,0)
 ;;=3^Spontaneous Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,1555,0)
 ;;=92532^^10^132^2^^^^1
 ;;^UTILITY(U,$J,358.3,1555,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1555,1,2,0)
 ;;=2^92532
 ;;^UTILITY(U,$J,358.3,1555,1,3,0)
 ;;=3^Positional Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,1556,0)
 ;;=92533^^10^132^3^^^^1
 ;;^UTILITY(U,$J,358.3,1556,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1556,1,2,0)
 ;;=2^92533
 ;;^UTILITY(U,$J,358.3,1556,1,3,0)
 ;;=3^Caloric Vestibular Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,1557,0)
 ;;=92534^^10^132^4^^^^1
 ;;^UTILITY(U,$J,358.3,1557,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1557,1,2,0)
 ;;=2^92534
 ;;^UTILITY(U,$J,358.3,1557,1,3,0)
 ;;=3^Opokinetic Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,1558,0)
 ;;=92626^^10^133^3^^^^1
 ;;^UTILITY(U,$J,358.3,1558,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1558,1,2,0)
 ;;=2^92626
 ;;^UTILITY(U,$J,358.3,1558,1,3,0)
 ;;=3^Eval of Auditory Rehab Status,1st Hr
 ;;^UTILITY(U,$J,358.3,1559,0)
 ;;=92627^^10^133^4^^^^1
 ;;^UTILITY(U,$J,358.3,1559,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1559,1,2,0)
 ;;=2^92627
 ;;^UTILITY(U,$J,358.3,1559,1,3,0)
 ;;=3^Eval of Auditory Rehab Status,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,1560,0)
 ;;=92630^^10^133^1^^^^1
 ;;^UTILITY(U,$J,358.3,1560,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1560,1,2,0)
 ;;=2^92630
 ;;^UTILITY(U,$J,358.3,1560,1,3,0)
 ;;=3^Auditory Rehab;Prelingual Hearing Loss
 ;;^UTILITY(U,$J,358.3,1561,0)
 ;;=92633^^10^133^2^^^^1
 ;;^UTILITY(U,$J,358.3,1561,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1561,1,2,0)
 ;;=2^92633
 ;;^UTILITY(U,$J,358.3,1561,1,3,0)
 ;;=3^Auditory Rehab;Postlingual Hearing Loss
 ;;^UTILITY(U,$J,358.3,1562,0)
 ;;=92625^^10^133^5^^^^1
 ;;^UTILITY(U,$J,358.3,1562,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1562,1,2,0)
 ;;=2^92625
 ;;^UTILITY(U,$J,358.3,1562,1,3,0)
 ;;=3^Tinnitus Assessment
 ;;^UTILITY(U,$J,358.3,1563,0)
 ;;=99366^^10^134^1^^^^1
 ;;^UTILITY(U,$J,358.3,1563,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1563,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,1563,1,3,0)
 ;;=3^Team Conf w/ Pt by HC Pro,30 Min
 ;;^UTILITY(U,$J,358.3,1564,0)
 ;;=99368^^10^134^2^^^^1
 ;;^UTILITY(U,$J,358.3,1564,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1564,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,1564,1,3,0)
 ;;=3^Team Conf w/o Pt by HC Pro,30 Min
 ;;^UTILITY(U,$J,358.3,1565,0)
 ;;=99415^^10^135^1^^^^1
 ;;^UTILITY(U,$J,358.3,1565,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1565,1,2,0)
 ;;=2^99415
 ;;^UTILITY(U,$J,358.3,1565,1,3,0)
 ;;=3^Prolonged Clin Staff Svc;1st hr
 ;;^UTILITY(U,$J,358.3,1566,0)
 ;;=99416^^10^135^2^^^^1
 ;;^UTILITY(U,$J,358.3,1566,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1566,1,2,0)
 ;;=2^99416
 ;;^UTILITY(U,$J,358.3,1566,1,3,0)
 ;;=3^Prolonged Clin Staff Svc;Ea Addl 30min
 ;;^UTILITY(U,$J,358.3,1567,0)
 ;;=S04.61XA^^11^136^4
 ;;^UTILITY(U,$J,358.3,1567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1567,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, initial encounter
 ;;^UTILITY(U,$J,358.3,1567,1,4,0)
 ;;=4^S04.61XA
 ;;^UTILITY(U,$J,358.3,1567,2)
 ;;=^5020540
 ;;^UTILITY(U,$J,358.3,1568,0)
 ;;=S04.61XD^^11^136^5
 ;;^UTILITY(U,$J,358.3,1568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1568,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, subsequent encounter
 ;;^UTILITY(U,$J,358.3,1568,1,4,0)
 ;;=4^S04.61XD
 ;;^UTILITY(U,$J,358.3,1568,2)
 ;;=^5020541
 ;;^UTILITY(U,$J,358.3,1569,0)
 ;;=S04.61XS^^11^136^6
 ;;^UTILITY(U,$J,358.3,1569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1569,1,3,0)
 ;;=3^Injury of acoustic nerve, right side, sequela
 ;;^UTILITY(U,$J,358.3,1569,1,4,0)
 ;;=4^S04.61XS
 ;;^UTILITY(U,$J,358.3,1569,2)
 ;;=^5020542
 ;;^UTILITY(U,$J,358.3,1570,0)
 ;;=S04.62XA^^11^136^1
 ;;^UTILITY(U,$J,358.3,1570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1570,1,3,0)
 ;;=3^Injury of acoustic nerve, left side, initial encounter
 ;;^UTILITY(U,$J,358.3,1570,1,4,0)
 ;;=4^S04.62XA
