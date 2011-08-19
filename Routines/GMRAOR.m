GMRAOR ;HIRMFO/WAA,RM-OERR UTILITIES ;4/1/09  13:55
 ;;4.0;Adverse Reaction Tracking;**2,13,26,37,41,42,44**;Mar 29, 1996;Build 1
ORCHK(DFN,TYP,PTR,LOC) ; Given a patient IEN (DFN), this function will
 ; return 1 (true) if the patient has an allergy to an agent defined
 ; by TYP and PTR, else it returns 0 (false). See table below.
 ; The Contrast Media Reaction check will return a null if the patient
 ; is not in the ART database.  Contrast Media checks will also
 ; return whether the check is from local or remote data as the second
 ; piece of the flag if LOC is defined as a positive integer
 ; 
 ;    Contrast Media Reaction:  TYP="CM", PTR (undefined)
 ;              Drug Reaction:  TYP="DR", PTR=IEN in ^PSNDF(.
 ;           Drug Ingredients:  TYP="IN", PTR=IEN in ^PS(50.416,
 ;                 Drug Class:  TYP="CL", PTR=IEN in ^PS(50.605,
 ;
 N GMRAFLG,GMRACM,DA ;37
 S GMRAFLG=0
 I $G(DFN)<1!("^CM^DR^IN^CL^"'[("^"_$G(TYP)_"^"))!($G(TYP)'="CM"&($G(PTR)<1)) S GMRAFLG=""
 E  D
 .D GETDATA(DFN) ;26 Retreive local/remote allergy data for order checking
 .I TYP="CM" S GMRAFLG=$$RAD(DFN)_$S($G(LOC)&($G(GMRACM)'=""):("^"_$G(GMRACM)),1:"") ;37 check for Contrast Media Reaction, return location if requested
 .I TYP="DR" S GMRAFLG=$$DRUG(DFN,PTR) ; check for Drug Reaction
 .I TYP="IN" S GMRAFLG=$$ING(DFN,PTR) ; Check for Drug Ingredients
 .I TYP="CL" S GMRAFLG=$$CLASS(DFN,PTR) ; Check for Drug Class
 .Q
 Q GMRAFLG
RAD(DFN) ; Subroutine checks for Contrast Media Reaction, returns 1 or 0.
 N FLG,DC,LOCAL,REMOTE ;37 entire section added
 S FLG=$P($G(^GMR(120.86,DFN,0)),U,2) S:FLG=1 FLG=0 S DC="DX10" F  S DC=$O(^TMP("GMRAOC",$J,"APC",DC)) Q:DC'["DX10"  D
 .S FLG=1
 .I $G(^TMP("GMRAOC",$J,"APC",DC))["LOCAL" S LOCAL=1
 .I $G(^TMP("GMRAOC",$J,"APC",DC))["REMOTE" S REMOTE=1
 S GMRACM=$S($G(LOCAL)&($G(REMOTE)):"LOCAL AND REMOTE SITE(S)",$G(LOCAL):"LOCAL",$G(REMOTE):"REMOTE SITE(S)",1:"")
 ;D EN1^GMRADPT S FLG=GMRAL
 ;I GMRAL S GMRAPA=0 F  S GMRAPA=$O(GMRAL(GMRAPA)) Q:GMRAPA<1  D  Q:FLG
 ;.S FLG=$$RALLG^GMRARAD(GMRAPA)
 ;.Q
 Q FLG
DRUG(DFN,PTR) ; Subroutine checks for Drug Reaction, returns 1 or 0.
 N %,FLG,GMRAC,GMRADR,GMRAI,PSNVPN,PSNDA S FLG=0
 K GMRAING,GMRADRCL
 S PSNDA=$P(PTR,"."),PSNVPN=$P(PTR,".",2)
 I $G(@($$NDFREF_PSNDA_",0)"))'="" D
 .; Check for rxn to ingredients.
 .; If use the new entry point if there.
 .I $T(DISPDRG^PSNNGR)]"",PSNVPN]"" D
 ..K ^TMP("PSNDD",$J) D DISPDRG^PSNNGR ; get ingredients
 ..S GMRAI=0,%=1 F  S GMRAI=$O(^TMP("PSNDD",$J,GMRAI)) Q:GMRAI<1  I $D(^TMP("GMRAOC",$J,"API",GMRAI)) S FLG=1,GMRAING(%)=^TMP("PSNDD",$J,GMRAI)_$$FAC(^TMP("GMRAOC",$J,"API",GMRAI)),%=%+1 ;26
 ..K ^TMP("PSNDD",$J)
 ..Q
 .E  D  ; get ingredients
 ..K ^TMP("PSN",$J) D ^PSNNGR
 ..S GMRAI=0,%=1 F  S GMRAI=$O(^TMP("PSN",$J,GMRAI)) Q:GMRAI<1  I $D(^TMP("GMRAOC",$J,"API",GMRAI)) S FLG=1,GMRAING(%)=^TMP("PSN",$J,GMRAI)_$$FAC(^TMP("GMRAOC",$J,"API",GMRAI)),%=%+1 ;26
 ..K ^TMP("PSN",$J)
 ..Q
 .Q:FLG  ; Rxn to ingredient, quit now.
 .; Check for rxn to VA Drug Class
 .S PSNDA=$P(PTR,"."),PSNVPN=$P(PTR,".",2)
 .N CLASS
 .I PSNVPN S CLASS=$$DCLCODE^PSNAPIS(PSNDA,PSNVPN) D DRCL(CLASS) Q
 .N CLASS,GMRALIST
 .S GMRALIST=$$CLIST^PSNAPIS(PSNDA,.GMRALIST) Q:'$G(GMRALIST)
 .S GMRALIST=0 F  S GMRALIST=$O(GMRALIST(GMRALIST)) Q:'GMRALIST  D DRCL($P(GMRALIST(GMRALIST),U,2))
 .Q
 Q FLG
FAC(NODE) ;
 N FAC
 S FAC=$S($L(NODE):" ("_NODE_")",1:"")
 Q FAC
DRCL(CODE) ;return any rxn's in GMRADRCL(
 I '$D(^TMP("GMRAOC",$J,"APC",CODE)) Q
 N J S J=$S('$D(GMRADRCL):1,1:$O(GMRADRCL(999),-1)+1)
 ;S GMRADRCL(J)=$$CLASS2^PSNAPIS(CODE)
 N CLSFN
 ;S CLSFN=$P(^PS(50.605,+$O(^PS(50.605,"B",CODE,0)),0),U,2)
 S CLSFN=$$CODE2CL^GMRAPENC(CODE)
 S GMRADRCL(J)=CODE_"^"_CLSFN_$$FAC(^TMP("GMRAOC",$J,"APC",CODE))
 S FLG=2
 Q 
ING(DFN,PTR) ; Subroutine checks for Drug Ingredients, returns:
 ;                  If found FLG= 1 with GMRAIEN Array Drug Ingredients
 ;                 Not found FLG= 0
 N GMRAX K GMRAIEN
 S FLG=0
 S GMRAX=0
 F  S GMRAX=$O(^GMR(120.8,"API",DFN,PTR,GMRAX)) Q:GMRAX<1  S FLG=1,GMRAIEN(GMRAX)=""
 Q FLG
CLASS(DFN,PTR) ; Subroutine checks for Drug Class, returns:
 ;                  If found FLG= 1 with GMRAIEN Array Drug Class
 ;                 Not found FLG= 0
 N GMRAC,GMRAX K GMRAIEN
 ;S GMRAX=0,FLG=0,GMRAC=$P($G(^PS(50.605,PTR,0)),U)
 S GMRAX=0,FLG=0,GMRAC=$$CLP2CODE^GMRAPENC(PTR)
 I GMRAC'="" F  S GMRAX=$O(^GMR(120.8,"APC",DFN,GMRAC,GMRAX)) Q:GMRAX<1  S FLG=1,GMRAIEN(GMRAX)=""
 Q FLG
NDFREF() ;get version dependent NDF reference
 I $$VERSION^XPDUTL("PSN")<4 Q "^PSNDF("
 Q "^PSNDF(50.6," ; new reference for ver 4.0
 ;
GETDATA(DFN) ;Obtain local and HDR related allergy data for use in order checking.  Section added in patch 26
 ;Output from call will be stored in ^TMP as follows:
 ;^TMP("GMRAOC",$J,"API",J)="" where J is the ingredient IEN
 ;^TMP("GMRAOC",$J,"APC",K)="" where K is the drug class classification (e.g. MS105)
 ;
 F  L +^XTMP("GMRAOC",DFN):1 Q:$T
 K ^XTMP("GMRAOC",DFN) 
 D REMOTE(DFN),LOCAL(DFN)
 K ^TMP("GMRAOC",$J)
 M ^TMP("GMRAOC",$J)=^XTMP("GMRAOC",DFN)
 S ^XTMP("GMRAOC",DFN,0)=$$FMADD^XLFDT($$NOW^XLFDT,2)_U_$$NOW^XLFDT ;42
 L -^XTMP("GMRAOC",DFN)
 Q
 ;
LOCAL(DFN) ;
 N J
 S J=0 F  S J=$O(^GMR(120.8,"API",DFN,J)) Q:'+J  S ^XTMP("GMRAOC",DFN,"API",J)=$$SETNODE^GMRAOR1($G(^XTMP("GMRAOC",DFN,"API",J)),"LOCAL")
 S J="" F  S J=$O(^GMR(120.8,"APC",DFN,J)) Q:J=""  S ^XTMP("GMRAOC",DFN,"APC",J)=$$SETNODE^GMRAOR1($G(^XTMP("GMRAOC",DFN,"APC",J)),"LOCAL")
 Q
 ;
REMOTE(DFN) ;
 N J,FLG,REACT,IN,VUID,FILE,GMRARAY,DC,DCLASS,GMRAING,GMRADC,K,INGLST,I,PRIM,IEN
 ;Check for HDR data
 Q:'$L($T(HAVEHDR^ORRDI1))  Q:'$$HAVEHDR^ORRDI1  ;Quit if call doesn't exist or if the HDR isn't available
 Q:'$$GET^ORRDI1(DFN,"ART")  ;Quit if no HDR data for selected patient
 S J=0 F  S J=$O(^XTMP("ORRDI","ART",DFN,J)) Q:'+J  D
 .S FLG=0
 .S REACT=$G(^XTMP("ORRDI","ART",DFN,J,"REACTANT",0)) ;Reaction VUID
 .I $D(^XTMP("ORRDI","ART",DFN,J,"DRUG INGREDIENTS")) D  ;Ingredient data exists
 ..S FLG=1 ;Have ingredient data so REACT is ok
 ..S IN=0 F  S IN=$O(^XTMP("ORRDI","ART",DFN,J,"DRUG INGREDIENTS",IN)) Q:'+IN  D
 ...S VUID=$P(^(IN),U),FILE=$P(^(IN),U,3) ;Naked from above line
 ...S FILE=$P(FILE,"99VA",2)
 ...D GETIREF^XTID(FILE,,VUID,"GMRARAY") ;Get IENs related to VUID
 ...S IEN=0 F  S IEN=$O(GMRARAY(FILE,.01,IEN)) Q:'+IEN  S ^XTMP("GMRAOC",DFN,"API",+IEN)=$$SETNODE^GMRAOR1($G(^XTMP("GMRAOC",DFN,"API",+IEN)),"REMOTE SITE(S)")
 ...K GMRARAY
 .I $D(^XTMP("ORRDI","ART",DFN,J,"DRUG CLASSES")) D  ;Drug class data exists
 ..S FLG=1
 ..S DC=0 F  S DC=$O(^XTMP("ORRDI","ART",DFN,J,"DRUG CLASSES",DC)) Q:'+DC  D
 ...S DCLASS=$P(^(DC),U,2) ;Naked from above, gets drug class (e.g.MS105)
 ...S ^XTMP("GMRAOC",DFN,"APC",DCLASS)=$$SETNODE^GMRAOR1($G(^XTMP("GMRAOC",DFN,"APC",DCLASS)),"REMOTE SITE(S)")
 .D FIND(REACT,.GMRAING,.GMRADC) I $D(GMRAING)!($D(GMRADC)) D
 ..S K=0 F  S K=$O(GMRAING(K)) Q:'+K  S ^XTMP("GMRAOC",DFN,"API",K)=$$SETNODE^GMRAOR1($G(^XTMP("GMRAOC",DFN,"API",K)),"REMOTE SITE(S)")
 ..S K="" F  S K=$O(GMRADC(K)) Q:K=""  S ^XTMP("GMRAOC",DFN,"APC",K)=$$SETNODE^GMRAOR1($G(^XTMP("GMRAOC",DFN,"APC",K)),"REMOTE SITE(S)")
 I $D(^XTMP("GMRAOC",DFN,"API")) D
 .N I,INGLST
 .S I=0 F  S I=$O(^XTMP("GMRAOC",DFN,"API",I)) Q:'I  D
 ..N PRIM
 ..S PRIM=$$PRIMARY(I)
 ..I PRIM S INGLST(PRIM)=^XTMP("GMRAOC",DFN,"API",I) K ^XTMP("GMRAOC",DFN,"API",I)
 .S I=0 F  S I=$O(INGLST(I)) Q:'I  S ^XTMP("GMRAOC",DFN,"API",I)=INGLST(I)
 Q
 ;
FIND(REACT,ING,DC) ;If reactant didn't include drug classes and/or ingredients, try and find them locally.  Section added in patch 26
 N VUID,FILE,PSNDA,GMRAIEN,LIST,GMRAI,GMRALIST,GMRARAY,J,SUB,FLAG
 S FLAG=0
 S VUID=$P(REACT,U)
 S FILE=$P(REACT,U,3)
 S FILE=$P(FILE,"99VA",2)
 D GETIREF^XTID(,,VUID,"GMRARAY")
 S FILE="" F  S FILE=$O(GMRARAY(FILE)) Q:FILE=""  D
 .S GMRAIEN=0 F  S GMRAIEN=$O(GMRARAY(FILE,.01,GMRAIEN)) Q:'+GMRAIEN  D
 ..I FILE=50.6 D
 ...K ^TMP("PSN",$J) S PSNDA=+GMRAIEN D ^PSNNGR
 ...S GMRAI=0 F  S GMRAI=$O(^TMP("PSN",$J,GMRAI)) Q:GMRAI<1  S ING(GMRAI)=""
 ...K ^TMP("PSN",$J),GMRARAY
 ...S PSNDA=+GMRAIEN,GMRALIST=$$CLIST^PSNAPIS(PSNDA,.GMRALIST) Q:'$G(GMRALIST)
 ...S GMRALIST=0 F  S GMRALIST=$O(GMRALIST(GMRALIST)) Q:'GMRALIST  S DC($P(GMRALIST(GMRALIST),U,2))=""
 ..I FILE=120.82 D
 ...S SUB=0 F  S SUB=$O(^GMRD(120.82,+GMRAIEN,"ING",SUB)) Q:'+SUB  S ING(+$P($G(^GMRD(120.82,+GMRAIEN,"ING",SUB,0)),U))="" ;record ingredients
 ...S SUB=0 F  S SUB=$O(^GMRD(120.82,+GMRAIEN,"CLASS",SUB)) Q:'+SUB  S DC($P($$CLASS2^PSNAPIS(+$P($G(^GMRD(120.82,+GMRAIEN,"CLASS",SUB,0)),U)),U))="" ;Get drug classes
 ..I FILE=50.605 D
 ...S DC($P($$CLASS2^PSNAPIS(+GMRAIEN),U))=""
 ..I FILE=50.416 D
 ...S ING(+GMRAIEN)=""
 Q
PRIMARY(INGIEN) ;check if INGIEN is a primary ingredient
 ;returns 0 if INGIEN is primary
 ;returns the IEN of INGIEN's primary ingredient if INGIEN is not primary
 N RETURN
 K ^TMP($J,"GMRALIST")
 D ZERO^PSN50P41(INGIEN,,,"GMRALIST")
 S RETURN=+$G(^TMP($J,"GMRALIST",INGIEN,2))
 Q RETURN
