DG53173P ;ALB/MM - POST INIT FOR DG*5.3*173;3/2/98
 ;;5.3;Registration;**173**;Aug 13, 1993
 ;
 ;This routine will update the entires in the FY multiple (#45.9101)
 ;in the RUG-II file (#45.91) to meet Year 2000 requirements.
 ;All digit fiscal years will be changed to fileman date
 ;(ex.:  97 has been changed to 2970000).
 ;
EN D BMES^XPDUTL(">> Updating FY multiple to meet Year 2000 Requirements.")
 D FY
 Q
FY ;Change IFN and .01 fields in FY multiple
 N DGRUG,DGFY,DGFMFY
 S DGRUG=0
 F  S DGRUG=$O(^DG(45.91,DGRUG)) Q:'DGRUG  D
 .S DGFY=0
 .F  S DGFY=$O(^DG(45.91,DGRUG,"FY",DGFY)) Q:'DGFY!(DGFY>99)  D
 ..S DGFMFY=(DGFY+200)_"0000"
 ..S ^DG(45.91,DGRUG,"FY",DGFMFY,0)=DGFMFY_U_$P(^DG(45.91,DGRUG,"FY",DGFY,0),U,2,99)
 ..K ^DG(45.91,DGRUG,"FY",DGFY,0)
 .S:$G(DGFMFY) $P(^DG(45.91,DGRUG,"FY",0),U,3)=DGFMFY
 Q
