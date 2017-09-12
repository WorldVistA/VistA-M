XU8P616 ; BA/BP - PERSON CLASSES;01/10/13
 ;;8.0;KERNEL;**616**; July 10, 1995;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; Update Person Class file for 01/01/2013
POST ;
 D DEL ;clean entry 1212-1217 if existed
 D DEL858 ; clean entry 858 before update
 D ADD ;add entry 1212-1217 in the file
 D DEF ;update definition for entries
 Q
 ;
ADD ;add the entry 1212-1217
 N XUDATA
 S XUDATA="1212^Other Service Providers^Case Manager/Care Coordinator^^a^^V080101^171M00000X^^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1213^Other Service Providers^Community Health Worker^^a^^V080400^172V00000X^^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1214^Other Service Providers^Interpreter^^a^^V080300^171R00000X^^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1215^Other Service Providers^Mechanotherapist^^a^^V080600^172M00000X^^^^I"
 D ADD1(XUDATA)
 S XUDATA="1216^Dental Providers^Dentist^Dentist Anesthesiologist^a^^V030490^1223D0004X^^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1217^Ambulatory Health Care Facilities^Clinic/Center^Birthing^a^^^261QB0400X^^^^N"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="858^Allopathic and Osteopathic Physicians^Pediatrics^Sports Medicine^a^^V182522^2080S0010X^^37^^I"
 D ADD1(XUDATA)
 Q
 ;^USC(8932.1,D0,0)= (#.01) PROVIDER TYPE [1F] ^ (#1) CLASSIFICATION [2F] ^ 
 ;                ==>(#2) AREA OF SPECIALIZATION [3F] ^ (#3) STATUS [4S] ^ (#4) 
 ;                ==>DATE INACTIVATED [5D] ^ (#5) VA CODE [6F] ^ (#6) X12 CODE 
 ;                ==>[7F] ^ (#7) reserved [8F] ^ (#8) SPECIALTY CODE [9F] ^ 
 ;^USC(8932.1,D0,11,0)=^8932.111^^  (#11) DEFINITION
 ;^USC(8932.1,D0,11,D1,0)= (#.01) DEFINITION [1W] ^ 
 ;^USC(8932.1,D0,90002)=  ^ (#90002) INDIVIDUAL/NON [2S] ^
 ;
ADD1(XUDATA) ; add single entry
 N FDA,FDAIEN,XUD
 S XUD=$G(XUDATA)
 S FDAIEN(1)=$P(XUD,"^")
 S FDA(8932.1,"+1,",.01)=$P(XUD,"^",2)
 S FDA(8932.1,"+1,",1)=$P(XUD,"^",3)
 S FDA(8932.1,"+1,",2)=$P(XUD,"^",4)
 S FDA(8932.1,"+1,",3)="a"
 S FDA(8932.1,"+1,",5)=$P(XUD,"^",7)
 S FDA(8932.1,"+1,",6)=$P(XUD,"^",8)
 S FDA(8932.1,"+1,",8)=$P(XUD,"^",10)
 S FDA(8932.1,"+1,",90002)=$P(XUD,"^",12)
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 Q
 ;
DEL ; Delete entries
 N XU581,DIK,DA
 F XU581=1212:1:1217 S DIK="^USC(8932.1,",DA=XU581 D ^DIK 
 Q
 ;
DEL858 ; delete entry 858 before update
 N DIR,DA
 S DIK="^USC(8932.1,",DA=858 D ^DIK
 Q
 ;
DEF ; Update definitions
 N XUI F XUI=1212:1:1217 D DEF1(XUI)
 N XUI D DEF1(858)
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
GETDEF ; get definitions
 N XUI,XUY
 F XUI=1212:1:1217 D
 . S XUY=$G(^USC(8932.1,XUI,11,0)),XUY=$P(XUY,"^",3)
 . I XUY>0 D GETDES(XUI,XUY)
 Q
 ;
GETDES(XUI,XUY) ; get single entry definition
 N XUA,XUB
 W !,XUI," ;"
 F XUA=1:1:XUY W !," ;;",$G(^USC(8932.1,XUI,11,XUA,0))
 W !," ;;END"
 Q
GET ;
 N XU591
 F XU591=1212:1:1217 D GET1(XU591)
 Q
 ;
GET1(XUIEN) ; Get information of given entry from Person Class file.
 N XUI
 S XUI=" ;;"_XUIEN_"^"_$G(^USC(8932.1,XUIEN,0))
 S $P(XUI,"^",12)=$G(^USC(8932.1,XUIEN,90002))
 W !," N XUDATA"
 W !," S XUDATA=","""",$P(XUI,";;",2),""""
 W !," D ADD1(XUDATA)"
 Q
 ;
1212 ;
 ;;A person who provides case management services and assists an individual 
 ;;in gaining access to needed medical, social, educational, and/or other 
 ;;services. The person has the ability to provide an assessment and review 
 ;;of completed plan of care on a periodic basis. This person is also able 
 ;;to take collaborative action to coordinate the services with other 
 ;;providers and monitor the enrollee's progress toward the cost-effective 
 ;;achievement of objectives specified in the plan of care. Credentials may 
 ;;vary from an experience in the fields of psychology, social work, 
 ;;rehabilitation, nursing or a closely related human service field, to a 
 ;;related Assoc of Arts Degree or to nursing credentials. Some states may 
 ;;require certification in case management.
 ;;END
1213 ;
 ;;Community health workers (CHW) are lay members of communities who work 
 ;;either for pay or as volunteers in association with the local health care 
 ;;system in both urban and rural environments and usually share ethnicity, 
 ;;language, socioeconomic status and life experiences with the community 
 ;;members they serve. They have been identified by many titles such as 
 ;;community health advisors, lay health advocates, promotores(as), 
 ;;outreach educators, community health representatives, peer health 
 ;;promoters, and peer health educators. CHWs offer interpretation and 
 ;;translation services, provide culturally appropriate health education and 
 ;;information, assist people in receiving the care they need, give informal 
 ;;counseling and guidance on health behaviors, advocate for individual and 
 ;;community health needs, and provide some direct services such as first 
 ;;aid and blood pressure screening. Some examples of these practitioners 
 ;;are Community Health Aides or Practitioners established under 25 USC 
 ;;1616 (l) under HHS, Indian Health Service, Public Health Service.
 ;;END
1214 ;
 ;;An Interpreter is a person who translates oral communication between two 
 ;;or more people. This includes translating from one language to another or 
 ;;interpreting sign language. An interpreter is necessary for medical care 
 ;;when the patient does not speak the language of the health care provider 
 ;;or when the patient has a disability involving spoken language.
 ;;END
1215 ;
 ;;A practitioner of mechanotherapy examines patients by verbal inquiry, 
 ;;examination of the musculoskeletal system by hand, and visual inspection 
 ;;and observation. In the treatment of patients, mechanotherapists employ 
 ;;the techniques of advised or supervised exercise; electrical 
 ;;neuromuscular stimulation; massage or manipulation; or air, water, heat, 
 ;;cold, sound, or infrared ray therapy.
 ;;END
1216 ;
 ;;A dentist who has successfully completed an accredited postdoctoral 
 ;;anesthesiology residency training program for dentists of two or more 
 ;;years duration, in accord with Commission on Dental Accreditation's 
 ;;Standards for Dental Anesthesiology Residency Programs, and/or meets the 
 ;;eligibility requirements for examination by the American Dental Board of 
 ;;Anesthesiology.
 ;; 
 ;;Source: The American Society of Dentist Anesthesiologists.
 ;;END
1217 ;
 ;;A freestanding birth center is a health facility other than a hospital 
 ;;where childbirth is planned to occur away from the pregnant woman's 
 ;;residence, and that provides prenatal, labor and delivery, and postpartum 
 ;;care, as well as other ambulatory services for women and newborns.
 ;; 
 ;;Source: Summarized from Social Security Act [42 U.S.C. 1396d(1)(3)(B)].
 ;;END
858 ;
 ;;A pediatrician who is responsible for continuous care in the field of 
 ;;sports medicine, not only for the enhancement of health and fitness, but 
 ;;also for the prevention of injury and illness. A sports medicine 
 ;;physician must have knowledge and experience in the promotion of wellness 
 ;;and the prevention of injury. Knowledge about special areas of medicine 
 ;;such as exercise physiology, biomechanics, nutrition, psychology, 
 ;;physical rehabilitation, epidemiology, physical evaluation, injuries 
 ;;(treatment and prevention and referral practice) and the role of exercise 
 ;;in promoting a healthy lifestyle are essential to the practice of sports 
 ;;medicine. The sports medicine physician requires special education to 
 ;;provide the knowledge to improve the healthcare of the individual engaged 
 ;;in physical exercise (sports) whether as an individual or in team 
 ;;participation.   Source: American Board of Medical Specialties, 2007. 
 ;;www.abms.org [7/1/2007: definition added, source added; 7/1/2011: 
 ;;modified source]
 ;; 
 ;;Additional Resources: American Board of Pediatrics, 2007. 
 ;;http://www.abp.org/. American Osteopathic Board of Pediatrics, 2007. 
 ;;http://www.osteopathic.org/certification
 ;; 
 ;;Board certification for Medical Doctors (MDs) is provided by the American 
 ;;Board of Pediatrics. Board certification for Doctors of Osteopathy (DOs) 
 ;;is provided by the American Osteopathic Board of Pediatrics. 
 ;;END
