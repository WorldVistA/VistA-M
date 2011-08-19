BPSOSU4 ;BHAM ISC/FCS/DRS/FLS - copied for ECME ;03/07/08  10:38
 ;;1.0;E CLAIMS MGMT ENGINE;**1,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;----------------------------------------------------------------------
 ;Standard List PROMPT:
 ;
 ;Parameters:
 ;   TYPE     - S or M (single or multiple selection)
 ;   LROOT    - List global root (eg: "^LIST($J,")
 ;   AROOT    - Answer global root (eg: "^LISTANS($J,")
 ;   STITLE   - Screen Title
 ;   .PROMPT  - List PROMPT Array
 ;   OPTIONAL - 1 or 0 (optional or required)
 ;   PGLEN    - Page length
 ;   TIMEOUT  - Number of seconds
 ;
 ;Returns:
 ;   <null>   - Unable to process list
 ;   <Ans>    - For TYPE="S", item selected
 ;   <^>      - Up-arrow entered
 ;   <^^>     - Two up-arrows entered
 ;   <-1>     - Timeout occurred
 ;
 ;----------------------------------------------------------------------
LIST(TYPE,LROOT,AROOT,STITLE,PROMPT,OPTIONAL,PGLEN,TIMEOUT) ;EP
 ;
 ;Manage local variables
 N CPAGE,NPAGES,START,END,ANS,NLINES,CHEAD1,CHEAD2,I,CMD
 ;
 Q:$G(TYPE)="" ""
 Q:$G(LROOT)="" ""
 Q:$G(AROOT)="" ""
 ;
 S STITLE=$G(STITLE)
 S OPTIONAL=+$G(OPTIONAL)
 S:$G(PGLEN)="" PGLEN=10
 S:$G(TIMEOUT)="" TIMEOUT=$G(DTIME)
 ;
 D INIT
LP1 D DPAGE
 S ANS=$$PROMPT()
 I ANS="?" D DHELP G LP1
 Q:(TYPE="M")&('OPTIONAL)&(ANS="^")&($D(@($E(AROOT,1,$L(AROOT)-1)_")"))'=0) ANS
 Q:OPTIONAL&(ANS="^") ANS
 Q:ANS="^^" ANS
 Q:ANS="TIMEOUT" -1
 I ANS="" D NEXTPG G LP1
 I $E(ANS,1)="P" D JUMPPG G LP1
 ;
 I TYPE="S"&(+ANS<1!(+ANS>END)) G LP1
 I TYPE="S"&(+ANS>0&(+ANS'>END)) S @(AROOT_(+ANS)_")")="" Q ANS
 I TYPE="M" F I=1:1:$L(ANS,",") D
 .S CMD=$P(ANS,",",I)
 .I CMD?1N.N D MARK(CMD) Q
 .I CMD?1"-".N D UNMARK($P(CMD,"-",2)) Q
 .I CMD?1N.N1"-"1N.N D RMARK(CMD) Q
 .I CMD?1"-"1N.N1"-"1N.N D RUNMARK(CMD) Q
 G LP1
 ;----------------------------------------------------------------------
HEADER N LINE
 W @IOF,!
 D:STITLE'="" WCENTER^BPSOSU9(STITLE,IOM)
 D:STITLE'="" WCENTER^BPSOSU9($TR($J("",$L(STITLE))," ","-"),IOM)
 ;
 ;DISPLAY PROMPT LINEs
 S LINE=0
 F  D  Q:LINE=""
 .S LINE=$O(PROMPT(LINE))
 .Q:LINE=""
 .W:LINE=1 !!
 .W PROMPT(LINE),!
 ;
 W:$G(CHEAD1)'="" !,?9,CHEAD1,!
 W:$G(CHEAD2)'="" ?9,CHEAD2
 Q
 ;----------------------------------------------------------------------
INIT N CNSPACES,CNAMES,CDEF,INDEX,COLUMNS
 S NLINES=+$G(@(LROOT_"0)")) I 'NLINES D  Q
 . D IMPOSS^BPSOSUE("P","TI","0 lines indicated in "_LROOT,,"INIT",$T(+0))
 S NPAGES=((NLINES-1)\PGLEN)+1
 S CPAGE=1
 S COLUMNS=$G(@(LROOT_"""Column HEADERs"""_")"))
 D:COLUMNS'=""
 .S (CHEAD1,CHEAD2)=""
 .S CNSPACES=$P(COLUMNS,"|",1)
 .S CNAMES=$P(COLUMNS,"|",2)
 .F INDEX=1:1:$L(CNAMES,",") D
 ..S CDEF=$P(CNAMES,",",INDEX)
 ..S CHEAD1=CHEAD1_$S(INDEX=1:"",1:$J("",CNSPACES))_$$LJBF^BPSOSU9($P(CDEF,":",1),$P(CDEF,":",2))
 ..S CHEAD2=CHEAD2_$S(INDEX=1:"",1:$J("",CNSPACES))_$TR($J("",$P(CDEF,":",2))," ","-")
 Q
 ;----------------------------------------------------------------------
MARK(X) ;
 Q:X<1!(X>NLINES)
 S @(AROOT_X_")")=""
 Q
 ;----------------------------------------------------------------------
RMARK(X) ;
 N START,END,INDEX
 S START=$P(X,"-",1)
 S END=$P(X,"-",2)
 F INDEX=START:1:END D MARK(INDEX)
 Q
 ;----------------------------------------------------------------------
UNMARK(X) ;
 Q:X<1!(X>NLINES)
 K @(AROOT_X_")")
 Q
 ;----------------------------------------------------------------------
RUNMARK(X) ;
 N START,END,INDEX
 S START=$P(X,"-",2)
 S END=$P(X,"-",3)
 F INDEX=START:1:END D UNMARK(INDEX)
 Q
 ;----------------------------------------------------------------------
DPAGE N LNUM
 D HEADER
 W !
 S START=((CPAGE-1)*PGLEN)+1
 S END=START+PGLEN-1
 S:END>NLINES END=NLINES
 F LNUM=START:1:END D
 .W $S($D(@(AROOT_LNUM_")")):"*",1:" ")
 .W $J(LNUM,5)," - "
 .W $G(@(LROOT_LNUM_","_"""E"""_")")),!
 Q
 ;----------------------------------------------------------------------
PROMPT() ;
 W:TYPE="S" !,"[Page "_CPAGE_" of "_NPAGES_"]  Commands: #, P#, <Enter>, ^, ^^ or ?",!
 W:TYPE="M" !,"[Page "_CPAGE_" of "_NPAGES_"]  Commands: #, -#, #-#, -#-#, P#, <Enter>, ^, ^^ or ?",!
 W "Select Item #: "
 R ANS:TIMEOUT
 I '$T S ANS="TIMEOUT"
 Q ANS
 ;----------------------------------------------------------------------
NEXTPG S CPAGE=CPAGE+1
 S:CPAGE>NPAGES CPAGE=NPAGES
 Q
 ;----------------------------------------------------------------------
JUMPPG N NUM
 Q:$E(ANS,1)'="P"
 S NUM=+$P(ANS,"P",2)
 Q:NUM<1!(NUM>NPAGES)
 S CPAGE=NUM
 Q
 ;----------------------------------------------------------------------
DHELP ;
 N X
 W !!,"Enter one of the following commands:",!!
 W ?10,"#",?20,"- Selects entry number # from the list",!
 W:TYPE="M" ?10,"-#",?20,"- Deselects entry number # from the list",!
 W:TYPE="M" ?10,"#-#",?20,"- Selects the range of entries # thru #",!
 W:TYPE="M" ?10,"-#-#",?20,"- Deselects the range of entries # thru #",!
 W:TYPE="M"!(TYPE="S"&(OPTIONAL)) ?10,"^",?20,"- Exit the list",!
 W ?10,"P#",?20,"- Jumps to page number #",!
 W ?10,"<Enter>",?20,"- DISPLAYs next page",!
 W ?10,"^^",?20,"- Aborts and returns to menu",!
 W ?10,"?",?20,"- DISPLAYs this help text",!!
 D PRESSANY^BPSOSU5(0,TIMEOUT)
 Q
