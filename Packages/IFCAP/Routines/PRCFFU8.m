PRCFFU8 ;WISC/SJG-OBLIGATION PROCESSING UTILITIES, CON'T ;5/17/09  23:39
 ;;5.1;IFCAP;**130,196**;Oct 20, 2000;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*196 Send order obligation date to GECS for creation
 ;            of the SO document CTL segment with correct date for 
 ;            Cancel doc and Decrease Adj doc or when
 ;            amending a vendor.
 ;
 ; No Top Level Entry
 QUIT
MSG ;
 W !!,"This Purchase Order Amendment will not require a Modification "
 W:PRCFA("TT")="MO" !,"Miscellaneous Order (MO) "
 W:PRCFA("TT")="SO" !,"Service Order (SO) "
 W "Document for the following reason(s):"
 W !!,"The Amendment consisted of: "
 I $D(PRCFA("SHIP")),PRCFA("SHIP")]"" W ?30,PRCFA("SHIP"),!
 I $D(PRCFA("SOURCE")),PRCFA("SOURCE")]"" W ?30,PRCFA("SOURCE"),!
 I $D(PRCFA("MAIL")),PRCFA("MAIL")]"" W ?30,PRCFA("MAIL"),!
 I $D(PRCFA("ADMADD")),PRCFA("ADMADD")]"" W ?30,PRCFA("ADMADD"),!
 I $D(PRCFA("ADMDEL")),PRCFA("ADMDEL")]"" W ?30,PRCFA("ADMDEL"),!
 I $D(PRCFA("AUTH")),PRCFA("AUTH")]"" W ?30,PRCFA("AUTH"),!
 I $D(PRCFA("ZERO")),PRCFA("ZERO")]"" W ?30,PRCFA("ZERO"),! H 3
 I $D(PRCFA("WASH")),PRCFA("WASH")]"" W ?30,PRCFA("WASH"),! H 3
 W !!,"No Modification FMS Document has been transmitted!!" H 3
 QUIT
 ;
CANCEL(REF,TYPE) ; Cancel FMS Obligation Documents
 ; REF - PAT Reference Number
 ; TYPE - FMS Transaction Type
 ; DATA - MO2 Segment
 N DATA,FMSCOMDT       ;PRC*5.1*196
 S FMSCOMDT=PRCFA("OBLDATE")    ;PRC*5.1*196
 S (PRCFA("MOD"),PRCFA("CANCEL"))="X^2^Cancellation Entry"
 S FMSMOD=$P(PRCFA("MOD"),U)
 I PRCFA("TT")="AR",$E(REF,11,12)'=12 S REF=$E(REF,1,10)_12
 S FMSSEC=$$SEC1^PRC0C(PRC("SITE"))
 I TYPE="AR" D CANC S TYPE="SO",REF=$E(REF,1,10)
 D:$G(MTOPDA)="" DEC,CANC Q
DEC ;
 Q:XRBLD=2  ; exit if rebuilding the 'E' (amended original) transaction
 W !!,"...now generating the FMS Decrease "_TYPE_" Obligation Document..."
 S FMSDES="Decrease Obligation Amount of "_TYPE_" Obligation Document"
 I XRBLD=0 D CONTROL^GECSUFMS("I",PRC("SITE"),REF,TYPE,FMSSEC,1,"Y",FMSDES,FMSCOMDT)    ;PRC*5.1*196
 S DATA=$$SEG2^PRCFFU8("X^"_TYPE,POIEN,.SEG)
 D GECS
 S PRCFA("PODA")=PRCFA("OLDPODA")
 I '$D(POESIG) I $D(PRCFA("PODA")),+PRCFA("PODA")>0 S POESIG=1
 N FMSDOCT S FMSDOCT=$P(PRCFA("REF"),"-",2)
 D EN7^PRCFFU41(TYPE,FMSMOD,PRCFA("OBLDATE"),FMSDOCT)
 Q
CANC ;
 Q:XRBLD=2
 W !!,"...now generating the FMS "_TYPE_" Cancellation Document..."
 S FMSDES="Cancellation of "_TYPE_" Obligation Document"
 I XRBLD=0 D CONTROL^GECSUFMS("I",PRC("SITE"),REF,TYPE,FMSSEC,1,"Y",FMSDES,FMSCOMDT)   ;PRC*5.1*196
 S DATA=$$SEG2^PRCFFU8("X^"_TYPE,POIEN,.SEG)
 D GECS
 S PRCFA("PODA")=PRCFA("OLDPODA")
 I '$D(POESIG) I $D(PRCFA("PODA")),+PRCFA("PODA")>0 S POESIG=1
 N FMSDOCT S FMSDOCT=$P(PRCFA("REF"),"-",2)
 D EN7^PRCFFU41(TYPE,FMSMOD,PRCFA("OBLDATE"),FMSDOCT)
 Q
 ;
GECS ; Common GECS processing for 'X' documents
 D SETCS^GECSSTAA(GECSFMS("DA"),DATA)
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 N P2 S P2=+PO_"/"_PRCFA("AMEND#"),$P(P2,"/",5)=$P($G(PRCFA("ACCPD")),U),$P(P2,"/",6)=PRCFA("OBLDATE")
 D SETPARAM^GECSSDCT(GECSFMS("DA"),P2)
 Q
SEG2(TYPE,IEN,SEG) ; Create MO2 segment for cancellation document
 ; IEN - Internal Entry Number of Purchase Order
 ; TYPE - FMS Document Type 
 ; SEG - Return value for MO2 segment
 D GENDIQ^PRCFFU7(442,IEN,.1,"I","")
 S FMSPODAT=$G(PRCFA("OBLDATE"))
 I FMSPODAT="" D NOW^%DTC S FMSPODAT=X
 D DATE^PRCFFU2(FMSPODAT,.A,.B,.C)
 S FMSPODAT=FMSYR_"^"_FMSMO_"^"_FMSDAY
 I $P(TYPE,"^",2)="AR" S SEG="RC2",$P(SEG,U,7)=$P(TYPE,"^",1)_"^~"
 E  S SEG="MO2",$P(SEG,U,10)=$P(TYPE,"^",1)_"^~"
 S $P(SEG,"^",2,4)=FMSPODAT
 I $P(TYPE,"^",2)="SO",PRCFA("MP")=2 S $P(SEG,U,11)="C"
 S:$P(SEG,U,$L(SEG,U))'="~" SEG=SEG_"^~"
 K PRCTMP
 QUIT SEG
