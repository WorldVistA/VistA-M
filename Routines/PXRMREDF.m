PXRMREDF ; SLC/PJH - Edit PXRM reminder findings. ;06/05/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ;
 ; Called by PXRMREDT which newes and initialized DEF, DEF1, DEF2.
 ;
SET S:'$D(^PXD(811.9,DA,20,0)) ^PXD(811.9,DA,20,0)="^811.902V" Q
 ;Display ALL findings
 ;
 ;--------------------
DSPALL(TYPE,NODE,DA,LIST) ;
 I '$D(LIST) D  Q
 . I TYPE="D" W !!,"Reminder has no findings!",!
 . I TYPE="T" W !!,"Reminder Term has no findings!",!
 N FINUM,FMTSTR,FNAME,FTYPE,IND,NL,OUTPUT,TEXTSTR
 W !!,"Choose from:",!
 S FMTSTR="2L1^60L1^9L1^3R"
 S FTYPE=""
 F  S FTYPE=$O(LIST(FTYPE)) Q:FTYPE=""  D
 . S FNAME=0
 . F  S FNAME=$O(LIST(FTYPE,FNAME)) Q:FNAME=""  D
 .. S FINUM=0
 .. F  S FINUM=$O(LIST(FTYPE,FNAME,FINUM)) Q:FINUM=""  D
 ... S TEXTSTR=FTYPE_U_FNAME_U_"Finding #"_U_FINUM
 ... D COLFMT^PXRMTEXT(FMTSTR,TEXTSTR," ",.NL,.OUTPUT)
 ... F IND=1:1:NL W !,OUTPUT(IND)
 ;Update
 D LIST^PXRMREDT(NODE,DA,.DEF1,.LIST)
 Q
 ;
 ;Edit individual FINDING entry
 ;-----------------------------
FEDIT(IEN) ;
 N CFIEN,DA,DIC,DIE,DR,ETYPE,GLOB
 N STATUS,TERMSTAT,TIEN,TERMTYPE,VF,WPIEN,Y
 S DA(1)=IEN
 S DIC="^PXD(811.9,"_IEN_",20,"
 I $P(^PXD(811.9,IEN,100),U)="N",$G(PXRMINST)'=1 S DIC(0)="QEA"
 E  S DIC(0)="QEAL"
 S DIC("A")="Select FINDING: "
 S DIC("P")="811.902V"
 D ^DIC
 I Y=-1 S DTOUT=1 Q
 S DIE=DIC K DIC
 S DIE("NO^")="OUTOK"
 S DA=+Y,GLOB=$P($P(Y,U,2),";",2) Q:GLOB=""
 S TYPE=$G(DEF1(GLOB))
 S SDA(2)=DA(1),SDA(1)=DA
 ;Save term IEN
 S STATUS=0
 I TYPE="CF" S CFIEN=$P($P(Y,U,2),";",1) D
 .I $D(^PXRMD(811.4,CFIEN,1))>0 D
 ..W !!,"Computed Finding Description:" S WPIEN=0
 ..F  S WPIEN=$O(^PXRMD(811.4,CFIEN,1,WPIEN)) Q:+WPIEN'>0  D
 ...W !,$G(^PXRMD(811.4,CFIEN,1,WPIEN,0))
 .E  W !!,"No description defined for this computed finding"
 I TYPE="MH" D WARN^PXRMMH
 I TYPE="RT" S TIEN=$P($P(Y,U,2),";",1)
 ;Finding record fields
 W !!,"Editing Finding Number: "_$G(DA)
 S DR=".01;3;I X=""0Y"" S Y=6;1;2;6;7;8;9;12;17"
 ;Taxonomy - use inactive problems
 I TYPE="TX" D
 .S TERMSTAT=$$TAXNODE^PXRMSTA1($P($P(Y,U,2),";"),"H")
 .I TERMSTAT="P" S DR=DR_";10" Q
 .I TERMSTAT'=0 S DR=DR_";10",STATUS=1
 I TYPE="RT" D
 .S TERMTYPE=$$TERMTYPE(TIEN)
 .I TERMTYPE["H" S DR=DR_";11"
 ;Health Factor - within category rank
 I TYPE="HF" S DR=DR_";11"
 ;If V file INCLUDE VISIT DATA
 S VF=$S(TYPE="ED":1,TYPE="EX":1,TYPE="HF":1,TYPE="IM":1,TYPE="ST":1,TYPE="TX":1,1:0)
 I TYPE="RT",$P(TERMTYPE,U,2)="VF" S VF=1
 I VF S DR=DR_";28"
 ;
 ;Mental Health - scale
 I TYPE="MH" S DR=DR_";13"
 ;Radiology procedure.
 I TYPE="RP" S STATUS=1
 ;Orderable Item
 I TYPE="OI" S DR=DR_";27",STATUS=1
 ;Rx Type
 I (TYPE="DC")!(TYPE="DG")!(TYPE="DR") S DR=DR_";16;27",STATUS=1
 ;Condition
 S DR=DR_";14;15;18"
 I TYPE="CF" S DR=DR_";26"
 ;Found/not found text
 S DR=DR_";4;5"
 ;
 I TYPE="RT" D
 . I TERMTYPE["D" S DR=DR_";16;27",STATUS=1
 . I TERMTYPE["O" S DR=DR_";27",STATUS=1
 . I TERMTYPE["R" S STATUS=1
 . I TERMTYPE["T" S STATUS=1
 .I TERMTYPE[2 D
 .. N MSG
 .. S MSG(1)="Cannot set a status since the term contains multiple types of findings"
 .. S MSG(2)="Edit the status field at the term level for each finding" H 2
 .. D EN^DDIOL(.MSG)
 ;Edit finding record
 D ^DIE
 S $P(^PXD(811.9,IEN,20,0),U,3)=0
 I $D(Y) S DTOUT=1 Q
 ;Check if deleted
 I '$D(DA) Q
 I STATUS=1,$D(Y)=0 D STATUS^PXRMSTA1(.DA,"D")
 ;
 S ETYPE=$P(^PXD(811.9,IEN,20,SDA(1),0),U,1)
 ;Option to edit term findings
 I $P(ETYPE,";",2)="PXRMD(811.5," D
 . S TIEN=$P(ETYPE,";",1)
 . D TMAP(IEN,TIEN)
 Q
 ;
 ;Edit individual function finding entry
 ;-----------------------------
FFEDIT(IEN) ;
 N DA,DIC,DIE,DR,Y
 S DA(1)=IEN
 S DIC="^PXD(811.9,"_IEN_",25,"
 S DIC(0)="QEAL"
 S DIC("A")="Select FUNCTION FINDING: "
 D ^DIC
 I Y=-1 S DTOUT=1 Q
 S DIE=DIC K DIC
 S DA=+Y
 ;Finding record fields
 S DR=".01;3"
 ;Edit finding record
 D ^DIE
 I $D(Y) S DTOUT=1 Q
 I '$D(DA) Q
 ;If the function string is null don't do the rest of the fields.
 I $G(^PXD(811.9,IEN,25,DA,3))="" Q
 S DR="1;2;11;12;15;I X=""0Y"" S Y=16;13;14;16"
 D ^DIE
 I $D(Y) S DTOUT=1 Q
 I '$D(DA) Q
 ;Check if deleted
 Q
 ;
 ;Edit Reminder Function Findings
 ;----------------------
FFIND ;
 N DTOUT,DUOUT
 F  D  Q:$D(DUOUT)!$D(DTOUT)
 .D FFEDIT(DA) I $D(DUOUT)!$D(DTOUT) Q
 K DUOUT,DTOUT
 Q
 ;
 ;Edit Reminder Findings
 ;----------------------
FIND(LIST) ;
 N DTOUT,DUOUT,NODE,SDA
 D SET ; Check if node defined
 S NODE="^PXD(811.9)"
 F  D  Q:$D(DUOUT)!$D(DTOUT)
 .;Display list of existing reminder findings
 .W !!,"Reminder Definition Findings"
 .D DSPALL("D",NODE,DA,.LIST)
 .;Edit findings
 .D FEDIT(DA) I $D(DUOUT)!$D(DTOUT) D LIST^PXRMREDT(NODE,DA,.DEF1,.LIST) Q
 .;Update list with finding changes
 .D LIST^PXRMREDT(NODE,DA,.DEF1,.LIST)
 Q
 ;
 ;General help text routine
 ;-------------------------
HELP(CALL) ;
 N HTEXT
 N DIWF,DIWL,DIWR,IC
 S DIWF="C70",DIWL=0,DIWR=70
 ;
 I CALL=1 D
 .S HTEXT(1)="Select the type of finding you wish to change or add."
 .S HTEXT(2)="Type '?' for a list of the available finding types."
 I CALL=2 D
 .S HTEXT(1)="Select section of the reminder you wish to edit or 'All'"
 .S HTEXT(2)="to step through all sections of the reminder definition."
 I CALL=3 D
 .S HTEXT(1)="Select 'Y' to edit the findings mapped to this term"
 .S HTEXT(2)="or 'N' to return to select another reminder finding."
 ;
 K ^UTILITY($J,"W")
 S IC=""
 F  S IC=$O(HTEXT(IC)) Q:IC=""  D
 . S X=HTEXT(IC)
 . D ^DIWP
 W !
 S IC=0
 F  S IC=$O(^UTILITY($J,"W",0,IC)) Q:IC=""  D
 . W !,^UTILITY($J,"W",0,IC,0)
 K ^UTILITY($J,"W")
 W !
 Q
 ;
 ;Display TERM findings
 ;--------------------
TDSP(DA) ;
 N FIRST,SUB,SUB1,TLST
 S FIRST=1,SUB="",SUB1=""
 ;Build list of term findings
 D TLST(.TLST,DA)
 ;Display list
 F  S SUB=$O(TLST(SUB)) Q:SUB=""  D
 .S SUB1=0
 .F  S SUB1=$O(TLST(SUB,SUB1)) Q:SUB1=""  D
 ..I FIRST S FIRST=0 W !!,"Reminder Term Findings:",!!
 ..W SUB
 ..W ?8,SUB1,!
 I FIRST W !!,"Term has no mapped findings",!!
 Q
 ;
 ;List Reminders using this term
 ;------------------------------
TERMS(TIEN,RIEN) ;
 ;RIEN will be the reminder ien if called from reminder edit
 ;or zero if called from term edit
 N ARRAY,FIND,IEN,SUB,TCNT,RNAME
 ;Scan all reminders in file #811.9
 S IEN=0,FIND="PXRMD(811.5,",TCNT=0
 F  S IEN=$O(^PXD(811.9,IEN)) Q:'IEN  D
 .;Exclude current reminder called in reminder edit
 .I RIEN,IEN=RIEN Q
 .;Check the term findings
 .I '$D(^PXD(811.9,IEN,20,"E",FIND,TIEN)) Q
 .;Add to reminder array
 .S RNAME=$P($G(^PXD(811.9,IEN,0)),U)
 .I RNAME="" S RNAME=IEN
 .I '$D(ARRAY(RNAME)) S TCNT=TCNT+1
 .S ARRAY(RNAME)=""
 ;
 ;Display list of reminders using the term
 I TCNT D
 .N TXT
 .S TXT="This Reminder Term is" S:RIEN TXT=TXT_" also"
 .S TXT=TXT_" used by the following Reminder Definition"
 .I TCNT>1 S TXT=TXT_"s"
 .W !!,TXT_":"
 .S RNAME="" F  S RNAME=$O(ARRAY(RNAME)) Q:RNAME=""  W !," ",RNAME
 Q
 ;
 ;------------------------------
 ;Check term for finding item to edit status item
TERMTYPE(TIEN) ;
 N DRUG,FOUND,HF,ORD,OTHER,RAD,RESULT,TAX,TYPE,VF
 S (DRUG,FOUND,HF,ORD,OTHER,RAD,RESULT,TAX,VF)=0
 S TYPE="" F  S TYPE=$O(^PXRMD(811.5,TIEN,20,"B",TYPE)) Q:TYPE=""  D
 . I TYPE["AUTTEDT(" S (OTHER,VF)=1 Q
 . I TYPE["AUTTHF(" S (HF,OTHER,VF)=1 Q
 . I TYPE["AUTTIMM(" S (OTHER,VF)=1 Q
 . I TYPE["AUTTSK(" S (OTHER,VF)=1 Q
 . I TYPE["ORD" S (ORD,FOUND)=1 Q
 . I TYPE["PS" S (DRUG,FOUND)=1 Q
 . I TYPE["PXD(811.2" S (FOUND,TAX,VF)=1 Q
 . I TYPE["RAMIS" S (FOUND,RAD)=1 Q
 . S OTHER=1
 I RAD=1,ORD=0,TAX=0,DRUG=0,OTHER=0 S RESULT="R"
 I RAD=0,ORD=1,TAX=0,DRUG=0,OTHER=0 S RESULT="O"
 I RAD=0,ORD=0,TAX=1,DRUG=0,OTHER=0 S RESULT="T"
 I RAD=0,ORD=0,TAX=0,DRUG=1,OTHER=0 S RESULT="D"
 I OTHER=1 S RESULT=1 I FOUND=1 S RESULT=2
 I RESULT="T" S RESULT=$$TAXTYPE^PXRMSTA1(TIEN,"")
 I HF=1 S RESULT="H"_RESULT
 I VF=1 S RESULT=RESULT_U_"VF"
 Q RESULT
 ;
 ;Build list of mapped findings for term
 ;--------------------------------------
TLST(ARRAY,DA) ;
 N TYPE,DATA,GLOB,IEN,NAME,NODE,SUB
 ;Clear passed arrays
 K ARRAY
 ;Build cross reference global to file number
 ;Get each finding
 S SUB=0 F  S SUB=$O(^PXRMD(811.5,DA,20,SUB)) Q:'SUB  D
 .S DATA=$G(^PXRMD(811.5,DA,20,SUB,0)) I DATA="" Q
 .;Determine global and global ien
 .S NODE=$P(DATA,U),GLOB=$P(NODE,";",2),IEN=$P(NODE,";")
 .;Ignore null entries
 .I (GLOB="")!(IEN="") Q
 .;Work out the file type
 .S TYPE=$G(DEF1(GLOB)) Q:TYPE=""
 .S NAME=$P($G(@(U_GLOB_IEN_",0)")),U)
 .S ARRAY(TYPE,NAME)=""
 Q
 ;
 ;Map Term findings
 ;-----------------
TMAP(RIEN,TIEN) ;
 N TOPT,TNAM
 ;Display any other reminders using this term
 D TERMS(TIEN,RIEN)
 ;Term name
 S TNAM=$P($G(^PXRMD(811.5,TIEN,0)),U)
 ;Give option to edit mapped findings (Y/N)
 D TMASK(.TOPT,TNAM) Q:$D(DUOUT)!($D(DTOUT))
 ;Edit term findings
 I TOPT="Y" D TRMED(TIEN)
 Q
 ;
 ;Option to edit term findings
 ;----------------------------
TMASK(YESNO,TNAM) ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YA0"
 S DIR("A")="Do you want to edit mapped findings for "_TNAM_": "
 S (DIR("B"),YESNO)="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMREDF(3)"
 W !
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 S YESNO=$E(Y(0))
 Q
 ;
 ;Term edit
 ;---------
TRMED(DA) ;
 N CS1,CS2,DIC,DLAYGO,DTOUT,DUOUT,Y
 K DLAYGO,DTOUT,DUOUT,Y
 ;Display term findings
 D TDSP(DA)
 ;Initialize change history
 S CS1=$$FILE^PXRMEXCS(811.5,DA)
 ;Edit term findings
 S DIC="^PXRMD(811.5,"
 D EDIT^PXRMTMED(DIC,DA)
 ;Update change history
 S CS2=$$FILE^PXRMEXCS(811.5,DA)
 I CS2=0 Q
 I CS2'=CS1 D SEHIST^PXRMUTIL(811.5,DIC,DA)
 Q
 ;
