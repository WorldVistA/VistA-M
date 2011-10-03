IBEMTSCU ;ALB/RFJ-print billable types for visit copay ;23 Nov 01
 ;;2.0;INTEGRATED BILLING;**167,177,187**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
EFFDT() ;effect date Visit Copay 2
 Q 3021001  ;OCT 1,2002
 ;
ADD(IBSTOPCD,IBEFFDT,IBBILTYP,IBDESC,IBOVER) ;  add a stop code to file 352.5
 ;  ibstopcd = 3 or 6 digit stop code to add
 ;  ibeffdt  = effective date, internal fileman form (ex:3011206)
 ;             if effective date is not passed, it uses today (dt)
 ;  ibbiltyp = billable type (B=basic, S=specialty, N=non-billable)
 ;             default is non-billable if a B or S is not passed
 ;  ibdesc   = description of stop code
 ;  ibover   = if the code belongs to Override table
 ;  returns 1 if added, -#^error if not added
 ;
 N D,D0,DA,DI,DIC,DIE,DLAYGO,DQ,DR,IBDA,X,Y,IBZ
 ;
 ;  check length of stop code
 I '(($L(IBSTOPCD)=3)!($L(IBSTOPCD)=6)) Q "-1^STOP CODE "_IBSTOPCD_" NOT 3 OR 6 CHARACTERS IN LENGTH."
 ;
 ;  change billable type code to match set of codes in file 352.5
 S IBBILTYP=$S(IBBILTYP="B":1,IBBILTYP="S":2,1:0)
 ;
 S (DIC,DIE)="^IBE(352.5,",DIC(0)="L",DLAYGO=352.5
 ;
 ;  check to see if entry is in the file
 S IBDA=$O(^IBE(352.5,"AEFFDT",IBSTOPCD,-IBEFFDT,0))
 I IBDA S IBZ=$G(^IBE(352.5,IBDA,0)) D  Q 1
 .   S DR=""
 .   ;  check to see if the correct billable type is set correctly
 .   I $P(IBZ,"^",3)'=IBBILTYP S DR=".03////"_IBBILTYP_";"
 .   ;  check description
 .   I $P(IBZ,"^",4)'=$E(IBDESC,1,30) S DR=DR_".04////"_$E(IBDESC,1,30)
 .   ;  if not, change it
 .   I $L(DR) S DA=IBDA D ^DIE
 ;
 ;  add entry to file 352.5
 S X=IBSTOPCD
 S DIC("DR")=".02////"_IBEFFDT_";.03////"_IBBILTYP_";.04////"_$E(IBDESC,1,30)_";"
 S:$G(IBOVER)=1 DIC("DR")=DIC("DR")_".05////1;"
 D FILE^DICN
 Q 1
 ;
 ;
DIQ407(DA,DR) ;  diq call to retrieve data for dr fields in file 40.7
 N D0,DIC,DIQ,DIQ2,YY
 K IBSCDATA(40.7,DA)
 I $G(DR)="" S DR=".01:4;"
 S DIQ(0)="IE",DIC="^DIC(40.7,",DIQ="IBSCDATA" D EN^DIQ1
 Q
 ;
 ;0 - active
ISINACT(IBCODE) ;
 Q:$L(IBCODE)=6 $$INACTIVE($E(IBCODE,1,3))+$$INACTIVE($E(IBCODE,4,6))
 Q $$INACTIVE(IBCODE)
 ;
INACTIVE(IBSTCODE) ;  return 1 if inactive in file 40.7
 ;  also, return ibscdata(da for stop code entries in 40.7)
 N DA,IBSCDATA,RESULT
 ;
 ;  default is inactive
 S RESULT=1
 ;
 S DA=0 F  S DA=$O(^DIC(40.7,"C",IBSTCODE,DA)) Q:'DA  D
 . D DIQ407(DA,2)
 . I 'IBSCDATA(40.7,DA,2,"I") S RESULT=0
 ;
 Q RESULT
 ;
 ;
ASK() ; ask if the user wants to enter a stop code or select a clinic
 ; return will be what entry point to use
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="S^C:Clinic;S:Stop Code" D ^DIR
 Q $S(Y="C":"C",Y="S":"S",1:"")
 ;
ASKSCODE(IBPROMPT) ;  ask and return selected stop code from file 352.5
 ;  ibprompt = optional prompt to display
 ;
 N DIC,DILN,I,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIC="^IBE(352.5,",DIC(0)="QEAM"
 S DIC("A")="Select OUTPATIENT VISIT STOP CODE: "
 I $G(IBPROMPT)'="" S DIC("A")=IBPROMPT
 S DIC("S")="I $$STOPSCRN^IBEMTSCU(Y)"
 ;
 W ! D ^DIC
 I Y<1 Q -1
 Q +Y
 ;
 ;
STOPSCRN(IBX) ; screens out so only active and current ones are selectable
 ;
 ; if we have no from date, all are selectable
 I '$G(IBFR) Q 1
 ;
 N IBZ,IBAX,IBS,IBEFFDT
 S IBZ=$G(^IBE(352.5,IBX,0)),IBS=$P(IBZ,"^")
 ;
 ; is the effective date for this entry in the future?
 I $P(IBZ,"^",2)>IBFR Q 0
 ;
 ;  get the effective date for stop code and visit date
 S IBEFFDT=$O(^IBE(352.5,"AEFFDT",IBS,-(IBFR+.1)))
 I 'IBEFFDT Q 0
 ;
 ;  get the billable entry to compare
 S IBAX=$O(^IBE(352.5,"AEFFDT",IBS,IBEFFDT,0))
 ;
 Q $S(IBX=IBAX:1,1:0)
 ;
ASKSC(IBVISTDT) ; ask for a clinic to look up the stop code
 ; it will prompt for a clinic selection, and return the stop
 ; code number in 352.5 associated with the clinic
 N DIC,X,Y,IB407,IBEFDT,IBCLIN
 S DIC="^SC(",DIC(0)="AEMQZ",DIC("A")="Select CLINIC: ",DIC("S")="I $P(^(0),U,3)=""C""" D ^DIC Q:Y<1 -1
 S IBCLIN=+Y
 ;primary
 S IB407=$P(Y(0),"^",7)
 S IBCODE1=$$GETCODE(IB407)
 ; if < eff date
 Q:IBVISTDT<$$EFFDT() $$GET3525(+IBCODE1,0,IBVISTDT)
 ;secondary
 ; get the secondary stop code value
 S IBCODE2=$$GETCRED(IBCLIN)
 ;return proper IEN of #352.5
 Q +$$GET3525(IBCODE1,IBCODE2,IBVISTDT)
 ;
 ;
GETTYPE(IBSTOPCD,IBVISTDT) ;  lookup billable type
 ;  input ibstopcd = stop code (.01 field entry in file 352.5)
 ;        ibvistdt = visit date in fileman format
 ;
 ;  returns     -1 = stop code/effective date not found or defined
 ;               0 = non-billable
 ;               1 = basic rate
 ;               2 = specialty rate
 ;
 N DA,IBEFFDT,RESULT
 ;
 ;  get the effective date for stop code and visit date
 S IBEFFDT=$O(^IBE(352.5,"AEFFDT",IBSTOPCD,-(IBVISTDT+.1)))
 I 'IBEFFDT Q -1
 ;
 ;  get the billable type
 S DA=$O(^IBE(352.5,"AEFFDT",IBSTOPCD,IBEFFDT,0))
 I 'DA Q -1
 ;
 ;  get the billable type
 S RESULT=+$P($G(^IBE(352.5,DA,0)),"^",3)
 Q RESULT
 ;
 ;
GETSC(IBSL,IBVISTDT) ;  return the ien of the entry in file 352.5.
 ;  ibsl is the clinic stop code in 409.68.  find the matching
 ;  entry in file 352.5.  the 352.5 entry is populated in the 350 field
 ;  for reference using the ibstopda variable
 ;    input ibsl = 409.68:ien
 N IB407,IBCLIN,IBCODE1,IBCODE2
 I $P(IBSL,":")'=409.68 Q ""
 ;primary
 ;this is the ien for file 40.7 (dbia402)
 S IB407=+$P($G(^SCE(+$P(IBSL,":",2),0)),"^",3)
 ;get the primary stop code value
 S IBCODE1=+$$GETCODE(IB407)
 ;if < eff date
 Q:IBVISTDT<$$EFFDT() $$GET3525(+IBCODE1,0,IBVISTDT)
 ;secondary
 ;get clinic(#44) pointer from #409.68
 S IBCLIN=+$P($G(^SCE(+$P(IBSL,":",2),0)),"^",4)
 ;get the secondary stop code value
 S IBCODE2=+$$GETCRED(IBCLIN)
 ;return proper IEN of #352.5
 Q $$GET3525(+IBCODE1,+IBCODE2,IBVISTDT)
 ;
 ;apply business rules, select appropr. code in #352.5 and return its IEN
 ;if  not found then return ""
GET3525(IBCODE1,IBCODE2,IBVISTDT) ;
 Q:+IBCODE1=0 ""  ;must be defined as a required field in #44
 Q:$L(+IBCODE1)'=3!(IBCODE1<0) ""
 I $L(+IBCODE2)'=3!(IBCODE2<0) S IBCODE2=0
 N IB6DIG
 N IBEFDT1,IBIEN1,IBOVER1,IBTYPE1
 N IBEFDT2,IBIEN2,IBOVER2,IBTYPE2
 S (IBIEN1,IBIEN2,IBOVER1,IBOVER2)=0
 ;------ find appropriate ien in file #352.5
 S IB6DIG=$S(IBCODE2>0:IBCODE1_IBCODE2,1:IBCODE1)
 ;in the #352.5 with appropriate eff date?
 S IBEFDT1=+$O(^IBE(352.5,"AEFFDT",IB6DIG,-(IBVISTDT+.1)))
 ;
 ;A) if found and it is 6 or 3 digit code
 I IBEFDT1 D  Q:IBIEN1>0 IBIEN1
 . ;get the entry in 352.5 
 . S IBIEN1=+$O(^IBE(352.5,"AEFFDT",IB6DIG,IBEFDT1,0))
 ;
 ;B) if not found and it is 3 digit - return nothing, BASIC applies
 I +IBCODE2=0 Q ""
 ;
 ;C) if not found and it is 6 digit - try each separately
 ;-- primary code
 ;in the #352.5 "override" tables with appropriate eff date?
 S IBEFDT1=+$O(^IBE(352.5,"AEFFDT",IBCODE1,-(IBVISTDT+.1)))
 I IBEFDT1 D
 . ;get the entry in 352.5 
 . S IBIEN1=+$O(^IBE(352.5,"AEFFDT",IBCODE1,IBEFDT1,0))
 . Q:IBIEN1=0
 . S IBOVER1=+$P($G(^IBE(352.5,IBIEN1,0)),"^",5)
 . S IBTYPE1=+$P($G(^IBE(352.5,IBIEN1,0)),"^",3)
 ;-- secondary code
 ;in the #352.5 "override" tables with appropriate eff date?
 S IBEFDT2=+$O(^IBE(352.5,"AEFFDT",IBCODE2,-(IBVISTDT+.1)))
 I IBEFDT2 D
 . ;get the entry in 352.5 
 . S IBIEN2=+$O(^IBE(352.5,"AEFFDT",IBCODE2,IBEFDT2,0))
 . Q:IBIEN2=0
 . S IBOVER2=+$P($G(^IBE(352.5,IBIEN2,0)),"^",5)
 . S IBTYPE2=+$P($G(^IBE(352.5,IBIEN2,0)),"^",3)
 ;
 ; If not found in override tables 
 ; - AND primary is not in #352.5 then return nothing, BASIC applies
 ; - AND primary is in #352.5 then return IBIEN1
 I IBOVER1=0,IBOVER2=0 Q $S(IBIEN1>0:IBIEN1,1:"")
 ;
 I IBOVER1=0,IBOVER2'=0 Q +IBIEN2
 ;
 I IBOVER1'=0,IBOVER2=0 Q +IBIEN1
 ;
 ; If IBOVER1'=0,IBOVER2'=0
 I IBTYPE1=0 Q +IBIEN1  ;NON
 I IBTYPE2=0 Q +IBIEN2  ;NON
 I IBTYPE1=2 Q +IBIEN1  ;SPEC
 I IBTYPE2=2 Q +IBIEN2  ;SPEC
 Q +IBIEN1  ;BASIC
 ;
 ;
OPT ;  perform outpatient copay edits for visits after 11/29/01
 ;  called from IBECEA3
 ;
 ;  return IBSTOPDA (if selected) to be stored in file 350
 K IBSTOPDA,IBANS
 ;
 ;  ask selection by clinic or stop code
 S IBANS=$$ASK I '$L(IBANS) W !!,"Charge NOT added." S IBY=-1 Q
 ;
 ;  ask clinic stop to calc charges
 S IBSTOPDA=+$S(IBANS="S":$$ASKSCODE,1:$$ASKSC(IBFR))
 I IBSTOPDA<0 S IBY=-1 W !!,"Charge NOT added." K IBSTOPDA Q
 ;
 ;  user selected a non-billable clinic stop
 I IBSTOPDA>0,'$P($G(^IBE(352.5,IBSTOPDA,0)),"^",3) W !?5,"********** This is a NON-BILLABLE Clinic Stop **********",!?5,"Select an active billable clinic stop or press RETURN to exit." G OPT
 ;  user selected an inactive stop code
 I IBSTOPDA>0,$$ISINACT($P($G(^IBE(352.5,IBSTOPDA,0)),"^")) W !?5,"********** This is a INACTIVE Clinic Stop in file #40.7 **********",!?5,"Select an active billable clinic stop or press RETURN to exit." G OPT
 ;
 ;  *** get the charge ***
 ;  return IBTO, IBUNIT, IBEVDA, IBCHG for processing in IBECEAU3
 N IBDT,IBTYPE,IBX
 S (IBDT,IBTO)=IBFR       ;visit date
 S IBX="O" ;O for outpatient
 S IBUNIT=1,IBEVDA="*"
 S IBTYPE=1 ;BASIC by default
 S:IBSTOPDA>0 IBTYPE=$P(^IBE(352.5,IBSTOPDA,0),"^",3)  ;type of charge, basic or specialty
 D TYPE^IBAUTL2
 I IBY<0 Q
 ;
 W !!,"Charge to be billed under the ",$$TYPE^IBEMTSCR($P($G(^IBE(352.5,IBSTOPDA,0)),"^",3))," Rate --> $",$J(IBCHG,0,2)
 Q
 ;
 ;Get credit pair (secondary code) from #44
GETCRED(IBCLIN) ;
 N IB407
 ; get credit pair (secondary stop code pointer) from #44
 S IB407=+$P($G(^SC(IBCLIN,0)),"^",18)
 ; if IB407 is defined, get the stop code in IBSCDATA(40.7,IB407,1,"E")
 Q $$GETCODE(IB407)
 ;
GETCODE(IB407) ;
 ; get the stop code in IBSCDATA(40.7,IB407,1,"E")
 N IBCODE,IBSCDATA
 S IBCODE=0
 I IB407'=0 D DIQ407(IB407,1) D
 . I $G(IBSCDATA(40.7,IB407,1,"E"))="" Q
 . S IBCODE=+$G(IBSCDATA(40.7,IB407,1,"E"))
 . S:$L(+IBCODE)'=3!(IBCODE<0) IBCODE=0
 Q IBCODE
 ;
