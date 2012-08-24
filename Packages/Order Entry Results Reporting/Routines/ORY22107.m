ORY22107 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*221) ;AUG 30,2005 at 11:41
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
 G ^ORY22108
 ;
 Q
 ;
DATA ;
 ;
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
 ;;R^"860.8:",100,23
 ;;D^  ; Q OCXMON_" "_OCXDAY_","_OCXYR
 ;;R^"860.8:",100,24
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^CREATININE CLEARANCE (ESTIMATED/CALCULATED)
 ;;R^"860.8:",.01,"E"
 ;;D^CREATININE CLEARANCE (ESTIMATED/CALCULATED)
 ;;R^"860.8:",.02,"E"
 ;;D^CRCL
 ;;R^"860.8:",1,1
 ;;D^The CrCl algorithm uses adjusted body weight if patient height is > 60 
 ;;R^"860.8:",1,2
 ;;D^inches.  Approved by the CPRS Clinical Workgroup 8/11/04, it is based on a
 ;;R^"860.8:",1,3
 ;;D^modified Cockcroft-Gault formula and was installed with patch OR*3*221.
 ;;R^"860.8:",1,4
 ;;D^For more information:
 ;;R^"860.8:",1,5
 ;;D^   http://www.ascp.com/public/pubs/tcp/1999/jan/cockcroft.shtml
 ;;R^"860.8:",1,6
 ;;D^ 
 ;;R^"860.8:",1,7
 ;;D^   CrCl (male) = (140 - age) x (adj body weight* in kg)       
 ;;R^"860.8:",1,8
 ;;D^                 --------------------------------------
 ;;R^"860.8:",1,9
 ;;D^                   (serum creatinine) x 72
 ;;R^"860.8:",1,10
 ;;D^  * If patient height is not greater than 60 inches, actual body weight 
 ;;R^"860.8:",1,11
 ;;D^    is used.
 ;;R^"860.8:",1,12
 ;;D^  CrCl (female) = 0.85 x CrCl (male) 
 ;;R^"860.8:",1,13
 ;;D^ 
 ;;R^"860.8:",1,14
 ;;D^To calculate adjusted body weight, the following equations are used:
 ;;R^"860.8:",1,15
 ;;D^Ideal body weight (IBW) = 50 kg x (for men) or 45 kg x (for women) + 
 ;;R^"860.8:",1,16
 ;;D^                          2.3 x (height in inches - 60) 
 ;;R^"860.8:",1,17
 ;;D^Adjusted body weight (Adj. BW) if the ratio of actual BW/IBW > 1.3 =
 ;;R^"860.8:",1,18
 ;;D^   (0.3 x (Actual BW - IBW)) + IBW
 ;;R^"860.8:",1,19
 ;;D^Adjusted body weight if the ratio of actual BW/IBW is not > 1.3 =
 ;;R^"860.8:",1,20
 ;;D^   IBW or Actual BW (whichever is less)
 ;;R^"860.8:",100,1
 ;;D^  ;CRCL(DFN) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; N HT,AGE,SEX,SCR,SCRD,CRCL,LRWKLD,RSLT,ORW,ORH,PSCR
 ;;R^"860.8:",100,4
 ;;D^  ; N HTGT60,ABW,IBW,BWRATIO,BWDIFF,LOWBW,ADJBW
 ;;R^"860.8:",100,5
 ;;D^  ; S RSLT="0^<Unavailable>"
 ;;R^"860.8:",100,6
 ;;D^  ; S PSCR="^^^^^^0"
 ;;R^"860.8:",100,7
 ;;D^  ; D VITAL^ORQQVI("WEIGHT","WT",DFN,.ORW,0,"",$$NOW^XLFDT)
 ;;R^"860.8:",100,8
 ;;D^  ; Q:'$D(ORW) RSLT
 ;;R^"860.8:",100,9
 ;;D^  ; S ABW=$P(ORW(1),U,3) Q:+$G(ABW)<1 RSLT
 ;;R^"860.8:",100,10
 ;;D^  ; S ABW=ABW/2.2  ;ABW (actual body weight) in kg
 ;;R^"860.8:",100,11
 ;;D^  ; D VITAL^ORQQVI("HEIGHT","HT",DFN,.ORH,0,"",$$NOW^XLFDT)
 ;;R^"860.8:",100,12
 ;;D^  ; Q:'$D(ORH) RSLT
 ;;R^"860.8:",100,13
 ;;D^  ; S HT=$P(ORH(1),U,3) Q:+$G(HT)<1 RSLT
 ;;R^"860.8:",100,14
 ;;D^  ; S AGE=$$AGE^ORQPTQ4(DFN) Q:'AGE RSLT
 ;;R^"860.8:",100,15
 ;;D^  ; S SEX=$P($$SEX^ORQPTQ4(DFN),U,1) Q:'$L(SEX) RSLT
 ;;R^"860.8:",100,16
 ;;D^  ; S OCXTL="" Q:'$$TERMLKUP^ORB31(.OCXTL,"SERUM CREATININE") RSLT
 ;;R^"860.8:",100,17
 ;;D^  ; S OCXTLS="" Q:'$$TERMLKUP^ORB31(.OCXTLS,"SERUM SPECIMEN") RSLT
 ;;R^"860.8:",100,18
 ;;D^  ; S SCR="",OCXT=0 F  S OCXT=$O(OCXTL(OCXT)) Q:'OCXT  D
 ;;R^"860.8:",100,19
 ;;D^  ; .S OCXTS=0 F  S OCXTS=$O(OCXTLS(OCXTS)) Q:'OCXTS  D
 ;;R^"860.8:",100,20
 ;;D^  ; ..S SCR=$$LOCL^ORQQLR1(DFN,$P(OCXTL(OCXT),U),$P(OCXTLS(OCXTS),U))
 ;;R^"860.8:",100,21
 ;;D^  ; ..I $P(SCR,U,7)>$P(PSCR,U,7) S PSCR=SCR
 ;;R^"860.8:",100,22
 ;;D^  ; S SCR=PSCR,SCRV=$P(SCR,U,3) Q:+$G(SCRV)<.01 RSLT
 ;;R^"860.8:",100,23
 ;;D^  ; S SCRD=$P(SCR,U,7) Q:'$L(SCRD) RSLT
 ;;R^"860.8:",100,24
 ;;D^  ; ;
 ;;R^"860.8:",100,25
 ;;D^  ; S HTGT60=$S(HT>60:(HT-60)*2.3,1:0)  ;if ht > 60 inches
 ;;R^"860.8:",100,26
 ;;D^  ; I HTGT60>0 D
 ;;R^"860.8:",100,27
 ;;D^  ; .S IBW=$S(SEX="M":50+HTGT60,1:45.5+HTGT60)  ;Ideal Body Weight
 ;;R^"860.8:",100,28
 ;;D^  ; .S BWRATIO=(ABW/IBW)  ;body weight ratio
 ;;R^"860.8:",100,29
 ;;D^  ; .S BWDIFF=$S(ABW>IBW:ABW-IBW,1:0)
 ;;R^"860.8:",100,30
 ;;D^  ; .S LOWBW=$S(IBW<ABW:IBW,1:ABW)
 ;;R^"860.8:",100,31
 ;;D^  ; .I BWRATIO>1.3,(BWDIFF>0) S ADJBW=((0.3*BWDIFF)+IBW)
 ;;R^"860.8:",100,32
 ;;D^  ; .E  S ADJBW=LOWBW
 ;;R^"860.8:",100,33
 ;;D^  ; I +$G(ADJBW)<1 D
 ;;R^"860.8:",100,34
 ;;D^  ; .S ADJBW=ABW
 ;;R^"860.8:",100,35
 ;;D^  ; S CRCL=(((140-AGE)*ADJBW)/(SCRV*72))
 ;;R^"860.8:",100,36
 ;;D^  ; ;
 ;;R^"860.8:",100,37
 ;;D^  ; S:SEX="M" RSLT=SCRD_U_$J(CRCL,1,1)
 ;;R^"860.8:",100,38
 ;;D^  ; S:SEX="F" RSLT=SCRD_U_$J((CRCL*.85),1,1)
 ;;R^"860.8:",100,39
 ;;D^  ; Q RSLT
 ;;R^"860.8:",100,40
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^ELAPSED ORDER CHECK TIME LOGGER
 ;;R^"860.8:",.01,"E"
 ;;D^ELAPSED ORDER CHECK TIME LOGGER
 ;;R^"860.8:",.02,"E"
 ;;D^TIMELOG
 ;;R^"860.8:",100,1
 ;;D^  ;TIMELOG(OCXMODE,OCXCALL) ; Log an entry in the Elapsed time log.
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; ;
 ;;R^"860.8:",100,4
 ;;D^  ; Q 0
 ;;R^"860.8:",100,5
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^EQUALS TERM OPERATOR
 ;;R^"860.8:",.01,"E"
 ;;D^EQUALS TERM OPERATOR
 ;;R^"860.8:",.02,"E"
 ;;D^EQTERM
 ;;R^"860.8:",100,1
 ;;D^  ;EQTERM(DATA,TERM) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^T+; I $G(OCXTRACE) W !,"%%%%",?20," Execution trace  DATA: ",$G(DATA),"   TERM: ",$G(TERM)
 ;1;
 ;
