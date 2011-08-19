PXRMCFED ; SLC/PKR - Edit a reminder computed finding. ;06/19/2001
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;======================================================
 N CS1,CS2,DA,DIC,DLAYGO,DTOUT,DUOUT,Y
GETNAME ;Get the name of the computed finding to edit.
 ;Make sure the user has programmer access.
 I DUZ(0)'="@" D  Q
 . W !!,"Only those with programmer's access can perform this function."
 K DA,DIC,DLAYGO,DTOUT,DUOUT,Y
 S DIC="^PXRMD(811.4,"
 S DIC(0)="AEMQL"
 S DIC("A")="Select Reminder Computed Finding: "
 S DIC("S")="I $P(^(0),U,1)'[""VA-"""
 S DLAYGO=811.4
 ;Set the starting place for additions.
 D SETSTART^PXRMCOPY(DIC)
 W !
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT)) Q
 I Y=-1 G END
 S DA=$P(Y,U,1)
 S CS1=$$FILE^PXRMEXCS(811.4,DA)
 D EDIT(DIC,DA)
 S CS2=$$FILE^PXRMEXCS(811.4,DA)
 I CS2=0 Q
 I CS2'=CS1 D SEHIST^PXRMUTIL(811.4,DIC,DA)
 G GETNAME
END ;
 Q
 ;
 ;======================================================
EDIT(ROOT,DA) ;
 N DIE,DR,DIDEL
 S DIE=ROOT,DIDEL=811.4
 S DR="[PXRM EDIT REMINDER CF]"
 D ^DIE
 Q
 ;
