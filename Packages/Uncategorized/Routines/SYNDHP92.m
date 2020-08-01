SYNDHP92 ; HC/ART - HealthConcourse - DHP Save TIU Note ;01/26/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
CREATETIU(RETSTAT,DHPICN,TITLE,VISIT,TEXT,ESIG) ;save a TIU note for a patient
 ;Inputs: RETSTAT - return status, by reference
 ;        DHPICN  - patient ICN, required
 ;        TITLE   - pointer to the TIU DOCUMENT DEFINITION FILE (#8925.1), required
 ;        VISIT   - pointer to the Visit File (#9000010), required
 ;        TEXT    - input array with document identifiers and text, by reference, required
 ;          TEXT("TEXT",1,0)="abcd"
 ;          TEXT("TEXT",n,0)="wxyz"
 ;        ESIG - e-signature to sign note
 ;Output: RETSTAT - return status
 ;          IEN of the resulting entry in the TIU DOCUMENT FILE (#8925)
 ;       or -1^error message
 ;
 ; validate ICN
 I $G(DHPICN)="" S RETSTAT="-1^No patient identifier" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTAT="-1^Patient identifier not recognised" QUIT
 ; get patient IEN from ICN
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTAT="-1^AFICN x-ref issue" QUIT
 ;
 ; validate TITLE
 I '$G(TITLE) S RETSTAT="-1^No title identifier" QUIT
 I '$D(^TIU(8925.1,TITLE,0)) S RETSTAT="-1^Title not found" QUIT
 ;
 ; validate VISIT
 I '$G(VISIT) S RETSTAT="-1^No visit identifier" QUIT
 I '$D(^AUPNVSIT(VISIT,0)) S RETSTAT="-1^Visit not found" QUIT
 N PAT S PAT=$$GET1^DIQ(9000010,VISIT_",",.05,"I")
 I PATIEN'=PAT S RETSTAT="-1^Visit is not for this patient" QUIT
 ;
 ; validate TEXT
 I '$D(TEXT) S RETSTAT="-1^No note text" QUIT
 ;
 ;optional parameters
 N VDATE S VDATE=""
 N VLOC S VLOC=""
 N VSTR S VSTR=""
 N SUPPRESS S SUPPRESS=0
 N NOASF S NOASF=1
 ;
 N VPROV S VPROV=$O(^AUPNVPRV("AD",VISIT,"")) ;visit provider ien
 I VPROV="" S RETSTAT="-1^no provider associated with visit" QUIT
 w "VPROV: ",VPROV,"    ",$$GET1^DIQ(200,VPROV_",",.01),!
 ;
 N TIUX
 S TIUX(.02)=PATIEN ;Patient IEN
 S TIUX(.01)=TITLE
 S TIUX(.03)=VISIT
 S TIUX(1201)=$$NOW^XLFDT() ;entry date/time
 S TIUX(1205)=$$GET1^DIQ(9000010,VISIT_",",.06,"I") ;hospital location
 S TIUX(1301)=$$GET1^DIQ(9000010,VISIT_",",.01,"I") ;reference date=Visit Date
 M TIUX=TEXT ;note text
 ;
 ;create the note
 D MAKE^TIUSRVP(.RETSTAT,PATIEN,TITLE,VDATE,VLOC,VISIT,.TIUX,VSTR,SUPPRESS,NOASF)
 I '+RETSTAT S RETSTAT="-1^Error creating note^"_RETSTAT QUIT
 ;
 N FDA
 N IENS S IENS=+RETSTAT_","
 S FDA(8925,IENS,1202)=VPROV
 S FDA(8925,IENS,1204)=VPROV
 S FDA(8925,IENS,1302)=VPROV
 D FILE^DIE("K","FDA","MSG")
 ;
 N NOTEIEN S NOTEIEN=+RETSTAT
 ;
 ;sign the note
 QUIT:$G(ESIG)=""
 N duzsave S duzsave=DUZ
 S DUZ=VPROV
 N RETVAL
 D SIGN^TIUSRVP(.RETVAL,NOTEIEN,$$ENCRYP^XUSRB1(ESIG))
 I +RETVAL S RETSTAT="-1^Error signing note^"_RETVAL
 S DUZ=duzsave
 ;
 QUIT
 ;
