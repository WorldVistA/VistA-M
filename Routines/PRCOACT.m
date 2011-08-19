PRCOACT ;WISC/DJM-"ACT" & "PRJ" TRANSACTIONS FROM AUSTIN ;7/21/96  21:45
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
START ;THIS ROUTINE WILL SAVE THE INCOMMING "ACT" OR "PRJ" TRANSACTION
 ;IN THE "EDI STATUS" FILE (#443.75) WITHIN AN EXISTING RECORD.  THIS
 ;ROUTINE WILL START UP WHEN AN "ACT" OR "PRJ" TRANSACTION ARRIVES
 ;FROM AUSTIN AND IS SAVED IN FILE 423.6.  AFTER SAVING IN 423.6 THE
 ;SERVER WILL START UP A BACKGROUND TASK THAT CALLS THIS ROUTINE.
 ;
 ;THE BACKGROUND TASK WILL SET UP **PRCDA**, THE INTERNAL ENTRY
 ;NUMBER FROM FILE 423.6.  THE RECORD AT **PRCDA** CONTAINS THE DATA
 ;FROM THE "ACT" OR "PRJ" TRANSACTION THAT 'ARRIVED' FROM AUSTIN.
 ;
 N COUNT,COUNTER,I,LINE,MGP,PONO,PRC,PRCMG,PRCTC,PRCTT,PRCXM,RFQ,RECORD,ERRCNT
 N RRC,SEGT,STATION,STCK,TEXT,VENDOR,X,X1,X2
 ;
 ;NOW LETS VERIFY THAT THE TRANSACTION BELONGS TO THIS SITE.
 ;
 S LINE=$G(^PRCF(423.6,PRCDA,1,10000,0))
 S MGP=$O(^PRCF(423.5,"B",$P(LINE,U)_"-"_$P(LINE,U,4),0))
 I MGP="" S PRCXM(1)=$P($T(ERROR+8),";;",2)_$P(LINE,U)_"-"_$P(LINE,U,4)_"." G EXIT
 S MGP=$G(^PRCF(423.5,MGP,0))
 I MGP="" S PRCXM(1)=$P($T(ERROR+9),";;",2) G EXIT
 I $P(MGP,U,2)="" S PRCXM(1)=$P($T(ERROR+10),";;",2) G EXIT
 I $P(MGP,U,2)]"" S PRCMG=$P($G(^XMB(3.8,$P(MGP,U,2),0)),U)
 I PRCMG="" S PRCXM(1)=$P($T(ERROR+11),";;",2) G EXIT
 D  I $D(PRCXM(1)) G EXIT
 .  I ",ACT,PRJ,"'[","_$P(LINE,U,4)_"," S PRCXM(1)=$P($T(ERROR+1),";;",2)_$P(LINE,U,4)_"." Q
 .  S STATION=$P(LINE,U,3) I STATION="" S PRCXM(1)=$P($T(ERROR+4),";;",2)_$G(PRCDA)_"." Q
 .  S STCK=$O(^PRC(411,"B",STATION,0)) I STCK'>0 S PRCXM(1)=$P($T(ERROR+2),";;",2)_$G(STATION)_"." Q
 .  Q
 S PRCTC=$P(LINE,U,4)
 ;
 ;GATHER THE DATA FROM THE 'AT' SEGMENT OF THE TRANSACTION.
 ;
 S LINE=$G(^PRCF(423.6,PRCDA,1,10001,0))
 I $P(LINE,U,1)'="AT" S PRCXM(1)=$P($T(ERROR+3),";;",2)_$P($G(LINE),U)_"." G EXIT
 S PRCTT=$P(LINE,U,2)
 I PRCTT="" S PRCXM(1)=$P($T(ERROR+13),";;",2)_$G(PRCDA)_"." G EXIT
 S COUNT=+$P(LINE,U,3)
 ;
 ;NOW GET THE DATA FROM EACH 'TR' OR 'RJ' SEGMENT.
 ;
 S I=10001
 S COUNTER=0,ERRCNT=1
 K PRCXM
 F  S I=$O(^PRCF(423.6,PRCDA,1,I)) Q:I'>0  D  D:$O(PRCXM(0)) PERROR^PRCOACT0 Q:LINE["$"
 .  K PRC
 .  S LINE=$G(^PRCF(423.6,PRCDA,1,I,0))
 .  Q:$E(LINE,1)="$"
 .  S SEGT=$P(LINE,U)
 .  Q:",TR,RJ,"'[","_SEGT_","
 .  S PRC(1,443.75,"?+1,",9)=PRCTC
 .  S PRC(1,443.75,"?+1,",21)=COUNT
 .  S PONO=$P(LINE,U,2)
 .  I PRCTT="PHA" D
 .  .  F  Q:$A(PONO,$L(PONO))'=32  S PONO=$E(PONO,1,$L(PONO)-1)
 .  .  S PONO=$E(PONO,1,3)_"-"_$E(PONO,4,$L(PONO))
 .  .  Q
 .  S X1=$E($P(LINE,U,5),1,4)-1700_"0101"
 .  S X2=$E($P(LINE,U,5),5,7)-1
 .  D C^%DTC
 .  S PRC(1,443.75,"?+1,",10)=X_"."_$P(LINE,U,6)
 .  S PRC(1,443.75,"?+1,",22)=$S(PRCTC="ACT":$P(LINE,U,7),1:$P(LINE,U,14))
 .  S VENDOR=$P(LINE,U,3)
 .  S:PRCTT="RFQ" RFQ=$S(PRCTC="ACT":$P(LINE,U,8),1:$P(LINE,U,16))
 .  S:PRCTT="TXT" TEXT=$P(LINE,U,4)
 .  I PONO="" S PRCXM(ERRCNT)=$P($T(ERROR+14),";;",2)_$G(PRCDA)_"." D ERRCNT Q
 .  I PRCTT'="PHA",VENDOR="" S PRCXM(ERRCNT)=$P($T(ERROR+15),";;",2)_$G(PRCDA)_"." D ERRCNT Q
 .  I PRCTT="RFQ",RFQ="" S PRCXM(ERRCNT)=$P($T(ERROR+16),";;",2)_$G(PRCDA)_"." D ERRCNT Q
 .  I PRCTT="TXT",TEXT="" S PRCXM(ERRCNT)=$P($T(ERROR+17),";;",2)_$G(PRCDA)_"." D ERRCNT Q
 .  S RECORD=""
 .  I PRCTT="PHA" D  Q:$O(PRCXM(0))
 . . I VENDOR]"" S RECORD=$O(^PRC(443.75,"AO",PRCTT,PONO,VENDOR,0))
 . . I 'RECORD D  I 'RECORD S PRCXM(ERRCNT)=$P($T(ERROR+19),";;",2)_$G(PRCDA)_"." D ERRCNT Q
 . . . S RECORD=$O(^PRC(443.75,"AR",PONO,0))
 . . Q:$O(PRCXM(0))
 . . S VENDOR(1)=$P($G(^PRC(443.75,+$G(RECORD),0)),U,6)
 . . I VENDOR]"",VENDOR(1)]""&(VENDOR'=VENDOR(1)) S PRCXM(ERRCNT)=$P($T(ERROR+20),";;",2)_$G(RECORD)_"." D ERRCNT Q
 .  S:PRCTT="RFQ" RECORD=$O(^PRC(443.75,"AC",PRCTT,PONO,VENDOR,RFQ,0))
 .  S:PRCTT="TXT" RECORD=$O(^PRC(443.75,"AF",PRCTT,PONO,VENDOR,TEXT,0))
 .  I $G(^PRC(443.75,+$G(RECORD),0))']"" S PRCXM(ERRCNT)=$P($T(ERROR+12),";;",2)_$G(PONO)_"." D ERRCNT Q
 .  L +^PRC(443.75,RECORD):180 E  S PRCXM(ERRCNT)=$P($T(ERROR+18),";;",2)_$G(RECORD)_"." D ERRCNT Q
 . ;
 .  I SEGT="RJ" D
 .  .  S PRC(1,443.75,"?+1,",11)=$P(LINE,U,7)
 .  .  S PRC(1,443.75,"?+1,",12)=$P(LINE,U,8)
 .  .  S PRC(1,443.75,"?+1,",13)=$P(LINE,U,9)
 .  .  S:$P(LINE,U,12)]"" PRC(1,443.75,"?+1,",17)=$P(LINE,U,12)
 .  .  S:$P(LINE,U,13)]"" PRC(1,443.75,"?+1,",18)=$P(LINE,U,13)
 .  .  S:$P(LINE,U,10)]"" PRC(1,443.75,"?+1,",14)=$P(LINE,U,10)
 .  .  S RRC=$$EXTRL^PRCOACT0($P(LINE,U,15),1)
 .  .  I RRC']"" S PRCXM(ERRCNT)=$P($T(ERROR+5),";;",2)_$G(PRCDA)_"." D ERRCNT
 .  .  I RRC']"" S PRC(1,443.75,"?+1,",19)="E"
 .  .  I RRC']"" S PRC(1,443.75,"?+1,",20)=$P($T(ERROR+5),";;",3) Q
 .  .  S RRC=$O(^PRC(443.76,"B",RRC,0))
 .  .  I RRC'>0 S PRCXM(ERRCNT)=$P($T(ERROR+6),";;",2)_$G(PRCDA)_" (Error Code is "_$$EXTRL^PRCOACT0($P(LINE,U,15),1)_")." D ERRCNT
 .  .  I RRC'>0 S PRC(1,443.75,"?+1,",19)="E"
 .  .  I RRC'>0 S PRC(1,443.75,"?+1,",20)=$P($T(ERROR+6),";;",3) Q
 .  .  S PRC(1,443.75,"?+1,",15)=RRC
 .  .  Q
 .  S PRC(1,443.75,"?+1,",.01)=+$P($G(^PRC(443.75,RECORD,0)),U)
 .  D UPDATE^DIE("","PRC(1)")
 .  S COUNTER=COUNTER+1
STOP .  L:$G(RECORD) -^PRC(443.75,RECORD)
 .  Q
 I $G(RECORD),COUNTER'=COUNT S PRCXM(ERRCNT)=$P($T(ERROR+7),";;",2)_$G(PRCDA)_"." D ERRCNT
 ;
EXIT I $O(PRCXM(0)) D PERROR^PRCOACT0
 Q
ERRCNT ;increment counter for multiple errors within RJ,TR processing
 S ERRCNT=ERRCNT+1
 Q
 ;
ERROR ;HERE IS THE LIST OF ERROR MESSAGES
 ;;Expected an ACT or a PRJ transaction.  Received a ;;A1
 ;;The STATION number sent from EDI can not be found. The number is ;;A2
 ;;The second segment is not the expected AT segment. It was a ;;A3
 ;;There is no STATION number sent from EDI.  IEN for 423.6 is ;;A4
 ;;No REJECT REASON CODE from EDI. The record IEN in 423.6 is ;;A5
 ;;The ERROR CODE can not be found in the EDI ERROR CODES file. The record IEN in 423.6 is ;;A6
 ;;There is a difference in the number of TR or RJ segments expected and how many found. File 423.6 entry is ;;A7
 ;;There is no "B" cross-reference entry for this transaction in file 423.5. The entry is ;;A8
 ;;There is a "B" cross-reference entry for this transaction but no record.;;A9
 ;;There is a record for this transaction but no mail group pointer is listed.;;A10
 ;;The mail group entered in the record in file 423.5 can not be found in the mail group file.;;A11
 ;;The incoming record can't be found in file 443.75.  The RFQ/PO# is ;;A12
 ;;Required field TYPE OF TRANSACTION is blank. IEN for file 423.6 is ;;A13
 ;;Required field REF NUMBER is blank. IEN for file 423.6 is ;;A14
 ;;Required field VENDOR ID NUMBER is blank. IEN for file 423.6 is ;;A15
 ;;Required field TYPE OF RFQ is blank. IEN for file 423.6 is ;;A16
 ;;Required field TXT MESSAGE NUMBER is blank. IEN for file 423.6 is ;;A17
 ;;Unable to access record in file 443.75. IEN is ;;A18
 ;;Unable to locate entry in file 443.75. IEN for file 423.6 is ;;A19
 ;;VENDOR ID on transmission does not match 443.75 entry.  The IEN is ;;A20
