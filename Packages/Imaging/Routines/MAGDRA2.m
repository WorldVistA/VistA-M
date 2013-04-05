MAGDRA2 ;WOIFO/LB,JSL,SAF - Routine for DICOM fix ; 13 Jul 2011 10:22 AM
 ;;3.0;IMAGING;**10,11,51,54,49,123**;Mar 19, 2002;Build 67;Jul 24, 2012
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ; Routine to create the MAGDY variable needed by MAGDLB1 routine when
 ; manually correcting DICOM FIX files.
EN ;
 ; MAGDY variable to be created during this execution.
 N MAGBEG,MAGEND,MAGDFN,MAGOUT,MAGX,MAGXX,INFO,MAGNME,MAGPID
 S MAGBEG=1070101,MAGEND=$$DT^XLFDT
READ ;
 S (MAGDFN,MAGX)=$$READ^MAGDRA3
 Q:MAGX="^"
 S MAGDFN=+MAGDFN
 I 'MAGDFN W !,"Entry not found, enter a ""^"" to quit." G READ
 ;
 I MAGX["~" G ONE  ;Lookup was on case number and successful
 S MAGXX=$$FIND1^DIC(70,"","","`"_MAGDFN)   ;Radiology patient
 ;
 I MAGDFN=MAGXX D
 . S INFO=$$PTINFO Q:$D(MAGERR)
 . S MAGNME=$P(INFO,"^"),MAGPID=$P(INFO,"^",2)
 . K ^TMP($J,"RAE1")  ;Re-established by EN1^RA07PC1 -DBIA available
 . ; Set the beginning and ending date.
 . D EN1^RAO7PC1(MAGDFN,MAGBEG,MAGEND,500)
 . D:$D(^TMP($J,"RAE1")) LOOP^MAGDRA1
 . Q
 E  D  G:MAGX'="^" READ
 . W !,"No Radiology information found for the supplied answer.",$C(7)
 . Q
 Q
 ;
PTINFO() ;
 N INFO,MAGOUT
 I '$D(MAGDFN) Q ""
 I $$ISIHS^MAGSPID() D  Q INFO  ;P123 - MOD for IHS patients with Health Record Numbers (i.e. Chawktaw)
 . N DFN S DFN=MAGDFN,INFO="" D DEM^VADPT
 . I $G(VA("PID"))'="" S INFO=$G(VADM(1))_"^"_$TR(VA("PID"),"-")
 . E  S INFO=$G(VADM(1))_"^"_$P($G(VADM(2)),"^")
 . Q
 D GETS^DIQ(2,MAGDFN,".01;.09","E","MAGOUT","MAGERR")
 I $D(MAGERR) Q ""
 I $D(MAGOUT) D  Q INFO
 . S INFO=$G(MAGOUT(2,MAGDFN_",",.01,"E"))
 . S INFO=INFO_"^"_$G(MAGOUT(2,MAGDFN_",",.09,"E"))
 . Q
 Q ""
 ;
LCASE(MAGDT,MAGCASE) ; return the accession number
 N ACNUMB,ARESULT
 S ACNUMB=$TR($TR($$FMTE^XLFDT(MAGDT,"2FD")," ","0"),"/","")_"-"_MAGCASE
 I $$USESSAN^RAHLRU1(),$$ACCFIND^RAAPI(ACNUMB,.ARESULT)>0 D  ; ICR 5600
 . ; lookup site-specific accession number
 . N ACNUMB1,RADFN,RADTI,RACNI
 . S RADFN=$P(ARESULT(1),"^",1),RADTI=$P(ARESULT(1),"^",2)
 . S RACNI=$P(ARESULT(1),"^",3)
 . S ACNUMB1=$$GET1^DIQ(70.03,(RACNI_","_RADTI_","_RADFN),31)
 . I ACNUMB1'="" S ACNUMB=ACNUMB1
 . Q
 Q ACNUMB
 ;
IMG(MAGRPT) ;
 N INFO,MAGOUT,MAGERR
 I 'MAGRPT Q ""
 D GETS^DIQ(74,MAGRPT,"2005*","I","MAGOUT","MAGERR")
 I $D(MAGERR) Q ""
 I $D(MAGOUT(74.02005)) Q " i"
 Q ""
 ;
PROC(MAGPRC) ;
 Q $$FIND1^DIC(71,,"XB",MAGPRC)
 ;
ONE ;
 ;MAGDFN,MAGX variables expected from EN
 I 'MAGDFN,'+MAGX Q
 N BEG,CASE,CDATE,CS,DATA,END,FLDS,INFO,MAGCASE,MAGCNI,MAGDATE,MAGDTI
 N MAGEXST,MAGLOC,MAGNME,MAGOUT,MAGPIEN,MAGPRC,MAGPSET,MAGPST,MAGRPT
 N PP,PSET,RAENTRY,RAMEMLOW,RAPRTSET,RIEN,STAT,X,X1,X2,XX
 N RARPT,RADFN,RADTI,RACNI ;<--Variables needed for EN1^RAUTL20
 ; RAUTL20 used to retrieve if case is part of a print set.
 S MAGDFN=$P(MAGX,"~"),INFO=$$PTINFO
 S MAGNME=$P(INFO,"^"),MAGPID=$P(INFO,"^",2)
 S RIEN=$P(MAGX,"~",2)_","_$P(MAGX,"~",1)
 S BEG=9999999.9999-$P(MAGX,"~",2),END=$$FMADD^XLFDT(BEG,2)
 K ^TMP($J,"RAE1")
 D EN1^RAO7PC1(MAGDFN,BEG,END,20)
 S RAENTRY=$P(MAGX,"~",2)_"-"_$P(MAGX,"~",3)
 Q:'$D(^TMP($J,"RAE1"))
 Q:'$D(^TMP($J,"RAE1",MAGDFN,RAENTRY))
 S DATA=^TMP($J,"RAE1",MAGDFN,RAENTRY)
 S MAGDATE=$P(RAENTRY,"-"),CDATE=9999999.9999-MAGDATE
 S MAGDATE=$TR($$FMTE^XLFDT(CDATE,"2FD")," ","0")
 S MAGPRC=$P(DATA,"^"),CASE=$P(DATA,"^",2),STAT=$P(DATA,"^",6)
 S MAGEXST=$P(STAT,"~",2),MAGLOC=$P(DATA,"^",7)
 S (MAGRPT,RARPT)=$P(DATA,"^",5)
 S (MAGDTI,RADTI)=$P(RAENTRY,"-")
 S (MAGCNI,RACNI)=$P(RAENTRY,"-",2),RADFN=MAGDFN
 S MAGCASE=$$LCASE(CDATE,CASE),MAGPIEN=$$PROC(MAGPRC)
 ; RADTI, RADFN, RACNI variables needed for EN1^RAUTL20
 D EN1^RAUTL20
 S (PSET,MAGPSET)=""
 S PSET=$S(RAMEMLOW:"+",RAPRTSET:".",1:"")
 I PSET=".",RACNI>1 D
 . N OLDENTRY S OLDENTRY=$P(RAENTRY,"-")_"-"
 . S OLDENTRY=$O(^TMP($J,"RAE1",MAGDFN,OLDENTRY)) I $L(OLDENTRY) D
 . . S MAGCASE=$P(^TMP($J,"RAE1",MAGDFN,OLDENTRY),"^",2)
 . . S CDATE=$P(RAENTRY,"-")
 . . S CDATE=9999999.9999-CDATE
 . . S MAGCASE=$$LCASE^MAGDRA2(CDATE,MAGCASE),RACNI=$P(OLDENTRY,"-",2)
 . . S MAGPST=CASE_" is part of this printset."
 . . Q
 . Q
 I $D(RAPRTSET) S PP=$S(MAGCNI>1:".",MAGCNI=1:"+",1:"")
 S MAGCNI=RACNI
 W !,"PATIENT: ",MAGNME,?51,$$PIDLABEL^MAGSPID(),": ",MAGPID
 W !,"Case No.",?15,"Procedure",?42,"Location",?64,"Exam Date"
 W !,"________",?15,"_________",?42,"________________",?64,"________"
 W !,$G(PP),CASE,$$IMG(MAGRPT),?15,MAGPRC,?42,MAGLOC,?64,MAGDATE
 W !,"Exam status: ",MAGEXST," "," ",$G(MAGPST)
 D MAGDY
 Q
 ;
MAGDY ;
 S MAGDY=MAGDFN_"^"_MAGNME_"^"_MAGPID_"^"_MAGCASE_"^"_MAGPRC_"^"_MAGDTI
 S MAGDY=MAGDY_"^"_MAGCNI_"^"_MAGPIEN_"^"_$G(MAGPST)_"^"
 K MAGNME,MAGPID,MAGCASE,MAGPRC,MAGDTI,MAGCNI,MAGPIEN,MAPST
 Q
 ;
