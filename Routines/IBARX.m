IBARX ;ALB/AAS-INTEGRATED BILLING, PHARMACY COPAY INTERFACE ;14-FEB-91
 ;;2.0;INTEGRATED BILLING;**101,150,156,168,186,237,308**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
XTYPE ; - tag XTYPE - returns array of billable action types for service
 ;  - see IBARXDOC for documentation
 ;
X1 K Y D INSTAL I '$T S Y=-1 Q
 N I,J,X1,X2,DA,DFN,IBCAP S Y=1,IBSAVX=X,IBTAG=1,IBWHER=5
 ;
 D CHKX^IBAUTL G:+Y<1 XTYPEQ
 ;
 I '$D(^IBE(350.1,"ANEW",IBSERV,1,1)) D  S Y=-1 G XTYPEQ
 .I '$D(ZTQUEUED) W !!,*7,"WARNING: Pharmacy Copay not working,",!,"         Check IB SERVICE/SECTION in Pharmacy Site File.",!!
 .D E3^IBAERR
 ;
 N X D ELIG^VADPT,INP^VADPT,DOM S Y=1
 F I=0:0 S I=$O(^IBE(350.1,"ANEW",IBSERV,1,I)) Q:'I  I $D(^IBE(350.1,I,40)) S DA=I X ^IBE(350.1,DA,40) S Y(DA,X)=I_"^"_X1_"^"_X2 S:'$G(IBCAP) IBCAP=X
 ;
 I $G(IBCAP),$G(DFN) D NEW^IBARXPFS(DFN)
 ;
XTYPEQ K X1,X2,IBSERV,VAEL,VA,VAERR,IBDOM,VAIN,IBSAVX,IBTAG,IBWHER
 ;
 Q
 ;
DOM S IBDOM=0 I $D(VAIN(4)),$D(^DIC(42,+VAIN(4),0)),$P(^(0),"^",3)="D" S IBDOM=1
 Q
NEW ;  - process new/renew/refill rx for charges
 ;  - see IBARXDOC for documentation
 ;
N1 K Y,IBSAVX D INSTAL I '$T S Y=-1 Q
 N I,J,X1,X2,DA,DFN,IBEXMP
 S IBWHER=1,IBSAVX=X,Y=1,IBTAG=2 D CHKX^IBAUTL I +Y<1 G NEWQ
 I $D(X)<11 S Y="-1^IB010" G NEWQ
 S J="" F  S J=$O(X(J)) Q:J=""  S IBSAVX(J)=X(J)
 D ARPARM^IBAUTL I +Y<1 G NEWQ
 ;
 ; -- check rx exemption in case refill is exempt
 ; -- if exempt set amount to each rx and total to zero
 ;    1= exempt, 0= non-exempt, -1=copay off (manila)
 S IBEXMP=+$$RXEXMT^IBARXEU0(DFN,DT)
 I IBEXMP'=0 D  S Y="1^0" G NEWQ
 .S IBJ=""
 .; changed return value 6th piece is the exempt flag
 .F  S IBJ=$O(IBSAVX(IBJ)) Q:IBJ=""  S $P(Y(IBJ),"^",6)=IBEXMP
 .Q
 ;
 ; check to see if billing has been tracked across facilities before,
 ; if not, start now.
 D TRACK^IBARXMN(DFN) I +Y<1 G NEWQ
 ;
 S IBTOTL=0
 D BILLNO^IBAUTL I +Y<1 G NEWQ
 ;
 S IBTOTL=0,IBJ="",IBSEQNO=$P(^IBE(350.1,IBATYP,0),"^",5) I 'IBSEQNO S Y="-1^IB023" G NEWQ
 F  S IBJ=$O(IBSAVX(IBJ)) Q:IBJ=""  S IBX=IBSAVX(IBJ) D RX^IBARX1
 I +Y<1 G NEWQ
 ;
 ; changed to only do if charge exists
 D:IBTOTL ^IBAFIL
 ;
 S IBJ="" F  S IBJ=$O(IBSAVY(IBJ)) Q:IBJ=""  S Y(IBJ)=IBSAVY(IBJ)
 S:+Y>0 Y="1^"_IBTOTL S X=IBSAVX
 ;
NEWQ D:+Y<1 ^IBAERR
 D END
 Q
 ;
INSTAL I $S($D(^IBE(350.9,1,0)):1,$D(^IB(0)):1,1:0)
 Q
 ;
CANCEL ;  - cancel charges for a rx
 ;  - see IBARXDOC for documentation
 ;
C1 K Y,IBSAVX N I,J,X1,X2,DA,DFN I '$G(IBUPDATE) N IBCAP,IBAMP,IBSAVXMC
 S IBWHER=1,IBSAVX=X,Y=1,IBTAG=3 D CHKX^IBAUTL I +Y<1 G CANQ
 I $D(X)<11 S Y="-1^IB010" G CANQ
 S J="" F  S J=$O(X(J)) Q:J=""  S IBSAVX(J)=X(J)
 D ARPARM^IBAUTL I +Y<1 G CANQ
 ;
 S IBJ="",IBTOTL=0
 F  S IBJ=$O(IBSAVX(IBJ)) Q:IBJ=""  S IBX=IBSAVX(IBJ) D CANRX^IBARX1 I +IBY(IBJ)'<1 D ^IBAFIL:$P(IBND,"^",5)'=8 I +Y<1 S IBY(IBJ)=Y
 I +Y<1 S IBT="",IBY=Y,IBM="" F  S IBM=$O(IBY(IBM)) Q:IBM=""  I +IBY(IBM)<1 S Y=IBY(IBM) D ^IBAERR S Y(IBM)=IBY(IBM),Y=IBY
CANQ D:+Y<1 ^IBAERR:('$D(IBT))
 S X=IBSAVX
 M IBSAVXMC=Y
 D END
 ;
 ; now that I have cancelled lets see if there are some to be billed
 I '$G(IBUPDATE),$D(IBCAP)>10 D QCAN^IBARXMC(DFN,.IBCAP,.IBSAVXMC)
 ;S IBD=0 F  S IBD=$O(IBCAP(IBD)) Q:IBD<1  D CANCEL^IBARXMC(DFN,IBD)
 Q
 ;
UPDATE ;  - will cancel current open charge and create updated entry
 ;  - see IBARXDOC for documentation
 ;
U1 K Y,IBSAVX N I,J,X1,X2,DA,DFN,IBEXMP,IBUPDATE,IBCAP,IBEFDT,IBAMP,IBSAVXMC
 S IBUPDATE=1  ; new flag so we know we are updating
 S IBWHER=1,IBSAVX=X,Y=1,IBTAG=4 D CHKX^IBAUTL I +Y<1 G UPDQ
 S IBSAVXU=IBSAVX
 I $D(X)<11 S Y="-1^IB010" G UPDQ
 S J="" F  S J=$O(X(J)) Q:J=""  S IBSAVXU(J)=X(J),X(J)=$P(X(J),"^",3,4) D EFDT^IBARXMU($P(X(J),"^"),.IBEFDT)
 ;
 D CANCEL
U2 K X
 S X=IBSAVXU S J="" F  S J=$O(IBSAVXU(J)) Q:J=""  S X(J)=$P(IBSAVXU(J),"^",1,3)
 S IBSAVX=X,Y=1,IBTAG=4 D CHKX^IBAUTL I +Y<1 G UPDQ
 D ARPARM^IBAUTL I +Y<1 G UPDQ
 ;
 ; -- check rx exemption in case refill is exempt
 ; -- if exempt set amount to each rx and total to zero
 S IBEXMP=+$$RXEXMT^IBARXEU0(DFN,DT)
 I IBEXMP'=0 D  S Y="1^0" G UPDQ
 .; changed return value 6th piece is the exempt flag
 .S IBJ="" F  S IBJ=$O(IBSAVXU(IBJ)) Q:IBJ=""  S $P(Y(IBJ),"^",6)=IBEXMP
 .Q
 ;
 S IBATYP=$P(^IBE(350.1,+IBATYP,0),"^",7) I '$D(^IBE(350.1,+IBATYP,0)) S Y="-1^IB008" G UPDQ ;update type action
 ;
 D BILLNO^IBAUTL G:+Y<1 UPDQ
 S IBTOTL=0,IBNOS="",IBSEQNO=$P(^IBE(350.1,IBATYP,0),"^",5) I 'IBSEQNO S Y="-1^IB023" G UPDQ
 S IBJ="" F  S IBJ=$O(IBSAVXU(IBJ)) Q:IBJ=""  S IBX=IBSAVXU(IBJ) S:$D(IBEFDT(+$P(IBX,"^",3))) IBEFDT=IBEFDT(+$P(IBX,"^",3)) D UCHPAR,RX^IBARX1:'$D(IBSAVY(IBJ)) S IBEFDT=0
 D ^IBAFIL
 ;
 S IBJ="" F  S IBJ=$O(IBSAVY(IBJ)) Q:IBJ=""  S Y(IBJ)=IBSAVY(IBJ),$P(Y(IBJ),"^",6)=+$G(IBEXMP) S:+Y(IBJ)<1 Y=Y(IBJ)
 S:+Y>0 Y="1^"_IBTOTL S X=IBSAVXU
 ;
 ; now that I have the update done lets see if there are some to be billed
 I $D(IBCAP)>10 D QCAN^IBARXMC(DFN,.IBCAP,.IBSAVXMC)
 ;S IBD=0 F  S IBD=$O(IBCAP(IBD)) Q:IBD<1  D CANCEL^IBARXMC(DFN,IBD)
 ;
UPDQ D:+Y<1 ^IBAERR
 K IBSAVXU
END K %,%H,%I,K,X1,X2,X3,IBSERV,IBATYP,IBAFY,IBDUZ,IBNOW,IBSAVX,IBTOTL,IBX,IBT,IBCHRG,IBDESC,IBFAC,IBIL,IBN,IBNOS,IBSEQNO,IBSITE,IBTAG,IBTRAN,IBCRES,IBJ,IBLAST,IBND,IBY,IBPARNT,IBUNIT,IBJ,IBARTYP,IBI,IBSAVY,IBWHER
 Q
UCHPAR ; Check that IB action and its parent exist.
 S IBPARNT=$P(IBX,"^",3)
 I '$D(^IB(+IBPARNT,0)) S IBSAVY(IBJ)="-1^IB021" G UCHPARQ
 S IBPARNT=$P(^IB(+IBPARNT,0),"^",9)
 I '$D(^IB(+IBPARNT,0)) S IBSAVY(IBJ)="-1^IB027"
UCHPARQ Q
 ;
STATUS(X) ; returns the status of a transaction in 350
 ;  - see IBARXDOC for documentation
 ;
 N Y S Y=$G(^IB(X,0))
 Q +$S($P(Y,"^",5)=10:2,1:$P($G(^IBE(350.1,+$P(Y,"^",3),0)),"^",5))
 ;
CANIBAM ; used by pso to cancel a 354.71 transaction
 ;  - see IBARXDOC for documentation
 N IBZ,IBXX,IBYY,IBCAP
 M IBXX=X
 S IBXX=0 F  S IBXX=$O(IBXX(IBXX)) Q:IBXX=""  D
 . N IBY
 . S IBZ=$G(^IBAM(354.71,+IBXX(IBXX),0))
 . I $P(IBZ,"^",4) S IBYY(IBXX)="-1^Transaction has been billed" Q
 . I $P(IBZ,"^",5)="Y"!($P(IBZ,"^",5)="X") S IBYY(IBXX)="-1^Transaction already cancelled" Q
 . S IBZ=$$CANCEL^IBARXMN($P(IBZ,"^",2),+IBXX(IBXX),.IBY,$P(IBXX(IBXX),"^",2))
 . S IBYY(IBXX)=$S($P($G(IBY),"^")=-1:IBY,1:IBZ)
 K Y M Y=IBYY
 Q
 ;
UPIBAM ;  - will cancel current potential charge and create updated entry
 ;  - see IBARXDOC for documentation
 ;
 N IBXX,IBYY,IBWHER,IBTAG,IBZ,IBX,IBY,IBSAVX,IBA,IBAM,IBATYP,IBCAP,IBDESC,IBDUZ,IBSERV,IBTCH
 M IBXX=X
 S IBA=$O(X("")) I IBA="" S (Y)="-1^Invalid Subscript in X" Q
 S IBWHER=1,Y=1,IBTAG=4,IBSAVX=X D CHKX^IBAUTL I +Y<1 S Y(IBA)=Y Q
 S IBZ=$G(^IBAM(354.71,+$P($G(IBXX(IBA)),"^",3),0))
 ;
 ; check out the transaction sent
 I 'IBZ S (Y,Y(IBA))="-1^Not a valid transaction number" Q
 I $P(IBZ,"^",4) S (Y,Y(IBA))="-1^Transaction has been billed" Q
 I $P(IBZ,"^",5)="Y"!($P(IBZ,"^",5)="X") S (Y,Y(IBA))="-1^Transaction already cancelled" Q
 ;
 ; cancel that transaction
 S IBX=$$CANCEL^IBARXMN($P(IBZ,"^",2),$P($G(IBXX(IBA)),"^",3),.Y,$P(IBXX(IBA),"^",4)) I +Y<1 S Y(IBA)=Y Q
 ;
 ; create the new updated transaction
 S IBX=IBXX(IBA) D BDESC^IBARX1 S IBATYP=$P(^IBE(350.1,+IBATYP,0),"^",7),DA=IBATYP D COST^IBAUTL S IBTCH=$P(IBX,"^",2)*X1
 S IBAM=$$ADD^IBARXMN($P(IBZ,"^",2),"^^"_$P(IBZ,"^",3)_"^^P^"_$P(IBXX(IBA),"^")_"^"_$P(IBXX(IBA),"^",2)_"^"_IBTCH_"^"_IBDESC_"^"_$$PARENT^IBARXMC($P(IBXX(IBA),"^",3))_"^0^"_IBTCH_"^"_(+$P($$SITE^IBARXMU,"^",3)),IBATYP)
 I IBAM<1 S (Y,Y(IBA))="-1^IB316" Q
 ;
 S Y(IBA)=IBAM,Y=1
 ;
 Q
