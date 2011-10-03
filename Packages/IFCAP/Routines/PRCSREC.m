PRCSREC ;WISC/KMB/DL-FMS 820 RECONCILIATION INTERCEPT ;12/28/99  11:06
V ;;5.1;IFCAP;**96**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;  add entry to file 417, update CP balance on File 420
 ;  finally, send 820 to designee at CP
 ;  if duplicate, or CP is not in IFCAP, set status to "N" or "D"
START ;
 Q:'$D(PRCDA)
 N AA,STATUS,STATION,CHECK,FILE,FCP,PODA,OUT,RDA,FY,QTR,TEMP,PONUM,PONUM1,TRANSNUM,X,Y,TDATE
 N LINE,LNN,TRANCODE,COUNTER,AMT,RDATE,FMSREF,K,ERROR,STRING
 N ENDFY,BEGFY
 S OUT=0,(FCP,STATION)=""
 D NOW^%DTC S RDATE=%,RDA=PRCDA
 ;    1,2 is this the right type of transaction
 S CHECK=$P($G(^PRCF(423.6,RDA,1,10000,0)),"^",3) I CHECK'["IFC" S OUT=1 D EVAL Q
 S CHECK=$P($G(^PRCF(423.6,RDA,1,10000,0)),"^",5) I CHECK'["REC" S OUT=2 D EVAL Q
 ;    3 is site correct
 S STATION=$P($G(^PRCF(423.6,RDA,1,10000,0)),"^",4) I STATION="" S OUT=3 D EVAL Q
 I '$D(^PRC(420,STATION)) S OUT=3 D EVAL Q
 S LINE=10000 F  S LINE=$O(^PRCF(423.6,RDA,1,LINE)) Q:'LINE  D PROCESS
 D KILL^PRCOSRV3(PRCDA)
 QUIT
PROCESS ;  check each transmission line sent
 Q:$P($G(^PRCF(423.6,RDA,1,LINE,0)),"^")["{"
 S STRING=^PRCF(423.6,RDA,1,LINE,0)
 ;    5,7 can a unique transmission record be determined
 S (PONUM,PONUM1)=$P(STRING,"^",18) I PONUM="" S OUT=5 D EVAL Q
 S LNN=$P(STRING,"^",19),TDATE=$P(STRING,"^",22) I TDATE="" S OUT=5 D EVAL Q
 S TRANCODE=$P(STRING,"^",17) I TRANCODE="" S OUT=7 D EVAL Q
 ;    8  is there a fiscal year/quarter
 S STATION=$P(STRING,"^",8),FY=$P(STRING,"^",4),QUARTER=$P(STRING,"^",5),AMT=$P(STRING,"^",20)
 I (FY="")!(QUARTER="") S OUT=8 D EVAL Q
 I (QUARTER'?1N)!(QUARTER>5) S OUT=8 D EVAL Q
 S ENDFY=$P(STRING,"^",3),BEGFY=$P(STRING,"^",2)
 S TRANSNUM=TRANCODE_"-"_PONUM_"-"_TDATE_"-"_+LNN_"-"_QUARTER
FCPCHEC ;
 ;    if there is a PO number, get CP from 442 record
 S $P(STRING,"^",9)=$P(STRING,"^",21)
 S PODA=0,(FCP,FILE)="" S PONUM=$E(PONUM,4,9),PONUM=STATION_"-"_PONUM
 ;    if it is not an employee payroll transaction ok to search file 442
 I TRANCODE'="PR" D  I $D(^PRC(420,STATION,1,+FCP,4,FY)) D CONTINU Q
 .S:$D(^PRC(442,"B",PONUM)) PODA=$O(^PRC(442,"B",PONUM,0))
 .I +PODA'=0 S FCP=$P($G(^PRC(442,PODA,0)),"^",3),FCP=+$P(FCP," ")
 .Q
 ;    if no PO match is found, use required fields table
 S ARRAY("BFY")=+$$YEAR^PRC0C($P(STRING,"^",2))
 S FILE=417.1
 S ARRAY("FUND")=$P(STRING,"^",6),ARRAY("AO")=$P(STRING,"^",7),ARRAY("FCPRJ")=$P(STRING,"^",10)
 S ARRAY("PGM")=$P(STRING,"^",21),ARRAY("OC")=$P(STRING,"^",16),ARRAY("JOB")=$P(STRING,"^",14),ARRAY("SITE")=STATION
 ;
 S A="" D FINDCP I A="" S FCP="000" S STATUS="N" D SET Q
 ;
 S B=$$FIRST^PRC0B1("^PRCD(420.141,""B"","""_A_""",",0)
 I 'B S FCP="000" S STATUS="N" D SET Q
 S FCP=+$P(^PRCD(420.141,B,0),"^",2)
 I +FCP=0 S FCP="000" S STATUS="N" D SET Q
 I '$D(^PRC(420,STATION,1,+FCP)) S FCP="000",STATUS="N" D SET Q
CONTINU ;    set control point balance on file 420
 S FILE=417,TRANSNUM=TRANSNUM_"-"_FCP
 S CHECK=TRANSNUM I $D(^PRCS(417,"B",CHECK)) S FILE=417.1 D SET Q
 S STATUS="P" D SET S AA=STATION_"^"_+FCP_"^"_FY_"^"_QUARTER_"^"_AMT
 I TRANCODE'="CC",$E(PONUM1,4,7)'?4A D EBAL^PRCSEZ(AA,"C")
 D EBAL^PRCSEZ(AA,"O")
 S INFORM=$P($T(MESSAGE+9),";;",2)
 I STATUS="P" D ^PRCSREC1 K INFORM QUIT
EVAL I OUT'=0 S ERROR=$P($T(MESSAGE+OUT),";;",2) D ^PRCSREC1
 S OUT=0 K ERROR QUIT
SET ;  set data on file 417 with status of "P" (posted), "D" (duplicate), "N" (no CP)
 S X=TRANSNUM,DIC="^PRCS("_FILE_",",DIC(0)="LZ",DLAYGO=FILE D FILE^DICN Q:Y=-1  S FMSDA=+Y K DLAYGO
 L +^PRCS(FILE,FMSDA):5 Q:'$T  F K=2,3,5:1:20 S $P(^PRCS(FILE,FMSDA,0),"^",K)=$P(STRING,"^",K)
 S K=$P(STRING,"^",4),DIE=DIC,DA=FMSDA,DR="3////^S X=K" D ^DIE
 S X=TDATE,X=$E(X,3,4)_"/"_$E(X,5,6)_"/"_$E(X,1,2) K %DT D ^%DT
 S $P(^PRCS(FILE,FMSDA,0),"^",22)=Y
 I FILE=417 S DIE=DIC,DA=FMSDA,DR="51///^S X=STATUS"_";"_"22///^S X=1" D ^DIE
 S COUNTER=STATION_"-"_FY_"-"_QUARTER_"-"_FCP,$P(^PRCS(FILE,FMSDA,0),"^",21)=COUNTER
 S ^PRCS(FILE,"C",COUNTER,FMSDA)=""
 L -^PRCS(FILE,FMSDA)
 K ARRAY,DA,DIC,DIE,DR QUIT
FINDCP ;
 S FUNDCODE=+$$FUND^PRC0C(ARRAY("FUND"),ARRAY("BFY")) Q:FUNDCODE=0
 D DOCREQ^PRC0C(FUNDCODE,"AB","AB"),DOCREQ^PRC0C(FUNDCODE,"SAB","SAB")
 F A="SPE","REV","GL" I $$REQ^PRC0C(FUNDCODE,A,"JOB")="Y" S SAB("JOB")="Y"
 S EE="~",A=ARRAY("SITE")_EE_ARRAY("BFY")_EE_ARRAY("FUND")
 F I="AO","PGM","FCPRJ","OC","JOB" D
 .I $G(AB(I))="Y"!($G(SAB(I))="Y") S PIECE=ARRAY(I)
 .E  S PIECE=""
 .S A=A_EE_PIECE
 K AB,EE,I,PIECE,FIELD,FUNDCODE,SAB Q
MESSAGE ;
 ;;IFCAP transmission code is incorrect
 ;;Transmission type is not correct for 820 processing
 ;;Site reference is incorrect
 ;;
 ;;No FMS message transmission number sent in this transaction
 ;;Duplicate message transmission number sent in transaction
 ;;No FMS transaction code was sent for this transaction
 ;;Invalid fiscal year or quarter sent in this transaction
 ;;Your control point balances have been adjusted by the amount above
