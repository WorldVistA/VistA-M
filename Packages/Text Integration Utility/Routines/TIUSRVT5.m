TIUSRVT5 ;SP/WAT - Set/Remove consult lock values for templates and fields ;05/04/20  06:49
 ;;1.0;TEXT INTEGRATION UTILITIES;**290**;Jun 20, 1997;Build 548
 ;;ICRs ;;^XPAR 2263 ;;^DIE 2053 ;;^DIR 10026 ;;^DIC 10006
 Q
SETCNLOK ;set param value for TIU TEMPLATE CONSULT LOCK and CONSULT LOCK fields in 8927 & 8927.1
 N TIUPAR,TIUVAL,TIUERR,TIUTMPL,TIUIEN,TIUCNT,TIUCNLK,TIUARY,TIUY,TIUACT,TIUINST,CHOICE,TIUNEXT,TIULAST,TIUASK,TIUENT,TIUPIEN
 ;TIUVAL - template name or @ used in EN^XPAR
 ;TIUINST - instance value for parameter  TIUENT - entity for parameter  TIUPIEN - parameter IEN from 8989.51
 ;TIUTMPL - template name
 ;TIUACT - Add new template to parameter or Remove existing value
 ;TIUNEXT - next available instance value for parameter; used in DIR call for default response
 W @IOF
 S TIUPAR="TIU TEMPLATE CONSULT LOCK",TIUINST="",TIUCNT=""
 S TIUPIEN=$$FIND1^DIC(8989.51,,"BX",TIUPAR) I $G(TIUPIEN)'>0 W !!,"**TIU TEMPLATE CONSULT LOCK parameter not found!**" Q
 D GETENT^XPAREDIT(.TIUENT,TIUPIEN_"^"_TIUPAR)
 Q:$G(TIUENT)=""
 D GETLST^XPAR(.TIUY,TIUENT,TIUPAR,"N",.TIUERR)
 I $G(TIUERR)>0 D ERROR Q
 I $G(TIUY)>0 D
 . W !,?5,"NUMBER",?20,"TEMPLATE"
 . W !,?5,"======",?20,"========"
 . F  S TIUCNT=$O(TIUY(TIUCNT)) Q:TIUCNT=""  D
 .. W !,?5,TIUCNT,?20,$P(TIUY(TIUCNT),U,2)
 .. S TIULAST=TIUCNT
 . W !
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I $G(TIUY)>0 D
 . S DIR(0)="SB^R:REMOVE;A:ADD"
 . S TIUASK="Remove existing template or Add new entry?"
 . S DIR("A")=TIUASK
 . D ^DIR
 Q:$D(DIRUT)!($D(DIROUT))
 E  S Y="A" K DIR G ADD Q
 I Y="R" D  I $G(CHOICE)'["^"&($G(CHOICE)'="") D PAR K DIR W !,"... Deleted." Q
 . S TIUACT="R"
 . I $G(TIUY)=1 S CHOICE=$O(TIUY(""))
 . I $G(TIUY)>1 S CHOICE=$$CHOOSE(.TIUY) Q:$G(CHOICE)["^"!($G(CHOICE)="")
 . S TIUINST=CHOICE,TIUVAL="@"
 . S TIUIEN=$P(TIUY(CHOICE),U)
 I $G(CHOICE)["^" K DIR Q
ADD I Y="A" S TIUACT="A" N DIC,X,Y,DTOUT,DUOUT S DIC=8927,DIC(0)="ABE",DIC("S")="I $P(^TIU(8927,Y,0),U,19)[""GMR(123.5""" D ^DIC Q:$D(DTOUT)!($D(DUOUT))!(Y=-1)
 S TIUIEN=$P(Y,U),TIUTMPL=$P(Y,U,2)
 S TIUVAL=TIUTMPL
 S TIUNEXT=$G(TIULAST)+1 ;set lazy but if TIUNEXT is greater than 999, go back for empties
 I TIUNEXT=1000 D
 . F TIUCNT=1:1:TIUY Q:TIUNEXT<1000  D
 .. I '$D(TIUY(TIUCNT)) S TIUNEXT=TIUCNT
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT S DIR("0")="N^1:999:3^D SCREEN^TIUSRVT5",DIR("?")="Enter a new instance number; one not current in use"
 S DIR("B")=TIUNEXT D ^DIR Q:$D(DIRUT)!($D(DIROUT))
 S TIUINST=Y K DIR
PAR D EN^XPAR(TIUENT,TIUPAR,TIUINST,TIUVAL,.TIUERR)
 I $G(TIUERR)>0 D ERROR Q
 ;if no error then go set CONSULT LOCK values for template
 ;get all items for template
 D BLD(TIUIEN,.TIUARY)
 ;TIUCNLK - lock consult template? 1 to set, @ to remove; should be based on if template is added to or removed from the parameter
 ;set for each template
 S TIUCNLK=$S(TIUVAL="@":"@",1:1)
 N DIE,DA,DR S DIE="^TIU(8927,",DR=".2///^S X=TIUCNLK"
 F TIUCNT=1:1 Q:'$D(TIUARY(TIUCNT))  D
 .S DA=TIUARY(TIUCNT)
 .L +^TIU(8927,DA):0
 .I $T D:+$G(DA)>0 ^DIE L -^TIU(8927,DA)
 D FLD
 ;set for each template field
 S TIUCNT="",DIE="^TIU(8927.1,",DR=".17///^S X=TIUCNLK"
 F  S TIUCNT=$O(^TMP("TIU F",$J,TIUCNT)) Q:TIUCNT=""  D
 . S DA=$O(^TIU(8927.1,"B",^TMP("TIU F",$J,TIUCNT),""))
 . L +^TIU(8927.1,DA):0
 . I $T D:+$G(DA)>0 ^DIE L -^TIU(8927.1,DA)
 K ^TMP("TIU F",$J)
 Q
FLD ;build list of template fields
 ;TIUARY set in call to BLD
 K ^TMP("TIU FIELDS",$J)
 N TIUY,TIUFLD,CNT,CNT2,CNT3 S (CNT,CNT2)="",CNT3=1
 F  S CNT=$O(TIUARY(CNT)) Q:CNT=""  D
 . D GETBOIL^TIUSRVT(.TIUY,(TIUARY(CNT))) ;TIUY = name of ^TMP(TIU TEMPLATE,$J)
 . F  S CNT2=$O(@TIUY@(CNT2)) Q:CNT2=""  D
 .. S ^TMP("TIU FIELDS",$J,CNT3)=@TIUY@(CNT2),CNT3=CNT3+1 ;get every line; possible to have remnant of a wrapped field e.g. "40x2}"
 N BEG,END,FIELD,LINE,LNCNT,I,OK,LNWRAP K ^TMP("TIU F",$J) S LNCNT=1,OK=1,I="",LNWRAP=""
 F  S CNT=$O(^TMP("TIU FIELDS",$J,CNT)) Q:CNT=""  D
 . S LINE=^TMP("TIU FIELDS",$J,CNT)
 . I $L(LNWRAP)>0 S LINE=LNWRAP_LINE,LNWRAP="" ;if length, may need to finish building FLD from previous line of text
 . F  D  Q:END=0
 . . S BEG=$FIND(LINE,"{FLD:") I BEG=0 S END=0 Q  ;didn't find {FLD:, possible fragmented line
 . . S END=$FIND(LINE,"}",BEG)
 . . S:END=0 LNWRAP=LINE ; assume a fragment of a FLD, concatenate and check next LINE in template.
 . . Q:END=0
 . . S FIELD=$E(LINE,BEG,(END-2))
 . . S OK=1,I=""
 . . F  S I=$O(^TMP("TIU F",$J,I)) Q:I=""!(OK=0)  D  ;prevent dups in ^TMP("TIU F"
 . . . S:(FIELD["{FLD")!(FIELD?.E1"}") OK=0 Q  ;keep out some junk that GUI editor allows
 . . . S:^TMP("TIU F",$J,I)=FIELD OK=0
 . . S:OK ^TMP("TIU F",$J,LNCNT)=FIELD,LNCNT=LNCNT+1
 . . S LINE=$E(LINE,(END),999)
 K ^TMP("TIU FIELDS",$J)
 Q
SCREEN ;screen it
 N I,OK S OK=0,I=""
 F  S I=$O(TIUY(I)) Q:I=""  D
 .S:X=I OK=1
 ;if you get through the loop and OK=1, value already exists so we must kill it
 K:OK X
 Q
CHOOSE(TIUY) ;get item to delete
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,I
 S DIR(0)="F^1:3^K:'$D(TIUY(X)) X"
 S DIR("A")="Select NUMBER to remove"
 S DIR("?")="Enter NUMBER from list above."
 D ^DIR
 K DIR
 Q Y
ERROR ; show it
 W !,"ERROR #"_$P(TIUERR,U)
 W !,"TEXT: "_$P(TIUERR,U,2),!
 Q
BLD(TIUIEN,TIUARY) ; Build array of templates.
 ;
 N TIUIDX
 ;
 S TIUIDX=$O(TIUARY(" "),-1)+1
 S TIUARY(TIUIDX)=TIUIEN
 S TIUIDX=0
 F  S TIUIDX=$O(^TIU(8927,TIUIEN,10,TIUIDX))  Q:'TIUIDX  D
 .D BLD($P(^TIU(8927,TIUIEN,10,TIUIDX,0),U,2),.TIUARY)
 Q
