IBDEI3IJ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.4,1477,0)
 ;;=DELIRIUM^7^141
 ;;^UTILITY(U,$J,358.4,1478,0)
 ;;=DEMENTIA/NEUROCOGNITIVE DISORDERS^8^141
 ;;^UTILITY(U,$J,358.4,1479,0)
 ;;=DEPRESSIVE DISORDERS^9^141
 ;;^UTILITY(U,$J,358.4,1480,0)
 ;;=DISSOCIATIVE DISORDERS ^10^141
 ;;^UTILITY(U,$J,358.4,1481,0)
 ;;=EATING DISORDERS^11^141
 ;;^UTILITY(U,$J,358.4,1482,0)
 ;;=EDUCATIONAL/OCCUPATIONAL PROBLEMS^12^141
 ;;^UTILITY(U,$J,358.4,1483,0)
 ;;=GENDER DYSPHORIA^13^141
 ;;^UTILITY(U,$J,358.4,1484,0)
 ;;=HOUSING/ECONOMIC PROBLEMS^14^141
 ;;^UTILITY(U,$J,358.4,1485,0)
 ;;=MEDICATION-INDUCED MOVEMENT DISORDERS^16^141
 ;;^UTILITY(U,$J,358.4,1486,0)
 ;;=OBSESSIVE-COMPULSIVE & RELATED DISORDERS^17^141
 ;;^UTILITY(U,$J,358.4,1487,0)
 ;;=ORGANIC DISORDERS^18^141
 ;;^UTILITY(U,$J,358.4,1488,0)
 ;;=PERSONAL HX & CURRENT CIRCUMSTANCES^20^141
 ;;^UTILITY(U,$J,358.4,1489,0)
 ;;=ADHD^2^141
 ;;^UTILITY(U,$J,358.4,1490,0)
 ;;=COUNSELING/MED ADVICE^5^141
 ;;^UTILITY(U,$J,358.4,1491,0)
 ;;=SOCIAL ENVIRONMENT PROBLEMS^28^141
 ;;^UTILITY(U,$J,358.4,1492,0)
 ;;=PARAPHILIC DISORDERS^19^141
 ;;^UTILITY(U,$J,358.4,1493,0)
 ;;=PERSONALITY DISORDERS^21^141
 ;;^UTILITY(U,$J,358.4,1494,0)
 ;;=CRIME/LEGAL SYSTEM PROBLEMS^6^141
 ;;^UTILITY(U,$J,358.4,1495,0)
 ;;=PSYCHOSOCIAL/PERSONAL/ENVIRONMENTAL^22^141
 ;;^UTILITY(U,$J,358.4,1496,0)
 ;;=RELATIONAL PROBLEMS^23^141
 ;;^UTILITY(U,$J,358.4,1497,0)
 ;;=SCHIZOPHRENIA/OTH PSYCHOTIC DISORDERS^25^141
 ;;^UTILITY(U,$J,358.4,1498,0)
 ;;=SEXUAL DYSFUNCTION^26^141
 ;;^UTILITY(U,$J,358.4,1499,0)
 ;;=SLEEP DISORDERS^27^141
 ;;^UTILITY(U,$J,358.4,1500,0)
 ;;=SUBSTANCE ABUSE-ALCOHOL^30^141
 ;;^UTILITY(U,$J,358.4,1501,0)
 ;;=SUBSTANCE ABUSE-AMPHETAMINE^31^141
 ;;^UTILITY(U,$J,358.4,1502,0)
 ;;=SUBSTANCE ABUSE-CANNABIS^32^141
 ;;^UTILITY(U,$J,358.4,1503,0)
 ;;=SUBSTANCE ABUSE-HALLUCINOGEN^34^141
 ;;^UTILITY(U,$J,358.4,1504,0)
 ;;=SUBSTANCE ABUSE-OPIOID^36^141
 ;;^UTILITY(U,$J,358.4,1505,0)
 ;;=SUBSTANCE ABUSE-PSYCHOACTIVE DRUGS^37^141
 ;;^UTILITY(U,$J,358.4,1506,0)
 ;;=SUBSTANCE ABUSE-SEDATIVE/HYPNOTIC^38^141
 ;;^UTILITY(U,$J,358.4,1507,0)
 ;;=SUBSTANCE ABUSE-TOBACCO^39^141
 ;;^UTILITY(U,$J,358.4,1508,0)
 ;;=SUBSTANCE ABUSE-COCAINE^33^141
 ;;^UTILITY(U,$J,358.4,1509,0)
 ;;=TRAUMA/STRESSOR-RELATED DISORDERS^40^141
 ;;^UTILITY(U,$J,358.4,1510,0)
 ;;=SUBSTANCE ABUSE-INHALANT^35^141
 ;;^UTILITY(U,$J,358.4,1511,0)
 ;;=INTELLECTUAL DISABILITIES^15^141
 ;;^UTILITY(U,$J,358.4,1512,0)
 ;;=RESEARCH^24^141
 ;;^UTILITY(U,$J,358.4,1513,0)
 ;;=SOMATOFORM DISORDERS^29^141
 ;;^UTILITY(U,$J,358.4,1514,0)
 ;;=NEW PATIENT^1^142
 ;;^UTILITY(U,$J,358.4,1515,0)
 ;;=ESTABLISHED PATIENT^2^142
 ;;^UTILITY(U,$J,358.4,1516,0)
 ;;=EDUCATION & TRAINING FOR SELF MANAGEMENT^3^142
 ;;^UTILITY(U,$J,358.4,1517,0)
 ;;=ABUSE AND NEGLECT^1^143
 ;;^UTILITY(U,$J,358.4,1518,0)
 ;;=ANXIETY DISORDERS^3^143
 ;;^UTILITY(U,$J,358.4,1519,0)
 ;;=BIPOLAR DISORDERS^4^143
 ;;^UTILITY(U,$J,358.4,1520,0)
 ;;=DELIRIUM^7^143
 ;;^UTILITY(U,$J,358.4,1521,0)
 ;;=DEMENTIA/NEUROCOGNITIVE DISORDERS^8^143
 ;;^UTILITY(U,$J,358.4,1522,0)
 ;;=DEPRESSIVE DISORDERS^9^143
 ;;^UTILITY(U,$J,358.4,1523,0)
 ;;=DISSOCIATIVE DISORDERS ^10^143
 ;;^UTILITY(U,$J,358.4,1524,0)
 ;;=EATING DISORDERS^11^143
 ;;^UTILITY(U,$J,358.4,1525,0)
 ;;=EDUCATIONAL/OCCUPATIONAL PROBLEMS^12^143
 ;;^UTILITY(U,$J,358.4,1526,0)
 ;;=GENDER DYSPHORIA^13^143
 ;;^UTILITY(U,$J,358.4,1527,0)
 ;;=HOUSING/ECONOMIC PROBLEMS^14^143
 ;;^UTILITY(U,$J,358.4,1528,0)
 ;;=MEDICATION-INDUCED MOVEMENT DISORDERS^16^143
 ;;^UTILITY(U,$J,358.4,1529,0)
 ;;=OBSESSIVE-COMPULSIVE & RELATED DISORDERS^17^143
 ;;^UTILITY(U,$J,358.4,1530,0)
 ;;=ORGANIC DISORDERS^18^143