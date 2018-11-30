BPSSCRU4 ;BHAM ISC/SS - ECME SCREEN UTILITIES ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3**;JUN 2004;Build 20
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 ;USER SCREEN
 Q
 ;
 ;repeatedly prompts the user for line#
 ;the user should "^" to quit or enter a correct line #
 ;input:
 ;  BPROMPT - prompt string
 ;  BPTYPE expected user's selection on level 
 ;  of P-patient or C-claim or PC - both
 ;  BPERRMES - optional - the message to display when the user
 ;    tries to make multi line selection
 ;  BPDFLT - default value for the prompt (optional)
 ;output:
 ;  piece 1: 
 ;   1 - okay
 ;   <0 - errors
 ;   0 - user wants to quit
 ;  piece 2: patient ien #2
 ;  piece 3: insurance ien #36
 ;  piece 4: ptr to #9002313.59
 ;  piece 5: 1st line for index(es) in LM "VALM" array
 ;  piece 6: patient's index
 ;  piece 7: claim's index
ASKLINE(BPROMPT,BPTYPE,BPERRMES,BPDFLT) ;
 N BPRET,BPCNT
 S BPRET="",BPCNT=0
 F  S BPRET=$$SELLINE(BPROMPT,BPTYPE,VALMAR,$G(BPDFLT)) Q:BPRET'<0  D
 . ;D RE^VALM4
 . ;
 . I BPCNT<1 S BPCNT=BPCNT+1 W !
 . E  S BPCNT=0 D RE^VALM4
 . I BPRET=-1 W " - Invalid line number" ; (invalid Patient summary line)"
 . I BPRET=-8 W " - ",$S($G(BPERRMES)]"":BPERRMES,1:" Invalid line number")
 . I BPRET=-4 W " - Invalid line number" ; (invalid RX line)"
 . I BPRET=-2 W " - Please select Patient's summary line."
 . I BPRET=-3 W " - Please specify RX line."
 . I BPRET<-4 W " - Incorrect format." ; Corrupted array (",BPRET,")"
 Q BPRET
 ;/**
 ;prompts the user for line# for various menu option of the User Screen
 ;input:
 ;  BPROMPT - prompt string
 ;  BPTYPE - expected user's selection on level 
 ;  of P-patient or C-claim or PC - both
 ;  BPTMP1 - temporary global (VALMAR)
 ;  BPDFLT - default value for the prompt (optional)
 ;output:
 ;  piece 1: 
 ;   1 - okay
 ;   <0 - errors
 ;   0 - user wants to quit
 ;  piece 2: patient ien #2
 ;  piece 3: insurance ien #36
 ;  piece 4: ptr to #9002313.59
 ;  piece 5: 1st line for index(es) in LM "VALM" array
 ;  piece 6: patient's index
 ;  piece 7: claim's index
SELLINE(BPROMPT,BPTYPE,BPTMP1,BPDFLT) ;*/
 N BPX,BPLINE,BPPATIND,BPCLMIND
 N BPDFN,BPSINSUR,BP59,BP1LN
 S BPLINE=$$PROMPT(BPROMPT,$G(BPDFLT))
 I BPLINE="^" Q 0
 S BPPATIND=+$P(BPLINE,".")
 I (BPLINE["-")!(BPLINE[",") Q -8  ;multiple line input in not allowed
 I '$D(@BPTMP1@("LMIND",BPPATIND)) Q -1  ;the patient level doesn't exist
 S BPCLMIND=+$P(BPLINE,".",2)
 I BPTYPE="P",BPCLMIND>0 Q -2  ;P was requested but claim portion was provided
 I BPTYPE="C",BPCLMIND=0 Q -3  ;C was requested but claim portion was not provided
 I '$D(@BPTMP1@("LMIND",BPPATIND,BPCLMIND)) Q -4  ;the claim level doesn't exist
 S BPDFN=$O(@BPTMP1@("LMIND",BPPATIND,BPCLMIND,0))
 I +BPDFN=0 Q -5  ;error
 S BPSINSUR=$O(@BPTMP1@("LMIND",BPPATIND,BPCLMIND,BPDFN,""))
 I BPSINSUR="" Q -6  ;error
 ;if fractional part was entered
 I BPCLMIND>0 D  I +BP59=0 Q -7  ;error
 . S BP59=$O(@BPTMP1@("LMIND",BPPATIND,BPCLMIND,BPDFN,BPSINSUR,0))
 I BPCLMIND=0 S BP59=0
 S BP1LN=$O(@BPTMP1@("LMIND",BPPATIND,BPCLMIND,BPDFN,BPSINSUR,BP59,0))
 I +BP1LN=0 Q -7  ;error
 Q "1"_U_BPDFN_U_BPSINSUR_U_BP59_U_BP1LN_U_BPPATIND_U_BPCLMIND
 ;
 ;input:
 ;BPSPROM - prompt text
 ;BPSDFVL - default value (optional)
 ;returns:
 ; "response^"
PROMPT(BPSPROM,BPSDFVL) ;
 N BPRET,DIR,X,Y,DIRUT
 S BPRET="^"
 S DIR(0)="F^::2",DIR("A")=BPSPROM
 I $L($G(BPSDFVL))>0 S DIR("B")=$G(BPSDFVL)
 D ^DIR I $D(DIRUT) Q "^"
 S $P(BPRET,U)=Y
 Q BPRET
 ;
 ;/**
 ;check and process user input
 ;input:
 ;  BPLINE - input string
 ;  BPTYPE - expected user's selection on level 
 ;  of P-patient or C-claim or PC - both
 ;  BPTMP1 - temporary global (VALMAR)
 ;output:
 ;  piece 1: 
 ;   1 - okay
 ;   <0 - errors
 ;   0 - user wants to quit
 ;  piece 2: patient ien #2
 ;  piece 3: insurance ien #36
 ;  piece 4: ptr to #9002313.59
 ;  piece 5: 1st line for index(es) in LM "VALM" array
 ;  piece 6: patient's index
 ;  piece 7: claim's index
CHECKLN(BPLINE,BPTYPE,BPTMP1) ;*/
 N BPX,BPPATIND,BPCLMIND
 N BPDFN,BPSINSUR,BP59,BP1LN
 I BPLINE="^" Q 0
 S BPPATIND=+$P(BPLINE,".")
 I '$D(@BPTMP1@("LMIND",BPPATIND)) Q -1  ;the patient level doesn't exist
 S BPCLMIND=+$P(BPLINE,".",2)
 I BPTYPE="P",BPCLMIND>0 Q -2  ;P was requested but claim portion was provided
 I BPTYPE="C",BPCLMIND=0 Q -3  ;C was requested but claim portion was not provided
 I '$D(@BPTMP1@("LMIND",BPPATIND,BPCLMIND)) Q -4  ;the claim level doesn't exist
 S BPDFN=$O(@BPTMP1@("LMIND",BPPATIND,BPCLMIND,0))
 I +BPDFN=0 Q -5  ;error
 S BPSINSUR=$O(@BPTMP1@("LMIND",BPPATIND,BPCLMIND,BPDFN,""))
 I BPSINSUR="" Q -6  ;error
 ;if fractional part was entered
 I BPCLMIND>0 D  I +BP59=0 Q -7  ;error
 . S BP59=$O(@BPTMP1@("LMIND",BPPATIND,BPCLMIND,BPDFN,BPSINSUR,0))
 I BPCLMIND=0 S BP59=0
 S BP1LN=$O(@BPTMP1@("LMIND",BPPATIND,BPCLMIND,BPDFN,BPSINSUR,BP59,0))
 I +BP1LN=0 Q -7  ;error
 Q "1"_U_BPDFN_U_BPSINSUR_U_BP59_U_BP1LN_U_BPPATIND_U_BPCLMIND
 ;
 ;
 ;BPTMP = VALMAR
 ;input:
 ; BPROMPT - prompt text
 ; BPTYPE - expected user's selection on level 
 ;  of P-patient or C-claim or PC - both
 ; BPTMP - temporary global (like VALMAR)
 ; BPARRLN2 - to return results
 ;output :
 ;  1 if okay
 ;  -1 -invalid format
 ;  ^ - quit
 ;  BPARRLN2 - Array(B59)="line# in VALM"^"PatientIndex.ClaimIndex"
 ;example:
 ;  BPARR(30045.00001)=134^2.34
ASKLINES(BPROMPT,BPTYPE,BPARRLN2,BPTMP) ;
 N BPQ,BPXLN,BPN,BPLN,BPZ
 N BPL,BPCLM
 N BPARRLN1,BPX1
 S BPSPROM="Select item(s)"
 S BPLN=$$PROMPT(BPSPROM,"")
 I BPLN="^" Q "^"
 S BPLN=$P(BPLN,U)
 S BPQ=0
 F BPN=1:1 S BPX1=$P(BPLN,",",BPN) Q:$L(BPX1)=0  D  Q:BPQ'=0
 . S BPZ=$$MKINDEXS(BPX1,BPTMP,.BPARRLN1)
 . I BPZ<1 S BPQ=-1
 . I (BPZ=-1)!(BPZ=-2) W !,"Invalid format.",!
 . I (BPZ=-3) W !,"Not a valid selection.",!
 Q:BPQ=-1 -1
 ;
 N BPPAT,BPCLM
 S BPPAT=0 F  S BPPAT=$O(BPARRLN1(BPPAT)) Q:BPPAT=""  D
 . S BPCLM=0 F  S BPCLM=$O(BPARRLN1(BPPAT,BPCLM)) Q:BPCLM=""  D
 . . S BP1=$G(BPARRLN1(BPPAT,BPCLM))
 . . Q:$L(BP1)=0
 . . S BPARRLN2(+$P(BP1,U,4))=+$P(BP1,U,5)_U_BPPAT_"."_BPCLM
 Q 1
 ;
 ;/**
 ;checks for dashes and if so then create a number of indexes for the range
 ;i.e. convert all "1.2-2.3" to "1.2,1.3,1.4,2.1,2.2,2.3"
 ;AND create entries in BPARR for all "right" indexes
 ;input:
 ;BPVAL - value to check (exmpl: "1.2-2.4")
 ;BPTMP1 - global ref with data (exmpl: VALMAR)
 ;BPARR - array with parsed line indexes 
 ;output:
 ;Exmpl:
 ; BPARR(1.2)=""
 ; BPARR(1.3)=""
 ; ...
 ; returns:
 ; 1 - okay
 ; <0 invalid format 
MKINDEXS(BPVAL,BPTMP1,BPARR) ;
 N BPFR,BPTO,BPQ,BPRET
 N BPPAT,BPCLM,BPCLSTRT,BPCLEND,BPQ2
 N BPFRPAT,BPTOPAT,BPFRCLM,BPTOCLM,BP1
 S BPQ=0
 S BPRET=1
 I BPVAL'["-" D  Q BPRET
 . S BPPAT=$P(BPVAL,".",1)
 . I BPPAT'=+BPPAT S BPRET=-1 Q  ;invalid format, patient part is not numeric
 . S BPCLM=$P(BPVAL,".",2)
 . ;if only patient index
 . I $L(BPCLM)=0 D  Q
 . . S BPQ2=0
 . . F BPCLM=1:1 D  Q:BPQ2'=0
 . . . ;quit if there are no more claims for the patient
 . . . S BP1=$$CHECKLN(BPPAT_"."_BPCLM,"C",BPTMP1)
 . . . I BP1<1 S BPQ2=1 Q
 . . . S BPARR(+BPPAT,+BPCLM)=BP1
 . ;if only patient+claim index
 . I BPCLM'=+BPCLM S BPRET=-2 Q  ;invalid format, claim portion is not numeric
 . S BP1=$$CHECKLN(BPPAT_"."_BPCLM,"C",BPTMP1)
 . I BP1<1 S BPRET=-3 Q  ;not found
 . S BPARR(+BPPAT,+BPCLM)=BP1
 ;********* if contains "-"
 S BPFR=$P(BPVAL,"-",1)
 S BPTO=$P(BPVAL,"-",2)
 I BPTO["-" Q -3  ;invalid format (to many dashes)
 S BPFRPAT=$P(BPFR,".",1)
 S BPTOPAT=$P(BPTO,".",1)
 S BPFRCLM=$P(BPFR,".",2)
 I $L(BPFRCLM)=0 S BPFRCLM=1
 S BPTOCLM=$P(BPTO,".",2)
 I $L(BPTOCLM)=0 S BPTOCLM=999999
 I BPFRPAT'=+BPFRPAT Q -1  ;invalid format, patient part is not numeric
 I BPTOPAT'=+BPTOPAT Q -1  ;invalid format, patient part is not numeric
 I BPFRCLM'=+BPFRCLM Q -2  ;invalid format, claim portion is not numeric
 I BPTOCLM'=+BPTOCLM Q -2  ;invalid format, claim portion is not numeric
 F BPPAT=BPFRPAT:1:BPTOPAT D
 . I BPPAT=BPFRPAT S BPCLSTRT=BPFRCLM
 . E  S BPCLSTRT=1
 . I BPPAT=BPTOPAT S BPCLEND=BPTOCLM
 . E  S BPCLEND=999999
 . S BPQ2=0
 . F BPCLM=BPCLSTRT:1:BPCLEND D  Q:BPQ2'=0
 . . ;quit if there are no more claims for the patient
 . . S BP1=$$CHECKLN(BPPAT_"."_BPCLM,"C",BPTMP1)
 . . I BP1<1 S BPQ2=1 Q
 . . S BPARR(+BPPAT,+BPCLM)=BP1
 Q 1
 ;
