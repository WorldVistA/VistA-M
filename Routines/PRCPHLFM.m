PRCPHLFM ;WISC/CC/DWA-build HL7 messages for item maintenance ;11/5/03  22:34
V ;;5.1;IFCAP;**1,24,52,63**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
BLDSEG(ACTION,ITEM,SIP) ;
 ;
 ; ACTION (1st '^' piece) 1 if add, 2 if delete, 3 if update
 ;        (2nd '^' piece) flag indicating txn MUST be built 
 ; ITEM   the number of the item affected
 ; SIP    the number of the secondary inventory point affected
 ;        0 (zero) for non-station specific edits (from PRCHE)
 ; MSG    0 to suppress messages, 1 to display them
 ;
 ; if this is a non-station specific edit (i.e. from PRCHE)
 ;
 N MSG,PUSH S MSG=1
 S PUSH=0
 I $P(ACTION,"^",2)=1 S PUSH=1
 I ACTION=3,SIP=0 D  QUIT
 . N SS,IME
 . S SS=0,IME=0 ; entry from PRCHE
 . F  S SS=$O(^PRCP(445.5,SS)) Q:'+SS  D
 . . ; send transaction to non-station specific SS housing the item
 . . I $P(^PRCP(445.5,SS,0),"^",2)="O",$O(^PRCP(445,"AH",ITEM,SS,""))>0 D GO
 ;
 N IME,SS
 I $P(^PRCP(445,SIP,0),"^",3)'="S" QUIT
 I '$D(^PRCP(445,SIP,1,ITEM)),ACTION'=2 QUIT
 S SS=$P($G(^PRCP(445,SIP,5)),"^",1) I SS']"" QUIT
 S IME=0
 ;
GO N %,%H,%I,CNT,DATETIME,HLA,HLCS,HLEVN,HLFS,ITEMDATA,MC,NM,OUT,PRIM,SEG,X
 N MYRESULT,MYOPTNS
 I SIP>0,'+$P($G(^PRCP(445,SIP,1,ITEM,0)),"^",9),ACTION'=2 QUIT  ; only deletes are valid for items with no normal
 S CNT=0,OUT=0
 ; if the supply station doesn't handle station specific data
 I SS>0,$P(^PRCP(445.5,SS,0),"^",2)="O",'PUSH D  I OUT QUIT
 . ; I ACTION=3 S OUT=1 QUIT  ; quit if editing station specific data
 . ; for add, quit if item is already on an IP in the SS 
 . I ACTION=1 D
 . . N A,B
 . . S A=0
 . . S A=$O(^PRCP(445,"AH",ITEM,SS,"")) I +A'>0 S OUT=1 QUIT  ; should have one
 . . I A'=SIP S OUT=1 QUIT  ; item on a different IP in the SS
 . . I A=SIP S B=$O(^PRCP(445,"AH",ITEM,SS,A)) I +B>0 S OUT=1 QUIT
 . I ACTION=2 D  I OUT=1 QUIT
 . . N A,B
 . . S A=0
 . . S A=$O(^PRCP(445,"AH",ITEM,SS,"")) I +A'>0 QUIT  ; should find one
 . . I A'=SIP S OUT=1 QUIT  ; item is on a different IP in the SS, don't delete from system
 . . I A=SIP S B=$O(^PRCP(445,"AH",ITEM,SS,A)) I +B>0 S OUT=1 QUIT  ; item exists on another IP in the SS, don't delete from system
 . ; S SIP=0 ; flag to indicate revisions are not station specific
 ;
 ; set up environment for message
1 D INIT^HLFNC2("PRCP EV ITEM UPDATE",.HL)
 I $G(HL) D:'IME&MSG  Q  ; error occurred
 . D EN^DDIOL("The HL7 transaction cannot be built now.")
 . I ACTION=1,MSG D EN^DDIOL("You will need to add this item directly to the supply station.")
 . I ACTION=2,MSG D EN^DDIOL("You will need to delete this item from your supply station.")
 . I ACTION=3,MSG D EN^DDIOL("You must edit the item again later to update the supply station.")
 . D EN^DDIOL("Error: "_$P(HL,"^",2))
 S HLFS=$G(HL("FS")) I HLFS="" S HLFS="|"
 S HLCS=$E(HL("ECH"),1)
 ;
 I MSG D EN^DDIOL("Building HL7 "_($P("ADD,DELETE,EDIT",",",ACTION))_" Transaction on item#"_ITEM_" for "_$P(^PRCP(445.5,SS,0),"^",1))
 I MSG,SIP>0 D EN^DDIOL(" station "_$P(^PRCP(445,SIP,0),"^",1))
 ;
 ; create MFI segment
2 D NOW^%DTC S DATETIME=$P(%+17000000,".",1)_$P(%,".",2)
 S SEG="MFI"_HL("FS")
 S SEG=SEG_($S(SIP>0:445,1:441))_HL("FS")_HL("FS")
 S HLA("HLS",1)=SEG_"UPD"_HL("FS")_DATETIME_HL("FS")_HL("FS")_"NE"
 ;
 ; create MFE segment
 S SEG="MFE"_HL("FS")
 I ACTION=1 S SEG=SEG_"MAD"
 I ACTION=2 S SEG=SEG_"MDL"
 I ACTION=3 S SEG=SEG_"MUP"
 S SEG=SEG_HL("FS")_HL("FS")_HL("FS")
 S HLA("HLS",2)=SEG_ITEM_"~"_$P(^PRC(441,ITEM,0),"^",2)
 ;
 I SIP'>0 G 3 ; Z segment for station specific items only
 ;
 S ITEMDATA=""
 S ITEMDATA=^PRCP(445,SIP,1,ITEM,0)
 S PRIM=$P(ITEMDATA,"^",12) I PRIM']"" D
 . S PRIM=$O(^PRCP(445,"AB",SIP,""))
 . I PRIM]"" S PRIM=PRIM_";PRCP(445,"
 S NM=$P($G(^PRCP(445,SIP,1,ITEM,6)),"^",1)
 I NM']"",+PRIM>0 S NM=$P($G(^PRCP(445,+PRIM,1,ITEM,6)),"^",1)
 I NM']"" S NM=$P(^PRC(441,ITEM,0),"^",2)
 ;
 ; create Z segment
 S SEG="ZIM"_HL("FS")_ITEM_"~"_NM ; item# and description
 S SEG=SEG_HL("FS")_"~"_$P(^PRCP(445,SIP,0),"^",1) ; full station name
 S SEG=SEG_HL("FS")_$P(ITEMDATA,"^",9) ; normal level
 S SEG=SEG_HL("FS")_$P(ITEMDATA,"^",10) ; std reord pt
 S SEG=SEG_HL("FS")_$P(ITEMDATA,"^",11)_HL("FS") ; emergency
 I $P(ITEMDATA,"^",5)]"" S SEG=SEG_$P($G(^PRCD(420.5,$P(ITEMDATA,"^",5),0)),"^",1) ; unit of issue
 I PRIM]"" S X=$$GETVEN^PRCPUVEN(SIP,ITEM,PRIM,1)
 S X=$P(X,"^",4) I X']"" S X=1
 S SEG=SEG_HL("FS")_X ; pkg multiple (conversion factor)
 S HLA("HLS",3)=SEG_HL("FS")_$P(ITEMDATA,"^",15) ; last cost
 ;
 ;call HL7 to transmit message
3 S HLL("LINKS",1)="PRCP SU ITEM UPDATE"_"^"_$P(^PRCP(445.5,SS,0),"^",3)
 D GENERATE^HLMA("PRCP EV ITEM UPDATE","LM",1,.MYRESULT,"",.MYOPTNS)
 I MSG,$P(MYRESULT,"^",2,3)]"" D
 . ; error handler for message send failures
 . D EN^DDIOL("ERROR: "_MYRESULT)
 Q
 ;
 ; send all items in IP to supply station
INIT D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="P" W !," This option may only be invoked from the Primary"
 N ACTION,DIR,DTOUT,DUOUT,INVPT,ITEM,PRCPINPT,Y
INIT0 S INVPT=$$INVPT^PRCPUINV(PRC("SITE"),"S","","","") Q:'INVPT
 I $P($G(^PRCP(445,INVPT,5)),"^",1)']"" W !,"This option may only be run for supply station secondary inventory points." G INIT0
 ;
 ; ask initialize or update supply station items?
 S DIR("A",1)="This option sends information about ALL items with a normal stock"
 S DIR("A",2)="level greater than zero to the linked supply station. "
 S DIR("A",3)="You must flag the transactions as 'ADD' or 'EDIT'."
 S DIR("A",4)=""
 S DIR("A")="Select 'Add' OR 'Edit' transactions"
 S DIR(0)="SB^A:ADD;E:EDIT"
 D ^DIR
 I $D(DUOUT)!($D(DTOUT))!(Y']"") QUIT
 S ACTION=3 ; default to edit
 I Y="A" S ACTION=1
 ;
 S ITEM=0 F  S ITEM=$O(^PRCP(445,INVPT,1,ITEM)) Q:'+ITEM  D
 . I '$D(^PRCP(445,INVPT,1,ITEM,0)) QUIT
 . I +$P($G(^PRCP(445,INVPT,1,ITEM,0)),"^",9)=0 QUIT
 . D BLDSEG^PRCPHLFM(ACTION,ITEM,INVPT)
 . Q
 Q
