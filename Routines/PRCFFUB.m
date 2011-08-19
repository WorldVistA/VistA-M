PRCFFUB ;WISC/SJG-OBLIGATION ERROR PROCESSING REBUILD ;7/24/00  23:12
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Routine to handle special processing for the rebuild/transmit for
 ; MO/SO cancellation documents.  
 ;
 ;  Subroutine EN sets the value of XRBLD =
 ; 1 if the selected transaction to be rebuilt is an MO.X, SO.X or AR.X
 ; 2 if the selected transaction is an MO.E, SO.E, AR.E associated with
 ; an amendment that generated cancellation transactions
EN ;
 N XFLAG
 Q:MODDOC=""  ; no batch number, this is not an amendment
 S XFLAG=$$GETTXNS^PRCFFERT(PO,PRCFA("AMEND#"),PRCFA("MP"))
 I $P(XFLAG,"^",5)'=1,$P(XFLAG,"^",1)="" QUIT  ; this amendment has no cancels associated with it (if SO.E exists, it was created via an amendment)
 S DESC=$G(GECSDATA(2100.1,GECSDATA,4,"E"))
 Q:DESC=""
 I DESC["Decrease"!(DESC["Cancellation") D
 . S XRBLD=1
 . K MSG W !
 . S MSG(1)="You are attempting to retransmit an FMS Document with a document action of 'X'."
 . S MSG(2)="An FMS document with a document action of 'X' will decrease this obligation"
 . S MSG(3)="to $0.00 or cancel this obligation from FMS.",MSG(3.5)=" "
 . S MSG(4)="Please use extreme caution with these documents!"
 . D EN^DDIOL(.MSG) W ! K MSG
 I DESC["Amendment" D
 . S XRBLD=2
 . I $P(XFLAG,"^",5)'=1 D  Q
 . . K MSG W !
 . . S MSG(1)="This document was created from a 'Replace PO Number' amendment.  Please"
 . . S MSG(2)="verify the 'X' action documents for "_$P(^PRC(442,$P(^PRC(442,+PO,23),"^",3),0),"^",1)_" have been accepted."
 . . I $P(PRCFA("GECS"),"^")="AR" S MSG(3)="If the SO original was not accepted, this AR will reject."
 . . D EN^DDIOL(.MSG) W ! K MSG
 . K MSG W !
 . S MSG(1)="Before proceeding with this rebuild, please ensure that the previous"
 . S MSG(2)="'X' action documents have been accepted in FMS.  Otherwise, this document"
 . S MSG(3)="will reject because an obligation already exists under this PAT number."
 . I $P(PRCFA("GECS"),"^")="AR" D
 . . S MSG(2)="'X' actions and SO original were accepted in FMS.  Otherwise, this AR"
 . . S MSG(3)="may reject or not accrue the correct version of the intended document."
 . D EN^DDIOL(.MSG) W ! K MSG
 QUIT
 ;
GO ; rebuild the selected transaction now
 S FMSSEC=$$SEC1^PRC0C(PRC("SITE"))
 S TYPE=PRCFA("TT")
 ;
GO0 I XRBLD=1 D 
 . S (PRCFA("MOD"),PRCFA("CANCEL"))="X^2^Cancellation Entry"
 . S FMSMOD=$P(PRCFA("MOD"),U)
 . S TAG=$E(DESC,1)
 . I TAG="D" S DESC="Decrease Obligation Amount of "_TYPE
 . I TAG="C" S DESC="Cancellation of "_TYPE
 . S DESC=DESC_" Obligation Document Rebuild/Transmit"
 ;
 I XRBLD=2 D
 . S PRCFA("MOD")="E^0^Original Entry (Amended)"
 . S PRCFA("CANCEL")="X^2^Cancellation Entry"
 . S TAG="A"
 . S DESC="Purchase Order Amendment Rebuild/Transmit"
 ;
 D REBUILD^GECSUFM1(GECSDATA,"I",FMSSEC,"Y",DESC)
 S GECSFMS("DA")=GECSDATA
 I TAG="D" D DEC^PRCFFU8 ; (decrease)
 I TAG="C" D CANC^PRCFFU8 ; (cancel)
 I TAG="A" D ^PRCFFM1M ; (original - amended)
 ;
GOUT KILL DESC,FMSSEC
 QUIT
 ;
LOOP ; Check for any 'X' docs -- this subroutine deleted by patch PRC*5*179
 ; routine could incorrectly label future amendments as cancel associated
 ;N LOOP,N0,FMSDOC S LOOP=0
 ;F  S LOOP=$O(^PRC(442,+PO,10,LOOP)) Q:LOOP'>0  D
 ;.S N0=^PRC(442,+PO,10,LOOP,0),FMSDOC=$P(N0,".",1,2)
 ;.I FMSDOC["X" S XFLAG=1
 ;.Q
 ;Q
