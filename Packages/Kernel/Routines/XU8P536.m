XU8P536 ;BT/BP-OAK Person Class File APIs; 10/22/09
 ;;8.0;KERNEL;**536**; July 10, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
POST ;
 D DEL
 D ADD
 D DEF
 Q
 ;
ADD ; Add new entries from 1159 and 1160
 N XUI,XUDATA
 F XUI=1:1:2 S XUDATA=$T(DATA+XUI) Q:XUDATA=" ;;END"  D
 . S XUDATA=$P(XUDATA,";;",2) Q:XUDATA="END"
 . D ADD1(XUDATA)
 Q
 ;
ADD1(XUDATA) ; add single entry
 N FDA,FDAIEN,XUD
 S XUD=$G(XUDATA)
 S FDAIEN(1)=$P(XUD,"^")
 S FDA(8932.1,"+1,",.01)=$P(XUD,"^",2)
 S FDA(8932.1,"+1,",1)=$P(XUD,"^",3)
 S FDA(8932.1,"+1,",2)=$P(XUD,"^",4)
 S FDA(8932.1,"+1,",3)="a"
 S FDA(8932.1,"+1,",5)=$P(XUD,"^",5)
 S FDA(8932.1,"+1,",6)=$P(XUD,"^",6)
 S FDA(8932.1,"+1,",8)=$P(XUD,"^",7)
 S FDA(8932.1,"+1,",90002)=$P(XUD,"^",8)
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 Q
 ;
DEL ; Delete entry
 N XUI F XUI=1159,1160 D
 . N DIK,DA S DIK="^USC(8932.1,",DA=XUI D ^DIK
 Q
 ;
DATA ; information of entries from 1153-1156
 ;;1159^Pharmacy Service Providers^Pharmacist^Oncology^V090108^1835X0200X^87^I
 ;;1160^Pharmacy Service Providers^Pharmacist^Geriatric^V090107^1835G0303X^87^I
 ;;END
 ;;
DEF ; Update definitions 1159 and 1160
 N XUI
 F XUI=1159,1160 D
 . D DEF1(XUI)
 Q
 ;
DEF1(XUI) ; Update definition for single entry XUI
 N XUI1,XUDATA,XUY
 K ^TMP($J,"XUBA")
 F XUY=1:1:100 S XUDATA=$T(@XUI+XUY) Q:XUDATA=" ;;END"  D 
 . S ^TMP($J,"XUBA",XUI,XUY,0)=$P(XUDATA,";;",2)
 S XUI1=XUI_","
 D WP^DIE(8932.1,XUI1,11,"K","^TMP($J,""XUBA"",XUI)")
 K ^TMP($J,"XUBA")
 Q
 ; information of definitions
1159 ;
 ;;A licensed pharmacist who has demonstrated specialized knowledge and 
 ;;skill in developing, recommending, implementing, monitoring, and 
 ;;modifying pharmacotherapeutic plans to optimize outcomes in patients with 
 ;;malignant diseases.
 ;; 
 ;;Source: Specialty certification and recertification program administered 
 ;;by Board of Pharmaceutical Specialties, www.bpsweb.org [7/1/2006: new]
 ;;END
1160 ;
 ;;A pharmacist who is certified in geriatric pharmacy practice is 
 ;;designated as a "Certified Geriatric Pharmacist" (CGP). To become 
 ;;certified, candidates are expected to be knowledgeable about principles 
 ;;of geriatric pharmacotherapy and the provision of pharmaceutical care to 
 ;;the elderly.
 ;; 
 ;;Source: Commission for Certification in Geriatric Pharmacy (www.ccgp.org) 
 ;;[7/1/2006: new]
 ;;END
