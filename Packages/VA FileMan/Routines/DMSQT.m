DMSQT ;SFISC/EZ-TROUBLE SHOOTING ;11/13/97  12:25
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
 ; DMQ - status flag for flow of control
 ; DMTDATE, DMEDATE - dates when Tables and Errors last updates
 ; DMLTBL - last table
 ; DMLFILE, DMNFILE - last file being processed, next one to be done
 ; DMLCOL, DMCNODE - last column processed, that column's node
 ; DMLCTE, DMLCTBL - last column's table element and table
 ; DMLCFILE, DMLCFLD - the last column's file and field reference
 ; DMNCFLD - what would be the next column's field reference
 ; (using ^DD to see what field is coming up next for processing)
 ; DMNCFILE - what would be the next column's file reference
 ; DMPARENT - parent to a subfile, may itself be a subfile
 ; DMTOPFLD - the top (upper) level field number for a subfile
 ; DMNXTFLD - the next field in the upper file to be processed
 ; DMNEXTF - the next file to be processed, coming up a subfile path
 ; DMNEXTSF - the next subfile to be processed, up from a subfile path
 ; DMNAME - the name of a file or subfile
 ; DMLFK, DMLFKTE - last foreign key, and it's last table element
 ; DMFKTBL - foreign key table, pointer from table element record
 ; DMPKTE - primary key table element record
 ; DMKEYS, DMC - keys (primary keys), and a counter
 ; DMFKFILE - foreign key file, the table element pointer
 ; DMASTER - the master table for this index table
 ; DMLO, DMLOF - where SQLI left off when building index tables
 ; So DMLO would be the last regular table where SQLI left off
 ; and DMLOF would be that table's file number.
EN ; main driver logic
 ; follows flow of ALLF^DMSQF, checking that each step completed
 I $$WAIT^DMSQT1 D  Q
 . W !?5,"Try again later.  An SQLI projection is running right"
 . W !?5,"now.  It might take a few hours to finish, but then you"
 . W !?5,"can try again and get a final status report."
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="DQ^DMSQT",ZTDESC="SQLI DIAGNOSTICS REPORT"
 . D ^%ZTLOAD D HOME^%ZIS K IO("Q")
DQ U IO D INIT D
 . D DATE
 . D SCHEMA D PAGE Q:$D(DIRUT)
 . D A D PAGE Q:$D(DIRUT)
 . D B D PAGE Q:$D(DIRUT)
 . D C D PAGE Q:$D(DIRUT)
 . D D D PAGE Q:$D(DIRUT)
 D @$S($D(DIRUT):"EXIT",DMQ=1:"DONE",DMQ=2:"ERROR",1:"EXIT")
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
INIT ; initialize variables
 S DMQ="" D DT^DICRW
 S DMTDATE=$P($G(^DMSQ("T",1,0)),U,8)
 S DMEDATE=$O(^DMSQ("EX","D",0))
 S DMLTBL=$O(^DMSQ("T",999999999999999999999999),-1)
 S DMLCOL=$O(^DMSQ("C",999999999999999999999999),-1)
 S DMLFK=$O(^DMSQ("F",999999999999999999999999),-1)
 Q
PAGE K DIRUT I $Y+4>IOSL S DIR(0)="E" D:IOST["C-" ^DIR W @IOF
 Q
DATE ; check when projection run, compare with today
 S Y=DT D DD^%DT W !?10,"          TODAY'S DATE: ",Y,!
 I 'DMTDATE D
 . W !?5,"No date associated with first SQLI Table record."
 I 'DMEDATE D
 . W !?5,"No dates found in the SQLI Error Log."
 I DMTDATE'=DMEDATE D
 . W !?5,"Different dates on Table and Error Log files."
 S Y=DMTDATE D DD^%DT W !?10,"LAST SQLI TABLE UPDATE: ",Y
 S Y=DMEDATE D DD^%DT W !?10,"LAST SQLI ERROR UPDATE: ",Y,!
 ;I DMTDATE,DMEDATE,DT'=DMTDATE,DT'=DMEDATE D
 I (DMTDATE!DMEDATE)&(DT'=DMTDATE!(DT'=DMEDATE)) D
 . W !?5,"SQLI was run in the past.  DDs may have changed since then.",!
 Q
SCHEMA ; check if schema node set
 I '$O(^DMSQ("S",0)) S DMQ=2 D  Q
 . W !?5,"No SQLI Schema records.  Has the SQLI projection been run?"
 Q
A ; were all regular tables built?
 I 'DMLTBL S DMQ=2 D  Q
 . W !!?5,"No records in the SQLI Table file."
 I $P(^DMSQ("T",DMLTBL,0),U,4) D  Q
 . W !?5,"All regular tables appear to have been built."
 S DMLFILE=$P(^DMSQ("T",DMLTBL,0),U,7) I 'DMLFILE S DMQ=2 Q
 ;. W !!?5,"Not all files appear to have been built as tables."
 W !?5,"The last regular file to be processed was ",DMLFILE,"."
 S DMNFILE=+$O(^DIC(DMLFILE)) I DMNFILE S DMQ=2 D  Q
 . W !?5,"The next one, file ",DMNFILE," may be the problem."
 . D BADFILE(DMNFILE)
 S DMNFILE=+$O(^DD(DMLFILE)) I DMNFILE S DMQ=2 D  Q
 . I $D(^DD(DMNFILE,0,"UP")) D
 .. W !?5,"The next one, subfile ",DMNFILE," may be the problem."
 .. D BADFILE(DMNFILE)
 Q
B ; were all columns built?
 I 'DMLCOL S DMQ=2 D  Q
 . W !!?5,"No records in the SQLI Column file."
 S DMLCTE=$P(^DMSQ("C",DMLCOL,0),U,1)
 S DMLCTBL=$P($G(^DMSQ("E",DMLCTE,0)),U,3)
 I DMLCTBL=DMLTBL D  Q
 . W !!?5,"Columns have been built for the last table processed."
 S DMQ=2 D
 . W !!?5,"It looks like not all columns were processed."
 S DMCNODE=^DMSQ("C",DMLCOL,0)
 S DMLCFILE=$P(DMCNODE,U,5),DMLCFLD=$P(DMCNODE,U,6)
 I DMLCFILE,DMLCFLD D
 . W !?5,"The last file processed was ",DMLCFILE,"."
 . W !?5,"The last field processed was ",DMLCFLD,"."
 . S DMNCFLD=$O(^DD(DMLCFILE,DMLCFLD)) I +DMNCFLD D  Q
 .. W !!?5,"The next field to be processed looks like ",DMNCFLD,"."
 .. D BADFILE(DMLCFILE)
 . I $D(^DIC(DMLCFILE)) S DMNCFILE=$O(^DIC(DMLCFILE)) I +DMNCFILE D  Q
 .. W !?5,"Having finished with all fields of ",DMLCFILE,", SQLI was probably"
 .. W !?5,"trying to process ",DMNCFILE,", the next file."
 .. D BADFILE(DMNCFILE)
 . S DMPARENT=$G(^DD(DMLCFILE,0,"UP")) I DMPARENT D
 .. W !?5,"The last one (",DMLCFILE,") is a subfile of ",DMPARENT,"."
 .. S DMTOPFLD=$O(^DD(DMPARENT,"SB",DMLCFILE,0))
 .. W !?5,"It is field ",DMTOPFLD," of file ",DMPARENT,"."
 .. S DMNXTFLD=$O(^DD(DMPARENT,DMTOPFLD)) I +DMNXTFLD D
 ... W !?5,"The next field to be processed looks like ",DMNXTFLD,"."
 ... D BADFILE(DMPARENT)
 .. I '+DMNXTFLD D
 ... W !?5,"That looks like the last field in ",DMPARENT,"."
 ... I $D(^DIC(DMPARENT)) D  Q
 .... S DMNEXTF=$O(^DIC(DMPARENT)) I +DMNEXTF D
 ..... W !?5,"The next file to be processed looks like ",DMNEXTF,"."
 ..... D BADFILE(DMNEXTF)
 ... S DMNEXTSF=$G(^DD(DMPARENT,0,"UP")) I DMNEXTSF D  Q
 .... W !?5,"The next subfile to be processed looks like ",DMNEXTSF,"."
 .... D BADFILE(DMNEXTSF)
 Q
BADFILE(NUM) ;
 S DMNAME=$P($G(^DIC(NUM,0)),U,1)
 I 'DMNAME S DMNAME=$O(^DD(NUM,0,"NM",0))
 D PAGE Q:$D(DIRUT)
 W !!?5,"SUGGESTION: Investigate this file/subfile as the potential"
 W !?5,"source of the problem.  That's:  ",NUM,"  ",DMNAME,!
 Q
C ; were all foreign keys built?
 I 'DMLFK S DMQ=2 D  Q
 . W !!?5,"No foreign key records have been built."
 S DMLFKTE=$O(^DMSQ("E","E","F",999999999999),-1)
 I 'DMLFKTE S DMQ=2 D  Q
 . W !?5,"No table elements have been built for foreign keys."
 S DMFKTBL=$P(^DMSQ("E",DMLFKTE,0),U,3)
 S DMPKTE=$O(^DMSQ("E","F",DMFKTBL,"P",0))
 S (DMKEYS,DMC)=0
 F  S DMKEYS=$O(^DMSQ("P","B",DMPKTE,DMKEYS)) Q:DMKEYS=""  S DMC=DMC+1
 S DMFKFILE=$P(^DMSQ("T",DMFKTBL,0),U,7)
 I DMC>1 D  Q
 . W !!?5,"All regular foreign keys have been built (FKs)."
 . W !?5,"Parent foreign keys (PFKs) have also been built, the"
 . W !?5,"last one being for file/subfile ",DMFKFILE,"."
 I DMC'>1 S DMQ=2 D  Q
 . W !!?5,"Only regular foreign keys (FKs) have been processed."
 . W !?5,"The last was for file/subfile ",DMFKFILE,"."
 Q
D ; were all index tables built?
 I 'DMLTBL S DMQ=2 D  Q
 . W !!?5,"No records for SQLI index tables."
 S DMASTER=$P(^DMSQ("T",DMLTBL,0),U,4) I 'DMASTER S DMQ=2 D  Q
 . W !!?5,"Index tables don't appear to have been built."
 S DMLO=$O(^DMSQ("T",DMASTER)) I 'DMLO S DMQ=2 Q
 S DMLOF=$P(^DMSQ("T",DMLO,0),U,7) I DMLOF D
 . ; find out if any indexes remain to be processed
 . S DMLOOP=DMASTER F  S DMLOOP=$O(^DMSQ("T",DMLOOP)) Q:DMLOOP'>0  D
 .. Q:$P(^DMSQ("T",DMLOOP,0),U,4)
 .. S:$$IDX^DMSQT1(DMLOOP) DMQ=2
 I DMQ=2 W !!?5,"Index processing stopped at file ",DMLOF,"." Q
 S DMQ=1
 W !!?5,"All index tables appear to have been built.  The last was for"
 W !?5,"file/subfile ",$P(^DMSQ("T",DMASTER,0),U,7),"."
 Q
DONE ; come here if all checks succeed
 W !!?5,"No problems detected in SQLI data structures themselves.",!
 Q
ERROR ; come here on error
 W !!?5,"Problems found in SQLI data structures."
 W !?5,"---------------------------------------"
 W !?5,"See SQLI Site Manual, trouble-shooting section, for ideas about"
 W !?5,"how to investigate the problem.  For example, RUNONE^DMSQ may be"
 W !?5,"used to explore a potential problem file."
 Q
EXIT K DMQ,DMTDATE,DMEDATE,DMLTBL,DMLFILE,DMNFILE
 K DMLCOL,DMLCTE,DMLCTBL,DMCNODE,DMLCFILE,DMLCFLD,DMNCFLD
 K DMNCFILE,DMPARENT
 K DMTOPFLD,DMNXTFLD,DMNEXTF,DMNEXTSF,DMNAME,DMLFK,DMLFKTE,DMFKTBL
 K DMPKTE,DMKEYS,DMC,DMFKFILE,DMASTER,DMLO,DMLOF,DMLOOP
 Q
