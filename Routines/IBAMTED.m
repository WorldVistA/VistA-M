IBAMTED ;ALB/CPM,GN,PHH,EG - MEANS TEST EVENT DRIVER INTERFACE ; 11/30/05 1:48pm
 ;;2.0;INTEGRATED BILLING;**15,255,269,321,312**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;IB*2*269 add IVM converted RX Copay Test update calls to a new API.
 ;
 ; -- do medication copayment exemption processing
 ;
 ;Z06 processing for RX Copay then Quit
 I $D(EASZ06),DGMTYPT=2 D ^IBAMTED2 G END                    ;IB*2*269
 ;Original Non-Z06 Copay processing
 I '$D(EASZ06) D
 . ;this routine is called from the DG namespace and IB namespace
 . ;when coming in from the DG namespace, variable DGMTD and DGMTDT is
 . ;used to define the means test test.  When coming in
 . ;from the IB namespace, variable IBDT  OR IVMMTDT is used
 . I '$D(IBDT) N IBDT
 . S IBDT=$S($D(IBDT):IBDT,$D(IVMMTDT):IVMMTDT,$D(DGMTDT):DGMTDT,$D(DGMTD):DGMTD,1:0)
 . I $P($G(^DGMT(408.31,+$$LST^DGMTCOU1(DFN,IBDT,2),0)),"^",23)=2 Q
 . I $G(^DGMT(408.31,+$$LST^DGMTCOU1(DFN,IBDT,2),"C",1,0))["Z06 MT via Edb" Q
 . D ^IBAMTED1
 . Q
 ;
 ; -- end medication copayment exemption processing
 ;
 Q:+$$SWSTAT^IBBAPI()                                        ;IB*2.0*312
 ;
 ; Quit if supported variables are unavailable.
 Q:'$D(DFN)!('$D(DGMTA))!('$D(DGMTP))!('$D(DUZ))!('$D(DGMTINF))!('$D(DGMTACT))
 ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBAMTED-1" D T0^%ZOSV ;start rt clock
 ;
 ; -- quit if copay exemption test
 I $P(DGMTA,"^",19)=2!($P(DGMTP,"^",19)=2) G END
 ;
 ; Quit if test is a Category change resulting from a deleted test.
 I DGMTA]"",DGMTP]"",+DGMTA'=+DGMTP G END ; on-line deletion
 I DGMTA]"",DGMTP]"",DGMTACT="DEL" G END ; IVM 'delete' transmission
 ;
 ; Process Means Tests uploaded by IVM.
 I DGMTACT="UPL"!(DGMTACT="DUP") D  G END
 .;
 .; - if IVM is uploading a verified test, create new MT charges
 .I $P(DGMTP,"^",23)<2,$P(DGMTA,"^",23)>1,'$$CK^DGMTUB(DGMTP),$$CK^DGMTUB(DGMTA) D ^IBAMTV Q
 .;
 .; - if IVM is sending a 'Delete' transmission, cancel previous charges
 .I $P(DGMTP,"^",23)>1,$P(DGMTA,"^",23)<2,$$CK^DGMTUB(DGMTP),'$$CK^DGMTUB(DGMTA) D CANC^IBAMTV
 ;
 ; Quit if the most current Means Test was not altered.
 S IBMT=$S(DGMTA="":DGMTP,1:DGMTA)
 S X=$$LST^DGMTU(DFN) I X,$P(X,"^",2)>+IBMT G END
 ;
 ; Quit if an added or deleted test is a Required test.
 I (DGMTA=""!(DGMTP="")),$P(IBMT,"^",3)=1 G END
 ;
 ; Determine the billable status before and after the transaction.
 D NOW^%DTC S IBCATCA=$$BIL^DGMTUB(DFN,%)
 S IBCATCP=$S(DGMTP="":$$ADD,DGMTA="":$$CK^DGMTUB(DGMTP),1:$$EDIT)
 ;
 ; Generate a bulletin if the patient's billing status has changed.
 I (IBCATCP&('IBCATCA))!('IBCATCP&(IBCATCA)) D
 .S IBEFDT=$S($P(IBMT,"^",7):+$P(IBMT,"^",7),1:+IBMT)
 .I IBCATCP,'IBCATCA,'$$CHG^IBAMTEDU(IBEFDT) Q  ; hasn't been billed since going c->a
 .I 'IBCATCP,IBCATCA,'$$EP^IBAMTEDU(IBEFDT) Q  ; hasn't been treated since going a->c
 .D MT^IBAMTBU2 ; create bulletin
 ;
END K IBARR,IBCANCEL,IBCATCA,IBCATCP,IBDIQ,IBDUZ,IBEFDT,IBMT,IBI,IBC,IBPT,IBT
 K DIC,DIQ,DR,DA,VA,VAERR,VAEL,X,X1,X2,XMDUZ,XMTEXT,XMY,XMSUB
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBAMTED" D T1^%ZOSV ;stop rt clock
 Q
 ;
 ;
ADD() ; Determine the billable status before adding a Means Test.
 S X1=$S($P(DGMTA,"^",3)=3:+DGMTA,1:+$P(DGMTA,"^",7)\1),X2=-1 D C^%DTC
 Q $$BIL^DGMTUB(DFN,X)
 ;
 ;
EDIT() ; Determine the billable status before editing a Means Test.
 I $P(DGMTP,"^",3)'=1 Q $$CK^DGMTUB(DGMTP)
 S X1=+DGMTP,X2=-1 D C^%DTC Q $$BIL^DGMTUB(DFN,X)
