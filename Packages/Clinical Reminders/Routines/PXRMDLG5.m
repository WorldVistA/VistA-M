PXRMDLG5 ; SLC/PJH - Reminder Dialog Edit/Inquiry ;06/08/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ;
ALT(DIEN,LEV,DSEQ,NODE,VIEW,NLINE,CNT,ALTLEN) ;
 ;Display branching logic text in dialog summary view
 N DATA,DNAM,DTYP,IEN,TERM,TNAME,TSTAT,TEMP
 S DATA=$G(^PXRMD(801.41,DIEN,49))
 I '+$P(DATA,U)!($P($G(DATA),U,2)="") Q
 S TNAME=$P($G(^PXRMD(811.5,$P(DATA,U),0)),U)
 S TSTAT=$S($P(DATA,U,2)="1":"TRUE",1:"FALSE")
 I +$P(DATA,U,3)>0 D
 .S IEN=$P(DATA,U,3),DNAM=$P($G(^PXRMD(801.41,IEN,0)),U)
 .S DTYP=$S($P($G(^PXRMD(801.41,IEN,0)),U,4)="E":"Element",$P($G(^PXRMD(801.41,IEN,0)),U,4)="G":"Group")
 I $G(DNAM)="" S TEMP="Suppressed if Reminder Term "_TNAME_" evaluates as "_TSTAT
 I $G(DNAM)'="" S TEMP="Replaced by "_DNAM_" if Reminder Term "_TNAME_" evaluates as "_TSTAT
 D TEXT(.NLINES,CNT,ALTLEN,TEMP,NODE)
 Q
 ;
ASK(YESNO,PIEN) ;Confirm
 K DIR,DIROUT,DIRUT,DNAME,DTOUT,DTYP,DUOUT,TEXT,X,Y
 N DDATA,DNAME,DTYP
 S DDATA=$G(^PXRMD(801.41,PIEN,0))
 ;Parent name and type
 S DNAME=$P(DDATA,U),DTYP=$P(DDATA,U,4)
 ;
 S DIR(0)="YA0"
 S DIR("A")="Add sequence "_SEQ_" to "
 I DTYP="G" S DIR("A")=DIR("A")_"group "_DNAME_": "
 E  S DIR("A")=DIR("A")_"reminder dialog ?: "
 S DIR("B")="N",DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D XHLP^PXRMDLG(1)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0)) I YESNO'="Y" S DUOUT=1
 S VALMBCK="R"
 Q
 ;
BHELP(VALUE) ;
 N HTEXT
 D FULL^VALM1
 ;Help text for Reminder Dialog Branching logic
 I VALUE=1 D
 .;Reminder Term field
 .S HTEXT(1)="Enter a reminder term that will be used to determine if the reminder"
 .S HTEXT(2)="element/group should be replaced or suppressed if the reminder term evaluation"
 .S HTEXT(3)="matches the value in the Reminder Term Status field."
 I VALUE=2 D
 .;Reminder Term Status field
 .S HTEXT(1)="Enter either 1 for true or 0 for false. This value will be used with the"
 .S HTEXT(2)="reminder term field to determine if this item should be replaced with a"
 .S HTEXT(3)="different element/group defined in the Replacement Element/Group field, or if"
 .S HTEXT(4)="this item should be suppressed."
 I VALUE=3 D
 .;Replacement Element/Group field
 .S HTEXT(1)="Enter an element/group that will be used as a replacement to thisitem, or"
 .S HTEXT(2)="leave this field blank to suppress this item if the term evaluation"
 .S HTEXT(3)="matches the value defined in the term status field. "
 I VALUE=4 D
 .;Patient Specific field
 .S HTEXT(1)="Enter either 1 for true or 0 for false. This value must be set to true"
 .S HTEXT(2)="if item in this dialog will be using reminder term to either replace an item"
 .S HTEXT(3)="or to suppress an item."
 D HELP^PXRMEUT(.HTEXT)
 Q
 ;
INQ(DIEN) ;INQ Inquiry/Print option
 ; Used by 801.41 print templates
 ; [PXRM REMINDER DIALOG]
 ; [PXRM DIALOG GROUP]
 ;
 N DEF,DEF1,DEF2 D DEF^PXRMRUTL("811.902",.DEF,.DEF1,.DEF2)
 N NLINE,NODE,NSEL,SUB
 S NLINE=0,NODE="PXRMDLG4",NSEL=0
 K ^TMP(NODE,$J)
 ;
 ;Components
 W !!,"      Seq.       Dialog",!
 D DETAIL^PXRMDLG4(DIEN,"",4,NODE)
 ;
 ;Print lines from workfile
 S SUB=""
 F  S SUB=$O(^TMP(NODE,$J,SUB)) Q:'SUB  W !,^TMP(NODE,$J,SUB,0)
 K ^TMP(NODE,$J)
 Q
 ;
MH(IEN) ;Allow IEN=109 (HX2) as a place holder for 601 entries that do not
 ;have a corresponding 601.71 entry.
 I IEN=109 Q 1
 I $G(PXRMINST)=1 Q 1
 N MAXNUM
 S MAXNUM=+$P($G(^PXRM(800,1,"MH")),U)
 I MAXNUM=0 S MAXNUM=25
 ;DBIA #5056
 Q $$ONECR^YTQPXRM5(IEN,MAXNUM)
 ;
MSEL(NUM) ;
 I NUM=4,'$$PATCH^XPDUTL("OR*3.0*243") D EN^DDIOL("THIS SELECTION IS NOT VALID, UNTIL CPRS 27 IS INSTALLED") Q 0
 Q 1
 ;
MHREQHLP ;
 N TEXT
 S TEXT(1)="Select 0, ""Optional open and optional complete (partial complete possible)"","
 S TEXT(2)="if the user should be able to optionally select/open the MH test in the reminder dialog and optionally complete the MH test before the reminder dialog can be finished."
 S TEXT(3)=" "
 S TEXT(4)="Select 1, ""Required open and required complete before finish"","
 S TEXT(5)="if the user is required to select/open and complete the MH test in the reminder dialog before the reminder dialog can be finished."
 S TEXT(6)=" "
 S TEXT(7)="Select 2, ""Optional open and required complete or cancel before finish"","
 S TEXT(8)="if the user should be able to optionally select/open the MH test in the reminder dialog; however, if the user opens the MH test, then the user is required to complete or cancel the MH test before the reminder dialog can be finished."
 S TEXT(9)=" "
 S TEXT(10)="Note: Clicking the cancel button in the MH Test is considered the same as not opening the MH Test."
 S TEXT(11)="Also, Option 2, ""Optional open and required complete or cancel before finish"", only works with CPRS 27 and"
 S TEXT(12)="YS_MHA.dll. If Option 2 is selected and the user is using a pre-CPRS 27 version this option will be treated by CPRS as Option 1, ""Required open and required complete before finish""."
 D HELP^PXRMEUT(.TEXT)
 Q
 ;
NTERM(DA,OTERM,NTERM) ;
 I +OTERM=0 S OTERM=$P($G(DA),U)
 I +NTERM=0 K OTERM Q 2
 I +OTERM=0,+NTERM>0 K OTERM Q 1
 I +OTERM'=+NTERM K OTERM Q 0
 K OTERM
 Q 1
 ;
OTERM(DA) ;
 K OTERM
 S OTERM=$P($G(^PXRMD(801.41,DA,49)),U)
 Q
 ;
RESCHK(IEN) ;Called by input template PXRM EDIT ELEMENT. Preserve Y so template
 ;branching works.
 N CNT,FDA,MSG,RG,RGIEN,VALID,Y
 S CNT=0
 F  S CNT=$O(^PXRMD(801.41,IEN,51,CNT)) Q:CNT'>0  D
 .S RGIEN=$P($G(^PXRMD(801.41,IEN,51,CNT,0)),U) I +RGIEN'>0 Q
 .S RG=$P($G(^PXRMD(801.41,RGIEN,0)),U,1)
 .I RG="" Q
 .S VALID=$$RGLSCR(IEN,RG,RGIEN)
 .I VALID Q
 .W !,"Deleting the result group ",RG," from the element/group."
 .S FDA(801.41121,CNT_","_IEN_",",.01)="@"
 .D FILE^DIE("E","FDA","MSG")
 .S RGKILL=1
 .I $D(MSG) D AWRITE^PXRMUTIL("MSG")
 Q
 ;
RSELEDIT(DA) ;
 N NODE,RESULT
 ;RESULT=0 EDIT NOTHING
 ;RESULT=1 EDIT INFORMATIONAL TEXT
 ;RESULT=2 EDIT EVERYTHING
 S RESULT=2
 I $G(PXRMINST)=1,DUZ(0)="@" Q RESULT
 S NODE=$G(^PXRMD(801.41,DA,100))
 I $P(NODE,U)="N" S RESULT=0
 I RESULT=0,+$P(NODE,U,4)=0 S RESULT=1
 Q RESULT
 ;
RGLSCR(DA,X,IEN) ;Input transform/screen for RESULT GROUP LIST
 I $G(PXRMINST)=1 Q 1
 I $G(PXRMEXCH)=1 Q 1
 N HELP,MHTEST,NMATCH,TEXT,VALID,Y
 S NMATCH=0
 S MHTEST=$O(^PXRMD(801.41,"B",X),-1)
 F  S MHTEST=$O(^PXRMD(801.41,"B",MHTEST)) Q:(NMATCH>1)!(MHTEST'[X)  S NMATCH=NMATCH+1
 ;If there is an exact match to the user's input turn help on.
 S HELP=$S($G(DIQUIET):0,NMATCH=1:1,1:0)
 S VALID=1
 ;Make sure the TYPE is a result group
 I '$D(^PXRMD(801.41,"TYPE","S",IEN)) D
 . I HELP S TEXT(1)="TYPE must be a result group."
 . S VALID=0
 ;Make sure the finding item for the element matches the 
 ;MH Test assigned to the Result Group
 S MHTEST=+$P($G(^PXRMD(801.41,DA,1)),U,5) I MHTEST="" D
 . I HELP S TEXT(2)="The MH test is missing."
 . S VALID=0
 I +$P($G(^PXRMD(801.41,IEN,50)),U)'=MHTEST D
 . I HELP S TEXT(3)="The finding item does not match the MH Test assigned to the Result Group"
 . S VALID=0
 ;Make sure a scale has been defined.
 I +$P($G(^PXRMD(801.41,IEN,50)),U,2)'>0 D
 . I HELP S TEXT(4)="An MH Scale must be defined."
 . S VALID=0
 ;Make sure it is not disabled.
 I +$P($G(^PXRMD(801.41,IEN,0)),U,3)>0 D
 . S VALID=0
 . I HELP D
 .. N EM,TYPE
 .. S TYPE=$P(^PXRMD(801.41,IEN,0),U,4)
 .. S TYPE=$$EXTERNAL^DILFD(801.41,4,"",TYPE,.EM)
 .. S TEXT(5)="The "_TYPE_" is disabled."
 I HELP,'VALID D EN^DDIOL(.TEXT)
 Q VALID
 ;
SETGBL(FILE) ;
 N GBL,LEN
 S LEN=$L(FILE)
 I $E(FILE,LEN)="," S GBL=U_$E(FILE,1,(LEN-1))_")"
 I $E(FILE,LEN)="(" S GBL=U_$E(FILE,1,(LEN-1))
 Q GBL
 ;
TERMS(DA,X) ;
 N TERM
 S TERM=$P($G(^PXRMD(801.41,DA,49)),U)
 I +TERM=0 D  Q 0
 .W !,"Cannot set Reminder Term Status if the Reminder Term field is blank"
 .H 2
 I +TERM>0,$G(X)="" Q 2
 Q 1
 ;
TEXT(NLINES,CNT,ATLEN,TEMP,NODE) ;
 N CNT1,NOUT,OUTPUT,WIDTH
 S WIDTH=IOM-(2+(CNT+ATLEN))
 S CNT1=1 D FORMATS^PXRMTEXT(1,WIDTH,TEMP,.NOUT,.OUTPUT)
 I NOUT>0 F CNT1=1:1:NOUT D
 .S NLINE=NLINE+1,^TMP(NODE,$J,NLINE,0)=$J("",2+(CNT+ATLEN))_OUTPUT(CNT1)
 Q
 ;
