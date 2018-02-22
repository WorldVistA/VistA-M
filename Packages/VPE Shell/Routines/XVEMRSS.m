XVEMRSS ;DJB/VRR**Rtn String Search ;2017-08-15  4:30 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Search was DSM/Cache specific. Refactored by Sam Habiel (c) 2016
 ; to be standard.
 NEW ASK,CNT,EXCLUDE,FLAGEDT,FLAGQ,QUIT,STRING
TOP ;
 D SELECT^XVEMRUS G:$O(^UTILITY($J," "))="" EX
 S (FLAGEDT,FLAGQ)=0
 D STRG G:'$D(STRING(1))!FLAGQ TOP
 D EXCLUDE
 D LIST
 G TOP
EX ;
 KILL ^UTILITY($J)
 Q
 ;
STRG ;Get Search String
 NEW CD
 KILL STRING
 S CNT("STR")=0
 W !
STRG1 W !,"Enter SEARCH STRING "_(CNT("STR")+1)_": "
 R CD:300 I "^"[CD S:CD="^" FLAGQ=1 Q
 I "??"[CD D HELP G:ASK'="S" STRG1
 S CNT("STR")=CNT("STR")+1
 S STRING(CNT("STR"))=CD
 I CNT("STR")=1,"=<>"[$E(CD),CD?1E1.2N1"/"1.2N1"/"1.2N D  Q
 . S FLAGEDT=$E(CD) ;...Find rtns by edit date: =<> Date
 G STRG1
 ;
EXCLUDE ;Get Exclude String.
 NEW CD
 KILL EXCLUDE
 S CNT("EXC")=0
 Q:CNT("STR")>1  ;..Quit if more than 1 Search String
 Q:FLAGEDT?1P  ;....Quit if doing an Edit Date type search
 W !
EXCLUDE1 W !,"Enter EXCLUDE STRING "_(CNT("EXC")+1)_": "
 R CD:300 Q:"^"[CD
 I "??"[CD D HELP1 G:ASK'="E" EXCLUDE1
 S CNT("EXC")=CNT("EXC")+1
 S EXCLUDE(CNT("EXC"))=CD
 G EXCLUDE1
 ;
LIST ;List routines
 NEW CHKE,CHKS,COL,EXC,FLAGA,I,I1,I2,I3,NUMR,NUMS,RTN,TIC,TXT
 S (FLAGA,FLAGQ,NUMR,NUMS,TIC)=0
 S COL=1
 W !
 S RTN=" "
 F I=1:1 S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""!FLAGQ  D  ;
 . I FLAGEDT?1P D FINDEDIT Q
 . W !,RTN,"  "
 . D SEARCH(RTN)
 . S NUMR=NUMR+1 S:TIC NUMS=NUMS+1 W:TIC ! S TIC=0
 W !!?1,$J(NUMR,4)
 W " Routine",$S(NUMR=1:" ",1:"s "),"searched."
 W !?1,$J(NUMS,4)
 W " Routine",$S(NUMS=1:" ",1:"s "),"contained search string(s)."
 Q
 ;
FINDEDIT ;Find rtns edited before/after/on a certain date
 NEW CHK,DATE,I,RTNDATE,TXT
 ;
 S TXT=$T(+1^@RTN)
 D  Q:$G(RTNDATE)']""
 . ;Old format: [6/1/99 8:40pm]
 . I TXT[" [" S RTNDATE=$P(TXT," [",$L(TXT," [")) Q
 . ;New format: ; 7/2/99 12:49pm
 . I TXT["; " S RTNDATE=$P(TXT,"; ",$L(TXT,"; ")) Q
 S RTNDATE=$P(RTNDATE," ",1) ;............Date rtn last edited
 S DATE=$E(STRING(1),2,99) ;..............Date being searched for
 ;
 F I=1:1:3 S RTNDATE(I)=+$P(RTNDATE,"/",I)
 F I=1:1:3 S DATE(I)=+$P(DATE,"/",I)
 ;
 ;If year is less than 40, add 100.
 I RTNDATE(3)<40 S RTNDATE(3)=100+RTNDATE(3)
 I DATE(3)<40 S DATE(3)=100+DATE(3)
 ;
 S NUMR=NUMR+1,CHK=0
 I FLAGEDT="=",RTNDATE'=DATE Q  ;.........Equals
 ; 1=Month 2=Day 3=Year
 I FLAGEDT=">" D  Q:CHK  ;................Greater Than
 . I RTNDATE(3)<DATE(3) S CHK=1 Q
 . I RTNDATE(3)=DATE(3),RTNDATE(1)<DATE(1) S CHK=1 Q
 . I RTNDATE(1)=DATE(1),RTNDATE(2)'>DATE(2) S CHK=1 Q
 I FLAGEDT="<" D  Q:CHK  ;................Less Than
 . I RTNDATE(3)>DATE(3) S CHK=1 Q
 . I RTNDATE(3)=DATE(3),RTNDATE(1)>DATE(1) S CHK=1 Q
 . I RTNDATE(1)=DATE(1),RTNDATE(2)'<DATE(2) S CHK=1 Q
 S NUMS=NUMS+1
 W:COL=1 ! W ?COL,RTN,?($X+(10-$L(RTN))) S COL=COL+30 S:COL>70 COL=1
 F I=1:1:3 W RTNDATE(I) W:I<3 "/"
 Q
 ;
HELP ;User entered '?' at STRING prompt
 ;Return: ASK="S" if user wants to Search
 ;
 W ?25,"Do you want Help, or to Search for '"_CD_"'"
 W !?25,"Select [H]elp or [S]earch: "
 R ASK:300 Q:"^"[ASK  I "Ss"[$E(ASK) S ASK="S" Q
 W !!?3,"Enter any character string. The selected routines will be searched"
 W !?3,"and any line containing the string will be displayed. You may"
 W !?3,"enter more than 1 search string.",!
 W !?3,"Whenever the display stops at a program line that contains a"
 W !?3,"string, you may enter <RETURN> to contine, '^' to quit, '?' for"
 W !?3,"Help, or 'A' for Autoprint. When Autoprint is active, the display"
 W !?3,"will not stop at each line containing a string."
 W !!?3,"If you use ..E as your editor, you can find routines that have been"
 W !?3,"edited before/after/on a certain date: Before: <1/2/95"
 W !?3,"                                       After.: >1/2/95"
 W !?3,"                                       On....: =1/2/95",!
 Q
HELP1 ;User entered '?' at EXCLUDE prompt
 ;Return: ASK="E" if user wants to Exclude
 ;
 W ?25,"Do you want Help, or to Exclude '"_EXCLUDE_"'"
 W !?25,"Select [H]elp or [E]xclude: "
 R ASK:300 Q:"^"[ASK  I "Ee"[$E(ASK) S ASK="E" Q
 W !!?3,"Enter any character string. Any lines that contain the SEARCH STRING"
 W !?3,"will be checked to see if they also contain the EXCLUDE STRING. If they"
 W !?3,"do, they may be rejected. For example: If a line of code like 'AB,AB1,YY2'"
 W !?3,"is searched for YY excluding YY2, it WON'T pass the search. If it is"
 W !?3,"searched for AB excluding AB1, it WILL pass the search."
 W !!?3,"You will not be prompted for an EXCLUDE STRING if there is more than"
 W !?3,"one SEARCH STRING.",!
 Q
INIT ;
 ; S CODE1="F I1=1:1 S TXT=$T(+I1) Q:TXT=""""!FLAGQ  F I2=1:1:CNT(""STR"") I TXT[STRING(I2) S CHKS=1 X CODE2 I CHKS W !!,RTN,""+"",I1-1,"" -->"",TXT S TIC=1 X:'FLAGA CODE4 Q"
 ;
 ; S CODE2="S CHKE=0 X CODE3 Q:'CHKE  S (CHKS,EXC)=0 F  S EXC=$O(EXCLUDE(EXC)) Q:'EXC!CHKS  F I3=1:1:$F(TXT,EXCLUDE(EXC)) I $P(TXT,EXCLUDE(EXC),I3)[STRING(I2) S CHKS=1 Q"
 ;
 ; S CODE3="S EXC=0 F  S EXC=$O(EXCLUDE(EXC)) Q:'EXC!CHKE  I TXT[EXCLUDE(EXC) S CHKE=1"
 ;
 ; S CODE4="R ASK:300 S:ASK=""a"" ASK=""A"" R:""^,A""'[ASK !!?2,""<RETURN>=Continue  ^=Quit  A=AutoPrint"",!?2,""Select: "",ASK:300 S:ASK[""^"" FLAGQ=1 S:ASK=""A"" FLAGA=1"
 Q
SEARCH(RTN) ; [Internal] Perform actual search of routines
 ; NB: Replaces INIT code and others that used ZLOAD on DSM like systems.
 ;Check each line of rtn to see if it contains STRING array.
 N CHKS S CHKS=0
 N I1,TXT F I1=1:1 S TXT=$T(+I1^@RTN) Q:TXT=""!FLAGQ  D
 . N I2 F I2=1:1:CNT("STR") I TXT[STRING(I2) D
 .. S CHKS=1
 .. D EXCL(TXT)
 .. I CHKS W !!,RTN,"+",I1-1," -->",TXT S TIC=1 D:'FLAGA ASK
 QUIT
 ;
EXCL(TXT) ; [Internal] Excludes
 ; Input: TXT - Line of Routine Code
 ;See if line that contains STRING also contains EXCLUDE.
 N CHKE S CHKE=0
 N EXC S EXC=0
 F  S EXC=$O(EXCLUDE(EXC)) Q:'EXC!CHKE  I TXT[EXCLUDE(EXC) S CHKE=1
 Q:'CHKE
 ;
 ; VEN/SMH: This looks really weird, but I am keeping it.
 ;Does any part of line surrounding EXCLUDE, contain STRING?
 S (CHKS,EXC)=0
 F  S EXC=$O(EXCLUDE(EXC)) Q:'EXC!CHKS  D
 . N I3 F I3=1:1:$F(TXT,EXCLUDE(EXC)) I $P(TXT,EXCLUDE(EXC),I3)[STRING(I2) S CHKS=1 Q
 QUIT
 ;
ASK ; [Internal] Ask to continue
 ;Output: FLAGA=AutoPrint active
 ;Output: FLAGQ=Quit
 N ASK
 R ASK:300
 S:ASK="a" ASK="A"
 R:"^,A"'[ASK !!?2,"<RETURN>=Continue  ^=Quit  A=AutoPrint",!?2,"Select: ",ASK:300
 S:ASK["^" FLAGQ=1
 S:ASK="A" FLAGA=1
 QUIT
