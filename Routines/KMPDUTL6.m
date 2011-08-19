KMPDUTL6 ;OIFO/RAK - CPU Utilities ;2/17/04  10:58
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;;
CPUDEL ;-- delete cpu data from file #8973 - cp parameters
 ;
 N DA,DIK,X,Y
 ;
 S DA(1)=$O(^KMPD(8973,0)) Q:'DA(1)
 S DIK="^KMPD(8973,"_DA(1)_",20,"
 F DA=0:0 S DA=$O(^KMPD(8973,DA(1),20,DA)) Q:'DA  D ^DIK
 ;
 Q
 ;
CPUGET(KMPDARRY) ;--get cpu data
 ;-----------------------------------------------------------------------
 ; KMPDARRY... Return array (passed by reference) in format:
 ;              KMPDARRY(1)=Node
 ;-----------------------------------------------------------------------
 ;
 K KMPDARRY
 Q:$G(^KMPD(8973,1,20,0))=""
 M KMPDARRY=^KMPD(8973,1,20)
 ;
 Q
 ;
CPUSET(KMPDLT) ;-- set cpu info into file #8973 cp parameters
 ;---------------------------------------------------------------------
 ; KMPDLT... Delete previous entries
 ;            0 - do not delete
 ;            1 - delete
 ;---------------------------------------------------------------------
 ;
 S KMPDLT=+$G(KMPDLT)
 ;
 N CPU,IEN,ERROR,FDA,NODE,ZIEN
 ;
 ; delete current CPU entries
 D:KMPDLT CPUDEL
 ;
 S IEN=$O(^KMPD(8973,0)) Q:'IEN
 ; get cpu data
 D CPU^KMPDUTL5(.CPU) Q:'$D(CPU)
 ; file cpu data
 S NODE=""
 F  S NODE=$O(CPU(NODE)) Q:NODE=""  D 
 .K FDA,ERROR,ZIEN
 .S FDA($J,8973.201,"?+1,"_IEN_",",.01)=NODE
 .S FDA($J,8973.201,"?+1,"_IEN_",",.02)=$P(CPU(NODE),U)
 .S FDA($J,8973.201,"?+1,"_IEN_",",.03)=$P(CPU(NODE),U,2)
 .S FDA($J,8973.201,"?+1,"_IEN_",",.04)=$P(CPU(NODE),U,3)
 .S FDA($J,8973.201,"?+1,"_IEN_",",.05)=$P(CPU(NODE),U,4)
 .D UPDATE^DIE("","FDA($J)",.ZIEN,"ERROR")
 ;
 Q
