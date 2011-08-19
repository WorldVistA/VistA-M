HDISVF08 ;ALB/RMO - 7118.22 File Utilities/API Cont.; 1/18/05@1:57:00
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
 ;---- Begin HDIS Facility Term/Concept Association file (#7118.22) API(s) ----
 ;
FINDFAC(HDISYIEN,HDISFIEN,HDISTIEN,HDISIREF,HDISADDF,HDISAIEN,HDISERRM) ;Find or Add a New Facility Term/Concept Entry
 ; Input  -- HDISYIEN HDIS System file (#7118.21) IEN
 ;           HDISFIEN HDIS File/Field file (#7115.6) IEN
 ;           HDISTIEN HDIS Term/Concept VUID Association file (#7118.11) IEN
 ;           HDISIREF Internal Reference  (Optional)
 ;           HDISADDF Add a New Entry Flag  (Optional- Default 0)
 ;                    1=Yes and 0=No
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISAIEN  HDIS Facility Term/Concept Association file IEN
 ;           If Failure:
 ;           HDISERRM  Error Message  (Optional)
 N HDISI,HDISOKF
 ;Initialize ouput
 S (HDISAIEN,HDISERRM)=""
 ;Check for missing variables, exit if not defined
 I $G(HDISYIEN)'>0!($G(HDISFIEN)'>0)!($G(HDISTIEN)'>0) D  G FINDFACQ
 . S HDISERRM="Required Variable Missing."
 ;Check for existing System, File/Field, Term/Concept and Internal Reference, return entry and exit if it exists
 I $D(^HDISF(7118.22,"AS",HDISYIEN,HDISFIEN,HDISTIEN)) D  G ADDFACQ:$G(HDISAIEN)
 . S HDISI=0
 . F  S HDISI=$O(^HDISF(7118.22,"AS",HDISYIEN,HDISFIEN,HDISTIEN,HDISI))  Q:'HDISI!($G(HDISAIEN))  D
 . . I $D(^HDISF(7118.22,HDISI,0)),$P(^(0),"^",3)=$G(HDISIREF) D
 . . . S HDISAIEN=HDISI
 . . . S HDISOKF=1
 ;If flag set, Add a New Facility Term/Concept Entry
 I $G(HDISADDF) S HDISOKF=$$ADDFAC(HDISYIEN,HDISFIEN,HDISTIEN,$G(HDISIREF),.HDISAIEN,.HDISERRM)
FINDFACQ Q +$G(HDISOKF)
 ;
ADDFAC(HDISYIEN,HDISFIEN,HDISTIEN,HDISIREF,HDISAIEN,HDISERRM) ;Find or Add a New Facility Term/Concept Entry
 ; Input  -- HDISYIEN HDIS System file (#7118.21) IEN
 ;           HDISFIEN HDIS File/Field file (#7115.6) IEN
 ;           HDISTIEN HDIS Term/Concept VUID Association file (#7118.11) IEN
 ;           HDISIREF Internal Reference  (Optional)
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISAIEN  HDIS Facility Term/Concept Association file IEN
 ;           If Failure:
 ;           HDISERRM  Error Message  (Optional)
 N HDISFDA,HDISIEN,HDISMSG,HDISOKF
 ;Initialize ouput
 S (HDISAIEN,HDISERRM)=""
 ;Set array for System, File/Field, Internal Reference, Term/Concept and Date/Time Term/Concept Associated
 S HDISFDA(7118.22,"+1,",.01)=$G(HDISYIEN)
 S HDISFDA(7118.22,"+1,",.02)=$G(HDISFIEN)
 I $D(HDISIREF) S HDISFDA(7118.22,"+1,",.03)=$G(HDISIREF)
 S HDISFDA(7118.22,"+1,",.04)=$G(HDISTIEN)
 S HDISFDA(7118.22,"+1,",.05)=$$NOW^XLFDT
 D UPDATE^DIE("","HDISFDA","HDISIEN","HDISMSG")
 ;Check for error
 I $D(HDISMSG("DIERR")) D
 . S HDISERRM=$G(HDISMSG("DIERR",1,"TEXT",1))
 ELSE  D
 . S HDISAIEN=+$G(HDISIEN(1))
 . S HDISOKF=1
 D CLEAN^DILF
ADDFACQ Q +$G(HDISOKF)
 ;
GETIENS(HDISYIEN,HDISFIEN,HDISTIEN,HDISIENS) ;Get IENS for Facility Term/Concept by System, File/Field and Term/Concept
 ; Input  -- HDISYIEN HDIS System file (#7118.21) IEN
 ;           HDISFIEN HDIS File/Field file (#7115.6) IEN
 ;           HDISTIEN HDIS Term/Concept VUID Association file (#7118.11) IEN
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISIENS Array where HDISIENS(IEN)=Internal Reference field (#.03)
 N HDISI
 ;Initialize ouput
 K HDISIENS
 ;Check for missing variables, exit if not defined
 I $G(HDISYIEN)'>0!($G(HDISFIEN)'>0)!($G(HDISTIEN)'>0) G GETIENSQ
 S HDISI=0
 F  S HDISI=$O(^HDISF(7118.22,"AS",HDISYIEN,HDISFIEN,HDISTIEN,HDISI))  Q:'HDISI  D
 . I $D(^HDISF(7118.22,HDISI,0)) S HDISIENS(HDISI)=$P(^(0),"^",3)
GETIENSQ Q +$S($D(HDISIENS):1,1:0)
 ;
 ;---- End HDIS Facility Term/Concept Association file (#7118.22) ----
