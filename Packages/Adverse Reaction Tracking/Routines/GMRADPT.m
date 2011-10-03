GMRADPT ;HIRMFO/RM,WAA-UTILITY TO GATHER PATIENT DATA ;1/15/98  13:47
 ;;4.0;Adverse Reaction Tracking;**2,10**;Mar 29, 1996
EN1 ; ENTRY TO GATHER PATIENT A/AR DATA
 ;INPUT VARIABLES:
 ;
 ; DFN             Pointer to Patient file.
 ; GMRA (OPTIONAL) A^B^C   DEFAULT="0^0^111"
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
 ;OUTPUT VARIABLES:
 ; GMRAL = 1 if patient has Adverse Reaction
 ;         0 if patient has no known Adverse Reaction
 ;      null if patient has not been asked about Adverse Reaction
 ; GMRAL(PTR TO 120.8) = A^B^C^D^E^F^G^H^I
 ;    where A = Pointer to Patient file.
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
 ;          I = IEN and Global root of reactant (stored in piece B above)
 ;              set equal to the GMR ALLERGY field (#1) of the PATIENT
 ;              ALLERGY file (#120.8)
 ; GMRAL(PTR TO 120.8,"S",COUNT) = S
 ;    where COUNT = number 1 to number of signs/symptoms for this
 ;                  reaction.
 ;              S = a sign/symptom for this reaction in the format:
 ;                  External format;Internal format
 ;
 ;*  NOTE: This piece will no longer be supported after 9/1/97,
 ;         Please use piece G.
 ;** NOTE: This piece will no longer be supported after 9/1/97,
 ;         Please use piece H.
 ;
 N GMRAOTH
 Q:'$D(DFN)  S:'$D(GMRA)#2 GMRA="0^0^111" K GMRAL
DPT ;
 ;Read NKA Node in file 120.86
 S GMRAL=$P($G(^GMR(120.86,DFN,0)),U,2)
 ;Do not set GMRAL array if patient is unassessed or NKA.
 I GMRAL=0 Q  ;PATIENT HAS NO KNOWN ALLERGIES
 F GMRAREC=0:0 S GMRAREC=$O(^GMR(120.8,"B",DFN,GMRAREC)) Q:GMRAREC'>0  S GMRANODE=$S($D(^GMR(120.8,GMRAREC,0)):^(0),1:"") D:GMRANODE SETAL
 I GMRAL=1,+$O(GMRAL(0))'>0 S GMRAL=0 ;if flag is set to 1 (reactions exist), then make certain the reactions are passed in the GMRAL array
 K GMRA,GMRANODE,GMRAOSOF,GMRAREC,GMRATCNT
 Q
SETAL ;
 N %,GMRAI,GMRASIGN
 ;Q:'$P(GMRANODE,"^",12)&'$D(GMRAOSOF)  ;IF NOT SIGNED OFF MARK IT
 Q:+$G(^GMR(120.8,GMRAREC,"ER"))&'$D(GMRAERR)  ;IF ENTERED IN ERROR QUIT
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
 D PASS(GMRAREC,.GMRAL)
 Q
PASS(GMRAREC,GMRAL) ; Data filer
 ; This subroutine will store all the patient date for a reaction is an
 ; array.
 ; Input:
 ;     GMRAREC = The IEN for the entry in 120.8
 ;Output:
 ;     GMRAL(GMRAREC) the array entry for the record
 ;
 N GMRANODE
 S GMRANODE=$G(^GMR(120.8,GMRAREC,0)) Q:GMRANODE=""
 S %=$P(GMRANODE,"^",14)
 S GMRAL(GMRAREC)=$P(GMRANODE,"^",1,2)_"^"_$E($P(GMRANODE,"^",20))_"^"_+$P(GMRANODE,"^",16)_"^"_$S(%="A"!(%="U"):0,1:1)
 S GMRAL(GMRAREC)=GMRAL(GMRAREC)_"^"_$S(%="A":"ALLERGY;0",%="P":"PHARMACOLOGIC;2",%="U":"UNKNOWN;U",1:"")_"^"_$P(GMRANODE,"^",20)_"^"_$S(%="A":"ALLERGY;A",%="P":"PHARMACOLOGIC;P",%="U":"UNKNOWN;U",1:"")
 S GMRAL(GMRAREC)=GMRAL(GMRAREC)_"^"_$P(GMRANODE,"^",3)
 Q:'$O(^GMR(120.8,GMRAREC,10,0))  ;QUIT IF NO SIGNS/SYMPTOMS
 S:'$D(GMRAOTH) GMRAOTH=$O(^GMRD(120.83,"B","OTHER REACTION",0))
 S GMRAX=0,GMRAY=1 F  S GMRAX=$O(^GMR(120.8,GMRAREC,10,GMRAX)) Q:GMRAX<1  D  I GMRAZ'="" S GMRAL(GMRAREC,"S",GMRAY)=GMRAZ(1),GMRAY=GMRAY+1
 .S GMRAZ=$G(^GMR(120.8,GMRAREC,10,GMRAX,0))
 .S GMRAZ(1)=$S(+GMRAZ'=GMRAOTH:$P($G(^GMRD(120.83,+GMRAZ,0)),U)_";"_+GMRAZ,1:$P(GMRAZ,U,2)_";"_+GMRAZ)
 .Q
 K GMRAX,GMRAY,GMRAZ
 Q
