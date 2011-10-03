ONCPST22 ;HIRMFO/GWB - Post-init for Patch ONC*2.11*22
 ;;2.11;ONCOLOGY;**22**; Mar 07, 1995
 ;(1) Re-index STATUS (160,15) "AS" cross-reference
 ;(2) Remove TYPE OF REPORTING SOURCE (165.5,1.2) codes 2 and 9 
 ;(3) Convert EXTRANODAL SITE W/C-D SURGERY (165.5,855) values of 888 to
 ;   C888
 ;(4) Convert SEER EOD-88 3rd edition PROSTATE EXTENSION (165.5,30) codes
 ;   '99' to '90'
AS ;Reindex STATUS (160,15) field (1)
 K ^ONCO(160,"AS")
 S DIK="^ONCO(160,",DIK(1)="15" D ENALL^DIK
 K DIK
 S CT=0 F IEN=0:0 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  D
 .S CT=CT+1 I CT#100=0 W "."
 .I ($P(^ONCO(165.5,IEN,0),U,10)=2)!($P(^ONCO(165.5,IEN,0),U,10)=9) S $P(^ONCO(165.5,IEN,0),U,10)=""           ;(2)
 .I $D(^ONCO(165.5,IEN,3)),$P(^ONCO(165.5,IEN,3),U,33)=0 S $P(^ONCO(165.5,IEN,3),U,33)=1
 .I $D(^ONCO(165.5,IEN,"NHL2")),$P(^ONCO(165.5,IEN,"NHL2"),U,10)=888 S $P(^ONCO(165.5,IEN,"NHL2"),U,10)="C888" ;(3)
 .I '$D(^ONCO(165.5,IEN,2)) Q    ;(4)
 .S TOP=$P($G(^ONCO(165.5,IEN,2)),U,1)  ;Topography
 .S ED=$$EDITION^ONCOU55(IEN)           ;Edition of SEER
 .S EXT=$P($G(^ONCO(165.5,IEN,2)),U,10) ;Extension
 .I (TOP'=67619)!(ED'=3)!(EXT'=99) Q
 .S $P(^ONCO(165.5,IEN,2),U,10)=90
EXIT K CT,EXT,IEN,TOP,ED Q
