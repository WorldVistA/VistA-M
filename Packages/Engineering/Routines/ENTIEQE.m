ENTIEQE ;WOIFO/SAB - Edit Equipment Records (IT) ;2/4/2008
 ;;7.0;ENGINEERING;**87**;Aug 17, 1993;Build 16
 ;
SELEQ ; select (and process) equipment for edit
 S END=0
 S ENSCR="N ENCMR S ENCMR=$P($G(^(2)),U,9) I ENCMR,$D(^ENG(6914.1,""AIT"",1,ENCMR))"
 ;
 ; select and process equipment
 F  S DIC("S")=ENSCR D GETEQ^ENUTL Q:Y<1  S ENDA=+Y D EQP Q:END
 ; clean up
 K DIC,END,ENDA,ENEQ,ENSCR,Y
 Q
 ;
EQP ; process one equipment item (edit)
 ; input
 ;   ENDA - ien of equipment item
 ; output
 ;   END - flag, true when entire process should stop
 ;
 N DA,DDSFILE,DIROUT,DIRUT,DR,DTOUT,DUOUT
 ; lock equipment
 L +^ENG(6914,ENDA):$S($D(DILOCKTM):DILOCKTM,1:5) I '$T D  G EQPX
 . W $C(7),!,"Record being edited by someone else. Try later."
 . S DIR(0)="E" D ^DIR K DIR S:$D(DTOUT) END=1
 ;
 ; call fileman screen handler
 S DDSFILE=6914,DR="[ENIT EDIT]",DA=ENDA
 D ^DDS
 I $D(DTOUT) S END=1 ; user timed out
 ;
 ; unlock equip
 L -^ENG(6914,ENDA)
 ;
EQPX ; clean up
 Q
 ;
 ;ENTIEQE
