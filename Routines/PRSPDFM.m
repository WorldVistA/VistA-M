PRSPDFM ;WOIFO/MGD - PTP DELETE FUTURE MEMORANDUM ;04/07/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;The following routine will allow HR to delete a Part Time
 ; Physician's Memorandum of Service Level Expectations.
 ; For a memorandum to be eligible for deletion it must not have had
 ; any Pay Period processed.
 ;
 Q
MAIN ; Main Driver
 N STDAT,ENDAT,AHRS,ICOM,ESOK
 ; Prompt for Part Time Physician
 D PTP
 I Y'>0 D KILL Q
 S PRSIEN=+Y
 ; Find any memorandums that meet the deletion qualifications
 D MEM
 Q:'MIEN
 ; Display employee and memorandum information
 D DISPLAY
 ; Issue Delete Memorandum prompt
 W !!,"Delete this Memoranda: "
 S %=0 D YN^DICN
 I %'=1 D KILL Q
 ; Prompt for E-sig and update file
 D ESIG
 ;
 Q
 ;
PTP ; Prompt for Part Time Physician
 W !
 S DIC="^PRSPC(",DIC(0)="AEMQZ",DIC("A")="Select EMPLOYEE: "
 D ^DIC K DIC
 S PRSIEN=+Y
 Q
 ;
MEM ; Find any memorandums that meet the deletion qualifications
 N INDX,MEM,PPE,PPI459
 S (MEM,MIEN)=0,INDX=1
 F  S MEM=$O(^PRST(458.7,"B",PRSIEN,MEM)) Q:'MEM  D
 . S DATA=$G(^PRST(458.7,MEM,0))
 . Q:DATA=""
 . S START=$P(DATA,U,2),END=$P(DATA,U,3) ; Start Date, End Date
 . ; If the PP covering the Start Date is not opened no additional checks
 . ; are needed
 . S PPI=$P($G(^PRST(458,"AD",START)),U,1)
 . I PPI="" D  Q
 . . S MIEN=MEM,MEM(1)=MIEN_"^"_START_"^"_END_"^ACTIVE"
 . ; If the 1st PP covered by the memorandum is opened, check to see
 . ; what status it is in.
 . S PPE=$P($G(^PRST(458,PPI,0)),U,1)
 . Q:PPE=""
 . S PPI459=$O(^PRST(459,"B",PPE,0))
 . ; Check to see if Payroll for the first PP of the memorandum has 
 . ; already been processed.
 . I PPI459 D  Q
 . . W !!,"The payroll for the first Pay Period covered by this Memorandum"
 . . W !,"has already been processed.  This memorandum will have to be"
 . . W !,"terminated and reconciled."
 . . S MIEN=-1
 . ; Checks for Payroll not yet processed.
 . S STATUS=$P($G(^PRST(458,PPI,"E",PRSIEN,0)),U,2)
 . I STATUS="X" D  Q
 . . W !!,"This PT Physician's timecard has already been transmitted."
 . . W !,"If you think there is enough time to retransmit their 8B, you may:"
 . . W !,"1. Have the Payroll Supervisor return the timecard"
 . . W !,"2. Delete the memorandum"
 . . W !,"3. Have the PTP complete a paper Subsidiary Record"
 . . W !,"4. Have the Supervisor review and approve the Subsidiary Record"
 . . W !,"5. Have the Timekeeper post each day in the Pay Period"
 . . W !,"6. Re-certify and re-transmit the timecard"
 . . W !!,"If there isn't enough time, the memorandum will have to be"
 . . W !,"terminated and reconciled."
 . . S MIEN=-1
 . ;
 . I STATUS="P" D  Q
 . . W !!,"This PT Physician's timecard has already been certified."
 . . W !,"If you think there is enough time, you may:"
 . . W !,"1. Have the Payroll Supervisor return the timecard"
 . . W !,"2. Delete the memorandum"
 . . W !,"3. Have the PTP complete a paper Subsidiary Record"
 . . W !,"4. Have the Supervisor review and approve the Subsidiary Record"
 . . W !,"5. Have the Timekeeper post each day in the Pay Period"
 . . W !,"6. Re-certify the timecard."
 . . W !!,"If there isn't enough time, the memorandum will have to be"
 . . W !,"terminated and reconciled."
 . . S MIEN=-1
 . ; The End Date for future memorandums may not be in #458 yet
 . I PPI="" D  Q
 . . S MEM(INDX)=MEM_"^"_START_"^"_END_"^ACTIVE",INDX=INDX+1
 . ; If the End Date is in #458 check the timecard status for that PP
 . ; Quit if Timecard status for the last PP of the mem is not (T)imekeeper
 . Q:$P($G(^PRST(458,PPI,"E",PRSIEN,0)),U,2)'="T"
 . S MEM(INDX)=MEM_"^"_START_"^"_END_"^ACTIVE",INDX=INDX+1
 ; If no memos meet the deletion qualifications
 I '$D(MEM(1)) D  Q
 . W !!,"No memorandums meet the deletion qualifications for the "
 . W "selected employee,"
 . S MIEN=0
 ; If only one memo
 I '$D(MEM(2)) S MIEN=$P(MEM(1),U,1) Q
 ; Display list if more than one
 I $D(MEM(2)) D
 . W !!," # ",?5,"STARTS          ENDS"
 . F MEM=1:1 Q:'$D(MEM(MEM))  D
 . . S DATA=MEM(MEM)
 . . S Y=$P(DATA,U,2)
 . . D DD^%DT
 . . S START=Y
 . . S Y=$P(DATA,U,3)
 . . D DD^%DT
 . . S END=Y
 . . W !!,MEM,?5,START," TO ",END
 . ;
ASK . ; Ask user to select which memorandum they want
 . S END="",END=$O(MEM(END),-1)
 . W !!,"Enter a number between 1 and ",END," :"
 . R ASK:DTIME
 . S ASK=$$UPPER^PRSRUTL(ASK)
 . Q:ASK=""!(ASK="^")
 . I '$D(MEM(ASK)) D  G ASK
 . . W !!,"Enter a number between 1 and ",END," or ^ to exit"
 . S MIEN=$P(MEM(ASK),U,1)
 Q
 ;
DISPLAY ; Display memorandum info to validate the correct employee was chosen
 S SCRTTL="Delete PT Physician Memoranda"
 D HDR^PRSPUT1(PRSIEN,SCRTTL)
 S DATA=$G(^PRST(458.7,MIEN,0))
 S X=$P(DATA,U,2)
 S START=$P(DATA,U,2),END=$P(DATA,U,3),AHRS=$P(DATA,U,4)
 S Y=START
 D DD^%DT
 S START=Y
 S Y=END
 D DD^%DT
 S END=Y
 W !!,"  Start Date: ",START
 W !,"    End Date: ",END
 W !,"Agreed Hours: ",AHRS,!!
 Q
 ;
ESIG ; Prompt for Electronic Signature and store fields in #458.7
 ;
 N ESOK,PPE
 D ^PRSAES
 I ESOK D
 . ; obtain first PP covered by the this memo
 . S PPE=$P($G(^PRST(458.7,MIEN,9,1,0)),U)
 . ;
 . ; Update #458.7 to delete the memo
 . S DA=MIEN,DIK="^PRST(458.7,"
 . D ^DIK
 . W !!,"Memorandum Deleted."
 . ;
 . ; loop thru PP to clear ESR and (if necesary) time card
 . Q:PPE=""
 . S PPI=$O(^PRST(458,"B",PPE,0))
 . Q:'PPI
 . S PPI=PPI-.01 ; init PPI to include 1st PP in loop
 . F  S PPI=$O(^PRST(458,PPI)) Q:'PPI  D
 . . F DAY=1:1:14 D
 . . . ; Check if Daily ESR with a status of APPROVED
 . . . S ESRSTAT=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,7)),U,1)
 . . . I ESRSTAT=5 D  ; Clear Time Card posting information
 . . . . K ^PRST(458,PPI,"E",PRSIEN,"D",DAY,2),^(3),^(10)
 . . . ;
 . . . ; delete any ESR data
 . . . ; use fileman to delete ESR DAILY STATUS so x-ref will get updated
 . . . S PRSFDA(458.02,DAY_","_PRSIEN_","_PPI_",",146)="@"
 . . . D FILE^DIE("","PRSFDA"),MSG^DIALOG()
 . . . ; delete ESR related fields
 . . . K ^PRST(458,PPI,"E",PRSIEN,"D",DAY,5),^(6),^(7)
 ;
KILL ; Clean up variables
 ;
 K ASK,D1,DA,DATA,DAY,DIK,DIR,DIRUT,END,ESRSTAT,INDX,MEM,MIEN
 K PPI,PRSIEN,PRSFDA,TDATE,TCOM,SCRTTL,START,STATUS,STOP,X,Y,%,%DT
 Q
