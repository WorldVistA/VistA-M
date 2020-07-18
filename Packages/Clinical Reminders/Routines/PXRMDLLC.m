PXRMDLLC ;SLC/AGP - REMINDER DIALOG LOADER ;Mar 21, 2018@13:59
 ;;2.0;CLINICAL REMINDERS;**45**;Feb 04, 2005;Build 566
 ;
BLDPTYPE(DIEN,PROMPTS) ;
 N DSUB,DCIEN,PTIEN
 S DSUB=0 F  S DSUB=$O(^PXRMD(801.41,DIEN,10,DSUB)) Q:DSUB'>0  D
 .S DCIEN=$P($G(^PXRMD(801.41,DIEN,10,DSUB,0)),U,2) Q:'DCIEN
 .I $$ISDISAB^PXRMDLL(DCIEN)=1 Q
 .I "PF"'[$P($G(^PXRMD(801.41,DCIEN,0)),U,4) Q
 .S PTIEN=$P($G(^PXRMD(801.41,DCIEN,46)),U) I PTIEN'>0 Q
 .S PROMPTS(PTIEN)=""
 Q
DCHK(DIEN) ;
 ; this function will check each element/group showing a checkbox.
 ;if the item has a General Reminder Finding it will check to see if the finding exists in the TMP global.
 ;if it does it will return a value of "C" can probably be change to a 1/0 return value
 I +$G(CHKLVL)'=1 Q ""
 I '$D(^TMP($J,"PXRM GEN FINDING",DIALOGIEN)) Q ""
 N DOCHCK,FIELD,FILE,FIND,FINDS,FOUND,IENS,NODE,NUM,PFIELD,PKG,PROMPTS,VALUE
 ;^TMP($J,"PXRM GEN FINDING",DIEN,PKGNAME,FILE NUMBER,FIELD NUMBER,IENS)
 ;IENS can be a multiple
 ;build array of general finding types
 S FIND=$P($G(^PXRMD(801.41,DIEN,1)),U,5)
 I FIND["801.46",$$ISVALID(+FIND,DIEN) M FINDS(+FIND)=^PXRMD(801.46,+FIND)
 ;check additional findings
 S NUM=0 F  S NUM=$O(^PXRMD(801.41,DIEN,3,NUM)) Q:NUM'>0  D
 .S FIND=$P($G(^PXRMD(801.41,DIEN,3,NUM,0)),U) I FIND["801.46",$$ISVALID(+FIND,DIEN) M FINDS(+FIND)=^PXRMD(801.46,+FIND)
 I '$D(FINDS) Q ""
 ;build array of prompts type for the DIEN
 D BLDPTYPE(DIEN,.PROMPTS)
 ;check for general finding types in the TMP global
 S NUM=0,FOUND=0 F  S NUM=$O(FINDS(NUM)) Q:NUM'>0!(FOUND=1)  D
 .;S NODE=$G(FINDS(NUM,0)),PKG=$$GET1^DIQ(9.4,$P(NODE,U,2),.01),FILE=$P(NODE,U,3),FIELD=$P($G(FINDS(NUM,1)),U,2)
 .S NODE=$G(FINDS(NUM,0)),PKG=$P(NODE,U,2),FILE=$P(NODE,U,3),FIELD=$P($G(FINDS(NUM,1)),U,2),PFIELD=$P($G(FINDS(NUM,2)),U,2)
 .S DOCHCK=0
 .I FIELD'="",$D(^TMP($J,"PXRM GEN FINDING",DIALOGIEN,PKG,FILE,FIELD)) S DOCHCK=1
 .I PFIELD'="",$D(^TMP($J,"PXRM GEN FINDING",DIALOGIEN,PKG,FILE,PFIELD)) S DOCHCK=1
 .I DOCHCK=0 Q
 .;if prompt value is defined check for existing prompt type in dialog item.
 .I $P($G(FINDS(NUM,2)),U)'="",$D(PROMPTS($P($G(FINDS(NUM,2)),U))) S FOUND=1 Q
 .;quit if value is not defined
 .I $P($G(FINDS(NUM,1)),U)="" Q
 .;check to see if return value matches value returned from branching logic
 .S IENS="" F  S IENS=$O(^TMP($J,"PXRM GEN FINDING",DIALOGIEN,PKG,FILE,FIELD,IENS)) Q:IENS=""  D
 ..I $P($G(FINDS(NUM,1)),U)=$G(^TMP($J,"PXRM GEN FINDING",DIALOGIEN,PKG,FILE,FIELD,IENS)) S FOUND=1
 ;AGP COMMENTED OUT HANDLE CODE TO CHECK FOR PROMPTS
 ;.I $P($G(FINDS(NUM,1)),U)'="",$D(^TMP($J,"PXRM GEN FINDING",DIALOGIEN,PKG,FILE,FIELD)) D
 ;..S IENS="" F  S IENS=$O(^TMP($J,"PXRM GEN FINDING",DIALOGIEN,PKG,FILE,FIELD,IENS)) Q:IENS=""  D
 ;...I $P($G(FINDS(NUM,1)),U)=$G(^TMP($J,"PXRM GEN FINDING",DIALOGIEN,PKG,FILE,FIELD,IENS)) S FOUND=1
 I FOUND=1 Q "C"
 Q ""
 ;
ISVALID(FIND,DIEN) ;
 I $P($G(^PXRMD(801.41,DIEN,"DATA")),U,2)=1 Q 0
 ;AGP change to check for prompt type also.
 I $P($G(^PXRMD(801.46,FIND,1)),U)="",$P($G(^PXRMD(801.46,FIND,2)),U)="" Q 0
 Q 1
 ;
FIND(FIND) ;
 Q
 ;
CHKHLVL(ORY,OCNT,CHKSTAT) ;
 ; this function starts at OCNT and works it way back up the ORY array
 ;the purpose of this function is to set high level element/groups to check for the item set to checked in $$DCHK
 ;condition the possible element must be in the direction sequence of the checked item. It must also be set to show a check box
 ;;examples
 ;;        5               <== Should be set to check from the LSTHCK procedure
 ;;        5.10            <== Should be set to check from this function
 ;;        5.10.5          <== Should be set to check from this function
 ;;        5.10.5.10
 ;;        5.10.5.15.5
 ;;        5.10.5.15.10    <== Should be set to check from this function
 ;;        5.10.5.15.10.5
 ;;        5.10.5.15.10.15 <== is starting checked from $$DCHK
 ;;        10
 N DONE,FOUND,ESEQ,FOUND,TCNT,SEQ,TSEQ,TSEQ1,PIECE,DIEN
 I +$G(CHKLVL)'=1 Q
 S SEQ=$P(ORY(OCNT),U,3)
 S PIECE=$L(SEQ,".") I PIECE=1 Q
 ;get first parent sequence
 S TCNT=OCNT,TSEQ=$P(SEQ,".",1,PIECE-1)
 S PIECE=PIECE-1
 ;while look this loop will continue until at fist level sequence then it does a check at that sequence level
 S DONE=0
 F  D  I DONE=1!($L(TSEQ,".")=1) Q
 .S FOUND=0 F  S TCNT=$O(ORY(TCNT),-1) Q:TCNT<1!(FOUND=1)!(DONE=1)  D
 ..S NODE=$G(ORY(TCNT)) I $P(NODE,U)>1 Q
 ..S TSEQ1=$P(NODE,U,3),DIEN=$P(NODE,U,2)
 ..I TSEQ'=TSEQ1 Q
 ..I $P($G(CHKSTAT(TSEQ)),U)=DIEN,$P($G(CHKSTAT(TSEQ)),U,2)=0 S DONE=1 Q
 ..I $P(NODE,U,4)="C" S DONE=1 Q
 ..;must be set to show a checkbox, and the item cannot have findings
 ..I $P(NODE,U,4)="S",'$$HASFIND($P(NODE,U,2)) S $P(ORY(TCNT),U,4)="C"
 ..I $P(ORY(TCNT),U,4)="S" S DONE=1 Q
 ..;remove last sequence number to restart or end the while loop
 ..I PIECE>0 S PIECE=PIECE-1
 ..S TSEQ=$P(TSEQ,".",1,PIECE),FOUND=1
 I DONE=0 D LSTHCHK(.ORY,TSEQ,TCNT+1,.CHKSTAT)
 Q
 ;
LSTHCHK(ORY,TSEQ,TCNT,CHKSTAT) ;
 ;;this function does the same as above but only checks the last single check level
 ;;example sequence of 5,10,15,20
 N DONE,NODE,DIEN
 S DONE=0 F  S TCNT=$O(ORY(TCNT),-1) Q:TCNT<1!(DONE=1)  D
 .S NODE=$G(ORY(TCNT)),DIEN=$P(NODE,U,2) I $P(NODE,U)>1 Q
 .I $P(NODE,U,3)=TSEQ D
 ..I $P(NODE,U,4)="C" S DONE=1 Q
 ..I $P($G(CHKSTAT(TSEQ)),U)=DIEN,$P($G(CHKSTAT(TSEQ)),U,2)=0 S DONE=1 Q
 ..;I $P(NODE,U,4)="S" S $P(ORY(TCNT),U,4)="C"
 ..I $P(NODE,U,4)="S",'$$HASFIND($P(NODE,U,2)) S $P(ORY(TCNT),U,4)="C"
 ..S DONE=1
 .I $P(NODE,U,3)<TSEQ S DONE=1 Q
 Q
 ;
HASFIND(DIEN) ;
 I $P($G(^PXRMD(801.41,DIEN,1)),U,5)'="" Q 1
 I $D(^PXRMD(801.41,DIEN,3))>10 Q 1
 Q 0
 ;
