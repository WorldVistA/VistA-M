VIAASQH ;ALB/CR - RTLS Set Quantity on-hand in GIP ;4/20/16 10:12 pm
 ;;1.0;RTLS;**4**;April 22, 2013;Build 21
 ;
 ; Access to file #441 covered by IA #5921
 ; Access to file #445 covered by IA #5923
 ; Get unique handle ID string for ^XTMP covered by IA #4770
 ; Call to $$UPDATE^PRCPUSA covered by IA #10085
 Q
 ;
 ; -- set quantity on-hand with feed from WaveMark. The
 ; transaction can be either a usage ('U'), or a physical count
 ; ('P').
 ; -- Input required:
 ; inventory point name
 ; item master #
 ; quantity to update quantity on-hand in file #445
 ; flag to indicate transaction type: 'U' or 'P' only
 ; -- Output:
 ; stored in ^XTMP("VIAASQH",$J,0) and passed forward via RETSTA;
 ; contains a short message to indicate success. For a failure,
 ; the following format is used:
 ; "-###^"_failure_message, where '###' is a 3-digit http status
 ; code.
 ;
 ;            ********* NOTICE ************
 ; -----------------------------------------------------------------
 ; the user 'VIAASSERVICE,RTLS APPLICATION PROXY' must be added to the
 ; inventory point for the Cathlab before any of the transactions 
 ; below can be executed properly in GIP
 ; -----------------------------------------------------------------
 ;
QOH(RETSTA,IPNAME,ITEM,QTY,QOHFLAG) ;
 ; RPC [VIAA SET QUANTITY ON HAND]
 ;
 N A,ITEMIEN,IPIEN,TIMDATE,VIAA,PRCPBALM,%,X,Y ;  variables PRCPBALM,% used in IFCAP/GIP
 ; clean up ^TMP of old data and ^XTMP if found
 S A="" F  S A=$O(^TMP(A)) Q:A=""  I $E(A,1,7)["VIAASQH" K ^TMP(A),^XTMP(A)
 ;
 S VIAA=$$HANDLE^XUSRB4("VIAASQH") ; get handle, prepare for entry in ^XTMP
 S $P(^XTMP(VIAA,0),U,3)="Quantity On-Hand Set up for GIP"
 S X=DT D NOW^%DTC,YX^%DTC S TIMDATE=Y  ; current date/time
 S ^TMP(VIAA,"Received_Data_From_WaveMark",TIMDATE)=IPNAME_U_ITEM_U_QTY_U_QOHFLAG
 I $G(IPNAME)="" S ^XTMP(VIAA,$J,0)="-400^Inventory Point name cannot be null" D EXIT Q
 I '$O(^PRCP(445,"B",IPNAME,"")) S ^XTMP(VIAA,$J,0)="-404^"_IPNAME_" is not a legal Inventory Point" D EXIT Q
 S IPIEN=$O(^PRCP(445,"B",IPNAME,""))
 ;
 I +ITEM'=ITEM S ^XTMP(VIAA,$J,0)="-400^Item Master # received is not legal" D EXIT Q
 I $G(ITEM)="" S ^XTMP(VIAA,$J,0)="-400^Item Master # cannot be null" D EXIT Q
 I +ITEM=0 S ^XTMP(VIAA,$J,0)="-400^Item Master # cannot be zero" D EXIT Q
 S ITEMIEN=+$O(^PRC(441,"B",ITEM,""))
 I ITEMIEN'=ITEM S ^XTMP(VIAA,$J,0)="-400^Item "_ITEM_" does not exist in the Item Master File" D EXIT Q
 I '$D(^PRCP(445,"AE",ITEM,IPIEN,ITEM)) S ^XTMP(VIAA,$J,0)="-404^Item Master #"_ITEM_" is not in Inventory Point "_IPNAME D EXIT Q
 ;
 I $G(QTY)="" S ^XTMP(VIAA,$J,0)="-400^Invalid quantity on-hand received - cannot be null" D EXIT Q
 I QTY<0 S ^XTMP(VIAA,$J,0)="-400^Invalid quantity on-hand "_QTY_" received - cannot be negative" D EXIT Q
 I "^U^P^"'[(U_QOHFLAG_U) S ^XTMP(VIAA,$J,0)="-400^'"_QOHFLAG_"' is an invalid transaction flag. Only 'U' or 'P' are allowed" D EXIT Q
 ;
 ; -- set up variables for GIP call
 ; for usage WaveMark will only send a quantity greater than zero to VistA
 S X=DT D NOW^%DTC,YX^%DTC S TIMDATE=Y  ; current date/time
 ; prepare to save result of processing in VistA and pass results to client
 ;
 I $G(QOHFLAG)="U" D  S:$G(%)="" ^XTMP(VIAA,$J,0)="1^Usage transaction in GIP completed for Item Mater #"_ITEM_" on "_TIMDATE D EXIT Q
 . S PRCPBALM("I")=IPIEN,PRCPBALM("ITEM")=ITEM,PRCPBALM("QTY")=-QTY
 . S PRCPBALM("TYP")="U"
 . S PRCPBALM("COM")="WaveMark usage transaction"
 . L +^PRCP(445,IPIEN,1,ITEM,0):1 I '$T S ^XTMP(VIAA,$J,0)="-423^The resource that is being accessed is locked - cannot complete usage processing for Item Master #"_ITEM_", on "_TIMDATE D EXIT Q
 . S %=$$UPDATE^PRCPUSA(.PRCPBALM)  ; update quantity on-hand
 . L -^PRCP(445,IPIEN,1,ITEM,0)
 . I %'="" S ^TMP(VIAA,"Response from GIP")=%
 . I %'="" S ^XTMP(VIAA,$J,0)="-400^GIP Quantity On-Hand not updated - "_% D EXIT Q
 ;
 I $G(QOHFLAG)="P" D  S:$G(%)="" ^XTMP(VIAA,$J,0)="1^Physical Count transaction in GIP completed for Item Master #"_ITEM_" on "_TIMDATE
 . S PRCPBALM("I")=IPIEN,PRCPBALM("ITEM")=ITEM
 . S PRCPBALM("TYP")="P"
 . S PRCPBALM("COM")="WaveMark physical count transaction"
 . L +^PRCP(445,IPIEN,1,ITEM,0):1 I '$T S ^XTMP(VIAA,$J,0)="-423^The resource that is being accessed is locked - cannot complete physical count for Item Master #"_ITEM_", on "_TIMDATE D EXIT Q
 . S PRCPBALM("QTY")=QTY-$$GET1^DIQ(445.01,ITEM_","_IPIEN_",",7) ; update quantity on-hand
 . S %=$$UPDATE^PRCPUSA(.PRCPBALM)   ; update quantity on-hand
 . L -^PRCP(445,IPIEN,1,ITEM,0)
 . I %'="" S ^TMP(VIAA,"Response from GIP")=%
 . I %'="" S ^XTMP(VIAA,$J,0)="-400^GIP Quantity On-Hand not updated - "_% D EXIT Q
 ;
EXIT S RETSTA=$NA(^XTMP(VIAA,$J))
 ; save whatever we processed and answer sent to the calling app
 M ^TMP(VIAA,"Saved_Transaction_Header")=^XTMP(VIAA,0)
 M ^TMP(VIAA,"Saved_Transaction_Type: "_QOHFLAG)=^XTMP(VIAA,$J)
 L -^XTMP(VIAA) ; release lock for $$HANDLE^XUSRB4 call
 Q
