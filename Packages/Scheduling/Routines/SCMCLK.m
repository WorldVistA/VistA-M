SCMCLK ;bp/cmf - Preceptor History Functions ; Sep 1999
 ;;5.3;Scheduling;**177,204**;AUG 13, 1993
 ;
 ; - $$OKPREC functions
 ;        - input variables (required)
 ;               scien    := pointer to 404.57 (precepted ien)
 ;               scpien   := pointer to 404.57 (preceptor ien)
 ;               sclnkdt  := date to test
 ;        - output        
 ;               $p1      := 1=assignment ok
 ;                           0=not
 ;               $p2      := if not, reason code
 ;               $p3      := if not, reason
 ; 
OKPREC(SCIEN,SCPIEN,SCLNKDT) ;
 ;
 S SCIEN=+$G(SCIEN,0)
 S SCPIEN=+$G(SCPIEN,0)
 S SCLNKDT=+$G(SCLNKDT,0)
 I (SCIEN<1)!(SCPIEN<1)!(SCLNKDT<1) Q $$S(8)
 ; 
 I SCIEN=SCPIEN Q $$S(1)
 ;
 N SCX,SCY,SCPAH,SCPAHA
 I '$D(^SCTM(404.57,SCIEN,0)) Q $$S(8)
 S SCX=$G(^SCTM(404.57,SCIEN,0))
 I '$D(^SCTM(404.57,SCPIEN,0)) Q $$S(8)
 S SCY=^SCTM(404.57,SCPIEN,0)
 I $P(SCX,U,2)'=$P(SCY,U,2) Q $$S(2)
 ;
 D DTARY(0)
 S SCPAH=$$VALHIST^SCAPMCU5(404.53,SCPIEN,"SCPAHA")
 I $$ACTHIST^SCAPMCU5("SCPAHA","SCLNKDT") Q $$S(3)
 ;I $$ACTHIST^SCAPMCU2(404.53,SCPIEN,"SCLNKDT") Q $$S(3)
 ;
 I '+$P(SCY,U,12) Q $$S(4)
 ;
 I +$P(SCX,U,4),'+$P(SCY,U,4) Q $$S(5)
 ;
 I $$ACTHIST^SCAPMCU2(404.59,SCPIEN,"SCLNKDT")<1 Q $$S(6)
 ;
 I $$CHKPRTP() Q $$S(9)
 ;
 Q 1
 ;
OKPREC1(SCPIEN,SCLNKDT) ;
 ;               ; prevent preceptor assignment danglers
 ;               ; should also return array of danglers, if any,
 ;               ; for a cleanup function, but not asked for yet
 ;
 ;
 S SCPIEN=+$G(SCPIEN,0)
 S SCLNKDT=+$G(SCLNKDT,0)
 I (SCPIEN<1)!(SCLNKDT<1) Q $$S(8)
 I '$D(^SCTM(404.53,"AD",SCPIEN)) Q 1
 ;
 N SCX,SCN
 D DTARY(1)
 K ^TMP("SCPHIS",$J)
 S SCX=$$PRECHIS(SCPIEN,"SCLNKDT","^TMP(""SCPHIS"",$J)")
 K ^TMP("SCPHIS",$J)
 ;
 Q $S(SCX>0:$$S(7),1:1)
 ;
OKPREC2(SCIEN,SCLNKDT) ; return preceptor ien^name, if any
 ;               ; used for computed field 306 of file 404.57
 ;
 ;
 S SCIEN=+$G(SCIEN,0)
 S SCLNKDT=+$G(SCLNKDT,0)
 I (SCIEN<1)!(SCLNKDT<1) Q $$S(8)
 N SCX,SCP2,SCP3,SCPIEN,SCLNKLI,SCLNKER,SCPAH,SCPAHA
 D DTARY(0)
 S SCPAH=$$VALHIST^SCAPMCU5(404.53,SCIEN,"SCPAHA")
 S SCX=$$ACTHIST^SCAPMCU5("SCPAHA","SCLNKDT")
 ;S SCX=$$ACTHIST^SCAPMCU2(404.53,SCIEN,"SCLNKDT")
 I +SCX<1 Q ""
 S SCP2=$P(SCX,U,2)
 I +SCP2<1 Q ""
 S SCP3=$P(SCX,U,3)
 I '$D(^SCTM(404.53,SCP3,0)) Q $$S(8)
 S SCPIEN=$P(^SCTM(404.53,SCP3,0),U,6)
 Q $$GETPRTP^SCAPMCU2(SCPIEN,SCLNKDT)
 ;
OKPREC3(SCIEN,SCLNKDT) ; return preceptor position ien^name, if any
 ;               ; used for computed field 305 of file 404.57
 ;
 ;
 S SCIEN=+$G(SCIEN,0)
 S SCLNKDT=+$G(SCLNKDT,0)
 I (SCIEN<1)!(SCLNKDT<1) Q $$S(8)
 N SCX,SCP2,SCP3,SCPIEN,SCLNKER,SCPAH,SCPAHA
 D DTARY(0)
 S SCPAH=$$VALHIST^SCAPMCU5(404.53,SCIEN,"SCPAHA")
 S SCX=$$ACTHIST^SCAPMCU5("SCPAHA","SCLNKDT")
 ;S SCX=$$ACTHIST^SCAPMCU2(404.53,SCIEN,"SCLNKDT")
 I +SCX<1 Q ""
 S SCP2=$P(SCX,U,2)
 I +SCP2<1 Q ""
 S SCP3=$P(SCX,U,3)
 I '$D(^SCTM(404.53,SCP3,0)) Q $$S(8)
 S SCPIEN=$P(^SCTM(404.53,SCP3,0),U,6)
 Q SCPIEN_U_$$EXT^SCAPMCU2(404.53,SCPIEN)
 ;
OKPREC4(SCIEN) ; return if precepted position can be un-precepted
 ;       ; if patient assign after 1st preceptment date, NO
 ;       ; used by computed field #400 of file 404.57
 S SCIEN=$G(SCIEN,0)
 I (SCIEN<1)!('$D(^SCTM(404.57,SCIEN))) Q $$S(8)
 I '$D(^SCTM(404.53,"B",SCIEN)) Q 1
 ;
 N SCVALHIS,SCDT,SCX
 S SCDT=$P($$VALHIST^SCAPMCU5(404.53,SCIEN,"SCVALHIS"),U,2)
 I SCDT=0 Q 1
 S SCX=$$PCPOSCNT^SCAPMCU1(SCIEN,SCDT,0,1)
 Q $S(SCX>0:$$S(10),1:1)
 ;
OKPREC5(SCIEN,SCLNKDT) ; if position has a preceptor,
 ;               ; is preceptor link valid?
 ;
 S SCIEN=$G(SCIEN,0)
 S SCLNKDT=$G(SCLNKDT,DT)
 I (SCIEN<1)!(SCLNKDT<1) Q $$S(8)
 N SCPIEN
 S SCPIEN=+$$OKPREC3(SCIEN,SCLNKDT)
 I SCPIEN<1 Q 1
 Q $$OKPREC(SCIEN,SCPIEN,SCLNKDT)
 ;
PRECHIS(SCPIEN,SCDATES,SCLIST) ;return precepted positions for preceptor
 ; input
 ;    SCPIEN := preceptor pos ien (404.57) (required)
 ;    SCDATES := standard PCMM date array  (required)
 ;    SCDATES(begin) := start date [default = DT]
 ;    SCDATES(end)   := end date   [default = DT]
 ;    SCDATES(incl)  := always set to 0
 ;    SCLIST := output array (required)
 ;
 ; output
 ;    @SCLIST@(scn)
 ;     format := 
 ;      pieces 1-13:  same as SCLIST(scn,) node of $$prtp^scapmc8
 ;      pieces 14-16: same as SCLIST(scn,'PR',) node of $$prtp^scapmc8
 ;    @SCLIST@('SCPR',precepted team posn ien (404.57) +
 ;                   ,preceptor start date +
 ;                   ,preceptor asgn ien, +
 ;                   ,precepted posn asgn ien,scn)
 ;
 S SCPIEN=+$G(SCPIEN,0)
 S SCDATES=$G(SCDATES)
 S SCLIST=$G(SCLIST)
 I (SCPIEN<1)!(SCDATES']"")!(SCLIST']"") Q $$S(8)
 ;
 N SCN,SCPVAL,SCPN,SCIEN,SCX,SCXP,SCXPR,SCXARY,SCXDT
 N SCPTP,SCPTPN,SCBEGIN,SCEND,SCESEQ,SCLSEQ
 N SCP1P11,SCP12,SCP13,SCP14,SCP15,SCP16,SCR
 ;
 S (@SCDATES@("BEGIN"),SCBEGIN)=$G(@SCDATES@("BEGIN"),DT)
 S (@SCDATES@("END"),SCEND)=$G(@SCDATES@("END"),DT)
 S @SCDATES@("INCL")=0
 ;
 I '$D(^SCTM(404.53,"D",SCPIEN)) Q 0
 I '$D(^SCTM(404.53,"AD",SCPIEN)) Q 0
 S SCPN=0                              ; incrementor
 S @SCLIST@(0)=0
 S SCIEN=0
 F  S SCIEN=$O(^SCTM(404.53,"AD",SCPIEN,SCIEN)) Q:'SCIEN  D
 . ;K SCXPR
 . ;S SCX=$$ACTHIST^SCAPMCU2(404.53,SCIEN,.SCDATES,"SCXER","SCXPR")
 . ;Q:+SCX<1
 . K SCPVAL(SCIEN)
 . S SCX=$$VALHIST^SCAPMCU5(404.53,SCIEN,"SCPVAL("_SCIEN_")")
 . Q:'$D(SCPVAL(SCIEN))
 . S SCX=$$ACTHIST^SCAPMCU5("SCPVAL("_SCIEN_")",.SCDATES)
 . Q:+SCX<1
 . ;
 . S SCX=0
 . F  S SCX=$O(^SCTM(404.53,"AD",SCPIEN,SCIEN,1,SCX)) Q:'SCX  D
 . . Q:'$D(SCPVAL(SCIEN,"I",SCX))
 . . S SCXARY=$O(SCPVAL(SCIEN,"I",SCX,0))
 . . S SCP14=$O(SCPVAL(SCIEN,SCXARY,0))              ;precept start dt
 . . S SCP16=$O(SCPVAL(SCIEN,SCXARY,SCP14,0))        ;precept start ien
 . . S SCP15=$P(SCPVAL(SCIEN,SCXARY,SCP14,SCP16),U)
 . . S SCP15=$S(+SCP15>1:SCP15,1:9999999)            ;precept end dt
 . . Q:'$$DTCHK^SCAPU1(SCBEGIN,SCEND,0,SCP14,SCP15)
 . . K SCPTP
 . . K SCXDT
 . . S SCXDT("BEGIN")=SCP14
 . . S SCXDT("END")=SCP15
 . . S SCXDT("INCL")=0
 . . S SCXP=$$PRTP^SCAPMC8(SCIEN,"SCXDT","SCPTP","SCPTPE")
 . . Q:+$G(SCPTP(0))<1
 . . F SCXP=1:1:SCPTP(0) D
 . . . S SCPN=SCPN+1
 . . . S SCP1P11=$P(SCPTP(SCXP),U,1,11)
 . . . S SCP12=$P(SCPTP(SCXP),U,12)
 . . . S SCP13=$P(SCPTP(SCXP),U,13)
 . . . S SCR=SCP1P11_U_SCP12_U_SCP13_U_SCP14_U_SCP15_U_SCP16
 . . . S @SCLIST@(0)=SCPN
 . . . S @SCLIST@(SCPN)=SCR
 . . . S @SCLIST@("SCPR",SCIEN,SCP14,SCP16,$P(SCR,U,11),SCPN)=""
 . . . Q
 . . Q
 . K SCPVAL(SCIEN)
 . Q
 ;
PRECQ Q @SCLIST@(0)>0
 ;
DTARY(SCX) ;
 S SCLNKDT("BEGIN")=SCLNKDT
 S SCLNKDT("END")=$S(SCX=1:9999999,1:SCLNKDT)
 S SCLNKDT("INCL")=0
 ;I $G(SCLIST)]"" S SCLNKDT("END")=$G(SCLNKDT0,9999999)
 Q
 ;
CHKPRTP() ;
 Q $$GETPRTP^SCAPMCU2(SCIEN,SCLNKDT)=$$GETPRTP^SCAPMCU2(SCPIEN,SCLNKDT)
 ;
S(SCX) Q 0_U_SCX_U_$P($T(T+SCX),";;",2)_"."
 ;
T ;;
1 ;;Position can't precept itself;;
2 ;;Preceptor and precepted must be on same team;;
3 ;;Preceptor can't have a preceptor on assignment date;;
4 ;;Preceptor must be able to act as a preceptor;;
5 ;;Preceptor must be PC if precepted is PC;;
6 ;;Preceptor must be active on assignment date;;
7 ;;Active or future precepted position(s);;
8 ;;Invalid Parameter
9 ;;Preceptor/Precepted Staff can't be the same;;
10 ;;Position has patient assignments after precepted date;;
 ;
