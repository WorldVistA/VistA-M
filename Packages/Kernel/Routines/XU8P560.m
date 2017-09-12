XU8P560 ; BA/BP - PERSON CLASSES; 01/11/11
 ;;8.0;KERNEL;**560**; July 10, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
POST ;
 D DEL ;clean entry 410,1167-1169 if existed
 D ADD ;add entry 410,1167-1169 in the file
 D DEF ;update definition for entries
 Q
 ;
ADD ;add the entry 410,1167 and 1169
 N XUDATA S XUDATA="410^Respiratory, Rehabilitative and Restorative Service Providers^Orthotic Fitter^^V130207^225000000X^57^I"
 D ADD1(XUDATA)
 N XUDATA S XUDATA="1167^Other Service Providers Type^Lactation Consultant, Non-RN^^V070850^174N00000X^^I"
 D ADD1(XUDATA)
 N XUDATA S XUDATA="1168^Other Service Providers Type^Clinical Ethicist^^V081810^174V00000X^^I"
 D ADD1(XUDATA)
 N XUDATA S XUDATA="1169^Allopathic & Osteopathic Physicians^Electrodiagnostic Medicine^^V181550^204R00000X^13^I"
 D ADD1(XUDATA)
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
DEL ; Delete entries
 N XU560,DIK,DA
 F XU560=410,1167,1168,1169 D
 . S DIK="^USC(8932.1,",DA=XU560 D ^DIK
 Q
 ;
DEF ; Update definitions
 N XUI
 F XUI=410,1167,1168,1169 D
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
 ;
410 ;
 ;;An individual trained in the management of fitting prefabricated orthoses.
 ;;
 ;;Source: National Uniform Claim Committee
 ;;
 ;;Additional Resources: American Board for Certification in Orthotics, 
 ;;Prosthetics and Pedorthics, Inc., www.abcop.org and Board of 
 ;;Certification/Accreditation, International, www.bocusa.org.
 ;;END
1167 ;
 ;;An individual trained to provide breastfeeding assistance services to 
 ;;both mothers and infants. Lactation Consultants are not required to be 
 ;;nurses and are trained through specific courses of education. The 
 ;;Lactation Consultant may have additional certification through a national 
 ;;or international organization.
 ;; 
 ;;Source: National Uniform Claim Committee
 ;;END
1168 ;
 ;;A clinical ethicist has been trained in bioethics and ethics case 
 ;;consultation. The clinical ethicist addresses medical-ethical dilemmas 
 ;;arising in clinical practice, such as end-of-life care, refusal of 
 ;;treatment, and futility of care; assists patients and health care 
 ;;providers with medical decision-making; and provides ethics education for 
 ;;patients and families.
 ;; 
 ;;Source: National Uniform Claim Committee
 ;;END
1169 ;
 ;;Electrodiagnostic medicine is the medical subspecialty that applies 
 ;;neurophysiologic techniques to diagnose, evaluate, and treat patients 
 ;;with impairments of the neurologic, neuromuscular, and/or muscular 
 ;;systems. Qualified physicians are trained in performing 
 ;;electrophysiological testing and interpretation of the test data. They 
 ;;require knowledge in anatomy, physiology, kinesiology, histology, and 
 ;;pathology of the brain, spinal cord, autonomic nerves, cranial nerves, 
 ;;peripheral nerves, neuromuscular junction, and muscles. They must know 
 ;;clinical features and treatment of diseases of the central, peripheral, 
 ;;and autonomic nervous systems, as well as those of neuromuscular junction 
 ;;and muscle. Physicians also require special knowledge about electric 
 ;;signal processing, including waveform analysis, electronics and 
 ;;instrumentation, stimulation and recording equipment, and statistics.
 ;; 
 ;;Source: American Association of Neuromuscular & Electrodiagnostic 
 ;;Medicine, 2011. www.aanem.org
 ;;END
