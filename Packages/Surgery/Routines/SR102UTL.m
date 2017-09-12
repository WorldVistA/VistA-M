SR102UTL ;BIR/ASJ-Utility routine for patch SR*3*102; [04/03/01  09:50 AM ]
 ;;3.0; Surgery ;**102**;24 Jun 93
POST ;
 S SRSITE=0 F  S SRSITE=$O(^SRO(133,"B",SRSITE)) Q:'SRSITE  S SRDA=$O(^SRO(133,"B",SRSITE,0)),$P(^SRO(133,SRDA,0),"^",5)=""
 Q
