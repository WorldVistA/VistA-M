XUAF4 ;ISC-SF/RWF/RAM - Institution file access. ;12/03/2019  08:07
 ;;8.0;KERNEL;**43,112,206,209,232,217,261,394,549,555,723**;Jul 10, 1995;Build 3
 ;;Per VA Directive 6402, this routine should not be modified
 Q  ;No access from the top.
 ;
PARENT(ROOT,CHILD,ASSO) ;sr. Return array of IEN's of parents
 N %,%0
 S CHILD=$$LKUP(CHILD),ASSO=$$ASSO($G(ASSO)),%=0
 F  S %=$O(^DIC(4,CHILD,7,%)) Q:%'>0  S %0=+$P(^(%,0),U,2) D
 . Q:+%'=ASSO
 . S @ROOT@("P",+%0)=$$NS(+%0)
 Q
CHILDREN(ROOT,PAR,ASSO,XUAC) ;sr. Return the children
 N %,%1 S %=0,PAR=$$LKUP(PAR),ASSO=$$ASSO($G(ASSO)),XUAC=$G(XUAC)
 Q:ASSO'>0
 F  S %=$O(^DIC(4,"AC",ASSO,PAR,%)) Q:%'>0  D
 . I XUAC,$$STATUS(%)="I" Q
 . S @ROOT@("C",%)=$$NS(%)
 Q
SIBLING(ROOT,CHILD,ASSO) ;sr. Return the siblings
 N % S %=0,ASSO=$$ASSO($G(ASSO))
 D PARENT(ROOT,CHILD,ASSO)
 F  S %=$O(@ROOT@("P",%)) Q:%'>0  D CHILDREN($NA(@ROOT@("P",%)),"`"_%,ASSO)
 Q
NNT(%) ;ef.sr. Return Name, Station Number, ASSO
 I %'>0 Q ""
 Q $$NS(%)_"^"_$$WHAT(%,13)
 ;
LKUP(%) ;ef.sr. Resolve a value into IEN
 I $E(%)="`" S %=+$E(%,2,99) Q:$D(^DIC(4,%,0))#2 % Q 0
 ;Q $$FIND1^DIC(4,,"MX",%)
 Q $$FIND1^DIC(4,,"MX",%,,"I $P(^(0),U,11)'=""I""") ;To screen Inactive
 ;
STATUS(%) ;Get the status of a IEN
 Q $P($G(^DIC(4,%,0)),U,11)
 ;
TYPE(%) ;Lookup a Faclity TYPE in file 4.1
 I %="" Q %
 I $D(^DIC(4.1,"B",%))>9 Q %
 S %=$$FIND1^DIC(4.1,,"MX",%)
 Q $P($G(^DIC(4.1,+%,0)),U)
 ;
ASSO(%) ;Lookup an Asso
 Q:+%=% % S:%="" %="VISN"
 S %=$$FIND1^DIC(4.05,,"MX",%)
 Q +%
 ;
NS(IEN) ;ef.sr. Return name and station #
 Q $P($G(^DIC(4,IEN,0)),U,1)_U_$P($G(^DIC(4,+IEN,99)),U,1)
 ;
WHAT(IEN,FLD) ;ef.sr. Field to return
 Q $$GET1^DIQ(4,IEN_",",FLD,"")
 ;
CIRN(%1,%2) ;ef.sr. Is this a CIRN Enables inst.
 N % S %1=+$G(%1)
 Q:'$D(^DIC(4,%1,0)) -1
 I $G(%2)]"" N DIE,DR,DA S DA=%1,DR="990.1///"_%2,DIE="^DIC(4," D ^DIE
 Q $$WHAT(%1,990.1)
 ;
IEN(STA) ;return IEN for a station number
 S STA=$G(STA) Q:STA="" STA
 Q $O(^DIC(4,"D",STA,0))
 ;
STA(IEN) ;return station number for an IEN
 Q $P($G(^DIC(4,+IEN,99)),U)
 ;
TF(IEN) ;active treating facility? (1=YES,0=NO)
 N ARRAY Q:'$G(IEN) 0
 D F4($$STA(IEN),.ARRAY,"AM")
 Q $S(ARRAY:1,1:0)
 ;
RT(IEN) ;realigned to
 N ARRAY Q:'$G(IEN) 0
 D F4($$STA(IEN),.ARRAY)
 Q $G(ARRAY("REALIGNED TO"))
 ;
RF(IEN) ;realigned from
 N ARRAY Q:'$G(IEN) 0
 D F4($$STA(IEN),.ARRAY)
 Q $G(ARRAY("REALIGNED FROM"))
 ;
O99(IEN) ;returns pointer to new station number IEN
 Q:$O(^DIC(4,"AOLD99",+$G(IEN),""))="" ""
 Q $O(^DIC(4,"D",$O(^DIC(4,"AOLD99",+$G(IEN),"")),0))
 ;
LEGACY(STA) ; -- legacy station number (1=yes; 0=no)
 Q $S($$RT^XUAF4(+$$IEN^XUAF4(STA)):1,1:0)
 ;
PRNT(STA) ; -- parent facility
 N X S STA=$G(STA) Q:STA="" "0^no station number passed"
 D PARENT("X",STA,"PARENT FACILITY") S X=$O(X("P",0))
 Q:'X "0^no parent associated with input station number"
 Q X_U_$P($G(X("P",+X)),U,2)_U_$P($G(X("P",+X)),U)
 ;
NAME(IEN) ; -- Official Name
 Q:$P($G(^DIC(4,+IEN,99)),U,3)'="" $P($G(^DIC(4,+IEN,99)),U,3)
 Q $P($G(^DIC(4,+IEN,0)),U)
 ;
ACTIVE(IEN) ; -- active facility (1=active, 0=inactive)
 ;
 Q '$P($G(^DIC(4,+IEN,99)),U,4)
 ;
PADD(IEN) ; -- physical address (street addr^city^state^zip)
 ;
 N X,STATE
 ;
 S X=$P($G(^DIC(4,+IEN,0)),U,2)
 S STATE=$P($G(^DIC(5,+X,0)),U,2)
 S X=$G(^DIC(4,+IEN,1)) Q:X="" X
 ;
 Q $P(X,U)_U_$P(X,U,3)_U_STATE_U_$P(X,U,4)
 ;
MADD(IEN) ; -- mailing address (street addr^city^state^zip)
 ;
 N X,STATE
 ;
 S X=$G(^DIC(4,+IEN,4)) Q:X="" X
 S STATE=$P($G(^DIC(5,+$P(X,U,4),0)),U,2)
 ;
 Q $P(X,U)_U_$P(X,U,3)_U_STATE_U_$P(X,U,5)
 ;
F4(STA,ARRAY,FLAG,ONDT) ;File #4 multipurpose API
 ;
 ;INPUT
 ;       STA     Station number (required)
 ;
 ;    [.]ARRAY   $NAME reference for return values.  (required)
 ;
 ;       FLAG    A = Active entries only.  (optional)
 ;               M = Medical treating facilities only.
 ;
 ;       ONDT    Return name on this FM internal date.  (optional);
 ;
 ;OUTPUT
 ;       ARRAY                     IEN or '0^error message'
 ;       ARRAY("NAME")             name
 ;       ARRAY("VA NAME")          offical va name
 ;       ARRAY("STATION NUMBER")   station number
 ;       ARRAY("TYPE")             facilty type name
 ;       ARRAY("INACTIVE")         inactive date (0=not inactive)
 ;       note: if inactive date not available but entry inactive then 1
 ;
 ;       ARRAY("REALIGNED TO")     IEN^station number^date
 ;       ARRAY("REALIGNED FROM")   IEN^station number^date
 ;
 K ARRAY
 S STA=$G(STA),FLAG=$G(FLAG),ONDT=$G(ONDT)
 I STA="" S ARRAY="0^invalid input STA - required" Q
 ;
 N IEN,N99,TO,FM,I,RDT,NAME,VANAME,HDT
 ;
 S IEN=$$IEN(STA)
 I 'IEN S ARRAY="0^station number does not exist" Q
 S N99=$G(^DIC(4,+IEN,99))
 S ARRAY=$$SCRN() Q:'ARRAY
 ;
 S ARRAY("NAME")=$P(^DIC(4,IEN,0),U)
 S ARRAY("VA NAME")=$P(N99,U,3)
 S ARRAY("STATION NUMBER")=STA
 S ARRAY("TYPE")=$P($G(^DIC(4.1,+$G(^DIC(4,IEN,3)),0)),U)
 ;
 ;realignments
 S TO=$O(^DIC(4,"ARTO",IEN,0)) D:TO
 .S RDT=$O(^DIC(4,"ART",TO,IEN,0))
 .S ARRAY("REALIGNED TO")=TO_U_$$STA(TO)_U_RDT
 S FM=$O(^DIC(4,"ARFM",IEN,0)) D:FM
 .S ARRAY("REALIGNED FROM")=FM_U_$$STA(FM)_U_$O(^DIC(4,"ARF",FM,IEN,0))
 ;
 S I=$O(^DIC(4,"AI",IEN,0)),I=$S(I:I,$G(RDT):RDT,1:+$P(N99,U,4))
 S ARRAY("INACTIVE")=I
 ;
 Q:'ONDT
 ;
 ;get name for date
 S NAME=ARRAY("NAME")
 S VANAME=ARRAY("VA NAME")
 S HDT=DT
 F  S HDT=$O(^DIC(4,IEN,999,HDT),-1) Q:('HDT!(HDT<ONDT))  D
 .N X S X=$G(^DIC(4,IEN,999,HDT,0)) Q:X=""
 .S:$P(X,U,2)'="" NAME=$P(X,U,2)
 .S:$P(X,U,3)'="" VANAME=$P(X,U,3)
 S ARRAY("NAME")=NAME
 S ARRAY("VA NAME")=VANAME
 ;
 Q
 ;
IDT(IEN) ; inactive date
 N IDT,ND,XDT
 S IEN=$G(IEN) Q:'IEN IEN
 S XDT=9999999,IDT=""
 F  S XDT=$O(^DIC(4,+IEN,999,XDT),-1) Q:'XDT  D  Q:IDT
 .S ND=$G(^DIC(4,+IEN,999,XDT,0)) Q:ND=""
 .S IDT=$S($P(ND,U,5):XDT,$P(ND,U,7):XDT,1:IDT)
 Q IDT
 ;
SCRN() ;sreen IEN
 N X S X=$E(N99,1,3)
 I FLAG["A",$P(N99,U,4) Q "0^inactive facility"
 I FLAG["M",$S(X=358:0,X=740:0,X<400:1,X>759:1,X<700:0,X<750:1,1:0),$G(DUZ("AG"))="V" Q "0^not a treating facility"
 Q IEN
 ;
LOOKUP ; -- lookup an enty by coding system / ID pair
 ;
 N DIC,D
 ;
 S DIC="^DIC(4,",DIC(0)="QEA",D="XUMFIDX" D IX^DIC
 ;
 Q
 ;
IDX(CDSYS,ID) ; -- return IEN for a given coding system / ID pair
 ;
 ;INPUT
 ;       CDSYS   coding system (required)
 ;       ID      identifier (required)
 ;OUTPUT
 ;       $$      Internal Entry Number
 ;
 N IEN
 ;
 S CDSYS=$G(CDSYS),ID=$G(ID)
 ;
 Q:CDSYS="" "0^CDSYS required"
 Q:ID="" "0^ID required"
 ;
 I CDSYS="VASTANUM" Q $O(^DIC(4,"D",ID,0))
 I CDSYS="NPI"  Q $O(^DIC(4,"ANPI",ID,0))
 ;
 S IEN=$O(^DIC(4,"XUMFIDX",CDSYS,ID,0))
 ;
 Q $S(IEN:IEN,1:"0^not found")
 ;
ID(CDSYS,IEN) ; returns the ID for a given coding system / IEN
 ;
 ;INPUT
 ;       CDSYS   coding system (required)
 ;       IEN     Internal Entry Number (required)
 ;OUTPUT
 ;       $$      Identifier
 ;
 N ID,IDX
 ;
 S CDSYS=$G(CDSYS),IEN=$G(IEN)
 Q:CDSYS="" "" Q:'IEN "" Q:'$D(^DIC(4,IEN)) ""
 ;
 I CDSYS="VASTANUM" Q $P($G(^DIC(4,+IEN,99)),U)
 I CDSYS="NPI"  Q $P($G(^DIC(4,+IEN,"NPI")),U)
 ;
 S IDX=$O(^DIC(4,IEN,9999,"B",CDSYS,0)) Q:'IDX ""
 ;
 Q $P($G(^DIC(4,IEN,9999,IDX,0)),U,2)
 ;
CDSYS(Y) ; coding systems
 ;
 ;INPUT/OUTPUT
 ;       .Y     Y(CDSYS) = $D local system ^ coding system name
 ;
 S Y("DMIS")=$D(^DIC(4,"XUMFIDX","DMIS"))_U_"DoD DMIS ID"
 S Y("VASTANUM")=$D(^DIC(4,"D"))_U_"VA Station Number"
 S Y("NPI")=$D(^DIC(4,"ANPI"))_U_"NPI"
 S Y("CLIA")=$D(^DIC(4,"XUMFIDX","CLIA"))_U_"CLIA number"
 S Y("MAMMO-ACR")=$D(^DIC(4,"XUMFIDX","MAMMO-ACR"))_U_"MAMMO-ACR number"
 ;
 Q
 ;
LCDSYS(Y) ;  list coding systems
 ;
 N CDSYS
 S CDSYS=""
 S CDSYS("NPI")="",CDSYS("VASTANUM")=""
 F  S CDSYS=$O(^DIC(4,"XUMFIDX",CDSYS)) Q:CDSYS=""  D
 .S Y(CDSYS)=""
 ;
 Q
 ;
BNIEN(IEN) ; -- Billing Facility Name - Internal Entry Number
 ;
 Q $P($G(^DIC(4,+IEN,99)),U,2)
 ;
BNSTA(STA) ; -- Billing Facility Name - Station Number
 ;
 Q $P($G(^DIC(4,+$$IEN^XUAF4(STA),99)),U,2)
 ;
CERNER(STA) ; Check if a facility has been converted to CERNER
 ; Take in STA = Station number
 ; Return -1 for invalid station number
 ; Return 1 for CERNER station
 N XUSIEN
 S XUSIEN=+$$IEN^XUAF4(STA) I XUSIEN'>0 Q "-1^"_STA_" is not a valid station number"
 Q $P($G(^DIC(4,XUSIEN,102)),U)
 ;
