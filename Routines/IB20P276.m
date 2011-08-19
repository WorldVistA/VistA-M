IB20P276 ;DALOI/AAT - POST INIT ACTION ;24-JUN-2003
 ;;2.0;INTEGRATED BILLING;**276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;  Post Init Description: This init will resolve the pointer issues
 ;  for the new entries required in 350.2 and the update need in
 ;  file 399.1. This post init is associated with path *132*.
 ;
 Q
 ;
 ;
EN ;
 D BMES^XPDUTL(">>> Adding/modifying CLAIMS TRACKING NON-BILLABLE REASONS in the file #356.8")
 D NEWNBR
 ;
 ;Temporary:
 D BMES^XPDUTL(">>> Correcting the BPS CLAIM file, field #900 'CLOSE REASON'")
 D BPSFIX
 D BMES^XPDUTL(">>> Correcting 'CLOSE REASON' in the temporary IB events log")
 D LOGFIX
 ;
 D BMES^XPDUTL(">>> Enable menu option 'IBCNR EDIT HIPAA NCPDP FLAG'")
 D OPT
 ;
 D BMES^XPDUTL(">>> Reviewing and correcting the PLAN file entries")
 D ^IBCNRXI1
 ;
 D BMES^XPDUTL(">>> All POST-INIT Activities have been completed. <<<")
 Q
 ;
NEWNBR ; Add/Modify IB non-billable reasons #356.8
 N IBI,IBY,IBMES
 F IBI=1:1 S IBY=$P($T(REASONS+IBI),";;",2,255) Q:'IBY  D
 . N IBNAME,IBE02,IBE03,IBL,IBIEN
 . S IBNAME=$P(IBY,U,2) Q:IBNAME=""
 . S IBE02=$P(IBY,U,3)
 . S IBE03=$P(IBY,U,4)
 . S $E(IBL,33-$L(IBNAME))=" "
 . S IBMES="  "_$J(IBI,2)_"  "_IBNAME_IBL
 . S IBIEN=$O(^IBE(356.8,"B",IBNAME,0))
 . S:IBIEN="" IBIEN=0
 . S:$G(^IBE(356.8,IBIEN,0))="" IBIEN=0
 . I IBIEN S IBMES=IBMES_" Already on file"
 . I 'IBIEN D
 .. N IBRT,IBIEN,IBERR,IBCNT
 .. S IBCNT=0
 .. S IBRT(356.8,"+1,",.01)=IBNAME
 .. S IBRT(356.8,"+1,",.02)=IBE02
 .. S IBRT(356.8,"+1,",.03)=IBE03
 .. D UPDATE^DIE("","IBRT","IBIEN","IBERR")
 .. I $D(IBERR) D  S IBCNT=IBCNT+1
 ... N Y S Y="" F  S Y=$O(IBERR(Y)) Q:Y=""  D
 .... S IBMES=IBMES_" *** Error: "_$G(IBERR(Y,1,"TEXT",1))
 . I IBIEN D
 .. S $P(^IBE(356.8,IBIEN,0),U,2)=IBE02
 .. S $P(^IBE(356.8,IBIEN,0),U,3)=IBE03
 . D MES^XPDUTL(IBMES)
 Q
 ;
 ;
OPT ; Enable the menu option "IBCNR EDIT HIPAA NCPDP FLAG" 
 N IEN,IBRT,IBERR
 S IEN=$O(^DIC(19,"B","IBCNR EDIT HIPAA NCPDP FLAG",""))
 I 'IEN D BMES^XPDUTL(" *** Error: option 'IBCNR EDIT HIPAA NCPDP FLAG' not found") Q
 S IBRT(19,IEN_",",2)="@"
 D FILE^DIE("E","IBRT","IBERR")
 I $D(IBERR) D
 . N Y S Y="" F  S Y=$O(IBERR(Y)) Q:Y=""  D
 .. D BMES^XPDUTL(" *** Error: "_$G(IBERR(Y,1,"TEXT",1)))
 Q
 ;
 ;
 ; *** Not implemented ***
ADDUSR ; Add the user to the New Person file (#200)
 Q
 N DIC,X,Y,DO,DD,DLAYGO,IBNAME
 S IBNAME="E-PHARMACY"
 S DIC(0)="",DIC="^VA(200,",X=IBNAME D ^DIC
 I Y>0 D  Q
 . D BMES^XPDUTL("User "_IBNAME_" already exists in the NEW PERSON file - not added")
 D BMES^XPDUTL("Adding new user, "_IBNAME_", to the NEW PERSON file")
 S DLAYGO=200,DIC(0)="L",DIC="^VA(200,",DIC("DR")="1////MRA",X=IBNAME D FILE^DICN K DIC,DO,DD,DLAYGO
 I Y'>0 D  Q
 . D BMES^XPDUTL("A problem was encountered trying to add user, "_IBNAME)
 . D BMES^XPDUTL("The entry must be added manually to the NEW PERSON file")
 ;
 D BMES^XPDUTL("User, "_IBNAME_", was successfully added to the NEW PERSON file")
 Q
 ;
 ;Temporary Clean-up procedure to eliminate QTY-DAYS SUPPLY switching
VERIFY(IBIFN,IBRX,IBFIL) ;check and correct
 N IBX,QTY,DSUPP,IBZ,IBRXZ
 S IBRXZ=$G(^PSRX(IBRX,1,IBFIL,0)) Q:IBRXZ=""
 S QTY=+$P(IBRXZ,U,4) Q:'QTY  Q:QTY>999
 S DSUPP=+$P(IBRXZ,U,10) Q:'DSUPP  Q:DSUPP>90
 ;
 S IBX=0 F  S IBX=$O(^IBA(362.4,"C",IBIFN,IBX)) Q:'IBX  D
 . ;W !,IBIFN,?10," ",IBRX,?22," ",IBFIL
 . S IBZ=$G(^IBA(362.4,IBX,0)) Q:IBZ=""
 . I QTY=+$P(IBZ,U,7),DSUPP=+$P(IBZ,U,6) Q
 . ;W " *** INCORRECT: QTY/DAYS=",+$P(IBZ,U,7),"/",+$P(IBZ,U,6),", MUST BE ",QTY,"/",DSUPP
 . D SETQTY(IBX,QTY,DSUPP)
 Q
SETQTY(IBX,QTY,DSUPP) ;
 N IBRT,IBERR
 S IBRT(362.4,IBX_",",.06)=DSUPP
 S IBRT(362.4,IBX_",",.07)=QTY
 D FILE^DIE("","IBRT","IBERR")
 ;I $D(IBERR) W ! ZW IBERR
 Q
 ;
 ;
GETRX(IBIFN) ;Get Rx from 362.4
 N IBX,IBRX,IBRXN
 S IBRX=0
 S IBX=+$O(^IBA(362.4,"C",+IBIFN,""))
 S IBRXN=$P($G(^IBA(362.4,IBX,0)),U)
 I IBRXN'="" S IBRX=+$O(^PSRX("B",IBRXN,0))
 Q IBRX
 ;
BULL ; Generate a bulletin with modified bills.
 N IBGRP,XMDUZ,XMTEXT,XMSUB,XMY
 ;
 S XMSUB="FIXING 'CANCELLATION' IN NCPDP ZERO BILLS"
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="^TMP("_$J_",""IB20P276"","
 S XMY(DUZ)=""
 S XMY("G.PRCA ERROR")=""
 D ^XMD
 Q
 ;
 ;
SETSTA(IBIFN) ; set the status
 N IBIENS,IBFDA,IBERR
 S IBIENS=IBIFN_","
 S IBFDA(430,IBIENS,8)="COLLECTED/CLOSED"
 D FILE^DIE("E","IBFDA","IBERR")
 Q '$D(IBERR)
 ;
BPSFIX ;CONVERT OLD BPS CODES
 N I,IBZ,IBY,IBC,IBOTH,IBT,ZNODE
 S ZNODE="BPSIB-CONVERT-9002313.02-904"
 I $D(^XTMP(ZNODE,0)) D MES^XPDUTL("*** Already converted") Q
 F I=1:1 S IBY=$P($T(REASONS+I),";;",2,255) Q:'IBY  S IBC(+IBY)=$O(^IBE(356.8,"B",$P(IBY,U,2),0))
 S IBOTH=$O(^IBE(356.8,"B","OTHER",0))
 S I=0 F  S I=$O(^BPSC(I)) Q:'I  S IBZ=$G(^(I,0)) D:$P(IBZ,U,7)=""
 . N IBOLD,IBNEW
 . S IBOLD=$P($G(^BPSC(I,900)),U,4) Q:IBOLD=""
 . S IBNEW=+$G(IBC(IBOLD)) S:'IBNEW IBNEW=IBOTH
 . ;W !,"I=",I,?10,"CODE=",IBOLD,",   NEW=",IBNEW
 . S $P(^BPSC(I,900),U,4)=IBNEW
 . S $P(^BPSC(I,0),U,7)=0  ; as a flag to avoid double conversion
 S ^XTMP(ZNODE,0)=$$FMADD^XLFDT(DT,365)_U_DT_U_"BPS CONVERSION FLAG"
 Q
 ;
LOGFIX ;CONVERT CLOSE REASON IN THE IB LOG
 N I,J,IBNODE,IBZ,IBY,IBC,IBOTH,IBT,IBDROP
 F I=1:1 S IBY=$P($T(REASONS+I),";;",2,255) Q:'IBY  S IBC(+IBY)=$O(^IBE(356.8,"B",$P(IBY,U,2),0))
 S IBOTH=$O(^IBE(356.8,"B","OTHER",0))
 ;
 S (I,IBNODE)="IBNCPDP-"
 F  S I=$O(^XTMP(I)) Q:I'[IBNODE  D
 . S J=0 F  S J=$O(^XTMP(I,J)) Q:'J  D
 .. I '$D(^XTMP(I,J,"IBD","CLOSE REASON")) Q
 .. I $D(^XTMP(I,J,"IBD","DROP TO PAPER")) Q  ; Already converted
 .. N IBOLD,IBNEW
 .. S IBOLD=$G(^XTMP(I,J,"IBD","CLOSE REASON")) Q:IBOLD=""
 .. S IBNEW=+$G(IBC(IBOLD)) S:'IBNEW IBNEW=IBOTH
 .. ;W !,"I=",I,",  J=",J,",",?15,"CODE=",IBOLD,",   NEW=",IBNEW
 .. S ^XTMP(I,J,"IBD","CLOSE REASON")=IBNEW
 .. S ^XTMP(I,J,"IBD","DROP TO PAPER")=(IBOLD=1)  ;flag to avoid double conversion
 Q
 ;
REASONS ;CLOSE REASON  to add/modify into file #356.8
 ;;2^NOT INSURED^1^0
 ;;3^SERVICE NOT COVERED^1^0
 ;;4^COVERAGE CANCELED^1^0
 ;;6^INVALID PRESCRIPTION ENTRY^1^0
 ;;7^PRESCRIPTION DELETED^1^0
 ;;8^PRESCRIPTION NOT RELEASED^1^0
 ;;5^DRUG NOT BILLABLE^1^0
 ;;10^90 DAY RX FILL NOT COVERED^1^1
 ;;11^NOT A CONTRACTED PROVIDER^1^1
 ;;12^INVALID MULTIPLES PER DAY SUPP^1^0
 ;;13^REFILL TOO SOON^1^0
 ;;9^INVALID NDC FROM CMOP^1^0
 ;;1^OTHER^1^1
 ;;
