SDAMEVT4 ;ALB/MJK - Appt Event Driver Utilities ;12/1/91
 ;;5.3;Scheduling;**28,132**;Aug 13, 1993
 ;
COMP(SDHDL,SDAMEVT) ; -- main entry point for compare
 N SDORG,SDCHG
 S (SDORG,SDCHG)=0
 F  S SDORG=$O(^TMP("SDEVT",$J,SDHDL,SDORG)) Q:'SDORG  D  Q:SDCHG
 .;
 .; -- if overall visit flag is 1
 .;      then set to 1
 .IF $G(^TMP("SDEVT",$J,SDHDL,SDORG,"VISIT CHANGE FLAGS"))[1 S SDCHG=1 Q
 .;
 .; -- if not a credit stop
 .;      and visit flags not set then assume data changed
 .;        then set to 1
 .IF SDORG'=4,$G(^TMP("SDEVT",$J,SDHDL,SDORG,"VISIT CHANGE FLAGS"))="" S SDCHG=1 Q
 .;
 .; -- process orginating types 
 .I SDORG=1 S SDCHG=$$APPT(SDHDL) Q
 .I SDORG=2 S SDCHG=$$AE(SDHDL) Q
 .I SDORG=3 S SDCHG=$$DIS(SDHDL) Q
 .I SDORG=4 S SDCHG=$$CRSC(SDHDL) Q
COMPQ Q SDCHG
 ;
APPT(SDHDL) ; -- appt check
 N SDCHG,NODE
 S SDCHG=$S(SDATA("BEFORE","STATUS")'=SDATA("AFTER","STATUS"):1,1:0)
 I 'SDCHG S SDCHG=$$OE(SDHDL,1)
 I 'SDCHG F NODE="DPT","SC" I $G(^TMP("SDEVT",$J,SDHDL,1,NODE,0,"BEFORE"))'=$G(^("AFTER")) S SDCHG=1 Q
 Q SDCHG
 ;
AE(SDHDL) ; -- add/edit check
 N SDCHG,SDDA,NODE
 S SDCHG=$$OE(SDHDL,2)
 I 'SDCHG,$G(^TMP("SDEVT",$J,SDHDL,2,"STANDALONE",0,"BEFORE"))'=$G(^("AFTER")) S SDCHG=1
 Q SDCHG
 ;
DIS(SDHDL) ; - disposition check
 N SDCHG
 S SDCHG=$$OE(SDHDL,3)
 I 'SDCHG,$G(^TMP("SDEVT",$J,SDHDL,3,"DIS",0,"BEFORE"))'=$G(^("AFTER")) S SDCHG=1
 Q SDCHG
 ;
CRSC(SDHDL) ; -- credit stop code check
 N SDCHG
 S SDCHG=$$OE(SDHDL,4)
 Q SDCHG
 ;
OE(SDHDL,SDORG) ; -- compare encounter data
 N SDCHG,SDI,NODE,SDOE
 S (SDOE,SDCHG)=0
 F  S SDOE=$O(^TMP("SDEVT",$J,SDHDL,SDORG,"SDOE",SDOE)) Q:'SDOE  D  Q:SDCHG
 .I $G(^TMP("SDEVT",$J,SDHDL,SDORG,"SDOE",SDOE,0,"BEFORE"))'=$G(^("AFTER")) S SDCHG=1 Q
 .F NODE="CL" S SDI=0 D  Q:SDCHG
 ..F  S SDI=$O(^TMP("SDEVT",$J,SDHDL,SDORG,"SDOE",SDOE,NODE,SDI)) Q:'SDI  D  Q:SDCHG
 ...I $G(^TMP("SDEVT",$J,SDHDL,SDORG,"SDOE",SDOE,NODE,SDI,0,"BEFORE"))'=$G(^("AFTER")) S SDCHG=1
OEQ Q SDCHG
 ;
 ; -- SEE SDAMEVT0 FOR DOC ON VARIABLES
 ;
MODE(SDHDL) ; -- can event talk
 N Y S Y=""
 I $D(ZTQUEUED) S Y=2 ; -- queued job
 I Y="",IO'=IO(0) S Y=2 ; -- not home device
 S:Y="" Y=$G(SDMODE)
 Q $S(Y=0:"DIALOGUE",Y=1:"MONOLOGUE",Y=2:"QUIET",1:"QUIET")
 ;
MESSAGE(MESSAGE,SDHDL) ; -- show message to user if ok
 N SDSENT
 I $$MODE()["LOGUE" W !!,MESSAGE S SDSENT=1
 Q $G(SDSENT)
 ;
CHANGE(SDHDL,SDORG,SDFLAGS) ; -- set visit change flags value
 S ^TMP("SDEVT",$J,+$G(SDHDL),+$G(SDORG),"VISIT CHANGE FLAGS")=$G(SDFLAGS)
 Q
 ;
