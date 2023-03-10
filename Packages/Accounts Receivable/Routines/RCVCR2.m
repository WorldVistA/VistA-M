RCVCR2 ;SLC/LLB/JC - First Party Veterans Charge Report ; NOV 30,2020@13:36
 ;;4.5;Accounts Receivable;**373,379**;Mar 20, 1995;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;External References  Type       ICR #
 ;-------------------  ---------- -----
 ; GETS^DIQ            Supported  2056
 ; EN^DIQ1             Supported  10015
 ; RX^PSO52API         Supported  4820
 ; $$FMTE^XLFDT        Supported  10103
 ; $$STRIP^XLFSTR      Supported  10104
 ;
 ;ICR#  TYPE          DESCRIPTION
 ;----- ----------    ---------------------
 ; 7217 Private       File (#399), access to "C" cross-reference and fields (#.08),(#.17),(#18),(#19)
 ; 3820 Private       File (#399), access to fields (#.01),(#.03),(#.05),(#.07),(#.11),(#.13),(#151) and access to (#42) multiple fields: (#.01), (#.03), (#.04), (#.05), (#.1), (#.11)  ;jmc
 ; 1992 Contr. Sub.   File (#399), access to field (#17)
 ; 418  Contr. Sub.   File (#45),  access to discharge Date field (#70), Admission Date Field (#2)  ;jmc
 ; 6033 Contr. Sub.   File (#362.4) access to "C" cross reference and access for fields (#.01), (#.03), (#.04), (#.05), (#.1)
 ;
GET399 ; Insert code to loop through 399 here
 N IBIEN,IBFLDS,BILLCLAS,BILLTYP,BILLNUM,EVNTDT,MULT,X,RCNODE,D1,IBRSC,IBCHRG,IBRXNAM
 N IBUNITS,IBBEDST,IBTYPE,SVCDT,IBSTATNM,CNT,DIC,DR,DA,DIQ,IBBCPR,ARAPPR,ARRSC,ARSTAT,ARIEN
 S IBUNITS=1,(ARSTAT,ARAPPR,ARRSC)=""
 ; Start by using the patient index "C" to get all records for patient
 I '$D(^DGCR(399,"C",DFN)) Q  ;No file 399 records for patient
 S IBIEN=0
 F  S IBIEN=$O(^DGCR(399,"C",DFN,IBIEN)) Q:IBIEN=""  D
 . K IBFLDS,IBERR,IBBEDST
 . ; Fields captured
 . ;    .01 BILL NUMBER [BILLNUM]
 . ;    .03 Event Date  [EVNTDT]
 . ;    .05 Bill Classification  [BILLCLAS]
 . ;    .07 Rate Type
 . ;    .08 PTF Entry Number
 . ;    .11 Who's Responsible for Bill?
 . ;    .13 Status [STAT]
 . ;    .17 Primary Bill [PBILL]
 . ;    151 Statement Covers From  ;jmc
 . ;     42 Revenue Code ([Multiple] capture all fields of all multiples)
 . ;     17 Date Bill Cancelled
 . ;     18 Bill Cancelled By
 . ;     19 Reason Cancelled
 . K DIC,DR,DA,DIQ
 . ;D GETS^DIQ(399,IBIEN_",",".01;.03;.05;.07;.08;.11;.13;.17;17;18;19;42*","IE","IBFLDS","IBERR")
 . D GETS^DIQ(399,IBIEN_",",".01;.03;.05;.07;.08;.11;.13;.17;17;18;19;151;42*","IE","IBFLDS","IBERR")  ;jmc
 . Q:$D(IBERR)
 . S BILLTYP="/"_IBFLDS(399,IBIEN_",",.07,"E")_"/"
 . I "/HUMANITARIAN/INELIGIBLE/MEANS TEST/DENTAL/"'[BILLTYP Q  ;Exclude all but specific Bill Type
 . ; All of these are patient responsibility
 . I IBFLDS(399,IBIEN_",",.11,"I")'="p" Q  ;exclude all but patient responsibility
 . ; Skip all that don't fall into the required rate types
 . ; Determine STATUS and skip any that are not 3 AUTHORIZED,4 PRNT/TX,7 CANCELLED
 . I "/3/4/7/"'[IBFLDS(399,IBIEN_",",.13,"I") Q
 . S BILLCLAS=IBFLDS(399,IBIEN_",",.05,"I")
 . D PROC399
 K XTEMP
 Q
 ;
PROC399 ; Process one 399 record
 ;N XTEMP,IBDISDT,DATEINFO,IBBCNUM,IBPTF,IBXDRG,IENS,IBRXFLG,FLAG399,IBADMDT
 N XTEMP,IBDISDT,DATEINFO,IBBCNUM,IBXDRG,IENS,IBRXFLG,FLAG399  ;jmc
 N IBCANCLD,IBCANCLR,IBCANCLB,ARFLDS
 S FLAG399=0
 S IBSTATNM=IBFLDS(399,IBIEN_",",.13,"E")
 S BILLNUM=IBFLDS(399,IBIEN_",",.01,"E")
 S EVNTDT=IBFLDS(399,IBIEN_",",.03,"I")\1
 S SVCDT=EVNTDT
 S TRIGDT=EVNTDT
 ; If there are more than one RC multiple split them into separate lines
 ; if prescription get info from File 52 especially Release Date
 ; if inpatient get discharge use Event date as Admission date
 I BILLCLAS=1!(BILLCLAS=2) D  ; Inpatient
 . S IBDISDT=""
 . ;S IBPTF=$G(IBFLDS(399,IBIEN_",",.08,"I")) ; Read PTF file
 . ;jmc
 . N IBFROMDT
 . S IBFROMDT=$G(IBFLDS(399,IBIEN_",",151,"I")) ;^DGCR(399,D0,U)= (#151) STATEMENT COVERS FROM [1D] 
 . I IBFROMDT'="" S TRIGDT=IBFROMDT,IBDISDT=IBFROMDT,EVNTDT=IBFROMDT
 . ;I IBPTF'="" S IENS=IBPTF_"," S IBDISDT=$$GET1^DIQ(45,IENS,70,"I",,"45ERR")\1
 . ;I IBDISDT'="" S TRIGDT=IBDISDT  ;jmc
 I (BILLCLAS=1!BILLCLAS=2),(IBDISDT="") Q  ; Inpatient not billed until discharged
 ; Get information from file #430
 I BILLNUM'="" S ARIEN=$O(^PRCA(430,"D",BILLNUM,"")) ;Get IEN to 430 based on bill number
 I BILLNUM'="",$G(ARIEN)'="" D
 . S DIC=430,DR="3;8;203;255.1",DA=ARIEN,DIQ="ARFLDS",DIQ(0)="IE" D EN^DIQ1
 . S (ARSTAT,ARAPPR,ARRSC)=""
 . S ARSTAT=$E($G(ARFLDS(430,ARIEN,8,"E")),1,21) ; AR Status
 . S ARAPPR=$G(ARFLDS(430,ARIEN,203,"E")) ; APPR
 . I ARAPPR="" S ARAPPR="RVW"
 . S ARRSC=$G(ARFLDS(430,ARIEN,255.1,"E")) ; RSC
 . I ARRSC="" S ARRSC="RVW"
 ; Get Cancellation Info
 S IBCANCLD=$G(IBFLDS(399,IBIEN_",",17,"I"))
 S IBCANCLR=$G(IBFLDS(399,IBIEN_",",19,"E"))
 S IBCANCLB=$G(IBFLDS(399,IBIEN_",",18,"E"))
 ;
 I '$D(IBFLDS(399.042)) D  Q  ;Handle no revenue codes
 . I $O(ARFLDS(430,""))="" S IBCHRG=0  ;this is to prevent if ARIEN does not exist or is null and will allow the program to exit gracefully
 . E  S IBCHRG=$G(ARFLDS(430,ARIEN,3,"E")) ; ORIGINAL AMOUNT from #430
 . I IBCHRG="" S IBCHRG=0
 . S IBBCNUM=0
 . ; Get RX infor if any
 . S IBRXFLG=0 ;Flag if RX information
 . I (IBSVCTYP=2!(IBSVCTYP=3)),$D(^IBA(362.4,"C",IBIEN)) S TRIGDT=0 D CHKBCRX Q  ;trigger to display the RX infor if user select Outpatient Medication or Both
 . S TRIGDT=EVNTDT I TRIGDT<FRMDTINT!(TRIGDT>TODTINT) Q
 . I 'IBRXFLG,'$D(^IBA(362.4,"C",IBIEN)) Q:IBSVCTYP=2  D ST399TMP ;display the Medical Care only
 I $D(IBFLDS(399.042)) D RCNODE S FLAG399=1
 Q
 ;
RCNODE ; Capture Revenue Code Node information
 N IBITEM,RCCNT,IBRXDT,RXFLDS
 S IBRXFLG=0,IBRXDT=""
 S X="",MULT=0 F  S X=$O(IBFLDS(399.042,X),-1) Q:X=""  S MULT=MULT+1
 S (IBRSC,IBCHRG,IBUNITS,IBBEDST,IBTYPE,IBITEM,IBBCPR,IBRXFILL,IBRXNUM,RXIEN,RCNODE)=""
 F RCCNT=1:1:MULT D  ; Build a separate line in the report
 . S RCNODE=$O(IBFLDS(399.042,RCNODE))
 . S D1=+RCNODE
 . S IBRSC=IBFLDS(399.042,RCNODE,.01,"E") ;Revenue Source Code
 . I IBRSC="" S IBRSC="RVW"
 . S IBCHRG=IBFLDS(399.042,RCNODE,.04,"E") ; Total Charge
 . S IBUNITS=IBFLDS(399.042,RCNODE,.03,"E") ; Units of service
 . S IBBEDST=IBFLDS(399.042,RCNODE,.05,"E") ; Bed Section 
 . S IBTYPE=IBFLDS(399.042,RCNODE,.1,"E") ; IB Type
 . S IBITEM=IBFLDS(399.042,RCNODE,.11,"I") ; ITEM number (For RX pointer to file #362.4)
 . S SVCDT=EVNTDT
 . I IBSVCTYP=2,$G(IBBEDST)'="PRESCRIPTION" Q  ; Only include 399 RX charges
 . I IBSVCTYP=1,$G(IBBEDST)="PRESCRIPTION" Q  ; Only include 399 non RX charges
 . I $G(IBBEDST)="PRESCRIPTION" D
 . . S DATEINFO="RX/"_"399/"_SVCDT_"/"_SVCDT_"//"
 . . I IBITEM="" D CHKBCRX ; add check of "C" index if IBITEM=""
 . . I IBITEM="" Q
 . . S IBBCPR=IBITEM
 . . K DIC,DR,DA,DIQ,IBERR,RXFLDS
 . . D GETS^DIQ(362.4,IBITEM_",",".01;.03;.04;.1","IE","RXFLDS","IBERR")
 . . Q:$D(IBERR)
 . . S IBRXNUM=RXFLDS(362.4,IBITEM_",",.01,"E") ;RX Number
 . . S IBRXFILL=RXFLDS(362.4,IBITEM_",",.1,"E") ;Fill Number
 . . S IBRXNAM=RXFLDS(362.4,IBITEM_",",.04,"E") ;Drug from file #50
 . . S IBRXDT=RXFLDS(362.4,IBITEM_",",.03,"I") ;IB 362.4 date
 . . I IBRXNUM="" Q
 . . I +IBRXNUM>0 D
 . . . S RXIEN=0 S RXIEN=$$GETIEN52(DFN,IBRXNUM)
 . . . I +RXIEN<1 D  ;If RXIEN is equal to zero, then get all the RX info from file #362.4
 . . . . S RXIEN=+$G(RXFLDS(362.4,IBITEM_",",.01,"I")) ;this RXIEN comes from file 362.4
 . . . . S DATEINFO="RX/"_"399/"_IBRXDT_"/"_IBRXDT_"/"_IBRXNUM_"/"_$E(IBRXNAM,1,16)
 . . . E  S DATEINFO=$$IB399RX(DFN,RXIEN,+IBRXFILL)
 . . I +IBRXNUM'>0 D
 . . . S DATEINFO="RX/"_"399/"_EVNTDT_"/"_EVNTDT_"/"_IBRXNUM_"/"_$E(IBRXNAM,1,16)
 . . S SVCDT=$P(DATEINFO,"/",3)
 . . S TRIGDT=$P(DATEINFO,"/",3)
 . I TRIGDT<FRMDTINT!(TRIGDT>TODTINT) Q
 . I 'IBRXFLG D ST399TMP
 Q
 ;
ST399TMP ; Write one 399 record into TMP file
 N LCNT,LTRFLD,RC430IEN,TLTR,RCTPR399
 S (CNT,RCTPR399)=0
 S IBBEDST=$G(IBBEDST)
 I $D(^TMP($J,"RCVCR",BILLNUM,SVCDT)) S CNT="" S CNT=$O(^TMP($J,"RCVCR",BILLNUM,SVCDT,CNT),-1)+1
 S XTEMP=399_U_IBIEN_U ; Pos 1-3 FILE^IBIEN^IB Ref #
 S XTEMP=XTEMP_U ;Pos 4 Parent Charge 
 S XTEMP=XTEMP_U ;Pos 5 Parent Event
 S XTEMP=XTEMP_U_"*"_IBSTATNM_U_IBUNITS ;Pos 6 IB STATUS Pos 7 Units
 S XTEMP=XTEMP_U_IBCHRG ;Pos 8 Total Charge
 S XTEMP=XTEMP_U_BILLNUM ;Pos 9 AR Bill #
 S XTEMP=XTEMP_U_$P(BILLTYP,"/",2) ;Pos 10 Category
 I IBBEDST'="PRESCRIPTION" S XTEMP=XTEMP_U_$$STRIP^XLFSTR($$FMTE^XLFDT(SVCDT,"8D")," ")_U_U_U ;Pos 11  Medical DOS Pos 12-14 blank
 I IBBEDST="PRESCRIPTION" D
 . I $P(DATEINFO,"/",5)="" S XTEMP=XTEMP_U_U_$$STRIP^XLFSTR($$FMTE^XLFDT(SVCDT,"8D")," ")_U_U ; Medical DOS if RX info missing
 . I $P(DATEINFO,"/",5)'="" D
 . . S XTEMP=XTEMP_U_U_$$STRIP^XLFSTR($$FMTE^XLFDT(SVCDT,"8D")," ") ;Pos 11 blank Pos 12 Release RX Date
 . . S XTEMP=XTEMP_U_$P(DATEINFO,"/",5)_U_$P(DATEINFO,"/",6) ;Pos 13 RX Number, Pos 14 RX Name
 S XTEMP=XTEMP_U_$E($G(ARSTAT),1,21) ;Pos 15 AR Status ;Pos 15 AR Status
 S XTEMP=XTEMP_U_$$STRIP^XLFSTR($$FMTE^XLFDT($G(IBCANCLD),"8D")," ") ;Pos 16 Cancel Dt
 S XTEMP=XTEMP_U_$E($G(IBCANCLR),1,14) ;Pos 17 Cancel Reason
 S XTEMP=XTEMP_U_$E($G(IBCANCLB),1,16) ;Pos 18 Cancel By
 S XTEMP=XTEMP_U_$G(ARAPPR) ;Pos 19 APPR
 S XTEMP=XTEMP_U_$G(ARRSC)  ;Pos 20 RSC
 ;Get Letter dates if they exist
 I BILLNUM'="" S RC430IEN=$O(^PRCA(430,"D",BILLNUM,""))
 K ARFLDS
 S DIC=430,DR="61:63;68",DA=$S($G(RC430IEN)'="":RC430IEN,1:$G(BILLNUM)),DIQ="ARFLDS",DIQ(0)="I" D EN^DIQ1
 S LCNT=0
 F LTRFLD=61,62,63,68 D
 . I $G(RC430IEN)="" Q
 . I $G(LETTER)'=1 Q  ;JMC If LETTER'=1 Q (Do not display letters)
 . S LCNT=LCNT+1 S TLTR="LTR"_LCNT
 . S @TLTR=ARFLDS(430,RC430IEN,LTRFLD,"I")
 . I @TLTR'="" S XTEMP=XTEMP_U_$$STRIP^XLFSTR($$FMTE^XLFDT(@TLTR,"8D")," ") ; Pos 21-24 Letter 1-4
 . I @TLTR="" S XTEMP=XTEMP_U_"NO DATE" ; Pos 21-24 Letter 1-4
 I +XTEMP=399,$P(XTEMP,U,12)'="",$P(XTEMP,U,13)="" S $P(XTEMP,U,13)="PHARMACY"
 I $G(LETTER)=2 D  ;user wants to display Total Payments Received on Bill Number
 . S RCTPR399=+$P($G(^PRCA(430,RC430IEN,7)),"^",7)
 . S XTEMP=XTEMP_U_RCTPR399
 S ^TMP($J,"RCVCR",BILLNUM,SVCDT,CNT)=XTEMP
 K XTEMP
 Q
 ; Determine type of bill and the appropriate date falls within the desired date range
 ; What date do we use for selection / display?
 ;   Use event date except for RX (Release DT) and 
 ;      Inpatient (Discharge DT)for selection and Event Dt for (Admission DT) for display
 ; For Inpatient
 ; #399 Field .08 Pointer to PTF (Patient Transfer File #45) to get Admission and discharge DT 
 ; For RX
 ; Check RC Multiples for BEDSECTION=Prescription  & TYPE=RX then ITEM is an IEN to file #362.4
 ; #362.4 will have an RX# to lookup in file #52 and a FILL NUMBER (0 or null if original RX or a
 ; positive refill number) and if a fill number is present check the appropriate refill in #52
 ; check status for inclusion
 ;
IB399RX(DFN,RXIEN,IBRXFILL) ; Get Prescription information for 399 bills.
 N RESPONSE,RXNODE,IBRXNAME,IBRXNUM,RXDATE
 K ^TMP($J,"RXRDT")
 S RESPONSE=""
 S RXNODE="0,2"
 I IBRXFILL>0 S RXNODE="0,2,R^^"_IBRXFILL
 D RX^PSO52API(DFN,"RXRDT",RXIEN,,RXNODE,,)
 I +$G(^TMP($J,"RXRDT",DFN,0))=-1 S RESPONSE="RX/"_"399#/"_$P(^TMP($J,"RXRDT",DFN,0),U,2) Q RESPONSE
 I IBRXFILL>0 S RXDATE=$P($G(^TMP($J,"RXRDT",DFN,RXIEN,"RF",IBRXFILL,17)),U,1)
 E  S RXDATE=$P($G(^TMP($J,"RXRDT",DFN,RXIEN,31)),U,1)
 S RXDATE=RXDATE\1
 I 'RXDATE S RXDATE=$G(IBRXDT)\1
 S IBRXNUM=$S(+RXIEN<1:RXFLDS(362.4,RXITEM_",",.01,"E"),1:^TMP($J,"RXRDT",DFN,RXIEN,.01))
 S IBRXNAME=$S(+RXIEN<1:RXFLDS(362.4,RXITEM_",",.04,"E"),1:$P(^TMP($J,"RXRDT",DFN,RXIEN,6),U,2))
 S RESPONSE="RX/"_"399/"_RXDATE_"/"_RXDATE_"/"_IBRXNUM_"/"_$E(IBRXNAME,1,16)
 S TRIGDT=$P(RESPONSE,"/",3)
 I TRIGDT<FRMDTINT!(TRIGDT>TODTINT) S RESPONSE="RX/"_"399#"_"/DATE NOT IN RANGE" Q RESPONSE
 Q RESPONSE
 ;
CHKBCRX ;
 N RXITEM
 S IBBCNUM=0
 F  S IBBCNUM=$O(^IBA(362.4,"C",IBIEN,IBBCNUM)) Q:IBBCNUM=""  D
 . S IBRXFLG=1,RXITEM=IBBCNUM
 . S DATEINFO=""
 . S IBERR=""
 . K RXFLDS D GETS^DIQ(362.4,RXITEM_",",".01;.03;.04;.05;.1","IE","RXFLDS","IBERR")
 . I IBERR Q
 . S IBRXNUM=RXFLDS(362.4,RXITEM_",",.01,"E") ;RX Number
 . S IBRXFILL=RXFLDS(362.4,RXITEM_",",.1,"E") ;Fill Number
 . S IBRXDT=RXFLDS(362.4,RXITEM_",",.03,"I") ;IB 362.4 date
 . S IBRXNAM=RXFLDS(362.4,RXITEM_",",.04,"E") ;Drug from file #50 
 . S RXIEN=RXFLDS(362.4,RXITEM_",",.05,"I") ;IEN into file 52
 . S DATEINFO=$$IB399RX(DFN,RXIEN,IBRXFILL)
 . S TRIGDT=$P(DATEINFO,"/",3)
 . I TRIGDT<FRMDTINT!(TRIGDT>TODTINT) Q
 . S SVCDT=$P(DATEINFO,"/",3)
 . I $G(IBBEDST)="" S IBBEDST="PRESCRIPTION" ;this will prevent for the RX's data to be displayed if user select service type of Medical Care
 . D ST399TMP
 Q
 ;
GETIEN52(RCDFN,RCRX) ;return IEN for #52 by RX# and DFN
 N RCRET
 K ^TMP($J,"RCPRRX")
 D RX^PSO52API(RCDFN,"RCPRRX",,RCRX,"0")
 I +$G(^TMP($J,"RCPRRX",RCDFN,0))=-1 Q 0
 S RCRET=+$O(^TMP($J,"RCPRRX",RCDFN,0))
 K ^TMP($J,"RCPRRX")
 Q RCRET
 ;
