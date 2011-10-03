DGUTL2 ;ALB/MJK/AAS - CALCULATE PASS DAYS UTILITY ; 8/5/02 5:48pm
 ;;5.3;Registration;**259,468**;Aug 13, 1993
 ;
 ;
CALC ; -- calculate days
 ;  input: DGBDT := begin date
 ;         DGEDT := end date
 ;         DGADM := adm date
 ;         DGPMCA:= corresponding. admission.
 ;         DGMVTP:= type movements to count - see below
 ; output: DGREC := #days count asih
 ;
 Q:'$D(DGMVTP)
 S DGREC=0,DGXFRS="^UTILITY($J,""DGXFRS"")"
 F DGI=DGADM:0 S DGI=$O(^DGPM("APCA",DFN,DGPMCA,DGI)) Q:'DGI!(DGI>DGEDT)  I $D(^DGPM(+$O(^(DGI,0)),0)),$P(^(0),U,2)=2 S @DGXFRS@(DGI)=+$P(^(0),U,18)
 F DGI=0:0 S DGI=$O(@DGXFRS@(DGI)) Q:'DGI  I DGMVTP[(U_@DGXFRS@(DGI)_U) S DGA=$O(@DGXFRS@(DGI)) I $S('DGA:1,1:DGA'<DGBDT) S X2=$S(DGI<DGBDT:DGBDT,1:DGI),X1=$S('DGA:DGEDT,DGA<DGEDT:DGA,1:DGEDT) D ^%DTC S DGREC=DGREC+X Q:'DGA
CALCQ K @DGXFRS,DGXFRS,DGI Q
 ;
ASIH ;calculate asih days
 S DGMVTP="^13^43^44^45^" G CALC
 ;
PL ;calculate total PASS and UA, AA leave days
 S DGMVTP="^1^2^3^25^26^" G CALC
 ;
PLASIH ;calculate pass, leave and asih days
 S DGMVTP="^1^2^3^25^26^13^43^44^45^" G CALC
 ;
APLD(DGPMCA,DGARR,DGBDT,DGEDT,DGMTYP) ;Return ASIH, pass & leave days and dates
 ;Input: DGPMCA=corresponding admission (pointer to file #405).
 ;Input: DGARR=output array name.
 ;Input: DGBDT=billing begin date. 
 ;Input: DGEDT=billing end date. 
 ;Input: DGMTYP=movement types (optional) where:
 ;            'A' = ASIH movements
 ;            'P' = pass and leave movements
 ;            'B' = both (default)
 ;
 ;Output: '-1' as an extrinisic value if input parameters are invalid.  
 ;          1  as an extrinisic value if input parameters are valid.  
 ;          Total ASIH,PASS & LEAVE days returned as array (DGARR). 
 ;
 ;Output: DGARR array where:
 ;        DGARR(0)=Total days^Begin date^End date.
 ;        DGARR(Movement_Ien Pointer to 405)=Movement_start_date^Movement_end_date^
 ;        Total_days^Movement_type(Pointer to 405.2)^(used only to denote a return
 ;        movement set as "RTN")^Return_Movement_type^Return_Movement_Ien.
 ;
 ;validate input
 N DFN,DGMOV,DGMVTP,SOL,EOL,DGM0,TDGI,TDGM,DGI,DGM,X1,X2,DGCT,DGDIS,X
 N DGPL,DGRC,MDT,RTN,NDGM,PROCESS,RTN,XSOL,XSOL,XDGMOV,ISOL,RCNT,DGRTMV,DGIB K DGARR
 S DGPMCA=$G(DGPMCA),DGMTYP=$G(DGMTYP),(DGBDT)=($G(DGBDT)\1),DGEDT=($G(DGEDT)\1)
 I DGBDT<1!(DGEDT<1)!(DGPMCA="")!'$D(^DGPM(DGPMCA,0))!(DGBDT>DGEDT) Q -1
 I DGEDT>DT Q -1  ; no future billing dates.
 ;initialize variables
 S DGMVTP=$S(DGMTYP="A":"^13^43^44^45^",DGMTYP="P":"^1^2^3^25^26^",1:"^1^2^3^25^26^13^43^44^45^")
 S DGRTMV=$S(DGMTYP="A":"^14^",DGMTYP="P":"^22^23^24^",1:"^14^22^23^24^")
 S DGPL="^1^2^3^25^26^13^43^44^45^"
 S DGCT=0,DGI=0,DGMOV="^TMP(""DGMOV"",$J)" K ^TMP("DGMOV",$J)
 S DGM0=^DGPM(+DGPMCA,0),DFN=$P(DGM0,U,3) Q:$P(DGM0,U,2)'=1 -1
 S DGDIS=$P($G(^DGPM(+$P(DGM0,U,17),0)),U) I DGDIS>1 D
 .I DGEDT>DGDIS S DGEDT=DGDIS
 .S DGMVTP=DGMVTP_$P(^DGPM($P(DGM0,U,17),0),U,18)_"^"
 I DGDIS,DGBDT'<DGDIS Q -1  ;  date range starts after discharge 
 S DGRC=0,DGI=DGBDT F  S DGI=$O(^DGPM("APCA",DFN,DGPMCA,DGI)) Q:'DGI!(DGI\1>DGEDT)  D
 .S DGM=$O(^DGPM("APCA",DFN,DGPMCA,DGI,0)),DGM0=$G(^DGPM(DGM,0)),MDT=DGM0\1
 .Q:MDT>DGEDT  I $P(DGM0,U,2)=2!($P(DGM0,U,2)=3) S @DGMOV@(DGI,DGM)=DGM0 S DGRC=DGRC+1
 ;Examine movements movements for selected movement option.
 I DGRC=0 S (SOL,DGM0)=DGBDT,EOL=DGEDT,DGIB=0 D IBCHK G ENDREC ; interm billcheck
 N DGRTNCHK,DG,DGK,DGB S (RTN,DGI,RCNT)=0 F DG=1:1 S DGI=$O(@DGMOV@(DGI)) Q:'DGI  S RCNT=RCNT+1 D
 .S DGIB=0,NDGM="",EOL=0,DGM=$O(@DGMOV@(DGI,0)),NDGM=DGI,NDGM=$O(@DGMOV@(NDGM))
 .S DGM0=@DGMOV@(DGI,DGM),SOL=$P(DGM0,U,1)
 .S PROCESS=$S(DGMVTP'[(U_$P(DGM0,U,18)_U):0,$P(DGM0,U,2)=3:1,1:1)
 .S PROCESS=$S(DGRTMV[(U_$P(DGM0,U,18)_U)&(RCNT=1):1,1:PROCESS)
 .Q:'PROCESS
 .S DGK="",DGB=""
 .F  S DGK=$O(DGRTNCHK(DGK)) Q:DGK=""  I DGRTNCHK(DGK)[(DGI_DGM) S DGB=1 Q
 .Q:DGB
 .S TDGI=DGI F  S TDGI=$O(@DGMOV@(TDGI)) Q:'TDGI!(EOL)  D
 ..S TDGM=$O(@DGMOV@(TDGI,0)) I DGRTMV[(U_$P(@DGMOV@(TDGI,TDGM),U,18)_U)  D
 ...S RTN=U_"RTN"_U_($P((@DGMOV@(TDGI,TDGM)),U,18))_U_TDGM,EOL=1
 ...S DGRTNCHK(DG)=TDGI_TDGM
 .S EOL=$S('NDGM:DGEDT,NDGM>DGEDT:DGEDT,1:NDGM) D
 ..S SOL=$S(SOL<DGBDT:DGBDT,$P(DGM0,U,2)=3&(RCNT=1):DGBDT,1:SOL)
 ..I RCNT=1 D IBCHK I DGRTMV[(U_$P(DGM0,U,18)_U) D
 ...S RTN=U_"RTN"_U_($P(DGM0,U,18))_U_DGM
 ..I RCNT=1,$P(DGM0,U,2)=3,DGIB=0 Q
 ..S X2=SOL,X1=EOL D ^%DTC I RTN=0,(EOL\1)'=(DGDIS\1),(SOL\1)'=(DGDIS\1),EOL'=NDGM S X=X+1
 ..I X=0 S RTN=0 Q
 ..S DGARR(DGM)=SOL_U_EOL_U_X_U_$P(DGM0,U,18)
 ..S:RTN'=0 DGARR(DGM)=DGARR(DGM)_RTN,RTN=0
 ..S DGCT=DGCT+X  ;Grand total 
ENDREC S DGARR(0)=DGCT_U_DGBDT_U_DGEDT K ^TMP("DGMOV",$J)
 Q 1
IBCHK S ISOL=DGM0\1 S ISOL=$O(^DGPM("APCA",DFN,DGPMCA,ISOL),-1) I ISOL D
 .S XDGMOV="" S XDGMOV=$O(^DGPM("APCA",DFN,DGPMCA,ISOL,XDGMOV)) Q:XDGMOV=""  D
 ..I DGMVTP[(U_$P(^DGPM(XDGMOV,0),U,18)_U) S DGIB=1 I DGRC S EOL=$S($P(DGM0,U,2)=3&(RCNT=1):EOL,1:SOL),SOL=DGBDT ;interim billing ch
 ..I DGRC=0,DGIB=1 S X2=SOL,X1=EOL D ^%DTC S DGCT=X,DGCT=DGCT+1
 Q
