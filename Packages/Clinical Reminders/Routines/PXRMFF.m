PXRMFF ;SLC/PKR - Clinical Reminders function finding evaluation. ;03/12/2013
 ;;2.0;CLINICAL REMINDERS;**4,6,11,18,22,24,26**;Feb 04, 2005;Build 404
 ;===========================================
EVAL(DFN,DEFARR,FIEVAL) ;Evaluate function findings.
 N ARGLIST,FFIND,FFN,FN,FUN,FUNIND,FUNN,FVALUE,JND
 N LOGIC,LOGVAL,NL,ROUTINE,TEMP
 I '$D(DEFARR(25)) Q
 S FFN="FF"
 F  S FFN=$O(DEFARR(25,FFN)) Q:FFN'["FF"  D
 . K FN
 . S FUNIND=0
 . F  S FUNIND=+$O(DEFARR(25,FFN,5,FUNIND)) Q:FUNIND=0  D
 .. S FUNN=$P(DEFARR(25,FFN,5,FUNIND,0),U,1)
 .. S FUN=$P(DEFARR(25,FFN,5,FUNIND,0),U,2)
 .. S TEMP=^PXRMD(802.4,FUN,0)
 .. S ROUTINE=$P(TEMP,U,2,3)_"(.ARGLIST,.FIEVAL,.FVALUE)"
 .. K ARGLIST
 .. S (JND,NL)=0
 .. F  S JND=+$O(DEFARR(25,FFN,5,FUNIND,20,JND)) Q:JND=0  D
 ... S NL=NL+1
 ... S ARGLIST(NL)=DEFARR(25,FFN,5,FUNIND,20,JND,0)
 .. S ARGLIST(0)=NL
 .. D @ROUTINE
 .. S FN(FUNIND)=FVALUE
 . S LOGIC=$G(DEFARR(25,FFN,10))
 . S LOGIC=$S(LOGIC'="":LOGIC,1:0)
 . S LOGVAL=$$EVALLOG(LOGIC,.FN)
 . S FIEVAL(FFN)=LOGVAL
 . S FIEVAL(FFN,"NUMBER")=$P(FFN,"FF",2)
 . S FIEVAL(FFN,"FINDING")=$G(FUN)_";PXRMD(802.4,"
 . I $G(PXRMDEBG) D
 .. S ^TMP(PXRMPID,$J,"FFDEB",FFN,"DETAIL")=FIEVAL(FFN)_U_DEFARR(25,FFN,3)_U_$$NLOGIC(LOGIC,.FN)
 .. I $G(PXRMFFSS) D SBSDISP(LOGIC,FFN,.FN)
 Q
 ;
 ;===========================================
EVALLOG(LOGIC,FN) ;Evaluate the logic string.
 N DIVBY0,DIVOP,IND,NLOGIC,NODIV,NULL,NUMSTACK,OP1,OP2,OPER,OPERS
 N PFSTACK,RES,TEMP,UNARY
 I LOGIC="" Q 0
 S NULL="" ;REMOVE THIS WHEN DONE FIXING.
 S NODIV=$S(LOGIC["/":0,LOGIC["\":0,LOGIC["#":0,1:1)
 I NODIV Q @LOGIC
 S NULL=""
 S DIVBY0=0,DIVOP="/\#"
 S OPERS=$$GETOPERS^PXRMFFDB
 S NLOGIC=$$NLOGIC(LOGIC,.FN)
 D POSTFIX^PXRMSTAC(NLOGIC,OPERS,.PFSTACK)
 F IND=1:1:PFSTACK(0) D
 . S TEMP=PFSTACK(IND)
 .;Check for a unary operator.
 . S UNARY=$S(TEMP="+U":1,TEMP="-U":1,TEMP="'U":1,1:0)
 . S OPER=$S(UNARY:$E(TEMP,1),1:TEMP)
 . I OPERS'[OPER D PUSH^PXRMSTAC(.NUMSTACK,TEMP) Q
 .;If control gets to here we have an operator.
 . S OP2=$$POP^PXRMSTAC(.NUMSTACK)
 . S OP2=$$STRCLEAN(OP2)
 . I UNARY S TEMP="S RES="_OPER_"OP2"
 . I 'UNARY D
 .. S OP1=$$POP^PXRMSTAC(.NUMSTACK)
 .. S OP1=$$STRCLEAN(OP1)
 ..;Flag division by 0 with ~
 .. I DIVOP[OPER,+OP2=0 S DIVBY0=1,TEMP="S RES=""~"""
 .. E  S TEMP="S RES=OP1"_OPER_"OP2"
 .;Do the math and put the result on the stack. The result of division
 .;by 0 with any operator is 0.
 . I ($G(OP1)="~")!(OP2="~") S RES=0
 . E  X TEMP
 . D PUSH^PXRMSTAC(.NUMSTACK,RES)
 S RES=$$POP^PXRMSTAC(.NUMSTACK)
 I PFSTACK(0)=1 D
 . I @NLOGIC S RES=1
 . E  S RES=0
 Q RES
 ;
 ;===========================================
EVALPL(DEFARR,FFIND,PLIST) ;Build a list of patients based on a function
 ;finding.
 N ARGL,ARGLIST,AT,COUNT,DAS,DATE,DFN
 N FI,FIEVAL,FIEVT,FILIST,FILENUM,FINDPA,FN
 N FUN,FUNCTION,FUNNM,FUNN,FUNNUM,FVALUE
 N IND,ITEM,JND,LOGIC,LNAME,NARG,NFI,NFUN
 N ROUTINE,TEMP,TERMARR,UNIQFIL
 S LOGIC=DEFARR(25,FFIND,10)
 I LOGIC="" Q
 ;Build the list of functions and findings used by the function finding.
 S (FUNNUM,NFUN)=0
 F  S FUNNUM=+$O(DEFARR(25,FFIND,5,FUNNUM)) Q:FUNNUM=0  D
 . S NFUN=NFUN+1
 . S FUNN=$P(DEFARR(25,FFIND,5,FUNNUM,0),U,1)
 . S FUN=$P(DEFARR(25,FFIND,5,FUNNUM,0),U,2)
 . S TEMP=^PXRMD(802.4,FUN,0)
 . S FUN=$P(TEMP,U,1)
 . S FUNCTION(NFUN)=$TR(FUN,"_","")
 . S ROUTINE(NFUN)=$P(TEMP,U,2,3)_"(.ARGL,.FIEVAL,.FVALUE)"
 . S (FI,NARG,NFI)=0
 . F  S FI=+$O(DEFARR(25,FFIND,5,FUNNUM,20,FI)) Q:FI=0  D
 .. S NARG=NARG+1,ARGLIST(NFUN,NARG)=DEFARR(25,FFIND,5,FUNNUM,20,FI,0)
 .. S AT=$$ARGTYPE^PXRMFFAT(FUNCTION(NFUN),FI)
 .. I AT="F" S NFI=NFI+1,FILIST(NFUN,NFI)=ARGLIST(NFUN,NARG)
 . S ARGLIST(NFUN,0)=NARG
 . S FILIST(NFUN,0)=NFI
 ;A finding may be used in more than one function in the function
 ;finding so build a list of the unique findings.
 F IND=1:1:NFUN D
 . F JND=1:1:FILIST(IND,0) D
 .. S TEMP=$P(DEFARR(20,FILIST(IND,JND),0),U,1)
 .. S ITEM=$P(TEMP,";",1)
 .. S FILENUM=$$GETFNUM^PXRMDATA($P(TEMP,";",2))
 .. S UNIQFIL(FILIST(IND,JND))=""
 K ^TMP($J,"PXRMFFDFN")
 S IND=0
 F  S IND=$O(UNIQFIL(IND)) Q:IND=""  D
 . S FINDPA(0)=DEFARR(20,IND,0)
 . S FINDPA(3)=DEFARR(20,IND,3)
 . S FINDPA(10)=DEFARR(20,IND,10)
 . S FINDPA(11)=DEFARR(20,IND,11)
 . D GENTERM^PXRMPLST(FINDPA(0),IND,.TERMARR)
 . S LNAME(IND)="PXRMFF"_IND
 . K ^TMP($J,LNAME(IND))
 . D EVALPL^PXRMTERL(.FINDPA,.TERMARR,LNAME(IND))
 .;Get rid of the false part of the list.
 . K ^TMP($J,LNAME(IND),0)
 .;Build a complete list of patients.
 . S DFN=0
 . F  S DFN=$O(^TMP($J,LNAME(IND),1,DFN)) Q:DFN=""  S ^TMP($J,"PXRMFFDFN",DFN)=""
 ;Evaluate the function finding for each patient. If the function
 ;finding is true then add the patient to PLIST.
 S DFN=0
 F  S DFN=$O(^TMP($J,"PXRMFFDFN",DFN)) Q:DFN=""  D
 . K FIEVAL
 . S IND=""
 . F  S IND=$O(UNIQFIL(IND)) Q:IND=""  D
 .. S FIEVAL(IND)=0
 .. S ITEM=""
 .. F  S ITEM=$O(^TMP($J,LNAME(IND),1,DFN,ITEM)) Q:ITEM=""  D
 ... S COUNT=0
 ... F  S COUNT=$O(^TMP($J,LNAME(IND),1,DFN,ITEM,COUNT)) Q:COUNT=""  D
 .... S FILENUM=$O(^TMP($J,LNAME(IND),1,DFN,ITEM,COUNT,""))
 .... S TEMP=^TMP($J,LNAME(IND),1,DFN,ITEM,COUNT,FILENUM)
 .... S DAS=$P(TEMP,U,1)
 .... S DATE=$P(TEMP,U,2)
 .... K FIEVT
 .... D GETDATA^PXRMDATA(FILENUM,DAS,.FIEVT)
 .... M FIEVAL(IND,COUNT)=FIEVT
 .... S FIEVAL(IND,COUNT,"DATE")=DATE,FIEVAL(IND,COUNT)=1
 .;Save the top level results for each finding.
 . S IND=0
 . F  S IND=$O(FIEVAL(IND)) Q:IND=""  D
 .. K FIEVT M FIEVT=FIEVAL(IND)
 .. S NFI=+$O(FIEVT(""),-1)
 .. D SFRES^PXRMUTIL(-1,NFI,.FIEVT)
 .. K FIEVAL(IND) M FIEVAL(IND)=FIEVT
 .;Evaluate the function finding for this patient.
 . K FN
 . F IND=1:1:NFUN D
 .. K ARGL M ARGL=ARGLIST(IND)
 .. D @ROUTINE(IND)
 .. S FN(IND)=FVALUE
 . I @LOGIC S ^TMP($J,PLIST,1,DFN,1,FFIND)=""
 ;Clean up.
 K ^TMP($J,"PXRMFFDFN")
 S IND=""
 F  S IND=$O(UNIQFIL(IND)) Q:IND=""  K ^TMP($J,LNAME(IND))
 Q
 ;
 ;===========================================
MHVOUT(INDENT,IFIEVAL,NLINES,TEXT) ;Produce the MHV output.
 ;None currently defined.
 Q
 ;
 ;===========================================
NLOGIC(LOGIC,FN) ;Replace the symbols in the logic string with their values.
 N IND,NLOGIC,TEMP
 I LOGIC="" Q 0
 S NLOGIC=LOGIC
 I NLOGIC["$P" S NLOGIC=$$PRP(NLOGIC)
 I $D(PXRMAGE) S NLOGIC=$$STRREP^PXRMUTIL(NLOGIC,"PXRMAGE",PXRMAGE)
 I $D(PXRMDOB) S NLOGIC=$$STRREP^PXRMUTIL(NLOGIC,"PXRMDOB",PXRMDOB)
 I $D(PXRMDOD) S NLOGIC=$$STRREP^PXRMUTIL(NLOGIC,"PXRMDOD",PXRMDOD)
 I $D(PXRMLAD) S NLOGIC=$$STRREP^PXRMUTIL(NLOGIC,"PXRMLAD",PXRMLAD)
 I $D(PXRMSEX) S NLOGIC=$$STRREP^PXRMUTIL(NLOGIC,"PXRMSEX",""""_PXRMSEX_"""")
 S IND=""
 F  S IND=$O(FN(IND)) Q:IND=""  D
 . S TEMP=$S(FN(IND)="":"NULL",1:FN(IND))
 . S NLOGIC=$$STRREP^PXRMUTIL(NLOGIC,"FN("_IND_")",TEMP)
 Q NLOGIC
 ;
 ;===========================================
OUTPUT(INDENT,IFIEVAL,NLINES,TEXT) ;Produce the clinical
 ;maintenance output. None currently defined.
 Q
 ;
 ;===========================================
PRP(LOGIC) ;Process $P in logic.
 N IND,PFSTACK,RES,T1,TEMP
 D POSTFIX^PXRMSTAC(LOGIC,"",.PFSTACK)
 F IND=1:1:PFSTACK(0) D
 . I PFSTACK(IND)'="$P" Q
 . S IND=IND+1,T1=PFSTACK(IND)
 . I T1="FN" S IND=IND+1,T1=T1_"("_PFSTACK(IND)_")",IND=IND+1,T1=T1_PFSTACK(IND)
 . S TEMP="$P("_T1_")"
 . S T1="S RES="_TEMP
 . X T1
 . I RES="" S RES="NULL"
 . S LOGIC=$$STRREP^PXRMUTIL(LOGIC,TEMP,RES)
 Q LOGIC
 ;
 ;===========================================
SBSDISP(LOGIC,FFN,FN) ;Create a step-by-step display of the function finding
 ;evaluation for reminder test.
 N DIVOP,IND,NLOGIC,NUMSTACK,OP1,OP2,OPER,OPERS,PFSTACK
 N RES,TEMP,TEXT,UNARY
 N NSTEPS,REPL
 I LOGIC="" Q 0
 S NSTEPS=0
 S DIVOP="/\#"
 S OPERS=$$GETOPERS^PXRMFFDB
 S NLOGIC=$$NLOGIC(LOGIC,.FN)
 K ^TMP("PXRMFFSS",$J,FFN)
 S ^TMP("PXRMFFSS",$J,FFN,0)=NLOGIC
 D POSTFIX^PXRMSTAC(NLOGIC,OPERS,.PFSTACK)
 F IND=1:1:PFSTACK(0) D
 . S TEMP=PFSTACK(IND)
 .;Check for a unary operator.
 . S UNARY=$S(TEMP="+U":1,TEMP="-U":1,TEMP="'U":1,1:0)
 . S OPER=$S(UNARY:$E(TEMP,1),1:TEMP)
 . I OPERS'[OPER D PUSH^PXRMSTAC(.NUMSTACK,TEMP) Q
 .;If control gets to here we have an operator.
 . S OP2=$$POP^PXRMSTAC(.NUMSTACK)
 . S OP2=$$STRCLEAN(OP2)
 . I UNARY S TEMP="S RES="_OPER_"OP2",TEXT=OPER_OP2
 . I 'UNARY D
 .. S OP1=$$POP^PXRMSTAC(.NUMSTACK)
 .. S OP1=$$STRCLEAN(OP1)
 ..;Flag division by 0 with ~
 .. I DIVOP[OPER,+OP2=0 S TEMP="S RES=""~""",TEXT="0/0"
 .. E  S TEMP="S RES=OP1"_OPER_"OP2",TEXT=OP1_OPER_OP2
 .;Do the math and put the result on the stack. The result of division
 .;by 0 with any operator is 0.
 . I ($G(OP1)="~")!(OP2="~") S RES=0
 . E  X TEMP
 . S NSTEPS=NSTEPS+1
 . S ^TMP("PXRMFFSS",$J,FFN,NSTEPS)=TEXT_"="_RES
 . D PUSH^PXRMSTAC(.NUMSTACK,RES)
 S RES=$$POP^PXRMSTAC(.NUMSTACK)
 I PFSTACK(0)=1 D
 . S RES=$S(NLOGIC:1,1:0)
 . S ^TMP("PXRMFFSS",$J,FFN,1)=PFSTACK(1)_"="_RES
 Q
 ;
 ;===========================================
STRCLEAN(STRING) ;Remove extra quotes from strings.
 I +STRING=STRING Q STRING
 N LEN,QUOTE
 S QUOTE=$C(34)
 S LEN=$L(STRING)
 I ($E(STRING,1)=QUOTE),($E(STRING,LEN)=QUOTE) Q $E(STRING,2,LEN-1)
 Q STRING
 ;
