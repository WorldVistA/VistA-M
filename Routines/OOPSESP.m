OOPSESP ;WIOFO/CAH-EDIT SITE PARAMETER ;2/16/00
 ;;2.0;ASISTS;;Jun 03, 2002
 W @IOF
EDIT K DR S DR(1,2262,10)=".01 SITE NAME..............."
 K DO,DD S DIC="^OOPS(2262,",DIC(0)="AEMQ" D ^DIC G:Y=-1 EXIT
 ; patch 11 - added .7 below - new field
 S DR(2,2262.03)=".7;1;2;3;4;5;6"
 S DIE="^OOPS(2262,",IEN2262=+Y,DA=IEN2262,DR=""
 ; patch 11 - removed field 1 from input screen - not used.
 ; S DR(1,2262,20)="1 OWCP AGENCY CODE........"
 S DR(1,2262,30)="2 OWCP DISTRICT OFFICE...."
 S DR(1,2262,40)="3"    ;MULTIPLE FIELD
 D ^DIE
EXIT K DA,DIC,DIE,DR,IEN2262
 Q
