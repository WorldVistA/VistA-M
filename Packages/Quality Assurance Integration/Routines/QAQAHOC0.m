QAQAHOC0 ;HISC/DAD-AD HOC REPORTS: MAIN DRIVER ;7/12/95  14:53
 ;;1.7;QM Integration Module;**1**;07/25/1995
 ;
 ;Required / Optional Variables
 ;
 ; QAQDIC  = File NUMBER of the file to print from.
 ; QAQMRTN = Entry point to setup the QAQMENU array (Format TAG^ROUTINE)
 ; QAQORTN = Entry point to set up other FileMan EN1^DIP variables, i.e.
 ;           DCOPIES, DHD, DHIT, DIOBEG, DIOEND, DIS(), IOP, PG optional
 ; QAQMHDR = Text to be used as the header at the top of the sort/print
 ;           menu screens.  Header appears as === QAQMHDR Ad Hoc Report
 ;           Generator ===.  Set QAQMHDR = @ to suppress the header.
 ;           Maximum of 45 characters.
 ;
 ;Menu Array Format (Set up by D @QAQMRTN)
 ;
 ; QAQMENU()  = Sort ^ Menu text ^ ~Field # ^ DIR(0)
 ;  Sort      = 1 - Allow sorting,  0 - Don't allow sorting.
 ;  Menu text = Menu text as it will appear to the user (Max 30 char).
 ;  ~Field #  = Any valid EN1^DIP BY/FLDS string.  The ~ is replaced by
 ;              the sort/print prefixes entered by the user or null.
 ;              Any ;"TEXT" appended to the BY/FLDS string should be
 ;              in the last ';' piece of the string.
 ;  DIR(0)    = The DIR(0) string used when the user is prompted for a
 ;              from/to range on the sort.  DIR(0) should have a third
 ;              '^' piece (input transform) that always returns the
 ;              external form of the data or -1 in the variable Y.
 ;
 G:$S($D(QAQDIC)[0:1,QAQDIC'>0:1,$D(^DIC(QAQDIC,0))[0:1,$D(QAQMRTN)[0:1,QAQMRTN="":1,1:0) EXIT I $D(QAQORTN)#2,QAQORTN="" G EXIT
 D XIT,HOME^%ZIS,@QAQMRTN K QAQMENU(0)
 S (QAQMMAX,QAQCHKSM,QAQSORT)=0 F QA=0:0 S QA=$O(QAQMENU(QA)) Q:QA'>0  D
 . S QAQMMAX=QAQMMAX+1,QAQCHKSM(0)=0,X=QAQMENU(QA) S:X QAQSORT=QAQSORT+1
 . F QAI=1:1:$L(X) S QAQCHKSM(0)=$A(X,QAI)*QAI+QAQCHKSM(0)
 . S QAQCHKSM=QAQCHKSM(0)*QA+QAQCHKSM
 . Q
 G:(QAQMMAX'>0)!(QAQSORT'>0) EXIT
 S QAQBLURB="Enter numeric 1 to "_QAQMMAX_", <RETURN> to end, ^ to exit"
 S QAQYESNO="Please answer Y(es) or N(o).",QAQDTIME=10,(BY,FLDS)=""
 S QAQMAXOP("S")=4,QAQMAXOP("P")=7,(QAQNUMOP("S"),QAQNUMOP("P"),QAQQUIT,QAQNEXT)=0
 ;
SORT S QAQTYPE="S",QAQTYPE(0)="sort",QAQTYPE(1)="Sort",(QAQMLOAD,QAQMOUTP,QAQMSAVE)=0 K QAQCHOSN F QAQSEQ=1:1 D ENASK^QAQAHOC1 Q:QAQNEXT
 S QAQNUMOP("S")=QAQSEQ-1 G EXIT:QAQQUIT,PRNT:QAQMLOAD D:QAQMSAVE SAVE^QAQAHOC3
PRNT D:QAQMOUTP EN2^QAQAHOC4
 S QAQTYPE="P",QAQTYPE(0)="print",QAQTYPE(1)="Print",(QAQMLOAD,QAQMOUTP,QAQMSAVE)=0 K QAQCHOSN F QAQSEQ=1:1 D ENASK^QAQAHOC1 Q:QAQNEXT
 S QAQNUMOP("P")=QAQSEQ-1 G EXIT:QAQQUIT,OTHER:QAQMLOAD D:QAQMSAVE SAVE^QAQAHOC3
OTHER ; *** Execute OTHER entry point in the Ad Hoc interface routine
 D:QAQMOUTP EN2^QAQAHOC4
 K DHD,PG,DHIT,DIOEND,DIOBEG,DCOPIES,IOP,DIS
 I $D(QAQORTN)#2 S QAQQUIT=0 D @QAQORTN G:QAQQUIT EXIT
DHD ; *** Prompt user for report header
 G:$D(DHD)#2 BYFLDS
 K DIR S DIR(0)="FAO^0:60^D DHDCHK^QAQAHOC0"
 S DIR("A",1)="   Enter special report header, if desired (maximum of 60 characters).",DIR("A")="   ",DIR("?")="^D EN^QAQAHOCH(""H5"")"
 W ! D ^DIR G:$D(DIROUT)!$D(DTOUT)!$D(DUOUT) EXIT
 K DHD S:Y]"" DHD=Y
BYFLDS ; *** Process the BY and FLDS strings
 K QAQCHOSN
 F QA=1:1:QAQNUMOP("P") S QAI=$O(QAQOPTN("P",QA,"")) Q:QAI=""  D
 . S @$S(QA=1:"FLDS",1:"FLDS("_(QA-1)_")")=QAQOPTN("P",QA,QAI)
 . S QAQCHOSN(QAI)=""
 . Q
 F QA=1:1:QAQNUMOP("S") S QAI=$O(QAQOPTN("S",QA,"")) Q:QAI=""  D
 . S X=QAQOPTN("S",QA,QAI),QAQSHD=$P(X,";",$L(X,";")),Y=$L(QAQSHD)
 . I QAQSHD["""" D
 .. S X=$P(X,";",1,$L(X,";")-1)
 .. S QAQSHD=";"_$E(QAQSHD,1,Y-1)_$S($L(QAQSHD)>2:": """,1:"""")
 .. S X=X_$S($D(QAQCHOSN(QAI))[0:QAQSHD,X[":,":"",X[":":QAQSHD,1:"")
 .. Q
 . I $L(BY)+$L(X)+1>255 D  Q
 .. W !!?3,"Sort too big !!"
 .. W !?3,"Skipping sort field number ",QAI,", "
 .. W $P(QAQMENU(QAI),"^",2),"."
 .. Q
 . S BY=BY_X_","
 . Q
 K DIC S DIC=QAQDIC,L=0,BY=$$COMMA(BY)
 W ! D XIT,EN1^DIP
EXIT ; *** Exit the Ad Hoc Reoprt Generator
 K BY,DCOPIES,DHD,DHIT,DIC,DIOBEG,DIOEND,DIS,FLDS,FR,IOP,L,PG,TO,QAQDIC,QAQFOUND,QAQMHDR,QAQMMAX,QAQMRTN,QAQORTN
XIT K %,%DT,%ZIS,D0,D1,DA,DIK,DIR,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,POP,QA,QAI,QAQ,QAQAGIN,QAQBEGIN,QAQBLURB,QAQCHKSM,QAQCHOSN,QAQD0,QAQD1,QAQDIR,QAQDTIME,QAQEND,QAQEXIT,QAQFIELD,QAQFLDNO,QAQLIST,QAQLST,QAQMACRO,QAQMAXOP,QAQMENU
 K QAQMLOAD,QAQMOUTP,QAQMSAVE,QAQNEXT,QAQNONE,QAQNUMOP,QAQOK,QAQOPTN,QAQORDER,QAQPREFX,QAQQUIT,QAQREPLC,QAQSELOP,QAQSEQ,QAQSHD,QAQSORT,QAQSUFFX,QAQTAB,QAQTEMP,QAQTYPE,QAQUNDL,QAQYESNO,X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 Q
COMMA(X) ; *** Remove extra commas from X
 F QA=$L(X):-1 Q:$E(X,QA)'=","
 Q $E(X,1,QA)
DHDCHK ; *** Check DHD for MUMPS code
 Q:X'?1"W ".E  Q:$G(DUZ(0))["@"  N QA
 F QA=1:2 Q:$P(X,"""",QA,999)=""  I $P($E(X,3,999),"""",QA)[" " K X Q
 Q
