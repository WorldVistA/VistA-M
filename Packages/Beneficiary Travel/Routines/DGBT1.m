DGBT1 ;ALB/SCK/BLD - BENEFICIARY TRAVEL DISPLAY SCREEN 1; 12/15/92  1/8/93 4/1/93 ; 10/31/05 1:11pm
 ;;1.0;Beneficiary Travel;**11,20**;September 25, 2001;Build 185
 Q
SCREEN ;  clear screen and write headers
 N TOTRIPS,ONEWAY,RT,MONTHDED,WAIVER,WTYPE,TTRIPS,TDED,TFIEN,DGBTOTHER
 D MONTOT(.TOTRIPS,.ONEWAY,.RT,.MONTHDED,.WAIVER,.WTYPE,.TTRIPS,.TDED) Q:$G(DGBTQUIT)
 S DGBTOTHER=0
 W @IOF
 W !?18,"Beneficiary Travel Claim Information <Screen 1>"
 W !!?2,"Claim Date: ",DGBTDTE
 D PID^VADPT6 W !!?8,"Name: ",VADM(1),?40,"PT ID: ",VA("PID"),?64,"DOB: ",$P(VADM(3),"^",2)
 I '$G(CHZFLG)!('$D(^DGBT(392,DGBTDT,"D"))) W !!?5,"Address: ",VAPA(1) W:VAPA(2)]"" !?14,VAPA(2) W:VAPA(3)]"" !?14,VAPA(3) W !?14,VAPA(4),$S(VAPA(4)]"":", "_$P(VAPA(5),"^",2)_"  "_$P(VAPA(11),U,2),1:"UNSPECIFIED")
 I $G(CHZFLG),$D(^DGBT(392,DGBTDT,"D")) D
 .N CLMADD,CLMST
 .S CLMADD=^DGBT(392,DGBTDT,"D")
 .S CLMST=$P(CLMADD,"^",5) S:$G(CLMST)'="" CLMST=$P(^DIC(5,CLMST,0),"^",2)
 .W !!?5,"Address: ",$P(CLMADD,"^",1) W:$P(CLMADD,"^",2)]"" !?14,$P(CLMADD,"^",2) W:$P(CLMADD,"^",3)]"" !?14,$P(CLMADD,"^",3) W !?14,$P(CLMADD,"^",4),$S($P(CLMADD,"^",4)]"":", "_CLMST_"  "_$P(CLMADD,"^",6),1:"UNSPECIFIED")
 W !!?5,$$ADDCHG(DFN)
 ;
SETVAR  ;  if new claim, move in current info for elig, sc%
 I 'CHZFLG S DGBTELG=VAEL(1),DGBTCSC=VAEL(3)
 I +DGBTELG=3,'$E(DGBTCSC)=1 S DGBTCSC=1
 I ($P(DGBTELG,U,2)["NSC")&(DGBTDYFL)&'($G(DGBTREF)) D
 .I +$TR($P(DGBTINC,U),"$,","")<DGBTRXTH S $P(DGBTELG,U,2)=$P(DGBTELG,U,2)_" LOW INCOME"
 W !!," Eligibility: ",$P(DGBTELG,"^",2) W:DGBTCSC ?45,"SC%: ",$P(DGBTCSC,"^",2) ;W !
 I $O(VAEL(1,0))'="" W !," Other Elig.: " F I=0:0 S I=$O(VAEL(1,I)) Q:'I  D
 .W ?14,$P(VAEL(1,I),"^",2),!
 .I VAEL(1,I)["HOUSEBOUND" S DGBTOTHER=1
 .I VAEL(1,I)["AID & ATTENDANCE" S DGBTOTHER=1
 .I VAEL(1,I)["PENSION" S DGBTOTHER=1
 ;
SC ;  service connected status/information
 I DGBTCSC&($P(DGBTCSC,"^",2)'>29) W !!,"Disabilities:" S I3=""
 N DGQUIT
 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I!($G(DGQUIT)=1)  D
 . S I1=^(I,0),I2=$S($D(^DIC(31,+I1,0)):$P(^(0),"^",1)_" ("_+$P(I1,"^",2)_"%-"_$S($P(I1,"^",3):"SC",1:"NSC")_")",1:""),I3=I1
 . I $Y>(IOSL-3) D PAUSE I DGQUIT=0 W @IOF
 . I $G(DGQUIT)=1 Q
 .D
 ..I DGBTCSC&($P(DGBTCSC,"^",2)'>29) Q
 ..I I=$O(^DPT(DFN,.372,0)) W !
 . W ?16 W I2,!
 ;
INCOME ;  income and eligibility information
 ;DAYFLG = NUMBER OF DAYS SINCE LAST MEANS TEST
 N DGBTIFL,DGBTDATA,TESTDATE,DGBTDAYS,DGNOTEST,RXCP,RXCPST,DGRXDATA,RXDAYS,RXCPDATA,RXCPTS,DGBTST,BUSEXP,LOWINC,NOTEST
 ;
 ;
 S DGBTIFL=$P(DGBTINC,U,2)
 S (DAYFLG,RXDAYS,RXCPTS)=""
 ;CHECK HOW DAYS SINCE LAST MEANS TEST
 I $$DAYSTEST(DFN,.DAYFLG,.RXDAYS,.RXCPST,.LOWINC,.DGNOTEST)
 ; 
 S BUSEXP=$$ABP^DGBTUTL(DFN)
 ;
 ;CHANGED FOR DGBT*1*20
 S ELIGTYP=$$GET1^DIQ(8.1,3_",",.01)
 I '$G(DGBTOTHER),'$G(LOWINC),($G(VAEL(3))),$P($G(VAEL(3)),"^",2)<30,($P(VAEL(1),"^",2))=ELIGTYP W !?2,"BT Alert: ELIGIBLE FOR SC APPOINTMENTS ONLY"
 I $G(BUSEXP) D
 .S Y=BUSEXP X ^DD("DD")
 .W !!?2,"BT Alert: BUS PASS ISSUED - EXPIRES ",Y
 ; 
 I (DAYFLG!DGBTINCA),'$G(RXCPST) D  D QUIT Q    ;valid mt in last 365 days + PAVEL
 .W !!?2,"Income: ",$P(DGBTINC,U),DGBTDTY,?35,"Source of Income:  ",$S(DGBTIFL="M":"MEANS TEST",DGBTIFL="C":"COPAY TEST",DGBTIFL="P":"Alt.Income POW",DGBTIFL="H":"Alt. Income Hardship",1:"")
 .W !?2,"No. of Dependents: ",DGBTDEP
 .;
 .I DGBTMTS]"" W:$P(DGBTMTS,"^")'="N" ?40,"MT Status: ",$S($P(DGBTMTS,"^")="R":"REQUIRED",$P(DGBTMTS,"^")="P":$P($P(DGBTMTS,"^",2)," "),DGBTMTS=U!($G(RXCPST)):" NOT APPLICABLE",1:$P(DGBTMTS,"^",2))
 .W:$P(DGBTMTS,"^")="P" !?68,$P($P(DGBTMTS,"^",2)," ",2)
 .I $P(DGBTMTS,"^")="N" W !!?20,"MEANS TEST ",$P(DGBTMTS,"^",2)
 .;
 .W !!?2,"BT Income: ",$S($D(DGBTCA):DGBTCA,1:"NOT RECORDED") W:$D(DGBTCE) ?25,"Certified Eligible: ",$S(DGBTCE:"YES",1:"NO"),?53,"Date Certified: ",$S($D(DGBTCD):DGBTCD,1:"NOT RECORDED")
 .I $D(DGBTCE) I DGBTCE'=1 W *7,*7,!!?8,"* * * NOTE * * PATIENT HAS BEEN CERTIFIED INELIGIBLE BASED ON INCOME"
 .S DGBTINFL="" I $D(DGBTINC),$D(DGBTCA),$P(DGBTINC,U)'=DGBTCA,$P(DGBTMTS,"^")'="N" S DGBTINFL=" * * * * Discrepancy exists in incomes reported, please verify * * * *" W !!?5,DGBTINFL
 .I '$D(DGBTRET(0)) W !,?50,$$WVEXP     ;*DGBT*1.0*20 BLD * E2
 .I $D(DGBTRET(0)),$P(DGBTRET(0),"^",6)'="MAN" W !,?50,$$WVEXP ; /*DGBT*1.0*20 RFE */
 .I $D(DGBTRET(0)),$P(DGBTRET(0),"^",6)="MAN" W !,?52,"WAIVER EXPIRES: ",$P(DGBTRET(0),"^",7)
 .F I=$Y:1:20 W !
 ;
 ;no valid mt test in last 365 days or no test has been done
 I 'DAYFLG D  D QUIT Q
  .W !!?2,"Income: ","",?40,"Source of Income:  ",""
 .W !?2,"No. of Dependents: ",DGBTDEP
 .I DGBTMTS]"" W ?40,"MT Status: ","EXPIRED"
 .W !!?2,"BT Income: ",$S($D(DGBTCA):DGBTCA,1:"NOT RECORDED") W:$D(DGBTCE) ?25,"Certified Eligible: ",$S(DGBTCE:"YES",1:"NO"),?53,"Date Certified: ",$S($D(DGBTCD):DGBTCD,1:"NOT RECORDED")
 .I '$D(DGBTRET(0)) W !,?50,$$WVEXP     ;*DGBT*1.0*20 BLD * E2
 .I $D(DGBTRET(0)),$P(DGBTRET(0),"^",6)'="MAN" W !,?50,$$WVEXP ; /*DGBT*1.0*20 RFE */
 .I $D(DGBTRET(0)),$P(DGBTRET(0),"^",6)="MAN" W !,?52,"WAIVER EXPIRES: ",$P(DGBTRET(0),"^",7)
 .F I=$Y:1:20 W !
 ;
 I DAYFLG,$G(RXCPST) D
 .I $G(RXCP)'=1,$P($G(DGBTINCA),"^",2)'="" W !!?2,"Income: ",$S($P($G(DGBTINCA),"^",2)'="":$P(DGBTINCA,"^",2),1:""),DGBTDTY,?40,"Source of Income:  ","Alternate Income/"_$S($P(DGBTINCA,"^",4)="H":"Hardship",1:"POW")
 .I $G(RXCP)'=1,$P($G(DGBTINCA),"^",2)="" W !!?2,"Income: ",DGBTDTY,?40,"Source of Income:  ","COPAY TEST"               ;RXCP'=1 Copy NON-EXEMPT
 .I $G(RXCP)=1,$P($G(DGBTINCA),"^",2)'="" W !!?2,"Income: ",$S($P($G(DGBTINCA),"^",2)'="":$P(DGBTINCA,"^",2),1:""),DGBTDTY,?40,"Source of Income:  ","Alternate Income/"_$S($P(DGBTINCA,"^",4)="H":"Hardship",1:"POW")
 .I $G(RXCP)=1,$P($G(DGBTINCA),"^",2)="" W !!?2,"Income: ",$P(DGBTINC,U),DGBTDTY,?40,"Source of Income:  ","COPAY TEST"  ;RXCP=1  Copay EXEMPT
 .W !?2,"No. of Dependents: ",DGBTDEP
 .I DGBTMTS]"" W ?40,"MT Status: ","NOT APPLICABLE"
 .W !!?2,"BT Income: ","INELIGIBLE"
 .I '$D(DGBTRET(0)) W ?50,$$WVEXP     ;*DGBT*1.0*20 BLD * E2
 .I $D(DGBTRET(0)),$P(DGBTRET(0),"^",6)'="MAN" W ?50,$$WVEXP ; /*DGBT*1.0*20 RFE */
 .I $D(DGBTRET(0)),$P(DGBTRET(0),"^",6)="MAN" W ?52,"WAIVER EXPIRES: ",$P(DGBTRET(0),"^",7)
 .F I=$Y:1:20 W !
 ;
QUIT ;
 K I1,I2,I3
 D MONTDISP(TOTRIPS,ONEWAY,RT,MONTHDED,WAIVER,WTYPE)
 Q
 ;
MONTOT(TOTRIPS,ONEWAY,RT,MONTHDED,WAIVER,WTYPE,TTRIPS,TDED) ;
 ;
 N RETURN
 S RETURN=""
 ;Return values: total number of trips ^ number of one way trips ^ number of round trips ^ deductible (all this for the month) ^ waiver y/n (y will be 1, n will be no) ^
 ;total number of trips as of this claim date ^ deductible as of this claim date
 ;from the local data base
 S RETURN=$$WAIV^DGBTRDVW(DFN,DGBTDTI)
 S ONEWAY=$S($P($G(RETURN),"^",2):$P($G(RETURN),"^",2),1:0)
 S RT=$S($P($G(RETURN),"^",3):$P($G(RETURN),"^",3),1:0)
 S WAIVER=$S($P($G(RETURN),"^",5)=1:"YES",1:"NO")
 S MONTHDED=$S($P($G(RETURN),"^",4):$P($G(RETURN),"^",4),1:0)
 S WTYPE=$P(RETURN,"^",5)
 S TOTRIPS=(RT*2)+ONEWAY
 S TTRIPS=$S($P($G(RETURN),U,8):$P($G(RETURN),U,8),1:0)
 S TDED=$S($P($G(RETURN),U,9):$P($G(RETURN),U,9),1:0)
 S DGBTREF=0
 S DGBTREF=$$LSTMTRIN(DFN,DGBTDTI)
 I (WAIVER="NO")&($G(DGBTDYFL)) D
 .I DGBTNSC D  Q
 ..N INCOME
 ..S INCOME=+$TR($P($G(DGBTINC),U),"$,","")
 ..I INCOME'="",INCOME<DGBTRXTH,'$G(DGBTREF) S WAIVER="YES",$P(RETURN,U,5)=1,$P(RETURN,U,6)="NSC"
 ..;I ($P($G(DGBTINC),"^",1)'="")&+$TR($P(DGBTINC,U),"$,","")<DGBTRXTH,'$G(DGBTREF) S WAIVER="YES",$P(RETURN,U,5)=1,$P(RETURN,U,6)="NSC"
 .I '$G(DGBTREF)&(+$G(VAEL(3)))&($P($G(DGBTINC),"^",1)'="")&(+$TR($P(DGBTINC,U),"$,","")<DGBTMTTH) S WAIVER="YES",$P(RETURN,U,5)=1,$P(RETURN,U,6)="LI" Q
 .I ($P($G(DGBTINC),"^",1)'="")&+$$LI^DGBTUTL(DFN,DGBTDTI,DGBTDEP,,DGBTINCA)'=0 S WAIVER="YES",$P(RETURN,U,5)=1,$P(RETURN,U,6)="LI"
 .I $P($G(DGBTINC),"^",1)="" S $P(RETURN,"^",6)=""
 I TOTRIPS<6,MONTHDED<18,$P(RETURN,"^",5)=0 D  Q:$G(DGBTQUIT)      ;if less than 6 trips and no waiver check for remote facility visits
 .S RETURN=""
 .D OPT^DGBTRDV(DFN,DGBTDTI) I $G(RDVMSG) W $$PAUSE^DGBTUTL(0) S:$G(Y)="^" DGBTQUIT=1 Q:$G(DGBTQUIT)!($G(DGBTRET(0))="")
 .I $G(RDVMSG) W $$PAUSE^DGBTUTL(0)
 .S ONEWAY=$G(ONEWAY)+$P(RETURN,"^",2)
 .S RT=$G(RT)+$P(RETURN,"^",3)
 .S MONTHDED=$G(MONTHDED)+$P(RETURN,"^",4)
 .S TOTRIPS=TOTRIPS+$P(RETURN,"^",1)
 .S TTRIPS=TTRIPS+$P(RETURN,U,8)
 .S TDED=TDED+$P(RETURN,U,9)
 .S $P(RETURN,"^",1)=TOTRIPS
 .S $P(RETURN,"^",8)=TTRIPS
 .S $P(RETURN,"^",9)=TDED
 .I $P(RETURN,"^",5)'=1 S $P(RETURN,"^",5)=$S(TTRIPS>6:1,TDED>18:0,1:$P(RETURN,"^",5))
 .S WAIVER=$S($P(RETURN,"^",5)=1:"YES",1:"NO")
 I WAIVER'="YES" S WAIVER=$S($P(RETURN,"^",1)>6:"YES",1:"NO")
 S MONTOT=$G(TOTRIPS)_"^"_$G(ONEWAY)_"^"_$G(RT)_"^"_$G(MONTHDED)_"^"_$G(WAIVER)_U_$G(TTRIPS)_U_$G(TDED)
 Q
 ;
MONTDISP(TOTRIPS,ONEWAY,RT,MONTHDED,WAIVER,WTYPE) ;
 ;
 W !?2,"TOTAL TRIPS THIS MONTH: ",$G(ONEWAY)_" ONE WAY, ",$G(RT)_" RD TRIP"
 W ?52,"WAIVER GRANTED: ",$G(WAIVER)
 W !?2,"TOTAL DEDUCTIBLE THIS MONTH: ",MONTHDED
 ;
 Q
 ;
PAUSE   ;added with DGBT*1*11
 I $E(IOST,1,2)["C-" N DIR S DIR(0)="E" D ^DIR S DGQUIT='Y
 Q
 ;
DAYSTEST(DFN,DAYFLG,RXDAYS,RXCPST,LOWINC,NOTEST) ;determines whether or not a valid MT in last 365 days.
 N DGBTDATA,TESTDATA,DGBTDAYS,DGMTSTAT,DGBTST,DGRXDATA,DGTSTTYP,DGMTST,X,DGMTYPT1,THRESHLD,INCOM
 S DGMTYPT1=3,DAYFLG=0,(DGMTST,RXCPST,THRESHLD,INCOM)=""
 S DGBTDATA=$$LST^DGMTCOU1(DFN,$P(DGBTDT,".",1),.DGMTYPT1)
 I DGBTDATA'="" D
 .S TESTDATE=$$LSTMTDT(DFN)
 .S DGBTDAYS=$$FMDIFF^XLFDT($P(DGBTDTI,".",1),TESTDATE)            ;get number of days from claim date to last MT
 .S DAYFLG=$S(DGBTDAYS>365:0,1:1)                   ;if greater than 365 days then no valid MT test
 .I DGMTYPT1=1 S DGMTST=$P(DGBTDATA,"^",3)="NO LONGER REQUIRED"
 .I DGMTYPT1=2 S RXCPST=$P(DGBTDATA,"^",3)="NON-EXEMPT"
 .S:RXCPST'=1 RXCP=1                             ;************************
 .S DGBTRET=$S(+$$LI^DGBTUTL(DFN,DGBTDTI,DGBTDEP,,DGBTINCA):"1^",1:"0^") ;Get Low Income + count Alternate Income   PAVEL
 .S LOWINC=$P(DGBTRET,"^",1)
 I $G(DAYFLG)=0 S DGNOTEST=1
 Q ""
 ;
ADDCHG(DFN) ;this will print the permanet Address last changed date or the Temporary Address last change date
 ;
 N DATE,TMPADD
 S TMPADD=$S($$GET1^DIQ(2,DFN,.12105)="YES":0,1:1)
 I TMPADD D
 .S DATE="Date Address Last Changed: "_$P($$GET1^DIQ(2,DFN,.118),"@",1)
 E  S DATE="Date Address Last Changed: "_$P($$GET1^DIQ(2,DFN,.12113),"@",1)
 ;
 Q DATE
 ; 
WVEXP() ; Waiver expiration date  ; /* Tagline added DGBT*1.0*20 RFE */
 N RETURN
 I $$WVELG Q "WAIVER EXPIRES: PENSION"
 N WVREQEXP
 I $D(^DGBT(392.7,"C",DFN)) S WVREQEXP=$$WVREQ("IN")
 I $G(WVREQEXP)="PENSION" Q "WAIVER EXPIRES: PENSION"
 N DGMTYPT1,TESTDATEI
 S TESTDATE=$$TESTDATE
 S TESTDATEI=$$DTFORMI(TESTDATE)
 I TESTDATEI<$P(DGBTDTI,".") Q ""
 I +$G(DGBTINCA) Q "WAIVER EXPIRES: "_TESTDATE
 I '+$G(LOWINC) Q $$WVREQ("EX")
 N LABL
 S LABL=$S($G(DGMTYPT1)=1:"MEANS TEST ",$G(DGMTYPT1)=2:"COPAY TEST ",1:"WAIVER ")_"EXPIRES: "
 Q LABL_TESTDATE
 ;
TESTDATE() ;
 I (+$G(DGBTINCA)),($G(WVREQEXP)>$P(DGBTINCA,U,5)) Q $$DTFORM(WVREQEXP)
 I +$G(DGBTINCA) Q $$DTFORM($P(DGBTINCA,U,5))
 S DGMTYPT1=3
 S TESTDATE=$P($$LST^DGMTCOU1(DFN,DGBTDTI,.DGMTYPT1),U,2)
 I 'DAYFLG S (TESTDATE,DGMTYPT1)=0
 I (+TESTDATE=0),($E($G(WVREQEXP),1,3)>$E(DGBTDTI,1,3)) Q $$DTFORM(WVREQEXP)
 I +TESTDATE=0 Q "12/31/"_$E(DGBTDTI,2,3)
 Q $$DTFORM(($E(TESTDATE,1,3)+1)_$E(TESTDATE,4,7))
 ;
DTFORM(INTDT) ;
 Q $E(INTDT,4,5)_"/"_$E(INTDT,6,7)_"/"_$E(INTDT,2,3)
 ;
DTFORMI(TESTDATE) ; 
 Q 3_$P(TESTDATE,"/",3)_$P(TESTDATE,"/",2)_$P(TESTDATE,"/")
 ;
WVELG() ; Eligibility for waiver being PENSION DGBT*1.0*20 RFE
 I VAEL(1)["PENSION" Q 1
 I $P(VAEL(1),"^",2)="AID & ATTENDANCE" Q 1
 I $P(VAEL(1),"^",2)="HOUSEBOUND" Q 1
 N HIT
 S (HIT,I)=""
 F  S I=$O(VAEL(1,I)) Q:I=""  D  Q:HIT
 .I VAEL(1,I)["PENSION" S HIT=1 Q
 .I $P(VAEL(1,I),"^",2)="AID & ATTENDANCE" S HIT=1 Q
 .I $P(VAEL(1,I),"^",2)="HOUSEBOUND" S HIT=1 Q
 Q HIT
 ;
YEAR(DT1) ; DT2 will be a year after DT1  ; /*Tagline added DGBT*1.0*20 RFE */
 N DT2,MO,YR
 S DT2=$$FMTH^XLFDT(DT1,1)+365
 S YR=+$E(DT1,2,3),MO=+$E(DT1,4,5)
 I (YR#4=3),(MO>2) S DT2=DT2+1 ; Leap year
 I (YR#4=0),(MO<3) S DT2=DT2+1 ; Leap year
 Q DT2
 ;
WVREQ(INEX) ; Manual deductible waiver request DGBT*1.0*20 RFE
 I '$D(^DGBT(392.7,"C",DFN)) Q ""
 N DGBTDW,EXPDT
 S (DGBTDW,I)=""
 F  S I=$O(^DGBT(392.7,"C",DFN,I),-1) Q:I=""  D  Q:DGBTDW'=""
 .I $$GET1^DIQ(392.7,I,97,"I") Q
 . S EXPDT=$$GET1^DIQ(392.7,I,8,"I")
 . I EXPDT="PENSION" S DGBTDW=1 Q
 . I $E(I,1,3)=$E(DGBTA,1,3) S DGBTDW=^DGBT(392.7,I,0) Q
 . I $E(I,1,3)'=($E(DGBTA,1,3)-1) Q
 . I $$GET1^DIQ(392.7,I,8,"I")<$P(DGBTA,".") Q
 . S DGBTDW=^DGBT(392.7,I,0)
 I DGBTDW="" Q ""
 I $P(DGBTDW,"^",3)=0 Q ""
 I $P(DGBTA,".")<$P($P(DGBTDW,U),".") Q ""
 I INEX="IN" Q EXPDT
 I $G(EXPDT)="PENSION" Q "WAIVER EXPIRES: PENSION"
 I EXPDT<$P(DGBTDTI,".") Q ""
 Q "WAIVER EXPIRES: "_$$DTFORM(EXPDT)
 ;
LSTMTDT(DFN) ;this will return the last means test date
 N MTIEN
 S MTIEN=""
 S MTIEN=$O(^DGMT(408.31,"C",DFN,MTIEN),-1)
 S LSTMTDT=$P(^DGMT(408.31,MTIEN,0),"^",1)
 Q LSTMTDT
 ;
LSTMTRIN(DFN,DGBTDTI) ;this willl return whether the patient refused to give income
 N MTIEN,REFUSED
 S REFUSED=1
 S MTIEN=+$$LST^DGMTCOU1(DFN,DGBTDTI,3)
 I MTIEN'="" S REFUSED=$$GET1^DIQ(408.31,MTIEN,.14,"I")
 Q REFUSED
