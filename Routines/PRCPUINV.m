PRCPUINV ;WISC/RFJ/DGL-inventory point selection ; 9/20/06 11:04am
V ;;5.1;IFCAP;**1,98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
INVPT(PRCPSITE,PRCPTYPE,ADDNEW,PRCPUSER,DEFAULT) ;  select inventory point
 ;  prcptype=w or p or s
 ;  addnew  =1 to add new inventory points
 ;  prcpuser=1 to screen and set user
 ;  default =default inventory point
 ;  return da; 0 no item selected; ^ for ^ entered or timeout
 I 'PRCPSITE!("WPS"'[PRCPTYPE) Q ""
 N %,D0,DA,DI,DIE,DG,DIC,DISYS,DLAYGO,DQ,DR,PRC,PRCPPRIV,X,Y
 S PRC("SITE")=PRCPSITE
 ;  do not allow adding new entries for whse if defined
 I PRCPTYPE="W" F %=0:0 S %=$O(^PRCP(445,"AC","W",%)) Q:'%  I +$G(^PRCP(445,%,0))=PRCPSITE S ADDNEW=0 Q
 S DIC="^PRCP(445,",DIC(0)="QEAM",DIC("A")="Select a '"_$S(PRCPTYPE="W":"Warehouse",PRCPTYPE="P":"Primary",1:"Secondary")_"' Type Inventory Point: "
 I DEFAULT'="" S DIC("B")=DEFAULT
 I ADDNEW S DIC(0)="QEALM",DLAYGO=445,DIC("DR")=".8;.7///"_PRCPTYPE_";.5//"_$S(PRCPTYPE="S":"NO",1:"YES")_";.6//"_$S(PRCPTYPE="S":"NO",1:"YES")_";"_$S(PRCPTYPE="S":"",1:".9;")
 S DIC("S")="I +^(0)=PRCPSITE,$P(^(0),U,3)=PRCPTYPE"_$S(PRCPUSER:",$D(^PRCP(445,+Y,4,+$G(DUZ),0))",1:""),PRCPPRIV=1
 W ! D ^DIC
 ;  if new entry added, add authorized user
 I $P(Y,"^",3),$G(DUZ),PRCPUSER D
 .   D ADDUSER^PRCPXTRM(+Y,DUZ)
 .   W !?2,"TYPE OF INVENTORY POINT: ",$S(PRCPTYPE="W":"WAREHOUSE",PRCPTYPE="P":"PRIMARY",1:"SECONDARY")
 Q $S($G(DUOUT):"^",$G(DTOUT):"^",Y<1:0,1:+Y)
 ;
 ;
TYPE ;  called from 445,.7 input transform.  you cannot have
 ;  multiple warehouses with the same station number
 N STATION,%
 S STATION=+$G(^PRCP(445,DA,0)),%=0
 F  S %=$O(^PRCP(445,"AC","W",%)) Q:'%  I %'=DA,+$G(^PRCP(445,%,0))=STATION W !?2,"YOU CANNOT HAVE MULTIPLE WAREHOUSES WITH THE SAME STATION NUMBER." K X Q
 Q
 ;
 ;
KILL(INVPT) ;  update all pointers when deleting an inventory point
 ; (invoked from 'DEL' node in .01 field of file 445)
 ; 
 N %,DATA,NAME,OUTORD,X
 S XP(1)="You cannot delete inventory points after they are created."
 S XP(2)="This action removes all the items, distribution points, users,"
 S XP(3)="etc., for the inventory point and changes the name to"
 S XP(4)="STATIONNUMBER-'***INACTIVE_#***' where # is the internal entry number."
 S XP="",XP(5)="",XP(6)="  ARE YOU SURE YOU WANT TO PROCEED"
 I $$YN^PRCPUYN(2)'=1 Q
 ;
 ; quit if this inventory point has outstanding distribution orders
 S DATA=$P(^PRCP(445,INVPT,0),"^",3) ; search for primary or secondary
 I DATA="P"!(DATA="S") D  I OUTORD Q
 . S OUTORD=$$ORDCHK^PRCPUITM(0,INVPT,"REC","")
 . I OUTORD D  Q
 . . D EN^DDIOL("You must first post or delete outstanding orders for this inventory point.")
 . . I +$G(DQ) S DE(+$G(DQ))=$P($G(^PRCP(445,INVPT,0)),"^",1)
 . . W !!
 ;
 ; if the inventory point is linked to a supply station
 I $P($G(^PRCP(445,INVPT,5)),"^",1)]"" D  Q
 . D EN^DDIOL("This inventory point is linked to a supply station.")
 . D EN^DDIOL("You must first delete the Supply Station Provider.")
 ; 
 W !?3,"Wait, deleting data, changing name, etc..."
 S DATA=$P($G(^PRCP(445,INVPT,5)),"^",1) ; supply station
 I DATA K ^PRCP(445,"AI",DATA,INVPT)
 ;  remove x-ref on inventory points
 S %=0 F  S %=$O(^PRCP(445,INVPT,2,%)) Q:'%  K ^PRCP(445,"AB",%,INVPT,%)
 ;  remove x-ref on inventory,ODI users ("AJ" (ODI) from PRC*5.1*98)
 S %=0 F  S %=$O(^PRCP(445,INVPT,4,%)) Q:'%  K ^PRCP(445,"AD",%,INVPT,%)
 S %=0 F  S %=$O(^PRCP(445,INVPT,9,%)) Q:'%  K ^PRCP(445,"AJ",%,INVPT,%)
 ;  remove x-ref on items
 S %=0 F  S %=$O(^PRCP(445,INVPT,1,%)) Q:'%  D
 . K ^PRCP(445,"AE",%,INVPT,%)
 . I DATA K ^PRCP(445,"AH",%,DATA,INVPT)
 ;  change name, etc
 S X=^PRCP(445,INVPT,0),NAME=$P(X,"^")
 S:$P(NAME,"-",2,99)="" $P(NAME,"-",2,99)=" "
 S:$P(X,"^",5)="" $P(X,"^",5)=" "
 K ^PRCP(445,"AF",+X,$P(X,"^",5),INVPT)
 K ^PRCP(445,"B",$P(X,"^"),INVPT)
 K ^PRCP(445,"C",$P(NAME,"-",2,99),INVPT)
 K ^PRCP(445,INVPT)
 S $P(NAME,"-",2,99)="***INACTIVE_"_INVPT_"***"
 S ^PRCP(445,"B",NAME,INVPT)=""
 S ^PRCP(445,"C",$P(NAME,"-",2),INVPT)=""
 S ^PRCP(445,INVPT,0)=NAME_"^N^"_$P(X,"^",3)_"^^^N"
 W !?5,"Name changed to: ",NAME
 ;
 W !?3,"Removing as a distribution point for the following inventory points:"
 S %=0 F  S %=$O(^PRCP(445,"AB",INVPT,%)) Q:'%  I $D(^PRCP(445,%,2,INVPT)) W !?5,$$INVNAME^PRCPUX1(%) K ^PRCP(445,%,2,INVPT) I $D(^PRCP(445,%,2,0)) S X=^(0) D
 .   S $P(X,"^",4)=$P(X,"^",4)-1 S:$P(X,"^",4)<0 $P(X,"^",4)=0 S:$P(X,"^",3)=INVPT $P(X,"^",3)="" S ^PRCP(445,%,2,0)=X
 K ^PRCP(445,"AB",INVPT)
 ;
 W !?3,"Removing link to the following fund control points:"
 S %=0 F  S %=$O(^PRC(420,"AE",%)) Q:'%  S PRC("SITE")=%,X=0 F  S X=$O(^PRC(420,"AE",%,INVPT,X)) Q:'X  W !?5,%,"-",X D DEL^PRCPUFCP(X,INVPT)
 I +$G(DQ) S DE(+$G(DQ))=NAME
 W !!
 Q
 ;
 ;PRCPUINV
