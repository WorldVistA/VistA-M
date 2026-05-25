MAGDHOWE ;WOIFO/PMK/JSJ - Clinical Specialty MWL & HL7 Editor ; Apr 27, 2022@11:43:08
 ;;3.0;IMAGING;**138,231,278,370**;Mar 19, 2002;Build 2
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
 ; Supported IA #2053 reference UPDATE^DIE subroutine call
 ; Supported IA #10013 reference ^DIK subroutine call
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ; Supported IA #2056 reference GETS^DIQ subroutine call
 ; Private IA #7095 to read GMRC PROCEDURE file (#123.3)
 ; Controlled IA #4171 to read REQUEST SERVICES file (#123.5)
 ; Supported IA #10026 reference ^DIR subroutine call
 ;
ENTRY ; entry point from menu
 N CHANGE,CHOICE,CLINIC,CPT,HL7SUBLIST,IEN,IENS,IPROCIDX,ISPECIDX,LOCATION
 N MSG,OPTION,PROCEDURE,PROMPT,SERVICE,QRSCP,X
 N DIERR,IENS,MAGERR,MAGFDA,MAGIENS
 S CHANGE=0 ; use for counting updates
 S (MSG(1),MSG(3))=""
 S MSG(2)="       CLINICAL SPECIALTY DICOM & HL7 file (#2006.5831) Editor"
 W !! D HEADING^MAGDTRDX(.MSG)
 W !!,"Add/Edit a Consult or a Procedure?"
 S OPTION(1)="1:Consult"
 S OPTION(2)="2:Procedure"
 S OPTION(3)="3:Display the existing dictionary"
 S OPTION(4)="4:Quit"
 S PROMPT="Enter an option"
 S X=$$CHOOSE(PROMPT,"",.CHOICE,.OPTION) Q:X<0
 ;
 I CHOICE=4 Q
 D CHOICE G ENTRY
 Q
CHOICE ; option driver
 I CHOICE=3 D WORKLIST^MAGDTRDX W !,"-- End of File --",!! Q
 ;
 I CHOICE=1 D  Q:X<0  ; add a consult (PROCEDURE=0)
 . S X=$$CONSULT(.SERVICE,.PROCEDURE)
 . Q
 E  D  Q:X<0  ; add a procedure within a service
 . S X=$$PROC(.PROCEDURE,.SERVICE)
 . Q
 S IEN=$$IREQUEST^MAGDHOW1(+SERVICE,+PROCEDURE)
 I IEN D  Q
 . W !!,"An entry for the "
 . I PROCEDURE="" W $P(SERVICE,"^",2)," consult"
 . E  D
 . . W $P(PROCEDURE,"^",2)," procedure"
 . . W !,"for the ",$P(SERVICE,"^",2)," service"
 . . Q
 . W !,"is already on file."
 . D UPDATE(IEN)
 . Q
 ;
 S X=$$ISPECIDX(.ISPECIDX) Q:X<0
 S X=$$IPROCIDX(.IPROCIDX) Q:X<0
 S X=$$LOCATION(.LOCATION) Q:X<0
 S X=$$CPT(.CPT) Q:X<0
 S X=$$HL7SUBL(.HL7SUBLIST) Q:X<0
 S X=$$QRSCP(.QRSCP) Q:X<0
 S X=$$CLINIC(.CLINIC) Q:X<0
 ;
 D DISPLAY
 ;
 W !!
 S X=$$YESNO("Create this entry","n",.CHOICE) Q:X<-1
 I CHOICE'="YES" W " -- entry not created" Q
 ;
 ; create the entry
 S IENS="+1,"
 S MAGFDA(2006.5831,IENS,.01)=$P(SERVICE,"^",1)    ; REQUEST SERVICE (-> 123.5)
 S MAGFDA(2006.5831,IENS,2)=$P(PROCEDURE,"^",1)    ; PROCEDURE (-> 123.3)
 S MAGFDA(2006.5831,IENS,3)=$P(ISPECIDX,"^",1)     ; SPECIALTY INDEX (-> 2005.84)
 S MAGFDA(2006.5831,IENS,4)=$P(IPROCIDX,"^",1)     ; PROCEDURE INDEX (-> 2005.85)
 S MAGFDA(2006.5831,IENS,5)=$P(LOCATION,"^",1)     ; LOCATION (-> 4) 
 S MAGFDA(2006.5831,IENS,6)=$P(CPT,"^",1)          ; CPT (-> 81)
 S MAGFDA(2006.5831,IENS,7)=$P(HL7SUBLIST,"^",1)   ; HL7 HL0 SUBSCRIBER LIST (-> 779.4)
 S MAGFDA(2006.5831,IENS,8)=$P(QRSCP,"^",1)        ; Query/Retrieve Provider
 D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
 I $D(DIERR) W !!,"*** Entry NOT Created ***" Q
 E  W " -- entry created"
 S IEN=MAGIENS(1)
 ; output the CLINIC
 S I=0 F  S I=$O(CLINIC(I)) Q:'I  D
  . N DIERR,MAGERR,MAGFDA,MAGIENS
  . S MAGFDA(2006.58311,"+1,"_IEN_",",.01)=$P(CLINIC(I),"^",1)
  . D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
  . Q
 ;
 Q
 ;
UPDATE(IEN) ; delete or update the consult or procedure
 N CLINIC,CPT,HL7SUBLIST,I,IPROCIDX,ISPECIDX,LOCATION,PROCEDURE,SERVICE,X
 S X=^MAG(2006.5831,IEN,0)
 S SERVICE=$P(X,"^",1),PROCEDURE=$P(X,"^",2)
 S SERVICE=SERVICE_"^"_$$GET1^DIQ(123.5,SERVICE,.01)
 S PROCEDURE=PROCEDURE_"^"_$$GET1^DIQ(123.3,PROCEDURE,.01)
 S ISPECIDX=$$GETVALUE(2005.84,$P(X,"^",3),".01;3")
 S IPROCIDX=$$GETVALUE(2005.85,$P(X,"^",4),".01;3")
 S LOCATION=$$GETVALUE(4,$P(X,"^",5),".01;99")
 S CPT=$$GETVALUE(81,$P(X,"^",6),".01;2")
 S HL7SUBLIST=$$GETVALUE(779.4,$P(X,"^",7),".01")
 S QRSCP=$P(X,"^",8),QRSCP=QRSCP_"^"_QRSCP ; ien same as name
 S I=0 F  S I=$O(^MAG(2006.5831,IEN,1,I)) Q:'I  D
 . S CLINIC(I)=$$GETVALUE(44,^MAG(2006.5831,IEN,1,I,0),".01")
 . Q
 D DISPLAY
 ;
 S X=$$YESNO("Change this entry","n",.CHOICE) Q:X<-1
 I CHOICE'="YES" W " -- entry not changed" Q
 W !
 S X=$$YESNO("Delete the entire entry","n",.CHOICE) Q:X<-1
 I CHOICE="YES" D  Q  ; delete the entire entry
 . N DA,DIK
 . S DIK="^MAG(2006.5831,",DA=IEN
 . D ^DIK
 . W " -- entry deleted"
 . Q
 W " -- entry not deleted"
 ;
 D UPDATE1 ; update the entry
 Q
 ;
UPDATE1 ; update a the consult or procedure
 N DIERR,IENS,MAGERR,MAGFDA,MAGIENS,X
 ;
 S X=$$ISPECIDX(.ISPECIDX) Q:X<0
 S X=$$IPROCIDX(.IPROCIDX) Q:X<0
 S X=$$LOCATION(.LOCATION) Q:X<0
 S X=$$CPT(.CPT) Q:X<0
 S X=$$HL7SUBL(.HL7SUBLIST) Q:X<0
 S X=$$QRSCP(.QRSCP) Q:X<0
 S X=$$CLINIC(.CLINIC) Q:X<0
 ;
 I CHANGE=0 W !!,"No changes" Q
 ;
 D DISPLAY
 ;
 W !
 S X=$$YESNO("Update this entry","n",.CHOICE) Q:X<-1
 I CHOICE'="YES" W " -- entry not updated" Q
 ;
 ; update the entry
 S IENS=IEN_","
 S MAGFDA(2006.5831,IENS,3)=$P(ISPECIDX,"^",1)     ; SPECIALTY INDEX (-> 2005.84)
 S MAGFDA(2006.5831,IENS,4)=$P(IPROCIDX,"^",1)     ; PROCEDURE INDEX (-> 2005.85)
 S MAGFDA(2006.5831,IENS,5)=$P(LOCATION,"^",1)     ; LOCATION (-> 4) 
 S MAGFDA(2006.5831,IENS,6)=$P(CPT,"^",1)          ; CPT (-> 81)
 S MAGFDA(2006.5831,IENS,7)=$P(HL7SUBLIST,"^",1)   ; HL7 HL0 SUBSCRIBER LIST (-> 779.4)
 S MAGFDA(2006.5831,IENS,8)=$P(QRSCP,"^",1)        ; Query/Retrieve Provider
 D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
 I $D(DIERR) W !!,"*** Entry NOT Updated ***"
 E  W !!,"Entry Updated"
 ;
 ; update the CLINIC
 S I=0 F  S I=$O(^MAG(2006.5831,IEN,1,I)) Q:'I  D
 . N DIK,DA ; delete the old CLINIC
 . S DA(1)=IEN,DA=I,DIK="^MAG(2006.5831,"_DA(1)_",1," D ^DIK
 . Q
 S I=0 F  S I=$O(CLINIC(I)) Q:'I  D
  . N DIERR,MAGERR,MAGFDA,MAGIENS
  . S MAGFDA(2006.58311,"+1,"_IEN_",",.01)=$P(CLINIC(I),"^",1)
  . D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
  . Q
 Q
 ;
CONSULT(SERVICE,PROCEDURE) ;
 S PROCEDURE=""
 Q $$LOOKUP(.SERVICE,"Request Service",123.5,".01",1)
 ;
PROC(PROCEDURE,SERVICE) ;
 N A,CHOICE,I,J,OPTION,OPTIONIEN,X
 S X=$$LOOKUP(.PROCEDURE,"Procedure",123.3,".01",1)
 I X<0 Q X  ; lookup failed
 D GETS^DIQ(123.3,+PROCEDURE,"**","EI","A")
 S I="" F J=1:1 S I=$O(A(123.32,I)) Q:I=""  D
 . S OPTION(J)=J_":"_A(123.32,I,.01,"E")
 . S OPTIONIEN(J)=A(123.32,I,.01,"I")
 . Q
 S I=$O(OPTION(""))
 I I="" D  Q -1
 . W !,"No RELATED SERVICE on file"
 I $O(OPTION(I))="" D
 . S SERVICE=OPTIONIEN(I)_"^"_$P(OPTION(I),":",2)
 . W !,"Request Service: ",$P(OPTION(I),":",2)
 . Q
 E  D
 . S PROMPT="Select the Request Service from the list"
 . S X=$$CHOOSE(PROMPT,"",.CHOICE,.OPTION) Q:X<0
 . S SERVICE=OPTIONIEN(CHOICE)_"^"_$P(OPTION(CHOICE),":",2)
 . Q
 Q X
 ;
ISPECIDX(ISPECIDX) ;
 Q $$LOOKUP(.ISPECIDX,"Imaging Specialty Index",2005.84,".01;3",1)
 ;
IPROCIDX(IPROCIDX) ;
 Q $$LOOKUP(.IPROCIDX,"Imaging Procedure Index",2005.85,".01;3",0)
 ;
LOCATION(LOCATION) ;
 Q $$LOOKUP(.LOCATION,"Acquisition Institution",4,"99;.01",1)
 ;
HL7SUBL(HL7SUBLIST) ;
 Q $$LOOKUP(.HL7SUBLIST,"HL7 (Optimized) Subscription List",779.4,".01",0)
 ;
QRSCP(QRSCP) ;
 Q $$LOOKUP(.QRSCP,"Query/Retrieve Provider",2006.587,,0)
 ;
CPT(CPT) ;
 I $G(CPT)="",+PROCEDURE D  ; lookup CPT in Medicine Package
 . N A,MCAR6972 ; PROCEDURE/SUBSPECIALTY file (#697.2)
 . S MCAR6972=$$GET1^DIQ(123.3,+PROCEDURE,.05,"I")
 . I MCAR6972 D
 . . D GETS^DIQ(697.2,MCAR6972,"**","I","A")
 . . Q:'$D(A(697.21,"1,2,",.01,"I"))  ; no CPT code
 . . S CPT=A(697.21,"1,2,",.01,"I") ; get first CPT code
 . . S CPT=CPT_"^"_$$GET1^DIQ(81,+CPT,.01) ; CPT code
 . . S CPT=CPT_"^"_$$GET1^DIQ(81,+CPT,2) ; CPT name
 . . Q
 . Q
 Q $$LOOKUP(.CPT,"CPT Code",81,".01;2",0)
 ;
CLINIC(CLINIC) ;
 N DONE,I,J,TMP,X
 S J=0
 W !
 I $D(CLINIC) D
 . S I=0 F  S I=$O(CLINIC(I)) Q:'I  D
 . . S DONE=0 F  D  Q:DONE
 . . . W !,"Clinic: ",$$P(CLINIC(I))," ",$TR($J("",40-$X)," ","-")," Remove this clinic? n// "
 . . . R X:DTIME E  S X="^"
 . . . I X["^" S DONE=-1,I=99999 Q 
 . . . I X="" S X="NO" W X
 . . . I "YyNn"'[$E(X) W !,"Enter YES to keep the clinic or NO to remove it." Q
 . . . I "Yy"[$E(X) W " -- removed" S CHANGE=CHANGE+1
 . . . E  S J=J+1,TMP(CLINIC(I))=""
 . . . S DONE=1
 . . . Q
 . . Q
 . W !
 . Q
 F I=J+1:1 D  Q:X<1
 . N NEWCLINIC
 . S X=$$LOOKUP(.NEWCLINIC,"Clinic #"_I,44,".01",0) Q:X<1
 . I $D(TMP(NEWCLINIC)) W " -- already there" S I=I-1 Q
 . S TMP(NEWCLINIC)="",CHANGE=CHANGE+1
 . Q
 K CLINIC ; remove any duplicates
 S (I,J)=0 F  S I=$O(TMP(I)) Q:'I  S J=J+1,CLINIC(J)=I
 Q 1
 ;
LOOKUP(ITEM,NAME,FILE,FIELDS,REQUIRED) ; lookup entry
 N A,DIR,DONE,I,RETURN,TMP,X,Y,DTOUT  ;P278 JSJ add TMP
 ;
 S DONE=0
 ;
 I $D(ITEM) D  Q:DONE DONE
 . W !!,NAME,": ",$$P(ITEM)
 . S X=$$YESNO("Change this value","n",.CHOICE) Q:X<-1
 . I CHOICE'="YES" S DONE=1 Q
 . S CHANGE=CHANGE+1
 . Q
 ;
 I FILE=2006.587 D  Q RETURN ; special code for Query/Retrieve Provider
 . N DEFAULT
 . S DEFAULT=$P($G(ITEM),"^",2)
 . I DEFAULT'="" D
 . . S X=$$YESNO("Delete the Query/Retrieve Provider","n",.CHOICE) Q:X<-1
 . . I CHOICE="YES" S ITEM="",RETURN=1,DONE=1
 . . Q
 . E  D
 . . S X=$$YESNO("Specify a Query/Retrieve Provider","n",.CHOICE) Q:X<-1
 . . I CHOICE'="YES" S ITEM="",RETURN=1,DONE=1
 . . Q
 . I DONE Q  ; don't want a Query/Retrieve Provider
 . W !
 . S ITEM=$$PICKSCP^MAGDSTQ9(DEFAULT,"Q/R")
 . I ITEM="" S RETURN=-1 Q
 . S ITEM=ITEM_"^"_ITEM,RETURN=1
 . Q
 ;
 S DIR("A")="Enter the "_NAME ; prompt
 S DIR("B")=$P($G(ITEM),"^",2) I DIR("B")="" K DIR("B") ; default
 S $P(DIR(0),"^",1)=$S(REQUIRED:"P",1:"PO")
 S $P(DIR(0),"^",2)=FILE_":EMZ"
 I FILE="2005.85" D BLDPXLST   ;P278 - for procedure list, only display/allow procedures linked to the selected specialty
 D ^DIR
 I $G(DTOUT) Q -1  ;P278 JSJ handle timeout to prevent passing through required field
 I Y="^" Q -1
 I Y="^^" Q -2
 I Y=-1!(Y="") S ITEM="" Q 0  ;P370 GEF
 I FILE="2005.85",Y]"" S Y=$G(TMP(Y),-999)  ;P278 JSJ
 S ITEM=$$GETVALUE(FILE,+Y,FIELDS)
 Q 1
 ;
GETVALUE(FILE,IEN,FIELDS) ;
 N I,VALUE
 S VALUE=IEN
 F I=1:1:$L(FIELDS,";") D
 . S VALUE=VALUE_"^"_$$GET1^DIQ(FILE,IEN,$P(FIELDS,";",I))
 . Q
 Q VALUE
 ;
BLDPXLST ;build alpha sorted procedure list filtered by specialty ;P278 added sub
 NEW J,LLIST,NAME
 S $P(DIR(0),"^",1)=$S(REQUIRED:"SA",1:"SAO")  ;change to 'set of codes'
 S DIR("A")=DIR("A")_": "  ;keep colon at end of prompt
 K DIR("L"),TMP
 S DIR("L")=""
 S NAME="",J=0
 S LLIST=""
 F  S NAME=$O(^MAG(2005.85,"B",NAME)) Q:NAME=""  D
 . N NONE,ND0,OK,SPEC,FOUND S FOUND=0,OK="",SPEC=0
 . Q:'$G(ISPECIDX)
 . S SPEC=+ISPECIDX D SPEC^MAGSIXGT
 . S IEN=$O(^MAG(2005.85,"B",NAME,""),-1) Q:'IEN
 . I $O(^MAG(2005.85,IEN,1,"B",""))="" S FOUND=2
 . I 'FOUND N SPECX S (FOUND,SPECX)=0 D  Q:'FOUND
 .. F  S SPECX=$O(OK(3,SPECX)) Q:'SPECX!FOUND  I $D(^MAG(2005.85,IEN,1,"B",SPECX)) S FOUND=1
 . Q:'FOUND
 . S ND0=$G(^MAG(2005.85,IEN,0)) Q:$P(ND0,"^",3)="I"
 . S J=J+1
 . S DIR("L",J)="   "_J_" "_NAME
 . S $P(LLIST,";",J)=J_":"_NAME
 . S TMP(J)=IEN
 S $P(DIR(0),"^",2)=LLIST
 Q
 ;
DISPLAY ; Display data
 N I,X
 W !
 W !,"        Request Service = ",$$P(SERVICE)
 W !,"              Procedure = ",$$P(PROCEDURE)
 W !,"        Specialty Index = ",$$P(ISPECIDX)
 W !,"        Procedure Index = ",$$P(IPROCIDX)
 W !,"               Worklist = ",$P(ISPECIDX,"^",3)
 I IPROCIDX W "/",$P(IPROCIDX,"^",3)
 W " (",$P(ISPECIDX,"^",2)
 I IPROCIDX W "/",$P(IPROCIDX,"^",2)
 W ")"
 W !,"            Acquired at = ",$$P(LOCATION)
 W !,"               CPT Code = ",$$P(CPT)
 W !,"    HL7 Subscriber List = ",$$P(HL7SUBLIST)
 W !,"Query/Retrieve Provider = ",$$P(QRSCP)
 S I=0 F  S I=$O(CLINIC(I)) Q:'I  D
 . W !,"                 Clinic = ",$$P(CLINIC(I))
 . Q
 W !
 ; output Associated Stop Code(s) if any
 D GETS^DIQ(123.5,+SERVICE,"**","E","X")
 I $D(X(123.5688)) D
 . S I="" F  S I=$O(X(123.5688,I)) Q:I=""  D
 . . W !,"Associated Stop Code = ",X(123.5688,I,.01,"E")
 . . Q
 . Q
 E  D
 . W !,"Warning: No Associated Stop Codes are defined for this Request Service."
 . W !,"         Use CONSULT ASSOCIATED STOP CODE menu option to define them."
 W !
 Q
 ;
P(X) ;
 N Z
 S Z=$P(X,"^",2)
 I $P(X,"^",3)'="" S Z=Z_" -- "_$P(X,"^",3)
 Q Z
 ;
YESNO(PROMPT,DEFAULT,CHOICE) ; generic YES/NO question driver
 N DIR,DIRUT,DIROUT,X,Y
 S DIR(0)="Y" S DIR("A")=PROMPT M DIR("A")=PROMPT
 I $G(DEFAULT)'="" S DIR("B")=DEFAULT
 D ^DIR
 I $D(DIROUT) Q -2
 I $D(DIRUT) Q -1
 S CHOICE=Y(0)
 Q 1
 ;
CHOOSE(PROMPT,DEFAULT,CHOICE,OPTION) ; generic question driver
 N DIR,DIRUT,DIROUT,I,X,Y
 S DIR(0)="S^",I=0
 F  S I=$O(OPTION(I)) Q:'I  D
 . S DIR(0)=DIR(0)_$S(I>1:";",1:"")_OPTION(I)
 . Q
 S DIR("A")=PROMPT
 I $G(DEFAULT)'="" S DIR("B")=DEFAULT
 D ^DIR
 I $D(DIROUT) Q -2
 I $D(DIRUT) Q -1
 S CHOICE=Y
 Q 1
