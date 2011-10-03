PXRMXTF ; SLC/PJH - Reminder Reports Template Filing ;05/02/2002
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ; 
 ; Called from PXRMXTA
 ;
 ;Select template name and file
 ;-----------------------------
START N NEWIEN,NEWTEMP,OLDTEMP
 ;Save original name
 S OLDTEMP=$P(PXRMTMP,U,2)
 ;Reset PXRMTMP in case the template name field has been edited
 S $P(PXRMTMP,U,2)=$P($G(^PXRMPT(810.1,$P(PXRMTMP,U,1),0)),U)
 ;Redisplay changes made
 D REDISP
 ;Prompt template name
 D NAME
 ;Rollback ^DIE changes if edit is abandoned
 I $D(DTOUT)!$D(DUOUT) D ROLL Q
 ;
 I NEWTEMP=$P(PXRMTMP,U,2),NEWTEMP=OLDTEMP D MESS(1,NEWTEMP)
 I NEWTEMP=$P(PXRMTMP,U,2),NEWTEMP'=OLDTEMP D MESS(3,OLDTEMP,NEWTEMP)
 ;
 ;If a new template ID is selected then create a new template
 I NEWTEMP'=$P(PXRMTMP,U,2) D  I $D(MSG) S DTOUT=1 Q
 .;Create template header
 .D HEADER
 .;Save edited template detail to new template name
 .D REFILE Q:$D(MSG)
 .;Save Message
 .D MESS(2,NEWTEMP)
 .;File original arrays to old template (rollback ^DIE changes)
 .D FILE^PXRMXTU(PXRMTMP,1,1)
 .;Set selected template ID
 .S PXRMTMP=NEWIEN
 ;
 ;Reload arrays
 D LOAD^PXRMXT I $D(MSG) S DTOUT=1 Q
EXIT Q
 ;
 ;Rename edited template
 ;----------------------
NAME N X,Y,TEXT,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="FAU"_U_"3:30"_U_"K:'$$OK^PXRMXTF(X) X"
 S DIR("A")="STORE REPORT LOGIC IN TEMPLATE NAME: "
 S DIR("B")=$P(PXRMTMP,U,2)
 S DIR("?")="Enter template name. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXTF(1)"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S NEWTEMP=Y
 Q
 ;
 ;Check if the template name is in use
 ;------------------------------------
OK(NAME) ;
 ;Original template name may be used
 I X=DIR("B") Q 1
 I $E(DIR("B"),1,$L(X))=X Q 0
 ;Else check if template name defined
 I '$D(^PXRMPT(810.1,"B",NAME)) Q 1
 Q 0
 ;
 ;Create Template header and get IEN
 ;----------------------------------
HEADER N DATA,IEN,NUM
 ;Otherwise create a new entry
 S DATA=$G(^PXRMPT(810.1,0)),IEN=$P(DATA,U,3),NUM=$P(DATA,U,4)
 F  S IEN=IEN+1 Q:'$D(^PXRMPT(IEN,0))
 S ^PXRMPT(810.1,IEN,0)=NEWTEMP
 S ^PXRMPT(810.1,"B",NEWTEMP,IEN)=""
 S $P(^PXRMPT(810.1,0),U,3)=IEN,$P(^PXRMPT(810.1,0),U,4)=NUM+1
 S NEWIEN=IEN_U_NEWTEMP
 Q
 ;
 ;Redisplay edited template details
 ;---------------------------------------------
REDISP N PXRMLCSC,PXRMPRIM,PXRMREP,PXRMSEL,PXRMTYP,PXRMFD,RUN,PXRMCS
 N PXRMREM,PXRMFAC,PXRMPRV,PXRMPAT,PXRMOTM,PXRMSCAT,PXRMLCHL,PXRMCS
 N PXRMLIST,TITLE
 ;
 ;Load temporary arrays from edited template PXRMTMP
 D LOAD^PXRMXT I $D(MSG) Q
 ;Clear last run date
 S RUN=""
 ;Display
 D ^PXRMXTD
 ;
 Q
 ;
 ;Copy edited template details to new template
 ;---------------------------------------------
REFILE N PXRMLCSC,PXRMPRIM,PXRMREP,PXRMSEL,PXRMTYP,PXRMFD,RUN,PXRMCS
 N PXRMREM,PXRMFAC,PXRMPRV,PXRMPAT,PXRMOTM,PXRMSCAT,PXRMLCHL,PXRMCS
 N PXRMLIST,TITLE
 ;
 ;Load temporary arrays from edited template PXRMTMP
 D LOAD^PXRMXT I $D(MSG) Q
 ;Clear last run date
 S RUN=""
 ;Save arrays to new ID
 D FILE^PXRMXTU(NEWIEN,1,0) Q:$D(MSG)
 Q
 ;
 ;Rollback changes (also called from PXRMXTA)
 ;----------------
ROLL ;
 D FILE^PXRMXTU(PXRMTMP,1,1)
 I $D(MSG) S DTOUT=1 Q
 ;Changes not saved message
 D MESS(0,$P(PXRMTMP,U,2))
 Q
 ;
 ;Filing messages
 ;---------------
MESS(MODE,INP,INP1) ;
 I MODE=0 W !,"Changes to template '"_INP_"' have not been saved" Q
 I MODE=1 W !,"Changes to template '"_INP_"' have been saved"
 I MODE=2 W !,"A new template '"_INP_"' has been created"
 I MODE=3 W !,"Template '"_INP_"' renamed as '"_INP1_"'"
 I MODE=4 W !,"Template '"_INP_"' not saved"
 Q
 ;
 ;General help text routine. Write out the text in the HTEXT array
 ;----------------------------------------------------------------
HELP(CALL) ;
 N HTEXT
 N DIWF,DIWL,DIWR,IC
 S DIWF="C70",DIWL=0,DIWR=70
 ;
 I CALL=1 D
 .S HTEXT(1)="To save or rename the existing template use the default"
 .S HTEXT(2)="name. To create a new template and leave the original "
 .S HTEXT(3)="unchanged enter a different template name "
 .S HTEXT(4)="that is not in use."
 ;
 K ^UTILITY($J,"W")
 S IC=""
 F  S IC=$O(HTEXT(IC)) Q:IC=""  D
 . S X=HTEXT(IC)
 . D ^DIWP
 W !
 S IC=0
 F  S IC=$O(^UTILITY($J,"W",0,IC)) Q:IC=""  D
 . W !,^UTILITY($J,"W",0,IC,0)
 K ^UTILITY($J,"W")
 W !
 Q
