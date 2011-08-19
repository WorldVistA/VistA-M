GMRAGUI1 ;SLC/DAN - CPRS GUI support ;2/9/09  09:45
 ;;4.0;Adverse Reaction Tracking;**21,25,36,38,42**;Mar 29, 1996;Build 4
 ;
 Q
EN1 ; GETREC, cont'd
OBSV ;  Get OBSERVATIONS from file 120.85
 S STRING="~OBSERVATIONS" D NEXT
 S OBSIEN=0
OBSLOOP S OBSIEN=$O(^GMR(120.85,"C",GMRAIEN,OBSIEN)) G:OBSIEN<1 EXIT
 S GMRA(1)=$G(^GMR(120.85,OBSIEN,0)) Q:'$L(GMRA(1))
 S STRING="tRecord            : "_OBSIEN D NEXT
 S USRNAM=""
 S USR=$P(GMRA(1),U,13) I USR'="" D GETUSR
 S Y=$P(GMRA(1),U,1) X ^DD("DD")
 S STRING="tDate/Time of Event: "_Y D NEXT
 S STRING="tObserver          : "_USRNAM D NEXT
 S SEVCOD=$P(GMRA(1),U,14)
 S SEVER=$S(SEVCOD=1:"MILD",SEVCOD=2:"MODERATE",SEVCOD=3:"SEVERE",1:"")
 S STRING="tSeverity          : "_SEVER D NEXT
 S Y=$P(GMRA(1),U,18) X ^DD("DD")
 S STRING="tDate Reported     : "_Y D NEXT
 S USRNAM=""
 S USR=$P(GMRA(1),U,19) I USR'="" D GETUSR
 S STRING="tReporting User    : "_USRNAM D NEXT
 S STRING="t" F I=1:1:60 S STRING=STRING_"-"
 D NEXT
 G OBSLOOP
EXIT Q
NEXT ;SET ARRAY NODE AND INCREMENT ARRAY COUNTER
 S @GMRARRAY@(ND)=STRING,ND=ND+1,STRING=""
 Q
GETUSR S USRNAM=$$GET1^DIQ(200,USR_",",".01")
 Q
 ;
EIE(GMRAIEN,GMRADFN,GMRARRAY) ;Mark individual entry as entered in error
 N DIE,DA,DR,Y,DIK,DFN,OROLD,VAIN,X,GMRAOUT,GMRAPA
 L +^XTMP("GMRAED",GMRADFN):1 I '$T D MESS Q
 S GMRAPA=GMRAIEN
 S DIE="^GMR(120.8,",DA=GMRAPA,DR="15///1;22///1;23///"_@GMRARRAY@("GMRAERRDT")_";24////"_$G(@GMRARRAY@("GMRAERRBY"),.5) ;36
 D ^DIE ;Entered in error on date/time by user
 I $D(@GMRARRAY@("GMRAERRCMTS")) D ADCOM(GMRAPA,"E",$NA(@GMRARRAY@("GMRAERRCMTS"))) ;add comments
 I $$NKASCR^GMRANKA($P(^GMR(120.8,GMRAPA,0),U)) D
 .S DIK="^GMR(120.86,",DA=$P(^GMR(120.8,GMRAPA,0),U)
 .D ^DIK ;If patient's last allergy marked as entered in error then delete assessment
 S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 S GMRAOUT=0
 D EN1^GMRAEAB ;Sends entered in error bulletin to appropriate mail groups
 D EN1^GMRAPET0(GMRADFN,GMRAPA,"E",.GMRAOUT) ;21 File Progress Note
 S DFN=GMRADFN
 D INP^VADPT S X=$$FIND1^DIC(101,,"BX","GMRA ENTERED IN ERROR")_";ORD(101,"
 D:X EN^XQOR ;Process protocols hanging off of "entered in error" protocol
 L -^XTMP("GMRAED",GMRADFN)
 S ORY=0_$S(+$G(GMRAPN)>0:("^"_+$G(GMRAPN)),1:"") ;38 Return IEN of progress note if created
 Q
 ;
ADCOM(ENTRY,TYPE,GMRACOM) ;Add comments to allergies
 ;
 N FDA,GMRAI,X,DIWL,DIWR
 K ^UTILITY($J,"W") S DIWL=1,DIWR=60 S GMRAI=0 F  S GMRAI=$O(@GMRACOM@(GMRAI)) Q:'+GMRAI  S X=@GMRACOM@(GMRAI) D ^DIWP
 S GMRACOM="^UTILITY($J,""W"",1)"
 S FDA(120.826,"+1,"_ENTRY_",",.01)=$$NOW^XLFDT
 S FDA(120.826,"+1,"_ENTRY_",",1)=DUZ
 S FDA(120.826,"+1,"_ENTRY_",",1.5)=TYPE
 S FDA(120.826,"+1,"_ENTRY_",",2)=GMRACOM
 D UPDATE^DIE("","FDA")
 Q
 ;
NKA ;Change patient assessment to NKA
 ;
 N DA,DR,DIE,NKA,DFN
 S DFN=ORDFN
 L +^XTMP("GMRAED",DFN):1 I '$T D MESS Q
 S NKA=$$NKA^GMRANKA(DFN)
 I NKA=0 Q  ;Patient is already NKA
 I NKA=1 S ORY="-1^Patient has active allergies - can't mark as NKA" Q
 L +^GMR(120.86,0):5 I '$T S ORY="-1^Unable to update assessment - try again." Q
 I '$D(^GMR(120.86,DFN,0)) D  ;Add assessment entry
 .S $P(^GMR(120.86,0),U,3,4)=(DFN_"^"_($P(^GMR(120.86,0),U,4)+1))
 .S ^GMR(120.86,DFN,0)=DFN_U,^GMR(120.86,"B",DFN,DFN)=""
 L -^GMR(120.86,0) L +^GMR(120.86,DFN,0):5 I '$T S ORY="-1^Unable to update assessment - try again." Q
 S DIE="^GMR(120.86,",DA=DFN,DR="1////0;2////"_DUZ_";3///NOW" D ^DIE
 S ORY=0
 L -^XTMP("GMRAED",DFN)
 Q
 ;
UPDATE(GMRAIEN,DFN,GMRARRAY) ;Add/edit allergies
 N NEW,NKA,FDA,NODE,IEN,SUB,FILE,DA,DIK,SIEN,GMRAS0,GMRAIEN,GMRAL,GMRAPA,GMRAAR,GMRALL,GMRADFN,GMRAOUT,GMRAROT,GMRAPN
 S NEW='$G(GMRAIEN)
 I NEW,$$DUPCHK^GMRAOR0(DFN,$P(@GMRARRAY@("GMRAGNT"),U))=1 S ORY="-1^Patient already has a "_$P(@GMRARRAY@("GMRAGNT"),U)_" reaction entered.  No duplicates allowed." Q
 L +^XTMP("GMRAED",DFN):1 I '$T D MESS Q
 D SITE^GMRAUTL S GMRASITE(0)=$G(^GMRD(120.84,+GMRASITE,0))
 S NKA='$$NKA^GMRANKA(DFN) ;is patient NKA?
 I NKA,NEW D
 .S FDA(120.86,"?+"_DFN_",",.01)=DFN
 .S FDA(120.86,"?+"_DFN_",",1)=1
 .S FDA(120.86,"?+"_DFN_",",2)=DUZ
 .S FDA(120.86,"?+"_DFN_",",3)=$G(@GMRARRAY@("GMRAORDT"),$$NOW^XLFDT)
 .S IEN(DFN)=DFN
 .D UPDATE^DIE("","FDA","IEN")
 K FDA,IEN
 S NODE=$S($G(NEW):"+1,",1:(GMRAIEN_","))
 S:$G(NEW) FDA(120.8,NODE,.01)=DFN
 I $P($G(@GMRARRAY@("GMRAGNT")),U,2)["50.67" S $P(@GMRARRAY@("GMRAGNT"),U,2)=$$TGTOG^PSNAPIS($P(@GMRARRAY@("GMRAGNT"),U))_";PSNDF(50.6,"
 F SUB="GMRAGNT;.02","GMRATYPE;3.1","GMRANATR;17","GMRAORIG;5","GMRAORDT;4","GMRAOBHX;6" D
 .S FDA(120.8,NODE,$P(SUB,";",2))=$P(@GMRARRAY@($P(SUB,";")),U)
 .I (SUB["GMRAGNT"),NEW S FDA(120.8,NODE,1)=$P(@GMRARRAY@($P(SUB,";")),U,2)
 D UPDATE^DIE("","FDA","IEN")
 S:NEW GMRAIEN=IEN(1)
 K FDA
 F SUB="GMRACHT","GMRAIDBN" D
 .Q:'$D(@GMRARRAY@(SUB))  ;Stop if no updates
 .S FILE=$S(SUB="GMRACHT":120.813,1:120.814)
 .S FDA(FILE,"+1,"_GMRAIEN_",",.01)=@GMRARRAY@(SUB,1)
 .S FDA(FILE,"+1,"_GMRAIEN_",",1)=DUZ
 .D UPDATE^DIE("","FDA")
 I $D(@GMRARRAY@("GMRACMTS")) D ADCOM(GMRAIEN,"O",$NA(@GMRARRAY@("GMRACMTS"))) ;Add comments if included
 K FDA
 S SUB=0 F  S SUB=$O(@GMRARRAY@("GMRASYMP",SUB)) Q:'+SUB  D
 .S GMRAS0=^(SUB) ;Naked from above
 .Q:$P(^(SUB),U)=""  ;25 No text or free text entered so don't store
 .S SIEN=$O(^GMR(120.8,GMRAIEN,10,"B",$P(GMRAS0,U),0))
 .I SIEN,$P(^GMR(120.8,GMRAIEN,10,SIEN,0),U,4)=$P(GMRAS0,U,3) Q  ;Exists and nothing has changed
 .I SIEN,$P(GMRAS0,U,5)="@" S DIK="^GMR(120.8,"_GMRAIEN_",",DA(1)=GMRAIEN,DA=SIEN D ^DIK Q  ;Sign/symptom deleted
 .S:'SIEN FDA(120.81,"+1,"_GMRAIEN_",",.01)=$S($P(GMRAS0,U)="FT":$O(^GMRD(120.83,"B","OTHER REACTION",0)),1:$P(GMRAS0,U))
 .S NODE=$S(SIEN:SIEN_","_GMRAIEN,1:"+1,"_GMRAIEN_",")
 .S:$P(GMRAS0,U)="FT" FDA(120.81,NODE,1)=$P(GMRAS0,U,2)
 .S FDA(120.81,NODE,2)=DUZ
 .S FDA(120.81,NODE,3)=$P(GMRAS0,U,3)
 .D UPDATE^DIE("","FDA","","ERR")
 .S GMRAROT($P(GMRAS0,U,2))="" ;21 record s/s added
 I NEW D
 .S GMRALL(GMRAIEN)="" D VAD^GMRAUTL1(DFN,,.GMRALOC,.GMRANAM) D EN7^GMRAMCB ;Send mark chart/ID band bulletin if needed.
 .I $P(@GMRARRAY@("GMRAOBHX"),U)="o" D  ;if observed reaction add data to 120.85
 ..S GMRAOUT=0 ;21
 ..S GMRAL(GMRAIEN,"O",GMRAIEN)=$G(@GMRARRAY@("GMRARDT"))_"^"_$G(@GMRARRAY@("GMRASEVR"))
 ..S GMRADFN=DFN
 ..S GMRAL(GMRAIEN)="^^"_$P($G(@GMRARRAY@("GMRAGNT")),U)_"^^^^"_$G(@GMRARRAY@("GMRAORIG"))
 ..M GMRAL(GMRAIEN,"S")=@GMRARRAY@("GMRASYMP")
 ..S SUB=0 F  S SUB=$O(GMRAL(GMRAIEN,"S",SUB)) Q:'+SUB  S $P(GMRAL(GMRAIEN,"S",SUB),U,2)=$P(GMRAL(GMRAIEN,"S",SUB),U,2)_"^" S:$P(GMRAL(GMRAIEN,"S",SUB),U)="FT" $P(GMRAL(GMRAIEN,"S",SUB),U)=$O(^GMRD(120.83,"B","OTHER REACTION",0))
 ..S GMRAL=GMRAIEN
 ..D ADVERSE^GMRAOR7(GMRAIEN,.GMRAL) ;adds entry to 120.85
 ..S GMRAIEN(GMRAIEN)="" ;21
 ..D EN1^GMRAPET0(GMRADFN,.GMRAIEN,"S",.GMRAOUT) ;21 File progress note
 ..I $G(@GMRARRAY@("GMRATYPE"))["D" S GMRAPA=GMRAIEN D EN1^GMRAPTB ;21 Send med-watch update
 .S GMRAAR=$P($G(@GMRARRAY@("GMRAGNT")),U,2),GMRAPA=GMRAIEN
 .D EN1^GMRAOR9 S ^TMP($J,"GMRASF",1,GMRAPA)="" D RANGE^GMRASIGN(1) ;add ingredients/classes send appropriate bulletins
 S ORY=0_$S(+$G(GMRAPN)>0:("^"_+$G(GMRAPN)),1:"") ;38 If note was created send back IEN
 L -^XTMP("GMRAED",DFN)
 Q
 ;
MESS ;Give out locked message
 N GMRAXBOS,GMRAL1,GMRAL2
 S GMRAXBOS=$$BROKER^XWBLIB ;In GUI?
 S GMRAL1="Another user is editing this patient's allergy information."
 S GMRAL2="Please refresh/review the patient's information before proceeding."
 I 'GMRAXBOS W !,GMRAL1,!,GMRAL2 D WAIT^GMRAFX3 Q
 S ORY="-1^"_GMRAL1_"  "_GMRAL2
 Q
