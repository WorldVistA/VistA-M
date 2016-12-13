IBJPC3 ;ALB/YMG - IBJP HCSR Wards/Clinics association with Payer ;10-JUN-2015
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
 Q
 ;
ADDPYR(WHICH) ; Add payer association
 ; WHICH = 1 - use Clinic Search inclusion list
 ;         2 - use Ward Search inclusion list
 ;
 N ANOTHER,DA,DIC,DLAYGO,DO,DTOUT,DUOUT,IEN,NODE,REFRESH,X,Y
 S VALMBCK="R"
 D FULL^VALM1
 S IEN=$$SELEVENT^IBTRH1(0,"","",0,"IBJPC1IX") I '+IEN Q
 S NODE=$S(WHICH=1:63,1:64)
 S REFRESH=$$ADDPYR1(NODE,IEN)
 I REFRESH D INIT^IBJPC1(WHICH)
 Q
 ;
ADDPYR1(NODE,IEN) ; Add payer association to a given clinic / ward
 ; NODE = 63 - for Clinic Search inclusion list
 ;        64 - for Ward Search inclusion list
 ;
 ; IEN - IEN in sub-file 350.963 for clinics or 350.964 for wards
 ;
 ; returns 1 if screen refresh is necessary, 0 otherwise
 ;
 N ANOTHER,DA,DIC,DLAYGO,DO,DTOUT,DUOUT,REFRESH,X,Y
 I NODE'>0!(IEN'>0) Q
 D DISPPYR(NODE,IEN)
 S REFRESH=0 S:$$ASKALL(NODE,IEN,"YES") REFRESH=1
 ;
 I '$$ISALL(NODE,IEN) D:REFRESH DISPPYR(NODE,IEN) S ANOTHER=1 F  D  Q:$G(DTOUT)!($G(DUOUT))  Q:'ANOTHER
 .S DIC=365.12,DIC(0)="AOEMQ",DIC("A")="Select Payer: "
 .S DIC("S")="I '$O(^IBE(350.9,1,"_NODE_","_IEN_",1,""B"",Y,""""))"
 .D ^DIC I +Y'>0 S ANOTHER=0 Q
 .S DIC="^IBE(350.9,1,"_NODE_","_IEN_",1,"
 .S DIC(0)="L",DA(1)=IEN,DA(2)=1,X=+Y,DLAYGO=$S(WHICH=1:350.9631,1:350.9641)
 .K DO D FILE^DICN
 .I '$G(DTOUT)&('$G(DUOUT)) S:+Y>0 REFRESH=1 W !,$S(+Y>0:"Payer added to the list.",1:"Unable to add payer.")
 .Q 
 Q REFRESH
 ;
DELPYR(WHICH) ; Delete payer association
 ; WHICH = 1 - use Clinic Search inclusion list
 ;         2 - use Ward Search inclusion list
 ;
 N ANOTHER,DA,DIC,DIK,DTOUT,DUOUT,IEN,NODE,REFRESH,X,Y
 N IEN,NODE
 S VALMBCK="R",REFRESH=0
 D FULL^VALM1
 S IEN=$$SELEVENT^IBTRH1(0,"","",0,"IBJPC1IX") I '+IEN Q
 S NODE=$S(WHICH=1:63,1:64)
 D DISPPYR(NODE,IEN)
 S:$$ASKALL(NODE,IEN,"NO") REFRESH=1
 ;
 I '$$ISALL(NODE,IEN),$$GETTOT(NODE,IEN)>0 D
 .S ANOTHER=1 D:REFRESH DISPPYR(NODE,IEN) F  D  Q:$G(DTOUT)!($G(DUOUT))!($$GETTOT(NODE,IEN)'>0)  Q:'ANOTHER
 ..S (DIC,DIK)="^IBE(350.9,1,"_NODE_","_IEN_",1,",DIC(0)="AOEMQ",DIC("A")="Select Payer: " D ^DIC
 ..I +Y'>0 S ANOTHER=0 Q
 ..S DA(1)=IEN,DA(2)=1,DA=+Y D ^DIK W !,"Payer deleted from the list." S REFRESH=1
 ..Q
 .Q
 I REFRESH D INIT^IBJPC1(WHICH)
 Q
 ;
DISPPYR(NODE,IEN) ; Display payer association
 ; NODE = 63 - for Clinic Search inclusion list
 ;        64 - for Ward Search inclusion list
 ;
 ; IEN - IEN in sub-file 350.963 for clinics or 350.964 for wards
 ;
 N ISALL,PYRNAME,PYRPTR,TOTAL,Z
 I '+$G(IEN)!('+$G(NODE)) Q
 S ISALL=$$ISALL(NODE,IEN),TOTAL=$$GETTOT(NODE,IEN)
 W !!,$S(WHICH=1:"Clinic",1:"Ward")," is currently included in the list for ",$S(ISALL:"all payers.",'ISALL&('TOTAL):"no payers",1:"the following "_TOTAL_" payers:"),!
 I 'ISALL S Z=0 F  S Z=$O(^IBE(350.9,1,NODE,IEN,1,Z)) Q:'Z  D
 .S PYRPTR=+$P(^IBE(350.9,1,NODE,IEN,1,Z,0),U) I PYRPTR W !,$P(^IBE(365.12,PYRPTR,0),U)
 .Q
 W !
 Q
 ;
ASKALL(NODE,IEN,DEF) ; Prompt for association with all payers
 ; NODE = 63 - for Clinic Search inclusion list
 ;        64 - for Ward Search inclusion list
 ;
 ; IEN - IEN in sub-file 350.963 for clinics or 350.964 for wards
 ; DEF - default for the prompt ("YES" or "NO")
 ;
 ; returns 1 if value of .02 field has changed, 0 otherwise
 ;
 N DA,DIE,DR,DTOUT,VAL,X,Y
 S VAL=$$ISALL(NODE,IEN)
 S DIE="^IBE(350.9,1,"_NODE_",",DA=IEN,DR=".02//"_DEF D ^DIE
 Q $S(VAL=$$ISALL(NODE,IEN):0,1:1)
 ;
ISALL(NODE,IEN) ; Check association with all payers
 ; NODE = 63 - for Clinic Search inclusion list
 ;        64 - for Ward Search inclusion list
 ;
 ; IEN - IEN in sub-file 350.963 for clinics or 350.964 for wards
 ;
 ; Returns 1 if clinic/ward is associated with all payers, 0 otherwise
 N RES
 S RES=0 I +$G(IEN)&(+$G(NODE)) S RES=+$P($G(^IBE(350.9,1,NODE,IEN,0)),U,2)
 Q RES
 ;
GETTOT(NODE,IEN) ; Returns total number of payers associated with clinic/ward.
 ; NODE = 63 - for Clinic Search inclusion list
 ;        64 - for Ward Search inclusion list
 ;
 ; IEN - IEN in sub-file 350.963 for clinics or 350.964 for wards
 ;
 N RES
 S RES=0 I +$G(IEN)&(+$G(NODE)) S RES=+$P($G(^IBE(350.9,1,NODE,IEN,1,0)),U,4)
 Q RES
