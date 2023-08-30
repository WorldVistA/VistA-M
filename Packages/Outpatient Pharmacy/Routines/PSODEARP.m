PSODEARP ;ALB/BI - DEA EXPIRATION DATE REPORT ;10/12/22  16:32
 ;;7.0;OUTPATIENT PHARMACY;**667,684,545**;DEC 1997;Build 270
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 ;External reference to sub-file NEW DEA #'S (#200.5321) is supported by DBIA 7000
 Q
 ;
EN  ; Main Routine Entry Point
 N DIROUT,DTOUT,DUOUT,PSOQ,PSOPAGE,POP,PSHEADER,PSCPRSSA,PSOEDS,PSOSCR,PSOOUT,PSOTYP,PSOCPRSU
 S PSOPAGE=0
 W !!,"Report requires 512 Columns"
 S PSOQ=0          ; quit flag
 S PSOCPRSU=""
 ;
 S PSHEADER="Includes: "
 ;
 ; Input Questions
 ;
 ; CPRS System Access {Active, DISUSERed, or Both}
 S DIR(0)="S^A:Active;D:DISUSERed/Terminated;B:Both",DIR("A")="CPRS System Access" D ^DIR K DIR Q:$D(DUOUT)!$D(DTOUT)!$D(DIROUT)
 S PSCPRSSA=Y
 S PSOCPRSU=$$CPRSUSRS(PSCPRSSA) Q:PSOCPRSU<0
 S PSHEADER=PSHEADER_$S(PSOCPRSU:"CPRS ",PSOCPRSU=0:"ALL Eligible ",1:"")
 S PSHEADER=PSHEADER_$S(PSCPRSSA="A":"Active ",PSCPRSSA="D":"DISUSERed/Terminated ",PSCPRSSA="B":"Active, DISUSERed/Terminated, ",1:"")_"and "
 ;
 ; Expiration Date Status {EXPIRED, NO EXP DATE, <30-DAYS, <90-DAYS}
 S DIR(0)="S^E:EXPIRED;N:NO EXP DATE;3:<30-DAYS;9:<90-DAYS",DIR("A")="Expiration Date Status" D ^DIR K DIR Q:$D(DUOUT)!$D(DTOUT)!$D(DIROUT)
 S PSOEDS=Y,PSHEADER=PSHEADER_$S(Y="E":"Expired DEA Number.",Y="N":"No DEA Expiration Date.",Y="3":"DEA Expiring within next 30 days.",Y="9":"DEA Expiring within next 90 days.",1:"")
 D  Q:$G(PSOTYP)="D"  I $G(PSOOUT) Q
 . S PSOTYP=$$TYPE() I $G(PSOOUT) Q
 . I $G(PSOTYP)="D" D DL^PSODEARV I $G(PSOOUT) Q
 . I $G(PSOTYP)="D" D RUN^PSODEARV(PSHEADER,PSCPRSSA,PSOEDS,PSOCPRSU)
 ;
 D DEVICE Q:PSOQ   ; Print to device
 D RUN(PSHEADER,PSCPRSSA,PSOEDS,PSOCPRSU) Q:PSOQ  ; Run Report
 Q
 ;
GUI ; Entry point for ePCS GUI Report
 N %H,PSOQ,PSOPAGE,PSOSCR,PSCPRSSA,PSOEDS,PSOCPRSU
 ; I $G(ECPTYP)="E" D EXPORT,^EPCSKILL Q  ; ePCS not exporting to Excel at this point
 S %H=$H D YX^%DTC S EPCSRDT=Y            ; Date report is run
 S PSOQ=0          ; quit flag
 S PSOPAGE=0
 S PSOSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 S PSOCPRSU=$S(EPCSTYPE="C":1,EPCSTYPE="A":0)
 S PSHEADER="Includes: "
 S PSHEADER=PSHEADER_$S(PSOCPRSU:"CPRS ",PSOCPRSU=0:"ALL Eligible ",1:"")
 ;
 ; CPRS System Access {Active, DISUSERed/Terminated, or Both}
 S PSHEADER=PSHEADER_$S(EPCSCPRS="A":"Active",EPCSCPRS="D":"DISUSERed/Terminated",EPCSCPRS="B":"Active, DISUSERed/Terminated,",1:"")_" and "
 ;
 ; Expiration Date Status {EXPIRED, NO EXP DATE, <30-DAYS, <90-DAYS}
 S PSHEADER=PSHEADER_$S(EPCSSTAT="E":"Expired DEA Number.",EPCSSTAT="N":"No DEA Expiration Date.",EPCSSTAT="3":"DEA Expiring within next 30 days.",EPCSSTAT="9":"DEA Expiring within next 90 days.",1:"")
 ;
 S PSCPRSSA=EPCSCPRS S PSOEDS=EPCSSTAT
 D RUN(PSHEADER,PSCPRSSA,PSOEDS,PSOCPRSU) Q:PSOQ      ; Run Report
 ;I $D(EPCSGUI) D ^EPCSKILL Q    // Kill variables...
 Q
 ;
DEVICE  ; Request Device Information
 N %ZIS,IOP,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP,RTN,VAR
 K IO("Q")
 S %ZIS="QM"
 W ! D ^%ZIS
 I POP S PSOQ=1 Q
 S PSOSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 I $D(IO("Q")) D  S PSOQ=1
 . S RTN=$P($T(+1)," ",1)
 . S ZTRTN="RUN^"_RTN_"(PSHEADER,PSCPRSSA,PSOEDS)"
 . S ZTIO=ION
 . S ZTSAVE("PS*")=""
 . S ZTDESC="DEA EXPIRATION REPORT"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 Q
 ;
COMPILE(PSCPRSSA,PSOEDS,PSOCPRSU,PSOPROB)  ; -- Compile the report lines into the sort global
 N DEAIEN,DEATXT,PSCOUNT1,PSOLINE,PSOTD
 S PSCOUNT1=0
 S DEATXT="" F  S DEATXT=$O(^XTV(8991.9,"B",DEATXT)) Q:DEATXT=""  D
 . S DEAIEN=$O(^XTV(8991.9,"B",DEATXT,0)) Q:'DEAIEN
 . S NPIEN="" F  S NPIEN=$O(^VA(200,"PS4",DEATXT,NPIEN)) Q:'NPIEN  D
 . . K TMP,PSODNOBJ D GETS^DIQ(8991.9,DEAIEN_",","**","","TMP","MSG") M PSODNOBJ=TMP(8991.9,DEAIEN_",")
 . . K TMP,PSONPOBJ D GETS^DIQ(200,NPIEN_",","**","","TMP","MSG") M PSONPOBJ=TMP(200,NPIEN_",")
 . . S (PSOTD,PSONPOBJ(9.2))=$$GET1^DIQ(200,NPIEN_",",9.2,"I"),PSONPOBJ(9.2)=$$FMTE^XLFDT(PSONPOBJ(9.2),"5DZ")
 . . S PSONPOBJ(202)=$$GET1^DIQ(200,NPIEN_",",202,"I"),PSONPOBJ(202)=$$FMTE^XLFDT(PSONPOBJ(202),"5DZ")
 . . S PSODNOBJ(.04)=$$GET1^DIQ(8991.9,DEAIEN_",",.04,"I"),PSODNOBJ(.04)=$$FMTE^XLFDT(PSODNOBJ(.04),"5DZ")
 . . S PSONPOBJ(747.44)=$$GET1^DIQ(200,NPIEN_",",747.44,"I"),PSONPOBJ(747.44)=$$FMTE^XLFDT(PSONPOBJ(747.44),"5DZ")
 . . Q:'$$TEST(.PSODNOBJ,.PSONPOBJ,PSCPRSSA,PSOEDS,NPIEN,PSOCPRSU)
 . . N P200P5321 S P200P5321=$$FIND1^DIC(200.5321,","_NPIEN_",",,DEATXT)
 . . I '$G(P200P5321) S PSODNOBJ(.01)="*PROBLEM*",PSOPROB=$G(PSOPROB)+1
 . . S PSOLINE=""
 . . S PSOLINE=PSOLINE_$$LJ^XLFSTR(PSONPOBJ(9.2),"12T")_"  "               ; TERMINATION DATE       #200,    #9.2
 . . S PSOLINE=PSOLINE_$$LJ^XLFSTR(PSONPOBJ(.01),"33T")_"  "               ; NAME                   #200,    #.01
 . . S PSOLINE=PSOLINE_$$LJ^XLFSTR(PSODNOBJ(.01),"9T")_"  "               ; DEA                    #8991.9, #.01
 . . S PSOLINE=PSOLINE_$$LJ^XLFSTR(PSODNOBJ(.04),"12T")_"  "              ; DEA Expiration Date    #8991.9, #.04
 . . ;S PSOLINE=PSOLINE_$$LJ^XLFSTR(PSONPOBJ(53.2),"9T")_"  "               ; DEA                    #200,    #53.2
 . . ;S PSOLINE=PSOLINE_$$LJ^XLFSTR(PSONPOBJ(747.44),"12T")_"  "            ; DEA Expiration Date    #200,    #747.44
 . . S PSOLINE=PSOLINE_$$LJ^XLFSTR(PSONPOBJ(202),"12T")_"  "               ; LAST SIGN-ON           #200,    #202
 . . S PSOLINE=PSOLINE_$$LJ^XLFSTR(PSONPOBJ(8),"23T")_"  "                 ; TITLE                  #200,    #8
 . . S PSOLINE=PSOLINE_$$LJ^XLFSTR(PSONPOBJ(29),"16T")_"  "                ; SERVICE/SECTION        #200,    #29
 . . S PSCOUNT1=PSCOUNT1+1
 . . S PSOTD=$S(PSOTD:PSOTD,1:1)
 . . S ^TMP($J,"PSODEARP",PSOTD,PSONPOBJ(.01),PSCOUNT1,1)=PSOLINE
 . . ;
 . . D:PSONPOBJ(53.9)'=""
 . . . S PSOLINE=$$LJ^XLFSTR("                         ","21T")             ; INDENT 21 SPACES
 . . . S PSOLINE=PSOLINE_"REMARKS: "_$$LJ^XLFSTR(PSONPOBJ(53.9),"100T")     ; REMARKS FIELD          #200,    #53.9
 . . . S ^TMP($J,"PSODEARP",PSOTD,PSONPOBJ(.01),PSCOUNT1,2)=PSOLINE
 . . ;
 . . S PSOLINE=""                                                          ; BLANK LINE
 . . S ^TMP($J,"PSODEARP",PSOTD,PSONPOBJ(.01),PSCOUNT1,3)=PSOLINE
 Q
 ;
RUN(PSHEADER,PSCPRSSA,PSOEDS,PSOCPRSU)  ; Run Report
 N PSCOUNT2,PSOTD,PSONAME,PSOPROB
 S PSOPROB=0  ; Track orphan x-refs in ^VA(200,"PS1"
 K ^TMP($J,"PSODEARP") ; Clear the temporary accumulator
 D COMPILE(PSCPRSSA,PSOEDS,PSOCPRSU,.PSOPROB)
 U IO
 D HDR(PSHEADER)
 I '$D(^TMP($J,"PSODEARP")) W "There is no Data to Print",!
 S PSOTD=0 F  S PSOTD=$O(^TMP($J,"PSODEARP",PSOTD)) Q:+PSOTD=0  Q:PSOQ  D
 . S PSONAME="" F  S PSONAME=$O(^TMP($J,"PSODEARP",PSOTD,PSONAME)) Q:PSONAME=""  Q:PSOQ  D
 .. S PSCOUNT2=0 F  S PSCOUNT2=$O(^TMP($J,"PSODEARP",PSOTD,PSONAME,PSCOUNT2)) Q:+PSCOUNT2=0  Q:PSOQ  D
 ... W ^TMP($J,"PSODEARP",PSOTD,PSONAME,PSCOUNT2,1),! D CHKP(PSHEADER) Q:PSOQ
 ... I $D(^TMP($J,"PSODEARP",PSOTD,PSONAME,PSCOUNT2,2)) D  Q:PSOQ
 .... W ^TMP($J,"PSODEARP",PSOTD,PSONAME,PSCOUNT2,2),! D CHKP(PSHEADER) Q:PSOQ
 ... W ^TMP($J,"PSODEARP",PSOTD,PSONAME,PSCOUNT2,3),! D CHKP(PSHEADER) Q:PSOQ
 I 'PSOQ,$G(PSOPROB) D
 . W !,"*PROBLEM* INDICATES BAD CROSS REFERENCE IN NEW PERSON FILE.",!,"CONTACT PRODUCT SUPPORT TO RESOLVE.",!
 I $D(EPCSGUI) Q
 I 'PSOSCR W !,@IOF
 D ^%ZISC
 K ^TMP($J,"PSODEARP") ; Clear the temporary accumulator
 Q:PSOQ
 I PSOSCR K DIR("A") S DIR(0)="E" D ^DIR K DIR
 Q
 ;
HDR(PSHEADER)  ; Report header
 N PSOI
 S PSOPAGE=PSOPAGE+1
 W @IOF,?(IOM-83),"DEA Expiration Date Report"
 W !,PSHEADER,?(IOM-45),"     Run Date: ",$$FMTE^XLFDT(DT,"5DZ"),?(IOM-12)," Page: ",PSOPAGE,!
 W !,$$TITLES
 W ! F PSOI=1:1:$S($G(IOM):(IOM-1),1:130) W "-"
 W !
 Q
 ;
CHKP(PSHEADER)  ; Check for End Of Page
 I $Y>(IOSL-4) D:PSOSCR  Q:PSOQ  D HDR(PSHEADER)
 . N X,Y,DTOUT,DUOUT,DIRUT,DIR
 . U IO(0) S DIR(0)="E" D ^DIR K DIR S:$D(DIRUT) PSOQ=2
 . U IO
 Q
 ;
TITLES()  ; -- Create the header TITLES.
 N TITLES
 S TITLES=""
 S TITLES=TITLES_$$LJ^XLFSTR("TERM DATE","12T")_"  "        ; TERMINATION DATE       #200,    #9.2
 S TITLES=TITLES_$$LJ^XLFSTR("NAME","33T")_"  "             ; NAME                   #8991.9, #1.1
 S TITLES=TITLES_$$LJ^XLFSTR("DEA","9T")_"  "               ; DEA                    #8991.9, #.01
 S TITLES=TITLES_$$LJ^XLFSTR("DEA EXP DT","12T")_"  "       ; DEA Expiration Date    #8991.9, #.04
 S TITLES=TITLES_$$LJ^XLFSTR("LAST SIGN-ON","12T")_"  "     ; LAST SIGN-ON           #200,    #202
 S TITLES=TITLES_$$LJ^XLFSTR("TITLE","23T")_"  "            ; TITLE                  #200,    #8
 S TITLES=TITLES_$$LJ^XLFSTR("SERVICE/SECTION","16T")_"  "  ; SERVICE/SECTION        #200,    #29
 Q TITLES
 ;
TEST(PSODNOBJ,PSONPOBJ,PSCPRSSA,PSOEDS,NPIEN,PSOCPRSU)  ; -- Perform the requested test for screening critera
 N DEAEXPDT D DT^DILF("",PSODNOBJ(.04),.DEAEXPDT)
 N RESP,PSOACC S RESP=0
 N PSOTERM,PSOTODAY
 S PSOTERM=$$GET1^DIQ(200,NPIEN,9.2,"I")
 S PSOTODAY=$$DT^XLFDT
 S PSOACC=$$GET1^DIQ(200,NPIEN,2,"I")
 ;
 ; CPRS Provider Active and DEA is expired.
 I PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="E",$$ACTIVE^XUSER(NPIEN),PSODNOBJ(.04)'="",(DEAEXPDT<$$DT^XLFDT()) Q 1  ; Active CPRS Providers Only
 ; All (CPRS and Non-CPRS) Active Providers and DEA is expired
 I 'PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="E",PSONPOBJ(7)'="YES",('PSOTERM!(PSOTERM>PSOTODAY)),PSODNOBJ(.04)'="",(DEAEXPDT<$$DT^XLFDT()) Q 1     ; All Active Providers
 ;
 ; CPRS Provider Active and does not have a DEA expiration date.
 I PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="N",$$ACTIVE^XUSER(NPIEN),PSODNOBJ(.04)="" Q 1   ; Active CPRS Providers Only
 ; All (CPRS and Non-CPRS) Active Provider and does not have a DEA expiration date.
 I 'PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="N",PSONPOBJ(7)'="YES",('PSOTERM!(PSOTERM>PSOTODAY)),PSODNOBJ(.04)="" Q 1      ; All Active Providers
 ;
 ; CPRS Provider Active and DEA is expiring within next 30 days.
 I PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="3",$$ACTIVE^XUSER(NPIEN),PSODNOBJ(.04)'="",DEAEXPDT<$$FMADD^XLFDT(DT,30),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1   ; Active CPRS Providers Only
 ; All (CPRS and Non-CPRS) Active Provider and DEA is expiring within next 30 days.
 I 'PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="3",PSONPOBJ(7)'="YES",('PSOTERM!(PSOTERM>PSOTODAY)),PSODNOBJ(.04)'="",(DEAEXPDT'>$$FMADD^XLFDT(DT,30)),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1      ; All Active Providers
 ;
 ; CPRS Provider Active and DEA expiring within the next 90 days.
 I PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="9",$$ACTIVE^XUSER(NPIEN),PSODNOBJ(.04)'="",DEAEXPDT<$$FMADD^XLFDT(DT,90),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1   ; Active CPRS Providers Only
 ; All (CPRS and Non-CPRS) Active DEA expiring within the next 90 days.
 I 'PSOCPRSU,((PSCPRSSA="A")!(PSCPRSSA="B")),PSOEDS="9",PSONPOBJ(7)'="YES",('PSOTERM!(PSOTERM>PSOTODAY)),PSODNOBJ(.04)'="",(DEAEXPDT'>$$FMADD^XLFDT(DT,90)),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1      ; All Active Providers
 ;
 ; CPRS Provider disusered and DEA is expired.
 I PSOCPRSU,$L(PSOACC),((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="E",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)'="",(DEAEXPDT<$$DT^XLFDT()) Q 1
 ; All (CPRS and Non-CPRS) disusered provider and DEA is expired.
 I 'PSOCPRSU,((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="E",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)'="",(DEAEXPDT<$$DT^XLFDT()) Q 1
 ;
 ; CPRS Provider disusered and does not have a DEA expiration date.
 I PSOCPRSU,$L(PSOACC),((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="N",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)="" Q 1
 ; All (CPRS and Non-CPRS) disusered provider and does not have a DEA expiration date.
 I 'PSOCPRSU,((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="N",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)="" Q 1
 ;
 ; CPRS Provider disusered and DEA is expiring within the next 30 days.
 I PSOCPRSU,$L(PSOACC),((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="3",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)'="",(DEAEXPDT'>$$FMADD^XLFDT(DT,30)),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1
 ; All (CPRS and Non-CPRS) disusered Provider and DEA is expiring within the next 30 days.
 I 'PSOCPRSU,((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="3",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)'="",(DEAEXPDT'>$$FMADD^XLFDT(DT,30)),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1
 ;
 ; CPRS Provider disusered and DEA is expiring within the next 90 days.
 I PSOCPRSU,$L(PSOACC),((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="9",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)'="",(DEAEXPDT'>$$FMADD^XLFDT(DT,90)),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1
 ; All (CPRS and Non-CPRS) disusered and DEA is expiring within the next 90 days.
 I 'PSOCPRSU,((PSCPRSSA="D")!(PSCPRSSA="B")),PSOEDS="9",((PSONPOBJ(7)="YES")!(PSOTERM&(PSOTERM<PSOTODAY))),PSODNOBJ(.04)'="",(DEAEXPDT'>$$FMADD^XLFDT(DT,90)),DEAEXPDT>$$FMADD^XLFDT(DT,-1) Q 1
 ;
 Q RESP
 ;
TYPE() ;Prompt for report format or delimited list
 N PSOTYP
 S PSOTYP=""
 W ! K DIR,Y S DIR(0)="S^R:Report;D:Delimited File"
 S DIR("?",1)="Enter 'R' to see the output in a report format,"
 S DIR("?")="enter 'D' for a delimited list that can be exported to Excel."
 S DIR("A")="Select (R)eport or (D)elimited File"
 S DIR("B")="R"
 D ^DIR K DIR I $D(DIRUT) S PSOOUT=1 K DIRUT,DTOUT,DUOUT,DIR,X,Y Q PSOTYP
 S PSOTYP=Y
 K DIRUT,DTOUT,DUOUT,DIR,X,Y
 Q PSOTYP
 ;
CPRSUSRS(STATUS) ; Ask user if they want to constrain report to users with ACCESS CODE (CPRS Users) or ALL (e.g., Comm Care/Non-VA)
 ; Active CPRS System Access only, or ALL active access (i.e., no ACCESS CODE for Community Care/Non-VA providers) 
 N DIR,STATUSE
 S STATUSE=$S($G(STATUS)="A":"Active ",$G(STATUS)="D":"Disusered/Terminated ",1:"")
 S DIR(0)="S^CPRS:CPRS "_STATUSE_"Providers Only;ALL:ALL Eligible "_STATUSE_"Providers",DIR("A")="Type of System Access"
 S DIR("?",1)="If CPRS is selected, only providers with an ACCESS CODE are displayed."
 S DIR("?")="If ALL is selected, providers with and without an ACCESS CODE are displayed."
 D ^DIR K DIR Q:$D(DUOUT)!$D(DTOUT)!$D(DIROUT) -1
 Q $S(Y="CPRS":1,Y="ALL":0,1:-1)
