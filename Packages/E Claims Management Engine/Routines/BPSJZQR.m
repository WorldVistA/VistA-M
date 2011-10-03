BPSJZQR ;BHAM ISC/LJF - HL7 Registration ZQR Message ;3/3/08  17:03
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; ZQR is pharmacy site registration info
 ;
EN(HL) N BPSZQR,BPSFS,BPSCPS,BPSREP,BPSVA1,BPSVA2,BPSCNF,BPSI
 ;
 ; Normally: HL("FS")="|"  HL("ECH")="^~\&"
 S BPSFS=$G(HL("FS")) I BPSFS="" S BPSFS="|"
 S BPSCPS=$E($G(HL("ECH"))) I BPSCPS="" S BPSCPS="^"
 S BPSREP=$E($G(HL("ECH")),2) I BPSREP="" S BPSREP="~"
 ;
 S BPSZQR=BPSFS_(+$P($G(HL("SITE")),"^",3))
 ;
 ; Get Contact Info
 S BPSVA1=$G(^BPS(9002313.99,1,"VITRIA")),BPSVA2=$P(BPSVA1,"^",2)
 ;
 ; Get Version number
 S BPSZQR=BPSZQR_BPSFS_$P(BPSVA1,"^",3)
 ;
 ; Port
 S BPSZQR=BPSZQR_BPSFS_$G(HL("EPPORT"))
 ;
 ; Load the Name and Means Fields
 ; Default the values to null
 F BPSI=5:1:8 S $P(BPSZQR,BPSFS,BPSI)=""
 ; Contact
 I BPSVA1 D
 . S BPSCNF=$$VA200NM^BPSJUTL(+BPSVA1,"",.HL) I BPSCNF]"" S $P(BPSZQR,BPSFS,5)=BPSCNF
 . S BPSCNF=$$VA20013^BPSJUTL(+BPSVA1,.HL) I BPSCNF]"" S $P(BPSZQR,BPSFS,6)=BPSCNF
 ;
 ; Alternate Contact
 I BPSVA2 D
 . S BPSCNF=$$VA200NM^BPSJUTL(BPSVA2,"",.HL) I BPSCNF]"" S $P(BPSZQR,BPSFS,7)=BPSCNF
 . S BPSCNF=$$VA20013^BPSJUTL(BPSVA2,.HL) I BPSCNF]"" S $P(BPSZQR,BPSFS,8)=BPSCNF
 ;
 Q "ZQR|"_BPSZQR
