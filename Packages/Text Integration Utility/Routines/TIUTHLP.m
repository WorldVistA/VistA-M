TIUTHLP ; SLC/JER - Help for Transcription ;4/18/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**21,113**;Jun 20, 1997
MAIN ; Control branching
 N DIC,DTOUT,DUOUT,X,Y,TIUFPRIV S TIUFPRIV=1
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 S DIC=8925.1,DIC(0)="AEMQZ",DIC("A")="Select DOCUMENT DEFINITION: "
 S DIC("B")=$G(^DISV(+DUZ,"^TIU(8925.1,"))
 D ^DIC I $D(DTOUT) W "   Timed out..." Q
 I +Y'>0 D  Q
 . I $D(DUOUT) Q
 . W !!,"Required information for UPLOAD help not set up for this document."
 I $P(TIUPRM0,U,16)="D" D DHDR(.Y,TIUPRM0,TIUPRM1)
 E  I $P(TIUPRM0,U,16)="C" D CHDR(.Y,TIUPRM0,TIUPRM1)
 E  W !!,"Required information for UPLOAD help not set up for this report type."
 Q
DHDR(TIUX,TIUPRM0,TIUPRM1) ; Display Delimited String Header
 N TIUA,TIUI,TIUHSIG,TIUESTR,TIUHSTR,TIULIM,TIUTYP,TIUITEM
 N TIUNODE
 S TIUHSIG=$P(TIUPRM0,U,10),TIULIM=$P(TIUPRM0,U,13),TIUTYP=$P(TIUX(0),U,2)
 S TIUA=+TIUX,TIUI=2,(TIUHSTR,TIUESTR)=TIUHSIG_TIULIM_TIUTYP
 F  S TIUI=$O(^TIU(8925.1,TIUA,"ITEM",TIUI)) Q:+TIUI'>0  D
 . S TIUNODE=$G(^TIU(8925.1,TIUA,"ITEM",TIUI,0))
 . S $P(TIUHSTR,TIULIM,TIUI)=$P(TIUNODE,U,2)
 . S $P(TIUESTR,TIULIM,TIUI)=$P(TIUNODE,U,5)
 W !!,"Header line example:"
 W !!,TIUESTR ;header string with example of data
 W !!,"Report format:"
 W !!,TIUHSTR ;Header string with data description
 D RESTHDR(.TIUX,TIUPRM0,TIUPRM1)
 Q
CHDR(TIUX,TIUPRM0,TIUPRM1) ; Display Captioned Header
 N TIUA,TIUI,TIUNODE
 S TIUA=+TIUX
 W !!,$P(TIUPRM0,U,10),":",?40,$P(TIUX(0),U)
 S TIUI=0
 F  S TIUI=$O(^TIU(8925.1,TIUA,"HEAD",TIUI)) Q:+TIUI'>0  D
 . S TIUNODE=$G(^TIU(8925.1,TIUA,"HEAD",TIUI,0))
 . W !,$P(TIUNODE,U)_":",?40,$S($P(TIUNODE,U,5)]"":$P(TIUNODE,U,5),1:"""field entry""")
 W !,$P(TIUPRM0,U,12)
 D RESTHDR(.TIUX,TIUPRM0,TIUPRM1)
 Q
RESTHDR(TIUX,TIUPRM0,TIUPRM1) ;Header info that is same for both types
 W !?2,$P(TIUX(0),U)," Text"
 W !,$P(TIUPRM0,U,11)
 W !!,"*** File should be ASCII with width no greater than 80 columns."
 W !,"*** Use ","""",$P(TIUPRM1,U,6),""""," for ","""BLANKS"""
 W " (word or phrase in dictation that isn't understood)."
 Q
DIV ; Display user log-on division
 W $C(7),!!,"You are currently logged into DIVISION: "
 W $P($$NS^XUAF4(+$G(DUZ(2))),U),!!,"If a hospital location cannot be"
 W " determined for an uploaded document,",!,"the document's division"
 W " may be loaded with your log-in division."
 Q
