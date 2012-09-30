PXRMORXR ; SLC/AGP - Reminder Order Checks XREF;01/27/2012
 ;;2.0;CLINICAL REMINDERS;**16,22**;Feb 04, 2005;Build 160
 ;
 Q
 ;
 ;for the rules X(1)=RULE NAME, X(2)=ACTIVE FLAG, X(3)=TESTING FLAG
 ;
DELDRCL(IENS,OLD) ;
 ;This subroutine allows users to add delete orderable item that are
 ;THIS IS NO LONGER NEEDED AFTER PATCH 22 IS INSTALLED
 I IENS(1)="" Q
 I $G(PXRMDALL)=1 Q
 I $G(DIUTIL)="VERIFY FIELDS" Q
 I $G(OLD)="" Q
 Q
 ;
 ;FORMAT OF XREF ^PXD(801,"AOIR",OI,TEST,GIEN,RULEIEN)=""
XREFCHK ;
 N ACTIVE,CNT,GIEN,GNAME,OI,OINAME,OUTPUT,RIEN,RNAME,RULES,TEST,TEXTIN
 ;start from AOIR xref
 S CNT=0,OI=0
 F  S OI=$O(^PXD(801,"AOIR",OI)) Q:OI'>0  D
 .S OINAME=$P(^ORD(101.43,OI,0),U)
 .I '$D(^PXD(801,"O",OI)) D  Q
 ..K TEXTIN
 ..S TEXTIN(1)="Orderable item : "_OINAME_" does not exist in the Reminder Orderable Item Group file."
 ..D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 .S RIEN=0
 .F  S RIEN=$O(^PXD(801,"AOIR",OI,RIEN)) Q:RIEN'>0  D
 ..D CHKRULE(RIEN,.CNT,.OUTPUT)
 ..S GIEN=0 F  S GIEN=$O(^PXD(801,"AOIR",OI,RIEN,GIEN)) Q:GIEN'>0  D
 ...I '$D(^PXD(801,GIEN)) D  Q
 ....K TEXTIN
 ....S TEXTIN(1)="Reminder Orderable Item Group IEN "_GIEN_" does not exist in the file."  Q
 ....D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 ;
 ;from the ADRUGR cross-reference
 N IEN,PHARMITM,TYPE
 S TYPE="" F  S TYPE=$O(^PXD(801,"ADRUGR",TYPE)) Q:TYPE=""  D
 .S IEN=0 F  S IEN=$O(^PXD(801,"ADRUGR",TYPE,IEN)) Q:IEN'>0  D
 ..S PHARMITM(TYPE,IEN)=""
 ..S RIEN=0 F  S RIEN=$O(^PXD(801,"ADRUGR",TYPE,IEN,RIEN)) Q:RIEN'>0  D
 ...D CHKRULE(RIEN,.CNT,.OUTPUT)
 ...S GIEN=0
 ...F  S GIEN=$O(^PXD(801,"ADRUG",TYPE,IEN,RIEN,GIEN)) Q:GIEN'>0  D
 ....I '$D(^PXD(801,GIEN)) D  Q
 .....K TEXTIN
 .....S TEXTIN(1)="Reminder Orderable Item Group IEN "_GIEN_" does not exist in the file."  Q
 .....D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 ....D CHKGDR(GIEN,.PHARMITM,.CNT,.OUTPUT)
 ;
 ;check from file structure
 S GIEN=0 F  S GIEN=$O(^PXD(801,GIEN)) Q:GIEN'>0  D
 .;build list of rules
 .S RIEN=0 F  S RIEN=$O(^PXD(801,GIEN,3,RIEN)) Q:RIEN'>0  S RULES(RIEN)=""
 .;loop OI multiple for each OI
 .S OI=0 F  S OI=$O(^PXD(801,GIEN,2,"B",OI)) Q:OI'>0  D
 ..D CHKXFRF(GIEN,OI,"AOIR",.RULES)
 ;
 ;write out the output
 I '$D(OUTPUT) W !,"No errors found" Q
 S CNT=0 F  S CNT=$O(OUTPUT(CNT)) Q:CNT'>0  W !,OUTPUT(CNT)
 Q
 ;
BUILDMSG(NIN,TEXTIN,CNT,MESS) ;
 N LINE,NOUT,TEXTOUT
 D FORMAT^PXRMTEXT(1,75,NIN,.TEXTIN,.NOUT,.TEXTOUT)
 S CNT=CNT+1,MESS(CNT)=""
 F LINE=1:1:NOUT S CNT=CNT+1,MESS(CNT)=TEXTOUT(LINE)
 Q
 ;
CHKXFRF(GIEN,ITEM,NODE,RULES) ;
 N IEN,NAME,PIEN,TYPE
 I ITEM[";" D  I TYPE="" Q
 .S TYPE=$S(ITEM["PSDRUG":"DR",ITEM["PSNDF(50.6":"DG",ITEM["PS(50.605":"DC",1:"")
 .S PIEN=+ITEM
 S IEN=0 F  S IEN=$O(RULES(IEN)) Q:IEN'>0  D
 .I NODE="AOIR" D  Q
 ..I $D(^PXD(801,"AOIR",ITEM,RIEN,GIEN)) D
 ...K TEXTIN
 ...S TEXTIN(1)="ERROR IN AOIR CROSS-REFERENCE"
 ...S TEXTIN(2)="Rule ien: "_IEN_", OI ien: "_ITEM_", Group IEN: "_GIEN
 ...S TEXTIN(3)=" does not exist in the AOIR xref"
 ...D BUILDMSG(3,.TEXTIN,.CNT,.OUTPUT)
 .I $D(^PXD(801,"ADRUGR",TYPE,PIEN,RIEN,GIEN)) Q
 .K TEXTIN
 .S TEXTIN(1)="ERROR IN ADRUGR CROSS-REFERENCE"
 .S TEXTIN(2)="Rule ien: "_IEN_", Item ien: "_ITEM_", Group IEN: "_GIEN
 .S TEXTIN(3)=" does not exist in the ADRUGR xref"
 .D BUILDMSG(3,.TEXTIN,.CNT,.OUTPUT)
 Q
 ;
CHKGDR(GIEN,PHARMITM,CNT,OUTPUT) ;
 N GNAME,IEN,ITEM,TYPE
 S GNAME=$P(^PXD(801,GIEN,0),U)
 S TYPE="" F  S TYPE=$O(PHARMITM(TYPE)) Q:TYPE=""  D
 .S IEN=0 F  S IEN=$O(PHARMITM(TYPE,IEN)) Q:IEN'>0  D
 ..S ITEM=IEN_$S(TYPE="DR":";PSDRUG(",TYPE="DC":";PS(50.605",TYPE="DG":";PSNDF(50.6,",1:"")
 ..I ITEM'[";" Q
 ..I $D(^PXD(801,GIEN,1.5,"B",ITEM)) Q
 ..S TEXTIN(1)="Item: "_ITEM_" does not exist in the Reminder Orderable Item Group File entry."
 ..D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 Q
 ;
CHKRULE(RIEN,CNT,OUTPUT) ;
 N NODE,RNAME,TEXTIN
 I $D(^PXD(801.1,RIEN)) Q
 S TEXTIN(1)="Rule Ien: "_RIEN_" does not exist in the Reminder Order Check Rule File entry."
 D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 Q
 ;
DRUGKILL(DA,OLD) ;
 N IEN,RIEN,TYPE
 S TYPE=$S(OLD["PSDRUG":"DR",OLD["PSNDF(50.6":"DG",OLD["PS(50.605":"DC",1:"")
 I TYPE="" Q
 S IEN=0 F  S IEN=$O(^PXD(801,DA(1),3,IEN)) Q:IEN'>0  D
 .S RIEN=$P($G(^PXD(801,DA(1),3,IEN,0)),U) I +RIEN'>0 Q
 .I $D(^PXD(801,"ADRUGR",TYPE,+OLD,RIEN,DA(1))) K ^PXD(801,"ADRUGR",TYPE,+OLD,RIEN,DA(1))
 Q
 ;
DRUGSET(DA,NEW) ;
 N RIEN,TYPE
 ;I '$D(^PXD(801,DA(1),3)) Q
 S TYPE=$S(NEW["PSDRUG":"DR",NEW["PSNDF(50.6":"DG",NEW["PS(50.605":"DC",1:"")
 I TYPE="" Q
 S RIEN=0 F  S RIEN=$O(^PXD(801,DA(1),3,"B",RIEN)) Q:RIEN'>0  D
 .S ^PXD(801,"ADRUGR",TYPE,+NEW,RIEN,DA(1))=""
 Q
 ;
OIKAOI(DA,OLD) ;
 N IEN,RIEN
 ;I '$D(^PXD(801,DA(1),3)) Q
 S IEN=0 F  S IEN=$O(^PXD(801,DA(1),3,IEN)) Q:IEN'>0  D
 .S RIEN=$P($G(^PXD(801,DA(1),3,IEN,0)),U) I +RIEN'>0 Q
 .I $D(^PXD(801,"AOIR",OLD,RIEN,DA(1))) K ^PXD(801,"AOIR",OLD,RIEN,DA(1))
 Q
 ;
OISAOI(DA,NEW) ;
 N RIEN
 ;I '$D(^PXD(801,DA(1),3)) Q
 S RIEN=0 F  S RIEN=$O(^PXD(801,DA(1),3,"B",RIEN)) Q:RIEN'>0  D
 .S ^PXD(801,"AOIR",NEW,RIEN,DA(1))=""
 Q
 ;
RULEKAOI(DA,OLD) ;
 ;I OLD(1)=""!(OLD(2)="")!(OLD(3)="") Q
 N DIEN,OI,TYPE
 ;kill OI index off
 S OI=0 F  S OI=$O(^PXD(801,DA(1),2,"B",OI)) Q:OI'>0  D
 .I $D(^PXD(801,"AOIR",OI,OLD(1),DA(1))) K ^PXD(801,"AOIR",OI,OLD(1),DA(1))
 ; kill Drug Item Index off
 S DIEN="" F  S DIEN=$O(^PXD(801,DA(1),1.5,"B",DIEN)) Q:DIEN=""  D
 .S TYPE=$S(DIEN["PSDRUG":"DR",DIEN["PSNDF(50.6":"DG",DIEN["PS(50.605":"DC",1:"")
 .I TYPE="" Q
 .I $D(^PXD(801,"ADRUGR",TYPE,+DIEN,OLD(1),DA(1))) K ^PXD(801,"ADRUGR",TYPE,+DIEN,OLD(1),DA(1))
 Q
 ;
RULESAOI(DA,NEW) ;
 N DIEN,OI,TYPE
 ;set OI index
 S OI=0 F  S OI=$O(^PXD(801,DA(1),2,"B",OI)) Q:OI'>0  D
 .S ^PXD(801,"AOIR",OI,NEW(1),DA(1))=""
 ;set Drug Item Index
 S DIEN="" F  S DIEN=$O(^PXD(801,DA(1),1.5,"B",DIEN)) Q:DIEN=""  D
 .S TYPE=$S(DIEN["PSDRUG":"DR",DIEN["PSNDF(50.6":"DG",DIEN["PS(50.605":"DC",1:"")
 .I TYPE="" Q
 .S ^PXD(801,"ADRUGR",TYPE,+DIEN,NEW(1),DA(1))=""
 Q
 ;
TESTER ;
 N CNT,DFN,DIC,DIROUT,DIRUT,DRUG,DTOUT,DUOUT,NAME,OI,ONAME,SEV,SUB,TEST
 S DIC=2,DIC("A")="Select Patient: ",DIC(0)="AEQMZ" D ^DIC
 I $D(DIROUT)!($D(DIRUT)) Q
 I $D(DTOUT)!($D(DUOUT)) Q
 S OI=0,DRUG=0
 S DFN=+$P(Y,U)
 W !,"Select an Orderable Item or press ENTER to select a Drug."
 S DIC=101.43,DIC("A")="Select Orderable Item: ",DIC(0)="AEQMZ" D ^DIC
 I $D(DIROUT)!($D(DIRUT)) Q
 I $D(DTOUT)!($D(DUOUT)) Q
 S OI=+$P(Y,U)
 I +OI'>0 D
 .S DIC=50,DIC("A")="Select Drug: ",DIC(0)="AEQMZ" D ^DIC
 .I $D(DIROUT)!($D(DIRUT)) Q
 .I $D(DTOUT)!($D(DUOUT)) Q
 .S DRUG=+$P(Y,U)
 I OI'>0,DRUG'>0 W !,"An Orderable Item or a Drug is required." Q
 W !!
 S SUB=$S(DRUG>0:DRUG,1:OI)
 F TEST=0:1:1 D
 .D ORDERCHK^PXRMORCH(DFN,OI,TEST,DRUG,1)
 .I '$D(^TMP($J,SUB)) W !,"No "_$S(TEST=0:"Production Rules",1:"Testing Rules")_" found." Q
 .W !,$S(TEST=0:"Production Rules:",1:"Testing Rules:")
 .F SEV=3,2,1 D
 ..I '$D(^TMP($J,SUB,SEV)) W !,"No rules with a severity of "_$S(SEV=1:"High",SEV=2:"Medium",1:"Low")_" found." Q
 ..W !,$S(SEV=1:"High",SEV=2:"Medium",1:"Low")_" Severity Results:"
 ..S ONAME="",NAME=""
 ..F  S NAME=$O(^TMP($J,SUB,SEV,NAME)) Q:NAME=""  D
 ...I NAME'=ONAME S ONAME=NAME W !!,NAME
 ...S CNT=0 F  S CNT=$O(^TMP($J,SUB,SEV,NAME,CNT)) Q:CNT'>0  D
 ....W !,^TMP($J,SUB,SEV,NAME,CNT)
 Q
 ;
