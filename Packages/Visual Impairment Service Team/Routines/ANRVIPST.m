ANRVIPST ;HCIOFO/NDH - Post Initialization routine March 18, 1998
 ;;4.0; Visual Impairment Service Team ;**2**;12 JUN 98
START ; Populate 2041.05 with correct email distribution list
 S ANRVI=0,ANRVADR="VHACO117AMIS@DOMAIN.EXT"
 F  S ANRVI=$O(^ANRV(2041,ANRVI)) Q:+ANRVI=0  D
 .S ANRVX(2041,ANRVI_",",.05)=ANRVADR
 D FILE^DIE("E","ANRVX")
 Q
