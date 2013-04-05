EDPYPST ;SLC/KCM - Post init for facility install ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
 D PROXY,CONVERT,FIXSPEC,FIXWAIT,FIXDFLT,AO,CHOICES,DELBRD,FIXAPX,FIXSTA,FIXICD,FIXPDFN
 K ^TMP("EDP-LAST-VERSION")
 Q
 ;
PROXY ; Create proxy user
 Q:$O(^VA(200,"B","EDPTRACKING,PROXY",0))
 N X
 S X=$$CREATE^XUSAP("EDPTRACKING,PROXY","","EDPS BOARD CONTEXT")
 Q
 ;
CONVERT ; set ^XTMP for tracking conversion
 Q:'$D(^DIZ(172006,0))  Q:$G(^XTMP("EDP-CONV"))="DONE"
 I '$D(^XTMP("EDP-CONV")) S ^XTMP("EDP-CONV",0)=$$FMADD^XLFDT(DT,365)_U_DT_"^Copy ED data to EDIS files"
 N I,DIV,X S X=$G(^XTMP("EDP-CONV","X")) ;old format
 S I=0 F  S I=$O(^DIZ(172012,I)) Q:I<1  D
 . S DIV=$$DIV(I) Q:'DIV  Q:$D(^XTMP("EDP-CONV","D",DIV))
 . N X1,X2,X3 S (X2,X3)=0
 . S X1=$S($L(X):"",1:I)
 . S:$P(X,U,2) X2="" I $P(X,U,3) S X2="" D  ;old format - active done
 .. N L S L=$P(X,U,3)+1
 .. F  S L=$O(^DIZ(172006,L),-1) Q:L<1  I +$G(^(L,3))=DIV S X3=L Q
 . S ^XTMP("EDP-CONV","D",DIV)=X1_U_X2_U_X3 ; I^0^0
 Q
DIV(X) ; return file 4 ien for Configuration
 N X0,Y
 S X0=$G(^DIZ(172012,+$G(X),0)),Y=+X0
 I Y<1 S Y=+$S($P(X0,U,2):$P(X0,U,2),1:$$SITE^VASITE)
 Q Y
 ;
FIXSPEC ; add the display properties to existing spec
 I $$VERGTE^EDPYPRE(16) Q  ; only convert if version <16
 ;
 N SPEC
 S SPEC=0 F  S SPEC=$O(^EDPB(231.9,SPEC)) Q:'SPEC  D ADDPROP(SPEC),MOVEBRD(SPEC)
 Q
ADDPROP(SPEC) ; add display properties to spec
 N I,X,WP,ORIG,SKIP,DIERR
 S SKIP=0
 S I=0 F  S I=$O(^EDPB(231.9,SPEC,2,I)) Q:'I  D
 . S ORIG(I)=^EDPB(231.9,SPEC,2,I,0)
 . I ORIG(I)["displayProperties" S SKIP=1
 Q:SKIP
 ;
 N LN S LN=0
 S I=0 F  S I=$O(ORIG(I)) Q:'I  D
 . S LN=LN+1 S WP(LN)=ORIG(I)
 . I ORIG(I)["<spec>" S LN=LN+1,WP(LN)=$P($T(DP+1),";",3,99)
 D WP^DIE(231.9,SPEC_",",2,"","WP")
 D CLEAN^DILF
 Q
MOVEBRD(AREA) ; move the display board spec into a multiple
 I $P($G(^EDPB(231.9,AREA,4,0)),U,4) Q  ; already entries in the multiple
 I '$O(^EDPB(231.9,AREA,2,0)) Q         ; no spec to move
 ;
 N I,X0,WP,MSG
 S I=0 F  S I=$O(^EDPB(231.9,AREA,2,I)) Q:'I  D
 . S X0=^EDPB(231.9,AREA,2,I,0)
 . Q:X0="<spec>"  Q:X0="</spec>"
 . S WP(I)=X0
 D UPDBRD^EDPBCF(AREA,0,"Main (default)",.WP,.MSG)
 Q
DP ; default display properties
 ;;<displayProperties fontSize="10" displayWidth="1024" displayLabel="1024x768" scrollDelay="7" />
 ;
FIXWAIT ; change the category of waiting room to "waiting"
 I $$VERGTE^EDPYPRE(14) Q  ; only convert if version <14
 ;
 N IEN
 S IEN=0 F  S IEN=$O(^EDPB(231.8,"B","Waiting",IEN)) Q:'IEN  D
 . S $P(^EDPB(231.8,IEN,0),U,9)=2
 Q
FIXDFLT ; create initial default rooms
 N AREA,X1,AMB,DFLT,STN
 S AREA=0 F  S AREA=$O(^EDPB(231.9,AREA)) Q:'AREA  D
 . S X1=$G(^EDPB(231.9,AREA,1)),AMB=$P(X1,U,11),DFLT=$P(X1,U,12)
 . S STN=$P(^EDPB(231.9,AREA,0),U,2)
 . I 'AMB D
 . . S AMB=$O(^EDPB(231.8,"AC",STN,AREA,"AMBU",0))
 . . S:AMB $P(^EDPB(231.9,AREA,1),U,11)=AMB
 . I 'DFLT D
 . . S DFLT=$O(^EDPB(231.8,"AC",STN,AREA,"WAIT",0))
 . . S $P(^EDPB(231.9,AREA,1),U,12)=DFLT
 Q
 ;
DELBRD ; delete the DD and data for the old display board spec
 I $$VERGTE^EDPYPRE(20) Q  ; only convert if version <20
 ;
 I $$GET1^DID(231.9,2,,"TYPE")'="WORD-PROCESSING" Q
 N DIU
 S DIU=231.92,DIU(0)="SD"
 D EN^DIU2
 Q
AO ; build AO index on #230
 Q:$D(^EDP(230,"AO"))
 N LOG,IEN,ORD
 S LOG=0 F  S LOG=+$O(^EDP(230,LOG)) Q:LOG<1  D
 . S IEN=0 F  S IEN=+$O(^EDP(230,LOG,8,IEN)) Q:IEN<1  S ORD=+$G(^(IEN,0)) D
 .. S:ORD ^EDP(230,"AO",ORD,LOG,IEN)=""
 Q
CHOICES ; initialize choices timestamps
 N AREA
 S AREA=0 F  S AREA=$O(^EDPB(231.9,AREA)) Q:'AREA  S ^EDPB(231.9,AREA,231)=$H
 Q
FIXNV ; convert the "no value" codes to 0
 Q  ; maybe do this later....
 N NOVAL,LOG
 S NOVAL=+$O(^EDPB(233.1,"B","edp.reserved.novalue",0))
 Q:'NOVAL
 S LOG=0 F  S LOG=$O(^EDP(230,LOG)) Q:'LOG  D
 . D CHGNV(230,LOG,0,10)
 . D CHGNV(230,LOG,1,2)
 . D CHGNV(230,LOG,1,5)
 . D CHGNV(230,LOG,3,2)
 . D CHGNV(230,LOG,3,3)
 S LOG=0 F  S LOG=$O(^EDP(230.1,LOG)) Q:'LOG  D
 . D CHGNV(230.1,LOG,0,10)
 . D CHGNV(230.1,LOG,0,11)
 . D CHGNV(230.1,LOG,0,12)
 . D CHGNV(230.1,LOG,3,2)
 . D CHGNV(230.1,LOG,3,3)
 Q
CHGNV(FN,LOG,SUB,P) ; convert individual piece, expects NOVAL defined
 Q  ; maybe do this later....
 I $P($G(^EDP(FN,LOG,SUB)),U,P)=NOVAL S $P(^EDP(FN,LOG,SUB),U,P)=0
 Q
FIXAPX ; fix the AP xref in 230
 I $$VERGTE^EDPYPRE(21) Q  ; only convert if version <21
 ;
 K ^EDP(230,"AP")
 N DIK,DA
 S DIK="^EDP(230,",DIK(1)=".06^AP"
 D ENALL^DIK
 Q
FIXPDFN ; create the DFN xref in 230
 I $$VERGTE^EDPYPRE(24) Q  ; only convert if last version <24
 ;
 K ^EDP(230,"PDFN")
 N DIK,DA
 S DIK="^EDP(230,",DIK(1)=".06^PDFN"
 D ENALL^DIK
 Q
FIXSTA ; convert the station number field to an institution pointer
 I $$VERGTE^EDPYPRE(22) Q  ; only convert if version <22
 ;
 N IEN
 S IEN=0 F  S IEN=$O(^EDP(230,IEN)) Q:'IEN  D CHGSTA(230,IEN)
 S IEN=0 F  S IEN=$O(^EDPB(231.7,IEN)) Q:'IEN  D CHGSTA(231.7,IEN)
 S IEN=0 F  S IEN=$O(^EDPB(231.8,IEN)) Q:'IEN  D CHGSTA(231.8,IEN)
 S IEN=0 F  S IEN=$O(^EDPB(231.9,IEN)) Q:'IEN  D CHGSTA(231.9,IEN)
 D CLEAN^DILF
 Q
CHGSTA(EDPFILE,EDPIEN) ; convert station number to institution pointer withing file
 N STA,INST
 S STA=$P($S(EDPFILE<231:^EDP(EDPFILE,EDPIEN,0),1:^EDPB(EDPFILE,EDPIEN,0)),U,2)
 S INST=$$IEN^XUAF4(STA)
 ;
 N FDA,DIERR,ERR
 S FDA(EDPFILE,EDPIEN_",",.02)=INST
 D FILE^DIE("","FDA","ERR")
 I $D(DIERR) W !,"STA Error, File=",EDPFILE,"  IEN=",EDPIEN,"  STA=",STN,"  INST=",INST
 Q
FIXICD ; convert the ICD Code file to a pointer to the ICD file
 I $$VERGTE^EDPYPRE(22) Q  ; only convert if version <22
 ;
 N LOG,IEN
 S LOG=0 F  S LOG=$O(^EDP(230,LOG)) Q:'LOG  D
 . S IEN=0 F  S IEN=$O(^EDP(230,LOG,4,IEN)) Q:'IEN  D CHGICD(LOG,IEN)
 D CLEAN^DILF
 Q
CHGICD(LOG,IEN) ; convert individual ICD Code to ICD Pointer
 N ICDCODE,ICDIEN
 S ICDCODE=$P($P(^EDP(230,LOG,4,IEN,0),U,2),"/",1)
 Q:'$L(ICDCODE)
 S ICDIEN=+$O(^ICD9("BA",ICDCODE_" ",0))
 ;
 N FDA,DIERR,ERR
 S FDA(230.04,IEN_","_LOG_",",.02)=ICDIEN
 D FILE^DIE("","FDA","ERR")
 I $D(DIERR) W !,"STA Error, File=",EDPFILE,"  IEN=",EDPIEN,"  STA=",STN,"  INST=",INST
 Q
