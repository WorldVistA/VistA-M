DGREGTED ;ALB/BAJ - Temporary & Confidential Address Edits API ; 8/1/08 1:22pm
 ;;5.3;Registration;**688**;Aug 13, 1993;Build 29
EN(DFN,TYPE,RET) ;Entry point
 ; This routine controls Edits to Temporary & Confidential addresses
 ; 
 ; Input
 ;       DFN  = Patient DFN
 ;       TYPE = Type of address: "TEMP" or "CONF"
 ;       RET  = Flag to signal return to first prompt
 ;       
 ; Output
 ;       RET  0 = Return to first prompt
 ;            1 = Do not return
 ;       
 N DGINPUT,FORGN,FSTR,ICNTRY,CNTRY,PSTR,DGCMP,DGOLD
 N FSLINE1,FSLINE2,FSLINE3,FCITY,FSTATE,FCOUNTY,FZIP,FPHONE
 N FPROV,FPSTAL,FCNTRY,FNODE1,FNODE2,CPEICE,OLDC,RPROC
 N I,X,Y
 I $G(DFN)="" Q
 ;I ($G(DFN)'?.N) Q
 D INIT^DGREGTE2  I $P($G(^DPT(DFN,FNODE1)),U,9)="N" Q
 D GETOLD^DGREGTE2(.DGCMP,DFN,TYPE) M DGOLD=DGCMP("OLD") K DGCMP
 S CNTRY="",ICNTRY=$P($G(^DPT(DFN,FNODE2)),"^",CPEICE) I ICNTRY="" S ICNTRY=1    ;default US if NULL
 S FORGN=$$FOREIGN^DGADDUTL(DFN,ICNTRY,2,FCNTRY,.CNTRY) Q:$G(CNTRY)=""  I FORGN=-1 S RET=0 Q
 S FSTR=$$INPT1^DGREGTE2(DFN,FORGN,.PSTR),DGINPUT=1 D INPUT(.DGINPUT,DFN,FSTR)
 I $G(DGINPUT)=-1 S RET=0 Q
 D SAVE(.DGINPUT,DFN,FSTR,CNTRY)
 Q
 ;
INPUT(DGINPUT,DFN,FSTR) ;Let user input address changes
 ; Input:
 ;       DGINPUT - Array to hold field values DGINPUT(field#)
 ;       DFN     - Patient DFN
 ;       FSTR    - String of fields (foreign or domestic) to work with
 ;       
 ; Output: 
 ;       DGINPUT(field#)=external^internal(if any)
 ; 
 N DIR,X,Y,DA,DGR,DTOUT,DUOUT,DIROUT,DGN,L,SUCCESS,REP
 F L=1:1:$L(FSTR,",") S DGN=$P(FSTR,",",L) Q:DGINPUT=-1  D
 . S REP=0
 . I $$SKIP^DGREGTE2(DGN,.DGINPUT) Q
 . S SUCCESS=$$READ(DFN,.DGOLD,DGN,.Y,.REP) I 'SUCCESS D  Q
 . . I 'REP S DGINPUT=-1 Q
 . . ; repeat the question so we have to set the counter back
 . . S L=L-1
 . S DGINPUT(DGN)=$G(Y)
 Q
 ;
READ(DFN,DGOLD,DGN,Y,REP) ;Read input, return success
 ; Input:
 ;       DFN   - Patient DFN
 ;       DGOLD - Array of current field values.
 ;       DGN   - Current field to read
 ;       Y     - Current Field value
 ;       REP   - Flag -- should prompt be repeated
 ;       
 ; Output
 ;       SUCCESS 1 = Input successful go to next prompt
 ;               0 = Input unsuccessful Repeat or Abort as indicated by REP variable
 ;       REP     1 = Error - Repeat prompt
 ;               0 = Error - Do not repeat
 ;       Y       New field value
 ;       
 N SUCCESS,DIR,DA,DTOUT,DUOUT,DIRUT,DIROUT,X,L,T,POP,DGST,CNTYFLD,REVERSE
 S SUCCESS=1,(POP,REVERSE)=0,CNTYFLD=$S(TYPE="TEMP":"TEMPORARY ADDRESS COUNTY",1:"CONFIDENTIAL ADDRESS COUNTY")
 S DIR(0)=2_","_DGN,DIR("B")=$G(DGOLD(DGN))
 S DA=DFN
 F  D  Q:POP
 . K DTOUT,DUOUT,DIROUT
 . S MSG=""
 . I ($G(DGINPUT(FSTATE))="")&(DGN=FCOUNTY) S POP=1 Q
 . S DIR("B")=$S($D(DGINPUT(DGN)):DGINPUT(DGN),$G(DGOLD(DGN))]"":DGOLD(DGN),1:"")
 . I DGN=FCOUNTY D 
 . . S DIR(0)="POA^DIC(5,"_$P(DGINPUT(FSTATE),U)_",1,:AEMQ"
 . . S DIR("A")=CNTYFLD_": "
 . . ; we can't prompt if there's no previous entry
 . . I $D(DGOLD(DGN)) S T=$L(DGOLD(DGN)," "),DIR("B")=$P($G(DGOLD(DGN))," ",1,T-1)
 . D ^DIR
 . I $D(DTOUT) S POP=1,SUCCESS=0 Q
 . I $D(DIRUT) S MSG="",REVERSE=0 D ANSW(X,.DGOLD,DGN,.MSG,.Y,.REP,$G(RET),.REVERSE) S:REP SUCCESS=0 W:MSG]"" !,MSG
 . I REVERSE S (REP,SUCCESS)=0
 . S POP=1
 Q SUCCESS
 ;
SAVE(DGINPUT,DFN,FSTR,CNTRY) ;Save changes
 N DATA,DGENDA,L,T,FILE,ERROR
 S DGENDA=DFN,FILE=2
 ; need to get the country code into the DGINPUT array
 S DGINPUT(FCNTRY)=$O(^HL(779.004,"B",CNTRY,""))
 S FSTR=FSTR_","_FCNTRY
 F L=1:1:$L(FSTR,",") S T=$P(FSTR,",",L) S DATA(T)=$P($G(DGINPUT(T)),U)
 Q $$UPD^DGENDBS(FILE,.DGENDA,.DATA,.ERROR)
 ;
ANSW(YIN,DGOLD,DGN,MSG,YOUT,REP,RET,REVERSE) ;analyze input commands
 ; This API will process reads and set bits, messages and flags accordingly.
 ; Because there is different behavior depending on prompt and input, the input
 ; of each field needs to be evaluated separately at the time of input and before
 ; deciding to continue the edit.  Input rules are loaded into array RPROC at the
 ; beginning of this routine in call to INIT^DGREGTE2.
 ; 
 ; Input
 ;       N       - User input "Y" value
 ;       DGOLD   - Array of current values
 ;       DGN     - Current field
 ;       MSG     - Variable for Text message
 ;       YOUT    - User input ("Y") value
 ;       REP     - Flag to repeat prompt
 ;       RET     - Flag to return success or failure to calling module
 ;       REVERSE - Flag to revert to first prompt in sequence
 ; 
 ; Output
 ;       MSG     - Text message (for incorrect entries)
 ;       REP     - Repeat current prompt
 ;       REVERSE - Revert to first prompt in sequence
 ; 
 N X,Y,DTOUT,DIRUT,DUOUT,PRMPT,RMSG,TDGN,ACT
 N OLDVAL,NEWVAL
 ;
 S PRMPT=$S(TYPE="TEMP":"TEMPORARY",1:"CONFIDENTIAL")
 S RMSG("LINE")="BUT I NEED AT LEAST ONE LINE OF A "_PRMPT_" ADDRESS"
 S RMSG("REVERSE")="This is a required response."
 S RMSG("REPEAT")="EXIT NOT ALLOWED ??"
 S RMSG("QUES")="??"
 S RMSG("INSTRUCT")=$S(TYPE="TEMP":"TADD^DGLOCK1",TYPE="CONF":"CADD1^DGLOCK3",1:"OK")
 S OLDVAL=$G(DGOLD(DGN)),OLDVAL=$$PROC(OLDVAL),NEWVAL=$$PROC(YIN)
 S TDGN=$S($D(RPROC(DGN,OLDVAL,NEWVAL)):DGN,1:"ALL")
 I '$D(RPROC(TDGN,OLDVAL,NEWVAL)) S RPROC(TDGN,OLDVAL,NEWVAL)="OK"
 S ACT=RPROC(TDGN,OLDVAL,NEWVAL)
 D @ACT
 Q
REVERSE ;
 N MSUB
 S MSUB=$S(DGN=FSLINE1:"LINE",1:"REVERSE")
 W !,RMSG(MSUB)
 S REVERSE=1
 Q
REPEAT ;
 W !,RMSG("REPEAT")
 S REP=1
 Q
OK ;
 Q
QUES ;
 W RMSG("QUES")
 S REP=1
 Q
CONFIRM ;
 I '$$SURE^DGREGTE2 S YOUT=DGOLD(DGN),REP=1 Q
 S YOUT=YIN,REP=0
 Q
INSTRUCT ;
 D @RMSG("INSTRUCT")
 S REP=1
 Q
PROC(VAL) ;process the input and return a type of value
 ; input
 ;   VAL - The value to examine
 ;       
 ; output
 ;   a value type
 ;     VALUE  = input - validation is a separate task and is not done here
 ;     NULL   = NULL input
 ;     UPCAR  = the "^" character
 ;     DELETE = the "@" character
 Q $S(VAL="":"NULL",$E(VAL)="^":"UPCAR",$E(VAL)="@":"DELETE",1:"VALUE")
EOP ;End of page prompt
 N DIR,DTOUT,DUOUT,DIROUT,X,Y
 S DIR(0)="E"
 S DIR("A")="Press ENTER to continue"
 D ^DIR
 Q
