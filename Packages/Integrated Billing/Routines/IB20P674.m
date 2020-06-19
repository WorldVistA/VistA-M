IB20P674 ;/Albany - IB*2.0*674 POST INSTALL;02/04/20 2:10pm
 ;;2.0;Integrated Billing;**674**;Mar 20, 1995;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for IB*2.0*674
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*674")
 D TSKPUSH  ; add/edit the nightly task
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*674")
 Q
 ;
TSKPUSH ; task the  routine as a Night Job using TaskMan.
 ;
 N IBMULTI
 D MES^XPDUTL("Tasking Nightly Copay Synch ... ")
 ;
 S IBMULTI=$$FIND1^DIC(19.2,,"B","IBUC MULTI FAC COPAY SYNCH","B")
 ;
 I IBMULTI D  Q
 . N FDA,MESS,TSTAMP
 . S FDA(19.2,+IBMULTI_",",11)=DUZ
 . D FILE^DIE("","FDA","MESS")
 . D MES^XPDUTL("Updated Nightly Copay Synch ... ")
 ;
 I 'IBMULTI D  Q
 . N FDA,IENROOT,MESS,TSTAMP
 . S TSTAMP=$$FMADD^XLFDT($$NOW^XLFDT(),1),$P(TSTAMP,".",2)="0200"
 . S FDA(19.2,"+1,",.01)=$$FIND1^DIC(19,,"B","IBUC MULTI FAC COPAY SYNCH")
 . S FDA(19.2,"+1,",2)=TSTAMP
 . S FDA(19.2,"+1,",6)="D@2AM"
 . S FDA(19.2,"+1,",11)=DUZ
 . D UPDATE^DIE("","FDA","IENROOT","MESS")
 . D MES^XPDUTL("Added Nightly Copay Synch ... ")
 Q
