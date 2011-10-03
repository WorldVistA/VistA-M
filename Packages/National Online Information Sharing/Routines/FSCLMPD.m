FSCLMPD ;SLC/STAFF-NOIS List Manager Protocol Display ;1/11/98  18:35
 ;;1.1;NOIS;;Sep 06, 1998
 ;
LC ; from FSCLMP
 I '@VALMAR W !,"No calls to View." H 2 Q
 N CHOICE,DEFAULT,FIELD,FORMAT,OK
 S CHOICE="1-"_+@VALMAR,DEFAULT=CHOICE D SELECT^FSCUL(CHOICE,"",DEFAULT,"VVALUES",.OK) I OK D
 .S FORMAT="",OK=1 D EXPAND^FSCUX(.FORMAT,.OK,$$VFORMAT^FSCUF(DUZ)) I OK D
 ..K FSCSTYLE S FSCSTYLE=$$STYLE^FSCU(FORMAT),FIELD="" F  S FIELD=$O(FORMAT(FIELD)) Q:FIELD=""  S FSCSTYLE(FIELD)=FORMAT(FIELD)
 ..D VIEW^FSCLM(VALMAR,"VVALUES",.FSCSTYLE)
 S VALMBCK=$S($G(FSCEXIT):"Q",1:"R")
 Q
 ;
LIST ; from FSCLMP
 I '$$CHECK^FSCLMPM(FSCLNUM,DUZ) W !,"You cannot update this list.",$C(7) H 2 Q
 I $P(^FSC("LIST",FSCLNUM,0),U,3)'="A" W !,"You cannot update this type of list.",$C(7) H 2 Q
 W !,"Upating ",FSCLNAME,!
 D UPDATE^FSCLP(,FSCLNUM)
 K FSCQEDIT
 Q
 ;
ASKLIST ; from FSCLMPC, FSCLMPO
 N DIR,X,Y K DIR,FSCQEDIT
 S DIR(0)="YAO",DIR("A")="Do you want to rebuild this list? ",DIR("B")="YES"
 S DIR("?",1)="Enter YES to rebuild this list."
 S DIR("?",2)="Enter NO or '^' to leave the list alone."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U 1 NOIS"
 D ^DIR K DIR
 I Y=1 D LIST
 Q
