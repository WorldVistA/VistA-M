HMPCORD5 ;SLC/AGP,ASMR/EJK,RRB - Retrieved Orderable Items;Nov 04, 2015 12:13:23
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; DE2497/RRB - Removed unused variable, HMP777
 Q
 ;
IMMTYPE ;
 N ORWLST,ORDT,HMPIMM
 S (ORWLST,ORDT)=""
 S (HMPCNT,HMPLAST,HMPI)=0
 N IMM
 ;D IMMTYPE^ORWPCE2(.ORWLST,ORDT)   ;use existing broker call ORWPCE GET IMMUNIZATION TYPE
 N IEN,CNT,BINDEX S (IEN,CNT)=0
 S:'$G(ORDT) ORDT=DT
 ; ^AUTTIMM - IMMUNIZATION file #9999999.14, ***DBIA2454 subscription needed***
 F  S IEN=$O(^AUTTIMM(IEN)) Q:IEN=""!(IEN'?1N.N)  D
 . I $D(^AUTTIMM(IEN,0))#2,+$P(^(0),"^",7)=0 S CNT=CNT+1,ORWLST(CNT)=IEN_"^"_$G(^(0))
 . Q
 S IMM="",HMPIMM=""
 F  S IMM=$O(ORWLST(IMM)) Q:IMM=""  D
 . S HMPIMM("localId")=$P(ORWLST(IMM),"^",1)  ;get the ien for each item found
 . S HMPIMM("name")=$P(ORWLST(IMM),"^",2) ;get the name for each item found
 . S HMPIMM("mnemonic")=$P(ORWLST(IMM),"^",3)  ;get the mnemonic for each entry
 . S HMPIMM("uid")=$$SETUID^HMPUTILS("immunization",,HMPIMM("localId"))  ;set the uid string
 . S HMPCNT=HMPCNT+1
 . D ADD^HMPEF("HMPIMM") S HMPLAST=HMPCNT  ;add it to the JSON results array
 . Q
 S HMPFINI=1
 Q
 ;
SIGNS ;
 N IEN,NAME,HMPSS
 S IEN=0,HMPCNT=0,HMPI=0
 F  S IEN=$O(^GMRD(120.83,IEN)) Q:IEN=""!(IEN'?1N.N)  D
 . S NAME=$P($G(^GMRD(120.83,IEN,0)),"^",1)
 . Q:NAME']""
 . S HMPSS("localId")=IEN
 . S HMPSS("name")=NAME
 . S HMPSS("uid")=$$SETUID^HMPUTILS("sign-symptom",,HMPSS("localId"))
 . S HMPCNT=HMPCNT+1
 . D ADD^HMPEF("HMPSS") S HMPLAST=HMPCNT
 . Q
 S HMPFINI=1
 Q
 ;
ALLTYPE ; deprecated
 ;N ORX,ROOT,XP,CNT,ORFILE,ORSRC,ORIEN,ORREAX,ALLCNT,ALLLAST,ALLITEM
 ;S ORIEN=0,CNT=0,ORSRC=0,ORFILE="",ALLCNT=0,ALLLAST=0
 ;S X=""
 ;F ROOT="^GMRD(120.82)","^PSNDF(50.6)","^PSNDF(50.67)","^PSDRUG(""B"")","^PS(50.416)","^PS(50.605)" D
 ;F ROOT="^GMRD(120.82,""B"")","^GMRD(120.82,""D"")","^PSDRUG(""C"")","^PS(50.416,""P"")","^PS(50.605,""C"")",$$B^PSNAPIS,$$T^PSNAPIS,"^PSDRUG(""B"")" D
 ;F ROOT="^GMRD(120.82,""B"")","^PSDRUG(""C"")","^PS(50.416,""P"")","^PS(50.605,""C"")",$$B^PSNAPIS,$$T^PSNAPIS,"^PSDRUG(""B"")" D
 ;. S ORSRC=$G(ORSRC)+1,ORFILE=$P(ROOT,",",1)_")",ORSRC(ORSRC)=$P($T(FILENAME+ORSRC),";;",2)
 ;. I (ORSRC'=2),(ORSRC'=6) S:'$D(Y(ORIEN_";"_ROOT)) CNT=CNT+1,Y(ORIEN_";"_ROOT)=ORSRC_U_ORSRC(ORSRC)_U_U_U_"TOP"_U_"+"
 ;. I ORSRC=1!(ORSRC=2) D
 ;.. F  S X=$O(@ROOT@(X)) Q:X=""  D
 ;... I ORSRC=1,X="OTHER ALLERGY/ADVERSE REACTION" Q  ;don't send this entry
 ;... S ORIEN=$O(@ROOT@(X,0))
 ;... I $L($T(SCREEN^XTID)) I $$SCREEN^XTID(120.82,.01,ORIEN_",") Q  ;233 Is term active?
 ;... I ORSRC=2 S:'$D(Y(ORIEN_";"_ROOT)) CNT=CNT+1,Y(ORIEN_";"_ROOT)=ORIEN_U_$P($G(^GMRD(120.82,+ORIEN,0)),U,1)_" <"_X_">"_ROOT
 ;... I ORSRC'=2  S:'$D(Y(ORIEN_";"_ROOT)) CNT=CNT+1,Y(ORIEN_";"_ROOT)=ORIEN_U_X_ROOT
 ;... S Y(ORIEN_";"_ROOT)=Y(ORIEN_";"_ROOT)_U_$P($G(^GMRD(120.82,+ORIEN,0)),U,2)_U_$S(ORSRC=2:1,1:ORSRC)
 ;.. S XP=X F  S XP=$O(@ROOT@(XP)) Q:XP=""  Q:$E(XP,1,$L(X))'=X  D
 ;... I ORSRC=1,XP="OTHER ALLERGY/ADVERSE REACTION" Q  ;don't send this entry
 ;... S ORIEN=$O(@ROOT@(XP,0))
 ;... I $L($T(SCREEN^XTID)) I $$SCREEN^XTID(120.82,.01,ORIEN_",") Q  ;233 Is term active?
 ;... I ORSRC=2 S:'$D(Y(ORIEN_";"_ROOT)) CNT=CNT+1,Y(ORIEN_";"_ROOT)=ORIEN_U_$P($G(^GMRD(120.82,+ORIEN,0)),U,1)_" <"_XP_">"_ROOT ; partial matches
 ;... I ORSRC'=2  S:'$D(Y(ORIEN_";"_ROOT)) CNT=CNT+1,Y(ORIEN_";"_ROOT)=ORIEN_U_XP_ROOT
 ;... S:'$D(Y(ORIEN_";"_ROOT)) Y(ORIEN_";"_ROOT)=Y(ORIEN_";"_ROOT)_U_$P($G(^GMRD(120.82,+ORIEN,0)),U,2)_U_$S(ORSRC=2:1,1:ORSRC)
 ;.. I (ORSRC>2),(ORSRC'=4),(ORSRC'=5),(ORSRC'=6) D
 ;.. N CODE,LIST,VAL,NAME
 ;.. S CODE=$S(ORSRC=3:"S VAL=$$TGTOG2^PSNAPIS(X,.LIST)",ORSRC=4:"D TRDNAME(X,.LIST)",ORSRC=7:"D INGSRCH(X,.LIST)",ORSRC=8:"D CLASRCH(X,.LIST)",1:"") Q:'$L(CODE)
 ;.. X CODE I $D(LIST) S ORIEN=0 F  S ORIEN=$O(LIST(ORIEN)) Q:'ORIEN  D
 ;... S NAME=$P(LIST(ORIEN),U,2)
 ;... Q:$E($P(LIST(ORIEN),U,2),1,$L(X))'=X
 ;... I $L($T(SCREEN^XTID)) I $$SCREEN^XTID($S(ORSRC=3:50.6,(ORSRC=4):50.6,ORSRC=7:50.416,ORSRC=8:50.605,1:0),.01,ORIEN_",") Q
 ;... S:'$D(Y(ORIEN_";"_ROOT)) CNT=CNT+1,Y(ORIEN_";"_ROOT)=ORIEN_U_NAME_ROOT_U_"D"_U_ORSRC
 ;.. I ORSRC=4 D
 ;.. N CODE,LIST,VAL,NAME
 ;.. S CODE="D TRDNAME(X,.LIST)"
 ;.. X CODE I $D(LIST) S ORIEN=0 F  S ORIEN=$O(LIST(ORIEN)) Q:'ORIEN  D
 ;... S NAME=$P(LIST(ORIEN),U,2)
 ;... Q:$E($P(LIST(ORIEN),U,2),1,$L(X))'=X
 ;... I $L($T(SCREEN^XTID)) I $$SCREEN^XTID(50.6,.01,+LIST(ORIEN)_",") Q
 ;... S:'$D(Y(ORIEN_";"_ROOT)) CNT=CNT+1,Y(ORIEN_";"_ROOT)=+LIST(ORIEN)_U_NAME_ROOT_U_"D"_U_ORSRC
 ;S CNT=""
 ;F  S CNT=$O(Y(CNT)) Q:CNT=""  D
 ;. K ALLERGY
 ;. S ALLITEM=$G(Y(CNT))
 ;. I Y(CNT)["^TOP^+" Q
 ;. I Y(CNT)'["^TOP^+" D
 ;.. S ALLERGY("localId")=$P(ALLITEM,"^",1)
 ;.. S ALLERGY("name")=$P(ALLITEM,"^",2)
 ;.. S ALLERGY("root")=$P(ALLITEM,"^",3)
 ;.. S ALLERGY("uid")=$$SETUID^HMPUTILS("allergy-list",,ALLERGY("localId")_";"_$TR(ALLERGY("root"),"""",""))  ;set the uid string
 ;.. S HMPCNT=$G(HMPCNT)+1 D ADD^HMPEF("ALLERGY") S HMPLAST=HMPCNT
 ;.. Q
 ;. Q
 ;S HMPFINI=1
 ;K X,Y
 Q
 ;
VTYPE ; ;VITALS TYPE
 N IEN
 S (HMPCNT,HMPI,HMPLAST,IEN)=0
 F  S IEN=$O(^GMRD(120.51,IEN)) Q:IEN=""!(IEN'?1N.N)  D
 . S VTYPE("localId")=IEN
 . S VTYPE("name")=$P(^GMRD(120.51,IEN,0),"^",1)
 . S VTYPE("abbreviation")=$P(^GMRD(120.51,IEN,0),"^",2)
 . S VTYPE("rate")=$P(^GMRD(120.51,IEN,0),"^",4)
 . I VTYPE("rate")]"" S VTYPE("rate")=$S(VTYPE("rate")=1:"YES",1:"NO")
 . S VTYPE("pce")=$P(^GMRD(120.51,IEN,0),"^",7)
 . S VTYPE("vuid")="urn:va:vuid:"_$P($G(^GMRD(120.51,IEN,"VUID")),"^",1)
 . S VTYPE("masterVuid")=$P($G(^GMRD(120.51,IEN,"VUID")),"^",2)
 . I VTYPE("masterVuid")]"" S VTYPE("masterVuid")=$S(VTYPE("masterVuid")=1:"YES",1:"NO")
 . S VTYPE("effective")=$P($G(^GMRD(120.51,IEN,"TERMSTATUS",1,0)),"^",1)
 . I VTYPE("effective")]"" S VTYPE("effective")=$$JSONDT^HMPUTILS(VTYPE("effective"))
 . S VTYPE("status")=$P($G(^GMRD(120.51,IEN,"TERMSTATUS",1,0)),"^",2)
 . I VTYPE("status")]"" S VTYPE("status")=$S(VTYPE("status")=1:"ACTIVE",1:"INACTIVE")
 . S VTYPE("uid")=$$SETUID^HMPUTILS("vital-type",,VTYPE("localId"))
 . S HMPCNT=HMPCNT+1 D ADD^HMPEF("VTYPE") S HMPLAST=HMPCNT
 S HMPFINI=1
 K VTYPE
 Q
 ;
VQUAL ; VITALS QUALIFIER
 N IEN,I
 S (HMPCNT,HMPI,HMPLAST,IEN)=0
 F  S IEN=$O(^GMRD(120.52,IEN)) Q:IEN=""!(IEN'?1N.N)  D
 . S VQUAL("localId")=IEN
 . S VQUAL("synonym")=$P(^GMRD(120.52,IEN,0),"^",2)
 . S I=0
 . K VQUAL("vtype") ;ejk - stop bleed over from previous extracts. 
 . F  S I=$O(^GMRD(120.52,IEN,1,I)) Q:I=""!(I'?1N.N)  D
 .. S VQUAL("vtype",I,"vitalType")=$P($G(^GMRD(120.52,IEN,1,I,0)),"^",1)
 .. S VQUAL("vtype",I,"category")=$P($G(^GMRD(120.52,IEN,1,I,0)),"^",2)
 .. ;ejk DE294 - vital type and vital category need to be presented as urn entries and not the name
 .. ;I VQUAL("vtype",I,"vitalType")]"" S VQUAL("vtype",I,"vitalType")=$P($G(^GMRD(120.51,I,0)),"^",1)
 .. ;I VQUAL("vtype",I,"category")]"" S VQUAL("vtype",I,"category")=$P($G(^GMRD(120.53,I,0)),"^",1)
 .. I VQUAL("vtype",I,"vitalType")]"" S VQUAL("vtype",I,"vitalType")=$$SETUID^HMPUTILS("vital-type",,VQUAL("vtype",I,"vitalType"))
 .. I VQUAL("vtype",I,"category")]"" S VQUAL("vtype",I,"category")=$$SETUID^HMPUTILS("vital-category",,VQUAL("vtype",I,"category"))
 .. Q
 . S VQUAL("vuid")="urn:va:vuid:"_$P($G(^GMRD(120.52,IEN,"VUID")),"^",1)
 . S VQUAL("masterVuid")=$P($G(^GMRD(120.52,IEN,"VUID")),"^",2)
 . I VQUAL("masterVuid")]"" S VQUAL("masterVuid")=$S(VQUAL("masterVuid")=1:"YES",1:"NO")
 . S VQUAL("effectiveDate")=$P($G(^GMRD(120.52,IEN,"TERMSTATUS",1,0)),"^",1)
 . I VQUAL("effectiveDate")]"" S VQUAL("effectiveDate")=$$JSONDT^HMPUTILS(VQUAL("effectiveDate"))
 . S VQUAL("status")=$P($G(^GMRD(120.52,IEN,"TERMSTATUS",1,0)),"^",2)
 . I VQUAL("status")]"" S VQUAL("status")=$S(VQUAL("status")=1:"ACTIVE",1:"INACTIVE")
 . S VQUAL("uid")=$$SETUID^HMPUTILS("vital-qualifier",,VQUAL("localId"))
 . S VQUAL("qualifier")=$$SETUID^HMPUTILS("vital-qualifier",,VQUAL("localId"))
 . ;ejk DE295 do not include qualifier if it is the same value as the uid
 . I VQUAL("uid")=VQUAL("qualifier") K VQUAL("qualifier")
 . S HMPCNT=HMPCNT+1 D ADD^HMPEF("VQUAL") S HMPLAST=HMPCNT
 S HMPFINI=1
 K VQUAL
 Q
 ;
VCAT ;VITALS CATAGORY
 N IEN,I
 S (HMPCNT,HMPI,HMPLAST,IEN)=0
 F  S IEN=$O(^GMRD(120.53,IEN)) Q:IEN=""!(IEN'?1N.N)  D
 . S VCAT("localId")=IEN
 . I $P($G(^GMRD(120.53,IEN,0)),"^",1)]"" S VCAT("category")=$P(^GMRD(120.53,IEN,0),"^",1)
 . I $P($G(^GMRD(120.53,IEN,0)),"^",2)]"" S VCAT("synonym")=$P(^GMRD(120.53,IEN,0),"^",2)
 . I $G(VCAT("synonym"))="" K VCAT("synonym")
 . S I=0
 . ;EJK - kill off vtype array to stop inheriting values from previous extracts
 . K VCAT("vtype")
 . F  S I=$O(^GMRD(120.53,IEN,1,I)) Q:I=""!(I'?1N.N)  D
 .. ;ejk DE298 do not send null values. 
 .. I $P($G(^GMRD(120.53,IEN,1,I,0)),"^",1)]"" S VCAT("vtype",I,"vitalType")=$P($G(^GMRD(120.53,IEN,1,I,0)),"^",1)
 .. I VCAT("vtype",I,"vitalType")]"" S VCAT("vtype",I,"vitalType")=$$SETUID^HMPUTILS("vital-type",,VCAT("vtype",I,"vitalType"))
 .. I $P($G(^GMRD(120.53,IEN,1,I,0)),"^",3)]"" S VCAT("vtype",I,"maxEntries")=$P($G(^GMRD(120.53,IEN,1,I,0)),"^",3)
 .. I $P($G(^GMRD(120.53,IEN,1,I,0)),"^",5)]"" S VCAT("vtype",I,"printOrder")=$P($G(^GMRD(120.53,IEN,1,I,0)),"^",5)
 .. I $P($G(^GMRD(120.53,IEN,1,I,0)),"^",6)]"" S VCAT("vtype",I,"editOrder")=$P($G(^GMRD(120.53,IEN,1,I,0)),"^",6)
 .. I $P($G(^GMRD(120.53,IEN,1,I,0)),"^",7)]"" S VCAT("vtype",I,"defaultQualifier")=$P($G(^GMRD(120.53,IEN,1,I,0)),"^",7),VCAT("vtype",I,"defaultQualifier")=$$SETUID^HMPUTILS("vital-qualifier",,VCAT("vtype",I,"defaultQualifier"))
 .. Q
 . S VCAT("vuid")="urn:va:vuid:"_$P($G(^GMRD(120.53,IEN,"VUID")),"^",1)
 . S VCAT("masterVuid")=$P($G(^GMRD(120.53,IEN,"VUID")),"^",2)
 . I VCAT("masterVuid")]"" S VCAT("masterVuid")=$S(VCAT("masterVuid")=1:"YES",1:"NO")
 . S VCAT("effectiveDate")=$P($G(^GMRD(120.53,IEN,"TERMSTATUS",1,0)),"^",1)
 . I VCAT("effectiveDate")]"" S VCAT("effectiveDate")=$$JSONDT^HMPUTILS(VCAT("effectiveDate"))
 . S VCAT("status")=$P($G(^GMRD(120.53,IEN,"TERMSTATUS",1,0)),"^",2)
 . I VCAT("status")]"" S VCAT("status")=$S(VCAT("status")=1:"ACTIVE",1:"INACTIVE")
 . S VCAT("uid")=$$SETUID^HMPUTILS("vital-category",,VCAT("localId"))
 . S HMPCNT=HMPCNT+1 D ADD^HMPEF("VCAT") S HMPLAST=HMPCNT
 . Q
 S HMPFINI=1
 K VCAT
 Q
 ;
INGSRCH(NAME,LIST) ;
 K ^TMP($J,"ORWDAL32")
 D NAME^PSN50P41(NAME,"ORWDAL32")
 I $D(^TMP($J,"ORWDAL32","P")) D
 . N I S I="" F  S I=$O(^TMP($J,"ORWDAL32","P",I)) Q:I=""  D
 .. N J S J=0 F  S J=$O(^TMP($J,"ORWDAL32","P",I,J)) Q:'J  S LIST(J)=J_U_I
 K ^TMP($J,"ORWDAL32")
 Q
CLASRCH(NAME,LIST) ;
 K ^TMP($J,"ORWDAL32")
 D C^PSN50P65(,NAME,"ORWDAL32")
 I $D(^TMP($J,"ORWDAL32","C")) D
 . N I S I="" F  S I=$O(^TMP($J,"ORWDAL32","C",I)) Q:I=""  D
 .. N J S J=0 F  S J=$O(^TMP($J,"ORWDAL32","C",I,J)) Q:'J  S LIST(J)=J_U_$G(^TMP($J,"ORWDAL32",J,1))
 K ^TMP($J,"ORWDAL32")
 Q
TRDNAME(NAME,LIST) ;
 K ^TMP($J,"ORWDAL32")
 D ALL^PSN5067(,NAME,,"ORWDAL32")
 I $D(^TMP($J,"ORWDAL32","B")) D
 . N I S I="" F  S I=$O(^TMP($J,"ORWDAL32","B",I)) Q:I=""  D
 .. N J,K S J=$O(^TMP($J,"ORWDAL32","B",I,0)) Q:'J  S K=$$TGTOG^PSNAPIS(I),LIST(J)=K_U_$G(^TMP($J,"ORWDAL32",J,4))
 K ^TMP($J,"ORWDAL32")
 Q
FILENAME ; Display text of filenames for search treeview
 ;;VA Allergies File
 ;;VA Allergies File (Synonyms)  SPACER ONLY - NOT DISPLAYED
 ;;National Drug File - Generic Drug Name
 ;;National Drug file - Trade Name
 ;;Local Drug File
 ;;Local Drug File (Synonyms)  SPACER ONLY - NOT DISPLAYED
 ;;Drug Ingredients File
 ;;VA Drug Class File
 ;;
