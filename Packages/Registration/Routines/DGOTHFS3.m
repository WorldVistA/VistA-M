DGOTHFS3 ;SLC/RM - FORMER OTH PATIENT DETAIL REPORT 2 - CONTINUATION ; Sep 29, 2020@3:51 pm
 ;;5.3;Registration;**1034,1035**;Aug 13, 1993;Build 14
 ;
 ;Global References      Supported by ICR#   Type
 ;-----------------      -----------------   ----------
 ; ^TMP($J               SACC 2.3.2.5.1
 ;
 ;External References
 ;-------------------
 ; $$GET1^DIQ             2056               Supported
 ; ^DIR                  10026               Supported
 ; $$CPTIER^PSNAPIS       2531               Supported
 ; RX^PSO52API            4820               Supported
 ; PSS^PSO59              4827               Supported
 ; NDF^PSS50              4533               Supported
 ; $$FMTE^XLFDT          10103               Supported
 ; $$STA^XUAF4            2171               Supported
 ;No direct call
 Q
 ;
SORTENC() ;prompt user how ENCOUNTER report will be sorted
 N X,Y,Z,DIR,DIROUT,DIRUT,DTOUT,DUOUT,DGASK
 S DIR(0)="S^1:By Date of Service;2:By Division"
 S DIR("L",1)="Select Episodes of Care sorting order:"
 S DIR("L",2)="  1.  By Date of Service"
 S DIR("L")="  2.  By Division"
 S DIR("B")="1"
 S DIR("A")="Sort Report"
 S DIR("?")="^D SORTHLP^DGOTHFS4(1)"
 D ^DIR K DIR
 S DGASK=$$ANSWER(X,Y)
 I DGASK>0 S DGSORT("SORTENCBY")=DGASK_U_$S(DGASK=1:"By Date of Service",1:"By Division"),DGASK=1
 E  S DGASK=0
 Q DGASK
 ;
ANSWER(X,Y) ;
 S Z=$S($D(DTOUT):-2,$D(DUOUT):-1,$D(DIROUT):-1,1:"")
 I Z="" S Z=$S(Y=-1:"",X="@":"@",1:$P(Y,U)) Q Z
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(X="@":"@",1:$P(Y,U))
 ;
SORTRX() ;prompt user how Rx report will be sorted
 N X,Y,Z,DIR,DIROUT,DIRUT,DTOUT,DUOUT,DGASK
 S DIR(0)="S^1:By Rx Release Date;2:By Division"
 S DIR("L",1)="Select Released Prescription sorting order:"
 S DIR("L",2)="  1.  By Rx Release Date"
 S DIR("L")="  2.  By Division"
 S DIR("B")="1"
 S DIR("A")="Sort Report"
 S DIR("?")="^D SORTHLP^DGOTHFS4(2)"
 D ^DIR K DIR
 S DGASK=$$ANSWER(X,Y)
 I DGASK>0 S DGSORT("SORTRXBY")=DGASK_U_$S(DGASK=1:"By Rx Release Date",1:"By Division"),DGASK=1
 E  S DGASK=0
 Q DGASK
 ;
ENCTRIB ;get the  IB STATUS for the Outpatient and Inpatient episode of care
 N FILENO,ENCDT,STATNUM,RECNT,IBFILENO,TMPDATA,CHRGCNT,DFN405,DFN409,SUB1,SUB2,NWBILL,OLDBILL,OLDOEDT,PRNTSEC,OUTPATARY
 S (CHRGCNT,PRNTSEC)=0
 I PRINTRPT S (OLDBILL,OLDOEDT)=""
 S SUB1="" F  S SUB1=$O(@RECORD@(SUB1)) Q:SUB1=""  D  Q:DGQ
 . S SUB2="" F  S SUB2=$O(@RECORD@(SUB1,SUB2)) Q:SUB2=""  D  Q:DGQ
 . . S FILENO="" F  S FILENO=$O(@RECORD@(SUB1,SUB2,FILENO)) Q:FILENO=""  D  Q:DGQ
 . . . S RECNT="" F  S RECNT=$O(@RECORD@(SUB1,SUB2,FILENO,RECNT)) Q:RECNT=""  D  Q:DGQ
 . . . . S CHRGCNT=0
 . . . . I FILENO=52 K @RECORD@(SUB1,SUB2,FILENO,RECNT) Q  ;remove any RX record for EOC display
 . . . . I $P(DGSORT("SORTENCBY"),U)=1 S ENCDT=SUB1,STATNUM=SUB2 ;sort by date of service
 . . . . I $P(DGSORT("SORTENCBY"),U)=2 S ENCDT=SUB2,STATNUM=SUB1 ;sort by division
 . . . . I 'PRINTRPT,(FILENO=409.68!(FILENO=405)) D  Q
 . . . . . ;only get the IB status for the Outpatient and Inpatient episode of care
 . . . . . F IBFILENO=350,399 D
 . . . . . . S (DFN405,DFN409)=0
 . . . . . . I FILENO=409.68!(FILENO=405) S (DFN405,DFN409)=$P(@RECORD@(SUB1,SUB2,FILENO,RECNT),U,7) ;file #409.68 or file #45 IEN
 . . . . . . I FILENO=405,$P(@RECORD@(SUB1,SUB2,FILENO,RECNT),U,8)'="" S DFN405=$P($P(@RECORD@(SUB1,SUB2,FILENO,RECNT),U,8),";") ;file #405 IEN for file #350 evaluation
 . . . . . . I IBFILENO=399 S DFN405=$P($P(@RECORD@(SUB1,SUB2,FILENO,RECNT),U,8),";",2) ;File #45 IEN for file #399 record evaluation
 . . . . . . D IBSTATUS^DGFSMOUT(IBFILENO,ENCDT)
 . . . . I PRINTRPT D
 . . . . . S TMPDATA=@RECORD@(SUB1,SUB2,FILENO,RECNT)
 . . . . . S NWBILL=$S(FILENO=350:$P($P(TMPDATA,U,10),"-",2),FILENO=399:$P(TMPDATA,U,11),1:0)
 . . . . . D PRNTENC(TMPDATA,ENCDT) K TMPDATA S OLDBILL=NWBILL,OLDOEDT=ENCDT\1
 . . . . Q:DGQ
 . . . Q:DGQ
 . . Q:DGQ
 . Q:DGQ
 I PRINTRPT D
 . W ! D LINE^DGOTHFS2(1)
 . Q:DGQ
 . W !!,"Total Number of Episode(s) of Care:  ",DGTOTENC
 Q
 ;
PRNTENC(TMPDATA,ENCDT) ;continuation of ENCTR tag found in DGOTHFS2
 N RECNUM,RSLTFRMOE,TRUE
 S TRUE=0
 I $Y>(IOSL-4) W ! D PAUSE^DGOTHFS2(.DGQ) Q:DGQ  D PTHDR^DGOTHFS2,LINE^DGOTHFS2(0),ENCHDR^DGOTHFS2(1),ENCTRCOL^DGOTHFS2,LINE^DGOTHFS2(1)
 ;display the clinic name, etc. only once
 I FILENO=350!(FILENO=399) D
 . I OLDBILL'=NWBILL S TRUE=1 D DSPLAY
 . I OLDBILL=NWBILL,OLDOEDT'=ENCDT\1 S TRUE=1 D DSPLAY
 . I 'TRUE  W !
 . I FILENO=350 D
 . . W ?89,$S(NWBILL=0:"",1:NWBILL) ;bill no
 . . W ?100,$E($P(TMPDATA,U,7),1,15) ;action/rate type
 . . W ?116,$E($P(TMPDATA,U,13),1,16) ;IB status
 . I FILENO=399 D
 . . W ?89,$S(NWBILL=0:"",1:NWBILL) ;bill no
 . . W ?100,$E($P(TMPDATA,U,9),1,15) ;action/rate type
 . . W ?116,$E($P(TMPDATA,U,14),1,16) ;IB status
 E  D
 . D DSPLAY
 . S TRUE=0
 . I $O(@RECORD@(SUB1,SUB2,FILENO,RECNT,""))'="" D
 . . S RECNUM="" F  S RECNUM=$O(@RECORD@(SUB1,SUB2,FILENO,RECNT,RECNUM)) Q:RECNUM=""  D
 . . . I RECNUM>1 W !
 . . . W ?89,$P(@RECORD@(SUB1,SUB2,FILENO,RECNT,RECNUM),U,4) ;bill no
 . . . S RSLTFRMOE=$P(@RECORD@(SUB1,SUB2,FILENO,RECNT,RECNUM),U,5)
 . . . I $P(RSLTFRMOE,":")=405!($P(RSLTFRMOE,":")=409.68) W ?100,$E($P(@RECORD@(SUB1,SUB2,FILENO,RECNT,RECNUM),U),1,15) ;action/rate type from file #350
 . . . E  W ?100,$E($P(@RECORD@(SUB1,SUB2,FILENO,RECNT,RECNUM),U,2),1,15) ;action/rate type from file #399
 . . . W ?116,$E($P(@RECORD@(SUB1,SUB2,FILENO,RECNT,RECNUM),U,7),1,16) ;IB status
 . . . I $D(@RECORD@(SUB1,SUB2,FILENO,RECNT+1)),'PRNTSEC D  Q  ;this means the record has secondary stop code
 . . . . S TMPDATA=@RECORD@(SUB1,SUB2,FILENO,RECNT+1)
 . . . . W !,?22,$E($P(TMPDATA,U,4),1,18) S TRUE=0,PRNTSEC=1 ;display the secondary stop code first before displaying the other statuses
 . . . S TRUE=1
 Q
 ;
DSPLAY ;display episode of care data
 I FILENO=409.68,$P(TMPDATA,U,10)'=1 D  Q  ;this means that the record belongs to a secondary stop code, as per business owner, only display the stop code name and leave out the rest
 . I 'PRNTSEC D
 . . I $D(OUTPATARY($P(TMPDATA,U,3),ENCDT\1)) W !,?22,$E($P(TMPDATA,U,4),1,20) Q
 . . D DSPLAY1
 . S PRNTSEC=0
 I FILENO=405,$P(TMPDATA,U,10)>1 D  Q  ;this means that the record belongs to a secondary stop code (inpatient outpatient encounter)
 . I $O(@RECORD@(SUB1,SUB2,FILENO,RECNT,""))="" W !,?22,$E($P(TMPDATA,U,4),1,20)
 D DSPLAY1
 S DGTOTENC=DGTOTENC+1
 Q
 ;
DSPLAY1 ;
 W !,$E($P(TMPDATA,U,3),1,20) ;clinic name/Location of care
 W ?22,$E($P(TMPDATA,U,4),1,20) ;clinic stop code/treating specialty
 I FILENO=350!(FILENO=399) W ?45,"N/A" ;Primary/Principal diagnosis
 I FILENO=409.68 W ?45,$P(TMPDATA,U,9) ;Primary/Principal diagnosis
 I FILENO=405 W ?45,$S($P(TMPDATA,U,9)'="":$P(TMPDATA,U,9),1:$P(TMPDATA,U,8)) ;Primary/Principal diagnosis
 W ?55,$P(TMPDATA,U,2) ;Division
 W ?61,$$FMTE^XLFDT(ENCDT\1,"5ZF") ;Appt. Date/Time or Date of Service
 W ?72,$E($P(TMPDATA,U,5),1,14) ;user last updated/edited the entry
 S OUTPATARY($P(TMPDATA,U,3),ENCDT\1)=""
 Q
 ;
CPTIER ;extract Rx Copay Tier
 N DGDRUGIEN
 K ^TMP($J,"OTHCPTIER"),DGCPTIER
 S DGDRUGIEN=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,6),U)
 D NDF^PSS50(DGDRUGIEN,"","","","","OTHCPTIER")
 ;look up the tier of the prescription
 ;returns the tier level of the specified prescription
 ;default tier is always 2
 S DGCPTIER=$P(^TMP($J,"OTHCPTIER",DGDRUGIEN,20),U)
 S DGCPTIER=$S(DGCPTIER:$P($$CPTIER^PSNAPIS(DGCPTIER,DT,DGDRUGIEN,1),U),1:2)
 K ^TMP($J,"OTHCPTIER")
 Q
 ;
SITE(FLAG) ;site where Rx's released
 K ^TMP($J,"OTHFSMSITE"),DGRXDIV ;site where RX's released
 I FLAG<1 S DGRXDIV=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,20),U)
 E  S DGRXDIV=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,"RF",JJ,8),U)
 D PSS^PSO59(DGRXDIV,,"OTHFSMSITE")
 S DGRXDIV=^TMP($J,"OTHFSMSITE",DGRXDIV,.06)
 K ^TMP($J,"OTHFSMSITE")
 Q
 ;
RX1 ;continuation of RX line tag from above
 N RATETYP,QUIT,DGRXNUM,DGRXIEN,DATA1,DATA2,IB350DIV,IB399DIV,IB362FLNUM,DGPRTLTOT,DGOTHFLGPRTL
 S (RATETYP,IB362FLNUM,DGPRTLTOT,DGOTHFLGPRTL)=0
 S DGPRTLTOT=+$P($G(^TMP($J,"OTHFSMR2",DFN,OTHIBRX,"P",0)),U) ;total rx partial fill entry/record
 I $$RXBSTAT(OTHIBRX) D  Q
 . ;this is the happy path
 . S DGRXNUM=^TMP($J,"OTHFSMR2",DFN,OTHIBRX,.01)
 . S DGRXIEN=OTHIBRX
 . I FILENO=350 D
 . . I $P(RESULT,";",2)']"" D SORTORRX ;sort original rx
 . . I $P(RESULT,";",2)]"" D SORTRFRX ;sort refill rx
 . I FILENO=399 D
 . . I $P(RESULT,":",5)=0 D SORTORRX ;sort original rx
 . . I DGPRTLTOT,$P(RESULT,":",5)["P" S DGOTHFLGPRTL=1 D PARTIAL^DGPPOHUT("OTHFSMR2") ;sort partial rx
 . . I $P(RESULT,":",5)'["P",+$P(RESULT,":",5)>0 D SORTRFRX ;sort refill rx
 I OTHIBRX<1 D  Q
 . I FILENO=350 D
 . . ;this means the RX is manually entered and RESULTING FROM field=350
 . . K DATA1,DATA2,IB350DIV
 . . S IB350DIV=$P($P(^TMP($J,"IBOTHSTAT",FILENO,OTHIBDT,DFN,OTHIBREC),U,8),"-")
 . . S DATA1="NON-VA"_U_$P($P(RESULT,";",2),":",2)_U_"N/A"_U_"N/A"_U_IB350DIV_U_"N/A"_U_$P($P(RESULT,";",2),":")
 . . D IBSTAT
 . . I $P(DGSORT("SORTRXBY"),U)=1 S CNTR=CNTR+1,^TMP($J,"OTHFSMRX",OTHIBDT,IB350DIV,DFN,"NA",CNTR)=DATA1_U_DATA2
 . . E  S CNTR=CNTR+1,^TMP($J,"OTHFSMRX",IB350DIV,OTHIBDT,DFN,"NA",CNTR)=DATA1_U_DATA2
 . I FILENO=399 D
 . . ;this means the RX is manually entered in file #399 with no record in file #52
 . . K DATA1,DATA2,IB399DIV
 . . S IB399DIV=$P(^TMP($J,"IBOTHSTAT",FILENO,OTHIBDT,DFN,OTHIBREC),U,8)
 . . S IB399DIV=$$STA^XUAF4($$GET1^DIQ(40.8,IB399DIV_",",.07,"I")),IB362FLNUM=$S($P(RESULT,":",5)>0:"("_$P(RESULT,":",5)_")",1:"")
 . . S DATA1=$E($P($P(RESULT,":",4),"-"),1,12)_IB362FLNUM_U_"N/A"_U_"N/A"_U_$P($P(RESULT,":",4),"-",2)_U_IB399DIV_U_OTHIBDT_U_OTHIBDT
 . . D IBSTAT
 . . I $P(DGSORT("SORTRXBY"),U)=1 S CNTR=CNTR+1,^TMP($J,"OTHFSMRX",OTHIBDT,IB399DIV,DFN,OTHIBRX,CNTR)=DATA1_U_DATA2
 . . E  S CNTR=CNTR+1,^TMP($J,"OTHFSMRX",IB399DIV,OTHIBDT,DFN,OTHIBRX,CNTR)=DATA1_U_DATA2
 I '$$RXBSTAT(OTHIBRX) D
 . ;RX exist in 350 but not in ^TMP($J,"OTHFSMR2","B" file#52
 . K ^TMP($J,"OTHMSNGRX") D RX^PSO52API(DGDFN,"OTHMSNGRX",OTHIBRX,,"2,R,P",DGSORT("DGBEG"),$$FMADD^XLFDT(DGSORT("DGEND"),366))
 . M ^TMP($J,"OTHFSMR2")=^TMP($J,"OTHMSNGRX") K ^TMP($J,"OTHMSNGRX")
 . S DGRXNUM=^TMP($J,"OTHFSMR2",DFN,OTHIBRX,.01)
 . S DGRXIEN=OTHIBRX,DGOTHFLGPRTL=0
 . I $P(RESULT,";",2)']"" D SORTORRX ;sort original rx
 . I $P(RESULT,";",2)]"" D SORTRFRX ;sort refill rx
 . I DGPRTLTOT S DGOTHFLGPRTL=1 D PARTIAL^DGPPOHUT("OTHFSMR2") ;sort partial rx
 Q
 ;
RXBSTAT(OTHIBRX) ;Rx B Cross Reference in ^TMP($J,"OTHFSMR2"
 N DGRXNUM,DGRXIEN,FND
 S FND=0
 S DGRXNUM="" F  S DGRXNUM=$O(^TMP($J,"OTHFSMR2","B",DGRXNUM)) Q:DGRXNUM=""!(FND)  D
 . S DGRXIEN="" F  S DGRXIEN=$O(^TMP($J,"OTHFSMR2","B",DGRXNUM,DGRXIEN)) Q:DGRXIEN=""  D
 . I $D(^TMP($J,"OTHFSMR2","B",DGRXNUM,OTHIBRX)) S FND=1
 Q FND
 ;
SORTORRX ;Sort Original RX
 N DGNUMOFREF,DGDAYSUP,DGFILLDT,DATA1,DATA2,DGCPTIER,DGRXDIV,DGRELDATE
 S DGRELDATE=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,31),U)
 I +DGRELDATE<1,+$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,32.1),U)>1 S DGRELDATE=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,32.1),U)_"R",DGRTNSTCK=1 ;extract the RETURN TO STOCK date release date/time if the original fill date is missing
 S DGFILLDT=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,22),U) ;original Fill Date
 I '$$CHKDATE^DGOTHFS2(+DGRELDATE\1,.DGSORT) Q  ;do not include if released date is null
 D CPTIER ;extract the copay tier
 S DGNUMOFREF=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,9),U) ;# of refills
 S DGDAYSUP=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,8),U) ;days supply
 D SITE(0) ;extract the site where Rx's released
 S DATA1=DGRXNUM_U_DGCPTIER_U_DGNUMOFREF_U_DGDAYSUP_U_DGRXDIV_U_DGFILLDT_U_DGRELDATE
 I $G(OTHIBRX) D IBSTAT ;Extract the IB Status in File #350/File #399
 I $P(DGSORT("SORTRXBY"),U)=1 S CNTR=CNTR+1,^TMP($J,"OTHFSMRX",+OTHIBDT,DGRXDIV,DFN,DGRXNUM,CNTR)=DATA1_$S($G(OTHIBRX):U_DATA2,1:"")
 E  S CNTR=CNTR+1,^TMP($J,"OTHFSMRX",DGRXDIV,+OTHIBDT,DFN,DGRXNUM,CNTR)=DATA1_$S($G(OTHIBRX):U_DATA2,1:"")
 S $P(^TMP($J,"OTHFSMR2","B",DGRXNUM,DGRXIEN),U)=1 ;marked that this RX already been evaluated
 Q
 ;
IBSTAT ;Extract the IB Status in File #350 and File #399
 N BILLNO,RXIBSTAT
 S BILLNO=$P(^TMP($J,"IBOTHSTAT",FILENO,OTHIBDT,DFN,OTHIBREC),U,4)
 I FILENO=350 S BILLNO=$P(BILLNO,"-",2)
 I FILENO=399 S RATETYP=$P(^TMP($J,"IBOTHSTAT",FILENO,OTHIBDT,DFN,OTHIBREC),U,2)
 S RXIBSTAT=$P(^TMP($J,"IBOTHSTAT",FILENO,OTHIBDT,DFN,OTHIBREC),U,7)
 S DATA2=BILLNO_U_$S(FILENO=350:ACCTYP,1:RATETYP)_U_RXIBSTAT
 Q
 ;
SORTRFRX ;Sort Refill RX
 N JJ,DGRFRELDT,DGDSRF,DGFLDTRF,DATA1,DATA2,DGRXDIV,DGDSRF,DGRFRELDT,DGNUMOFREF
 ;if there are any and the released date is within the user specified date range, then include it into the report
 S DGTOTRF=+$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,"RF",0),U)
 ;quit if no refills found for this Rx
 Q:+DGTOTRF<1
 ;rx refill released date/time
 I FILENO=350 D
 . S JJ=$P($P(RESULT,";",2),":",2)
 . S DGRFRELDT=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,"RF",JJ,17),U) ;refill release date/time
 . I +DGRFRELDT<1,+$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,"RF",JJ,14),U)>1 S DGRFRELDT=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,"RF",JJ,14),U)_"R",DGRTNSTCK=1 ;extract the RETURN TO STOCK date release date/time
 I FILENO=399 D
 . S JJ=$P(RESULT,":",5)
 . S DGRFRELDT=+OTHIBDT
 ;quit if rx refill released date not within the user specified date range or no refill release date
 Q:'$$CHKDATE^DGOTHFS2(+DGRFRELDT\1,.DGSORT)
 I +JJ>0 D SETRF
 Q
 ;
SETRF ;set Refill RX
 S DGNUMOFREF=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,9),U) ;# of refills
 D CPTIER ;extract the copay tier
 S DGDSRF=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,"RF",JJ,1.1),U) ;refill days supply
 D SITE(1) ;extract the site where Rx's released
 S DGFLDTRF=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,"RF",JJ,.01),U) ;refill Fill Date
 S DATA1=DGRXNUM_"("_JJ_")"_U_DGCPTIER_U_DGNUMOFREF_U_DGDSRF_U_DGRXDIV_U_DGFLDTRF_U_DGRFRELDT
 I $G(OTHIBRX) D IBSTAT ;Extract the IB Status in File #350/File #399
 I $P(DGSORT("SORTRXBY"),U)=1 S CNTR=CNTR+1,^TMP($J,"OTHFSMRX",+DGRFRELDT\1,DGRXDIV,DFN,DGRXNUM,CNTR)=DATA1_$S($G(OTHIBRX):U_DATA2,1:"")
 E  S CNTR=CNTR+1,^TMP($J,"OTHFSMRX",DGRXDIV,+DGRFRELDT\1,DFN,DGRXNUM,CNTR)=DATA1_$S($G(OTHIBRX):U_DATA2,1:"")
 S ^TMP($J,"OTHFSMR2","B",DGRXNUM,DGRXIEN,JJ_"R")="" ;marked that this refill RX already been evaluated
 Q
 ;
RXNOSTAT ;Extract those RX's that has not been charge
 N DGRXNUM,DGRXIEN,DGRELDATE,DATA1,DATA2,FILENO,DGTOTRF,JJ,OTHIBDT,DGRFRELDT,ORGRXSTAT,DGPRTLTOT,DGOTHFLGPRTL
 K OTHIBRX
 S (JJ,DGPRTLTOT,DGOTHFLGPRTL)=0
 S DGRXNUM="" F  S DGRXNUM=$O(^TMP($J,"OTHFSMR2","B",DGRXNUM)) Q:DGRXNUM=""  D  Q:DGQ
 . S DGRXIEN="" F  S DGRXIEN=$O(^TMP($J,"OTHFSMR2","B",DGRXNUM,DGRXIEN)) Q:DGRXIEN=""  D  Q:DGQ
 . . K ORGRXSTAT,DGPRTLTOT
 . . S ORGRXSTAT=$P(^TMP($J,"OTHFSMR2","B",DGRXNUM,DGRXIEN),U)
 . . I +ORGRXSTAT<1 D RXNOSTA1
 . . D RXNOSTA2
 . . S DGPRTLTOT=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,"P",0),U) ;total rx partial fill entry/record
 . . I +DGPRTLTOT>0 S DGOTHFLGPRTL=1 D PARTIAL^DGPPOHUT("OTHFSMR2") ;extract rx partial fill. We are still displaying this info though there are no charges generated
 Q
 ;
RXNOSTA1 ;
 S DGRELDATE=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,31),U)
 I +DGRELDATE<1,+$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,32.1),U)>1 S DGRELDATE=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,32.1),U)_"R" ;extract the RETURN TO STOCK date release date/time if the original fill date is missing
 I '$$CHKDATE^DGOTHFS2(+DGRELDATE\1,.DGSORT) Q
 S OTHIBDT=+DGRELDATE\1
 D SORTORRX
 Q
 ;
RXNOSTA2 ;
 ;check if there are any refill charges for this Rx
 S DGTOTRF=+$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,"RF",0),U)
 I +DGTOTRF>0 D
 . F JJ=1:1:DGTOTRF D
 . . Q:$D(^TMP($J,"OTHFSMR2","B",DGRXNUM,DGRXIEN,JJ_"R"))  ;this Refill RX already been evaluated
 . . K DATA1,DATA2,DGRXDIV,DGDSRF,DGRFRELDT,DGFLDTRF
 . . ;rx refill released date/time
 . . S DGRFRELDT=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,"RF",JJ,17),U) ;refill release date/time
 . . I +DGRFRELDT<1,+$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,"RF",JJ,14),U)>1 S DGRFRELDT=$P(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,"RF",JJ,14),U)_"R" ;extract the RETURN TO STOCK date release date/time
 . . S OTHIBDT=+DGRFRELDT\1
 . . Q:'$$CHKDATE^DGOTHFS2(+DGRFRELDT\1,.DGSORT)
 . . I $O(^TMP($J,"OTHFSMR2",DFN,DGRXIEN,""))'["P" D SETRF
 Q
 ;
