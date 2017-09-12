SR146UTL ;BIR/ADM - SR*3*146 POST-INSTALL ;01/13/06
 ;;3.0; Surgery ;**146**;24 Jun 93
 Q
POST ; post-install action for SR*3*146 to update file 133
 ; set UPDATES TO PCE field to ALL CASES
 ; set ASK CLASSIFICATION QUESTIONS field to YES
 N SRI
 S SRI=0 F  S SRI=$O(^SRO(133,SRI)) Q:'SRI  I $D(^SRO(133,SRI,0)) D
 .S $P(^SRO(133,SRI,0),"^",15)="A",$P(^SRO(133,SRI,0),"^",16)=1
 Q
