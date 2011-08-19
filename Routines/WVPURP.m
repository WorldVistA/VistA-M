WVPURP ;HIOFO/FT,JR-NOTIFICATION TABLES MAINTENANC; ;8/28/03  16:38
 ;;1.0;WOMEN'S HEALTH;**4,9,16**;Sep 30, 1998
 ;;  Original routine created by IHS/ANMC/MWR
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  ADD/EDIT/PRINT NOTIFICATION PURPOSE FILE ENTRIES, EDIT PCD DAYS,
 ;;  EDIT NOTIFICATION TYPE SYNONYMS, ADD/EDIT NOTIFICATION OUTCOMES.
 ;
 ; This routine uses the following IAs:
 ; #10089 - ^%ZISC call                  (supported)
 ; #10103 - ^XLFDT calls                 (supported)
 ; #10104 - ^XLFSTR calls                (supported)
 ;
PRINTPUR ; Called by option "WV PRINT NOTIF PURPOSE&LETTER"
 D SETVARS^WVUTL5
 D DEVICE
 I WVPOP D KILL Q
PRINT ; Print purpose and letter entries
 U IO
 S WVNAME="",(WVPAGE,WVPOP)=0
 S WVDATE=$$FMTE^XLFDT($$NOW^XLFDT(),"1P") ;current date/time
 S WVDASH=$$REPEAT^XLFSTR("-",79) ;line of dashes
 ; loop thru File 790.404 (B x-ref)
 F  S WVNAME=$O(^WV(790.404,"B",WVNAME)) Q:WVNAME=""!(WVPOP)  S WVIEN=0 F  S WVIEN=$O(^WV(790.404,"B",WVNAME,WVIEN)) Q:'WVIEN!(WVPOP)  D
 .S WVNODE=$G(^WV(790.404,WVIEN,0)) Q:WVNODE=""
 .D HEADER
 .D RESOLVE
 .W !!?3,"PURPOSE: "_$P(WVNODE,U,1),?55,"SYNONYM: "_$P(WVNODE,U,3)
 .W !?2,"PRIORITY: "_$G(WVARRAY(790.404,WVIEN_",",.02,"E")),?56,"ACTIVE: "_$G(WVARRAY(790.404,WVIEN_",",.04,"E"))
 .W !?2,"BR or CX: "_$G(WVARRAY(790.404,WVIEN_",",.05,"E"))
 .W !?4,"LETTER: "_$G(WVARRAY(790.404,WVIEN_",",.06,"E"))
 .W !,"BR TX NEED: "_$G(WVARRAY(790.404,WVIEN_",",.07,"E"))
 .S WVDUE=$$DMY($G(WVARRAY(790.404,WVIEN_",",.08,"E")))
 .W ?48,"BR TX DUE DATE: "_WVDUE
 .W !,"CX TX NEED: "_$G(WVARRAY(790.404,WVIEN_",",.09,"E"))
 .S WVDUE=$$DMY($G(WVARRAY(790.404,WVIEN_",",.1,"E")))
 .W ?48,"CX TX DUE DATE: "_WVDUE,!!
 .S WVLINE=0
 .F  S WVLINE=$O(^WV(790.404,WVIEN,1,WVLINE)) Q:'WVLINE!(WVPOP)  D
 ..I ($Y+4)>IOSL D:$E(IOST)="C" DIRZ^WVUTL3 Q:WVPOP  D HEADER
 ..W !,$G(^WV(790.404,WVIEN,1,WVLINE,0))
 ..Q
 .Q:WVPOP
 .I $E(IOST)="C" D DIRZ^WVUTL3
 .Q
 I $D(ZTQUEUED) S ZTREQ="@"
KILL ; Kill variables
 K WVARRAY,WVDASH,WVDATE,WVDUE,WVIEN,WVLINE
 K WVNAME,WVNODE,WVPAGE,WVPOP,X,Y
 D ^%ZISC
 Q
HEADER ; Report header
 W:$Y>0 @IOF
 S WVPAGE=WVPAGE+1
 W "NOTIFICATION PURPOSE & LETTER LIST",?45,WVDATE,?70,"PAGE: "_WVPAGE
 W !,WVDASH
 Q
RESOLVE ; Resolve data to external values
 K WVARRAY
 D CLEAN^DILF
 D GETS^DIQ(790.404,WVIEN_",",".02;.04:.1","E","WVARRAY")
 Q
DEVICE ; Get device and possibly queue to taskman
 N ZTRTN
 S ZTRTN="DEQUEUE^WVPURP"
 D ZIS^WVUTL2(.WVPOP,1,"HOME")
 Q
DEQUEUE ; Taskman queue of printout
 D PRINT
 Q
 ;
EDITPUR ;EP
 ;---> CALLED BY OPTION "WV EDIT NOTIF PURPOSE&LETTER".
 D SETVARS^WVUTL5
 ;---> DISPLAY MENU TITLE FROM WV MENU OPTIONS.
 F  D  Q:$G(Y)<0
 .D TITLE^WVUTL5("EDIT NOTIFICATION PURPOSE & LETTER FILE")
 .D DIC^WVFMAN(790.404,"QEMAL",.Y)
 .Q:Y<0
 .S DA=+Y
 .D:$P(Y,U,3) ADDLET
 .D:'$P(Y,U,3) REPLACE
 .Q:WVPOP
 .;---> EDIT WITH SCREENMAN.
 .S DR="[WV NOTIFPURPOSE-FORM-1]"
 .D DDS^WVFMAN(790.404,DR,DA,"","",.WVPOP)
 D KILLALL^WVUTL8
 Q
 ;
 ;
ADDLET ;EP
 ;---> CALLED BY OPTION "WV ADD NOTIF PURPOSE&LETTER".
 K ^WV(790.404,DA,1)
 N N S N=0
 F  S N=$O(^WV(790.6,1,1,N)) Q:'N  D
 .S ^WV(790.404,DA,1,N,0)=^WV(790.6,1,1,N,0)
 S ^WV(790.404,DA,1,0)=^WV(790.6,1,1,0)
 Q
 ;
REPLACE ;EP
 ;---> REPLACE OLD LETTER FOR THIS NOTIF PURPOSE WITH GENERIC SAMPLE.
 N DIR,DIRUT,Y
 W !!?3,"Do you wish to delete the old letter for this Purpose of "
 W "Notification",!?3,"and replace it with the generic sample letter?"
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="   Enter Yes or No: " D HELP1
 D ^DIR W !
 S:$D(DIRUT) WVPOP=1
 I Y D ADDLET
 Q
 ;
HELP1 ;EP
 ;;Enter YES to delete the old letter for this Purpose of Notification
 ;;and to begin with a fresh copy of the generic sample letter.
 S WVTAB=5,WVLINL="HELP1" D HELPTX
 Q
 ;
HELPTX ;EP
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  S DIR("?",I)=T_$P(X,";;",2)
 S DIR("?")=DIR("?",I-1) K DIR("?",I-1)
 Q
 ;
TYPE ;EP
 ;---> EDIT SYNONYMS FOR NOTIFICATION TYPES.
 D SETVARS^WVUTL5
 F  D  Q:$G(Y)<0
 .D TITLE^WVUTL5("EDIT SYNONYMS FOR NOTIFICATION TYPES") D TEXT1
 .N A S A="   Select NOTIFICATION TYPE: "
 .D DIC^WVFMAN(790.403,"QEMA",.Y,A)
 .Q:Y<0
 .D DIE^WVFMAN(790.403,.03,+Y,.WVPOP)
 W @IOF
 D KILLALL^WVUTL8
 Q
 ;
OUTCOME ;EP
 ;---> ADD/EDIT NOTIFICATION OUTCOME FILE.
 D SETVARS^WVUTL5
 F  D  Q:$G(Y)<0
 .D TITLE^WVUTL5("ADD/EDIT NOTIFICATION OUTCOME FILE")
 .D DIC^WVFMAN(790.405,"QEMAL",.Y,"   Select OUTCOME: ")
 .Q:Y<0
 .D DIE^WVFMAN(790.405,.02,+Y,.WVPOP)
 W @IOF
 D KILLALL^WVUTL8
 Q
 ;
TEXT1 ;EP
 ;;You may enter a synonym for each Notification Type.  The synonym will
 ;;allow the Notification Type to be called up by typing only a few
 ;;characters.  Synonyms should be unique and less than 4 characters.
 ;;
 ;;For example, "L1" might be used for LETTER,FIRST; "L2" for
 ;;LETTER,SECOND; "L3" for LETTER,THIRD, and so on.
 ;;
 ;;
 S WVTAB=5,WVLINL="TEXT1" D PRINTX
 Q
 ;
PRINTX ;EP
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  W !,T,$P(X,";;",2)
 Q
 ;
GENSTUFF ;EP
 ;---> STUFF THE GENERIC SAMPLE LETTER INTO ALL PURPOSES OF NOTIF.
 N DA
 S DA=0
 F  S DA=$O(^WV(790.404,DA)) Q:'DA  W !,DA  D ADDLET^WVPURP
 Q
DMY(WVDUE) ; Spell out Days, Months or Years
 N WVDUE1,WVDUE2
 I WVDUE="" Q ""
 I '$S(WVDUE["D":1,WVDUE["M":1,WVDUE["Y":1,1:0) Q WVDUE
 S WVDUE1=+WVDUE
 S WVDUE2=$S(WVDUE["D":"Day",WVDUE["M":"Month",WVDUE["Y":"Year",1:"")
 S:WVDUE1>1 WVDUE2=WVDUE2_"s"
 S:WVDUE2="s" WVDUE2=""
 S WVDUE=WVDUE1_" "_WVDUE2
 Q WVDUE
 ;
DMYCHECK ; Called from ^DD(790.404,.8,0) - BR TX DUE DATE
 ; and ^DD(790.404,.1,0) - CX TX DUE DATE
 ; Check X to see if it is a date offset (e.g., 365D, 12M or 1Y).
 ; Returns -1 if not an exceptable value
 Q:'$D(X)
 I $L(X)>4!($L(X)<2) S X=-1 Q
 S X=$$UP^XLFSTR(X)
 I X'?1.3N1"D",X'?1.3N1"M",X'?1.3N1"Y" S X=-1
 Q
