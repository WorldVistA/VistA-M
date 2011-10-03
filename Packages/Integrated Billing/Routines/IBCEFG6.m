IBCEFG6 ;ALB/TMP - OUTPUT FORMATTER MAINT-FORM FLD ACTION PROCESSING ;23-JAN-96
 ;;2.0;INTEGRATED BILLING;**52,51**;21-MAR-94
 ;
ADD ; Add a new local form fld
 ; Assumes IBCEXDA defined
 N %,IB,IBASSOC,IBDA,IBSEL,IBCOPY,X,Y,DD,DO,DIC,DIE,DR,DA,DLAYGO,LDINUM,DINUM,IBSCREEN
 G:'$G(IBCEXDA) ADDQ
 D FULL^VALM1
 S IBASSOC=$P($G(^IBE(353,IBCEXDA,2)),U,5) S:IBASSOC=IBCEXDA IBASSOC="" S IBSEL=(IBASSOC'="")
 S IBSCREEN=$P($G(^IBE(353,IBCEXDA,2)),U,2)="S"
 I 'IBASSOC,$O(^IBA(364.6,"B",IBCEXDA,"")) D  G:'IBSEL ADD1
 .W !,"OVERRIDE AN EXISTING FIELD" S %=2 D YN^DICN
 .I (%+1#3) S IBSEL=1
 G:'IBSEL ADD1
 D SEL(.IBDA,1)
 S IB=$O(IBDA("")) G:'IB ADDQ
 ; Associated form - only choose non-associated fld to override
 I IBASSOC,$S('IBSCREEN:$P($G(^IBA(364.6,+IBDA(IB),0)),U,2)'="N",1:0) W !!,"Can Only Over-ride a NATIONAL form field",! D PAUSE^VALM1 S IB=0 G ADDQ
 I 'IBASSOC,$S('IBSCREEN:$P($G(^IBA(364.6,+IBDA(IB),0)),U,3),1:+IBDA(IB)'=$P($G(^IBA(364.6,+IBDA(IB),0)),U,3)) W !!,"Can't Over-ride a form field that is an over-ride itself",! D PAUSE^VALM1 S IB=0 G ADDQ
 I $P($G(^IBA(364.6,+IBDA(IB),0)),U,7)=0 W !!,"Form field definition will not allow override",! D PAUSE^VALM1 S IB=0 G ADDQ
 W !!,"Over-riding Form Field # ",IB," - ",$P($G(^IBA(364.6,+IBDA(IB),0)),U,10)
 W !,"IS THIS OK" S %=2 D YN^DICN
 I '(%+1#3) S IB=0 G ADDQ
 W !,"COPY OVER THE DATA ELEMENT AND OUTPUT FORMAT FROM THE ORIGINAL FLD" S %=1 D YN^DICN
 G:%<0 ADDQ
 S IB=+IBDA(IB)
 S IBCOPY=$S(%+1#3:$O(^IBA(364.7,"B",IB,"")),1:"")
ADD1 K DO,DD,DINUM
 S DIC="^IBA(364.6,",DIC(0)="L",DLAYGO=364.6,X=IBCEXDA
 S Z=$O(^IBA(364.6,"A"),-1) S:Z<10000 Z=9999
 F LDINUM=Z+1:1 L +^IBA(364.6,LDINUM):1 I $T S DINUM=LDINUM Q
 S DIC("DR")=".02///L;.07////1;I '$G(IB) S Y=""@10"";.03////"_$G(IB)_";S Y=""@99"""
 S DIC("DR")=DIC("DR")_";@10;.04;I X="""" W !,""MUST HAVE A PAGE/SEQ"" S Y=""@10"";@20;.05;I X="""" W !,""MUST HAVE A FIRST LINE #"" S Y=""@20"";@30;.08;I X="""" W !,""MUST HAVE A STARTING COLUMN"" S Y=""@30"";@99"
 D FILE^DICN
 K DLAYGO,DO,DD,DINUM
 S $P(^IBA(364.6,0),U,3)=$O(^IBA(364.6,9999),-1) L -^IBA(364.6,LDINUM)
 K DIC,DO,DD,DLAYGO
 G:Y<0 ADDQ
 S IBDA=+Y
ADDQ I $G(IBDA) D EDITL(IBDA,"",1,$G(IBCOPY)),BLD^IBCEFG5
 S VALMBCK="R"
 Q
 ;
EDIT ; Edit a local form fld
 N IBEDIT,IBDA,IB
 D FULL^VALM1
 S IBEDIT=0
 D SEL(.IBDA)
 S IB=0 F  S IB=$O(IBDA(IB)) Q:'IB  W !!,"Form field: (#",IB,")",$S($P($G(^IBA(364.6,+IBDA(IB),0)),U,10)'="":" - "_$P(^(0),U,10),1:"") D
 .I $P($G(^IBA(364.6,+IBDA(IB),0)),U,2)="N" W " is a NATIONAL form field",! D NOEDIT("EDIT A NATIONAL FIELD FROM") Q
 .D VIEW^IBCEFG61(+IBDA(IB),+$O(^IBA(364.7,"B",+IBDA(IB),""))),EDITL(+IBDA(IB),IB) S IBEDIT=1
 D:IBEDIT BLD^IBCEFG5
 S VALMBCK="R"
 Q
 ;
EDITL(DA,FLD,NOASK,IBCOPY) ; Edit a local form fld #FLD in display whose ien is DA
 ; NOASK = 1, don't ask, just do it
 ; IBCOPY = IFN of entry in file 364.7 whose data element and format code
 ;          should be copied into this new entry
 S DIE="^IBA(364.6,",DR="[IBCE ADD/EDIT LOCAL FORM FIELD]" D ^DIE
 I '$G(NOASK) W !!,$S($D(^IBA(364.7,"B",DA)):"EDIT",1:"ADD")," FORM FIELD",$S($G(FLD):" #"_FLD,1:""),"'S CONTENT DEFINITION NOW" S %=2 D YN^DICN
 I $G(NOASK) W !!,"...Please define CONTENT of field...",! S %=1
 D:(%+1#3) CONTENT(DA,$G(IBCOPY))
 Q
 ;
VIEWF(IBDA) ;
 D SEL(.IBDA)
 D FULL^VALM1
 S IBDA=0 F  S IBDA=$O(IBDA(IBDA)) Q:'IBDA  W !!,"Definition of Form Field: (#",IBDA,")",$S($P($G(^IBA(364.6,+IBDA(IBDA),0)),U,10)'="":" - "_$P(^(0),U,10),1:"") D
 .D VIEW^IBCEFG61(+IBDA(IBDA),+$O(^IBA(364.7,"B",+IBDA(IBDA),""))),PAUSE^VALM1
 ;I IBCONT D BLD^IBCEFG5
 S VALMBCK="R"
 Q
 ;
CONTENT(IBDA,IBCOPY) ; Add/edit form fld definition content
 ; IBDA = corresponding entry in file 364.6 for definition being
 ;    added/edited.  If null, ask for selections from current screen
 ; IBCOPY = IFN of entry in file 364.7 whose data element and format code
 ;          should be copied into this new entry
 N IBCONT,DIPA
 D FULL^VALM1
 S IBCONT=0
 I $G(IBDA) D CONTED(IBDA,.IBCONT,$G(IBCOPY)) G CONTQ
 D SEL(.IBDA)
 S IBDA=0 F  S IBDA=$O(IBDA(IBDA)) Q:'IBDA  W !!,"Defining content of form field: (#",IBDA,")",$S($P($G(^IBA(364.6,+IBDA(IBDA),0)),U,10)'="":" - "_$P(^(0),U,10),1:"") D
 .I $P($G(^IBA(364.6,+IBDA(IBDA),0)),U,2)="N" W " is a NATIONAL form field",! D NOEDIT("EDIT A NATIONAL FIELD FROM") Q
 .D VIEW^IBCEFG61(+IBDA(IBDA),+$O(^IBA(364.7,"B",+IBDA(IBDA),""))),CONTED(+IBDA(IBDA),.IBCONT)
CONTQ I IBCONT D BLD^IBCEFG5
 S VALMBCK="R"
 Q
 ;
CONTED(IBDA,IBCONT,IBCOPY) ; Edit definition for ien IBDA
 ; IBDA = file 364.6 entry whose definition is being edited
 ; IBCONT = flag returned as 1 if a new associated form fld created,
 ;    forcing a regeneration of the display
 ; IBCOPY = IFN of entry in file 364.7 whose data element and format code
 ;          should be copied into this new entry
 N IBCECDA,DIC,DD,DO,DINUM,LDINUM,X,Y,Z
 S IBCECDA=$O(^IBA(364.7,"B",IBDA,""))
 I IBCECDA="" D  S:IBCECDA IBCONT=1
 .K DO,DD,DINUM
 .S DIC="^IBA(364.7,",DIC(0)="L",DLAYGO=364.7,DIC("DR")=".02////L;.07////N",X=IBDA
 .I $G(IBCOPY) S DIC("DR")=DIC("DR")_";.03////"_$P($G(^IBA(364.7,IBCOPY,0)),U,3)
 .S Z=$O(^IBA(364.7,"A"),-1) S:Z<10000 Z=9999
 .F LDINUM=Z+1:1 L +^IBA(364.7,LDINUM):1 I $T S DINUM=LDINUM Q
 .D FILE^DICN
 .S $P(^IBA(364.7,0),U,3)=$O(^IBA(364.7,9999),-1) L -^IBA(364.7,LDINUM)
 .K DIC,DO,DD,DINUM,DLAYGO
 .S:Y>0 IBCECDA=+Y
 .I $G(IBCOPY) S ^IBA(364.7,+Y,1)=$G(^IBA(364.7,IBCOPY,1)) M ^IBA(364.7,+Y,3)=^IBA(364.7,IBCOPY,3)
 Q:'IBCECDA
ED1 S DA=IBCECDA,DIE="^IBA(364.7,",DR="[IBCE EDIT FIELD CONTENT]" D ^DIE
 I $$EDCHK^IBCEFG60(IBCECDA) G ED1 ;Do edit checks,re-edit if indicated
 Q
 ;
VIEWEL(IBBASE) ; View a data element
 ; IBBASE = ien of the base file for the element to be viewed
 ;    if undef - any element can be selected
 N DIC,Y,IBBASE
 D FULL^VALM1
 W !!
 I $G(IBCEXDA) S IBBASE=+$G(^IBE(353,IBCEXDA,2))
 S:$G(IBBASE) DIC("S")="I $P(^(0),U,5)="_IBBASE S DIC="^IBA(364.5,",DIC(0)="AEMQ",DIC("A")="Select a DATA ELEMENT: " D ^DIC K DIC
 I Y>0 D VIEWE^IBCEFG61(+Y),PAUSE^VALM1
VIEWELQ S VALMBCK="R"
 Q
 ;
NOEDIT(FUNC,FLD) ; Write NO CHANGE msg for associated flds
 I $G(FLD) W !,"FORM FIELD #: ",FLD
 W !,*7,"YOU CANNOT ",FUNC," A NATIONALLY ASSOCIATED LOCAL FORM",!," - REDEFINE THE FIELD'S CONTENT BY USING A LOCAL FORM FIELD TO OVERRIDE"
 D PAUSE^VALM1
 Q
 ;
FNL ; Clean up
 K ^TMP("IBCEDEFDX",$J)
 D CLEAN^VALM10
 Q
 ;
SEL(IBDA,ONE) ; Select form fld entries from list
 D EN^VALM2($G(XQORNOD(0)),$S('$G(ONE):"",1:"S"))
 S IBDA=0 F  S IBDA=$O(VALMY(IBDA)) Q:'IBDA  S IBDA(IBDA)=+$P($G(^TMP("IBCEFLDDX",$J,IBDA)),U,2)
 Q
 ;
