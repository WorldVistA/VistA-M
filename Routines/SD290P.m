SD290P ;bpiofo/swo - 290 post init; OCT 20 2003
 ;;5.3;Scheduling;**290**;AUG 13, 1993
 N SDIEN
 S SDIEN=$O(^HL(771,"B","SD-SITE-PAIT",""))
 I SDIEN="" D  Q
 . D BMES^XPDUTL(" Unable to update FACILITY NAME field of file 771")
 . D BMES^XPDUTL(" Edit entry SD-SITE-PAIT manually")
 S $P(^HL(771,SDIEN,0),"^",3)=$P($$SITE^VASITE(),"^",3)
 D BMES^XPDUTL(" HL7 Parameters Updated Successfully")
 Q
