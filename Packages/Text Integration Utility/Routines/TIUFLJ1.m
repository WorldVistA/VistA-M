TIUFLJ1 ;SLC/MAM - DOCUMENTATION, LOCKEMB(FILEDA,NAP,LUNLOCK), STATEMB(FILEDA,STATFLG,NAP), EDBTEXT(FILEDA,NAPNAME) ;;7/1/97
 ;;1.0;TEXT INTEGRATION UTILITIES;**2**;Jun 20, 1997
 ;
 ;     ** Documentation on Array ^TMP("TIUFEMBED") **
 ;
 ; Array looks like 
 ;       ^TMP("TIUFEMBED",$J,OBJECTDA,"TIUFTL",NAP,FILEDA) if FILEDA
 ;           is a title, or
 ;       ^TMP("TIUFEMBED",$J,OBJECTDA,"TIUFCO",NAP,FILEDA) if FILEDA
 ;           is a component DESCENDING FROM A TITLE, or
 ;       ^TMP("TIUFEMBED",$J,OBJECTDA,"TIUFORPHAN",NAP,FILEDA) if
 ;           FILEDA is a COMPONENT NOT DESCENDING FROM A TITLE.
 ;
 ; ^TMP("TIUFEMBED",$J,OBJECTDA,"TIUFTL",NAP,FILEDA) = original status
 ;(status when array was set) of FILEDA: ACTIVE, TEST, INACTIVE, or "".
 ;
 ; NAP is N, A, P, or ANY.
 ;NAP="N":   Array is set if FILEDA'S boilerplate text has NAME of object
 ;           OBJECTDA embedded in it.
 ;NAP="A":   Array is set if FILEDA'S boilerplate text has ABBREVIATION
 ;           of object OBJECTDA embedded in it.
 ;NAP="P":   Array is set if FILEDA'S boilerplate text has PRINT NAME
 ;           of object OBJECTDA embedded in it.
 ;NAP="ANY": Array is set if FILEDA'S boilerplate text has ANY of the
 ;           above attributes of object OBJECTDA embedded in it.
 ;Name, Abbreviation, and Print Name are the values that existed when
 ;array was SET.
 ;
 ;                             **********
 ;
LOCKEMB(FILEDA,NAP,LUNLOCK) ; Function returns 1 if has successfully locked or unlocked all Titles in ^TMP("TIUFEMBED",$J,FILEDA,"TIUFTL",NAP)
 ; NAP See top of rtn TIUFLJ
 ; LUNLOCK = + or -
 N TITLEDA,NAME,ABBREV,PNAME,ONODE0,LOCKANS,CONT
 S LOCKANS=1
 S TITLEDA=0 F  S TITLEDA=$O(^TMP("TIUFEMBED",$J,FILEDA,"TIUFTL",NAP,TITLEDA)) Q:'TITLEDA  D  G:'LOCKANS LOCKX
 . I LUNLOCK="-" L -^TIU(8925.1,TITLEDA,0) Q
 . L +^TIU(8925.1,TITLEDA,0):1 I '$T W !!," Another user is editing one of the Titles you need to edit.  Please try later.",! S LOCKANS=0
LOCKX Q LOCKANS
 ;
STATEMB(FILEDA,STATFLG,NAP) ; Inactivate/reactivate titles in ^TMP("TIUFEMBED",$J,FILEDA,"TIUFTL",NAP).
 ; Edit Status to original status if STATFLG="O", to inactive if STATFLG="I".
 ; If restoring to Active, checks for problems, does not reactivate if problems are found.
 N TITLEDA,TNODE0,TSTATUS,NAME,ABBREV,PNAME,ONODE0,LIST,MSG,PTITLEDA
 S TITLEDA=0 F  S TITLEDA=$O(^TMP("TIUFEMBED",$J,FILEDA,"TIUFTL",NAP,TITLEDA)) Q:'TITLEDA  D
 . S TNODE0=^TIU(8925.1,TITLEDA,0),TSTATUS=^TMP("TIUFEMBED",$J,FILEDA,"TIUFTL",NAP,TITLEDA) ;may be ""
 . I STATFLG="O",TSTATUS="ACTIVE" D
 . . S PTITLEDA=+$O(^TIU(8925.1,"AD",TITLEDA,0))
 . . D STATLIST^TIUFLF5(TITLEDA,PTITLEDA,"A",.MSG,.LIST) Q:$D(DTOUT)
 . . I STATFLG="O" W !!,"Restoring IFN ",TITLEDA,"..."
 . . I LIST'["A" W !,MSG,! D PAUSE^TIUFXHLX Q
 . . D AUTOSTAT^TIUFLF6(TITLEDA,TNODE0,TSTATUS) W " ."
 . I STATFLG="O",TSTATUS="TEST" D AUTOSTAT^TIUFLF6(TITLEDA,TNODE0,TSTATUS) W " ."
 . I STATFLG="I",TSTATUS'="INACTIVE" D AUTOSTAT^TIUFLF6(TITLEDA,TNODE0,"INACTIVE") W " ."
 I STATFLG="O",$O(^TMP("TIUFEMBED",$J,FILEDA,"TIUFTL",NAP,0)) W !!,"Finished Restoring Titles to original Status.",!
 Q
 ;
EDBTEXT(FILEDA,NAP) ; Edit boilerplate text of the Titles in ^TMP("TIUFEMBED",$J,FILEDA,"TIUFTL",NAP).
 N TITLEDA,TNODE0,TSTATUS,NAME,ABBREV,PNAME,ONODE0
 S TITLEDA=0 F  S TITLEDA=$O(^TMP("TIUFEMBED",$J,FILEDA,"TIUFTL",NAP,TITLEDA)) Q:'TITLEDA  D  Q:$D(DTOUT)
 . D EDBOIL^TIUFLD1(TITLEDA,^TIU(8925.1,TITLEDA,0)) Q:$D(DTOUT)
 . D DEDBOIL^TIUFLD1(TITLEDA)
 Q
 ;
