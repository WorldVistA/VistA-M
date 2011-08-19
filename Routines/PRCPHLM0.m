PRCPHLM0 ;WISC/CC - NOTIFY USERS OF HL7 TRANSACTION PROBLEMS; 4/00
V ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ERR(NUMBER,BULLETIN,SECID,PARAM,HLTXN,PRCPHL) ;
 ;
 ; NUMBER = error code
 ; BULLETIN = Specifies the bulletin to send to users
 ; SECID = ien of secondary inventory point
 ; PRARAM = array of values extracted from the HL7 transaction
 ; HLTXN = ien of ^HLMA and of ^HL(772)
 ; PRCPHL = array of HL7 segments in message (not always present)
 ;
 N ERR,LNCNT,ITEM,MES,PRCPXMY
 S ERR=NUMBER,LNCNT=0
 K ^TMP($J,"PRCPHL7")
 S MES="HL7 transaction #"_HLTXN_" has "
 F LNCNT=2,3 S ^TMP($J,"PRCPHL7",1,LNCNT,0)=" "
 I +ERR=1 D  ; bad message
 . I ERR="1A" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"missing or unexpected segments."
 . I ERR="1B" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"the wrong message type."
 . I ERR="1C" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"a bad order control code in ORC."
 . I ERR="1D" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"a bad order control code/activity."
 . I ERR="1E" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"bad values in the QRD fields."
 . I ERR="1F" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"an indication that the supply station could not respond."
 I +ERR=2 D  ; bad order number
 . I ERR="2A" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"an order not in GIP or primary is unknown."
 . I ERR="2A" S ^TMP($J,"PRCPHL7",1,2,0)="Please remove this order from the supply station."
 . I ERR="2B" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"activity on a posted order."
 . I ERR="2C" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"order activity rejected by GIP."
 . I ERR="2C" S ^TMP($J,"PRCPHL7",1,2,0)="All Posting activity for this order must be done on GIP."
 . I ERR="2D" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"no order number."
 I +ERR=3 D  ; bad secondary inventory point
 . I ERR="3A" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"an inventory point not in GIP."
 . I ERR="3B" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"an IP that is not a secondary."
 . I ERR="3C" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"a secondary IP not in the order."
 . I ERR="3D" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"an invalid site specified."
 . I ERR="3E" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"no station specified."
 . I ERR="3F" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"a non-supply station IP."
 I +ERR=4 D  ; bad quantity received
 . S ^TMP($J,"PRCPHL7",1,1,0)=MES_"an excessive quantity transacted."
 I +ERR=5 D  ; bad quantity remaining
 . S ^TMP($J,"PRCPHL7",1,1,0)=MES_"an excessive quantity remaining."
 I +ERR=6 D  ; bad item
 . I ERR="6A" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"an item not in the order."
 . I ERR="6B" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"an item not in the primary."
 . I ERR="6C" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"an item not in the secondary."
 . I ERR="6D" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"a non-supply station item."
 . I ERR="6E" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"an invalid item."
 . I ERR="6F" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"no item information."
 . I ERR="6G" S ^TMP($J,"PRCPHL7",1,1,0)=MES_"a case cart or instrument kit item."
 . S ^TMP($J,"PRCPHL7",1,2,0)="item# "_PARAM("ITEM")_" "_PARAM("NAME")
 ;
 I $P(HLTXN,".",3)=447 D  ; error encountered processing ^PRCP(447.1)
 . I BULLETIN="PRCP_BAD_ORDER" D
 . . I PARAM("TYPE")="FU" S ^TMP($J,"PRCPHL7",1,2,0)="Message indicating receipt of all ordered items was not processed."
 . . I PARAM("TYPE")'="FU",ERR'="6F" S ^TMP($J,"PRCPHL7",1,2,0)="Received "_PARAM("QTY")_" unit(s) of item# "_PARAM("ITEM")_" "_PARAM("NAME")
 . I BULLETIN="PRCP_BAD_ACTIVITY" D
 . . S ^TMP($J,"PRCPHL7",1,2,0)=PARAM("QTY")_" unit(s) of item# "_PARAM("ITEM")_" "_PARAM("NAME")
 . . I PARAM("ACTIVITY")="USGE" S I="taken for "_PARAM("RECIPIENT")
 . . I PARAM("ACTIVITY")="RTRN" S I="returned from "_PARAM("RECIPIENT")
 . . I PARAM("ACTIVITY")="DISP" S I="disposed of"
 . . I PARAM("ACTIVITY")="ADJD"!(PARAM("ACTIVITY")="DISP") S I="adjusted out of the inventory"
 . . I PARAM("ACTIVITY")="ADJI" S I="adjusted into the inventory"
 . . S ^TMP($J,"PRCPHL7",1,3,0)="was/were "_I_" by "_PARAM("USER")
 ;
 I +ERR>99 D  ; error encountered while building ^PRCP(447.1)
 . S ^TMP($J,"PRCPHL7",1,1,0)="GIP can't create a new record for HL7 transaction# "_HLTXN
 . S ^TMP($J,"PRCPHL7",1,2,0)="Contact your IRM if GIP continues to have trouble creating records."
 . I BULLETIN="PRCP_BAD_ORDER" D
 . . I PARAM("TYPE")="FU" S ^TMP($J,"PRCPHL7",1,3,0)="Message indicating receipt of all ordered items was not processed."
 . . I PARAM("TYPE")'="FU" S ^TMP($J,"PRCPHL7",1,3,0)="Received "_PARAM("QTY")_" unit(s) of item# "_PARAM("ITEM")_" "_PARAM("NAME")
 . . S ^TMP($J,"PRCPHL7",1,4,0)="Please adjust the GIP to show this information."
 . . S ^TMP($J,"PRCPHL7",1,5,0)=" "
 . I BULLETIN="PRCP_BAD_ACTIVITY" D
 . . S ^TMP($J,"PRCPHL7",1,3,0)=PARAM("QTY")_" unit(s) of item# "_PARAM("ITEM")_" "_PARAM("NAME")
 . . I PARAM("ACTIVITY")="USGE" S I="taken for "_PARAM("RECIPIENT")
 . . I PARAM("ACTIVITY")="RTRN" S I="returned from "_PARAM("RECIPIENT")
 . . I PARAM("ACTIVITY")="DISP" S I="disposed of"
 . . I PARAM("ACTIVITY")="ADJD"!(PARAM("ACTIVITY")="DISP") S I="adjusted out of the inventory"
 . . I PARAM("ACTIVITY")="ADJI" S I="adjusted into the inventory"
 . . S ^TMP($J,"PRCPHL7",1,4,0)="was/were "_I_" by "_PARAM("USER")
 . . S ^TMP($J,"PRCPHL7",1,5,0)="Please adjust the GIP to show this information."
 . . S ^TMP($J,"PRCPHL7",1,6,0)=" "
 . . S LNCNT=6
 S LNCNT=3,I=0
 I ERR>99 D
 .  I BULLETIN="PRCP_BAD_ACTIVITY" S LNCNT=6
 .  I BULLETIN="PRCP_BAD_ORDER" S LNCNT=5
 I $D(PRCPHL) F  S I=$O(PRCPHL(I)) Q:I']""  D
 . S LNCNT=LNCNT+1,^TMP($J,"PRCPHL7",1,LNCNT,0)=PRCPHL(I)
 I $D(PRCPHL),HLQUIT>0 F  X HLNEXT Q:HLQUIT'>0  D
 . S LNCNT=LNCNT+1,^TMP($J,"PRCPHL7",1,LNCNT,0)=HLNODE
 S ^TMP($J,"PRCPHL7",1,0)=LNCNT
 I SECID D BLDLIST I $O(XMY(0))]"" D SEND
 I 'SECID D
 . N SS
 . S SECID=0,SS=0
 . F  S SS=$O(^PRCP(445,"AI",SS)) Q:'+SS  D
 . . S SECID=$O(^PRCP(445,"AI",SS,SECID)) Q:'+SECID  D BLDLIST
 . I $O(XMY(0))]"" D SEND
 K ^TMP($J,"PRCPHL7")
 Q
 ;
 ; build array of message recipients
BLDLIST D GETUSER^PRCPXTRM(SECID) Q:'$O(PRCPXMY(""))  ; inventory point users
 S ITEM=0
 ; restrict to managers
 F  S ITEM=$O(PRCPXMY(ITEM)) Q:ITEM'>0  I PRCPXMY(ITEM)=1 S XMY(ITEM)=""
 Q
 ;
SEND S XMTEXT="^TMP($J,""PRCPHL7"",1,"
 S XMB=BULLETIN
 I XMB="PRCP_BAD_ORDER" D
 . S XMB(1)=PARAM("ORDER")
 . S XMB(2)=PARAM("SIPNAME")
 I XMB="PRCP_BAD_ACTIVITY" D
 . S XMB(1)=PARAM("SIPNAME")
 . S XMB(2)=PARAM("ITEM")
 . S XMB(3)=PARAM("ACTIVITY")
 I XMB="PRCP_BAD_QUERY" D
 . S XMB(1)=PARAM("SIPNAME")
 S XMDUZ="SUPPLY STATION INTERFACE"
 D EN^XMB
 Q
