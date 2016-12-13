BPSSCRN0 ;ALB/ESG - ECME user screen open/close non-billable entry ;21-SEP-2015
 ;;1.0;E CLAIMS MGMT ENGINE;**20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
OC ; entry point for open/close non-billable entry action
 N BPRET,BP59,CLTOOP,JJ1,JJ2,JJ3,DFN,BPSSCRLN,BLN,COMMENT,BPQ,DIE,DA,DR,X,Y
 D FULL^VALM1
 W "Open/Close Non-Billable Entry",!,"Enter the line number for the entry to be opened or closed."
 S BPRET=$$ASKLINE^BPSSCRU4("Select item","C","Please select a single Rx line.")
 I BPRET<1 G OCX
 S BP59=$P(BPRET,U,4)
 I '$$NB^BPSSCR03(BP59) W !!,"The selected entry must be a Non-Billable entry. Please try again." D PAUSE^VALM1 G OCX
 ;
 I $$NBCL^BPSSCR03(BP59) S CLTOOP=1,JJ1="OPEN",JJ2="OPENED",JJ3="Opening"    ; Closed entry to be re-opened
 E  S CLTOOP=0,JJ1="CLOSE",JJ2="CLOSED",JJ3="Closing"                        ; Open entry to be closed
 ;
 S DFN=+$P(BPRET,U,2) I 'DFN W !!,"Patient isn't valid for this entry." D PAUSE^VALM1 G OCX
 S BPSSCRLN=$P(BPRET,U,5)       ; starting line# for the ListMan display array
 ;
 W !!,"You've chosen to ",JJ1," the following entry for"
 W !,$P($G(^DPT(DFN,0)),U,1)," :"
 S BLN=BPSSCRLN-1
 F  S BLN=$O(^TMP("BPSSCR",$J,"VALM","IDX",BLN)) Q:'BLN  Q:'$D(^TMP("BPSSCR",$J,"VALM","IDX",BLN,BP59))  D
 . W !,$G(^TMP("BPSSCR",$J,"VALM",BLN,0))
 . Q
 W !!,"The Selected Entry will be ",JJ2,".",!
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
 w !!,JJ3," Entry"
 S DIE=9002313.59
 S DA=BP59
 I CLTOOP S DR="302////0;306////"_$$NOW^XLFDT_";307////^S X=DUZ;308////^S X=COMMENT"     ; re-opening entry
 I 'CLTOOP S DR="302////1;303////"_$$NOW^XLFDT_";304////^S X=DUZ;305////^S X=COMMENT"    ; closing entry
 D ^DIE
 D PAUSE^VALM1
 D REDRAW^BPSSCRUD("Updating screen ...")
 ;
OCX ;
 S VALMBCK="R"
 Q
 ;
