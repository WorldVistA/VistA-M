RARIC1 ;HISC/GJC-Check to see if Imaging package exists ;3/4/96  15:43
 ;;5.0;Radiology/Nuclear Medicine;**23,93**;Mar 16, 1998;Build 3
 ; 07/15/2008 BAY/KAM rem call 249750 RA*5*93 Correct DIK Calls
 ;
 ; API's STUFPHY and DELIMGPT are supported by DBIA#3317
 ;
IMAGE() ; check to see if Imaging package exists
 ; called from RACNLU, RAPTLU and RART1
 ; 1 = exists
 ; 0 = doesn't exist
 S X="MAGBAPI" X ^%ZOSF("TEST") I '$T Q 0
 S X="MAGGTIA" X ^%ZOSF("TEST") I '$T Q 0
 Q $S($O(^MAG(2005,0)):1,1:0)
 ;
 ;
STUFPHY(RAVERF,RASR,RARTN) ; stuff physician duz
 ;RASR should be rtn MAGJUPD1's RIST, =15 if staff, =12 if resident
 ;RAVERF=duz of physician (primary staff or primary resident)
 S RARTN="STUFPHY called"
 I '$D(DA(2))!'$D(DA(1))!'($D(DA)#2) S RARTN="Missing DA references" Q
 I 'RASR S RARTN="Missing RASR value" Q
 N RAERR,RAFLD,RAMDIV,RAMDV,RAMLC,RAESIG,RACOD
 ;
 ; check loc access
 S RACOD=$S(RASR=15:"S",RASR=12:"R",1:"")
 I RACOD="" S RARTN="Can't determine staff/resident code" Q
 I '$$SCRN^RAUTL8(.DA,RACOD,RAVERF,"PRI") S RARTN="Failed loc access" Q
 ;
 ; check verifier access
 I $D(^RADPT(DA(2),"DT",DA(1),0)) S RAMDIV=^(0),RAMLC=+$P(RAMDIV,"^",4),RAMDIV=+$P(RAMDIV,"^",3),RAMDV=$S($D(^RA(79,RAMDIV,.1)):^(.1),1:""),RAMDV=$S(RAMDV="":RAMDV,1:$TR(RAMDV,"YyNn",1100))
 I '$D(RAMDV) S RARTN="Can't determine RAMDV" Q
 D VERCHK^RAHLO3 ;returns RAERR text string
 I $G(RAERR)]"" S RARTN="Failed verifier: "_RAERR Q
 ;
 ; stuff data
 S DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P"","
 S DR=RASR_"////"_RAVERF D ^DIE K DI,DIC,DE,DQ,DIE,DR
 S RARTN=1
 ;
 ;delete 2nd staff/resident if it matches the primary staff/resident
 S RAFLD=$S(RASR=15:60,RASR=12:70,1:"")
 I 'RAFLD K DA Q  ;can't determine secondary field to check/delete
 D EN^RAUTL8(RAVERF,RAFLD,.DA)
 K DA
 Q
DELIMGPT(RAIE74,RAIE2005) ;delete imaging pointer
 ;input RAIE74 is File 74's ien
 ;input RAIE2005  is File 2005's ien
 ; quit if either input value is 0 or null or non-numeric
 Q:'RAIE74  Q:'RAIE2005
 ; quit if report doesn't have this RAIE2005 value
 N DA,DIK
 S DA=$O(^RARPT(RAIE74,2005,"B",RAIE2005,0))
 Q:'DA
 ; delete this 2005 pointer record
 ;07/17/2008 modified setting DIK in next line
 S DA(1)=RAIE74,DIK="^RARPT("_DA(1)_",2005," D ^DIK
 Q
EHVC ; Executable Help for File 72's VISTARAD CATEGORY field
 N RATXT,I
 F I=1:1:12 S RATXT(I)=$P($T(EHVCTXT+I),";;",2)
 D EN^DDIOL(.RATXT)
 Q
EHVCTXT ;
 ;;This field is only needed for sites that will be using VistaRad for soft-copy
 ;;reading of images.  This information is used by VistaRad software to prepare
 ;;the various types of exam lists that are displayed on the VistaRad workstation,
 ;;and to properly manage exam locking for the radiologists.
 ;;
 ;;If this Examination Status is to be used for exams that will be
 ;;read with VistaRad, then enter a value that corresponds to it
 ;;from the following list.  Note that not all status codes should
 ;;be assigned a VistaRad Category value, but only those that apply.
 ;;  
 ;;All other Exam Status codes that may be defined in the Radiology
 ;;Exam Status file should NOT be entered into this field.
 Q
