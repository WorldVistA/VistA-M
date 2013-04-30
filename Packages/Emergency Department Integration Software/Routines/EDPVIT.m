EDPVIT ;SLC/MKB -- Vitals utilities ;4/25/12 12:51pm
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
GET(DFN,BEG,END) ; -- Return vitals measurements from BEG to END
 D XML^EDPX("<Vitals dfn="""_$G(DFN)_""" >")
 ;D XML^EDPX("<Vitals>")
 S DFN=+$G(DFN) I DFN<1 D ERR("Missing or invalid patient DFN") D XML^EDPX("</Vitals>") Q
 N LOG,GMRVSTR,IDT,TYPE,IEN,REC,EDPX,LAST,X
 S LOG=+$O(^EDP(230,"APA",DFN,0))
 S:'$G(END) END=9999999 I '$G(BEG) D
 . I LOG S BEG=+$P($G(^EDP(230,LOG,0)),U,8) ;Time In
 . E  S BEG=$$FMADD^XLFDT($$NOW^XLFDT,-1)   ;Last 24 hours
 S GMRVSTR="BP;T;R;P;HT;WT;PN",GMRVSTR(0)=BEG_U_END_"^9999999^1"
 K ^UTILITY($J,"GMRVD") D EN1^GMRVUT0
 ; ^UTILITY($J,"GMRVD",IDT,TYPE,IEN) = $P(^GMR(120.5,IEN,0),U,1,9)_
 ;  ^ Qual1 ^ Qual2 ^ * ^ metric ^ BMI ^ L/Min ^ SuppO2% ^ all qual's
 S IDT="A" F  S IDT=$O(^UTILITY($J,"GMRVD",IDT),-1) Q:IDT<1  D
 . K EDPX S EDPX("time")=9999999-IDT
 . S TYPE="" F  S TYPE=$O(^UTILITY($J,"GMRVD",IDT,TYPE)) Q:TYPE=""  D
 .. S IEN=$O(^UTILITY($J,"GMRVD",IDT,TYPE,0)),REC=$G(^(IEN))
 .. S EDPX(TYPE)=$P(REC,U,8),LAST=9999999-IDT
 . ; EDPX("error")="false" ;for now
 . D XML^EDPX($$XMLA^EDPX("vital",.EDPX))
GETQ ;end
 D XML^EDPX("</Vitals>")
 S X=$G(^EDP(230,LOG,7)) I X D  ;schedule
 . K EDPX S EDPX("frequency")=$P(X,U),EDPX("frequencyUnits")="mins"
 . ;S:$P(X,U,2) EDPX("duration")=$P(X,U,2),EDPX("durationUnits")="mins"
 . S:$G(LAST) EDPX("lastUpdated")=LAST
 . D XML^EDPX($$XMLA^EDPX("schedule",.EDPX))
 Q
 ;
PUT(DFN,DATA) ; -- Save new measurement
 N I,NM,VAL,TIME,LOC,TYPE,X,ERROR
 S DFN=+$G(DFN) I DFN<1 D ERR("Missing or invalid patient DFN") Q
 F I=1:1:$L(DATA,"^") D  ;parse
 . S X=$P(DATA,U,I),NM=$P(X,"="),VAL=$P(X,"=",2)
 . S:$L(NM) DATA($$UP^XLFSTR(NM))=VAL
 S TIME=$G(DATA("TIME")),ERROR=$G(DATA("ERROR"))
 I TIME<1 D ERR("Missing or invalid time") Q
 I ERROR="true" D  G PUTQ
 . ;mark all values at TIME as Entered in Error
 S LOC=$$DFLTLOC^EDPLPCE(DFN)
 I LOC<1 D ERR("Missing default ED Hospital Location") Q
 F TYPE="BP","T","R","P","HT","WT","PN" S X=$G(DATA(TYPE)) I X D
 . N IEN,DATA,EDPY
 . S IEN=+$O(^GMRD(120.51,"C",TYPE,0))
 . S DATA=TIME_U_DFN_U_IEN_";"_X_U_LOC_U_DUZ
 . D EN1^GMVDCSAV(.EDPY,DATA) ;IA #4815
PUTQ ;return new list
 D GET(DFN)
 Q
 ;
ERR(MSG) ; -- Return error node
 I +MSG S MSG=$$MSG^EDPX(MSG)
 N X S X="<error msg='"_MSG_"' />"
 D XML^EDPX(X)
 Q
 ;
LAST(DFN) ; -- Return time that vitals were last taken
 N Y,IDX
 S IDX=$Q(^GMR(120.5,"AA",DFN)),Y=""
 I $P(IDX,",",3)=DFN S Y=9999999-+$P(IDX,",",5)
 Q Y
 ;
 ; -- Worksheet calls:
 ;
READ(CTXT) ; -- return current vitals in XML
 D XML^EDPX("<vitals>")
 N DFN,LOG,BEG,END,GMRVSTR,IDT,TYPE,IEN,REC,EDPX,LAST,X,EDPBMI,Q
 S DFN=+$G(CTXT("dfn")),LOG=+$G(CTXT("log"))
 I DFN<1 D ERR("Missing or invalid patient DFN") G RQ
 S END=9999999 D
 . I LOG S BEG=+$P($G(^EDP(230,LOG,0)),U,8) ;Time In
 . E  S BEG=$$FMADD^XLFDT($$NOW^XLFDT,-1)   ;Last 24 hours
 S GMRVSTR="BP;T;R;P;HT;WT;CVP;CG;PO2;PN",GMRVSTR(0)=BEG_U_END_"^9999999^1"
 K ^UTILITY($J,"GMRVD") D EN1^GMRVUT0
 ; ^UTILITY($J,"GMRVD",IDT,TYPE,IEN) = $P(^GMR(120.5,IEN,0),U,1,9)_
 ;  ^ Qual1 ^ Qual2 ^ * ^ metric ^ BMI ^ L/Min ^ SuppO2% ^ all qual's
 S IDT="A" F  S IDT=$O(^UTILITY($J,"GMRVD",IDT),-1) Q:IDT<1  D
 . D XML^EDPX("<vital>")
 . S LAST=9999999-IDT
 . S TYPE="" F  S TYPE=$O(^UTILITY($J,"GMRVD",IDT,TYPE)) Q:TYPE=""  D
 .. S IEN=$O(^UTILITY($J,"GMRVD",IDT,TYPE,0)),REC=$G(^(IEN)) K EDPX
 .. S EDPX("id")=IEN,EDPX("time")=LAST,EDPX("ussValue")=$P(REC,U,8)
 .. S EDPX("name")=TYPE I TYPE="WT",$P(REC,U,14) S EDPBMI=IEN_U_$P(REC,U,14)
 .. S X=$S(TYPE="T":"F",TYPE="HT":"in",TYPE="WT":"lb",TYPE="CVP":"cmH2O",TYPE="CG":"in",1:"")
 .. S:$L(X) EDPX("ussUnits")=X I $L($P(REC,U,13)) D
 ... S X=$S(TYPE="T":"C",TYPE="HT":"cm",TYPE="WT":"kg",TYPE="CVP":"mmHg",TYPE="CG":"cm",1:"")
 ... S EDPX("metricValue")=$P(REC,U,13) S:$L(X) EDPX("metricUnits")=X
 .. S EDPX("abnormal")=$S($L($P(REC,U,12)):"true",1:"false")
 .. I '$L($P(REC,U,17)) D XML^EDPX($$XMLA^EDPX("vitalMsmt",.EDPX)) Q
 .. ;Qualifiers
 .. D XML^EDPX($$XMLA^EDPX("vitalMsmt",.EDPX,""))
 .. D XML^EDPX("<qualifiers>") S X=$P(REC,U,17)
 .. F I=1:1:$L(X,";") S Q=$P(X,";",I) D XML^EDPX("<qualifier value="""_Q_""" />")
 .. D XML^EDPX("</qualifiers>")
 .. D XML^EDPX("</vitalMsmt>")
 . I $G(EDPBMI) D  K EDPBMI
 .. K EDPX S EDPX("id")=+EDPBMI_"BMI",EDPX("time")=LAST
 .. S EDPX("ussValue")=$P(EDPBMI,U,2),EDPX("name")="BMI"
 .. D XML^EDPX($$XMLA^EDPX("vitalMsmt",.EDPX))
 . D XML^EDPX("</vital>")
RQ ;end
 D XML^EDPX("</vitals>")
 S X=$G(^EDP(230,LOG,7)) I X D  ;schedule
 . K EDPX S EDPX("frequency")=$P(X,U),EDPX("frequencyUnits")="mins"
 . S EDPX("repeatVitals")=$S($P(X,U,2):"true",1:"false")
 . S:$G(LAST) EDPX("lastUpdated")=LAST
 . D XML^EDPX($$XMLA^EDPX("schedule",.EDPX))
 Q
 ;
SAVE(ARRAY) ; -- process incoming Vitals XML array
 N DFN,LOG,ADD,DEL,SCH,EDPI,LOC,TIME,ID,X1,X2
 S DFN=+$G(ARRAY("context",1,"/dfn")) ;?!?
 I DFN<1 D ERR("Missing or invalid patient DFN") Q
 S LOG=+$G(ARRAY("context",1,"/log")) ;?!?
 ; entered in error
 M DEL=ARRAY("removeVitals",1,"vitalMsmt")
 F EDPI=1:1 S ID=$G(DEL(EDPI,"/id")) Q:ID=""  D
 . N DATA,EDPRES S DATA=ID_U_DUZ_U_$G(DEL(EDPI,"/reason"))
 . D ERROR^GMVUTL1(.EDPRES,DATA)
 ; add a new measurement
 M ADD=ARRAY("addVital",1,"vitalMsmt")
 S LOC=$$DFLTLOC^EDPLPCE(DFN),TIME=$$NOW^XLFDT
 I LOC<1 D ERR("Missing default ED Hospital Location") Q
 F EDPI=1:1 S TYPE=$G(ADD(EDPI,"/name")) Q:TYPE=""  D
 . N IEN,DATA,EDPY,X
 . S X=$G(ADD(EDPI,"/value")) Q:'$L(X)
 . ;ck /units, convert if necessary ??
 . S IEN=+$O(^GMRD(120.51,"C",TYPE,0))
 . S DATA=TIME_U_DFN_U_IEN_";"_X_U_LOC_U_DUZ
 . D EN1^GMVDCSAV(.EDPY,DATA) ;IA #4815
 ; save frequency
 M SCH=ARRAY("schedule",1) I $D(SCH),LOG D
 . S X1=+$G(SCH("/frequency")) ;ck units?
 . S X2=$S($G(SCH("/repeatVitals"))="true":1,1:0)
 . S ^EDP(230,LOG,7)=X1_U_X2
 Q
