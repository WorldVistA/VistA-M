OROTHBTN ;SLC/SS/RM/JC - OTH LOCAL MESSAGE ; 02/19/2021  09:11
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**546**;Dec 17, 1997;Build 24
 ; 
 ; ICR#     TYPE    DESCRIPTION
 ; ---------------------------------
 ; 2685     PRI     OE/RR Direct Access to File ^XTV(8989.51
 ;
 Q
LOCMSG ; Add/Edit Local Message on OTH Button
 N LOCMSG1,LOCMSG2,DIE,DA,DR,ARRAY,ARRAY2,DIC,X,LOCIEN,LOCDFLT
 S LOCDFLT="Call Registration Team for Details. "
 S DIC="^XTV(8989.51,",DIC(0)="QEZ",X="OR OTH BTN LOCAL MSG"
 D ^DIC
 S LOCIEN=$P($G(Y),"^")
 D GETS^DIQ(8989.51,LOCIEN_",","**","","ARRAY")
 W #!,"Add/Edit Text for Display in OTH Button in CPRS",!
 W "-----------------------------------------------",!
 W "The text 'Call Registration Team for Details.' will always be displayed."
 W !,"It cannot be edited or deleted.",!
 W !,"All messages will display like this:"
 W !,"Call Registration Team for Details. Optional Line 1"
 W !,"Optional Line 2"
 W !!,"Current Local Message: ",!
 S LOCMSG1=$G(ARRAY(8989.51,LOCIEN_",","20",1))
 S LOCMSG2=$G(ARRAY(8989.51,LOCIEN_",","20",2))
 W $G(LOCDFLT)_$G(LOCMSG1),!
 W $G(LOCMSG2),!
LOCLINE ; Return here if input is too long
 N LOCREAD1,LOCREAD2,LOCKEEP,LOCMSG,DIR,DTOUT,DUOUT
 N LOCNO
 S LOCNO=0,DTIME=$S($G(DTIME)>300:300,1:$G(DTIME))
 W !!
 S DIR(0)="FAO^0:24",DIR("A")="  Enter Line 1 (optional, 24 char max): "
 S DIR("B")=$G(LOCMSG1)
 S DIR("T")=60
 S DIR("?")="Enter up to 24 characters. "
 S DIR("?",1)="The text 'Call Registration Team for Details.' will be displayed"
 S DIR("?",2)="regardless of whether the user enters any further lines of data."
 S DIR("?",3)="It cannot be edited or deleted."
 S DIR("?",4)="You may optionally enter or edit text to display in CPRS."
 S DIR("?",5)="Line 1 has a maximum of 24 characters."
 S DIR("??")="^D HELP^OROTHBTN"
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) Q
 S LOCREAD1=$G(X)
 I $G(LOCREAD1)="^" Q
 I $G(LOCREAD1)="@" S LOCREAD1="",LOCNO=$$REMOVE(1,.LOCMSG)
 I $G(LOCNO)=0,$G(X)="@" S LOCREAD1=$G(LOCMSG1)
LOCLINE2 ;
 N DIR,LOCNO2,DTOUT,DUOUT
 S (LOCNO,LOCNO2)=0,DTIME=$S($G(DTIME)>300:300,1:$G(DTIME))
 W !!
 S DIR(0)="FAO^0:70",DIR("A")="  Enter Line 2 (optional, 70 char max): "
 S DIR("B")=$G(LOCMSG2)
 S DIR("T")=60
 S DIR("?")="Enter up to 70 characters. "
 S DIR("?",1)="The text 'Call Registration Team for Details.' will be displayed"
 S DIR("?",2)="regardless of whether the user enters any further lines of data."
 S DIR("?",3)="It cannot be edited or deleted."
 S DIR("?",4)="You may optionally enter or edit text to display in CPRS."
 S DIR("?",5)="Line 2 has a maximum of 70 characters."
 S DIR("??")="^D HELP^OROTHBTN"
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) Q
 S LOCREAD2=$G(X)
 I $G(LOCREAD2)="^" Q
 I $G(LOCREAD2)="@" S LOCREAD2="",LOCNO2=$$REMOVE(2,.LOCMSG)
 I $G(LOCNO2)=0,$G(X)="@" S LOCREAD2=$G(LOCMSG2)
 W !
 S LOCMSG(1)=$G(LOCREAD1)
 S LOCMSG(2)=$G(LOCREAD2)
 D WP^DIE(8989.51,LOCIEN_",",20,"","LOCMSG","DGMTERR")
 Q
 ;
HELP ; Long help text for ??
 W !,""
 W !,"The text 'Call Registration Team for Details.' will be displayed"
 W !,"regardless of whether the user enters any further lines of data."
 W !,"It cannot be edited or deleted."
 W !
 W !,"You may optionally add up to 2 additional lines of text"
 W !,"to be displayed in the OTH button in CPRS when it is"
 W !,"populated for a patient."
 W !
 W !,"Line 1 has a maximum of 24 characters."
 W !,"If a value is given for Line 1, it will be concatenated to the end"
 W !,"of 'Call Registration Team for Details.'"
 W !!,"Line 2 has a maximum of 70 characters."
 W !!,"All messages will display like this:"
 W !,"Call Registration Team for Details. Optional Line 1"
 W !,"Optional Line 2"
 Q
 ;
REMOVE(LINE,LOCMSG) ;-- sure you want to delete?
 N X,Y,DIR,DA
 S DIR(0)="YA",DIR("A")="  Are you sure you want to delete this line? "
 S DIR("B")="NO" W $C(7)
 D ^DIR
 S X=$$UP^XLFSTR(X)
 I $G(X)="N"!($G(X)="NO") S LOCNO=0
 I $G(X)="Y"!($G(X)="YES") S LOCNO=1
 Q LOCNO
 ;
