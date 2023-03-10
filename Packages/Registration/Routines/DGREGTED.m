DGREGTED ;ALB/BAJ,BDB,JAM - Temporary & Confidential Address Edits API ;23 May 2017  12:48 PM
 ;;5.3;Registration;**688,851,941,1014,1040**;Aug 13, 1993;Build 15
 ;
EN(DFN,TYPE,RET) ;Entry point
 ; This routine controls Edits to Temporary & Confidential addresses
 ; 
 ; Input
 ;       DFN  = Patient DFN
 ;       TYPE = Type of address: "TEMP" or "CONF"
 ;       RET  = Flag to signal return to first prompt
 ;       
 ; Output
 ;       RET  0 = Return to first prompt in the address edit group 
 ;            1 = Do not return (address was saved)
 ;       
 N DGINPUT,FORGN,FSTR,ICNTRY,CNTRY,PSTR,DGCMP,DGOLD,DR,DIE
 N FSLINE1,FSLINE2,FSLINE3,FCITY,FSTATE,FCOUNTY,FZIP,FPHONE
 N FPROV,FPSTAL,FCNTRY,FNODE1,FNODE2,CPEICE,OLDC,RPROC
 N I,X,Y
 I $G(DFN)="" Q
 ;I ($G(DFN)'?.N) Q
 D INIT^DGREGTE2  I $P($G(^DPT(DFN,FNODE1)),U,9)="N" Q
 D GETOLD^DGREGTE2(.DGCMP,DFN,TYPE) M DGOLD=DGCMP("OLD") K DGCMP
 S CNTRY="",ICNTRY=$P($G(^DPT(DFN,FNODE2)),"^",CPEICE) I ICNTRY="" S ICNTRY=1    ;default US if NULL
 ;
 ; DG*5.3*1014; jam; ** Start changes **
 ; RETRY tag added below
RETRY ; Tag for reentering the address
 S FORGN=$$FOREIGN^DGADDUTL(DFN,ICNTRY,2,FCNTRY,.CNTRY) I FORGN=-1 S RET=0,DGTMOT=1 Q
 Q:$G(CNTRY)=""
 S FSTR=$$INPT1^DGREGTE2(DFN,FORGN,.PSTR),DGINPUT=1 D INPUT(.DGINPUT,DFN,FSTR)
 I $G(DGINPUT)=-1 S RET=0 Q
 ;
 ; DG*5.3*1014; jam; For confidential address, if required fields are missing, we can't call the validation service - force user to correct the address
 I TYPE="CONF",DGINPUT(.1411)=""!(DGINPUT(.1414)="")!(($G(DGINPUT(.1416))="")&('FORGN)) D  G RETRY
 . I 'FORGN W !!?3,*7,"CONFIDENTIAL ADDRESS [LINE 1], CITY, and ZIP CODE fields are required."
 . I FORGN W !!?3,*7,"CONFIDENTIAL ADDRESS [LINE 1] and CITY fields are required."
 ; DG*5.3*1014; jam; Address Validation service for confidential address only - TEMP address will skip over this
 I TYPE'="CONF" G SVADD
 ; Place the country code and name into the DGINPUT array
 S DGINPUT(FCNTRY)=$O(^HL(779.004,"B",CNTRY,""))_"^"_CNTRY
 ; DG*5.3*1014; Display address entered - user may reenter the address or continue to Validation service.
 W !
 N DGNEWADD
 M DGNEWADD("NEW")=DGINPUT
 I FORGN D DISPFGN(.DGNEWADD,"NEW")
 I 'FORGN D DISPUS(.DGNEWADD,"NEW")
 K DGNEWADD
CHK ; DG*5.3*1014; Prompt user and allow them to correct the address or continue to Validation service
 N DIR
 S DIR("A",1)="If address is ready for validation enter <RET> to continue, 'E' to Edit"
 S DIR("A")=" or '^' to quit"
 S DIR(0)="FO"
 S DIR("?")="Enter 'E' to edit the address, <RET> to continue to address validation or '^' to exit and cancel the address entry/edit.."
 D ^DIR K DIR
 ; DG*5.3*1040 - Set variable DGTMOT=1, if timeout and QUIT
 I $D(DTOUT) S DGTMOT=1 Q
 ; DG*5.3*1040 - Remove the DTOUT check
 I $D(DUOUT) W !,"Address changes not saved." D EOP Q  ;Exiting - Not saving address
 I X="E"!(X="e") G RETRY  ; re-enter address
 I X'="" G CHK  ; at this point, any response but <RET> will not be accepted
 ; DG*5.3*1014; jam; Add call to Address Validation service
 N DGADVRET
 S DGADVRET=$$EN^DGADDVAL(.DGINPUT,"C")
 ; DG*5.3*1040; if return is -1 timeout occurred
 I DGADVRET=-1 S DGTMOT=1 Q
 ; if return is 0 - address could not be validated
 I 'DGADVRET W !!,"No Results - UAM Address Validation Service is unable to validate the address.",!,"Please verify the address entered. " D EOP Q:+$G(DGTMOT)  ; DG*5.3*1040 - Check EOP timeout and QUIT
 ; DGINPUT array contains the address that is validated/accepted or what the user entered if the validation service failed
 ;
SVADD ; Save the address - SVADD tag added for DG*5.3*1014; jam; ** End of 1014 changes **
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
 . ; DG*5.3*1040 - Set variable DGTMOT to 1 to track ZIP timeout
 . I DGN=FZIP D ZIPINP(.DGINPUT,DFN) S:DGINPUT=-1 DGTMOT=1 Q  ;DG*5.3*851
 . S SUCCESS=$$READ(DFN,.DGOLD,DGN,.Y,.REP) I 'SUCCESS D  Q
 . . ; DG*5.3*1040 - Set variable DGTMOT to 1 to track field timeout
 . . I 'REP S DGINPUT=-1,DGTMOT=1 Q
 . . ; repeat the question so we have to set the counter back
 . . S L=L-1
 . ; DG*5.3*1014 ;jam; prevent the @ from getting into the array
 . I $G(Y)="@" S Y=""
 . S DGINPUT(DGN)=$G(Y)
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
 N DATA,DGENDA,L,T,FILE,ERROR,LOOP,LOOP1,LOOP2
 S DGENDA=DFN,FILE=2
 ; need to get the country code into the DGINPUT array
 S DGINPUT(FCNTRY)=$O(^HL(779.004,"B",CNTRY,""))
 S FSTR=FSTR_","_FCNTRY
 I (TYPE="TEMP")!(TYPE="CONF") S FSTR=FSTR_","_FCITY_","_FSTATE_","_FCOUNTY ;DG*5.3*851
 F L=1:1:$L(FSTR,",") S T=$P(FSTR,",",L) S DATA(T)=$P($G(DGINPUT(T)),U)
 ;JAM; Set the CASS field for Temp and Confidential;  DG*5.3*941
 I TYPE="TEMP" S DATA(.12115)="NC"
 I TYPE="CONF" S DATA(.14117)="NC"
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
 ; DG*5.3*1040; LINE message for NULL "FSLINE1" is moved to REPEAT
 ;N MSUB
 ;S MSUB=$S(DGN=FSLINE1:"LINE",1:"REVERSE")
 ;W !,RMSG(MSUB)
 W !,RMSG("REVERSE")
 S REVERSE=1
 Q
REPEAT ;
 ;W !,RMSG("REPEAT")
 N MSUB
 S MSUB=$S(DGN=FSLINE1:"LINE",1:"REPEAT")
 W !,RMSG(MSUB)
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
 ; DG*5.3*1040 - Set variable DGTMOT=1, if timeout
 S:$D(DTOUT) DGTMOT=1
 Q
 ; DG*5.3*851
ZIPINP(DGINPUT,DFN) ;get ZIP+4 input
 N DGR,DGX
 D EN^DGREGTZL(.DGR,DFN)
 ;DG*5.3*1014 - Zip entry failed (due to timeout, or ^ entry, or input error) - before the Quit, set DGINPUT=-1
 ;I $G(DGR)=-1 Q
 I $G(DGR)=-1 S DGINPUT=-1 Q
 M DGINPUT=DGR
 S DGX=DGINPUT(FCOUNTY),DGINPUT(FCOUNTY)=$P(DGX,"^",2)_"^"_$P(DGX,"^",1)
 S DGX=DGINPUT(FSTATE),DGINPUT(FSTATE)=$P(DGX,"^",2)_"^"_$P(DGX,"^",1)
 Q
SKIP(DGN,DGINPUT,FLG) ; determine whether or not to skip this step
 N SKIP
 S SKIP=0
 I ($G(DGINPUT(FSLINE1))="")&((DGN=FSLINE2)!(DGN=FSLINE3)) S SKIP=1
 I ($G(DGINPUT(FSLINE2))="")&(DGN=FSLINE3) S SKIP=1
 I ($G(FLG(1))'=1)&((DGN=FPHONE)) S SKIP=1
 Q SKIP
UPCT ;Indicate "^" or "^^" are unacceptable inputs.
 W !,"EXIT NOT ALLOWED ??"
 Q
 ;
 ; DG*5.3*1014;jam;  Added these tags to display the address prior to calling the Validation service
DISPUS(DGCMP,DGM) ;tag to display US data
 N DGCNTRY
 ;    "AddressLine1,AddressLine2,AddressLine3,City,State,County,Zip,Province,PostalCode^Country"
 ;        ".1411,.1412,.1413,.1414,.1415,.14111,.1416,.14114,.14115,.14116"  ; Confidential address fields
 W !,?2,"[",DGM," CONFIDENTIAL ADDRESS]"
 W !?16,$G(DGCMP(DGM,.1411))
 I $G(DGCMP(DGM,.1412))'="" W !,?16,$G(DGCMP(DGM,.1412))
 I $G(DGCMP(DGM,.1413))'="" W !,?16,$G(DGCMP(DGM,.1413))
 W !,?16,$G(DGCMP(DGM,.1414))
 W:($G(DGCMP(DGM,.1414))'="")!($P($G(DGCMP(DGM,.1415)),U,2)'="") ","
 W $P($G(DGCMP(DGM,.1415)),U,2)
 W " ",$G(DGCMP(DGM,.1416))
 S DGCNTRY=$$CNTRYI^DGADDUTL($P($G(DGCMP(DGM,.14116)),U))
 I DGCNTRY]"",(DGCNTRY'=-1) W !?16,DGCNTRY
 I $P($G(DGCMP(DGM,.14111)),U)'="" W !,?6,"  County: ",$P($G(DGCMP(DGM,.14111)),U,2)
 W !
 Q
 ;
DISPFGN(DGCMP,DGM) ;tag to display Foreign data
 N DGCNTRY
 W !,?2,"[",DGM," CONFIDENTIAL ADDRESS]"
 W !?16,$G(DGCMP(DGM,.1411))
 I $G(DGCMP(DGM,.1412))'="" W !,?16,$G(DGCMP(DGM,.1412))
 I $G(DGCMP(DGM,.1413))'="" W !,?16,$G(DGCMP(DGM,.1413))
 W !,?16,$G(DGCMP(DGM,.1414))_" "_$G(DGCMP(DGM,.14114))_" "_$G(DGCMP(DGM,.14115))
 S DGCNTRY=$$CNTRYI^DGADDUTL($P($G(DGCMP(DGM,.14116)),U))
 S DGCNTRY=$S(DGCNTRY="":"UNSPECIFIED COUNTRY",DGCNTRY=-1:"UNKNOWN COUNTRY",1:DGCNTRY)
 I DGCNTRY]"" W !?16,DGCNTRY
 W !
 Q
