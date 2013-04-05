RMPRWOFX ;HOIFO/SPS - PRE-INIT PROSTHETICS WO FILE FIX ;08/24/06
 ;;3.0;Prosthetics;**75**;Feb 09, 1996;Build 25
 ;
 ; Fix to check for installation of patch 75 then delete 
 ; erroneous data in file 664.1 8th piece that might have been
 ; left over from 1994-95
EN ;
 N RMPRP,RMPRIEN
 S RMPRP=$$PATCH^XPDUTL("RMPR*3.0*75")
 I RMPRP=1 Q  ;Stop if 75 is installed
 ;
 S RMPRIEN=""
 F  S RMPRIEN=$O(^RMPR(664.1,RMPRIEN)) Q:RMPRIEN=""  D
 .Q:'$D(^RMPR(664.1,RMPRIEN,0))
 .Q:+$P(^RMPR(664.1,RMPRIEN,0),U)>2961231
 .I $P(^RMPR(664.1,RMPRIEN,0),U,8)'="" S $P(^(0),U,8)=""
 Q
