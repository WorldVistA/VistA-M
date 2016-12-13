IBTRH5F ;ALB/FA - HCSR Create 278 Request ;15-SEP-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ; Contains Entry points and functions used in creating a 278 request from a
 ; selected entry in the HCSR Response worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ; SELSAPI      - Allows the user to see a quick view of the currently entered
 ;                Service Line Additional Information Lines and either pick one
 ;                to edit, enter a new one or skip.
 ; SELPT        - Allows the user to see a quick view of the currently entered
 ;                Patient Event Transport Lines and either pick one to edit, 
 ;                enter a new one or skip.
 ; SELSTI       - Allows the user to see a quick view of the currently entered
 ;                Service Line Tooth Information Lines and either pick one to 
 ;                edit, enter a new one or skip.
 ;-----------------------------------------------------------------------------
 ;
SELPT(IBTRIEN) ;EP
 ; Called from within Input template IB CREATE 278 REQUEST
 ; Provides the user with a quick view of currently entered Patient Transport
 ; multiples and allows them to select one to edit or enter a new one.
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ; Returns: Value of the .01 field of the multiple to edit
 ;          "" if creating a new multiple, -2 to exit template
 ;          IBNEW=1 when creating a new entry
 N CNT,ENTNUM,FDA,IEN,H1,H2,L1,L2,MAX,PT,PTDATA,PTTYPE,RETIEN,SECT,X,XX,Y,YY
 S IBNEW=0,SECT="Patient Transport Information"
 ;
 ; First check for an empty Patient Transport Information Lines to delete
 D DELPT(IBTRIEN)
 ;
 ; Next create an array of all current Patient Transport Information lines
 S XX=+$P($G(^IBT(356.22,IBTRIEN,14,0)),"^",4)      ; Total # of lines
 S MAX=$S(XX<5:"",1:"Patient Transport Information Lines")
 S SECT="Patient Transport Information"
 S IEN=0,CNT=0
 F  D  Q:+IEN=0
 . S IEN=$O(^IBT(356.22,IBTRIEN,14,IEN))
 . Q:+IEN=0
 . S CNT=CNT+1
 . S PT=$G(^IBT(356.22,IBTRIEN,14,IEN,0))
 . S XX=$$LJ^XLFSTR(CNT,4)                              ; Selection #
 . S YY=$$GET1^DIQ(356.2214,IEN_","_DA_",",.01)
 . S YY=$E(YY,1,20)_"  "
 . S XX=XX_$$LJ^XLFSTR(YY,22)
 . S YY=$$GET1^DIQ(356.2214,IEN_","_DA_",",.02)
 . S XX=XX_$$LJ^XLFSTR(YY,"54T")
 . S PTDATA(CNT)=IEN_"^"_XX
 ;
 S H1="#   Type                  Location Name"
 S H2="--  --------------------  ------------------------------------------------------"
 S L1="The following Patient Transport Information is currently on file."
 S L2="Enter the # of an entry to edit, 'NEW' to add one or press Return to skip."
 ;
 ; Creating 1st Patient Transport Information Line
 I CNT=0 D  Q $O(RETIEN(0))
 . W !!,"Two Patient Transport Information lines are required.",!
 . S PTTYPE=$$PTTYPE(IBTRIEN,1)                 ; Get the .01 value
 . S FDA(356.2214,"+1,"_IBTRIEN_",",.01)=PTTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 ;
 ; Creating 2nd  Patient Transport Information Line
 I CNT=1 D  Q $O(RETIEN(0))
 . W !!,"Two Patient Transport Information lines are required.",!!
 . W !,L1,!,H1,!,H2,!,$P(PTDATA(1),"^",2),!!
 . S PTTYPE=$$PTTYPE(IBTRIEN,1)                 ; Get the .01 value
 . S FDA(356.2214,"+2,"_IBTRIEN_",",.01)=PTTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 ;
 ; Next display all of the current Patient Transport Lines
 S XX=$$SELENT^IBTRH5D(.PTDATA,H1,H2,L1,L2,MAX,"",SECT)
 I XX?1"D".N D  Q -3
 . S (XX,ENTNUM)=$P(XX,"D",2)
 . S XX=$P(PTDATA(XX),"^",1)
 . D DELPT(IBTRIEN,XX)
 . W !,"Entry #",ENTNUM," has been deleted."
 I XX<0 Q XX
 I XX=0 D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . S PTTYPE=$$PTTYPE(IBTRIEN)                   ; Get the .01 value
 . I PTTYPE="" S XX=-1 Q                        ; None entered
 . S IBNEW=1
 . S XX=PTTYPE
 . S FDA(356.2214,"+1,"_IBTRIEN_",",.01)=PTTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 Q $P(PTDATA(XX),"^",1)
 ;
PTTYPE(IBTRIEN,REQ) ; Prompts the user to enter the .01 (Entity Identifier) field
 ; of the Patient Transport Information Multiple
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          REQ     - 1 if field is required
 ;                    Optional, defaults to 0
 ; Returns: Selected Entity Identifier or "" of not entered
 N ARR,DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,EIS,ERR,IX,X,XX,YY
PTTYPE1 ; Looping tag
 S:'$D(REQ) REQ=0
 S EIS="",IX=0
 F  D  Q:'+IX
 . S IX=$O(^IBT(356.22,IBTRIEN,14,IX))
 . Q:+IX=0
 . S XX=$P(^IBT(356.22,IBTRIEN,14,IX,0),"^",1)
 . S EIS=$S(EIS="":XX,1:EIS_"^"_XX)
 S DA(1)=IBTRIEN
 S:EIS'="" EIS="^"_EIS_"^"
 D FIELD^DID(356.2214,.01,,"POINTER","ARR","ERR")
 S DIR("A")="  Ambulance Location Qualifier: "
 S XX=""
 F IX=1:1:$L(ARR("POINTER"),";") D
 . S YY=$P(ARR("POINTER"),";",IX)
 . Q:EIS[("^"_$P(YY,":",1)_"^")
 . S XX=$S(XX="":YY,1:XX_";"_YY)
 S DIR(0)=$S(REQ:"SA^",1:"SOA^")_XX
 D ^DIR
 I REQ,$D(DIRUT) D  G PTTYPE1
 . W !,*7," Entity Identifier is required.",!!
 Q:$D(DIRUT) ""
 Q $P(Y,"^",1)
 ;
DELPT(IBTRIEN,IEN) ; Checks to see if the user entered 'NEW' to create a new 
 ; Patient Transport Information Line and didn't enter any data for it OR 
 ; selected a line to delete. If so, the Patient Transport Information Line with
 ; no data (or selected) is deleted
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          IEN     - Optional, IEN of the multiple to be deleted if passed
 ;                    defaults to ""
 ; Output:  Empty (or selected) Patient Transport Information line is deleted (Potentially)
 N DA,DIK,PTIEN,X,XX,Y
 S:'$D(IEN) IEN=""
 I IEN'="" D  Q
 . S DA(1)=IBTRIEN,DA=IEN
 . S DIK="^IBT(356.22,DA(1),14,"
 . D ^DIK                                           ; Delete the multiple
 ;
 S PTIEN=+$P($G(^IBT(356.22,IBTRIEN,14,0)),"^",3)   ; Last Multiple IEN
 Q:'PTIEN
 S XX=$G(^IBT(356.22,IBTRIEN,14,PTIEN,0))
 S $P(XX,"^",1)=""                                  ; Remove .01 field
 Q:$TR(XX,"^","")'=""                               ; 0 node data exists
 S DA(1)=IBTRIEN,DA=PTIEN
 S DIK="^IBT(356.22,DA(1),14,"
 D ^DIK                                             ; Delete the multiple
 Q
 ;
SELSAPI(IBTRIEN,SIEN) ;EP
 ; Called from within Input template IB CREATE 278 REQUEST
 ; Provides the user with a quick view of currently entered Service Line 
 ; Additional Patient Information multiples and allows them to select one to 
 ; edit or enter a new  one.
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          SIEN    - IEN of the service line multiple being edited
 ; Returns: Value of the .01 field of the multiple to edit
 ;          "" if creating a new multiple, -2 to exit multiple
 ;          IBNEW=1 when creating a new entry
 N AIDATA,CNT,ENTNUM,FDA,IEN,IENS,H1,H2,L1,L2,MAX,RETIEN,RTYPE,SECT,X,XX,Y,YY
 S IBNEW=0,SECT="Service Additional Patient Information"
 ;
 ; First check for an empty Additional Patient Information Line to delete
 D DELSAPI(IBTRIEN,SIEN)
 ;
 ; Next create an array of all current Additional Patient 
 ; Information lines to display
 S XX=+$P($G(^IBT(356.22,IBTRIEN,16,SIEN,6,0)),"^",4)  ; Total # of API Lines
 S MAX=$S(XX<10:"",1:"Additional Patient Information Lines")
 S IEN=0,CNT=0
 F  D  Q:+IEN=0
 . S IEN=$O(^IBT(356.22,IBTRIEN,16,SIEN,6,IEN))
 . Q:+IEN=0
 . S CNT=CNT+1
 . S XX="  "_$$LJ^XLFSTR(CNT,4)                 ; Selection #
 . S IENS=IEN_","_SIEN_","_IBTRIEN_","
 . S YY=$$GET1^DIQ(356.22166,IENS,.01)          ; Report Type Desc
 . S YY=$E(YY,1,26)_"  "
 . S XX=XX_$$LJ^XLFSTR(YY,28)
 . S YY=$$GET1^DIQ(356.22166,IENS,.02)          ; Delivery Method
 . S YY=$E(YY,1,20)_"  "
 . S XX=XX_$$LJ^XLFSTR(YY,23)
 . S YY=$$GET1^DIQ(356.22166,IENS,.03)          ; Attachment Ctrl #
 . S YY=$E(YY,1,22)
 . S XX=XX_$$LJ^XLFSTR(YY,22)
 . S AIDATA(CNT)=IEN_"^"_XX
 ;
 I 'CNT D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . W !!,"  No Additional Patient Information is currently on file.",!
 . S XX=$$ASKNEW^IBTRH5D("  Add Additional Patient Information","NO")
 . Q:XX<0
 . S RTYPE=$$RTYPE(IBTRIEN,SIEN)                ; Get the .01 value
 . I RTYPE="" S XX=-1 Q                         ; None entered
 . S IBNEW=1,XX=RTYPE
 . S FDA(356.22166,"+1,"_SIEN_","_IBTRIEN_",",.01)=RTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 ;
 ; Next display all of the current Additional Patient Information
 S H1="  #   Report Type                 Delivery Method        Attachment Control #"
 S H2="  --  --------------------------  ---------------------  ----------------------"
 S L1="  The following Additional Patient Information is currently on file."
 S L2="  Enter the # of an entry to edit, 'NEW' to add one or press Return to skip."
 S XX=$$SELENT^IBTRH5D(.AIDATA,H1,H2,L1,L2,MAX,1,SECT)
 I XX?1"D".N D  Q -3
 . S (XX,ENTNUM)=$P(XX,"D",2)
 . S XX=$P(AIDATA(XX),"^",1)
 . D DELSAPI(IBTRIEN,SIEN,XX)
 . W !,"Entry #",ENTNUM," has been deleted."
 I XX<0 Q XX
 I XX=0 D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . S RTYPE=$$RTYPE(IBTRIEN,SIEN)                ; Get the .01 value
 . I RTYPE="" S XX=-1 Q                         ; None entered
 . S XX=RTYPE
 . S IBNEW=1
 . S FDA(356.22166,"+1,"_SIEN_","_IBTRIEN_",",.01)=RTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 Q $P(AIDATA(XX),"^",1)
 ;
DELSAPI(IBTRIEN,SIEN,IEN) ; Checks to see if the user entered 'NEW' to create a new 
 ; Additional Patient Information Line and didn't enter any data for it or selected
 ; a line to be deleted.  If so, the empty or selected Additional Patient Information
 ; line is deleted
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          SIEN    - IEN of the Service Line being edited
 ;          IEN     - Optional, IEN of the multiple to be deleted if passed
 ;                    defaults to ""
 ; Output:  Empty or selected Additional Patient Information line is deleted (Potentially)
 N APIIEN,DA,DIK,X,XX,Y
 S:'$D(IEN) IEN=""
 I IEN'="" D  Q
 . S DA(2)=IBTRIEN,DA(1)=SIEN,DA=IEN
 . S DIK="^IBT(356.22,DA(2),16,DA(1),6,"
 . D ^DIK                                           ; Delete the multiple
 ;
 S APIIEN=+$P($G(^IBT(356.22,IBTRIEN,16,SIEN,11,0)),"^",3)  ; Last Multiple IEN
 Q:'APIIEN
 S XX=$G(^IBT(356.22,IBTRIEN,16,SIEN,6,APIIEN,0))
 S $P(XX,"^",1)=""                                  ; Remove .01 field
 Q:$TR(XX,"^","")'=""                               ; 0 node data exists
 S DA(2)=IBTRIEN,DA(1)=SIEN,DA=APIIEN
 S DIK="^IBT(356.22,DA(2),16,DA(1),6,"
 D ^DIK                                             ; Delete the multiple
 Q
 ;
RTYPE(IBTRIEN,SIEN) ; Prompts the user to enter the .01 (Report Type) field of the
 ; Additional Patient Information multiple
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          SIEN    - IEN of the Service Line
 ; Returns: IEN of the selected Report Type or "" of not entered
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DA(2)=IBTRIEN,DA(1)=SIEN
 S DIR(0)="356.22166,.01",DIR("A")="    Report Type"
 D ^DIR
 Q:$D(DIRUT) ""
 Q $P(Y,"^",1)
 ;
SELSTI(IBTRIEN,SIEN) ;EP
 ; Called from within Input template IB CREATE 278 REQUEST
 ; Provides the user with a quick view of currently entered Service Line Tooth
 ; Information multiples and allows them to select one to edit or enter a new
 ; one.
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          SIEN   - Service Line Multiple IEN
 ; Returns: Value of the .01 field of the multiple to edit
 ;          "" if creating a new multiple, -2 to exit multiple
 ;          IBNEW=1 when creating a new entry
 N CNT,ENTNUM,TDATA,IEN,H1,H2,IEN,IENS,L1,L2,MAX,RETIEN,SECT,TIDATA,TTYPE,X,XX,Y,YY
 S IBNEW=0,SECT="Tooth Information"
 ;
 ; First check for an empty Additional Patient Information Line to delete
 D DELSTI(IBTRIEN,SIEN)
 ;
 ; Next create an array of all current Service Line Tooth Information Lines
 S XX=+$P($G(^IBT(356.22,IBTRIEN,16,SIEN,4,0)),"^",4)  ; Total # of multiples
 S MAX=$S(XX<32:"",1:"Tooth Information Lines")
 S IEN=0,CNT=0
 F  D  Q:+IEN=0
 . S IEN=$O(^IBT(356.22,IBTRIEN,16,SIEN,4,IEN))
 . Q:+IEN=0
 . S CNT=CNT+1
 . S XX="  "_$$LJ^XLFSTR(CNT,4)                 ; Selection #
 . S IENS=IEN_","_SIEN_","_IBTRIEN_","
 . S YY=$$GET1^DIQ(356.22164,IENS,.01,"I")      ; Tooth Code (External)
 . S YY=$$GET1^DIQ(356.022,YY_",",.01)          ; Tooth Code
 . S XX=XX_$$LJ^XLFSTR(YY,7)
 . S YY=$$GET1^DIQ(356.22164,IENS,.02)          ; Tooth Surface #1
 . S XX=XX_$$LJ^XLFSTR(YY,12)
 . S YY=$$GET1^DIQ(356.22164,IENS,.03)          ; Tooth Surface #2
 . S XX=XX_$$LJ^XLFSTR(YY,12)
 . S YY=$$GET1^DIQ(356.22164,IENS,.04)          ; Tooth Surface #3
 . S XX=XX_$$LJ^XLFSTR(YY,12)
 . S YY=$$GET1^DIQ(356.22164,IENS,.05)          ; Tooth Surface #4
 . S XX=XX_$$LJ^XLFSTR(YY,12)
 . S TIDATA(CNT)=IEN_"^"_XX
 ;
 I 'CNT D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . W !!,"  No Additional Patient Information is currently on file.",!
 . S XX=$$ASKNEW^IBTRH5D("  Add Tooth Information")
 . Q:XX<0
 . S TTYPE=$$TTYPE(IBTRIEN,SIEN)                ; Get the .01 value
 . I TTYPE="" S XX=-1 Q                         ; None entered
 . S IBNEW=1,XX=TTYPE
 . S FDA(356.22164,"+1,"_SIEN_","_IBTRIEN_",",.01)=TTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 ;
 ; Next display all of the current Tooth Information lines and let the user select one
 S H1="  #   Tooth  Surface #1  Surface #2  Surface #3  Surface #4"
 S H2="  --  -----  ----------  ----------  ----------  ----------"
 S L1="  The following Tooth Information Lines are currently on file."
 S L2="  Enter the # of a Line to edit, 'NEW' to add one or press Return to skip."
 S XX=$$SELENT^IBTRH5D(.TIDATA,H1,H2,L1,L2,MAX,1,SECT)
 I XX?1"D".N D  Q -3
 . S (XX,ENTNUM)=$P(XX,"D",2)
 . S XX=$P(TIDATA(XX),"^",1)
 . D DELSTI(IBTRIEN,SIEN,XX)
 . W !,"Entry #",ENTNUM," has been deleted."
 I XX<0 Q XX
 I XX=0 D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . S TTYPE=$$TTYPE(IBTRIEN,SIEN)                ; Get the .01 value
 . I TTYPE="" S XX=-1 Q                         ; None entered
 . S IBNEW=1
 . S XX=TTYPE
 . S FDA(356.22164,"+1,"_SIEN_","_IBTRIEN_",",.01)=TTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 Q $P(TIDATA(XX),"^",1)
 ;
DELSTI(IBTRIEN,SIEN,IEN) ; Checks to see if the user entered 'NEW' to create a new 
 ; Tooth Information Line and didn't enter any data for it OR selected a line
 ; to be deleted.  If so, the Additional Tooth Information line with no data 
 ; (or selected) is deleted
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          SIEN    - IEN of the Service Line being edited
 ; Output:  Empty (or selected) Tooth Information line is deleted (Potentially)
 N DA,DIK,TIIEN,X,XX,Y
 S:'$D(IEN) IEN=""
 I IEN'="" D  Q
 . S DA(2)=IBTRIEN,DA(1)=SIEN,DA=IEN
 . S DIK="^IBT(356.22,DA(2),16,DA(1),4,"
 . D ^DIK                                           ; Delete the multiple
 ;
 S TIIEN=+$P($G(^IBT(356.22,IBTRIEN,16,SIEN,4,0)),"^",3)  ; Last Multiple IEN
 Q:'TIIEN
 S XX=$G(^IBT(356.22,IBTRIEN,16,SIEN,4,TIIEN,0))
 S $P(XX,"^",1)=""                                  ; Remove .01 field
 Q:$TR(XX,"^","")'=""                               ; 0 node data exists
 S DA(2)=IBTRIEN,DA(1)=SIEN,DA=TIIEN
 S DIK="^IBT(356.22,DA(2),16,DA(1),4,"
 D ^DIK                                             ; Delete the multiple
 Q
 ;
TTYPE(IBTRIEN,SIEN) ; Prompts the user to enter the .01 (Tooth) field of the
 ; Tooth Information multiple
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          SIEN    - IEN of the Service Line
 ; Returns: IEN of the selected Tooth Type or "" of not entered
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DA(2)=IBTRIEN,DA(1)=SIEN
 S DIR(0)="356.22164,.01",DIR("A")="    Tooth Code"
 D ^DIR
 Q:$D(DIRUT) ""
 Q $P(Y,"^",1)
 ;
