PXRMLOG ; SLC/PKR - Clinical Reminders logic routines. ;02/26/2010
 ;;2.0;CLINICAL REMINDERS;**4,6,12,17**;Feb 04, 2005;Build 102
 ;==========================================================
EVALPCL(DEFARR,PXRMPDEM,FREQ,PCLOGIC,FIEVAL) ;Evaluate the Patient Cohort
 ;Logic.
 ;Determine the applicable frequency age range set; get the baseline.
 N AGEFI,IND,FINDING,FIFREQ,FLIST,FREQDAY,MAXAGE,MINAGE,NODE,NUMAFI
 N PCLOG,PCLSTR,RANKAR,RANK,RANKFI,TEMP,TEST
 D MMF^PXRMAGE(.DEFARR,.PXRMPDEM,.MINAGE,.MAXAGE,.FREQ,.FIEVAL)
 S FIFREQ="Baseline"
 ;If there is no match with any of the baseline values FREQ=-1.
 ;If there was no frequency in the definition then FREQ="".
 ;See if any findings override the baseline.
 S TEMP=DEFARR(40)
 S NUMAFI=+$P(TEMP,U,1)
 ;If there are no age findings use the baseline.
 I NUMAFI=0 G ACHK
 S FLIST=$P(TEMP,U,2)
 F IND=1:1:NUMAFI D
 . S FINDING=$P(FLIST,";",IND)
 . I FIEVAL(FINDING) D
 .. S NODE=$S(FINDING["FF":25,1:20)
 .. S TEMP=DEFARR(NODE,FINDING,0)
 .. S RANK=+$P(TEMP,U,5)
 .. I RANK=0 S RANK=9999
 .. S FREQDAY=$$FRQINDAY^PXRMDATE($P(TEMP,U,4))
 ..;If there is no frequency with this rank ignore it.
 .. I FREQDAY]"" S RANKAR(RANK,FREQDAY,FINDING)=""
 ;If there was a ranking use it otherwise use the greatest frequency.
 I '$D(RANKAR) G ACHK
 S RANK=0
 S RANK=+$O(RANKAR(RANK))
 S FREQDAY=+$O(RANKAR(RANK,""))
 S FINDING=$O(RANKAR(RANK,FREQDAY,""))
 I FINDING'="" D
 . S NODE=$S(FINDING["FF":25,1:20)
 . S TEMP=DEFARR(NODE,FINDING,0)
 . S FREQ=$P(TEMP,U,4)
 . S MINAGE=$P(TEMP,U,2)
 . S MAXAGE=$P(TEMP,U,3)
 . S FIFREQ="Finding "_FINDING
 .;Remove the baseline age findings since they have been overridden.
 . K FIEVAL("AGE")
ACHK ;
 I FREQ="" D
 . S AGEFI=0
 . S ^TMP(PXRMPID,$J,PXRMITEM,"INFO","NOFREQ")="There is no reminder frequency!"
 E  D
 .;Save the final frequency and age range for display.
 .;Use the z so this will be the last of the info text.
 . S ^TMP(PXRMPID,$J,PXRMITEM,"zFREQARNG")=FREQ_U_MINAGE_U_MAXAGE_U_FIFREQ
 . S AGEFI=$S(FREQ=-1:0,1:$$AGECHECK^PXRMAGE(PXRMPDEM("AGE"),MINAGE,MAXAGE))
 S FIEVAL("AGE")=AGEFI
 ;
 ;Evaluate the patient cohort logic
EVAL ;
 N AGE,DPCLOG,FI,FF,FUN,FUNCTION,FUNLIST,NUM,SEX,VAR
 S TEMP=DEFARR(32)
 S NUM=+$P(TEMP,U,1)
 S (PCLOG,PCLSTR)=DEFARR(31)
 S FLIST=$P(TEMP,U,2)
 F IND=1:1:NUM D
 . S FINDING=$P(FLIST,";",IND)
 . I FINDING="AGE" S AGE=+$G(FIEVAL("AGE"))
 . I FINDING="SEX" S SEX=+$G(FIEVAL("SEX"))
 . I FINDING["FF" S TEMP=$P(FINDING,"FF",2),FF(TEMP)=FIEVAL(FINDING)
 . E  S FI(FINDING)=FIEVAL(FINDING)
 I @PCLOG
 S TEST=$T
 I 'AGEFI,PCLSTR["AGE" D
 . S ^TMP(PXRMPID,$J,PXRMITEM,"N/A","AGE")=""
 . S ^TMP(PXRMPID,$J,PXRMITEM,"INFO","AGE")="Patient does not meet any age criteria!"
 ;Reminders are always N/A for dead patients unless PXRMIDOD is true in which case
 ;the regular cohort logic applies.
 I '$G(PXRMIDOD),PXRMPDEM("DOD")'="" S TEST=0
 S PCLOGIC=TEST_U_PCLSTR
 I 'TEST S ^TMP(PXRMPID,$J,PXRMITEM,"N/A","COHORT")=""
 I $G(PXRMDEBG) D
 . S DPCLOG=PCLOG
 . F IND=1:1:NUM D
 .. S FINDING=$P(FLIST,";",IND)
 .. I FINDING="AGE" S DPCLOG=$$STRREP^PXRMUTIL(DPCLOG,"AGE",+$G(FIEVAL(FINDING))) Q
 .. I FINDING="SEX" S DPCLOG=$$STRREP^PXRMUTIL(DPCLOG,"SEX",+$G(FIEVAL(FINDING))) Q
 .. S TEMP=$S(FINDING["FF":"FF("_$P(FINDING,"FF",2)_")",1:"FI("_FINDING_")")
 .. S DPCLOG=$$STRREP^PXRMUTIL(DPCLOG,TEMP,FIEVAL(FINDING))
 S PCLOGIC=PCLOGIC_U_$G(DPCLOG)
 I $G(PXRMDEBG) S ^TMP(PXRMPID,$J,PXRMITEM,"PATIENT COHORT LOGIC")=PCLOGIC
 Q
 ;
 ;==========================================================
EVALRESL(DEFARR,RESDATE,RESLOGIC,FIEVAL) ;Evaluate the
 ;Resolution Logic.
 N DRESLOG,IND,FF,FI,FINDING,FLIST,NUM,RESLOG,RESLSTR,TEMP,TEST
 S TEMP=DEFARR(36)
 S NUM=+$P(TEMP,U,1)
 I NUM=0 Q
 S (RESLOG,RESLSTR)=DEFARR(35)
 S FLIST=$P(TEMP,U,2)
 F IND=1:1:NUM D
 . S FINDING=$P(FLIST,";",IND)
 .;Check for contraindicated in a resolution finding
 . I $G(FIEVAL(FINDING,"CONTRAINDICATED")) S FIEVAL("CONTRAINDICATED")=1
 . I FINDING["FF" S TEMP=$P(FINDING,"FF",2),FF(TEMP)=FIEVAL(FINDING)
 . E  S FI(FINDING)=FIEVAL(FINDING)
 I @RESLOG
 S TEST=$T
 I $G(PXRMDEBG) D
 . S DRESLOG=RESLOG
 . F IND=1:1:NUM D
 .. S FINDING=$P(FLIST,";",IND)
 .. S TEMP=$S(FINDING["FF":"FF("_$P(FINDING,"FF",2)_")",1:"FI("_FINDING_")")
 .. S DRESLOG=$$STRREP^PXRMUTIL(DRESLOG,TEMP,FIEVAL(FINDING))
 S RESLOGIC=TEST_U_RESLSTR_U_$G(DRESLOG)
 I $G(PXRMDEBG) S ^TMP(PXRMPID,$J,PXRMITEM,"RESOLUTION LOGIC")=RESLOGIC
 S RESDATE=$S(TEST=1:$$RESDATE(RESLSTR,.FIEVAL),1:0)
 Q
 ;
 ;==========================================================
LOGOP(DT1,DT2,LOP) ;Given two dates return the most recent if the logical
 ;operator is ! and the oldest if it is &. True FFs which don't have
 ;a date are flagged with date of -1.
 I DT1=0,DT2=0 Q 0
 I DT1=-1,DT2=-1 Q -1
 N VALUE
 I LOP="&" D  Q VALUE
 . I (DT1=0)!(DT2=0) S VALUE=0 Q
 . I DT1=-1 S VALUE=DT2 Q
 . I DT2=-1 S VALUE=DT1 Q
 . S VALUE=$S(DT1>DT2:DT2,1:DT1)
 I LOP'="!" Q 0
 I DT1=-1 Q $S(DT2>0:DT2,1:-1)
 I DT2=-1 Q $S(DT1>0:DT1,1:-1)
 Q $S(DT1>DT2:DT1,1:DT2)
 ;
 ;==========================================================
RESDATE(RESLSTR,FIEVAL) ;Return the resolution date based on the following
 ;rules:
 ; Dates that are ORed use the most recent.
 ; Dates that are ANDed use the oldest.
 ;Note: This is routine is call only if the resolution logic is true.
 N DATE,DSTRING,DT1,DT2,DT3,IND,INDEX,JND
 N OPER,PFSTACK,STACK,TEMP
 ;Remove leading (n) entries.
 I ($E(RESLSTR,1,4)="(0)!")!($E(RESLSTR,1,4)="(1)&") S $E(RESLSTR,1,4)=""
 ;If a finding is NOTTED and the resolution logic evaluates to true
 ;then the finding must be false so it will not have a date,
 ;therefore change 'FI into FF since FFs don't have dates.
 S DSTRING=$$STRREP^PXRMUTIL(RESLSTR,"'FI","FF")
 ;Replace true findings with their dates.
 S OPER="!&"
 D POSTFIX^PXRMSTAC(DSTRING,OPER,.PFSTACK)
 S JND=0
 F IND=1:1:PFSTACK(0) D
 . S TEMP=PFSTACK(IND)
 . I TEMP="FI" D  Q
 .. S IND=IND+1,INDEX=PFSTACK(IND)
 .. S DATE=$S(FIEVAL(INDEX)=1:FIEVAL(INDEX,"DATE"),1:0)
 .. S JND=JND+1,STACK(JND)=DATE
 . I TEMP["FF" D  Q
 .. S IND=IND+1,INDEX=PFSTACK(IND)
 ..;FFs do not have dates, flag with -1.
 .. S DATE=-1,JND=JND+1,STACK(JND)=DATE
 . I OPER[TEMP S JND=JND+1,STACK(JND)=TEMP
 S STACK(0)=JND
 K PFSTACK
 S PFSTACK(0)=0
 F IND=1:1:STACK(0) D
 . S TEMP=STACK(IND)
 . I OPER[TEMP D
 ..;Pop the top two elements on the stack and do the operation.
 .. S DT1=$$POP^PXRMSTAC(.PFSTACK)
 .. S DT2=$$POP^PXRMSTAC(.PFSTACK)
 .. S DT3=$$LOGOP(DT1,DT2,TEMP)
 ..;Save the result back on the stack
 .. D PUSH^PXRMSTAC(.PFSTACK,DT3)
 . E  D PUSH^PXRMSTAC(.PFSTACK,TEMP)
 ;The result is the only thing left on the stack.
 Q $$POP^PXRMSTAC(.PFSTACK)
 ;
 ;==========================================================
SEX(DEFARR,SEX) ;Return FALSE (0) if the patient is the wrong sex for
 ; the reminder, TRUE (1) is the patient is the right sex.
 N REMSEX
 S REMSEX=$P(DEFARR(0),U,9)
 I REMSEX="" Q 1
 I SEX=REMSEX Q 1
 S ^TMP(PXRMPID,$J,PXRMITEM,"N/A","SEX")=""
 S ^TMP(PXRMPID,$J,PXRMITEM,"INFO","SEX")="Patient is the wrong sex!"
 Q 0
 ;
 ;==========================================================
VALID(LOGSTR,DA,MINLEN,MAXLEN) ;Make sure that LOGSTR is a valid logic string.
 ;This is called by the input transform for PATIENT COHORT LOGIC and
 ;RESOLUTION LOGIC. Return 1 if LOGSTR is ok.
 ;Don't do this if this is being called as a result of an install
 ;through the Exchange Utility.
 I $G(PXRMEXCH) Q 1
 I LOGSTR="" Q 0
 ;
 ;Check the length.
 N LEN
 S LEN=$L(LOGSTR)
 I LEN<MINLEN D  Q 0
 . D EN^DDIOL("Logic string is too short")
 I LEN>MAXLEN D  Q 0
 . D EN^DDIOL("Logic string is too long")
 ;
 ;Use the FileMan code validator to check the code.
 N TEST,X
 S X="S Y="_$TR(LOGSTR,";","")
 D ^DIM
 I $D(X)=0 D  Q 0
 . S TEXT(1)="LOGIC string: "_LOGSTR
 . S TEXT(2)="contains invalid MUMPS code!"
 . D EN^DDIOL(.TEXT)
 ;
 N ELE1,ELE2,MNUM,SEP,STACK,TEXT,TSTSTR,VALID
 ;Make sure the entries in LOGSTR are valid elements or functions.
 S TSTSTR=LOGSTR
 S TSTSTR=$TR(TSTSTR,"'","")
 S TSTSTR=$TR(TSTSTR,"&",U)
 S TSTSTR=$TR(TSTSTR,"!",U)
 ;Set the allowable logic separators.
 S SEP="^,<>="
 ;Convert the string to postfix form for evaluation.
 D POSTFIX^PXRMSTAC(TSTSTR,SEP,.STACK)
 S (ELE1,VALID)=1
 F  Q:(ELE1="")!(VALID=0)  D
 . S ELE1=$$POP^PXRMSTAC(.STACK)
 . I SEP[ELE1 Q
 .;If the element is FI or FF then the next element should be a number.
 . S MNUM=$S(ELE1="FI":20,ELE1="FF":25,1:"")
 . I MNUM'="" D
 .. S ELE2=$$POP^PXRMSTAC(.STACK)
 .. I ELE2'=+ELE2 S VALID=0
 .. I VALID S VALID=$D(^PXD(811.9,DA,MNUM,ELE2))
 .. I 'VALID D
 ... S TEXT=ELE1_"("_ELE2_") is not in this definition!"
 ... D EN^DDIOL(TEXT)
 Q VALID
 ;
 ;==========================================================
VALIDR(LOGSTR,DA,MINLEN,MAXLEN) ;Make sure that LOGSTR is a valid resolution 
 ;logic string. This is called by the input transform for RESOLUTION
 ;LOGIC. Return 1 if LOGSTR is ok.
 ;Don't do this if this is being called as a result of an install
 ;through the Exchange Utility.
 I $G(PXRMEXCH) Q 1
 I LOGSTR="" Q 0
 N TEXT
 ;The resolution logic cannot contain SEX or AGE.
 I LOGSTR["AGE" D  Q 0
 . S TEXT="The resolution logic cannot contain AGE!"
 . D EN^DDIOL(TEXT)
 I LOGSTR["SEX" D  Q 0
 . S TEXT="The resolution logic cannot contain SEX!"
 . D EN^DDIOL(TEXT)
 ;Now call the regular logic string validator.
 Q $$VALID(LOGSTR,DA,MINLEN,MAXLEN)
 ;
