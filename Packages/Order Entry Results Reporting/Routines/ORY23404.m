ORY23404 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*234) ;MAY 13,2005 at 09:31
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**234**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY234ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY23405
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"860.8:",100,5
 ;;D^  ; I (OCXC["G") S:$L(OCXX) OCXX=OCXX_" and/or " S OCXX=OCXX_"Gastrografin"
 ;;R^"860.8:",100,6
 ;;D^  ; I (OCXC["I") S:$L(OCXX) OCXX=OCXX_" and/or " S OCXX=OCXX_"Ionic Iodinated"
 ;;R^"860.8:",100,7
 ;;D^  ; I (OCXC["N") S:$L(OCXX) OCXX=OCXX_" and/or " S OCXX=OCXX_"Non-ionic Iodinated"
 ;;R^"860.8:",100,8
 ;;D^  ; I (OCXC["L") S:$L(OCXX) OCXX=OCXX_" and/or " S OCXX=OCXX_"Gadolinium"
 ;;R^"860.8:",100,9
 ;;D^  ; I (OCXC["C") S:$L(OCXX) OCXX=OCXX_" and/or " S OCXX=OCXX_"Cholecystographic"
 ;;R^"860.8:",100,10
 ;;D^  ; I (OCXC["M") S:$L(OCXX) OCXX=OCXX_" and/or " S OCXX=OCXX_"Unspecified contrast media"
 ;;R^"860.8:",100,11
 ;;D^  ; Q OCXX
 ;;R^"860.8:",100,12
 ;;D^  ; ;
 ;;EOR^
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
 ;;R^"860.8:",100,2
 ;;D^  ; ; date into an Externl Format (Human Readable) date.   'OCXF=SHORT FORMAT OCXF=LONG FORMAT
 ;;R^"860.8:",100,3
 ;;D^  ; ;
 ;;R^"860.8:",100,4
 ;;D^  ; Q:'$L($G(OCXDT)) "" S OCXF=+$G(OCXF)
 ;;R^"860.8:",100,5
 ;;D^  ; N OCXYR,OCXLPYR,OCXMON,OCXDAY,OCXHR,OCXMIN,OCXSEC,OCXCYR
 ;;R^"860.8:",100,6
 ;;D^  ; S (OCXYR,OCXLPYR,OCXMON,OCXDAY,OCXHR,OCXMIN,OCXSEC,OCXAP)=""
 ;;R^"860.8:",100,7
 ;;D^  ; S OCXSEC=$E(OCXDT#60+100,2,3),OCXDT=OCXDT\60
 ;;R^"860.8:",100,8
 ;;D^  ; S OCXMIN=$E(OCXDT#60+100,2,3),OCXDT=OCXDT\60
 ;;R^"860.8:",100,9
 ;;D^  ; S OCXHR=$E(OCXDT#24+100,2,3),OCXDT=OCXDT\24
 ;;R^"860.8:",100,10
 ;;D^  ; S OCXCYR=($H\1461)*4+1841+(($H#1461)\365)
 ;;R^"860.8:",100,11
 ;;D^  ; S OCXYR=(OCXDT\1461)*4+1841,OCXDT=OCXDT#1461
 ;;R^"860.8:",100,12
 ;;D^  ; S OCXLPYR=(OCXDT\365),OCXDT=OCXDT-(OCXLPYR*365),OCXYR=OCXYR+OCXLPYR
 ;;R^"860.8:",100,13
 ;;D^  ; S OCXCNT="031^059^090^120^151^181^212^243^273^304^334^365"
 ;;R^"860.8:",100,14
 ;;D^  ; S:(OCXLPYR=3) OCXCNT="031^060^091^121^152^182^213^244^274^305^335^366"
 ;;R^"860.8:",100,15
 ;;D^  ; F OCXMON=1:1:12 Q:(OCXDT<$P(OCXCNT,U,OCXMON))
 ;;R^"860.8:",100,16
 ;;D^  ; S OCXDAY=OCXDT-$P(OCXCNT,U,OCXMON-1)+1
 ;;R^"860.8:",100,17
 ;;D^  ; I OCXF S OCXMON=$P("January^February^March^April^May^June^July^August^September^October^November^December",U,OCXMON)
 ;;R^"860.8:",100,18
 ;;D^  ; E  S OCXMON=$E(OCXMON+100,2,3)
 ;;R^"860.8:",100,19
 ;;D^  ; S OCXAP=$S('OCXHR:"Midnight",(OCXHR=12):"Noon",(OCXHR<12):"AM",1:"PM")
 ;;R^"860.8:",100,20
 ;;D^  ; I OCXF S OCXHR=OCXHR#12 S:'OCXHR OCXHR=12
 ;;R^"860.8:",100,21
 ;;D^  ; Q:'OCXF $E(OCXMON+100,2,3)_"/"_$E(OCXDAY+100,2,3)_$S((OCXCYR=OCXYR):" "_OCXHR_":"_OCXMIN,1:"/"_$E(OCXYR,3,4))
 ;;R^"860.8:",100,22
 ;;D^  ; Q:(OCXHR+OCXMIN+OCXSEC) OCXMON_" "_OCXDAY_","_OCXYR_" at "_OCXHR_":"_OCXMIN_"."_OCXSEC_" "_OCXAP
 ;1;
 ;
