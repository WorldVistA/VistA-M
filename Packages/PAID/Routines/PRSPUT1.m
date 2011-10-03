PRSPUT1 ;WOIFO/MGD - PART TIME PHYSICIAN UTILITIES #1 ;05/17/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;The following routine contains various utilities for the  Part Time
 ;Physician functionality that was added as part of patch PRS*4.0*93.
 ;
 ;----------------------------------------------------------------------
 ; Determine the IEN of the PT Physician's memorandum if any for the
 ; current date or the date specified in the MDAT parameter.
 ; Input: PTPIEN - IEN of the PT Physician
 ;          MDAT - Optional - date within memorandum in FileMan format
 ;
 ; Output: IEN^STATUS
 ;         IEN - of the PT Phy's memorandum in the #458.7 file or 0
 ;      STATUS - of the memorandum
 ;-----------------------------------------------------------------------
MIEN(PRSIEN,MDAT) ;
 Q:'PRSIEN 0_"^"
 N ENDAT,MDATA,QUIT,STATUS,STDAT,TDAT,MIEN
 S MDAT=$G(MDAT,DT)
 S (MIEN,QUIT)=0
 F  S MIEN=$O(^PRST(458.7,"B",PRSIEN,MIEN)) Q:'MIEN  D  Q:QUIT
 . S MDATA=$G(^PRST(458.7,MIEN,0))
 . S STDAT=$P(MDATA,U,2)                  ; START DATE OF MEMORANDUM
 . S ENDAT=$P(MDATA,U,3)                  ; END DATE OF MEMORANDUM
 . S STATUS=$P(MDATA,U,6)                 ; STATUS OF MEMORANDUM
 . S TDAT=$P($G(^PRST(458.7,MIEN,4)),U,1) ; TERMINATION DATE
 . I TDAT D
 . . I TDAT<ENDAT S ENDAT=TDAT
 . I MDAT'<STDAT,MDAT'>ENDAT S QUIT=1
 I MIEN="" S MIEN=0,STATUS=0
 Q MIEN_"^"_STATUS
 ;
 ;-----------------------------------------------------------------------
 ;Display information on a PT Physician's memoranda
 ; Input: PRSIEN - IEN of the PT Physician.
 ;        SCRTTL - Title for the screen.
 ;         ARRAY - The array where the message to be printed will be
 ;                 stored. (optional) If not specified, no array will
 ;                 be created.
 ;         INDEX - The index where the array will start. (optional) This
 ;                 will be set to 1 if no index is passed.
 ;           PPI - Optional: IEN of the desired PP.  If supplied, the
 ;                 external format will be displayed on line 
 ;
 ; Output: VA header, screen title and 10 fields to identify the PT Phy
 ;         Array with the same data if the ARRAY parameter is passed.
 ;-----------------------------------------------------------------------
HDR(PRSIEN,SCRTTL,ARRAY,INDEX,PPI) ;
 Q:'PRSIEN
 S SCRTTL=$G(SCRTTL,"")
 S ARRAY=$G(ARRAY,"")
 I $G(INDEX)="",($G(ARRAY)'="") D INDEX
 N C0,DATE,PPE,SSN,TAB,TEXT,X,YR
 I $G(PPI)="" D  ; If no PPI passed in get last PP in #459
 . S PPE="A",PPE=$O(^PRST(459,PPE),-1)
 . S PPE=$P($G(^PRST(459,PPE,0)),U,1)
 I $G(PPI)>0 S PPE=$P($G(^PRST(458,PPI,0)),U,1)
 S TEXT="PP:"_PPE,$E(TEXT,26)="",TEXT=TEXT_"VA TIME & ATTENDANCE SYSTEM"
 D NOW^%DTC
 S YR=%I(3)+1700,YR=$E(YR,3,4)
 S DATE=%I(1)_"/"_%I(2)_"/"_YR
 S $E(TEXT,73)="",TEXT=TEXT_DATE
 D A1 ; Line #1
 S TAB=39-($L(SCRTTL)\2)
 S $E(TEXT,TAB)="",TEXT=TEXT_SCRTTL
 D A1 ; Line #2
 S C0=^PRSPC(PRSIEN,0)
 S TEXT=$P(C0,U,1),$E(TEXT,70)=""
 S SSN=$P(C0,U,9)
 S SSN="XXX-XX-"_$E(SSN,6,9)
 S TEXT=TEXT_SSN
 D A1 ; Line #3
 S TEXT="Pay Plan: "_$P(C0,"^",21)_"     Duty Basis: "_$P(C0,"^",10)
 S TEXT=TEXT_"     FLSA: "_$P(C0,"^",12)_"     Normal Hours: "
 S TEXT=TEXT_$J($P(C0,"^",16),3)_"     Comp/Flex: "
 S TEXT=TEXT_$P($G(^PRSPC(PRSIEN,1)),"^",7)
 D A1 ; Line #4
 S TEXT="T&L: "_$P(C0,"^",8),$E(TEXT,69)=""
 S TEXT=TEXT_"Station: "_$P(C0,"^",7)
 D A1 ; Line #5
 K INDEX,%I
 Q
 ;
 ;-----------------------------------------------------------------------
 ; Display information on a PT Physician's memoranda
 ; Input: PRSIEN - IEN of the PT Physician
 ;          MIEN - IEN of the PT Phy's memorandum in #458.7
 ;         ARRAY - The array where the message to be printed will be
 ;                 stored. (Optional) If not specified, no array will
 ;                 be created.
 ;         INDEX - The index where the array will start. (optional) This
 ;                 will be set to 1 if no index is passed.
 ;         HRSCO - Carrryover Hours from a prior memorandum. (optional)
 ;
 ; Output: 4 line summary of the PT Phy's current memorandum
 ;         Array with the same data if the ARRAY parameter is passed.
 ;-----------------------------------------------------------------------
MEM(PRSIEN,MIEN,ARRAY,INDEX,HRSCO) ;
 Q:'PRSIEN&('MIEN)
 I $G(INDEX)="",($G(ARRAY)'="") D INDEX
 N AHRS,AHTCM,COHRS,DATA,EDAT,ENDDAT,HRSWK,HTSHBW,I,IEN458,LASTDAY,LASTPP
 N LASTPPE,LPPP,NPHRS,OTHRS,POHC,POMC,POT,PPP,QUIT,TAB,TDAT,TDATEX,TEXT
 N THRSWK,TTEXT,WPHRS
 ; Load 0 node from #458.7.  Quit if it doesn't exist
 S DATA=$G(^PRST(458.7,MIEN,0))
 Q:DATA=""
 ; Determine last PP processed
 S LASTPP="A"
 S LASTPP=$O(^PRST(459,LASTPP),-1)
 Q:'LASTPP
 S LASTPPE=$P(^PRST(459,LASTPP,0),U,1)
 S IEN458="",IEN458=$O(^PRST(458,"B",LASTPPE,IEN458))
 Q:'IEN458
 S LASTDAY=$P($G(^PRST(458,IEN458,2)),U,14)
 S TTEXT="Memorandum & Leave Status thru PP "_LASTPPE_" Ending "_LASTDAY
 S TAB=40-($L(TTEXT)\2)
 S $E(TEXT,TAB)="",TEXT=TEXT_TTEXT
 D A1 ; Line #1
 S Y=$P(DATA,U,2) ;       START DATE
 D DD^%DT
 S STDAT=Y
 S (EDAT,Y)=$P(DATA,U,3) ;       END DATE
 D DD^%DT
 S ENDDAT=Y
 ; Check for Termination
 S (TDAT,Y)=+$G(^PRST(458.7,MIEN,4))
 D DD^%DT
 S TDATEX=Y ; Termination Date External
 S AHRS=$P(DATA,U,4)   ; AGREED HOURS
 S COHRS=$P(DATA,U,9)  ; CARRYOVER HOURS
 S HRSCO=$G(HRSCO,0)   ; HRS CARRIED OVER FROM PRIOR MEMO
 S NPHRS=$P(DATA,U,12) ; NON-PAY HOURS
 S WPHRS=$P(DATA,U,13) ; WITHOUT PAY HOURS
 S THRSWK=0.00 ; TOTAL HOURS WORKED
 S POMC=0.00  ;   PERCENTAGE OF MEMORANDA COMPLETED
 S POHC=0.00  ;   PERCENTAGE OF HOURS COMPLETED
 S AHTCM=0.00 ;  AVERAGE HOURS TO COMPLETE MEMORANDUM
 S POT=0.00   ;    % OFF TARGET
 S OTHRS=0.00 ;  OFF TARGET HOURS
 S HRSWK=0.00 ;  HRS TOTAL FROM WORKED PAY PERIODS
 ;
 S $E(TEXT,2)="",TEXT=TEXT_"Start Date: "_STDAT
 S $E(TEXT,29,31)="|  ",TEXT=TEXT_"Agreed Hours: "_$J(AHRS,7,2)
 S $E(TEXT,55,57)="|  ",TEXT=TEXT_"      LWOP Hrs: "_$J(WPHRS,7,2)
 D A1 ; Line #2
 ;
 S LPPP=$$MEMCPP^PRSPUT3(MIEN)
 S PPP=$P(LPPP,U,2),LPPP=$P(LPPP,U,1)
 ; Check to see if last PP certified in #458 is in #459
 I LPPP'="",'$D(^PRST(459,"B",LPPP)) S PPP=PPP-1
 ; Loop to determine the total hours worked from multiple
 F I=1:1:PPP D
 . S HRSWK=HRSWK+$$GET1^DIQ(458.701,I_","_MIEN_",",1)
 S THRSWK=HRSWK+COHRS+HRSCO ; Adjust for carryover hours
 ; Hrs That Should Have Been Worked - has any NP and WP included
 S HTSHBW=((AHRS/26)*PPP)-NPHRS-WPHRS
 S OTHRS=THRSWK-HTSHBW
 S POHC=THRSWK/(AHRS-NPHRS-WPHRS)*100 ; Adjust % or Hrs Completed
 ; Only calculate the following if memo has started and not ended
 I PPP,PPP<26 D
 . I HTSHBW'=THRSWK D  ; PTP has worked more or less than Ave Hrs/PP
 . . I THRSWK'<(AHRS-NPHRS-WPHRS) S AHTCM=0
 . . I THRSWK<(AHRS-NPHRS-WPHRS) S AHTCM=AHRS-THRSWK-NPHRS-WPHRS/(26-PPP)
 . . S POT=(AHRS/26*PPP)-WPHRS-NPHRS
 . . S POT=THRSWK-POT/POT,POT=POT*100
 . I HTSHBW=THRSWK D  ; PTP has worked exactly Ave Hrs/PP
 . . S AHTCM=AHRS-THRSWK-WPHRS-NPHRS/(26-PPP)
 . . S POT=0
 I PPP=26 D  ; Memo has ended
 . S AHTCM=0
 . S POT=(AHRS/26*PPP)-WPHRS-NPHRS
 . S POT=THRSWK-POT/POT,POT=POT*100
 I PPP=0 D  ; 1st PP hasn't been processed
 . S AHTCM=AHRS-COHRS/26
 . S POT=0
 I TDAT D
 . S $E(TEXT,2)="",TEXT=TEXT_"TERMINATED: "_TDATEX
 I TDAT=0 S $E(TEXT,4)="",TEXT=TEXT_"End Date: "_ENDDAT
 S $E(TEXT,29,31)="|  ",TEXT=TEXT_"Hours Worked: "_$J(HRSWK,7,2)
 S $E(TEXT,55,57)="|  ",TEXT=TEXT_"   Non Pay Hrs: "_$J(NPHRS,7,2)
 D A1 ; Line #3
 ;
 S POMC=PPP_" of 26 PP = "_$J(100*(PPP/26),6,2)_"%"
 I PPP<10 S $E(TEXT,6)="",TEXT=TEXT_POMC
 I PPP>9 S $E(TEXT,5)="",TEXT=TEXT_POMC
 S $E(TEXT,29,30)="| "
 S TEXT=TEXT_"Carryover Hrs: "_$J($S(HRSCO:HRSCO,1:COHRS),7,2)
 S $E(TEXT,55,57)="|  ",TEXT=TEXT_"Off Target Hrs: "_$J(OTHRS,7,2)
 D A1 ; Line #4
 ;
 S TEXT="% Hrs Completed = "_$J(POHC,6,2)_"%"
 S $E(TEXT,29,31)="|  ",TEXT=TEXT_"   Total Hrs: "
 S TEXT=TEXT_$J(THRSWK,7,2)
 S $E(TEXT,55,57)="|  ",TEXT=TEXT_"  Off Target %: "_$J(POT,7,2)
 D A1 ; Line #5
 ;
 I PPP<26 D
 . S TEXT=(AHRS-NPHRS-WPHRS)-THRSWK,TEXT=TEXT/(26-PPP)
 . S TEXT=$FN(TEXT,"",2)
 . S TEXT="   Agreement will be met by averaging "_TEXT
 . S TEXT=TEXT_" Hrs/PP during remainder of memo."
 ;
 I PPP=26 D
 . S $E(TEXT,30)="",TEXT=TEXT_"This memorandum has ended"
 ;
 I TDAT D
 . I LPPP'="" D
 . . S LPPP=$O(^PRST(458,"B",LPPP,0))
 . . S LPPP=$P($G(^PRST(458,LPPP,1)),U,14)
 . . I TDAT'>LPPP D  Q
 . . . S TEXT="",$E(TEXT,30)="",TEXT=TEXT_"This memorandum has ended"
 ;
 D A1 ; Line #6
 K INDEX,Y
 Q
 ;
A1 ; Set TEXT into the array
 ;
 N A1
 W !,TEXT
 I $G(ARRAY)'="" D
 . S A1="S "_ARRAY_INDEX_")="_""""_TEXT_""""
 . X A1
 . S INDEX=INDEX+1
 S TEXT=""
 Q
 ;
INDEX ; Get last index in array if not passed in
 ;
 S INDEX="S INDEX=$O("_ARRAY_"""A""),-1)"
 X INDEX
 I 'INDEX S INDEX=1 Q
 I INDEX S INDEX=INDEX+1
 Q
