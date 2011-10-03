ORPRPM ;DAN/SLC Performance Measure; ;9/4/08  08:17
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**107,114,119,196,190,225,243,296**;Dec 17, 1997;Build 19
 ;
 ;DBIA SECTION
 ;4195 - EN^PSOTPCUL
 ;3744 - $$TESTPAT^VADPT
 ;10060- Reference to file 200
 ;
 ;This routine will print a report indicating the percent of
 ;orders entered for a provider by a provider holding the ORES key.
 ;The data for the report will be stored in ^TMP as follows:
 ;^TMP($J,"SUM",Provider Name,Patient Status)=Total # of order (universe)^Denominator^Numerator^Verbal^Written^Telephone^Policy^Electronically entered^Student entered^Outpatient narcotic orders
 ;Where Patient Status is I for inpatient or O for outpatient.
 ;
 N DIR,ORSD,ORED,ORPROV,ORTYPE,ORPT,ORREP,ORPIECE,Y,DIRUT,DUOUT,DTOUT,ZTRTN,ORDT,ORIEN,ORACT0,ORPVID,PG,REPDT,ORSTOP,ORI,ORJ,ORPAT,ORTOT,ORSTOT,X,ORPVNM,ORORD,ORPTST,ORP,ORWROTE,ORNS,ORFS,ORPFILE
 D GETDATE K DIR Q:$D(DIRUT)  ;quit if no dates selected ;get start and end dates
 D GETPROV K DIR Q:'$D(ORPROV)!($G(ORPROV)'="ALL"&($D(ORPROV)'=11))!($D(DUOUT))!($D(DTOUT))  ;quit if user didn't select all providers or if didn't choose individual providers or if user timed out or up-arrowed out
 D GETOTHER Q:$D(DIRUT)  ;quit if any questions were unanswered in this section
 S ZTRTN="DQ^ORPRPM" D QUE^ORUTL1(ZTRTN,"CPRS Performance Monitor")
 Q
 ;
GETDATE ;Prompt for start and end dates
 S DIR(0)="DO^:DT:AE",DIR("A")="Enter starting date",DIR("?")="Enter date to begin searching from" D ^DIR Q:$D(DIRUT)  S ORSD=Y
 S DIR(0)="DOA^"_ORSD_":DT:AE",DIR("A")="Enter ending date: ",DIR("?")="Enter date to stop searching.  Must be between "_$$FMTE^XLFDT(ORSD,2)_" and "_$$FMTE^XLFDT(DT,2) D ^DIR Q:$D(DIRUT)
 S ORED=Y_.24,ORSD=ORSD-.1 ;Set end date to end of day, start date back to include current day
 Q  ;End GETDATE
 ;
GETPROV ;Allow selection of all/single/multiple providers
 ;return ORPROV="ALL" for all providers or ORPROV array for individual providers
 S DIR(0)="Y",DIR("A")="Do you want ALL providers to appear on this report",DIR("B")="Y",DIR("?")="Enter Yes to search for all providers.  Enter No to select individual providers"  D ^DIR Q:$D(DIRUT)  S ORPROV=$S(Y=1:"ALL",1:"") Q:ORPROV="ALL"
 K DIR ;clear DIR variables before getting individual providers
 F  D  Q:$D(DIRUT)  ;quit when finished selecting
 .S DIR(0)="PO^200:AEQM",DIR("S")="I $D(^VA(200,""AK.PROVIDER"",$P(^(0),U)))",DIR("A")="Select "_$S($D(ORPROV)=11:"another ",1:"")_"provider"
 .S DIR("?")="Select providers to appear on report.  Return when finished, ^ to stop processing" D ^DIR Q:$D(DIRUT)  S ORPROV(+Y)=""
 Q  ;End GETPROV
 ;
GETOTHER ;Get order type, patient type, and summary only report response
 ;Get order type first
 S DIR(0)="S^A:All orders;P:Pharmacy orders only",DIR("A")="Select order category",DIR("B")="P",DIR("?")="Enter P to see pharmacy orders only.  Enter A to see all orders. Enter ^ to quit" D ^DIR Q:$D(DIRUT)  S ORTYPE=Y
 K DIR
 ;Get patient status
 S DIR(0)="S^I:Inpatient;O:Outpatient;B:Both",DIR("A")="Select patient status",DIR("B")="B",DIR("?")="Enter patient status at time of order.  Enter ^ to quit" D ^DIR Q:$D(DIRUT)  S ORPT=Y
 K DIR
 ;Ask if user desires facility subtotal, summary, detail, or both (detail and summary) reports
 S DIR(0)="S^S:Summary (includes provider details);D:Detail (includes order details);B:Both (Summary & Detail);T:Summary Report Totals Only (no provider details)",DIR("A")="Select report",DIR("B")="S"
 D ^DIR Q:$D(DIRUT)  S ORREP=Y,ORFS=0 I Y="T" S ORREP="S",ORFS=1
 K DIR
 Q  ;End GETOTHER
 ;
DQ ;Come here to do build and print from QUE^ORUTL either direct or tasked
 U IO K ^TMP($J) ;clean out temp space
 S ORDT=ORSD F  S ORDT=$O(^OR(100,"AF",ORDT)) Q:'ORDT!(ORDT>ORED)  S ORIEN="" F  S ORIEN=$O(^OR(100,"AF",ORDT,ORIEN)) Q:'ORIEN  I $O(^OR(100,"AF",ORDT,ORIEN,0))=1 I $D(^OR(100,ORIEN,8,1,0)) D CHECK
 D PRINT^ORPRPM1
 K ^TMP($J)
 Q
 ;
CHECK ;If order matches requirements then save
 S ORPFILE=$P($G(^OR(100,ORIEN,0)),"^",2) Q:ORPFILE=""  ;Quit if no object of order
 I $P(ORPFILE,";",2)["DPT" Q:$$TESTPAT^VADPT(+$P($G(^OR(100,ORIEN,0)),"^",2))  ;225 Quit if test patient
 Q:+$P($G(^OR(100,ORIEN,3)),"^",11)'=0  ;190 quit if order type not standard
 Q:$P(^ORD(100.98,$P(^OR(100,ORIEN,0),U,11),0),U)="NON-VA MEDICATIONS"  ;225 Quit if Non-VA med entry
 S ORPTST=$P($G(^OR(100,ORIEN,0)),"^",12) ;patient status (in/out)
 I ORPT'="B" Q:ORPTST'=ORPT  ;Quit if patient status is not 'both' and status doesn't match selected status
 S ORNS=$$NMSP^ORCD($P($G(^OR(100,ORIEN,0)),"^",14))
 I ORTYPE'="A"&(ORNS'="PS") Q  ;if not getting all types of orders then quit if order is not from pharmacy
 I ORPTST="O",ORNS="PS",$G(^OR(100,ORIEN,4))=+$G(^OR(100,ORIEN,4)),$L($T(EN^PSOTPCUL)) Q:$$EN^PSOTPCUL($G(^OR(100,ORIEN,4)))  ;196 Don't count if outpatient pharm order is a transitional pharmacy benefit order
 S ORACT0=$G(^OR(100,ORIEN,8,1,0)),ORORD=$P(ORACT0,"^",12) ;ORORD holds nature of order ien
 S ORPVID=$P(ORACT0,"^",3) I ORPROV'="ALL" Q:'$D(ORPROV(ORPVID))  ;quit if ordering provider doesn't match user selected provider
 S ORPVNM=$$GET1^DIQ(200,ORPVID_",",.01) ;225 get provider name
 Q:'$D(^XUSEC("ORES",ORPVID))  ;quit if ordering provider doesn't have ORES key DBIA # 10076 allows direct read of XUSEC
 Q:"^1^2^3^5^8^"'[("^"_ORORD_"^")  ;quit if NATURE OF ORDER is not verbal, written, telephoned, policy, or electronically entered
 D COUNT ;Count order
 Q
 ;
COUNT ;This section determines how the order should be counted
 N OREB,ORPIECE
 D ADD(1) ;Add one to universe (total # of orders)
 S OREB=$P(ORACT0,"^",13) ;Entered by
 S ^TMP($J,"DET",ORPVNM,ORIEN)=$D(^XUSEC("ORES",OREB))&(OREB=ORPVID) ;Mark "HAS ORES" column for detailed listing if entered by = provider and has ORES key
 I OREB=ORPVID D ADD(2),ADD(3) Q  ;if order entered by provider then add one to denominator and numerator
 I ORNS="PS" I $$OIDEA=1 D ADD(10) Q  ;If order requires wet signature add one to narcotic group
 I $$STUDENT D ADD(9) Q  ;If order entered by student add one to student group
 S ORPIECE=$S(ORORD=1:4,ORORD=2:5,ORORD=3:6,ORORD=8:7,1:8) D ADD(ORPIECE) ;add to exceptions group for orders not entered by provider
 I ORORD'=5 D ADD(2) ;Add to denominator if not policy order
 Q
 ;
ADD(PIECE) ;Add one to storage
 S $P(^TMP($J,"SUM",ORPVNM,ORPTST),"^",PIECE)=$P($G(^TMP($J,"SUM",ORPVNM,ORPTST)),"^",PIECE)+1 Q
 ;
OIDEA() ;Check to see if pharmacy order requires wet signature
 ;dbia 3373 allows call to pharmacy API or dbia 221 allows direct read of ^PSDRUG if routine doesn't exist yet
 N OI,PSOI,SIGREQ,PSSXOLP,PSSXOLPD,PSSXOLPX,PSSXNODD,PSSPKLX
 Q:ORPTST'="O" 0 ;quit if inpatient
 S OI=$$VALUE^ORX8(ORIEN,"ORDERABLE") ;get orderable item
 S PSOI=+$P($G(^ORD(101.43,+OI,0)),U,2) I PSOI'>0 Q 0 ;quit if no pharmacy orderable item
 I $L($T(OIDEA^PSSUTLA1)) S SIGREQ=$$OIDEA^PSSUTLA1(PSOI,"O") Q:SIGREQ=1 1 Q 0 ;If SIGREQ = 1 then wet signature required
 S (PSSXOLPD,PSSXNODD)=0
 S PSSPKLX=0
 K ^TMP($J,"ORPRPM ASP")
 D ASP^PSS50(PSOI,,,"ORPRPM ASP")
 F PSSXOLP=0:0 S PSSXOLP=$O(^TMP($J,"ORPRPM ASP","")) Q:'PSSXOLP!(PSSXOLPD=1)  D
 .K ^TMP($J,"ORPRPM DATA") D DATA^PSS50(PSSXOLP,,(DT-1),,,"ORPRPM DATA") I +^TMP($J,"ORPRPM DATA",0)<0 Q
 .I 'PSSPKLX,$G(^TMP($J,"ORPRPM DATA",63))'["O" K ^TMP($J,"ORPRPM DATA") Q
 .I PSSPKLX I $G(^TMP($J,"ORPRPM DATA",63))'["U",$G(^TMP($J,"ORPRPM DATA",63))'["I" Q
 .S PSSXNODD=1
 .S PSSXOLPX=$G(^TMP($J,"ORPRPM DATA",3))
 .I PSSXOLPX[1!(PSSXOLPX[2)!((PSSXOLPX[3)&(PSSXOLPX["A")) S PSSXOLPD=1 Q
 .I PSSXOLPX[3!(PSSXOLPX[4)!(PSSXOLPX[5) S PSSXOLPD=2
 I PSSXOLPD=0,'PSSXNODD S PSSXOLPD=""
 K ^TMP($J,"ORPRPM ASP")
 K ^TMP($J,"ORPRPM DATA")
 Q PSSXOLPD
 ;
STUDENT() ;Check to see if entered by is a student
 ;Check USER CLASS for membership in "STUDENT" CLASS - DBIA 2324
 ;Then check PROVIDER CLASS in NEW PERSON file for "STUDENT" - DBIA 10060
 N ORCLASS,ORSUB,EXPIRE,ORUSR
 D WHATIS^USRLM(OREB,"ORCLASS") ;API to get user class membership
 S ORSUB=0,ORUSR=0 F  S ORSUB=$O(ORCLASS(ORSUB)) Q:ORSUB=""!ORUSR  D
 .I $$UP^XLFSTR(ORSUB)'["STUDENT" Q  ;User not a member of student class
 .I ORDT'<+$P(ORCLASS(ORSUB),"^",4) S EXPIRE=$S(+$P(ORCLASS(ORSUB),"^",5):$P(ORCLASS(ORSUB),"^",5),1:9999999) I ORDT'>EXPIRE S ORUSR=1 ;member of student class and within date range for class
 I ORUSR Q 1 ;User identified as a student
 K ORCLASS
 S DIC=200,DR=53.5,DA=OREB,DIQ="ORCLASS",DIQ(0)="E" D EN^DIQ1
 I $G(ORCLASS(200,OREB,53.5,"E"))["STUDENT" Q 1 ;Provider class set to student
 Q 0 ;User not a student
