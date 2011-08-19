RAO7SCH ;HISC/FPT,GJC-Scheduled Request from Rad to OE/RR! ;9/5/97  08:54
 ;;5.0;Radiology/Nuclear Medicine;**10,18**;Mar 16, 1998
 ;;last modification by SS JUN 19,2000 for P18
EN1(RAOIFN) ; 'RAOIFN' is the ien in file 75.1
 ; New vars & define the following variables: RAECH, RAECH array & RAHLFS
 N RAREG S RAREG=0 S:$D(RAOPT("REG"))#2!($D(RAOPT("ADDEXAM"))#2) RAREG=1
 N RA,RA0,RACPT,RACTIVDT,RAECH,RAEXAMID,RAHLFS,RAPROCDR,RASCH,RATAB,RAVAR
 S RATAB=1 D EN1^RAO7UTL S RA0=$G(^RAO(75.1,RAOIFN,0)) Q:RA0']""
 S RAVAR="RATMP(",RAVARBLE="RATMP"
 ; msh
 S @(RAVAR_RATAB_")")=$$MSH^RAO7UTL("ORM^O01") ;P18 event type added
 ; pid
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")=$$PID^RAO7UTL(RA0)
 ; orc
 I RAREG D
 . ; if registering a patient
 . S RAEXAMID=RAECH(2)_RADTI_RAECH(2)_RACNI
 . Q
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")="ORC"_RAHLFS_"SC"_RAHLFS_$P(RA0,U,7)_RAECH(1)_"OR"_RAHLFS_RAOIFN_$S(RAREG:RAEXAMID,1:"")_RAECH(1)_"RA"_$$STR^RAO7UTL(2)_$S(RAREG:"ZR",1:"")_$$STR^RAO7UTL(7)_$P(RA0,U,14)
 ; RAREG is defined based on RAOPT("REG") set in the entry action
 ; of RA REG. A full SC order control message is sent to OE when the
 ; order is scheduled. A modified SC order control message is sent when
 ; the order is registered (the 'ORC' segment is modified).
 S RAPROCDR(0)=$G(^RAMIS(71,+$P(RA0,U,2),0)),RAPROCDR(9)=+$P(RAPROCDR(0),U,9)
 S RACPT(0)=$$NAMCODE^RACPTMSC(RAPROCDR(9),DT)
 S RASCH=$$HLDATE^HLFNC($P(RA0,U,23),"TS")
 S RACTIVDT=$$HLDATE^HLFNC($P(RA0,U,18),"TS"),RA("STATUS")="P"
 I RAREG D  Q
 . ; build 'OBR' segment when the order is registered (patch 3 logic)
 . S RA("OBR",4)=$P(RACPT(0),U)_U_$P(RACPT(0),U,2)_U_"CPT4"_U_+$P(RA0,U,2)_U_$P(RAPROCDR(0),U)_"^99RAP"
 . S RATAB=RATAB+1,@(RAVAR_RATAB_")")="OBR"_$$STR^RAO7UTL(4)_RA("OBR",4)
 . D SHIP
 . Q
 ; obr
 S RA("OBR",4)=$P(RACPT(0),U)_U_$P(RACPT(0),U,2)_U_"CPT4"_U_+$P(RA0,U,2)_U_$P(RAPROCDR(0),U)_"^99RAP"
 S RATAB=RATAB+1,@(RAVAR_RATAB_")")="OBR"_$$STR^RAO7UTL(4)_RA("OBR",4)_$$STR^RAO7UTL(18)_RACTIVDT_$$STR^RAO7UTL(3)_RA("STATUS")_$$STR^RAO7UTL(11)_RASCH
SHIP ; ship message to MSG^RAO7UTL which fires of the HL7 message to CPRS
 D MSG^RAO7UTL("RA EVSEND OR",.@RAVARBLE)
 Q
