ORKREC ; SLC/AEB - Recipient Options - Order Checking Parameters Management ;9/22/97
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,85**;Dec 17, 1997
 ;
PFLAG ;
 N ORKT,ORKPAR,PIEN,ORKEDIT,ORKLST,ORKIEN,ORKV
 S ORKT="Enable/Disable an Order Check for Yourself",PIEN=0
 D TITLE(ORKT)
 S PIEN=$O(^XTV(8989.51,"B","ORK PROCESSING FLAG",PIEN)) Q:PIEN=""
 S ORKPAR=PIEN
 ;
 ;get a list of order checks that cannot be edited by end user:
 S ORKIEN=0 F  S ORKIEN=$O(^ORD(100.8,ORKIEN)) Q:+$G(ORKIEN)<1  D
 .S ORKV=$$GET^XPAR("ALL","ORK EDITABLE BY USER",ORKIEN,"I")
 .S:$L(ORKV) ORKEDIT(ORKIEN)=ORKV
 ;
 D PROC
 Q
USRCHKS ; List order checks a user could receive
 D USRCHKS^ORKUTL(DUZ)
 Q
PROC ;  Process Parameter Settings
 W !,$$DASH($S($D(IOM):IOM-1,1:78))
 N ENT
 S ENT=DUZ_";VA(200," ;Entity is the recipient/user
 D EDIT^XPAREDIT(ENT,ORKPAR)
 Q
TITLE(ORKT)  ;
 ; Center and write title - Parameter to be set
 S IOP=0 D ^%ZIS K IOP W @IOF
 W !,?(80-$L(ORKT)-1/2),ORKT
 Q
 ;
DASH(N) ;extrinsic function returns N dashes
 N X
 S $P(X,"-",N+1)=""
 Q X
