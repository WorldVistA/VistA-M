MCESSCR ;WISC/DCB-Sets up the screening for Electronic Signature ;6/26/96  12:51
 ;;2.3;Medicine;;09/13/1996
 ;
PREEDIT(MCFILE) ; sets screen logic for edit
 ;Sets up DIC("S") for editing
 S:'$D(DIC("DR")) DIC("DR")="1"
 Q $S($D(DIC("S")):DIC("S")_",$$SCREDIT^MCESSCR()",1:"I $$SCREDIT^MCESSCR()")
 ;
PREVIEW(MCFILE) ; sets screen logic for display and prints.
 ;Sets up DIC("S") for display and printing
 N MFD
 S MFD=$D(MCESMFD),SUPV=$S($D(MCESSUP):1,1:0) K MCESSUP,MCESMFD
 Q $S($D(DIC("S")):DIC("S")_",$$SCRPRT^MCESSCR(MCESKEY,"_MFD_","_SUPV_","_SUPV_")",1:"I $$SCRPRT^MCESSCR(MCESKEY,"_MFD_","_MCSUP_","_SUPV_")")
 ;
SCRPRT(KEY,MFD,SUP,SUPV) ; Screens out the records for printing.
 ;Don't print if the record is mark for deletions 
 ;or the user don't have the key to display drafts
 ;or the user has a key, he can display all reports
 N TEMP,CODE,RMFD,MFD2
 I MCFILE=691.5,$D(^MCAR(MCFILE,Y,"A")) Q 1
 I '$D(^MCAR(MCFILE,Y,"ES")) Q 1
 S TEMP=$G(^MCAR(MCFILE,Y,"ES")),CODE=$$ESTONUM1($P(TEMP,U,7)),RMFD=+$P(TEMP,U,12)
 I SUPV=1,(CODE'=8) Q 0
 I SUPV=1,(CODE=8) Q 1
 Q $S(RMFD:MFD,MFD=1:0,CODE=8:SUP,MCESSEC:1,CODE>2:1,1:0)
 ;
SCREDIT() ; Screens out the records for edits
 ;Screens out reports that has been mark for deletion and superseded
 ; For Key-Holder
 N TEMP,CODE,MFD
 S TEMP=$G(^MCAR(MCFILE,Y,"ES")),CODE=$$ESTONUM1($P(TEMP,U,7)),MFD=+$P(TEMP,U,12),TEMP=(MCESSEC&(CODE<8))
 I MCFILE=691.5,'$D(^MCAR(MCFILE,Y,"ES")),$D(^MCAR(MCFILE,Y,"A")) Q 0
 Q $S(MFD=1:0,CODE<3:1,TEMP:1,1:0)
 ;
SCRSUMPT(MCESKEY,REC,SUPV) ;Screen out the records for summary of patients
 ; Screens out mark for deletion and draft reports if the user don't
 ; have the key 
 N TEMP,CODE,MFD
 I '$D(^MCAR(MCFILE,REC,"ES")) Q 1
 S TEMP=$G(^MCAR(MCFILE,REC,"ES")),CODE=$$ESTONUM1($P(TEMP,U,7)),MFD=+$P(TEMP,U,12),MCESSEC=$D(^XUSEC(MCESKEY,DUZ))
 Q $S(MFD=1:1,CODE=8:SUPV,MCESSEC:1,CODE>2:1,1:0)
 ;
SCRGI(MCFILE,REC,KEY,SUPV)     ; Screens out records for reports for GI printed by fileman (THE RECALL LIST)
 ; Screens out mark for deletion and draft reports, if the user don't
 ; have the key. 
 N TEMP,CODE,MFD
 S TEMP=$G(^MCAR(MCFILE,REC,"ES")),CODE=$$ESTONUM1($P(TEMP,U,7)),MFD=+$P(TEMP,U,12),TEMP=(MCESSEC&(CODE>2))
 Q $S(MFD=1:1,CODE=8:SUPV,TEMP:1,1:0)
SCRDEL(MCFILE,REC) ;Screen out for deleting drafts
 N TEMP,CODE,MFD
 S TEMP=$G(^MCAR(MCFILE,REC,"ES")),CODE=$$ESTONUM1($P(TEMP,U,7)),MFD=+$P(TEMP,U,12),TEMP=(CODE<3)
 Q $S(MCESSEC:0,TEMP:1,1:0)
ESTONUM(MCFILE,MCREC) ; Convert Release Code to Number
 S TP=$P($G(^MCAR(MCFILE,MCREC,"ES")),U,7)
 Q $$ESTONUM1(TP)
ESTONUM1(TP) ; Convert a value to Release status
 Q $S(TP="PD":2,TP="RV":3,TP="ROV":4,TP="RNV":5,TP="S":8,TP="SRV":6,TP="SROV":7,1:1)
NUMTOES(TP)       ;Convert number back to Release Code
 ;Q $S(TP=2:"PD",TP=3:"RV",TP=4:"ROV",TP=5:"RNV",TP=6:"SRV",TP=7:"SRNV",TP=8:"S",1:"D")
 Q $S(TP=2:"PD",TP=3:"RV",TP=4:"ROV",TP=5:"RNV",TP=6:"SRV",TP=7:"SROV",TP=8:"S",1:"D")
ESRC(MCFILE,MCARGDA) ;  Electronic Singature & Release Control
 I $D(^MCAR(MCFILE,MCARGDA)),MCESON S UNSIGNED=$S($P($G(^MCAR(MCFILE,MCARGDA,"ES")),U,4)="":1,1:0) D POST^MCESEDT(MCFILE,.MCARGDA) D:UNSIGNED=1 ^MCWORKLD
 Q
