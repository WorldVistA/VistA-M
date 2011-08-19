IBCEU4 ;ALB/TMP - EDI UTILITIES ;02-OCT-96
 ;;2.0;INTEGRATED BILLING;**51,137,210,155,290,403**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
TESTFLD ;  Entrypoint to call to test the output the formatter will
 ;  produce for a specific entry in file 364.7
 ;
 N X,Y,DIC,IBCT
 K IBXDATA,IBXSAVE
 S IBCT=0
 F  W !,$S(IBCT:"Another ",1:""),"Bill: " S DIC="^DGCR(399,",DIC(0)="AEMQ" D ^DIC Q:Y<0  D
 . S IBCT=1
 . K ^TMP($J),^TMP("IBXSAVE",$J),^TMP("IBXDATA",$J),IBXSAVE,IBXDATA
 . D FLDS(+Y)
 . F  R !!,"VARIABLE TO DISPLAY (IBXDATA): ",X:DTIME Q:X["^"  S:X="" X="IBXDATA" D
 .. I $S($E(X,$L(X))'=")"&($L(X,"(")>1):1,1:$L(X,"(")'=$L(X,")")) W !,"BAD VARIABLE NAME" Q
 .. I '$D(@X) W "   *** NO DATA TO DISPLAY" Q
 .. N S S S=X
 .. W !,X," = ",$G(@X)
 .. F  S X=$Q(@X) Q:X'[S  W !,X," = ",@X
 .. W !
 Q
 ;
FLDS(IBIFN) ; Extract fields for bill IBIFN
 N X,Y,DIC,IB1,IBI,IBAR,IBXPG,IBXLN,IBXCOL,IBXREC,Z,Z0
 W !,"Remember to run this for flds that set up pre-requisite data (if any) first",!
 ;
 S IB1=1
 F  W !,$S('IB1:"Another ",1:""),"Form Field: " S DIC="^IBA(364.7,",DIC(0)="AEMQZ" D ^DIC Q:Y<0  D
 . S IB1=0
 . N IBZXX,IBXIEN
 . ; Execute data element logic for fld
 . S IBI=+Y,Z=$P($G(^IBA(364.5,+$P(Y(0),U,3),0)),U)
 . S Z0=$G(^IBA(364.6,+Y(0),0))
 . S IBAR=$G(^IBA(364.5,+$P(Y(0),U,3),2)) S:IBAR="" IBAR="IBXDATA"
 . S IBXPG=$P(Z0,U,4),IBXLN=$P(Z0,U,5),IBXCOL=$P(Z0,U,8),IBXREC=1
 . D F^IBCEF(Z,"IBZXX","",IBIFN)
 . Q:'$D(IBZXX)
 . K @IBAR
 . M @IBAR=IBZXX
 . I $G(^IBA(364.7,IBI,1))'="" S IBXIEN=IBIFN X ^IBA(364.7,IBI,1)
 . D CLEAN^DILF
 Q
 ;
DATE(X) ; Convert date in YYYYMMDD or YYMMDD format to MM DD YYYY or MM DD YY
 N Z
 S Z=X
 I $L(X)=8 S Z=$E(X,5,6)_" "_$E(X,7,8)_" "_$E(X,1,4)
 I $L(X)=6 S Z=$E(X,3,4)_" "_$E(X,5,6)_" "_$E(X,1,2)
 Q Z
 ;
MCRSPEC(IBIFN,MCR,IBPIEN) ; Returns specialty code for a provider on bill
 ; IBIFN = bill ien (file 399)
 ; MCR = 1 if 2-digit MCR code should be returned 0 or null=3 digit code
 ; IBPIEN = vp of the provider for which to get the
 ;   specialty, otherwise it returns specialty code for the 'required'
 ;   provider on bill (default is file 200 if no file designated)
 ;
 N IBZ,IBDT
 S IBZ="99" ;default if none found
 S IBDT=$P($G(^DGCR(399,+IBIFN,"U")),U,1)  ; use statement from date
 I '$G(IBPIEN) D F^IBCEF("N-SPECIALTY CODE","IBZ",,IBIFN)
 I $G(IBPIEN) S:$P(IBPIEN,";",2)="" IBPIEN=IBPIEN_";VA(200," S IBZ=$$SPEC^IBCEU(IBPIEN,IBDT)
 I '$G(MCR) S IBZ="0"_IBZ
 Q IBZ
 ;
ECODE(IBP,CD) ; Function returns 1 if procedure ien IBP is an E-code
 ; CD = returned = the external code, if passed by reference
 N Q
 S CD=$P($$ICD9^IBACSV(+IBP),U)
 Q ($E(CD)="E")
 ;
BOX82NM(IBIFN,IBZSAVE) ; Returns the data to be printed in form locators 82
 ; and 83 on the UB92 for bill ien IBIFN, based on the providers on the
 ; bill
 ; Pass array IBZSAVE by reference
 N Z,IBZ,IBCT
 ;
 D F^IBCEF("N-ALL PROVIDERS","IBZ",,IBIFN)
 F Z=1:1:6 S IBZSAVE("PRV-82",Z)=""
 ; Find Providers and store them (if found) in this order:
 ; Attending/Rendering, Operating, Referring, Other
 F Z=4,2,1,9 D
 . S IBCT=$S(Z=4:0,1:IBCT) Q:IBCT>4
 . I Z=4,$$FT^IBCEF(IBIFN)=2 S Z=3    ; Find rendering for HCFA 1500
 . I $S(Z=4!(Z=3):0,1:'$O(IBZ(Z,0))) Q
 . S IBCT=IBCT+1
 . I Z=4,$G(IBZ(4,1))="",$$FT^IBCEF(IBIFN)=3,'$D(^DGCR(399,IBIFN,"PRV")) S IBZ(Z,1)="DEPT OF VETERANS AFFAIRS" ;Default for old bills w/o prv
 . I $O(IBZ(Z,1,1)) S IBZSAVE("PRV-82",IBCT)=$G(IBZ(Z,1,2))_" "_$G(IBZ(Z,1,3))
 . S IBCT=IBCT+1,IBZSAVE("PRV-82",IBCT)=$P($G(IBZ(Z,1,1)),U)_" "_$P($G(IBZ(Z,1)),U)
 Q
 ;
STATOK(IBIFN,VALST) ; Returns 1 if status of bill IBIFN is one of the valid
 ;  status codes in VALST
 N OK,Z
 S OK=0
 I $G(VALST)'="" S OK=$L(VALST,$P($G(^DGCR(399,IBIFN,0)),U,13))>1
 Q OK
 ;
RXPRLOOK(IBX) ; Do a FM lookup of procedures for RX that can be linked
 ; to a specific revenue code (ones that are not already soft-linked)
 ; Function returns ien of the 'CP' node multiple for the selected proc
 ; OR  "" if none selected or selection is invalid
 ;
 ; IBX = the procedure code
 ;
 N IBZ,IBMAX,IBEACH,IBMANY,IBHLP,IBNEXT,Z
 S IBMAX=50,IBEACH=5,IBHLP=0
 K ^TMP("DILIST",$J),^TMP("DIERR",$J),^TMP("DIHELP",$J),^TMP("IBLIST",$J)
 ;
 S IBZ=IBX
 I IBX?1"?".E,'$D(DIQUIET) D
 . I IBX?2"?".E S IBMAX=50,IBEACH=20 D RXPRHLP(IBMAX,.IBNEXT) S IBHLP=1
 . S IBX=""
 . ;
 I IBX'="" D
 . S:$L(IBX)<5 IBX="`"_IBX
 . D FIND^DIC(399.0304,","_DA(1)_",","@;.01E","A",IBX,IBMAX,,"I '$$LINKED^IBCEU4(.DA,Y)")
 . D XFER(0)
 ;
 S IBMANY=($G(^TMP("IBLIST",$J,0))>1)
 I IBMANY D  ;More than one match found
 . I $D(DIQUIET) S ^TMP("IBLIST",$J,0)=0,IBX="" Q
 . N IB1,IB2,IBSEL,IBGOT,IBCNT,Q,Q1
 . S (IBGOT,IB1,IB2)=0
 . F  S IB1=$O(^TMP("IBLIST",$J,2,IB1)) Q:'IB1  D  Q:IBGOT
 .. S IB2=IB2+1
 .. S Q=$J("",5)_$S('IBHLP:$E(IB2_$J("",5),1,5),1:"")_^TMP("IBLIST",$J,2,IB1)
 .. F Q1=0:0 S Q1=$O(^TMP("IBLIST",$J,"ID",IB1,Q1)) Q:'Q1  D
 ... I $G(^TMP("IBLIST",$J,"ID",IB1,Q1))'="" S Q=Q_"  "_^TMP("IBLIST",$J,"ID",IB1,Q1) Q
 ... I $G(^TMP("IBLIST",$J,"ID",IB1,Q1,"E"))'="" S Q=Q_"  "_^TMP("IBLIST",$J,"ID",IB1,Q1,"E")
 .. S IBSEL($S(IB2#IBEACH:IB2#IBEACH,1:IBEACH))=Q
 .. I '$O(^TMP("IBLIST",$J,2,IB1))!'(IB1#IBEACH) D
 ... M DIR("A")=IBSEL K IBSEL
 ... I 'IBHLP D
 .... S:$O(^TMP("IBLIST",$J,2,IB1)) DIR("A",6)="Press <RETURN> to see more, '^' to exit this list, OR"
 .... S DIR("A")="SELECT 1-"_IB2_": "
 .... S DIR(0)="NAO^1:"_IB2_":0"
 .... S DIR("?")="Enter your selection for procedure from 1 to "_IB2
 ... I IBHLP D
 .... I $S(IB2'=+$G(^TMP("IBLIST",$J,0)):1,1:$P($G(^(0)),U,3)) S DIR("A")="'^' TO STOP: ",DIR(0)="EA" Q
 .... S Z=0 F  S Z=$O(DIR("A",Z)) Q:'Z  W !,DIR("A",Z)
 .... S Y="^" K DIR W ! Q
 ... I $D(DIR("A")) D ^DIR K DIR
 ... I IBHLP S Y=$S(Y=1:"",1:"^")
 ... I Y="" D  Q
 .... I $O(^TMP("IBLIST",$J,2,IB1)) Q
 .... S IBX=""
 .... W:'IBHLP !
 .... I $P($G(^TMP("IBLIST",$J,0)),U,3),IB1'<IBMAX D
 ..... I 'IBHLP W !!,"There were more than ",IBMAX," matches found.  Please try again with more specific input",! Q
 ..... D RXPRHLP(IBMAX,.IBNEXT)
 ... I Y["^" S IBX="",IBGOT=1 Q
 ... I Y>0 S IBGOT=1,IBX=$G(^TMP("IBLIST",$J,2,+Y)) D RECALL^DILFD(399.0304,+IBX_",",DUZ)
 . I 'IBGOT S ^TMP("IBLIST",$J,0)=0
 I 'IBMANY,$G(^TMP("IBLIST",$J,0)) D
 . N Q,Q1
 . S Q=^TMP("IBLIST",$J,2,1)
 . F Q1=0:0 S Q1=$O(^TMP("IBLIST",$J,"ID",1,Q1)) Q:'Q1  D
 .. I $G(^TMP("IBLIST",$J,"ID",1,Q1))'="" S Q=Q_"  "_^TMP("IBLIST",$J,"ID",1,Q1) Q
 .. I $G(^TMP("IBLIST",$J,"ID",1,Q1,"E"))'="" S Q=Q_"  "_^TMP("IBLIST",$J,"ID",1,Q1,"E")
 . D EN^DDIOL($J("",16)_Q) S IBX=$G(^TMP("IBLIST",$J,2,1)) D RECALL^DILFD(399.0304,+IBX_",",DUZ)
 ;
 D CLEAN^DILF
 K ^TMP("IBLIST",$J)
 Q IBX
 ;
RXPRHLP(IBMAX,IBNEXT) ; Get list for ?? help
 ;
 ; IBMAX = The maximum # of entries to extract at once
 ; IBNEXT = Contains the value of the index to start at
 ;
 N IBQ,IBZ
 S IBQ=+$O(^TMP("IBLIST",$J,2,""),-1),IBZ=","_DA(1)_","
 D LIST^DIC(399.0304,IBZ,"@;.01EI;1E",,IBMAX,.IBNEXT,,"B","I '$$LINKED^IBCEU4(.DA,Y)"),XFER(IBQ)
 Q
 ;
LINKED(DA,Y) ; Function returns 1 if proc already linked to an RX rev code
 ; DA = the DA array from the RC multiple
 ; Y = the ien of the CP multiple
 N Z
 S Z=+$O(^DGCR(399,DA(1),"RC","ACP",Y,0))
 Q $S(Z:Z'=DA,1:0)
 ;
XFER(IBQ) ; Transfer DILIST to IBLIST array
 ; IBQ = the number of entries already found
 N Z,IBZ
 S (Z,IBZ)=0
 F  S Z=$O(^TMP("DILIST",$J,2,Z)) Q:'Z  S IBZ=IBZ+1,^TMP("IBLIST",$J,2,IBZ+IBQ)=^TMP("DILIST",$J,2,Z) M ^TMP("IBLIST",$J,"ID",IBZ+IBQ)=^TMP("DILIST",$J,"ID",Z)
 ;
 I $D(^TMP("DILIST",$J,0)) S ^TMP("IBLIST",$J,0)=^TMP("DILIST",$J,0)
 S $P(^TMP("IBLIST",$J,0),U)=IBQ+IBZ
 Q
 ;
NOREV(DA,IBRX) ; Returns 1 if no other revenue code on bill DA(1)
 ; is linked to prescription entry IBRX
 N X,Z
 S X=1,Z=0 F  S Z=$O(^DGCR(399,DA(1),"RC",Z)) Q:'Z  I DA'=Z,$P($G(^(Z,0)),U,11)=IBRX S X=0 Q
 Q X
 ;
ASKRX(DA) ; Returns the selected RX entry in file 362.4
 N DIR,X,Y
 S DIR(0)="PAO^IBA(362.4,"
 S DIR("A")="  RX: ",DIR("B")=$P($G(^IBA(362.4,+$P($G(^DGCR(399,DA(1),"RC",DA,0)),U,11),0)),U)
 S DIR("S")="I $P(^(0),U,2)=DA(1),$$NOREV^IBCEU4(.DA,Y)"
 D ^DIR K DIR
 Q $S(Y>0:+Y,1:"")
 ;
SLF(IBIFN) ;  Returns 1 if Attending/Rendering provider id is SLF000
 N IB,IBZ
 S IB=0
 D F^IBCEF("N-ATT/REND PROVIDER ID","IBZ",,IBIFN)
 S:$G(IBZ)="SLF000" IB=1
 Q IB
 ;
GETPOA(IBDX,PRTFLG) ; returns POA indicator for a given DX
 ; IBDX - ien in file 362.3
 ; PRTFLG - 1 if POA is fetched for printed form, 0 otherwise
 N POA
 S POA=""
 S:+IBDX>0 POA=$P($G(^IBA(362.3,IBDX,0)),U,4)
 ; on UB-04 print "" instead of "1" for blank.
 I PRTFLG,POA="1" S POA=""
 Q POA
