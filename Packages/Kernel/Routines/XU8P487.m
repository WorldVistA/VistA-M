XU8P487 ; BT/OAKLAND - POST ROUTINE; 1/31/08
 ;;8.0;KERNEL;**487**;Jul 10, 1995;Build 2
 ;;"Per VHA Directive 2004-038, this routine should not be modified".
 Q
POST ;
 D KILL,ADD,EDIT,EDIT1
 Q
 ;
ADD ; Add new entries from 1132-1136 
 N XUI,XUPR,XUCL,XUSP,XUX12,XUVAC,XUSPC,XUIEN,XUDATA
 F XUI=1:1:5 S XUDATA=$T(DATA+XUI) Q:XUDATA=" ;;END"  D
 . S XUDATA=$P(XUDATA,";;",2) Q:XUDATA="END"
 . S XUIEN=$P(XUDATA,"^"),XUPR=$P(XUDATA,"^",2),XUCL=$P(XUDATA,"^",3),XUSP=$P(XUDATA,"^",4)
 . S XUX12=$P(XUDATA,"^",5),XUVAC=$P(XUDATA,"^",6),XUSPC=$P(XUDATA,"^",7)
 . D UPDT(XUIEN,XUPR,XUCL,XUSP,XUX12,XUVAC,XUSPC)
 Q
 ;
EDIT ;Edit entries 759
 N FDA
 S FDA(8932.1,"759,",2)="Procedural Dermatology"
 D FILE^DIE("","FDA","ZZERR")
 Q
 ;
UPDT(XUIEN,XUPR,XUCL,XUSP,XUX12,XUVAC,XUSPC) ; add single entry
 N FDA,FDAIEN S FDAIEN(1)=XUIEN
 S FDA(8932.1,"+1,",.01)=XUPR,FDA(8932.1,"+1,",1)=XUCL
 S FDA(8932.1,"+1,",2)=XUSP,FDA(8932.1,"+1,",3)="a"
 S FDA(8932.1,"+1,",5)=$G(XUVAC),FDA(8932.1,"+1,",6)=XUX12
 S FDA(8932.1,"+1,",8)=$G(XUSPC)
 I XUIEN=1136 S FDA(8932.1,"+1,",90002)="N"
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 Q
 ;
EDIT1 ; Update definitions
 N XUI,XUI1,XUY,XUDATA
 K ^TMP($J,"XUBA")
 F XUI=755,759,875,903,905,1132,1133,1134,1135,1136 D
 . F XUY=1:1:100 S XUDATA=$T(@XUI+XUY) Q:XUDATA=" ;;END"  D 
 . . S ^TMP($J,"XUBA",XUI,XUY,0)=$P(XUDATA,";;",2,99)
 . S XUI1=XUI_","
 . D WP^DIE(8932.1,XUI1,11,"K","^TMP($J,""XUBA"",XUI)")
 K ^TMP($J,"XUBA")
 Q
KILL ; kill entries 1132-1136
 N DIK,DA S DIK="^USC(8932.1," F DA=1132,1133,1134,1135,1136 D ^DIK
 Q
 ;
DATA ; information of entries from 1132-1136
 ;;1132^Chiropractic Providers^Chiropractor^Pediatric Chiropractor^111NP0017X^V020900^
 ;;1133^Other Service Providers^Reflexologist^^173C00000X^V082400^
 ;;1134^Other Service Providers^Sleep Specialist, PhD^^173F00000X^V082500^
 ;;1135^Pharmacy Service Providers^Pharmacist^Pharmacist Clinician (PhC)/ Clinical Pharmacy Specialist^1835P0018X^V090106^
 ;;1136^Agencies^Foster Care Agency^^253J00000X^^
 ;;END
 ;
 ; information of definitions
755 ;
 ;;The highly-trained surgeons that perform Mohs Micrographic Surgery are 
 ;;specialists both in dermatology and pathology. With their extensive 
 ;;knowledge of the skin and unique pathological skills, they are able to 
 ;;remove only diseased tissue, preserving healthy tissue and minimizing the 
 ;;cosmetic impact of the surgery. Mohs surgeons who belong to the American 
 ;;College of Mohs Surgery (ACMS) have completed a minimum of one year of 
 ;;fellowship training at one of the ACMS-approved training centers in the 
 ;;U.S.
 ;;
 ;;Source: American College of Mohs Surgery, 2007
 ;; 
 ;;Additional Resources: Additional Resources: http://www.mohscollege.org/; 
 ;;American Board of Dermatology, 2007. http://www.abderm.org/
 ;;END
759 ;
 ;;Procedural Dermatology, a subspecialty of Dermatology, encompassing a 
 ;;wide variety of surgical procedures and methods to remove or modify skin 
 ;;tissue for health or cosmetic benefit. These methods include scalpel 
 ;;surgery, laser surgery, chemical surgery, cryosurgery (liquid nitrogen), 
 ;;electrosurgery, aspiration surgery, liposuction, injection of filler 
 ;;substances, and Mohs micrographic controlled surgery (a special technique 
 ;;for the removal of growths, especially skin cancers).
 ;;
 ;;Source: American Board of Dermatology, 2007
 ;;
 ;;Additional Resources: Some ABMS board certified dermatologists have 
 ;;completed a one-year ACGME approved fellowship in Procedural Dermatology, 
 ;;which has been offered since 2003. At this time the ABD does not offer 
 ;;subspecialty certification in Procedural Dermatology.
 ;;END
875 ;
 ;;A doctor of osteopathy board eligible/certified in the field of 
 ;;Psychiatry by the American Osteopathic Board of Neurology and Psychiatry 
 ;;is able to obtain a Certificate of Added Qualifications in the field of 
 ;;Addiction Medicine.
 ;;
 ;;Source: American Osteopathic Board of Neurology and Psychiatry, 2007 
 ;;
 ;;Additional Resources:
 ;;https://www.do-online.org/index.cfm?PageID=edu_main&au=D&SubSubPageID=crt_
 ;;speclist&SubPageID=crt_main
 ;;END
903 ;
 ;;Trauma surgery is a recognized subspecialty of general surgery. Trauma 
 ;;surgeons are physicians who have completed a five-year general surgery 
 ;;residency and usually continue with a one to two year fellowship in 
 ;;trauma and/or surgical critical care, typically leading to additional 
 ;;board certification in surgical critical care. There is no trauma surgery 
 ;;board certification at this point. To obtain board certification in 
 ;;surgical critical care, a fellowship in surgical critical care or 
 ;;anesthesiology critical care must be completed during or after general 
 ;;surgery residency.
 ;;
 ;;Source: American Board of Surgery, 2007
 ;;
 ;;Additional Resources: http://www.absurgery.org/.
 ;;END
905 ;
 ;;A surgical oncologist is a well-qualified surgeon who has obtained 
 ;;additional training and experience in the multidisciplinary approach to 
 ;;the prevention, diagnosis, treatment, and rehabilitation of cancer 
 ;;patients, and devotes a major portion of his or her professional practice 
 ;;to these activities and cancer research.
 ;;
 ;;Surgical oncology is a recognized fellowship subspecialty program of 
 ;;surgery. Separate board certification is not currently offered.
 ;;
 ;;Source: Society of Surgical Oncology, 2007
 ;; 
 ;;Additional Resources: http://www.surgonc.org/; American Board of Medical 
 ;;Specialties, 2007, www.abms.org; American Board of Surgery, 2007, 
 ;;http://www.absurgery.org/.
 ;;END
1132 ;
 ;;The Pediatric Chiropractor is a chiropractor with specialized, advanced 
 ;;training and certification in the evaluation, care and management of 
 ;;health and wellness conditions of infancy, childhood and adolescence. 
 ;;This specialist provides primary, comprehensive, therapeutic and 
 ;;preventative chiropractic health care for newborns through adolescents.
 ;;
 ;;Source: Council on Chiropractic Pediatrics, American Chiropractic 
 ;;Association, 2007
 ;;END
1133 ;
 ;;Reflexologists perform a non-invasive complementary modality involving 
 ;;thumb and finger techniques to apply alternating pressure to the reflexes 
 ;;within the reflex maps of the body located on the feet, hands, and outer 
 ;;ears. Reflexologists apply pressure to specific areas (feet, hands, and 
 ;;ears) to promote a response from an area far removed from the tissue 
 ;;stimulated via the nervous system and acupuncture meridians. 
 ;;Reflexologists are recommended to complete a minimum of 200 hours of 
 ;;education, typically including anatomy & physiology, Reflexology theory, 
 ;;body systems, zones, meridians & relaxation response, ethics, business 
 ;;standards, and supervised practicum.
 ;;
 ;;Source: National Uniform Claim Committee (based on the American                
 ;;Reflexology Certification Board definition of Reflexology), 2007
 ;;
 ;;Additional Resources: Foot and hand reflexology is a scientific art based 
 ;;on the premise that there are zones and reflex areas in the feet and 
 ;;hands which correspond to all body parts. The physical act of applying 
 ;;specific pressures using thumb, finger and hand techniques result in 
 ;;stress reduction which causes a physiological change in the body. 
 ;;Reflexology is a non-invasive, complementary modality involving thumb and 
 ;;finger techniques to apply alternating pressure to reflexes shown on 
 ;;reflex maps of the body located on the feet, hands, and outer ears.
 ;;
 ;;American Reflexology Certification Board, www.arcb.net/definiti.htm; 
 ;;Reflexology Association of America, www.reflexology-usa.org/standards.html
 ;;END
1134 ;
 ;;Sleep medicine is a clinical specialty with a focus on clinical problems 
 ;;that require accurate diagnosis and treatment. The knowledge base of 
 ;;sleep medicine is derived from many disciplines including neuroanatomy, 
 ;;neurophysiology, respiratory physiology, pharmacology, psychology, 
 ;;psychiatry, neurology, general internal medicine, pulmonary medicine, and 
 ;;pediatrics as well as others.
 ;;
 ;;Source: National Uniform Claim Committee (based on American Board of Sleep
 ;;Medicine), 2007
 ;;
 ;;Additional resources: www.absm.org
 ;;END
1135 ;
 ;;Pharmacist Clinician/Clinical Pharmacy Specialist is a pharmacist with 
 ;;additional training and an expanded scope of practice that may include 
 ;;prescriptive authority, therapeutic management, and disease management.   
 ;;
 ;;Source: National Uniform Claim Committee, 2007
 ;;END
1136 ;
 ;;A Foster Care Agency is an agency that provides foster care as defined in 
 ;;the Code of Federal Regulations (CFR) as "24-hour substitute care for 
 ;;children outside their own homes." Foster care settings include, but are 
 ;;not limited to, nonrelative foster family homes, relative foster homes 
 ;;(whether payments are being made or not), group homes, emergency 
 ;;shelters, residential facilities, and pre-adoptive homes.
 ;;
 ;;Source: Code Of Federal Regulations, Title 45, Volume 4, Part 1355,
 ;;Section 57
 ;;END
