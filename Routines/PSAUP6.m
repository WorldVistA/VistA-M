PSAUP6 ;BIR/JMB-Upload and Process Prime Vendor Invoice Data - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3**; 10/24/97
 ;This routine looks in the DRUG file for a supply line item. It looks
 ;for a NDC with an "S" in front of the UPC. It then looks for a matching
 ;VSN. If it is found, the NDC becomes "S"_UPC.
 ;
UPC ;If there is no NDC, the VSN is not found, & there is a UPC, look
 ;for a supply item.
 S (PSACNT,PSACNT1,PSAFND,PSAFND1,PSAIEN50)=0,PSASUP="S"_$P($P(PSADATA,"^",26),"~")
 F  S PSAIEN50=+$O(^PSDRUG("C",PSASUP,PSAIEN50)) Q:'PSAIEN50  S PSASYN=0 F  S PSASYN=+$O(^PSDRUG("C",PSASUP,PSAIEN50,PSASYN)) Q:'PSASYN  D
 .Q:'$D(^PSDRUG(PSAIEN50,1,PSASYN,0))
 .;DAVE B (PSA*3*3)
 .Q:$D(^PSDRUG(PSAIEN50,"I"))
 .I $P(^PSDRUG(PSAIEN50,1,PSASYN,0),"^",4)=PSAVSN S PSAFND=PSAFND+1,PSAFND1=PSAIEN50_"^"_PSASYN Q
 .I $P(^PSDRUG(PSAIEN50,1,PSASYN,0),"^",4)'=PSAVSN S PSACNT=PSACNT+1,PSACNT1=PSAIEN50_"^"_PSASYN
 ;
 ;If VSN & UPC match, set ^XTMP
 I PSAFND=1 D  Q
 .S PSAIEN=$P(PSAFND1,"^"),$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6)=PSAIEN,PSASUB=$P(PSAFND1,"^",2),$P(^(PSALINE),"^",7)=PSASUB
 .S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)=PSAVSN,PSANDC=PSASUP,$P(^(PSALINE),"^",4)=PSANDC
 ;
 ;If >1 with same VSN & UPC, set # with same UPC & VSN in ^XTMP & flag
 I PSAFND>1 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",26)=$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",26)_"~"_PSAFND,PSAOK=0 Q
 ;
 ;If 1 UPC and ...
 I PSACNT=1 S PSAIEN=$P(PSACNT1,"^"),$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6)=PSAIEN,PSASUB=$P(PSACNT1,"^",2),$P(^(PSALINE),"^",7)=PSASUB D  Q
 .;VSN is null, accept as found & set ^XTMP
 .I $P(^PSDRUG(PSAIEN,1,PSASUB,0),"^",4)="" S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)=PSAVSN,PSANDC=PSASUP,$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=PSANDC Q
 .;Different VSN, set VSN in UPC piece in ^XTMP
 .S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",26)=$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",26)_"~~"_$P(^PSDRUG(PSAIEN,1,PSASUB,0),"^",5),PSAOK=0
 ;
 ;If >1 VSN with differnt NDC, set flag in NDC piece of ^XTMP
 I PSACNT>1 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",26)=$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",26)_"~"_PSACNT,PSAOK=0
 Q
