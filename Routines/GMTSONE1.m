GMTSONE1 ; HIN/GWB - Oncology Health Summary Comp ; 1/11/05 8:53am
 ;;2.7;Health Summary;**72**;Oct 20, 1995
 ;                        
DISPLAY ; Display Extracted Data
 S IEN=0 F CNT=1:1 S IEN=$O(^UTILITY("DIQ1",$J,165.5,IEN)) Q:IEN=""  D
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W " #",CNT," Cancer Identification"
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," ------------------------"
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W:$D(^UTILITY("DIQ1",$J,165.5,IEN,2000)) !," Division...................: ",^UTILITY("DIQ1",$J,165.5,IEN,2000)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Class of Case..............: ",^UTILITY("DIQ1",$J,165.5,IEN,.04)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Date Dx....................: ",^UTILITY("DIQ1",$J,165.5,IEN,3)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Primary Site...............: ",^UTILITY("DIQ1",$J,165.5,IEN,20)
 . I ^UTILITY("DIQ1",$J,165.5,IEN,91)'="Complete" D  Q
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !," Abstract Status............: ",^UTILITY("DIQ1",$J,165.5,IEN,91)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !!
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . I ^UTILITY("DIQ1",$J,165.5,IEN,3,"I")<3010000 D
 . . W !," Histology (ICD-O-2)........: ",^UTILITY("DIQ1",$J,165.5,IEN,22)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . I ^UTILITY("DIQ1",$J,165.5,IEN,3,"I")>3001231 D
 . . W !," Histology (ICD-O-3)........: ",^UTILITY("DIQ1",$J,165.5,IEN,22.3)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Grade/Differentiation......: ",^UTILITY("DIQ1",$J,165.5,IEN,24)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Abstract Status............: ",^UTILITY("DIQ1",$J,165.5,IEN,91)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," #",CNT," Stage of Disease at Diagnosis"
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," --------------------------------"
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Tumor Size.................: ",^UTILITY("DIQ1",$J,165.5,IEN,29)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Regional Nodes Examined....: ",^UTILITY("DIQ1",$J,165.5,IEN,33)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Regional Nodes Positive....: ",^UTILITY("DIQ1",$J,165.5,IEN,32)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Clinical T.................: ",^UTILITY("DIQ1",$J,165.5,IEN,37.1)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Clinical N.................: ",^UTILITY("DIQ1",$J,165.5,IEN,37.2)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Clinical M.................: ",^UTILITY("DIQ1",$J,165.5,IEN,37.3)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Clinical Stage Group.......: ",^UTILITY("DIQ1",$J,165.5,IEN,38)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Pathologic T...............: ",^UTILITY("DIQ1",$J,165.5,IEN,85)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Pathologic N...............: ",^UTILITY("DIQ1",$J,165.5,IEN,86)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Pathologic M...............: ",^UTILITY("DIQ1",$J,165.5,IEN,87)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Pathologic Stage Group.....: ",^UTILITY("DIQ1",$J,165.5,IEN,88)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . I ^UTILITY("DIQ1",$J,165.5,IEN,3,"I")>3031231 D
 . . W !," #",CNT," Collaborative Staging"
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !," ------------------------"
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !," Derived AJCC T.............: ",^UTILITY("DIQ1",$J,165.5,IEN,160)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !," Derived AJCC T Descriptor..: ",^UTILITY("DIQ1",$J,165.5,IEN,161)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !," Derived AJCC N.............: ",^UTILITY("DIQ1",$J,165.5,IEN,162)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !," Derived AJCC N Descriptor..: ",^UTILITY("DIQ1",$J,165.5,IEN,163)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !," Derived AJCC M.............: ",^UTILITY("DIQ1",$J,165.5,IEN,164)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !," Derived AJCC M Descriptor..: ",^UTILITY("DIQ1",$J,165.5,IEN,165)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !," Derived AJCC Stage Group...: ",^UTILITY("DIQ1",$J,165.5,IEN,166)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !," Derived SS2000.............: ",^UTILITY("DIQ1",$J,165.5,IEN,168)
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," #",CNT," First Course of Treatment"
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," ----------------------------"
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . S TXT=^UTILITY("DIQ1",$J,165.5,IEN,58.1) D TXT
 . W !," Surgical Dx/Staging Proc...: ",^UTILITY("DIQ1",$J,165.5,IEN,58.3)," ",TXT1
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W:TXT2'="" !,?41,TXT2
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . S TXT=^UTILITY("DIQ1",$J,165.5,IEN,58.6) D TXT
 . W !," Surgery of primary site....: ",^UTILITY("DIQ1",$J,165.5,IEN,50)," ",TXT1
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W:TXT2'="" !,?41,TXT2
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Reason for no surgery......: ",^UTILITY("DIQ1",$J,165.5,IEN,58)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Radiation..................: ",^UTILITY("DIQ1",$J,165.5,IEN,51)," ",^UTILITY("DIQ1",$J,165.5,IEN,51.2)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Regional dose:cGy..........: ",^UTILITY("DIQ1",$J,165.5,IEN,442)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Boost dose:cGy.............: ",^UTILITY("DIQ1",$J,165.5,IEN,443)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Radiation treatment volume.: ",^UTILITY("DIQ1",$J,165.5,IEN,125)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Reason for no radiation....: ",^UTILITY("DIQ1",$J,165.5,IEN,75)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Chemotherapy...............: ",^UTILITY("DIQ1",$J,165.5,IEN,53)," ",^UTILITY("DIQ1",$J,165.5,IEN,53.2)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Hormone therapy............: ",^UTILITY("DIQ1",$J,165.5,IEN,54)," ",^UTILITY("DIQ1",$J,165.5,IEN,54.2)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Immunotherapy..............: ",^UTILITY("DIQ1",$J,165.5,IEN,55)," ",^UTILITY("DIQ1",$J,165.5,IEN,55.2)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Hema Trans/Endocrine Proc..: ",^UTILITY("DIQ1",$J,165.5,IEN,153.1)," ",^UTILITY("DIQ1",$J,165.5,IEN,153)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Other treatment............: ",^UTILITY("DIQ1",$J,165.5,IEN,57)," ",^UTILITY("DIQ1",$J,165.5,IEN,57.2)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Palliative Care............: ",^UTILITY("DIQ1",$J,165.5,IEN,12)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Protocol eligibility status: ",^UTILITY("DIQ1",$J,165.5,IEN,346)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Protocol participation.....: ",^UTILITY("DIQ1",$J,165.5,IEN,560)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . I $D(ONC("SUB",IEN)) D
 . . W !," #",CNT," Subsequent Treatment"
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . W !," -----------------------"
 . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . S SUBIEN=0
 . . F SUBCNT=1:1 S SUBIEN=$O(ONC("SUB",IEN,SUBIEN)) Q:SUBIEN=""  D
 . . . S SUBLET=$E(SUB,SUBCNT)
 . . . S TXT=$G(ONC("SUB",IEN,SUBIEN,.04)) D TXT
 . . . W !," ",SUBLET_"."," Surgery of primary site.: ",$G(ONC("SUB",IEN,SUBIEN,.041))," ",TXT1
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . . W:TXT2'="" !,?41,TXT2
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . . W !,"    Radiation...............: ",$G(ONC("SUB",IEN,SUBIEN,.051))," ",$G(ONC("SUB",IEN,SUBIEN,.05))
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . . W !,"    Chemotherapy............: ",$G(ONC("SUB",IEN,SUBIEN,.061))," ",$G(ONC("SUB",IEN,SUBIEN,.06))
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . . S TXT=$G(ONC("SUB",IEN,SUBIEN,.07)) D TXT
 . . . W !,"    Hormone therapy.........: ",$G(ONC("SUB",IEN,SUBIEN,.071))," ",TXT1
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . . W:TXT2'="" !,?41,TXT2
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . . W !,"    Immunotherapy...........: ",$G(ONC("SUB",IEN,SUBIEN,.081))," ",$G(ONC("SUB",IEN,SUBIEN,.08))
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . . S TXT=$G(ONC("SUB",IEN,SUBIEN,.09)) D TXT
 . . . W !,"    Other Treatment.........: ",$G(ONC("SUB",IEN,SUBIEN,.091))," ",TXT1
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . . W:TXT2'="" !,?41,TXT2
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . . . W !
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Cancer Status..............: ",^UTILITY("DIQ1",$J,165.5,IEN,95)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 I '$D(ONC(160.04)) W ! Q
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W " Follow-up"
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W !," ---------"
 D CKP^GMTSUP Q:$D(GMTSQIT)
 S IEN=0 F CNT=1:1 S IEN=$O(ONC(160.04,IEN)) Q:IEN=""  D
 . Q:ONC(160.04,IEN,.01)'=ONC(160,PTIEN_",",16)
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Last Contact or Death......: ",$G(ONC(160.04,IEN,.01))
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Vital Status...............: ",$G(ONC(160.04,IEN,1))
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !," Following Registry.........: ",$G(ONC(160.04,IEN,10))
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W !
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 W !
 D CKP^GMTSUP Q:$D(GMTSQIT)
 Q
TXT ; Print Formatted Text
 S (TXT1,TXT2)="",LOS=$L($G(TXT)) I LOS<40 S TXT1=$G(TXT) Q
 S NOP=$L($E($G(TXT),1,40)," ")
 S TXT1=$P($G(TXT)," ",1,NOP-1),TXT2=$P($G(TXT)," ",NOP,999)
 Q
