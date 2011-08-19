GMRCPSL1 ;SLC/MA - Special Consult Reports;9/21/01  05:25 ;1/10/02  14:26
 ;;3.0;CONSULT/REQUEST TRACKING;**23,22**;DEC 27, 1997
 ; This is the main entry routine for the Consult Reports that
 ; allow a user to search for consults by:  Provider, Location,
 ; or Procedure.  Also the user may select a date range and
 ; Consult status.
 ; The routines will not let the user search on any Inter-Facility
 ; information but will will use IFC when local fields are not present
EN ;
 ; GMRCARRY = used for entering more than one search value.
 ;            This array will be used by all the diff searches.
 ; GMRCDT1  = Start date
 ; GMRCDT2  = Stop date
 ; GMRCEND  = If equal to one end routine
 ; GMRCSRCH = Indicates which field to search on
 ; GMRCSTAT = Indicates which CPRS status to include
 ; GMRCRPT  = 80 - 132 character report & data only output
 ; GMRCBRK  = Print page break between sub-totals <Y-N>
 N GMRCDT1,GMRCDT2,GMRCARRY,GMRCSRCH,GMRCEND,GMRCSTAT,GMRCRPT,GMRCBRK
 N GMRCQUIT
 S (GMRCBRK,GMRCQUIT,GMRCEND)=0
 S GMRCSRCH=$$GETSRCH                  ; Get search sequence
 I GMRCSRCH=1 D                        ; Get Provider
 . D GETPROV(.GMRCARRY) D
 . . I '$D(GMRCARRY(1)) D WARNING
 ;
 I GMRCSRCH=2 D                        ; Get Location
 . D GETLOC(.GMRCARRY) D
 . . I '$D(GMRCARRY(1)) D WARNING
 ;
 I GMRCSRCH=3 D                        ; Get Procedure
 . D GETPROC(.GMRCARRY) D
 . . I '$D(GMRCARRY) D WARNING
 I GMRCEND=1 K GMRCEND Q
 S GMRCRPT=$$TYPERPT Q:GMRCRPT=0       ; Get type or print
 I GMRCRPT'=3 S GMRCBRK=$$PAGEBRK      ; Break between sub-totals
 I GMRCBRK>1 Q
 D GETDATE I GMRCQUIT Q                ; Get Date
 I '$D(GMRCDT2) Q
 S GMRCDT2=GMRCDT2+1
 ;
 ;
 S GMRCSTAT=$$STS^GMRCPC1 Q:'GMRCSTAT  ; Get search CPRS status
 ;
 I GMRCRPT=0 Q
 ;
 D DEVICE                              ; Get printer device
 ;
 ; At this point all user input has been collected
 ;
 I $D(IO("Q")) D QUEUE Q
 ;
 ; Go build ^TMP("GMRCRPT",$J) using user input variables &
 ; write report
 D PRINT^GMRCPSL2(GMRCSRCH,.GMRCARRY,GMRCDT1,GMRCDT2,GMRCSTAT,GMRCRPT,GMRCBRK)  ;Report writer
 KILL DIR,DIC,^TMP("GMRCRPT",$J)
 Q
 ;
CHECK(GMRCDAT)  ;CHECK FREE TEXT INPUT 
 N %DT,X,Y
 I $E("ALL DATES",1,$L(GMRCDAT))=$$UP^XLFSTR(GMRCDAT) Q "ALL"
 S %DT="E",X=GMRCDAT D ^%DT I Y<1 Q 0
 Q +Y
 I '$D(GMRCDT1) Q
 I GMRCDT1="ALL" S GMRCDT1=0000000,GMRCDT2=9999999
 Q
DEVICE  ; device for printout of entries to group update
 N %ZIS,POP
 I GMRCRPT=2 D
 . W !!,"You must configure your terminal so that it"
 . W " will support 132 character"
 . W !,"emulation and reply 132 to the right margin setting if"
 . W " using HOME"
 . W !,"as the device."
 . W !,""
 I GMRCRPT=3 D
 . W !!,"OK, you have selected a TABLE output format."
 . W !,"You must use your personal computer's terminal emulation"
 . W !,"to capture the output:"
 . W !,""
 . W !,"     1.  Enter at the DEVICE: HOME// prompt "";250;99999999"
 . W !,"         and do not hit the enter key."
 . W !,"     2.  Open a capture file within your terminal emulation program."
 . W !,"     3.  Hit enter to start the down load."
 . W !,"     4.  Close the capture file when the output stops."
 . W !,""
RETRY ;
 S %ZIS="MQ"
 D ^%ZIS
 I POP S GMRCEND=1 Q
 Q
 ;
GETDATE ;Get START and STOP dates
 ;GMRCDT1=Start date
 ;GMRCDT2=Stop date
 N DTOUT,DIR,DUOUT,DIRUT,X,Y
GETDATE1 ;
 S DIR(0)="FA^1:45",DIR("A")="List From Starting Date (ALL): "
 S DIR("B")="T-30" D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S GMRCQUIT=1 Q
 S GMRCDT1=$$CHECK(X)
 I 'GMRCDT1,GMRCDT1'="ALL" G GETDATE1
 I GMRCDT1="ALL" S GMRCDT1=0,GMRCDT2=9999999 Q
 K DIR
 S DIR(0)="DAO^::E",DIR("A")="List To This Ending Date: " D ^DIR
 I $D(DTOUT)!($D(DUOUT)) K GMRCDT1,GMRCDT2 Q
 I +Y=0 W "(NOW)" S GMRCDT2=$$DT^XLFDT Q
 I +Y<GMRCDT1 S GMRCDT2=GMRCDT1,GMRCDT1=+Y
 S:'$D(GMRCDT2) GMRCDT2=+Y
 Q
 ;
 ; Get a Location
GETLOC(GMRCARRY) ;
 ; DBIA 10040 call DIC=44
 N DIC,DIR,DIRUT,DUOUT,DTOUT,X,Y,GMRCCNTR,GMRCQLOC
 S GMRCCNTR=0
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Enter 'YES' if you want all LOCATIONS"
 W !,""
 D ^DIR
 W !,""
 I Y=1 S GMRCARRY(1)="ALL"
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SA^L:LOCAL;R:REMOTE;B:BOTH LOCAL AND REMOTE LOCATIONS"
 S DIR("A")=$S($D(GMRCARRY):"All ",1:"")_"(L)ocal, (R)emote, or (B)oth Local and Remote Locations: "
 S DIR("B")="Local"
 S DIR("?")="^D HELP^GMRCPSL1"
 D ^DIR I $D(DIRUT) S GMRCEND=1 Q
 S GMRCARRY=Y
 Q:$D(GMRCARRY(1))
 W !
 I "LB"[GMRCARRY D
 . S DIC=44,DIC(0)="AEMQ",DIC("A")="ENTER Local LOCATION: "
 . F  D ^DIC Q:$D(DUOUT)!($D(DTOUT))!(Y<0)  D
 . .  S GMRCCNTR=GMRCCNTR+1
 . .  S GMRCARRY(GMRCCNTR)=Y_"^"_44
 I "B"[GMRCARRY W !
 I "RB"[GMRCARRY D
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="PO^4:EMQ"
 . S DIR("S")="I $$STA^XUAF4(+Y)=+$$STA^XUAF4(+Y)"
 . S DIR("A")="ENTER Remote LOCATION"
 . S DIR("?")="For this report, Institution file (#4) entries are considered Remote locations."
 . F  D ^DIR S:$D(DTOUT) GMRCEND=1 S:$D(DUOUT) GMRCEND=1 Q:$D(DIRUT)  D
 . . S GMRCCNTR=GMRCCNTR+1
 . . S GMRCARRY(GMRCCNTR)=Y_"^"_4
 Q
 ;
 ; Get a Procedure
GETPROC(GMRCARRY) ;
 N DIC,DIR,DIRUT,DUOUT,DTOUT,X,Y,GMRCCNTR,GMRCQPRC
 S GMRCCNTR=0
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Enter 'YES' if you want all PROCEDURES"
 W !,""
 D ^DIR
 W !,""
 I Y=1 S GMRCARRY(1)="ALL"  Q
 S DIC=123.3,DIC(0)="AEMQ",DIC("A")="ENTER PROCEDURE: "
 F  D ^DIC Q:$D(DUOUT)!($D(DTOUT))!(Y<0)  D
 .  S GMRCCNTR=GMRCCNTR+1
 .  S GMRCARRY(GMRCCNTR)=Y
 Q
 ;
 ; Get a Provider name
GETPROV(GMRCARRY) ;
 ; DBIA 10060 call DIC=200
 N DIC,DIRUT,DUOUT,DTOUT,X,Y,GMRCCNTR,GMRCQPRV
 S GMRCCNTR=0
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Enter 'YES' if you want all PROVIDERS"
 W !,""
 D ^DIR
 W !,""
 I Y=1 S GMRCARRY(1)="ALL"
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SA^L:LOCAL;R:REMOTE;B:BOTH LOCAL AND REMOTE PROVIDERS"
 S DIR("A")=$S($D(GMRCARRY):"All ",1:"")_"(L)ocal, (R)emote, or (B)oth Local and Remote Providers: "
 S DIR("B")="Local"
 S DIR("?")="^D HELP^GMRCPSL1"
 D ^DIR I $D(DIRUT) S GMRCEND=1 Q
 S GMRCARRY=Y
 Q:$D(GMRCARRY(1))
 W !
 I "LB"[GMRCARRY D
 . S DIC=200,DIC(0)="AEMQ",DIC("A")="ENTER Local PROVIDER: "
 . F  D ^DIC Q:$D(DUOUT)!($D(DTOUT))!(Y<0)  D
 . .  S GMRCCNTR=GMRCCNTR+1
 . .  S GMRCARRY(GMRCCNTR)=Y_"^"_200
 I "B"[GMRCARRY W !
 I "RB"[GMRCARRY D
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="FO^2:40^D UP^GMRCA2 K:'$D(^GMR(123,""AIP"",X)) X"
 . S DIR("?")="^D HELPR^GMRCIR,HELPR^GMRCPSL1"
 . S DIR("A")="ENTER Remote PROVIDER"
 . F  D ^DIR S:$D(DTOUT) GMRCEND=1 S:$D(DUOUT) GMRCEND=1 Q:$D(DIRUT)  D
 . . D UP^GMRCA2 S Y=X
 . . S GMRCCNTR=GMRCCNTR+1
 . . S GMRCARRY(GMRCCNTR)=Y
 Q
HELP ; Help for location and provider prompts
 W !!?3,"""Local"" refers to non-Inter-facility requests and Inter-"
 W !?3,"facility requests originating locally."
 W !?3,"""Remote"" only refers to Inter-facility requests originating"
 W !?3,"at another site."
 Q
HELPR ; Help for remote provider prompt
 W:$Y>(IOSL-4) @IOF
 W !!?3,"Enter the ENTIRE name in proper CASE, exactly as it"
 W !?3,"appears in the above list (including any credentials)."
 W !?3,"Use copy/paste to avoid typing errors."
 W !?3,"NO partial matches are done."
 W !
 Q
GETSRCH() ;   What search criteria should report be in???
 N DIR,Y,X
 S DIR("A",1)="Enter Search criteria:"
 S DIR("A",2)=""
 S DIR("A",3)="                  1 = Sending Provider"
 S DIR("A",4)="                  2 = Location"
 S DIR("A",5)="                  3 = Procedure"
 S DIR("A",6)=""
 S DIR("A")="Search criteria"
 S DIR("B")=1
 S DIR(0)="NO^1:3"
 D ^DIR
 I ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)) S GMRCEND=1
 Q Y
 ;
PAGEBRK() ; Does user want page breaks between sub-totals?
 N DIR
 S DIR(0)="Y"
 S DIR("A")="Display sort sequence & page breaks between sub-totals"
 S DIR("B")="YES"
 D ^DIR I $D(DIRUT) Q 2
 Q +Y
TYPERPT() ; Get type of report to print
 N DIR
 S DIR(0)="SO^1:80 column;2:132 column;3:Table Export"
 S DIR("L",1)="Please select an output format from the following:"
 S DIR("L",2)=""
 S DIR("L",3)="1 -  80 column standard print [STANDARD]"
 S DIR("L",4)="2 - 132 column standard print"
 S DIR("L")="3 - Table without headers (export to another application)"
 S DIR("B")=1
 D ^DIR I $D(DIRUT)!(Y>3) Q 0
 Q +Y
 ;
QUEUE   ; send task for print and update
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTSK
 S ZTRTN="PRTTSK^GMRCPSL2",ZTDESC="PRINT OF RECORDS FILE 123"
 S ZTIO=ION
 S ZTSAVE("GMRC*")=""
 D ^%ZTLOAD I $G(ZTSK) W !,"Task # ",ZTSK
 I '$G(ZTSK) W !,"Unable to queue report!  Try again later."
 Q
WARNING ; Let user know that they did not enter any data.
 W !!,"No search criteria was entered" H 1
 S GMRCEND=1
 Q
