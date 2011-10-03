PXRMORXR ; SLC/AGP - Reminder Order Checks XREF;04/16/2010
 ;;2.0;CLINICAL REMINDERS;**16**;Feb 04, 2005;Build 119
 ;
 Q
 ;
 ;for the rules X(1)=RULE NAME, X(2)=ACTIVE FLAG, X(3)=TESTING FLAG
 ;
 ;FORMAT OF XREF ^PXD(801,"AOIR",OI,TEST,GIEN,RULEIEN)=""
 ;
AOIRCHK ;
 N ACTIVE,CNT,GIEN,GNAME,OI,OINAME,OUTPUT,RIEN,RNAME,TEST,TEXTIN
 ;start from AOIR xref
 S CNT=0,OI=0
 F  S OI=$O(^PXD(801,"AOIR",OI)) Q:OI'>0  D
 .S OINAME=$P(^ORD(101.43,OI,0),U)
 .I '$D(^PXD(801,"O",OI)) D  Q
 ..K TEXTIN
 ..S TEXTIN(1)="Orderable item : "_OINAME_" does not exist in the Reminder Orderable Item Group file."
 ..D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 .S TEST=0 F  S TEST=$O(^PXD(801,"AOIR",OI,TEST)) Q:TEST'>0  D
 ..S GIEN=0 F  S GIEN=$O(^PXD(801,"AOIR",OI,TEST,GIEN)) Q:GIEN'>0  D
 ...S RIEN=0
 ...F  S RIEN=$O(^PXD(801,"AOIR",OI,TEST,GIEN,RIEN)) Q:RIEN'>0  D
 ....D CHKFXR(OI,OINAME,TEST,GIEN,RIEN,.CNT,.OUTPUT)
 ;
 ;check from file structure
 S GIEN=0 F  S GIEN=$O(^PXD(801,GIEN)) Q:GIEN'>0  D
 .S GNAME=$P(^PXD(801,GIEN,0),U)
 .;loop OI multiple for each OI
 .S OI=0 F  S OI=$O(^PXD(801,GIEN,2,"B",OI)) Q:OI'>0  D
 ..S OINAME=$P(^ORD(101.43,OI,0),U)
 ..;
 ..;for each OI check to see if corresponding Rule is in the xref
 ..S RIEN=0 F  S RIEN=$O(^PXD(801,GIEN,3,RIEN)) Q:RIEN'>0  D
 ...S NODE=$G(^PXD(801,GIEN,3,RIEN,0))
 ...S RNAME=$P(NODE,U),ACTIVE=$P(NODE,U,3),TEST=$P(NODE,U,4)
 ...;
 ...;only active entries should be in the xref
 ...I ACTIVE=1 D  Q
 ....I $D(^PXD(801,"AOIR",OI,TEST,GIEN,RIEN)) Q
 ....K TEXTIN
 ....S TEXTIN(1)="Rule "_RNAME_" with an active status and a testing "
 ....S TEXTIN(2)="flag of "_TEST_" assigned to Reminder Orderable Item Group "_GNAME
 ....S TEXTIN(3)=" does not exist in the AOIR xref for Orderable Item "_OINAME
 ....D BUILDMSG(3,.TEXTIN,.CNT,.OUTPUT)
 ...;
 ...;inactive entries should not be in the xref
 ...I $D(^PXD(801,"AOIR",OI,TEST,GIEN,RIEN)) Q
 ...K TEXTIN
 ...S TEXTIN(1)="Rule "_RNAME_" with an inactive status and a testing "
 ...S TEXTIN(2)="flag of "_TEST_" assigned to Reminder Orderable Item Group "_GNAME
 ...S TEXTIN(3)=" exist in the AOIR xref for Orderable Item "_OINAME
 ...D BUILDMSG(3,.TEXTIN,.CNT,.OUTPUT)
 ;
 ;write out the output
 I '$D(OUTPUT) W !,"No errors found" Q
 S CNT=0 F  S CNT=$O(OUTPUT(CNT)) Q:CNT'>0  W !,OUTPUT(CNT)
 Q
 ;
BLDDCOI(DA,SEL,LIST) ;
 ;builds a list of OI associate with drug class NOT being deleted from
 ;the order check group
 N DRCLIEN,DRUGIEN,POIIEN,OIIEN
 S DRCLIEN=""
 F  S DRCLIEN=$O(^PXD(801,DA(1),1.5,"B",DRCLIEN)) Q:DRCLIEN=""  D
 .I DRCLIEN=SEL Q
 .K ^TMP($J,"VAC")
 .D IX^PSSCLINR("VAC",DRCLIEN)
 .I '$D(^TMP($J,"VAC")) Q
 .S DRUGIEN=0
 .F  S DRUGIEN=$O(^TMP($J,"VAC",DRCLIEN,DRUGIEN)) Q:DRUGIEN'>0  D
 ..; DBIA 5187
 ..S POIIEN=$$ITEM^PSSCLINR(DRUGIEN) I POIIEN'>0 Q
 ..S OIIEN=$O(^ORD(101.43,"ID",POIIEN_";99PSP","")) Q:OIIEN'>0
 ..S ^TMP($J,"DRCL LIST",OIIEN)=DRCLIEN
 Q
 ;
BUILDMSG(NIN,TEXTIN,CNT,MESS) ;
 N LINE,NOUT,TEXTOUT
 D FORMAT^PXRMTEXT(1,75,NIN,.TEXTIN,.NOUT,.TEXTOUT)
 S CNT=CNT+1,MESS(CNT)=""
 F LINE=1:1:NOUT S CNT=CNT+1,MESS(CNT)=TEXTOUT(LINE)
 Q
 ;
CHKFXR(OI,OINAME,TEST,GIEN,RIEN,CNT,OUTPUT) ;
 N GNAME,NODE,RNAME,TEXTIN
 I '$D(^PXD(801,GIEN)) D  Q
 .K TEXTIN
 .S TEXTIN(1)="Reminder Orderable Item Group IEN "_GIEN_" does not exist in the file."  Q
 .D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 S GNAME=$P(^PXD(801,GIEN,0),U)
 I '$D(^PXD(801,GIEN,2,"B",OI)) D  Q
 .K TEXTIN
 .S TEXTIN(1)="Orderable Item: "_OINAME_" does not exist in the Reminder Orderable Item File entry "_GNAME_"."
 .D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 I '$D(^PXD(801,GIEN,3,RIEN)) D  Q
 .K TEXTIN
 .S TEXTIN(1)="Rule Ien: "_RIEN_" does not exist in the Reminder Orderable Item File entry "_GNAME_"."
 .D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 S NODE=$G(^PXD(801,GIEN,3,RIEN,0))
 S RNAME=$P(NODE,U)
 I $P(NODE,U,3)=0 D  Q
 .K TEXTIN
 .S TEXTIN(1)="Rule "_RNAME_" assigned to Reminder Orderable Item File entry "_GNAME_" is marked as inactive."
 .D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 I TEST'=$P(NODE,U,4) D  Q
 .K TEXTIN
 .S TEXTIN(1)="Rule "_RNAME_" assigned to Reminder Orderable Item File entry "_GNAME_" status does not match."
 .D BUILDMSG(1,.TEXTIN,.CNT,.OUTPUT)
 Q
 ;
CNDSRULE(DA,OLD,NEW) ;
 I OLD(1)="",NEW(1)'="" Q 1
 I OLD(2)'=NEW(2) Q 1
 I OLD(3)'=NEW(3) Q 1
 Q 0
 ;
CNDKRULE(DA,OLD,NEW) ;
 I NEW(1)'="",NEW(1)="" Q 1
 I OLD(2)'=NEW(2) Q 1
 I OLD(3)'=NEW(3) Q 1
 Q
 ;
DELDRCL(IENS,OLD) ;
 ;This subroutine allows users to add delete orderable item that are
 ;assigned to a drug class
 I IENS(1)="" Q
 I $G(PXRMDALL)=1 Q
 I $G(DIUTIL)="VERIFY FIELDS" Q
 I $G(OLD)="" Q
 N DA,DRCLNAME,DRGIEN,DRUGIEN,DIK,OIIEN,OINAME,POIIEN,TEXT,Y
 K ^TMP($J,"DRCL LIST")
 S DA(1)=IENS(1)
 S DIK="^PXD(801,"_DA(1)_",2,"
 S DRGIEN=OLD
 I DRGIEN'>0 Q
 ;Build list of OI belonging to other Drug Classes
 D BLDDCOI(.DA,DRGIEN,"DRCL LIST") ;
 ; DBIA 5187
 K ^TMP($J,"VAC")
 D IX^PSSCLINR("VAC",DRGIEN)
 I '$D(^TMP($J,"VAC")) Q
 S DRUGIEN=0
 F  S DRUGIEN=$O(^TMP($J,"VAC",DRGIEN,DRUGIEN)) Q:DRUGIEN'>0  D
 .; DBIA 5187
 .S POIIEN=$$ITEM^PSSCLINR(DRUGIEN) I POIIEN'>0 Q
 .S OIIEN=$O(^ORD(101.43,"ID",POIIEN_";99PSP","")) Q:OIIEN'>0
 .I $D(^TMP($J,"DRCL LIST",OIIEN)) D  Q
 ..S OINAME=$P($G(^ORD(101.43,OIIEN,0)),U)
 ..S DRCLNAME="DRCLNAME"
 ..S TEXT(1)="Cannot delete orderable item: "_OINAME_" it is assigned to another drug class "_DRCLNAME_"in this group."
 ..D EN^DDIOL(.TEXT)
 .S DA=$O(^PXD(801,DA(1),2,"B",OIIEN,"")) I DA="" Q
 .D ^DIK
 .S TEXT(1)="Removing Orderable Item: "_$P($G(^ORD(101.43,OIIEN,0)),U)
 .D EN^DDIOL(.TEXT)
 K ^TMP($J,"VAC"),^TMP($J,"DRCL LIST")
 Q
 ;
EXCHINST(NAME) ;
 ;this calls the ADC xref to add OI associated with a drug class
 ;when installing an order check group from exchange
 N CNT,DRCLIEN,IEN
 S IEN(1)=$O(^PXD(801,"B",NAME,"")) Q:IEN(1)'>0
 S CNT=0
 I '$D(^PXD(801,IEN(1),1.5)) Q
 F  S CNT=$O(^PXD(801,IEN(1),1.5,CNT)) Q:CNT'>0  D
 .S DRCLIEN=$P($G(^PXD(801,IEN(1),1.5,CNT,0)),U) I +DRCLIEN=0 Q
 .D IMPDRCL(.IEN,DRCLIEN)
 Q
 ;
IMPDRCL(IENS,NEW) ;
 ;This subroutine automatically add all orderable item that are
 ;assigned to a drug class
 I $G(DIUTIL)="VERIFY FIELDS" Q
 I $G(NEW)="" Q
 I $G(PXRMEXCH)=1 Q
 N DRGIEN,DRUGIEN,FDA,MSG,OIIEN,POIIEN,TEXT,Y
 S DRGIEN=NEW
 ; DBIA 5187
 K ^TMP($J,"VAC")
 D IX^PSSCLINR("VAC",DRGIEN)
 I '$D(^TMP($J,"VAC")) Q
 S DRUGIEN=0
 F  S DRUGIEN=$O(^TMP($J,"VAC",DRGIEN,DRUGIEN)) Q:DRUGIEN'>0  D
 .; DBIA 5187
 .S POIIEN=$$ITEM^PSSCLINR(DRUGIEN) I POIIEN'>0 Q
 .S OIIEN=$O(^ORD(101.43,"ID",POIIEN_";99PSP","")) Q:OIIEN'>0
 .I $G(^ORD(101.43,OIIEN,.1))'="" Q
 .S TEXT(1)="Adding Orderable Item: "_$P($G(^ORD(101.43,OIIEN,0)),U)
 .I $D(^PXD(801,IENS(1),2,"B",OIIEN)) D
 ..S TEXT(1)="Orderable Item: "_$P($G(^ORD(101.43,OIIEN,0)),U)_" already added."
 .D EN^DDIOL(.TEXT)
 .;
 .S FDA(801.02,"?+1,"_IENS(1)_",",.01)=OIIEN
 .D UPDATE^DIE("","FDA","","MSG") I $D(MSG) D AWRITE^PXRMUTIL("MSG") H 2
 .K FDA
 K ^TMP($J,"VAC")
 Q
 ;
OIKAOI(DA,OLD) ;
 N NODE,RIEN
 ;I '$D(^PXD(801,DA(1),3)) Q
 S RIEN=0 F  S RIEN=$O(^PXD(801,DA(1),3,RIEN)) Q:RIEN'>0  D
 .S NODE=$G(^PXD(801,DA(1),3,RIEN,0)) I $P(NODE,U,3)=0 Q
 .I $D(^PXD(801,"AOIR",OLD,$P(NODE,U,4),DA(1),RIEN)) K ^PXD(801,"AOIR",OLD,$P(NODE,U,4),DA(1),RIEN)
 Q
 ;
OISAOI(DA,NEW) ;
 N NODE,RIEN
 ;I '$D(^PXD(801,DA(1),3)) Q
 S RIEN=0 F  S RIEN=$O(^PXD(801,DA(1),3,RIEN)) Q:RIEN'>0  D
 .S NODE=$G(^PXD(801,DA(1),3,RIEN,0)) I $P(NODE,U,3)=0 Q
 .S ^PXD(801,"AOIR",NEW,$P(NODE,U,4),DA(1),RIEN)=""
 Q
 ;
RULEKAOI(DA,OLD) ;
 ;I OLD(1)=""!(OLD(2)="")!(OLD(3)="") Q
 N OI
 S OI=0 F  S OI=$O(^PXD(801,DA(1),2,"B",OI)) Q:OI'>0  D
 .I $D(^PXD(801,"AOIR",OI,OLD(3),DA(1),DA)) K ^PXD(801,"AOIR",OI,OLD(3),DA(1),DA)
 Q
 ;
RULESAOI(DA,NEW) ;
 N OI
 ;I +NEW(2)=0 Q
 ;I $G(NEW(3))="" Q
 N OI
 S OI=0 F  S OI=$O(^PXD(801,DA(1),2,"B",OI)) Q:OI'>0  D
 .S ^PXD(801,"AOIR",OI,NEW(3),DA(1),DA)=""
 Q
 ;
TESTER ;
 N CNT,DFN,DIC,DIROUT,DIRUT,DTOUT,DUOUT,NAME,OI,ONAME,SEV,TEST
 S DIC=2,DIC("A")="Select Patient: ",DIC(0)="AEQMZ" D ^DIC
 I $D(DIROUT)!($D(DIRUT)) Q
 I $D(DTOUT)!($D(DUOUT)) Q
 S DFN=+$P(Y,U)
 S DIC=101.43,DIC("A")="Select Orderable Item: ",DIC(0)="AEQMZ" D ^DIC
 I $D(DIROUT)!($D(DIRUT)) Q
 I $D(DTOUT)!($D(DUOUT)) Q
 S OI=+$P(Y,U)
 W !!
 F TEST=0:1:1 D
 .D ORDERCHK^PXRMORCH(DFN,OI,TEST,1)
 .I '$D(^TMP($J,OI)) W !,"No "_$S(TEST=0:"Production Rules",1:"Testing Rules")_" found." Q
 .W !,$S(TEST=0:"Production Rules:",1:"Testing Rules:")
 .F SEV=3,2,1 D
 ..I '$D(^TMP($J,OI,SEV)) W !,"No rules with a severity of "_$S(SEV=1:"High",SEV=2:"Medium",1:"Low")_" found." Q
 ..W !,$S(SEV=1:"High",SEV=2:"Medium",1:"Low")_" Severity Results:"
 ..S ONAME="",NAME=""
 ..F  S NAME=$O(^TMP($J,OI,SEV,NAME)) Q:NAME=""  D
 ...I NAME'=ONAME S ONAME=NAME W !!,NAME
 ...S CNT=0 F  S CNT=$O(^TMP($J,OI,SEV,NAME,CNT)) Q:CNT'>0  D
 ....W !,^TMP($J,OI,SEV,NAME,CNT)
 Q
 ;
