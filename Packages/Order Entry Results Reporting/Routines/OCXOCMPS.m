OCXOCMPS ;SLC/RJS,CLA - ORDER CHECK CODE COMPILER (Screen Code Library) ;8/16/99  09:03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
EN ;
 ;
 Q
 ;
OPSCR() ;
 ;
 N OCXDT,OCXOPDT
 S OCXOPDT=$P($G(^OCXS(864.1,+$P(^(0),U,2),0)),U,1)
 S OCXDT=$$DTYP(+$G(^OCXS(860.3,+$G(DA(1)),"COND",+$G(DA),"DFLD1")))
 Q:'(OCXDT=OCXOPDT) 0 Q ''$D(^OCXS(863.9,+Y,"PAR","B","OCXO GENERATE CODE FUNCTION"))
 ;
SCFLD(OCXNODE,OCXD0) ;
 ;
 ; This subroutine is called from the input transform of
 ; 'Data Field 1', 'Data Field 2', and 'Data Field 3' of the
 ; Conditional Expression Sub-Field of the Order Check Element
 ; file. The naked pointer should therefore be pointing to the
 ; 'zero' node of the record being processed.
 ;
 N CONTXT,LINKS,D0
 M LINKS=^("LINK")
 S CONTXT=$P($G(^OCXS(860.3,OCXD0,0)),U,2)
 I $D(LINKS(+CONTXT)) Q 1
 S CONTXT=$O(^OCXS(860.6,"B","DATABASE LOOKUP",0)) Q:'CONTXT 0
 Q ''$D(LINKS(+CONTXT))
 ;
SOURCE(OCXNODE,D0,D1) ;
 ;
 Q ($P(OCXNODE,U,2)=(+$G(^OCXS(860.4,D0,"LINK",D1,0))))
 ;
DTYP(DFLD) ;
 Q:'DFLD "A"
 N OCXLINK,OCXATT,OCXDTN,OCXDTYP,OCXX,OCXCON
 S OCXCON=$O(^OCXS(860.4,+DFLD,"LINK",0)) Q:'OCXCON "AA"
 S OCXLINK=$G(^OCXS(860.4,+DFLD,"LINK",OCXCON,"DATAPATH")) Q:'$L(OCXLINK) "B"
 S OCXLINK=$O(^OCXS(863.3,"B",OCXLINK,0)) Q:'OCXLINK "C"
 S OCXATT=$P($G(^OCXS(863.3,+OCXLINK,0)),U,5) Q:'OCXATT "D"
 S OCXDTN=$O(^OCXS(863.8,"B","DATA TYPE",0)) Q:'OCXDTN "E"
 S OCXX=0 F  S OCXX=$O(^OCXS(863.4,OCXATT,"PAR",OCXX)) Q:'OCXX  Q:($P(^OCXS(863.4,OCXATT,"PAR",OCXX,0),U,1)=OCXDTN)
 Q:'OCXX "F" Q $G(^OCXS(863.4,OCXATT,"PAR",OCXX,"VAL"))
 ;
LABEL ;
 N OCXER,OCXX,OCXY,OCXSUB
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S OCXX=X,OCXER=0
 I ($L(X)>30)!($L(X)<1) W !,"   ",$L(OCXX)," characters, Label TOO long... " S OCXER=OCXER+1
 I (X["(") W !,"  Illegal punctuation -> '(' " S OCXER=OCXER+1
 I (X[")") W !,"  Illegal punctuation -> ')' " S OCXER=OCXER+1
 S OCXY=$O(^OCXS(860.2,+$G(DA(1)),"C","C",X,0))
 I OCXY,'(OCXY=DA) W !,"  This label already used by another element",!,"   -> ",$P($G(^OCXS(860.3,+$G(^OCXS(860.2,DA(1),"C",OCXY,0)),0)),U,1) S OCXER=OCXER+1
 S OCXY=$O(^OCXS(864.1,"B","BOOLEAN",0))
 I OCXY F OCXSUB="B","AKA" D
 .N OCXNAM S OCXNAM="" F  S OCXNAM=$O(^OCXS(863.9,OCXSUB,OCXNAM)) Q:'$L(OCXNAM)  D
 ..S OCXX=0 F  S OCXX=$O(^OCXS(863.9,OCXSUB,OCXNAM,OCXX)) Q:'OCXX  D
 ...N OCXDTYP S OCXDTYP=$P($G(^OCXS(863.9,OCXX,0)),U,2) Q:'(OCXDTYP=OCXY)
 ...I ((" "_X_" ")[(" "_OCXNAM_" ")) W !,"  Illegal Reserved word -> '",OCXNAM,"'" S OCXER=OCXER+1
 I (" "_X_" "[(" IF ")) W !,"  Illegal Reserved word -> 'IF'" S OCXER=OCXER+1
 ;
 I OCXER K X
 Q
 ;
