DVBC193P ;AJF;Conversion of Request Status Field ; 8/23/18 9:55am
 ;;2.7;AMIE;**193**; ;Build 84
 ;Post conversion for patch 193
 ;This routine converts the Request Status field to a pointer
 ;IEN in file #396.33
 W !!,"****************************************************"
 W !,"Start Request Status Conversion"
 W !,"-------------------------",!
  N A,A1,A2,RO,DA,X
 S A=0
 F  S A=$O(^DVB(396.3,A)) Q:A=""  D
 .Q:'$D(^DVB(396.3,A,0))
 .S A1=$P(^DVB(396.3,A,0),"^",18),RO=$P(^DVB(396.3,A,0),"^",3)
 .S A2=$S(A1="N":1,A1="P":2,A1="S":3,A1="R":4,A1="C":5,A1="X":6,A1="RX":7,A1="T":8,A1="NT":9,A1="CT":10,1:A1)
 .S $P(^DVB(396.3,A,0),"^",18)=A2
 .;Convert "AF" xref
 .Q:A=""
 .Q:A1=""
 .S DA=A,X=A1 X ^DD(396.3,17,1,1,2)
 .Q:A2=""
 .S X=A2 X ^DD(396.3,17,1,1,1)
 W !,"Request Status Field Update Successful",!
 W !,"-------------------------"
 W !,"End Request Status Conversion"
 W !!,"************************************"
 ;
 ;
PMAIN ;-- update DVBAB CAPRI MINIMUM VERSION Parameter.
 ;
 N DVBERR
 ;W !!,"*************************************************"
 W !!,"Start DVBAB CAPRI Minimum Version Parameter Update"
 W !,"-------------------------",!
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI MINIMUM VERSION","CAPRI GUI V2.7*193.12*1*A*3181118")
 D UPDMSG("CAPRI Minimum Version",DVBERR)
 ;
 W !!,"-------------------------"
 W !,"End DVBAB CAPRI Minimum Version Parameter Updates"
 W !,"****************************************************",!!
 Q
 ;
ENXPAR(DVBENT,DVBPAR,DVBVAL) ;Update Parameter values
 ;
 ;  Input:
 ;    DVBENT - Parameter Entity
 ;    DVBPAR - Parameter Name
 ;    DVBVAL - Parameter Value
 ;
 ;  Output:
 ;    Function value - returns "0" on success;
 ;                     otherwise returns error#^errortext
 ;
 N DVBERR
 D EN^XPAR(DVBENT,DVBPAR,1,DVBVAL,.DVBERR)
 Q DVBERR
 ;
UPDMSG(DVBPAR,DVBERR) ;display update message
 ;
 ;  Input:
 ;    DVBPAR - Parameter Name
 ;    DVBERR - Parameter Update result
 ;
 ;  Output: none
 ;
 I DVBERR D
 . D MES^XPDUTL(DVBPAR_" update FAILURE.")
 . D MES^XPDUTL("  Failure reason: "_DVBERR)
 E  D
 . D MES^XPDUTL(DVBPAR_" Update Successful")
 Q
 ;
