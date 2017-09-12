IBY288PO ;ALB/ESG - IB*2*288 POST-INSTALL ROUTINE ;21-OCT-2004
 ;;2.0;INTEGRATED BILLING;**288**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Entry Point
 ;
 D AEXREF
 D FACBILID
 D TESTQ
 ;
 Q
 ;
AEXREF ; Build the new and improved "AE" x-ref in file 399
 D BMES^XPDUTL("Removing the old ""AE"" index file data and definition")
 D DELIX^DDMOD(399,135,1)
 KILL ^DGCR(399,"AE")
 D MES^XPDUTL("Done")
 ;
 D BMES^XPDUTL("Creating the new ""AE"" index file data and definition")
 N IBXR,IBRES,IBOUT
 S IBXR("FILE")=399
 S IBXR("NAME")="AE"
 S IBXR("TYPE")="MU"
 S IBXR("USE")="S"
 S IBXR("EXECUTION")="R"
 S IBXR("ACTIVITY")="IR"
 S IBXR("SHORT DESCR")="Index by patient and insurance company"
 S IBXR("DESCR",1)="Cross reference of patients and bills to payer responsible for the bill."
 S IBXR("DESCR",2)="This will be used to prevent deletion of insurance policy entries from the"
 S IBXR("DESCR",3)="patient file if a bill has been created for this insurance company."
 S IBXR("DESCR",4)=" "
 S IBXR("DESCR",5)="Created with patch IB*2.0*288 replacing traditional cross-reference #1 in "
 S IBXR("DESCR",6)="field 135 of file 399.  Medicare is now a valid insurance company for "
 S IBXR("DESCR",7)="this index file."
 S IBXR("SET")="N CURR S CURR=+$$COBN^IBCEF(DA) I $G(X(4)),$G(X(CURR)) S ^DGCR(399,""AE"",X(4),X(CURR),DA)="""""
 S IBXR("KILL")="N G I $G(X(4)) F G=1,2,3 I $G(X(G)) K ^DGCR(399,""AE"",X(4),X(G),DA)"
 S IBXR("WHOLE KILL")="K ^DGCR(399,""AE"")"
 S IBXR("VAL",1)=101
 S IBXR("VAL",1,"COLLATION")="F"
 S IBXR("VAL",2)=102
 S IBXR("VAL",2,"COLLATION")="F"
 S IBXR("VAL",3)=103
 S IBXR("VAL",3,"COLLATION")="F"
 S IBXR("VAL",4)=.02
 S IBXR("VAL",4,"COLLATION")="F"
 D CREIXN^DDMOD(.IBXR,"SW",.IBRES,"IBOUT")
 I +$G(IBRES) D MES^XPDUTL("Index successfully created!") G AEXXX
 ;
 ; Index file failure.  Not created for some reason
 ;
 D MES^XPDUTL("A PROBLEM WAS ENCOUNTERED.  INDEX FILE NOT CREATED!!!")
 D MES^XPDUTL("SENDING MAILMAN MESSAGE...")
 D MES^XPDUTL("PLACING THE 'PATIENT INSURANCE INFO VIEW/EDIT' OPTION OUT-OF-ORDER.")
 NEW XMDUZ,XMSUBJ,XMBODY,MSG,XMTO,DA,DIE,DR,IBX
 S XMDUZ=DUZ,XMSUBJ="IB*2*288 Error:  AE index not built",XMBODY="MSG"
 S MSG(1)="The updated ""AE"" index for file 399 was not created at"
 S MSG(2)=" "
 S MSG(3)="     "_$$SITE^VASITE
 S MSG(4)=" "
 S MSG(5)="The Patient Insurance Info View/Edit option has been placed out of order."
 ;
 ; recipients of message
 S XMTO(DUZ)=""
 S XMTO("eric.gustafson@daou.com")=""
 S XMTO("michael.f.pida@us.pwc.com")=""
 S XMTO("Janet.Harris2@domain.ext")=""
 S XMTO("Cari.Hutchison@domain.ext")=""
 S XMTO("G.PATCHES")=""
 S IBX=0 F  S IBX=$O(^XUSEC("IB INSURANCE SUPERVISOR",IBX)) Q:'IBX  S XMTO(IBX)=""
 ;
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO)
 ;
 ; place the option out of order
 S DA=$O(^DIC(19,"B","IBCN PATIENT INSURANCE",""))
 I DA S DIE=19,DR="2////IB Patch 288 Installation Failure" D ^DIE
AEXXX ;
 Q
 ;
FACBILID ; move the hosp and prof provider ID#'s in file 36 for the
 ; Medicare (WNR) entry into file 355.92.
 ;
 D BMES^XPDUTL("Updating facility provider ids for MEDICARE (WNR)")
 N DO,DD,DLAYGO,DIC,X,Y,Z,Z0,Z00,Z11,Z17,IBINS,IBID,IBHCFA,IBUB
 S IBID=$$BF^IBCU()
 I IBID S IBINS=0 F  S IBINS=$O(^DIC(36,"B","MEDICARE (WNR)",IBINS)) Q:'IBINS  S Z11=$P($G(^DIC(36,IBINS,0)),U,11),Z17=$P($G(^DIC(36,IBINS,0)),U,17) D
 . S (IBHCFA,IBUB)=0
 . S Z0=0 F  S Z0=$O(^IBA(355.92,"B",IBINS,Z0)) Q:'Z0  S Z00=$G(^IBA(355.92,Z0,0)) D  Q:IBHCFA&IBUB
 .. I $P(Z00,U,6)=IBID S:$P(Z00,U,4)=2 IBHCFA=1 S:$P(Z00,U,4)=1 IBUB=1 Q
 . I Z11'="",'IBUB S X=IBINS,DIC("DR")=".04////1;.06////"_IBID_";.07////"_Z11,DIC="^IBA(355.92,",DLAYGO=355.92,DIC(0)="L" D FILE^DICN K DO,DD,DLAYGO,DIC
 . I Z17'="",'IBHCFA S X=IBINS,DIC("DR")=".04////2;.06////"_IBID_";.07////"_Z17,DIC="^IBA(355.92,",DLAYGO=355.92,DIC(0)="L" D FILE^DICN K DO,DD,DLAYGO,DIC
 ;
FACBILX ;
 Q
 ;
TESTQ ; Change the 837 test transmission queue to be "MCT"
 D BMES^XPDUTL("Setting the EDI 837 Test Transmit Queue to ""MCT""")
 S $P(^IBE(350.9,1,8),U,9)="MCT"
TESTQX ;
 Q
 ;
