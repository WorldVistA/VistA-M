PXRMICHK ;SLC/PKR - Integrity checking routines. ;05/31/2022
 ;;2.0;CLINICAL REMINDERS;**18,24,26,47,45,42,65**;Feb 04, 2005;Build 438
 ;===============
ADDTEXT(NIN,TEXT,NL,OUTPUT) ;
 N IND,NOUT,TEXTOUT
 D FORMAT^PXRMTEXT(1,80,NIN,.TEXT,.NOUT,.TEXTOUT)
 F IND=1:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(IND)
 Q
 ;
 ;===============
CCRLOGIC(COHOK,FFOK,RESOK,DEFARR,NL,OUTPUT) ;Check cohort and resolution logic.
 N AGE,FIEVAL,FINDING,FF,FLIST,IND,JND,NUM,OCCN,PCLOG
 N RESLOG,RESLSTR,SEX,TEMP,TEST,TEXT
 N PXRMAGE,PXRMDATE,PXRMDOB,PXRMDOD,PXRMLAD,PXRMSEX,PXRMSIG
 S (PXRMAGE,PXRMDATE,PXRMDOB,PXRMDOD,PXRMLAD)=0
 S (PXRMSEX,PXRMSIG)=""
 ;Set all findings false.
 S (FIEVAL("AGE"),FIEVAL("SEX"))=0
 S IND=0
 F  S IND=+$O(DEFARR(20,IND)) Q:IND=0  D
 . S FIEVAL(IND)=0
 . S OCCN=$P(DEFARR(20,IND,0),U,14)
 . F JND=1:1:OCCN S FIEVAL(IND,JND)=0
 ;If there were no problems with the function findings evaluate them
 ;with all findings false.
 I FFOK D EVAL^PXRMFF(.DEFARR,.FIEVAL)
 S PCLOG=DEFARR(31)
 I (PCLOG["FF"),('FFOK) S COHOK=0
 I COHOK D
 . S TEMP=DEFARR(32)
 . S NUM=+$P(TEMP,U,1)
 . I NUM=0 Q
 . S FLIST=$P(TEMP,U,2)
 . F IND=1:1:NUM D
 .. S FINDING=$P(FLIST,";",IND)
 .. I FINDING="AGE" S AGE=+$G(FIEVAL("AGE"))
 .. I FINDING="SEX" S SEX=+$G(FIEVAL("SEX"))
 .. I FINDING["FF" S TEMP=$P(FINDING,"FF",2),FF(TEMP)=FIEVAL(FINDING)
 .. E  S FI(FINDING)=FIEVAL(FINDING)
 . I @PCLOG
 . S TEST=$T
 . I TEST D
 .. S TEXT(1)="WARNING: Cohort logic is true even when there are no true findings!"
 .. D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 S (RESLOG,RESLSTR)=DEFARR(35)
 I (RESLOG["FF"),('FFOK) S RESOK=0
 I RESOK D
 . S TEMP=DEFARR(36)
 . S NUM=+$P(TEMP,U,1)
 . I NUM=0 Q
 . S (RESLOG,RESLSTR)=DEFARR(35)
 . S FLIST=$P(TEMP,U,2)
 . F IND=1:1:NUM D
 .. S FINDING=$P(FLIST,";",IND)
 .. I FINDING["FF" S TEMP=$P(FINDING,"FF",2),FF(TEMP)=FIEVAL(FINDING)
 .. E  S FI(FINDING)=FIEVAL(FINDING)
 . I @RESLOG
 . S TEST=$T
 . I TEST D
 .. S TEXT(1)="WARNING: Resolution logic is true even when there are no true findings!"
 .. D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 Q
 ;
 ;===============
CFCHK(USAGE,IND,FIEN,DEFARR,TYPE,NL,OUTPUT) ;Check computed findings.
 N CFNAME,CFPAR,CFPREQ,CFTYPE,OK,TEXT
 S OK=1
 ;Is the Computed Finding Parameter required?
 S CFPREQ=$P(^PXRMD(811.4,FIEN,0),U,6)
 S CFNAME=$P(^PXRMD(811.4,FIEN,0),U,1)
 S CFPAR=$P(DEFARR(20,IND,15),U,1)
 I CFPREQ,CFPAR="" D
 . I TYPE="D" S TEXT(1)="FATAL: Finding number "_IND_" uses computed finding "_CFNAME_"."
 . I TYPE="T" S TEXT(1)="FATAL: Term finding number "_IND_" uses computed finding "_CFNAME_"."
 . S TEXT(2)="This computed finding will not work properly unless the"
 . S TEXT(3)="Computed Finding Parameter is defined and in this case it is not."
 . D ADDTEXT(3,.TEXT,.NL,.OUTPUT)
 . S OK=0
 ;If USAGE is 'L' make sure the CF is list type.
 S CFTYPE=$P(^PXRMD(811.4,FIEN,0),U,5)
 I CFTYPE="" S CFTYPE="S"
 I (USAGE["L"),(CFTYPE'="L") D
 . S CFNAME=$P(^PXRMD(811.4,FIEN,0),U,1)
 . K TEXT
 . I TYPE="D" S TEXT(1)="FATAL: Finding number "_IND_" uses computed finding "_CFNAME_"."
 . I TYPE="T" S TEXT(1)="FATAL: Term finding number "_IND_" uses computed finding "_CFNAME_"."
 . S TEXT(2)="Usage is 'L' and this computed finding's Type is "_CFTYPE_";"
 . S TEXT(3)="the Type must be 'L'."
 . D ADDTEXT(3,.TEXT,.NL,.OUTPUT)
 . S OK=0
 ;If the CF is VA-REMINDER DEFINITION do additional checks.
 I (CFNAME="VA-REMINDER DEFINITION") S OK=$$RDCFCHK(CFNAME,CFPAR,IND,TYPE,.NL,.OUTPUT)
 Q OK
 ;
 ;===============
CHECKALL ;Check all definitions.
 N IEN,NAME,OK,OUTPUT,POP,PXRMDONE,TEXT
 W #!,"Check the integrity of all reminder definitions."
 D ^%ZIS Q:POP
 U IO
 S NAME="",PXRMDONE=0
 F  S NAME=$O(^PXD(811.9,"B",NAME)) Q:(NAME="")!(PXRMDONE)  D
 . S IEN=$O(^PXD(811.9,"B",NAME,""))
 . W !!,"Checking "_NAME_" (IEN="_IEN_")"
 . K OUTPUT
 . S OK=$$DEF^PXRMICHK(IEN,.OUTPUT,1)
 D ^%ZISC
 Q
 ;
 ;===============
CHECKONE ;Check selected definitions.
 N DIC,DTOUT,DUOUT,IEN,OK,OUTPUT,Y
 S DIC="^PXD(811.9,"
 S DIC(0)="AEMQ"
 S DIC("A")="Select Reminder Definition: "
GETDEF ;Get the definition to check.
 W !
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT)) Q
 I Y=-1 Q
 S IEN=$P(Y,U,1)
 W #
 K OUTPUT
 S OK=$$DEF^PXRMICHK(IEN,.OUTPUT,1)
 G GETDEF
 Q
 ;
 ;===============
DATECHK(FINDING,DATE,TYPE,DEFARR,NL,OUTPUT) ;Check Beginning and Ending
 ;Date/Times if they contain FIEVAL.
 N ARGS,DFI,DTYPE,OCC,OCN,OK,TEXT
 S OK=1
 S ARGS=$E(DATE,$F(DATE,"FIEVAL("),$F(DATE,"""DATE"")")-9)
 I ARGS="" Q OK
 S DFI=$P(ARGS,",",1)
 I '$D(DEFARR(20,DFI)) D
 . S DTYPE=$S(TYPE="BDT":"Beginning Date/Time",TYPE="EDT":"Ending Date/Time")
 . S TEXT(1)="FATAL: "_DTYPE_" for finding number "_FINDING_" uses finding number "_DFI_" which does not exist."
 . D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 . S OK=0
 I OK D
 . S OCN=$P(ARGS,",",2)
 . I OCN="" Q
 . S OCC=+$P(DEFARR(20,DFI,0),U,14)
 . S OCC=$S(OCC=0:1,OCC>0:OCC,1:-OCC)
 . I OCN>OCC D
 .. S DTYPE=$S(TYPE="BDT":"Beginning Date/Time",TYPE="EDT":"Ending Date/Time")
 .. S TEXT(1)="FATAL: "_DTYPE_" for finding number "_FINDING_" uses occurrence "_OCN_" of finding number "_DFI_";"
 .. S TEXT(2)="the Occurrence Count for finding "_DFI_" is "_OCC_"."
 .. D ADDTEXT(2,.TEXT,.NL,.OUTPUT)
 .. S OK=0
 Q OK
 ;
 ;===============
DEF(IEN,OUTPUT,WRITE) ;Definition integrity check. 0 is returned if the
 ;definition has fatal errors, otherwise 1 is returned.
 ;Warning and error text is stored in the OUTPUT array. If WRITE=1 then
 ;the contents of OUTPUT will be written out.
 N ARGTYPE,BDT,C1,COHOK,DEF,DEFARR,EDT,FFOK
 N FFNUM,FI,FIEN,FLIST,FNUM,FUNCTION,GBL,IND,JND,KND
 N LOGCHK,LOGINTR,LOGSTR,NBFREQ,NFI,NFFREQ,NL
 N OCC,OCN,OK,RESOK
 N TEXT,USAGE,ZNODE
 S NL=0,OK=1
 ;Check usage.
 S ZNODE=^PXD(811.9,IEN,100)
 S USAGE=$P(ZNODE,U,4)
 I $P(ZNODE,U,1)'="N",USAGE["P" D
 . K TEXT
 . S TEXT(1)="WARNING: Usage field contains a ""P"" and this is not a national reminder definition."
 . D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 ;
 D DEF^PXRMLDR(IEN,.DEFARR)
 S DEF=$P(DEFARR(0),U,1)
 ;
 ;Check findings and finding modifiers.
 S IND=0
 F  S IND=+$O(DEFARR(20,IND)) Q:IND=0  D
 . S ZNODE=DEFARR(20,IND,0)
 . S FI=$P(ZNODE,U,1)
 . S FIEN=$P(FI,";",1)
 . S GBL=$P(FI,";",2)
 . I (FIEN'=+FIEN)!(GBL="") D  Q
 .. K TEXT
 .. S TEXT(1)="FATAL: Finding number "_IND_" is invalid."
 .. D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 .. S OK=0
 . S FNUM=$$GETFNUM^PXRMEXPS(GBL)
 . I '$$FIND1^DIC(FNUM,"","XU","`"_FIEN) D
 .. K TEXT
 .. S TEXT(1)="FATAL: Finding number "_IND_", does not exist! It is entry number "_FIEN_" in file #"_FNUM_"."
 .. D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 .. S OK=0
 . S BDT=$P(ZNODE,U,8)
 . I BDT["FIEVAL",'$$DATECHK(IND,BDT,"BDT",.DEFARR,.NL,.OUTPUT) S OK=0
 . S EDT=$P(ZNODE,U,11)
 . I EDT["FIEVAL",'$$DATECHK(IND,EDT,"EDT",.DEFARR,.NL,.OUTPUT) S OK=0
 .;Check computed findings.
 . I (GBL="PXRMD(811.4,"),'$$CFCHK(USAGE,IND,FIEN,.DEFARR,"D",.NL,.OUTPUT) S OK=0
 .;Check terms.
 . I (GBL="PXRMD(811.5,"),'$$TERMCHK^PXRMICK1(USAGE,FIEN,.NL,.OUTPUT) S OK=0
 ;
 ;Check for recursion.
 I $$RECCHK(IEN,.NL,.OUTPUT) S OK=0
 ;
 ;Check function findings.
 S FFNUM="FF",FFOK=1
 F  S FFNUM=$O(DEFARR(25,FFNUM)) Q:FFNUM=""  D
 . S IND=$P(FFNUM,"FF",2)
 .;Check for an invalid function string.
 . I $L($G(DEFARR(25,FFNUM,3)))<2 D  Q
 .. K TEXT
 .. S TEXT(1)="FATAL: Function finding number "_IND_" has an invalid function string."
 .. D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 .. S (FFOK,OK)=0
 . S JND=0
 . F  S JND=+$O(DEFARR(25,FFNUM,5,JND)) Q:JND=0  D
 .. S FUNCTION=$P(DEFARR(25,FFNUM,5,JND,0),U,2)
 .. S FUNCTION=$P(^PXRMD(802.4,FUNCTION,0),U,1)
 .. S KND=0
 .. F  S KND=+$O(DEFARR(25,FFNUM,5,JND,20,KND)) Q:KND=0  D
 ... S ARGTYPE=$$ARGTYPE^PXRMFFAT(FUNCTION,KND)
 ... I ARGTYPE="F" D
 .... S FI=DEFARR(25,FFNUM,5,JND,20,KND,0)
 .... S C1=$E(FI,1)
 .... I (C1="C")!(C1="R") S FI=$E(FI,2,15)
 .... I '$D(DEFARR(20,FI,0)) D
 ..... K TEXT
 ..... S TEXT(1)="FATAL: Function finding number "_IND_" depends on finding number "_FI_" which does not exist."
 ..... D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 ..... S (FFOK,OK)=0
 ... I FFOK,ARGTYPE="N" D
 .... S OCN=DEFARR(25,FFNUM,5,JND,20,KND,0)
 .... S OCC=+$P(DEFARR(20,FI,0),U,14)
 .... S OCC=$S(OCC=0:1,OCC>0:OCC,1:-OCC)
 .... ;Ignore Occurrence Count check for contraindication and refusal findings.
 .... I (C1="C")!(C1="R") S OCN=OCC
 .... I OCN>OCC D
 ..... K TEXT
 ..... S TEXT(1)="FATAL: Function finding number "_IND_" uses occurrence number "_OCN
 ..... S TEXT(2)="of finding number "_FI_"."
 ..... S TEXT(3)="The Occurrence Count for finding "_FI_" is "_OCC_"."
 ..... D ADDTEXT(3,.TEXT,.NL,.OUTPUT)
 ..... S (FFOK,OK)=0
 ;
 ;Check custom date due.
 S IND=0
 F  S IND=+$O(DEFARR(47,IND)) Q:IND=0  D
 . S FI=$P(DEFARR(47,IND,0),U,1)
 . I '$D(DEFARR(20,FI,0)) D
 .. K TEXT
 .. S TEXT(1)="FATAL: Custom Date Due depends on finding number "_FI_" which does not exist."
 .. D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 .. S OK=0
 ;
 ;Check cohort logic structure and dependencies.
 S LOGSTR=$G(DEFARR(31))
 ;Run the input transform.
 S LOGINTR=$S(LOGSTR'="":$$VALID^PXRMLOG(LOGSTR,IEN,3,512),1:1)
 S NFI=+$P($G(DEFARR(32)),U,1)
 S FLIST=$P($G(DEFARR(32)),U,2)
 S LOGCHK=$$LOGCHECK(NFI,FLIST,LOGSTR,"Patient Cohort",.DEFARR,.NL,.OUTPUT)
 S COHOK=LOGINTR&LOGCHK
 I 'COHOK D
 . S TEXT(1)="FATAL: Definition has invalid cohort logic.\\"
 . S TEXT(2)=" "_LOGSTR
 . D ADDTEXT(2,.TEXT,.NL,.OUTPUT)
 . S OK=0
 ;
 ;If the USAGE is List, check the cohort logic to make sure it
 ;meets the special requirements.
 I USAGE["L",COHOK S COHOK=$$LCOHORTC(.DEFARR,.NL,.OUTPUT)
 I 'COHOK S OK=0
 ;
 ;Check resolution structure and dependencies.
 S LOGSTR=$G(DEFARR(35))
 ;Run the input transform.
 S LOGINTR=$S(LOGSTR'="":$$VALIDR^PXRMLOG(LOGSTR,IEN,5,512),1:1)
 S NFI=+$P($G(DEFARR(36)),U,1)
 S FLIST=$P($G(DEFARR(36)),U,2)
 S LOGCHK=$$LOGCHECK(NFI,FLIST,LOGSTR,"Resolution",.DEFARR,.NL,.OUTPUT)
 S RESOK=LOGINTR&LOGCHK
 I 'RESOK D
 . S TEXT(1)="FATAL: Definition has invalid resolution logic.\\"
 . S TEXT(2)=" "_LOGSTR
 . D ADDTEXT(2,.TEXT,.NL,.OUTPUT)
 . S OK=0
 ;
 ;Make other checks for bad cohort and resolution logic; these are
 ;all just warnings.
 D CCRLOGIC(COHOK,FFOK,RESOK,.DEFARR,.NL,.OUTPUT)
 ;
 ;Check for frequencies, a frequency is required if there is resolution
 ;logic.
 S (IND,NBFREQ,NFFREQ)=0
 F  S IND=+$O(DEFARR(7,IND)) Q:IND=0  S NBFREQ=NBFREQ+1
 I NBFREQ=0 D
 . K TEXT
 . S TEXT(1)="WARNING: No baseline frequencies are defined."
 . D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 I NBFREQ=0 D
 . S IND=0
 . F  S IND=+$O(DEFARR(20,IND)) Q:IND=0  I $P(DEFARR(20,IND,0),U,4)'="" S NFFREQ=NFFREQ+1
 . S IND="FF"
 . F  S IND=$O(DEFARR(25,IND)) Q:IND=""  I $P(DEFARR(25,IND,0),U,4)'="" S NFFREQ=NFFREQ+1
 I (NBFREQ=0),(NFFREQ=0),(DEFARR(35)'="") D
 . K TEXT
 . S TEXT(1)="FATAL: Definition has resolution logic but no baseline frequencies."
 . S TEXT(2)="Also there are no findings or function findings that set a frequency."
 . D ADDTEXT(2,.TEXT,.NL,.OUTPUT)
 . S OK=0
 . I (NBFREQ=0),(NFFREQ>0),(DEFARR(35)'="") D
 . K TEXT
 . S TEXT(1)="WARNING: Definition has resolution logic but no baseline frequencies."
 . S TEXT(2)="There are findings that set a frequency but if they are all false there will not be a frequency."
 . D ADDTEXT(2,.TEXT,.NL,.OUTPUT)
 K TEXT
 I OK S TEXT(1)="No fatal reminder definition errors were found."
 E  S TEXT(1)="This reminder definition has fatal errors and it will not work!"
 D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 I WRITE=1 D OUTPUT^PXRMICK1(NL,.OUTPUT)
 Q OK
 ;
 ;===============
LCOHORTC(DEFARR,NL,OUTPUT) ;Check list type reminder cohort logic for special
 ;requirements.
 N IND,MAXAGE,MINAGE,NL,OK,PCLOG,TEXT
 S (OK,NL)=1
 S PCLOG=DEFARR(31)
 ;The cohort logic cannot start with a logical not.
 I $E(PCLOG,1)="'" D
 . S NL=NL+1
 . S TEXT(NL)="The cohort logic cannot start with a logical not.\\"
 . S OK=0
 I PCLOG["!'" D
 . S NL=NL+1
 . S TEXT(NL)="The cohort logic cannot contain !' (OR NOT).\\"
 . S OK=0
 I PCLOG["AGE" D
 .;Make sure a baseline age range is defined.
 . S IND=0 F  S IND=$O(DEFARR(7,IND)) Q:(IND="")  Q:(DEFARR(7,IND,0)'="")
 . S MINAGE=$S(IND="":0,1:+$P($G(DEFARR(7,IND,0)),U,2))
 . S MAXAGE=$S(IND="":0,1:+$P($G(DEFARR(7,IND,0)),U,3))
 . I (MINAGE=0),(MAXAGE=0) D
 .. S NL=NL+1
 .. S TEXT(NL)="The cohort logic contains AGE but no baseline age range is defined.\\"
 .. S OK=0
 I PCLOG["SEX" D
 . I $P(DEFARR(0),U,9)="" D
 .. S NL=NL+1
 .. S TEXT(NL)="The cohort logic contains SEX but the SEX SPECIFIC field is not defined.\\"
 .. S OK=0
 I PCLOG["SEX" D
 . N PFSTACK
 . D POSTFIX^PXRMSTAC(PCLOG,"!&",.PFSTACK)
 . I PFSTACK(1)'="SEX" Q
 . I (PFSTACK(2)'="AGE")!(PFSTACK(3)'="&") D
 .. S NL=NL+1
 .. S TEXT(NL)="The cohort logic starts with SEX but SEX is not logically ANDED with AGE.\\"
 .. S OK=0
 I 'OK D
 . S TEXT(1)="FATAL: List type definitions have the following restrictions:\\"
 . D ADDTEXT(NL,.TEXT,.NL,.OUTPUT)
 Q OK
 ;
 ;===============
LOGCHECK(NFI,FLIST,LOGSTR,TYPE,DEFARR,NL,OUTPUT) ;Verify logic strings.
 ;Make sure the findings exist and the syntax is correct.
 N FFNUM,FI,IND,OK,TEXT,X
 S OK=1
 I NFI=0 D  Q OK
 . S TEXT(1)="WARNING: There is no "_TYPE_" logic."
 . D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 F IND=1:1:NFI D
 . S FI=$P(FLIST,";",IND)
 . I FI=+FI D
 .. I '$D(DEFARR(20,FI,0)) D
 ... S TEXT(1)="FATAL: "_TYPE_" logic uses finding "_FI_" which does not exist."
 ... D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 ... S OK=0
 . I FI["FF" D
 .. I '$D(DEFARR(25,FI,0)) D
 ... S FFNUM=$P(FI,"FF",2)
 ... S TEXT(1)="Fatal :"_TYPE_" logic uses function finding "_FFNUM_" which does not exist."
 ... D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 ... S OK=0
 S X="S Y="_LOGSTR
 D ^DIM
 I '$D(X) D
 . S TEXT(1)="FATAL: "_TYPE_" logic syntax is invalid."
 . D ADDTEXT(1,.TEXT,.NL,.OUTPUT)
 . S OK=0
 Q OK
 ;
 ;===============
RDCFCHK(CFNAME,CFPAR,IND,TYPE,NL,OUTPUT) ;Additional checks when the computed
 ;finding is VA-REMINDER DEFINTION.
 ;A blank Computed Finding Parameter has already been checked for.
 I CFPAR="" Q 0
 N NDEFIEN,RECUR,TEXT
 S NDEFIEN=$S(+CFPAR=CFPAR:+CFPAR,1:$O(^PXD(811.9,"B",CFPAR,"")))
 I NDEFIEN="" D  Q 0
 . I TYPE="D" S TEXT(1)="FATAL: Finding number "_IND_" uses computed finding "_CFNAME_"."
 . I TYPE="T" S TEXT(1)="FATAL: Term finding number "_IND_" uses computed finding "_CFNAME_"."
 . S TEXT(2)="The Computed Finding Parameter is set to "_CFPAR_", that reminder does not exist."
 . D ADDTEXT(2,.TEXT,.NL,.OUTPUT)
 ;Usage check.
 S USAGE=$P(^PXD(811.9,NDEFIEN,100),U,4)
 I USAGE["L" D  Q 0
 . I TYPE="D" S TEXT(1)="FATAL: Finding number "_IND_" uses computed finding "_CFNAME_"."
 . I TYPE="T" S TEXT(1)="FATAL: Term finding number "_IND_" uses computed finding "_CFNAME_"."
 . S TEXT(2)="The Computed Finding Parameter is set to "_CFPAR_", the Usage for that reminder contains L."
 . S TEXT(3)="List type reminders cannot be used with VA-REMINDER DEFINITION."
 . D ADDTEXT(3,.TEXT,.NL,.OUTPUT)
 Q 1
 ;
 ;===============
RECCHK(DEFIEN,NL,OUTPUT) ;Check for recursion
 N RECUR,P1,P2,P3,TEXT,TYPE
 S RECUR=$$RECCHK^PXRMRCUR(DEFIEN)
 S P1=$P(RECUR,U,1)
 I P1 D
 . N DEFNAME
 . S DEFNAME=$P(^PXD(811.9,DEFIEN,0),U,1)
 . S P2=$P(RECUR,U,2)
 . S P3=$P(RECUR,U,3)
 . S TYPE=$S(P3'="":"T",1:"D")
 . I TYPE="D" D
 .. S TEXT(1)="FATAL: Finding number "_$P(P2,";",3)_" uses CF.VA-REMINDER DEFINITION."
 .. S TEXT(2)="It is recursively calling definition "_DEFNAME_"."
 . I TYPE="T" D
 .. N TNAME
 .. S TNAME=$P(^PXRMD(811.5,$P(P3,";",2),0),U,1)
 .. S TEXT(1)="FATAL: Finding number "_$P(P2,";",3)_" uses term "_TNAME_"."
 .. S TEXT(2)="This term is recursively calling definition "_DEFNAME_"."
 . D ADDTEXT(2,.TEXT,.NL,.OUTPUT)
 Q P1
 ;
