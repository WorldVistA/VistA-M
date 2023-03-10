DGOTHFS4 ;SLC/RM - FORMER OTH PP PATIENT UTILITY ; January 20, 2021@9:15 am
 ;;5.3;Registration;**1034,1035,1047**;Aug 13, 1993;Build 13
 ;
 ;Global References      Supported by ICR#                  Type
 ;-----------------      -----------------                  ----------
 ; ^TMP($J               SACC 2.3.2.5.1
 ; ^DGPM("ATID1"         419 (DG is the Custodial Package)  Cont. Sub.
 ;
 ;External References
 ;-------------------
 ; $$GET1^DIQ             2056                              Supported
 ; $$FMTE^XLFDT          10103                              Supported
 ; $$STA^XUAF4            2171                              Supported
 ; $$GETPDX^SDOE          2546                              Supported
 ; $$CODEC^ICDEX          5747                              Cont. Sub.
 ; $$ICDDX^ICDEX          5747                              Cont. Sub. 
 Q
 ;
GETPDX(OEIEN) ;extract the outpatient encounter primary diagnosis
 S (PRIMDX,DXNAME)=""
 S PRIMDX=$$GETPDX^SDOE(OEIEN)
 S PRIMDX=$$CODEC^ICDEX(80,PRIMDX)
 I $P(PRIMDX,U)=-1 S PRIMDX="NONE" Q
 S DXNAME=$$ICDDX^ICDEX(PRIMDX)
 Q
 ;
FLTRENC ;determine whether to prompt the Encounter sorting or not
 N FILENO,SUB1,SUB2,RECNT,ACTYP,RESULT,RXARRAY,RXIBIEN,RXNAME,RXNUMFIL
 S RESULT=0
 S SUB1="" F  S SUB1=$O(@RECORD@(SUB1)) Q:SUB1=""  D
 . S SUB2="" F  S SUB2=$O(@RECORD@(SUB1,SUB2)) Q:SUB2=""  D
 . . S FILENO="" F  S FILENO=$O(@RECORD@(SUB1,SUB2,FILENO)) Q:FILENO=""  D
 . . . S RECNT="" F  S RECNT=$O(@RECORD@(SUB1,SUB2,FILENO,RECNT)) Q:RECNT=""  D
 . . . . S ACTYP=$P(@RECORD@(SUB1,SUB2,FILENO,RECNT),U,7)
 . . . . I FILENO=350!(FILENO=399) D
 . . . . . I FILENO=350 S RESULT=$P($P($P(@RECORD@(SUB1,SUB2,FILENO,RECNT),U,11),";"),":"),RXIBIEN=$P($P($P(@RECORD@(SUB1,SUB2,FILENO,RECNT),U,11),":",2),";")
 . . . . . I FILENO=399 D
 . . . . . . S RXIBIEN=$P($P(@RECORD@(SUB1,SUB2,FILENO,RECNT),U,12),":",3)
 . . . . . . S RXNAME=$P($P($P(@RECORD@(SUB1,SUB2,FILENO,RECNT),U,12),":",4),"-")
 . . . . . . S RXNUMFIL=$P($P(@RECORD@(SUB1,SUB2,FILENO,RECNT),U,12),":",5)
 . . . . . . I +RXIBIEN<1 S RXIBIEN=RXNAME_"("_RXNUMFIL_")"
 . . . . . I ACTYP["RX"!(ACTYP["PRESCRIPTION") D  Q
 . . . . . . I RESULT=350,'$D(RXARRAY(SUB1,RXIBIEN)) S DGTOTALRX=DGTOTALRX+1 ;the patient had record only in file #350
 . . . . . . I FILENO=399,'$D(RXARRAY(SUB1,RXIBIEN)),+RXIBIEN<1 S DGTOTALRX=DGTOTALRX+1 ;the patient had record only in file #399
 . . . . . . I RESULT=52,+$P(^TMP($J,"OTHFSMR2",DGDFN,0),U)<1,'$D(RXARRAY(SUB1,RXIBIEN)) S DGTOTALRX=DGTOTALRX+1 ;has rx record charges in file #350 but those RX charges are not found in file #52
 . . . . . . K @RECORD@(SUB1,SUB2,FILENO,RECNT) ;sort by date of service
 . . . . . . I SORTENCBY=2 K @RECORD1@(SUB2,SUB1,FILENO,RECNT) ;sort by division
 . . . . . . S DGENCNT=DGENCNT-1 ;subtract the # of record of episode of care for this patient since this is rx
 . . . . . . S RXARRAY(SUB1,RXIBIEN)=""
 . . . . . I FILENO=350,RESULT'=350 S DGENCNT=DGENCNT-1 Q  ;result from comes from 405 or 409.68
 . . . . . I FILENO=350,RESULT=350 Q  ;result manually entered from file #350 is already counted
 . . . . . I FILENO=399,+$P(@RECORD@(SUB1,SUB2,FILENO,RECNT),U,17)>1 S DGENCNT=DGENCNT-1 ;file is 399
 K RXARRAY
 Q
 ;
TOTRX ;determine whether to prompt the RX sorting or not
 N DGRXNUM,DGRXIEN,DGRELDATE,DGTOTRF,DGRFRELDT,JJ,RXORFLCNT
 S (DGTOTRX52,RXORFLCNT)=0
 S DGRXNUM="" F  S DGRXNUM=$O(^TMP($J,"OTHFSMR2","B",DGRXNUM)) Q:DGRXNUM=""  D
 . S DGRXIEN="" F  S DGRXIEN=$O(^TMP($J,"OTHFSMR2","B",DGRXNUM,DGRXIEN)) Q:DGRXIEN=""  D
 . . S RXORFLCNT=0
 . . S DGRELDATE=$P(^TMP($J,"OTHFSMR2",DGDFN,DGRXIEN,31),U)
 . . I +DGRELDATE<1,+$P(^TMP($J,"OTHFSMR2",DGDFN,DGRXIEN,32.1),U)>1 S DGRELDATE=$P(^TMP($J,"OTHFSMR2",DGDFN,DGRXIEN,32.1),U),DGRTNSTCK=1 ;extract the RETURN TO STOCK date release date/time if the original fill date is missing
 . . I $$CHKDATE^DGOTHFS2(DGRELDATE\1,.DGSORT) S DGTOTRX52=DGTOTRX52+1,RXORFLCNT=1 ;count total rx
 . . E  D
 . . . ;check if the rx refill is within the date range by the time patient became OTH
 . . . S DGTOTRF=$P(^TMP($J,"OTHFSMR2",DGDFN,DGRXIEN,"RF",0),U)
 . . . I DGTOTRF>0 D
 . . . . F JJ=1:1:DGTOTRF D
 . . . . S DGRFRELDT=+$P(^TMP($J,"OTHFSMR2",DGDFN,DGRXIEN,"RF",JJ,17),U)
 . . . . I +DGRFRELDT<1,+$P(^TMP($J,"OTHFSMR2",DGDFN,DGRXIEN,"RF",JJ,14),U)>1 S DGRFRELDT=$P(^TMP($J,"OTHFSMR2",DGDFN,DGRXIEN,"RF",JJ,14),U),DGRTNSTCK=1 ;extract the RETURN TO STOCK date release date/time
 . . . . Q:$$CHKDATE^DGOTHFS2(DGRFRELDT\1,.DGSORT)
 . . . . I RXORFLCNT,DGRELDATE\1'=DGRFRELDT\1 S DGTOTRX52=DGTOTRX52+1
 Q
 ;
PRINTRX ;display patient's released prescription
 ;display this piece of information to its own page so that the report will not look cluttered
 D RXHDR(0),RXCOL,LINE^DGOTHFS2(1)
 N DGRXNUM,DGRXCNT,SUB1,SUB2,DGNARX,DGCPYTIER,DGRXTOTCNT,DGTOTALRX
 N RXIBBILNO,PRNTDRX,RXNUMBER,RXRELDATE,RXPRVS
 S (DGTOTALRX,DGNARX,RXPRVS)=0
 I $O(^TMP($J,"OTHFSMRX",""))="" D  Q
 . W !!,">> NO DATA FOUND FROM "_$$FMTE^XLFDT(DGSORT("DGBEG"),"5ZF")_" TO "_$$FMTE^XLFDT(DGSORT("DGEND"),"5ZF")_"."
 . W ! D LINE^DGOTHFS2(1) W !
 . S DGTOTALRX=0
 . W !,"Total Number of Rx:    ",+DGTOTALRX,!!!
 ;otherwise, print patient's list of rx's
 S SUB1="" F  S SUB1=$O(^TMP($J,"OTHFSMRX",SUB1)) Q:SUB1=""  D  Q:DGQ
 . S SUB2="" F  S SUB2=$O(^TMP($J,"OTHFSMRX",SUB1,SUB2)) Q:SUB2=""  D  Q:DGQ
 . . S DGRXNUM="" F  S DGRXNUM=$O(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM)) Q:DGRXNUM=""  D  Q:DGQ
 . . . S DGRXCNT="" F  S DGRXCNT=$O(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT)) Q:DGRXCNT=""  D  Q:DGQ
 . . . . I $Y>(IOSL-4) W ! D PAUSE^DGOTHFS2(.DGQ) Q:DGQ  D PTHDR^DGOTHFS2,LINE^DGOTHFS2(0),RXHDR(1),RXCOL,LINE^DGOTHFS2(1)
 . . . . W !
 . . . . S RXNUMBER=$P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U) ;Rx #
 . . . . S RXIBBILNO=$P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,8)
 . . . . I RXIBBILNO="" S RXIBBILNO="NON-VA"_DGRXCNT
 . . . . S RXRELDATE=$P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,7)\1
 . . . . I '$D(PRNTDRX(RXNUMBER,+RXRELDATE)) D PRINTRX1,PRINTRX2
 . . . . I $D(PRNTDRX(RXNUMBER,+RXRELDATE)) D
 . . . . . I RXNUMBER="NON-VA",$G(PRNTDRX(RXNUMBER,+RXRELDATE))'=RXIBBILNO D PRINTRX1,PRINTRX2 Q
 . . . . . I RXNUMBER["P",$G(PRNTDRX(RXNUMBER,+RXRELDATE))=1 Q  ;already printed, do no print again
 . . . . . I $P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,7)["P",$P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,8)="" D  Q  ;if partial and no bill, display the fill and released date only
 . . . . . . I $G(PRNTDRX(RXNUMBER,+RXRELDATE))'=1,RXPRVS'=RXNUMBER D PRINTRX1,PRINTRX2 Q
 . . . . . . W ?49,$$FMTE^XLFDT($P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,6),"5Z") ;fill date
 . . . . . . D PRINTRX3
 . . . . . D PRINTRX2
 . . . . I RXNUMBER="NON-VA",$G(PRNTDRX(RXNUMBER,+RXRELDATE))'=RXIBBILNO S DGNARX=DGNARX+1
 . . . . S DGTOTALRX($P($P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U),"("))=""
 . . . . S PRNTDRX(RXNUMBER,+RXRELDATE)=$S(RXNUMBER="NON-VA":RXIBBILNO,RXNUMBER["P":1,1:"")
 . . . . S RXPRVS=RXNUMBER
 . . . Q:DGQ
 . . Q:DGQ
 . Q:DGQ
 ;if patient had Rx's but the released date is not within date range from the time patient became OTH to PE is verified
 ;those Rx's will not be included into the report
 Q:DGQ
 S DGRXTOTCNT="" F  S DGRXTOTCNT=$O(DGTOTALRX(DGRXTOTCNT)) Q:DGRXTOTCNT=""  D
 . I DGRXTOTCNT="NON-VA" Q
 . S DGTOTALRX=DGTOTALRX+1
 S DGTOTALRX=DGTOTALRX+DGNARX
 I DGTOTALRX<1,DGNARX<1 W !,">> NO DATA FOUND FROM "_$$FMTE^XLFDT(DGSORT("DGBEG"),"5ZF")_" TO "_$$FMTE^XLFDT(DGSORT("DGEND"),"5ZF")_"."
 W ! D LINE^DGOTHFS2(1) W !
 W:DGTOTALRX>0 !,"Total Number of Rx:    ",DGTOTALRX
 I DGTOTALRX<3 W !!!
 K PRNTDRX,DGTOTALRX
 Q
 ;
PRINTRX1 ;
 N TMPRXRLDTE
 W RXNUMBER
 S DGCPYTIER=$P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,2)
 W ?15,$S(DGCPYTIER'="":DGCPYTIER,1:"N/A") ;copay tier
 W ?22,$J($P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,3),2) ;# of refills
 W ?31,$J($P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,4),2) ;days supply
 W ?39,$P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,5) ;division
 W ?49,$$FMTE^XLFDT($P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,6),"5Z") ;fill date
 D PRINTRX3
 Q
 ;
PRINTRX3 ;
 S TMPRXRLDTE=$P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,7)
 W ?61,$$FMTE^XLFDT(+TMPRXRLDTE\1,"5Z") ;rx released date/time
 I TMPRXRLDTE["R" W "R" ;for return to stock
 I TMPRXRLDTE["P" W "P" S $P(RXNUMBER,")")=$P(RXNUMBER,")")_"P" ;for rx partial fill
 Q
 ;
PRINTRX2 ;print the IB status for an RX
 W ?74,$P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,8) ;Bill no
 W ?89,$E($P($P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,9),";"),1,20) ;action type
 W ?111,$E($P(^TMP($J,"OTHFSMRX",SUB1,SUB2,DFN,DGRXNUM,DGRXCNT),U,10),1,20) ;rx IB STATUS
 Q
 ;
RXCOL ;display Rx column name
 W !,"Rx #",?15,"Copay",?22,"# of",?31,"Days",?39,"Division",?49,"Fill Date",?61,"Rx Release",?74,"Bill #",?89,"Action Type/",?111,"IB Status"
 W !,?15,"Tier",?22,"Refills",?31,"Supply",?61,"Date",?89,"Rate Type",!
 Q
 ;
RXHDR(FLAG) ;Released Prescription Header
 N TITLE
 S TITLE="PATIENT'S RELEASED PRESCRIPTION"_$S(FLAG:" - Continuation",1:"")
 W !,?132-$L(TITLE)\2,TITLE,!
 D DTRANGE^DGOTHFS2
 S TITLE="Sorted By: "_$E($P(DGSORT("SORTRXBY"),U,2),4,20)
 I $P(DGSORT("SORTRXBY"),U,2)'="" W ?132-$L(TITLE)\2,TITLE,!
 I $O(^TMP($J,"OTHFSMRX",""))'="" D
 . I $G(DGRTNSTCK)=1,$G(DGPRTLRXFL)=1 W ?39,"'R' = Return Medication To Stock    'P' = Partial Fill",!
 . I $G(DGRTNSTCK)=1,$G(DGPRTLRXFL)=0 W ?48,"'R' = Return Medication To Stock",!
 . I $G(DGRTNSTCK)=0,$G(DGPRTLRXFL)=1 W ?55,"'P' = Partial Fill",!
 D LINE^DGOTHFS2(1)
 Q
 ;
SORTHLP(DGSEL) ;provide extended DIR("?") help test for Encounter and Rx report section
 ; Input: DGSEL - prompt var for help text word selection
 ; Output: none
 S DGSEL=$S(DGSEL=1:"Date of Service",1:"Rx Released Date")
 W !,"  Please Select:"
 W !,"   1.  "_DGSEL
 W !,"       If you want to sort the report by "_DGSEL_", then by Division",!
 W !,"   2.  Division"
 W !,"       If you want to sort the report by Division, then by "_DGSEL
 Q
 ;
ATID1 ;extract the ward and the last user edited the record in file #405
 N ADMDT405,PTMOVIEN
 S PTFIEN405=0,(WRDIEN,LSTUSR,DGDIV,DGDIVNME,DGSTA)=""
 I $D(^DGPM("ATID1",DGDFN)) D
 . S ADMDT405="" F  S ADMDT405=$O(^DGPM("ATID1",DGDFN,ADMDT405)) Q:'+ADMDT405  D
 . . S PTMOVIEN=0 F  S PTMOVIEN=$O(^DGPM("ATID1",DGDFN,ADMDT405,PTMOVIEN)) Q:'PTMOVIEN  D
 . . . I ADMDT=(9999999.9999999-ADMDT405) D
 . . . . K DGOUT,DGOUTERR D GETS^DIQ(405,PTMOVIEN_",",".01;.03;.06;.07;.09;.14;.16;.17;102","IE","DGOUT","DGOUTERR") ;DG is the custodial package for #405, no icr needed
 . . . . S WRDIEN=DGOUT(405,PTMOVIEN_",",.06,"I") ;ward ien points to file #42
 . . . . S LSTUSR=DGOUT(405,PTMOVIEN_",",102,"E") ;last user update the record
 . . . . I WRDIEN'="" D
 . . . . . K DIVINPT D GETS^DIQ(42,WRDIEN_",",".015;.017","IE","DIVINPT") ;extract division name,station number, and treating specialty
 . . . . . S DGDIV=DIVINPT(42,WRDIEN_",",.015,"I") ;division ien - DG is the custodial package for #42, no icr needed
 . . . . . S DGDIVNME=DIVINPT(42,WRDIEN_",",.015,"E") ;division name
 . . . . . S DGSTA=$$STA^XUAF4($$GET1^DIQ(40.8,DGDIV_",",.07,"I"))
 . . . . . I TRTFCLTY="" S TRTFCLTY=DIVINPT(42,WRDIEN_",",.017,"E") ;if treating facility is null get in file #45
 . . . . S PTFIEN405=PTMOVIEN
 Q
 ;
DOS399(FILENO) ;
 N OTHIBDT,OTHIBREC,DGDIVIEN,DGDT,DGSTA,DGSTANAME,DGLSTUSR,DGIBSTPCODE,ACCTYP,TMPDATA,TMPDATA1
 S OTHIBDT="" F  S OTHIBDT=$O(@IBOTHSTAT@(FILENO,OTHIBDT)) Q:OTHIBDT=""  D
 . S OTHIBREC="" F  S OTHIBREC=$O(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC)) Q:OTHIBREC=""  D
 . . S TMPDATA1=$G(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC))
 . . S ACCTYP=$P($P($P(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC),U,5),";"),":",2)
 . . S DGDIVIEN=$P(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC),U,8),DGSTA=$$STA^XUAF4($$GET1^DIQ(40.8,DGDIVIEN_",",.07,"I")) ;station number (eg. 442)
 . . S DGSTANAME=$$GET1^DIQ(40.8,DGDIVIEN_",",.01,"E") ;station name (eg. CHEYENNE VA MEDICAL)
 . . S DGLSTUSR=$P(@IBOTHSTAT@(FILENO,OTHIBDT,DGDFN,OTHIBREC),U,9) ;user entered/edit the record
 . . S TMPDATA=DGSTANAME_U_DGSTA_U_"NON-VA"_U_"N/A"_U_DGLSTUSR_U_DGDIVIEN_U_ACCTYP_U_TMPDATA1
 . . S DGENCNT=DGENCNT+1
 . . S @RECORD@(OTHIBDT,DGSTA,399,DGENCNT)=TMPDATA ;sort by date of service
 . . I SORTENCBY=2 S @RECORD1@(DGSTA,OTHIBDT,399,DGENCNT)=TMPDATA ;sort by division
 Q
 ;
