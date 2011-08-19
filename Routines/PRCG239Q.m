PRCG239Q ;WISC/BGJ-IFCAP 410 FILE CLEANUP (QUEUE) ;11/8/99
V ;;5.1;IFCAP;**95**;Oct 20, 2000
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;This routine is installed by patch PRC*5.1*95.
 ;This routine creates entries in file 443.1 for background processing
 ;by PurgeMaster.  Entries are created for file 417.
 ;Routine PRCG239P will be utilized by PurgeMaster to actually purge the
 ;entries in this file.
 ;
 W @IOF,!
 D MSG
 S %A="Are you ready to continue",%A(0)="!",%=1
 D ^PRCFYN Q:%'=1
 S PRCF("X")="AS" D ^PRCFSITE G OUT:'%
 D NOW^%DTC K %H,%,%I
 S CFY=$E(X,1,3)+1700,CFY=$S(+$E(X,4,5)>9:CFY+1,1:CFY)
 S PFY=CFY-1700-1_"0930"
 S X="Date/Fiscal Year thru which FMS reconilliation data in file 417 will be purged."
 D DATE
 I +OUT G OUT
 I $E(Y,4,7)="0000" S Y=$E(Y,1,3)_"0930"
 S PRC("DATE")=Y
 K OUT
DQ ;
 I $D(ZTQUEUED) S ZTREQ="@"
 F I=1:1 S X=$T(LOAD+I) Q:$P(X,";",3)=""  D
 . S FILE(I)=$P(X,";",3),GLO(I)=$P(X,";",4),REF(I)=$P(X,";",5),ADDVAR(I)=$P(X,";",6)
 S N=0,TREC=0
 F  S N=$O(GLO(N)) Q:'N  D
 . S X="S REC(N)=$P("_GLO(N)_"0),U,4)" X X S TREC=TREC+REC(N)
 S OGET=TREC\1000+1
 S MESSAGE="CREATING PURGEMASTER ENTRIES FOR FILE CLEANUP"
 D BEGIN^PRCGU
 S LEVEL=0
 F  S LEVEL=$O(GLO(LEVEL)) Q:LEVEL=""  D
 . S GLO=GLO(LEVEL),REF=REF(LEVEL),ADDVAR=""
 . S:ADDVAR(LEVEL)]"" @("ADDVAR="_ADDVAR(LEVEL))
 . S NEXT=0
 . F  D  S XCOUNT=XCOUNT+COUNT D PERCENT^PRCGU Q:'NEXT
 . . S COUNT=0
 . . F  D  Q:'NEXT!(COUNT>LREC)
 . . . S GET=($S((LREC-COUNT)>OGET:OGET,1:(LREC-COUNT)+2))-1
 . . . I GET<1 S GET=1
 . . . D GET
 . . . Q:'NEXT
 . . . S COUNT=COUNT+ICOUNT
 . . . S Z="",ROUTINE=REF_"^PRCG239P",VARIABLE=BEGDA_"-"_ENDA_";"_PRC("SITE")
 . . . I ADDVAR]"" S VARIABLE=VARIABLE_";"_ADDVAR
 . . . D ADD^PRCGPM1(ROUTINE,VARIABLE,.Z)
 D END^PRCGU
 ;
OUT ;
 K A,ADDVAR,ATERM,BEGDA,BTIME,CFY,COUNT,CURSOR,DX,DY,ENDA,FILE,GET,GLO,HOURS,ICOUNT,LEVEL,LINE,LREC,MIN,NEXT,OGET,OUT,PERCENT,PFY,REC,REF,ROUTINE,RTIME,SEC,TIME,TREC,TTIME,VARIABLE,X,XCOUNT,XPOS,Y,Z,PRC
 D KILL^%ZISS
 Q
GET ;
 S (BEGDA,ENDA)=NEXT+1,ICOUNT=1
 S @("NEXT=$O("_GLO_"NEXT))")
 I 'NEXT S NEXT="" Q
 S BEGDA=NEXT,(NEXT,ENDA)=NEXT+GET,ICOUNT=ENDA-BEGDA+1
 Q
MSG ;
 S X="This will schedule records in file 417 for review in the "
 S X=X_"background by PurgeMaster (file 443.1 will be populated).  "
 S X=X_"FMS reconcilliation data in file 417 will be purged by "
 S X=X_"PurgeMaster based on the date that you will enter."
 D MSG^PRCFQ W !
 S X="The date you are about to enter MUST be confirmed with A&MM "
 S X=X_"or Fiscal staff.  FAILURE TO DO SO MAY RESULT IN DATA "
 S X=X_"CORRUPTION." D MSG^PRCFQ W $C(7),$C(7),$C(7)
 Q
DATE ;Select fiscal year
 S DIR(0)="DA^:"_PFY_":EA"
 S DIR("A")="Select DATE/FISCAL YEAR: "
 S DIR("A",1)=X
 S DIR("?")="You may only select for purging those documents which are not in the current Fiscal Year."
 D ^DIR
 S OUT=$G(DTOUT)_$G(DUOUT)_$G(DIRUT)_$G(DIROUT)
 K DTOUT,DUOUT,DIRUT,DIROUT,DIR
 Q
LOAD ;
 ;;417;^PRCS(417,;417;PRC("DATE")
 ;;;
