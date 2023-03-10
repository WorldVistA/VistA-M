RAO7CMP ;HISC/FPT,GJC-Completed Request from Rad to OE/RR! ; Aug 18, 2020@15:35:45
 ;;5.0;Radiology/Nuclear Medicine;**10,18,26,28,160**;Mar 16, 1998;Build 4
 ;Last modification for P18 by SS, JULY 6, 2000
EN1(RAOIFN) ; 'RAOIFN' is the ien in file 75.1
 ; New vars & define the following variables: RAECH, RAECH array & RAHLFS
 N A,DFN,RA,RA0,RA70,RA74,RABNORM,RACNT,RACPT,RACTIVDT,RADFN,RADTI,RAECH
 N RAEXAM,RAHLFS,RAOBDT,RAPRIOR,RAPROC,RAPRVPHY,RAR,RARXAM,RATAB,RAVAR
 N RAXSET
 N RA18PROC ;P18 procedure ien
 S RATAB=1 D EN1^RAO7UTL S RA0=$G(^RAO(75.1,RAOIFN,0)) Q:RA0']""
 D SETVAR S RAR=$G(^RAO(75.1,RAOIFN,"R"))
 S RAVAR="RATMP(",RAVARBLE="RATMP"
 ; msh
 S @(RAVAR_RATAB_")")=$$MSH^RAO7UTL("ORU^R01") ;P18 Event type
 ; pid
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")=$$PID^RAO7UTL(RA0)
 ; orc
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")="ORC"_RAHLFS_"RE"_RAHLFS_$P(RA0,U,7)_RAECH(1)_"OR"_RAHLFS_RAOIFN_RAECH(2)_RADTI_RAECH(2)_$S(RAXSET:"",1:RAEXAM)_RAECH(1)_"RA"_$$STR^RAO7UTL(4)_RA("ORC",7)_$$STR^RAO7UTL(5)_$P(RA0,U,14)
 ; obr
 I RAXSET D  ; Exam is part of a set, check all others.
 . S RABNORM=$$ABNOR^RAO7UTL1(RAOIFN,RADFN,RADTI)
 . Q
 E  S RABNORM=$$DIAG^RAO7UTL(RADFN,RADTI,RAEXAM)
 S RA("OBR",4)=$P(RACPT(0),U)_U_$P(RACPT(0),U,2)_U_"CPT4"_U_RA18PROC_U_$P(RAPROC(0),U)_"^99RAP" ;P18
 S RA("STATUS")="F" ; Results Status
 I 'RAXSET D
 . S RAPRVPHY=$P(RA74(0),"^",9) ; Verifying Physician
 . I RAPRVPHY="" D
 .. S RAPRVPHY=$P(RA70(0),"^",15) ; Prim. Stf.
 .. S:RAPRVPHY="" RAPRVPHY=$P(RA70(0),"^",12) ; Prim. Res.
 .. Q
 . Q
 S RACTIVDT=$$HLDATE^HLFNC($P(RA0,"^",18),"TS") ; Status Update D/T
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")="OBR"_$$STR^RAO7UTL(4)_RA("OBR",4)_$$STR^RAO7UTL(3)_RAOBDT_$$STR^RAO7UTL(15)_RACTIVDT_$$STR^RAO7UTL(3)_RA("STATUS")_$$STR^RAO7UTL(7)_$G(RAPRVPHY)
 ; obx
 ; set abnormal flag, if found
 I 'RAXSET D  ; Not part of a set
 . I +$O(^RARPT(RA70(17),"I",0)) D
 .. S (A,RACNT)=0 F  S A=$O(^RARPT(RA70(17),"I",A)) Q:A'>0  D
 ... S RACNT=RACNT+1,RATAB=RATAB+1
 ... S @(RAVAR_RATAB_")")="OBX"_RAHLFS_RACNT_RAHLFS_"TX"_RAHLFS_"I^Impression^L"_RAHLFS_"1"_RAHLFS_$G(^RARPT(RA70(17),"I",A,0))_$$STR^RAO7UTL(3)_$S(RACNT=1:RABNORM,1:"")
 ... Q
 .. Q
 . E  D
 .. S RACNT=1,RATAB=RATAB+1
 .. S @(RAVAR_RATAB_")")="OBX"_RAHLFS_RACNT_RAHLFS_"TX"_RAHLFS_"I^Impression^L"_RAHLFS_"1"_$$STR^RAO7UTL(4)_RABNORM
 .. Q
 . Q
 E  D  ; Part of a set
 . S RACNT=1,RATAB=RATAB+1
 . S @(RAVAR_RATAB_")")="OBX"_RAHLFS_RACNT_RAHLFS_"TX"_RAHLFS_"I^Impression^L"_RAHLFS_"1"_RAHLFS_"Part of a set - see individual procedures"_$$STR^RAO7UTL(3)_RABNORM
 . Q
 K VA,VADM,VAERR
 D MSG^RAO7UTL("RA EVSEND OR",.@RAVARBLE)
 Q
SETVAR ; Setup exam specific variables
 S RADFN=+RA0,RADTI=+$O(^RADPT("AO",RAOIFN,RADFN,0)) ;P18
 S RAEXAM=+$O(^RADPT("AO",RAOIFN,RADFN,RADTI,0)) ;P26
 S RA70(0)=$G(^RADPT(RADFN,"DT",RADTI,"P",RAEXAM,0)) ;P26
 ;if CPRS patch not installed always take procedure ien from 75.1
 ;if not - then in case of Parent procedure take it from 75.1,otherwise-from 70
 I '$$PATCH^XPDUTL("OR*3.0*92") S RA18PROC=+$P(RA0,U,2) ;P18
 ;gjc p160 $G on the procedure zero node to prevent hard error
 E  S RA18PROC=$S($P($G(^RAMIS(71,+$P(RA0,U,2),0)),U,6)="P":+$P(RA0,U,2),1:+$P(RA70(0),U,2)) ;P18;P26;P31
 S RAPROC(0)=$G(^RAMIS(71,RA18PROC,0)),RAPROC(9)=+$P(RAPROC(0),U,9) ;P18
 S RACPT(0)=$$NAMCODE^RACPTMSC(RAPROC(9),DT)
 S RAPRIOR=$P(RA0,U,6)
 S RAPRIOR=$S(RAPRIOR=1:"S",RAPRIOR=2:"A",RAPRIOR=9:"R",1:"")
 S RA("ORC",7)="^^^^^"_RAPRIOR
 S RARXAM(0)=$G(^RADPT(RADFN,"DT",RADTI,0))
 S RAXSET=+$P(RARXAM(0),"^",5) ; '1' if part of xam set
 S RAOBDT=$$HLDATE^HLFNC((9999999.9999-RADTI),"TS")
 S RA70(17)=+$P(RA70(0),"^",17),RA74(0)=$G(^RARPT(RA70(17),0))
 Q
