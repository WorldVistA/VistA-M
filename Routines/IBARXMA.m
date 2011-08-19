IBARXMA ;LL/ELZ - PHARMCAY COPAY BACKGROUND PROCESSES ;19-JAN-2001
 ;;2.0;INTEGRATED BILLING;**150,158**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
FILER(IBA) ; This label is called by the IB background filer to
 ; notify other facilities that a transaction has occurred on the current
 ; facility.  It will then update the status in 354.71 assuming that the
 ; transaction was accepted at all the subscribing facilities.
 ; 
 ; IBA would be the IEN of file 350 to process.
 ;
 N IBZ,IBY,Y,IBER
 ;
 S IBZ=$P($G(^IB(+IBA,0)),"^",19) I 'IBZ Q
 S $P(^IBAM(354.71,IBZ,0),"^",4)=+IBA  ; set reference back
 ;
 S IBY=1 D FOUND(.IBY,IBZ)
 ;
 I -1=+$G(IBY) S Y=IBY D ^IBAERR
 ;
 Q
 ;
FOUND(IBY,IBZ) ; come in here to do the work
 ;
 ; ien in 354.71 stored in IBZ, assumes DFN is defined
 ;
 N IBTFL,IBX,IBT,X,Y,DIE,DA,DR,DIC,IBS
 ;
 ; get treating facility list
 S IBTFL=$$TFL^IBARXMU(DFN,.IBTFL)
 ;
 ; no other facilities, i'm done
 I 'IBTFL D STATUS(.IBY,IBZ,0) Q
 ;
 ; ok lets do some talking to other VA's
 S IBX=0 F  S IBX=$O(IBTFL(IBX)) Q:IBX<1!(IBY<1)  D
 . ;
 . ; have I already completed transmission here?
 . S IBS=$$LKUP^XUAF4(IBX) I IBS>0,$P($G(^IBAM(354.71,IBZ,1,+$O(^IBAM(354.71,IBZ,1,"B",+IBS,0)),0)),"^",2),'$G(IBONE) Q
 . ;
 . I '$D(ZTQUEUED) U IO W !,"Now transmitting to ",$P(IBTFL(IBX),"^",2)," ..."
 . S IBT=$$SEND^IBARXMU(DFN,IBX,^IBAM(354.71,IBZ,0))
 . ;
 . ; update 354.71 transmission record
 . S DA=$O(^IBAM(354.71,IBZ,1,"B",IBS,0)),DA(1)=IBZ
 . ;
 . ; save of error(s) for message
 . S:IBT<1 IBER(IBX)=IBT
 . ;
 . I DA D  Q
 .. S DIE="^IBAM(354.71,"_IBZ_",1,",DR=".02////"_$S(+IBT>0:1,1:0)
 .. L +^IBAM(354.71,IBZ,1,DA):10 I '$T S IBY="-1^IB318" Q
 .. D ^DIE L -^IBAM(354.71,IBZ,1,DA)
 . S DIC="^IBAM(354.71,"_IBZ_",1,",DIC(0)="",X=IBS
 . S DIC("DR")=".02////"_$S(IBT>0:1,1:0) D FILE^DICN
 ;
 D STATUS(.IBY,IBZ,IBTFL):IBY>0
 ;
 Q
 ;
NIGHT ; queue off job to do nightly processing
 N IOP,ZTIO,ZTSAVE,ZTRTN,ZTDESC,ZTASK,%ZIS,ZTDTH
 S ZTIO="",ZTRTN="NIGHTQ^IBARXMA",ZTDTH=$H,ZTDESC="RX Copay Cap Follow-up Transmissions"
 D ^%ZTLOAD
 Q
 ;
NIGHTQ ; called from nightly background job for transmissions
 ;
 N IBX,IBS,X
 ;
 F IBS="P","Y" S IBX=0 F  S IBX=$O(^IBAM(354.71,"AC",IBS,IBX)) Q:IBX<1  D
 . N IBY,IBZ,IBM,XMZ,XMY,XMDUZ,XMSUB,IBL,IBF,IBT,DFN,IBA,IBN,IBER S IBY=1
 . ;
 . S DFN=$P($G(^IBAM(354.71,+IBX,0)),"^",2) Q:'DFN
 . S IBY=1 D FOUND(.IBY,IBX)
 . ;
 . ; if it is successful, quit and move on to next one
 . S IBZ=^IBAM(354.71,IBX,0)
 . I IBY>0,($P(IBZ,"^",5)="C"!($P(IBZ,"^",5)="X")) Q
 . ;
 . ; is the transaction < 2 days old, quit
 . I $$FMADD^XLFDT($P(IBZ,"^",15),2)>DT Q
 . ;
 . ; send message to mail group of old transaction notification
 . D DEM^VADPT
 . S XMSUB="Rx Copay Transmission Error",XMDUZ="INTEGRATED BILLING PACKAGE" D XMZ^XMA2 I XMZ<1 Q
 . S IBL=0
 . D M("A medication co-payment transaction could not be sent to one or more of"),M("the patient's treating facilities for at least 2 days.  After verifying that")
 . D M("the HL7 Logical Links are working correctly to the sites listed below, you"),M("can use the option 'Push Rx Copay Cap Transactions' to transmit this")
 . D M("transaction immediately or the IB software will try to transmit this"),M("transaction when the IB MT NIGHT COMP job runs.")
 . D M(" "),M("    Patient: "_VADM(1)),M("        SSN: "_VA("PID")),M("Transaction: "_$P(IBZ,"^")),M(" ")
 . D M("Facility                               Status"),M("-----------------------------------    --------------------")
 . S IBF=0 F  S IBF=$O(^IBAM(354.71,IBX,1,IBF)) Q:IBF<1  S IBT=^IBAM(354.71,IBX,1,IBF,0),IBN=$$FAC^IBARXMU(+IBT),IBN=$P(IBN,"^")_" ("_$P(IBN,"^",2)_")" D
 .. D M($$SP(IBN,39)_$$EXTERNAL^DILFD(354.711,.02,"",$P(IBT,"^",2)))
 . ;
 . ; include errors in message
 . I $D(IBER) D M(" "),M("Errors:") S X=0 F  S X=$O(IBER(X)) Q:X<1  D M(X_" = "_IBER(X))
 . ;
 . S ^XMB(3.9,XMZ,2,0)="^3.92^"_IBL_"^"_IBL_"^"_DT
 . S XMY("G.IB RX COPAY CAP ERROR")=""
 . D ENT1^XMD
 Q
 ;
SP(X,Y) ; makes X be Y space long
 F  Q:$L(X)>(Y-1)  S X=X_" "
 Q $E(X,1,Y)
 ;
STATUS(IBY,IBZ,IBT) ; update status in 354.71 if applicable
 ; IBY is return error if applicable
 ; IBZ is the entry number in 354.71
 ; IBT indicates number of treating facilities
 ;
 N IBS,IBX,DA,DIE,DR,X,Y,IBD
 ;
 S IBS=1,IBX=0 I IBT F  S IBX=$O(^IBAM(354.71,IBZ,1,IBX)) Q:IBX<1  S:$P(^IBAM(354.71,IBZ,1,IBX,0),"^",2)'=1 IBS=0
 ;
 I IBS S IBD=$P(^IBAM(354.71,IBZ,0),"^",5) D
 . S DIE="^IBAM(354.71,",DA=IBZ
 . S DR=".05///"_$S(IBD="Y":"X",IBD="X":IBD,1:"C")
 . L +^IBAM(354.71,IBZ):10 I '$T S IBY="-1^IB318" Q
 . D ^DIE L -^IBAM(354.71,IBZ)
 ;
 I $G(IBY)<1 S IBY=1 ; success flag
 ;
 Q
M(T) ; used to set text in mail message
 ; assumes XMZ and IBL
 S IBL=IBL+1,^XMB(3.9,XMZ,2,IBL,0)=T
