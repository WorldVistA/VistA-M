PXRMPLST ; SLC/PKR - Build a patient list from a reminder definition. ;01/24/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;Input  :  RIEN     - Reminder IEN
 ;          PLIST    - List returned in ^TMP($J,PLIST,DFN)
 ;          DFNONLY  - If true list contains only DFN information
 ;          PXRMDATE - Evaluation date
 ;===================================================
BLDPLST(DEFARR,PLIST,DFNONLY) ;
 N DFN,DOBE,DOBS,ELE,ERROR,ERRSTR,IND,FNUM
 N LIST1,LIST2,LNAME,LSP,LSTACK
 N NDR,NOT,OPER,PCLOG,PFSTACK,SEX,TYPE
 ;
 ;Get the cohort logic string. This has passed a validation before
 ;it can be selected for building patient lists so we don't need to
 ;check it here.
 S PCLOG=DEFARR(31)
 I PCLOG="" Q
 S OPER="!&~"
 ;Get the sex field, if PCLOG does not contain SEX set it to null.
 S SEX=$S(PCLOG["SEX":$P(DEFARR(0),U,9),1:"")
 ;If PCLOG contains age build the corresponding date of birth range(s).
 I PCLOG["AGE" D DOBR(.DEFARR,.NDR,.DOBS,.DOBE)
 ;Replace &' with ~ so the stack will be built properly.
 S PCLOG=$$STRREP^PXRMUTIL(PCLOG,"&'","~")
 D POSTFIX^PXRMSTAC(PCLOG,OPER,.PFSTACK)
 ;Process the logic.
 D CFSAA(.PFSTACK)
 S (IND,ERROR,LSP,LSTACK(0),NOT)=0
 F  Q:(IND'<PFSTACK(0))!(ERROR)  D
 . S IND=IND+1,ELE=PFSTACK(IND)
 . I ELE["'" S NOT=1
 . S TYPE=$S(ELE="'":"NOT",ELE["AGE":"A",ELE["FI":"FI",ELE["FF":"FF",ELE="SAA":"SAA",ELE["SEX":"S",OPER[ELE:"OP",1:"")
 .;
 . I TYPE="A" D  Q
 .. S LNAME="LIST"_IND
 .. D LSA("",NDR,.DOBS,.DOBE,LNAME)
 .. D PUSH^PXRMSTAC(.LSTACK,LNAME)
 .. D AGEFI(.DEFARR,LNAME,SEX,"")
 .;
 . I TYPE="FI" D  Q
 .. S IND=IND+1,FNUM=PFSTACK(IND)
 .. I +FNUM'=FNUM S ERROR=1,ERRSTR="Error - having a finding not followed by a number" Q
 .. S LNAME="LIST"_IND
 .. D EVALPL^PXRMEVFI(.DEFARR,FNUM,LNAME)
 .. D PUSH^PXRMSTAC(.LSTACK,LNAME)
 .;
 . I TYPE="FF" D  Q
 .. S IND=IND+1,FNUM=PFSTACK(IND)
 .. I +FNUM'=FNUM S ERROR=1,ERRSTR="Error - having a function finding not followed by a number"
 .. S LNAME="LIST"_IND
 .. D EVALPL^PXRMFF(.DEFARR,"FF"_FNUM,LNAME)
 .. D PUSH^PXRMSTAC(.LSTACK,LNAME)
 .;
 . I TYPE="NOT" S NOT=1 Q 
 .;
 . I TYPE="OP" D  Q
 .. S LIST2=$$POP^PXRMSTAC(.LSTACK)
 .. S LIST1=$$POP^PXRMSTAC(.LSTACK)
 .. I NOT S ELE=ELE_"'",NOT=0
 .. D LOGOP(LIST1,LIST2,ELE)
 .. D PUSH^PXRMSTAC(.LSTACK,LIST1)
 .. K ^TMP($J,LIST2)
 .;
 . I TYPE="S" D  Q
 .. S LNAME="LIST"_IND
 .. D LSEX(SEX,LNAME,.LSTACK)
 .. D PUSH^PXRMSTAC(.LSTACK,LNAME)
 .;
 . I TYPE="SAA" D  Q
 .. S LNAME="LIST"_IND
 .. D LSA(SEX,NDR,.DOBS,.DOBE,LNAME)
 .. D PUSH^PXRMSTAC(.LSTACK,LNAME)
 .. D AGEFI(.DEFARR,LNAME,SEX,"")
 .;
 S LIST1=$$POP^PXRMSTAC(.LSTACK)
 ;If AGE is not in the cohort logic look for any findings that set the
 ;frequency to 0Y and therefore remove the patient from the cohort.
 I PCLOG'["AGE" D AGEFI(.DEFARR,LIST1,"","0Y")
 ;
 I $G(DFNONLY) D
 . S DFN=0
 . F  S DFN=$O(^TMP($J,LIST1,1,DFN)) Q:DFN=""  D
 .. S ^TMP($J,PLIST,DFN)=""
 E  M ^TMP($J,PLIST)=^TMP($J,LIST1)
 K ^TMP($J,LIST1)
 Q
 ;
 ;==================================================
AGEFI(DEFARR,LNAME,SEX,ONLYFREQ) ;Check for patients that need to be
 ;added or removed because of a finding that changes the age range.
 N DEL,DFN,DOB,DOBE,DOBS,FILIST,FINUM,FREQ,IND,JND,LOGOP
 N MINAGE,MAXAGE,NUMAFI,PSEX,RANK,RANKARR,RF,TEMP,TGLIST
 S NUMAFI=$P(DEFARR(40),U,1)
 I NUMAFI=0 Q
 S FILIST=$P(DEFARR(40),U,2)
 F IND=1:1:NUMAFI D
 . S FINUM=$P(FILIST,";",IND)
 . S TEMP=$S(FINUM["FF":DEFARR(25,FINUM,0),1:DEFARR(20,FINUM,0))
 . S RANK=+$P(TEMP,U,5)
 . I RANK=0 S RANK=9999
 . S FREQ=$$FRQINDAY^PXRMDATE($P(TEMP,U,4))
 .;If there is no frequency with this rank ignore it.
 . I FREQ]"" S RANKARR(RANK,FREQ,FINUM)=""
 S IND=0,RANK=""
 F  S RANK=$O(RANKARR(RANK)) Q:RANK=""  D
 . S FREQ=""
 . F  S FREQ=$O(RANKARR(RANK,FREQ)) Q:FREQ=""  D
 .. S FINUM=0
 .. F  S FINUM=$O(RANKARR(RANK,FREQ,FINUM)) Q:FINUM=""  D
 ... S IND=IND+1,RF(IND)=FINUM
 I IND'=NUMAFI W !,"Error in AGEFI^PXRMPLST - Ranking failed!"
 ;Build a list for each age finding.
 F IND=1:1:NUMAFI D
 . S FINUM=RF(IND)
 . S TGLIST="AGEFI"_FINUM
 . S TEMP=$S(FINUM["FF":DEFARR(25,FINUM,0),1:DEFARR(20,FINUM,0))
 . S FREQ=$P(TEMP,U,4)
 . I ONLYFREQ="0Y",FREQ'="0Y" S LOGOP(IND)="~" Q
 . S LOGOP(IND)=$S(FREQ="0Y":"~",FREQ="":"~",1:"!")
 . S MINAGE=$P(TEMP,U,2)
 . S MAXAGE=$P(TEMP,U,3)
 . S DOBE=$S(MINAGE="":$$NOW^PXRMDATE,1:$$GETDOB(MINAGE,"MIN"))
 . S DOBS=$S(MAXAGE="":0,1:$$GETDOB(MAXAGE,"MAX"))
 . K ^TMP($J,TGLIST)
 . I FINUM=+FINUM D EVALPL^PXRMEVFI(.DEFARR,FINUM,TGLIST)
 . I FINUM["FF" D EVALPL^PXRMFF(.DEFARR,FINUM,TGLIST)
 .;Filter TGLIST based on the age range.
 . S DFN=$S(FREQ="0Y":$O(^TMP($J,TGLIST,1,""),-1),1:0)
 . F  S DFN=$O(^TMP($J,TGLIST,1,DFN)) Q:DFN=""  D
 .. S DEL=0
 ..;Reference to ^DPT DBIA #10035
 .. S PSEX=$P(^DPT(DFN,0),U,2),DOB=$P(^DPT(DFN,0),U,3)
 .. I SEX'="",PSEX'=SEX S DEL=1
 .. I (DOB<DOBS)!(DOB>DOBE) S DEL=1
 .. I DEL K ^TMP($J,TGLIST,0,DFN),^TMP($J,TGLIST,1,DFN)
 ;Remove patients on a list with a higher rank from all lists with
 ;a lower rank.
 F IND=1:1:NUMAFI D
 . F JND=IND+1:1:NUMAFI D LOGOP("AGEFI"_RF(JND),"AGEFI"_RF(IND),"~")
 F IND=1:1:NUMAFI D
 . D LOGOP(LNAME,"AGEFI"_RF(IND),LOGOP(IND))
 . K ^TMP($J,"AGEFI"_RF(IND))
 Q
 ;
 ;==================================================
CFSAA(STACK) ;Check for the first three elements on the stack being
 ;SEX, AGE, and &. If that is the case replace the with the "special"
 ;finding SAA.
 N EL1,EL2,EL3,SAA
 S SAA=0
 S EL1=$G(STACK(1)),EL2=$G(STACK(2)),EL3=$G(STACK(3))
 I EL1="SEX",EL2="AGE",EL3="&" S SAA=1
 I EL1="AGE",EL2="SEX",EL3="&" S SAA=1
 I 'SAA Q
 ;Create a new pseudo-element for SEX&AGE.
 S EL1=$$POP^PXRMSTAC(.STACK)
 S EL1=$$POP^PXRMSTAC(.STACK)
 S EL1=$$POP^PXRMSTAC(.STACK)
 D PUSH^PXRMSTAC(.STACK,"SAA")
 Q
 ;
 ;==================================================
DOBR(DEFARR,NDR,DOBS,DOBE) ;Build the date of birth range.
 N IND,FREQ,MINAGE,MAXAGE,TEMP
 S (IND,NDR)=0
 F  S IND=+$O(DEFARR(7,IND)) Q:IND=0  D
 . S TEMP=DEFARR(7,IND,0)
 . S FREQ=$P(TEMP,U,1)
 . I (FREQ="0Y")!(FREQ="") Q
 . S MINAGE=$P(TEMP,U,2)
 . S MAXAGE=$P(TEMP,U,3)
 . S NDR=NDR+1
 . S DOBE(NDR)=$S(MINAGE="":$$NOW^PXRMDATE,1:$$GETDOB(MINAGE,"MIN"))
 . S DOBS(NDR)=$S(MAXAGE="":0,1:$$GETDOB(MAXAGE,"MAX"))
 Q
 ;
 ;==================================================
GENTERM(FINDING,FINUM,TERMARR) ;Given a reminder finding generate a term
 ;for patient list evaluation.
 N IEN,IND,TEMP,TYPE
 S TEMP=$P(FINDING,U,1)
 S IEN=$P(TEMP,";",1)
 S TYPE=$P(TEMP,";",2)
 ;If the finding is a term just load the term.
 I TYPE="PXRMD(811.5," D TERM^PXRMLDR(IEN,.TERMARR) Q
 S TERMARR(0)="GENERATED"
 S TERMARR("IEN")=0
 M TERMARR(20,1)=DEFARR(20,FINUM)
 S TERMARR("E",TYPE,IEN,1)=""
 Q
 ;
 ;==================================================
GETDOB(AGE,TYPE) ;Given an age in years return the corresponding date of
 ;birth. If TYPE is MIN then find the date of birth that will make them
 ;that age. If TYPE is MAX find the last day that will make them
 ;that age, i.e., the next day is their birthday.
 N DATE,DOB
 S DATE=$$NOW^PXRMDATE
 I TYPE="MIN" S DOB=DATE-(10000*AGE)
 I TYPE="MAX" S DOB=DATE-(10000*(AGE+1)),DOB=$$FMADD^XLFDT(DOB,1)
 Q DOB
 ;
 ;==================================================
LOGOP(LIST1,LIST2,LOGOP) ;Given LIST1 and LIST2 apply the logical
 ;operator LOGOP to generate a new list and return it in LIST1
 N DFN1,DFN2
 I LOGOP="&" D  Q
 . S DFN1=""
 . F  S DFN1=$O(^TMP($J,LIST1,1,DFN1)) Q:DFN1=""  D
 .. I $D(^TMP($J,LIST2,1,DFN1)) M ^TMP($J,LIST1,1,DFN1)=^TMP($J,LIST2,1,DFN1) Q
 .. K ^TMP($J,LIST1,1,DFN1)
 ;
 ;"~" represents "&'".
 I LOGOP="~" D  Q
 . S DFN1=""
 . F  S DFN1=$O(^TMP($J,LIST1,1,DFN1)) Q:DFN1=""  D
 .. I $D(^TMP($J,LIST2,1,DFN1)) K ^TMP($J,LIST1,1,DFN1)
 ;
 I LOGOP="!" D
 . S DFN2=""
 . F  S DFN2=$O(^TMP($J,LIST2,1,DFN2)) Q:DFN2=""  D
 .. M ^TMP($J,LIST1,1,DFN2)=^TMP($J,LIST2,1,DFN2)
 Q
 ;
 ;==================================================
LSA(SEX,NDR,DOBS,DOBE,LNAME) ;Build a list from a SEX & AGE finding.
 ;Reference to ^DPT DBIA #10035
 N DFN,DS,IND,SEXOK
 F IND=1:1:NDR D
 . S DS=DOBS(IND)-.000001
 . F  S DS=$O(^DPT("ADOB",DS)) Q:(DS>DOBE(IND))!(DS="")  D
 .. S DFN=""
 .. F  S DFN=$O(^DPT("ADOB",DS,DFN)) Q:DFN=""  D
 ... S SEXOK=$S(SEX="":1,$D(^DPT("ASX",SEX,DFN)):1,1:0)
 ... I SEXOK S ^TMP($J,LNAME,1,DFN,1,"SAA")=""
 Q
 ;
 ;==================================================
LSEX(SEX,LNAME,LSTACK) ;Build a list from a SEX finding.
 ;Reference to ^DPT DBIA #10035
 N ELIST
 ;Start with the existing list to build a list based on sex.
 S ELIST=$$POP^PXRMSTAC(.LSTACK)
 D PUSH^PXRMSTAC(.LSTACK,ELIST)
 S DFN=0
 F  S DFN=$O(^TMP($J,ELIST,1,DFN)) Q:DFN=""  D
 . I $D(^DPT("ASX",SEX,DFN)) S ^TMP($J,LNAME,1,DFN,SEX,1)=""
 Q
 ;
