BPSSCRCL ;BHAM ISC/SS - ECME SCREEN CLOSE CLAIMS ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,5,7,8,11,15,19**;JUN 2004;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to FIND^PSOREJUT supported by ICR #4706
 ;
 Q
 ;
CLO ;entry point to close claims
 N BPRET,BPSARR59
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Enter the line numbers for the claim(s) to be closed."
 S BPRET=$$ASKLINES^BPSSCRU4("Select item(s)","C",.BPSARR59,VALMAR)
 I BPRET="^" S VALMBCK="R" Q
 ;close claims
 ;update the content of the screen
 ;only if at least one claim was closed
 I $$CLOSE(.BPSARR59) D REDRAW^BPSSCRUD("Updating screen for closed claims...")
 E  S VALMBCK="R"
 Q
 ;
 ;close claims
 ;input:
 ; BP59ARR - array with ptrs to BPS TRANSACTION FILE
 ;       BP59ARR(ien59)="ien in TMP ^ number on the user screen"
 ;returns:
 ; BPCLTOT - number of closed claims
CLOSE(BP59ARR) ;
 N BPNEWARR,BPRETV,BPREJFLG,X
 N BPDFN,BP59,BPIFANY,BPQ,BPCLST,BPS52,BPSRF,BPSZ,BPSECOND
 N BPREAS,BPCOMM,BP90ANSW,BPRCOPAY,BPRXINFO,BPCOP,BPCLTOT,BPINS,BPINSNM,BP59FRST
 S BPRETV=$$MKNEWARR^BPSSCR05(.BP59ARR,.BPNEWARR,.BPINS)
 S BPQ="",BPIFANY=0,BPREJFLG=1,BPSECOND=0
 S BPDFN=""
 F  S BPDFN=$O(BPNEWARR(BPDFN)) Q:BPDFN=""  D  Q:BPQ="^"
 . W !!,"You've chosen to close the following prescription(s) for",!,$E($$PATNAME^BPSSCRU2(BPDFN),1,13)_" :"
 . S BP59="" F  S BP59=$O(BPNEWARR(BPDFN,BP59)) Q:BP59=""  D  Q:BPQ="^"
 . . I $Y>20 D PAUSE^VALM1 W @IOF I X="^" S BPQ="^" Q
 . . S BPIFANY=1,BPQ=""
 . . S BPREJFLG=+$P($G(BPNEWARR(BPDFN,BP59)),U,3)
 . . W !,@VALMAR@(+$G(BPNEWARR(BPDFN,BP59)),0)
 . . D DISPREJ^BPSSCRU6(BP59)
 . . ;can't close a closed claim. The user must reopen first.
 . . I $$CLOSED02^BPSSCR03($P($G(^BPST(BP59,0)),U,4)) W !,"This claim is already closed." S BPQ="^" Q
 . . ; Check for unresolved rejects - BPS*1*19
 . . S BPSZ=$$RXREF^BPSSCRU2(BP59)
 . . I $$FIND^PSOREJUT($P(BPSZ,U),$P(BPSZ,U,2)) D  Q
 . . . W !,"The Prescription is currently open in the pharmacist's Third Party Payer"
 . . . W !,"Reject Worklist. The claim cannot be closed until action is taken by the"
 . . . W !,"pharmacist."
 . . . S BPQ="^"
 . . ;get claim status from transaction
 . . S BPCLST=$$CLAIMST^BPSSCRU3(BP59)
 . . ;Is this a secondary claim?
 . . I $P($G(^BPST(BP59,0)),U,14)=2 S BPSECOND=1
 . . I $P($G(^BPST(BP59,0)),U,14)<2,$$PAYABLE^BPSOSRX5($P(BPCLST,U)),$$PAYBLSEC^BPSUTIL2(BP59) D  S BPQ="^" Q
 . . . W !,"The claim cannot be closed if the secondary claim is payable.",!,"Please reverse the secondary claim first."
 . . I BPSECOND,BPCLST'["E REJECTED",BPCLST'["E REVERSAL ACCEPTED" D  S BPQ="^" Q
 . . . W !,"The CLOSE action can only be applied to an E REJECTED or E REVERSAL ACCEPTED",!,"secondary claim. This claim is ",$P(BPCLST,U),".",!,"The secondary claim is also closed when the primary claim is closed."
 . . W:BPREJFLG=0 !,"Claim Neither Rejected Nor Reversed and cannot be Closed."
 I +BPRETV=0 Q $$QUITCL()
 I BPQ="^" Q $$QUITCL()
 ;
 ; check 2nd insurance, but only if closing a Primary claim.
 S BPQ=""
 I 'BPSECOND D
 . S BPDFN="" F  S BPDFN=$O(BPINS(BPDFN)) Q:BPDFN=""  D  Q:BPQ="^"
 . . S BPINSNM="" F  S BPINSNM=$O(BPINS(BPDFN,BPINSNM)) Q:BPINSNM=""  D  Q:BPQ="^"
 . . . S BP59FRST=0
 . . . S BP59=""
 . . . K BPRXINFO
 . . . F  S BP59=$O(BPINS(BPDFN,BPINSNM,BP59)) Q:BP59=""  D  Q:BPQ="^"
 . . . . S:BP59FRST=0 BP59FRST=BP59
 . . . . S BPRXINFO(BP59)=$E($G(@VALMAR@(+$G(BP59ARR(BP59)),0)),7,99)
 . . . ; Only check 2nd if the RX/Fill is released
 . . . S BPSZ=$$RXREF^BPSSCRU2(BP59FRST)
 . . . S BPS52=$P(BPSZ,U),BPSRF=$P(BPSZ,U,2)
 . . . Q:$$RELDATE^BPSBCKJ(BPS52,BPSRF)']""
 . . . ; call CH2NDINS^BPSSCRU5 only once for all claims for this patient and insurance
 . . . ; you can use one BP59FRST for the group of claims here as a parameter since 
 . . . ; they all are all identical from the "patient-insurance pair" point of view
 . . . D:BP59FRST>0 CH2NDINS^BPSSCRU5(BP59FRST,$E($$PATNAME^BPSSCRU2(BPDFN),1,13),BPINSNM,.BPRXINFO)
 ;
 I BPQ="^" Q $$QUITCL()
 ;
 W !!,"ALL Selected Rxs will be CLOSED using the same information gathered in the",!,"following prompts.",!
 S BPQ=$$YESNO^BPSSCRRS("Are you sure?(Y/N)")
 I BPQ'=1 Q $$QUITCL() ; 
 ; ask questions for all of them
 W !!
 I $$ASKQUEST(+$P(BPRETV,U,2),.BPREAS,.BPCOMM,.BP90ANSW,.BPRCOPAY)'=1 Q $$QUITCL()
 ;
 W @IOF
 ;and finally close all
 S BPCLTOT=0
 S BPDFN="" F  S BPDFN=$O(BPNEWARR(BPDFN)) Q:BPDFN=""  D
 . S BP59="" F  S BP59=$O(BPNEWARR(BPDFN,BP59)) Q:BP59=""  D
 . . I $P($G(BPNEWARR(BPDFN,BP59)),U,3)=0 Q  ;can't be closed
 . . S BPCOP=0
 . . I +BPRCOPAY=1,$P($G(BPNEWARR(BPDFN,BP59)),U,4)=1 S BPCOP=1 ;release copay
 . . I $$CLOSEIT(BP59,$P(BPREAS,U,2),BPCOMM,BP90ANSW,BPCOP)>0 D
 . . . S BPCLTOT=BPCLTOT+1
 ;
 W !,BPCLTOT," claim",$S(BPCLTOT'=1:"s have",1:" has")," been closed.",!
 D PAUSE^VALM1
 Q BPCLTOT
 ;
QUITCL() ;
 W !!,"0 claims have been closed."
 D PAUSE^VALM1
 Q 0
 ;/**
 ;Ask all necessary questions
 ;Input
 ; BPRELCOP - ask release copay question
 ; .BPREAZ - ptr to #356.8 ^ CLOSE REASON NAME ^ ECME FLAG ^ ECME PAPER FLAG
 ; .BPCOMZ - close comment (string)
 ; .BP90ANSZ - "", "D"(drop to paper) or "N" (non-billable)
 ; .BPRCOPAZ - 1(Yes) or 0(No) , answer to "release copay" question
 ;Output:
 ; 0 - cancel process
 ; ^ - emergency quit (cancel process)
 ; 1 - ok, can proceed
ASKQUEST(BPRELCOP,BPREAZ,BPCOMZ,BP90ANSZ,BPRCOPAZ) ;*/
 S BPCOMZ=""
 S BP90ANSZ=""
 S BPRCOPAZ=0
 ;ask the user to choose the close reason from #356.8
 ;using set of close reasons in IB file 356.8
 S BPREAZ=$$REASON()
 I BPREAZ="^" Q "^"
 I ($P(BPREAZ,U,4)=1) D  ;if has ECME PAPER FLAG
 . ;ask if the claim is still billable thru paper?
 . S BP90ANSZ=$$PROMPT^BPSSCRCV("S^N:NON-BILLABLE;D:DROP TO PAPER","Treat as (N)on-Billable Episode or (D)rop Bill to Paper?","")
 I BP90ANSZ=-1 Q "^"
 S BPCOMZ=$$COMMENT("Comment ",40)
 I (BPCOMZ="^") Q "^"
 I $L(BPCOMZ)>0,BPCOMZ?1" "." " S BPCOMZ=""
 ;check copay
 ;ask "release copay?" in all NON-BILLABLE cases, i.e. except user answered "DROP TO PAPER"
 ;(even in cases when he was not asked about it)
 I BP90ANSZ'="D",BPRELCOP D
 . ; Ask user if s/he wants to release a copay
 . S BPRCOPAZ=$$YESNO^BPSSCRRS("Release Patient CoPay(Y/N)")
 I BPRCOPAZ=-1 Q "^"
 ;
 S BPQ=$$YESNO^BPSSCRRS("Are you sure?(Y/N)")
 I BPQ=-1 Q "^" ;quit by "^"
 I BPQ'=1 Q 0 ;doesn't want to proceed
 Q 1 ; answers can be used
 ;
 ;/**
 ;ask for the close reason
 ;return:
 ;   ptr to #356.8 ^ CLOSE REASON NAME ^ ECME FLAG ^ ECME PAPER FLAG
REASON() ;
 N DIC,BPREASNM,BP3568,Y
 ; - Asks for REASON for Closing
 S DIC="^IBE(356.8,",DIC(0)="AEQMZ"
 S DIC("S")="I $P(^(0),U,2)=1"
 D ^DIC
 I Y=-1 Q "^"
 Q +Y_U_Y(0)
 ;/**
 ;enter the comment
 ;BPSTR  -prompt string
 ;BPMLEN -maxlen
COMMENT(BPSTR,BPMLEN) ;*/
 N DIR,DTOUT,DUOUT,BPQ
 I '$D(BPSTR) S BPSTR="Comment "
 I '$D(BPMLEN) S BPMLEN=40
 S DIR(0)="FO^0:250"
 S DIR("A")=BPSTR
 S DIR("?",1)="This response must have no more than "_BPMLEN_" characters"
 S DIR("?")="and must not contain embedded up arrow."
 S BPQ=0
 F  D  Q:+BPQ'=0
 . D ^DIR
 . I $D(DUOUT)!($D(DTOUT)) S BPQ=-1 Q
 . I $L(Y)'>BPMLEN S BPQ=1 Q
 . W !!,"This response must have no more than "_BPMLEN_" characters"
 . W !,"and must not contain embedded uparrow.",!
 . S DIR("B")=$E(Y,1,BPMLEN)
 Q:BPQ<0 "^"
 Q Y
 ;/** 
 ;close the claim
 ;the approach and code partially borrowed from IHS code CLOSE^BPSOS6N
 ;BPSTRA - ptr to #9002313.59
 ;REASON - text name of the close reason 
 ;BPSCLCM - comment 
 ;BPDROP:
 ;  "D" - DROP BILL TO PAPER
 ;  "N" - NON-BILLABLE
 ;BPRELCOP - 1 (Yes) or 0 (No) release copay or not?
CLOSEIT(BPSTRA,REASON,BPSCLCM,BPDROP,BPRELCOP) ;
 N BPSCLA,ERROR,DA,DR,BPLCK,DIE
 S BPSCLA=$$GET1^DIQ(9002313.59,BPSTRA,3,"I")
 W !,"Closing Claim ",$$GET1^DIQ(9002313.02,BPSCLA,.01),"..."
 S BPLCK=0
 L +^BPSC(BPSCLA):0
 I $T S BPLCK=1
 E  W !,"       *** CLAIM ",$$GET1^DIQ(9002313.02,BPSCLA,.01)," IN USE ***" Q 0
 D CLOSE^BPSBUTL(BPSCLA,BPSTRA,REASON,$S($G(BPDROP)="D":1,1:0),BPRELCOP,BPSCLCM,.ERROR)
 I $D(ERROR) W "NOT OK" D DSPERR(ERROR) D  Q 0
 . I BPLCK=1 L -^BPSC(BPSCLA)
 S DIE="^BPSC(",DA=BPSCLA,DR="901///1;902///"_$$NOW^XLFDT()_";903////"_DUZ_";904///"_REASON_";905////"_BPDROP D ^DIE
 I BPLCK=1 L -^BPSC(BPSCLA)
 H 1 W "OK"
 Q 1
 ;
DSPERR(MSG) ; Display the ERROR message
 W !,"Error: *** ",MSG," ***"
 Q
 ;
 ;/**
 ;ECME has tried to submit the claim to insurance with the name BPINSNAM
 ;but the claim was rejected and now we need to determine if the patient
 ;has any other insurance with pharmacy coverage that can be billed for the RX
 ;Input:
 ; BP59 - pointer to file #9002313.59
 ; BPINSNAM - insurance that have already been used by ECME
 ;Output:
 ; 0 - not found
 ; 1 ^ Insurance Name ^ Group Number ^ Date  of service
NEXTINS(BP59,BPINSNAM) ;get insurance info by the pointer of #9002313.59
 N BPDOS,BPDFN,BPZZ,BP36,BPX,BPHONE,BPY,BPINSNM
 N BPPHARM,BPCOORD,BPINS,BPFOUND
 S BPY=0
 S BPHONE=$P($G(^BPST(BP59,10,+$G(^BPST(BP59,9)),3)),U,2)
 S BPDOS=+$P($G(^BPST(BP59,12)),U,2)\1
 I BPDOS=0 S BPDOS=+$P($G(^BPST(BP59,0)),U,8)\1
 S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 ; call INSUR^IBBAPI to get information about:
 ;1 = Insurance Company Name
 ;7 = Coordination of Benefits (primary, secondary, tertiary)
 ;15 = Pharmacy Coverage?
 ;18 = Group Number
 S BPX=$$INSUR^IBBAPI(BPDFN,BPDOS,,.BPZZ,"1,7,15,18")
 S BP1="" F  S BP1=$O(BPZZ("IBBAPI","INSUR",BP1)) Q:+BP1=0  D
 . ;get pharmacy coverage
 . S BPPHARM=+$G(BPZZ("IBBAPI","INSUR",BP1,15))
 I BPX<1 Q 0
 D PROCINS(.BPZZ)
 ;check pharmacy coverage
 S BPFOUND=0 ;if found will be set to insurance node in the INSUR^IBBAPI array
 S BPPHARM=1 ;look only at those with pharmacy coverage
 S BPCOORD=0
 F  S BPCOORD=+$O(BPZZ("RES",BPPHARM,BPCOORD)) Q:BPCOORD=0!(BPFOUND'=0)  D
 . S BPINS=+$O(BPZZ("RES",BPPHARM,BPCOORD,0))
 . I BPINS>0 I $P($G(BPZZ("IBBAPI","INSUR",BPINS,1)),U,2)'=BPINSNAM S BPFOUND=BPINS
 I BPFOUND=0 Q 0
 Q 1_U_$P($G(BPZZ("IBBAPI","INSUR",BPFOUND,1)),U,2)_U_$P($G(BPZZ("IBBAPI","INSUR",BPFOUND,18)),U)_U_BPDOS
 ;
 ;process insurances
 ;input: local array returned by INSUR^IBBAPI
 ;output: BPZZ("RES",pharmacy coverage,coordination,insurance element # in BPZZ array)
PROCINS(BPZZ) ;
 N BP1,BP2,BP0,BPPHONE,BPPHARM,BPCOORD
 S BP1="" F  S BP1=$O(BPZZ("IBBAPI","INSUR",BP1)) Q:+BP1=0  D
 . ;get pharmacy coverage
 . S BPPHARM=+$G(BPZZ("IBBAPI","INSUR",BP1,15))
 . ;get coordination of benefits
 . S BPCOORD=+$G(BPZZ("IBBAPI","INSUR",BP1,7))
 . ;create ^TMP to sort results by pharmacy coverage and coordination of benefits
 . S BPZZ("RES",BPPHARM,BPCOORD,BP1)=""
 Q
