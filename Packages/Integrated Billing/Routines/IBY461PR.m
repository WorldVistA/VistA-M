IBY461PR ;ALB/DEM - IB*2*461 PRE-INSTALL - ICD10 ;23-JAN-2012
 ;;2.0;INTEGRATED BILLING;**461**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 D DELOF       ; delete all output formatter data elements included in build
 Q
 ;
INCLUDE(FILE,Y) ; function to determine if output formatter entry should be included in the build
 ; FILE=5,6,7 indicating file 364.x
 ; Y=ien to file
 ;
 NEW OK,LN,TAG,DATA
 S OK=0
 F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,U_Y_U) S OK=1 Q
 Q OK
 ;
DELOF ; Delete included output formatter entries
 NEW FILE,DIK,LN,TAG,DATA,PCE,DA,Y
 F FILE=7 S DIK="^IBA(364."_FILE_"," F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 Q
 ;
 ;-----------------------------------------------------------------------
 ; Output Formatter (#364.7) entries modified: IB 837 TRANSMISSION Code Qualifiers & PRV
 ;   40 - PC1-4   - Procedure Code Qualifier
 ; 1617 - CL1A-17 - Patient Reason for Visit Qualifier (1)
 ; 1619 - CL1A-19 - Patient Reason for Visit Qualifier (2)
 ; 1620 - CL1A-20 - Patient Reason for Visit (2)
 ; 1621 - CL1A-21 - Patient Reason for Visit Qualifier (3)
 ; 1622 - CL1A-22 - Patient Reason for Visit (3)
 ; 1635 - CL1A-15 - Code List Qualifier Code (BJ)
 ;
 ; Output Formatter (#364.7) entries modified: UB-04 Diagnosis, Locally Printed
 ; 1298 - FL-67  - PRIN DIAG CODE (FL-67/1/1)
 ; 1302 - FL-67J - OTHER DIAG CODE 10(FL-67J/1/1)
 ; 1314 - FL-67K - OTHER DIAG CODE 11(FL-67K/1/1)
 ; 1315 - FL-67L - OTHER DIAG CODE 12(FL-67L/1/1)
 ; 1346 - FL-67A - OTHER DIAG CODE 1 (FL-67A/1/1)
 ; 1347 - FL-67B - OTHER DIAG CODE 2 (FL-67B/1/1)
 ; 1348 - FL-67C - OTHER DIAG CODE 3 (FL-67C/1/1)
 ; 1349 - FL-67D - OTHER DIAG CODE 4 (FL-67D/1/1)
 ; 1350 - FL-67E - OTHER DIAG CODE 5 (FL-67E/1/1)
 ; 1351 - FL-67F - OTHER DIAG CODE 6 (FL-67F/1/1)
 ; 1352 - FL-67G - OTHER DIAG CODE 7 (FL-67G/1/1)
 ; 1353 - FL-67H - OTHER DIAG CODE 8 (FL-67H/1/1)
 ; 1354 - FL-67I - OTHER DIAG CODE 9 (FL-67I/1/1)
 ; 1355 - FL-67M - OTHER DIAG CODE 13(FL-67M/1/1)
 ; 1356 - FL-67N - OTHER DIAG CODE 14(FL-67N/1/1)
 ; 1357 - FL-67O - OTHER DIAG CODE 15(FL-67O/1/1)
 ; 1358 - FL-67P - OTHER DIAG CODE 16(FL-67P/1/1)
 ; 1359 - FL-67Q - OTHER DIAG CODE 17(FL-67Q/1/1)
 ; 1370 - FL-69  - ADM DIAG CODE (FL-69)
 ; 1371 - FL-72a - ECI (FL-72A/1/1)
 ; 1407 - FL-70a - PATIENT REASON DX (FL-70/1/1)
 ; 1408 - FL-70b - PATIENT REASON DX (FL-70/1/2)
 ; 1409 - FL-70c - PATIENT REASON DX (FL-70/1/3)
 ; 1412 - FL-72b - ECI (FL-72B/1/1)
 ; 1414 - FL-72c - ECI (FL-72C/1/1)
 ;
ENT7 ; output formatter entries in file 364.7 to be included
 ;
 ;;^40^1617^1619^1620^1621^1622^1635^
 ;;^1298^1302^1314^1315^1346^1347^1348^1349^1350^1351^1352^1353^1354^
 ;;^1355^1356^1357^1358^1359^1370^1371^1407^1408^1409^1412^1414^
 ;
