DVBAUTL4 ;ALB/JLU;UTILITY ROUTINE;9/9/94
 ;;2.7;AMIE;**28**;Apr 10, 1995
 ;
WR(TEXT) ;
 ;this is the main entry point for the AMIE writer
 ;the following is a desciption of how to set up the text string to use
 ;this call.
 ;The first uparrow piece contians the description of what to execute
 ;on this line.  The second peice contians the actual line of text.
 ;The descriptions are defined below
 ;1st = contains a 1 or zero 1 for beep zero no beep
 ;2nd = contains the number of spaces before and/or after the text 1:1
 ;3rd = contains the number of tabs before and/or after the text 1:2
 ;4th = contains the number of lines before and/or after the text 1:4
 ;5th = contains the number of form feeds before and/or after the 
 ;      text 1:3
 ;TEXT  = contains the array that holds the text to be displayed
 ;        the array is to look like ARRAY(X,0)  local or global
 ;        The X must start at one and be in consecutive order.
 ;The data in each array element will look like. "0,1:1,1:2,1:4,1:3^text"
 ;
 F LP=1:1 S TEXTM=$G(@TEXT@(LP,0)) Q:TEXTM=""  DO
 .D SETTEXT
 .D SETVAR
 .I TEXT2="",SPACE="",TAB="",LINE="",FORM="",BEEP="" Q
 .I $G(IO)'="" U IO
 .I TEXT2="" D SHORT
 .I TEXT2]"" D BODY
 .Q
 D EXIT
 Q
 ;
EXIT K TEXTM,TEXT1,TEXT2,SPACE,TAB,BEEP,LINE,FORM,LP
 Q
 ;
SHORT ;no text available may want to just use curser control
 I FORM]"" D FORM(FORM,"B")
 I LINE]"" D LINE(LINE,"B")
 I TAB]"" D TAB(TAB,"B")
 I SPACE]"" D SPACE(SPACE,"B")
 I BEEP]"",BEEP>0 D BEEP
 Q
 ;
BODY ;text is available will look at all
 I BEEP]"",BEEP>0 D BEEP
 I FORM]"" D FORM(FORM,"B")
 I LINE]"" D LINE(LINE,"B")
 I TAB]"" D TAB(TAB,"B")
 I SPACE]"" D SPACE(SPACE,"B")
 D TEXT(TEXT2)
 I SPACE]"" D SPACE(SPACE,"A")
 I TAB]"" D TAB(TAB,"A")
 I LINE]"" D LINE(LINE,"A")
 I FORM]"" D FORM(FORM,"A")
 Q
 ;
FORM(A,B) ;issues the form feeds
 ;
 N VAR,LP
 S VAR=$$SET(A,B)
 Q:VAR=""
 F LP=1:1:VAR W @$S('$D(IOF):"#",IOF="":"#",1:IOF)
 Q
 ;
LINE(A,B) ;issues the line feeds
 ;
 N VAR,LP
 S VAR=$$SET(A,B)
 Q:VAR=""
 F LP=1:1:VAR W !
 Q
 ;
TAB(A,B) ;issues the tabs
 ;
 N VAR,LP
 S VAR=$$SET(A,B)
 Q:VAR=""!(VAR=0)
 S DX=0,DY=$S(IOST["C-":$S($Y>IOSL:IOSL,1:$Y),1:0)
 X ^%ZOSF("XY")
 K DX,DY
 W ?VAR
 Q
 ;
SPACE(A,B) ;issues the spaces
 ;
 N VAR,LP
 S VAR=$$SET(A,B)
 Q:VAR=""
 F LP=1:1:VAR W " "
 Q
 ;
TEXT(A) ;writes the text
 ;
 W A
 Q
 ;
SET(A,B) ;general set statement
 ;
 Q $S(B="B":+A,1:$P(A,":",2))
 ;
BEEP ;does a beep
 W *7
 Q
 ;
SETTEXT ;sets up the two parts of each string
 S TEXT1=$P(TEXTM,"^",1)
 S TEXT2=$F(TEXTM,"^")
 S TEXT2=$E(TEXTM,TEXT2,999)
 Q
 ;
SETVAR ;sets up the necessary variables for each attribute
 S BEEP=$P(TEXT1,",",1)
 S SPACE=$P(TEXT1,",",2)
 S TAB=$P(TEXT1,",",3)
 S LINE=$P(TEXT1,",",4)
 S FORM=$P(TEXT1,",",5)
 Q
 ;
CLEAR ;clears the screen
 S VAR(1,0)="0,0,0,3,1^"
 D WR^DVBAUTL4("VAR")
 K VAR
 Q
