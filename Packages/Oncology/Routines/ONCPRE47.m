ONCPRE47 ;Hines OIFO/GWB - PRE-INSTALL ROUTINE FOR PATCH ONC*2.11*47
 ;;2.11;ONCOLOGY;**47**;Mar 07, 1995;Build 19
 ;
 ;Kill ONCOLOGY DATA EXTRACT FORMAT (160.16) data
 K ^ONCO(160.16)
 ;
ITEM2 ;Change ZIP CODE (5.11) field COUNTY (5.11,2) pointer value from 3162
 ;to 37 for ZIP CODE entry 92183 (IEN = 86016)
 I '$D(^VIC(5.1,37,0)) G MISC6
 I $P($G(^VIC(5.11,86016,0)),U,3)=3162 S $P(^VIC(5.11,86016,0),U,3)=37
 ;
 ;Convert COUNTY AT DX (165.5,10) pointer values of 3162 to 37
 F IEN=0:0 S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  D
 .S CNTDX=$P($G(^ONCO(165.5,IEN,1)),U,3)
 .I CNTDX=3162 S $P(^ONCO(165.5,IEN,1),U,3)=37
 ;
 ;Delete COUNTY (5.1) entry 3162 (SAN DIEGO)
 S DIK="^VIC(5.1,",DA=3162 D ^DIK
 ;
MISC6 ;Delete CASE CLASS (165.5,.043)
 ;Delete MAJOR ICDO-SITES (165.5,.016)
 ;These COMPUTED fields do not work correctly and are not needed.
 S DIK="^DD(165.5,",DA=.043,DA(1)=165.5 D ^DIK
 S DIK="^DD(165.5,",DA=.016,DA(1)=165.5 D ^DIK
 ;
MISC7 ;Delete STAGE GROUPING-AJCC (165.5,38.5)
 ;The data dictionary for STAGE GROUPING-AJCC contains can unnecessary
 ;9.1 computed expression node.  STAGE GROUPING-AJCC will be re-created
 ;by the install.
 S DIK="^DD(165.5,",DA=38.5,DA(1)=165.5 D ^DIK
 Q
