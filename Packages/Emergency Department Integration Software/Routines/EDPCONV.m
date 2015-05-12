EDPCONV ;SLC/MKB - Process incoming mail to convert local ED Visits ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;**2**;Feb 24, 2012;Build 23
 ;
AREA(DIV) ; -- Return #231.9 ien for DIVision (#4 ien)
 Q +$O(^EDPB(231.9,"C",DIV,0))
 ;
VST(OLD) ; -- Copy OLD(node) ER visit entry into ^EDP(230)
 N X,I,EDPY,EDPSITE,EDPDIFF,EDPAREA,EDPSTA,EDPLOG,EDPI,PNM,SSN
 S EDPSITE=$G(OLD("SITE")),X=$G(OLD("TZ")),EDPDIFF=0 ;$$TZONE(X)
 S EDPAREA=$$AREA(EDPSITE) Q:EDPAREA<1
 S EDPSTA=$$STA^XUAF4(EDPSITE)            ;station number
 F I=0,1,2,3,4,6,9 S OLD(I)=$G(OLD(I))    ;defined
 S X=$P(OLD(0),U,5),EDPY=$$NEW(230,X) Q:EDPY<1
 S PNM=$P(OLD(0),U),SSN=$P(OLD(0),U,3)    ;patient name, ssn
 S EDPLOG(0)=X_U_EDPSITE_U_EDPAREA_U_PNM_U_SSN_U_$P(OLD(6),U,2)_U_$G(OLD("CLOSED"))_U_$P(OLD(4),U,4,5)_U_$$ARR($P(OLD(0),U,6))_U_$$PID(PNM,SSN) ;_U_EDPDIFF
 S X=$P(OLD(9),U,3) S:'X X=$P(OLD(6),U,3) ;disposition
 S EDPLOG(1)=$P(OLD(1),U)_U_$$DISP(X)_U_$P(OLD(9),U,2)_U_$P(OLD(9),U)_U_$$DEL($P(OLD(4),U,7))
 S X=$P(OLD(2),U) S:$L(X) EDPLOG(2)=X
 S EDPLOG(3)=U_$$STS($P(OLD(0),U,4))_U_$$ACU($P(OLD(4),U,3))_U_$$LOC($P(OLD(3),U,2))_U_$P(OLD(4),U)_U_$P(OLD(4),U,2)_U_$P(OLD(4),U,6)_U_$P(OLD(6),U)
 I $D(OLD(8)) M EDPLOG(4)=OLD(8) S $P(EDPLOG(4,0),U,2)="230.04A" D
 . S EDPI=0 F  S EDPI=$O(EDPLOG(4,EDPI)) Q:EDPI<1  D
 .. S X=$P($G(EDPLOG(4,EDPI,0)),U,2) Q:'$L(X)  ;code -> ien
 .. I X?1"ICD-9-CODE-".E S X=$P(X,"-",4)
 .. I X["/" S X=$P(X,"/")
 .. ;Begin EDP*2.0*2 CHANGES.
 .. S X=$$ICDDX^EDPLEX(X,$P($G(^EDP(230,EDPY,0),2781001),U,8)),$P(EDPLOG(4,EDPI,0),U,2)=$S(X>0:+X,1:"")
 .. ;End EDP*2.0*2 CHANGES.
 ; Save/Xref log entry
 M ^EDP(230,EDPY)=EDPLOG
 D XREF(230,EDPY)
 ;
 ; Set History from Movement nodes
 S EDPI="MVT" F  S EDPI=$O(OLD(EDPI)) Q:EDPI'?1"MVT"1.N  D HIST(EDPI,EDPY)
 ;
 ; Create Orders list for active visits
 I '$G(OLD("CLOSED")) S X=EDPLOG(0) D ORDERS(EDPY,X)
 ;
 S OLD(230)=EDPY ;return new ien
 Q
 ;
HIST(MVTI,LOG) ; -- Copy OLD(MVTI) into ^EDP(230.1)
 N EDPY,MVT,ACT
 S EDPY=$$NEW(230.1,LOG) Q:EDPY<1
 S MVT=OLD(MVTI)
 S ACT(0)=LOG_U_$P(MVT,U,2)_U_U_$P($G(^EDP(230,LOG,0)),U,4,6)
 S ACT(3)=U_$$STS($P(MVT,U,3))_U_$$ACU($P(MVT,U,4))_U_$$LOC($P(MVT,U,5))_U_$P(MVT,U,6,8)
 ; Save/Xref history
 M ^EDP(230.1,EDPY)=ACT
 D XREF(230.1,EDPY)
 Q
 ;
NEW(FILE,X) ; -- Return ien of new entry in FILE
 N DO,DIC,DA,Y
 S DIC="^EDP("_FILE_",",DIC(0)="LF" D FILE^DICN
 Q +Y
 ;
XREF(FILE,DA) ; -- Set all xrefs for DA in FILE
 N DIK
 S DIK="^EDP("_FILE_"," D IX1^DIK
 Q
 ;
PID(NM,ID) ; -- Return brief id (L0000) for patient
 N Y S Y=$E(NM)_$E(ID,6,9)
 Q Y
 ;
TZONE(X) ; -- Return #minutes local offset for time zone
 N Y S Y=$E(X)_(60*$E(X,2,3)+$E(X,4,5))
 Q Y
 ;
ACU(X) ; -- Return[/add] #233.1 ien for Acuity X
 I $G(X)="" Q ""
 N Y,NODE S NODE=$G(OLD("ACU"_+X)) Q:NODE="" $$NOVALUE
 S X=$P(NODE,U,2),Y=""
 S:$L(X) Y=+$O(^EDPB(233.1,"AB","acuity",X,0)) Q:Y Y
 ; add local item
 N FDA,FDAIEN,DIERR,ERR,NM
 S NM=$P(NODE,U),NM=$S(NM["-":$P(NM,"-",2),1:NM)
 S FDA(233.1,"+1,",.01)=EDPSTA_".acuity."_$$LOW^XLFSTR(NM)
 S FDA(233.1,"+1,",.02)=X
 S FDA(233.1,"+1,",.03)=X
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 S Y=$S('$D(DIERR):+$G(FDAIEN(1)),1:"")
 Q Y
 ;
STS(X) ; -- Return[/add] #233.1 ien for Status X
 I $G(X)="" Q ""
 N Y,NODE
 S NODE=$G(OLD("STS"_+X)),Y="" Q:NODE="" $$NOVALUE
 S X=$P(NODE,U,1) S:$L(X) Y=+$O(^EDPB(233.1,"AC","status",X,0)) Q:Y Y
 S X=$P(NODE,U,4) S:$L(X) Y=+$O(^EDPB(233.1,"AB","status",X,0)) Q:Y Y
 ; add local item
 N FDA,FDAIEN,DIERR,ERR
 S FDA(233.1,"+1,",.01)=EDPSTA_".status."_$$LOW^XLFSTR(X)
 S FDA(233.1,"+1,",.02)=$P(NODE,U)           ;text
 S FDA(233.1,"+1,",.03)=X                    ;display/abbreviation
 S:$P(NODE,U,6)="Y" FDA(233.1,"+1,",.05)="A" ;admission flag
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 S Y=$S('$D(DIERR):+$G(FDAIEN(1)),1:"")
 Q Y
 ;
DEL(X) ; -- Return[/add] #233.1 ien for Delay Reason X
 I $G(X)="" Q ""
 N Y,NODE
 S NODE=$G(OLD("DEL"_+X)),Y="" Q:NODE="" $$NOVALUE
 S X=$P(NODE,U,1) S:$L(X) Y=+$O(^EDPB(233.1,"AC","delay",X,0)) Q:Y Y
 S X=$P(NODE,U,3) S:$L(X) Y=+$O(^EDPB(233.1,"AB","delay",X,0)) Q:Y Y
 ; add local item
 N FDA,FDAIEN,DIERR,ERR
 S FDA(233.1,"+1,",.01)=EDPSTA_".delay."_$$LOW^XLFSTR(X)
 S FDA(233.1,"+1,",.02)=$P(NODE,U)     ;name
 S FDA(233.1,"+1,",.03)=$P(NODE,U,3)   ;abbreviation
 S FDA(233.1,"+1,",.05)=$P(NODE,U,5)   ;report flag
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 S Y=$S('$D(DIERR):+$G(FDAIEN(1)),1:"")
 Q Y
 ;
ARR(X) ; -- Return[/add] #233.1 ien for Arrival Mode X
 I $G(X)="" Q ""
 N Y,NODE
 S NODE=$G(OLD("ARR"_+X)),Y="" Q:NODE="" $$NOVALUE
 S X=$P($P(NODE,U)," ") S:$L(X) Y=+$O(^EDPB(233.1,"AC","source",X,0)) Q:Y Y
 ; add local item
 N FDA,FDAIEN,DIERR,ERR
 S FDA(233.1,"+1,",.01)=EDPSTA_".source."_$$LOW^XLFSTR(X)
 S FDA(233.1,"+1,",.02)=X
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 S Y=$S('$D(DIERR):+$G(FDAIEN(1)),1:"")
 Q Y
 ;
DISP(X) ; -- Return[/add] #233.1 ien for Disposition code X
 I $G(X)="" Q ""
 N Y,NODE
 S NODE=$G(OLD("DIS"_X)),Y="" Q:NODE="" $$NOVALUE
 S:X X=$P(NODE,U,5) ;ien -> abbreviation
 I $L(X) S Y=+$O(^EDPB(233.1,"AB","disposition",X,0)) Q:Y Y
 E  S X=$P(NODE,U) S:$L(X) Y=+$O(^EDPB(233.1,"AC","disposition",X,0)) Q:Y Y
 ; add local item
 N FDA,FDAIEN,DIERR,ERR
 S X=$P($P(NODE,U)," ") ;1st word, for name
 S FDA(233.1,"+1,",.01)=EDPSTA_".disposition."_$$LOW^XLFSTR(X)
 S FDA(233.1,"+1,",.02)=$P(NODE,U)        ;Display Name
 S FDA(233.1,"+1,",.03)=$P(NODE,U,5)      ;Abbreviation
 S:$P(NODE,U,7) FDA(233.1,"+1,",.05)="M"  ;Missed Opportunity
 S:$P(NODE,U,6) FDA(233.1,"+1,",.05)="A"  ;Admission
 S:$P(NODE,U,8) FDA(233.1,"+1,",.05)="VA" ;VA Admission
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 S Y=$S('$D(DIERR):+$G(FDAIEN(1)),1:"")
 Q Y
 ;
LOC(X) ; -- Return[/add] #231.8 ien for Location X
 I $G(X)="" Q ""
 N Y,NODE
 S NODE=$G(OLD("LOC"_+X)) S:NODE="" NODE="UNKNOWN^UNK^^0^^^0"
 S X=$P(NODE,U,2),Y=""
 S:$L(X) Y=+$O(^EDPB(231.8,"AC",EDPSITE,EDPAREA,X,0)) Q:Y Y
 ; add local item
 N FDA,FDAIEN,DIERR,ERR,X
 S FDA(231.8,"+1,",.01)=$TR($P(NODE,U),"-") ;Name
 S FDA(231.8,"+1,",.02)=EDPSITE             ;Institution ien
 S FDA(231.8,"+1,",.03)=EDPAREA             ;Area ien
 S FDA(231.8,"+1,",.04)='$P(NODE,U,4)       ;Inactive
 S FDA(231.8,"+1,",.05)=$P(NODE,U,6)        ;Sequence
 S FDA(231.8,"+1,",.06)=$P(NODE,U,2)        ;Display Name
 S X=$P(NODE,U,7),X=$S(X=2:0,X=0:2,1:1)
 S FDA(231.8,"+1,",.07)=X                   ;Display When
 S FDA(231.8,"+1,",.08)=$$STS($P(NODE,U,8)) ;Default Status ien
 S FDA(231.8,"+1,",.1)=$P(NODE,U,9)         ;Shared Name [Room]
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 S Y=$S('$D(DIERR):+$G(FDAIEN(1)),1:"")
LCQ ;exit
 Q Y
 ;
NOVALUE() Q $O(^EDPB(233.1,"B","edp.reserved.novalue",0))
 ;
ORDERS(LOG,NODE) ; -- build Orders multiple
 N ORLIST,DFN,IN,OUT,ORI,ORIFN,STS,REL,PKG,X,Y,DIC,DA
 S DFN=+$P(NODE,U,6) Q:DFN<1
 S IN=$P(NODE,U,8) Q:IN<1  Q:IN<$$FMADD^XLFDT(DT,-1)  ;old
 S OUT=$P(NODE,U,9) S:OUT<1 OUT=$$NOW^XLFDT
 K ^TMP("ORR",$J) D EN^ORQ1(DFN_";DPT(",,1,,IN,OUT) S ORI=0
 F  S ORI=$O(^TMP("ORR",$J,ORLIST,ORI)) Q:ORI<1  S ORIFN=+$G(^(ORI)) D
 . Q:$O(^EDP(230,LOG,8,"B",ORIFN,0))
 . S X=$$GET1^DIQ(100,ORIFN_",",5,"I") Q:(X=10)!(X=11)  ;unreleased
 . S STS=$S("^1^2^7^12^13^14^"[(U_X_U):"C","^3^6^9^15^"[(U_X_U):"A",1:"N")
 . S REL=$$GET1^DIQ(100.008,"1,"_ORIFN_",",16,"I")
 . S X=$$GET1^DIQ(100,ORIFN_",","12:1")
 . S PKG=$S($E(X,1,2)="LR":"L",$E(X,1,2)="PS":"M",$E(X,1,2)="RA":"R",X="GMRC":"C",1:"A")
 . ; add to subfile
 . K X,Y,DIC,DA
 . S DIC="^EDP(230,"_LOG_",8,",DIC(0)="LZ",DA(1)=LOG,X=+ORIFN
 . S DIC("DR")=".02///"_PKG_";.03///"_STS_";.05///"_REL
 . ;S:$$VAL("stat") DIC("DR")=DIC("DR")_";.04///1"
 . D FILE^DICN
 K ^TMP("ORR",$J,ORLIST)
 Q
 ;
 ; ------- fix ICD9 Code field -------
 ;
ICD ; -- convert ICD codes to #80 iens
 N EDP1,EDP2,X0,X,Y
 S EDP1=0 F  S EDP1=$O(^EDP(230,EDP1)) Q:EDP1<1  I $D(^(EDP1,4)) D
 . S EDP2=0 F  S EDP2=$O(^EDP(230,EDP1,4,EDP2)) Q:EDP2<1  S X0=$G(^(EDP2,0)) D
 .. S X=$P(X0,U,2) Q:'$L(X)
 .. I X?1"ICD-9-CODE-".E S X=$P(X,"-",4)
 .. I X["/" S X=$P(X,"/")
 .. S Y=$$ICDDX^ICDCODE(X)
 .. I Y>0 S $P(^EDP(230,EDP1,4,EDP2,0),U,2)=+Y
 Q
 ;
SHOWICD(BEG,END) ; -- show Dx nodes from BEG to END
 N IEN,DA,X0,X
 S BEG=$G(BEG,0),END=$G(END,9999999)
 S IEN=BEG F  S IEN=$O(^EDP(230,IEN)) Q:(IEN<1)!(IEN>END)  I $D(^(IEN,4)) D
 . S DA=0 F  S DA=$O(^EDP(230,IEN,4,DA)) Q:DA<1  S X0=$G(^(DA,0)) D
 .. S X=$P(X0,U,2) Q:X=""  ;show any non-ien value
 .. I $S(X<0:1,+X'=X:1,X[".":1,1:0) W !,IEN,?10,DA,?15,X0
 Q
 ;
 ; ------ fix Tracking Room-Bed file #231.8 ------
 ;
MARK(STN) ; -- mark duplicate locations with correct ien,
 ;             for repointing from STN to Institution ien set
 N AREA,NM,IEN,LOC
 S AREA=+$O(^EDPB(231.8,"AC",STN,0))
 S NM="" F  S NM=$O(^EDPB(231.8,"AC",STN,AREA,NM)) Q:NM=""  D
 . S LOC=+$O(^EDPB(231.8,"AC",STN,AREA,NM,0))  ;keep 1st, or
 . I $G(^EDPB(231.8,LOC,"FIX")) S LOC=^("FIX") ;manually set to desired
 . S IEN=LOC F  S IEN=+$O(^EDPB(231.8,"AC",STN,AREA,NM,IEN)) Q:IEN<1  S ^EDPB(231.8,IEN,"FIX")=LOC
 Q
 ;
LOOP ; -- loop through Log,History files and repoint if FIX node exists
 N FILE,IEN,LOC,FIX
 F FILE=230,230.1 D
 . S IEN=0 F  S IEN=$O(^EDP(FILE,IEN)) Q:IEN<1  S LOC=$P($G(^(IEN,3)),U,4) I LOC D
 .. S FIX=+$G(^EDPB(231.8,LOC,"FIX"))
 .. I FIX S $P(^EDP(FILE,IEN,3),U,4)=FIX
 Q
 ;
DIK ; -- remove duplicate entries from #231.8
 N IEN,DA,DIK
 S IEN=0 F  S IEN=$O(^EDPB(231.8,IEN)) Q:IEN<1  I $G(^(IEN,"FIX")) D
 . S DA=IEN,DIK="^EDPB(231.8," D ^DIK
 Q
