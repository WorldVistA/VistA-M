SDOEOE ;ALB/MJK - ACRP APIs For An Encounter ;8/12/96
 ;;5.3;Scheduling;**131,132**;Aug 13, 1993
 ;
OE0(SDOE) ; -- get only supported 0th node fields
 Q $$OE0^SDOEQ(.SDOE)  ; -- in SDOEQ for SCAN speed reasons
 ;
 ;
GETOE(SDOE,SDERR) ; -- SDOE GET ZERO NODE
 ;   API ID: 98
 ;
 ;
 Q $S($$VALOE(.SDOE,$G(SDERR)):$$OE0^SDOEQ(.SDOE),1:"")
 ;
 ;
GETGEN(SDOE,SDAT,SDERR) ; -- SDOE GET GENERAL DATA
 ;   API ID: 76
 ;
 ;
GETGENG ; -- goto entry point
 ; -- do validation checks
 IF '$$VALOE(.SDOE,$G(SDERR)) G GETGENQ
 ;
 S @SDAT=SDOE
 S @SDAT@(0)=$$OE0^SDOEQ(.SDOE)
GETGENQ Q
 ;
 ;
PARSE(SDATA,SDFMT,SDY,SDERR) ; -- SDOE PARSE GENERAL DATA
 ;   API ID: 78
 ;
 ;
PARSEG ; -- goto entry point
 ; -- do validation checks
 ; -- invalid format check
 IF '$$VALFMT(SDFMT,$G(SDERR)) G PARSEQ
 ;
 ; -- no data check
 IF $G(SDATA(0))="" D  G PARSEQ
 . D BLD^SDQVAL(4096800.024,"","",$G(SDERR))
 ;
 IF SDFMT="EXTERNAL" D  G PARSEQ
 . N SDX S SDX=$G(SDATA(0))
 . S @SDY@(.01)=$$FMTE^XLFDT($P(SDX,"^",1))
 . S @SDY@(.02)=$P($G(^DPT(+$P(SDX,"^",2),0)),"^")
 . S @SDY@(.03)=$P($G(^DIC(40.7,+$P(SDX,"^",3),0)),"^")
 . S @SDY@(.04)=$P($G(^SC(+$P(SDX,"^",4),0)),"^")
 . S @SDY@(.05)=$$FMTE^XLFDT($P($G(^AUPNVSIT(+$P(SDX,"^",5),0)),"^"))
 . S @SDY@(.06)=$$FMTE^XLFDT($P($G(^SCE(+$P(SDX,"^",6),0)),"^"))
 . S @SDY@(.07)=$$FMTE^XLFDT($P(SDX,"^",7))
 . ;
 . S X=$P(SDX,"^",8)
 . S @SDY@(.08)=$S(X=1:"APPOINTMENT",X=2:"STOP CODE ADDITION",X=3:"DISPOSITION",X=4:"CREDIT STOP CODE",1:"")
 . ;
 . ; S @SDY@(.09)=$P(SDX,"^",9) ; -- extended reference not supported
 . S @SDY@(.1)=$P($G(^SD(409.1,+$P(SDX,"^",10),0)),"^")
 . S @SDY@(.11)=$P($G(^DG(40.8,+$P(SDX,"^",11),0)),"^")
 . S @SDY@(.12)=$P($G(^SD(409.63,+$P(SDX,"^",12),0)),"^")
 . S @SDY@(.13)=$P($G(^DIC(8,+$P(SDX,"^",13),0)),"^")
 ;
 ;
 IF SDFMT="INTERNAL" D  G PARSEQ
 . N SDX S SDX=$G(SDATA(0))
 . S @SDY@(.01)=$P(SDX,"^",1)
 . S @SDY@(.02)=$P(SDX,"^",2)
 . S @SDY@(.03)=$P(SDX,"^",3)
 . S @SDY@(.04)=$P(SDX,"^",4)
 . S @SDY@(.05)=$P(SDX,"^",5)
 . S @SDY@(.06)=$P(SDX,"^",6)
 . S @SDY@(.07)=$P(SDX,"^",7)
 . S @SDY@(.08)=$P(SDX,"^",8)
 . ;S @SDY@(.09)=$P(SDX,"^",9) ; -- extended reference not supported
 . S @SDY@(.1)=$P(SDX,"^",10)
 . S @SDY@(.11)=$P(SDX,"^",11)
 . S @SDY@(.12)=$P(SDX,"^",12)
 . S @SDY@(.13)=$P(SDX,"^",13)
 ;
PARSEQ Q
 ;
 ;
EXAE(DFN,SDBEG,SDEND,SDFLAGS,SDERR) ; -- SDOE FIND FIRST STANDALONE
 ;   API ID: 72
 ;
 N SDOE,SDE,X,SDT,SDQUIT
 S SDOE=""
 ;
 ; -- do validation checks
 IF '$$PAT^SDQVAL(.DFN,$G(SDERR)) G EXAEQ
 IF '$$RANGE^SDQVAL(.SDBEG,.SDEND,$G(SDERR)) G EXAEQ
 ;
 S SDQUIT=0
 S SDT=SDBEG-.000001,SDE=SDEND+$S($P(SDEND,".",2)="":.24,1:"")
 F  S SDT=$O(^SCE("ADFN",DFN,SDT)) Q:'SDT!(SDT>SDE)  D  Q:SDQUIT
 . S SDOE=0 F  S SDOE=$O(^SCE("ADFN",DFN,SDT,SDOE)) Q:'SDOE  D  Q:SDQUIT
 . . S X=$$OE0^SDOEQ(.SDOE)
 . . IF $G(SDFLAGS)["C",'$P(X,"^",7) Q    ; quit if not "C"ompleted
 . . IF $P(X,"^",6) Q                     ; Parents only
 . . IF $P(X,"^",8)'=2 Q                  ; Stop code addition only
 . . S SDQUIT=1                           ; Quit after one hit
 ;
EXAEQ Q SDOE
 ;
 ;
GETLAST(DFN,SDBEG,SDFLAGS,SDERR) ; -- SDOE FIND LAST STANDALONE
 ;   API ID: 75
 ;
 N SDOE,SDE,X,SDT,SDQUIT,SDEND
 S SDOE="",SDEND=9999999
 ;
 ; -- do validation checks
 IF '$$PAT^SDQVAL(.DFN,$G(SDERR)) G GETLASTQ
 IF '$$RANGE^SDQVAL(.SDBEG,.SDEND,$G(SDERR)) G GETLASTQ
 ;
 S SDQUIT=0
 S SDT=SDEND
 F  S SDT=$O(^SCE("ADFN",DFN,SDT),-1) Q:'SDT!(SDT<SDBEG)  D  Q:SDQUIT
 . S SDOE="" F  S SDOE=$O(^SCE("ADFN",DFN,SDT,SDOE),-1) Q:'SDOE  D  Q:SDQUIT
 . . S X=$$OE0^SDOEQ(.SDOE)
 . . IF $G(SDFLAGS)["C",'$P(X,"^",7) Q    ; quit if not "C"ompleted
 . . IF $P(X,"^",6) Q                     ; Parents only
 . . IF $P(X,"^",8)'=2 Q                  ; Stop code addition only
 . . S SDQUIT=1                           ; Quit after one hit
 ;
GETLASTQ Q SDOE
 ;
 ;
EXOE(DFN,SDBEG,SDEND,SDFLAGS,SDERR) ; -- SDOE FIND FIRST ENCOUNTER
 ;   API ID: 74
 ;
 N SDOE,SDE,X,SDT,SDQUIT
 S SDOE=""
 ;
 ; -- do validation checks
 IF '$$PAT^SDQVAL(.DFN,$G(SDERR)) G EXOEQ
 IF '$$RANGE^SDQVAL(.SDBEG,.SDEND,$G(SDERR)) G EXOEQ
 ;
 S SDQUIT=0
 S SDT=SDBEG-.000001,SDE=SDEND+$S($P(SDEND,".",2)="":.24,1:"")
 F  S SDT=$O(^SCE("ADFN",DFN,SDT)) Q:'SDT!(SDT>SDE)  D  Q:SDQUIT
 . S SDOE=0 F  S SDOE=$O(^SCE("ADFN",DFN,SDT,SDOE)) Q:'SDOE  D  Q:SDQUIT
 . . S X=$$OE0^SDOEQ(.SDOE)
 . . IF $G(SDFLAGS)["C",'$P(X,"^",7) Q    ; quit if not "C"ompleted
 . . S SDQUIT=1                           ; Quit after one hit
 ;
EXOEQ Q SDOE
 ;
 ;
VALOE(SDOE,SDERR) ; -- validate sdoe input
 ;
 ; -- do checks
 IF SDOE,$D(^SCE(SDOE,0)) Q 1
 ;
 ; -- build error msg
 N SDIN,SDOUT
 S SDIN("ID")=SDOE
 S SDOUT("ID")=SDOE
 D BLD^SDQVAL(4096800.001,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
VALFMT(SDFMT,SDERR) ; -- validate return format
 ;
 ; -- do checks
 IF SDFMT="EXTERNAL"!(SDFMT="INTERNAL") Q 1
 ;
 ; -- build error msg
 N SDIN,SDOUT
 S SDIN("FORMAT")=SDFMT
 S SDOUT("FORMAT")=SDFMT
 D BLD^SDQVAL(4096800.023,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
