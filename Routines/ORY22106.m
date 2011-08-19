ORY22106 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*221) ;AUG 30,2005 at 11:41
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**221**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY221ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY22107
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.3:","863.32:2",1,"E"
 ;;D^0
 ;;EOR^
 ;;KEY^863.3:^PATIENT.REN_LAB_RES
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.REN_LAB_RES
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^LAB RESULTS
 ;;R^"863.3:",.06,"E"
 ;;D^99
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO EXTERNAL FUNCTION CALL
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^FLAB(|PATIENT IEN|,"SERUM CREATININE^SERUM UREA NITROGEN","SERUM SPECIMEN")
 ;;EOR^
 ;;KEY^863.3:^PATIENT.TAKING_GLUCOPHAGE
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.TAKING_GLUCOPHAGE
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^CURRENT GLUCOPHAGE FLAG
 ;;R^"863.3:",.06,"E"
 ;;D^999
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO EXTERNAL FUNCTION CALL
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^TAKEMED^ORKPS(|PATIENT IEN|,"^GLUCOPHAGE^METFORMIN^AVANDAMET^METAGLIP")
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.3:","863.32:2",1,"E"
 ;;D^1
 ;;EOR^
 ;;EOF^OCXS(863.3)^1
 ;;SOF^860.9  ORDER CHECK NATIONAL TERM
 ;;KEY^860.9:^ANGIOGRAM (PERIPHERAL)
 ;;R^"860.9:",.01,"E"
 ;;D^ANGIOGRAM (PERIPHERAL)
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^BLOOD SPECIMEN
 ;;R^"860.9:",.01,"E"
 ;;D^BLOOD SPECIMEN
 ;;R^"860.9:",.02,"E"
 ;;D^61
 ;;EOR^
 ;;KEY^860.9:^DANGEROUS MEDS FOR PTS > 64
 ;;R^"860.9:",.01,"E"
 ;;D^DANGEROUS MEDS FOR PTS > 64
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;R^"860.9:",2,"E"
 ;;D^I $P($G(^ORD(100.98,$P($G(^ORD(101.43,+Y,0)),U,5),0)),U)="PHARMACY"
 ;;EOR^
 ;;KEY^860.9:^DNR
 ;;R^"860.9:",.01,"E"
 ;;D^DNR
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^EGFR
 ;;R^"860.9:",.01,"E"
 ;;D^EGFR
 ;;R^"860.9:",.02,"E"
 ;;D^60
 ;;EOR^
 ;;KEY^860.9:^FOOD-DRUG INTERACTION MED
 ;;R^"860.9:",.01,"E"
 ;;D^FOOD-DRUG INTERACTION MED
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;R^"860.9:",2,"E"
 ;;D^I $P($G(^ORD(100.98,$P($G(^ORD(101.43,+Y,0)),U,5),0)),U)="PHARMACY"
 ;;EOR^
 ;;KEY^860.9:^NPO
 ;;R^"860.9:",.01,"E"
 ;;D^NPO
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^ONE TIME MED
 ;;R^"860.9:",.01,"E"
 ;;D^ONE TIME MED
 ;;R^"860.9:",.02,"E"
 ;;D^51.1
 ;;R^"860.9:",2,"E"
 ;;D^I $E($P(^(0),U,4),1,2)="PS"
 ;;EOR^
 ;;KEY^860.9:^PARTIAL THROMBOPLASTIN TIME
 ;;R^"860.9:",.01,"E"
 ;;D^PARTIAL THROMBOPLASTIN TIME
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^PROTHROMBIN TIME
 ;;R^"860.9:",.01,"E"
 ;;D^PROTHROMBIN TIME
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^SERUM CREATININE
 ;;R^"860.9:",.01,"E"
 ;;D^SERUM CREATININE
 ;;R^"860.9:",.02,"E"
 ;;D^60
 ;;EOR^
 ;;KEY^860.9:^SERUM SPECIMEN
 ;;R^"860.9:",.01,"E"
 ;;D^SERUM SPECIMEN
 ;;R^"860.9:",.02,"E"
 ;;D^61
 ;;EOR^
 ;;KEY^860.9:^SERUM UREA NITROGEN
 ;;R^"860.9:",.01,"E"
 ;;D^SERUM UREA NITROGEN
 ;;R^"860.9:",.02,"E"
 ;;D^60
 ;;EOR^
 ;;KEY^860.9:^WBC
 ;;R^"860.9:",.01,"E"
 ;;D^WBC
 ;;R^"860.9:",.02,"E"
 ;;D^60
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
 ;;D^  ; N OCXDIFF,OCXVAL S (OCXDIFF,OCXVAL)=0
 ;;R^"860.8:",100,7
 ;;D^  ; ;
 ;;R^"860.8:",100,8
 ;;D^  ; I $L(OCXDT),'OCXDT,(OCXDT[" at ") D  ; EXTERNAL EXPERT SYSTEM FORMAT 1 TO EXTERNAL FORMAT
 ;;R^"860.8:",100,9
 ;;D^  ; .N OCXHR,OCXMIN,OCXTIME
 ;;R^"860.8:",100,10
 ;;D^  ; .S OCXTIME=$P($P(OCXDT," at ",2),".",1),OCXHR=$P(OCXTIME,":",1),OCXMIN=$P(OCXTIME,":",2)
 ;;R^"860.8:",100,11
 ;;D^  ; .S:(OCXDT["Midnight") OCXHR=00
 ;;R^"860.8:",100,12
 ;;D^  ; .S:(OCXDT["PM") OCXHR=OCXHR+12
 ;;R^"860.8:",100,13
 ;;D^  ; .S OCXDT=$P(OCXDT," at ")_"@"_$E(OCXHR+100,2,3)_$E(OCXMIN+100,2,3)
 ;;R^"860.8:",100,14
 ;;D^  ; ;
 ;;R^"860.8:",100,15
 ;;D^  ; I $L(OCXDT),(OCXDT?1.2N1"/"1.2N.1" ".2N.1":".2N) D  ; EXTERNAL EXPERT SYSTEM FORMAT 2 TO EXTERNAL FORMAT
 ;;R^"860.8:",100,16
 ;;D^  ; .N OCXMON
 ;;R^"860.8:",100,17
 ;;D^  ; .S OCXMON=$P("January^February^March^April^May^June^July^August^September^October^November^December",U,$P(OCXDT,"/",1))
 ;;R^"860.8:",100,18
 ;;D^  ; .I $L($P(OCXDT," ",2)) S OCXDT=OCXMON_" "_$P($P(OCXDT," ",1),"/",2)_"@"_$TR($P(OCXDT," ",2),":","")
 ;;R^"860.8:",100,19
 ;;D^  ; .E  S OCXDT=OCXMON_" "_$P($P(OCXDT," ",1),"/",2)
 ;;R^"860.8:",100,20
 ;;D^  ; ;
 ;;R^"860.8:",100,21
 ;;D^  ; I $L(OCXDT),(OCXDT?1.2N1"/"1.2N1"/"1.2N.1" ".2N.1":".2N) D  ; EXTERNAL EXPERT SYSTEM FORMAT 3 TO EXTERNAL FORMAT
 ;;R^"860.8:",100,22
 ;;D^  ; .N OCXMON
 ;;R^"860.8:",100,23
 ;;D^  ; .S OCXMON=$P("January^February^March^April^May^June^July^August^September^October^November^December",U,$P(OCXDT,"/",1))
 ;;R^"860.8:",100,24
 ;;D^  ; .I $L($P(OCXDT," ",2)) S OCXDT=OCXMON_" "_$P($P(OCXDT," ",1),"/",2)_","_$P($P(OCXDT," ",1),"/",3)_"@"_$TR($P(OCXDT," ",2),":","")
 ;;R^"860.8:",100,25
 ;;D^  ; .E  S OCXDT=OCXMON_" "_$P($P(OCXDT," ",1),"/",2)_", "_$P($P(OCXDT," ",1),"/",3)
 ;;R^"860.8:",100,26
 ;;D^  ; ;
 ;;R^"860.8:",100,27
 ;;D^  ; I $L(OCXDT),'OCXDT D  ; EXTERNAL FORMAT TO INTERNAL FILEMAN FORMAT
 ;;R^"860.8:",100,28
 ;;D^  ; .I (OCXDT["@0000") S OCXDT=$P(OCXDT,"@",1),OCXDIFF=1
 ;;R^"860.8:",100,29
 ;;D^  ; .N %DT,X,Y S X=OCXDT,%DT="" S:(OCXDT["@")!(OCXDT="N") %DT="T" D ^%DT S OCXDT=+Y
 ;;R^"860.8:",100,30
 ;;D^  ; ;
 ;;R^"860.8:",100,31
 ;;D^  ; I ($L(OCXDT\1)>7) S OCXDT=$$HL7TFM^XLFDT(OCXDT)  ; HL7 FORMAT TO INTERNAL FILEMAN FORMAT
 ;;R^"860.8:",100,32
 ;;D^  ; ;
 ;;R^"860.8:",100,33
 ;;D^  ; I ($L(OCXDT\1)=7) S OCXDT=$$FMTH^XLFDT(+OCXDT)   ; INTERNAL FILEMAN FORMAT TO $H FORMAT
 ;;R^"860.8:",100,34
 ;;D^  ; ;
 ;;R^"860.8:",100,35
 ;;D^  ; I (OCXDT?5N1","1.5N) S OCXVAL=(OCXDT*86400)+$P(OCXDT,",",2)     ;  $H FORMAT TO EXPERT SYSTEM INTERNAL FORMAT
 ;;R^"860.8:",100,36
 ;;D^  ; ;
 ;;R^"860.8:",100,37
 ;;D^  ; Q OCXVAL
 ;;R^"860.8:",100,38
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^CONVERT DATE FROM OCX FORMAT TO READABLE FORMAT
 ;;R^"860.8:",.01,"E"
 ;;D^CONVERT DATE FROM OCX FORMAT TO READABLE FORMAT
 ;;R^"860.8:",.02,"E"
 ;;D^INT2DT
 ;;R^"860.8:",1,1
 ;;D^  ;INT2DT(OCXDT,OCXF) ;      This Local Extrinsic Function converts an OCX internal format
 ;;R^"860.8:",1,2
 ;;D^  ; ; date into an Externl Format (Human Readable) date.   'OCXF=SHORT FORMAT OCXF=LONG FORMAT
 ;;R^"860.8:",1,3
 ;;D^  ; ;
 ;;R^"860.8:",100,1
 ;;D^  ;INT2DT(OCXDT,OCXF) ;      This Local Extrinsic Function converts an OCX internal format
 ;1;
 ;
