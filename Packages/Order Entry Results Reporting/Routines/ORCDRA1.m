ORCDRA1 ;SLC/MKB-Utility functions for RA dialogs ; 08 May 2002  2:12 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4,75,141**;Dec 17, 1997
DIV() ; -- Returns division of ordering location
 N Y I $G(ORL),'$G(OREVENT) S Y=+$P($G(^SC(+ORL,0)),U,15),Y=+$$SITE^VASITE(DT,Y)
 I $G(OREVENT) S Y=+$$DIV^OREVNTX(OREVENT)
 S:$G(Y)'>0 Y=+$G(DUZ(2))
DIVQ Q Y
 ;
CKPTYPE ; -- Check procedure for Series type
 N PTYPE S PTYPE=$P($G(^ORD(101.43,+$$VAL^ORCD("PROCEDURE"),"RA")),U,2)
 Q:PTYPE'="S"  Q:'$L($P($G(^RAMIS(71.2,+Y,0)),U,2))
 W $C(7),!,"This procedure modifier may not be selected with a procedure series!",!
 K DONE,ORDIALOG(PROMPT,ORI)
 Q
 ;
VALIDWP(ROOT) ; -- Validate wp field (borrowed from VALWP^RAUTL5)
 ; Pass back '1' is data is valid, '0' if not valid.
 Q:'$L($G(ROOT)) 0 Q:'$O(@(ROOT_"0)")) 0
 N CHAR,CNT,WL,WPFLG,X,Y,Z
 S (WPFLG,X)=0
 F  S X=$O(@(ROOT_X_")")) Q:X'>0  D  Q:WPFLG
 . S (CNT,WL)=0
 . S Y=$G(@(ROOT_X_",0)")) Q:Y']""
 . S WL=$L(Y)
 . F Z=1:1:WL D  Q:WPFLG
 .. S CHAR=$E(Y,Z) S:CHAR?1AN CNT=CNT+1
 .. S:CHAR'?1AN&(CNT>0) CNT=0 S:CNT=2 WPFLG=1
 Q WPFLG
 ;
CHNGCAT ; -- Kill dependent values if Category changes
 N P,PTR
 F P="LOCATION","CONTRACT/SHARING SOURCE","RESEARCH SOURCE" D
 . S PTR=+$O(^ORD(101.41,"AB",$E("OR GTX "_P,1,63),0))
 . K:PTR ORDIALOG(PTR,1),ORDIALOG(PTR,"S") ; kill value,screen
 Q
 ;
MATCH(CATG) ; -- Category match pt location type?
 I $G(OREVENT) Q 1 ; location will be stuffed
 N TYPE,SCREEN,Y S TYPE=$P($G(^SC(+$G(ORL),0)),U,3),Y=1
 S:CATG="I"&(TYPE'="W") SCREEN="I $P(^(0),U,3)=""W"",'$P($G(^(""OOS"")),""^"")"
 S:CATG="O"&(TYPE="W") SCREEN="I $P(^(0),U,3)'=""W"",'$P($G(^(""OOS"")),""^"")"
 I $D(SCREEN) S Y=0,ORDIALOG($$PTR^ORCD("OR GTX LOCATION"),"S")=SCREEN
 Q Y
 ;
SCHEDULD() ; -- Returns 1 or 0, if patient is scheduled for pre-op
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I $G(ORDIALOG(PROMPT,1)) Q 1 ; don't ask - already have date
 S DIR(0)="YAO",DIR("A")="Is this patient scheduled for pre-op? "
 S DIR("B")="NO" D ^DIR S:$D(DTOUT)!($D(DUOUT)) ORQUIT=1
 Q +Y
 ;
MODE() ; -- Returns default mode of transport
 Q:$G(ORTYPE)="Z" "" N I,M,P
 S I=0,M=$O(^ORD(101.41,"AB","OR GTX MODIFIERS",0))
 S P=$O(^RAMIS(71.2,"B","PORTABLE EXAM",0))
 F  S I=$O(ORDIALOG(M,I)) Q:I'>0  I ORDIALOG(M,I)=P S Y="P" Q
 S:'$D(Y) Y=$S($G(ORWARD):"W",1:"A")
 Q Y
 ;
ILOC ; -- Get allowable imaging locations
 N ITYPE,ORY,IFN,CNT K ORDIALOG(PROMPT,"LIST")
 S ITYPE=$P(ORDG,U,4) D EN4^RAO7PC1(ITYPE,"ORY")
 S (IFN,CNT)=0 F  S IFN=$O(ORY(IFN)) Q:IFN'>0  D
 . S CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=ORY(IFN)_U_IFN
 . S ORDIALOG(PROMPT,"LIST","B",$P(ORY(IFN),U,2))=IFN
 S:CNT ORDIALOG(PROMPT,"LIST")=CNT_"^1",Y=+ORDIALOG(PROMPT,"LIST",1)
 Q
 ;
DEFLOC() ; -- Returns default imaging location
 N X,I S X=+$G(ORDIALOG(PROMPT,"LIST",1))
 I $G(ORDIV) S I=0 F  S I=$O(ORDIALOG(PROMPT,"LIST",I)) Q:I'>0  I $P(ORDIALOG(PROMPT,"LIST",I),U,3)=ORDIV S X=+ORDIALOG(PROMPT,"LIST",I) Q
 Q X
