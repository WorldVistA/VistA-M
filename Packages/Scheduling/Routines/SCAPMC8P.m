SCAPMC8P ;bp/cmf - preceptor sub-array for practitioner list ; 8/10/99 1:19pm
 ;;5.3;Scheduling;**177,212**;AUG 13, 1993
 ;;1.0
 ;
PRCTP ; preceptor practitioners for position
 ;
ST N SCDATES1,SCN1,SCEFF1,SCPAH1,SCACT1,SCINDT1,SCNODE1,SCPRTP1
 N SCDATES2,SCN2,SCPTP,SCX,SCXA,SCXE,SCNA,SCNE,SCPRCLST,SCPRCPTR
 N SCP1P11,SCP12,SCP13,SCP14P16,SCR
 N SCLIST1,SCLIST2,SCN3,SCN4,SCPS,SCPSX,SCPSXA,SCPSXE,SCVALHIS
 ;
 S @SCLIST@("PR","CH")=$$VALHIST^SCAPMCU5(404.53,SCTP,"SCVALHIS")
 G:'$$ACTHIST^SCAPMCU5("SCVALHIS","SCDATES") PRECQ
 G:'$D(SCVALHIS) PRECQ
 ;
LOOP1 ; build list of preceptor assignments
 S SCEFF1=-(SCEND+.000001)
 S (SCN1,SCLIST1(0))=0
 F  S SCEFF1=$O(^SCTM(404.53,"AIDT",SCTP,1,SCEFF1)) Q:'SCEFF1  D
 . ;Q:'$$ACTHIST^SCAPMCU2(404.53,SCTP,SCDATES,.SCERR,"SCPRTP1")
 . S SCPAH1=""
 . F  S SCPAH1=$O(^SCTM(404.53,"AIDT",SCTP,1,SCEFF1,SCPAH1),-1) Q:'SCPAH1  D
 . . Q:'$D(SCVALHIS("I",SCPAH1))
 . . N SCACT1,SCI
 . . S SCNODE1=^SCTM(404.53,SCPAH1,0)
 . . S SCI=$O(SCVALHIS("I",SCPAH1,0))
 . . S SCACT1=$O(SCVALHIS(SCI,0))
 . . S SCPTP=+$P(SCNODE1,U,6)
 . . Q:$D(SCLIST1("SCPR",SCACT1,SCPTP))
 . . S SCINDT1=$P(SCVALHIS(SCI,SCACT1,SCPAH1),U)
 . . Q:'$$DTCHK^SCAPU1(SCBEGIN,SCEND,SCINCL,SCACT1,SCINDT1)
 . . S SCN1=SCN1+1
 . . S SCLIST1(0)=SCN1
 . . S SCLIST1(SCN1)=SCPTP_U_SCACT1_U_SCINDT1_U_SCPAH1
 . . S SCLIST1("SCPR",SCACT1,SCPTP,SCN1)=""
 . . Q
 . Q
 ;
LOOP2 ; get preceptors for preceptor assignments
 G:SCLIST1(0)<1 PRECQ
 S SCLIST2(0)=SCLIST1(0)
 F SCN2=1:1:SCLIST2(0) D
 . S SCX=SCLIST1(SCN2)
 . ; bp/cmf 212 begin
 . ; OLD CODE BELOW
 . ;S SCPTP=$P(SCX,U)
 . ;K SCPRCLST
 . ;Q:'$$PRTP^SCAPMC8(SCPTP,"SCDATES","SCPRCLST",SCERR,0)
 . ; OLD CODE ABOVE
 . ; NEW CODE BELOW
 . S SCPTP=$P(SCX,U)
 . S SCDATES1("BEGIN")=$P(SCX,U,2)
 . S SCDATES1("END")=$P(SCX,U,3)
 . S SCDATES1("INCL")=0
 . K SCPRCLST
 . Q:'$$PRTP^SCAPMC8(SCPTP,"SCDATES1","SCPRCLST",SCERR,0)
 . ; NEW CODE ABOVE
 . ; bp/cmf 212 end
 . Q:'$D(SCPRCLST(0))
 . S SCLIST2(SCN2,0)=SCPRCLST(0)
 . F SCN3=1:1:SCPRCLST(0) D
 . . S SCLIST2(SCN2,SCN3)=SCPRCLST(SCN3)
 . Q
 ;
LOOP3 ; add preceptor sub-array to sclist
 G:SCLIST2(0)<1 PRECQ
 F SCN1=1:1:@SCLIST@(0) D
 . S SCXA=$P(@SCLIST@(SCN1),U,9)                          ;asgn actdt
 . S SCXE=$P(@SCLIST@(SCN1),U,10)
 . S SCXE=$S(+SCXE:SCXE,1:9999999)                        ;asgn enddt
 . S SCNA=SCXE
 . S SCN4=0
 . F  S SCNA=$O(SCLIST1("SCPR",SCNA),-1) Q:'SCNA  D       ;prec actdt
 . . S SCPTP=$O(SCLIST1("SCPR",SCNA,0))                   ;prec tpien
 . . S SCN2=$O(SCLIST1("SCPR",SCNA,SCPTP,0))
 . . Q:'$D(SCLIST2(SCN2))
 . . S SCP14P16=$P(SCLIST1(SCN2),U,2,4)                   ;prec string
 . . S SCNE=$P(SCLIST1(SCN2),U,3)
 . . S SCNE=$S(+SCNE:SCNE,1:9999999)                      ;prec enddt
 . . Q:SCNE<SCXA
 . . F SCN3=1:1:SCLIST2(SCN2,0) D
 . . . ; bp/cmf 212 begin
 . . . ; old code below
 . . . ;S SCN4=SCN4+1
 . . . ;S SCPSX=SCLIST2(SCN2,SCN3)                         ;asgn string
 . . . ;S SCP1P11=$P(SCPSX,U,1,11)                         ;pos string
 . . . ;S SCP12=$P(SCPSX,U,12)                             ;should be ""
 . . . ;S SCP13=$P(SCPSX,U,13)                             ;should be ""
 . . . ;S SCR=SCP1P11_U_SCP12_U_SCP13_U_SCP14P16           ;rtrn string
 . . . ; old code above
 . . . ; new code below
 . . . S SCPSX=SCLIST2(SCN2,SCN3)                         ;asgn string
 . . . Q:'$$DTCHK^SCAPU1(SCXA,SCXE,0,$P(SCPSX,U,9),$P(SCPSX,U,10))
 . . . S SCN4=SCN4+1
 . . . S SCP1P11=$P(SCPSX,U,1,11)                         ;pos string
 . . . S SCP12=$P(SCPSX,U,12)                             ;should be ""
 . . . S SCP13=$P(SCPSX,U,13)                             ;should be ""
 . . . S SCR=SCP1P11_U_SCP12_U_SCP13_U_SCP14P16           ;rtrn string
 . . . ; new code above
 . . . ; bp/cmf 212 end
 . . . S @SCLIST@(SCN1,"PR",SCN4)=SCR
 . . . S @SCLIST@(SCN1,"PR",0)=SCN4
 . . . S @SCLIST@(SCN1,"SCPR",$P(SCR,U),$P(SCR,U,3),$P(SCR,U,14),SCN4)=""
 . . . Q
 . . Q
 . Q
 ;
PRECQ I +SCALLHIS D TPALL^SCAPMC8A(404.53)
 Q
 ;
