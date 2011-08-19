IBECUSMU ;ALB/CPM - PHARMACY BILLING OPTION UTILITIES ; 12-DEC-96
 ;;2.0;INTEGRATED BILLING;**52,347**;21-MAR-94;Build 24
 ;
 ;
FINDC(IBIN,IBW,IBOUT) ; Find transactions which can be cancelled.
 ;  Input:     IBIN  --  Array of transactions, passed by reference
 ;              IBW  --  1 => Write reject statements
 ;                       2 => No writes
 ; Output:    IBOUT  --  Array of transactions which can be cancelled
 ;
 N IBKEY,IBCHTRN,IBCHTRN5,IBCHTRN6
 S IBKEY="" F  S IBKEY=$O(IBIN(IBKEY)) Q:IBKEY=""  D
 .S IBCHTRN=IBIN(IBKEY)
 .S IBCHTRN5=$G(^IBA(351.5,IBCHTRN,5)),IBCHTRN6=$G(^(6))
 .;
 .; - can cancel if original transmission was billed
 .;   (no billing rejects) without trying to cancel
 .;   (no cancel auth) or if the cancel was rejected
 .I IBCHTRN5="",IBCHTRN6=""!($P(IBCHTRN6,"^",3)'="") S IBOUT(IBKEY)=IBCHTRN Q
 .;
 .; - write error messages
 .Q:'$G(IBW)
 .;
 .; - billing transaction was rejected
 .I IBCHTRN5]"" W !," The claim for ",$S($P(IBKEY,";",2):"refill #"_$P(IBKEY,";",2),1:"the original fill")," for this prescription was rejected." Q
 .;
 .; - transaction was cancelled
 .W !?1,$S($P(IBKEY,";",2):"Refill #"_$P(IBKEY,";",2),1:"The original fill")," for this prescription has already been reversed."
 ;
 Q
 ;
 ;
FINDB(IBRX,IBW,IBOUT) ; Find prescriptions which can be billed.
 ;  Input:     IBRX  --  Pointer to the prescription in file #52
 ;              IBW  --  1 => Write reject statements
 ;                       2 => No writes
 ; Output:    IBOUT  --  Array of transactions which can be billed
 ;
 N IBARR,IBREF,IBKEY,IBCHTRN,IBCHTRN5,IBCHTRN6,IBREF1,LIST
 S LIST="FINDBLIST"
 ;
 ; - build potential array from prescription (#52) file
 S IBARR(IBRX_";0")=$O(^IBA(351.5,"B",IBRX_";0",0))
 S IBREF=0
 D RX^PSO52API($$FILE^IBRXUTL(IBRX,2),LIST,IBRX,,"R^^",,)
 S IBREF=0 F  S IBREF=$O(^TMP($J,LIST,$$FILE^IBRXUTL(IBRX,2),IBRX,"RF",IBREF)) Q:IBREF'>0  D
 .Q:'IBREF
 .S IBARR(IBRX_";"_IBREF)=$O(^IBA(351.5,"B",IBRX_";"_IBREF,0))
 ;
 K ^TMP($J,LIST)
 S IBKEY="" F  S IBKEY=$O(IBARR(IBKEY)) Q:IBKEY=""  D
 .S IBCHTRN=IBARR(IBKEY)
 .I 'IBCHTRN S IBOUT(IBKEY)=IBCHTRN Q
 .;
 .S IBCHTRN5=$G(^IBA(351.5,IBCHTRN,5)),IBCHTRN6=$G(^(6))
 .;
 .; - can bill if original transmission was rejected,
 .;   or if that transmission was cancelled (re-submit)
 .I IBCHTRN5]""!(IBCHTRN5=""&($P(IBCHTRN6,"^")'="")) S IBOUT(IBKEY)=IBCHTRN Q
 .;
 .; - write messages
 .Q:'$G(IBW)
 .;
 .; - already billed (previous cancellation was rejected)
 .I $P(IBCHTRN6,"^",3)'="" W !!," The previous cancellation for ",$S($P(IBKEY,";",2):"refill #"_$P(IBKEY,";",2),1:"the original fill")," was rejected." Q
 .;
 .; - never tried to cancel
 .W !!?1,$S($P(IBKEY,";",2):"Refill #"_$P(IBKEY,";",2),1:"The original fill")," for this prescription has already been billed."
 ;
 Q
 ;
 ;
SEL(IBARR) ; Select a fill for a prescription.
 ;  Input:   IBARR  --  Array of prescriptions passed by reference.
 ; Output:   IBNUM  --  One of the fill numbers, or -1 (none selected)
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,IBSTR,IBKEY,IBRX,IBREF,IBFILL,IBNUM
 ;
 ; - build string for DIR(0)
 S (IBSTR,IBKEY)="",IBNUM=-1
 F  S IBKEY=$O(IBARR(IBKEY)) Q:IBKEY=""  D
 .S IBRX=+IBKEY,IBREF=+$P(IBKEY,";",2)
 .S IBFILL=$S(IBREF:+$$SUBFILE^IBRXUTL(IBRX,IBREF,52,.01),1:+$$FILE^IBRXUTL(IBRX,22))
 .S IBSTR=IBSTR_IBREF_":"_$S(IBREF:"Refill #"_IBREF,1:"Original Fill")_" (filled "_$$DAT1^IBOUTL(IBFILL)_");"
 ;
 I IBSTR="" G SELQ
 ;
 S DIR("A")="Select one of the fills by number",DIR(0)="S^"_IBSTR
 D ^DIR I $D(DUOUT)!$D(DIROUT)!$D(DTOUT) G SELQ
 ;
 S IBNUM=Y
 ;
SELQ Q IBNUM
