HLOPRSR2 ;ALB/CJM - Visual Parser 12 JUN 1997 10:00 am ;08/17/2009
 ;;1.6;HEALTH LEVEL SEVEN;**138,139,146**;Oct 13, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
WRITELN(LINE,Y) ;writes one line to the screen
 D WRITELN^HLOPRSR1(.LINE,.Y)
 Q
 ;
RIGHT ;
 N CHAR,LINE,QUIT
 K VALUE
 S (QUIT,VALUE)=""
 ;
 ;header segments are a special case
 I ((SEGTYPE="MSH")!(SEGTYPE="BHS")),(+POS("CURRENT DELIMITER")=$$SEGSTART($$SEG)),$P(POS("CURRENT DELIMITER"),"^",2)=0 D  G GORIGHT
 .S POS("CURRENT DELIMITER")=$$LINE_"^4"
 .S POS("NEXT DELIMITER")=$$LINE_"^"_($F($G(@MSG@($$LINE)),FLD,5)-1)
 .S VALUE=FLD_$P($G(@MSG@($$LINE)),FLD,2)
 .S VALUE("START")=$$LINE_"^4"
 .S VALUE("END")=$$LINE_"^"_($L(VALUE)+3)
 .I $$X(4),$$FLD(2),$$REP(1),$$COMP(1),$$SUB(1)
 .S LASTPART(1)=1,LASTPART(1,1)=1,LASTPART(1,1,1)=1
 .S LASTPART(2)=1,LASTPART(2,1)=1,LASTPART(2,1,1)=1
 .;
 ;
 S POS("CURRENT DELIMITER")=POS("NEXT DELIMITER")
 I '(+POS("CURRENT DELIMITER"))!'$P(POS("CURRENT DELIMITER"),"^",2) D DOWN Q  ;at segment end so go to next segment
 ;
 I $$LINE(+POS("CURRENT DELIMITER")),$$X($P(POS("CURRENT DELIMITER"),"^",2)) ;set current position to current delimiter
 ;
 S CHAR=$$GETCHAR
 D  ;what is the next position in the segment?
 .I CHAR=FLD D  Q
 ..I $$FLD("+"),$$REP(1),$$COMP(1),$$SUB(1)
 .I CHAR=REP D  Q
 ..I $$REP("+"),$$COMP(1),$$SUB(1)
 .I CHAR=COMP D  Q
 ..I $$COMP("+"),$$SUB(1)
 .I CHAR=SUB D  Q
 ..I $$SUB("+")
 ;
 F  S CHAR=$$GETCHAR("+") D  Q:QUIT
 .I $L(CHAR),DELIM[CHAR S POS("NEXT DELIMITER")=$$LINE_"^"_$$X,QUIT=1 Q
 .I '$L(VALUE) S VALUE("START")=$$LINE_"^"_$$X,VALUE("END")=VALUE("START")
 .I CHAR="" D  Q
 ..S QUIT=1
 ..S POS("NEXT DELIMITER")=$$LINE_"^0" ;signals end of segment
 .;
 .S:$L(VALUE)<512 VALUE=VALUE_CHAR
 S VALUE("END")=$$LINE_"^"_$$X
 ;
GORIGHT ;
 ;keep the current field in the scrolling region
 I $$Y>(IOBM-1) D SCROLL($$Y-(IOBM-1))
 ;
 D DESCRIBE^HLOPRSR3
 D HILITE(+$G(VALUE("START")),$P($G(VALUE("START")),"^",2),+$G(VALUE("END")),$P($G(VALUE("END")),"^",2))
 Q
LEFT ;
 N CHAR,LINE,QUIT
 K VALUE
 S (QUIT,VALUE)=""
 ;
 S POS("NEXT DELIMITER")=POS("CURRENT DELIMITER")
 I $$LINE<2,$$X<2 D UP Q
 ;
 ;header segments are a special case
 I ((SEGTYPE="MSH")!(SEGTYPE="BHS")),$$LINE=$$SEGSTART($$SEG),$$X<$F($G(@MSG@($$LINE)),FLD,5) D  G GOLEFT
 .I $$X>4 D
 ..S POS("CURRENT DELIMITER")=$$LINE_"^4"
 ..S VALUE=FLD_$P($G(@MSG@($$LINE)),FLD,2)
 ..S VALUE("START")=$$LINE_"^4"
 ..S VALUE("END")=$$LINE_"^"_($L(VALUE)+3)
 ..I $$X(4),$$FLD(2),$$REP(1),$$COMP(1),$$SUB(1)
 ..S LASTPART(1)=1,LASTPART(1,1)=1,LASTPART(1,1,1)=1
 ..S LASTPART(2)=1,LASTPART(2,1)=1,LASTPART(2,1,1)=1
 .E  D
 ..S VALUE=$P($G(@MSG@($$LINE)),FLD)
 ..S POS("CURRENT DELIMITER")=$$LINE_"^0"
 ..S VALUE("START")=$$LINE_"^1"
 ..S VALUE("END")=$$LINE_"^3"
 ..I $$X(0),$$FLD(0),$$REP(0),$$COMP(0),$$SUB(0)
 .;
 ;
 I '$P(POS("CURRENT DELIMITER"),"^",2) D  G GOLEFT  ;at segment start so go to end of prior segment
 .I $$LINE($$SEGSTART($$SEG(-1))),$$X(1),$$FLD(0),$$COMP(0),$$SUB(0) ;set line to start of prior seg
 .K VALUE S VALUE=""
 .S SEGTYPE=$E($G(@MSG@($$LINE)),1,3)
 .Q:$$LINE<1
 .I (SEGTYPE="MSH")!(SEGTYPE="BHS") D
 ..S VALUE=FLD_$P($G(@MSG@($$LINE)),FLD,2)
 ..S VALUE("START")=$$LINE_"^4"
 ..S VALUE("END")=$$LINE_"^"_($L(VALUE)+3)
 ..I $$X($F($G(@MSG@($$LINE)),FLD,5)-1),$$FLD(3),$$REP(1),$$COMP(1),$$SUB(1) S POS("CURRENT DELIMITER")=$$X
 ..S LASTPART(1)=1,LASTPART(1,1)=1,LASTPART(1,1,1)=1
 ..S LASTPART(2)=1,LASTPART(2,1)=1,LASTPART(2,1,1)=1
 .E  D
 ..S POS("CURRENT DELIMITER")=$$LINE_"^0"
 ..S POS("NEXT DELIMITER")=$$LINE_"^0"
 ..S VALUE=SEGTYPE,VALUE("START")=$$LINE_"^1",VALUE("END")=$$LINE_"^3"
 .F  S CHAR=$$GETCHAR("+") Q:CHAR=""  D
 ..I DELIM[CHAR D  Q
 ...S POS("CURRENT DELIMITER")=$$LINE_"^"_$$X
 ...K VALUE S VALUE=""
 ...I CHAR=FLD,$$FLD("+"),$$REP(1),$$COMP(1),$$SUB(1)  Q
 ...I CHAR=REP,$$REP("+"),$$COMP(1),$$SUB(1) Q
 ...I CHAR=COMP,$$COMP("+"),$$SUB(1) Q
 ...I CHAR=SUB,$$SUB("+") Q
 ..E  D
 ...S:$L(VALUE)<512 VALUE=VALUE_CHAR
 ...I $L(VALUE)=1 S VALUE("START")=$$LINE_"^"_$$X
 ...S VALUE("END")=$$LINE_"^"_$$X
 ;
 I $$LINE(+POS("CURRENT DELIMITER")),$$X($P(POS("CURRENT DELIMITER"),"^",2)) ;set current position to current delimiter
 ;
 ;
 S CHAR=$$GETCHAR
 D  ;what is the next position in the segment?
 .I CHAR=FLD D  Q
 ..I $$FLD("-"),$$REP(LASTPART($$FLD)),$$COMP(LASTPART($$FLD,$$REP)),$$SUB(LASTPART($$FLD,$$REP,$$COMP))
 .I CHAR=REP D  Q
 ..I $$REP("-"),$$COMP(LASTPART($$FLD,$$REP)),$$SUB(LASTPART($$FLD,$$REP,$$COMP))
 .I CHAR=COMP D  Q
 ..I $$COMP("-"),$$SUB(LASTPART($$FLD,$$REP,$$COMP))
 .I CHAR=SUB D  Q
 ..I $$SUB("-")
 ;
 F  S CHAR=$$GETCHAR("-") D  Q:QUIT
 .I $L(CHAR),DELIM[CHAR S POS("CURRENT DELIMITER")=$$LINE_"^"_$$X,QUIT=1 D  Q
 .I CHAR="" D
 ..S QUIT=1
 ..I VALUE="" D UP Q
 ..S POS("CURRENT DELIMITER")=$$LINE_"^0" ;signals end of segment
 .;
 .S:$L(VALUE)<512 VALUE=CHAR_VALUE
 .I $L(VALUE)=1 S VALUE("END")=$$LINE_"^"_$$X
 .S VALUE("START")=$$LINE_"^"_$$X
 ;
GOLEFT ;
 ;keep the current field in the scrolling region
 I $$Y<(IOTM) D SCROLL($$Y-IOTM)
 ;
 D DESCRIBE^HLOPRSR3
 D HILITE(+$G(VALUE("START")),$P($G(VALUE("START")),"^",2),+$G(VALUE("END")),$P($G(VALUE("END")),"^",2))
 Q
 ;
MSGSIZE() ;
 Q $$MSGSIZE^HLOPRSR1
SCRNSIZE() ;
 Q $$SCRNSIZE^HLOPRSR1
TOP(INC) ;msg line at the top of the scrolling area
 Q $$TOP^HLOPRSR1(.INC)
LINE(TO,INC) ;msg line
 Q $$LINE^HLOPRSR1(.TO,.INC)
 ;
X(TO,INC) ;current position within the line
 ;
 Q $$X^HLOPRSR1(.TO,.INC)
Y(LINE) ;screen line of msg line = LINE
 Q $$Y^HLOPRSR1(.LINE)
SEG(INC) ;returns the current segement #
 Q $$SEG^HLOPRSR1(.INC)
FLD(SET) ;returns the currrent field #
 Q $$FLD^HLOPRSR1(.SET)
REP(SET) ;returns the current repitition #
 Q $$REP^HLOPRSR1(.SET)
COMP(SET) ;returns the current component #
 Q $$COMP^HLOPRSR1(.SET)
 ;
SUB(SET) ;returns the current sub-component #
 Q $$SUB^HLOPRSR1(.SET)
 ;
SEGSTART(SEGMENT) ;
 Q $$SEGSTART^HLOPRSR1(.SEGMENT)
 ;
IOXY(Y,X) ; moves to screen position line=Y, col=X
 D IOXY^HLOPRSR1(.Y,.X)
 Q
HILITE(LINE1,CHAR1,LINE2,CHAR2) ;does hightlighting
 ;LINE1: starting line
 ;CHAR1: starting character
 ;LINE2: ending line
 ;CHAR2: ending character
 ;
 N X
 I $G(HILITE) D UNLITE
 I LINE1>0,CHAR1>0,LINE2>0,CHAR2>0 D
 .W IORVON
 .S HILITE=LINE1_"^"_CHAR1_"^"_LINE2_"^"_CHAR2
 .D LITE
 W IORVOFF
 S X=$P(POS("CURRENT DELIMITER"),"^",2)
 ;
 ;
 ;move curson to the delimiter, and write in bold
 D IOXY($$Y($$LINE(+POS("CURRENT DELIMITER"))),$$X(X))
 ;
 ;
 I X D
 .W IOINHI
 .W $$GETCHAR
 .W IOINORM
 .D IOXY($$Y,$$X)
 W IOCUON
 Q
 ;
LITE N LINE
 F LINE=LINE1:1:LINE2 D
 .I '($$Y(LINE)>IOBM),'($$Y(LINE)<IOTM) D
 ..D IOXY($$Y(LINE),$S(LINE=LINE1:CHAR1,1:1))
 ..W $E($G(@MSG@(LINE)),$S(LINE=LINE1:CHAR1,1:1),$S(LINE=LINE2:CHAR2,1:80))
 Q
 ;
UNLITE ;
 N LINE1,CHAR1,LINE2,CHAR2
 W IORVOFF
 Q:$G(HILITE)=""
 S LINE1=$P(HILITE,"^"),CHAR1=$P(HILITE,"^",2),LINE2=$P(HILITE,"^",3),CHAR2=$P(HILITE,"^",4)
 K HILITE
 I $G(SEGLINE(LINE2)),CHAR1=1 W IOINHI
 D LITE
 I $G(SEGLINE(LINE2)),CHAR1=1 W IOINORM
 Q
 ;
DOWN ;
 N I
 K LASTPART
 S SEGTYPE=""
 I $$SEGSTART($$SEG("+1")) D
 .I $$LINE($$SEGSTART($$SEG))
 E  D
 .I $$LINE(,1)>0,$$LINE<$$MSGSIZE,$$LINE($$MSGSIZE+1)
 F I="FLD","REP","COMP","SUB" S POS(I)=0
 I '($$Y>IOBM) D
 .D IOXY($$Y,1)
 E  D
 .D SCROLL($$Y-IOBM)
 S SEGTYPE=$E($G(@MSG@($$LINE)),1,3)
 S POS("CURRENT DELIMITER")=$$LINE_"^0"
 S POS("NEXT DELIMITER")=$$LINE_"^"_$S($$SEGSTART($$SEG):4,1:0)
 D DESCRIBE^HLOPRSR3
 D HILITE($$LINE,$$X,$$LINE,($$X+2))
 Q
 ;
UP ;
 N I
 K LASTPART
 S SEGTYPE=""
 I $$SEGSTART($$SEG("-1")) D
 .I $$LINE($$SEGSTART($$SEG))
 E  D
 .I $$LINE(,-1)>0,$$LINE<$$MSGSIZE,$$LINE(0) ;set line to 0
 F I="FLD","REP","COMP","SUB" S POS(I)=0
 I '($$Y<IOTM) D
 .D IOXY($$Y,1)
 E  D
 .D SCROLL($$Y-IOTM)
 S SEGTYPE=$E($G(@MSG@($$LINE)),1,3)
 S POS("CURRENT DELIMITER")=$$LINE_"^0"
 S POS("NEXT DELIMITER")=$$LINE_"^"_$S($$SEGSTART($$SEG):4,1:0)
 D DESCRIBE^HLOPRSR3
 D HILITE($$LINE,$$X,$$LINE,($$X+2))
 Q
 ;
SCROLL(COUNT) ; Scrolls up (COUNT positive) or down (COUNT negative)
 ;
 N I
 I COUNT>0 D
 .D IOXY(IOBM,1)
 .F I=1:1:COUNT D
 ..W IOIND
 ..I $$TOP(1)
 ..W $G(@MSG@($$BOT^HLOPRSR1))
 ..D IOXY(IOBM,1)
 .I $$LINE($$BOT^HLOPRSR1)
 .S POS("CHAR")=1
 .;
 I COUNT<0 D
 .D IOXY(1,1)
 .F I=-1:-1:COUNT D
 ..W IORI
 ..W $G(@MSG@($$TOP(-1)))
 ..D IOXY(1,1)
 .S POS("CHAR")=1
 Q
GETCHAR(INC) ;returns a message character, can go forward or backward but will not cross the segment boundary.
 ;INC:
 ;  not defined - assumes the current position
 ;  "+" - the next character. May change $$X and $$LINE
 ;  "-" - the prior character. May change $$X and $$LINE
 ;
 N END,TMP
 S END=0
 S TMP("LINE")=$$LINE
 S TMP("X")=$$X
 I $E($G(INC))="+" D
 .I '($$X<80) D  ;get char from next line
 ..;** P139 START CJM
 ..I ('$$SEGSTART($$SEG+1))!(($$LINE+1)<$$SEGSTART($$SEG+1)),$$LINE(,1),$$X(1)
 ..;** P139 END
 .E  D
 ..I $$X=$$X(,1) S END=1
 E  I $E($G(INC))="-" D
 .I '($$X()>1) D  ;get char from prior line
 ..I $$SEGSTART($$SEG)<$$LINE D
 ...I $$LINE(,-1),$$X($L($G(@MSG@($$LINE))))
 ..E  D
 ...S END=1
 .E  D
 ..I $$X=$$X(,-1) S END=1
 ;** P146 START CJM
 ;
 ;This line was added in patch 139.  It is incorrect!
 ;I TMP("LINE")=$$LINE,TMP("X")=$$X S END=1
 ;
 ;This is the corrected line.
 I $L($G(INC)),TMP("LINE")=$$LINE,TMP("X")=$$X S END=1
 ;**P146 END
 ;
 Q:END ""
 Q $E($G(@MSG@($$LINE)),$$X)
 ;
LJ(STRING,LENGTH) ;
 Q $$LJ^XLFSTR(STRING,LENGTH)
