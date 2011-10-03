PXRMSLST ; SLC/PJH - List Resolution Statuses ;03/09/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;List selected status
 ;--------------------
START N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,MODE,NOW,TO,Y
 ;
SELECT S MODE=""
 S DIC="^PXRMD(801.9,"
 S DIC(0)="AEMQ"
 S DIC("A")="Select Resolution Status: "
 D ^DIC
 I Y'=-1 D  G SELECT
 .D SET
 .D DISP
END Q
 ;
 ;List all statuses
 ;-----------------
ALL N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,MODE,NOW,TO,Y
 S Y=1,MODE="GENERAL"
 D SET
 S DIC="^PXRMD(801.9,"
 S BY=".01"
 S FR=""
 S TO=""
 S DHD="W ?0 D HED^PXRMSLST"
 D DISP
 Q
 ;
 ;Inquire/Print Option (for protocol PXRM GENERAL INQUIRE/PRINT)
 ;--------------------
INQ(Y) N BY,DC,DHD,DIC,FLDS,FR,L,LOGIC,MODE,NOW,TO
 S MODE=""
 S DIC="^PXRMD(801.9,"
 S DIC(0)="AEMQ"
 D SET
 D DISP
 Q
 ;
HED ; Display Header (see DHD variable)
 N TEMP,TEXTLEN,TEXTHED,TEXTUND
 S TEXTHED="RESOLUTION STATUS LIST"
 S TEXTUND=$TR($J("",IOM)," ","-")
 S TEMP=NOW_"  Page "_DC
 S TEXTLEN=$L(TEMP)
 W TEXTHED
 W ?(IOM-TEXTLEN),TEMP
 W !,TEXTUND,!!
 Q
 ;
DISP ;DISPLAY (Display from FLDS array)
 S L=0
 D EN1^DIP
 Q
 ;
 ;Work out national resolution status
NAT N NAT
 ;Ignore national codes
 I +$P($G(^PXRMD(801.9,+D0,0)),U,6) W ?29,"N/A" Q
 ;Get national code from cross reference
 S NAT=$O(^PXRMD(801.9,"AC",D0,""))
 ;If none allocated say so
 I NAT="" W ?29,"***UNDEFINED***" Q
 ;Get name of national status and display
 S DATA=$P($G(^PXRMD(801.9,NAT,0)),U)
 W ?29,DATA
 Q
 ;
SET ;Setup all the variables
 N NATIONAL
 ;
 ; Set Date for Header
 S NOW=$$NOW^XLFDT
 S NOW=$$FMTE^XLFDT(NOW,"1P")
 ;
 ;These variables need to be setup every time because DIP kills them.
 S BY="NUMBER"
 S (FR,TO)=+$P(Y,U,1)
 S DHD="W ?0 D HED^PXRMSLST"
 ;
 ;If the status is resticted edit then this is a national code
 S NATIONAL=+$P($G(^PXRMD(801.9,+Y,0)),U,6)
 ;
 ;General display used by list function
 I MODE="GENERAL" S FLDS="[PXRM RESOLUTIONS (GENERAL)]" Q
 ;National status display
 I NATIONAL S FLDS="[PXRM RESOLUTIONS (NATIONAL)]" Q
 ;Local Status display
 I 'NATIONAL S FLDS="[PXRM RESOLUTIONS (LOCAL)]" Q
 Q
 ;
 ;Resolution type
TYP I +$P($G(^PXRMD(801.9,+D0,0)),U,6) W ?20,"NATIONAL" Q
 W ?20,"LOCAL"
 Q
