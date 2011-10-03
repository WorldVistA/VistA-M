IB20PT2 ;ALB/CJM - CREATE FILE ENTRIES NEEDED BY THE ENCOUNTER FORM UTILITIES ;AUG 20,1993
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 ; - make an entry in the PACKAGE file for the import/export utility
 D MAKEPKG
 ;
 ; - make two required entries in the ENCOUNTER FORM file (#357)
 D MAKEFORM
 Q
 ;
 ;
MAKEPKG ; if the package entry for the import/export utility does not 
 ; already exist this will create one
 ;
 N NAME,PKG
 S NAME="IB ENCOUNTER FORM IMP/EXP"
 Q:$O(^DIC(9.4,"B",NAME,0))
 ;
 W !!,">>> Creating a PACKAGE (#9.4) file entry for the Encounter Form",!?4,"Import/Export Utility... "
 ;
 K DIC,DD,D0,DINUM S DIC="^DIC(9.4,",DIC(0)="",X=NAME
 D FILE^DICN K DIC,DIE,DA S PKG=+Y
 I PKG<0 W "Unable to create entry -- please call your supporting ISC." Q
 ;
 ;hard code the record
 ;
 S ^DIC(9.4,PKG,0)="IB ENCOUNTER FORM IMP/EXP^IBDE^The import/export utilities for encounter forms."
 S ^DIC(9.4,PKG,4,0)="^9.44PA^10^10"
 S ^DIC(9.4,PKG,4,1,0)="358"
 S ^DIC(9.4,PKG,4,1,222)="y^n^^n^^^y^o^n"
 S ^DIC(9.4,PKG,4,2,0)="358.1"
 S ^DIC(9.4,PKG,4,2,222)="y^n^^n^^^y^o^n"
 S ^DIC(9.4,PKG,4,3,0)="358.2"
 S ^DIC(9.4,PKG,4,3,222)="y^n^^n^^^y^o^n"
 S ^DIC(9.4,PKG,4,4,0)="358.3"
 S ^DIC(9.4,PKG,4,4,222)="y^n^^n^^^y^o^n"
 S ^DIC(9.4,PKG,4,5,0)="358.4"
 S ^DIC(9.4,PKG,4,5,222)="y^n^^n^^^y^o^n"
 S ^DIC(9.4,PKG,4,6,0)="358.5"
 S ^DIC(9.4,PKG,4,6,222)="y^n^^n^^^y^o^n"
 S ^DIC(9.4,PKG,4,7,0)="358.6"
 S ^DIC(9.4,PKG,4,7,222)="y^n^^n^^^y^o^n"
 S ^DIC(9.4,PKG,4,8,0)="358.7"
 S ^DIC(9.4,PKG,4,8,222)="y^n^^n^^^y^o^n"
 S ^DIC(9.4,PKG,4,9,0)="358.8"
 S ^DIC(9.4,PKG,4,9,222)="y^n^^n^^^y^o^n"
 S ^DIC(9.4,PKG,4,10,0)="358.91"
 S ^DIC(9.4,PKG,4,10,222)="y^n^^n^^^y^o^n"
 S ^DIC(9.4,PKG,5)="ALBANY"
 S ^DIC(9.4,PKG,11)="358^358.1"
 S ^DIC(9.4,PKG,22,0)="^9.49I^1^1"
 S ^DIC(9.4,PKG,22,1,0)="2.0^2930818^2930820"
 S ^DIC(9.4,PKG,"VERSION")="2.0"
 ;
 ;now index the package entry
 ;
 K DIK,DA S DIK="^DIC(9.4,",DA=PKG D IX1^DIK K DIK,DA
 W "done."
 Q
MAKEFORM ;creates two required tool kit forms - GARBAGE, and TOOL KIT
 ;
 N NAME,NODE
 S NAME="TOOL KIT",NODE="TOOL KIT^^Contains all of the tool kit blocks.^0^^^1^^132^80^4"
 D FORM
 S NAME="GARBAGE",NODE="GARBAGE^^Used as temporary storage for blocks while they are being edited.^0^^^1^^132^200^5"
 D FORM
 Q
 ;
FORM ;create the form - NAME and NODE should be defined
 N FORM
 ;if the form already exists, don't create another
 Q:$O(^IBE(357,"B",NAME,0))
 W !!,">>> Creating an entry in the ENCOUNTER FORM file (#357) required by the",!?4,"Encounter Form Utilities... "
 K DIC,DD,DO,DINUM S DIC="^IBE(357,",X=NAME,DIC(0)=""
 D FILE^DICN K DIC,DIE S FORM=+Y
 I FORM<0 W "Unable to create entry -- please call your supporting ISC." Q
 ;
 ;copy old 0 node into the new form
 S ^IBE(357,FORM,0)=NODE
 ;
 ;now index it
 K DIK,DA S DA=FORM,DIK="^IBE(357," D IX1^DIK K DIK,DA
 W "done"
 Q
