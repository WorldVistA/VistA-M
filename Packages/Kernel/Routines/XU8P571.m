XU8P571 ; BA/BP - PERSON CLASSES; 05/10/11
 ;;8.0;KERNEL;**571**; July 10, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ;
 D DEL ;clean entry 1170 if existed
 D ADD ;add entry 1170 in the file
 D DEF ;update definition for entries
 Q
 ;
ADD ;add the entry 1170
 N XUDATA
 S XUDATA="1170^Other Service Providers^Genetic Counselor, MS^^V082201^170300000X^^I"
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
 S XU560=1170 S DIK="^USC(8932.1,",DA=XU560 D ^DIK
 Q
 ;
DEF ; Update definitions
 N XUI
 S XUI=1170 D DEF1(XUI)
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
1170 ;
 ;;A masters trained health care provider who collects and interprets 
 ;;genetic family histories; assesses the risk of disease occurrence or
 ;;recurrence; identifies interventions to manage or ameliorate disease risk;
 ;;educates about inheritance, testing, management, prevention, ethical
 ;;issues, resources, and research; and counsels to promote informed choices
 ;;and adaptation. Certification was established in 1993 by the American
 ;;Board of Genetic Counseling and prior to that by the American Board of
 ;;Medical Genetics. Requirements for experience, licensure, and job
 ;;responsibilities vary among the states.
 ;; 
 ;;Source: National Society of Genetic Counselors [7/1/2005: new]
 ;;END
 Q
 ;
GETDATA ; get definitions
 N XUI,XUY
 S XUI=1170
 S XUY=$G(^USC(8932.1,XUI,11,0)),XUY=$P(XUY,"^",3)
 I XUY>0 D GETDES(XUI,XUY)
 Q
 ;
GETDES(XUI,XUY) ; get single entry definition
 N XUA,XUB
 W !,XUI," ;"
 F XUA=1:1:XUY W !," ;;",$G(^USC(8932.1,XUI,11,XUA,0))
 W !," ;;END"
 Q
