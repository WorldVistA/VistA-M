DGREGAED ;ALB/DW,PHH,BAJ,TDM,JAM,ARF,JAM - Address Edit API ;1/6/21  10:28
 ;;5.3;Registration;**522,560,658,730,688,808,915,941,1010,1014,1040,1127,1143**;Aug 13, 1993;Build 36
 ;;
 ;; **688** Modifications for Country and Foreign address
 ;; **915** Make DFN optional in case one is not established yet
 ;; ** 1143 ** Modifications and real-time address update
 ;
EN(DFN,FLG,SRC,DGRET) ;Entry point
 ;Input:
 ;  DFN (optional) - Internal Entry # of Patient File (#2)
 ;                   If not supplied then nothing filed or defaulted
 ;  FLG (optional) - Flags of 1 or 0; if null, 0 is assumed. Details:
 ;    FLG(1) - if 1 let user edit phone numbers (field #.131 and #.132)
 ;    FLG(2) - if 1 display before & after address for user confirmation
 ;  DGRET - if passed by reference will contain address info array
 K EASZIPLK,DGRET
 N DGINPUT,DGCMP,ICNTRY,CNTRY,FORGN,PSTR,OLDC,BAD
 N I,X,Y
 S DFN=+$G(DFN)
 ;I ($G(DFN)'?.N) Q
 ; DG*5.3*1143 - If not already set, set variables to be used during editing and flag that real-time address update is active or inactive
 I +$G(DGRTAON)=0 N DGRTAON S DGRTAON=$$ISRTAUON^DGRTAUPD() I DGRTAON=1 N DGADDGRP2,DGADDEDIT,DGRETRY
 ;
 S FLG(1)=$G(FLG(1)),FLG(2)=$G(FLG(2))
 D GETOLD(.DGCMP,DFN)
 S CNTRY="",ICNTRY=$S(DFN:$P($G(^DPT(DFN,.11)),"^",10),1:"")
 I ICNTRY="" S ICNTRY=1  ;default country is USA if NULL
 ;
 ; DG*5.3*1014; jam; ** Start changes **
RETRY ; DG*5.3*1014;jam ; Tag added for entry point to re-enter the address
 ; DG*5.3*1143 - Merge any current values being entered with the old values and overwrite the Country with what is in the local array for Country 
 I $D(DGADDGRP2) M DGCMP=DGADDGRP2 S ICNTRY=DGADDGRP2(.1173)
 ;
 ; DG*5.3*1040 - Set variable DGTMOT to 1 to track timeout
 S OLDC=DGCMP("OLD",.1173),FORGN=$$FOREIGN^DGADDUTL(DFN,ICNTRY,2,.1173,.CNTRY) I FORGN=-1 S DGTMOT=1 Q
 S FSTR=$$INPT1(FORGN,.PSTR)      ;set up field string of address prompts
 S DGINPUT=1 D INPUT(.DGINPUT,DFN,FSTR,CNTRY) I $G(DGINPUT)=-1 Q
 I 'DFN M DGRET=DGINPUT Q
 S BAD=0
 ; DG*5.3*1014; jam; If required fields are missing, we can't call the validation service
 ; DG*5.3*1143 - Add State as required (for domestic addresses)
 I DGINPUT(.111)=""!(DGINPUT(.114)="")!(($G(DGINPUT(.1112))=""!($G(DGINPUT(.115))="")!($G(DGINPUT(.115))="^"))&('FORGN)) D  G RETRY
 . I 'FORGN W !!?3,*7,"ADDRESS [LINE 1], CITY, STATE, and ZIP CODE fields are required."
 . I FORGN W !!?3,*7,"ADDRESS [LINE 1] and CITY fields are required."
 ; DG*5.3*1014; Display address entered - user may reenter the address or continue to Validation service.
 N DGNEWADD
 M DGNEWADD("NEW")=DGINPUT
 W !
 I FORGN D DISPFGN(.DGNEWADD,"NEW")
 I 'FORGN D DISPUS(.DGNEWADD,"NEW")
 K DGNEWADD
CHK ; DG*5.3*1014; Prompt user and allow them to correct the address or continue to Validation service
 N DIR
 S DIR("A",1)="If address is ready for validation enter <RET> to continue, 'E' to Edit"
 S DIR("A")=" or '^' to quit"
 S DIR(0)="FO"
 S DIR("?")="Enter 'E' to edit the address, <RET> to continue to address validation or '^' to exit and cancel the address entry/edit."
 D ^DIR K DIR
 ; DG*5.3*1040 - Set variable DGTMOT=1, if timeout and QUIT
 I $D(DTOUT) S DGTMOT=1 Q
 ;
 ; DG*5.3*1040 - Remove the DTOUT check
 I $D(DUOUT) W !,"Address changes not saved." D EOP Q  ;Exiting - Not saving address
 I X="E"!(X="e") G RETRY  ; re-enter address
 I X'="" G CHK  ; at this point, any response but <RET> will not be accepted
 ; DG*5.3*1014; jam; Add call to Address Validation service
 N DGADVRET,DGOVERKEY ;DG*5.3*1127 - Added DGOVERKEY variable
 S DGADVRET=$$EN^DGADDVAL(.DGINPUT,"P")
 ; DG*5.3*1127 - Get the override key. DGINPUT("overrideKey") will contain the value of the
 ;               override key set in DGADDLST which is called when validating the address
 S DGOVERKEY=$G(DGINPUT("overrideKey"))
 ; if return is -1 timeout occurred
 I DGADVRET=-1 S DGTMOT=1 Q
 ; if return is 0 - address was not validated
 I 'DGADVRET W !!,"No Results - UAM Address Validation Service is unable to validate the address.",!,"Please verify the address entered. " D EOP Q:+$G(DGTMOT)  ; DG*5.3*1040 - Check EOP timeout and QUIT
 ; DGINPUT array contains the address that is validated/accepted or what the user entered if the validation service failed
 ;
 ; DG*5.3*1014; jam; ** End changes **
 ;
 ; DG*5.3*1143 - If Real-time address (RTA) update is active, and hold flag is set, skip over the confirmation and handle saving the data for RTA updates.
 I $G(DGRTAON)=1,$G(DGRTAHOLD)=1 S DGRETRY=0 D SAVERTA G:DGRETRY=1 RETRY  Q
 ;
CONF I $G(FLG(2))=1 D COMPARE(.DGINPUT,.DGCMP,.FLG)
 ; DG*5.3*1040 - Store return value from $$CONFIRM()
 N DGCONFIRM S DGCONFIRM=$$CONFIRM()
 ; DG*5.3*1040 - Quit if timeout when DGCONFIRM = -1
 Q:DGCONFIRM=-1
 ;
 ; DG*5.3*1143 - After confirmation, if Real-time address (RTA) update is active, handle saving the data for RTA updates.
 I $G(DGRTAON)=1,'DGCONFIRM W !,"Address changes not saved." D CLEAN D EOP Q
 I $G(DGRTAON)=1 S DGRETRY=0 D SAVERTA G:DGRETRY=1 RETRY  Q
 ;
 ; DG*5.3*1040 - Check variable DGCONFIRM
 I 'DGCONFIRM W !,"Address changes not saved." D EOP Q
 ;
 N DGPRIOR
 D GETPRIOR^DGADDUTL(DFN,.DGPRIOR)
 D SAVE(.DGINPUT,DFN,FSTR,FORGN) I $G(SRC)="",+$G(DGNEW) Q
 Q:'$$FILEYN^DGADDUTL(.DGPRIOR,.DGINPUT)
 D GETUPDTS^DGADDUTL(DFN,.DGINPUT)
 D UPDADDLG^DGADDUTL(DFN,.DGPRIOR,.DGINPUT)
 Q
 ;
CLEAN ; DG*5.3*1143 - Clean out edit data when the user saves or discards the changes
 K DGADDGRP2,DGADDEDIT(2)
 Q
SAVERTA ; DG*5.3*1143 - Save the address edits with RTA updates active
 ; Hold the data in local array DGADDGRP2
 D SAVETOLOCAL
 ; Set the Address Edit flag (group 2) so in ^DGRPP the user will be prompted to save or discard the changes
 S DGADDEDIT(2)=1
 ; If RTA Hold flag is set (set in DGRPCADD) changes will be filed later, quit
 I +$G(DGRTAHOLD)=1 Q
 ; Otherwise data should be sent to ES via RTA webservice and saved if valid response
 I $$SENDRTAU() D  Q
 . D SAVEFROMLOCAL
 . W !,"Change saved."
 . D EOP
 ; Sending of data failed - determine if the user will retry edits, and quit with 0
 ; If a timeout occurred
 I $D(DTOUT)!(+$G(DGTMOT)) Q 0
 ; If user entered "^"
 I $D(DUOUT) Q 0
 N X,Y,DIR
ASK ; Give the user the option to retry edits or quit
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
SAVETOLOCAL ; DG*5.3*1143 - Save user input to local array DGADDGRP2
 ; Hold the data in the DGADDGRP2 array and save to the DB later
 K DGADDGRP2
 ; This code mimics the SAVE logic except the data is saved to the local array
 S FSTR=FSTR_$S('FORGN:",.114,.115,.117,.1173",1:",.1173")
 F L=1:1:$L(FSTR,",") S DGN=$P(FSTR,",",L) D
 . N DGCODE,DGNAME
 . ; if the field contains external^internal value, store the internal value
 . S DGCODE=$P($G(DGINPUT(DGN)),U,2)
 . S DGNAME=$P($G(DGINPUT(DGN)),U)
 . S DGADDGRP2(DGN)=$S(DGCODE:DGCODE,1:DGNAME)
 ; store the Override key and the CASS indicator
 S DGADDGRP2(.1119)=$G(DGOVERKEY)
 S DGADDGRP2(.1118)="NC"
 Q
 ;
SENDRTAU() ; DG*5.3*1143 - send edited address data to ES via webservice directly
 N DGRTARET,DGERRS
 S DGRTARET=$$EN^DGRTAUPD(DFN,.DGERRS,,.DGADDGRP2)
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
 . D EOP
 Q DGRTARET
 ;
SAVEFROMLOCAL ; DG*5.3*1143 Save data to the DB from the local DGADDGRP2 array
 N DGN,DGVALUE,FDA
 S DGN=0
 F  S DGN=$O(DGADDGRP2(DGN)) Q:'DGN  D
 . S DGVALUE=DGADDGRP2(DGN)
 . S FDA(2,DFN_",",DGN)=DGVALUE
 . ; for home and office phone number, update the extension field
 . I DGN=.131 S FDA(2,DFN_",",.13211)=$P(DGADDGRP2(DGN),"X",2)
 . I DGN=.132 S FDA(2,DFN_",",.13213)=$P(DGADDGRP2(DGN),"X",2)
 D FILE^DIE("","FDA","MSG")
 ; Clean out the edit data
 D CLEAN
 Q
 ;
INPUT(DGINPUT,DFN,FSTR,CNTRY) ;Let user input address changes
 ;Output: DGINPUT(field#)=external^internal(if any)
 N DIR,X,Y,DA,DGR,DTOUT,DUOUT,DIROUT,DGN,L
 F L=1:1:$L(FSTR,",") S DGN=$P(FSTR,",",L),DGINPUT(DGN)="" Q:DGINPUT=-1  D
 . I $$SKIP(DGN,.DGINPUT,.FLG) Q
 . ; DG*5.3*1040 - Set timeout variable DGTMOT to 1, if ZIP timeout
 . I DGN=.1112 D ZIPINP(.DGINPUT,DFN) S:DGINPUT=-1 DGTMOT=1 Q
 . ; DG*5.3*1040 - Set timeout variable DGTMOT to 1, if field timeout
 . I '$$READ(DFN,DGN,.Y) S DGINPUT=-1,DGTMOT=1 Q
 . I DGN=.121 S Y=$G(Y) D  Q
 .. I Y="",DGINPUT(DGN)="" Q
 .. I DFN,$P(Y,U)=$$GET1^DIQ(2,DFN_",",DGN,"I") S DGINPUT(DGN)=$$GET1^DIQ(2,DFN_",",DGN)_U_$P(Y,U) Q
 .. S DGINPUT(DGN)=$P(Y(0),U)_U_Y
 . S DGINPUT(DGN)=$G(Y)
 I DGINPUT'=-1 S DGINPUT(.1173)=CNTRY_"^"_$O(^HL(779.004,"B",CNTRY,""))
 Q
GETOLD(DGCMP,DFN) ;populate array with existing address info
 N CCIEN,DGCURR,CFORGN,CFSTR,L,T,DGCIEN,DGST,DGCNTY,COUNTRY
 S CFORGN=0
 ; get current country
 ; If current country is NULL it is old data
 ; Leave it NULL here because this is not an edit function
 S CCIEN=$S(DFN:$$GET1^DIQ(2,DFN_",","COUNTRY","I"),1:"")
 ;I CCIEN="" S CCIEN=$O(^HL(779.004,"D","UNITED STATES",""))
 S CFORGN=$$FORIEN^DGADDUTL(CCIEN)
 ;get current address fields and xlate to ^DIQ format
 S CFSTR=$$INPT1(CFORGN),CFSTR=$TR(CFSTR,",",";")
 ; Domestic data needs some extra fields
 I 'CFORGN S CFSTR=CFSTR_";.114;.115;.117"
 I DFN D GETS^DIQ(2,DFN_",",CFSTR,"EI","DGCURR")
 F L=1:1:$L(CFSTR,";") S T=$P(CFSTR,";",L),DGCMP("OLD",T)=$G(DGCURR(2,DFN_",",T,"E"))
 S COUNTRY=$$CNTRYI^DGADDUTL(CCIEN) I COUNTRY=-1 S COUNTRY="UNKNOWN COUNTRY"
 S DGCMP("OLD",.1173)=COUNTRY_"^"_CCIEN
 I 'CFORGN D
 . S DGCIEN=$G(DGCURR(2,DFN_",",.117,"I"))
 . S DGST=$G(DGCURR(2,DFN_",",.115,"I"))
 . S DGCNTY=$$CNTY^DGREGAZL(DGST,DGCIEN)
 . I DGCNTY=-1 S DGCNTY=""
 . S DGCMP("OLD",.117)=$P(DGCNTY,U)_" "_$P(DGCNTY,U,3)
 Q
 ;
COMPARE(DGINPUT,DGCMP,FLG) ;Display before & after address fields.
 N DGM
 M DGCMP("NEW")=DGINPUT
 F DGM="OLD","NEW" D
 . I DGCMP(DGM,.1173)]"",$$FORIEN^DGADDUTL($P(DGCMP(DGM,.1173),U,2)) D DISPFGN(.DGCMP,DGM,.FLG) Q
 . I DGM="NEW" D
 . . S DGCNTY=$P($G(DGCMP("NEW",.117)),U)_" "_$P($G(DGCMP("NEW",.117)),U,3)
 . . S DGCMP("NEW",.117)=DGCNTY
 . . I ($L(DGCMP("NEW",.1112))>5)&($P(DGCMP("NEW",.1112),"-",2)="") S DGCMP("NEW",.1112)=$E(DGCMP("NEW",.1112),1,5)_"-"_$E(DGCMP("NEW",.1112),6,9)
 . D DISPUS(.DGCMP,DGM,.FLG)
 Q
 ;
DISPUS(DGCMP,DGM,FLG) ;tag to display US data
 N DGCNTRY
 W !,?2,"[",DGM," ADDRESS]"
 W ?16,$P($G(DGCMP(DGM,.111)),U)
 I $P($G(DGCMP(DGM,.112)),U)'="" W !,?16,$P($G(DGCMP(DGM,.112)),U)
 I $P($G(DGCMP(DGM,.113)),U)'="" W !,?16,$P($G(DGCMP(DGM,.113)),U)
 W !,?16,$P($G(DGCMP(DGM,.114)),U)
 W:($P($G(DGCMP(DGM,.114)),U)'="")!($P($G(DGCMP(DGM,.115)),U)'="") ","
 W $P($G(DGCMP(DGM,.115)),U)
 W " ",$G(DGCMP(DGM,.1112))
 S DGCNTRY=$$CNTRYI^DGADDUTL($P($G(DGCMP(DGM,.1173)),U,2))
 I DGCNTRY]"",(DGCNTRY'=-1) W !?16,DGCNTRY
 I $P($G(DGCMP(DGM,.117)),U)'="" W !,?6,"  County: ",$P($G(DGCMP(DGM,.117)),U)
 I $G(FLG(1))=1 D
 . W !,?6,"   Phone: ",?16,$P($G(DGCMP(DGM,.131)),U)
 . W !,?6,"  Office: ",?16,$P($G(DGCMP(DGM,.132)),U)
 W !,?6,"Bad Addr: ",?16,$P($G(DGCMP(DGM,.121)),U)
 W !
 Q
 ;
DISPFGN(DGCMP,DGM,FLG) ;tag to display Foreign data
 N DGCNTRY
 W !,?2,"[",DGM," ADDRESS]"
 W ?16,$P($G(DGCMP(DGM,.111)),U)
 I $P($G(DGCMP(DGM,.112)),U)'="" W !,?16,$P($G(DGCMP(DGM,.112)),U)
 I $P($G(DGCMP(DGM,.113)),U)'="" W !,?16,$P($G(DGCMP(DGM,.113)),U)
 ;W !,?16,$P($G(DGCMP(DGM,.1172)),U)_" "_$P($G(DGCMP(DGM,.114)),U)_" "_$P($G(DGCMP(DGM,.1171)),U) ;DG*1010 comment out
 W !,?16,$P($G(DGCMP(DGM,.114)),U)_" "_$P($G(DGCMP(DGM,.1171)),U)_" "_$P($G(DGCMP(DGM,.1172)),U) ; DG*1010 - display postal code last
 S DGCNTRY=$$CNTRYI^DGADDUTL($P($G(DGCMP(DGM,.1173)),U,2))
 S DGCNTRY=$S(DGCNTRY="":"UNSPECIFIED COUNTRY",DGCNTRY=-1:"UNKNOWN COUNTRY",1:DGCNTRY)
 I DGCNTRY]"" W !?16,DGCNTRY
 I $G(FLG(1))=1 D
 . W !,?6,"   Phone: ",?16,$P($G(DGCMP(DGM,.131)),U)
 . W !,?6,"  Office: ",?16,$P($G(DGCMP(DGM,.132)),U)
 W !,?6,"Bad Addr: ",?16,$P($G(DGCMP(DGM,.121)),U)
 W !
 Q
 ;
CONFIRM() ;Confirm if user wants to save the change
 N DIR,X,Y,DTOUT,DUOUT,DIROUT
 S DIR(0)="Y"
 S DIR("A")="Are you sure that you want to save the address changes"
 S DIR("?")="Please answer Y for YES or N for NO."
 D ^DIR
 ; DG*5.3*1040 - If timeout set DGTMOT=1 and return -1
 I $D(DTOUT) S DGTMOT=1 Q -1
 ; DG*5.3*1040 - Remove the DTOUT check
 I $G(Y)=0 Q 0
 I $D(DUOUT)!$D(DIROUT) Q 0
 Q 1
SAVE(DGINPUT,DFN,FSTR,FORGN) ;Save changes
 N DGN,DGER,DGM,L,DATA
 S DGER=0
 ; need to get the country code into the DGINPUT array
 ; if it's a domestic address, we have to add in CITY,STATE & COUNTY
 S FSTR=FSTR_$S('FORGN:",.114,.115,.117,.1173",1:",.1173")
 S FSTR=FSTR_",.1119",DGINPUT(.1119)=DGOVERKEY  ;DG*5.3*1127 - Store the override key returned from address validation
 F L=1:1:$L(FSTR,",") S DGN=$P(FSTR,",",L) D
 . I ($G(FLG(1))'=1)&((DGN=.131)!(DGN=.132)) Q
 . N DGCODE,DGNAME,FDA,MSG
 . S DGCODE=$P($G(DGINPUT(DGN)),U,2)
 . S DGNAME=$P($G(DGINPUT(DGN)),U)
 . S FDA(2,DFN_",",DGN)=$S(DGCODE:DGCODE,1:DGNAME)
 . D FILE^DIE($S(DGCODE:"",1:"E"),"FDA","MSG")
 . I $D(MSG) D
 .. S DGM="",DGER=1
 .. W !,"Please review the saved changes!!",!
 .. F  S DGM=$O(MSG("DIERR",1,"TEXT",DGM)) Q:DGM=""  D
 ... W $G(MSG("DIERR",1,"TEXT",DGM))
 I $G(DGER)=0 W !,"Change saved." D
 .;JAM, Set the CASS value for Perm Mailing Address ;DG*5.3*941
 . S DATA(.1118)="NC"
 . I $$UPD^DGENDBS(2,DFN,.DATA)
 D EOP
 Q
READ(DFN,DGN,Y) ;Read input, return success
 N SUCCESS,DIR,DA,DTOUT,DUOUT,DIROUT,L,POP,DGBAI,DGVAL
 S SUCCESS=1,POP=0
 F L=0:0 D  Q:POP
 . S DIR(0)=2_","_DGN
 . ; DG*5.3*1143 - If the RTA array has a value, use it for the field default
 . I $D(DGADDGRP2(DGN)) D
 . . S DIR("B")=DGADDGRP2(DGN)
 . . ; For the Bad Addr Ind. set the proper external value from the internal value
 . . I DGN=.121 S DGBAI=DGADDGRP2(DGN),DIR("B")=$S(DGBAI=1:"UNDELIVERABLE",DGBAI=2:"HOMELESS",DGBAI=3:"OTHER",1:"")
 . I DFN S DA=DFN
 . D ^DIR
 . I $D(DTOUT) S POP=1,SUCCESS=0 Q
 . I $D(DUOUT)!$D(DIROUT) D UPCT Q
 . ; DG*5.3*1143 - Check the format of the phone number fields since the user may have accepted the default value which would not be checked by Fileman
 . S DGVAL=Y
 . I DGN=.131!(DGN=.132) I DGVAL'="" D  I '$D(DGVAL)  W !,*7,"Answer must be 10 numbers in length with an optional 'X' and 1-6 digit",!,"extension number allowed.",!! Q
 . . S DGVAL=$TR(DGVAL,"x","X") K:$L(DGVAL)>17 DGVAL I $D(DGVAL) K:'(DGVAL?10N!(DGVAL?10.N1"X"1.6N)) DGVAL
 . S POP=1
 Q SUCCESS
INPT1(FORGN,PSTR) ; first address input prompts
 N FSTR
 ; PSTR is the full set of fields domestic & foreign combined
 ; FSTR is the set of fields depending on Country code
 S PSTR=".111,.112,.113,.114,.115,.117,.1112,.1171,.1172,.1173,.131,.132,.121"
 S FSTR=".111,.112,.113,.1112,.131,.132,.121"
 I FORGN S FSTR=".111,.112,.113,.114,.1171,.1172,.131,.132,.121"
 ; DG*5.3*1143 - if FLG(1) is not set, don't include the .131, .132 phone fields in the list below
 I FLG(1)=0 D
 . S PSTR=$P(PSTR,".131,.132,",1)_$P(PSTR,".131,.132,",2)
 . S FSTR=$P(FSTR,".131,.132,",1)_$P(FSTR,".131,.132,",2)
 Q FSTR
ZIPINP(DGINPUT,DFN) ; get ZIP+4 input
 N DGR
 ; DG*5.3*1143 - Pass the RTA local array values for zip code and city to use as the default value for input
 D EN^DGREGAZL(.DGR,DFN,$G(DGADDGRP2(.1112)),$G(DGADDGRP2(.114)))
 ;DG*5.3*1014 - Zip entry failed (due to timeout, or ^ entry, or input error) - before the Quit, set DGINPUT=-1
 ;I $G(DGR)=-1 Q
 I $G(DGR)=-1 S DGINPUT=-1 Q
 M DGINPUT=DGR
 Q
SKIP(DGN,DGINPUT,FLG) ; determine whether or not to skip this step
 N SKIP
 S SKIP=0
 I ($G(DGINPUT(.111))="")&((DGN=.112)!(DGN=.113)) S SKIP=1
 I ($G(DGINPUT(.112))="")&(DGN=.113) S SKIP=1
 I ($G(FLG(1))'=1)&((DGN=.131)!(DGN=.132)) S SKIP=1
 Q SKIP
EOP ;End of page prompt
 N DIR,DTOUT,DUOUT,DIROUT,X,Y
 S DIR(0)="E"
 S DIR("A")="Press ENTER to continue"
 D ^DIR
 ; DG*5.3*1040 - Set variable DGTMOT=1, if timeout
 S:$D(DTOUT) DGTMOT=1
 Q
UPCT ;Indicate "^" or "^^" are unacceptable inputs.
 W !,"EXIT NOT ALLOWED ??"
 Q
