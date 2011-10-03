DINIT6 ;SFISC/XAK-INITIALIZE VA FILEMAN ;2:13 PM  2 Nov 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 I $D(^DD("OS"))[0 D OS^DINIT
 W !!,"The following files have been installed:",!
 F X=0:0 S X=$O(^DIC(X)) Q:X>1.9999  Q:'X  W $E("   ",1,(3-$L($P(X,"."))))_X,?11,$P($G(^DIC(X,0)),U),! S ^DD(X,0,"VR")=VERSION
 S ^DD("VERSION")=VERSION,X=^DD("OS",^DD("OS"),0)
 S ^DD("ROU")=$P(X,U,4) K ^DD("SUB")
 D 1
 D ^DINITPST
E W !,"INITIALIZATION COMPLETED IN "_($P($H,",",2)-DIT)_" SECONDS."
 D KL Q
 ;
1 N DIT
 D KL,PKG,DIINIT
 Q
 ;
KL K %,%H,%X,%Y,DD,DH,DIC,DIK,DIT,DITZS,D,DA,VERSION,DU,F,I,J,P,X,Y,DIRUT,DTOUT,DUOUT
 Q
PKG ;
 I $D(^DIC(9.4,0))#2,($P(^DIC(9.4,0),U,1)'="PACKAGE") D  Q
 . W !!,"You have a file #9.4 that is not the 'Package' file."
 . W !,"Therefore, the Package file will not be initialized on your system."
 . W !,"You cannot use VA FileMan's package export utility, DIFROM."
 . Q
 I $$ROUEXIST^DILIBF("XPDUTL"),$$VERSION^XPDUTL("XU")'<8 Q
 K ^DD(9.4,913.5,2),^DD(9.4,914.5,2),^DD(9.4,916.5,2),^DD(9.44,222.7,2),^DD(9.44,222.9,2),^DD(9.44,1909)
 W !!,"Your Package file will now be updated.",!!
 D EN^DIPKINIT
 ;
 ;Update DIPK Package file entry
 N DIDATE,DIERR,DINDESC,DINIEN,DINFDA,DINMSG,DIVERS,X,Y,%DT
 S DIVERS=$P($T(V^DINIT),";",3)
 S X=$P($T(V^DINIT),";",6),%DT="" D ^%DT S DIDATE=Y
 S DINFDA(9.4,"?+1,",.01)="DIPK (PACKAGE FILE INIT)"
 S DINFDA(9.4,"?+1,",1)="DIPK"
 S DINFDA(9.4,"?+1,",2)="FileMan Init of Package File"
 S DINDESC(1,0)="Init of Package file to be used by VA FileMan sites that wish to export"
 S DINDESC(2,0)="software using DIFROM."
 S DINFDA(9.4,"?+1,",3)="DINDESC"
 S DINFDA(9.4,"?+1,",13)=DIVERS
 S DINFDA(9.49,"?+2,?+1,",.01)=DIVERS
 S:DIDATE>0 DINFDA(9.49,"?+2,?+1,",1)=DIDATE
 S DINFDA(9.49,"?+2,?+1,",2)=DT
 S:$G(DUZ) DINFDA(9.49,"?+2,?+1,",3)=DUZ
 D UPDATE^DIE("","DINFDA","DINIEN","DINMSG")
 Q
DIINIT ;Update VA FileMan package entry
 N DIDATE,DIERR,DINIEN,DINFDA,DINMSG,DIVERS,X,Y,%DT
 S DIVERS=$P($T(V^DINIT),";",3)
 S X=$P($T(V^DINIT),";",6),%DT="" D ^%DT S DIDATE=Y
 S DINFDA(9.4,"?+1,",.01)="VA FILEMAN"
 S DINFDA(9.4,"?+1,",1)="DI"
 S DINFDA(9.4,"?+1,",2)="FM INIT"
 S DINFDA(9.4,"?+1,",13)=DIVERS
 S DINFDA(9.49,"?+2,?+1,",.01)=DIVERS
 S:DIDATE>0 DINFDA(9.49,"?+2,?+1,",1)=DIDATE
 S DINFDA(9.49,"?+2,?+1,",2)=DT
 S:$G(DUZ) DINFDA(9.49,"?+2,?+1,",3)=DUZ
 D UPDATE^DIE("","DINFDA","DINIEN","DINMSG")
 I $G(DIERR),$D(DINMSG("DIERR","E",299)) D
 . W !!,$C(7),"WARNING: There is more than one 'VA FILEMAN' entry in the Package file (#9.4)."
 . W !,"         I am unable to determine which is the correct entry to update with"
 . W !,"         current installation data."
 . W !!,"         You can delete or edit erroneous entries and run DINIT again."
 . N DIR,DTOUT,DUOUT,DIRUT,DIROUT
 . S DIR(0)="E"
 . W ! D ^DIR
 ;
 ;Put PACKAGE pointer into FM DIALOG entries, re-index file
 N DIPKG,DIREC S DIPKG=$G(DINIEN(1))
 W !!,"Re-indexing entries in the DIALOG file."
 F DIREC=0:0 S DIREC=$O(^DI(.84,DIREC)) Q:'DIREC!(DIREC>10000)  D
 . S $P(^DI(.84,DIREC,0),U,4)=DIPKG
 K DA S DIK="^DI(.84," D IXALL^DIK
 Q
 ;
 ;Install FileMan options, keys, remote procedures, and DI package
 ;I $P($G(^DIC(19,0)),U,1)="OPTION",$P($G(^DIC(19.1,0)),U,1)="SECURITY KEY" D
 ;. W !!,"Options, security keys, and remote procedures will now be added to your system.",!!
 ;. D EN^DIINIT
 ;. I $$FIND1^DIC(19,"","","DDMP IMPORT") D
 ;. . N DIOK
 ;. . S DIOK=$$ADD^XPDMENU("DIOTHER","DDMP IMPORT","",8)
 ;. . I 'DIOK W !,"The DDMP IMPORT option was not added to the DIOTHER menu.",!
 ;. Q
 Q
