PXRMHIST ; SLC/PKR - Routines for dealing with edit histories. ;12/23/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;=====================================================
DISP(RIEN,MAX) ;Display edit history in reverse date order, newest to oldest.
 N CNT,EDATA,EIEN,ETIME,IC,NIN,NOUT,RNAME
 N TEXTIN,TEXTOUT,UIEN,USER
 ;Last N lines
 S CNT=0,EIEN=":"
 S RNAME=$P(^PXD(811.9,RIEN,0),U,1)
 W !!,"Edit History for reminder "_RNAME_":"
 F  S EIEN=$O(^PXD(811.9,RIEN,110,EIEN),-1) Q:'EIEN  Q:CNT=MAX  D
 .;Edit date and edit by fields
 . S EDATA=$G(^PXD(811.9,RIEN,110,EIEN,0)) Q:EDATA=""
 . S ETIME=$P(EDATA,U),UIEN=$P(EDATA,U,2) Q:'UIEN
 . S USER=$$GET1^DIQ(200,UIEN,.01),CNT=CNT+1
 . W !!,?2,"Edit date: ",$$FMTE^XLFDT(ETIME,"1")
 . W ?38,"Edit by: ",USER
 . S (IC,NIN)=0
 . F  S IC=$O(^PXD(811.9,RIEN,110,EIEN,1,IC)) Q:'IC  D
 .. S NIN=NIN+1
 .. S TEXTIN(NIN)=$G(^PXD(811.9,RIEN,110,EIEN,1,IC,0))
 . D FORMAT^PXRMTEXT(18,75,NIN,.TEXTIN,.NOUT,.TEXTOUT)
 . I NOUT>0 D
 .. W !,?2,"Edit Comments:",?1,$P(TEXTOUT(1)," ",17,99)
 .. F IC=2:1:NOUT W !,TEXTOUT(IC)
 Q
 ;
 ;=====================================================
MAX() ;Return the maximum number of occurrences to display.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,MAX,X,Y
 S DIR(0)="N^2:99"
 S DIR("A")="Maximum number of occurrences to display "
 ;Get the edit history count to use as a default value.
 S MAX=$G(^PXRM(800,1,"EDIT HISTORY COUNT")) I MAX="" S MAX=2
 S DIR("B")=MAX
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q 0
 I $D(DTOUT)!$D(DUOUT) Q 0
 Q +Y
 ;
 ;=====================================================
REM ;Select reminder definition for displaying the history.
 N IEN,IENN,MAX,PXRMROOT
 S IENN=0
 S PXRMROOT="^PXD(811.9,"
 S MAX=$$MAX
 I MAX=0 Q
 F  Q:IENN=-1  D
 . W !
 . S IENN=$$SELECT^PXRMINQ(PXRMROOT,"Select Reminder Definition: ","")
 . I IENN=-1 Q
 . S IEN=$P(IENN,U,1)
 . D DISP(IEN,MAX)
 Q
 ;=====================================================
RMEH ;Remove edit history. This is for items sent directly via KIDS that
 ;do not go through Exchange. Reminder computed findings are a good
 ;example.
 I DUZ(0)'="@" Q
 N CLASS,DIR,DIROUT,DIRUT,DTOUT,DUOUT,EH,ENTRY,IEN
 N FIELD,FILENUM,GLOBAL,NAME,X,Y
 W !,"Remove edit history from national reminder files.",!
 S DIR(0)="NAOU^0::15"
 S DIR("A")="Enter the file number: "
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q
 I (Y="")!($D(DTOUT))!($D(DUOUT)) Q
 S FILENUM=+Y
 S FIELD=$$GET1^DID(FILENUM,110,"","LABEL")
 I FIELD'="EDIT HISTORY" D  Q
 . W !,"This is no Edit History in this file!"
 S NAME=$$GET1^DID(FILENUM,"","","NAME")
 W !,"Looking for edit histories in file ",NAME
 S GLOBAL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")
 S ENTRY=GLOBAL_"IEN)"
 S IEN=0
 F  S IEN=+$O(@ENTRY) Q:(IEN=0)!($G(DUOUT))  D
 . S CLASS=GLOBAL_"IEN,100)"
 . S CLASS=$P(@CLASS,U,1)
 . I CLASS'="N" Q
 . S NAME=GLOBAL_"IEN,0)"
 . S NAME=$P(@NAME,U,1)
 . K DIR
 . S DIR(0)="YA"
 . S DIR("A")="Delete Edit History from entry "_NAME_"? "
 . S DIR("B")="N"
 . D ^DIR
 . I $D(DIROUT)!$D(DIRUT) Q
 . I (Y="")!($D(DTOUT))!($D(DUOUT)) Q
 . I 'Y Q
 . S EH=GLOBAL_"IEN,110)"
 . K @EH
 . S EH=GLOBAL_"IEN,110,0)"
 . S @EH="^811.9001D^^0"
 Q
 ;
