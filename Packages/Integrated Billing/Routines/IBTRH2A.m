IBTRH2A ;ALB/YMG - HCSR worklist expand entry cont. ;18-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
LOCKERR ; display a lock error message
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W *7,!!,"Some else is editing the event. Try again later."
 S DIR(0)="EA",DIR("A")="Press RETURN to continue " D ^DIR
 Q
 ;
COPYERR(TYPE) ; display the error encountered while copying a request
 ; TYPE = 0 - error while reading data, TYPE = 1 - error while filing data
 ; ERROR - array used for FM error reporting, populated in the calling tag
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,STR,X,Y,Z,Z1
 I $D(ERROR) D
 .W !,"Unable to copy - the following error was encountered while "
 .W $S(TYPE:"filing",1:"retrieving")," the data:"
 .S Z=0 F  S Z=$O(ERROR("DIERR",Z)) Q:'Z  D
 ..S STR=$G(ERROR("DIERR",Z)) I STR'="" W !,"Error code: "_STR
 ..S STR=$G(ERROR("DIERR",Z,"PARAM","FILE")) I STR'="" W !,"File number: "_STR
 ..S STR=$G(ERROR("DIERR",Z,"PARAM","FIELD")) I STR'="" W !,"Field number: "_STR
 ..W !,"Error text:" S Z1=0 F  S Z1=$O(ERROR("DIERR",1,"TEXT",Z1)) Q:'Z1  W !,ERROR("DIERR",1,"TEXT",Z1)
 ..Q
 .S DIR(0)="EA",DIR("A")="Press RETURN to continue " D ^DIR
 .Q
 Q
 ;
MLTCPY(SFNUM,NEWIENS) ; copy a multiple 
 ; SFNUM - sub-file number of a multiple to copy
 ; NEWIENS - iens of a new entry (copied to)
 ; OLDENTRY - FDA array to get data from (defined in the calling tag)
 ;
 ; returns 1 on successful copy, 0 on failure
 ;
 N ERROR,NEWENTRY,RES,STOPFLG,Z
 S RES=1,STOPFLG=0
 S Z=0 F  S Z=$O(OLDENTRY(SFNUM,Z)) Q:'Z  D  Q:STOPFLG
 .K NEWENTRY D FDACPY(SFNUM,Z,"+1,"_NEWIENS,.OLDENTRY,.NEWENTRY)
 .D UPDATE^DIE(,"NEWENTRY",,"ERROR")
 .I $D(ERROR) D COPYERR(1) S STOPFLG=1,RES=0
 .Q
 Q RES
 ;
FDACPY(FN,OLDIENS,NEWIENS,OLDENTRY,NEWENTRY) ; copy FDA array, move data from "I" nodes to regular ones
 ; FN - file or subfile #
 ; OLDIENS - IENS for the OLDENTRY array
 ; NEWIENS - IENS for the NEWENTRY array
 ; OLDENTRY - array to copy from (passed by reference)
 ; NEWENTRY - array to copy into (passed by reference)
 ;
 N FLD,VALUE
 S FLD="" F  S FLD=$O(OLDENTRY(FN,OLDIENS,FLD)) Q:FLD=""  D
 .S VALUE=$G(OLDENTRY(FN,OLDIENS,FLD,"I"))
 .I VALUE'="" S NEWENTRY(FN,NEWIENS,FLD)=VALUE
 .Q
 Q
 ;
MLTCLEAR(IBTRIEN) ; delete entries from multiples in file 356.22
 ; IBTRIEN -  file 356.22 ien
 N DA,DIK,FLD,Z
 I +$G(IBTRIEN)'>0 Q
 F FLD=3,11,13,14,15,16 D
 .S DIK="^IBT(356.22,"_IBTRIEN_","_FLD_",",DA(1)=IBTRIEN
 .S DA=0 F  S DA=$O(^IBT(356.22,IBTRIEN,FLD,DA)) Q:'DA!(DA?1.A)  D ^DIK
 .Q
 Q
 ;
ADDR(FILE,IEN,LN1FLD,LN2FLD,LN3FLD,CITFLD,STFLD,ZIPFLD,RES) ; format address for output
 ; FILE - file number to get address from
 ; IEN - ien in FILE
 ; LN1FLD - field # for addr. line 1
 ; LN2FLD - field # for addr. line 2
 ; LN3FLD - field # for addr. line 3
 ; CITFLD - field # for city
 ; STFLD - field # for state
 ; ZIPFLD - field # for zip
 ; RES - array of formatted address lines this function returns
 ;
 N ADDRDATA,DRSTR,CNT,CSSTR,IENS,LN1STR,LN2STR,LN3STR,STATE,TMP,Z,Z1,Z2,ZIP
 K RES S RES(1)=""
 S IENS=IEN_","
 S DRSTR=LN1FLD_";"_LN2FLD_";"_LN3FLD_";"_CITFLD_";"_STFLD_";"_ZIPFLD
 D GETS^DIQ(FILE,IENS,DRSTR,"EI","ADDRDATA")
 S CSSTR=$G(ADDRDATA(FILE,IENS,CITFLD,"E"))
 S STATE=$$GET1^DIQ(5,$G(ADDRDATA(FILE,IENS,STFLD,"I"))_",",1)
 S ZIP=$G(ADDRDATA(FILE,IENS,ZIPFLD,"E"))
 S TMP=$E(ZIP,6,9),ZIP=$E(ZIP,1,5)_$S(TMP'="":"-"_TMP,1:"")
 S STATE=STATE_$S(STATE=""!(ZIP=""):"",1:"  ")_ZIP
 S CSSTR=CSSTR_$S(CSSTR=""!(STATE=""):"",1:", ")_STATE
 S LN1STR=$G(ADDRDATA(FILE,IENS,LN1FLD,"E")),LN2STR=$G(ADDRDATA(FILE,IENS,LN2FLD,"E")),LN3STR=$G(ADDRDATA(FILE,IENS,LN3FLD,"E"))
 S CNT=1 F Z=LN1STR,LN2STR,LN3STR,CSSTR I Z'="" S Z1=$G(RES(CNT)),Z2=", " D
 .S:Z1="" Z2="" S:($L(Z1)+2+$L(Z))>64 Z2="",CNT=CNT+1 S RES(CNT)=$G(RES(CNT))_Z2_Z
 .Q
 Q
 ;
STATMSG(TYPE) ; display transmission status message
 ; TYPE - 1 if transmission successful, 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="EA"
 S DIR("A",1)=" "
 I TYPE=0 S DIR("A",2)="278 request has been sent successfully."
 I TYPE=1 S DIR("A",2)="Unable to send 278 request, can't find an entry in file 356.22."
 I TYPE=2 S DIR("A",2)="Unable to send 278 request, check HCSR worklist entry for errors."
 I TYPE=3 S DIR("A",2)="Unable to send 278 request, there's already a 278 request awaiting a response."
 I TYPE=4 S DIR("A",2)="This 278 request has a pending response from the payer. Please use SI action to send Inquiry if needed."
 S DIR("A")="Press RETURN to continue " D ^DIR
 Q
 ;
MSG215(TYPE,TTYPE) ; display transmission status message
 ; TYPE - 1 if transmission successful, 0 otherwise
 ; TTYPE - 'C' for 278x215 cancel transaction
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="EA"
 S DIR("A",1)=" "
 I TYPE=0 S DIR("A",2)="278 "_$S($G(TTYPE)="C":"Cancellation",1:"Inquiry")_" has been sent successfully."
 I TYPE=1 S DIR("A",2)="Unable to send 278 Inquiry, can't find an entry in file 356.22."
 I TYPE=2 S DIR("A",2)="Unable to send 278 "_$S($G(TTYPE)="C":"Cancellation",1:"Inquiry")_", check HCSR worklist entry for errors."
 I TYPE=3 S DIR("A",2)="Unable to send 278 Inquiry, HCSR worklist entry is NOT in a 'Pending' status."
 I TYPE=4 S DIR("A",2)="Unable to generate 278 Inquiry, copy of existing entry failed"
 I TYPE=5 S DIR("A",2)="278x215 Inquiry has already been generated for this HCSR worklist entry."
 S DIR("A")="Press RETURN to continue " D ^DIR
 Q
 ;
COPY278 ; copy 278 request
 ; requires IBTRIEN to be defined and contain ien of the 356.22 entry being copied
 ;
 N COB,COBSTR,CURCOB,DFN,DIR,DIROUT,DIRUT,DTOUT,DUOUT,ERROR,EVENTDT,IEN312,IENARRY,IENS,INSNODE0,INSDATA,LIST,NODE0
 N NEWENTRY,NIENS,NIENS16,OLDENTRY,OLDWP,SAVEIEN,STOPFLG,TMP,X,Y,Z,Z1,IBRESP,IBTRENT,NEWIEN,PAYIEN,STOP
 S VALMBCK="R"
 I +$G(IBTRIEN)'>0 Q
 S NODE0=$G(^IBT(356.22,IBTRIEN,0))
 S DFN=+$P(NODE0,U,2),IEN312=+$P(NODE0,U,3)
 S INSNODE0="" S:IEN312>0 INSNODE0=$G(^DPT(DFN,.312,IEN312,0)) ; 0-node in file 2.312
 S CURCOB=$P(INSNODE0,U,20) ; COB for the 356.22 entry we're working on
 S EVENTDT=$P(NODE0,U,7)
 ; build a list of existing entries for this patient and event date
 S Z="" F  S Z=$O(^IBT(356.22,"D",DFN,EVENTDT,Z)) Q:'Z  D
 .S NODE0=$G(^IBT(356.22,Z,0))
 .I +$P(NODE0,U,13)>0 Q  ; inquiry pointer exists - this is a response entry
 .S IEN312=+$P(NODE0,U,3) I IEN312>0,$G(LIST(IEN312))="" S LIST(IEN312)=Z_U_$$STATUS^IBTRH2(Z)
 .Q
 D ALL^IBCNS1(DFN,"INSDATA",1,$P(EVENTDT,"-"),1)
 I INSDATA(0)<2 D MSG(1) Q  ; need at least 2 insurance policies to be available
 S STOPFLG=0
 F COB=1:1:3 S IEN312=$O(INSDATA("S",COB,"")) I IEN312'="",COB'=CURCOB D  Q:STOPFLG
 .S PAYIEN=$P($G(^DPT(DFN,.312,IEN312,0)),"^") I PAYIEN="" S STOPFLG=1 Q
 .I '$D(^IBE(350.9,1,$S($P(NODE0,"^",4):66,1:65),"B",PAYIEN)) S STOP=2 Q
 .I +$P($G(LIST(IEN312)),U,2)>1 S STOP=3 Q  ; already sent request for this entry
 .S COBSTR=$S(COB=1:"primary",COB=2:"secondary",1:"tertiary")
 .S DIR("A")="Copy 278 request to "_COBSTR_" insurance? (Y/N): ",DIR("B")="Y",DIR(0)="YAO" D ^DIR K DIR
 .I $G(DTOUT)!$G(DUOUT)!$G(DIROUT)!($G(Y)'=1) Q
 .; copy the entry in 356.22
 .S STOP=4
 .S IENS=IBTRIEN_","
 .D GETS^DIQ(356.22,IENS,".02;.04:.07;.16;2.01:2.25;3*;4.01:4.14;5.01:5.18;6.01:6.18;7.01:7.13;8.01:8.08;9.01:9.08;10.01:10.13;11*;14*;15*;18.01:18.1","IN","OLDENTRY","ERROR")
 .I $D(ERROR) D COPYERR(0) S STOPFLG=1 Q
 .S NIENS=+$G(LIST(IEN312))_"," ; iens of the new entry in 356.22 (top level)
 .I NIENS="0," S NIENS="+1,",NEWENTRY(356.22,NIENS,.01)=$$NOW^XLFDT()
 .D FDACPY(356.22,IENS,NIENS,.OLDENTRY,.NEWENTRY)
 .S NEWENTRY(356.22,NIENS,.03)=IEN312
 .S NEWENTRY(356.22,NIENS,.11)=DUZ
 .; WP field 356.22/12
 .D GETS^DIQ(356.22,IENS,"12","N","OLDWP","ERROR") I $D(ERROR) D COPYERR(0) S STOPFLG=1 Q
 .M NEWENTRY(356.22,NIENS,12)=OLDWP(356.22,IENS,12)
 .I NIENS="+1," D UPDATE^DIE(,"NEWENTRY","NEWIEN","ERROR")
 .I NIENS'="+1," D FILE^DIE(,"NEWENTRY","ERROR")
 .I $D(ERROR) D COPYERR(1) S STOPFLG=1 Q
 .I $D(NEWIEN(1)) S NIENS=NEWIEN(1)_",",LIST(IEN312)=NEWIEN(1)
 .D MLTCLEAR($P(NIENS,","))
 .; multiple 356.223
 .I '$$MLTCPY(356.223,NIENS) S STOPFLG=1 Q
 .; multiple 356.2211
 .I '$$MLTCPY(356.2211,NIENS) S STOPFLG=1 Q
 .; multiple 356.2214
 .I '$$MLTCPY(356.2214,NIENS) S STOPFLG=1 Q
 .; multiple 356.2215
 .I '$$MLTCPY(356.2215,NIENS) S STOPFLG=1 Q
 .; multiple 356.2213 - not all fields are being copied, each entry needs to be handled separately
 .S Z=0 F  S Z=$O(^IBT(356.22,IBTRIEN,13,Z)) Q:'Z  D  Q:STOPFLG
 ..S IENS=Z_","_IBTRIEN_"," K NEWENTRY,OLDENTRY
 ..D GETS^DIQ(356.2213,IENS,".01:.03","IN","OLDENTRY","ERROR")
 ..I $D(ERROR) D COPYERR(0) S STOPFLG=1 Q
 ..D FDACPY(356.2213,IENS,"+1,"_NIENS,.OLDENTRY,.NEWENTRY)
 ..D UPDATE^DIE(,"NEWENTRY",,"ERROR")
 ..I $D(ERROR) D COPYERR(1) S STOPFLG=1
 ..Q
 .; multiple 356.2216 - not all fields are being copied, each entry needs to be handled separately
 .S Z=0 F  S Z=$O(^IBT(356.22,IBTRIEN,16,Z)) Q:'Z  D  Q:STOPFLG
 ..S IENS=Z_","_IBTRIEN_"," K OLDENTRY
 ..D GETS^DIQ(356.2216,IENS,".01:.14;1.01:1.12;2.01:2.09;3.01:3.07;4*;5.01:5.08;6*","IN","OLDENTRY","ERROR")
 ..I $D(ERROR) D COPYERR(0) S STOPFLG=1 Q
 ..K NEWENTRY D FDACPY(356.2216,IENS,"+1,"_NIENS,.OLDENTRY,.NEWENTRY)
 ..; WP field 356.2216/7
 ..K OLDWP D GETS^DIQ(356.2216,IENS,"7","N","OLDWP","ERROR") I $D(ERROR) D COPYERR(0) S STOPFLG=1 Q
 ..M NEWENTRY(356.2216,"+1,"_NIENS,7)=OLDWP(356.2216,IENS,7)
 ..K IENARRY D UPDATE^DIE(,"NEWENTRY","IENARRY","ERROR")
 ..I $D(ERROR) D COPYERR(1) S STOPFLG=1 Q
 ..S NIENS16=IENARRY(1)_","_NIENS ; iens of the new entry in 356.2216
 ..; multiple 356.22164
 ..I '$$MLTCPY(356.22164,NIENS16) S STOPFLG=1 Q
 ..; multiple 356.22166
 ..I '$$MLTCPY(356.22166,NIENS16) S STOPFLG=1 Q
 ..; multiple 356.22167
 ..I '$$MLTCPY(356.22166,NIENS16) S STOPFLG=1 Q
 ..; multiple 356.22168 - not all fields are being copied, each entry needs to be handled separately
 ..S Z1=0 F  S Z1=$O(^IBT(356.22,IBTRIEN,16,Z,8,Z1)) Q:'Z1  D  Q:STOPFLG
 ...S IENS=Z1_","_Z_","_IBTRIEN_"," K NEWENTRY,OLDENTRY
 ...D GETS^DIQ(356.22168,IENS,".01:.03","IN","OLDENTRY","ERROR")
 ...I $D(ERROR) D COPYERR(0) S STOPFLG=1 Q
 ...D FDACPY(356.22168,IENS,"+1,"_NIENS16,.OLDENTRY,.NEWENTRY)
 ...D UPDATE^DIE(,"NEWENTRY",,"ERROR")
 ...I $D(ERROR) D COPYERR(1) S STOPFLG=1
 ...Q
 ..Q
 .; ask if new 278 request should be sent right away
 .S SAVEIEN=IBTRIEN,IBTRIEN=+$G(LIST(IEN312)),IBTRENT=0 D SEND278^IBTRH2 S IBTRIEN=SAVEIEN
 .Q
 I +$G(STOP)>0,+$G(STOP)<4 D MSG(STOP)
 Q
 ;
MSG(TYPE) ;display status message
 ;  TYPE = 1 No alternate insurance available for this patient
 ;       = 2 alternate insurance not setup for 278 submission
 ;       = 3 278 already created for alternate insurance
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="EA"
 S DIR("A",1)=" "
 I TYPE=1 S DIR("A",2)="No alternate insurance available for this patient."
 I TYPE=2 S DIR("A",2)="Alternate insurance is not enabled for 278 submission."
 I TYPE=3 S DIR("A",2)="A 278 is already submitted for the alternate insurance."
 S DIR("A")="Press RETURN to continue " D ^DIR
 Q
