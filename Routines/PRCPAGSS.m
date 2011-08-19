PRCPAGSS ;WISC/RFJ-scheduled autogen secondary order build         ;01 Dec 92
V ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ; entry point for supply station secondaries
SSS N PRCPSCHE
 S PRCPSCHE=1
 D BUILD
 Q
 ;
 ; entry point for non-supply station secondaries
NSS N PRCPSCHE
 S PRCPSCHE=2
 D BUILD
 Q
 ;
BUILD L +^TMP("PRCPSCHE",PRCPSCHE):0 I $T=0 QUIT  ; process already running
 N PRCP,PRCPDP,PRCPFONE,PRCPFNON,PRCPIP,PRCPSS,PRCPXMY
 N ITEM,XMB,XMDUZ,XMTEXT,XMY
 K ^TMP($J,"PRCPAGSS")
 S PRCPIP=0
 I +$O(^PRCP(445,0))'>0 G QUIT
 F  S PRCPIP=$O(^PRCP(445,PRCPIP)) G BACKORD:+PRCPIP'>0  D
 . I '$D(^PRCP(445,PRCPIP,0)) QUIT
 . I $P($G(^PRCP(445,PRCPIP,0)),"^",3)'="S" QUIT
 . I $P($G(^PRCP(445,PRCPIP,0)),"^",1)["***INACTIVE_" QUIT
 . S PRCPSS=$P($G(^PRCP(445,PRCPIP,5)),"^",1)
 . I PRCPSS]"",PRCPSCHE'=1 QUIT
 . I PRCPSS']"",PRCPSCHE'=2 QUIT
 . S PRCPDP=$$FROMCHEK^PRCPUDPT(PRCPIP,0)
 . I $G(PRCPFNON)!'$G(PRCPFONE) QUIT  ; secondary must have only 1 supplier
 . S PRCP("I")=PRCPIP
 . K ^TMP($J,"PRCPAG")
 . S ^TMP($J,"PRCPAG","V",PRCPDP)=$$INVNAME^PRCPUX1(PRCPDP)
 . D START^PRCPAGS1
 . I $P(PRCPSCHE,"^",2)']"" QUIT  ; successfully processed
 . I $P(PRCPSCHE,"^",2)'=4 D BLDLIST ; No order numbers left or FileMan can't generate record or nothing to be ordered
 . I $P(PRCPSCHE,"^",2)=4 S ^TMP($J,"PRCPAGSS",PRCPIP)="" ; IP in use
 . S PRCPSCHE=+PRCPSCHE ; remove error codes if set
 . QUIT
 ;
 ; process any IP's that were in use, if possible
BACKORD S PRCPIP=0
 I $O(^TMP($J,"PRCPAGSS",0))']"" G QUIT
 F  S PRCPIP=$O(^TMP($J,"PRCPAGSS",PRCPIP)) G QUIT:+PRCPIP'>0 D
 . I '$D(^PRCP(445,PRCPIP,0)) QUIT
 . S PRCPSS=$P($G(^PRCP(445,PRCPIP,5)),"^",1)
 . I PRCPSS]"",PRCPSCHE'=1 QUIT
 . I PRCPSS']"",PRCPSCHE'=2 QUIT
 . S PRCPDP=$$FROMCHEK^PRCPUDPT(PRCPIP,0)
 . I $G(PRCPFNON)!'$G(PRCPFONE) QUIT  ; secondary must have only 1 supplier
 . S PRCP("I")=PRCPIP
 . K ^TMP($J,"PRCPAG")
 . S ^TMP($J,"PRCPAG","V",PRCPDP)=$$INVNAME^PRCPUX1(PRCPDP)
 . D START^PRCPAGS1
 . I $P(PRCPSCHE,"^",2)']"" QUIT  ; successfully processed
 . D BLDLIST
 . S PRCPSCHE=+PRCPSCHE ; remove error codes if set
 . QUIT
 ;
BLDLIST D GETUSER^PRCPXTRM(PRCPIP) Q:'$O(PRCPXMY(""))  ; inventory point users
 S ITEM=0
 ; restrict to managers
 F  S ITEM=$O(PRCPXMY(ITEM)) Q:ITEM'>0  I PRCPXMY(ITEM)=1 S XMY(ITEM)=""
 K ^TMP($J,"PRCPAGSSM")
 I $P(PRCPSCHE,"^",2)=1 S ^TMP($J,"PRCPAGSSM",1,1,0)="There are no available order numbers.  Please delete or post orders."
 I $P(PRCPSCHE,"^",2)=2 S ^TMP($J,"PRCPAGSSM",1,1,0)="The system was unable to add a new order."
 I $P(PRCPSCHE,"^",2)=3 S ^TMP($J,"PRCPAGSSM",1,1,0)="No items needed to be ordered."
 I $P(PRCPSCHE,"^",2)=4 S ^TMP($J,"PRCPAGSSM",1,1,0)="The inventory point was in use."
 S ^TMP($J,"PRCPAGSSM",1,0)=1
SEND S XMTEXT="^TMP($J,""PRCPAGSSM"",1,"
 S XMB="PRCP_ORDER_NOT_GENERATED"
 S XMB(1)=$$INVNAME^PRCPUX1(PRCPIP)
 S XMDUZ="SCHEDULED ORDER BUILDER"
 D EN^XMB
 Q
 ;
QUIT L -^TMP("PRCPSCHE",PRCPSCHE)
 K ^TMP($J,"PRCPAG"),^TMP($J,"PRCPAGSSM")
 QUIT
