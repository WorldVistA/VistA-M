IBCNSP01 ;ALB/AAS - INSURANCE MANAGEMENT - EXPANDED POLICY  ;05-MAR-1993
 ;;2.0;INTEGRATED BILLING;**43,52,85,251,371,377,416,452**;21-MAR-94;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
% D SUBSC,RIDER
 Q
 ;
SUBSC ; -- subscriber region
 N OFFSET,START,RX
 S START=24,OFFSET=2,RX=0
 D SET^IBCNSP(START,OFFSET," Subscriber Information ",IORVON,IORVOFF)
 S Y=$P(IBCDFND,"^",6),C=$P(^DD(2.312,6,0),"^",2) D Y^DIQ
 D SET^IBCNSP(START+1,OFFSET," Whose Insurance: "_Y)
 D SET^IBCNSP(START+2,OFFSET," Subscriber Name: "_$P(IBCDFND,"^",17))
 S Y=$P(IBCDFND4,"^",3),C=$P(^DD(2.312,4.03,0),"^",2) D Y^DIQ
 D SET^IBCNSP(START+3,OFFSET,"    Relationship: "_Y)
 D SET^IBCNSP(START+4,OFFSET,"      Primary ID: "_$P(IBCDFND,"^",2))
 S Y=$P(IBCDFND,"^",20),C=$P(^DD(2.312,.2,0),"^",2) D Y^DIQ
 D SET^IBCNSP(START+5,OFFSET,"Coord.  Benefits: "_Y)
 D SET^IBCNSP(START+6,OFFSET,"Primary Provider: "_$P(IBCDFND4,"^",1))
 D SET^IBCNSP(START+7,OFFSET," Prim Prov Phone: "_$P(IBCDFND4,"^",2))
 ;
 ; IB*2*452 - esg - display Pharmacy fields if they exist
 I $P(IBCDFND4,U,5)'=""!($P(IBCDFND4,U,6)'="") D
 . N G,IBY S G=+$P(IBCDFND4,U,5),IBY="",RX=2
 . I G S IBY=$$GET1^DIQ(9002313.19,G_",",.01)_" - "_$$GET1^DIQ(9002313.19,G_",",.02)
 . D SET^IBCNSP(START+8,OFFSET," Rx Relationship: "_IBY)
 . D SET^IBCNSP(START+9,OFFSET,"  Rx Person Code: "_$P(IBCDFND4,U,6))
 . Q
 ;
 ; Two blank lines at end of section
 D SET^IBCNSP(START+8+RX,OFFSET," ")
 D SET^IBCNSP(START+9+RX,OFFSET," ")
 Q
 ;
VER ; -- Entered/Verfied Region
 N OFFSET,START,EIVFLG
 S EIVFLG=+$P(IBCDFND4,"^",4)
 S START=$O(^TMP("IBCNSVP",$J,""),-1)+1,OFFSET=2
 S IB1ST("VERIFY")=START
 D SET^IBCNSP(START,OFFSET," User Information ",IORVON,IORVOFF)
 D SET^IBCNSP(START+1,OFFSET,"      Entered By: "_$E($P($G(^VA(200,+$P(IBCDFND1,"^",2),0)),"^",1),1,20))
 D SET^IBCNSP(START+2,OFFSET,"      Entered On: "_$$DAT1^IBOUTL(+IBCDFND1))
 D SET^IBCNSP(START+3,OFFSET,"Last Verified By: "_$S(EIVFLG:"AUTOUPDATE,IB-eIV",1:$E($P($G(^VA(200,+$P(IBCDFND1,"^",4),0)),"^",1),1,20)))
 D SET^IBCNSP(START+4,OFFSET,"Last Verified On: "_$$DAT1^IBOUTL(+$P(IBCDFND1,"^",3)))
 D SET^IBCNSP(START+5,OFFSET," Last Updated By: "_$S(EIVFLG:"AUTOUPDATE,IB-eIV",1:$E($P($G(^VA(200,+$P(IBCDFND1,"^",6),0)),"^",1),1,20)))
 D SET^IBCNSP(START+6,OFFSET," Last Updated On: "_$$DAT1^IBOUTL(+$P(IBCDFND1,"^",5)))
 D SET^IBCNSP(START+7,2," ")   ; 2 blank lines to end section
 D SET^IBCNSP(START+8,2," ")
VERQ Q
 ;
ID ; Subscriber and patient primary and secondary ID's and qualifiers
 NEW START,OFFSET,IBL,G,PCE,QUAL,QUAL1
 S G=IBCDFND5
 S (START,IBL)=$O(^TMP("IBCNSVP",$J,""),-1)+1,OFFSET=2
 S IB1ST("ID")=START
 D SET^IBCNSP(START,OFFSET," Insurance Company ID Numbers (use Subscriber Update Action) ",IORVON,IORVOFF)
 S IBL=IBL+1
 D SET^IBCNSP(IBL,OFFSET,"  Subscriber Primary ID: "_$P(IBCDFND,U,2))
 ;
 F PCE=3,5,7 D            ; subscriber secondary IDs
 . I $P(G,U,PCE)="" Q     ; no secondary ID#
 . S QUAL=$P(G,U,PCE-1)   ; internal qualifier code
 . S QUAL1=$S(QUAL="23":"Client#",QUAL="IG":"Ins. Policy#",QUAL="SY":"SSN",1:"Unknown")
 . S IBL=IBL+1
 . D SET^IBCNSP(IBL,OFFSET,"Subscriber Secondary ID: "_$P(G,U,PCE))
 . D SET^IBCNSP(IBL,52,"ID Qual: "_QUAL_" ("_QUAL1_")")
 . Q
 ;
 ; patient=subscriber so skip over patient ID# display
 I +$P(IBCDFND,U,16)=1 G ID1
 ;
 S IBL=IBL+1 D SET^IBCNSP(IBL,2," ")   ; blank line
 S IBL=IBL+1
 D SET^IBCNSP(IBL,OFFSET,"     Patient Primary ID: "_$P(G,U,1))
 ;
 F PCE=9,11,13 D          ; patient secondary IDs
 . I $P(G,U,PCE)="" Q     ; no secondary ID#
 . S QUAL=$P(G,U,PCE-1)   ; internal qualifier code
 . S QUAL1=$S(QUAL="23":"Client#",QUAL="IG":"Ins. Policy#",QUAL="SY":"SSN",1:"Unknown")
 . S IBL=IBL+1
 . D SET^IBCNSP(IBL,OFFSET,"   Patient Secondary ID: "_$P(G,U,PCE))
 . D SET^IBCNSP(IBL,52,"ID Qual: "_QUAL_" ("_QUAL1_")")
 . Q
 ;
ID1 ; end of section - 2 blank lines
 S IBL=IBL+1 D SET^IBCNSP(IBL,2," ")
 S IBL=IBL+1 D SET^IBCNSP(IBL,2," ")
IDQ ;
 Q
 ;
RIDER ; -- Personal policy riders
 N OFFSET,START,IBI,IBL,IBPR,IBPRD
 S START=$O(^TMP("IBCNSVP",$J,""),-1)+1,OFFSET=2,IBL=0
 D SET^IBCNSP(START,OFFSET," Personal Riders ",IORVON,IORVOFF)
 S IBI="" F  S IBI=$O(^IBA(355.7,"APP",DFN,IBCDFN,IBI)) Q:'IBI  S IBPR=$O(^(IBI,0)),IBPRD=+$G(^IBA(355.7,IBPR,0)),IBL=IBL+1 D
 . D SET^IBCNSP(START+IBL,OFFSET,"   Rider #"_IBL_": "_$$EXPAND^IBTRE(355.7,.01,IBPRD))
 . Q
 S IBL=IBL+1 D SET^IBCNSP(START+IBL,OFFSET," ")
 S IBL=IBL+1 D SET^IBCNSP(START+IBL,OFFSET," ")
 Q
 ;
AI ; -- Add ins. verification entry
 ;    called from ai^ibcnsp1
 ;
 ; -- see if current inpatient
 D INP^VADPT I +VAIN(1) D
 .S IBTRN=$O(^IBT(356,"AD",+VAIN(1),0))
 ;
 S IBXIFN=$O(^IBE(356.11,"ACODE",85,0))
 ;
 ; -- if not tracking id allow selecting
 I '$G(IBTRN) D  G:IBQUIT AIQ
 .W !,"You can now enter a contact and relate it to a Claims Tracking Admission entry."
 .S DIC("A")="Select RELATED ADMISSION DATE: "
 .S DIC="^IBT(356,",DIC(0)="AEQ",D="ADFN"_DFN,DIC("S")="I $P(^(0),U,5)"
 .D IX^DIC K DA,DR,DIC,DIE I $D(DUOUT)!($D(DTOUT)) S IBQUIT=1 Q
 .I +Y>1 S IBTRN=+Y
 ;
 I '$G(IBTRN) W !!,"Warning: This contact is not associated with any care in Claims Tracking.",!,"You may only edit or view this contact using this action.",!
 ;
 ; -- select date
 S IBOK=0,IBI=0 F  S IBI=$O(^IBT(356.2,"D",DFN,IBI)) Q:'IBI  I $P($G(^IBT(356.2,+IBI,0)),"^",4)=IBXIFN,$P($G(^(1)),"^",5)=IBCDFN S IBOK=1
 I IBOK D  G:IBQUIT AIQ
 .S DIC="^IBT(356.2,",DIC("A")="Select Contact Date: "
 .S X="??",DIC(0)="EQ",DIC("S")="I $P($G(^(1)),U,5)=IBCDFN,$P(^(0),U,4)=IBXIFN" ;,DLAYGO=356.2
 .S D="ADFN"_DFN
 .D IX^DIC K DIC,DR,DA,DIE,D I $D(DUOUT)!($D(DTOUT)) S IBQUIT=1
 ;
 S DIC="^IBT(356.2,",DIC("A")="Select Contact Date: ",DIC("B")="TODAY"
 S DIC("DR")=".02////"_$G(IBTRN)_";.04////"_IBXIFN_";.05////"_DFN_";.19////1;1.01///NOW;1.02////"_DUZ_";1.05////"_IBCDFN
 S DIC(0)="AEQL",DIC("S")="I $P(^(0),U,5)=DFN,$P($G(^(1)),U,5)=IBCDFN,$P(^(0),U,4)=IBXIFN",DLAYGO=356.2
 D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT))!(+Y<1) G AIQ
 S IBTRC=+Y
 I $G(IBTRC),$G(IBTRN),'$P(^IBT(356.2,+IBTRC,0),"^",2) S DA=IBTRC,DIE="^IBT(356.2,",DR=".02////"_$G(IBTRN) D ^DIE
 ;
 ; -- edit ins ver type
 D EDIT^IBTRCD1("[IBT INS VERIFICATION]",1)
AIQ Q
