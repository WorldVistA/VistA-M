PRCPSMCS ;WISC/RFJ-create and transmit isms code sheet from tmp     ;7/8/96  9:30 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
TRANSMIT(V1,V2,V3,V4,V5,V6) ;  transmit code sheets from tmp global
 ;  v1=station number
 ;  v2=transaction code (BAL or PHA, etc)
 ;  v3=reference number for header
 ;  v4=1stQueue^2ndQueue^... (form ISM or ISM^EDP)
 ;  v5=receiving station number for control segment
 ;  v6=transaction interface version number...padded to 3 numbers
 ;     with leading zeros
 ;  tmp($j,"string",1:n)=code sheet data
 ;  returns prcpxmz(sequence number)=mailman message number
 ;
 N %,CONTROL,COUNT,CSHEET,DATA,LASTONE,LINE,LINECNT,SEQUENCE,SIZE,XMZ
 ;  get control segment
 S CONTROL=$$CONTROL(V1,V2,V3,V5,$G(V6))
 ;
 K ^TMP($J,"PRCPSMC0"),PRCPXMZ
 ;
 ;  move code sheets to message number in tmp global
 S SEQUENCE=1,LINE=2,(SIZE,COUNT,CSHEET)=0 F  S CSHEET=$O(^TMP($J,"STRING",CSHEET)) Q:'CSHEET  S DATA=^(CSHEET),COUNT=COUNT+1 D
 .   ;
 .   ;  check for last code sheet => set flag
 .   I '$O(^TMP($J,"STRING",CSHEET)) S LASTONE=1,DATA=DATA_"$"
 .   ;
 .   ;  calculate message size
 .   S SIZE=SIZE+$L(DATA) I SIZE>30000,'$G(LASTONE) S DATA=DATA_$C(126)
 .   ;
 .   ;  build message in tmp
 .   S ^TMP($J,"PRCPSMC0",SEQUENCE,LINE,0)=DATA,LINE=LINE+1
 .   ;
 .   ;  increment counters if size exceeds 30k
 .   I '$G(LASTONE),SIZE>30000 S SEQUENCE=SEQUENCE+1,LINE=2,SIZE=$L(DATA)
 ;
 ;  get line count segment if required by transaction code
 I "BAL"[V2 S LINECNT=$$LINECNT(COUNT,V3)
 ;
 ;  put control headers on code sheets and transmit
 S $P(CONTROL,"^",9)=$E("000",$L(SEQUENCE)+1,3)_SEQUENCE
 F COUNT=1:1:SEQUENCE Q:'$D(^TMP($J,"PRCPSMC0",COUNT))  D
 .   ;
 .   ;  set control header to current sequence number (stored in count)
 .   S $P(CONTROL,"^",8)=$E("000",$L(COUNT)+1,3)_COUNT,^TMP($J,"PRCPSMC0",COUNT,1,0)=CONTROL_$S(COUNT=1&($D(LINECNT)):LINECNT,1:"")
 .   ;
 .   ;  create and transmit mail message
 .   D MAILMSG(COUNT,SEQUENCE,V2,V4)
 .   S PRCPXMZ(COUNT)=+$G(XMZ)
 K ^TMP($J,"PRCPSMC0")
 Q
 ;
 ;
CONTROL(V1,V2,V3,V4,V5) ;  build control segment
 ;  v1=station number
 ;  v2=transaction code
 ;  v3=reference number
 ;  v4=receiving station number
 ;  v5=transaction intreface version number
 ;  returns control segment string
 N %,%H,%I,DATE,NOW,TIME,VERSION,X,Y
 D NOW^%DTC S NOW=%,TIME=$E($P(%,".",2)_"000000",1,6),X1=$P(NOW,"."),X2=$E(NOW,1,3)_"0101" D ^%DTC S X=X+1,X=$E("000",$L(X)+1,3)_X,DATE=($E(NOW)+17)_$E(NOW,2,3)_X
 S VERSION=$S($G(V5)>0:V5,1:40)
 S VERSION=$E("000",$L(VERSION)+1,3)_VERSION
 Q "ISM^"_$E("   ",$L(V1)+1,3)_V1_"^"_$E("   ",$L(V4)+1,3)_V4_"^"_$E("   ",$L(V2)+1,3)_V2_"^"_DATE_"^"_TIME_"^"_V3_$E("                    ",$L(V3)+1,20)_"^001^001^"_VERSION_"^|"
 ;
 ;
LINECNT(V1,V2) ;line count segment
 ;  v1=line count
 ;  v2=reference number
 ;  returns line count segment
 Q "LC^"_V1_"^"_V2_"^|"
 ;
 ;
MAILMSG(V1,V2,V3,V4) ;create mail message
 ;  v1=sequence number
 ;  v2=total sequences
 ;  v3=transaction type
 ;  v4=1stQueue^2ndQueue^... (form ISM or ISM^EDP)
 ;  returns xmz message number
 N %,DA,DIC,GROUP,XCNP,XMDUZ,XMTEXT,XMY
 ;
 ;  set group variable to send messages to mail group
 S GROUP=0
 ;
 ;  build receiving queue and user array
 F %=1:1 Q:$P(V4,"^",%)=""  S XMY("XXX@Q-"_$P(V4,"^",%)_".VA.GOV")="" I $G(GROUP) S XMY("G."_$P(V4,"^",%))=""
 S DA=+$P($G(^PRCD(420.4,+$O(^PRCD(420.4,"B",V3,0)),0)),"^",4),%=0 F  S %=$O(^PRCF(423.9,DA,1,%)) Q:'%  S XMDUZ=+$G(^(%,0)) I XMDUZ S XMY(XMDUZ)=""
 S XMDUZ=DUZ,XMTEXT="^TMP($J,""PRCPSMC0"","_V1_",",XMSUB=V3_" TRANSACTION TO Q-"_$TR(V4,"^","/")_" (MSG "_V1_" OF "_V2_")"
 K XMZ D ^XMD Q
