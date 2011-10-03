IBDFCG1 ;ALB/MAF - CONT. of Clinic Group Enter Edit Screen - 1 1 95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
 ;
CLIN ; -- Loop thru all clinics in the clinic group to list alphabetically
 F IBDCL=0:0 S IBDCL=$O(^IBD(357.99,IBDIFN,10,IBDCL)) Q:'IBDCL  I $D(^IBD(357.99,IBDIFN,10,+IBDCL,0)) S X=+^(0),^TMP("IBMF",$J,IBDIFN,"C",$P(^SC(X,0),"^",1),X)=$P(^SC(X,0),"^",1)
 Q
 ;
 ;
CLIN1 ;  -- Reset the clinic array
 S IBDCL=$O(^TMP("IBMF",$J,IBDIFN,"C",IBDCL)) S:IBDCL']"" IBDFCFLG=1 Q:IBDCL']""  S IBDFCIEN=$O(^TMP("IBMF",$J,IBDIFN,"C",IBDCL,0)) I IBDFCIEN S ^TMP("IBMF",$J,IBDIFN,IBDFX,"C",IBDFCIEN)=IBDCL
 Q
 ;
 ;
DIV ; -- Loop thru all the division that are in a clinic group to list alphabetically
 F IBDDV=0:0 S IBDDV=$O(^IBD(357.99,IBDIFN,11,IBDDV)) Q:'IBDDV  I $D(^IBD(357.99,IBDIFN,11,+IBDDV,0)) S X=+^(0),^TMP("IBMF",$J,IBDIFN,"D",$P(^DG(40.8,X,0),"^",1),X)=$P(^DG(40.8,X,0),"^",1)
 Q
 ;
 ;
DIV1 ;  -- Reset the division array
 S IBDDV=$O(^TMP("IBMF",$J,IBDIFN,"D",IBDDV)) S:IBDDV']"" IBDFDFLG=1 Q:IBDDV']""  S IBDFDIEN=$O(^TMP("IBMF",$J,IBDIFN,"D",IBDDV,0)) I IBDFDIEN S ^TMP("IBMF",$J,IBDIFN,IBDFX,"D",IBDFDIEN)=IBDDV
 Q
 ;
WILDCARD ; -- parse out a wild card
 W !,"ADDING CLINIC: ",X,!
 S X=$E(X,1,($L(X)-1))
 I X]"" D
 .N IBCLIN,IBDA,IBCLINIC
 .S IBCLIN=0
 .F IBCLINIC=0:0 S IBCLIN=$O(^SC("B",IBCLIN)) Q:IBCLIN']""  I X=$E(IBCLIN,1,$L(X)) D
 ..S IBDA=$O(^SC("B",IBCLIN,0)) I $D(^SC(IBDA,0)),'$D(^IBD(357.99,DA,10,"B",IBDA)) D
 ...S IB3=$S($P($G(^IBD(357.99,DA,10,0)),"^",3)]"":$P(^IBD(357.99,DA,10,0),"^",3)+1,1:1),IB4=$S($P($G(^IBD(357.99,DA,10,0)),"^",4)]"":$P(^IBD(357.99,DA,10,0),"^",4)+1,1:1)
 ...S ^IBD(357.99,DA,10,IB3,0)=IBDA,^IBD(357.99,DA,10,"B",IBDA,IB3)=""
 ...I $D(^IBD(357.99,DA,10,0)) S $P(^IBD(357.99,DA,10,0),"^",3)=IB3,$P(^IBD(357.99,DA,10,0),"^",4)=IB4
 ...I '$D(^IBD(357.99,DA,10,0)) S ^IBD(357.99,DA,10,0)="^357.9901PA^"_IB3_"^"_IB4
 ..;F IBDA=0:0 S IBDA=$O(^SC("B",IBCLIN,IBDA)) Q:'IBDA  I $G(^SC("B",IBCLIN,IBDA)) S ^IBD(357.99,D0,10,D1,0)=IBDA,^IBD(357.99,D0,10,"B",D1,0)=""
 ..Q
