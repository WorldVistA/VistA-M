IBCEF5 ;ALB/TMP - MRA/EDI ACTIVATED UTILITIES ;06-FEB-96
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;
ADDRULE() ; Add a new rule to the EDI transmission rules file
 ; Function returns the entry number of the new rule or
 ;   0 if no rule added
 ;
 N DIR,X,Y,IBD,IBS,IBOK,IBDA1,IBC,DIC,DA,DR,DIE,IB,DO,DD,DLAYGO
 ;
 D FULL^VALM1
 S IBOK=1
 ;
 L +^IBE(364.4,0):10
 I '$T S IBOK=0 W !,"FILE LOCKED ... TRY AGAIN LATER" S IBOK=0 G ADDQ
 S X=$O(^IBE(364.4,"A"),-1)
 F  S X=X+1 I '$D(^IBE(364.4,X,0)) S DIC="^IBE(364.4,",DIC(0)="L",DLAYGO=364.4,DIC("DR")="10.01////"_DUZ_";10.02///"_$$NOW^XLFDT D FILE^DICN S IBDA1=+Y K DLAYGO,DIC Q
 L -^IBE(364.4,0)
 I IBDA1'>0 S IBOK=0 G ADDQ
 K DIR
 S DIR(0)="364.4,.11A",DIR("A")="New Rule's TYPE OF RULE: "
 D ^DIR K DIR
 I $D(DIRUT) S IBOK=0 G ADDQ ;Required
 S IB(.11)=+Y
 I +Y=0 W !,"YOU ARE ADDING A RULE THAT WILL ONLY ALLOW THE TRANSMISSION OF BILLS WHOSE",!,"  FORM TYPE IS INCLUDED IN THIS RULE."
 ;
 S IB(.03)=2 ;MRA ONLY
 I IB(.11)'=2 D  G:'IBOK ADDQ
 . S DIR(0)="364.4,.03A^^I X=2 K X",DIR("A")="New Rule's TRANSMISSION TYPE: "
 . D ^DIR K DIR,DA
 . I Y'>0 S IBOK=0 K IB(.03) ;Required
 . S IB(.03)=+Y
 ;
 S DIR("A")=$S(IB(.11)'=0:"APPLY RULE ONLY TO BILLS THAT ARE (I)NSTITUTIONAL, (P)ROFESSIONAL, OR (B)OTH: ",1:"ONLY TRANSMIT (I)NSTITUTIONAL, (P)ROFESSIONAL, OR (B)OTH: ")
 S DIR(0)="SAM^I:INSTITUTIONAL ONLY;P:PROFESSIONAL ONLY;B:BOTH TYPES"
 D ^DIR K DIR,DA
 I "IPB"'[Y S IBOK=0 G ADDQ
 S IB(.05)=$S(Y="I":1,Y="P":2,1:3)
 ;
 ;S DIR("A")="APPLY RULE ONLY TO BILLS THAT ARE (I)NPATIENT, (O)UTPATIENT, OR (B)OTH: "
 ;S DIR(0)="SAM^I:INPATIENT;OUTPATIENT;B:BOTH"
 ;D ^DIR K DIR,DA
 ;I "IPB"'[Y S IBOK=0 G ADDQ
 ;S IB(.04)=$S(Y="I":1,Y="P":2,1:3)
 S IB(.04)=3
 ;
 W !
 ;
 S IBS="",$P(IBS,"*",36)=""
 S DIR("A",1)=IBS
 S DIR("A",2)="THIS RULE WILL ONLY APPLY TO BILLS THAT MATCH ALL OF THE FOLLOWING CONDITIONS:"
 S IBD=2
 I IB(.11)'=2 D
 . S IBD=IBD+1
 . S DIR("A",IBD)=$J("",5)_"BILL IS "_$S(IB(.03)<3:"AN "_$P("EDI^MRA",U,+IB(.03)),1:"EITHER AN EDI OR MRA")_" BILL AND IS ALSO "
 . S Z=$S(IB(.11)=0:IB(.05)#2+1,1:+IB(.05))
 . S DIR("A",IBD)=DIR("A",IBD)_$S(IB(.05)<3:$P("AN INSTITUTIONAL^A PROFESSIONAL",U,Z),1:"EITHER A PROFESSIONAL OR INSTITUTIONAL")_" BILL"
 .;S IBD=IBD+1,DIR("A",IBD)=$J("",5)_"AND "_$S(IB(.04)<3:"IS ALSO AN "_$P("INPATIENT^OUTPATIENT",U,+IB(.04)),1:"IS EITHER AN INPATIENT OR OUTPATIENT")_" BILL."
 . S IBD=IBD+1,DIR("A",IBD)=""
 . S IBD=IBD+1,DIR("A",IBD)="NOTE: RULE WILL BE IGNORED FOR ANY BILLS THAT DO NOT MATCH ALL THE CONDITIONS"
 . ;
 . I IB(.11)=0 D INSINC(.IBD)
 . ;
 . I IB(.11)=1 D
 .. D INSINC(.IBD),RTINC(.IBD)
 . ;
 . I IB(.11)=9 D
 .. S IBD=IBD+1,DIR("A",IBD)=""
 .. D INSINC(.IBD)
 ;
 I IB(.11)=2 D
 . S IBD=IBD+1,DIR("A",IBD)=$J("",5)_"BILL IS AN MRA BILL"
 . S IBD=IBD+1,DIR("A",IBD)=$J("",5)_"AND IS ALSO "_$S(IB(.05)<3:$P("AN INSTITUTIONAL^A PROFESSIONAL",U,+IB(.05)),1:"EITHER A PROFESSIONAL OR INSTITUTIONAL")_" BILL"
 .;S IBD=IBD+1,DIR("A",IBD)=$J("",7)_"AND "_$S(IB(.04)<3:"IS ALSO AN "_$P("INPATIENT^OUTPATIENT",U,+IB(.04)),1:"IS EITHER AN INPATIENT OR OUTPATIENT")_" BILL"
 . S IBD=IBD+1,DIR("A",IBD)=$J("",5)_"AND ALSO HAS A NEXT INSURANCE THAT HAS BEEN INCLUDED IN THE"
 . S IBD=IBD+1,DIR("A",IBD)=$J("",8)_"'INSURANCE COMPANIES INCLUDED' LIST FOR THIS RULE."
 . S IBD=IBD+1,DIR("A",IBD)=""
 . S IBD=IBD+1,DIR("A",IBD)="NOTE: THIS RULE WILL BE IGNORED FOR ANY BILL THAT DOES NOT MATCH"
 . S IBD=IBD+1,DIR("A",IBD)="      ALL OF THESE CONDITIONS."
 . S IBD=IBD+1,DIR("A",IBD)=""
 . S IBD=IBD+1,DIR("A",IBD)="THE EFFECT OF THIS RULE WILL BE: IF A BILL MATCHES ALL OF THE ABOVE CONDITIONS,"
 . S IBD=IBD+1,DIR("A",IBD)="THE REQUEST AND RECEIPT OF AN MRA WILL NOT BE ALLOWED."
 S IBD=IBD+1,DIR("A",IBD)=IBS
 ;
 S DIR("A")="IS THIS CORRECT? "
 S DIR(0)="YA",DIR("B")="YES"
 D ^DIR K DIR
 I 'Y S IBOK=0 G ADDQ
 ;
 W !
 ;
 ; Combine inpatient/outpatient and inst/prof checks
 S IB(.05,"IN")=$S(IB(.04)=1:0,1:$S(IB(.05)=1:2,IB(.05)=2:1,1:3))
 S IB(.05,"OUT")=$S(IB(.04)=2:0,1:$S(IB(.05)=1:2,IB(.05)=2:1,1:3))
 S IB(1)=$S(IB(.11)=0:"I $$MULTYP^IBCEF5(.IB,"_IB(.05,"IN")_","_IB(.05,"OUT")_")",IB(.11)=1:"I $$BILLTYP^IBCEF5(IBIFN,$G(IBDA))",IB(.11)=2:"I $$REQMRA^IBEFUNC(IBIFN)",1:"")
 S DR=".03////"_IB(.03)_";.05////"_IB(.05)_";.02;.06;.08;4;.07"_$S(IB(.11)'=2:"",1:"////1")_";.11////"_IB(.11)
 S DR=DR_";1"_$S(IB(.11)<9:"////"_IB(1),1:"")
 S DIE="^IBE(364.4,",DA=IBDA1
 D ^DIE
 I $D(Y) S IBOK=0 G ADDQ
 ;
 W !
 S IB(.07)=$P($G(^IBE(364.4,IBDA1,0)),U,7)
 ;
 D:IB(.07)'=3 INSCO^IBCEF51(.IB,.IBOK,IBDA1)
 I 'IBOK K IB G ADDQ
 I IB(.11)=1 D BTYP^IBCEF51(.IB,.IBOK) ;Enter applicable bill types
 I 'IBOK K IB G ADDQ
 ;
 I IBOK D ADDBTYP^IBCEF61(.IB,IBDA1),INSADD^IBCEF61(.IB,IBDA1)
 ;
ADDQ I $G(IBDA1),'IBOK S DA=IBDA1,DIK="^IBE(364.4," D ^DIK
 I IBOK D REBLD^IBCEF6($G(IBACTIVE))
 Q $S(IBOK:IBDA1,1:0)
 ;
BILLTYP(IBIFN,IBDA) ; Check bill type for valid to transmit
 N IB,IB0,IB00,IB399,IBOK,IBALL,IBB,IBEXC,IBQUIT,IBINC,Z,Z1
 S Z=$$FT^IBCEF(IBIFN)
 S IB399=$G(^DGCR(399,IBIFN,0))
 S IB0=$P(IB399,U,24,26)
 S IB0=$P(IB0,U)_$P($G(^DGCR(399.1,+$P(IB0,U,2),0)),U,2)_$P(IB0,U,3)
 ;
 S (IB,IBINC,IBOK,IBALL)=0
 ;
 ; Check for all bill types allowed, dates allowed
 F  S IB=$O(^IBE(364.4,IBDA,"BTYP","B","XXX",IB)) Q:'IB  D  Q:IBALL
 . S IB00=$G(^IBE(364.4,IBDA,"BTYP",IB,0))
 . I $S($P(IB00,U,2):$P(IB00,U,2)'>DT,1:1),$S($P(IB00,U,3):$P(IB00,U,3)>DT,1:1) S IBALL=1 Q
 ;
 ; If not all bill types are included, find out if any are included
 I 'IBALL S IB="",IBINC=0 F  S IB=$O(^IBE(364.4,IBDA,"BTYP","B",IB),-1)  Q:IB=""!($E(IB)="-")  D  Q:IBINC
 . S IBB=+$O(^IBE(364.4,IBDA,"BTYP","B",IB,0)),IB00=$G(^IBE(364.4,IBDA,"BTYP",IBB,0))
 . I $S($P(IB00,U,2):$P(IB00,U,2)'>DT,1:1),$S($P(IB00,U,3):$P(IB00,U,3)>DT,1:1) S IBINC=1 Q
 ;
 I IB0'="" D  ;Check bill's type of bill in included list, or is excluded
 . S (IBQUIT,IBEXC)=0
 . F Z1=1,2 Q:Z1=2&'IBOK  S:'IBINC Z1=2,IBOK=1 F IB=$E(IB0)_"XX",$E(IB0,1,2)_"X",IB0 S IBQUIT=0 D  Q:IBQUIT
 .. I Z1=2 S IB="-"_IB ;Checking for exclusions on this pass
 .. S Z=0
 .. F  S Z=$O(^IBE(364.4,+$G(IBDA),"BTYP","B",IB,Z)) Q:'Z  S IB00=$G(^IBE(364.4,IBDA,"BTYP",Z,0)),IBQUIT=0 D  Q:IBQUIT
 ... I $P(IB00,U,2)>DT Q  ;Not effective yet
 ... I $P(IB00,U,3),$P(IB00,U,3)'>DT Q  ;Expired
 ... I $E(IB00)'="-" S (IBQUIT,IBOK)=1 Q  ; Bill type included
 ... I $E(IB00)="-" S IBOK=0,(IBEXC,IBQUIT)=1 Q  ; Bill type is excluded
 . I 'IBALL,'IBINC,'IBEXC S IBOK=1 ;No active restrictions found
 ;
BTYPQ Q IBOK
 ;
QUIT ; DIR call to continue processing after error message display
 S DIR("A")="Press RETURN to continue: "
 S DIR(0)="EA" D ^DIR K DIR
 ;
 Q
 ;
MULTYP(IB,IN,OUT) ; Code to execute to determine multiple types
 ;   of I/O and prof/inst bills combinations OK to transmit
 ; IB = ien of bill in file 399
 ; IB(x) = array containing necessary data for xref search from bill
 ;         subscripted by x=field # in file 364.4
 ; IN  =0 or null for no inpt at all
 ;     =1 for inpt,prof only;  =2 for inpt,inst only; =3 for inpt,both
 ; OUT =0 or null for no outpt at all
 ;     =1 for outpt,prof only;  =2 for outpt,inst only; =3 for outpt,both
 ;
 ;  Function returns 1 if edit passes, 0 if edit fails
 ;
 ; Functionality has been removed, but code remains in case they decide
 ; they need it later (INPT/OUTPT part)
 ;
 N IBOK
 S IBOK=1
 ; IB(.04) = the value of the bill's type of care (1=outpt, 2=inpt)
 ; IB(.05) = the value of the bill's form type (1=inst, 2=prof)
 ; outpatient bill
 I $G(IB(.04))=1,$G(OUT)'=3 D  G:'IBOK MULTQ
 . I +$G(OUT)=0 S IBOK=0 Q
 . I $G(OUT)=1,$G(IB(.05))'=2 S IBOK=0 Q
 . I $G(OUT)=2,$G(IB(.05))'=1 S IBOK=0 Q
 ; inpatient bill
 I $G(IB(.04))=2,$G(IN)'=3 D  G:'IBOK MULTQ
 . I +$G(IN)=0 S IBOK=0 Q
 . I $G(IN)=1,$G(IB(.05))'=2 S IBOK=0 Q
 . I $G(IN)=2,$G(IB(.05))'=1 S IBOK=0 Q
MULTQ Q IBOK
 ;
INSINC(IBD) ; Insurance include/exclude condition explanation
 ; IBD = line counter - pass by reference
 S IBD=IBD+1,DIR("A",IBD)=""
 S IBD=IBD+1,DIR("A",IBD)="THE EFFECT OF THIS RULE WILL BE: IF A BILL MATCHES BOTH OF THE ABOVE CONDITIONS,"
 S IBD=IBD+1,DIR("A",IBD)="THE RULE WILL BE APPLIED AND THE BILL WILL NOT BE TRANSMITTED IF:"
 S IBD=IBD+1,DIR("A",IBD)=" - THE RULE APPLIES TO ALL INSURANCE COMPANIES"
 S IBD=IBD+1,DIR("A",IBD)=$J("",17)_"OR"
 S IBD=IBD+1,DIR("A",IBD)=" - THE RULE 'APPLIES TO' ONLY SPECIFIC INSURANCE COMPANIES AND THE BILL'S"
 S IBD=IBD+1,DIR("A",IBD)="   INSURANCE COMPANY APPEARS ON THE RULE'S 'INCLUDE LIST'"
 S IBD=IBD+1,DIR("A",IBD)=$J("",17)_"OR"
 S IBD=IBD+1,DIR("A",IBD)=" - THE RULE 'EXCLUDES' SPECIFIC INSURANCE COMPANIES AND THE BILL'S"
 S IBD=IBD+1,DIR("A",IBD)="   INSURANCE COMPANY DOES NOT APPEAR ON THE RULE'S 'EXCLUDE LIST'"
 Q
 ;
RTINC(IBD) ; Bill type include/exclude condition explanation
 ; IBD = line counter - pass by reference
 ;
 S IBD=IBD+1,DIR("A",IBD)="*** AND ***"
 S IBD=IBD+1,DIR("A",IBD)=" - THE RULE HAS NO BILL TYPE RESTRICTIONS OR APPLIES TO ALL BILL TYPES"
 S IBD=IBD+1,DIR("A",IBD)=$J("",17)_"OR"
 S IBD=IBD+1,DIR("A",IBD)=" - THE RULE IS RESTRICTED TO CERTAIN BILL TYPES AND THE BILL'S BILL TYPE IS"
 S IBD=IBD+1,DIR("A",IBD)="   INCLUDED FOR THE RULE OR IS NOT EXCLUDED FOR THE RULE"
 Q
 ;
