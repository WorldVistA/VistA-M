ENSP1 ;(WASH ISC)/WDS@Charleston-Room, Lock, and Function Report ;4-22-93
V ;;7.0;ENGINEERING;;Aug 17, 1993
INIT ;
ASK S DIR(0)="SA^R:ROOM;S:SERVICE",DIR("A")="SORT REPORT BY: ",DIR("B")="R"
 S DIR("?")=" <cr> or 'R' to list by room, 'S' to list by service, '^' to QUIT",DIR("??")="^D HELP^ENSP1" D ^DIR G:$D(DIRUT) EXIT G @Y(0)
 ;
SETUP ;Set up variables before tasking or printing directly
 W !! K IOP D DEV^ENLIB G:POP EXIT S IOP=ION,L="0",DIC="^ENG(""SP"",",FLDS="[ENSP-ROOM-LOCK]"
 S DIOEND="I IOST[""C-"" R !!,""Press <RETURN> to continue"",X:DTIME"
DQ1 S:$D(IO("Q")) IOP="Q;"_IOP D EN1^DIP G EXIT
 ;
SERVICE ; PRINT ROOM/LOCK/FUNCTION REPORT BY SERVICE ORDER
 S DHD="Engineering ROOM/LOCK Report by Using Service for - "_$P(^DIC(6910,1,0),U,1)
 S BY="#1.5,2;S2,.01" G SETUP
 ;
ROOM ; PRINT ROOM/LOCK/FUNCTION REPORT BY ROOM NUMBER
 S DHD="Engineering ROOM/LOCK Report by Room Number for - "_$P(^DIC(6910,1,0),U,1)
 S BY=".01" G SETUP
 ;
FLDS ;LOCAL SELECTION OF PRINT TEMPLATE FOR FLDS
 S FLDS="[ENSPRM]",DA=$O(^ENG(6910.2,"B","SPACE SURVEY PRINTOUT",0)) I DA>0,$D(^ENG(6910.2,DA,0)) S X=$P(^(0),"^",2) I X="L",$D(^DIPT("B","ENZSPRM")) S FLDS="[ENZSPRM]"
 Q
EXIT K DA,DIR,FR,TO Q
 ;
HELP W !!,"Sort by ROOM gives an 80 column listing of all rooms that have"
 W !,"key/lock assignments in room order along with their assigned functions."
 W !!,"Sort by SERVICE gives a similar report that is useful as a keying"
 W !,"plan for all services. It is broken down by Service with each"
 W !,"assigned key broken out in its own segment.  Room numbers for the"
 W !,"particular key are sorted in order under that key.",! Q
 ;ENSP1
