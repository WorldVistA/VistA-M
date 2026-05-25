DGREGTED ;ALB/BAJ,BDB,JAM,ARF,JAM - Temporary & Confidential Address Edits API ;23 May 2017  12:48 PM
 ;;5.3;Registration;**688,851,941,1014,1040,1127,1143**;Aug 13, 1993;Build 36
 ;
EN(DFN,TYPE,RET) ;Entry point
 ; This routine controls Edits to Temp & Conf addresses
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
 N FSACTIVE,FSSTART,FSEND,DGERROR
 N I,X,Y,BAD,DGACTIVE
 I $G(DFN)="" Q
 ; DG*5.3*1143 - If not already set, set flag to be used during editing that real-time address update is active
 I +$G(DGRTAON)=0 N DGRTAON S DGRTAON=$$ISRTAUON^DGRTAUPD() I DGRTAON=1 N DGADDGRP3,DGADDGRP4,DGADDEDIT,DGRETRY
 ;
 ; DG*5.3*1143 - Prompt for Active?, Start and End Dates, and Confidential Categories and handle Active=NO
 ; Quit if no update occurred
 I '$$GETACT^DGREGTE2(DFN,TYPE,.DGINPUT,.DGACTIVE) Q
 ; Active? set to NO
 I DGACTIVE="N" D  Q
 . ; If RTA not active, store the field in the database - quit
 . I DGRTAON=0 D UPD^DGENDBS(2,DFN,.DGINPUT,.DGERROR)
 . ; Save changes for RTA active
 . I DGRTAON=1 D SAVERTA
 ;
 ; Active? set to YES
 D INIT^DGREGTE2
 D GETOLD^DGREGTE2(.DGCMP,DFN,TYPE) M DGOLD=DGCMP("OLD") K DGCMP
 S CNTRY="",ICNTRY=$P($G(^DPT(DFN,FNODE2)),"^",CPEICE) I ICNTRY="" S ICNTRY=1    ;default US if NULL
 ;
 ; DG*5.3*1143 - Merge any current values being entered with the old values and overwrite the Country with what is in the local array for Country 
 I TYPE="TEMP",$D(DGADDGRP3(.1223)) M DGOLD=DGADDGRP3 S ICNTRY=DGADDGRP3(.1223)
 I TYPE="CONF",$D(DGADDGRP4(.14116)) M DGOLD=DGADDGRP4 S ICNTRY=DGADDGRP4(.14116)
 ;
 ; DG*5.3*1014; jam; ** Start changes **
 ; RETRY tag added below
RETRY ; Tag for reentering the address
 ;
 S FORGN=$$FOREIGN^DGADDUTL(DFN,ICNTRY,2,FCNTRY,.CNTRY) I FORGN=-1 S RET=0,DGTMOT=1 Q
 Q:$G(CNTRY)=""
 S BAD=0
 S FSTR=$$INPT1^DGREGTE2(DFN,FORGN,.PSTR),DGINPUT=1 D INPUT(.DGINPUT,DFN,FSTR)
 I $G(DGINPUT)=-1 S RET=0 Q
 ;
 ; DG*5.3*1014; jam; For confidential address, if required fields are missing, force user to correct the address
 ; DG*5.3*1143 - add check for state being NULL or "^" for domestic address (zip function can return "^" when no state is found.
 I TYPE="CONF",DGINPUT(.1411)=""!(DGINPUT(.1414)="")!(($G(DGINPUT(.1416))=""!($G(DGINPUT(.1415))="^")!($G(DGINPUT(.1415))=""))&('FORGN)) D  G RETRY
 . I 'FORGN W !!?3,*7,"CONFIDENTIAL ADDRESS [LINE 1], CITY, STATE, and ZIP CODE fields are required."
 . I FORGN W !!?3,*7,"CONFIDENTIAL ADDRESS [LINE 1] and CITY fields are required."
 ;
 ; DG*5.3*1143 - For temporary address, add check for null or "^" state, if required fields are missing, force user to correct the address
 I TYPE="TEMP",DGINPUT(.1211)=""!(DGINPUT(.1214)="")!(($G(DGINPUT(.12112))="")!($G(DGINPUT(.1215))="^")!$G(DGINPUT(.1215))=""&('FORGN)) D  G RETRY
 . I 'FORGN W !!?3,*7,"TEMPORARY STREET [LINE 1], CITY, STATE, and ZIP CODE fields are required."
 . I FORGN W !!?3,*7,"TEMPORARY STREET [LINE 1] and CITY fields are required."
 ;
 ; DG*5.3*1014; jam; Address Validation service for confidential address only - TEMP address will skip over this
 I TYPE'="CONF" G SVADD
 ; Place the country code and name into the DGINPUT array
 S DGINPUT(FCNTRY)=$O(^HL(779.004,"B",CNTRY,""))_"^"_CNTRY
 ; DG*5.3*1014; Display address entered - user may reenter the address or continue to Validation service.
 W !
 N DGNEWADD
 M DGNEWADD("NEW")=DGINPUT
 ; DG*5.3*1143 - Moved the display tags to DGREGTE2 due to size limitations
 I FORGN D DISPFGN^DGREGTE2(.DGNEWADD,"NEW")
 I 'FORGN D DISPUS^DGREGTE2(.DGNEWADD,"NEW")
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
 ;
 ; DG*5.3*1040 - Remove the DTOUT check
 I $D(DUOUT) W !,"Changes not saved." D EOP Q
 I X="E"!(X="e") G RETRY  ; re-enter address
 I X'="" G CHK  ; Any response but <RET> not accepted
 ; DG*5.3*1014; jam; Add call to Address Validation service
 N DGADVRET,DGOVERKEY ;DG*5.3*1127 - Added DGOVERKEY variable
 S DGADVRET=$$EN^DGADDVAL(.DGINPUT,"C")
 ; DG*5.3*1127 - Get the override key. DGINPUT("overrideKey") will contain the value of the
 ;               override key set in DGADDLST which is called when validating the address
 S DGOVERKEY=$G(DGINPUT("overrideKey"))
 ; DG*5.3*1040; if return is -1 timeout occurred
 I DGADVRET=-1 S DGTMOT=1 Q
 ; if return is 0 - address could not be validated
 I 'DGADVRET W !!,"No Results - UAM Address Validation Service is unable to validate the address.",!,"Please verify the address entered. " D EOP Q:+$G(DGTMOT)  ; DG*5.3*1040 - Check EOP timeout and QUIT
 ; DGINPUT array contains the address that is validated/accepted or what the user entered if the validation service failed
 ;
SVADD ; Save the address - SVADD tag added for DG*5.3*1014; jam; ** End of 1014 changes **
 ; DG*5.3*1143 - If RTA update is active, save the data for RTA.
 I $G(DGRTAON)=1 S DGRETRY=0 D SAVERTA G:DGRETRY=1 RETRY  Q
 ;
 D SAVE(.DGINPUT,DFN,FSTR,CNTRY)
 Q
 ;
CLEAN(DGTYPE) ; Clean edit data for Conf or Temp Address when user saves or discards 
 ; DGTYPE:  "CONF" or "TEMP" address edit vars to clean out
 I DGTYPE="TEMP" D
 . K DGADDGRP3,DGADDEDIT(3)
 ;
 I DGTYPE="CONF" D
 . K DGADDGRP4,DGADDEDIT(4)
 Q
 ;
SAVERTA ; DG*5.3*1143 - Save the address edits with RTA updates active
 ; If adddress is active, save the data in local array DGADDGRP3 (TEMP) or DGADDGRP4 (CONF)
 I DGACTIVE="Y" D SAVETOLOCAL(TYPE)
 ; Set the RTA edit flag for the group
 I TYPE="TEMP" S DGADDEDIT(3)=1
 I TYPE="CONF" S DGADDEDIT(4)=1
 ; If RTA Hold flag is set (set by a calling program that will handle the save of changes), quit
 I +$G(DGRTAHOLD)=1 Q
 ; Otherwise data should be sent to ES via RTA webservice and saved if valid response
 I $$SENDRTAU(TYPE) D  Q
 . D SAVEFROMLOCAL(TYPE)
 . W !,"Change saved."
 . D EOP
 ; Determine is the user will retry edits, and quit with 0
 ; If a timeout occurred
 I $D(DTOUT)!(+$G(DGTMOT)) Q 0
 ; If user entered "^"
 I $D(DUOUT) Q 0
 N X,Y,DIR
ASK ; Give user the option to retry edits
 S DIR("A")="Enter 'E' to re-enter the data or '^' to quit"
 S DIR(0)="FO"
 S DIR("?")="Enter 'E' to re-edit the data, or '^' to exit and cancel the address entry/edit."
 D ^DIR K DIR
 ; If timeout, set timeout
 I $D(DTOUT) S DGTMOT=1 Q 0
 ; If user quit with ^
 I $D(DUOUT) Q 0
 ; User has opted to retry
 I X="E"!(X="e") S DGRETRY=1 Q 0
 G ASK  ; at this point, any other response is not accepted
 ;
SAVETOLOCAL(DGTYPE) ; DG*5.3*1143 - Save DGINPUT array to RTA group array
 N DATA,L,T
 I DGTYPE="TEMP" K DGADDGRP3
 I DGTYPE="CONF" K DGADDGRP4
 ; Move data from DGINPUT to the DGADDGRP3 (Temp) or DGADDGRP4 (Conf) array to be sent to ES via webservice
 ; This code mimics the SAVE logic except the data is saved to the local group array
 ; get the country code into the DGINPUT array
 S DGINPUT(FCNTRY)=$O(^HL(779.004,"B",CNTRY,""))
 S FSTR=FSTR_","_FCNTRY
 I (DGTYPE="TEMP")!(TYPE="CONF") S FSTR=FSTR_","_FCITY_","_FSTATE_","_FCOUNTY_","_FSACTIVE_","_FSSTART_","_FSEND
 I (DGTYPE="CONF") S DGINPUT(.141201)=DGOVERKEY,FSTR=FSTR_","_.141201
 F L=1:1:$L(FSTR,",") S T=$P(FSTR,",",L) S DATA(T)=$P($G(DGINPUT(T)),U)
 I DGTYPE="TEMP" S DATA(.12115)="NC" M DGADDGRP3=DATA
 I DGTYPE="CONF" S DATA(.14117)="NC" M DGADDGRP4=DATA
 ; Move Address categories into group array
 I DGTYPE="CONF" M DGADDGRP4("CCATS")=DGINPUT("CCATS")
 Q
 ;
SENDRTAU(DGTYPE) ; DG*5.3*1143 - send data to ES via webservice
 N DGRTARET,DGERRS
 I DGTYPE="TEMP" S DGRTARET=$$EN^DGRTAUPD(DFN,.DGERRS,,,.DGADDGRP3)
 I DGTYPE="CONF" S DGRTARET=$$EN^DGRTAUPD(DFN,.DGERRS,,,,.DGADDGRP4)
 I 'DGRTARET D
 . N X,Z,DGI,DGLINE,DIWR,DGL,DIWL,DIWF
 . S DIWL=0,DIWR=75,DIWF=""
 . ; Print out the message attached to the return
 . S X=$P(DGRTARET,"^",2)
 . K ^UTILITY($J,"W")
 . D ^DIWP
 . M DGLINE=^UTILITY($J,"W",0)
 . W !!,"** Webservice call failed:" F DGL=1:1:DGLINE W DGLINE(DGL,0),!
 . ; Print out the DGERRS text
 . S DGI="" F  S DGI=$O(DGERRS(DGI)) Q:'DGI  D
 . . W !,"("_DGI_") "
 . . S X=DGERRS(DGI)
 . . K ^UTILITY($J,"W")
 . . D ^DIWP
 . . M DGLINE=^UTILITY($J,"W",0)
 . . F DGL=1:1:DGLINE W DGLINE(DGL,0),!
 . ; Give the user the option to quit - DUOUT will be set if they enter "^"
 . D EOP
 Q DGRTARET
 ;
SAVEFROMLOCAL(DGTYPE) ; DG*5.3*1143 Save data to the DB from the local array (TEMP or CONF)
 N DGN,DGFDA
 S DGN=0
 ; If the "DELETE" node is set, the user changed the ACTIVE? field from YES to NO (see DGLOCK (TEMP) and DGLOCK3 (CONF))
 I DGTYPE="TEMP" D
 . ; If the "DELETE" node = 0 the data is not changing - no need to file the fields except for the ACTIVE? field
 . ;  Start and End Dates will be deleted via a trigger in the .12105 field
 . I $G(DGADDGRP3("DELETE"))=0 S DGFDA(2,DFN_",",.12105)="N" Q
 . F  S DGN=$O(DGADDGRP3(DGN)) Q:'DGN  D
 . . ; If the "DELETE" node = 1 The user said YES to delete the data - delete the fields
 . . I $G(DGADDGRP3("DELETE"))=1 S DGADDGRP3(DGN)="@"
 . . S DGFDA(2,DFN_",",DGN)=DGADDGRP3(DGN)
 . . ; for phone number, update the extension field
 . . I DGN=.1219 S DGFDA(2,DFN_",",.12117)=$P(DGADDGRP3(DGN),"X",2)
 I DGTYPE="CONF" D
 . I $G(DGADDGRP4("DELETE"))=0 S DGFDA(2,DFN_",",.14105)="N" Q
 . F  S DGN=$O(DGADDGRP4(DGN)) Q:'DGN  D
 . . I $G(DGADDGRP4("DELETE"))=1 S DGADDGRP4(DGN)="@"
 . . S DGFDA(2,DFN_",",DGN)=DGADDGRP4(DGN)
 . . ; for phone number, update the extension field (which will be cleared if phone is deleted)
 . . I DGN=.1315 S DGFDA(2,DFN_",",.13214)=$P(DGADDGRP4(DGN),"X",2)
 D FILE^DIE("","DGFDA","MSG")
 ;
 ; Save Address categories
 I DGTYPE="CONF" D
 . N DIK,DGIEN,DGNEWIEN
 . ; Clean out current categories
 . S DA(1)=DFN
 . S DIK="^DPT("_DFN_",.14,"
 . S DA=0 F  S DA=$O(^DPT(DFN,.14,DA)) Q:'DA  D ^DIK
 . ; If DELETE flag is set, quit
 . I $G(DGADDGRP4("DELETE"))=1 Q
 . K DGFDA
 . S DGIEN=0 F  S DGIEN=$O(DGADDGRP4("CCATS",2.141,DGIEN)) Q:'DGIEN  D
 . . S DGNEWIEN=DFN_","
 . . S DGNEWIEN="+1,"_DGNEWIEN
 . . S DGFDA(2.141,DGNEWIEN,.01)=DGADDGRP4("CCATS",2.141,DGIEN,.01,"I")
 . . S DGFDA(2.141,DGNEWIEN,1)=DGADDGRP4("CCATS",2.141,DGIEN,1,"I")
 . . D UPDATE^DIE("","DGFDA","","DGERR")
 . . K DGFDA
 ; Clean out the edit data
 D CLEAN(DGTYPE)
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
 N DATA,DGENDA,L,T,FILE,ERROR,LOOP,LOOP1,LOOP2,DA,DGFDA
 S DGENDA=DFN,FILE=2
 ; need to get the country code into the DGINPUT array
 S DGINPUT(FCNTRY)=$O(^HL(779.004,"B",CNTRY,""))
 S FSTR=FSTR_","_FCNTRY
 ; DG*5.3*1143 - add Active?, Start and End Date fields
 I (TYPE="TEMP")!(TYPE="CONF") S FSTR=FSTR_","_FCITY_","_FSTATE_","_FCOUNTY_","_FSACTIVE_","_FSSTART_","_FSEND ;DG*5.3*851
 I (TYPE="CONF") S DGINPUT(.141201)=DGOVERKEY,FSTR=FSTR_","_.141201 ;DG*5.3*1127 - Store the override key returned from the address validation
 F L=1:1:$L(FSTR,",") S T=$P(FSTR,",",L) S DATA(T)=$P($G(DGINPUT(T)),U)
 ;JAM; Set the CASS field for Temp and Confidential;  DG*5.3*941
 I TYPE="TEMP" S DATA(.12115)="NC"
 I TYPE="CONF" D
 . S DATA(.14117)="NC"
 . ; Store address categories if defined
 . N DIK,DGIEN,DGNEWIEN
 . ; Clean out current categories
 . S DA(1)=DFN
 . S DIK="^DPT("_DFN_",.14,"
 . S DA=0 F  S DA=$O(^DPT(DFN,.14,DA)) Q:'DA  D ^DIK
 . I '$D(DGINPUT("CCATS")) Q
 . K DGFDA
 . S DGIEN=0 F  S DGIEN=$O(DGINPUT("CCATS",2.141,DGIEN)) Q:'DGIEN  D
 . . S DGNEWIEN=DFN_","
 . . S DGNEWIEN="+1,"_DGNEWIEN
 . . S DGFDA(2.141,DGNEWIEN,.01)=DGINPUT("CCATS",2.141,DGIEN,.01,"I")
 . . S DGFDA(2.141,DGNEWIEN,1)=DGINPUT("CCATS",2.141,DGIEN,1,"I")
 . . D UPDATE^DIE("","DGFDA","","DGERR")
 . . K DGFDA
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
 ;
 ; DG*5.3*851
ZIPINP(DGINPUT,DFN) ;get ZIP+4 input
 N DGR,DGX
 ; DG*5.3*1143 - Pass the local array value for FZIP and FCITY (if defined) to use as the default values
 N DGDEFZIP,DGDEFCITY
 I TYPE="TEMP" S DGDEFZIP=$G(DGADDGRP3(FZIP)),DGDEFCITY=$G(DGADDGRP3(FCITY))
 I TYPE="CONF" S DGDEFZIP=$G(DGADDGRP4(FZIP)),DGDEFCITY=$G(DGADDGRP4(FCITY))
 D EN^DGREGTZL(.DGR,DFN,DGDEFZIP,DGDEFCITY)
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
