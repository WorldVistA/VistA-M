HDISVF04 ;ALB/RMO - 7118.11 File Utilities/API Cont.; 1/10/05@11:37:00
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
 ;---- Begin HDIS Term/Concept VUID Association file (#7118.11) API(s) ----
 ;
GETTERM(HDISTERM,HDISFARY,HDISTIEN) ;Get a Term/Concept Entry by Term/Concept and File/Field
 ; Input  -- HDISTERM Term/Concept Text
 ;           HDISFARY File/Field Array - Pass by HDISFARY(HDIS File/Field file #7115.6 IEN)=""
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISTIEN HDIS Term/Concept VUID Association file IEN
 N HDISFIEN,HDISI
 ;Initialize output
 S HDISTIEN=""
 ;Check for missing variables, exit if not defined
 I '$D(HDISTERM)!('$D(HDISFARY)) G GETTERMQ
 ;Check for existing Term/Concept and File/Field
 S HDISFIEN=0
 F  S HDISFIEN=$O(HDISFARY(HDISFIEN)) Q:'HDISFIEN  D
 . I $D(^HDISV(7118.11,"AC",HDISFIEN)) D
 . S HDISI=0
 . F  S HDISI=$O(^HDISV(7118.11,"AC",HDISFIEN,HDISI)) Q:'HDISI!($G(HDISTIEN))  D
 . . I $D(^HDISV(7118.11,HDISI,0)),$P(^(0),"^",1)=HDISTERM D
 . . . S HDISTIEN=HDISI
GETTERMQ Q +$S($G(HDISTIEN)>0:1,1:0)
 ;
ADDTERM(HDISTERM,HDISVUID,HDISFARY,HDISNTLF,HDISCKTF,HDISEDTM,HDISSTAT,HDISTIEN,HDISERRM) ;Add a New Term/Concept Entry
 ; Input  -- HDISTERM Term/Concept Text
 ;           HDISVUID VUID
 ;           HDISFARY File/Field Array - Pass by HDISFARY(HDIS File/Field file #7115.6 IEN)=""
 ;           HDISNTLF National Standard Flag  (Optional- Default 0)
 ;                    1=Yes and 0=No
 ;           HDISCKTF Check for Existing Term/Concept Flag  (Optional- Default 1)
 ;                    1=Yes and 0=No
 ;           HDISEDTM Effective Date/Time  (Optional- Default NOW)
 ;           HDISSTAT Status  (Optional- Default 0)
 ;                    1=Active and 0=Inactive
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISTIEN HDIS Term/Concept VUID Association file IEN
 ;           If Failure:
 ;           HDISERRM Error Message  (Optional)
 N HDISCNT,HDISERRF,HDISFDA,HDISFFNM,HDISFIEN,HDISI,HDISIEN,HDISIENS,HDISMSG,HDISNDTF,HDISOKF
 ;Initialize output
 S (HDISTIEN,HDISERRM)=""
 ;Check for missing variables, exit if not defined
 I '$D(HDISTERM)!($G(HDISVUID)'>0)!('$D(HDISFARY)) D  G ADDTERMQ
 . S HDISERRM="Required Variable Missing."
 ;Set National Standard Flag to default of 0, if needed
 S HDISNTLF=$S('$D(HDISNTLF):0,1:HDISNTLF)
 ;Set No Effective Date/Time Flag to 1 if there is no Effective Date/Time and no Status
 I '$G(HDISEDTM),'$G(HDISSTAT) D
 . S HDISNDTF=1
 ;If No Effective Date/Time Flag is set to 1, Effective Date/Time Multiple should not be created
 I '$G(HDISNDTF) D
 . ;Set Effective Date/Time to default of NOW, if needed
 . S HDISEDTM=$S('$D(HDISEDTM):$$NOW^XLFDT,1:HDISEDTM)
 . ;Set Status to default of 0, if needed
 . S HDISSTAT=$S('$D(HDISSTAT):0,1:HDISSTAT)
 ;Set Check for Existing Term/Concept Flag to default of 1, if needed
 S HDISCKTF=$S('$D(HDISCKTF):1,1:HDISCKTF)
 ;Check for existing Term/Concept and File/Field, return error and exit if it exists
 I $G(HDISCKTF),$$GETTERM(HDISTERM,.HDISFARY) D  G ADDTERMQ
 . S HDISERRM="Term/Concept and File/Field already exists."
 ;Check for existing Term/Concept and VUID, return error and exit if it exists
 I $$GETIENS(HDISVUID,.HDISIENS) D  G ADDTERMQ:$G(HDISERRF)
 . S HDISI=0
 . F  S HDISI=$O(HDISIENS(HDISI)) Q:'HDISI!($G(HDISERRF))  I $G(HDISIENS(HDISI))=HDISTERM D
 . . S HDISERRF=1
 . . S HDISERRM="Term/Concept and VUID already exists."
 ;Set array for Term/Concept and VUID
 S HDISFDA(7118.11,"+1,",.01)=$G(HDISTERM)
 S HDISFDA(7118.11,"+1,",99.99)=$G(HDISVUID)
 ;Set array for National Standard Flag to Yes
 I $G(HDISNTLF) D
 . S HDISFDA(7118.11,"+1,",1.02)=1
 ELSE  D
 . ;Set array for Date/Time Created and National Standard Flag to No
 . S HDISFDA(7118.11,"+1,",1.01)=$$NOW^XLFDT
 . S HDISFDA(7118.11,"+1,",1.02)=0
 ;If No Effective Date/Time Flag is set to 1, Effective Date/Time Multiple should not be created
 I '$G(HDISNDTF) D
 . ;Set array for Effective Date/Time and Status
 . S HDISFDA(7118.12,"+2,+1,",.01)=$G(HDISEDTM)
 . S HDISFDA(7118.12,"+2,+1,",.02)=$G(HDISSTAT)
 ;Set array for File/Field
 S HDISFIEN=0
 S HDISCNT=2
 F  S HDISFIEN=$O(HDISFARY(HDISFIEN)) Q:'HDISFIEN  I $D(^HDIS(7115.6,HDISFIEN,0)) S HDISFFNM=$P(^(0),"^",1) D
 . S HDISCNT=HDISCNT+1
 . S HDISFDA(7118.13,"+"_HDISCNT_",+1,",.01)=HDISFFNM
 D UPDATE^DIE("E","HDISFDA","HDISIEN","HDISMSG")
 ;Check for error
 I $D(HDISMSG("DIERR")) D
 . S HDISERRM=$G(HDISMSG("DIERR",1,"TEXT",1))
 ELSE  D
 . S HDISTIEN=+$G(HDISIEN(1))
 . S HDISOKF=1
 D CLEAN^DILF
ADDTERMQ Q +$G(HDISOKF)
 ;
GETIENS(HDISVUID,HDISIENS) ;Get IENS for a Term/Concept by VUID
 ; Input  -- HDISVUID VUID
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISIENS Array where HDISIENS(IEN)=Term/Concept field (#.01)
 N HDISI
 ;Initialize output
 K HDISIENS
 ;Check for missing variable, exit if not defined
 I $G(HDISVUID)'>0 G GETIENSQ
 ;Check for entries by VUID
 S HDISI=0
 F  S HDISI=$O(^HDISV(7118.11,"AVUID",HDISVUID,HDISI)) Q:'HDISI  D
 . I $D(^HDISV(7118.11,HDISI,0)) S HDISIENS(HDISI)=$P($G(^(0)),"^",1)
GETIENSQ Q +$S($D(HDISIENS):1,1:0)
 ;
GETVUID(HDISTIEN,HDISVUID) ;Get VUID for a Term/Concept by IEN
 ; Input  -- HDISTIEN HDIS Term/Concept VUID Association file IEN
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISVUID VUID
 ;Initialize output
 S HDISVUID=""
 ;Check for missing variable, exit if not defined
 I $G(HDISTIEN)'>0 G GETVUIDQ
 ;Check for VUID by IEN
 I $D(^HDISV(7118.11,HDISTIEN,"VUID")) S HDISVUID=$P($G(^("VUID")),"^",1)
GETVUIDQ Q +$S($G(HDISVUID)>0:1,1:0)
 ;
GETNTLF(HDISTIEN,HDISNTLF) ;Get National Standard Flag for a Term/Concept by IEN
 ; Input  -- HDISTIEN HDIS Term/Concept VUID Association file IEN
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISNTLF National Standard Flag
 ;Initialize output
 S HDISNTLF=""
 ;Check for missing variable, exit if not defined
 I $G(HDISTIEN)'>0 G GETNTLFQ
 ;Check for National Standard Flag by IEN
 I $D(^HDISV(7118.11,HDISTIEN,1)) S HDISNTLF=$P($G(^(1)),"^",2)
GETNTLFQ Q +$S($G(HDISNTLF)]"":1,1:0)
 ;
GETSTAT(HDISTIEN,HDISDTM,HDISEDTM,HDISSTAT) ;Get Effective Date and Status for a Term/Concept by IEN and Date/Time
 ; Input  -- HDISTIEN HDIS Term/Concept VUID Association file IEN
 ;           HDISDTM  Date/Time  (Optional- Default NOW for Current)
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISEDTM Effective Date/Time
 ;           HDISSTAT Status
 N HDIS0,HDISII
 ;Initialize output
 S (HDISEDTM,HDISSTAT)=""
 ;Check for missing variable, exit if not defined
 I $G(HDISTIEN)'>0 G GETSTATQ
 ;Set Date/Time to default of NOW for Current, if needed
 S HDISDTM=$S('$D(HDISDTM):$$NOW^XLFDT,1:HDISDTM)
 S:'$P(HDISDTM,".",2) HDISDTM=HDISDTM_.235959
 ;Get Effective Date/Time Multiple IEN by IEN and Date/Time
 S HDISII=+$O(^(+$O(^HDISV(7118.11,HDISTIEN,"TERMSTATUS","B",HDISDTM),-1),0))
 ;Check for Effective Date/Time and Status
 I $D(^HDISV(7118.11,HDISTIEN,"TERMSTATUS",HDISII,0)) S HDIS0=$G(^(0)) D
 . S HDISEDTM=$P(HDIS0,"^",1)
 . S HDISSTAT=$P(HDIS0,"^",2)
GETSTATQ Q +$S($G(HDISEDTM)'=""&($G(HDISSTAT)'=""):1,1:0)
 ;          
 ;---- End HDIS Term/Concept VUID Association file (#7118.11) API(s) ----
