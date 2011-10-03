PSJUNITD ;BIR/RLW-WRITE TO UNIT DOSE SUBFILE ;28 JUN 96 / 12:19 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
EN(PSJ) ; return a value for the DR or DIC("DR") string
 N I,X,LINETAG,FIELD S (X,FIELD)=""
 F  S FIELD=$O(PSJ(FIELD)) Q:FIELD=""  S LINETAG="" D
 .F I=1:1:$L(FIELD) S LINETAG=LINETAG+($A(FIELD,I)*I)
 .S:FIELD="REASON ORDER CREATED" LINETAG=9999
 .S X=X_+$P($T(@(LINETAG)),";;",2)_"////"_PSJ(FIELD)_";"
 Q X
 ;        
FIELDS ; fields from the NON-VERIFIED ORDERS file
5647 ;;.01      -    0;1       ORDER NUMBER
16398 ;;.25      -    0;18      ORIGINAL ORDER NUMBER
5438 ;;.5       -    0;15      PATIENT NAME
2737 ;;1        -    0;2       PROVIDER
6542 ;;2        -    1;0       DISPENSE DRUG
3319 ;;3        -    0;3       MED ROUTE
778 ;;4        -    0;4       TYPE
2378 ;;5        -    0;5       SELF MED
23949 ;;6        -    0;6       HOSPITAL SUPPLIED SELF MED
6607 ;;7        -    0;7       SCHEDULE TYPE
16029 ;;8        -    6;1       SPECIAL INSTRUCTIONS
6383 ;;9        -    2;10      ORIGINAL WARD
8415 ;;10       -    2;2       START DATE/TIME
3290 ;;11       -    0;10      DAY LIMIT
3991 ;;12       -    0;11      DOSE LIMIT
2829 ;;15       -    3;0       COMMENTS
8881 ;;16       -    4;1       VERIFYING NURSE
17739 ;;17       -    4;2       DATE VERIFIED BY NURSE
15382 ;;18       -    4;3       VERIFYING PHARMACIST
26697 ;;19       -    4;4       DATE VERIFIED BY PHARMACIST
3323 ;;20       -    4;5       PHYSICIAN
24702 ;;21       -    4;6       DATE VERIFIED BY PHYSICIAN
1129 ;;22       -    4;7       CLERK
15754 ;;23       -    4;8       DATE ENTERED BY CLERK
19488 ;;25       -    2;3       PREVIOUS STOP DATE/TIME
2643 ;;26       -    2;1       SCHEDULE
3767 ;;27       -    0;14      ORDER DATE
4412 ;;27.1     -    0;16      LOG-IN DATE
1705 ;;28       -    0;9       STATUS
5680 ;;29       -    9;0       ACTIVITY LOG
7361 ;;34       -    2;4       STOP DATE/TIME
4774 ;;41       -    2;5       ADMIN TIMES
22217 ;;42       -    2;6       FREQUENCY (in minutes)
2087 ;;43       -    4;15      RENEWAL
5681 ;;44       -    4;16      RENEWAL USER
13193 ;;45       -    4;17      DATE RENEWAL MARKED
9371 ;;46       -    4;12      MARKED CANCELLED
16124 ;;47       -    4;13      MARKED CANCELLED USER
15772 ;;48       -    4;14      DATE MARKED CANCELLED
12745 ;;49       -    4;11      AUTO CANLAG
1895 ;;50       -    4;9       PV FLAG
1893 ;;51       -    4;10      NV FLAG
3694 ;;52       -    7;1       LABEL DATE
5598 ;;53       -    7;2       LABEL REASON
31357 ;;54       -    5;7       *TOTALS EXTRA UNITS DISPENSED
18316 ;;55       -    5;8       *EXTRA UNITS DISPENSED
3001 ;;56       -    4;18      HOLD FLAG
3271 ;;57       -    4;19      HOLD USER
3046 ;;58       -    4;20      HOLD DATE
5015 ;;59       -    4;21      HOLD STATUS
6997 ;;59.1     -    4;26      OERR HOLD FLAG
5994 ;;60       -    4;22      OFF HOLD FLAG
6412 ;;61       -    4;23      OFF HOLD USER
6055 ;;62       -    4;24      OFF HOLD DATE
23207 ;;63       -    5;9       *TOTAL PRE-EXCHANGE UNITS
3710 ;;64       -    0;20      PURGE FLAG
711 ;;65       -    6.5;1     *SIG
11049 ;;66       -    0;21      ORDERS FILE ENTRY
7608 ;;67       -    4;25      MERGED PATIENT
3196 ;;68       -    0;23      LAST WARD
16181 ;;69       -    0;22      'NOT TO BE GIVEN' FLAG
20939 ;;70       -    2;7       ORIGINAL START DATE/TIME
5498 ;;71       -    11;0      DISPENSE LOG
11380 ;;72       -    12;0      PROVIDER COMMENTS
5686 ;;101      -    .1;1      PRIMARY DRUG
7370 ;;102      -    .1;2      DOSAGE ORDERED
14603 ;;103      -    0;24      REASON ORDER CREATED
7734 ;;104      -    0;25      PREVIOUS ORDER
8704 ;;105      -    0;26      FOLLOWING ORDER
8363 ;;106      -    .1;3      NATURE OF ORDER
25092 ;;107      -    0;27      REASON FOR FOLLOWING ORDER
