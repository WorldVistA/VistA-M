PXRMDLED ;SLC/AGP - DIALOG UTILITIES. ;12/02/2019
 ;;2.0;CLINICAL REMINDERS;**45**;Feb 04, 2005;Build 566
 Q
 ;
DICPROMPT(RESULT,GBL,ZERO,PROMPT,SCREEN,NUM) ;
 S DIC=GBL
 S DIC(0)=ZERO
 S DIC("A")=PROMPT
 ;Current dialog type only
 I SCREEN'="" S DIC("S")=SCREEN
 S DIC("??")=U_"D HELP^PXRMDLED("_NUM_")"
 W !
 D ^DIC
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S RESULT=Y
 Q
 ;
DIRPROMPT(RESULT,ZERO,PROMPT,NUM) ;
 S DIR(0)=ZERO
 S DIR("A")=PROMPT
 S DIR("?")=$S(NUM=2:"Enter the name of the template to create.",1:"Enter Y or N. For detailed help type ??")
 S DIR("??")=U_"D HELP^PXRMDLED("_NUM_")"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S RESULT=Y
 Q
 ;
EN ;
 N DIEN,DIC,DIR,DNAME,DR,DIROUT,DIRUT,DTOUT,DUOUT,TEMPNAME,TIEN,TNAME,VALUE,X,Y
FINDDIAL ;find dialog name #801.41
 D DICPROMPT(.VALUE,"^PXRMD(801.41,","AEMQ","Select Dialog Definition: ","I $P(^(0),U,4)=""R""",1)
 Q:$D(DTOUT)!($D(DUOUT))
 S DIEN=+VALUE
 S DNAME=$P(VALUE,U,2)
 ;
TNAME ;user supply template name #8927.1
 D DIRPROMPT(.TEMPNAME,"F^3:60","Enter template name",2)
 Q:$D(DTOUT)&($D(DUOUT))  G:$D(DUOUT) FINDDIAL
 ;
ATTACH ;attach to a note title
 K VALUE
 D DIRPROMPT(.VALUE,"Y","Link template to Document Title",3)
 Q:$D(DTOUT)&($D(DUOUT))  G:$D(DUOUT) TNAME
 I VALUE=0 D LINK(DNAME,"",TEMPNAME,1) Q
 ;
DOC ;find note title 8927.1
 K VALUE
 D DICPROMPT(.VALUE,"^TIU(8925.1,","AEMQ","Select Document Definition: ","I $P(^(0),U,4)=""DOC""",4)
 Q:$D(DTOUT)&($D(DUOUT))  G:$D(DUOUT) ATTACH
 S TIEN=+VALUE
 S TNAME=$P(VALUE,U,2)
 D LINK(DNAME,TNAME,TEMPNAME,0)
 Q
 ;
 ;link dialog to template and attach to a note title
LINK(DNAME,TITLE,TEMPNAME,TEMPONLY) ;
 D LINK2TIU^PXRMDUTL(DNAME,TITLE,TEMPNAME,TEMPONLY,"TIU(8925.1,")
 H 1
 Q
 ;
HELP(NUM) ; help prompts
 N HTEXT
 I NUM=1 D
 .S HTEXT(1)="Select the Reminder Dialog Definition to link to a Template."
 I NUM=2 D
 .S HTEXT(1)="Enter the template display name."
 I NUM=3 D
 .S HTEXT(1)="Select No to add the template to the Shared Folder only."
 .S HTEXT(2)="Select Yes to link the tempplate to a document title."
 I NUM=4 D
 .S HTEXT(1)="Select the document title to link the template to."
 D HELP^PXRMEUT(.HTEXT)
 Q
