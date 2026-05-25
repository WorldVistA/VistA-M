RAIPS220 ;WOIFO/KLM - Post-init Driver, patch 220 ; Nov 13, 2024@08:14:57
 ;;5.0;Radiology/Nuclear Medicine;**220**;Mar 16, 1998;Build 3
 ;
 ; This post-install routine will add the new option "RA REPROC" to
 ; the SCHEDULED OPTION file, and set it to run every fifteen minutes. 
 ;
 ; Routine/File         IA          Type
 ; -------------------------------------
 ; RESCH^XUTMOPT       1472         (S)
 ; FMADD/NOW^XLFDT     10103        (S)
 ; PROD^XUPROD         4440         (S)
 ;
 Q
EN ;Entry point
 I $$PROD^XUPROD()=0 D BMES^XPDUTL("TEST account - Option 'RA REPROC' not scheduled!") Q
 N RAOPT,RAWHEN,RAFREQ,RAFLAG,RAERR
 S RAOPT="RA REPROC",RAWHEN="T@"_$E($P($$FMADD^XLFDT($$NOW^XLFDT,,3),".",2),1,2)_"00",RAFREQ="900S",RAFLAG="L"
 D RESCH^XUTMOPT(RAOPT,RAWHEN,"",RAFREQ,RAFLAG,.RAERR)
 I $G(RAERR)=-1 D BMES^XPDUTL("There was a problem scheduling the 'RA REPROC' option. Please schedule it manually.")
 I $G(RAERR)="" D BMES^XPDUTL("'RA REPROC' option scheduled!")
 ;
 Q
