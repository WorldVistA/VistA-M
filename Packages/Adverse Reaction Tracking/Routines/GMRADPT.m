GMRADPT ;HIRMFO/RM,WAA - UTILITY TO GATHER PATIENT DATA ;06/01/2016  12:54
 ;;4.0;Adverse Reaction Tracking;**2,10,46,52**;Mar 29, 1996;Build 7
EN1 ; ENTRY TO GATHER PATIENT A/AR DATA
 ;CONTROLLED BY SUPPORTED INTEGRATION AGREEMENT #10099
 ;*BD
 N GMRAOTH,GMRAV1
 Q:'$D(DFN)
 I '$D(GMRA)#2 S GMRA="0^0^111"
 K GMRAL
 S GMRAV1=1,GMRAOTH=$O(^GMRD(120.83,"B","OTHER REACTION",0))
 D DPT
 Q
 ;*ED
EN2 ; ENTRY TO GATHER PATIENT A/AR DATA
 ;CONTROLLED BY SUPPORTED INTEGRATION AGREEMENT #10099
 ;INPUT VARIABLES:
 ;
 ; DFN             Pointer to Patient file.
 ; GMRA (OPTIONAL) A^B^C^D   DEFAULT="0^0^111^0"
 ;    where  A = 0 return all reactions (allergic/non-allergic).
 ;               1 return allergies only.
 ;               2 return non-allergies only.
 ;           B = 0 return all data (verified or non-verified).
 ;               1 return only verified data.
 ;               2 return only non-verified data.
 ;           C = X_Y_Z
 ;               where X, Y, and Z are either 0 or 1.  1 would mean to
 ;               return an Adverse Reaction of that particular type,
 ;               and zero means do not return an Adverse Reaction of
 ;               that type.
 ;               X is for TYPE=OTHER
 ;               Y is for TYPE=FOOD
 ;               Z is for TYPE=DRUG.
 ;               E.g., 001 (return drug only), 111 (returns all types),
 ;               and 010 (returns food only).
 ;           D = 0 return local allergies only
 ;               1 return local and remote allergies
 ;OUTPUT VARIABLES:
 ; GMRAL = 1 if patient has Adverse Reaction
 ;         0 if patient has no known Adverse Reaction
 ;      null if patient has not been asked about Adverse Reaction
 ; GMRAL(PTR) = A^B^C^D^E^F^G^H^I^J^K
 ;    where PTR = Either pointer to 120.8 for local reactions or 
 ;                'R' appended with pointer to ^XTMP("ORRDI","ART",DFN, for remote reactions
 ;          A = Pointer to Patient file.
 ;          B = Free text of causative agent.
 ;         *C = Type of reaction, where D is drug, F is food, and O is
 ;              other.
 ;          D = 1 if Adverse Reaction has been verified
 ;              0 if Adverse Reaction has not been verified
 ;          E = 0 if this is an allergic reaction
 ;              1 if this is not an allergic reaction
 ;        **F = the mechanism of reaction in the format:
 ;              External format;Internal format
 ;              (ALLERGY;0, PHARMACOLOGIC;2, UNKNOWN;U).
 ;          G = Type of reaction.
 ;              where   D = drug
 ;                     DF = drug/food
 ;                    DFO = drug/food/other
 ;                     DO = drug/other
 ;                      F = food
 ;                     FO = food/other
 ;                      O = other
 ;          H = the mechanism of reaction in the format:
 ;              External format;Internal format
 ;              (ALLERGY;A, PHARMACOLOGIC;P, UNKNOWN;U)
 ;          I = variable pointer to the causative agent returned in piece B
 ;          J = observed/historical of the reaction in the format:
 ;              External format;Internal format
 ; GMRAL(PTR,"S",COUNT) = S^D
 ;    where COUNT = number 1 to number of signs/symptoms for this
 ;                  reaction.
 ;              S = a sign/symptom for this reaction in the format:
 ;                  External format;Internal format
 ;              D = date/time sign/symptom entered in the format:
 ;                  External format;Internal format
 ; GMRAL(PTR,"O",COUNT) = S^D
 ;    where COUNT = number 1 to number of observations for this
 ;                  reaction.
 ;              S = a severity for this reaction in the format:
 ;                  External format;Internal format
 ;              D = date/time of observation in the format:
 ;                  External format;Internal format
 ; GMRAL(PTR,"SITE") = SITE
 ;    where SITE = reporting institution in the format:
 ;                 Institution File (#4) Pointer^Station Name^Station Number
 ;                 Note: This will only exist for remote reactions
 ;
 ;*  NOTE: This piece will no longer be supported after 9/1/97,
 ;         Please use piece G.
 ;** NOTE: This piece will no longer be supported after 9/1/97,
 ;         Please use piece H.
 ;
 ;*BD
 D DPT2
 Q
 ;*ED
DPT ;
 ;*BD
 ;Read NKA Node in file 120.86
 S GMRAL=$P($G(^GMR(120.86,DFN,0)),U,2)
 ;Do not set GMRAL array if patient is unassessed or NKA.
 I GMRAL=0 Q  ;PATIENT HAS NO KNOWN ALLERGIES
 F GMRAREC=0:0 S GMRAREC=$O(^GMR(120.8,"B",DFN,GMRAREC)) Q:GMRAREC'>0  S GMRANODE=$S($D(^GMR(120.8,GMRAREC,0)):^(0),1:"") D:GMRANODE SETAL(0)
 I GMRAL=1,+$O(GMRAL(0))'>0 S GMRAL=0 ;if flag is set to 1 (reactions exist), then make certain the reactions are passed in the GMRAL array
 K GMRA,GMRANODE,GMRAOSOF,GMRAREC,GMRATCNT
 Q
DPT2 ;DO NOT CALL THIS ENTRY POINT AS IT WILL BE DELETED IN THE FUTURE. USE EN2 INSTEAD.
 ;*ED
 N GMRAOTH,REMOTE,MECH,IDX,GMRANODE,GMRAOSOF,GMRAREC,GMRATCNT
 Q:'$D(DFN)
 I '$D(GMRA)#2 S GMRA="0^0^111^0"
 K GMRAL
 S GMRAOTH=$O(^GMRD(120.83,"B","OTHER REACTION",0))
 S REMOTE=$S(+$P(GMRA,U,4):$$HDRDATA^GMRAHDR,1:0)
 S GMRAL=$$NKA^GMRANKA(DFN)
 I +GMRAL=0,$P(GMRA,U,4),($D(^XTMP("ORRDI","ART",DFN,"ASSESSMENT"))>9) D
 .S IDX=0 F  S IDX=$O(^XTMP("ORRDI","ART",DFN,"ASSESSMENT",IDX)) Q:'IDX  D
 ..N RETURN
 ..S RETURN=$$INTERNAL(120.86,1,^XTMP("ORRDI","ART",DFN,"ASSESSMENT",1))
 ..I RETURN=1 S GMRAL=1
 ..I GMRAL'=1,(RETURN=0) S GMRAL=0
 Q:+GMRAL=0
 D MECH
 F GMRAREC=0:0 S GMRAREC=$O(^GMR(120.8,"B",DFN,GMRAREC)) Q:GMRAREC'>0  S GMRANODE=$S($D(^GMR(120.8,GMRAREC,0)):^(0),1:"") D:GMRANODE SETAL(0)
 I +$G(REMOTE)>0 D
 .N INDEX
 .S INDEX=0 F  S INDEX=$O(^XTMP("ORRDI","ART",DFN,INDEX)) Q:+$G(INDEX)=0  D
 ..N GMRANODE,GMRAREC,RETURN
 ..S GMRAREC=$NA(^XTMP("ORRDI","ART",DFN,INDEX))
 ..S RETURN=$$INTERNAL(120.8,17,$G(@GMRAREC@("MECHANISM",0)))
 ..S:RETURN'=-1 $P(GMRANODE,U,14)=RETURN
 ..S RETURN=$$UP^XLFSTR($E($G(@GMRAREC@("VERIFIED",0)),1))
 ..S $P(GMRANODE,U,16)=$S(RETURN="Y":1,RETURN="N":0,1:"")
 ..S $P(GMRANODE,U,20)=$P($G(@GMRAREC@("TYPE",0)),U,1)
 ..D SETAL(1)
 I GMRAL=1,$O(GMRAL(0))="" S GMRAL=0
 K GMRA
 Q
INTERNAL(FILE,FIELD,VALUE) ;RETURN INTERNAL VALUE OF VUID
 ;PARAMETERS: FILE => FILE NUMBER WHERE THE DATA RESIDES
 ;            FIELD => FIELD NUMBER WHERE THE DATA RESIDES
 ;            VALUE => CARET-DELIMITED STRING WHERE THE FIRST
 ;                     PIECE CONTAINS THE VUID
 ;RETURNS: -1 => BAD INPUT PARAMETERS
 ;         INTERNAL VALUE OF VUID
 N RETURN
 S RETURN=-1
 Q:$G(VALUE)="" RETURN
 N GMRARRAY
 D GETIREF^XTID(FILE,,$P(VALUE,U,1),"GMRARRAY")
 S:$D(GMRARRAY(FILE,FIELD))>9 RETURN=$O(GMRARRAY(FILE,FIELD,""))
 Q RETURN
SETAL(REMOTE) ;DETERMINE WHETHER TO RETURN CURRENT ALLERGY
 ;PARAMETER: REMOTE => 0 IF ALLERGY IS LOCAL, 1 IF IT IS REMOTE
 N %,GMRAI,GMRASIGN
 I 'REMOTE,(+$G(^GMR(120.8,GMRAREC,"ER"))) Q  ;IF LOCAL AND ENTERED IN ERROR QUIT (REMOTE ENTERED IN ERROR ALREADY FILTERED)
 I GMRAL'=1 S GMRAL=1 ; PATIENT HAS ALLERGIES
 S GMRAI=0 ; BEGIN CHECK FOR ADR/ALL CRITERIA
 I '$P(GMRA,"^") S GMRAI=1
 E  I $P(GMRA,"^")=1 S:$F("AU",$P(GMRANODE,"^",14))>1 GMRAI=1
 E  S:$F("P",$P(GMRANODE,"^",14))>1 GMRAI=1
 Q:'GMRAI  ; QUIT IF ADR/ALL CRITERIA NOT MET
 Q:2-$P(GMRA,"^",2)=(1-$P(GMRANODE,"^",16))  ;QUIT IF VER/NON VER CRITERIA NOT MET
 S GMRAI=0 ; BEGIN CHECK FOR ALLERGY TYPE CRITERIA
 F %=1:1:3 I $E($P(GMRA,"^",3),%),$P(GMRANODE,"^",20)[$E("OFD",%) S GMRAI=1 Q
 Q:'GMRAI  ; QUIT IF ALLERGY TYPE CRITERIA NOT MET
 D DATA(.GMRAREC,.GMRAL)
 Q
DATA(GMRAREC,GMRAL) ;RETRIEVE THE APPROPRIATE DATA
 ;PARAMETERS: GMRAREC => REFERENCE TO THE VARIABLE CONTAINING THE CURRENT ALLERGY'S IEN
 ;            GMRAL => REFERENCE TO THE ARRAY IN WHICH TO RETURN DATA
 D:+$G(GMRAREC)>0 PASS(.GMRAREC,.GMRAL)
 D:+$G(GMRAREC)=0 REMOTE(.GMRAL,.GMRAREC)
 Q
PASS(GMRAREC,GMRAL) ;RETRIEVE LOCAL DATA
 ;PARAMETERS: GMRAREC => IEN OF THE CURRENT ALLERGY
 ;            GMRAL => ARRAY IN WHICH TO RETURN DATA
 N GMRANODE,%,GMRAX,GMRAY,GMRAZ,GMRAKC
 I '$D(MECH) D
 .D MECH
 .S GMRAKC=1
 S GMRANODE=$G(^GMR(120.8,GMRAREC,0)) Q:GMRANODE=""
 S %=$P(GMRANODE,U,14)
 S GMRAL(GMRAREC)=$P(GMRANODE,U,1,2)_U_$E($P(GMRANODE,U,20))_U_+$P(GMRANODE,U,16)_U_$S(%="A"!(%="U"):0,1:1)
 S GMRAL(GMRAREC)=GMRAL(GMRAREC)_U_$S(%="A":"ALLERGY;0",%="P":"PHARMACOLOGIC;2",%="U":"UNKNOWN;U",1:"")_U_$P(GMRANODE,U,20)_U_$S(%'="":$G(MECH(%)),1:"")
 S GMRAL(GMRAREC)=GMRAL(GMRAREC)_U_$P(GMRANODE,U,3)
 ;*BD
 I '$G(GMRAV1) D
 .;*ED
 .S %=$P(GMRANODE,U,6)
 .S GMRAL(GMRAREC)=GMRAL(GMRAREC)_U_$$EXTERNAL^DILFD(120.8,6,,%)_";"_%
 .I $D(^GMR(120.85,"C",GMRAREC))>9 D
 ..N IEN,IDX
 ..S IEN=0 F  S IEN=$O(^GMR(120.85,"C",GMRAREC,IEN)) Q:'+IEN  D
 ...S IDX=1+$G(IDX),%=$P($G(^GMR(120.85,IEN,0)),U,14)
 ...S GMRAL(GMRAREC,"O",IDX)=$$EXTERNAL^DILFD(120.85,14.5,,%)_";"_%_U
 ...S %=$P($G(^GMR(120.85,IEN,0)),U)
 ...S GMRAL(GMRAREC,"O",IDX)=GMRAL(GMRAREC,"O",IDX)_$$EXTERNAL^DILFD(120.85,.01,,%)_";"_%
 I $O(^GMR(120.8,GMRAREC,10,0)) D
 .S GMRAX=0,GMRAY=1 F  S GMRAX=$O(^GMR(120.8,GMRAREC,10,GMRAX)) Q:GMRAX<1  D
 ..S GMRAZ=$G(^GMR(120.8,GMRAREC,10,GMRAX,0))
 ..Q:GMRAZ=""
 ..S GMRAZ(1)=$S(+GMRAZ'=GMRAOTH:$P($G(^GMRD(120.83,+GMRAZ,0)),U)_";"_+GMRAZ,1:$P(GMRAZ,U,2)_";"_+GMRAZ)
 ..;*BD
 ..I '$G(GMRAV1) D
 ...;*ED (CLEAN UP PERIODS)
 ...S GMRAZ(1)=GMRAZ(1)_U_$$FMTE^XLFDT($P(GMRAZ,U,4))_";"_$P(GMRAZ,U,4)
 ..S GMRAL(GMRAREC,"S",GMRAY)=GMRAZ(1),GMRAY=GMRAY+1
 K:+$G(GMRAKC) MECH
 Q
REMOTE(GMRAL,NODE) ;RETRIEVE REMOTE DATA
 ;PARAMETERS: GMRAL => ARRAY IN WHICH TO RETURN DATA
 ;            NODE => IEN OF THE CURRENT ALLERGY
 S MECH=$P(GMRANODE,U,14)
 ;A, B, & C
 S GMRAL("R"_INDEX)=DFN_U_$G(@NODE@("REACTANT",0))_U_U
 ;D
 S GMRAL("R"_INDEX)=GMRAL("R"_INDEX)_+$P(GMRANODE,U,16)_U
 ;E & F
 S GMRAL("R"_INDEX)=GMRAL("R"_INDEX)_$S(MECH="A"!(MECH="U"):0,1:1)_U_U
 ;G
 S GMRAL("R"_INDEX)=GMRAL("R"_INDEX)_$P(GMRANODE,U,20)_U
 ;H
 S GMRAL("R"_INDEX)=GMRAL("R"_INDEX)_$S(MECH'="":$G(MECH(MECH)),1:"")_U
 ;I
 N VUID,FILE,IEN,GLOBAL,RETURN,ERROR,GMRARRAY
 S VUID=$P($G(@NODE@("GMRALLERGY",0)),U,1)
 S FILE=$P($P($G(@NODE@("GMRALLERGY",0)),U,3),"99VA",2)
 I FILE>0 D
 .D FILE^DID(FILE,,"GLOBAL NAME","RETURN","ERROR")
 .Q:$D(ERROR)
 .D GETIREF^XTID(FILE,,VUID,"GMRARRAY")
 .S IEN=0 F  S IEN=$O(GMRARRAY(FILE,.01,IEN)) Q:+$G(IEN)=0  D
 ..S $P(GMRAL("R"_INDEX),U,9)=+IEN_";"_$P(RETURN("GLOBAL NAME"),U,2)
 S GMRAL("R"_INDEX)=GMRAL("R"_INDEX)_U
 ;J
 N OBSHIS
 I $D(@NODE@("OBS/HISTORICAL"))>9 D
 .N GMRARRAY
 .D GETIREF^XTID(120.8,,$P($G(@NODE@("OBS/HISTORICAL",0)),U,1),"GMRARRAY")
 .S OBSHIS=$O(GMRARRAY(120.8,6,"")),OBSHIS=$$EXTERNAL^DILFD(120.8,6,,OBSHIS)_";"_OBSHIS
 S GMRAL("R"_INDEX)=GMRAL("R"_INDEX)_$G(OBSHIS)
 ;K
 I $D(@NODE@("SEVERITY"))>9 D
 .S GMRAL("R"_INDEX,"O",1)=$P($G(@NODE@("SEVERITY",0)),U,2)_";"_$P($G(@NODE@("SEVERITY",0)),U)_U
 N SINDEX,DATE
 S SINDEX=0 F  S SINDEX=$O(@NODE@("SIGNS/SYMPTOMS",SINDEX)) Q:+$G(SINDEX)=0  D
 .I $P($G(@NODE@("SIGNS/SYMPTOMS",SINDEX)),U,3)="L" D
 ..S GMRAL("R"_INDEX,"S",SINDEX)=$P($G(@NODE@("SIGNS/SYMPTOMS",SINDEX)),U,2)_";"_GMRAOTH
 .I $P($G(@NODE@("SIGNS/SYMPTOMS",SINDEX)),U,3)'="L" D
 ..N GMRARRAY
 ..S VUID=$P($G(@NODE@("SIGNS/SYMPTOMS",SINDEX)),U,1)
 ..S FILE=$P($P($G(@NODE@("SIGNS/SYMPTOMS",SINDEX)),U,3),"99VA",2)
 ..D GETIREF^XTID(FILE,,VUID,"GMRARRAY")
 ..S IEN=0 F  S IEN=$O(GMRARRAY(FILE,.01,IEN)) Q:+$G(IEN)=0  D
 ...S GMRAL("R"_INDEX,"S",SINDEX)=$P($G(@NODE@("SIGNS/SYMPTOMS",SINDEX)),U,2)_";"_+IEN
 .S DATE=$$HL7TFM^XLFDT($G(@NODE@("SIGNS/SYMPTOMS",SINDEX,"DATE_ENTERED",0)))
 .S $P(GMRAL("R"_INDEX,"S",SINDEX),U,2)=$$FMTE^XLFDT(DATE)_";"_DATE
 S GMRAL("R"_INDEX,"SITE")=$G(@NODE@("FACILITY",0))
MECH ;CREATE MECHANISM ARRAY
 S MECH("A")="ALLERGY;A",MECH("P")="PHARMACOLOGIC;P",MECH("U")="UNKNOWN;U"
 Q
