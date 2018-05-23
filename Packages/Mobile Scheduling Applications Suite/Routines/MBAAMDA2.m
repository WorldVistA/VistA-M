MBAAMDA2 ;OIT-PD/VSL - APPOINTMENT API ;02/10/2016
 ;;1.0;Scheduling Calendar View;**1,5**;Feb 13, 2015;Build 6
 ;
 ;Associated ICRs
 ;  ICR#
 ;  6053 DPT
 ;  6044 SC(
 ;
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;FRSTAVBL(RETURN,SC) ; Get first available date
 ; S RETURN=$O(^SC(+SC,"T",0))
 ; S RETURN=$O(^(0))
 ; Q
 ; ;
SLOTS(RETURN,SC) ; Get available slots MBAA RPC: MBAA GET CLINIC AVAILABILITY
 ;T13 Change to use FM to get the data
 S SD=0 F  S SD=$O(^SC(SC,"ST",SD)) Q:SD'>0  D    ;ICR#: 6044 SC(
 .N IENS,ARRAY,ERR S IENS=$G(SD)_","_SC_"," D GETS^DIQ(44.005,IENS,".01;1","I","ARRAY","ERR")
 .S RETURN(SD,0)=$G(ARRAY(44.005,IENS,.01,"I")),RETURN(SD,1)=$G(ARRAY(44.005,IENS,1,"I"))
 .I $E(RETURN(SD,1),6,11)="      " S $E(RETURN(SD,1),6,11)="  " Q  ;MBAA*1*5 - 10 MINS SLOTS
 .I $E(RETURN(SD,1),6)'=" " S RETURN(SD,1)=$E(RETURN(SD,1),1,5)_"  "_$E(RETURN(SD,1),6,99) ;MBAA*1*5 20 MINS SLOTS
 K SD
 ;M RETURN=^SC(+SC,"ST")  ;ICR#: 6044 SC(
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;SCEXST(RETURN,CSC) ; Returns Outpatient Classification Stop Code Exception status
 ; N FILE,STOPN,IENACT,FLDS,FS
 ; S STOPN=$$GET1^DIQ(40.7,+CSC_",",1)
 ; S IENACT=""
 ; S IENACT=$O(^SD(409.45,"B",STOPN,IENACT))
 ; S FILE="409.45"
 ; S FLDS("*")=""
 ; S FS("75")="",FS("75","F")="409.4575",FS("75","N")="EFFECTIVE DATE"
 ; S RETURN=0
 ; I $D(IENACT) D
 ; . D GETREC^MBAAMDAL(.RETURN,IENACT,FILE,.FLDS,.FS,1,1,1) S RETURN=1
 ; Q
 ; ;
LSTAPPT(RETURN,SEARCH,START,NUMBER) ; Lists appointment types MBAA RPC: MBAA APPOINTMENT LIST BY NAME
 N FILE,FIELDS,RET
 S FILE="409.1",FIELDS="@;.01"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"B","","","RETURN")
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;GETAPPT(RETURN,TYPE,INT,EXT,REZ) ; Get Appointment Type
 ; N FILE,FLDS,SF
 ; S FILE=409.1,FLDS("*")=""
 ; D GETREC^MBAAMDAL(.RETURN,TYPE,FILE,.FLDS,.SF,$G(INT),$G(EXT),$G(REZ))
 ; Q
 ;
 ;GETELIG(RETURN,ELIG,INT,EXT,REZ) ; Get eligibility code
 ;N FILE,FLDS
 ;S FILE=8,FLDS("*")=""
 ;D GETREC^MBAAMDAL(.RETURN,ELIG,FILE,.FLDS,,$G(INT),$G(EXT),$G(REZ))
 ;Q
 ; ;
 ;HASPEND(RETURN,PAT,DT) ; Return 1 if patient has pending appointment
 ; S RETURN=0
 ; I '$D(^DPT(+$G(PAT),0)) D ERRX^MBAAAPIE(.RETURN,"PATNFND") Q RETURN
 ; S:$O(^DPT(PAT,"S",DT))>DT RETURN=1
 ; Q RETURN
 ; ;
 ;GETPEND(RETURN,PAT,DT) ; Get pending appointments
 ; N Y,AP
 ; F Y=DT:0 S Y=$O(^DPT(PAT,"S",Y)) Q:Y'>0  D
 ; . S AP=^(Y,0)
 ; . I "I"[$P(AP,U,2) D
 ; . . S RETURN(Y,.01)=$P(AP,U,1)
 ; . . S RETURN(Y,13)=$P(AP,U,11)
 ; . . S RETURN(Y,9.5)=$P(AP,U,16)
 ; . . S RETURN(Y,2)=$P(AP,U,3)
 ; . . S RETURN(Y,3)=$P(AP,U,4)
 ; . . S RETURN(Y,4)=$P(AP,U,5)
 ; Q
 ; ;
APTYNAME(TYPE) ; Get appointment type name MBAA RPC: MBAA PATIENT PENDING APPT
 Q $$GET1^DIQ(409.1,TYPE_",",.01)
 ;
GETAPTS(RETURN,DFN,SD) ; Get patient appointments Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT
 N FILE,SFILES,APTS,DT
 S FILE=2
 S SFILES("1900")="",SFILES("1900","N")="APT",SFILES("1900","F")="2.98",ROUT=3
 S:$G(ROUTC)=1 ROUT=4
 D GETREC^MBAAMDAL(.APTS,DFN,FILE,,.SFILES,1,1,1)
 I '$D(SD) M RETURN=APTS Q
 I $G(SD)>0&'$D(SD(0)) D  Q
 . I $D(APTS("APT",SD)) M RETURN("APT",SD)=APTS("APT",SD) Q
 S DT=$S(SD(0)=1:$P(SD,"."),SD(0)=0:$O(APTS("APT","")))
 F  S DT=$O(APTS("APT",DT)) Q:'$D(DT)!(DT="")  D
 . M RETURN("APT",DT)=APTS("APT",DT)
 Q
 ;
GETDAPTS(RETURN,DFN,SD) ; Get all appointments in the day Called by RPC MBAA APPOINTMENT MAKE
 N NOD
 S RETURN=0
 S IND=$P(SD,".")
 F  S IND=$O(^DPT(DFN,"S",IND)) Q:IND=""!($P(IND,".")>$P(SD,"."))  D  ;ICR#: 6053 DPT
 . ;T13 Change to use FM to get these fields
 . N ARRAY S IENS=$G(SD)_","_$G(DFN)_"," D GETS^DIQ(2.98,IENS,".01;3","I","ARRAY")
 . S RETURN(IND,1)=$G(ARRAY(2.98,IENS,.01,"I"))
 . S RETURN(IND,2)=$G(ARRAY(2.98,IENS,3,"I"))
 . ;S NOD=^DPT(DFN,"S",IND,0)
 . ;S RETURN(IND,1)=$P(NOD,U,1)
 . ;S RETURN(IND,2)=$P(NOD,U,2)
 S RETURN=1
 Q
 ;
LSTCRSNS(RETURN,SEARCH,START,NUMBER) ; MBAA RPC: MBAA LIST CANCELLATION REASONS
 N FILE,FIELDS,RET,SCR,TYP
 S FILE="409.2",FIELDS="@;.01"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 ;T16 Change to return only cancel reasons that a patient can select
 ;I $D(RETURN("TYPE")) S TYP=RETURN("TYPE"),SCR="I $P(^(0),U,2)[""PB""&'$P(^(0),U,4),(TYP_""B""[$P(^(0),U,2))"
 I $D(RETURN("TYPE")) S TYP=RETURN("TYPE")
 S SCR="I ""BP""[$P(^(0),U,2)"
 K RETURN
 D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"B",.SCR,"","RETURN","ERR")
 Q
 ;
LSTCSTA1(RETURN,SEARCH,START,NUMBER) ; Returns the list of states that allow cancellation. MBAA RPC: MBAA CANCEL APPOINTMENT
 N FILE,FIELDS,RET,SCR
 S FILE="409.63",FIELDS="@;.01"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S START(1)=1
 S START(2)=0
 D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"ACAN",.SCR,"","RETURN","ERR")
 Q
 ;
LSTCIST1(RETURN,SEARCH,START,NUMBER) ; Returns the list of states that allow check in. MBAA RPC: MBAA APPOINTMENT MAKE
 N FILE,FIELDS,RET,SCR
 S FILE="409.63",FIELDS="@;.01"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S START(1)=1
 S START(2)=0
 D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"ACI",.SCR,"","RETURN","ERR")
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;LSTCOST1(RETURN,SEARCH,START,NUMBER) ; Returns the list of states that allow check in.
 ; N FILE,FIELDS,RET,SCR
 ; S FILE="409.63",FIELDS="@;.01"
 ; S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 ; S START(1)=1
 ; S START(2)=0
 ; D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"ACO",.SCR,"","RETURN","ERR")
 ; Q
 ;
 ;LSTNSTA1(RETURN,SEARCH,START,NUMBER) ; Returns the list of states that allow no-show. 
 ;N FILE,FIELDS,RET,SCR
 ;S FILE="409.63",FIELDS="@;.01"
 ;S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 ;S START(1)=1
 ;S START(2)=0
 ;D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"ANS",,"","RETURN","ERR")
 ;Q
 ;
GETAPT0(DFN,SD) ; Get appointment 0 node MBAA RPC: MBAA CANCEL APPOINTMENT
 Q $G(^DPT(DFN,"S",SD,0))  ;ICR#: 6053 DPT
 ;
GETPAPT(RETURN,DFN,SD) ; Get patient appointment Called by RPC MBAA APPOINTMENT MAKE
 N IND
 F IND=0:0 S IND=$O(RETURN(IND)) Q:IND=""  D
 . S RETURN(IND)=$$GET1^DIQ(2.98,SD_","_DFN_",",IND,"I")
 S RETURN=1
 Q
 ;
