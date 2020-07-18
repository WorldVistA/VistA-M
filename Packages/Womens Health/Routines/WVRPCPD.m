WVRPCPD ;SPFO/LMT - API/RPC TX Needs Due ;01/23/2017  11:17
 ;;1.0;WOMEN'S HEALTH;**24**;Sep 30, 1998;Build 582
 ;
PROCDUE(WVRESULT,WVPROCTYP,WVPROCARR,WVDATE) ;
 ;
 ; Returns list of patient's with procedure(s) due. Excludes
 ; inactive WV PATIENTs and deceased patients.
 ;
 ;Input:
 ; WVPROCTYP - Procedure Type ("BR" or "CX"). Optional, defaults to "BR".
 ; WVPROCARR - Array of Procedure(s) (i.e., array of IENs from 790.51 (for
 ;             "BR") or file 790.5 (for "CX")). Optional, defaults to all
 ;             procedures, except "Not Indicated".
 ;    WVDATE - Date to use determine if procedure is due. Any due date
 ;             equal to WVDATE will be considered due. Optional,
 ;             defaults to DT.
 ;
 ;Returns:
 ;  @WVRESULT@(0)=Count
 ;  @WVRESULT@(n)=DFN ^ Procedure ^ Procedure Due Date
 ;
 N DFN,WV790,WVCNT,WVFILE,WVFLD,WVFLDDT,WVNODE0,WVPROC,WVPROCDT,WVTXNI
 ;
 S WVRESULT=$NA(^TMP("WVPROCDUE",$J))
 K ^TMP("WVPROCDUE",$J)
 S WVCNT=0
 ;
 I $G(WVPROCTYP)'?1(1"BR",1"CX") S WVPROCTYP="BR"
 I '$G(WVDATE) S WVDATE=DT
 ;
 S WV790=0
 F  S WV790=$O(^WV(790,WV790)) Q:'WV790  D
 . S WVNODE0=$G(^WV(790,WV790,0))
 . S DFN=$P(WVNODE0,U)
 . ;
 . ;if patient is inactive, quit
 . I $P(WVNODE0,U,24) Q
 . ;
 . ;If patient is deceased, set inactive date to date of death and quit
 . I $$DECEASED^WVUTL1(DFN) D  Q
 . . N DA,DR,DIE,X,Y
 . . S DIE="^WV(790,",DA=WV790
 . . S DR=".24////"_$P($$GET1^DIQ(2,DFN,.351,"I"),".") ;date only
 . . D ^DIE
 . ;
 . S WVFLD=18
 . S WVFLDDT=19
 . S WVFILE=790.51
 . I WVPROCTYP="CX" D
 . . S WVFLD=11
 . . S WVFLDDT=12
 . . S WVFILE=790.5
 . S WVTXNI=$$IEN^WVUTL9(WVFILE,"Not Indicated")
 . ;
 . S WVPROC=$P(WVNODE0,U,WVFLD)
 . I WVPROC="" Q
 . S WVPROCDT=$P(WVNODE0,U,WVFLDDT)
 . I WVPROCDT="" Q
 . ;
 . ; if only searching for specific procedures, quit if this
 . ; procedure is not included in the search.
 . I $O(WVPROCARR(0)),'$D(WVPROCARR(WVPROC)) Q
 . ;
 . ; if searching for all procedures, exclude "Not Indicated"
 . I '$O(WVPROCARR(0)),WVPROC=WVTXNI Q
 . ;
 . I WVPROCDT'=WVDATE Q
 . ;
 . S WVCNT=WVCNT+1
 . S ^TMP("WVPROCDUE",$J,WVCNT)=DFN_U_WVPROC_U_WVPROCDT
 ;
 S ^TMP("WVPROCDUE",$J,0)=WVCNT
 ;
 Q
