IBTRH5E ;ALB/FA - HCSR Create 278 Request ;12-AUG-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ; Contains Entry points and functions used in creating a 278 request from a
 ; selected entry in the HCSR Response worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ; SELSL        - Allows the user to see a quick view of the currently entered
 ;                Service Lines and either pick one to edit, enter a new one or
 ;                skip.
 ; SELOU        - Allows the user to see a quick view of the currently entered
 ;                Other UMO Information and either pick one to edit, enter a 
 ;                new one or skip.
 ; SELSPD       - Allows the user to see a quick view of the currently entered
 ;                Service Line Provider Data Lines and either pick one to edit,
 ;                enter a new one or skip.
 ;-----------------------------------------------------------------------------
 ;
SELOU(IBTRIEN) ;EP
 ; Called from within Input template IB CREATE 278 REQUEST
 ; Provides the user with a quick view of currently entered Other UMO
 ; Information multiples and allows them to select one to edit or enter a new 
 ; one.
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ; Returns: Value of the .01 field of the multiple to edit
 ;          "" if creating a new multiple, -2 to exit template
 ;          IBNEW=1 when creating a new entry
 N CNT,ENTNUM,FDA,IEN,H1,H2,L1,L2,OUDATA,OUTYPE,MAX,RETIEN,SECT,X,XX,Y,YY
 S IBNEW=0,SECT="Other UMO Information"
 ;
 ; First check for an empty Other UMO Information Lines to delete
 D DELOU(IBTRIEN)
 ;
 ; Next create an array of all current Other UMO Information lines
 S XX=+$P($G(^IBT(356.22,IBTRIEN,15,0)),"^",4)  ; Total # of multiples
 S MAX=$S(XX<3:"",1:"Other UMO Information Lines")
 S IEN=0,CNT=0
 F  D  Q:+IEN=0
 . S IEN=$O(^IBT(356.22,IBTRIEN,15,IEN))
 . Q:+IEN=0
 . S CNT=CNT+1
 . S XX=$$LJ^XLFSTR(CNT,4)                              ; Selection #
 . S YY=$$GET1^DIQ(356.2215,IEN_","_DA_",",.01)         ; UMO Type
 . S YY=$E(YY,1,30)_"  "
 . S XX=XX_$$LJ^XLFSTR(YY,32)
 . S YY=$$GET1^DIQ(356.2215,IEN_","_DA_",",.02)         ; UMO Name
 . S XX=XX_$$LJ^XLFSTR(YY,"44T")
 . S OUDATA(CNT)=IEN_"^"_XX
 ;
 ; Creating 1st Other UMO Information Line?
 I 'CNT D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . W !!,"No Other UMO Information is currently on file.",!
 . S XX=$$ASKNEW^IBTRH5D("Add Other UMO Information","NO")
 . Q:XX<0
 . S OUTYPE=$$OUTYPE(IBTRIEN)                   ; Get the .01 value
 . I OUTYPE="" S XX=-1 Q                        ; None entered
 . S IBNEW=1,XX=OUTYPE
 . S FDA(356.2215,"+1,"_IBTRIEN_",",.01)=OUTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 ;
 ; Next display all of the current Other UMO Information
 S H1="#   Type                            UMO Name"
 S H2="--  ------------------------------  ------------------------------"
 S L1="The following Other UMO Information is currently on file."
 S L2="Enter the # of an entry to edit, 'NEW' to add one or press Return to skip."
 S XX=$$SELENT^IBTRH5D(.OUDATA,H1,H2,L1,L2,MAX,"",SECT)
 I XX?1"D".N D  Q -3
 . S (XX,ENTNUM)=$P(XX,"D",2)
 . S XX=$P(OUDATA(XX),U)
 . D DELOU(IBTRIEN,XX)
 . W !,"Entry #",ENTNUM," has been deleted."
 ;
 I XX<0 Q XX
 I XX=0 D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . S OUTYPE=$$OUTYPE(IBTRIEN)                   ; Get the .01 value
 . I OUTYPE="" S XX=-1 Q                        ; None entered
 . S IBNEW=1
 . S XX=OUTYPE
 . S FDA(356.2215,"+1,"_IBTRIEN_",",.01)=OUTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 Q $P(OUDATA(XX),"^",1)
 ;
OUTYPE(IBTRIEN) ; Prompts the user to enter the .01 (Entity Identifier) field
 ; of the Other UMO Information Multiple
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ; Returns: Selected Entity Identifier or "" of not entered
 N ARR,DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,EIS,ERR,IX,X,XX,YY
 S EIS="",IX=0
 F  D  Q:'+IX
 . S IX=$O(^IBT(356.22,IBTRIEN,15,IX))
 . Q:+IX=0
 . S XX=$P(^IBT(356.22,IBTRIEN,15,IX,0),"^",1)
 . S EIS=$S(EIS="":XX,1:EIS_"^"_XX)
 S DA(1)=IBTRIEN
 S:EIS'="" EIS="^"_EIS_"^"
 D FIELD^DID(356.2215,.01,,"POINTER","ARR","ERR")
 S DIR("A")="  Other UMO Qualifier: "
 S XX=""
 F IX=1:1:$L(ARR("POINTER"),";") D
 . S YY=$P(ARR("POINTER"),";",IX)
 . Q:EIS[("^"_$P(YY,":",1)_"^")
 . S XX=$S(XX="":YY,1:XX_";"_YY)
 S DIR(0)="SOA^"_XX
 D ^DIR
 Q:$D(DIRUT) ""
 Q $P(Y,"^",1)
 ;
DELOU(IBTRIEN,IEN) ; Checks to see if the user entered 'NEW' to create a new 
 ; Other UMO Information Line and didn't enter any data for it OR selected a
 ; line to be deleted. If so, the Other Information Line with no data (or'
 ; selected) is deleted
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          IEN     - Optional, IEN of the multiple to be deleted if passed
 ;                    defaults to ""
 ; Output:  Empty or selected Other UMO Information line is deleted (Potentially)
 N DA,DIK,OUIEN,X,XX,Y
 S:'$D(IEN) IEN=""
 I IEN'="" D  Q
 . S DA(1)=IBTRIEN,DA=IEN
 . S DIK="^IBT(356.22,DA(1),15,"
 . D ^DIK                                           ; Delete the multiple
 ;
 S OUIEN=+$P($G(^IBT(356.22,IBTRIEN,15,0)),"^",3)   ; Last Multiple IEN
 Q:'OUIEN
 S XX=$G(^IBT(356.22,IBTRIEN,15,OUIEN,0))
 S $P(XX,"^",1)=""                                  ; Remove .01 field
 Q:$TR(XX,"^","")'=""                               ; 0 node data exists
 S DA(1)=IBTRIEN,DA=OUIEN
 S DIK="^IBT(356.22,DA(1),15,"
 D ^DIK                                             ; Delete the multiple
 Q
 ;
SELSL(IBTRIEN) ;EP
 ; Called from within Input template IB CREATE 278 REQUEST
 ; Provides the user with a quick view of currently entered Service Lines and
 ; allows them to select one to edit or enter a new Service Line.
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          IBTRF   - 1 - Being called from the brief form
 ; Returns: Value of the .01 field of the multiple to edit
 ;          "" if creating a new multiple
 ;          -1 if skipping altogether
 ;          -2 to exit template
 ;          IBNEW=1 when creating a new entry
 N CNT,ENTNUM,FDA,H1,H2,IEN,L1,L2,NIEN,RETIEN,SECT,SLDATA,X,XX,Y
 S IBNEW=0,SECT="Service Line Detail"
 ;
 ; First check for an empty Service Line to delete
 D DELSL(IBTRIEN)
 ;
 ; Next create an array of all current Service Lines
 S NIEN=+$P($G(^IBT(356.22,IBTRIEN,16,0)),"^",3)+1    ; Next Multiple IEN
 S IEN=0,CNT=0
 F  D  Q:+IEN=0
 . S IEN=$O(^IBT(356.22,IBTRIEN,16,IEN))
 . Q:+IEN=0
 . S CNT=CNT+1
 . S XX=$$GETSELLN(CNT,IBTRIEN,IEN,.H1,.H2)           ; Format Service line for display
 . S SLDATA(CNT)=IEN_"^"_XX
 ;
 ; Creating 1st Service Line? 
 I 'CNT D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 .I $G(IBTRBRF)'=1 D
 ..W !!,"No Service Line Detail is currently on file.",!
 ..S XX=$$ASKNEW^IBTRH5D("Add a new Service Line")
 ..Q
 .I $G(IBTRBRF)=1 S XX=0
 .Q:XX<0
 .S IBNEW=1,XX=NIEN
 .S FDA(356.2216,"+1,"_IBTRIEN_",",.01)=NIEN
 .D UPDATE^DIE("","FDA","RETIEN")                  ; File the new line
 .Q
 ;
 ; Next display all of the current Service Lines and let the user select one
 S L1="The following Service Lines are currently on file."
 S L2="Enter the # of a line to edit, 'NEW' to add one or press Return to skip."
 S XX=$$SELENT^IBTRH5D(.SLDATA,H1,H2,L1,L2,"",SECT)
 I XX?1"D".N D  Q -3
 . S (XX,ENTNUM)=$P(XX,"D",2)
 . S XX=$P(SLDATA(XX),"^",1)
 . D DELSL(IBTRIEN,XX)
 . W !,"Entry #",ENTNUM," has been deleted."
 I XX<0 Q XX
 I XX=0 D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . S XX=NIEN
 . S IBNEW=1
 . S FDA(356.2216,"+1,"_IBTRIEN_",",.01)=NIEN
 . D UPDATE^DIE("","FDA","RETIEN")                  ; File the new line
 Q $P(SLDATA(XX),"^",1)
 ;
GETSELLN(CNT,IBTRIEN,IEN,H1,H2) ; Gets a line of information to display a 
 ; Service Line
 ; Input:   CNT         - Current line Count
 ;          IBTRIEN     - IEN of the entry
 ;          IEN         - IEN of the Service Line
 ;          IBTRF       - 1 - Being called from the brief form
 ; Output:  H1          - 1st Header display line
 ;          H2          - 2nd Header display line
 ; Returns: Service line display
 N FILE,N4,XX,YY,ZZ
 ; IBTRBRF is defined in IB CREATE 278 REQUEST SHORT input template
 I $G(IBTRBRF)'=1 D
 . S H1="#   Type    Proc Code             Revenue  Code         Units/# of Procedures"
 . S H2="--  ------  --------------------  -------------------   ---------------------"
 I $G(IBTRBRF)=1 D
 . S H1="#   Proc Code             "
 . S H2="--  --------------------  "
 S XX=$$LJ^XLFSTR(CNT,4)                                    ; Selection #
 I $G(IBTRBRF)'=1 D
 . S YY=$$GET1^DIQ(356.2216,IEN_","_IBTRIEN_",",1.12,"I")
 . S YY=$S(YY="P":"Prof",YY="I":"Inst",YY="D":"Dental",1:"")
 . S XX=XX_$$LJ^XLFSTR(YY,6)_"  "
 S ZZ=$$GET1^DIQ(356.2216,IEN_","_IBTRIEN_",",1.01,"I")     ; Procedure Coding Method
 S N4=$S(ZZ="N4":1,1:0)
 S:'N4 YY=$$GET1^DIQ(356.2216,IEN_","_IBTRIEN_",",1.02)     ; Procedure Code
 S:N4 YY=$$GET1^DIQ(356.2216,IEN_","_IBTRIEN_",",12.01)     ; N4 Procedure Code
 S XX=XX_$$LJ^XLFSTR(YY,"20T")_"  "
 I $G(IBTRBRF)'=1 D
 . S YY=$$GET1^DIQ(356.2216,IEN_","_IBTRIEN_",",2.06,"I")    ; Revenue Code IEN
 . S YY=$$GET1^DIQ(399.2,YY_",",.01,"I")                     ; Revenue Code
 . S XX=XX_$$LJ^XLFSTR(YY,"20T")_"  "
 . S YY=$$GET1^DIQ(356.2216,IEN_","_IBTRIEN_",",1.1)         ; Units
 . S ZZ=$$GET1^DIQ(356.2216,IEN_","_IBTRIEN_",",1.11)        ; Unit Count
 . S YY=ZZ_" "_YY
 . S XX=XX_$$LJ^XLFSTR(YY,"21")
 Q XX
 ;
DELSL(IBTRIEN,IEN) ; Checks to see if the user entered 'NEW' to create a new 
 ; Service Line and didn't enter any data for it OR selected a service line
 ; to be deleted.  If so, the Service Line with no data (or selected) is deleted
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          IEN     - Optional, IEN of the multiple to be deleted if passed
 ;                    defaults to ""
 ; Output:  Empty or selected Service line is deleted (Potentially)
 N DA,DATA,DIK,LIEN,X,XX,Y,YY
 S:'$D(IEN) IEN=""
 I IEN'="" D  Q
 . S DA(1)=IBTRIEN,DA=IEN
 . S DIK="^IBT(356.22,DA(1),16,"
 . D ^DIK                                         ; Delete the multiple
 ;
 S LIEN=+$P($G(^IBT(356.22,IBTRIEN,16,0)),U,3)    ; Last Multiple IEN
 Q:'LIEN
 S XX=$G(^IBT(356.22,IBTRIEN,16,LIEN,0))
 S ($P(XX,U),$P(XX,U,11))=""                      ; Remove fields .01 and .11
 Q:$TR(XX,U,"")'=""                               ; 0 node data exists
 S XX=$G(^IBT(356.22,IBTRIEN,16,LIEN,1))
 S $P(XX,U,12)=""                                 ; Remove Service Line Type
 S $P(XX,U)=""                                    ; Remove Procedure Code Type
 Q:$TR(XX,U,"")'=""                               ; 1 node data exists
 S DATA=0
 F YY=2:1:9 D  Q:DATA
 . S XX=$G(^IBT(356.22,IBTRIEN,16,LIEN,YY))
 . S:$TR(XX,U,"")'="" DATA=1                      ; 2-9 node data exists
 Q:DATA
 S DA(1)=IBTRIEN,DA=LIEN
 S DIK="^IBT(356.22,DA(1),16,"
 D ^DIK                                             ; Delete the line
 Q
 ;
SELSPD(IBTRIEN,SIEN) ;EP
 ; Called from within Input template IB CREATE 278 REQUEST
 ; Provides the user with a quick view of currently entered Service Line 
 ; Provider Data multiples and allows them to select one to edit or enter a 
 ; new one.
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          SIEN   - Service Line Multiple IEN
 ; Returns: Value of the .01 field of the multiple to edit
 ;          "" if creating a new multiple, -2 to exit multiple
 ;          IBNEW=1 when creating a new entry
 N CNT,ENTNUM,FDA,H1,H2,IEN,IENS,L1,L2,MAX,PDDATA,PTYPE,RETIEN,SECT,X,XX,Y,YY
 S IBNEW=0,SECT="Service Provider Data Information"
 ;
 ; First check for an empty Provider Data Line to delete
 D DELSPD(IBTRIEN,SIEN)
 ;
 ; Next create an array of all current Service Line Provider Data Information lines
 S XX=+$P($G(^IBT(356.22,IBTRIEN,16,SIEN,8,0)),"^",4)  ; Total # of multiples
 S MAX=$S(XX<10:"",1:"Provider Data Lines")
 S IEN=0,CNT=0
 F  D  Q:+IEN=0
 . S IEN=$O(^IBT(356.22,IBTRIEN,16,SIEN,8,IEN))
 . Q:+IEN=0
 . S CNT=CNT+1
 . S XX="  "_$$LJ^XLFSTR(CNT,4)                 ; Selection #
 . S IENS=IEN_","_SIEN_","_IBTRIEN_","
 . S YY=$$GET1^DIQ(356.22168,IENS,.01)          ; Prov Type Desc
 . S XX=XX_$$LJ^XLFSTR(YY,"32T")
 . S YY=$$GET1^DIQ(356.22168,IENS,.02)          ; Person/Non-Person
 . S XX=XX_$$LJ^XLFSTR(YY,12)
 . S YY=$$GET1^DIQ(356.22168,IENS,.03)          ; Provider Name
 . S XX=XX_$$LJ^XLFSTR(YY,"30T")
 . S PDDATA(CNT)=IEN_"^"_XX
 ;
 I 'CNT D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . W !!,"  No Service Provider Data is currently on file.",!
 . S XX=$$ASKNEW^IBTRH5D("  Add Service Provider Data Information","NO")
 . Q:XX<0
 . S PTYPE=$$PTYPE(IBTRIEN,SIEN)                ; Get the .01 value
 . I PTYPE="" S XX=-1 Q                         ; None entered
 . S IBNEW=1,XX=PTYPE
 . S FDA(356.22168,"+1,"_SIEN_","_IBTRIEN_",",.01)=PTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 ;
 ; Next display all of the current Service Line Provider Data lines
 S H1="  #   Provider Type                   Per/Non     Provider"
 S H2="  --  ------------------------------  ----------  ------------------------------"
 S L1="  The following Provider Data Information is currently on file."
 S L2="  Enter the # of an entry to edit, 'NEW' to add one or press Return to skip."
 S XX=$$SELENT^IBTRH5D(.PDDATA,H1,H2,L1,L2,MAX,1,SECT)
 I XX?1"D".N D  Q -3
 . S (XX,ENTNUM)=$P(XX,"D",2)
 . S XX=$P(PDDATA(XX),"^",1)
 . D DELSPD(IBTRIEN,SIEN,XX)
 . W !,"Entry #",ENTNUM," has been deleted."
 I XX<0 Q XX
 I XX=0 D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . S PTYPE=$$PTYPE(IBTRIEN,SIEN)                ; Get the .01 value
 . I PTYPE="" S XX=-1 Q                         ; None entered
 . S XX=PTYPE
 . S IBNEW=1
 . ;
 . ; NOTE: the code below had "+1," which doesn't work, don't change back
 . S FDA(356.22168,"+2,"_SIEN_","_IBTRIEN_",",.01)=PTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 Q $P(PDDATA(XX),"^",1)
 ;
DELSPD(IBTRIEN,SIEN,IEN) ; Checks to see if the user entered 'NEW' to create a new
 ; Service Provider Data Line and didn't enter any data for it or selected a line
 ; to delete .  If so, the Service Provider Data line with no data (or selectd) is deleted
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          SIEN    - IEN of the Service Line
 ;          IEN     - Optional, IEN of the multiple to be deleted if passed
 ;                    defaults to ""
 ; Output:  Empty OR selected Service Provider Data Line is deleted (Potentially)
 N PDIEN,DA,DIK,X,XX,Y
 S:'$D(IEN) IEN=""
 I IEN'="" D  Q
 . S DA(2)=IBTRIEN,DA(1)=SIEN,DA=IEN
 . S DIK="^IBT(356.22,DA(2),16,DA(1),8,"
 . D ^DIK                                           ; Delete the multiple
 S PDIEN=+$P($G(^IBT(356.22,IBTRIEN,16,SIEN,8,0)),"^",3)   ; Last Multiple IEN
 Q:'PDIEN
 S XX=$G(^IBT(356.22,IBTRIEN,16,SIEN,8,PDIEN,0))
 S $P(XX,"^",1)=""                                  ; Remove .01 field
 Q:$TR(XX,"^","")'=""                               ; 0 node data exists
 S DA(2)=IBTRIEN,DA(1)=SIEN,DA=PDIEN
 S DIK="^IBT(356.22,DA(2),16,DA(1),8,"
 D ^DIK                                             ; Delete the multiple
 Q
 ;
PTYPE(IBTRIEN,SIEN) ; Prompts the user to enter the .01 (Provider Type) field
 ; of the Provider Data multiple
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          SIEN    - IEN of the Service Line
 ; Returns: IEN of the selected Provider Type or "" of not entered
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DA(1)=IBTRIEN
 S DIR(0)="356.22168,.01",DIR("A")="    Provider Type"
 D ^DIR
 Q:$D(DIRUT) ""
 Q $P(Y,"^",1)
 ;
