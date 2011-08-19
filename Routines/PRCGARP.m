PRCGARP ;WIRMFO@ALTOONA/CTB  IFCAP PURGE SCHEDULER ;12/10/97  9:52 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 W @IOF,!,"IFCAP PURGE SCHEDULER",!
 S %A="This option will allow you to purge IFCAP records which have previously been",%A(1)="identified and archived for your station.",%A(2)="Have you received and verified your archive micro fiche"
 D ^PRCFYN Q:%<0
 I %=2 D  Q:%'=1
 . S %A="I will allow you to purge records which have not been archived, but it is",%A(1)="probably not a good idea to do so.",%A(2)="Are you sure you want to continue",%=2 D ^PRCFYN Q:%'=1
 . S %A="ARE YOU POSITIVE",%=2 D ^PRCFYN
 . QUIT
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S TREC=$P(^PRC(443.9,0),"^",4),OGET=TREC\1000+1
 S MESSAGE="CREATING PURGEMASTER ENTRIES" K ITEMS
 D BEGIN^PRCGU
 S NEXT=0
X F  D  S XCOUNT=XCOUNT+COUNT D PERCENT^PRCGU Q:'NEXT
 . S COUNT=0 F  D  QUIT:'NEXT!(COUNT>LREC)
 . . S GET=($S((LREC-COUNT)>OGET:OGET,1:(LREC-COUNT)+2))-1
 . . I GET<1 S GET=1
 . . S NEXT=$O(^PRC(443.9,NEXT)) Q:'NEXT  D GET S COUNT=COUNT+ICOUNT
 . . S Z="",ROUTINE="START^PRCGARP1",VARIABLE=BEGDA_"-"_ENDA_";"_PRC("SITE") D ADD^PRCGPM1(ROUTINE,VARIABLE,.Z)
 . . QUIT
 . QUIT
 D END^PRCGU
 QUIT
GET S (BEGDA,ENDA)=NEXT,ICOUNT=1
 Q:ICOUNT=GET
 F  S NEXT=$O(^PRC(443.9,NEXT)) Q:'NEXT  S ENDA=NEXT,ICOUNT=ICOUNT+1 Q:ICOUNT=GET
 QUIT
