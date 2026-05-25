IBY779PO ;WCJ/EDE - IB*2.0*779 POST INSTALL;01/04/24 2:10pm
 ;;2.0;Integrated Billing;**779**;Mar 20, 1995;Build 7
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ;Post Install for IB*2.0*779
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*779")
 D TSKPUSH  ; add the nightly task
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*779")
 Q
 ;
TSKPUSH ; task the  routine as a Night Job using TaskMan.
 ;
 N IBMULTI
 D MES^XPDUTL("Tasking Nightly Copay Synch ... ")
 ;
 S IBMULTI=$$FIND1^DIC(19.2,,"B","IBMH MULTI FAC COPAY SYNCH","B")
 ;
 I IBMULTI D  Q
 . D MES^XPDUTL("Nothing to see here folks (it awas already scheduled)  ... ")
 ;
 I 'IBMULTI D  Q
 . N FDA,IENROOT,MESS,TSTAMP
 . S TSTAMP=$$FMADD^XLFDT($$NOW^XLFDT(),1),$P(TSTAMP,".",2)="0200"
 . S FDA(19.2,"+1,",.01)=$$FIND1^DIC(19,,"B","IBMH MULTI FAC COPAY SYNCH")
 . S FDA(19.2,"+1,",2)=TSTAMP
 . S FDA(19.2,"+1,",6)="D@2AM"
 . S FDA(19.2,"+1,",11)=DUZ
 . D UPDATE^DIE("","FDA","IENROOT","MESS")
 . D MES^XPDUTL("Added Nightly Copay Synch ... ")
 Q
