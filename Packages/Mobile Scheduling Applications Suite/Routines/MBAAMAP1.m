MBAAMAP1 ;OIT-PD/VSL - APPOINTMENT API ;02/10/2016
 ;;1.0;Scheduling Calendar View;**1**;Aug 27, 2014;Build 85
 ;
 ;Associated ICRs
 ;  ICR#
 ;  10104 XLFSTR
 ;  10103 XLFDT
 ;
 ;code removed below is scheduled for a future release of MBAA
CLNCK(RETURN,CLN) ;Check clinic for valid stop code restriction. Called by RPC MBAA APPOINTMENT MAKE
 ;  INPUT:   CLN   = IEN of Clinic
 ;
 ;  OUTPUT:  1 if no error or 0^error message
 N PSC,SSC,ND0,VAL,FLDS
 S RETURN=0
 I CLN="" D ERRX^MBAAAPIE(.RETURN,"CLNINV") Q 0
 D GETCLN^MBAAMDA1(.FLDS,CLN,1,0,0)
 I '$D(FLDS) D ERRX^MBAAAPIE(.RETURN,"CLNNDFN") Q 0
 I $G(FLDS(2))'="C" Q 1     ;not a Clinic
 S %=$$SCREST(.RETURN,FLDS(8),"P")
 Q:'% %  Q:FLDS(2503)="" 1
 S %=$$SCREST(.RETURN,FLDS(2503),"S")
 S RETURN=%
 Q RETURN
 ;
SCREST(RETURN,SCIEN,TYP) ;check stop code restriction in file 40.7 for a clinic. MBAA RPC: MBAA APPOINTMENT MAKE
 ;  INPUT:   SCIEN = IEN of Stop Code
 ;           TYP   = Stop Code Type, Primary (P) or Secondary (S)
 ;           DIS   = Message Display, 1 - Display or 0 No Display
 ;
 ;  OUTPUT:  1 if no error, or 0^error message
 ;          
 N SCN,RTY,CTY,RDT,STR,STYP,FLDS,TEXT
 S STYP="("_$S(TYP="P":"Prim",1:"Second")_"ary)"
 S RETURN=0
 I +SCIEN<1 S TEXT(1)=STYP D ERRX^MBAAAPIE(.RETURN,"CLNSCIN",.TEXT) Q 0
 S CTY=$S(TYP="P":"^P^E^",1:"^S^E^")
 D GETCSC^MBAAMDA1(.FLDS,SCIEN)
 S RTY=$G(FLDS(5)),RDT=$G(FLDS(6))
 I RTY="" D  Q 0
 . S TEXT(1)=$G(FLDS(1)),TEXT(2)=STYP
 . D ERRX^MBAAAPIE(.RETURN,"CLNSCNR",.TEXT)
 I CTY'[("^"_RTY_"^") D  Q 0
 . S TEXT(1)=$G(FLDS(1)),TEXT(2)=$S(TYP="P":"Prim",1:"Second")_"ary"
 . D ERRX^MBAAAPIE(.RETURN,"CLNSCPS",.TEXT)
 I RDT>DT D  Q 0
 . S TEXT(1)=$G(FLDS(1)),TEXT(2)=$$FMTE^XLFDT(RDT,"1F"),TEXT(3)=STYP  ;ICR#: 10103 XLFDT
 . D ERRX^MBAAAPIE(.RETURN,"CLNSCRD",.TEXT)
 S RETURN=1
 Q 1
 ; ;
GETCLN(RETURN,CLN) ; Get Clinic data MBAA RPC: MBAA PATIENT PENDING APPT
 ;  INPUT:   CLN = IEN of Clinic
 N DATA
 S RETURN=0
 D GETCLN^MBAAMDA1(.DATA,CLN,1,1,1)
 I '$D(DATA) D ERRX^MBAAAPIE(.RETURN,"CLNNFND") Q 0
 M RETURN=DATA
 S RETURN=1
 Q 1
 ;
 ;LSTCLNS(RETURN,SEARCH,START,NUMBER) ; Return clinics filtered by name.
 ; N LST
 ; D LSTCLNS^MBAAMDA1(.LST,$G(SEARCH),.START,$G(NUMBER))
 ; D BLDLST^MBAAMAPI(.RETURN,.LST)
 ; Q 1
 ; ;
CLNRGHT(RETURN,CLN) ; Verifies (DUZ) user access to Clinic Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT
 N DATA,TXT
 S RETURN=0
 D GETCLN^MBAAMDA1(.DATA,CLN,1)
 I DATA(2500)="Y"  D  Q RETURN
 . I $D(DATA(2501,DUZ,.01))>0 S RETURN=1 Q
 . E  D
 . . S RETURN=0 S TXT(1)=DATA(.01),TXT(2)=$C(10)
 . . D ERRX^MBAAAPIE(.RETURN,"CLNURGT",.TXT)
 . . S RETURN("CLN")=DATA(.01)
 E  S RETURN=1 Q 1
 ;
 ;CLNVSC(RETURN,SC) ; Verifies clinic stop code validation
 ; N DATA
 ; S RETURN=0
 ; D GETCSC^MBAAMDA1(.DATA,+SC)
 ; I $S('$D(DATA):1,'DATA(2):0,1:$G(DATA(2))'>DT) D  Q RETURN
 ; . S TEXT(1)=+SC
 ; . D ERRX^MBAAAPIE(.RETURN,"CLNSCIN",.TEXT)
 ; . S RETURN=0
 ; S RETURN=1
 ; Q RETURN
 ;
GETSCAP(RETURN,SC,DFN,SD) ; Get clinic appointment Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT
 N NOD0,CO
 I '$D(DFN)!(+$G(DFN)'>0) S RETURN=0,TXT(1)="DFN" D ERRX^MBAAAPIE(.RETURN,"INVPARAM",.TXT)
 I '$D(SC)!(+$G(SC)'>0) S RETURN=0,TXT(1)="SC" D ERRX^MBAAAPIE(.RETURN,"INVPARAM",.TXT)
 I '$D(SD)!(+$G(SD)'>0) S RETURN=0,TXT(1)="SD" D ERRX^MBAAAPIE(.RETURN,"INVPARAM",.TXT)
 D GETSCAP^MBAAMDA1(.RETURN,+SC,+DFN,+SD)
 I $D(RETURN) D
 . S NOD0=RETURN(0),CO=$G(RETURN("C"))
 . S RETURN("IFN")=RETURN
 . S RETURN("USER")=$P(NOD0,U,6)
 . S RETURN("DATE")=$P(NOD0,U,7)
 . S RETURN("CHECKOUT")=$P(CO,U,3)
 . S RETURN("CHECKIN")=$P(CO,U,1)
 . S RETURN("LENGTH")=$P(NOD0,U,2)
 . S RETURN("CONSULT")=$P(NOD0,U,11)
 Q 1
 ;
SLOTS(RETURN,SC) ; Get available slots MBAA RPC: MBAA GET CLINIC AVAILABILITY
 D SLOTS^MBAAMDA2(.RETURN,SC)
 S RETURN=1
 Q 1
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;SCEXST(RETURN,CSC) ; Get Stop Cod Exception status
 ; N RET,LAST
 ; D SCEXST^MBAAMDA2(.RET,CSC)
 ; S RETURN=RET
 ; I RET>0 S LAST=99999999999,LAST=$O(RET("EFFECTIVE DATE",LAST),-1) D
 ; . M RETURN=RET("EFFECTIVE DATE",LAST)
 ; Q RETURN
 ; ;
LSTAPPT(RETURN,SEARCH,START,NUMBER) ; Lists appointment types MBAA RPC: MBAA APPOINTMENT LIST BY NAME
 N RET,DL,IN
 S:'$D(START) START="" S:'$D(SEARCH) SEARCH=""
 S:'$G(NUMBER) NUMBER=""
 S RETURN=0
 D LSTAPPT^MBAAMDA2(.RET,$$UP^XLFSTR(SEARCH),.START,NUMBER)  ;ICR#: 10104 XLFSTR
 S RETURN(0)=RET("DILIST",0)
 S DL="DILIST"
 F IN=1:1:$P(RETURN(0),U,1) D
 . S RETURN(IN)=""
 . S RETURN(IN,"ID")=RET(DL,2,IN)
 . S RETURN(IN,"NAME")=RET(DL,"ID",IN,".01")
 S RETURN=1
 Q 1
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;GETAPPT(RETURN,TYPE) ; Returns Appointment Type detail
 ; D GETAPPT^MBAAMDA2(.RETURN,TYPE,1,1,1)
 ; S RETURN=1
 ; Q 1
 ; ;
 ;GETELIG(RETURN,ELIG) ; Returns Eligibility Code detail 
 ; D GETELIG^MBAAMDA2(.RETURN,ELIG,1,1,1)
 ; S RETURN=1
 ; Q 1
 ; ;
 ;GETPEND(RETURN,DFN,DT) ; Get pending appointments
 ; N CNT,SCAP,APP,CLN,%
 ; S CNT=""
 ; D GETPEND^MBAAMDA2(.APP,DFN,DT)
 ; F  S CNT=$O(APP(CNT)) Q:CNT=""  D
 ; . S RETURN(CNT,"COLLATERAL VISIT")=APP(CNT,13)
 ; . S RETURN(CNT,"APPOINTMENT TYPE")=$$APTYNAME^MBAAMDA2(APP(CNT,9.5))
 ; . S RETURN(CNT,"LAB")=APP(CNT,2)
 ; . S RETURN(CNT,"XRAY")=APP(CNT,3)
 ; . S RETURN(CNT,"EKG")=APP(CNT,4)
 ; . S %=$$GETCLN^MBAAMAP1(.CLN,APP(CNT,.01))
 ; . S RETURN(CNT,"CLINIC")=$P(CLN("NAME"),U,2)
 ; . S %=$$GETSCAP^MBAAMAP1(.SCAP,APP(CNT,.01),DFN,CNT)
 ; . S RETURN(CNT,"LENGTH OF APP'T")=$G(SCAP("LENGTH"))
 ; . S RETURN(CNT,"CONSULT LINK")=$G(SCAP("CONSULT"))
 ; S RETURN=($D(RETURN)>0)
 ; Q 1
 ; ;
 ;GETAPTS(RETURN,DFN,SD) ; Get patient appointments
 ; S DFN=+DFN
 ; D GETAPTS^MBAAMDA2(.RETURN,+DFN,.SD)
 ; S RETURN=($D(RETURN)>0)
 ; Q 1
 ; ;
LSTCRSNS(RETURN,SEARCH,START,NUMBER) ; MBAA RPC: MBAA LIST CANCELLATION REASONS
 N LST
 M LST=RETURN
 D LSTCRSNS^MBAAMDA2(.LST,$$UP^XLFSTR($G(SEARCH)),.START,$G(NUMBER))
 D BLDLST^MBAAMAPI(.RETURN,.LST)
 Q RETURN
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;FRSTAVBL(RETURN,SC) ; Get first available date
 ; D FRSTAVBL^MBAAMDA2(.RETURN,SC)
 ; Q 1
 ; ;
 ;linetag LSTCAPTS is removed, it is not needed until the next enhancement of MBAA
 ;LSTCAPTS(RETURN,SC,SDBEG,SDEND,STAT) ; Returns clinic appointments filtered by date and status
 ;N APTS,CNT,IND,FAPTS,GROUPS
 ;S CNT=0,IND=0
 ;S RETURN=0
 ;D GROUP^SDAM($P(STAT,U),.GROUPS)
 ;D LSTCAPTS^MBAAMDA1(.APTS,SC,.SDBEG,.SDEND)
 ;D BLDAPTS(.RETURN,.APTS,SC,,.GROUPS)
 ;S RETURN=1
 ;Q 1
 ;
 ;linetag LSTPAPTS is removed, this functionality is not needed until a future enhancement of MBAA
 ;LSTPAPTS(RETURN,DFN,SDBEG,SDEND,STAT) ; Returns patient appointments filtered by date and status
 ;N APTS,CNT,IND,FAPTS,GROUPS
 ;S CNT=0,IND=0
 ;S RETURN=0
 ;D GROUP^SDAM($P(STAT,U),.GROUPS)
 ;D LSTPAPTS^MBAAMDA1(.APTS,DFN,.SDBEG,.SDEND)
 ;D BLDAPTS(.RETURN,.APTS,,DFN,.GROUPS)
 ;S RETURN=1
 ;Q 1
 ;
 ;linetag BLDAPTS is removed, it is not needed until the next enhancement of MBAA
 ;BLDAPTS(RETURN,APTS,SSC,SDFN,GROUPS) ; Build appointment list
 ;N IND,DFN,SC,VA,VADM,CDATA,SDATA,SDDA,SDSTAT,CAPT,PAPT
 ;F IND=0:0 S IND=$O(APTS(IND)) Q:IND=""  D
 ;. S SDATA=APTS(IND,"SDATA")
 ;. Q:'$G(SDFN)&($P(SDATA,U,2)["C")
 ;. S DFN=$S('$G(SDFN):+APTS(IND,"CDATA"),1:SDFN)
 ;. S SD=APTS(IND,"SD")
 ;. S SC=$S('$G(SSC):APTS(IND,"SC"),1:SSC)
 ;. S SDDA=APTS(IND,"SDDA")
 ;. S CDATA=$G(APTS(IND,"CDATA"))
 ;. S SDSTAT=$$STATUS^SDAM1(DFN,SD,SC,SDATA,$S($D(SDDA):SDDA,1:""))
 ;. Q:'$$CHK^SDAM1(,,,,.GROUPS,SDSTAT)
 ;. Q:$G(SSC)&(($P(CDATA,U,9)="C")!($P(SDATA,U,2)["C")&($G(SC)))
 ;. S CNT=CNT+1
 ;. D 2^VADPT
 ;. S RETURN(CNT,"BID")=VA("BID")
 ;. S RETURN(CNT,"NAME")=VADM(1)
 ;. D GETPAPT^MBAAMDA4(.PAPT,DFN,SD)
 ;. S RETURN(CNT,"GAF")=$$GAFREQ(DFN,SC,$P(SDATA,U,11))
 ;. S RETURN(CNT,"SD")=SD
 ;. S RETURN(CNT,"STAT")=SDSTAT
 ;. S RETURN(CNT,"STATI")=PAPT(3,"I")
 ;. S RETURN(CNT,"OE")=PAPT(21,"I")
 ;. S RETURN(CNT,"DFN")=DFN
 ;. S RETURN(CNT,"LAB")=$P(SDATA,U,3)
 ;. S RETURN(CNT,"XRAY")=$P(SDATA,U,4)
 ;. S RETURN(CNT,"EKG")=$P(SDATA,U,5)
 ;. S RETURN(CNT,"SC")=SC
 ;. D GETCAPT^MBAAMDA4(.CAPT,DFN,SD)
 ;. S RETURN(CNT,"LEN")=CAPT(1)
 ;. S RETURN(CNT,"CLINIC")=PAPT(.01,"E")
 ;. S RETURN(CNT,"SDDA")=APTS(IND,"SDDA")
 ;. S:$G(APTS(IND,"CONS"))>0 RETURN(CNT,"CSTAT")=$$CNSSTAT^MBAAMEXT(APTS(IND,"CONS"))
 ;Q
 ;
 ;GAFREQ(DFN,SC,CVSIT) ;
 ; N SDELIG,SDGAF,SDGAFST
 ; S SDELIG=$$ELSTAT^SDUTL2(DFN)
 ; I $$MHCLIN^SDUTL2(SC),'($$COLLAT^SDUTL2(SDELIG)!$G(CVSIT)) D  Q SDGAFST
 ; . S SDGAF=$$NEWGAF^SDUTL2(DFN),SDGAFST=$P(SDGAF,"^") Q
 ; Q 0
 ; ;
 ;GETCSC(RETURN,SC) ; Get clinic stop code
 ; N CLN
 ; D GETCLN^MBAAMDA1(.CLN,SC,1)
 ; D GETCSC^MBAAMDA1(.RETURN,$G(CLN(8)))
 ; S RETURN=1
 ; Q 1
 ; ;
CPAIR(RETURN,SC) ;Validate primary stop code, get credit pair MBAA RPC: MBAA APPOINTMENT MAKE
 ;Input: SC=HOSPITAL LOCATION record IFN
 ;Input: RETURN=variable to return clinic credit pair (pass by reference)
 ;Output: 1=success, 0=invalid primary stop code
 N SDSSC
 D GETCLN^MBAAMDA1(.CLN,SC,1)
 D GETCSC^MBAAMDA1(.CS,CLN(8))
 S RETURN=$G(CS(1)),RETURN=$S(RETURN<100:0,RETURN>999:0,1:RETURN)
 Q:RETURN'>0 0
 K CS D GETCSC^MBAAMDA1(.CS,CLN(2503))
 S SDSSC=$G(CS(1)),RETURN=RETURN_$S(SDSSC<100:"000",SDSSC>999:"000",1:SDSSC)
 Q 1
 ;
PTFU(RETURN,DFN,SC)    ;Determine if this is a follow-up (return to clinic within 24 months) Called by RPC MBAA APPOINTMENT MAKE
 ;Input: DFN=patient ifn
 ;Input: SC=clinic ifn
 ;Output: '1' if seen within 24 months, '0' otherwise
 ;
 Q:'DFN!'SC 0  ;variable check
 S RETURN=1
 N SDBDT,SDT,SDX,SDY,SDZ,SDCP,SDCP1,SC0,SDENC,SDCT,LST,ENC,FLDS
 ;set up variables
 S SDBDT=(DT-20000)+.24,SDT=DT_.999999,SDY=0
 S SDX=$$CPAIR(.SDCP,SC)  ;get credit pair for this clinic
 ;Iterate through encounters
 D LSTAENC^MBAAMDA1(.LST,DFN)
 S FLDS(.04)="CLINIC",FLDS(.06)="PARENT"
 D BLDLST^MBAAMAPI(.ENC,.LST,.FLDS)
 F  S SDT=$O(ENC(SDT),-1) Q:'SDT!SDY  D
 . Q:ENC(SDT,"PARENT")]""  ;parent encounters only
 . Q:ENC(SDT,"NAME")<SDBDT
 . S SDX=$$CPAIR(.SDCP1,ENC(SDT,"CLINIC"))  ;get credit pair for encounter
 . S SDY=SDCP=SDCP1  ;compare credit pairs
 . Q
 Q SDY
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;HASPEND(RETURN,DFN,DT) ; Check if patient has panding appointments
 ; D HASPEND^MBAAMDA2(.RETURN,DFN,DT)
 ; Q 1
 ; ;
 ;LSTSRT(RETURN) ;List scheduling request types
 ; K RETURN
 ; S RETURN=1
 ; D LSTSCOD^MBAAMDAL(2.98,25,.RETURN)
 ; Q 1
 ; ;
 ;LSTAPPST(RETURN) ;List appointment statuses
 ; K RETURN
 ; S RETURN=1
 ; D LSTSCOD^MBAAMDAL(2.98,3,.RETURN)
 ; Q 1
 ; ;
 ;LSTHLTP(RETURN) ;List hospital location types
 ; K RETURN
 ; S RETURN=1
 ; D LSTSCOD^MBAAMDAL(44,2,.RETURN)
 ; Q 1
 ;
