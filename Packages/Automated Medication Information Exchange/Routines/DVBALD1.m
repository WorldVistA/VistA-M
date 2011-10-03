DVBALD1 ;ALB/JLU;extension of DVBALD;9/19/94
 ;;2.7;AMIE;;Apr 10, 1995
 ;
ADD(WHO) ;this is used by both the add and create actions of List Man
 ;discharge.
 K DVBAQUIT
 S VAR(1,0)="0,0,0,2,1^"_$S(WHO="AD":"You may now add to the default list of discharge types.",1:"You may now select a new list of discharge types.")
 S VAR(2,0)="0,0,0,1,0^Both 'active' and 'inactive' discharge types can be selected."
 S VAR(3,0)="0,0,0,1:2,0^If help or a list is needed enter a '?'"
 D WR^DVBAUTL4("VAR")
 K VAR
 S DVBIEDSC=$$DSCTIEN^DVBAUTL6("DISCHARGE") ;gets the IFN of "discharge"
 I DVBIEDSC<1 DO  Q
 .S VAR(1,0)="1,0,0,2,0^No discharge type MAS Movement Transaction type was found"
 .S VAR(2,0)="0,0,0,1,0^Contact your site manager."
 .D WR^DVBAUTL4("VAR")
 .S DVBAQUIT=1
 .K VAR
 .Q
 F  DO  Q:$D(DVBAQUIT)  ;loop to keep asking for movement types
 .S DIC="^DG(405.2,",DIC(0)="AEMQZ"
 .S DIC("S")="I DVBIEDSC=$P(^(0),U,2)!(+Y=18)!(+Y=40)!(+Y=43) I '$D(^TMP(""DVBA"",$J,""DUP"",+Y))"
 .D ^DIC
 .I +Y>0 DO
 ..I $$CHECKDUP(+Y) Q  ;checks for duplicates not really needed but
 ..D SETARAY(Y)
 ..Q
 .I +Y<1 S DVBAQUIT=1
 .Q
 K DVBIEDSC
 Q
 ;
CHECKDUP(A) ;checks if an entry has already been selected.  if yes returns a 1
 I $D(^TMP("DVBA",$J,"DUP",+Y)) DO  Q 1
 .S VAR(1,0)="1,0,0,2,0^This discharge type has already been selected."
 .D WR^DVBAUTL4("VAR")
 .K VAR
 .Q
 E  Q 0
 ;
SETARAY(A) ;sets the necessary listmanager and global arrays for this
 ;selection
 ;A is the IEN of the discharge type and the second piece is the
 ;external value
 N TEXT
 S VALMCNT=VALMCNT+1
 S TEXT=$$SETFLD^VALM1(VALMCNT,"","ITEM")
 S TEXT=$$SETFLD^VALM1($P(A,U,2),TEXT,"DISCHARGE TYPE")
 S TEXT=$$SETFLD^VALM1(+A,TEXT,"DISCHARGE CODE")
 S DVBA=$$CHECK^DVBAUTL6(+A)
 I DVBA=0 S TEXT=$$SETFLD^VALM1("INACTIVE",TEXT,"STATUS")
 S @VALMAR@(VALMCNT,0)=TEXT
 S @VALMAR@("IDX",VALMCNT,VALMCNT)=""
 S ^TMP("DVBA",$J,"DUP",+A)=""
 S @VALMAR@("FND",VALMCNT,+A)=""
 Q
 ;
DELETE ;This entry point allows the users to delete from the list of discharge
 ;types
 K DVBAQUIT
 F  DO  Q:$D(DVBAQUIT)
 .D RE^VALM4
 .S VALMNOD=$G(XQORNOD(0))
 .D EN^VALM2(VALMNOD,"O")
 .I '$O(VALMY("")) S DVBAQUIT=1 Q
 .S DVBA=""
 .F  S DVBA=$O(VALMY(DVBA)) Q:DVBA=""  DO
 ..S DVBB=$O(@VALMAR@("FND",DVBA,0))
 ..K ^TMP("DVBA",$J,"DUP",DVBB)
 ..K @VALMAR@("FND",DVBA,DVBB)
 ..K @VALMAR@(DVBA,0)
 ..K @VALMAR@("IDX",DVBA)
 ..Q
 .D RELIST
 .Q
 K DVBA,DVBB
 Q
 ;
RELIST ;re-organizes the list after a deletion
 N DVBA,DVBOLD,DVBOLDC
 S VALMCNT=0,DVBA=""
 F  S DVBA=$O(@VALMAR@(DVBA)) Q:'DVBA  DO
 .S VALMCNT=VALMCNT+1
 .S DVBOLD=$$SETFLD^VALM1(VALMCNT,@VALMAR@(DVBA,0),"ITEM")
 .S DVBOLDC=$O(@VALMAR@("FND",DVBA,0))
 .K @VALMAR@(DVBA,0)
 .K @VALMAR@("IDX",DVBA)
 .K @VALMAR@("FND",DVBA)
 .S @VALMAR@(VALMCNT,0)=DVBOLD
 .S @VALMAR@("IDX",VALMCNT,VALMCNT)=""
 .S @VALMAR@("FND",VALMCNT,DVBOLDC)=""
 .Q
 Q
