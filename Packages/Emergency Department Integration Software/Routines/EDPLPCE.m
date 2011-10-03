EDPLPCE ;SLC/KCM - Create a Visit
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
UPDVISIT(LOG,PCE) ; Get / Create a Visit
 ; PCE is list of potential updates to the visit
 ; PCE(TYP,n)=type^ien^code^label^add^del^upd^prim^qty
 N DFN,TS,LOC,X0
 S X0=^EDP(230,LOG,0),DFN=$P(X0,U,6),TS=$P(X0,U,8),LOC=$P(X0,U,14)
 I 'LOC S LOC=$$DFLTLOC(DFN)
 I 'DFN!('TS)!('LOC) Q 0  ; not enough info
 ;
 N EDPDATA,EDPVISIT,EDPPCHG
 S EDPVISIT=$P(X0,U,12),EDPPCHG=0 S:'EDPVISIT TS=$$TS4VISIT(DFN,LOC,TS)
 ;
 ; if closed record and no visit, bail
 I $P(X0,U,7),'EDPVISIT Q 0
 ;
 ; if no visit, but diagnoses exist, xfer the diagnoses
 I 'EDPVISIT D XFERDIAG(LOG,.PCE)
 ; remove current primary provider(s) if there is a new one
 I EDPVISIT,$G(PCE("PRI")) D
 . N IPRV,XPRV,OLDPRI
 . K ^TMP("PXKENC",$J)
 . D ENCEVENT^PXAPI(EDPVISIT)
 . S IPRV=0 F  S IPRV=$O(^TMP("PXKENC",$J,EDPVISIT,"PRV",IPRV)) Q:'IPRV  D
 .. S XPRV=^TMP("PXKENC",$J,EDPVISIT,"PRV",IPRV,0)
 .. Q:$P(XPRV,U,4)'="P"
 .. I +XPRV'=$G(PCE("PRI")) S EDPDATA("PROVIDER",IPRV,"NAME")=+XPRV,EDPDATA("PROVIDER",IPRV,"PRIMARY")=0
 ; add any new providers that were entered
 S I=0 F  S I=$O(PCE("PRV",I)) Q:'I  D
 . S EDPDATA("PROVIDER",I,"NAME")=+PCE("PRV",I)
 . I +PCE("PRV",I)=$G(PCE("PRI")) S EDPDATA("PROVIDER",I,"PRIMARY")=1,EDPPCHG=1
 ; update diagnoses
 S I=0 F  S I=$O(PCE("POV",I)) Q:'I  D
 . S X=PCE("POV",I)
 . Q:'($P(X,U,5)!$P(X,U,6)!$P(X,U,7))  ; no updates for this diagnosis
 . I $P(X,U,2) D
 .. N CODE S CODE=$$ICDONE^LEXU($P(X,U,2),TS)
 .. S $P(X,U,3)=CODE
 . Q:'$L($P(X,U,3))                   ; not coded
 . S IEN=+$O(^ICD9("BA",$P(X,U,3)_" ",0)) Q:'IEN
 . S EDPDATA("DX/PL",I,"DIAGNOSIS")=IEN
 . S EDPDATA("DX/PL",I,"NARRATIVE")=$P(X,U,4)
 . I $P(X,U,8) S EDPDATA("DX/PL",I,"PRIMARY")=1
 . I $P(X,U,6) S EDPDATA("DX/PL",I,"DELETE")=1
 ; update procedures
 S I=0 F  S I=$O(PCE("CPT",I)) Q:'I  D
 . S X=PCE("CPT",I)
 . Q:'($P(X,U,5)!$P(X,U,6)!$P(X,U,7))  ; no updates for this procedure
 . I $P(X,U,2) D
 .. N CODE S CODE=$$CPTONE^LEXU($P(X,U,2),TS)
 .. S $P(X,U,3)=CODE
 . Q:'$L($P(X,U,3))                   ; not coded
 . S IEN=+$O(^ICPT("B",$P(X,U,3),0))
 . S EDPDATA("PROCEDURE",I,"PROCEDURE")=IEN
 . S EDPDATA("PROCEDURE",I,"QTY")=$S($P(X,U,9):$P(X,U,9),1:1)
 . S EDPDATA("PROCEDURE",I,"NARRATIVE")=$P(X,U,4)
 . I $P(X,U,6) S EDPDATA("PROCEDURE",I,"DELETE")=1
 ; exit if no updates
 Q:'$D(EDPDATA) 0
 ;
 N EDPKG,EDPSRC,EDPERR,OK
 S EDPKG=$O(^DIC(9.4,"B","EMERGENCY DEPARTMENT",0))
 S EDPSRC="EDP TRACKING LOG"
 S EDPDATA("ENCOUNTER",1,"PATIENT")=DFN
 S EDPDATA("ENCOUNTER",1,"HOS LOC")=LOC
 S EDPDATA("ENCOUNTER",1,"SERVICE CATEGORY")="A"
 S EDPDATA("ENCOUNTER",1,"ENCOUNTER TYPE")="P"
 I 'EDPVISIT S EDPDATA("ENCOUNTER",1,"ENC D/T")=TS
 S OK=$$DATA2PCE^PXAPI("EDPDATA",EDPKG,EDPSRC,.EDPVISIT,,,,EDPPCHG,.EDPERR)
 I OK<1 D
 . N NOW S NOW=$$NOW^XLFDT
 . S ^XTMP("EDPERR-PCE-"_LOG,0)=$$FMADD^XLFDT(NOW,7)_U_NOW_U_"ED PCE Error"
 . S ^XTMP("EDPERR-PCE-"_LOG,"VISIT")=EDPVISIT_U_OK
 . M ^XTMP("EDPERR-PCE-"_LOG,"DATA")=EDPDATA
 . M ^XTMP("EDPERR-PCE-"_LOG,"ERR")=EDPERR
 ;
 ; update the visit pointer in 230
 I EDPVISIT,OK,($P(X0,U,12)'=EDPVISIT) D
 . N FDA,DIERR,ERR
 . S FDA(230,LOG_",",.12)=EDPVISIT
 . D FILE^DIE("","FDA","ERR")
 Q
XFERDIAG(LOG,PCE) ; Setup diagnosis list based on entries in 230
 N IEN,X0,CODE
 K PCE("POV")  ; not worried about adds & subtracts, so start over
 S IEN=0 F  S IEN=$O(^EDP(230,LOG,4,IEN)) Q:'IEN  D
 . S X0=$G(^EDP(230,LOG,4,IEN,0))
 . S PCE("POV",IEN)="POV^^^^1"
 . S CODE=$P(X0,U,2) S:CODE CODE=$P(^ICD9(CODE,0),U)
 . S $P(PCE("POV",IEN),U,3)=CODE        ; code
 . S $P(PCE("POV",IEN),U,4)=$P(X0,U)    ; text
 . S $P(PCE("POV",IEN),U,8)=$P(X0,U,3)  ; primary
 Q
DELVISIT(LOG) ; Delete visit for stub entry
 N EDPVISIT S EDPVISIT=$P(^EDP(230,LOG,0),U,12)
 Q:'EDPVISIT
 ;
 N FDA,DIERR,ERR
 S FDA(230,LOG_",",.12)="@"
 D FILE^DIE("","FDA","ERR")
 ;
 S OK=$$DELVFILE^PXAPI("ALL",EDPVISIT,"EMERGENCY DEPARTMENT","EDP TRACKING LOG")
 Q
DFLTLOC(DFN) ; Return the default location for the ED
 N EDPLST,I,LST,TM,BEG,END,LOCS
 D GETLST^XPAR(.EDPLST,EDPSITE_";DIC(4,","EDPF LOCATION","Q")
 S TM=$E($P($$NOW^XLFDT,".",2)_"0000",1,4)
 ; put time ranges first, then sequence
 S I=0 F  S I=$O(EDPLST(I)) Q:'I  D
 . ; put sequence at end of list
 . I EDPLST(I)'["-" S LST(+EDPLST(I)*1000)=EDPLST(I),LOCS(+$P(EDPLST(I),U,2))="" Q
 . ; put time ranges at top of list
 . S BEG=+$P(EDPLST(I),"-"),END=+$P(EDPLST(I),"-",2)
 . I (TM<BEG)!(TM>END) Q  ; eliminating times that don't include NOW
 . S LST(I)=EDPLST(I),LOCS(+$P(EDPLST(I),U,2))=""
 ;
 ; look for visits to ED locations within the last hour
 N BACKTO,VTM,VLOC,LOC
 S BACKTO=$$FMADD^XLFDT($$NOW^XLFDT,0,-1),LOC=0
 I $G(DFN) D
 . S VTM="" F  S VTM=$O(^AUPNVSIT("AET",DFN,VTM),-1) Q:VTM<BACKTO  D
 .. S VLOC=0 F  S VLOC=$O(^AUPNVSIT("AET",DFN,VTM,VLOC)) Q:'VLOC  D  Q:LOC
 ... I $D(LOCS(VLOC)) S LOC=VLOC
 Q:LOC LOC
 ;
 ; otherwise, return the highest ranked location
 S I=$O(LST(0)) S:I LOC=$P(LST(I),U,2)
 Q LOC
 ;
TS4VISIT(DFN,LOC,TS) ; Return visit time if there is already a visit
 N BACKTO,VTM,VLOC,VCAT,NEWTS
 S BACKTO=$$FMADD^XLFDT($$NOW^XLFDT,0,-1),NEWTS=""
 S VTM="" F  S VTM=$O(^AUPNVSIT("AET",DFN,VTM),-1) Q:VTM<BACKTO  D
 . S VLOC=0 F  S VLOC=$O(^AUPNVSIT("AET",DFN,VTM,VLOC)) Q:'VLOC  Q:VLOC'=LOC  D
 .. S VCAT="" F  S VCAT=$O(^AUPNVSIT("AET",DFN,VTM,VLOC,VCAT)) Q:VCAT'="P"  D
 ... S NEWTS=VTM
 Q:NEWTS NEWTS
 Q TS
 ;
TEST ; Test creation of encounter
 N DFN S DFN=100679
 S LOC=$$GET^XPAR(DUZ(2)_";DIC(4,","EDPF LOCATION")
 ;
 N EDPKG,EDPSRC,OK
 S EDPKG=$O(^DIC(9.4,"B","EMERGENCY DEPARTMENT",0))
 S EDPSRC="EDP TRACKING LOG"
 S EDPDATA("ENCOUNTER",1,"PATIENT")=DFN
 S EDPDATA("ENCOUNTER",1,"HOS LOC")=LOC
 S EDPDATA("ENCOUNTER",1,"SERVICE CATEGORY")="A"
 S EDPDATA("ENCOUNTER",1,"ENCOUNTER TYPE")="P"
 S EDPDATA("ENCOUNTER",1,"ENC D/T")=$$NOW^XLFDT
 ;
 ;S EDPDATA("DX/PL",1,"DIAGNOSIS")=$O(^ICD9("BA","V70.3 ",0))
 ;S EDPDATA("PROCEDURE",1,"PROCEDURE")=$O(^ICPT("B","99201",0))
 S EDPDATA("PROVIDER",1,"NAME")=9066
 ;
 S OK=$$DATA2PCE^PXAPI("EDPDATA",EDPKG,EDPSRC,.EDPVISIT)
 Q
