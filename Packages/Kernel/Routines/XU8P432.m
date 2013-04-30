XU8P432 ;ISF/RWF - Patch XU*8*432 Post-init ;6/13/07  08:44
 ;;8.0;KERNEL;**432**;Jul 10, 1995;Build 3
 QUIT
 ;
PRE ;Show if site has any
 N DA,CT
 S DA=0,CT=0
 F  S DA=$O(^VA(200,DA)) Q:DA'>0  D:'$D(^VA(200,DA,0))
 . W !,"^VA(200,",DA,",0) is missing the zero node."
 . S CT=CT+1
 . Q
 I CT>0 W !!,"There are a total of ",CT," entries without zero nodes.",!,"The Post-Init will clean them up."
 W !,"Done"
 Q
POST ;Clean-up any danging nodes in ^VA(200,DA,1.1) or ^VA(200,DA,203.1)
 N DA
 S DA=0
 F  S DA=$O(^VA(200,DA)) Q:DA'>0  D:'$D(^VA(200,DA,0))
 . I $D(^VA(200,DA,1.1)) K ^VA(200,DA,1.1) W !,"^VA(200,",DA,",1.1) cleaned"
 . I $D(^VA(200,DA,203.1)) K ^VA(200,DA,203.1) W !,"^VA(200,",DA,",203.1) cleaned"
 . Q
