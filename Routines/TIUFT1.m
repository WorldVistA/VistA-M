TIUFT1 ; SLC/MAM - LM Template I (Items) Actions Delete, Edit/All, Mnemonic, Sequence, Menu Text,  MTXTCHEC(DA,FILEDA,SILENT) ;4/17/97  11:02
 ;;1.0;TEXT INTEGRATION UTILITIES;**17,27,43,64**;Jun 20, 1997
 ;
MTXTCHEC(DA,FILEDA,SILENT,OLDMTXT,NEWMTXT) ; Check/Stuff/Inform Menu Text.  **43**
 ; If no MTXT, or MTXT starts w space, or MTXT starts with ALL, stuff
 ;MTXT with first 20 chars of NAME (or, if NAME begins with ALL, begin
 ;MTXT w/ ALX instead of ALL).
 ; Requires array DA, i.e. DA(1) and DA, FILEDA, and SILENT.
 ; Returns OLD menu text (or NOTEN) in OLDMTXT if received.
 ; Returns NEW menu text (or NOENTRY) in NEWMTXT if received.
 N NAMEOK
 I $$MTXTOK(.DA,.OLDMTXT) S NEWMTXT=OLDMTXT G CHECX
 S NAMEOK=1,NEWMTXT=$G(^TIU(8925.1,FILEDA,0),"NOENTRY^"),NEWMTXT=$P(NEWMTXT,U),NEWMTXT=$E(NEWMTXT,1,20)
 I NEWMTXT="NOENTRY" G CHECX
 I $E(NEWMTXT,1,3)="ALL" S NAMEOK=0
 S NEWMTXT=$$MIXED^TIULS(NEWMTXT)
 I 'NAMEOK S $E(NEWMTXT,3)="X"
 D STUFF(.DA,NEWMTXT)
 D:'SILENT MSG(NEWMTXT)
CHECX Q
 ;
MTXTOK(DA,MTXT)  ; Function returns 0 if Menu Text begins with space or all (any case) or if there is no Menu Text.  Menu Text (or NOTEN if no ten node) is returned in MTXT.
 ; Requires DA, DA(1)
 N MTXTOK S MTXTOK=1
 S MTXT=$G(^TIU(8925.1,DA(1),10,DA,0),"NOTEN")
 I MTXT="NOTEN" S MTXTOK=0 G OKX
 S MTXT=$P(MTXT,U,4)
 I (MTXT="")!($E(MTXT)=" ")!($$UPPER^TIULS($E(MTXT,1,3))="ALL") S MTXTOK=0
OKX Q MTXTOK
 ;
STUFF(DA,MTXT) ; Stuff MTXT
 N DIE,DR
 S DR="4///"_MTXT,DIE="^TIU(8925.1,DA(1),10," D ^DIE
 Q
 ;
MSG(MTXT) ; Inform user
 I MTXT="NOTEN" W !!,"Item is missing from TIU DOCUMENT DEFINITION file.  See IRM.",! Q
 W !!,"Since item's Menu Text was bad or did not exist, item has been given Menu Text:",!,?5,MTXT,!
 I $G(TIUFSTMP)'="T" W "To edit, select 'Detailed Display' for the PARENT, then select 'Items'.",!
 H 3
 Q
 ;
EDDEL ; Template T (Items for Entry) Actions DELETE, EDIT/ ALL, MNEMONIC, SEQUENCE, MENU TEXT
 ; Action Delete Items deletes item as an item only, NOT as a file entry.
 ; No need to update original screen since entry collapsed, will reexpand
 ; Requires arrays TIUFINFO, TIUFNOD0
 N OLDLNO,SHIFT,TIUFDA10,LINENO,NODE0,NAME,INFO,TIUFERR,QUIT,TENDA
 N DA,DIE,DR,DIR,DIK,X,Y,FILEDA,IFILEDA,DDEFUSED,INODE0,ITYPE,TIUFFULL
 N ISTATUS,TIUFY,INATLFLG,TIUFXNOD,ISHARED,DTOUT,DIRUT,DIROUT
 S TIUFXNOD=$G(XQORNOD(0)),VALMBCK="",TIUFFULL=0
 S FILEDA=TIUFINFO("FILEDA")
 I $P(TIUFXNOD,U,3)["Delete",$P(TIUFNOD0,U,13),TIUFWHO'="N",$P(TIUFNOD0,U,4)="DOC"!($P(TIUFNOD0,U,4)="CO") W !!," Parent is National, of Type TL or CO; Can't add or delete Items" D PAUSE^TIUFXHLX G EDDEX
 L +^TIU(8925.1,FILEDA):1 I '$T W !!," Another user is editing this entry; Please try later",! H 2 G EDDEX
 D EN^VALM2(TIUFXNOD,"O")
 I '$O(VALMY(0)) G EDDEX
 S OLDLNO=0,VALMBCK="R"
 F  S OLDLNO=$O(VALMY(OLDLNO)) Q:'OLDLNO  D
 . S TIUFDA10(OLDLNO)=$P(^TMP("TIUF2IDX",$J,OLDLNO),U,6)
 . Q
 S (OLDLNO,QUIT)=0,DA(1)=FILEDA
 ; Delete Items
 I $P(TIUFXNOD,U,3)["Delete" D  G EDDEX
 . S DIR(0)="Y",DIR("A")="Sure you want to delete items",DIR("B")="NO"
 . S DIR("?",1)="Delete on Items Screen deletes entries as items from the parent ONLY; they are"
 . S DIR("?",2)="NOT deleted from the file itself.  For more, enter ?? at the Select Action"
 . S DIR("?")="prompt and see DELETE."
 . D ^DIR S TIUFY=Y K DIR,X,Y,DUOUT I TIUFY'=1 S VALMBCK="" W !!,"NOT Deleted!",! H 1 Q
 . N DIRUT
 . F  S OLDLNO=$O(TIUFDA10(OLDLNO)) Q:'OLDLNO  D  Q:$D(DIRUT)
 . . S TENDA=TIUFDA10(OLDLNO)
 . . S IFILEDA=+^TIU(8925.1,DA(1),10,TENDA,0)
 . . S INODE0=$G(^TIU(8925.1,IFILEDA,0)),ISHARED=+$P(INODE0,U,10)
 . . I INODE0="" W !!," Entry ",OLDLNO," does not exist in File; See IRM",! D PAUSE^TIUFXHLX Q
 . . S INATLFLG=+$P(INODE0,U,13),ITYPE=$P(INODE0,U,4),ISTATUS=$$STATWORD^TIUFLF5($P(INODE0,U,7)) ;e.g INACTIVE
 . . I INATLFLG,ITYPE'="CO",TIUFWHO'="N" W !!," Entry ",OLDLNO," can't be deleted from parent: Entry is National",! D PAUSE^TIUFXHLX Q  ;P64 prohibit deletion of natl entries as items except for natl components
 . . I TIUFWHO="C",'ISHARED W !!," Entry ",OLDLNO," can't be deleted from parent:",!,"Only Shared Components can be added/deleted.",! D PAUSE^TIUFXHLX Q
 . . ; If not CO, don't permit Item delete if Used by Docmts
 . . I ITYPE'="CO" D  I DDEFUSED="YES",'$$OVERRIDE^TIUFHA2("delete entry "_OLDLNO_" from parent even though it is IN USE by documents") W !,"  Entry ",OLDLNO," NOT deleted" H 3 Q
 . . . S DDEFUSED=$$DDEFUSED^TIUFLF(IFILEDA)
 . . . I DDEFUSED="YES" W !!," Entry ",OLDLNO," can't be deleted from parent: In Use by documents",! I TIUFWHO="N" D FULL^VALM1,OVERWARN^TIUFHA2 S TIUFFULL=1
 . . I ISTATUS'="INACTIVE" W !!," Entry ",OLDLNO," can't be deleted from parent: not INACTIVE",! D PAUSE^TIUFXHLX Q
 . . I TIUFTMPL="A",$E(TIUFATTR)="P",$$ORPHAN^TIUFLF4(FILEDA,TIUFNOD0)="NO" S TIUFREDO=1 ;orphaning items below item
 . . S DA=TENDA,DIK="^TIU(8925.1,DA(1),10," D ^DIK
 . . W !!," Entry ",OLDLNO," Deleted from parent",! H 2
 . . S LINENO=$O(^TMP("TIUF2IDX",$J,"DA10",TENDA,0))
 . . S SHIFT=-1
 . . D UPDATE^TIUFLLM1("T",SHIFT,LINENO-1) S VALMCNT=VALMCNT+SHIFT
 . . I $G(TIUFERR) S QUIT=1
 . . ; D screen will be updated when return from T to D.
 . . Q
 . D NODE0ARR^TIUFLF(FILEDA,.TIUFNOD0)
 . Q
 ; Edit Items
 D FULL^VALM1 S TIUFFULL=1
 F  S OLDLNO=$O(TIUFDA10(OLDLNO)) Q:'OLDLNO!QUIT  D
 . S QUIT=0
 . S TENDA=TIUFDA10(OLDLNO)
 . S LINENO=$O(^TMP("TIUF2IDX",$J,"DA10",TENDA,0))
 . S INFO=^TMP("TIUF2IDX",$J,LINENO)
 . S IFILEDA=$P(INFO,U,2),INODE0=$G(^TIU(8925.1,IFILEDA,0))
 . I INODE0="" W !!," Item ",OLDLNO," Not in File! See IRM.",!  D PAUSE^TIUFXHLX Q
 . S ITYPE=$P(INODE0,U,4)
 . W !!," Editing Entry ",OLDLNO
 . I $P(TIUFXNOD,U,3)="Mnemonic" S DR="2"
 . I $P(TIUFXNOD,U,3)="Sequence" S DR="3"
 . I $P(TIUFXNOD,U,3)="Menu Text" S DR="4"
 . I $P(TIUFXNOD,U,3)["All" S DR="3;2;4" I ITYPE'="CL",ITYPE'="DC" S DR="3;4"
 . S DA=TENDA
 . S DIE="^TIU(8925.1,DA(1),10," D ^DIE I $D(Y)!$D(DTOUT) S QUIT=1
 . D MTXTCHEC(.DA,IFILEDA,0) H 4 ;If user left bad Menu Text by accepting bad existing value, stuff and inform user.
 . Q
 G:$D(DTOUT) EDDEX
 D INIT^TIUFT
EDDEX I $D(DTOUT) S VALMBCK="Q"
 L -^TIU(8925.1,+$G(FILEDA))
 I $G(TIUFFULL) S VALMBCK="R" D RESET^TIUFXHLX
 Q
