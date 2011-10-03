IBCESRV1 ;ALB/TMP - Server interface to IB from Austin ;03/05/96
 ;;2.0;INTEGRATED BILLING;**137,181,191,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
PERROR(IBERR,IBTDA,IBEMG,IBXMZ) ; Process Errors - Send bulletin to mail group
 ; IBERR = Error text array
 ; IBTDA = Message File Entry # array
 ; IBEMG = name of the mail group to which these errors should be sent
 ; IBXMZ = the internal entry # of the mailman message (file 3.9)
 N CT,XMDUZ,XMSUBJ,XMBODY,XMB,XMINSTR,XMTYPE,XMFULL,XMTO,IBXM,XMZ,XMERR
 ;
 S CT=0
 ;
 I $G(IBEMG)="" S CT=CT+1,IBXM(CT)=$P($T(ERROR+2),";;",2),XMTO(.5)=""
 ;
 I $D(IBEMG) D
 . S:IBEMG="" IBEMG="IB EDI"
 . ;
 . S:$E(IBEMG,1,2)'="G." IBEMG="G."_IBEMG
 . ;
 . S XMTO("I:"_IBEMG)=""
 ;
 I $O(XMTO(.5))="" S XMTO("I:G.IB EDI")=""
 D EMFORM(CT,.IBERR,.IBXM,IBXMZ)
 ;
 S XMDUZ=""
 S XMSUBJ="EDI RETURN MESSAGE ROUTER ERROR",XMBODY="IBXM"
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 Q
 ;
EMFORM(CT,IBERR,IBXM,IBXMZ) ;
 ; INPUT:
 ;   CT = the number of lines previously populated in error message
 ;   IBERR = the array of errors
 ;
 ; OUTPUT:
 ;   IBXM = the array containing the complete error text
 ;
 N THDR,TDATE,TDATE1,TTIME,TTIME1,TTYP,Z,Z0,Z1,BATCH,BILL
 ;
 S IBTDA=+$O(IBTDA("")),THDR=$G(^IBA(364.2,IBTDA,0))
 ;
 I THDR'="" D  ;Messages partially filed
 . S TDATE=$P(THDR,U,10),TTIME=$P(TDATE,".",2)_"000000",TDATE=$$FMTE^XLFDT(TDATE,"2D")
 . S TDATE1=$P(THDR,U,3),TTIME1=$P(TDATE1,".",2)_"000000",TDATE1=$$FMTE^XLFDT(TDATE1,"2D")
 . S TTYP=$G(^IBE(364.3,+$P(THDR,U,2),0)),BATCH=$P(THDR,U,4),BILL=$P(THDR,U,5)
 ;
 I THDR="" D  ;No messages filed
 . S TDATE=$G(^TMP("IBERR",$J,"DATE")),TTIME=$P(TDATE,".",2)_"000000",TDATE=$$FMTE^XLFDT($P(TDATE,"."),"2D")
 . S TDATE1=$$NOW^XLFDT(),TTIME1=$P(TDATE1,".",2)_"000000",TDATE1=$$FMTE^XLFDT($P(TDATE1,"."),"2D")
 . S TTYP=$G(^TMP("IBERR",$J,"TYPE")),BATCH=$G(^TMP("IBERR",$J,"BATCH")),BILL=$G(^TMP("IBERR",$J,"BILL"))
 ;
 S CT=CT+1
 S IBXM(CT)="             Return Message Code: "_$P(TTYP,U)_"  "_$P(TTYP,U,5)
 ;
 S CT=CT+2
 S IBXM(CT-1)=" ",IBXM(CT)=$J("",13)_"Return Message Date: "_TDATE_"    Message Time: "_$E(TTIME,1,2)_":"_$E(TTIME,3,4)_":"_$E(TTIME,5,6),CT=CT+1
 ;
 S CT=CT+2
 S IBXM(CT-1)=" ",IBXM(CT)=$J("",21)_"Update Date: "_TDATE1_"     Update Time: "_$E(TTIME1,1,2)_":"_$E(TTIME1,3,4)_":"_$E(TTIME1,5,6)
 ;
 I BATCH S CT=CT+2,IBXM(CT-1)=" ",IBXM(CT)=$J("",25)_"Batch #: "_$P($G(^IBA(364.1,BATCH,0)),U)
 ;
 I BILL S CT=CT+2,IBXM(CT-1)=" ",IBXM(CT)=$J("",26)_"Bill #: "_$P($G(^DGCR(399,+$G(^IBA(364,+BILL,0)),0)),U)
 ;
 I IBTDA S CT=CT+2,IBXM(CT-1)=" ",IBXM(CT)=$J("",11)_"Return Message File #(s): " D
 . S (Z,Z0)=0 F  S Z=$O(IBTDA(Z)) Q:'Z  I IBTDA(Z) S IBXM(CT)=IBXM(CT)_$S(Z0:",",1:"")_Z,Z0=1
 ;
 S CT=CT+2,IBXM(CT-1)=" ",IBXM(CT)=$J("",15)_"Mailman Message #: "_$G(IBXMZ)
 ;
 I $G(IBERR)'="",IBERR?1A.E S CT=CT+2,IBXM(CT-1)=" ",IBXM(CT)=IBERR
 I $G(^TMP("IBERR",$J,"TEXT"))'="" S CT=CT+2,IBXM(CT)=^("TEXT"),IBXM(CT-1)=" "
 ;
 S Z="" F  S Z=$O(IBERR(Z)) Q:Z=""  S:$G(^TMP("IBERR",$J,"TEXT"))="" CT=CT+1,IBXM(CT)=" " S Z0="" F  S Z0=$O(IBERR(Z,Z0)) Q:Z0=""  I $G(IBERR(Z,Z0))'="",IBERR(Z,Z0)'=" " S CT=CT+1,IBXM(CT)=IBERR(Z,Z0)
 S Z=0 F  S Z=$O(^TMP("IBERR",$J,"MSG",Z)) Q:'Z  S CT=CT+1,IBXM(CT)=^(Z)
 ;
 S Z=+$O(^TMP("IB-HOLD",$J,""),-1) S:'Z Z="cannot be determined"
 I $S('Z:1,'$D(^TMP("IBMSG",$J,"BATCH",0,"D",0)):0,1:+$O(^TMP("IBMSG",$J,"BATCH",0,"D",0,""),-1)'=Z) S CT=CT+1,IBXM(CT)="Msg Line: "_$G(^TMP("IB-HOLD",$J,Z))
 I $O(^IBA(364.2,IBTDA,2,0))!$O(^TMP("IBERR",$J,"MSG",0))!($O(^TMP("IB-HOLD",$J,0))) S CT=CT+2,IBXM(CT-1)=" ",IBXM(CT)="Return Message Text:"
 ;
 I IBTDA D
 . S Z=0 F  S Z=$O(^IBA(364.2,+IBTDA,2,Z)) Q:'Z  I $G(^(Z,0))'="" S CT=CT+1,IBXM(CT)=^(0)
 Q
 ;
ERROR ;
 ;;Invalid mailgroup designated for EDI errors
 ;;Message header error
 ;
EXTERR(IBERR,IBTDA,IBE) ; Put error into error array
 N IBZ,Q
 S IBE="",IBERR=4,IBTDA(IBTDA)=1
 S IBZ=0 F  S IBZ=$O(IBE("DIERR",IBZ)) Q:'IBZ  S Q=$G(IBE("DIERR",IBZ,"TEXT",1)) I $L(Q),$L(Q)+$L(IBE)<99 S IBE=IBE_Q_";;"
 Q
 ;
ERRUPD(IBGBL,IBERR) ; Set up global array to hold message data
 ;
 N Z,Z0,Z1,Z11,Z2,Z3,CT,IBE,IBTXN1
 ;
 K ^TMP("IBERR",$J)
 S CT=0,IBTXN1=$G(@IBGBL)
 ;
 S ^TMP("IBERR",$J,"DATE")=IBDATE
 S ^TMP("IBERR",$J,"TYPE")=$P(IBTXN1,U)
 S ^TMP("IBERR",$J,"SUBJ")=$G(IBD("SUBJ"))
 ;
 I $G(IBERR),IBERR<20 D
 . S Z="ERROR+"_IBERR_"^IBCESRV"
 . S IBE=$P($T(@Z),";;",2)
 . I IBE'="" S ^TMP("IBERR",$J,"TEXT")=IBE
 ;
 S Z="" F  S Z=$O(IBERR(Z)) Q:Z=""  S Z0="" F  S Z0=$O(IBERR(Z,Z0)) Q:Z0=""  S IBE=$G(IBERR(Z,Z0)) D
 . I $L(IBE) S CT=CT+1,^TMP("IBERR",$J,"MSG",CT)=$S(IBE:$P($T(ERROR+IBE),";;",2),1:IBE)
 . S Z11="" F  S Z11=$O(IBERR(Z,Z0,Z11)) Q:Z11=""  S CT=CT+1,^TMP("IBERR",$J,"MSG",CT)=$G(IBERR(Z,Z0,Z11)) D
 .. S IBTXN1=$G(@IBGBL@(Z,Z0,0))
 .. S:$G(^TMP("IBERR",$J,"BATCH"))="" ^("BATCH")=$S(Z0="BATCH":Z11,1:"")
 .. S:$G(^TMP("IBERR",$J,"BILL"))="" ^("BILL")=$S(Z0="CLAIM":Z11,1:"")
 .. S:$G(^TMP("IBERR",$J,"TYPE"))="" ^("TYPE")=$P(IBTXN1,U,6)
 . S Z1=""
 . F  S Z1=$O(@IBGBL@(Z,Z0,"D",Z1)) Q:Z1=""  S Z2=0 F  S Z2=$O(@IBGBL@(Z,Z0,"D",Z1,Z2)) Q:'Z2  S Z3=$P(@IBGBL@(Z,Z0,"D",Z1,Z2),"##RAW DATA: ",2) I Z3'="" D
 .. S CT=CT+1,^TMP("IBERR",$J,"MSG",CT)=Z3
 ;
 I $D(@IBGBL@("BATCH",0)) D
 . S Z2="" F  S Z2=$O(@IBGBL@("BATCH",0,"D",0,Z2)) Q:Z2=""  S Z3=$P(@IBGBL@("BATCH",0,"D",0,Z2),"##RAW DATA: ",2) I Z3'="" D
 .. S CT=CT+1,^TMP("IBERR",$J,"MSG",CT)=Z3
 ;
 Q
 ;
DKILL(IBXMZ) ; Delete server mail message from postmaster mailbox
 ;
 D ZAPSERV^XMXAPI("S.IBCE MESSAGES SERVER",IBXMZ)
 ;
 Q
 ;
TRTN(IBTDA) ; Process incoming EDI message
 ; IBTDA = internal entry # of message (file 364.2)
 ; This procedure is called from ADD^IBCESRV with variable IBRTN holding the TAG^ROUTINE to be invoked
 NEW IBA,IBB,IBGBL,IBERR        ; protect looping variables from ADD^IBCESRV
 D @IBRTN
 Q
 ;
TRADEL(X) ; Process to delete message from temporary message holding file
 ;
 N DIK,DA,Y S DIK="^IBA(364.2,",DA=X D ^DIK
 Q
 ;
