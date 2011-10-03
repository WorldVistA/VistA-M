TIUFLJ ;SLC/MAM - NOTE, WARNOBJ(NAP,OBJECTDA,NODE0), HASIT(OBJECTDA,ONODE0,FILEDA,NAP,HASIT), DHASIT(OBJECTDA,ONODE0,FILEDA,NAP,DHASIT), EMBED(OBJECTDA,ONODE0,NAP,ALLSUB), OBJUSED(FILEDA) ;;4/23/97
 ;;1.0;TEXT INTEGRATION UTILITIES;**12**;Jun 20, 1997
 ;
NOTE ; Write note re possible change in list of titles.
 I $G(^TMP("TIUF3",$J,$G(TIUFELIN)+2,0))'["Object is Embedded in Title" Q
 W !!,"NAME:  Since objects are embedded by name, abbreviation or print name, NOT by"
 W !,"file number, your edit of name, abbreviation or print name may affect which"
 W !,"titles have the object embedded in them.  You may want to note the list of",!,"these titles from the Detailed Display screen NOW before it changes."
 D PAUSE^TIUFXHLX
 Q
 ;
WARNOBJ(NAP,OBJECTDA,NODE0) ; Function writes warning re edit object Name, Abbrev or Print Name. Returns CONTINUE =  1 or 0.
 ; Needs OBJECTDA.  Needs NAP = N or A or P. Needs ^TMP("TIUFEMBED,$J,OBJECTDA,"TIUFTL",NAP).  Needs NODE0.
 N ATTR,CONTINUE,TITLEDA,LINENO
 S ATTR=$S(NAP="N":"Name",NAP="A":"Abbreviation",1:"Print Name")
 S CONTINUE=1
 K ^TMP("TIUFEMBED",$J,OBJECTDA) D EMBED(OBJECTDA,NODE0,NAP,0)
 S TITLEDA=0 F  S TITLEDA=$O(^TMP("TIUFEMBED",$J,OBJECTDA,"TIUFTL",NAP,TITLEDA)) Q:'TITLEDA  Q:^TMP("TIUFEMBED",$J,OBJECTDA,"TIUFTL",NAP,TITLEDA)'="ACTIVE"  D
 . S LINENO=$O(^TMP("TIUF3IDX",$J,"DAF",TITLEDA,0))
 . I CONTINUE S CONTINUE=0 D
 . . D FULL^VALM1 S TIUFFULL=1 W !!
 . . W !,"Can't edit ",$$UPPER^TIULS(ATTR),": Object ",ATTR," is embedded in the boilerplate text"
 . . W !,"of the following active title(s).  If you wish to edit object ",ATTR,", you"
 . . W !,"must first inactivate these titles.  Then, after editing the object, you will"
 . . W !,"need to update the boilerplate text of these titles and then reactivate them."
 . . W !,"If you wish to edit ",ATTR," please note this list NOW and save it until all"
 . . W !,"titles are reactivated.",!
 . W ^TMP("TIUF3",$J,LINENO,0),!
 I CONTINUE D:NAP="N" NOTE G WARNX
 I 'CONTINUE D PAUSE^TIUFXHLX W !!
WARNX Q CONTINUE
 ;
HASIT(OBJECTDA,ONODE0,FILEDA,NAP,HASIT) ; Passes back HASIT=1 if title/
 ;component FILEDA has object (its name or abbreviation or print name
 ;or any of these, depending on NAP) in it.  To "Have it", Abbrev and
 ;Print Name must be exact, but Name can differ in case as long as
 ;uppercase(embedded name) = object name.
 ; Requires all vars to be received and already defined.
 N NAME,ABBREV,PNAME,TIUFK,TIUFJ,EMBEDNM,LINE
 S NAME=$P(ONODE0,U),ABBREV=$P(ONODE0,U,2),PNAME=$P(ONODE0,U,3)
 S TIUFJ=0 F  S TIUFJ=$O(^TIU(8925.1,FILEDA,"DFLT",TIUFJ)) Q:'TIUFJ  D
 . S LINE=$G(^TIU(8925.1,FILEDA,"DFLT",TIUFJ,0))
 . I LINE["|" F TIUFK=2:2:$L(LINE,"|") S EMBEDNM=$P(LINE,"|",TIUFK) D
 . . I EMBEDNM="" Q
 . . I NAP="N"!(NAP="ANY"),$$UPPER^TIULS(EMBEDNM)=NAME S HASIT=1
 . . I NAP="A"!(NAP="ANY"),EMBEDNM=ABBREV S HASIT=1
 . . I NAP="P"!(NAP="ANY"),EMBEDNM=PNAME S HASIT=1
 Q
 ;
DHASIT(OBJECTDA,ONODE0,FILEDA,NAP,DHASIT) ; Does HASIT for FILEDA descendants
 N TIUFITEM,TIUFI,MISSITEM,ITENDA,IFILEDA
 S MISSITEM=$$MISSITEM^TIUFLF4(FILEDA)
 I MISSITEM W !!," Corrupt Database: File Entry "_FILEDA_" Has Nonexistent Item "_MISSITEM_" ; See IRM",!,"Can't tell whether or not "_FILEDA_" has object.",! D PAUSE^TIUFXHLX G DHASX
 D ITEMS^TIUFLT(FILEDA)
 S TIUFI=0
 F  S TIUFI=$O(TIUFITEM(TIUFI)) Q:'TIUFI  D
 . S ITENDA=$P(TIUFITEM(TIUFI),U,2)
 . S IFILEDA=+$G(^TIU(8925.1,FILEDA,10,+ITENDA,0))
 . D HASIT(OBJECTDA,ONODE0,IFILEDA,NAP,.DHASIT)
 . D DHASIT(OBJECTDA,ONODE0,IFILEDA,NAP,.DHASIT)
DHASX Q
 ;
OBJUSED(FILEDA) ; Function returns 1 if FILEDA is embedded in boilerplate text of a Title or component; 1A if any of these titles is active; else 0.
 N USEDANS,TITLEDA,NODE0
 S NODE0=^TIU(8925.1,FILEDA,0)
 K ^TMP("TIUFEMBED",$J,FILEDA) D EMBED(FILEDA,NODE0,"ANY",1)
 I '$O(^TMP("TIUFEMBED",$J,FILEDA,"TIUFTL","ANY",0)),'$O(^TMP("TIUFEMBED",$J,FILEDA,"TIUFORPHAN","ANY",0)),'$O(^TMP("TIUFEMBED",$J,FILEDA,"TIUFCO","ANY",0)) S USEDANS=0 G OBJUX
 S USEDANS=1,TITLEDA=0 F  S TITLEDA=$O(^TMP("TIUFEMBED",$J,FILEDA,"TIUFTL","ANY",TITLEDA)) Q:'TITLEDA  I ^TMP("TIUFEMBED",$J,FILEDA,"TIUFTL","ANY",TITLEDA)="ACTIVE" S USEDANS="1A" G OBJUX
OBJUX Q USEDANS
 ;
EMBED(OBJECTDA,ONODE0,NAP,ALLSUBS) ; Sets ^TMP("TIUFEMBED",$J,OBJECTDA,SUBSCPT,NAP,FILEDA); See top of routine.
 ; Sets ^TMP("TIUFEMBED",$J,OBJECTDA,"TIUFTL",NAP,FILEDA) = status of FILEDA for Titles only: ACTIVE or  TEST or INACTIVE or "".
 ; If ALLSUBS=1, sets array for subscripts TIUFTL, TIUFCO and TIUFORPHAN.  Otherwise, just sets TIUFTL.
 N PARENT,FILEDA,TNODE0,STATUS,CONODE0
 K ^TMP("TIUFEMBED",$J,OBJECTDA)
 I '$G(ALLSUBS) S ALLSUBS=0
 S FILEDA=0 F  S FILEDA=$O(^TIU(8925.1,"AT","DOC",FILEDA)) Q:'FILEDA  D
 . S TNODE0=$G(^TIU(8925.1,FILEDA,0)) I TNODE0="" W !!,"Title ",FILEDA," from the AT cross reference does not exist; see IRM",! Q
 . S (HASIT,DHASIT)=0
 . D HASIT(OBJECTDA,ONODE0,FILEDA,NAP,.HASIT)
 . D DHASIT(OBJECTDA,ONODE0,FILEDA,NAP,.DHASIT)
 . I 'HASIT,'DHASIT Q
 . I 'DHASIT S ^TMP("TIUFEMBED",$J,OBJECTDA,"TIUFCO",NAP,FILEDA)=""
 . S TNODE0=^TIU(8925.1,FILEDA,0),STATUS=$$STATWORD^TIUFLF5($P(TNODE0,U,7))
 . S ^TMP("TIUFEMBED",$J,OBJECTDA,"TIUFTL",NAP,FILEDA)=STATUS
 I 'ALLSUBS Q
 S FILEDA=0 F  S FILEDA=$O(^TIU(8925.1,"AT","CO",FILEDA)) Q:'FILEDA  D
 . S CONODE0=$G(^TIU(8925.1,FILEDA,0)) I CONODE0="" W !!,"Component ",FILEDA," from the AT cross reference does not exist; see IRM",! Q
 . I $D(^TIU(8925.1,"AD",FILEDA)) Q
 . S (HASIT,DHASIT)=0
 . D HASIT(OBJECTDA,ONODE0,FILEDA,NAP,.HASIT)
 . D DHASIT(OBJECTDA,ONODE0,FILEDA,NAP,.DHASIT)
 . I 'HASIT,'DHASIT Q
 . S ^TMP("TIUFEMBED",$J,OBJECTDA,"TIUFORPHAN",NAP,FILEDA)=""
 Q
 ;
