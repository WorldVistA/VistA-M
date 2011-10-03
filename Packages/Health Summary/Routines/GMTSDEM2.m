GMTSDEM2 ; SLC/DLT,KER - Demographics (cont) ; 12/11/2002 [9/16/03 7:29am]
 ;;2.7;Health Summary;**56,58,60,62**;Oct 20, 1995
 ;                 
 ; External References
 ;   DBIA 10061  OAD^VADPT
 ;   DBIA 10061  DEM^VADPT
 ;   DBIA   951  ^IBE(355.1
 ;   DBIA   794  ^DIC(36
 ;   DBIA  2056  $$GET1^DIQ (file #36, and #355.1)
 ;   DBIA 10145  ALL^IBCNS1  
 ;   DBIA 10104  $$UP^XLFSTR
 ;                     
NOKC ; Next of Kin Component
 N GMTSNOK S GMTSNOK="" D NOK Q
NOK ; Next of Kin
 Q:$D(GMTSQIT)  N %,%H,STR,STR1,STR2,NOKTYPE,ADR,VAERR,VAOA K VAOA("A") D OAD^VADPT
 I $L($G(VAOA(9))) D
 . ;   Primary Next of Kin
 . S NOKTYPE="Primary" D DNOK
 . S VAOA("A")=3 D OAD^VADPT
 . I $L($G(VAOA(9))) D
 . . ;   Secondary Next of Kin
 . . K GMTSNOK S NOKTYPE="Secondary" D DNOK
 Q
DNOK ;   Display Next of Kin
 D:'$D(GMTSNOK) WRT^GMTSDEM("",,,,0) Q:$D(GMTSQIT)
 S STR1=$$UP^XLFSTR(VAOA(9)),STR2=$S('$L(VAOA(10)):"<not given>",1:$$UP^XLFSTR(VAOA(10)))
 D WRT^GMTSDEM(($G(NOKTYPE)_" NOK"),STR1,"Relation",STR2,1) Q:$D(GMTSQIT)
 S ADR=$G(VAOA(1)) K VAOA(1) I '$L(ADR) S ADR=$G(VAOA(2)) K VAOA(2) I '$L(ADR) S ADR=$G(VAOA(3)) K VAOA(3)
 S STR=$S('$L(ADR):"<street address not available>",1:$$UP^XLFSTR(ADR))
 K:STR="<street address not available>" VAOA(1),VAOA(2),VAOA(3)
 D WRT^GMTSDEM("",STR,"Phone",VAOA(8),1) Q:$D(GMTSQIT)
 S ADR=$G(VAOA(2)) K VAOA(2) I '$L(ADR) S ADR=$G(VAOA(3)) K VAOA(3)
 S STR=$$UP^XLFSTR(ADR) D:$L(STR) WRT^GMTSDEM("",STR,,,1) Q:$D(GMTSQIT)
 S ADR=$G(VAOA(3))
 S STR=$$UP^XLFSTR(ADR) D:$L(STR) WRT^GMTSDEM("",STR,,,1) Q:$D(GMTSQIT)
 I VAOA(4)'="" D
 . S STR=$$UP^XLFSTR(VAOA(4)) S:VAOA(5) STR=STR_", "_$$UP^XLFSTR($P(VAOA(5),U,2)) S:VAOA(6) STR=STR_"  "_$$UP^XLFSTR(VAOA(6))
 . D WRT^GMTSDEM("",STR,,,1) Q:$D(GMTSQIT)
 Q
 ;                
INS ; Insurance Info
 N I,INSURE,GMTSX,IEN,VAL,CLAIM,COMPANY,TYPE,COB,SUBSCRIB,GROUP,HOLDER,EFFECT,EXPIRE
 D ALL^IBCNS1(DFN,"INSURE") Q:$O(INSURE(0))=""
 S I=0 F  S I=$O(INSURE(I)) Q:'I  D   Q:$D(GMTSQIT)
 . S (COMPANY,TYPE,GROUP,HOLDER,EFFECT,EXPIRE)=""
 . S GMTSX=INSURE(I,0),IEN=+GMTSX
 . ;   Insurance Company
 . S COMPANY=$$GET1^DIQ(36,(+IEN_","),.01) Q:'$L(COMPANY)
 . S CLAIM=INSURE(I,355.3)
 . ;   Policy Type
 . S IEN=$P(CLAIM,"^",9)
 . S TYPE="" I IEN]"" D
 . . S TYPE=$$GET1^DIQ(355.1,(+IEN_","),.01) S TYPE=$$ABR(TYPE)
 . ;   Group Number
 . S GROUP=$P(CLAIM,"^",4)
 . S GMTSX=INSURE(I,0),VAL=$P(GMTSX,"^",6)
 . ;   Insurance Policy Holder
 . S HOLDER=$S(VAL="v":"SELF",VAL="s":"SPOUSE",1:"OTHER")
 . ;   Insurance Effect Date
 . S EFFECT=$P(GMTSX,"^",8)
 . ;   Insurance Expiration Date
 . S EXPIRE=$P(GMTSX,"^",4)
 . ;   Subscriber ID
 . S SUBSCRIB=$P($G(INSURE(I,0)),"^",2)
 . ;   Coordination of Benefits
 . S COB=+($P($G(INSURE(I,0)),"^",20))
 . S COB=$S(COB=1:"PRIMARY",COB=2:"SECONDARY",COB=3:"TERTIARY",1:"UNKNOWN")
 . Q:$D(GMTSQIT)  D WRT^GMTSDEM("",,,,0) Q:$D(GMTSQIT)
 . D WRT^GMTSDEM("Insurance Company",$E(COMPANY,1,27),"Holder",HOLDER,1) Q:$D(GMTSQIT)
 . I $L(TYPE)!($L(EFFECT)) D WRT^GMTSDEM("Policy Type",$E(TYPE,1,28),"Effective",$$EDT^GMTSU(EFFECT),1) Q:$D(GMTSQIT)
 . I $L(GROUP)!($L(EXPIRE)) D WRT^GMTSDEM("Group #",$E(GROUP,1,28),"Expires",$$EDT^GMTSU(EXPIRE),1) Q:$D(GMTSQIT)
 . I $L(SUBSCRIB)!($L(COB)) D WRT^GMTSDEM("Subscriber ID",$E(SUBSCRIB,1,28),"Coord. of Benefits",COB,1) Q:$D(GMTSQIT)
 Q
 ;          
RACE ; Race and Ethnicity
 N GMTS D ER(+($G(DFN)),.GMTS) I $L($G(GMTS(2)))!($L($G(GMTS(6)))) D  Q
 . N GMTSD,GMTSI,GMTSC
 . S (GMTSI,GMTSC)=0 F GMTSI=1:1 Q:'$L($P($G(GMTS(6)),"^",GMTSI))  D  Q:$D(GMTSQIT)
 . . S GMTSD=$P($G(GMTS(6)),"^",GMTSI),GMTSC=GMTSC+1
 . . D:+GMTSC=1 WRT^GMTSDEM("Ethnicity",GMTSD,"",,1) Q:$D(GMTSQIT)
 . . D:+GMTSC>1 WRT^GMTSDEM("",GMTSD,"",,1) Q:$D(GMTSQIT)
 . Q:$D(GMTSQIT)
 . S (GMTSI,GMTSC)=0 F GMTSI=1:1 Q:'$L($P($G(GMTS(2)),"^",GMTSI))  D  Q:$D(GMTSQIT)
 . . S GMTSD=$P($G(GMTS(2)),"^",GMTSI),GMTSC=GMTSC+1
 . . D:+GMTSC=1 WRT^GMTSDEM("Race",GMTSD,"",,1) Q:$D(GMTSQIT)
 . . D:+GMTSC>1 WRT^GMTSDEM("",GMTSD,"",,1) Q:$D(GMTSQIT)
 I '$L($G(GMTS(2)))&('$L($G(GMTS(6)))) D  Q
 . N GMTSD,GMTSI,GMTSC S GMTSD=$G(GMTS(.06)) D WRT^GMTSDEM("Race",GMTSD,"",,1) Q:$D(GMTSQIT)
 Q
RE ; Race and Ethnicity Component
 N GMTS D ER(+($G(DFN)),.GMTS) I $L($G(GMTS(2)))!($L($G(GMTS(6)))) D  Q
 . N GMTSD,GMTSI,GMTSC
 . S (GMTSI,GMTSC)=0 F GMTSI=1:1 Q:'$L($P($G(GMTS(6)),"^",GMTSI))  D  Q:$D(GMTSQIT)
 . . S GMTSD=$P($G(GMTS(6)),"^",GMTSI),GMTSC=GMTSC+1
 . . D:+GMTSC=1 WRT^GMTSDEM("Ethnicity",GMTSD,"",,1) Q:$D(GMTSQIT)
 . . D:+GMTSC>1 WRT^GMTSDEM("",GMTSD,"",,1) Q:$D(GMTSQIT)
 . Q:$D(GMTSQIT)
 . S (GMTSI,GMTSC)=0 F GMTSI=1:1 Q:'$L($P($G(GMTS(2)),"^",GMTSI))  D  Q:$D(GMTSQIT)
 . . S GMTSD=$P($G(GMTS(2)),"^",GMTSI),GMTSC=GMTSC+1
 . . D:+GMTSC=1 WRT^GMTSDEM("Race",GMTSD,"",,1) Q:$D(GMTSQIT)
 . . D:+GMTSC>1 WRT^GMTSDEM("",GMTSD,"",,1) Q:$D(GMTSQIT)
 I '$L($G(GMTS(2)))&('$L($G(GMTS(6)))) D  Q
 . N GMTSD,GMTSI,GMTSC S GMTSD=$G(GMTS(.06)) D WRT^GMTSDEM("Race",GMTSD,"",,1) Q:$D(GMTSQIT)
 Q
ER(DFN,GMTS) ;   Get Ethnicity and Race
 N VADM,VA,VAERR,GMTSD,GMTSI,GMTSC,X,Y S DFN=+($G(DFN)) Q:+DFN=0
 D DEM^VADPT S GMTSD=$P($G(VADM(8)),"^",2),GMTS(.06)=GMTSD,GMTS("OLD")=GMTSD
 S GMTSI=0 F  S GMTSI=$O(VADM(11,GMTSI)) Q:+GMTSI=0  D
 . S GMTSD=$P($G(VADM(11,GMTSI)),"^",2) S:$L(GMTSD) GMTS(6)=$G(GMTS(6))_"^"_GMTSD
 S GMTSD=$G(GMTS(6)) F  Q:$E(GMTSD,1)'="^"  S GMTSD=$E(GMTSD,2,$L(GMTSD))
 S GMTS(6)=GMTSD S GMTSI=0 F  S GMTSI=$O(VADM(12,GMTSI)) Q:+GMTSI=0  D
 . S GMTSD=$P($G(VADM(12,GMTSI)),"^",2) S:$L(GMTSD) GMTS(2)=$G(GMTS(2))_"^"_GMTSD
 S GMTSD=$G(GMTS(2)) F  Q:$E(GMTSD,1)'="^"  S GMTSD=$E(GMTSD,2,$L(GMTSD))
 S GMTS(2)=GMTSD,GMTSD=$G(GMTS(6))_"^^"_$G(GMTS(2)) F  Q:$E(GMTSD,1)'="^"  S GMTSD=$E(GMTSD,2,$L(GMTSD))
 S GMTS("NEW")=GMTSD,GMTS(.06)=$G(GMTS(.06)),GMTS(2)=$G(GMTS(2)),GMTS(6)=$G(GMTS(6))
 Q
 ;              
ABR(X) ; Abbreviations
 S X=$$UP^XLFSTR($G(X)) N TM,AB,SID S TM="PROCEDURES",AB="PROC" S:X[TM X=$$SW(X,TM,AB)
 S TM="SUPPLEMENTAL",AB="SUP" S:X[TM X=$$SW(X,TM,AB) S TM="ORGANIZATION",AB="ORG" S:X[TM X=$$SW(X,TM,AB) S TM="ORIGIZ",AB="ORG" S:X[TM X=$$SW(X,TM,AB)
 S TM="ORGANIZ",AB="ORG" S:X[TM X=$$SW(X,TM,AB) S TM="MAINTENANCE",AB="MAINT" S:X[TM X=$$SW(X,TM,AB) S TM="PROVIDER",AB="PROV" S:X[TM X=$$SW(X,TM,AB)
 S TM="INDIVIDUAL",AB="INDIVID" S:X[TM X=$$SW(X,TM,AB) S TM="ASSOCATION",AB="ASSOC" S:X[TM X=$$SW(X,TM,AB) S TM="ASSOCIATION",AB="ASSOC" S:X[TM X=$$SW(X,TM,AB)
 S TM="PRACT",AB="PRACT" S:X[TM X=$$SW(X,TM,AB) S TM="INSURANCE",AB="INS" S:X[TM X=$$SW(X,TM,AB) S TM="ETC.",AB="ETC" S:X[TM X=$$SW(X,TM,AB)
 S TM="(ONLY)",AB="" S:X[TM X=$$SW(X,TM,AB) S TM="PROTECTION",AB="PROT" S:X[TM X=$$SW(X,TM,AB) S TM="PRACTICE",AB="PRACT" S:X[TM X=$$SW(X,TM,AB)
 Q X
SW(X,Y,Z) ; Swap Abbreviation with Term
 N TM,AB
 S X=$G(X),TM=$$TRIM($G(Y)),AB=$$TRIM($G(Z)) Q:X="" ""  Q:TM="" X  Q:TM=AB X
 F  Q:X'[TM  S X=$P(X,TM,1)_AB_$P(X,TM,2)
 Q X
TRIM(X) ; Trim Spaces
 S X=$G(X) Q:X="" X F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,229)
 Q X
