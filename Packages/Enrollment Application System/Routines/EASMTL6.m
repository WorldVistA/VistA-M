EASMTL6 ; ALB/SCK,BRM,LBD,PHH - AUTOMATED MEANS TEST LETTER-INTERACTIVE PRINT ; 5/22/03 9:52am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,14,15,29,25,22,54**;MAR 15,2001
 ;
EN ; Main entry point
 ; Input, set in option call, if not passed in, or called interactively, user is asked to specify.
 ;    EATYP - Used for selective printing of letters and forms
 ;         1 : 60-Day
 ;         2 : 30-Day
 ;         4 :  0-Day
 ;
 N DIR,DIRUT,POP,EASLOC,Y
 ;
 ;; Select type of letter to print
 I '$G(EATYP) D  Q:$D(DIRUT)
 . S DIR(0)="SO^1:60-Day;2:30-Day;4:0-Day"
 . S DIR("?")="Select the type of letter to print"
 . D ^DIR K DIR
 . S EATYP=+Y
 ;
 ;; Select facility filter if appropriate
 S EASLOC=-1
 I $$GET1^DIQ(713,1,8,"I") D  Q:$D(DIRUT)
 . S DIR(0)="YAO",DIR("A")="Filter letters by Preferred Facility? "
 . S DIR("B")="NO"
 . S DIR("?")="Enter 'YES' to limit letters to a specific Facility or 'NO' to print all letters."
 . D ^DIR K DIR
 . Q:$D(DIRUT)!('Y)
 . S EASLOC=$$FACNUM
 ;
 K IOP,IO("Q")
 ;
 S %ZIS="QP",%ZIS("B")=$$GET1^DIQ(713,1,5)
 D ^%ZIS K %ZIS
 Q:POP
 I $D(IO("Q")) D QUE Q
 D LTR
 D ^%ZISC
 K EATYP
 Q
 ;
QUE ; Queue the report
 N ZTRTN,ZTDESC,ZTSAVE,ZTSK,ZTDTH,ZTQUEUED
 ;
 S ZTRTN="LTR^EASMTL6"
 S ZTDESC="EAS MT LETTERS PRINT JOB"
 S ZTSAVE("EATYP")="",ZTSAVE("EASLOC")=""
 S ZTDTH="NOW"
 ;
 D ^%ZTLOAD
 I $D(ZTSK)[0 W !!?5,"Letters canceled!"
 E  W !!?5,"Letters queued! [ ",ZTSK," ]"
 D HOME^%ZIS
 Q
 ;
LTR ; Main entry point
 N EASTMP,EASKP
 ;
 S EASTMP="^TMP(""EASMT"",$J)"
 K @EASTMP
 ;
 I '$D(ZTQUEUED) W !,"...Gathering letters to print...Please wait"
 D BLD(EATYP,EASLOC,EASTMP,.EASKP)
 D RESULT(.EASKP,EATYP)
 I '$D(ZTQUEUED) W !,"...Printing letters..."
 D PRINT(EASTMP,EATYP)
 K @EASTMP,EATYP
 Q
 ;
RESULT(EASKP,EATYP) ; Send results of letter printing to mail group
 N MSG,XMSUB,XMY,XMTEXT,XMDUZ,TOT,X1
 ;
 S MSG(1)="Letters to print: "_$J($FN(EASKP("CNT"),","),8)
 S MSG(2)="Letters where the print date has not reached: "_$J($FN(EASKP("T"),","),8)
 S MSG(2.5)=""
 S MSG(3)="The following letters were found but not printed for the following reasons:"
 S MSG(4)="Incomplete/Bad Addr :                 "_$J($FN(EASKP("I"),","),8)
 S MSG(5)="Deceased :                            "_$J($FN(EASKP("D"),","),8)
 S MSG(6)="MT Changed:                           "_$J($FN(EASKP("C"),","),8)
 S MSG(7)="Prohibit flag set:                    "_$J($FN(EASKP("P"),","),8)
 S MSG(8)="Not a User Enrollee:                  "_$J($FN(EASKP("U"),","),8)
 S MSG(8.5)="Not a User Enrollee of this facility: "_$J($FN(EASKP("O"),","),8)
 S MSG(9)=""
 S TOT=0 F X1="I","D","C","P","O","T","U","CNT" S TOT=TOT+EASKP(X1)
 S MSG(10)="Total Letters Processed: "_$J($FN(TOT,","),8)_" (MT not returned)"
 ;
 S XMSUB=$S(EATYP=1:"60-Day",EATYP=2:"30-Day",1:"0-Day")_" Print Letter Results"
 S XMTEXT="MSG("
 S XMY("G.EAS MTLETTERS")=""
 S XMDUZ="AUTOMATED MT LETTERS"
 D ^XMD
 Q
 ;
BLD(EATYP,EASLOC,EASTMP,EASKP) ; Build TMP array of letters to print
 N DFN,EASIEN,COUNT,EAX2,EASPTR,EASABRT,EASUE
 ;
 F EAX2="P","D","C","F","T","I","O","U","CNT" S EASKP(EAX2)=0
 S COUNT=0
 ;
 S EASIEN=0 ; Begin loop through un-returned means tests
 F  S EASIEN=$O(^EAS(713.2,"AC",0,EASIEN)) Q:'EASIEN  D  Q:$G(EASABRT)
 . S EASPTR=$$GET1^DIQ(713.2,EASIEN,2,"I") ; Pointer to File 713.1
 . ; begin checks
 . Q:EASPTR<0  ; SAFETY CHECK
 . Q:$$LTRTYP^EASMTL6B(EASIEN)'=EATYP  ;  Check for appropriate letter type
 . S DFN=$$GET1^DIQ(713.1,EASPTR,.01,"I") Q:'DFN
 . ;; Filter by site, quit if filter not met
 . I +$G(EASLOC)>0 Q:$$GET1^DIQ(2,DFN,27.02,"I")'=+EASLOC
 . I $D(^EAS(713.1,"AP",1,EASPTR)) D  Q  ; Check Prohibit letter
 . . D CLRFLG^EASMTUTL(0,EASIEN)
 . . S EASKP("P")=EASKP("P")+1
 . I $$DECEASED^EASMTUTL(EASIEN) D  Q  ; Check Deceased
 . . D CLRFLG^EASMTUTL(0,EASIEN)
 . . S EASKP("D")=EASKP("D")+1
 . I $$CHECKMT^EASMTUTL(EASPTR,EASIEN) D  Q  ; Check MT changed?
 . . D CLRFLG^EASMTUTL(0,EASIEN)
 . . S EASKP("C")=EASKP("C")+1 Q
 . I $$FUTMT^EASMTUTL(EASIEN) D  Q  ; Check for a Future MT
 . . D CLRFLG^EASMTUTL(0,EASIEN)
 . . S EASKP("F")=EASKP("F")+1
 . I '$$THRSHLD(EATYP,EASIEN) D  Q  ; Quit if letter threshold not reached
 . . S EASKP("T")=EASKP("T")+1
 . ; Get User Enrollee status (0=not UE; 1=UE; 2=UE, not this site)
 . S EASUE=$$UESTAT^EASUER(DFN)
 . I 'EASUE D  Q     ; Quit if not User Enrollee
 . . D NOPRT(EATYP,EASIEN)
 . . S EASKP("U")=EASKP("U")+1
 . I EASUE'=1 D  Q   ; Quit if User Enrollee site is not this facility
 . . D NOPRT(EATYP,EASIEN)
 . . S EASKP("O")=EASKP("O")+1
 . I $$CHKADR^EASMTL6A(EASPTR) D  Q  ; Check for valid address
 . . S EASKP("I")=EASKP("I")+1
 . S @EASTMP@(EASIEN)=EATYP ; Build entry
 . S EASKP("CNT")=EASKP("CNT")+1
 . I $D(IO("Q")),$$S^%ZTLOAD("STOPPED BY USER") S EASABRT=1
 Q
 ;
OWNED(PTR1,EAIEN) ;  Check - Does this facility "own" this means test
 ;  Returns '1' if means test 'owned' by facility
 ;          '0' if not owned
 ;
 N MTNODE,MTLST,MTOWN,RSLT
 ;
 S RSLT=0
 S MTLST=$$LST^DGMTU(PTR1)
 I $P(MTLST,U,1)>0 D
 . S MTNODE=$G(^DGMT(408.31,$P(MTLST,U,1),0))
 . S MTOWN=$$GET1^DIQ(408.34,$P(MTNODE,U,23),.01)
 . I MTOWN="VAMC" S RSLT=1 Q
 . I MTOWN="DCD",$$VERSION^XPDUTL("IVMC") S RSLT=1
 ;
 ;; If another facility 'owns' this MT, update MT Status information
 I 'RSLT D
 . Q:'EAIEN
 . S DIE="^EAS(713.2,",DA=EAIEN
 . S DR="4///YES;5///TODAY;7///MT 'OWNED' BY ANOTHER FACILITY;9///NO;12///NO;18///NO"
 . D ^DIE K DIE
 ;
 Q RSLT
 ;
PRINT(EASTMP,EATYP) ; Print letters
 N EASIEN,EASABRT,Y
 ;
 U IO
 S EASIEN=0
 F  S EASIEN=$O(@EASTMP@(EASIEN)) Q:'EASIEN  D  Q:$G(EASABRT)
 . D LETTER^EASMTL6A(EASIEN,EATYP) ; Print letter
 . D UPDSTAT(EASIEN,EATYP) ; Update Letter status file, #713.2
 . I $D(IO("Q")),$$S^%ZTLOAD("STOPPED BY USER") S EASABRT=1 Q
 . I '$D(IO("Q")),$E(IOST,1,2)="C-" D
 . . S DIR(0)="E"
 . . D ^DIR K DIR
 . . S:'Y EASABRT=1
 Q
 ;
THRSHLD(EATYP,EASIEN) ; Check threshold for letter types
 ; Input
 ;    EATYP  - Letter type to print
 ;    EASIEN - IEN for file #713.2
 ;
 ; Output
 ;    RSLT = 1: Letter is inside threshold to print
 ;           0: Letter is outside threshold (Don't print)
 ;
 N DIFF,THRESH,RSLT,ANVDT,MTDT
 ;
 S RSLT=1
 Q:'$G(EATYP)
 S THRESH=$S(EATYP=1:60,EATYP=2:30,1:0)
 S MTDT=$$GET1^DIQ(713.2,EASIEN,3,"I")
 S ANVDT=$$ADDLEAP^EASMTUTL(MTDT)
 S DIFF=$$FMDIFF^XLFDT(ANVDT,$$DT^XLFDT)
 I DIFF>THRESH S RSLT=0
 Q RSLT
 ;
NOPRT(EATYP,EASIEN) ; Letter not printed, update Letter Status file #713.2
 ; Input
 ;    EATYP  - Letter type to print
 ;    EASIEN - IEN for file #713.2
 ;
 N DIE,DR,DA,LTR
 Q:'$G(EATYP)  Q:'$G(EASIEN)
 S DIE="^EAS(713.2,",DA=EASIEN
 S LTR=$S(EATYP=1:9,EATYP=2:12,EATYP=4:18,1:0)
 Q:'LTR
 ; Set current letter print statuses = "N"
 S DR=LTR_"///0;"_(LTR+1)_"///0"
 ; If current letter is not 0-day letter, set next letter print = "Y"
 S:LTR'=18 DR=DR_";"_$S(LTR=9:12,1:18)_"///1"
 D ^DIE
 Q
 ;
UPDSTAT(EASN,EAX) ; Update Letter status file, #713.2
 N DIE,DR,DA,EAPD,EAFLG,NXTFLG
 ;
 S DIE="^EAS(713.2,",DA=EASN
 S DR=$S(EAX=1:10,EAX=2:13,EAX=4:19,1:0)
 Q:'DR
 S EAPD=DR_".5",EAFLG=DR-1
 S DR=DR_"///1;"_EAPD_"///^S X=$$DT^XLFDT;"_EAFLG_"///0"
 S NXTFLG=$S(EAFLG=9:12,EAFLG=12:18,1:0)
 S:NXTFLG>0 DR=DR_";"_NXTFLG_"///1"
 D ^DIE K DIE
 D CLRFLG^EASMTUTL(EAX,EASN)
 Q
 ;
FACNUM() ;  Get facility number
 N RSLT,DIR,Y
 ;
 S DIR(0)="P^4:EMZ"
 S DIR("S")="I '$P($G(^DIC(4,Y,99)),U,4)"
 D ^DIR K DIR
 I $D(DIRUT) S RSLT=0
 E  S RSLT=+Y_"^"_$P($G(^DIC(4,+Y,99)),U,1)
 ;
 Q RSLT
 ;
GETFAC(EADFN,EASARY) ;  set facility return address information
 N EASFAC,EAX,EASF,EAS4
 ;
 I $$GET1^DIQ(713,1,9,"I") D
 . S EASFAC=$$GET1^DIQ(2,EADFN,27.02,"I")
 . Q:'EASFAC
 . ;; Check for inactive flag
 . Q:$$GET1^DIQ(4,EASFAC,101,"I")
 . D GETS^DIQ(4,EASFAC,".01;1.01;1.02;1.03;1.04;.02;100","EI","EAS4")
 . S EASF=EASFAC_","
 . ;; Check for valid address information
 . I EAS4(4,EASF,1.01,"E")]"",EAS4(4,EASF,1.03,"E")]"",EAS4(4,EASF,.02,"E")]"" S EASARY("TYP")="P"
 ;
 I $G(EASARY("TYP"))'="P" D
 . S EASFAC=$$SITE^VASITE
 . D GETS^DIQ(4,+EASFAC,".01;1.01;1.02;1.03;1.04;.02;100","EI","EAS4")
 . S EASARY("TYP")="F"
 ;
 S EASARY("FACNUM")=+EASFAC
 S EASARY("FAC")=$$GET1^DIQ(4,+EASFAC,.01,"I")
 F EAX=1.01,1.02,1.03,1.04,100 D
 .  S EASARY(EAX)=EAS4(4,+EASFAC_",",EAX,"E")
 S EASARY(.02)=EAS4(4,+EASFAC_",",.02,"E")_"^"_$$GET1^DIQ(5,EAS4(4,+EASFAC_",",.02,"I"),1)
 Q
