ONCORF ;HIRMFO/GWB - OVER-RIDE FLAG PRINT;11/30/00
 ;;2.11;ONCOLOGY;**27,30**;Mar 07, 1995
PRT N DI,DIC,DR,DA,DIQ,ONC
 S DIC="^ONCO(165.5,"
 S DR="205:226"
 S DA=D0,DIQ="ONC" D EN^DIQ1
 W !," Over-ride Age/Site/Morph.: ",ONC(165.5,D0,205),?40,"Over-ride SS/NodesPos....: ",ONC(165.5,D0,218)
 W !," Over-ride SeqNo/DxConf...: ",ONC(165.5,D0,206),?40,"Over-ride SS/TNM-N.......: ",ONC(165.5,D0,219)
 W !," Over-ride Site/Lat/SeqNo.: ",ONC(165.5,D0,207),?40,"Over-ride SS/TNM-M.......: ",ONC(165.5,D0,220)
 W !," Over-ride Surg/DxConf....: ",ONC(165.5,D0,208),?40,"Over-ride SS/DisMet1.....: ",ONC(165.5,D0,221)
 W !," Over-ride Site/Type......: ",ONC(165.5,D0,209),?40,"Over-ride Acsn/Class/Seq.: ",ONC(165.5,D0,222)
 W !," Over-ride Histology......: ",ONC(165.5,D0,210),?40,"Over-ride HospSeq/DxConf.: ",ONC(165.5,D0,223)
 W !," Over-ride Report Source..: ",ONC(165.5,D0,211),?40,"Over-ride COC-Site/Type..: ",ONC(165.5,D0,224)
 W !," Over-ride Ill-define Site: ",ONC(165.5,D0,212),?40,"Over-ride HospSeq/Site...: ",ONC(165.5,D0,225)
 W !," Over-ride Leuk, Lymphoma.: ",ONC(165.5,D0,213),?40,"Over-ride Site/TNM-StgGrp: ",ONC(165.5,D0,226)
 W !," Over-ride Site/Behavior..: ",ONC(165.5,D0,214)
 W !," Over-ride Site/EOD/DX Dt.: ",ONC(165.5,D0,215)
 W !," Over-ride Site/Lat/EOD...: ",ONC(165.5,D0,216)
 W !," Over-ride Site/Lat/Morph.: ",ONC(165.5,D0,217)
 W !,DASHES
 Q
