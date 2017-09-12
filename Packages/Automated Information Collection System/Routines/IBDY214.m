IBDY214 ;ALB/JLS - EDIT FILE 357.6 IEN 94 - PATCH IBD*2.1*14  13-DEC-96
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;**14**; 3-APR-96
 ;
 ; resets PCE DIM PIECE,  NARRATIVE (#12.03) from 1 to 7 for entry
 ; PX INPUT IMMUNIZATION (#94).
 ;
 ; PX IMMUNIZATION INPUT/SELECTION entries AVAILABLE? (Y/N) field set
 ; to YES.
 ;
 D SETNARR,PXIMM
 Q
 ;
SETNARR ; Reset field 12.03 from 1 (original) to 7 (new) for ien #94
 N X,IBDIMM94
 S X(1)=">>> Updating the PCE DIM PIECE,  NARRATIVE field for ien #94 in file 357.6."
 S X(2)=" " D BMES^XPDUTL(.X)
 S IBDIMM94=$G(^IBE(357.6,94,0)) I IBDIMM94]"" D
 .S $P(^IBE(357.6,94,12),"^",3)=7
 .W !,"Package File entry PX INPUT IMMUNIZATION has been updated."
 .Q
 I IBDIMM94="" W !,"Package File entry PX INPUT IMMUNIZATION not found, no updating done."
 Q
PXIMM ; Check/Set AVAILABLE? (Y/N) field (#.09) to YES for PX IMMUNIZATION entries
 N X,IBDIMM86,IBDIMM94
 S X(1)=">>> Checking AVAILABLE? (Y/N) field (#.09) for PX IMMUNIZATION entries."
 S X(2)=" " D BMES^XPDUTL(.X)
 S IBDIMM86=$G(^IBE(357.6,86,0)) I IBDIMM86]"" D
 .S $P(^IBE(357.6,86,0),"^",9)=1
 .W !,"Package File entry PX SELECT IMMUNIZATIONS enabled."
 .Q
 I IBDIMM86="" W !,"Package File entry PX SELECT IMMUNIZATIONS not found, not enabled."
 ;
 S IBDIMM94=$G(^IBE(357.6,94,0)) I IBDIMM94]"" D
 .S $P(^IBE(357.6,94,0),"^",9)=1
 .W !,"Package File entry PX INPUT IMMUNIZATION enabled."
 .Q
 I IBDIMM94="" W !,"Package File entry PX INPUT IMMUNIZATION not found, not enabled."
 Q
