BPSSCRN0 ;ALB/ESG - ECME user screen open/close non-billable entry ;21-SEP-2015
 ;;1.0;E CLAIMS MGMT ENGINE;**20,24**;JUN 2004;Build 43
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
OC ; entry point for open/close non-billable entry action
 N BPRET,BP59,CLTOOP,JJ1,JJ2,JJ3,DFN,BPSSCRLN,BLN,COMMENT,BPQ,DIE,DA,DR,X,Y
 N BPRET1,BPSARR59,BPSARR59A
 D FULL^VALM1
 W "Open/Close Non-Billable Entry"
 W !,"Enter the line numbers for the entry/entries to be opened or closed."
 S BPRET=$$ASKLINES^BPSSCRU4("Select items","C",.BPSARR59,VALMAR)
 I BPRET="^" G OCX
 ; Sort chosen entries
 ; BPRET1= # of Billable Claims^# of Open (Non-Billable) Claims^# of Closed (NB) Claims
 S BPRET1=$$OCNARR(.BPSARR59,.BPSARR59A)
 I $P(BPRET1,"^",2)+$P(BPRET1,"^",3)=0 D  G OCX
 . W !!,"The selected entries must be Non-Billable. Please try again."
 . D PAUSE^VALM1
 ;
 ; Display Billable claims that will not be included.
 I $P(BPRET1,"^")'=0 D  I BPQ="^" G OCX
 . W !!,"Selected entries must be Non-Billable."
 . W !,"The following entries are not Non-Billable and will not be included for"
 . S BPSPT=""
 . S BPQ=""
 . F  S BPSPT=$O(BPSARR59A(1,BPSPT)) Q:BPSPT=""  D  Q:BPQ="^"
 . . W !,BPSPT," :"
 . . S BPS59=""
 . . F  S BPS59=$O(BPSARR59A(1,BPSPT,BPS59)) Q:BPS59=""  D  Q:BPQ="^"
 . . . I $Y>20 D PAUSE^VALM1 W @IOF I X="^" S BPQ="^" Q
 . . . W !,@VALMAR@(+$G(BPSARR59A(1,BPSPT,BPS59)),0)
 . . . D DISPREJ^BPSSCRU6(BPS59)
 ;
 ; Display open claims to be closed.
 I $P(BPRET1,"^",2)'=0 D  I BPQ="^" G OCX
 . W !!,"You've chosen to CLOSE the following prescription(s) for"
 . S BPSPT=""
 . S BPQ=""
 . F  S BPSPT=$O(BPSARR59A(2,BPSPT)) Q:BPSPT=""  D  Q:BPQ="^"
 . . W !,BPSPT," :"
 . . S BPS59=""
 . . F  S BPS59=$O(BPSARR59A(2,BPSPT,BPS59)) Q:BPS59=""  D  Q:BPQ="^"
 . . . I $Y>20 D PAUSE^VALM1 W @IOF I X="^" S BPQ="^" Q
 . . . W !,@VALMAR@(+$G(BPSARR59A(2,BPSPT,BPS59)),0)
 . . . D DISPREJ^BPSSCRU6(BPS59)
 ;
 ;Display closed claims to be opened.
 I $P(BPRET1,"^",3)'=0 D  I BPQ="^" G OCX
 . W !!,"You've chosen to OPEN the following prescription(s) for"
 . S BPSPT=""
 . S BPQ=""
 . F  S BPSPT=$O(BPSARR59A(3,BPSPT)) Q:BPSPT=""  D  Q:BPQ="^"
 . . W !,BPSPT," :"
 . . S BPS59=""
 . . F  S BPS59=$O(BPSARR59A(3,BPSPT,BPS59)) Q:BPS59=""  D  Q:BPQ="^"
 . . . I $Y>20 D PAUSE^VALM1 W @IOF I X="^" S BPQ="^" Q
 . . . W !,@VALMAR@(+$G(BPSARR59A(3,BPSPT,BPS59)),0)
 . . . D DISPREJ^BPSSCRU6(BPS59)
 ;
 S BPSPRMPT=""
 I $P(BPRET1,"^",3)'=0,$P(BPRET1,"^",2)=0 S BPSPRMPT="OPENED"
 I $P(BPRET1,"^",2)'=0,$P(BPRET1,"^",3)=0 S BPSPRMPT="CLOSED"
 I $P(BPRET1,"^",2)'=0,$P(BPRET1,"^",3)'=0 S BPSPRMPT="OPENED/CLOSED"
 ;
 W !!,"ALL Selected Non-Billable Rxs will be "_BPSPRMPT_" using the"
 W !,"same information gathered in the following prompt.",!
 ;
COMQ ; capture the free text comments
 S COMMENT=$$COMMENT^BPSSCRCL("Comment ",40)
 I COMMENT=U W !!,"No changes made." D PAUSE^VALM1 G OCX
 S COMMENT=$$TRIM^XLFSTR(COMMENT)     ; remove leading or trailing spaces
 I '$L(COMMENT) W $C(7),!,"This is a required response. Enter '^' to exit" G COMQ
 ;
 S BPQ=$$YESNO^BPSSCRRS("Are you sure? (Y/N)")
 I BPQ'=1 W !!,"No changes made." D PAUSE^VALM1 G OCX
 ;
 ; time to file
 S DIE=9002313.59
 ;
 ; Loop through closed claims to be re-opened.
 I $P(BPRET1,"^",3)'=0 D
 . S BPSPT=""
 . F  S BPSPT=$O(BPSARR59A(3,BPSPT)) Q:BPSPT=""  D
 . . S DA=""
 . . F  S DA=$O(BPSARR59A(3,BPSPT,DA)) Q:DA=""  D
 . . . S DR="302////0;306////"_$$NOW^XLFDT
 . . . S DR=DR_";307////^S X=DUZ;308////^S X=COMMENT"
 . . . D ^DIE
 ;
 ; Loop through open claims to be closed.
 I $P(BPRET1,"^",2)'=0 D
 . S BPSPT=""
 . F  S BPSPT=$O(BPSARR59A(2,BPSPT)) Q:BPSPT=""  D
 . . S DA=""
 . . F  S DA=$O(BPSARR59A(2,BPSPT,DA)) Q:DA=""  D 
 . . . S DR="302////1;303////"_$$NOW^XLFDT
 . . . S DR=DR_";304////^S X=DUZ;305////^S X=COMMENT"
 . . . D ^DIE
 ;
 D PAUSE^VALM1
 D REDRAW^BPSSCRUD("Updating screen ...")
 ;
OCX ;
 I $G(BPQ)="^" D
 . W !,"0 claims have been opened/closed."
 . D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
OCNARR(BPARR,BPARR1) ; Re-sort array of user selected claims
 ; The user selected claims will be re-sorted, dividing them by
 ; Billable Claims, Non-Billable Open Claims and NB Closed Claims.
 ; The claims will also be sorted, within each grouping, alphabetically
 ; by Patient Name.
 ; BPARR - input - array of user selected claims
 ; BPARR1 - output - array of user selected claims; re-sorted
 ; BPARR1(1,PATIENT,BPS TRANSACTION) = Billable Claims
 ; BPARR1(2,PATIENT,BPS TRANSACTION) = Non-Billable Open Claims
 ; BPARR1(3,PATIENT,BPS TRANSACTION) = Non-Billable Closed Claims
 ; Function Return Value = Counts of each category from BPARR1
 ;  # of Billable Claims^# of Open NB Claims^# of Closed NB Claims
 ;
 N BPS59,BPSCLO,BPSCNT,BPSOPN,BPSPT,BPSBILL
 S BPSCNT=0,BPSOPN=0,BPSCLO=0
 S BPS59=""
 F  S BPS59=$O(BPARR(BPS59)) Q:BPS59=""  D
 . ; Patient Name
 . S BPSPT=$$GET1^DIQ(9002313.59,BPS59,5)
 . ; Billable=0 Non-Billable=1
 . S BPSBILL=$$NB^BPSSCR03(BPS59)
 . I BPSBILL=0 D  Q
 . . S BPARR1(1,BPSPT,BPS59)=BPARR(BPS59)
 . . S BPSCNT=BPSCNT+1
 . ; Only Non-Billable Claims at this point
 . ; Open=0 Closed=1
 . S BPSOPNCLO=$$NBCL^BPSSCR03(BPS59)
 . I BPSOPNCLO=0 D  Q
 . . S BPARR1(2,BPSPT,BPS59)=BPARR(BPS59)
 . . S BPSOPN=BPSOPN+1
 . S BPARR1(3,BPSPT,BPS59)=BPARR(BPS59)
 . S BPSCLO=BPSCLO+1
 Q BPSCNT_"^"_BPSOPN_"^"_BPSCLO
