OOPSCA ;HINES CIOFO/GWB-CREATE ASISTS AMENDMENT ;3/5/98
 ;;2.0;ASISTS;;Jun 03, 2002
 N DLAYGO
SUP S DIC="^OOPS(2260,",DIC("S")="I ($P(^OOPS(2260,Y,0),U,8)=DUZ)!($P(^OOPS(2260,Y,0),U,9)=DUZ),$P(^OOPS(2260,Y,0),U,6)=0" G DIC
SO S DIC="^OOPS(2260,",DIC("S")="I $P(^OOPS(2260,Y,0),U,6)=0"
DIC S DIC(0)="AEMNZ",DIC("A")="Select case to be amended: "
 D ^DIC Q:(Y<1)!($D(DTOUT))!($D(DUOUT))
 S OLDIEN=$P(Y,U),NUM=$P(^OOPS(2260,OLDIEN,0),U,1),SUF=$E(NUM,11)
 S $P(^OOPS(2260,OLDIEN,0),U,6)=3
 S NUM=$E(NUM,1,10)_$S(SUF="":"A",1:$CHAR($ASCII(SUF)+1))
 S DLAYGO=2260
 K DD,DO S DIC="^OOPS(2260,",DIC(0)="QLZ",X=NUM D FILE^DICN G:Y=-1 EXIT
 S NEWIEN=+Y
 MERGE ^OOPS(2260,NEWIEN)=^OOPS(2260,OLDIEN)
 ; patch 11 - set global into variable to use, set field 57 to ""
 ;            so case can be resent to NDB
 S OOP=^OOPS(2260,NEWIEN,0)
 S $P(OOP,U,1)=NUM,$P(OOP,U,6)=0,$P(OOP,U,11)="",$P(OOP,U,19)=""
 S ^OOPS(2260,NEWIEN,0)=OOP
 S $P(^OOPS(2260,NEWIEN,"CA"),U,6)=""
 S DIK="^OOPS(2260,",DA=NEWIEN D IX^DIK
 K ^OOPS(2260,NEWIEN,"2162ES")
 K ^OOPS(2260,NEWIEN,"CA1ES")
 K ^OOPS(2260,NEWIEN,"CA2ES")
 ; Clean up DOL cross reference - PATCH 8
 N IEN,X,WCPDUZ,WOK
 S WCPDUZ=$P($G(^OOPS(2260,NEWIEN,"WCES")),U)
 I $G(WCPDUZ) S WOK=1,X=WCPDUZ,IEN=OLDIEN D WK^OOPSUTL1
 K ^OOPS(2260,NEWIEN,"WCES")
 W !!,"Case number ",NUM," has been assigned to this amended incident."
 W !,"Use option ""Edit Report of Incident"" to complete this case."
EXIT K DIC,OLDIEN,NEWIEN,NUM,SUF,X,Y,DIK,OOP
 Q
