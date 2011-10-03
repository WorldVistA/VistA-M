IBCEFG60 ;ALB/TMP - OUTPUT FORMATTER-FORM FLD ACTION PROCESSING (CONT) ;28-JAN-96
 ;;2.0;INTEGRATED BILLING;**52,51**;21-MAR-94
 ;
DELETE ;
 N DIR,Y,IB,IBDA,IBDA1,IBDEL,IBAREC,Z,IB0,Q
 D FULL^VALM1
 S IBDEL=0
 D SEL^IBCEFG6(.IBDA)
 I $G(IBCEXDA) S IB=0 F  S IB=$O(IBDA(IB)) Q:'IB  W !! D
 .S IBDA=+IBDA(IB),IB0=$G(^IBA(364.6,IBDA,0))
 .I $P(IB0,U,2)="N" D NOEDIT^IBCEFG6("DELETE NATIONAL FIELDS FROM",IB) Q
 .S Q=$O(^IBA(364.6,"APAR",IBCEXDA,IBDA,""))
 . I Q,Q'=IBDA D  Q
 ..W !,*7,"Can't delete this field until all fields associated with it are deleted" D PAUSE^VALM1
 .S Z=$S($P(IB0,U,10)'="":" ("_$P(IB0,U,10)_")",1:"")
 .K DIR
 .S DIR(0)="YA",DIR("A")="Are you sure you want to DELETE LOCAL FORM FIELD #"_IB_Z_": ",DIR("B")="NO",DIR("A",1)="If you delete this form field, its content definition will",DIR("A",2)="   also be deleted"
 .D ^DIR K DIR
 .Q:$D(DIRUT)!('Y)  S IBDEL=1
 .S IBDA1=0 F  S IBDA1=$O(^IBA(364.7,"B",IBDA,IBDA1)) D  Q:'IBDA1
 ..I 'IBDA1 S DIK="^IBA(364.6,",DA=IBDA D ^DIK W "." Q
 ..S DIK="^IBA(364.7,",DA=IBDA1 W "." D ^DIK
 .W !!,"Form Field #",IB," Deleted"
 I IBDEL D PAUSE^VALM1,BLD^IBCEFG5
 S VALMBCK="R"
 Q
 ;
EDCHK(DA) ; Perform edit checks on content definition
 ; DA = ien of entry in file 364.7
 ; Returns 1 if user decides to re-edit due to warnings,
 ;         0 if no warnings or user does not want to re-edit
 N IBDA,IB0,IBINS,IBTYPE,WARN,IBX,REDO,IBDAP,IBFORM,IBFTYPE
 S (WARN,REDO)=0,IB0=$G(^IBA(364.7,DA,0)),IBDA=+IB0,IBDAP=$P($G(^IBA(364.6,+IB0,0)),U,3),IBINS=$P(IB0,U,5),IBTYPE=$P(IB0,U,6)
 S IBFORM=+$G(^IBA(364.6,IBDA,0)),IBFTYPE=$P($G(^IBE(353,IBFORM,2)),U,2)
 ;Check for missing data element/screen prompt
 I '$P(IB0,U,3),$P(IB0,U,4)="" S WARN(1)="",WARN=WARN+1
 G:'IBDAP ED1
 S IBX=0 F  S IBX=$O(^IBA(364.6,"APAR",IBFORM,IBDAP,IBX)) Q:'IBX  I IBX'=IBDA D
 .S IBX1=0 F  S IBX1=$O(^IBA(364.7,"B",IBX,IBX1)) Q:'IBX1  S IBX(IBX1)=$G(^IBA(364.7,IBX1,0))
 G:$O(IBX(""))="" ED1  ;No other override flds for the parent field
 ;Check for 2 fields for same ins co/bill type
 ;                   for same ins co/both bill type
 ;                   for same bill type/all ins companies
 ;                   for both bill type/all ins companies
 S IBX=0 F  S IBX=$O(IBX(IBX)) Q:'IBX  I $P(IBX(IBX),U,5)=IBINS,$P(IBX(IBX),U,6)=IBTYPE D  Q:$G(WARN(2))'=""
 . I 'IBINS,IBTYPE="",+IBX(IBX)=IBDAP Q  ; O/RIDE of 'ALL' default
 . S WARN(2)=$S(IBINS:IBINS,1:"ALL")_U_$S(IBTYPE'="":IBTYPE,1:"BOTH"),WARN=WARN+1 Q
ED1 I $O(WARN("")) D
 .W !!,*7,"The following problem",$S('WARN:"",1:"s")," exist for this definition:"
 .I $D(WARN(1)) W !,"  * DATA ELEMENT",$S(IBFTYPE'="S":" ",1:" OR SCREEN PROMPT "),"FOR FIELD IS MISSING - NO DATA WILL BE OUTPUT"
 .I $D(WARN(2)) W !,"  * MORE THAN ONE OVERRIDE FLD DEFINITION EXISTS FOR THE ASSOC FIELD FOR:",!,$J("",13),"INS CO: ",$$INS($P(WARN(2),U)),!,$J("",10),"BILL TYPE: ",$$BTYPE($P(WARN(2),U,2))
 .W !!,"WANT TO RE-EDIT THIS RECORD NOW?" S %=1 D YN^DICN S REDO=(%+1#3)
 Q REDO
 ;
BTYPE(X) ;RETURN INPT/OUTPT/ALL FOR BILL TYPE CODE IN X
 Q $S(X="BOTH":X,X="I":"INPT",X="O":"OUTPT",1:"??")
 ;
INS(X) ;RETURN NAME OF INSURANCE CO FOR CODE IN X
 Q $S(X="ALL":X,$P($G(^DIC(36,+X,0)),U)'="":$P(^(0),U),1:"??")
 ;
