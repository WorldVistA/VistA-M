GMTSRAE ; SLC/JER,KER HIN/GJC Selected Radiology Extract ; 04/19/2002
 ;;2.7;Health Summary;**14,25,30,37,40,47,49,51,84**;Oct 20, 1995;Build 6
 ;
 ; External References
 ;   DBIA  3125  ^RADPT( file 70
 ;   DBIA   501  ^RARPT( file 74, fields 5, 200, 300 and 400
 ;   DBIA  3417  ^RA(72, file 72, field 3 pending
 ;   DBIA   502  ^RAMIS(71, file 71, field 9
 ;   DBIA 10015  EN^DIQ1
 ;   DBIA  2056  $$GET1^DIQ (files 71, 72, and 74)
 ;   DBIA  2056  GETS^DIQ (file 70, subfile 70.03)
 ;   DBIA  1995  $$CPT^ICPTCOD
 ;   DBIA 10103  $$DT^XLFDT
 ;   DBIA 10104  $$UP^XLFSTR
 ;   DBIA  1996  $$MOD^ICPTMOD
 ;   DBIA 10011  ^DIWP
 ;                        
MAINSEL(MODE,TEST) ; Entry for Selection Items
 N GMTSIDT,GMTSIDT2,GMTSCNT,GMTSPN,GMTSMAX K ^TMP("RAE",$J) S GMTSCNT=0,GMTSMAX=$S(+$G(GMTSNDM)>0:GMTSNDM,1:999)
 S GMTSIDT=+GMTS1,GMTSIDT2=+($P(+GMTS2,".",1))_".999999"
 S:+($G(GMTSPXGO))=0 GMTSIDT=$P(GMTS1,".",1),GMTSIDT2=$P(GMTS2,".",1)_".999999"
 F  S GMTSIDT=$O(^RADPT(DFN,"DT","AP",TEST,GMTSIDT)) Q:GMTSIDT'>0!(GMTSIDT>GMTSIDT2)!(GMTSCNT=GMTSMAX)  D
 . Q:'$D(^RADPT(DFN,"DT",GMTSIDT,0))  N GMTS7002,GMTSPSET,GMTSXSET
 . S GMTS7002=$G(^RADPT(DFN,"DT",GMTSIDT,0))
 . S GMTSXSET=+$P(GMTS7002,"^",5)
 . S GMTSPN=0 F  S GMTSPN=$O(^RADPT(DFN,"DT","AP",TEST,GMTSIDT,GMTSPN)) Q:GMTSPN'>0!(GMTSCNT=GMTSMAX)  D
 . . S GMTSCNT=GMTSCNT+1 D GET
 Q
MAIN(MODE) ; Main Entry
 N GMTSIDT,GMTSCNT,GMTSPN,GMTSMAX
 K ^TMP("RAE",$J) S GMTSCNT=0,GMTSMAX=$S(+$G(GMTSNDM)>0:GMTSNDM,1:999)
 S GMTSIDT=+GMTS1,GMTSIDT2=+($P(+GMTS2,".",1))_".999999"
 S:+($G(GMTSPXGO))=0 GMTSIDT=$P(GMTS1,".",1),GMTSIDT2=$P(GMTS2,".",1)_".999999"
 F  S GMTSIDT=$O(^RADPT(DFN,"DT",GMTSIDT)) Q:GMTSIDT'>0!(GMTSIDT>GMTSIDT2)!(GMTSCNT=GMTSMAX)  D
 . Q:'$D(^RADPT(DFN,"DT",GMTSIDT,0))  N GMTS7002,GMTSPSET,GMTSXSET
 . S GMTS7002=$G(^RADPT(DFN,"DT",GMTSIDT,0))
 . S GMTSXSET=+$P(GMTS7002,"^",5)
 . S GMTSPN=0 F  S GMTSPN=$O(^RADPT(DFN,"DT",GMTSIDT,"P",GMTSPN)) Q:GMTSPN'>0!(+GMTSCNT'<GMTSMAX)  D
 . . S GMTSCNT=GMTSCNT+1 D GET
 Q
 ;                   
GET ; Gets data associated with study and sets global array
 ; ^TMP("RAE",$J, where:
 ;           
 ;    GMTSIDT = inverse exam date/time
 ;    GMTSPN  = Case IEN
 ;           
 ; ^TMP("RAE",$J,GMTSIDT,GMTSPN,0)= <exam date> ^ 
 ; <procedure> ^ <exam status> ^ <report status> ^ 
 ; <prim interpret resident> ^ <prim interpret staff> ^
 ; <CPT code> ^ <technologist> ^ <case number> ^
 ; < exam status order >
 ;           
 ; ^TMP("RAE",$J,GMTSIDT,"EXAMSET") Indicates if all 
 ; exams for this date/time are part of an exam set
 ;           
 ; ^TMP("RAE",$J,GMTSIDT,"PRINTSET") Indicates if all 
 ; exams for this exam set share the same report
 ;           
 ; Only if the report is verified -OR- released will 
 ; these nodes be set
 ;                  
 ; ^TMP("RAE",$J,IDT,PN,"D",seq #) = Dx codes
 ;     Sequence # = 1   Primary Dx
 ;     Sequence # > 1   Secondary Dx
 ; ^TMP("RAE",$J,IDT,PN,"H",line #)= Clinical History line #
 ; ^TMP("RAE",$J,IDT,PN,"S",line #)= Reason for Study line #
 ; ^TMP("RAE",$J,IDT,PN,"I",line #)= Impression Text line #
 ; ^TMP("RAE",$J,IDT,PN,"R",line #)= Report Text line #
 ;           
 N DA,DIC,DIQ,%,D0,DIW,DIWI,DIWT,DIWTC,DIWX,DIWF,DIWL,DIWR,DN,DR
 N I,J,Y,Z,GMTSCPT,GMTSED,GMTSCN,GMTSRP,GMTSRPI,GMTSST,GMTSPTR
 N GMTSTA,GMTSTAI,GMTSI,GMTSRAD,GMTSRRAD,GMTSSRAD,GMTSTC,GMTSSTO
 N GMTSIMGO,GMTSRA27 S GMTSRA27=$$PROK^GMTSU("RAUTL9",27)
 S GMTSED=+$P(GMTS7002,"^")
 S:GMTSXSET&('$D(^TMP("RAE",$J,GMTSIDT,"EXAMSET"))) ^TMP("RAE",$J,GMTSIDT,"EXAMSET")=""
 ;   Get
 ;     Exam Date    $P($G(^RADPT(DFN,"DT",GMTSIDT,0)),"^",1)
 ;     Exam Set     $P($G(^RADPT(DFN,"DT",GMTSIDT,0)),"^",5)
 ;     Case Number             70.03   .01   GMTSCN
 ;     Procedure               70.03    2    GMTSRP/GMTSRPI
 ;     Exam Status             70.03    3    GMTSST
 ;     Imaging Order           70.03   11    GMTSIMGO
 ;     Prim Interpret Resident 70.03   12    GMTSRRAD
 ;     Prim Diagnostic Code    70.03   13    GMTSDX
 ;     Prim Interpreting Staff 70.03   15    GMTSSRAD
 ;     Report Text             70.03   17    
 ;     Member of Set           70.03   25
 ;     Exam Status Order       72       3    GMTSSTO
 ;           
 S DIC="^RADPT("_DFN_",""DT"","_GMTSIDT_",""P"",",DA=GMTSPN,DIQ="GMTSRAD("
 S DIQ(0)="IE",DR=".01;2;3;11;12;13;15;17;25" D TECH
 D EN^DIQ1
 S GMTSCN=$G(GMTSRAD(70.03,GMTSPN,.01,"E"))
 S GMTSRP=$G(GMTSRAD(70.03,GMTSPN,2,"E"))
 S GMTSRPI=$G(GMTSRAD(70.03,GMTSPN,2,"I"))
 S GMTSST=$G(GMTSRAD(70.03,GMTSPN,3,"E"))
 S GMTSSTO=$G(GMTSRAD(70.03,GMTSPN,3,"I"))
 S GMTSSTO=$$GET1^DIQ(72,+GMTSSTO,3,"I")
 S GMTSIMGO=$G(GMTSRAD(70.03,GMTSPN,11,"I"))  ;Img Order # IEN
 I GMTSTC S GMTSTC(0)=$E($G(GMTSRAD(70.12,GMTSTC,.01,"E")),1,18)
 S GMTSRRAD=$E($G(GMTSRAD(70.03,GMTSPN,12,"E")),1,18)
 S GMTSSRAD=$E($G(GMTSRAD(70.03,GMTSPN,15,"E")),1,18)
 S GMTSPTR=$G(GMTSRAD(70.03,GMTSPN,17,"I"))
 ; Exam Set/Report
 ;           
 ;     If GMTSPSET = ""   single exam
 ;     If GMTSPSET = 1    exam set, single report
 ;     If GMTSPSET = 2    exam set, combined report
 ;           
 S GMTSPSET=$G(GMTSRAD(70.03,GMTSPN,25,"I"))
 D PMOD,CMOD I +GMTSPTR>0 S DIC="^RARPT(",DA=GMTSPTR,DIQ="GMTSRAD(",DIQ(0)="IE",DR="5" D EN^DIQ1
 S GMTSTA=$G(GMTSRAD(74,+GMTSPTR,5,"E"))
 S GMTSTAI=$G(GMTSRAD(74,+GMTSPTR,5,"I"))
 I $L(GMTSTAI),("VR"[$E(GMTSTAI)) D GETDX(GMTSPN_","_GMTSIDT_","_DFN_",")
 S GMTSCPT=$$GET1^DIQ(71,+GMTSRPI,9,"I")
 S GMTSCPT=$S(+GMTSCPT>0:$P($$CPT^ICPTCOD(+GMTSCPT),"^",2),1:"")
 S ^TMP("RAE",$J,GMTSIDT,GMTSPN,0)=GMTSED_U_GMTSRP_U_GMTSST_U_GMTSTA_U_GMTSRRAD_U_GMTSSRAD_U_GMTSCPT_U_$G(GMTSTC(0))_U_GMTSCN_U_$G(GMTSSTO)
 S GMTSI=0 F  S GMTSI=$O(GMTSRAD(70.1,GMTSI)) Q:+GMTSI'>0  D
 . S ^TMP("RAE",$J,GMTSIDT,GMTSPN,"M",GMTSI)=$G(GMTSRAD(70.1,GMTSI,.01,"E"))
 S GMTSI=0 F  S GMTSI=$O(GMTSRAD(70.1,GMTSI)) Q:+GMTSI'>0  D
 . S ^TMP("RAE",$J,GMTSIDT,GMTSPN,"M",GMTSI)=$G(GMTSRAD(70.1,GMTSI,.01,"E"))
 S GMTSI=0 F  S GMTSI=$O(GMTSRAD(70.3135,GMTSI)) Q:+GMTSI'>0  D
 . Q:'$L($G(GMTSRAD(70.3135,GMTSI,.01,"M")))  Q:'$L($G(GMTSRAD(70.3135,GMTSI,.01,"N")))  N I S I=+($G(^TMP("RAE",$J,GMTSIDT,GMTSPN,"CM",0)))+1
 . S ^TMP("RAE",$J,GMTSIDT,GMTSPN,"CM",I)=$G(GMTSRAD(70.3135,GMTSI,.01,"M"))_"^"_$$UP^XLFSTR($G(GMTSRAD(70.3135,GMTSI,.01,"N")))_"^"_$G(GMTSRAD(70.3135,GMTSI,.01,"N")),^TMP("RAE",$J,GMTSIDT,GMTSPN,"CM",0)=I
 ;   Only verified reports can be printed
 I GMTSTAI'="V",($E(IOST)="P") D  Q
 . S:GMTSPSET=2 ^TMP("RAE",$J,GMTSIDT,"PRINTSET")=""
 ;   Only verified & Released/Unverified can viewed
 I $S(GMTSTAI="V":0,GMTSTAI="R":0,1:1) D  Q
 . S:GMTSPSET=2 ^TMP("RAE",$J,GMTSIDT,"PRINTSET")=""
 Q:$D(^TMP("RAE",$J,GMTSIDT,"PRINTSET"))
 D GETIMP D:$G(MODE)=2 GETHIS^GMTSRAE1,GETR4S^GMTSRAE1,GETADD,GETREP
 S:GMTSPSET=2 ^TMP("RAE",$J,GMTSIDT,"PRINTSET")=""
 Q
 ;           
GETIMP ; Gets Radiologist's Impression
 N X,GMTSLN S X=$$GET1^DIQ(74,GMTSPTR,300,,"GMTST")
 K ^UTILITY($J,"W") N X,GMTSI S GMTSI=0 F  S GMTSI=$O(GMTST(GMTSI)) Q:+GMTSI=0  S X=$G(GMTST(GMTSI)) D FORMAT
 I $D(^UTILITY($J,"W")) F GMTSLN=1:1:^UTILITY($J,"W",3) S ^TMP("RAE",$J,GMTSIDT,GMTSPN,"I",GMTSLN)=^UTILITY($J,"W",3,GMTSLN,0)
 K ^UTILITY($J,"W"),GMTST
 Q
GETADD ; Gets Additional Clinical History (#74)
 Q:+($G(GMTSRA27))'>0  N X,GMTSLN S X=$$GET1^DIQ(74,GMTSPTR,400,,"GMTST")
 K ^UTILITY($J,"W") N X,GMTSI S GMTSI=0 F  S GMTSI=$O(GMTST(GMTSI)) Q:+GMTSI=0  S X=$G(GMTST(GMTSI)) D FORMAT
 I $D(^UTILITY($J,"W")) F GMTSLN=1:1:^UTILITY($J,"W",3) D
 . S ^TMP("RAE",$J,GMTSIDT,GMTSPN,"A",GMTSLN)=^UTILITY($J,"W",3,GMTSLN,0)
 K ^UTILITY($J,"W"),GMTST
 Q
GETREP ; Gets Radiologist's Report
 N X,GMTSLN S X=$$GET1^DIQ(74,GMTSPTR,200,,"GMTST")
 K ^UTILITY($J,"W") N X,I S GMTSI=0 F  S GMTSI=$O(GMTST(GMTSI)) Q:+GMTSI=0  S X=$G(GMTST(GMTSI)) D FORMAT
 I $D(^UTILITY($J,"W")) F GMTSLN=1:1:^UTILITY($J,"W",3) S ^TMP("RAE",$J,GMTSIDT,GMTSPN,"R",GMTSLN)=^UTILITY($J,"W",3,GMTSLN,0)
 K ^UTILITY($J,"W"),GMTST
 Q
PMOD ; Procedure Modifiers
 N GMTS,GMTSI S GMTS=$G(DIC) Q:'$L(DIC)  S GMTSI=+($G(DA)) Q:+GMTSI=0
 N DIC,DA,DR S DIC=GMTS_GMTSI_",""M"","
 S DA=0 F  S DA=$O(@(DIC_DA_")")) Q:+DA'>0  S DR=".01" D
 . D EN^DIQ1
 Q
CMOD ; CPT Modifiers
 N GMTS,GMTSI,GMTSC,GMTSCM,GMTSCN S GMTS=$G(DIC) Q:'$L(DIC)  S GMTSI=+($G(DA)) Q:+GMTSI=0
 S DT=$$DT^XLFDT,U="^" N DIC,DA,DR S DIC=GMTS_GMTSI_",""CMOD"","
 S DA=0 F  S DA=$O(@(DIC_DA_")")) Q:+DA'>0  S DR=".01" D EN^DIQ1
 S GMTSI=0 F  S GMTSI=$O(GMTSRAD(70.3135,GMTSI)) Q:+GMTSI=0  D
 . S GMTSC=$G(GMTSRAD(70.3135,GMTSI,.01,"I")) Q:+GMTSC=0
 . S GMTSCM=$$MOD^ICPTMOD(GMTSC,"I",)
 . S GMTSCN=$P(GMTSCM,"^",3),GMTSCM=$P(GMTSCM,"^",2)
 . S GMTSRAD(70.3135,GMTSI,.01,"M")=GMTSCM
 . S GMTSRAD(70.3135,GMTSI,.01,"N")=$$EN2^GMTSUMX(GMTSCN)
 Q
TECH ; Technician
 S GMTSTC=+$O(^RADPT(DFN,"DT",GMTSIDT,"P",GMTSPN,"TC",0))
 I GMTSTC S DR=$G(DR)_";175",DR(70.12)=.01,DA(70.12)=GMTSTC F  Q:$E(DR,1)'=";"  S DR=$E(DR,2,$L(DR))
 Q
FORMAT ; Calls ^DIWP to format each line of text
 N DIWL,DIWR,DIWF S DIWL=3,DIWR=($S(MODE=1:76,1:80))
 D ^DIWP Q
 ;               
GETDX(GMTSIEN) ; Set the data node with diagnostic code info.
 ;              
 ; Input:  GMTSIEN = Case IEN_","_exam date_","_DFN_","
 ; Output: ^TMP("RAE",$J,GMTSIDT,GMTSPN,"D",seq #) = Dx codes
 ;           
 ; Sequence # = 1   Primary Dx
 ; Sequence # > 1   Secondary Dx
 S ^TMP("RAE",$J,$P(GMTSIEN,",",2),$P(GMTSIEN,","),"D",1)=$G(GMTSRAD(70.03,$P(GMTSIEN,","),13,"E"))
 N GMTSI,GMTSII,GMTSDX S GMTSI=1 D GETS^DIQ(70.03,GMTSIEN,"13.1*","E","GMTSDX")
 S GMTSII="" F  S GMTSII=$O(GMTSDX(70.14,GMTSII)) Q:GMTSII=""  D
 . S GMTSI=GMTSI+1 S ^TMP("RAE",$J,$P(GMTSIEN,",",2),$P(GMTSIEN,","),"D",GMTSI)=$G(GMTSDX(70.14,GMTSII,.01,"E"))
 Q
