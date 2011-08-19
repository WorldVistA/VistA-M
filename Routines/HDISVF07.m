HDISVF07 ;ALB/RMO - 7118.21 File Utilities/API Cont.; 1/13/05@1:22:00
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
 ;---- Begin HDIS System file (#7118.21) API(s) ----
 ;
FINDSYS(HDISDIPA,HDISFACN,HDISTYPE,HDISADDF,HDISYIEN,HDISERRM) ;Find or Add a System Entry
 ; Input  -- HDISDIPA Domain/IP Address
 ;           HDISFACN Facility Number  (Optional- Default current facility number)
 ;           HDISTYPE Type  (Optional- Default current system)
 ;           HDISADDF Add a New Entry Flag (Optional- Default 0)
 ;                    1=Yes and 0=No
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISYIEN  HDIS System file IEN
 ;           If Failure:
 ;           HDISERRM  Error Message  (Optional)
 N HDISI,HDISIPTR,HDISOKF,HDISRSLT
 ;Initialize output
 S (HDISYIEN,HDISERRM)=""
 ;Check for missing variable, exit if not defined
 I $G(HDISDIPA)="" D  G FINDSYSQ
 . S HDISERRM="Required Variable Missing."
 ;Set Facility Number to default of current facility number, if needed
 S HDISFACN=$S('$D(HDISFACN):$$FACNUM^HDISVF01,1:HDISFACN)
 ;Check Facility Number, return error and exit if no value
 I $G(HDISFACN)="" D  G FINDSYSQ
 . S HDISERRM="Unable to determine Facility Number."
 ;Set Institution file (#4) IEN 
 S HDISIPTR=$$FACPTR^HDISVF01(HDISFACN)
 ;Check Institution file (#4) IEN, return error and exit if no value
 I $G(HDISIPTR)'>0 D  G FINDSYSQ
 . S HDISERRM="Unable to determine Institution file (#4) IEN."
 ;Set Type to default of current system, if needed
 S HDISTYPE=$S('$D(HDISTYPE):$$PROD^XUPROD,1:HDISTYPE)
 ;Convert HDISTYPE to internal value
 D CHK^DIE(7118.21,.03,"",HDISTYPE,.HDISRSLT)
 S HDISTYPE=HDISRSLT
 ;Check for existing Institution file (#4) IEN and Domain/IP Address, return entry and exit if it exists
 I $D(^HDISF(7118.21,"B",HDISIPTR)) D  G FINDSYSQ:$G(HDISYIEN)
 . S HDISI=0
 . F  S HDISI=$O(^HDISF(7118.21,"B",HDISIPTR,HDISI)) Q:'HDISI!($G(HDISYIEN))  D
 . . I $D(^HDISF(7118.21,HDISI,0)),$P(^(0),"^",2)=HDISDIPA D
 . . . S HDISYIEN=HDISI
 . . . S HDISOKF=1
 ;If flag is set, Add a New System Entry
 I $G(HDISADDF) S HDISOKF=$$ADDSYS(HDISIPTR,HDISDIPA,HDISTYPE,.HDISYIEN,.HDISERRM)
 ; 
FINDSYSQ Q +$G(HDISOKF)
 ;
ADDSYS(HDISIPTR,HDISDIPA,HDISTYPE,HDISYIEN,HDISERRM) ;Add a New System Entry
 ; Input  -- HDISIPTR Institution file (#4) IEN
 ;           HDISDIPA Domain/IP Address
 ;           HDISTYPE Type (Internal Value)
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISYIEN HDIS System file IEN
 ;           If Failure:
 ;           HDISERRM  Error Message  (Optional)
 N HDISFDA,HDISIEN,HDISMSG,HDISOKF
 ;Initialize output
 S (HDISYIEN,HDISERRM)=""
 ;Set array for Institution, Domain/IP Address and Type
 S HDISFDA(7118.21,"+1,",.01)=$G(HDISIPTR)
 S HDISFDA(7118.21,"+1,",.02)=$G(HDISDIPA)
 S HDISFDA(7118.21,"+1,",.03)=$G(HDISTYPE)
 D UPDATE^DIE("","HDISFDA","HDISIEN","HDISMSG")
 ;Check for error
 I $D(HDISMSG("DIERR")) D
 . S HDISERRM=$G(HDISMSG("DIERR",1,"TEXT",1))
 ELSE  D
 . S HDISYIEN=+$G(HDISIEN(1))
 . S HDISOKF=1
 D CLEAN^DILF
ADDSYSQ Q +$G(HDISOKF)
 ;
CURSYS(HDISYIEN) ;Current System's HDIS System file IEN
 ; Input  -- None
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISYIEN HDIS System file IEN
 N HDISFACN,HDISIPTR,HDISTYPE
 ;Initialize output
 S HDISYIEN=""
 ;Set Facility Number, Institution file (#4) IEN and Type
 S HDISFACN=$$FACNUM^HDISVF01
 S HDISIPTR=$$FACPTR^HDISVF01(HDISFACN)
 S HDISTYPE=$$PROD^XUPROD
 ;Check for entry by Type and Institution file (#4) IEN
 S HDISYIEN=$O(^HDISF(7118.21,"ATYP",+HDISTYPE,+HDISIPTR,0))
CURSYSQ Q +$S($G(HDISYIEN)>0:1,1:0)
 ;
GETFAC(HDISYIEN,HDISIPTR,HDISFACN) ;Get Institution file (#4) IEN and Facility Number by IEN
 ; Input  -- HDISYIEN HDIS System file IEN  (Optional- Default current system)
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISIPTR Institution file (#4) IEN
 ;           HDISFACN Facility Number
 ;Initialize output
 S (HDISIPTR,HDISFACN)=""
 ;Set HDIS System file IEN to current system, if needed
 I '$D(HDISYIEN),$$CURSYS(.HDISYIEN)
 ;Check for missing variable, exit if not defined
 I $G(HDISYIEN)'>0 G GETFACQ
 ;Check for Institution file (#4) IEN and Facility Number by IEN
 I $D(^HDISF(7118.21,HDISYIEN,0)) S HDISIPTR=$P($G(^(0)),"^",1) D
 . S HDISFACN=$$FACNUM^HDISVF01(HDISIPTR)
GETFACQ Q +$S($G(HDISIPTR)'=""&($G(HDISFACN)'=""):1,1:0)
 ;
GETDIP(HDISYIEN,HDISDIPA) ;Get Domain/IP Address by IEN
 ; Input  -- HDISYIEN HDIS System file IEN  (Optional- Default current system)
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISDIPA Domain/IP Address
 ;Initialize output
 S HDISDIPA=""
 ;Set HDIS System file IEN to current system, if needed
 I '$D(HDISYIEN),$$CURSYS(.HDISYIEN)
 ;Check for missing variable, exit if not defined
 I $G(HDISYIEN)'>0 G GETDIPQ
 ;Check for Domain/IP Address by IEN
 I $D(^HDISF(7118.21,HDISYIEN,0)) S HDISDIPA=$P($G(^(0)),"^",2)
GETDIPQ Q +$S($G(HDISDIPA)'="":1,1:0)
 ;
 ;
GETTYPE(HDISYIEN,HDISTYPE,HDISTYPX) ;Get Type (Internal and External Value) by IEN
 ; Input  -- HDISYIEN HDIS System file IEN  (Optional- Default current system)
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISTYPE Type (Internal Value)
 ;           HDISTYPX Type (External Value)
 ;Initialize output
 S (HDISTYPE,HDISTYPX)=""
 ;Set HDIS System file IEN to current system, if needed
 I '$D(HDISYIEN),$$CURSYS(.HDISYIEN)
 ;Check for missing variable, exit if not defined
 I $G(HDISYIEN)'>0 G GETTYPEQ
 ;Check for Domain/IP Address by IEN
 I $D(^HDISF(7118.21,HDISYIEN,0)) S HDISTYPE=$P($G(^(0)),"^",3) D
 . S HDISTYPX=$$GET1^DIQ(7118.21,HDISYIEN,.03)
GETTYPEQ Q +$S($G(HDISTYPE)'=""&($G(HDISTYPX)'=""):1,1:0)
 ;
 ;---- End HDIS System file (#7118.21) API(s) ----
