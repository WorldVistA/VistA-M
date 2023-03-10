VPRSDAC ;SLC/MKB -- SDA Consult utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**14,25**;Sep 01, 2011;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DIQ                           2056
 ; GMRCGUIB                      2980
 ; ICDEX                         5747
 ; ICPTCOD                       1995
 ; LEXTRAN                       4912
 ; TIULQ                         2693
 ;
GMRC1(IEN) ; -- Referral ID Action
 K VPRCONS,VPRCACT,VPRIFC S IEN=+$G(IEN)
 D GET^GMRCAPI(.VPRCONS,IEN),ACT^GMRCAPI(.VPRCACT,IEN)
 S VPRIFC=$$IFC^GMRCAPI(IEN)
 Q
 ;
CONSNAME(IEN) ; -- return display name using fields
 ; Request Type (#13), To Service (#1) & Procedure/Request Type (#4)
 N VPRX,Y S VPRX=$G(VPRCONS(0))
 I $P(VPRX,U,8)?1.N1";ORD(101," D  ;resolve old v-ptr
 . S Y=$P(VPRX,U,8)
 . S Y=$$GET1^DIQ(101,+Y,.01),$P(VPRX,U,8)=Y
 . S $P(VPRCONS(0),U,8)=Y
 S Y=$P(VPRX,U,5)
 I $P(VPRX,U,17)="P",$L($P(VPRX,U,8)) S Y=$P(VPRX,U,8)_" "_Y_" Proc"
 E  S Y=Y_" Cons"
 ;I $P(VPRX,U,17)="P",$L($P(VPRX,U,8)) S Y=$P(VPRX,U,8)
 ;E  S Y=$P(VPRX,U,5)_" Consult"
 Q Y
 ;
PROVDX(IEN) ; -- return full Consult ProvDx string, or null/DDEOUT
 N VPRICD,VPRNM,VPRDX,Y S Y=""
 S VPRNM=$G(VPRCONS(30)),VPRICD=$G(VPRCONS(30.1))
 ; if not ICD, return free text Dx
 I $P(VPRICD,U,3)'="ICD",$P(VPRICD,U,3)'="10D" D PDTXT G PDXQ
 ; if no code, return free text Dx
 I $P(VPRICD,U)="" D PDTXT G PDXQ
 ; if no text, resolve code to description
 I VPRNM="" D  I '$L(VPRNM) D PDTXT G PDXQ
 . Q:$$ICDD^ICDEX($P(VPRICD,U),.VPRDX,$P(VPRICD,U,2),$P(VPRICD,U,3))'>0
 . S VPRNM=$G(VPRDX(1))
 ; return valid ICD code
 S Y=$P(VPRICD,U)_U_VPRNM_U_$$SNAM^ICDEX($$SYS^ICDEX($P(VPRICD,U,3)))
PDXQ ;exit
 Q Y
 ;
PDTXT ; -- return ProvDx free text
 I $L(VPRNM) S Y=VPRNM_U_VPRNM Q
 S DDEOUT=1
 Q
 ;
GETACT(IEN) ; -- return DLIST(DA)='DA,IEN' of activity log entries
 N I,X,X0,CNT,TIU,ACT S IEN=+$G(IEN) Q:IEN<1
 D:'$O(VPRCACT(0)) ACT^GMRCAPI(.VPRCACT,IEN)
 S (I,CNT)=0 F  S I=$O(VPRCACT(I)) Q:I<1  D  Q:CNT>499
 . S X0=$G(VPRCACT(I,0)),X=$P(X0,U,2),TIU=+$P(X0,U,9)
 . ; look for duplicate IR's from runaway devices
 . I X="INCOMPLETE RPT" Q:$D(ACT(TIU))  S ACT(TIU)=""
 . S DLIST(I)=I_","_IEN,CNT=CNT+1
 Q
 ;
CP1(IEN) ; -- get MD nodes for procedure [ID Action]
 ; VPRCP = ^TMP("MDHSP",$J,I)
 ; VPRCN = ^GMR(123,consult,0)
 ; VPRTIU(field#,"I") = TIU data field
 I '$D(^TMP("MDHSP",$J)) D
 . S:'DFN DFN=+$$GET1^DIQ(702,IEN,.01,"I")
 . N DLIST D CPROCS^VPRSDAQ
 S I=+$G(^TMP("MDHSP",$J,"IEN",IEN)),VPRCP=$G(^TMP("MDHSP",$J,I))
 I VPRCP="" S DDEOUT=1 Q
 ; undo date formatting
 N X,Y,%DT,VPRD
 S X=$P(VPRCP,U,6) I $L(X) S %DT="STX" D ^%DT S:Y>0 $P(VPRCP,U,6)=Y
 ; get supporting data from Consult, TIU note
 S X=+$P(VPRCP,U,13) I X D  K VPRD
 . D DOCLIST^GMRCGUIB(.VPRD,X) S VPRCN=$G(VPRD(0)) M VPRCN=VPRD(50)
 S X=+$P(VPRCP,U,14) I X D  K VPRD
 . D EXTRACT^TIULQ(X,"VPRD",,".03;.05;1202;1211;1212",,,"I")
 . M VPRTIU=VPRD(X)
 Q
