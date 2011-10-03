PRSAXSR ; HISC/REL-Generate 8B Stub Record ;9/18/92  15:07
 ;;4.0;PAID;;Sep 21, 1995
 ;; DFN = Employee #    PPE = Pay Period (e.g., 92-18)   PPI= Internal PayPer #
 S C0=$G(^PRSPC(DFN,0)),STA=$P(C0,"^",7) S:STA'?3N STA="   "
 S SSN=$P(C0,"^",9) S:SSN'?9N SSN=999999999
 S NCODE=$E($P(C0,"^",1),1,3) S:$L(NCODE)'=3 NCODE="   "
 S TLB=$P(C0,"^",8) S:$L(TLB)'=3 TLB="   "
 S LVGP=$P(C0,"^",15) S:LVGP="" LVGP=" "
 S NH=$P(C0,"^",16),NH=$S(NH="":"  ",NH<10:"0"_NH,NH<100:NH,1:$E("+ABCDEF",$E(NH,1,2)-9)_$E(NH,3))
 S PYPL=$P(C0,"^",21) S:PYPL="" PYPL=" "
 S DB=$P(C0,"^",10) S:DB="" DB=" "
 S DAYNO="   " I $D(^PRST(458,PPI,"E",DFN,3)) S %=$P(^(3),"^",9) S:%?3N DAYNO=%
 S PYPR=$P(PPE,"-",2) S:PYPR'?2N PYPR="  "
 S HDR=" "_STA_SSN_NCODE_DAYNO_"8B"_TLB_LVGP_NH_PYPL_DB_PYPR Q
