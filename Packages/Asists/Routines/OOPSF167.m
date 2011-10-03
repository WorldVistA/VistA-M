OOPSF167 ;WIOFO/LLH-FIX FLD 167 FOR PATCH 8 ;6/30/2000 
 ;;2.0;ASISTS;;Jun 03, 2002
 ;
ENT ; loop thru ^OOPS(2260, if field 167 blank, prompt for data entry
 ; only for CA1 cases
 N IEN,INJ,DR,DA,DIC,DIE,DIR,OUT,Y
 S DIR("A",1)="Enter PAY RATE PER data for a single case or all cases."
 S DIR("A",2)=" PAY RATE PER field must be blank or have invalid data to access the record."
 S DIR("A")="Select 1 for ALL Cases, 2 for a Single Case:"
 S DIR(0)="SBX^1:ALL;2:SINGLE"
 D ^DIR
 I 'Y G EXIT
 I Y=2 D ONE G EXIT
 S IEN=0,OUT=""
 F  S IEN=$O(^OOPS(2260,IEN)) Q:(IEN'>0!($D(DTOUT))!(OUT))  D
 . S OUT="",INJ=$P($G(^OOPS(2260,IEN,0)),U,7)
 . I INJ=1 D
 .. I $$GET1^DIQ(2260,IEN,167)="" D
 ... W !,"Case: ",$$GET1^DIQ(2260,IEN,.01)
 ... W ?20,"Name: ",$$GET1^DIQ(2260,IEN,1,"E")
 ... S DIE="^OOPS(2260,",DA=IEN,DR="167"
 ... D ^DIE
 ... I $D(Y) S OUT=1
EXIT ; quit the routine
 Q
ONE ; only enter value for one case
 S DIC="^OOPS(2260,"
 S DIC("S")="I ($$GET1^DIQ(2260,Y,52,""I"")=1)&($$GET1^DIQ(2260,Y,167,""I"")="""")"
 S DIC(0)="AENZ",DIC("A")="   Select Case: "
 D ^DIC
 Q:Y<1
 Q:$D(DTOUT)!($D(DUOUT))
 S DA=$P(Y,U)
 S DIE="^OOPS(2260,",DR=167
 D ^DIE
 Q
