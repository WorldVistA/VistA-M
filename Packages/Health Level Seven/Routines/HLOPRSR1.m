HLOPRSR1 ;ALB/CJM - Visual Parser 12 JUN 1997 10:00 am ;11/12/2008
 ;;1.6;HEALTH LEVEL SEVEN;**138,139**;Oct 13, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 ;Definitions:
 ;$$SCRNSIZE number of lines in the scrolling region
 ;@MSG@() array containing the message
 ;$$MSGSIZE number of lines in the message
 ;$$TOP msg line number appearing at the top of the scrolling region.
 ;     It could be negative if the user scrolled up past the top of
 ;     the msg.
 ;$$BOT msg line number of the line that appears at the bottom of the
 ;          scrolling area. It could be bigger than $$MSGSIZE if the user
 ;          scrolled down past the msg
 ;$$LINE    the msg line being parsed
 ;$$X       the character parsing position within the msg line
 ;$$Y       the screen line of the current message line
 ;$$SEG     current segment #
 ;$$FLD     current field number
 ;$$REP     current repitition number
 ;$$COMP    current component #
 ;$$SUB     current subcomponent #
 ;$$SEGSTART (<segment number>) msg line # that the segment starts on
 ;SEGTYPE - 3 character segment type of the current segment
 ;DELIM -field,component,subcomponent,repitition dlimiters 
 ;FLD - field delimiter
 ;REP -repitition delimiter
 ;COMP - component delimiter
 ;SUB - subcomponent delimiter
 ;SEG - SEG(<seg#>)=line it starts on
 ;SEGLINE() - SEGLINE(<line number>)=segment it is in (1st line only)
 ;@DESCRIBE@() - list of text lines containing the description of current field
 ;
PARSE(PARMS) ;
 N MSG,POS,SEG,INPUT,QUIT,IOBM,IOTM,HILITE,FLD,REP,ESC,COMP,SUB,DELIM,SEGTYPE,SEGLINE,OLDBM,OLDTM,DESCRIBE,VALUE,LASTPART,VERSION,VALMBCK,XGRT,OLD,REPEAT
 S OLDBM=$G(IOBM),OLDTM=$G(IOTM)
 S VALMBCK="R"
 Q:'$$SETUP^HLOPRSR3(.PARMS,.MSG,.POS,.SEG)
 S QUIT=0
 F  S INPUT=$$READ^XGF(1,30) D  Q:QUIT  W IOCUON
 .D
 ..;remove what the user typed
 ..N CHAR,X,Y
 ..W IOCUOFF
 ..S CHAR=$$GETCHAR^HLOPRSR2
 ..I CHAR="" S CHAR=" "
 ..D IOXY($$Y,$$X)
 ..W $S($P(POS("CURRENT DELIMITER"),"^",2):IORVON,1:IOINHI)
 ..W IORVOFF,IOINORM
 ..W CHAR
 .;
 .I XGRT="UP" D UP^HLOPRSR2 Q
 .I (INPUT="U")!(INPUT="u") D UP^HLOPRSR2 Q
 .I XGRT="DOWN" D DOWN^HLOPRSR2 Q
 .I (INPUT="D")!(INPUT="d") D DOWN^HLOPRSR2 Q
 .I XGRT="LEFT" D LEFT^HLOPRSR2 Q
 .I (INPUT="L")!(INPUT="l") D LEFT^HLOPRSR2 Q
 .I XGRT="RIGHT" D RIGHT^HLOPRSR2 Q
 .I XGRT="TAB" D RIGHT^HLOPRSR2 Q
 .I (INPUT="R")!(INPUT="r") D RIGHT^HLOPRSR2 Q
 .I (INPUT="Q")!(INPUT="q") S QUIT=1
 .I (INPUT="?")!(INPUT="h")!(INPUT="h") D HELP^HLOPRSR3 Q
 .D IOXY($$Y,$$X) W IOCUON
 K @MSG
 I $L(DESCRIBE) K @DESCRIBE
 D CLEAN^XGF
 D ENS^%ZISS
 W IOEDALL
 S IOTM=OLDTM,IOBM=OLDBM W @IOSTBM
 Q
 ;
WRITELN(LINE,Y) ;writes one line to the screen
 ;LINE- # of line in @MSG
 ;Y - screen line #
 D IOXY(Y,1)
 I $G(SEGLINE(LINE)) D
 .W IOINHI
 .W $E($G(@MSG@(LINE)),1,3)
 .W IOINORM
 .W $E($G(@MSG@(LINE)),4,80)
 E  D
 .W $G(@MSG@(LINE))
 Q
 ;
MSGSIZE() ;
 Q $O(@MSG@(9999999999),-1)
SCRNSIZE() ;
 Q (IOBM-IOTM)+1
TOP(INC) ;msg line at the top of the scrolling area
 I $G(INC) S POS("TOP")=POS("TOP")+INC
 Q POS("TOP")
BOT() ;msg line at the bottom of the scrolling area
 Q ($$TOP+$$SCRNSIZE)-1
LINE(TO,INC) ;msg line
 ;
 ;If TO and INC are null, $$LINE returns the current msg line
 ;If TO is valued, the current line is set to TO and that value returned
 ;Otherwise, if INC is valued the current line is incremented by that value and is returned
 D
 .I $L($G(TO)),$$X(1) S POS("LINE")=TO
 .I $G(INC),$$X(1) S POS("LINE")=POS("LINE")+INC
 Q +$G(POS("LINE"))
 ;
X(TO,INC) ;current position within the line
 ;
 ;If TO and INC are null, $$X returns the current character position
 ;If TO is valued, the current position is set to TO and that value returned
 ;Otherwise, if INC is valued the current position is incremented by that value and is returned
 ;
 D
 .I $L($G(TO)) S POS("CHAR")=TO
 .I $G(INC) S POS("CHAR")=POS("CHAR")+INC
 ;
 I $G(POS("CHAR"))>$L($G(@MSG@($$LINE))) S POS("CHAR")=$L($G(@MSG@($$LINE)))
 I $G(POS("CHAR"))<1 S POS("CHAR")=1
 Q +$G(POS("CHAR"))
Y(LINE) ;screen line of msg line = LINE
 ;LINE defaults to $$LINE
 I $D(LINE) Q (LINE-$$TOP)+1
 Q ($$LINE-$$TOP)+1
SEG(INC) ;returns the current segement #
 ;if INC is passed in, the segment # is first incremented/decremented by INC, then the new value is returned
 ;returns the new current segment
 S POS("SEG")=$G(POS("SEG"))+$G(INC)
 Q POS("SEG")
FLD(SET) ;returns the currrent field #
 ;Input:
 ;  SET:
 ;      if "+" increments the field #
 ;      if "-" decrements the field #
 ;      if SET>0 sets the field # to SET
 D:$D(SET)
 .I $E(SET)="+" S POS("FLD")=$G(POS("FLD"))+1 Q
 .I $E(SET)="-" S POS("FLD")=$G(POS("FLD"))-1 Q
 .S POS("FLD")=SET
 Q $G(POS("FLD"))
REP(SET) ;returns the current repitition #
 ;Input:
 ;  SET:
 ;      if "+" increments the repitition #
 ;      if "-" decrements the repitition #
 ;      if >0 sets the repitition # to SET
 D:$D(SET) 
 .I $E(SET)="+" S POS("REP")=$G(POS("REP"))+1 Q
 .I $E(SET)="-" S POS("REP")=POS("REP")-1 Q
 .S POS("REP")=SET
 I $D(SET) S:'($G(LASTPART($$FLD))>POS("REP")) LASTPART($$FLD)=POS("REP")
 Q +$G(POS("REP"))
COMP(SET) ;returns the current component #
 ;Input:
 ;  SET:
 ;      if "+" increments the component #
 ;      if "-" decrements the component #
 ;      if >0 sets the component # to SET
 D:$D(SET) 
 .I $E(SET)="+" S POS("COMP")=$G(POS("COMP"))+1  Q
 .I $E(SET)="-" S POS("COMP")=POS("COMP")-1 Q
 .S POS("COMP")=SET
 I $D(SET) S:'($G(LASTPART($$FLD,$$REP))>POS("COMP")) LASTPART($$FLD,$$REP)=POS("COMP")
 Q +$G(POS("COMP"))
 ;
SUB(SET) ;returns the current sub-component #
 ;Input:
 ;  SET:
 ;      if "+" increments the subcomponent #
 ;      if "-" decrements the subcomponent #
 ;      if >0 sets the sub-component # to SET
 D:$D(SET) 
 .I $E(SET)="+" S POS("SUB")=$G(POS("SUB"))+1  Q
 .I $E(SET)="-" S POS("SUB")=POS("SUB")-1 Q
 .S POS("SUB")=SET
 I $D(SET) S:'($G(LASTPART($$FLD,$$REP,$$COMP))>POS("SUB")) LASTPART($$FLD,$$REP,$$COMP)=POS("SUB")
 Q +$G(POS("SUB"))
 ;
SEGSTART(SEGMENT) ;
 Q $G(SEG(SEGMENT))
 ;
IOXY(Y,X) ; moves to screen position line=Y, col=X
 ;convert to (0,0) origin
 I $G(X),X=+X S X=X-1
 I $G(Y),Y=+Y S Y=Y-1
 ;
 D IOXY^XGF($G(Y),$G(X))
 Q
