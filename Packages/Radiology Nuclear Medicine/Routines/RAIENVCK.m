RAIENVCK ;HIRMFO/GJC-Environmental Check Routine ;5/16/97  08:50
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
EN1 ; Version 5.0 environment check routine for Radiology/Nuclear Medicine.
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0) D  S XPDABORT=2 Q
 . W !?5,"DUZ and DUZ(0) must be defined as an active user to initialize"
 . W !?5,"the RADIOLOGY/NUCLEAR MEDICINE v",$P($T(+2),";",3)
 . W " software.",$C(7)
 . Q
 I DUZ(0)'="@" D  S XPDABORT=2 Q
 . W !?5,"You must have programmer access i.e, DUZ(0)=@, to run this "
 . W "init!",$C(7)
 . Q
 Q:$G(^RADPT(0))']""  ; virgin install, quit!
 ; Check for the two imaging types which will use radiopharmaceuticals.
 ; Abort the install if they are not present.
 S RAFLG=0
 I +$G(^DD(70,0,"VR"))<5.0 D
 . F RAI=1:1 S RATXT=$P($T(TEXT+RAI),";;",2) Q:RATXT']""  D
 .. S RATXT(1)=$P(RATXT,";"),RATXT(2)=$P(RATXT,";",2)
 .. I '$D(^RA(79.2,"C",RATXT(2))) D
 ... S (RAFLG,XPDABORT)=2 ; abort install, don't remove from ^XTMP
 ... W !!?3,"The Imaging type abbreviated as: "_RATXT(2)
 ... W !?3,"is missing.  ("_RATXT(1)_")"
 ... Q
 .. Q
 . Q
 I RAFLG D ERR792
 S RA787=+$O(^RA(78.7,"B","VERIFIED DATE",0))
 I $G(^RA(78.7,RA787,"E"))'["RAVERFDT" D
 . W !!?3,"Patch 2 (RA*4.5*2) must be installed before"
 . W " RADIOLOGY/NUCLEAR",!?3,"MEDICINE v",$P($T(+2),";",3)
 . W " can be installed!",$C(7) S XPDABORT=2
 . Q
 I '$$PATCH^XPDUTL("RA*4.5*10") D
 . W !!?3,"Patch 10 (RA*4.5*10) must be installed before"
 . W " RADIOLOGY/NUCLEAR",!?3,"MEDICINE v",$P($T(+2),";",3)
 . W " can be installed!",$C(7) S XPDABORT=2
 . Q
 I '$$CLEANUP() D
 . W !!?3,"RADIOLOGY/NUCLEAR MEDICINE CLEANUP v",$P($T(+2),";",3)
 . W " must be loaded and reside",!?3,"in the transport global before"
 . W " RADIOLOGY/NUCLEAR MEDICINE v",$P($T(+2),";",3)
 . W !?3,"can be installed!",!,$C(7) S XPDABORT=2
 . Q
XIT ; Exit point, kill variables then quit application.
 K RA787,RAFLG,RAI,RATXT
 Q
CLEANUP() ; Check if the 'Radiology/Nuclear Medicine Cleanup 5.0'
 ; distribution has been loaded and is resident in the transport global.
 ; Output: 0 if not loaded -OR- not resident in transport global
 ;         1 if ok to proceed (loaded & transport global present)
 N %,DIC,RASTAT,X,Y
 S X="RADIOLOGY/NUCLEAR MEDICINE CLEANUP "_$P($T(+2),";",3)
 S DIC="^XPD(9.7,",DIC(0)="O" D ^DIC Q:+Y'>0 0 ;cleanup missing
 S RASTAT=$$GET1^DIQ(9.7,+Y,.02,"I") ; status of distribution
 Q:RASTAT'=0 0 ; status must be 'loaded from distribution'
 Q:'$D(^XTMP("XPDI",+Y,"BLD")) 0 ; missing from transport global
 Q 1
ERR792 ; Error messages for an incomplete Imaging Type file.  Needed are the
 ; imaging type abbreviations for those imaging types which will use
 ; radiopharmaceuticals.
 W !!?3,"The Imaging Type file must have these imaging type"
 W !?3,"abbreviations before the package can be updated from"
 W !?3,"version 4.5 to 5.0:",!
 W !?5,"CARD  -   Cardiology Studies (Nuc Med)"
 W !?5,"NM    -   Nuclear Medicine"
 W !!?3,"Package installation cannot proceed.  Contact the Radiology/"
 W !?3,"Nuclear Medicine ADPAC for assistance.",$C(7)
 Q
TEXT ; Check I-Type & abbreviation of file 79.2 against those listed below.
 ;;CARDIOLOGY STUDIES (NUC MED);CARD
 ;;NUCLEAR MEDICINE;NM
 ;;
