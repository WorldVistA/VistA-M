IBCEMU3 ;ALB/ESG - MRA UTILITY - INS CO CHECKER ;14-JUNE-2004
 ;;2.0;INTEGRATED BILLING;**155**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
INSCHK ; Check insurance company file for "rogue" Medicare WNR entries
 ; Send an email message reporting any problems
 NEW IEN,INSNAME,CNT,MSG,Z,XMTEXT,XMDUZ,XMSUB,XMY,XMDUN,XMZ,XMMG
 NEW D,D0,D1,D2,DG,DIC,DICR,DISYS,DIW,DIFROM,DA,DIK,X,Y
 NEW MCR,DATA,Z0,Z5,PCE,TOC,IBX,INACTXT
 KILL ^TMP($J,"P155")
 S IEN=0,CNT=0,MCR=0
 F  S IEN=$O(^DIC(36,IEN)) Q:'IEN  D
 . I '$$MCRWNR^IBEFUNC(IEN) Q          ; not Medicare WNR
 . ;I $P($G(^DIC(36,IEN,0)),U,5) Q      ; inactive
 . ;I $P($G(^DIC(36,IEN,5)),U,1) Q      ; scheduled for deletion
 . S INSNAME=$P($G(^DIC(36,IEN,0)),U,1)
 . I INSNAME="MEDICARE (WNR)" D  Q     ; this is what it should be
 .. S MCR=MCR+1
 .. D MCRPRV(IEN),PROVID(IEN)          ; do some stuff with MCRWNR
 .. Q
 . I INSNAME="" S INSNAME="~UNKNOWN"
 . S CNT=CNT+1
 . S ^TMP($J,"P155",1,INSNAME,IEN)=""
 . Q
 ;
 ; Either none or more than 1 Medicare WNR entries exist
 I MCR'=1 D
 . S IEN=0,INSNAME="MEDICARE (WNR)"
 . I '$D(^DIC(36,"B",INSNAME)) S ^TMP($J,"P155",2,0)="DNE" Q
 . F  S IEN=$O(^DIC(36,"B",INSNAME,IEN)) Q:'IEN  D
 .. S DATA="",Z0=$G(^DIC(36,IEN,0)),Z5=$G(^DIC(36,IEN,5))
 .. I $P(Z0,U,2)'="N" S $P(DATA,U,1)=$$EXTERNAL^DILFD(36,1,,$P(Z0,U,2))
 .. S TOC=$$EXTERNAL^DILFD(36,.13,,$P(Z0,U,13))  ; type of coverage
 .. I TOC'="MEDICARE" S $P(DATA,U,2)=TOC
 .. I $P(Z0,U,5) S $P(DATA,U,3)=$$EXTERNAL^DILFD(36,.05,,$P(Z0,U,5))
 .. I $P(Z5,U,1) S $P(DATA,U,4)=$$EXTERNAL^DILFD(36,5.01,,$P(Z5,U,1))
 .. S ^TMP($J,"P155",2,IEN)=DATA
 .. Q
 . Q
 ;
 ; Check the Medicare related plans
 S IBX=$$GETWNR^IBCNSMM1()
 I 'IBX S ^TMP($J,"P155",3)=IBX
 ;
 S MSG(1)="MRA has been installed at the following site:"
 I '$$VFIELD^DILFD(350.9,8.11) S MSG(1)="Pre-MRA Insurance Company checker utility from:"
 ;
 S MSG(2)=""
 S MSG(3)="   "_$P($G(^DIC(4,+$P($G(^IBE(350.9,1,0)),U,2),0)),U,1)
 S MSG(4)="   "_$G(^XMB("NETNAME"))
 S MSG(5)="   "_$$SITE^VASITE()
 S MSG(6)=""
 S MSG(7)="Version Information:  "_$G(^XPD(9.7,+$O(^XPD(9.7,"B","IB*2.0*155",""),-1),2))
 S MSG(8)="",Z=8
 ;
 I '$D(^TMP($J,"P155")) D
 . S Z=Z+1,MSG(Z)="No problems detected with the set-up of MEDICARE (WNR)."
 . S Z=Z+1,MSG(Z)=""
 . Q
 ;
 I $D(^TMP($J,"P155",2)) D
 . S Z=Z+1,MSG(Z)="*** MEDICARE (WNR) IS NOT SET-UP CORRECTLY ***"
 . S Z=Z+1,MSG(Z)=""
 . ;
 . I $D(^TMP($J,"P155",2,0)) D  Q
 .. S Z=Z+1,MSG(Z)="   There is no insurance company on file named ""MEDICARE (WNR)""."
 .. S Z=Z+1,MSG(Z)=""
 .. Q
 . ;
 . I MCR>1 D
 .. S Z=Z+1,MSG(Z)="   There are multiple MEDICARE (WNR) entries defined."
 .. S Z=Z+1,MSG(Z)=""
 .. Q
 . ;
 . S IEN=0
 . F  S IEN=$O(^TMP($J,"P155",2,IEN)) Q:'IEN  D
 .. S DATA=^TMP($J,"P155",2,IEN)
 .. S Z=Z+1,MSG(Z)="   "_$P($G(^DIC(36,IEN,0)),U,1)_"  ien="_IEN
 .. I DATA="" S Z=Z+1,MSG(Z)="     VALID"
 .. F PCE=1:1:4 I $P(DATA,U,PCE)'="" D
 ... S Z=Z+1
 ... I PCE=1 S MSG(Z)="REIMBURSE?"
 ... I PCE=2 S MSG(Z)="TYPE OF COVERAGE"
 ... I PCE=3 S MSG(Z)="INACTIVE"
 ... I PCE=4 S MSG(Z)="SCHEDULED FOR DELETION"
 ... S MSG(Z)="     "_MSG(Z)_" = "_$P(DATA,U,PCE)
 ... Q
 .. S Z=Z+1,MSG(Z)=""
 .. Q
 . S Z=Z+1,MSG(Z)=""
 . Q
 ;
 I $D(^TMP($J,"P155",3)) D
 . S Z=Z+1,MSG(Z)="Additional Information:"
 . S Z=Z+1,MSG(Z)="   "_$G(^TMP($J,"P155",3))
 . S Z=Z+1,MSG(Z)=""
 . Q
 ;
 I $D(^TMP($J,"P155",1)) D
 . S Z=Z+1,MSG(Z)="The following insurance company is "
 . I CNT>1 S MSG(Z)="The following "_CNT_" insurance companies are "
 . S MSG(Z)=MSG(Z)_"incorrectly set-up like Medicare WNR:"
 . S Z=Z+1,MSG(Z)=""
 . S INSNAME=""
 . F  S INSNAME=$O(^TMP($J,"P155",1,INSNAME)) Q:INSNAME=""  S IEN=0 F  S IEN=$O(^TMP($J,"P155",1,INSNAME,IEN)) Q:'IEN  D
 .. S INACTXT=""
 .. I $P($G(^DIC(36,IEN,0)),U,5) S INACTXT="Inactive"
 .. S Z=Z+1,MSG(Z)="   "_$$LJ^XLFSTR(INSNAME,35)
 .. S MSG(Z)=MSG(Z)_$$LJ^XLFSTR(INACTXT,15)
 .. S MSG(Z)=MSG(Z)_"ien="_IEN
 .. Q
 . S Z=Z+1,MSG(Z)=""
 . S Z=Z+1,MSG(Z)="According to the VA guidelines for the Standardization of Medicare"
 . S Z=Z+1,MSG(Z)="Information, the only entry should be ""MEDICARE (WNR)""."
 . S Z=Z+1,MSG(Z)=""
 . Q
 ;
 ; Send this message to holders of the IB INSURANCE SUPERVISOR key
 S Z=Z+1,MSG(Z)="Local recipients of this message hold the IB INSURANCE SUPERVISOR key"
 S Z=Z+1,MSG(Z)=""
 S IBX=0
 F  S IBX=$O(^XUSEC("IB INSURANCE SUPERVISOR",IBX)) Q:'IBX  D
 . N INFO,PHONE,NAME,PHONE2
 . S INFO=$G(^VA(200,IBX,0))
 . I $P(INFO,U,7) Q    ; disuser
 . I $P(INFO,U,11) Q   ; termination date
 . S XMY(IBX)=""
 . S PHONE=$P($G(^VA(200,IBX,.13)),U,2)
 . S PHONE2=$P($G(^VA(200,IBX,.13)),U,5)
 . I PHONE2'="" S PHONE=PHONE_$S(PHONE'="":" / ",1:"")_PHONE2
 . I PHONE="" S PHONE="Unknown phone #"
 . S NAME=$P(INFO,U,1)
 . S Z=Z+1,MSG(Z)="   "_$$LJ^XLFSTR(NAME,40)_PHONE
 . Q
 S Z=Z+1,MSG(Z)=""
 ;
 ; MailMan variables and message sending
 S XMTEXT="MSG("
 S XMDUZ=DUZ
 S XMSUB="MEDICARE WNR ENTRIES"
 S XMY(DUZ)=""
 S XMY("michael.f.pida@us.pwc.com")=""
 S XMY("Janet.Harris2@med.va.gov")=""
 S XMY("Loretta.Gulley2@med.va.gov")=""
 S XMY("eric.gustafson@daou.com")=""
 ;
 D ^XMD   ; send it!
 ;
INSCHKX ;
 KILL ^TMP($J,"P155")
 Q
 ;
MCRPRV(INSIEN) ; Update fields in the MCRWNR entry
 ; This procedure updates the Hospital Provider Number field (.11)
 ; and the Professional Provider Number field (.17) in file 36 for the
 ; MEDICARE (WNR) entry.  These numbers have been assigned to the VA
 ; by Medicare.
 ;
 NEW DIE,DA,DR,D,D0,DI,DIC,DQ,X,Y
 S INSIEN=+$G(INSIEN)
 I '$D(^DIC(36,INSIEN)) G MCRPRVX
 S DIE=36,DA=INSIEN,DR=".11///670899;.17///670899"
 D ^DIE
MCRPRVX ;
 Q
 ;
PROVID(INSIEN) ; Add an entry to file 355.91 - IB insurance co level billing
 ; provider ID file.  This is to add an entry for the UPIN of VAD000
 ; into this file for the MEDICARE (WNR) insurance company entry.
 ;
 NEW DA,DATA,DIK,DG,DIC,DICR,DIW,X,Y
 S INSIEN=+$G(INSIEN)
 I '$D(^DIC(36,INSIEN)) G PROVIDX
 S DA=0
 F  S DA=$O(^IBA(355.91,"B",INSIEN,DA)) Q:'DA  D
 . S DATA=$G(^IBA(355.91,DA,0))
 . I $$EXTERNAL^DILFD(355.91,.06,,$P(DATA,U,6))'="UPIN" Q
 . S DIK="^IBA(355.91," D ^DIK    ; delete existing MCRWNR/upin entry
 . Q
 ;
 ; Add the new MCRWNR/upin entry
 NEW DIC,DO,DA,DINUM,X,Y,UPIN,DG,DICR,DIW
 S DIC="^IBA(355.91,",DIC(0)="F",X=INSIEN
 S UPIN=$O(^IBE(355.97,"B","UPIN",0)) I 'UPIN G PROVIDX
 S DIC("DR")=".04////0;.05////0;.06////"_UPIN_";.07////VAD000;.1////*N/A*"
 D FILE^DICN
PROVIDX ;
 Q
 ;
