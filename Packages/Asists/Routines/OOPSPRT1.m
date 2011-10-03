OOPSPRT1 ;HINES/WAA-Utilities Routines ;3/24/98
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
 ; This routine is to display all the report that a person has
 ; access to.
EN1(CALLER) ;
 ; Input:
 ;    Caller O = Safety Officer
 ;           U = Union
 ;           S = Supervisor
 ;           E = Employee
 ; 
 N YEAR,OUT,PAGE,STA,OUTPUT,SSN,HEAD
 ; Patch 5 - added logic to print all stations or 1
 S OUT=0,PAGE=1,OUTPUT=0
 S YEAR=""
 I CALLER="E" D
 .S SSN=$P(^VA(200,DUZ,1),U,9)
 .Q:$D(^OOPS(2260,"SSN",SSN))<1
 .Q
 D RANGE(.YEAR,.OUT)
 I 'OUT D STATION(.STA,.OUT)
 D:'OUT DEVICE
 I 'OUT D:'$D(IO("Q")) PRINT
EXIT ;
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 K IO("Q")
 Q
RANGE(YEAR,OUT) ; This Subroutine will allow the user to select a range.
 ; Output
 ;   YEAR = The year that the user what to print
 ;        = "" all years
 ;
 N DIR,DIRUT,Y
R1 S DIR(0)="NAO^0:9999:0"
 S DIR("A")="Select the Fiscal Year or RETURN for ALL: "
 S DIR("??")="Enter the Fiscal Year that you want to print for or RETURN for data in file"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S OUT=1 Q
 I Y'="",$L(Y)'=4 W !,"You must enter a 4 digit year." G R1
 S YEAR=Y
 I YEAR'="",'$O(^OOPS(2260,"B",(YEAR_"00000"))) W !,"No date for that Fiscal Year please select again." G R1
 Q
STATION(STA,OUT) ;
 S STA=""
 N DIC,DIR,DIRUT,Y
 S DIR(0)="Y",DIR("A")="Run report for 'ALL' Stations",DIR("B")="Yes"
 S DIR("?")="Enter 'Y'es to run for all Stations or 'N'o to run "
 S DIR("?")=DIR("?")_"for just one Station."
 D ^DIR I Y S STA="A" Q
 I $D(DIRUT)!($D(DUOUT)) S OUT=1 Q
S1 ; if get here user <CR>
 S DIC("A")="Select STATION NUMBER: "
 S DIC="^DIC(4,",DIC(0)="AEMQZ"
 D ^DIC K DIC
 I Y=-1 W !?5,"No Station selected, report will not run" S OUT=1 Q
 S STA=+Y
 I '$D(^OOPS(2260,"D",STA)) W !?5,"No data for that Station Number, Please select again." G S1
 Q
DEVICE ; This is the device selection routine.
 ;
 S %ZIS="QM" D ^%ZIS I POP S OUT=1 Q
 I $D(IO("Q")) D  Q
 .S ZTRTN="PRINT^OOPSPRT1",ZTDESC="Print Accident Report Sign-off list"
 .S ZTSAVE("YEAR")="",ZTSAVE("STA")=""   ; Patch 5 - added STA
 .S ZTSAVE("OUT")=""
 .S ZTSAVE("CALLER")=""
 .S ZTSAVE("SSN")=""
 .S ZTSAVE("PAGE")=""
 .S ZTSAVE("OUTPUT")=""
 .D ^%ZTLOAD D HOME^%ZIS Q
 .Q
 Q
PRINT ; This is the main print portion of the routine
 N CNT,LOOP
 S CNT=0
 S LOOP=$S(STA="A":"",1:STA)
 U IO
 I STA'="A" D ONE Q
MAIN ; Main Loop
 F  S LOOP=$O(^OOPS(2260,"D",LOOP)) Q:LOOP=""!OUT  S HEAD=1 D:$D(^OOPS(2260,"D",LOOP)) HEAD Q:OUT  D
 . S IEN=0 F  S IEN=$O(^OOPS(2260,"D",LOOP,IEN)) Q:IEN<1!OUT  D DATA
 Q
ONE ; Only 1 Station Selected
 I $D(^OOPS(2260,"D",LOOP)) D HEAD
 S IEN=0 F  S IEN=$O(^OOPS(2260,"D",LOOP,IEN)) Q:IEN<1!OUT  D DATA
 Q
DATA ; Loop to get & print data
 N CASE,NAME,SSN1,DATE,INC,CAT,YR
 S CASE=$$GET1^DIQ(2260,IEN,.01)
 S YR=$E(CASE,1,4)
 I YEAR,YEAR'=YR Q
 ; Only get OPEN cases - field 51 - 0 = OPEN
 I $$GET1^DIQ(2260,IEN,51,"I") Q
 S INC=$$GET1^DIQ(2260,IEN,52,"I")
 S NAME=$E($$GET1^DIQ(2260,IEN,1,"E"),1,30)
 S SSN1=$$GET1^DIQ(2260,IEN,5,"E")
 S DATE=$$GET1^DIQ(2260,IEN,4,"E")
 S CAT=$$GET1^DIQ(2260,IEN,2,"I")
 S CNT=CNT+1
 I CALLER="E" Q:SSN'=SSN1
 I CALLER="S" I ($$GET1^DIQ(2260,IEN,53,"I")'=DUZ),($$GET1^DIQ(2260,IEN,53.1,"I")'=DUZ) Q
 S OUTPUT=1
 D HEAD Q:OUT
 W !!,CASE
 W:CALLER'="U" ?12,NAME,?42,SSN1
 W ?57,DATE
 W !,?35,"   CA1   ",?50,"   CA2   ",?65,"  2162   "
 W !,?35,"---------",?50,"---------",?65,"---------"
 D          ; Employee Data
 . N SIGN
 . S SIGN=$$EDSTA^OOPSUTL1(IEN,"E")
 . W !,?20,"EMPLOYEE:"
 . I INC=1 W ?35
 . I INC=2 W ?50
 . ; Also, not a Non-PAID Employee either
 . ; Patch 5 - logic changed for new Personnel Categories
 . I '$$ISEMP^OOPSUTL4(IEN) W "N/A(",$E($$GET1^DIQ(2260,IEN,2,"E"),1,7),")" Q
 . W $S($P(SIGN,U,INC):" ",1:"UN-"),"SIGNED"
 . Q
 Q:CALLER="E"
 D           ; Supervisor Data
 . N SIGN
 . S SIGN=$$EDSTA^OOPSUTL1(IEN,"S")
 . W !,?20,"SUPERVISOR:"
 . I INC=1 W ?35
 . I INC=2 W ?50
 .;Also not a Non-Paid Employee either
 .; Patch 5 - See above
 . I '$$ISEMP^OOPSUTL4(IEN) W "N/A(",$E($$GET1^DIQ(2260,IEN,2,"E"),1,7),")"
 . E  W $S($P(SIGN,U,INC):" ",1:"UN-"),"SIGNED"
 . W ?65,$S($P(SIGN,U,3):" ",1:"UN-"),"SIGNED"
 . Q
 Q:CALLER="S"
 D           ; Safety Officer Data
 . N SIGN
 . S SIGN=$$EDSTA^OOPSUTL1(IEN,"O")
 . W !,?20,"SAFETY OFFICER:"
 . W ?65,$S($P(SIGN,U):" ",1:"UN-"),"SIGNED"
 . Q
 Q
HEAD ; This is the head portion of the routine
 I PAGE=1 D
 .W:$E(IOST,1,2)="C-" @IOF
 .Q
 I PAGE'=1 Q:($Y<(IOSL-6)&('HEAD))
 I $E(IOST,1,2)="C-" D  Q:OUT
 .I PAGE=1 W @IOF Q
 .I PAGE'=1 D  Q:OUT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S OUT=1
 ..K Y
 ..Q
 .Q
 Q:OUT
 I PAGE'=1 W @IOF
 N LINER,TAB,LINE2,TAB2
 W !,$$FMTE^XLFDT($$NOW^XLFDT,1),?70,"PAGE: ",PAGE,!
 S LINER="Accident Report Status"_$S(YEAR="":"",1:" for the fiscal Year "_YEAR)
 S TAB=(40-($L(LINER)/2))
 S LINE2="Station Number: "_$$GET1^DIQ(4,LOOP,.01,"E")
 S TAB2=(40-($L(LINE2)/2))
 W ?TAB,LINER,!,?TAB2,LINE2
 W !,"Case No."
 W:CALLER'="U" ?12,"Name",?46,"SSN"
 W ?57,"DATE OF INCIDENT"
 W !,"============================================================================="
 S PAGE=PAGE+1,HEAD=""
 Q
