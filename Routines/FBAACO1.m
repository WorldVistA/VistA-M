FBAACO1 ;AISC/GRR-ENTER PAYMENT CONTINUED ;7/17/2003
 ;;3.5;FEE BASIS;**4,61,77**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
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
PPT(FBDEF) ;establishes prompt pay type for entry
 ;fbaamm=ppt if 1 ask for each line item; if 0 don't ask
 ;fbaamm1=the ppt for each line item
 ;FBDEF=(optional) default for DIR prompt: =1 for yes, otherwise no
 N Y I FBAAMM="" S FBAAMM1="" Q
 I FBAAMM=1 F  D  Q:Y]""
 . S DIR(0)="Y",DIR("A")="Is this line item for a contracted service"
 . S DIR("B")=$S($G(FBDEF)=1:"Yes",1:"No")
 . S DIR("?")="Answering no indicates that interest will not be paid for this line item."
 . D ^DIR K DIR I $D(DIRUT) W !,$C(7),"Required Response!" S Y=""
 S FBAAMM1=$S(Y=1:1,1:"")
 Q
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
 S FBAAID=Y I '$G(FBCNP) I FBAAID<FBAABDT W !!,$C(7),"Invoice date is earlier than Patient's Authorization date!!" K FBAAID G GETINDT
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
