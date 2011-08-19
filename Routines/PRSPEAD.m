PRSPEAD ;WOIFO/SAB - DISPLAY EXTENDED ABSENCE ;10/20/2004
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Display List of Extended Absences
 ;
 N CNT,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,EAIEN,OUT,PG,PRSIEN,TDT,X,Y
 ;
 ; determine Employee IEN
 S PRSIEN=$$PRSIEN^PRSPUT2(1)
 I 'PRSIEN G EXIT
 ;
 S (CNT,OUT,PG)=0
 D HD
 ;
 W !?24,"VA TIME & ATTENDANCE SYSTEM",!?26,"DISPLAY EXTENDED ABSENCE",!
 ;
 ; ask date
 S DIR(0)="D^::EX",DIR("A")="Begin with Date",DIR("B")="T"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 ;
 ; loop thru employee extended absences by to date
 S TDT=Y-.01
 F  S TDT=$O(^PRST(458.4,"AEE",PRSIEN,TDT)) Q:TDT=""  D  Q:OUT
 . S EAIEN=0
 . F  S EAIEN=$O(^PRST(458.4,"AEE",PRSIEN,TDT,EAIEN)) Q:'EAIEN  D  Q:OUT
 . . I $Y+6>IOSL D HD Q:OUT
 . . D DISEA^PRSPEAU(EAIEN)
 . . S CNT=CNT+1
 ;
 I 'OUT,CNT=0 W !!,"No extended absence records on file."
 I 'OUT S DIR(0)="E" D ^DIR K DIR
 ;
EXIT ; exit point
 Q
 ;
HD ; header
 I $E(IOST,1,2)="C-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S OUT=1 Q
 I $E(IOST,1,2)="C-"!PG W @IOF
 S PG=PG+1
 Q
 ;
 ;PRSPEAD
