ONCPST45 ;Hines OIFO/GWB - Post-init for Patch ONC*2.11*45
 ;;2.11;ONCOLOGY;**45**; Mar 07, 1995
 ;
 ;Convert PRIMARY PAYER AT DX (165.5,18)
 ;from: 36 Medicaid with Medicare supplement
 ;  to: 64 Medicare with Medicaid eligibility
 S CTR=0 F IEN=0:0 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  D
 .S CTR=CTR+1 I CTR#100=0 W "."
 .S PPAD=$P($G(^ONCO(165.5,IEN,1)),U,11)
 .I PPAD=22 S $P(^ONCO(165.5,IEN,1),U,11)=25
