IBTRH5D ;ALB/FA - HCSR Create 278 Request ;12-AUG-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ; Contains Functions used in creating a 278 request from a
 ; selected entry in the HCSR Response worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ; SELAPI       - Allows the user to see a quick view of the currently entered
 ;                Additional Patient Information lines and either pick one to 
 ;                edit, enter a new one or skip.
 ; SELDX        - Allows the user to see a quick view of the currently entered
 ;                Diagnoses and either pick one to edit, enter a new one or
 ;                skip.
 ; SELPD        - Allows the user to see a quick view of the currently entered
 ;                Patient Event Provider Data Lines and either pick one to 
 ;                edit, enter a new one or skip.
 ;-----------------------------------------------------------------------------
 ;
SELAPI(IBTRIEN) ;EP
 ; Called from within Input template IB CREATE 278 REQUEST
 ; Provides the user with a quick view of currently entered Additional Patient
 ; Information multiples and allows them to select one to edit or enter a new 
 ; one.
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ; Returns: Value of the .01 field of the multiple to edit
 ;          "" if creating a new multiple, -2 to exit template
 ;          IBNEW - 1 if creating a new entry
 N AIDATA,CNT,ENTNUM,FDA,IEN,H1,H2,L1,L2,MAX,RETIEN,RTYPE,SECT,X,XX,Y,YY
 S IBNEW=0,SECT="Additional Patient Information"
 ;
 ; First check for an empty Additional Patient Information Line to delete
 D DELAPI(IBTRIEN)
 ;
 ; Next create an array of all current Additional Patient Information lines to
 ; display
 S XX=+$P($G(^IBT(356.22,IBTRIEN,11,0)),"^",4)  ; Total # of API Lines
 S MAX=$S(XX<10:"",1:"Additional Patient Information Lines")
 S IEN=0,CNT=0
 F  D  Q:+IEN=0
 . S IEN=$O(^IBT(356.22,IBTRIEN,11,IEN))
 . Q:+IEN=0
 . S CNT=CNT+1
 . S XX=$$LJ^XLFSTR(CNT,4)                      ; Selection #
 . S YY=$$GET1^DIQ(356.2211,IEN_","_DA_",",.01) ; Report Type Desc
 . S YY=$E(YY,1,28)_"  "
 . S XX=XX_$$LJ^XLFSTR(YY,30)
 . S YY=$$GET1^DIQ(356.2211,IEN_","_DA_",",.02) ; Delivery Method
 . S YY=$E(YY,1,20)_"  "
 . S XX=XX_$$LJ^XLFSTR(YY,23)
 . S YY=$$GET1^DIQ(356.2211,IEN_","_DA_",",.03) ; Attachment #
 . S YY=$E(YY,1,22)
 . S XX=XX_$$LJ^XLFSTR(YY,22)
 . S AIDATA(CNT)=IEN_"^"_XX
 ;
 I 'CNT D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . W !!,"No Additional Patient Information is currently on file.",!
 . S XX=$$ASKNEW("Add Additional Patient Information","NO")
 . Q:XX<0
 . S RTYPE=$$RTYPE(IBTRIEN)                     ; Get the .01 value
 . I RTYPE="" S XX=-1 Q                         ; None entered
 . S IBNEW=1,XX=RTYPE
 . S FDA(356.2211,"+1,"_IBTRIEN_",",.01)=RTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 ;
 ; Next display all of the current Additional Patient Information
 S H1="#   Report Type                   Delivery Method        Attachment Control #"
 S H2="--  ----------------------------  ---------------------  ----------------------"
 S L1="The following Additional Patient Information is currently on file."
 S L2="Enter the # of an entry to edit, 'NEW' to add one or press Return to skip."
 S XX=$$SELENT(.AIDATA,H1,H2,L1,L2,MAX,"",SECT)
 I XX?1"D".N D  Q -3
 . S (XX,ENTNUM)=$P(XX,"D",2)
 . S XX=$P(AIDATA(XX),U)
 . D DELAPI(IBTRIEN,XX)
 . W !,"Entry #",ENTNUM," has been deleted."
 I XX<0 Q XX
 I XX=0 D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . S RTYPE=$$RTYPE(IBTRIEN)                     ; Get the .01 value
 . I RTYPE="" S XX=-1 Q                         ; None entered
 . S IBNEW=1
 . S XX=RTYPE
 . S FDA(356.2211,"+1,"_IBTRIEN_",",.01)=RTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 Q $P(AIDATA(XX),"^",1)
 ;
DELAPI(IBTRIEN,IEN) ; Checks to see if the user entered 'NEW' to create a new 
 ; Additional Patient Information Line and didn't enter any data for it. Also
 ; checks to see if user selected to delete a specified line. If so, the 
 ; Additional Patient Information line with no data (or selected) is deleted
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          IEN     - Optional, IEN of the multiple to be deleted if passed
 ;                    defaults to ""
 ; Output:  Empty or selected Additional Patient Information line is deleted (Potentially)
 N APIIEN,DA,DIK,X,XX,Y
 S:'$D(IEN) IEN=""
 I IEN'="" D  Q
 . S DA(1)=IBTRIEN,DA=IEN
 . S DIK="^IBT(356.22,DA(1),11,"
 . D ^DIK                                           ; Delete the multiple
 ;
 S APIIEN=+$P($G(^IBT(356.22,IBTRIEN,11,0)),"^",3)  ; Last Multiple IEN
 Q:'APIIEN
 S XX=$G(^IBT(356.22,IBTRIEN,11,APIIEN,0))
 S $P(XX,"^",1)=""                                  ; Remove .01 field
 Q:$TR(XX,"^","")'=""                               ; 0 node data exists
 S DA(1)=IBTRIEN,DA=APIIEN
 S DIK="^IBT(356.22,DA(1),11,"
 D ^DIK                                             ; Delete the multiple
 Q
 ;
RTYPE(IBTRIEN) ; Prompts the user to enter the .01 (Report Type) field of the
 ; Additional Patient Information multiple
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ; Returns: IEN of the selected Report Type or "" of not entered
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DA(1)=IBTRIEN
 S DIR(0)="356.2211,.01",DIR("A")="  Report Type"
 D ^DIR
 Q:$D(DIRUT) ""
 Q $P(Y,"^",1)
 ;
SELPD(IBTRIEN) ;EP
 ; Called from within Input template IB CREATE 278 REQUEST
 ; Provides the user with a quick view of currently entered Provider Data
 ; multiples and allows them to select one to edit or enter a new one.
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          IBTRBRF - 1 if this display is being used from the brief template
 ;                    0 or undefined otherwise
 ; Returns: Value of the .01 field of the multiple to edit
 ;          "" if creating a new multiple, -2 to exit template
 ;          IBNEW=1 when creating a new entry
 N CNT,ENTNUM,FDA,IEN,H1,H2,L1,L2,MAX,PDDATA,PTYPE,RETIEN,SECT,X,XX,Y,YY
 S IBNEW=0,SECT="Provider Data Information"
 ;
 ; First check for an empty Provider Data Line to delete
 D DELPD(IBTRIEN)
 ;
 ; Next create an array of all current Provider Data Information lines
 S XX=+$P($G(^IBT(356.22,IBTRIEN,13,0)),"^",4)          ; # of Multiples
 S MAX=$S(XX<14:"",1:"Provider Data Lines")
 S IEN=0,CNT=0
 F  D  Q:+IEN=0
 . S IEN=$O(^IBT(356.22,IBTRIEN,13,IEN))
 . Q:+IEN=0
 . S CNT=CNT+1
 . S XX=$$LJ^XLFSTR(CNT,4)                              ; Selection #
 . S YY=$$GET1^DIQ(356.2213,IEN_","_DA_",",.01)         ; Prov Type Desc
 . S YY=$E(YY,1,30)_"  "
 . S XX=XX_$$LJ^XLFSTR(YY,32)
 . ;
 . ; IBTRBRF is defined in IB CREATE 278 REQUEST SHORT input template
 . I $G(IBTRBRF)'=1 D
 . . S YY=$$GET1^DIQ(356.2213,IEN_","_DA_",",.02)       ; Person/Non-Person
 . . S XX=XX_$$LJ^XLFSTR(YY,12)
 . S YY=$$GET1^DIQ(356.2213,IEN_","_DA_",",.03)
 . S XX=XX_$$LJ^XLFSTR(YY,"28T")
 . S PDDATA(CNT)=IEN_"^"_XX
 ; 
 I 'CNT D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 .I $G(IBTRBRF)'=1 D
 ..W !!,"No Provider Data Information is currently on file.",!
 ..S XX=$$ASKNEW("Add Provider Data Information")
 ..Q
 .I $G(IBTRBRF)=1 S XX=0
 .Q:XX<0
 .S PTYPE=$$PTYPE(IBTRIEN)                     ; Get the .01 value
 .I PTYPE="" S XX=-1 Q                         ; None entered
 .S IBNEW=1,XX=PTYPE
 .S FDA(356.2213,"+1,"_IBTRIEN_",",.01)=PTYPE
 .D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 .Q
 ;
 ; Next display all of the current Provider Data lines
 S H1="#   Provider Type                 "
 I $G(IBTRBRF)'=1 S H1=H1_"  Per/Non"
 S H1=H1_"     Provider"
 S H2="--  ------------------------------"
 I $G(IBTRBRF)'=1 S H2=H2_"  ----------"
 S H2=H2_"  ------------------------------"
 S L1="The following Provider Data Information is currently on file."
 S L2="Enter the # of an entry to edit, 'NEW' to add one or press Return to skip."
 S XX=$$SELENT(.PDDATA,H1,H2,L1,L2,MAX,"",SECT)
 I XX?1"D".N D  Q -3
 . S (XX,ENTNUM)=$P(XX,"D",2)
 . S XX=$P(PDDATA(XX),U)
 . D DELPD(IBTRIEN,XX)
 . W !,"Entry #",ENTNUM," has been deleted."
 I XX<0 Q XX
 I XX=0 D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . S PTYPE=$$PTYPE(IBTRIEN)                     ; Get the .01 value
 . I PTYPE="" S XX=-1 Q                         ; None entered
 . S XX=PTYPE
 . S IBNEW=1
 . S FDA(356.2213,"+1,"_IBTRIEN_",",.01)=PTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 Q $P(PDDATA(XX),"^",1)
 ;
DELPD(IBTRIEN,IEN) ; Checks to see if the user entered 'NEW' to create a new 
 ; Provider Data Line and didn't enter any data for it or selected a line to 
 ; be deleted.  If so, the empty or selected Provider Data line is deleted
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          IEN     - Optional, IEN of the multiple to be deleted if passed
 ;                    defaults to ""
 ; Output:  Empty or selected Provider Data line is deleted (Potentially)
 N PDIEN,DA,DIK,X,XX,Y
 S:'$D(IEN) IEN=""
 I IEN'="" D  Q
 . S DA(1)=IBTRIEN,DA=IEN
 . S DIK="^IBT(356.22,DA(1),13,"
 . D ^DIK                                           ; Delete the multiple
 ;
 S PDIEN=+$P($G(^IBT(356.22,IBTRIEN,13,0)),"^",3)   ; Last Multiple IEN
 Q:'PDIEN
 S XX=$G(^IBT(356.22,IBTRIEN,13,PDIEN,0))
 S $P(XX,"^",1)=""                                  ; Remove .01 field
 Q:$TR(XX,"^","")'=""                               ; 0 node data exists
 S DA(1)=IBTRIEN,DA=PDIEN
 S DIK="^IBT(356.22,DA(1),13,"
 D ^DIK                                             ; Delete the multiple
 Q
 ;
PTYPE(IBTRIEN) ; Prompts the user to enter the .01 (Provider Type) field of the
 ; Provider Data multiple
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ; Returns: IEN of the selected Provider Type or "" of not entered
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DA(1)=IBTRIEN
 S DIR(0)="356.2213,.01",DIR("A")="  Provider Type"
 D ^DIR
 Q:$D(DIRUT) ""
 Q $P(Y,"^",1)
 ;
SELDX(IBTRIEN) ;EP
 ; Called from within Input template IB CREATE 278 REQUEST
 ; Provides the user with a quick view of currently entered Diagnoses and
 ; allows them to select one to edit or enter a new diagnosis.
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          IBTRBRF - 1 if this display is being used from the brief template
 ;                    0 or undefined other otherwise
 ; Returns: Value of the .01 field of the multiple to edit
 ;          "" if creating a new multiple, -2 to exit template
 ;          -3 if a if a line was deleted
 ;          IBNEW=1 when creating a new entry
 N CNT,DXDATA,DXTYPE,ENTNUM,FDA,IEN,H1,H2,L1,L2,MAX,RETIEN,SECT,X,XX,Y,YY
 S IBNEW=0,SECT="Diagnosis Information"
 ;
 ; First check for an empty Diagnosis Line to delete
 D DELDX(IBTRIEN)
 ;
 ; Next create an array of all current Diagnoses lines
 S XX=+$P($G(^IBT(356.22,IBTRIEN,3,0)),"^",4)   ; Total # of Dx Lines
 S MAX=$S(XX<12:"",1:"Diagnosis Lines")
 S IEN=0,CNT=0
 F  D  Q:+IEN=0
 . S IEN=$O(^IBT(356.22,IBTRIEN,3,IEN))
 . Q:+IEN=0
 . S CNT=CNT+1
 . S XX=$$LJ^XLFSTR(CNT,4)                              ; Selection #
 . S YY=$$GET1^DIQ(356.223,IEN_","_DA_",",.01,"I")      ; Diagnosis Type
 . S YY=$$GET1^DIQ(356.006,YY_",",.01)
 . S XX=XX_$$LJ^XLFSTR(YY,7)
 . S YY=$$GET1^DIQ(356.223,IEN_","_DA_",",.02)          ; Diagnosis
 . S XX=XX_$$LJ^XLFSTR(YY,11)
 . I $G(IBTRBRF)'=1 D
 . . S YY=$$GET1^DIQ(356.223,IEN_","_DA_",",.03)        ; Date Known
 . . S XX=XX_$$LJ^XLFSTR(YY,14)
 . S DXDATA(CNT)=IEN_"^"_XX
 ;
 ; Creating 1st Diagnosis Line?
 I 'CNT D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 .I $G(IBTRBRF)'=1 D
 ..W !!,"No Diagnosis Information is currently on file.",!
 ..S XX=$$ASKNEW("Add a new Diagnosis")
 ..Q
 .I $G(IBTRBRF)=1 S XX=0
 .Q:XX<0
 .S DXTYPE=$$DXTYPE(IBTRIEN)                   ; Get the .01 value
 .I DXTYPE="" S XX=-1 Q                        ; None entered
 .S IBNEW=1,XX=DXTYPE
 .S FDA(356.223,"+1,"_IBTRIEN_",",.01)=DXTYPE
 .D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 .Q
 ;
 ; Next display all of the current Diagnoses and let the user select one
 S H1="#   Type   Diagnosis"
 I $G(IBTRBRF)'=1 S H1=H1_"  Date DX Known"
 S H2="--  -----  ---------"
 I $G(IBTRBRF)'=1 S H2=H2_"  -------------"
 S L1="The following Diagnoses are currently on file."
 S L2="Enter the # of a Diagnosis to edit, 'NEW' to add one or press Return to skip."
 S XX=$$SELENT(.DXDATA,H1,H2,L1,L2,MAX,"",SECT)
 I XX?1"D".N D  Q -3
 . S (XX,ENTNUM)=$P(XX,"D",2)
 . S XX=$P(DXDATA(XX),U)
 . D DELDX(IBTRIEN,XX)
 . W !,"Entry #",ENTNUM," has been deleted."
 I XX<0 Q XX
 I XX=0 D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . S DXTYPE=$$DXTYPE(IBTRIEN)                   ; Get the .01 value
 . I DXTYPE="" S XX=-1 Q                        ; None entered
 . S XX=DXTYPE
 . S IBNEW=1
 . S FDA(356.223,"+1,"_IBTRIEN_",",.01)=DXTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 Q $P(DXDATA(XX),"^",1)
 ;
DXTYPE(IBTRIEN) ; Prompts the user to enter the .01 (Diagnosis Type) field of
 ; the diagnosis multiple
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ; Returns: IEN of the selected Diagnosis Type or "" of not entered
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DA(1)=IBTRIEN,DA=$P($G(^IBT(356.22,IBTRIEN,3,0)),"^",3)+1
 S DIR(0)="356.223,.01",DIR("A")="  Diagnosis Qualifier"
 D ^DIR
 Q:$D(DIRUT) ""
 Q $P(Y,"^",1)
 ;
DELDX(IBTRIEN,IEN) ; Checks to see if the user entered 'NEW' to create a new 
 ; Diagnosis Line and didn't enter any data for it or selected a multiple to
 ; to be deleted.  If so, the empty or selected multiple is deleted
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          IEN     - Optional, IEN of the multiple to be deleted if passed
 ;                    defaults to ""
 ; Output:  Empty or selected Diagnosis line is deleted (Potentially)
 N DA,DIK,DXIEN,X,XX,Y
 S:'$D(IEN) IEN=""
 I IEN'="" D  Q
 . S DA(1)=IBTRIEN,DA=IEN
 . S DIK="^IBT(356.22,DA(1),3,"
 . D ^DIK                                           ; Delete the multiple
 ;
 S DXIEN=+$P($G(^IBT(356.22,IBTRIEN,3,0)),"^",3)    ; Last Multiple IEN
 Q:'DXIEN
 S XX=$G(^IBT(356.22,IBTRIEN,3,DXIEN,0))
 S $P(XX,"^",1)=""                                  ; Remove .01 field
 Q:$TR(XX,"^","")'=""                               ; 0 node data exists
 S DA(1)=IBTRIEN,DA=DXIEN
 S DIK="^IBT(356.22,DA(1),3,"
 D ^DIK                                             ; Delete the multiple
 Q
 ;
ASKNEW(PROMPT,DEFAULT) ;EP
 ; Ask if user wants to create a new entry
 ; Input:   PROMPT      - Yes/No question to ask the user
 ;          DEFALT      - Default Answer
 ;                        Optional, if not passed, set to 'YES'
 ; Returns: 0 - User wants to add a new Entry
 ;         -1 - User doesn't want to add a new entry
 ;         -2 - User wants to exit template
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,XX,Y
 S:'$D(DEFAULT) DEFAULT="YES"
 S XX=$P(PROMPT,"Add ",2)
 S DIR("?")="Select NO to skip this section. Select YES to enter "_XX_"."
 S DIR(0)="Y",DIR("A")=PROMPT,DIR("B")=DEFAULT
A1 ;
 D ^DIR
 I Y?1"^"1.E D JUMPERR^IBTRH5H G A1
 Q:$D(DUOUT) -2                                 ; User Pressed ^
 Q:$D(DTOUT) -1                                 ; User timed out
 I Y=0 Q -1
 Q 1
 ;
SELENT(ARRAY,H1,H2,L1,L2,MAX,INDENT,SECT) ; Select an entry to add/edit from a list
 ; Input:   ARRAY()     - Array of multiple lines to be displayed
 ;          H1          - 1st line of Header Information
 ;          H2          - 2nd line of Header Information
 ;          L1          - 1st line of DIR display
 ;          L2          - Selection line text
 ;          MAX         - Multiple Description
 ;                        If passed, entering a new line is not allowed
 ;                        Optional, defaults to "" if not passed
 ;          INDENT      - 1 to indent 2 spaces
 ;                        Optional, defaults to 0
 ;          SECT        - Section Header
 ; Returns: # - User wants to edit Entry #
 ;          0 - User wants to Add a new Entry
 ;         -1 - User wants to skip this section
 ;         -2 - User wants to exit template
 N DEL,DIR,DIROUT,DIRUT,DOK,DTOUT,DUOUT,IX,LN,X,XX,Y,YY
 S:'$D(MAX) MAX=""
 S:'$D(INDENT) INDENT=0
 S:'$D(SECT) SECT=""
 S DIR(0)="FO",LN=0
 S LN=LN+1,DIR("A",LN)=L1
 S LN=LN+1,DIR("A",LN)=" "
 S LN=LN+1,DIR("A",LN)=H1
 S LN=LN+1,DIR("A",LN)=H2
 S IX=""
 F  D  Q:IX=""
 . S IX=$O(ARRAY(IX))
 . Q:IX=""
 . S LN=LN+1,DIR("A",LN)=$P(ARRAY(IX),"^",2)
 S LN=LN+1,DIR("A",LN)=" "
 S LN=LN+1,DIR("A",LN)=L2
 S DIR("A")=$S(INDENT:"  ",1:"")_"Selection #"
 W !!
SELE1 ;
 S XX="Select NO to skip this section. Select YES to enter "_SECT_"."
 S XX=XX_"  To delete an entry from the list, select D followed by the "
 S XX=XX_"number of the entry you wish to delete."
 S DIR("?")=XX
 D ^DIR
 S DOK=1
 S Y=$$UP^XLFSTR(Y)                             ; Convert to Upper
 I Y?1"D".N D  Q:DOK Y
 . S XX=$P(Y,"D",2)
 . I XX>0,XX'>CNT,XX?.N Q                       ; Selected Entry to delete
 . S DOK=0
 . D SELERR(INDENT)
 G:'DOK SELE1
 I Y?1"^"1.E D JUMPERR^IBTRH5H G SELE1
 I $D(DUOUT) Q -2                               ; User pressed ^
 I $D(DTOUT) Q -1                               ; User timed out
 I Y="" Q -1                                    ; User pressed return
 S XX=$$UP^XLFSTR(Y)
 S YY=$S((XX="NEW")!(XX="N")!(XX="NE"):1,1:0)   ; User wants to enter a new one
 I MAX'="",YY D  G SELE1
 . W *7,!!,$S(INDENT:"  ",1:"")
 . W "The maximum Number of "_MAX_" have already been entered.",!
 Q:YY 0                                         ; Creating a new one
 I XX>0,XX'>CNT,XX?.N Q XX                      ; Selected Entry
 D SELERR(INDENT)
 G SELE1
 ;
SELERR(INDENT)  ; Multiple Selection error
 ; Input:   INDENT  - 1 to indent error message display
 W !!,*7,$S(INDENT:"  ",1:"")
 W "Enter a number from 1-",CNT,".  Enter NEW to enter a new entry."
 W !,$S(INDENT:"  ",1:"")
 W "To delete an entry from the list, select D followed by the "
 W !,$S(INDENT:"  ",1:"")
 W "number of the entry you wish to remove. Press return to skip selection."
 W !!
 Q
