LRACMOVE ;DALOI/JMC - MOVE MAJOR/MINOR HEADERS IN LAB REPORTS FILE (64.5);July 3, 2008
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ;
EN ; Move major and/or minor header to a new location
 ;
 N DIC,DIR,DIROUT,DIRUT,DUOUT,LRCKW,LRIEN,LRMH,LRSH,LRTYPE,X,Y
 ;
 I '$D(^XUSEC("LRLIASON",DUZ)) W $C(7),!,"You do not have access to this option" Q
 ;
 L +^LAB(64.5,0):DILOCKTM
 I '$T W !," This entry is being edited by someone else." Q
 ;
 S DIR(0)="SO^1:Major Header;2:Minor Header"
 S DIR("A")="Select type of header to move",DIR("B")=1,DIR("?")="Select the type of cumulative report header to move."
 D ^DIR
 I $D(DIRUT) D END Q
 ;
 S LRTYPE=+Y
 I LRTYPE=1 S LRMH=$$MAJOR
 ;
 I LRTYPE=2 D
 . S LRMH=$$MAJOR
 . I LRMH<1 Q
 . S LRSH=$$MINOR
 ;
 I LRMH<1 D END Q
 I LRTYPE=2,LRSH<1 D END Q
 ;
 D MOVETO
 I LRIEN<1 D END Q
 I LRTYPE=2,LRIEN(1)<1 D END Q
 ;
 ; Move the major/minor header to it's new destination
 D MOVE
 ;
 ; Reindex after move
 D REINDEX
 ;
 ; Run diagnostics to check for any problems introduced
 W !,"Run Diagnostic Report for LAB REPORTS File",!
 S LRCKW=0 D QUE^LRACDIAG
 ;
 D END
 ;
 Q
 ;
 ;
MAJOR() ; Select a major header
 ;
 N DIC
 S DIC(0)="AEMQZ",DIC="^LAB(64.5,1,1,"
 D ^DIC
 ;
 Q Y
 ;
 ;
MINOR() ; Select minor header within a major header
 ;
 N DIC
 S DIC(0)="AEMQZ",DIC="^LAB(64.5,1,1,"_+LRMH_",1,"
 D ^DIC
 ;
 Q Y
 ;
 ;
MOVETO ; Move the header to the destination location.
 ;
 N DA,DIC,DO,DINUM,DIR,DIROUT,DIRUT,DUOUT,LRMOVE,X
 ;
 I LRTYPE=1 D
 . S LRIEN=$$ADDIEN(LRTYPE)
 . I LRIEN<1 Q
 ;
 ;
 I LRTYPE=2 D
 . S LRIEN=0
 . S DIR(0)="SO^1:Within an existing major header;2:To a new major header"
 . S DIR("A")="Move minor header",DIR("B")=1
 . D ^DIR
 . I $D(DIRUT) Q
 . S LRMOVE=+Y
 . I LRMOVE=1 S LRIEN=$$MAJOR
 . I LRMOVE=2 S LRIEN=$$ADDIEN(1,"")
 . I LRIEN<1 Q
 . S LRIEN(1)=$$ADDIEN(LRTYPE,LRIEN)
 ;
 Q
 ;
 ;
ADDIEN(LRTYPE,LRIEN) ; Create new header
 ;
 N DA,DIC,DO,DINUM,LRDA,LRX,X,Y
 ;
 S DIC(0)="EZ",X="NEW HEADER"
 I LRTYPE=1 D
 . S DA(1)=1
 . S DIC="^LAB(64.5,1,1,",DIC("DR")=".01;5"
 . I $P(^LAB(64.5,1,1,+LRMH,0),"^",2)'="" S DIC("DR")=DIC("DR")_"//"_$P(^LAB(64.5,1,1,+LRMH,0),"^",2)
 ;
 I LRTYPE=2 D
 . S LRX=^LAB(64.5,1,1,+LRMH,1,+LRSH,0)
 . S DA(2)=1,DA(1)=+LRIEN
 . S DIC="^LAB(64.5,1,1,"_+LRIEN_",1,",DIC("DR")=".01;1////"_$P(LRX,"^",2)_";2////"_$P(LRX,"^",3)_";3////"_$P(LRX,"^",4)
 ;
 D FILE^DICN
 I Y>0 S LRDA=+Y_"^"_Y(0,0)
 E  S LRDA=Y
 ;
 Q LRDA
 ;
 ;
MOVE ; Move the entry to the new location, re-index the new entry and delete the old entry
 ;
 N DA,DIK
 ;
 W !!,"Copying ",$S(LRTYPE=1:"major",1:"minor")," header: ",$S(LRTYPE=1:$P(LRMH,"^",2),1:$P(LRSH,"^",2))
 W !," to ",$S(LRTYPE=1:"major",1:"minor")," header: ",$S(LRTYPE=1:$P(LRIEN,"^",2),1:$P(LRIEN(1),"^",2)),!
 I LRTYPE=2 W "  in the major header: ",$P(LRIEN,"^",2),!
 ;
 I LRTYPE=1 D
 . M ^LAB(64.5,1,1,+LRIEN,1)=^LAB(64.5,1,1,+LRMH,1)
 . S DA=+LRIEN,DA(1)=1,DIK="^LAB(64.5,1,1,"
 ;
 I LRTYPE=2 D
 . M ^LAB(64.5,1,1,+LRIEN,1,+LRIEN(1),1)=^LAB(64.5,1,1,+LRMH,1,+LRSH,1)
 . S DA=+LRIEN(1),DA(1)=+LRIEN,DA(2)=1,DIK="LAB(64.5,1,1,"_+LRIEN_",1,"
 ;
 ; Re-index the new entry
 W !,"Re-indexing new ",$S(LRTYPE=1:"major",1:"minor")," header: ",$S(LRTYPE=1:$P(LRIEN,"^",2),1:$P(LRIEN(1),"^",2)),!
 D IX1^DIK
 ;
 ; Delete the old entry
 W !,"Deleting ",$S(LRTYPE=1:"major",1:"minor")," header: ",$S(LRTYPE=1:$P(LRMH,"^",2),1:$P(LRSH,"^",2)),!
 K DA,DIK
 S DA=$S(LRTYPE=1:+LRMH,1:+LRSH)
 S DIK="^LAB(64.5,1,1,",DA(1)=1
 I LRTYPE=2 S DIK=DIK_+LRMH_",1,",DA(1)=+LRMH,DA(2)=1
 D ^DIK
 ;
 Q
 ;
 ;
REINDEX ; Reindex headers after they have been moved.
 N I,LR
 S LR(1)=1,LR(2)=1,LR(3)=1
 F I="A","AC","AR" K ^LAB(64.5,I)
 ;
 W !!,"Re-indexing the LAB REPORTS file for:"
 W !,"Mumps ""A"" index of the LAB TEST subfield",!?4,"(contains reference ranges, units, etc. from file 60)"
 W !,"Mumps ""AC"" index of the LAB TEST LOCATION subfield",!?4,"(atomic test x-ref.)"
 W !,"Mumps ""AR"" index of the LAB TEST subfield",!?4,"(site/specimen x-ref.)"
 ;
 D MAJ^LRACDIAG
 Q
 ;
 ;
END ; Release lock
 L -^LAB(64.5,0)
 Q
