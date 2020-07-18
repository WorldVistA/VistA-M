PXRMORXR ;SLC/AGP - Reminder Order Checks XREF;Apr 06, 2018@14:36
 ;;2.0;CLINICAL REMINDERS;**16,22,45**;Feb 04, 2005;Build 566
 ;
 Q
 ;
 ;for the rules X(1)=RULE NAME, X(2)=ACTIVE FLAG, X(3)=TESTING FLAG
 ;
 ;FORMAT OF XREF ^PXD(801,"AOIR",OI,TEST,GIEN,RULEIEN)=""
XREFCHK ;
 N ACTIVE,CNT,GIEN,GNAME,OI,OINAME,OUTPUT,RIEN,RNAME,RULES,TEST,TEXTIN,X,Y
 ;start from AOIR xref
 S CNT=0,OI=0
 ;
 ;from the ADRUGR cross-reference
 N IEN,PHARMITM,TYPE
 S TYPE="" F  S TYPE=$O(^PXD(801,"AITEM",TYPE)) Q:TYPE=""  D
 .S IEN=0 F  S IEN=$O(^PXD(801,"AITEM",TYPE,IEN)) Q:IEN'>0  D
 ..S RIEN=0 F  S RIEN=$O(^PXD(801,"AITEM",TYPE,IEN,RIEN)) Q:RIEN'>0  D
 ...D CHKRULE(RIEN,.CNT,.OUTPUT)
 ...S GIEN=0
 ...F  S GIEN=$O(^PXD(801,"AITEM",TYPE,IEN,RIEN,GIEN)) Q:GIEN'>0  D
 ....I '$D(^PXD(801,GIEN)) D  Q
 .....K TEXTIN
 .....S TEXTIN(1)="Reminder Orderable Item Group IEN "_GIEN_" does not exist in the file."  Q
 .....D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 ....D CHKGDR(GIEN,TYPE,IEN,RIEN,.CNT,.OUTPUT)
 ;
 ;check from file structure
 S GIEN=0 F  S GIEN=$O(^PXD(801,GIEN)) Q:GIEN'>0  D
 .K RULES
 .S Y=0 F  S Y=$O(^PXD(801,GIEN,3,Y)) Q:Y'>0  D
 ..S RIEN=+$G(^PXD(801,GIEN,3,Y,0)) I RIEN=0 Q
 ..S RULES(RIEN)=""
 .I '$D(RULES) Q
 .S X=0 F  S X=$O(^PXD(801,GIEN,1.5,X)) Q:X'>0  D
 ..S ITEM=$G(^PXD(801,GIEN,1.5,X,0)) Q:ITEM=""
 ..D CHKXFRF(GIEN,ITEM,"AITEM",.RULES,.CNT,.OUTPUT)
 ;
 D CHKGROUP(.CNT,.OUTPUT)
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
CHKGROUP(CNT,OUTPUT) ;
 N GIEN,ICNT,ITEM,ITMNAME,OCINCNT,OCIOCNT,TEXTIN,X
 S GIEN=0 F  S GIEN=$O(^PXD(801,GIEN)) Q:GIEN'>0  D
 .S ICNT=0,X=0 F  S X=$O(^PXD(801,GIEN,1.5,X)) Q:X'>0  D
 ..S ITEM=$G(^PXD(801,GIEN,1.5,X,0)) Q:ITEM=""
 ..S ICNT=ICNT+1
 ..S ITMNAME=$$GETOCINM^PXRMOCG(ITEM)
 ..I '$D(^PXD(801,GIEN,1.5,"OCIO",ITMNAME,X)) D
 ...S TEXTIN(1)="Group: "_GIEN_" item: "_ITEM_" cannot be found in xref OCIO"
 ...D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 ..I '$D(^PXD(801,GIEN,1.5,"OCIN",X)) D  Q
 ...S TEXTIN(1)="Group: "_GIEN_" item: "_X_" cannot be found in xref OCIN"
 ...D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 ..I $G(^PXD(801,GIEN,1.5,"OCIN",X))'=ITMNAME D
 ...S TEXTIN(1)="Group: "_GIEN_" item: "_X_" value "_$G(^PXD(801,GIEN,1.5,"OCIN",X))_" does not match "_ITMNAME
 ...D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 .;count indexes
 .S OCINCNT=0,X=0
 .W !,OCINCNT
 .F  S X=$O(^PXD(801,GIEN,1.5,"OCIN",X)) Q:X'>0  S OCINCNT=OCINCNT+1
 .I ICNT'=OCINCNT D
 ..S TEXTIN(1)="Group: "_GIEN_" Item multiple total number of items "_ICNT_" does not match the OCIN xref total number of items "_OCINCNT
 ..D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 .S OCIOCNT=0,X=""
 .F  S X=$O(^PXD(801,GIEN,1.5,"OCIO",X)) Q:X=""  S OCIOCNT=OCIOCNT+1
 .I ICNT'=OCIOCNT D
 ..S TEXTIN(1)="Group: "_GIEN_" Item multiple total number of items "_ICNT_" does not match the OCIO xref total number of items "_OCIOCNT
 ..D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 Q
 ;
CHKXFRF(GIEN,ITEM,NODE,RULES,CNT,OUTPUT) ;
 N IEN,NAME,PIEN,TYPE
 I ITEM[";" S TYPE=$$GETTYPE(ITEM),PIEN=+ITEM I TYPE="" Q
 S IEN=0 F  S IEN=$O(RULES(IEN)) Q:IEN'>0  D
 .I $D(^PXD(801,"AITEM",TYPE,PIEN,IEN,GIEN)) Q
 .K TEXTIN
 .S TEXTIN(1)="ERROR IN AITEM CROSS-REFERENCE"
 .S TEXTIN(2)="Rule ien: "_IEN_", Item ien: "_ITEM_", Group IEN: "_GIEN
 .S TEXTIN(3)=" does not exist in the AITEM xref"
 .D BUILDMSG(3,.TEXTIN,.CNT,.OUTPUT)
 Q
 ;
CHKGDR(GIEN,TYPE,IEN,RIEN,CNT,OUTPUT) ;
 N FOUND,GNAME,ITEM,TEXTIN,X
 S GNAME=$P(^PXD(801,GIEN,0),U)
 S ITEM=IEN_$$GETFILE(TYPE)
 I ITEM'[";" Q
 I '$D(^PXD(801,GIEN,1.5,"B",ITEM)) D
 .S TEXTIN(1)="Item: "_ITEM_" does not exist in the Reminder Orderable Item Group File entry."
 .D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 I '$D(^PXD(801,GIEN,3,"B",RIEN)) D
 .S TEXTIN(1)="Rule: "_RIEN_" does not exist in the Reminder Orderable Item Group File entry node 3 B xref."
 .D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 S FOUND=0,X=0 F  S X=$O(^PXD(801,GIEN,3,X)) Q:X'>0!(FOUND=1)  D
 .I +$G(^PXD(801,GIEN,3,X,0))=RIEN S FOUND=1
 I FOUND=0 D
 .S TEXTIN(1)="Rule: "_RIEN_" does not exist in the Reminder Orderable Item Group File entry node 3."
 .D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 Q
 ;
CHKRULE(RIEN,CNT,OUTPUT) ;
 N NODE,RNAME,TEXTIN
 I $D(^PXD(801.1,RIEN)) Q
 S TEXTIN(1)="Rule Ien: "_RIEN_" does not exist in the Reminder Order Check Rule File entry."
 D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 Q
 ;
 ;DRUGKILL(DA,OLD) ;
 ;N IEN,RIEN,TYPE
 ;S TYPE=$$GETTYPE(OLD)
 ;I TYPE="" Q
 ;S IEN=0 F  S IEN=$O(^PXD(801,DA(1),3,IEN)) Q:IEN'>0  D
 ;.S RIEN=$P($G(^PXD(801,DA(1),3,IEN,0)),U) I +RIEN'>0 Q
 ;.I $D(^PXD(801,"ADRUGR",TYPE,+OLD,RIEN,DA(1))) K ^PXD(801,"ADRUGR",TYPE,+OLD,RIEN,DA(1))
 ;Q
 ;
 ;DRUGSET(DA,NEW) ;
 ;N RIEN,TYPE
 ;S TYPE=$$GETTYPE(NEW)
 ;I TYPE="" Q
 ;S RIEN=0 F  S RIEN=$O(^PXD(801,DA(1),3,"B",RIEN)) Q:RIEN'>0  D
 ;.S ^PXD(801,"ADRUGR",TYPE,+NEW,RIEN,DA(1))=""
 ;Q
 ;
 ;DRUGKWH ;
 ;K ^PXD(801,"ADRUGR")
 ;Q
 ;
ITEMKILL(DA,OLD) ;
 N IEN,RIEN,TYPE
 S TYPE=$$GETTYPE(OLD)
 I TYPE="" Q
 S IEN=0 F  S IEN=$O(^PXD(801,DA(1),3,IEN)) Q:IEN'>0  D
 .S RIEN=$P($G(^PXD(801,DA(1),3,IEN,0)),U) I +RIEN'>0 Q
 .I $D(^PXD(801,"AITEM",TYPE,+OLD,RIEN,DA(1))) K ^PXD(801,"AITEM",TYPE,+OLD,RIEN,DA(1))
 Q
 ;
ITEMSET(DA,NEW) ;
 N RIEN,TYPE
 S TYPE=$$GETTYPE(NEW)
 I TYPE="" Q
 S RIEN=0 F  S RIEN=$O(^PXD(801,DA(1),3,"B",RIEN)) Q:RIEN'>0  D
 .S ^PXD(801,"AITEM",TYPE,+NEW,RIEN,DA(1))=""
 Q
 ;
ITEMKWH ;
 K ^PXD(801,"AITEM")
 Q
 ;
 ;OIKAOI(DA,OLD) ;
 ;N IEN,RIEN
 ;;I '$D(^PXD(801,DA(1),3)) Q
 ;S IEN=0 F  S IEN=$O(^PXD(801,DA(1),3,IEN)) Q:IEN'>0  D
 ;.S RIEN=$P($G(^PXD(801,DA(1),3,IEN,0)),U) I +RIEN'>0 Q
 ;.I $D(^PXD(801,"AOIR",OLD,RIEN,DA(1))) K ^PXD(801,"AOIR",OLD,RIEN,DA(1))
 ;Q
 ;
 ;OISAOI(DA,NEW) ;
 ;N RIEN
 ;;I '$D(^PXD(801,DA(1),3)) Q
 ;S RIEN=0 F  S RIEN=$O(^PXD(801,DA(1),3,"B",RIEN)) Q:RIEN'>0  D
 ;.S ^PXD(801,"AOIR",NEW,RIEN,DA(1))=""
 ;Q
 ;
GETTYPE(TYPE) ;
 N RESULT
 S RESULT=$S(TYPE["PSDRUG":"DR",$P(TYPE,";",2)="PSNDF(50.6,":"DG",TYPE["PS(50.605":"DC",TYPE["RA(79.2":"RA",TYPE["ORD(101.43":"OI",$P(TYPE,";",2)="PSNDF(50.68,":"DP",1:"")
 Q RESULT
 ;
GETFILE(TYPE) ;
 Q $S(TYPE="DR":";PSDRUG(",TYPE="DC":";PS(50.605,",TYPE="DG":";PSNDF(50.6,",TYPE="RA":";RA(79.2,",TYPE="OI":";ORD(101.43,",TYPE="DP":";PSNDF(50.68,",1:"")
 ;
RULEKITM(DA,OLD) ;
 ;I OLD(1)=""!(OLD(2)="")!(OLD(3)="") Q
 N DIEN,OI,TYPE
 ;kill AITEM index off
 ; kill Item Index off
 S DIEN="" F  S DIEN=$O(^PXD(801,DA(1),1.5,"B",DIEN)) Q:DIEN=""  D
 .S TYPE=$$GETTYPE(DIEN)
 .I TYPE="" Q
 .I $D(^PXD(801,"AITEM",TYPE,+DIEN,OLD(1),DA(1))) K ^PXD(801,"AITEM",TYPE,+DIEN,OLD(1),DA(1))
 Q
 ;
RULESITM(DA,NEW) ;
 N DIEN,OI,TYPE
 ;set AITEM index
 S DIEN="" F  S DIEN=$O(^PXD(801,DA(1),1.5,"B",DIEN)) Q:DIEN=""  D
 .S TYPE=$$GETTYPE(DIEN)
 .I TYPE="" Q
 .S ^PXD(801,"AITEM",TYPE,+DIEN,NEW(1),DA(1))=""
 Q
 ;
TESTER ;
 N CNT,DFN,DIC,DIROUT,DIRUT,DRUG,DTOUT,DUOUT,NAME,OI,ONAME,SEV,SUB,TEST,Y,X
 S DIC=2,DIC("A")="Select Patient: ",DIC(0)="AEQMZ" D ^DIC
 I $D(DIROUT)!($D(DIRUT)) Q
 I $D(DTOUT)!($D(DUOUT)) Q
 S DFN=+$P(Y,U) I DFN<=0 W !,"A Patient is required." Q
 S OI=0,DRUG=0
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
