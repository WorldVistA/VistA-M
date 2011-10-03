SPNAHOC0 ;HISC/DAD-AD HOC REPORTS: MAIN REPORT DRIVER ;9/11/96  14:58
 ;;2.0;Spinal Cord Dysfunction;**11,14,19**;01/02/1997
 ;
 ;Required / Optional Variables
 ;
 ; SPNDIC  = File NUMBER of the file to print from.
 ; SPNMRTN = Entry point to setup the SPNMENU array (Format TAG^ROUTINE)
 ; SPNORTN = Entry point to set up other FileMan EN1^DIP variables (opt)
 ; SPNMHDR = Text to be used as the sort/print menu screen header.
 ;           Header appears as === SPNMHDR Ad Hoc Report Generator ===
 ;           Set SPNMHDR = @ to suppress the header. (Maximum 45 chars)
 ;
 ;Menu Array Format (Set up by D @SPNMRTN)
 ;
 ; SPNMENU()  = Sort ^ Menu text ^ ~Field # ^ DIR(0)
 ;  Sort      = Allow sorting: 1 - Yes, 0 - No.
 ;  Menu text = Menu text as it will appear to the user (Max 30 char).
 ;  ~Field #  = Any valid EN1^DIP BY/FLDS string.  The ~ is replaced by
 ;              the sort/print prefixes entered by the user or null.
 ;              Any ;"TEXT" appended to the BY/FLDS string should be
 ;              in the last ';' piece.
 ;  DIR(0)    = The DIR(0) string used when the user is prompted for a
 ;              from/to range on the sort.  DIR(0) should have a third
 ;              '^' piece (input transform) that always returns the
 ;              external form of the data or -1 in the variable Y.
 ;  DIR("S")  = A DIR("S") screen.  This is the second '|' piece of
 ;              the line.
 ;
 G:$$GET1^DID(+$G(SPNDIC),"","","NAME")="" EXIT
 G:$S($G(SPNMRTN)="":1,$D(SPNORTN)#2:SPNORTN="",1:0) EXIT
 D SETUP^SPNAHOC5 G:(SPNMMAX'>0)!(SPNSORT'>0) EXIT
 ;
 F SPNTYPE="S","P" D  G:SPNQUIT EXIT
 . I SPNTYPE="S" S SPNTYPE(0)="sort",SPNTYPE(1)="Sort"
 . I SPNTYPE="P" S SPNTYPE(0)="print",SPNTYPE(1)="Print"
 . S (SPNMLOAD,SPNMOUTP,SPNMSAVE)=0 K SPNCHOSN
 . F SPNSEQ=1:1 D ENASK^SPNAHOC1 Q:SPNNEXT
 . S SPNNUMOP(SPNTYPE)=SPNSEQ-1 Q:SPNQUIT
 . I 'SPNMLOAD,SPNMSAVE D SAVE^SPNAHOC3
 . I SPNMOUTP D EN2^SPNAHOC4
 . Q
OTHER ; *** Execute OTHER entry point in the Ad Hoc interface routine
 K DCOPIES,DHD,DHIT,DIASKHD,DIOBEG,DIOEND,DIS,DISTOP,DQTIME,IOP,PG
 I $D(SPNORTN)#2 S SPNQUIT=0 D @SPNORTN G:SPNQUIT EXIT
DHD ; *** Prompt for report header
 I $D(DIASKHD)=0,$E($G(DHD),1,2)'="W " D  G:SPNQUIT EXIT
 . K DIR S DIR(0)="FAO^0:60^D DHDCHK^SPNAHOC0"
 . S DIR("A",1)="   Enter special report header, if desired (maximum of 60 characters)."
 . S DIR("A")="Header: ",DIR("?")="^D EN^SPNAHOCH(""H5"")"
 . S X=$P($$DHD^SPNAHOC4($G(SPNMACRO("P"))),U) S:X="" X=$G(DHD)
 . I X]"" S DIR("B")=X
 . W ! D ^DIR K DHD S:Y]"" DHD=Y
 . I $D(DIROUT)!$D(DTOUT)!$D(DUOUT) S SPNQUIT=1 Q
 . I $G(DHD)]"" D SAVDHD^SPNAHOC5($G(SPNMACRO("P")),DHD)
 . Q
DIPCRIT ; *** Sort criteria in report header
 F  D  Q:%
 . W !!?3,"Include the sort criteria in the header"
 . S %=$P($$DIPCRIT^SPNAHOC4($G(SPNMACRO("S"))),U)
 . I '% S %=$S($D(DIPCRIT):1,1:2)
 . D YN^DICN I '% D EN^SPNAHOCH("H11")
 . Q
 I %=-1 S SPNQUIT=1 G EXIT
 K DIPCRIT I %=1 S DIPCRIT=1
 D SAVDIPCR^SPNAHOC5($G(SPNMACRO("S")),$S(%=1:1,1:0))
BYFLDS ; *** Process BY & FLDS strings
 K SPNCHOSN
 F SP=1:1:SPNNUMOP("P") S SPI=$O(SPNOPTN("P",SP,"")) Q:SPI=""  D
 . S @$S(SP=1:"FLDS",1:"FLDS("_(SP-1)_")")=SPNOPTN("P",SP,SPI)
 . S SPNCHOSN(SPI)=""
 . Q
 F SP=1:1:SPNNUMOP("S") S SPI=$O(SPNOPTN("S",SP,"")) Q:SPI=""  D
 . S X=SPNOPTN("S",SP,SPI),SPNSHD=$P(X,";",$L(X,";")),Y=$L(SPNSHD)
 . I SPNSHD["""" D
 .. S X=$P(X,";",1,$L(X,";")-1)
 .. S SPNSHD=";"_$E(SPNSHD,1,Y-1)_$S($L(SPNSHD)>2:": """,1:"""")
 .. S X=X_$S($D(SPNCHOSN(SPI))[0:SPNSHD,X[":,":"",X[":":SPNSHD,1:"")
 .. Q
 . I $L(BY)+$L(X)+1>255 D  Q
 .. W !!?3,"Sort too big !!"
 .. W !?3,"Skipping sort field number ",SPI,", "
 .. W $P(SPNMENU(SPI),U,2),"."
 .. Q
 . S BY=BY_X_","
 . Q
 ;1 Self Report of Function
 ;2 FIM
 ;3 ASIA
 ;4 CHART
 ;5 FAM
 ;6 DIENER
 ;7 DUSOI
 ;8 Multiple Sclerosis
 S:'$D(SPNARPT) SPNARPT=10 I SPNARPT'=10 D 
 .S SP=SP+1 S BY=BY_.02_","
 .S X=X_SPNARPT
 .S FR(SP)=SPNARPT,TO(SP)=SPNARPT
 F SP=$L(BY):-1 Q:$E(X,SP)'=","  S BY=$E(BY,1,SP)
 K DIC S DIC=SPNDIC S:$D(L)[0 L=0
 W !,"Do not queue this report if you used up-front or user selectable filters." W ! D XIT,EN1^DIP
EXIT ; *** Exit the Ad Hoc Reoprt Generator
 K SPNARPT,SPNDIC,DCC,DIP,I,J,TO,FR,BY,X,Y,J,I,DIC,SP,SPI
 K BY,DCOPIES,DHD,DHIT,DIASKHD,DIC,DIOBEG,DIOEND,DIPCRIT,DIS,DISPAR
 K DISTOP,DISUPNO,DQTIME,FLDS,FR,IOP,L,PG,TO
 K SPNDIC,SPNMHDR,SPNMMAX,SPNMRTN,SPNORTN
XIT K %,%DT,%ZIS,D0,D1,DA,DIK,DIR,DIROUT,DIRUT,DLAYGO,DR,DTOUT,DUOUT,POP
 K SP,SPI,SPN,SPNAGIN,SPNBEGIN,SPNBLURB,SPNCHKSM,SPNCHOSN,SPND0,SPND1
 K SPNDIR,SPNDTIME,SPNEND,SPNEXIT,SPNFIELD,SPNFLDNO,SPNLIST,SPNLST
 K SPNMACRO,SPNMAXOP,SPNMENU,SPNMLOAD,SPNMOUTP,SPNMSAVE,SPNNEXT,SPNNONE
 K SPNNUMOP,SPNOK,SPNOPTN,SPNORDER,SPNPREFX,SPNQUIT,SPNREPLC,SPNSELOP
 K SPNSEQ,SPNSHD,SPNSORT,SPNSUFFX,SPNTAB,SPNTEMP,SPNTYP,SPNTYPE,SPNUNDL
 K SPNYESNO,X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 Q
DHDCHK ; *** Check DHD for MUMPS code
 I $S(X'?1"W ".E:1,$G(DUZ(0))["@":1,1:0) Q
 N SP
 F SP=1:2 Q:$S($D(X)[0:1,$P(X,"""",SP,$L(X,""""))="":1,1:0)  D
 . I $P($E(X,3,$L(X)),"""",SP)[" " K X
 . Q
 Q
