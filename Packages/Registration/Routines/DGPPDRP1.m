DGPPDRP1 ;SLC/RM - PRESUMPTIVE PSYCHOSIS DETAIL REPORT CONTINUATION ; Dec 21, 2020@10:00 am
 ;;5.3;Registration;**1035**;Aug 13, 1993;Build 14
 ;
 ;External References    Supported by ICR#    Type
 ;-------------------    -----------------    ---------
 ; $$GET1^DIQ             2056                Supported
 ; ^DIR                  10026                Supported
 ; $$CPTIER^PSNAPIS       2531                Supported
 ; PSS^PSO59              4827                Supported
 ; NDF^PSS50              4533                Supported
 ; 2^VADPT               10061                Supported
 ; $$FMTE^XLFDT          10103                Supported
 Q
 ;
PRNTENC(TMPDATA,ENCDT) ;continuation of ENCTR tag found in DGOTHFS2
 N RECNUM,RSLTFRMOE,TRUE,AMOUNT
 S TRUE=0
 I $Y>(IOSL-4) W ! D PAUSE(.DGQ) Q:DGQ  D PTHDR,LINE(0),ENCHDR(1),ENCTRCOL,LINE(1)
 I FILENO=350!(FILENO=399) D
 . S AMOUNT=0
 . I OLDBILL'=NWBILL S TRUE=1 D DSPLAY
 . I OLDBILL=NWBILL,OLDOEDT'=DGPPDOS S TRUE=1 D DSPLAY
 . I 'TRUE  W !
 . I FILENO=350 D
 . . W ?73,$E($P(TMPDATA,U,7),1,15) ;charge type
 . . W ?89,$S(NWBILL=0:"",1:NWBILL) ;bill no
 . . S AMOUNT=$$DOLLAR^DGPPRRPT($TR($P(TMPDATA,U,12),"$(),","")) ;format the charge amount
 . . W ?102,$J($TR(AMOUNT,"$()",""),14) ;charge amount
 . . W ?116,$E($P(TMPDATA,U,13),1,15) ;IB status
 . I FILENO=399 D
 . . W ?73,$E($P(TMPDATA,U,9),1,15) ;rate type
 . . W ?89,$S(NWBILL=0:"",1:NWBILL) ;bill no
 . . S AMOUNT=$$DOLLAR^DGPPRRPT($P(TMPDATA,U,13)) ;format the charge amount
 . . W ?102,$J($TR(AMOUNT,"$()",""),14) ;charge amount
 . . W ?116,$E($P(TMPDATA,U,14),1,15) ;IB status
 E  D
 . D DSPLAY
 . S TRUE=0
 . I $O(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT,""))'="" D
 . . S RECNUM="" F  S RECNUM=$O(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT,RECNUM)) Q:RECNUM=""  D
 . . . I TRUE W !
 . . . S AMOUNT=0
 . . . S RSLTFRMOE=$P(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT,RECNUM),U,5)
 . . . I $P(RSLTFRMOE,":")=405!($P(RSLTFRMOE,":")=409.68)!($P(RSLTFRMOE,":")=45) W ?73,$E($P(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT,RECNUM),U),1,15) ;charge type from file #350
 . . . E  W ?73,$E($P(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT,RECNUM),U,2),1,15) ;rate type from file #399
 . . . W ?89,$P(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT,RECNUM),U,4) ;bill no
 . . . S AMOUNT=$$DOLLAR^DGPPRRPT($TR($P(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT,RECNUM),U,6),"$(),","")) ;format the charge amount
 . . . W ?102,$J($TR(AMOUNT,"$()",""),14) ;copay amount
 . . . W ?116,$E($P(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT,RECNUM),U,7),1,15) ;IB status
 . . . I $D(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT+1)),'PRNTSEC D  Q  ;this means the record has secondary stop code
 . . . . S TMPDATA=@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT+1)
 . . . . W !,?20,$E($P(TMPDATA,U,4),1,18) S TRUE=0,PRNTSEC=1 ;display the secondary stop code first before displaying the other statuses
 . . . S TRUE=1 ;this flag determine when to write a new line
 Q
 ;
DSPLAY ;display episode of care data
 N DGAPPTYP,DGEOIEN
 I FILENO=409.68,$P(TMPDATA,U,10)'=1 D  Q  ;this means that the record belongs to a secondary stop code, as per business owner, only display the stop code name and leave out the rest
 . I 'PRNTSEC D
 . . I $D(OUTPATARY($P(TMPDATA,U,3),ENCDT\1)) W !,?20,$E($P(TMPDATA,U,4),1,18) Q
 . . D DSPLAY1
 . S PRNTSEC=0
 I FILENO=405,$P(TMPDATA,U,10)>1 D  Q   ;this means that the record belongs to a secondary stop code (inpatient outpatient encounter) 
 . I $O(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT,""))="" W !,?20,$E($P(TMPDATA,U,4),1,18)
 D DSPLAY1
 S DGTOTENC=DGTOTENC+1
 Q
 ;
DSPLAY1 ;
 W !,$E($P(TMPDATA,U,3),1,18) ;clinic name/Location of care
 W ?20,$E($P(TMPDATA,U,4),1,18) ;clinic stop code/treating specialty
 I FILENO=350!(FILENO=399) W ?40,"N/A" ;Primary/Principal diagnosis
 I FILENO=409.68 W ?40,$P(TMPDATA,U,9) ;Primary/Principal diagnosis
 I FILENO=405 W ?40,$S($P(TMPDATA,U,9)'="":$P(TMPDATA,U,9),1:$P(TMPDATA,U,8)) ;Primary/Principal diagnosis
 W ?50,$$FMTE^XLFDT(ENCDT\1,"5ZF") ;Appt. Date/Time or Date of Service
 S DGEOIEN=$P(TMPDATA,U,7)
 S DGAPPTYP=$$GET1^DIQ(409.68,DGEOIEN_",",.1,"E")
 S DGAPPTYP=$S(DGAPPTYP'="":DGAPPTYP,1:"N/A")
 ;Appointment type
 I DGAPPTYP="COMPENSATION & PENSION" S DGAPPTYP="COMP & PEN"
 I DGAPPTYP="CLASS II DENTAL" S DGAPPTYP="CLASS II"
 I DGAPPTYP="ORGAN DONORS" S DGAPPTYP="ORGAN DONOR"
 I DGAPPTYP="SHARING AGREEMENT" S DGAPPTYP="SHARING AG"
 I DGAPPTYP="COLLATERAL OF VET." S DGAPPTYP="COLLATERAL"
 I DGAPPTYP="COMPUTER GENERATED" S DGAPPTYP="COMPUTER"
 I DGAPPTYP="SERVICE CONNECTED" S DGAPPTYP="SERVICE CON"
 W ?61,$E(DGAPPTYP,1,10) ;appointment type
 S OUTPATARY($P(TMPDATA,U,3),ENCDT\1)=""
 Q
 ;
LINE(FLAG) ;prints double dash line
 N LINE
 I FLAG<1 F LINE=1:1:132 W "="
 E  F LINE=1:1:132 W "-"
 Q
 ;
PTHDR(TITLE) ;patient name and DOB header
 S TITLE=$G(TITLE)
 I $G(TRM)!('$G(TRM)&DGPAGE) W @IOF
 I $L(TITLE) W ?132-$L(TITLE)\2,TITLE W !
 S DGPAGE=$G(DGPAGE)+1
 I '$D(VADM) D 2^VADPT
 W "Patient Name:  ",DGPTNM_"  ("_DGPID_")",?112,"DOB:  ",$P(VADM(3),U,2),!
 Q
 ;
ENCTRCOL ;display encounter column name
 W !,"Location of",?20,"Stop Code Name/",?40,"Primary",?50,"Date of",?61,"Appt. Type",?73,"Charge Type/",?89,"Bill #",?102,"Charge Amount",?116,"IB Status"
 W !,"Care",?20,"Treating Specialty",?40,"DX",?50,"Service",?73,"Rate Type",!
 Q
 ;
ENCHDR(FLAG) ;Encounter Header
 N TITLE
 S TITLE="PATIENT'S EPISODE OF CARE"_$S(FLAG:" - Continuation",1:"")
 W !,?132-$L(TITLE)\2,TITLE,!
 D DTRANGE
 D LINE(1)
 Q
 ;
DTRANGE ;display date range
 N DTRANGE
 S DTRANGE="Date Range: "_$$FMTE^XLFDT(DGSORT("DGBEG"),"5ZF")_" - "_$$FMTE^XLFDT(DGSORT("DGEND"),"5ZF")
 W ?132-$L(DTRANGE)\2,DTRANGE,!
 Q
 ;
PAUSE(DGQ) ; pause screen display
 N J
 I $Y<(IOSL-4) D
 . F J=1:1 Q:($Y>(24-4))  W !
 I $G(DGPAGE)>0,TRM,$$E("Press <Enter> to continue or '^' to exit:")<1 S DGQ=1
 Q
 ;
E(MSG) ; ----- ask user to press enter to continue
 ;  Return: -2:Time-out; -1:'^'-out  1:anything else
 S MSG=$G(MSG)
 N X,Y,Z,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="EA"
 I $L(MSG) S DIR("A")=MSG
 D ^DIR
 S X=$S($D(DTOUT):-2,$D(DUOUT):-1,1:1)
 Q X
 ;
PARTIAL(LIST) ;extract rx partial fill for this patient
 N JJJ,DGPRTLDT,DGPRTLDIV,DGPRTLSTA,DGPRTLSTN,DGPRTLUSR,DGPRTLTOT
 S DGPRTLTOT=$P(^TMP($J,LIST,DGDFN,DGRXIEN,"P",0),U) ;total rx partial fill entry/record
 I DGPRTLTOT>0 D
 . F JJJ=1:1:DGPRTLTOT D
 . . S DGPRTLDT=$P($G(^TMP($J,LIST,DGDFN,DGRXIEN,"P",JJJ,8)),U) ;Rx partial fill released date
 . . I +DGPRTLDT<1,+$P(^TMP($J,LIST,DGDFN,DGRXIEN,"P",JJJ,5),U)>1 S DGPRTLDT=+$P(^TMP($J,LIST,DGDFN,DGRXIEN,"P",JJJ,5),U) ;extract the Rx Partial Fill RETURN TO STOCK date
 . . Q:'$$CHKDATE^DGOTHFSM(+DGPRTLDT\1,DGOTHREGDT,DGELGDTV)
 . . S DGPRTLDIV=+$P(^TMP($J,LIST,DGDFN,DGRXIEN,"P",JJJ,.09),U) ;rx partial fill division ien
 . . K ^TMP($J,"PSOSITERF") D PSS^PSO59(DGPRTLDIV,,"PSOSITERF") S DGPRTLSTA=$G(^TMP($J,"PSOSITERF",DGPRTLDIV,.06)) ;station number
 . . S DGPRTLSTN=$P(^TMP($J,LIST,DGDFN,DGRXIEN,"P",JJJ,.09),U,2) ;rx partial fill division name
 . . S DGPRTLUSR=$P(^TMP($J,LIST,DGDFN,DGRXIEN,"P",JJJ,.05),U,2) ;pharmacist entered this rx partial fill
 . . S DGPRTLUSR=$S(DGPRTLUSR="":"UNKNOWN",1:DGPRTLUSR)
 . . S DGENCNT=DGENCNT+1
 . . S @RECORD@(+DGPRTLDT\1,DGPRTLSTA,52,DGENCNT)=DGPRTLSTN_U_DGPRTLSTA_U_$S(DGCLNC'="":DGCLNC,1:"NON-VA")_U_"N/A"_U_DGPRTLUSR_U_DGPRTLDIV_U_"RX - "_DGRXNUM_":"_DGRXIEN
 K ^TMP($J,"PSOSITERF")
 Q
 ;
CPTIER ;extract Rx Copay Tier
 N DGDRUGIEN
 K ^TMP($J,"OTHCPTIER"),DGCPTIER
 S DGDRUGIEN=$P(^TMP($J,"DGPPDRX52",DFN,DGRXIEN,6),U)
 D NDF^PSS50(DGDRUGIEN,"","","","","OTHCPTIER")
 ;look up the tier of the prescription
 ;returns the tier level of the specified prescription
 ;default tier is always 2
 S DGCPTIER=$P(^TMP($J,"OTHCPTIER",DGDRUGIEN,20),U)
 S DGCPTIER=$S(DGCPTIER:$P($$CPTIER^PSNAPIS(DGCPTIER,DT,DGDRUGIEN,1),U),1:2)
 K ^TMP($J,"OTHCPTIER")
 Q
 ;
