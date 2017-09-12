DG5385PT ;ALB/ABR -POST-INIT TS CLEANUP FOR PATCH 85 ; 4/10/96
 ;;5.3;Registration;**85**;Aug 13, 1993
 ;
 ;Variables:
 ;  DGI = Division
 ;  DGJ = Treating Specialty
 ;  DGK = Census Date
 ;  DGX = Kill flag
 ;  DGY = # of days since previous TS census entry
 ;
POST ; entry point for post-install  - set up checkpoints
 N %
 S %=$$NEWCP^XPDUTL("DGTSI","EN^DG5385PT",0) ; call-back routine for KIDS
 S %=$$NEWCP^XPDUTL("DGTSJ"),%=$$NEWCP^XPDUTL("DGTSK")
 Q
 ;
EN ;
 N DGI,DGJ,DGK,DGK1,DGX,DGY,%
 ;
 D BMES^XPDUTL(" >>Treating Specialty Census clean-up")
 ;
 ; retrieve values in checkpoints, step back for $O function
 S DGI=+$$PARCP^XPDUTL("DGTSI"),DGJ=+$$PARCP^XPDUTL("DGTSJ"),DGK=+$$PARCP^XPDUTL("DGTSK")
 I DGK,'+$G(^DG(40.8,DGI,"TS",DGJ,"C",DGK,0)) S DGK=DGK-.001
 S:DGI DGI=DGI-.001 S:DGJ DGJ=DGJ-.001 ; if post-install has previously started, set DGI and DGJ back, so that $O will return values at time of failure
 ;
LOOP ; step thru division file, treating specialty census nodes to find problems
 F  S DGI=$O(^DG(40.8,DGI)) Q:'DGI  S %=$$UPCP^XPDUTL("DGTSI",DGI) F  S DGJ=+$O(^DG(40.8,DGI,"TS",+DGJ)),%=$$UPCP^XPDUTL("DGTSJ",DGJ) Q:'DGJ  S DGX=1 D  S DGK=0,%=$$UPCP^XPDUTL("DGTSK",DGK)
 .S:'DGK DGK=+$O(^DG(40.8,DGI,"TS",+DGJ,"C",+DGK))
 .F  S DGK1=DGK,DGK=+$O(^DG(40.8,DGI,"TS",+DGJ,"C",+DGK)),%=$$UPCP^XPDUTL("DGTSK",DGK) S DGY=$$DTCK(DGK,DGK1) Q:DGY=1  D  I DGX D FLG
 ..I 'DGY S $P(^DG(40.8,DGI,"TS",DGJ,"C",DGK,0),U)=DGK,^DG(40.8,DGI,"TS",DGJ,"C","B",DGK,DGK)=""
 ..; update DGK ckpt after file is updated, so $O finds next node to be considered.
 Q
 ;
FLG ;kills 0 x-refs
 K ^DG(40.8,DGI,"TS",DGJ,"C","B",0) S DGX=0
 Q
 ;
DTCK(X1,X2) ;  checks for 2 sequential dates
 N X
 ;   X1 = current date being checked  (DGK)
 ;   X2 = previous date checked  (DGK1)
 S X=0
 I 'X1 S X=1 G Q
 I +$G(^DG(40.8,DGI,"TS",DGJ,"C",DGK,0))=DGK D ^%DTC
Q Q X
