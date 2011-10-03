EASEZPVU ;ALB/GTS/CMF - MT PICKER FOR EZ/EZR PRINT
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57**;Mar 15, 2001
 ;
 Q
PICK(EASDFN,EASMTIEN) ;validate or pick mtien for printing
 ; Input: EASDFN - POINTER TO PATIENT FILE (#2) - required
 ;        EASMTIEN - POINTER TO MEANS TEST FILE (#408.31 - optional
 ; Output: RESULT - valid mt pointer, or null
 N RESULT,MTIEN,DIC,D,X,Y,DTOUT,DUOUT,EASSORT
 S RESULT=""
 ; if means test ien, then return it
 S MTIEN=$G(EASMTIEN)
 S MTIEN=$S($D(^DGMT(408.31,+MTIEN)):+MTIEN,MTIEN=0:0,MTIEN=-1:-1,1:"")
 I (+MTIEN>0)!(MTIEN=-1) Q MTIEN
 ;
 ; if no means test ien, then ask user for one
 D GETMTDAT(EASDFN)
 I $D(EASSORT) D
 .;display sort array here!
 .D DISPLAY
 .;lookup filtered by sort array
 .S DIC=408.31
 .S DIC(0)="AEMQ"
 .S DIC("A")="Select DATE OF TEST:"
 .S DIC("S")="I $D(EASSORT($P(^(0),U),Y))"
 .S D="ADFN"_EASDFN_"^B"
 .D MIX^DIC1
 .S RESULT=+Y
 Q RESULT
 ;
GETMTDAT(EASDFN) ;sort primary tests for printing selection
 ;
 ; Input:  EASDFN - Patient file IEN (DFN)
 ; Output: EASSORT - Array of Means Tests in the following format:
 ;  EASSORT(DATE,MTIEN)=MT IEN^Date of Test^Status Name^Status Code^Source
 ;
 ;check for futures
 ;  means test
 D SORT($$FUT^DGMTU(EASDFN,,1),"NO")
 ;  copay test
 D SORT($$FUT^DGMTU(EASDFN,,2),"NO")
 ;  ltc copay exemption test
 D SORT($$FUT^DGMTU(EASDFN,,4),"NO")
 ;look for current
 ;  means test
 D SORT($$LST^DGMTU(EASDFN,,1),"YES")
 ;  copay test
 D SORT($$LST^DGMTU(EASDFN,,2),"YES")
 ;  ltc copay exemption test
 D SORT($$LST^DGMTU(EASDFN,,4),"YES")
 Q
 ;
SORT(RETURN,PRIMARY) ;sort mt status string
 N DATE,MTIEN
 I +RETURN=0 Q
 S DATE=$P(RETURN,U,2)
 S MTIEN=$P(RETURN,U,1)
 S:$$GET1^DIQ(408.31,MTIEN_",",2)=PRIMARY EASSORT(DATE,MTIEN)=RETURN
 Q
 ;
DISPLAY ; eassort array
 N MTDT,MTIEN,MTIENS
 W !?3,"Choose from:"
 S MTDT=""
 F  S MTDT=$O(EASSORT(MTDT)) Q:MTDT=""  D
 .S MTIEN=""
 .F  S MTIEN=$O(EASSORT(MTDT,MTIEN)) Q:MTIEN=""  D
 ..S MTIENS=MTIEN_","
 ..W !?3,MTDT_"   "
 ..W $$GET1^DIQ(408.31,MTIENS,.01)_"   "  ;test date
 ..W $$GET1^DIQ(408.31,MTIENS,.019)_"   " ;type of test
 ..W $$GET1^DIQ(408.31,MTIENS,.03)_"   "  ;status
 ..W $$GET1^DIQ(408.31,MTIENS,.23)_"   "  ;source of test
 ..W $S($$GET1^DIQ(408.31,MTIENS,2)="YES":"PRIMARY",1:"NOT PRIMARY")
 ..Q
 .Q
 Q
 ;
