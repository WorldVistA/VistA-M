FBAACO1 ;AISC/GRR - ENTER PAYMENT CONTINUED ;6/25/2009
 ;;3.5;FEE BASIS;**4,61,77,108,124**;JAN 30, 1995;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
SVCPR ;set up service provided multiple
 I '$D(^FBAAC(DFN,1,FBV,1,FBSDI,1,0)) S ^FBAAC(DFN,1,FBV,1,FBSDI,1,0)="^162.03A^0^0"
 W ! S DLAYGO=162,DIC="^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,",DIC(0)=$S($G(FBCNP):"QL",1:"EQL"),X=""""_FBX_"""",DA(3)=DFN,DA(2)=FBV,DA(1)=FBSDI
 D
 . N ICPTVDT S ICPTVDT=$G(FBAADT) D ^DIC
 K DIC,DLAYGO,DA I Y<0 S FBAAOUT=1 Q
 S (FBAACPI,DA)=+Y
 ;
 ; update zip code and anesthesia time
 S DIE="^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,"
 K DA S DA(3)=DFN,DA(2)=FBV,DA(1)=FBSDI,DA=FBAACPI
 S DR="42////^S X=$G(FBZIP);43////^S X=$G(FBTIME)"
 D ^DIE K DIE,DA,DR
 ;
 ; create CPT MODIFIER entries from data in array FBMODA
 D REPMOD^FBAAUTL4(DFN,FBV,FBSDI,FBAACPI)
 ;
 Q
 ;
PPT(FBDEF,FBDEFC,FB162) ;establishes prompt pay type and contract for entry
 ; input
 ;   FBDEF  = (optional) default for DIR prompt: =1 for yes, else no
 ;   FBDEFC = (optional) default for the contract prompt
 ;   FBAAMM = ppt if 1 ask for each line item; if 0 don't ask
 ;   FBV    = vendor (ien) being paid
 ;   FBVEN  = vendor (ien) from authorization
 ;   FBCNTRA= contract (ien) from authorization
 ;   FB583  = (optional) $D(FB583) true if unauthorized claim
 ;   FB162  = (optional) = 1 if payment line item in sub-file 162.03 is being edited.  FBDEF and FBDEFC must be current values.
 ; output
 ;   FBAAMM1 = the ppt for the line item
 ;   FBCNTRP = contract ien for the line item
 N Y
 S (FBAAMM1,FBCNTRP)=""
 I FBAAMM="" Q
 S:'$D(FBV) FBV=$G(FBVEN)  ;SOMETIMES FBV DOES NOT EXIST BUT FBVEN IS SET EQUAL TO THE VENDOR IN FBCH ENTER PAYMENT
 I FBAAMM=1,'$D(FB583),$$UCFA^FBUTL7($G(FBV),$G(FBVEN),$G(FBCNTRA)) D  Q
 . W !,"Contract is ",$P($G(^FBAA(161.43,FBCNTRA,0)),U)," from the authorization."
 . S FBAAMM1=1
 . S FBCNTRP=FBCNTRA
 I FBAAMM=1 D
 . ;if editing line in file 162 contracted services can't be changed
 . I $G(FB162)=1 D
 .. W !,"Invoice ",$S(FBDEF=1:"is",1:"is not")," for contracted services."
 .. S Y=$S(FBDEF=1:1,1:0)
 . ;if not editing line in file 162 contracted services can be changed
 . I $G(FB162)'=1 F  D  Q:Y]""
 . . S DIR(0)="Y",DIR("A")="Is this line item for a contracted service"
 . . S DIR("B")=$S($G(FBDEF)=1:"Yes",1:"No")
 . . S DIR("?")="Answering no indicates that interest will not be paid for this line item."
 . . D ^DIR K DIR I $D(DIRUT) W !,$C(7),"Required Response!" S Y=""
 . S FBAAMM1=$S(Y=1:1,1:"")
 . Q:FBAAMM1=""
 . ;
 . S DIR(0)="PO^161.43:AQEM"
 . S DIR("A")="CONTRACT"
 . S DIR("?",1)="If the line item is under a contract then select it."
 . S DIR("?")="Contract must be active and applicable for the vendor."
 . S DIR("S")="I $P($G(^(0)),""^"",2)'=""I"",$$VCNTR^FBUTL7($G(FBV),+Y)"
 . S:$G(FBDEFC) DIR("B")=$P($G(^FBAA(161.43,FBDEFC,0)),U)
 . D ^DIR K DIR
 . ; if time-out or '^' and has default value (i.e. edit payment)
 . ;   return default so existing payment is not altered
 . I $D(DTOUT)!$D(DUOUT),$G(FBDEFC)>0 S FBCNTRP=FBDEFC Q
 . I Y>0 S FBCNTRP=+Y
 Q
 ;
Q K FBAADT,FBX,FBAACP W:FBINTOT>0 !!,"Invoice: "_FBAAIN_"  Totals $ "_$J(FBINTOT,1,2) G Q^FBAACO:$D(FB583),1^FBAACO:'$D(FBCHCO) Q
 ;
POS ; prompt for place of service
 ; output
 ;   FBHCFA(30) = place of service (internal)
 N Y
 S FBHCFA(30)=""
 S DIR(0)="P^353.1:EMZ"
 D ^DIR K DIR I $D(DIRUT) Q
 S FBHCFA(30)=$P(Y,U)
 Q
 ;
GETVEN ;select vendor from vendor file
 W !! S DLAYGO=161.2,DIC="^FBAAV(",DIC(0)="AEQLM" D ^DIC K DLAYGO I X="^"!(X="") S FBAAOUT=1 Q
 ;if new vendor, call in to new vendor setup routine
 G GETVEN:Y<0 S DA=+Y,DIE=DIC D:$P(Y,"^",3)=1 NEW^FBAAVD K DIE,DIC,DR,X,DLAYGO
GETVEN1 I $D(FB583) S DA=FBVEN
 I $D(^FBAAV(DA,0)),$P($G(^("ADEL")),U)="Y" W !!,$C(7),"Vendor has been flagged for Austin deletion!" G GETVEN:'$D(FB583) S FBAAOUT=1 Q
 D:$P(FBSITE(0),"^",11)="Y" EN1^FBAAVD
GETVEN2 I $P(FBSITE(0),"^",11)="Y",$D(^XUSEC("FBAA ESTABLISH VENDOR",DUZ)) S DIR(0)="Y",DIR("A")="Want to Edit data",DIR("B")="NO" D ^DIR K DIR S:$D(DIRUT) FBAAOUT=1 Q:$D(DIRUT)  D:Y EDITV^FBAAVD
 I $P(FBSITE(0),"^",11)'="Y"!('$D(^XUSEC("FBAA ESTABLISH VENDOR",DUZ))) S DIR(0)="E" D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1 Q
 S FBV=DA,FBAR(DA)="" D ^FBAACO4
 Q
 ;
GETINV ;assign invoice number or select existing invoice number
 K FBAAOUT S FBINTOT=0 S DIR(0)="Y",DIR("A")="Want a new Invoice number assigned",DIR("B")="YES" D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1 Q
 I Y D GETNXI^FBAAUTL W !!,"Invoice # ",FBAAIN," assigned to this Invoice" Q
GETINV1 ;selects existing invoice if user does not choose to assign new number
 S DIR(0)="N",DIR("A")="Select Invoice number",DIR("?")="Select one of the previously entered Invoice #'s" D ^DIR K DIR I $D(DIRUT)!(X="") G GETINV:'$G(FB583) S FBAAOUT=1 Q
 D CHK1^FBAACO4 G GETINV1:'$G(FBAACK1) K FBAACK1
 I '$D(^FBAAC("AJ",FBAABE,X)) D  G GETINV1
 . W !,$C(7),"Only previously entered invoices in the same batch may be selected!"
 S FBAAIN=X D CALC^FBAACO3 W:FBINTOT>0 ?33,"Current Total: $ "_$J(FBINTOT,1,2)
 Q
 ;
GETINDT ;get invoice dates
 ;input requires FBAABDT (authorization from date)
 K FBAAOUT W !,"Enter Date Correct Invoice Received or Last Date of Service" S %DT("A")="(whichever is later): " S:$G(FBAAID) %DT("B")=$$DATX^FBAAUTL(FBAAID) I $G(FBCNH) S %DT(0)=$G(FBENDDT)
 S %DT="AEXP" D ^%DT K %DT I X="^"!(X="") S FBAAOUT=1 Q
 S FBAAID=Y I $G(CALLERID)="FBCHEP",FBAAID<FBAAEDT D  K FBAAID G GETINDT
 .N SHOWDOS S SHOWDOS=$E(FBAAEDT,4,5)_"/"_$E(FBAAEDT,6,7)_"/"_$E(FBAAEDT,2,3) ;Convert FBAAEDT (Treatment TO Date) into display format for error message
 .W *7,!!?5,"*** Invoice Received Date cannot be before the ",!?8," Treatment TO Date ("_SHOWDOS_") !!!"
 I '$G(FBCNP) I FBAAID<FBAABDT D  K FBAAID G GETINDT
 .N SHOWDOS S SHOWDOS=$E(FBAABDT,4,5)_"/"_$E(FBAABDT,6,7)_"/"_$E(FBAABDT,2,3) ;Convert FBAABDT (Authorization From Date) into display format for error message
 .W !!,$C(7),?5,"*** Invoice Received Date cannot be earlier than",!?8," Patient's Authorization Date ("_SHOWDOS_") !!!"
GETIND1 W ! S %DT("A")="Enter Vendor Invoice Date: ",%DT="AEXP" S:$G(FBAAVID) %DT("B")=$$DATX^FBAAUTL(FBAAVID) D ^%DT K %DT G GETINDT:X="" I X="^" S FBAAOUT=1 Q
 S FBAAVID=Y I FBAAVID>FBAAID W !!,$C(7),"Vendor's invoice date is later than the date you received it!!" K FBAAVID G GETIND1
 Q
 ;
DISPINV ;display invoice totals
 ;required inputs FBAADT (auth dt),DFN
 S H=$E(FBAADT,1,5)_"00",R=9999999.9999-H,S=$E(FBAADT,1,5)_31,S=9999999.9999-S,G=+$E(FBAADT,4,5)_+$E(FBAADT,2,3) D CKMAX^FBAACO3
 S FBTPD=0 I $D(^FBAAC(DFN,3,"AB",FBAADT)) S FBZX=$O(^FBAAC(DFN,3,"AB",FBAADT,0)) I $D(^FBAAC(DFN,3,FBZX,0)) W !!,"$ ",$P(^(0),"^",3)," for travel already entered for this date of service" S FBTPD=1
 W:'$D(FBCHCO) !!,"Total already paid on ID Card for month:   $ ",A,"   Maximum allowed: $ ",$P(FBSITE(1),"^",9),!,"Total already paid on All/Other for month: $ ",FBAOT
 Q
