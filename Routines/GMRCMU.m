GMRCMU ;SLC/DLT - Add protocols to GMRC protocol menus ;5/20/98  14:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
GMRCR ;Check if protocol is already an entry in GMRCR REQUEST TYPES, add if not.
 K DIC S DA(1)=$O(^ORD(101,"B","GMRCRM REQUEST TYPES",0)) G:'DA(1) END
 I $D(^ORD(101,DA(1),10,"B",GMRCPROI)) G END
 W !!,"Filing ",GMRCPRO," as an item in GMRCR REQUEST TYPES Protocol Menu"
 W !,"    enabling use of this item when ""Procedure..."" is selected on Add menus"
 S SEQ=$P(^ORD(101,DA(1),10,0),"^",3)+1
 S DIC="^ORD(101,"_DA(1)_",10,",DIC(0)="L"
 S DLAYGO=101,X=GMRCPRO D ^DIC
 W !!?6,"< Protocol filed. >",! G END
END K DA,DLAYGO,DIC,X,SEQ,SYN Q
