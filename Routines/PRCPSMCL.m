PRCPSMCL ;WISC/RFJ-create and transmit log code sheet from tmp      ;22 Mar 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
TRANSMIT(V1,V2,V3) ;transmit code sheets from tmp global
 ;  v1=station number
 ;  v2=transaction type
 ;  v3=1stQueue^2ndQueue^... (form LOG)
 ;  tmp($j,"string",1:n)=code sheet data
 ;  returns prcpxmz(sequence number)=mailman message number
 ;
 N %,COUNT,CSHEET,DATA,LINE,PRCPSITE,SEQUENCE,XMZ
 ;
 K ^TMP($J,"PRCPSMC0"),PRCPXMZ S PRCPSITE=+V1
 ;
 ;  move code sheets to message number in tmp global
 S SEQUENCE=1,LINE=1,(COUNT,CSHEET)=0 F  S CSHEET=$O(^TMP($J,"STRING",CSHEET)) Q:'CSHEET  S DATA=^(CSHEET),COUNT=COUNT+1 D
 .   ;
 .   ;  build message in tmp
 .   S ^TMP($J,"PRCPSMC0",SEQUENCE,LINE,0)=DATA,LINE=LINE+1
 .   ;
 .   ;  increment counters if line equals 100 (code sheets)
 .   I $O(^TMP($J,"STRING",CSHEET)),LINE=100 S SEQUENCE=SEQUENCE+1,LINE=1
 ;
 ;  transmit
 F COUNT=1:1:SEQUENCE Q:'$D(^TMP($J,"PRCPSMC0",COUNT))  D
 .   ;
 .   ;  create and transmit mail message
 .   D MAILMSG^PRCPSMCS(COUNT,SEQUENCE,V2,V3)
 .   S PRCPXMZ(COUNT)=+$G(XMZ)
 .   ;I $G(XMZ) S %=$O(^PRC(411,PRCPSITE,2,"AC","S","")) I %'="" D PRINT(XMZ,%)
 K ^TMP($J,"PRCPSMC0")
 Q
 ;
 ;
PRINT(V1,V2) ;  forward mailman message to printer devive
 ;  v1=mailman message number
 ;  v2=printer device ^ printer device ^ ...
 N C,DIC,ER,X,XMDT,XMDUZ,XMY,XMZ,ZTPAR
 S XMZ=+V1,XMDUZ=DUZ
 F %=1:1 Q:$P(V2,"^",%)=""  S XMY("D."_$P(V2,"^",%)_"@"_$G(^XMB("NETNAME")))=""
 D ENT1^XMD Q
