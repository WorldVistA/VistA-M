PSOCPBK1 ;BIR/EJW,GN-Tally unbilled Automated-release refill copays ;8/10/05 12:50pm
 ;;7.0;OUTPATIENT PHARMACY;**215**;DEC 1997
 ;External reference to ^XUSEC supported by DBIA 10076
 ;External reference to IBARX supported by DBIA 125
 ;External reference to $$PROD^XUPROD(1) supported by DBIA 4440
 ;
 N DTOUT,DUOUT,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC
 I '$D(XPDQUES("POS1")) D  Q:'ZTDTH
 .K DIR
 .S DIR("A")="Enter when to Queue the Tally job to run in date@time format "
 .S DIR("B")="NOW"
 .S DIR(0)="D^::%DT"
 .S DIR("?")="Enter when to start the job. The default is Now. You can enter a date and time in the format like this: 081505@3:30p"
 .D ^DIR I $D(DTOUT)!($D(DUOUT)) W !,"Halting..." S ZTDTH="" Q
 .S ZTDTH=$$FMTH^XLFDT(Y)
 ;
 I $D(XPDQUES("POS1")) S ZTDTH=$$FMTH^XLFDT(XPDQUES("POS1"))
 ;
 D BMES^XPDUTL("===================================================")
 D MES^XPDUTL("Queuing background job to tally unbilled refills...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 D MES^XPDUTL("===================================================")
 L +^XTMP($$NAMSP):0 I '$T D  Q
 . I ZTDTH="" D BMES^XPDUTL("Tally job is already running.  Halting...")
 L -^XTMP($$NAMSP)
 S ZTRTN="EN^PSOCPBK1",ZTIO=""
 S ZTDESC="Background job to tally unbilled copays for refills via OPAI"
 D ^%ZTLOAD
 D:$D(ZTSK)
 .D BMES^XPDUTL("=========================")
 .D MES^XPDUTL("Task #"_ZTSK_" Queued!")
 .D MES^XPDUTL("=========================")
 .D BMES^XPDUTL("")
 D BMES^XPDUTL("")
 K XPDQUES
 Q
EN ;
 N NAMSP S NAMSP=$$NAMSP
 ;if can't get Lock, then already running.
 L +^XTMP(NAMSP):3 I '$T S:$D(ZTQUEUED) ZTREQ="@" Q
 ;if got a lock then must be fresh start, kill possible old Xtmp
 K ^XTMP(NAMSP)
 N PSODT,RXP,PSOTEXT,XX,YY,PSOCNT,PSOSTART,PSOEND,PSOVETS,PSOTRX,XIEN
 N PSOSCMX,PSODFN,PSOREL,PSOAMT,FOUND,V24,PSOTRF,PSOEND2,PSOSTRT2,QQ
 N PSOTIME,PSOSTNM,PSOS1,PSOINST,I,PSOTC,PSOCNTS,LIN,%,X1,XMY,STOP
 D NOW^%DTC S (Y,PSOS1)=% D DD^%DT S PSOSTART=Y
 S PSOSTRT2=$$FMTE^XLFDT(%,"1PS")
 I '$G(DT) S DT=$$DT^XLFDT
 I '$D(^XTMP(NAMSP)) S X1=DT D C^%DTC S ^XTMP(NAMSP,0)=$G(X)_"^"_DT_"^Tally of unbilled copays for refills via OPAI, PSO*7*215"
 ;
 ;get 1st occurence of install date of patch PSO*7*156 (OPAI)
 S XIEN=+$O(^XPD(9.7,"B","PSO*7.0*156",0))
 S PSODT=+$P($G(^XPD(9.7,XIEN,1)),"^",3)
 I 'PSODT S ^XTMP(NAMSP,0,.1)="OPAI PATCH PSO*7*156 IS NOT INSTALLED" D MAIL3^PSOCPBK2(^XTMP(NAMSP,0,.1)) Q
 ;
 ;check if any division is on v2.4 (OPAI interface)
 S V24=0
 F XX=0:0 S XX=$O(^PS(59,XX)) Q:'XX  D  Q:V24
 . S:+$G(^PS(59,XX,"DISP"))=2.4 V24=1
 I 'V24 D  Q
 . S ^XTMP(NAMSP,0,.2)="OPAI IS INSTALLED BUT IS NOT TURNED ON"
 . D MAIL3^PSOCPBK2(^XTMP(NAMSP,0,.2))
 ;
 S (PSOTRX,PSOTRF)=1
 K ^XTMP(NAMSP,0,"STOP") S STOP=0                 ;init stop flag to 0
 F QQ=1:1 S PSODT=$O(^PSRX("AL",PSODT)) Q:'PSODT  D  Q:STOP
 .I QQ#100=0,$D(^XTMP(NAMSP,0,"STOP")) K ^XTMP(NAMSP) S STOP=1 Q
 .S RXP=""
 .F PSOTRX=PSOTRX+1:1 S RXP=$O(^PSRX("AL",PSODT,RXP)) Q:'RXP  D
 ..;save last date & fill info
 ..S ^XTMP(NAMSP,0,"LAST")=PSODT_"^"_RXP_"^"_PSOTRX
 ..S PSODFN=$P($G(^PSRX(RXP,0)),"^",2)
 ..Q:('PSODFN)!('$D(^DPT(PSODFN,0)))         ;quit, no valid DFN info
 ..D XTYPE
 ..Q:+PSOSCMX=0                              ;quit, Exempt or deceased
 ..;search refills only, ignore 0=orig fill
 ..F YY=0:0 S YY=$O(^PSRX("AL",PSODT,RXP,YY)) Q:'YY  D ADDBILL
 Q:STOP
 ;
 S PSOCNT=0
 D TALLY^PSOCPBK2 Q:STOP
 D TOTAL
 D MAIL
 D MAIL2
 L -^XTMP(NAMSP)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
ADDBILL ;add to billable ^XTMP if ok, quit if not
 S PSOTRF=PSOTRF+1
 S PSOREL=$P($G(^PSRX(RXP,1,YY,0)),"^",18)
 Q:'PSOREL                                   ;not released
 Q:'YY                                       ;orig fill
 Q:+$$RXST^IBARXEU(PSODFN,$P(PSOREL,"."))    ;Exempt on Rel dte
 ;check refill
 Q:$P($G(^PSRX(RXP,1,YY,"IB")),"^",1)'=""    ;already billed
 Q:$P($G(^PSRX(RXP,1,YY,"IB")),"^",2)'=""    ;exceeded ann. cap
 ;
 ;look for Activity log entry per refill # with the below text
 S FOUND=0
 F XX=999:0 S XX=$O(^PSRX(RXP,"A",XX),-1) Q:'XX  D  Q:FOUND
 .Q:$P(^PSRX(RXP,"A",XX,0),"^",4)'=YY
 .Q:^PSRX(RXP,"A",XX,0)'["External Interface Dispensing is Complete"
 .S FOUND=1
 Q:'FOUND
 ;
 S ^XTMP(NAMSP,PSODFN,RXP,YY)=$P(PSOREL,".")  ;add to XTMP to be bill
 Q
 ;
MAIL ;
 N TOTAMT,PSOCXPDA
 D NOW^%DTC S Y=% D DD^%DT S PSOEND=Y
 S PSOEND2=$$FMTE^XLFDT(%,"1PS")
 I $G(DUZ) S XMY(DUZ)=""
 S XMDUZ="Outpatient Pharmacy",XMSUB="Outpatient Pharmacy Copay Tally"
 F PSOCXPDA=0:0 S PSOCXPDA=$O(^XUSEC("PSO COPAY",PSOCXPDA)) Q:'PSOCXPDA  S XMY(PSOCXPDA)=""
 I $O(XMY(""))="" Q  ; no recipients for mail message
 S PSOTEXT(1)="The Rx copay tally job for the Outpatient Pharmacy patch (PSO*7*215)"
 S PSOTEXT(2)="started "_PSOSTART_" and completed "_PSOEND_"."
 I PSOCNT=0 S PSOTEXT(3)="No released unbilled copay fills were found."
 I PSOCNT>0 D
 .S TOTAMT=0
 .F XX="YR2004","YR2005" D
 ..F YY=1:1:3 S PSOAMT(XX,YY)=PSOCNT(XX,YY)*YY*7,TOTAMT=TOTAMT+PSOAMT(XX,YY)
 .S PSOTEXT(3)="Auto-Released refills have now been marked as potentials for back billing."
 .S PSOTEXT(4)="There were "_$FN(PSOCNT,",")_" fills successfully tallied for "_$FN(PSOVETS,",")_" veterans."
 .S PSOTEXT(5)=" "
 .S PSOTEXT(6)="Fills eligible for back-billing by year:"
 .S PSOTEXT(7)="2004  30-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2004",1),6)
 .S PSOTEXT(7)=PSOTEXT(7)_"     $"_$J($FN(PSOAMT("YR2004",1),","),9)
 .S PSOTEXT(8)="2004  60-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2004",2),6)
 .S PSOTEXT(8)=PSOTEXT(8)_"     $"_$J($FN(PSOAMT("YR2004",2),","),9)
 .S PSOTEXT(9)="2004  90-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2004",3),6)
 .S PSOTEXT(9)=PSOTEXT(9)_"     $"_$J($FN(PSOAMT("YR2004",3),","),9)
 .S PSOTEXT(10)=""
 .S PSOTEXT(11)="2005  30-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2005",1),6)
 .S PSOTEXT(11)=PSOTEXT(11)_"     $"_$J($FN(PSOAMT("YR2005",1),","),9)
 .S PSOTEXT(12)="2005  60-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2005",2),6)
 .S PSOTEXT(12)=PSOTEXT(12)_"     $"_$J($FN(PSOAMT("YR2005",2),","),9)
 .S PSOTEXT(13)="2005  90-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2005",3),6)
 .S PSOTEXT(13)=PSOTEXT(13)_"     $"_$J($FN(PSOAMT("YR2005",3),","),9)
 .S PSOTEXT(14)="                                          =========="
 .S PSOTEXT(15)="                                    TOTAL $"_$J($FN(TOTAMT,","),9)
 .S PSOTEXT(16)=" "
 .S PSOTEXT(17)="To get a report of patients/prescriptions that were identified as potentially"
 .S PSOTEXT(18)="billable as part of this Tally, enter D RPT^PSOCPBK2 at the programmer's prompt"
 S XMTEXT="PSOTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
 ;
MAIL2 ;
 S LIN="",$P(LIN," ",80)=""
 D NOW^%DTC S PSOTIME=$$FMDIFF^XLFDT(%,$G(PSOS1),2)
 S PSOINST=$P($G(^DIC(4,+$P($G(^XMB(1,1,"XUS")),"^",17),99)),"^")
 S PSOSTNM=$P($G(^DIC(4,PSOINST,0)),"^")
 K PSOTEXT
 S XMY(DUZ)="",PSOTC=0,PSOCNTS=""
 F J="YR2004","YR2005" F I=1:1:3 D
 .S PSOTC=PSOTC+PSOCNT(J,I)
 .S PSOCNTS=PSOCNTS_","_PSOCNT(J,I)
 S XMY("NAPOLIELLO.GREG@FORUM.VA.GOV")=""
 S XMY("WHITE.ELAINE@FORUM.VA.GOV")=""
 S:$$PROD^XUPROD(1) XMY("WILLIAMSON.ERIC@FORUM.VA.GOV")=""
 S XMDUZ="PSO*7*215 TALLY"
 S XMSUB="STATION "_$G(PSOINST)
 S XMSUB=XMSUB_$S($$PROD^XUPROD(1):"(Prod)",1:"(Test)")
 S XMSUB=XMSUB_" UNBILLED COPAYS FOR PRESCRIPTION REFILLS"
 S PSOTEXT(1)="               Start time: "_PSOSTRT2
 S PSOTEXT(2)="           Completed time: "_PSOEND2
 S PSOTEXT(3)="             Elapsed Time: "_$$ETIME^PSOCPBK2(PSOTIME)
 S PSOTEXT(4)=""
 S PSOTEXT(5)="     Total RX's processed: "_$J($FN(PSOTRX,","),8)
 S PSOTEXT(6)="  Total Refills processed: "_$J($FN(PSOTRF,","),8)
 S PSOTEXT(7)="   Total billable refills: "_$J($FN(PSOTC,","),8)
 S PSOTEXT(8)="      Total billable vets: "_$J($FN(PSOVETS,","),8)
 S PSOTEXT(9)=""
 S PSOTEXT(10)="Excel comma delimited data below, Two heading, one data line"
 S PSOTEXT(11)=""
 S PSOTEXT(12)="Copy and paste any of the 2 heading & 1 data rows into Excel.  Then click "
 S PSOTEXT(13)="'Data', 'Text to Columns..', check 'Delimited', click Next, check 'Comma',"
 S PSOTEXT(14)="and click Finish"
 S PSOTEXT(15)=""
 S PSOTEXT(16)=$E(("Station,Station,,2004,,,2005"_LIN),1,79)
 S PSOTEXT(17)=$E(("Name,#,30 days,60 days,90 days,30 days,60 days,90 days"_LIN),1,79)
 S PSOTEXT(18)=$E((PSOSTNM_","_PSOINST_PSOCNTS_LIN),1,79)
 S PSOTEXT(19)=""
 S XMTEXT="PSOTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
 ;
XTYPE ;
 N Y,VADM,I,J,X,SAVY,DFN
 S DFN=PSODFN D DEM^VADPT I +$G(VADM(6)) S PSOSCMX="" Q  ; DECEASED
 S (X,PSOSCMX,SAVY)=""
 S J=0 F  S J=$O(^PS(59,J)) Q:'J  I +$G(^(J,"IB")) S X=+^("IB") Q
 I 'X Q
 S X=X_"^"_PSODFN D XTYPE^IBARX
 I $G(Y)'=1 Q
 S J="" F  S J=$O(Y(J)) Q:'J  S I="" F  S SAVY=I,I=$O(Y(J,I)) Q:I=""  S:I>0 PSOSCMX=I
 I PSOSCMX="",SAVY=0 Q  ; INCOME EXEMPT OR SERVICE-CONNECTED
 I PSOSCMX=2 Q  ; NEED TO ASK SC QUESTION
 Q
 ;
TOTAL ;
 N COUNT,COUNTED
 I '$D(PSOVETS) S PSOVETS=0
 N I,J
 F I=1:1:3 S (PSOCNT("YR2004",I),PSOCNT("YR2005",I))=0
 S PSODFN=0 F  S PSODFN=$O(^XTMP(NAMSP,PSODFN)) Q:'PSODFN  D
 .S COUNTED=0
 .F J="YR2004","YR2005" F I=1:1:3 S COUNT=$G(^XTMP(NAMSP,PSODFN,J,I)) I COUNT>0 S:'$G(COUNTED) COUNTED=1,PSOVETS=PSOVETS+1 S PSOCNT(J,I)=PSOCNT(J,I)+COUNT
 F I=1:1:3 S PSOCNT=PSOCNT+PSOCNT("YR2004",I)+PSOCNT("YR2005",I)
 Q
 ;
STATUS ;show status of job running
 I $$ST D
 .W !,"Currently processing:"
 .W !?5,"Released Date > ",+^XTMP($$NAMSP,0,"LAST")
 .W !?5,"         RX # > ",$P(^XTMP($$NAMSP,0,"LAST"),"^",2)
 .W !?5,"   TOTAL RX's > ",$P(^XTMP($$NAMSP,0,"LAST"),"^",3),!
 Q
 ;
STOP ;stop job command
 I $$ST S ^XTMP($$NAMSP,0,"STOP")="" D
 .W !,"Outpatient RX Copay Tally Job - set to STOP Soon"
 .W !!,"Check Status to be sure it has stopped and is not running..."
 .W !,"     (D STATUS^PSOCPBK1)"
 Q
ST() ;status
 L +^XTMP($$NAMSP):3 I $T D  Q 0
 .L -^XTMP($$NAMSP)
 .W !,"*** TALLY NOT CURRENTLY RUNNING! ***",!
 Q 1
NAMSP() ;
 Q $T(+0)
