BPSSCR04 ;BHAM ISC/SS - USER SCREEN ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;USER SCREEN
 Q
 ;input:
 ;BPTMP - TMP global to store data (example : $NA(^TMP($J,"BPSSCR")))
 ;BPARR - array with user profile information
COLLECT(BPTMP,BPARR) ;
 N BPBDT,BPEDT,BPSORT
 S BPBDT=BPARR("BDT") ;start date
 S BPEDT=BPARR("EDT") ;end date
 ;sort type - see SORTIT()
 S BPSORT=$G(BPARR(1.12))
 S:BPSORT="" BPSORT="T" ;default
 ;kill TMP
 ;look for  claims in 3 files
 ;temporary TMP file
 N BPTMP1 S BPTMP1=$NA(@BPTMP@("PRE59"))
 N BPTMP2 S BPTMP2=$NA(@BPTMP@("FILE59"))
 K @BPTMP1
 K @BPTMP2
 ;
 D LOOK02(BPBDT,BPEDT,BPTMP1,BPSORT)
 D LOOK57(BPBDT,BPEDT,BPTMP1,BPSORT)
 D LOOK59(BPBDT,BPEDT,BPTMP1,BPSORT)
 ;remove all claims that don't match filter criteria
 D FILTRALL^BPSSCR03(BPTMP1,BPTMP2,.BPARR)
 ;preliminary sorting for "T" sorting type
 I BPSORT="T" D TRDFNALL^BPSSCR03(BPTMP)
 ;final sorting 
 D SORTIT(BPTMP,BPSORT)
 K @BPTMP1
 K @BPTMP2
 Q
 ;Input:
 ;BPTMP - TMP global to store data (example : $NA(^TMP($J,"BPSSCR")))
 ;BPSORT:
 ;'T' FOR TRANSACTION DATE
 ;'D' FOR DIVISION (ECME pharmacy)
 ;'I' FOR INSURANCE
 ;'C' FOR REJECT CODE 
 ;'P' FOR PATIENT NAME
 ;'N' FOR DRUG NAME
 ;'B' FOR BILL TYPE (BB/RT)
 ;'L' FOR FILL LOCATION (Windows/Mail/CMOP) 
 ;'R' FOR RELEASED/NON-RELEASED RX
 ;'A' FOR ACTIVE/DISCONTINUED RX
 ;sort it and prepare the TMP for the user screen
SORTIT(BPTMP,BPSORT) ;*/
 ;S BP59=+$G(^TMP($J,"BPSSCR","SRT",BPSRT))
 ;BPSORT:
 ;TRANSACTION DATE - the last time when the record 
 ;in the file #9002313.59 -- BPS TRANSACTION FILE has been updated
 ;F   S X=$O(@BPTMP@("SRT",BPSRT))
 K @BPTMP@("SORT")
 N BPSRTVAL,BPTRDT,BP59,BPDFN,BPIEN,BPIENNM
 S BP59=0
 ;by transaction date -- sort by the patient/insurance combinations,
 ;which might have more than one claims. 
 ;- the first on the top will be the one which has the claim(s) with the 
 ;  most recent date (other claims in this group can have any other date)
 I BPSORT="T" D
 . D MKPATINS(BPTMP) ;1st step
 . D MKTRSORT(BPTMP) ;2nd step
 ;by patient name (and his/her insurances)
 I BPSORT="P" D
 . D MKNAMINS(BPTMP) ;1st step
 . D MKPTSORT(BPTMP) ;2nd step
 ;by insurance
 ;(the name will be shortened up to 10 chars and its 
 ;IEN is added to make the string unique) 
 I BPSORT="I" D
 . F  S BP59=$O(@BPTMP@("FILE59",BP59)) Q:+BP59=0  D
 . . S BPIEN=$$GETINSUR^BPSSCRU2(+BP59)
 . . S BPIENNM=$S(+BPIEN>0:$E($P(BPIEN,U,2),1,10)_U_(+BPIEN),1:"0")
 . . D SETSORT(BPTMP,BPSORT,BPIENNM,BP59)
 ;by division
 ;(the name will be shortened up to 10 chars and its 
 ;IEN is added to make the string unique) 
 I BPSORT="D" D
 . F  S BP59=$O(@BPTMP@("FILE59",BP59)) Q:+BP59=0  D
 . . S BPIEN=+$$DIVIS^BPSSCRU2(+BP59)
 . . S BPIENNM=$S(BPIEN>0:$E($$DIVNAME^BPSSCRDS(BPIEN),1,10)_U_(BPIEN),1:"0")
 . . D SETSORT(BPTMP,BPSORT,BPIENNM,BP59)
 ;by reject code
 ;the same claim can be listed more than once (under different reject code
 ;sections) because each claim may have more than one reject code.
 I BPSORT="C" D
 . F  S BP59=$O(@BPTMP@("FILE59",BP59)) Q:+BP59=0  D
 . . N BPRJCDS,BPRJ
 . . D REJCODES^BPSSCRU3(+BP59,.BPRJCDS)
 . . S BPRJ=""
 . . F  S BPRJ=$O(BPRJCDS(BPRJ)) Q:BPRJ=""  D
 . . . D SETSORT(BPTMP,BPSORT,BPRJ,BP59)
 ;by drug names 
 ;(the name will be shortened upto 10 chars and its 
 ;IEN is added to make the string unique) 
 I BPSORT="N" D
 . F  S BP59=$O(@BPTMP@("FILE59",BP59)) Q:+BP59=0  D
 . . S BPIEN=+$$GETDRG59^BPSSCRU2(+BP59)
 . . S BPIENNM=$S(BPIEN>0:$E($$DRGNAM^BPSSCRU2(BPIEN),1,10)_U_(BPIEN),1:"0")
 . . D SETSORT(BPTMP,BPSORT,BPIENNM,BP59)
 ;by claim origination type (BB- backbilling, RT- realtime)
 I BPSORT="B" D
 . F  S BP59=$O(@BPTMP@("FILE59",BP59)) Q:+BP59=0  D
 . . D SETSORT(BPTMP,BPSORT,$$RTBB^BPSSCRU2(+BP59),BP59)
 ;by filling location 
 ;M-MAIL/W-WINDOW/C-CMOP
 I BPSORT="L" D
 . F  S BP59=$O(@BPTMP@("FILE59",BP59)) Q:+BP59=0  D
 . . D SETSORT(BPTMP,BPSORT,$$MWCNAME^BPSSCRU2($$GETMWC^BPSSCRU2(+BP59)),BP59)
 ;by released (1) /non released (0)
 I BPSORT="R" D
 . F  S BP59=$O(@BPTMP@("FILE59",BP59)) Q:+BP59=0  D
 . . D SETSORT(BPTMP,BPSORT,$$ISRXREL^BPSSCRU2(+BP59),BP59)
 ;by status of the fill ACT-active/DIS-discontinued/SUS-suspended/etc
 I BPSORT="A" D
 . F  S BP59=$O(@BPTMP@("FILE59",BP59)) Q:+BP59=0  D
 . . D SETSORT(BPTMP,BPSORT,$$RXST^BPSSCRU2(+BP59),BP59)
 ;
 ;K @BPTMP@("FILE59")
 Q
 ;set SORT node
SETSORT(BPTMP,BPSORT,BPSRTVAL,BP59) ;*/
 S:$L(BPSRTVAL)>0 @BPTMP@("SORT",BPSORT,BPSRTVAL,BP59)=""
 Q
 ;first look at ^BPSC (#9002313.02) for fill/refill x-ref
 ; since #9002313.57 is not created at the time of refill
 ; and since #9002313.59 has the last update date, which can be any kind of date (released/reversal/etc)
 ;BPBEGDT - start date
 ;BPENDDT - end date
 ;BPTMP - tmp global for items found
 ;BPSORT - sort type (see COLLECT^BPSSCR04)
LOOK02(BPBEGDT,BPENDDT,BPTMP,BPSORT) ;
 N BP02,BPENDDT1,BPLDT02,BP59
 S BP59=0
 S BPLDT02=$$FM2YMD(BPBEGDT-0.00001)
 S BPENDDT1=$$FM2YMD(BPENDDT)
 I BPLDT02="" S BPLDT02=0
 I BPENDDT1="" S BPENDDT1=99999999
 F  S BPLDT02=+$O(^BPSC("AF",BPLDT02)) Q:BPLDT02=0!(BPLDT02>BPENDDT1)  D
 . S BP02=0 F  S BP02=$O(^BPSC("AF",BPLDT02,BP02)) Q:+BP02=0  D
 . . S BP59=+$O(^BPST("AE",BP02,0))
 . . Q:BP59=0
 . . I $D(@BPTMP@(BP59)) Q
 . . S @BPTMP@(BP59)=$$YMD2FM(BPLDT02)_"^02"
 Q
 ; finds claims in  #9002313.57 for given date frame
 ;#9002313.59 has only one entry per claim with, which has a date 
 ;  of the latest update for the claim
 ;#9002313.57 has more than one entries per claim and keep all 
 ;  changes made the claim
 ;so we have to go thru #9002313.57 to find the earliest date 
 ;related to the claim to check it against BPBEGDT
 ;BPBEGDT - start date
 ;BPENDDT - end date
 ;BPTMP - tmp global for items found
 ;BPSORT - sort type (see COLLECT^BPSSCR04)
LOOK57(BPBEGDT,BPENDDT,BPTMP,BPSORT) ;
 N BPLDT57,BP57,BP59
 S BPLDT57=BPBEGDT-0.00001
 F  S BPLDT57=+$O(^BPSTL("AH",BPLDT57)) Q:BPLDT57=0!(BPLDT57>BPENDDT)  D
 . S BP57=0 F  S BP57=$O(^BPSTL("AH",BPLDT57,BP57)) Q:+BP57=0  D
 . . S BP59=+$G(^BPSTL(BP57,0))
 . . I $D(@BPTMP@(BP59)) Q  ;don't create an entry if the claim is already there
 . . S @BPTMP@(BP59)=(BPLDT57\1)_"^57-"
 Q
 ; finds claims in  #9002313.59 for given date frame
 ;#9002313.59 has only one entry per claim with, which has a date 
 ;  of the latest update for the claim
 ;#9002313.57 has more than one entries per claim and keep all 
 ;  changes made the claim
 ;so we have to go thru #9002313.57 to find the earliest date 
 ;related to the claim to check it against BPBEGDT
 ;BPBEGDT - start date
 ;BPENDDT - end date
 ;BPTMP - tmp global for items found
 ;BPSORT - sort type (see COLLECT^BPSSCR04)
LOOK59(BPBEGDT,BPENDDT,BPTMP,BPSORT) ;
 N BPLDT59,BP59
 S BPLDT59=BPBEGDT-0.00001
 F  S BPLDT59=+$O(^BPST("AH",BPLDT59)) Q:BPLDT59=0!(BPLDT59>BPENDDT)  D
 . S BP59=0 F  S BP59=$O(^BPST("AH",BPLDT59,BP59)) Q:+BP59=0  D
 . . I $D(@BPTMP@(BP59)) Q  ;don't create an entry if the claim is already there
 . . S @BPTMP@(BP59)=(BPLDT59\1)_"^59-"
 Q
 ;
YMD2FM(BPYMD) ;convert YYYYDDMM to FM date
 Q (($E(BPYMD,1,4))-1700)_$E(BPYMD,5,8)
 ;
FM2YMD(BPFMDT) ;convert FM date to YYYYMMDD
 N Y,Y1
 S Y=$E(BPFMDT,2,3),Y1=$E(BPFMDT,1,1) S Y=$S(Y1=3:"20"_Y,Y1=2:"19"_Y,1:"")
 Q:Y Y_$E(BPFMDT,4,7)
 Q ""
 ;make PATIENT -INSURANCE intermediate SORTING
 ;global for transaction and patient sortings (1st pass)
 ;example:
 ;@BPTMP@("SORT","PI",BPDFN,BPINS,BP59)=""
MKPATINS(BPTMP) ;
 N BPSRTVAL,BPTRDT,BP59,BPDFN,BPINS
 S BP59=0
 F  S BP59=+$O(@BPTMP@("FILE59",BP59)) Q:+BP59=0  D
 . S BPDFN=+$$GETPATID^BPSSCRU2(BP59)
 . Q:BPDFN=0
 . S BPINS=+$$GETINSUR^BPSSCRU2(BP59)
 . S @BPTMP@("SORT","PI",BPDFN,BPINS,BP59)=""
 Q
 ;make PATIENT NAME -INSURANCE intermediate SORTING
 ;global for transaction and patient sortings (1st pass)
 ;example:
 ;@BPTMP@("SORT","PNI",BPDFN,BPINS,BP59)=""
MKNAMINS(BPTMP) ;
 N BPSRTVAL,BPTRDT,BP59,BPDFN,BPINS
 S BP59=0
 F  S BP59=+$O(@BPTMP@("FILE59",BP59)) Q:+BP59=0  D
 . S BPDFN=+$$GETPATID^BPSSCRU2(BP59)
 . Q:BPDFN=0
 . S BPINS=+$$GETINSUR^BPSSCRU2(BP59)
 . S @BPTMP@("SORT","PNI",$E($$PATNAME^BPSSCRU2(BPDFN),1,20)_BPDFN,BPINS,BP59)=""
 Q
 ;Transaction type sorting - the 2nd pass
 ;is called after MKPATINS
MKTRSORT(BPTMP) ;
 N BPSRTVAL,BPTRDT,BP59,BPDFN,BPINS
 S BPTRDT=-99999999,BPSRTVAL=0
 F  S BPTRDT=$O(@BPTMP@("TRDTDFN",BPTRDT)) Q:+BPTRDT=0  D
 . S BPDFN=0
 . F  S BPDFN=$O(@BPTMP@("TRDTDFN",BPTRDT,BPDFN)) Q:+BPDFN=0  D
 . . S BPINS=""
 . . F  S BPINS=$O(@BPTMP@("TRDTDFN",BPTRDT,BPDFN,BPINS)) Q:BPINS=""  D
 . . . S BPSRTVAL=BPSRTVAL+1,BPINS=+BPINS
 . . . S BP59=0
 . . . F  S BP59=$O(@BPTMP@("SORT","PI",BPDFN,BPINS,BP59)) Q:+BP59=0  D
 . . . . D SETSORT(BPTMP,"T",BPSRTVAL,BP59)
 Q
 ;Patient type sorting - the 2nd pass
 ;is called after MKPATINS
MKPTSORT(BPTMP) ;
 N BPSRTVAL,BPTRDT,BP59,BPPATNAM,BPINS
 S BPPATNAM="",BPSRTVAL=0
 F  S BPPATNAM=$O(@BPTMP@("SORT","PNI",BPPATNAM)) Q:BPPATNAM=""  D
 . S BPINS="" ;"" to handle claims without insurance (corrupted data)
 . F  S BPINS=$O(@BPTMP@("SORT","PNI",BPPATNAM,BPINS)) Q:BPINS=""  D
 . . S BPSRTVAL=BPSRTVAL+1,BPINS=+BPINS
 . . S BP59=0
 . . F  S BP59=$O(@BPTMP@("SORT","PNI",BPPATNAM,BPINS,BP59)) Q:+BP59=0  D
 . . . D SETSORT(BPTMP,"P",BPSRTVAL,BP59)
 Q
 ;
