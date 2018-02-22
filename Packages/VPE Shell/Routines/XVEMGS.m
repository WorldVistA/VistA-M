XVEMGS ;DJB/VGL**SAVE,UNSAVE ;2017-08-15  12:48 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in UNSAVS+13 (c) 2016 Sam Habiel
 ;
SAVE ;Save lines of code (to be UNsaved to a new location).
 NEW CNT,GLNAM,I,ND,RNG
 S CNT=1,RNG=$$GETRANG^XVEMKTR("VGL"_GLS) Q:RNG="^"
 I RNG["^" F ND=$P(RNG,"^",1):1:$P(RNG,"^",2) D SAVE1
 I RNG["," F I=1:1:$L(RNG,",") S ND=$P(RNG,",",I) D SAVE1
 S ^XVEMS("E","SAVE",$J,CNT)=""
 W "   Save Complete" H 1
 Q
SAVE1 ;
 Q:'$D(^TMP("XVV","VGL"_GLS,$J,ND))  S GLNAM=^(ND) Q:GLNAM']""
 S ^XVEMS("E","SAVE",$J,CNT)=$C(9)_@GLNAM,CNT=CNT+1
 Q
 ;===================================================================
UNSAVE ;Unsave code previously saved
 I '$D(^XVEMS("E","SAVE",$J)) D MSG^XVEMGUM(22,1) Q
 NEW CD,FLAGERR,I,J,LINES,NODE I $G(XVVSHL)'="RUN" NEW XVVSHC
 D CURSOR^XVEMKU1(0,XVVT("S2")+XVVT("FT")-2,1)
 F I=1:1 Q:^XVEMS("E","SAVE",$J,I)=""  Q:'$D(^(I))
 S LINES=I-1 D  D PAUSE^XVEMKU(1)
 . W LINES," LINE",$S(LINES=1:"",1:"S")," of code saved."
 . W " NOTE: Exit and reenter VGL to see newly created nodes."
 F I=1:1:LINES D UNSAVS Q:CD="^"
 Q
UNSAVS ;Get subscript
 S CD="" D CURSOR^XVEMKU1(0,XVVT("S2")+XVVT("FT")-2,1)
 W "Enter subscript to load LINE ",I," into a global node:"
 D SCREEN^XVEMKEA(GL_"(",2,75)
 I XVVSHC="<ESCH>" D MSG^XVEMGUM(21,1) G UNSAVS
 I CD="?"!(CD="??") D MSG^XVEMGUM(21,1) G UNSAVS
 I ",<ESC>,<F1E>,<F1Q>,<TAB>,<TO>,"[(","_XVVSHC_",")!(CD']"") S CD="^"
 Q:CD="^"
 I XVVSHC'="<RET>",XVVSHC?1"<".E1">".E G UNSAVS
 S NODE=GL_"("_CD S:$E(NODE,$L(NODE))'=")" NODE=NODE_")"
 S FLAGERR=0 D  G:FLAGERR UNSAVS
 . N $ESTACK,$ETRAP S $ETRAP="D ERROR^XVEMGS,UNWIND^XVEMSY"
 . I $G(XVSIMERR6) S $EC=",U-SIM-ERROR,"
 . S CD=^XVEMS("E","SAVE",$J,I)
 . F J=1:1:($L(CD,$C(9))-1) S CD=$P(CD,$C(9),1)_$P(CD,$C(9),2,999)
 . I $D(@NODE)#2 D MSG^XVEMGUM(12,1) S CD="",FLAGERR=1 Q
 . S @NODE=CD
 Q
ERROR ;
 D CURSOR^XVEMKU1(0,XVVT("S2")+XVVT("FT")-2,1)
 W $C(7),"Invalid subscript.."
 S CD="",FLAGERR=1 D PAUSE^XVEMKU(1)
 Q
