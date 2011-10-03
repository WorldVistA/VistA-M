OCXDI02C ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^OCXDIAG
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXDIAG",$J,$O(^TMP("OCXDIAG",$J,"A"),-1)+1)=TEXT
 ;
 G ^OCXDI02D
 ;
 Q
 ;
DATA ;
 ;
 ;;D^ORDER CHECK DATA CONTEXT
 ;;R^"863:",.02,"E"
 ;;D^860.6
 ;;EOR^
 ;;EOF^OCXS(863)^1
 ;;SOF^860.9  ORDER CHECK NATIONAL TERM
 ;;KEY^860.9:^SERUM CREATININE
 ;;R^"860.9:",.01,"E"
 ;;D^SERUM CREATININE
 ;;R^"860.9:",.02,"E"
 ;;D^60
 ;;EOR^
 ;;KEY^860.9:^SERUM UREA NITROGEN
 ;;R^"860.9:",.01,"E"
 ;;D^SERUM UREA NITROGEN
 ;;R^"860.9:",.02,"E"
 ;;D^60
 ;;EOR^
 ;;KEY^860.9:^DNR
 ;;R^"860.9:",.01,"E"
 ;;D^DNR
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^PROTHROMBIN TIME
 ;;R^"860.9:",.01,"E"
 ;;D^PROTHROMBIN TIME
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^NPO
 ;;R^"860.9:",.01,"E"
 ;;D^NPO
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^SERUM SPECIMEN
 ;;R^"860.9:",.01,"E"
 ;;D^SERUM SPECIMEN
 ;;R^"860.9:",.02,"E"
 ;;D^61
 ;;EOR^
 ;;KEY^860.9:^PARTIAL THROMBOPLASTIN TIME
 ;;R^"860.9:",.01,"E"
 ;;D^PARTIAL THROMBOPLASTIN TIME
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^ANGIOGRAM (PERIPHERAL)
 ;;R^"860.9:",.01,"E"
 ;;D^ANGIOGRAM (PERIPHERAL)
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^WBC
 ;;R^"860.9:",.01,"E"
 ;;D^WBC
 ;;R^"860.9:",.02,"E"
 ;;D^60
 ;;EOR^
 ;;KEY^860.9:^BLOOD SPECIMEN
 ;;R^"860.9:",.01,"E"
 ;;D^BLOOD SPECIMEN
 ;;R^"860.9:",.02,"E"
 ;;D^61
 ;;EOR^
 ;;KEY^860.9:^ONE TIME MED
 ;;R^"860.9:",.01,"E"
 ;;D^ONE TIME MED
 ;;R^"860.9:",.02,"E"
 ;;D^51.1
 ;;R^"860.9:",2,"E"
 ;;D^I $E($P(^(0),U,4),1,2)="PS"
 ;;EOR^
 ;;EOF^OCXS(860.9)^1
 ;;SOF^860.8  ORDER CHECK COMPILER FUNCTIONS
 ;;KEY^860.8:^CONVERT DATE FROM FILEMAN FORMAT TO OCX FORMAT
 ;;R^"860.8:",.01,"E"
 ;;D^CONVERT DATE FROM FILEMAN FORMAT TO OCX FORMAT
 ;;R^"860.8:",.02,"E"
 ;;D^DT2INT
 ;;R^"860.8:",1,1
 ;;D^  ;DT2INT(OCXDT) ;      This Local Extrinsic Function converts a date into an integer
 ;;R^"860.8:",1,2
 ;;D^  ; ; By taking the Years, Months, Days, Hours and Minutes converting
 ;;R^"860.8:",1,3
 ;;D^  ; ; Them into Seconds and then adding them all together into one big integer
 ;;R^"860.8:",100,1
 ;;D^  ;DT2INT(OCXDT) ;      This Local Extrinsic Function converts a date into an integer
 ;;R^"860.8:",100,2
 ;;D^  ; ; By taking the Years, Months, Days, Hours and Minutes converting
 ;;R^"860.8:",100,3
 ;;D^  ; ; Them into Seconds and then adding them all together into one big integer
 ;;R^"860.8:",100,4
 ;;D^  ; ;
 ;;R^"860.8:",100,5
 ;;D^  ; Q:'$L($G(OCXDT)) ""
 ;;R^"860.8:",100,6
 ;;D^  ; N OCXVAL S OCXVAL=0
 ;;R^"860.8:",100,7
 ;;D^  ; I (OCXDT?5N1","5N) Q (OCXDT*86400+$P(OCXDT,",",2))  ;  $H FORMAT
 ;;R^"860.8:",100,8
 ;;D^  ; I ($E(OCXDT,1)="T") D  Q OCXVAL  ; TODAY
 ;;R^"860.8:",100,9
 ;;D^  ; .S OCXVAL=$H*86400
 ;;R^"860.8:",100,10
 ;;D^  ; .S:(OCXDT["+") OCXVAL=OCXVAL+($P(OCXDT,"+",2)*86400)
 ;;R^"860.8:",100,11
 ;;D^  ; .S:(OCXDT["-") OCXVAL=OCXVAL-($P(OCXDT,"-",2)*86400)
 ;;R^"860.8:",100,12
 ;;D^  ; I ($E(OCXDT,1)="N") D  Q OCXVAL  ; NOW
 ;;R^"860.8:",100,13
 ;;D^  ; .S OCXVAL=$H*86400+$P($H,",",2)
 ;;R^"860.8:",100,14
 ;;D^  ; .S:(OCXDT["+") OCXVAL=OCXVAL+($P(OCXDT,"+",2)*86400)
 ;;R^"860.8:",100,15
 ;;D^  ; .S:(OCXDT["-") OCXVAL=OCXVAL-($P(OCXDT,"-",2)*86400)
 ;;R^"860.8:",100,16
 ;;D^  ; I +OCXDT,($L(OCXDT\1)=7) S OCXDT=($E(OCXDT,1,3)+1700)_$E(OCXDT,4,7)_$S((OCXDT["."):$P(OCXDT,".",2),1:"")  ;  CONVERT INTERNAL FILEMAN FORMAT TO HL7 FORMAT
 ;;R^"860.8:",100,17
 ;;D^  ; I +OCXDT,($L(OCXDT\1)>7) D  Q OCXVAL  ; HL7 FORMAT
 ;;R^"860.8:",100,18
 ;;D^  ; .S OCXVAL=($E(OCXDT,1,4)-1841*365)+($E(OCXDT,1,4)\4-460)-($E(OCXDT,1,4)\200-9) ; ADJUST FOR LEAP YEARS
 ;;R^"860.8:",100,19
 ;;D^  ; .S OCXVAL=OCXVAL+$P("000^031^059^090^120^151^181^212^243^273^304^334",U,$E(OCXDT,5,6)) ; MONTHS TO DAYS
 ;;R^"860.8:",100,20
 ;;D^  ; .S OCXVAL=OCXVAL+$E(OCXDT,7,8)-1  ; ADD DAYS
 ;;R^"860.8:",100,21
 ;;D^  ; .S OCXVAL=OCXVAL*86400  ; CONVERT TO SECONDS
 ;;R^"860.8:",100,22
 ;;D^  ; .S OCXVAL=OCXVAL+($E(OCXDT,9,10)*3600)+($E(OCXDT,11,12)*60)+$E(OCXDT,13,14)  ; ADD TIME
 ;;R^"860.8:",100,23
 ;;D^  ; Q OCXDT
 ;;R^"860.8:",100,24
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^PTRNODE
 ;;R^"860.8:",.01,"E"
 ;;D^PTRNODE
 ;;R^"860.8:",.02,"E"
 ;;D^PTRNODE
 ;;R^"860.8:",1,1
 ;;D^  ;PTRNODE(OCXFIL,OCXKEY,OCXNODE) ;     This Local Extrinsic Function returns the specified Node (OCXNODE)
 ;;R^"860.8:",1,2
 ;;D^  ; ;     From the specified record (OCXKEY) in a file (OCXFIL).
 ;;R^"860.8:",1,3
 ;;D^  ; ;
 ;;R^"860.8:",100,1
 ;;D^  ;PTRNODE(OCXFIL,OCXKEY,OCXNODE) ;     This Local Extrinsic Function returns the specified Node (OCXNODE)
 ;;R^"860.8:",100,2
 ;;D^  ; ;     From the specified record (OCXKEY) in a file (OCXFIL).
 ;;R^"860.8:",100,3
 ;;D^  ; ;
 ;;R^"860.8:",100,4
 ;;D^  ; ;
 ;;R^"860.8:",100,5
 ;;D^  ; N OCXDATA,OCXSUB,OCXGL S OCXDATA=0
 ;;R^"860.8:",100,6
 ;;D^  ; Q:'$L(OCXFIL) "" Q:'$L($G(OCXKEY)) "" S:'$L($G(OCXNODE)) OCXNODE=0
 ;1;
 ;
