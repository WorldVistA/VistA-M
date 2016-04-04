DIARB ;SFISC/TKW,WISC/CAP-ARCHIVING FUNCTIONS (CONT) ;4/24/96  10:55
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
ENTE ;ADD/REMOVE ENTRIES TO SELECTED
 S DIC("A")="ADD/DELETE ENTRIES FROM ARCHIVAL ACTIVITY: " K DIARC D FILE^DIARU G Q:'$D(DIARC)
 S DIARCNT=0 K DIC
D S DIC=+DIARF,DIC(0)="AEQMF",DIART=DIARF2,Z=0
E W ! S DIC("W")="W:$D(^DIBT(DIARU,1,+Y)) "" *on "_$S($D(DIAX):"EXTRACT",1:"ARCHIVE")_" list*"" S DIARX="""" F DIARX2=0:0 S DIARX=$O(^DD(+DIARF,0,""ID"",DIARX)) Q:DIARX=""""  S DIARX3=^(DIARX) I $D(@(DIC_""+Y,0)"")) X DIARX3"
 D ^DIC K DIC("W")
 I Y'>0 G QE
 S X=DIART G F:'X S Z=Z+1,%=$P($P(X,U,2),",",Z)
 G F:'% S $P(X,U)=$P($P(X,U),",",2,999),DIC=DIC_+Y_","_%_","
 I $D(@(DIC_"0)")),$P(^(0),U,2)-X=0 S DIART=X G E
 W !,$C(7),"No "_$O(^DD(+X,0,"NM",""))_" entry !!!",!
 G D
F K DR S DA=+Y,DR=0 D EN^DIQ
 I '$D(^DIBT(DIARU,1,DA)) G E1
 S DIR(0)="Y",DIR("A")="DELETE this entry FROM the "_$S($D(DIAX):"EXTRACT",1:"ARCHIVAL")_" SELECTION",DIR("B")="YES"
 D ^DIR G QE:$D(DUOUT)!$D(DTOUT),QE:'$D(Y)
 I 'Y W !!,"OK, I left it IN !" G D
 S DIARCNT=DIARCNT+1,A=^DIAR(1.11,DIARC,0),$P(A,U,7)=$P(A,U,7)-1,$P(A,U,8)=2,^(0)=A
 K ^DIBT(DIARU,1,DA),@(DIC_DA_",-9)") W "  Deleted"
 G D
E1 S DIR(0)="Y",DIR("A")="ADD this entry TO the "_$S($D(DIAX):"EXTRACT",1:"ARCHIVAL")_" SELECTION",DIR("B")="YES"
 D ^DIR G QE:$D(DUOUT)!$D(DTOUT),QE:'$D(Y)
 I 'Y W !!,"OK, I left it OUT !" G D
 S DIARCNT=DIARCNT+1,A=^DIAR(1.11,DIARC,0),$P(A,U,7)=$P(A,U,7)+1,$P(A,U,8)=2,^(0)=A
 S ^DIBT(DIARU,1,DA)="" W "  DONE"
 G D
QE S:'DIARCNT DIAR="" D UPDATE^DIARU
Q K DIAR,DIARC,DIARCNT,DIARD,DIARE,DIARF,DIARF0,DIARF1,DIARF2,DIARI,DIARP,DIARS,DIARST,DIART,DIARU,DIARX,DIAR
 K DIR,DIC,DIARL,DIARLINE,DIARBLNE,DIARPDEV,DIARPG,DIAX,DIAXFNO,DIAXNRB,DIAXMSG,DIARQUED,DIARTAB,DIARTRM,DIARXZ,DIARFLD,DIARFI,DIARXY
 K DIFILE,DIARXXX,DISTOP,DIARX2,DIARX3,DIPG,DIERR,DIOVRD
 Q
ASK W !!,$C(7),"This extract activity has already updated the destination file.",!
 S DIR("A")="Delete the destination file entries created by this extract activity",DIR("B")="NO",DIR(0)="Y"
 S DIR("??")="^W !!?5,""Enter YES to rollback the destination file to its state before the update."""
 D ^DIR I 'Y S DIAXNRB=1
 Q
