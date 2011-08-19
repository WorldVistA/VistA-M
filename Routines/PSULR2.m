PSULR2 ;BIR/PDW - PBM LAB EXTRACT  PROCESS PATIENTS ;25 AUG 1998
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA'S
 ; Reference to file #2  supported by DBIA 10035
 ; Reference to file #63 supported by DBIA 2524
 ;
EN ;EP  SCAN AND SPLIT INTO DIVISION,RECORDS
 ;   Build ^XTMP(,,"RECORDS",PSUDIV,L)
 ;   Build ^XTMP(,,"PATIENT",DFN,TEST)=""  AND THEN
 ;                                   ,DATE)=RESULT^FLAG
 K ^XTMP(PSULRSUB,"RECORDS"),^("PATIENTS")
 ;   Gather the tests necessary for each patient
 S PSUDA="" F  S PSUDA=$O(^XTMP(PSULRSUB,"EVENT",PSUDA)) Q:PSUDA'>0  S X=^(PSUDA) D TESTS
 ;
 ;   with the tests gathered for each patient
 ;   now scan each patients daily lab results looking for the tests
 D PATIENT
 Q
TESTS ;EP Gather tests for a patient for the drug class
 ;      nodes used in ^XTMP sampler
 ;^XTMP("PSULR_541074170","CODES","CV800",6) = POTASSIUM
 ;^XTMP("PSULR_541074170","EVENT",1) = IV^599^13^12345^ASPRIN^CV800
 ;^XTMP("PSULR_541074170","PATIENT",13,4) = CREATININE
 ;^XTMP("PSULR_541074170","PATIENT",13,4,7029388.859632) = 1.0^^^50
 ;^XTMP("PSULR_541074170","PATIENT",13,6) = POTASSIUM
 ;^XTMP("PSULR_541074170","PATIENT",13,6,7029388.859632) = 5.0^^^50
 ;
 ; lab test "ch" node locations for each drug class were built in PSULR1 
 ; Setup "Patient",ch node)="" by codes and tests built in XTMP(,,"CODES",TEST node)=test name
 ;
 S PSUDRCD=$P(X,U,6),PSUDFN=$P(X,U,3)
 S PSULRND=0 F  S PSULRND=$O(^XTMP(PSULRSUB,"CODES",PSUDRCD,PSULRND)) Q:PSULRND'>0  S X=^(PSULRND) D
 . S ^XTMP(PSULRSUB,"PATIENT",PSUDFN,PSULRND)=X
 Q
 ;
PATIENT ;EP SCAN for each patient their tests needed
 ;Take   ^XTMP(,"PATIENT","CH TEST NODE")=TESTNAME
 ;scan the lab file
 ;and build
 ;       ^XTMP(,"PATIENT","CH TEST NODE",DATE)=RESULT^TESTFLAG
 ;
 S X1=PSUEDT,X2=-365 D C^%DTC
 ;S X1=PSUSDT,X2=-365 D C^%DTC
 S PSULREDT=9999999-X ; only go back one year
 S PSULRSDT=9999999-PSUSDT
 ;
 ;     gather needed test (nodes) from ^XTMP and put into the X to PSUNODE array
 ;
 S DFN=0 F  K X S DFN=$O(^XTMP(PSULRSUB,"PATIENT",DFN)) Q:DFN'>0  M X=^(DFN) D
 . N PSUNODE
 . ;   psunode("CH" NODE)=test name
 . M PSUNODE=X
 . I '$D(^DPT(DFN,"LR")) Q
 . S PSULRDFN=^DPT(DFN,"LR")
 . S DA=PSULRSDT F  S DA=$O(^LR(PSULRDFN,"CH",DA)) Q:DA'>0  Q:'$D(PSUNODE)  Q:DA>PSULREDT  D
 .. ;  check each date for each ch node in PSUNODE
 .. S Y=0 F  S Y=$O(PSUNODE(Y)) Q:Y'>0  I $D(^LR(PSULRDFN,"CH",DA,Y)) D
 ...  ;found a test, save result & quit testing for the node
 ... I '$P(^LR(PSULRDFN,"CH",DA,0),U,3) Q  ; results not verified
 ... S ^XTMP(PSULRSUB,"PATIENT",DFN,Y,DA)=^LR(PSULRDFN,"CH",DA,Y)
 ... K PSUNODE(Y)
 ;
 Q
 ;
