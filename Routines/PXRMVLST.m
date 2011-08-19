PXRMVLST ; SLC/PKR - Validate a reminder definition for building a patient list. ;06/16/2005
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;==================================================
CCF(FINDING) ;Check a computed finding to see if it can be used for building
 ;a list.
 N IEN,TEMP,TEXT,TYPE,VALID
 S VALID=1
 S IEN=$P(FINDING,";",1)
 S TEMP=$G(^PXRMD(811.4,IEN,0))
 I TEMP="" D  Q 0
 . S TEXT="Trying to use computed finding number "_IEN_" it does not exist!"
 . D EN^DDIOL(TEXT)
 S TYPE=$P(TEMP,U,5)
 I TYPE="" S TYPE="S"
 I TYPE'="L" D
 . S VALID=0
 . S TEXT(1)="Computed finding "_$P(TEMP,U,1)_" is type "_TYPE_"."
 . S TEXT(2)="It cannot be used for building patient lists!"
 . D EN^DDIOL(.TEXT)
 Q VALID
 ;
 ;==================================================
CTERM(DEFARR,FINUM,FINDING) ;Check terms for computed findings and
 ;health factors to see if they are valid for building a list.
 N IEN,IND,TEXT,VALID,WCR
 S IEN=$P(FINDING,";",1)
 I '$D(^PXRMD(811.5,IEN,0)) D  Q 0
 . S TEXT="Trying to use term number "_IEN_" it does not exist!"
 . D EN^DDIOL(TEXT)
 S VALID=1
 I $D(^PXRMD(811.5,IEN,20,"E","PXRMD(811.4,")) D
 . S IND=0
 . F  S IND=$O(^PXRMD(811.5,IEN,20,"E","PXRMD(811.4,",IND)) Q:IND=""  D
 .. S VALID=$$CCF(IND)
 .. I 'VALID D
 ... S TEXT="The computed finding is used in term "_$P(^PXRMD(811.5,IEN,0),U,1)_"."
 ... D EN^DDIOL(TEXT)
 Q VALID
 ;
 ;==================================================
HF(DEFARR,FINUM) ;
 ;If a health factor is used its Within Category Rank must be 0.
 N WCR,TEXT
 S WCR=$P(DEFARR(20,FINUM,0),U,10)
 I WCR=0 Q 1
 S TEXT="Finding "_FINUM_" is a health factor and its Within Category Rank is not 0!"
 D EN^DDIOL(TEXT)
 Q 0
 ;
 ;==================================================
VDEF(RIEN) ;Check a reminder definition and see if it is valid for
 ;use in creating a patient list.
 N AGEFI,AGR,DEFARR,FFL,FI,FIL,FILIST,FINDING,FINUM,FREQ,FUNN,IND,OPER
 N MAXAGE,MINAGE,NUMAFI,PCLOG,PFSTACK
 N SAAFI,SEXFI,SSTACK,TEMP,TEXT,TYPE,VALID,VF
 I RIEN="" Q 0
 I '$D(^PXD(811.9,RIEN)) D  Q 0
 . S TEXT="The reminder does not exist!"
 . D EN^DDIOL(TEXT)
 ;
 ;See if the reminder is inactive.
 I $P($G(^PXD(811.9,RIEN,0)),U,6) D  Q 0
 . S TEXT="This reminder is inactive!"
 . D EN^DDIOL(TEXT)
 ;
 D DEF^PXRMLDR(RIEN,.DEFARR)
 S PCLOG=DEFARR(31)
 I PCLOG="" D  Q 0
 . S TEXT="This reminder does not contain any patient cohort logic!"
 . D EN^DDIOL(TEXT)
 ;
 ;The cohort logic cannot contain the old-style MRD.
 I $G(^PXD(811.9,RIEN,30))["MRD" D  Q 0
 . S TEXT="The patient cohort logic cannot contain the old-style MRD!"
 . D EN^DDIOL(TEXT)
 ;
 ;The cohort logic cannot start with a not.
 I $E(PCLOG,1)="'" D  Q 0
 . S TEXT="The patient cohort logic cannot start with a not!"
 . D EN^DDIOL(TEXT)
 ;
 ;The cohort logic cannot contain or not.
 ;Change any !(' to !' before checking.
 S TEMP=$TR(PCLOG,"(","")
 S TEMP=$TR(TEMP,")","")
 I TEMP["!'" D  Q 0
 . S TEXT="The patient cohort logic cannot contain or not!"
 . D EN^DDIOL(TEXT)
 ;
 S OPER="!&~"
 S PCLOG=$$STRREP^PXRMUTIL(PCLOG,"&'","~")
 D POSTFIX^PXRMSTAC(PCLOG,OPER,.PFSTACK)
 D CFSAA^PXRMPLST(.PFSTACK)
 M SSTACK=PFSTACK
 S (AGEFI,SAAFI,SEXFI)=0
 F IND=1:1:PFSTACK(0) D
 . S TEMP=$$POP^PXRMSTAC(.PFSTACK)
 . I TEMP="AGE" S AGEFI=IND
 . I TEMP="SAA" S SAAFI=IND
 . I TEMP="SEX" S SEXFI=IND
 . I TEMP="'SEX" S SEXFI=IND
 ;
 ;If AGE is defined then make sure a baseline age range is defined.
 I (AGEFI)!(SAAFI) D
 . S (AGR,IND)=0
 . F  S IND=+$O(DEFARR(7,IND)) Q:IND=0  D
 .. S TEMP=DEFARR(7,IND,0)
 .. I $P(TEMP,U,2)'="" S AGR=1
 .. I $P(TEMP,U,3)'="" S AGR=1
 ;
 S TEMP=DEFARR(40)
 S NUMAFI=+$P(TEMP,U,1)
 S FILIST=$P(TEMP,U,2)
 I (AGEFI!SAAFI),('AGR&(NUMAFI=0)) D  Q 0
 . S TEXT(1)="Age is used in the cohort logic and neither a baseline age range or any age"
 . S TEXT(2)="findings have been defined!"
 . D EN^DDIOL(.TEXT)
 ;
 ;SEX cannot be the first element unless it is followed by & AGE.
 I (SEXFI=1),('SAAFI) D  Q 0
 . S TEXT="SEX must be followed by & AGE when it starts the patient cohort logic!"
 . D EN^DDIOL(TEXT)
 ;If SEX is defined and there is not a combined sex & age finding then
 ;a sex must be defined and the logical operator cannot be an or.
 S VALID=1
 I (SEXFI),('SAAFI) D
 . I $P(^PXD(811.9,RIEN,0),U,9)="" D
 .. S VALID=0
 .. S TEXT(1)="Sex is used in the patient cohort logic and no sex is defined in the reminder"
 .. S TEXT(2)="definition!"
 .. D EN^DDIOL(.TEXT)
 . I VALID D
 .. S TEMP=SSTACK(SEXFI+1)
 .. I TEMP="!" D
 ... S VALID=0
 ... S TEXT="SEX cannot be used in conjunction with the or operator!"
 ... D EN^DDIOL(TEXT)
 I 'VALID Q VALID
 ;
 ;Check the age findings and see if any of them set the frequency to
 ;0Y. If they do they cannot have an associated age range.
 F IND=1:1:NUMAFI D
 . S FINUM=$P(FILIST,";",IND)
 . S TEMP=$S(FINUM["FF":DEFARR(25,FINUM,0),1:DEFARR(20,FINUM,0))
 . S MINAGE=$P(TEMP,U,2)
 . S MAXAGE=$P(TEMP,U,3)
 . S FREQ=$P(TEMP,U,4)
 . I FREQ="0Y",((MINAGE'="")!(MAXAGE'="")) D
 .. S VALID=0
 .. S TEXT(1)="Finding "_FINUM_" sets the frequency to 0Y and also sets an age range."
 .. S TEXT(2)="An age range is not allowed with a frequency of 0Y!"
 .. D EN^DDIOL(.TEXT)
 ;
 ;Build a list of all the findings that affect whether or not the
 ;patient is in the cohort and check to see if any of them use a
 ;computed finding. If they use a computed finding then it must be
 ;a list type. Health factors must have within category rank of 0.
 F IND=1:1:SSTACK(0) D
 . I (SSTACK(IND)["FI") D
 .. S FINUM=$G(SSTACK(IND+1))
 .. S FIL(FINUM)=""
 . I (SSTACK(IND)["FF") D
 .. S FINUM=$G(SSTACK(IND+1))
 .. S FFL(FINUM)="FF"_FINUM
 ;Add any age findings to the list.
 F IND=1:1:NUMAFI D
 . S TEMP=$P(FILIST,";",IND)
 . I TEMP=+TEMP S FIL(TEMP)=""
 . I TEMP["FF" S FFL($P(TEMP,"FF",2))=TEMP
 ;Add findings used by function findings to the list.
 S IND=0
 F  S IND=$O(FFL(IND)) Q:IND=""  D
 . S FUNN=0
 . S FUNN=$O(DEFARR(25,FFL(IND),5,FUNN)) Q:FUNN=""  D
 .. S FI=0
 .. F  S FI=$O(DEFARR(25,FFL(IND),5,FUNN,20,FI)) Q:FI=""  D
 ... S FINUM=DEFARR(25,FFL(IND),5,FUNN,20,FI,0)
 ... I '$D(DEFARR(20,FINUM)) D  Q
 .... S VALID=0
 .... S TEXT="Finding "_FINUM_" is used in FF("_IND_") and it does not exist!"
 .... D EN^DDIOL(TEXT)
 ... S FIL(FINUM)=""
 I 'VALID Q VALID
 S IND=0
 F  S IND=$O(FIL(IND)) Q:IND=""  D
 . S FINDING=$P($G(DEFARR(20,IND,0)),U,1)
 . I FINDING="" D  Q
 .. S VALID=0
 .. S TEXT="Finding number "_IND_" does not exist!"
 .. D EN^DDIOL(TEXT)
 . S TEMP=$P(FINDING,";",2)
 . S TYPE=$S(TEMP="AUTTHF(":"HF",TEMP="PXRMD(811.4,":"CF",TEMP="PXRMD(811.5,":"TERM",1:"REG")
 . I TYPE="REG" Q
 . I TYPE="CF" S VF=$$CCF(FINDING)
 . I TYPE="HF" S VF=$$HF(.DEFARR,IND)
 . I TYPE="TERM" S VF=$$CTERM(.DEFARR,IND,FINDING)
 . I VF=0 D
 .. S VALID=0
 .. S TEXT="Finding number "_IND_" is the problem finding."
 .. D EN^DDIOL(TEXT)
 Q VALID
 ;
