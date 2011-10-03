IBDF6C ;ALB/CJM - ENCOUNTER FORM - (deleting setup, editing form name) ;JAN 16,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
DSETUP ;allows user to select a form, then removes it from the clinic setup
 N SEL,IBFORM,SETUP
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL=$O(VALMY("")),(IBFORM,VALMBCK)=""
 I SEL S SEL=$G(@VALMAR@("IDX",2*SEL,SEL)),IBFORM=+SEL
 I IBFORM D
 .S VALMBCK="R"
 .K DA S DA=$O(^SD(409.95,"B",+$G(IBCLINIC),"")) Q:'DA
 .S SETUP=$G(^SD(409.95,DA,0)) Q:SETUP=""
 .S DR=$P(SEL,"^",2)_"////@"
 .K DIE S DIE=409.95 D ^DIE K DIE,DR,DA
 .X IBAPI("INDEX")
 Q
EDITFORM ;allows user to select a form, then edit its name, description,  and size
 N IBFORM,IBDELETE,IBSCAN,IBOLD ;IBDELETE,IBSCAN,IBOLD appear in the input template
 I $G(IBAPI("SELECT"))'="" X IBAPI("SELECT")
 S VALMBCK="R"
 I IBFORM D
 .D UNCMPALL^IBDF19(IBFORM)
 .D FULL^VALM1
 .S VALMBCK="R"
 .K DA,DR,DIE S DA=IBFORM
 .S DR="[IBDF EDIT OLD OR COPIED FORM]"
 .S IBOLD=$S($P($G(^IBE(357,IBFORM,0)),"^",16):0,1:1)
 .S DIE=357 D ^DIE K DIE,DR,DA
 .X IBAPI("INDEX")
 Q
