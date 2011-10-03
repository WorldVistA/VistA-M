SDUL40 ;ALB/MJK - Screen Malipulation Utilities (cont.) ; 12/1/91
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
FIND ; -- find text in list
 N START,BEG,SDQUIT,SDULHIT
 S DIR(0)="F^2:50",DIR("A")="Search for" S:$D(SDULFIND) DIR("B")=SDULFIND
 S DIR("?")="Enter from two to fifty characters."
 D ^DIR K DIR I "^"[Y G FINDQ
 S SDULFIND=Y,(BEG,START)=SDULBG,FINISH=SDULCNT
 F  D SEARCH(START,FINISH) D  D:SDULHIT UPD(SDULHIT,SDULFIND,"") Q:$D(SDQUIT)
 .I 'SDULHIT,BEG=1 D PAUSE^SDUL1 S SDQUIT="" Q
 .I SDULHIT,BEG=1,SDULHIT=SDULCNT D PAUSE^SDUL1 S SDQUIT="" Q
 .I 'SDULHIT!(SDULHIT=SDULCNT),BEG'=1,$$BEG S FINISH=BEG-1,(BEG,START)=1 Q
 .I 'SDULHIT!(SDULHIT=SDULCNT),BEG'=1 S SDQUIT="" Q
 .W ! S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Find Next '"_SDULFIND_"'" D ^DIR K DIR
 .I Y S START=SDULHIT+1 Q
 .S SDQUIT=""
FINDQ D FINISH^SDUL4 Q
 ;
BEG() ; -- ask if ok to start from top
 W !!,"<<< End of list >>>"
 S DIR(0)="Y",DIR("A")="Do you want to start at the beginning of the list",DIR("B")="Yes"
 D ^DIR K DIR
 Q Y
 ;
SEARCH(START,FINISH) ; -- search to end or first hit
 ; input:  START := line to start search on
 ;        FINISH := line to end search on
 ;
 N Y,X,L,CNT
 S SDULHIT="",CNT=0
 S SDULBCK="" D:SDULCC RESET^SDUL4 W !,"...searching for '"_SDULFIND_"'"
 F I=START:1:FINISH S CNT=CNT+1 W:'(CNT#100) "." I $$UPPER^SDUL1(@SDULAR@(I,0))[$$UPPER^SDUL1(SDULFIND) S SDULHIT=I Q
 I 'SDULHIT W *7,!!,"Text not found." G SEARCHQ
 I SDULCC D
 .I SDULHIT<SDULBG!(SDULHIT>SDULST) S SDULBG=SDULHIT D LST^SDUL4,PAINT^SDUL4
 .D UPD(SDULHIT,SDULFIND,"REV")
 D PGUPD^SDUL4
 I 'SDULCC S SDULBG=SDULHIT D REFRESH^SDUL
SEARCHQ Q
 ;
UPD(LINE,TEXT,ATTR) ; -- set/unset video attribute on text
 ;  input:    LINE := number of line
 ;            TEXT := chars to set attribute on
 ;            ATTR := attribute to use
 ;
 N ATTRON,ATTROFF,Y,LEN,POS
 I 'SDULCC G UPDQ
 S Y=@SDULAR@(LINE,0),LEN=$L(TEXT),POS=0,(ATTRON,ATTROFF)=""
 I ATTR="REV" S ATTRON=IORVON,ATTROFF=IORVOFF
 F  S POS=$F($$UPPER^SDUL1(Y),$$UPPER^SDUL1(TEXT),POS) Q:'POS  D INSTR^SDUL1(ATTRON_$E(Y,POS-LEN,POS-1)_ATTROFF,POS-LEN,SDUL("TM")+(LINE-SDULBG),LEN,0)
UPDQ Q
 ;
