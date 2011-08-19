PRCPHLSO ;WISC/CC/DWA-build HL7 messages for distribution order ;4/00
V ;;5.1;IFCAP;**1,52**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
BLDSEG(ORDRDA) ;
 N %,%H,%I,CNT,DATETIME,HLA,HLCS,HLEVN,HLFS,INVPT,ITEM,ITEMDA,ITEMNM
 N MC,MYOPTION,MYRESULT,ORDRDATA,PRIM,PRIMVN,SEG,X
 S CNT=0
 ;
 ;set up environment for message
1 D INIT^HLFNC2("PRCP EV REL ORDER",.HL)
 I $G(HL) D  Q  ; error occurred
 . W !,"The system can't build an HL7 message now to send your order to"
 . W !,"the supply station.  Please use the 'SO - Send Order' option later."
 . W !,"Error: "_$P(HL,"^",2)
 S HLFS=$G(HL("FS")) I HLFS="" S HLFS="|"
 S HLCS=$E(HL("ECH"),1)
 ;
 D NOW^%DTC S DATETIME=(17000000+$P(%,".",1))_$P(%,".",2)
 ; Add message txt to HLA array
 ; loop through each item in the order
 K ^TMP("HLS",$J)
 S ORDRDATA=^PRCP(445.3,ORDRDA,0)
 S INVPT=$P(ORDRDATA,"^",3) ; secondary inventory point
 S PRIM=$P(ORDRDATA,"^",2) ; primary IP
 S PRIMVN=PRIM_";PRCP(445,"
 S ITEM=0,CNT=0,USERNAME=""
 F  S ITEM=$O(^PRCP(445.3,ORDRDA,1,ITEM)) Q:'+ITEM  D
 . S CNT=CNT+1
 . ;
 . ; create ORC segment
 . S SEG="ORC"_HL("FS")_"RF" ; RF = order class
 . S SEG=SEG_HL("FS")_$P(ORDRDATA,"^",1) ; order number
 . S SEG=SEG_HL("FS")_HL("FS")
 . S SEG=SEG_"~"_$P(^PRCP(445,INVPT,0),"^",1) ; secondary inventory point
 . S SEG=SEG_HL("FS")_HL("FS")_HL("FS")_HL("FS")_HL("FS")
 . S SEG=SEG_DATETIME_HL("FS")
 . ; don't send name if vendor doesn't need it
 . S ^TMP("HLS",$J,CNT)=SEG_USERNAME
 . ;
 . ; create RQD Segment
 . S ITEMNM=$P($G(^PRCP(445,INVPT,1,ITEM,6)),"^",1)
 . I ITEMNM']"" D  ; if no item name, pull from primary or item master
 . . S X=$P(^PRCP(445.5,$P(^PRCP(445,INVPT,5),"^",1),0),"^",2)
 . . I X="S" S ITEMNM=$P($G(^PRCP(445,PRIM,1,ITEM,6)),"^",1)
 . . I X="O" S ITEMNM=$P($G(^PRC(441,ITEM,0)),"^",2)
 . S CNT=CNT+1
 . S SEG="RQD"_HL("FS")_HL("FS")_HL("FS")_HL("FS")
 . S SEG=SEG_ITEM_"~"_ITEMNM
 . S SEG=SEG_HL("FS")_$P(^PRCP(445.3,ORDRDA,1,ITEM,0),"^",2) ;qty
 . S SEG=SEG_HL("FS")
 . S ITEMDA=$P($G(^PRCP(445,PRIM,1,ITEM,0)),"^",5) ; primary unit of issue
 . I ITEMDA]"" S SEG=SEG_$P($G(^PRCD(420.5,ITEMDA,0)),"^",1) ; unit of issue
 . I ITEMDA']"" S SEG=SEG_"EA" ; GIP unit of issue default
 . S ^TMP("HLS",$J,CNT)=SEG
 . ;
 . ;NTE (to send conversion factor)
 . S CNT=CNT+1
 . S SEG="NTE"_HL("FS")_1_HL("FS")_"RQD"_HL("FS")
 . I PRIMVN]"" S X=$$GETVEN^PRCPUVEN(INVPT,ITEM,PRIMVN,1)
 . S SEG=SEG_$P(X,"^",4) ; pkg multiple (conversion factor)
 . S ITEMDA=$P($G(^PRCP(445,INVPT,1,ITEM,0)),"^",5) ; secondary unit of issue
 . I ITEMDA]"" S SEG=SEG_"~"_$P($G(^PRCD(420.5,ITEMDA,0)),"^",1) ; SECONDARY ISSUE UNIT
 . I ITEMDA']"" S SEG=SEG_"EA" ; GIP unit of issue default
 . S ^TMP("HLS",$J,CNT)=SEG
 ;
 ;notify user that message will be sent
 W !,"ORDER INFORMATION WILL BE TRANSMITTED TO THE SUPPLY STATION."
 ;
 ;call HL7 to transmit message
3 S HLL("LINKS",1)="PRCP SU REL ORDER"_"^"_$P(^PRCP(445.5,$P(^PRCP(445,INVPT,5),"^",1),0),"^",3)
 D GENERATE^HLMA("PRCP EV REL ORDER","GM",1,.MYRESULT,"",.MYOPTION)
 I $P(MYRESULT,"^",2,3)]"" D
 . ; error handler for message send failures
 . W !,"ERROR: ",MYRESULT
 Q
