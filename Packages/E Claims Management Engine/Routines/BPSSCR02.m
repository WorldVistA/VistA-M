BPSSCR02 ;BHAM ISC/SS - USER SCREEN UTILITIES ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;USER SCREEN
 ;
REVERSE ; 
 N BPSDFN,BPSRX
 D SELECT(.BPSDFN,.BPSRX)
 S VALMBCK="R"
 Q
 ;
SELECT(BPSDFN1,BPSRX1,BPSRF1,BPS59) ; Select a patient.  Returns patient IEN(s) in array
 N BPLN
 S BPLN=$$SELLINE("Select the line(s) with the paid claim(s) you wish to REVERSE","")
 Q
 ;
SELLINE(BPSPROM,BPSDFVL) ;
 N BPRET,DIR,X,Y,DIRUT
 S BPRET="^"
 W ! S DIR(0)="N^::2",DIR("A")=BPSPROM,DIR("B")=BPSDFVL D ^DIR I $D(DIRUT) Q "^"
 S $P(BPRET,U)=Y
 Q BPRET
 ;/**
 ;make array element
 ;BPLINE - line number in LM ARRAY (by ref)
 ;BPTMP - VALMAR (TMP global for LM)
 ;BP59 - ptr to 9002313.59
 ;BPLMIND - passed by ref - current patient(/insurance) index ( to make 1, 2,etc)
 ;BPDRIND - passed by ref - current claim level index ( to make .1, .2, .10,... .20,... )
 ;TMP structure gives on the screen:
 ;^TMP("BPSSCR",$J,"VALM","LMIND",1,0,DFN,0,0)=
 ;^TMP("BPSSCR",$J,"VALM",1,0)=1   BUMSTEAD,CHARLE (5444)/100-234-2345 *done* FINISHED
 ;BPLINE = 1
 ;BPLMIND=1
 ;on the screen:
 ;1   BUMSTEAD,CHARLE      (5444)   /100-234-2345 *done* FINISHED
 ;
 ;^TMP(538978189,"BPSSCR","SORT","T",1,401959.00001)=
 ;^TMP("BPSSCR",$J,"VALM","LMIND",1,1,DFN,401959.00001,1)=
 ;^TMP("BPSSCR",$J,"VALM",2,0)=  1.1   LOVASTATIN 20MG TAB
 ;BPLINE = 2
 ;BP59= 401959.00001
 ;on the screen:
 ;  1.1   LOVASTATIN 20MG TAB
 ;
 ;^TMP(538978189,"BPSSCR","SORT","T",1,501750.00011)=
 ;^TMP("BPSSCR",$J,"VALM","LMIND",1,2,DFN,501750.00011,2)=
 ;^TMP("BPSSCR",$J,"VALM",3,0)=  1.2   CIMETIDINE 300MG TAB
 ;BPLINE = 3
 ;BP59= 501750.00011
 ;on the screen:
 ;  1.2   CIMETIDINE 300MG TAB
 ;
MKARRELM(BPLINE,BPTMP,BP59,BPLMIND,BPDRIND,BPPREV) ;*/
 N BPSSTR,BPLNS,BPDFN,BPSTAT,BPSINSUR,BPINSDAT
 S BPDFN=+$P($G(^BPST(BP59,0)),U,6) ;patient's DFN
 S BPINSDAT=$$GETINSUR^BPSSCRU2(BP59)
 S BPSINSUR=+BPINSDAT ;patient's insurance IEN
 ;
 ;PATIENT SUMMARY level
 ; if last one was different DFN/INSURANCE combination then create a new Patient Summary level
 I (+$O(@BPTMP@("LMIND",BPLMIND,0,0))'=BPDFN)!(+$O(@BPTMP@("LMIND",BPLMIND,0,BPDFN,0))'=BPSINSUR) D
 . ;-------- first process previous patient & insurance group
 . ;determine patient summary statuses for the previous "patient" group
 . I BPLMIND>0,+BPPREV=BPLMIND D
 . . ;update the record for previous patient summary after we went thru all his claims
 . . D UPDPREV(BPTMP,BPLMIND,BPPREV)
 . ;process new "patient & insurance" group ------------------
 . S BPDRIND=0
 . S BPLMIND=(BPLMIND\1)+1
 . ;save the all necessary data for the patient & insurance to use as previous for STAT4PAT later on
 . S BPPREV=BPLMIND_U_BPLINE_U_BPDFN_U_$$PATINF(BPDFN,BPINSDAT)_U_BPSINSUR
 . S BPSSTR=$$LJ(BPLMIND,4)_$P(BPPREV,U,4)
 . D SAVEARR(BPTMP,BPLMIND,BPDRIND,BPDFN,0,BPLINE,BPSSTR,BPSINSUR)
 . S BPLINE=BPLINE+1
 ;
 ;CLAIMS level
 D
 . I +$O(@BPTMP@("LMIND",BPLMIND,BPDRIND,BPDFN,0))'=BP59 D
 . . S BPDRIND=BPDRIND+1
 . . S BPSSTR="  "_$$LJ(+$P(BPLMIND,".")_"."_BPDRIND,5)_" "_$$CLAIMINF(BP59)
 . . ;@debug,remove the next line after finish debugging
 . . ;S BPSSTR=BPSSTR_" 59:"_BP59_" DT:"_$$TRANDT^BPSSCRU2(BP59)_" DFN:"_BPDFN_" INS:"_BPSINSUR
 . . D SAVEARR(BPTMP,BPLMIND,BPDRIND,BPDFN,BP59,BPLINE,BPSSTR,BPSINSUR)
 . . S BPLINE=BPLINE+1
 . . N BPARR,X
 . . S BPLNS=$$ADDINF^BPSSCR03(BP59,.BPARR,74,"R")
 . . F X=1:1:BPLNS D
 . . . I $G(BPARR(X))="" Q
 . . . D SAVEARR(BPTMP,BPLMIND,BPDRIND,BPDFN,BP59,BPLINE,"      "_BPARR(X),BPSINSUR)
 . . . S BPLINE=BPLINE+1
 Q
 ;S BPS=BPX
 ;/**
 ;BP59
CLAIMINF(BP59) ;*/
 N BPX,BPX1
 S BPX1=$$RXREF^BPSSCRU2(BP59)
 ;S BPX=BP59_$$LJ($$DRGNAME^BPSSCRU2(BP59),22)_"  "_$$LJ($$NDC^BPSSCRU2(+BPX1,+$P(BPX1,U,2)),13)_"  "
 S BPX=$$LJ($$DRGNAME^BPSSCRU2(BP59),17)_"  "_$$LJ($$NDC^BPSSCRU2(+BPX1,+$P(BPX1,U,2)),13)_" "
 S BPX=BPX_$$LJ($$FILLDATE^BPSSCRRS(+BPX1,+$P(BPX1,U,2)),5)_" "
 S BPX=BPX_$$LJ($$RXNUM^BPSSCRU2(+BPX1),11)_" "_+$P(BPX1,U,2)_"/"
 S BPX=BPX_$$LJ($$ECMENUM^BPSSCRU2(BP59),7)_" "_$$MWCNAME^BPSSCRU2($$GETMWC^BPSSCRU2(BP59))_" "
 S BPX=BPX_$$RTBB^BPSSCRU2(BP59)_" "_$$RXST^BPSSCRU2(BP59)_"/"_$$RL^BPSSCRU2(BP59)
 Q BPX
 ;/**
 ;determine "done" and "FINISHED" status for patient/insurance group by BPLMIND in TMP global
STAT4PAT(BPLMIND) ;*/
 N BPCL,BPDFN,BP59,BPX,BPINS,BPX,BPCNT,BPELI
 N BPPB,BPRJ,BPACRV,BPRJRV,BPSR,BPFIN,BPPRCNTG
 S (BPCL,BPPB,BPRJ,BPACRV,BPSR,BPRJRV)=0
 S BPFIN=0 ; finished by default
 S BPPRCNTG=0
 S BPCNT=0
 F  S BPCL=+$O(@BPTMP@("LMIND",BPLMIND,BPCL)) Q:BPCL=0  D
 . S BPDFN=0
 . F  S BPDFN=+$O(@BPTMP@("LMIND",BPLMIND,BPCL,BPDFN)) Q:BPDFN=0  D
 . . S BPINS="" ;can be 0 in the TMP global if insurance plan
 . . ;is corrupted in file ##9002313.59
 . . F  S BPINS=$O(@BPTMP@("LMIND",BPLMIND,BPCL,BPDFN,BPINS)) Q:BPINS=""  D
 . . . S BP59=0,BPINS=+BPINS
 . . . F  S BP59=+$O(@BPTMP@("LMIND",BPLMIND,BPCL,BPDFN,BPINS,BP59)) Q:BP59=0  D
 . . . . S BPCNT=BPCNT+1
 . . . . S BPX=$P($$CLAIMST^BPSSCRU3(BP59),U)
 . . . . I BPX["E PAYABLE" S BPPB=BPPB+1 ;Payable
 . . . . I BPX["E REJECTED" S BPRJ=BPRJ+1 ;Rejected
 . . . . I BPX["E REVERSAL ACCEPTED" S BPACRV=BPACRV+1 ;Accepted Reversal 
 . . . . I BPX["E REVERSAL REJECTED" S BPRJRV=BPRJRV+1 ;Rejected Reversal
 . . . . I $D(BP59) S BPELI=$$ELIGCODE^BPSSCR05($G(BP59))
 S BPX=$S($G(BPELI)="V":"Vet",$G(BPELI)="T":"Tri",$G(BPELI)="C":"Cha",1:"Unk")
 ;
 I BPPB=BPCNT S BPX=BPX_" ALL payable"
 E  S BPX=BPX_" Pb:"_BPPB_" Rj:"_BPRJ_" AcRv:"_BPACRV_" RjRv:"_BPRJRV
 Q BPX
 ;/**
 ;gets the patient summary information
 ;input:
 ; BPDFN - ptr to #2
 ; BPINS - insurance ien^insurance name^phone 
 ;output:
 ; patient summary information
PATINF(BPDFN,BPINS) ;*/
 N X,BPINSNM
 S BPINSNM=$P(BPINS,U,2)
 S X=$$LJ^BPSSCR02($$PATNAME^BPSSCRU2(BPDFN),13) ;name
 S X=X_" "_$$LJ($$SSN4^BPSSCRU2(BPDFN),6) ;4digits of SSN
 S X=X_" "_$$LJ($S(BPINSNM="":"????",1:BPINSNM),8) ;insurance
 S X=X_"/"_$$LJ($P(BPINS,U,3),14) ;phone
 Q X
 ;
 ;/**
 ;creates an entry in LM array and builds a non-standard index
 ;BPLMIND - passed by ref - current LM index - patient_AND_insurance level 
 ;BPDRIND - passed by ref - current LM index  - claim level 
 ;BPTMP - VALMAR (TMP global for LM)
 ;BP59 - ptr to 9002313.59
 ;BPLINE - line number in LM ARRAY (by ref)
 ;BPSTR - string to save in ARRAY
 ;BPSINSUR - INSURANCE ien
SAVEARR(BPTMP1,BPLMIND,BPDRIND,BPDFN,BP59,BPLINE,BPSSTR,BPSINSUR) ;
 S @BPTMP1@("LMIND",BPLMIND,BPDRIND,BPDFN,BPSINSUR,BP59,BPLINE)=""
 D SET^VALM10(BPLINE,BPSSTR,BP59)
 Q
 ;left justified, blank padded
 ;adds spaces on right or truncates to make return string BPLEN characters long
 ;BPST- original string
 ;BPLEN - desired length
LJ(BPST,BPLEN) ;
 N BPL
 S BPL=BPLEN-$L(BPST)
 Q $E(BPST_$J("",$S(BPL<0:0,1:BPL)),1,BPLEN)
 ;
 ;right justified, blank padded
 ;adds spaces on left or truncates to make return string BPLEN characters long
 ;BPST- original string
 ;BPLEN - desired length
RJ(BPST,BPLEN)  ;
 S BPL=BPLEN-$L(BPST)
 I BPL>0 Q $J("",$S(BPL<0:0,1:BPL))_BPST
 Q $E(BPST,1,BPLEN)
 ;
 ;is the claim payable?
PAYABLE(BP59) ;
 I $P($$CLAIMST^BPSSCRU3(BP59),U)["E PAYABLE" Q 1
 Q 0
 ;
 ;is the claim rejected?
REJECTED(BP59) ;
 I $P($$CLAIMST^BPSSCRU3(BP59),U)["E REJECTED" Q 1
 I $P($$CLAIMST^BPSSCRU3(BP59),U)["E REVERSAL REJECTED" Q 1
 Q 0
 ;update patient summary information for the previous patient/insurance pair
UPDPREV(BPTMP,BPLMIND,BPPREV) ;
 N BPSSTR
 ;update the record for previous patient summary after we went thru all his claims
 S BPSSTR=$$LJ^BPSSCR02(BPLMIND,4)_$P(BPPREV,U,4)_" "_$$STAT4PAT^BPSSCR02(BPLMIND)
 D SAVEARR^BPSSCR02(BPTMP,BPLMIND,0,+$P(BPPREV,U,3),0,+$P(BPPREV,U,2),BPSSTR,+$P(BPPREV,U,5))
 Q
 ;
