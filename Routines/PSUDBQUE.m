PSUDBQUE ; IHS/ADC/GTH - DOUBLE QUEUING SHELL HANDLER; 04 NOV 1997
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ; XB*3*5 - IHS/ADC/GTH 10-31-97
 ; Thanks to Paul Wesley, DSD, for the original routine.
 ; ---------------------------------------------------------
 ; Programmer documentation included at end of routine - PGMNOTE
 ; ---------------------------------------------------------
 ;
START ;
EN ;PEP for double queuing
 NEW PSU ;     use a fresh array in case of nesting double queues
 ;     insure IO array is set fully
 I ($D(IO)'>10) S IOP="HOME" D ^%ZIS
 I $D(ZTQUEUED) S PSUFQ=1 S:'$D(PSUDTH) PSUDTH="NOW" ;   insure auto-requeue if called from a queued
 I '$D(PSURC),'$D(PSURP) Q  ;                            insure one of RC or RP exist
 I $D(PSUTITLE) S PSU("TITLE")=PSUTITLE K PSUTITLE
 I IO="" S ION="NULL",(IOST,IOM,IOSL)=0
 S PSU("IOP1")=ION_";"_IOST_";"_IOM_";"_IOSL ;           store current IO params
 I $G(IOPAR)]"" S PSU("IOPAR")=IOPAR ;                   store IOPAR
 I $L($G(PSURC))=0 S PSURC="NORC^PSUDBQUE" ;             no compute identified
 S PSU("RC")=PSURC,PSU("RP")=$G(PSURP),PSU("RX")=$G(PSURX)
 ;                                                      load PSUNS="xx;yy;.." into PSU("NS",xx*) ...
 S PSUNS=$TR("PSUNS",",",";") ;                         allow "," seperator
 F PSUI=1:1 S PSUNSX=$P($G(PSUNS),";",PSUI) Q:PSUNSX=""  S:(PSUNSX'["*") PSUNSX=PSUNSX_"*" S PSU("NS",PSUNSX)=""
 S PSU("NS","PSU*")=""
 ;                                                     load PSUNS("xxx") array into PSU("NS","xxx")
 S PSUNSX=""
 F  S PSUNSX=$O(PSUNS(PSUNSX)) Q:PSUNSX=""  S PSU("NS",PSUNSX)=""
 ; if this is a double queue with PSU("IOP") setup .. pull the parameters out
 ; of a ^%ZIS call to set up the parameters without an open
 S PSU("IOP")=$G(PSUIOP)
 I $D(PSUIOP) S IOP=PSUIOP
 ; PSU*3*5 - IHS/ADC/GTH 10-31-97 start block
 I $G(PSU("IOPAR"))]"" S %ZIS("IOPAR")=PSU("IOPAR") D
 . I PSU("IOPAR")'?1"(""".E1""":""".E1""")" Q  ;                skip HFS if not an HFS
 . S PSUHFSNM=$P(PSU("IOPAR"),":"),PSUHFSNM=$TR(PSUHFSNM,"()""")
 . S PSUHFSMD=$P(PSU("IOPAR"),":",2),PSUHFSMD=$TR(PSUHFSMD,"()""")
 . S %ZIS("HFSNAME")=PSUHFSNM,%ZIS("HFSMODE")=PSUHFSMD
 . ;this code drops through
 ; PSU*3*5 - IHS/ADC/GTH 10-31-97 end block
ZIS ;
 KILL IO("Q")
 I $G(PSURC)]"",$G(PSURP)="" G ZISQ
 S %ZIS="PQM"
 D ^%ZIS ;                 get parameters without an open
 I POP W !,"REPORTING-ABORTED",*7 G END1
 S PSU("IO")=IO,PSU("IOP")=ION_";"_IOST_";"_IOM_";"_IOSL,PSU("IOPAR")=$G(IOPAR),PSU("CPU")=$G(IOCPU),PSU("ION")=ION
ZISQ ;
 I '$D(IO("Q")),'$G(PSUFQ) D
 . I $D(ZTQUEUED) S PSUFQ=1 Q
 . I IO=IO(0),$G(PSURP)]"" Q
 . KILL DIR
 . S DIR(0)="Y",DIR("B")="Y",DIR("A")="Won't you queue this "
 . D ^DIR
 . KILL DIR
 . I X["^" S PSUQUIT=1
 . S:Y=1 IO("Q")=1
 . Q
 ;
 KILL PSU("ZTSK")
 I $D(ZTQUEUED),$G(ZTSK) S PSU("ZTSK")=ZTSK
 KILL ZTSK
 ;  quit if user says so
 I $G(PSUQUIT) KILL DIR S DIR(0)="E",DIR("A")="Report Aborted .. <CR> to continue" D ^DIR KILL DIR G END1
 ;
QUE1 ;
 I ($D(IO("Q"))!($G(PSUFQ))) D  K IO("Q") W:(($G(ZTSK))&('$D(PSU("ZTSK")))) !,"Tasked with ",ZTSK W:'$G(ZTSK) !,*7,"Que not successful ... REPORTING ABORTED" D:'$D(ZTQUEUED) ^%ZISC S IOP=PSU("IOP1") D:'$D(ZTQUEUED) ^%ZIS G END1 ;--->
 . ;I '$D(ZTQUEUED),IO=IO(0),$G(PSURP)]"" W !,"Queing to slave printer not allowed ... Report Aborting" Q  ;---^
 . I $D(PSU("TITLE")) S ZTDESC=PSU("TITLE")_" compute"
 . E  S ZTDESC="Double Que COMPUTing  "_PSURC_"  "_$G(PSURP)
 . S ZTIO="",ZTRTN="DEQUE1^PSUDBQUE"
 . S:$D(PSUDTH) ZTDTH=PSUDTH
 . S:$G(PSU("CPU"))]"" ZTCPU=PSU("CPU")
 . S PSUNSX=""
 . F  S PSUNSX=$O(PSU("NS",PSUNSX)) Q:PSUNSX=""  S ZTSAVE(PSUNSX)=""
 . KILL PSURC,PSURP,PSURX,PSUNS,PSUFQ,PSUDTH,PSUIOP,PSUPAR,PSUDTH,PSUNSX,PSUI
 . S ZTIO="" ;                               insure no device loaded
 . D ^%ZTLOAD
 . Q  ; these do .s branch to END1
 ; (((if queued the above code branched to END)))
 ;
DEQUE1 ;> 1st deque
 ;
 KILL PSURC,PSURP,PSURX,PSUNS,PSUFQ,PSUDTH,PSUIOP,PSUPAR,PSUDTH
 KILL PSU("ZTSK")
 I $D(ZTQUEUED),$G(ZTSK) S PSU("ZTSK")=ZTSK
 ;
COMPUTE ;>do computing | routine
 ;
 D @(PSU("RC")) ;  >>>PERFORM THE COMPUTE ROUTINE<<< ;stuffed if not provided with NORC^PSUDBQUE
 ;
QUE2 ;
 ;
 I $D(ZTQUEUED) D  G ENDC ;===>    automatically requeue if queued
 . Q:PSU("RP")=""
 . I $D(PSU("TITLE")) S ZTDESC=PSU("TITLE")_" print"
 . E  S ZTDESC="Double Que PRINT "_PSU("RC")_" "_PSU("RP")
 . S ZTIO=PSU("IO"),ZTDTH=$H,ZTRTN="DEQUE2^PSUDBQUE"
 . S PSUNSX=""
 . F  S PSUNSX=$O(PSU("NS",PSUNSX)) Q:PSUNSX=""  S ZTSAVE(PSUNSX)=""
 . D SETIOPN K ZTIO
 . D ^%ZTLOAD
 . I '$D(ZTSK) S PSUERR="SECOND QUE FAILED" D @^%ZOSF("ERRTN") Q
 . S PSUDBQUE=1
 . Q  ;                     ======>         this branches to ENDC
 ;
 ; device opened from the first que ask
DEQUE2 ;>EP 2nd Deque | printing
 KILL PSU("ZTSK")
 I $D(ZTQUEUED),$G(ZTSK) S PSU("ZTSK")=ZTSK
 ;open printer device for printing with all selected parameters
 G:(PSU("RP")="") END ;---> exit if no print
 ;
 U IO
 D @(PSU("RP")) ; >>>PERFORM PRINTING ROUTINE
 ;
 ;--------
END ;>End | cleanup
 ;
 I $G(PSU("RX"))'="" D @(PSU("RX")) ;   >>>PERFORM CLEANUP ROUTINE<<<
 ;
END0 ;EP - from compute cycle when PSU("RP") EXISTS
 I $D(PSU("ZTSK")) S PSUTZTSK=$G(ZTSK),ZTSK=PSU("ZTSK") D KILL^%ZTLOAD K ZTSK S:$G(PSUTZTSK) ZTSK=PSUTZTSK KILL PSUTZTSK
END1 ;EP clean out PSU as passed in
 D:'$D(ZTQUEUED) ^%ZISC
 S IOP=PSU("IOP1") ; restore original IO parameters
 D:'$D(ZTQUEUED) ^%ZIS
 K IOPAR,IOUPAR,IOP
 KILL PSU,PSURC,PSURP,PSURX,PSUNS,PSUFQ,PSUDTH,PSUIOP,PSUPAR,PSUDTH,PSUERR,PSUI,PSUNSX,PSUQUIT,PSUDBQUE
 ;
 Q
ENDC ;EP - end computing cycle
 I $G(PSU("RP"))="" G END
 G END0
 ;
 ;----------------
 ;----------------
SUB ;>Subroutines
 ;----------
NORC ;used if no PSURC identified
 Q
 ;
SETIOPN ;EP Set IOP parameters with (N)o open
 Q:'$D(PSU("IOP"))
 S IOP=PSU("IOP")
 ; PSU*3*5 - IHS/ADC/GTH 10-31-97 start block
 I $G(PSU("IOPAR"))]"" S %ZIS("IOPAR")=PSU("IOPAR") D
 . I PSU("IOPAR")'?1"(""".E1""":""".E1""")" Q  ;                skip HFS if not an HFS
 . S PSUHFSNM=$P(PSU("IOPAR"),":"),PSUHFSNM=$TR(PSUHFSNM,"()""")
 . S PSUHFSMD=$P(PSU("IOPAR"),":",2),PSUHFSMD=$TR(PSUHFSMD,"()""")
 . S %ZIS("HFSNAME")=PSUHFSNM,%ZIS("HFSMODE")=PSUHFSMD
 . Q
 ; PSU*3*5 - IHS/ADC/GTH 10-31-97 end block
 S %ZIS="N"
 S %H=299
 D ^%ZIS
 Q
PGMNOTE ;
 ;----------------------
 ;NOTES FOR PROGRAMMERS|
 ;----------------------
 ; VARIABLES NEEDED FROM CALLING PROGRAM
 ;
 ;MANDATORY
 ;  Either PSURC=Compute Routine or PSURP=Print Routine.
 ;
 ;OPTIONAL
 ;  PSURC= [label]^routine for code that will collect/compute data
 ;  PSURP= [label]^routine for code that will perform output
 ;  PSURX= [label]^routine for exit processing (clean up variables, etc.) HIGHLY RECOMMENDED.
 ;  PSUNS= namespace(s) of variables to be auto-loaded into ZTSAVE("namespace*")=""
 ;       ="DG;AUPN;PS;..." ; (will add '*'if missing).
 ;     or="DG,AUPN,PS,..." ; (may be semi-colon or comma delimited)
 ;  PSUNS("xxx")="" - ZTSAVE variable arrays where xxx is as described for ZTSAVE("xxxx")="".
 ;  PSUFQ= 1 Force Queueing, =0 Prompt for Queueing
 ;  PSUDTH= Tasking date.time in FM format.
 ;  PSUIOP= pre-selected print device constructed with  ION ; IOST ; IOSL ; IOM
 ;         (mandatory if the calling routine is a queued routine).
 ;  PSUPAR= %ZIS("IOPAR") values for host file with PSUIOP if needed.
 ;
 ;ACTIONS
 ; %ZIS with "PQM" is called by PSUDBQUE if '$D(PSUIOP).
 ;
 ; The user will be asked to queue if queuing has not been
 ; selected.
 ;
 ; IO variables for printing as necessary are automatically stored.
 ;
 ; PSUxx input variables are killed after loading into a PSU array.
 ;
 ; PSUDBQUE can be nested.
 ;
 ; The compute and print phases can call PSUDBQUE individually
 ; (PSUIOP is required).
 ;
 ; The appropriate %ZTSK node is killed.
 ;
 ;EX:
 ; S PSURC="C^AGTEST",PSURP="P^AGTEST",PSURX="END^AGTEST",PSUNS="AG"
 ; D ^PSUDBQUE ;handles foreground and tasking
 ; Q
