LRMIEDIM ;BPFO/DTG - LAB MICRO - LOOP ETIOLOGY FIELD FILE 61.2 FOR INACTIVE DATE ;08/15/2017
 ;;5.2;LAB SERVICE;**495**;Sep 27, 1994;Build 6
 ;
 ;associated to the [LRMI EDIT INACT DT MULTI 61.2] option
 ;
 ;This routine will go through the 61.2 by IDENTIFIER oldest to newest for those entries
 ;that do not have an INACTIVE DATE. The last entry (if the file for that combination was
 ;not complete) will be stored for upto 6 months so that when re-starting for that identifier
 ;it will allow to restart with that item if it does not have a inactive date or the next newest
 ;if it does. The person will also have the choice to start over from the oldest entry.
 ;
 Q
 ;
EN ; entry point from option
 N DIR,DIRUT,DIC,A,B,LRXT,MSG,LRRUN,LR0,LRIDENT,LRIDNM,X,Y,DIE,DTOUT,DR,DA,LR6491
EN1 S U="^" I $G(DT)="" S DT=$$DT^XLFDT
 S B=$$SITE^VASITE,B=$P(B,U,1),LRXT="LRENT-INACT"
 ;
 D ASKFILE
 I $D(DIRUT)!(Y="^") K MSG D  G OUT
 . S MSG(1)="Identifier Type Not Selected. Quitting"
 . S MSG(2)=""
 . D DISP
 S LRIDENT=Y,LRIDNM=Y(0)
 K DIR,DIRUT
 ;get ^XTMP for identifier
 S LRRUN=0,A=$G(^XTMP(LRXT,0)),B=$G(^XTMP(LRXT,LRIDENT,0))
 I +B>0 S LRRUN=+B
 I A="" S $P(A,U,3)="Save of Etiology File 61.2 Identifiers for Inactive Date entry"
 S $P(A,U,1)=$$FMADD^XLFDT(DT,60),$P(A,U,2)=DT
 S ^XTMP(LRXT,0)=A,^XTMP(LRXT,LRIDENT,0)=LRRUN
 I LRRUN=0 D XSET(LRIDENT,"") G LOOP
 S A=$$GETVAL(LRRUN)
 K DIR,DIRUT S DIR(0)="SO^C:CONTINUE WITH "_$E($P(A,U,1),1,45)_"  ["_(+B)_"];S:START OVER"
 S DIR("L",1)="   CONTINUE WITH "_$E($P(A,U,1),1,45)_"  ["_(+B)_"] (C)"
 S DIR("L")="   START OVER (S)"
 D ^DIR
 I $D(DIRUT)!(Y="^") K MSG D  G OUT
 . S MSG(1)="Continuation Method Not Selected. Quitting"
 . S MSG(2)=""
 . D DISP
 I $G(Y)="S" S LRRUN=0 G LOOP
 S LRRUN=LRRUN+1
 ;
LOOP S LRRUN=$O(^LAB(61.2,LRRUN)) I 'LRRUN D XSET(LRIDENT,"") D  G OUT
 . K MSG S MSG(1)="All Entries for the Selected Identifier ("_LRIDNM_") have been reviewed. Quitting"
 . S MSG(2)=""
 . D DISP
 S LR0=$G(^LAB(61.2,LRRUN,0)),LR6491=$G(^LAB(61.2,LRRUN,"64.91"))
 ; check if inactive date
 I $P(LR6491,U,2)'="" D XSET(LRIDENT,LRRUN) G LOOP
 ; check if right identifier
 I LRIDENT="X" G LP1
 I $P(LR0,U,5)=""&(LRIDENT="N") G LP1
 I $P(LR0,U,5)'=LRIDENT D XSET(LRIDENT,LRRUN) G LOOP
 ;
LP1 ; ask inactive date
 ; first lock entry
 L +^LAB(61.2,LRRUN):60 I '$T D  G OUT
 . K MSG S MSG(1)="Not Able to Lock Entry ("_$E($P(LR0,U,1),1,45)_" ["_LRRUN_"]). Quitting"
 . S MSG(2)=""
 . D DISP
 W !!,"Organism: ",$E($P(LR0,U,1),1,45)," (",LRRUN,")"
 K Y,DIE,DTOUT S DIE("NO^")="OUTOK",DIE="^LAB(61.2,",DA=LRRUN,DR="64.9102" D ^DIE
 L -^LAB(61.2,LRRUN)
 ; check if ^ was entered
 I $D(Y) D  G OUT
 . K MSG S MSG(1)="An '^' was detected. Quitting"
 . S MSG(2)=""
 . D DISP
 D XSET(LRIDENT,LRRUN)
 G LOOP
 ;
ASKFILE()  ; Ask user to select Identifier
 K DIR,DIRUT
 S DIR(0)="SO^B:BACTERIUM;F:FUNGUS;P:PARASITE;M:MYCOBACTERIUM;V:VIRUS;C:CHEMICAL;D:DRUG;R:RICKETTSIAE;A:PHYSICAL AGENT;N:NULL;X:ALL"
 S DIR("L",1)="   BACTERIUM           (B)"
 S DIR("L",2)="   FUNGUS              (F)"
 S DIR("L",3)="   PARASITE            (P)"
 S DIR("L",4)="   MYCOBACTERIUM       (M)"
 S DIR("L",5)="   VIRUS               (V)"
 S DIR("L",6)="   CHEMICAL            (C)"
 S DIR("L",7)="   DRUG                (D)"
 S DIR("L",8)="   RICKETTSIAE         (R)"
 S DIR("L",9)="   PHYSICAL AGENT      (A)"
 S DIR("L",10)="   NULL                (N)"
 S DIR("L")="   ALL                 (X)"
 S DIR("A")="Enter the Identifier Name or Code "
 D ^DIR
 Q
 ;
DISP ; display message
 D CLEAR^VALM1
 D BMES^XPDUTL(.MSG)
 Q
 ;
GETVAL(C) ; get 61.2 info
 N A,B,D
 S A=$G(^LAB(61.2,C,0)),B=$G(^LAB(61.2,C,64.91))
 S D=$P(A,U,1)_U_$P(A,U,5)_U_$P(B,U,2)
 Q D
 ;
OUT ; quit
 K DIR,DIRUT,DIC,A,B,LRXT,MSG,LRRUN,LR0,LRIDENT,LRIDNM,X,Y,DIE,DTOUT,DR,DA,LR6491,DIE("NO^")
 Q
 ;
XSET(A,B) ; set into XTMP
 ; A - Identifier,  B - value
 S ^XTMP(LRXT,A,0)=B
 Q
