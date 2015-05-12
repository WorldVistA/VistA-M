FBAAIAU ;ALB/FA - BUILD C8 MESSAGE ;03 Dec 2013  9:34 AM
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Contains utility functions for IPAC Vendor Agreement Management
 ;
 ;-----------------------------------------------------------------------------
 ;                           Methods
 ; CHKREQ       - Makes sure that all the required fields of the IPAC Vendor
 ;                agreement have values and if they do, changes the status of
 ;                the agreement to 'A'
 ; DELALL       - Delete all Vendor Agreements (161.95) and MRAs (161.96)
 ; LOCKVA       - Attempts to lock a specified IPAC Vendor Agreement
 ; SELMRA       - Displays a list of all the current MRA records and allows the
 ;                user to select one
 ; SELVA        - Displays a list of all the current IPAC Vendor Agreements and
 ;                allows the user to either select one to be edited or type 'NEW'
 ;                to enter a new one
 ; VADISP       - Returns the IPAC Vendor Agreement Display Layout for a 
 ;                specified vendor agreement
 ; VALOAD       - Returns an array of external field values for a specified
 ;                Vendor Agreement
 ; UNLOCKVA     - Unlocks a specified IPAC Vendor Agreement
 ;-----------------------------------------------------------------------------
 ;
CHKREQ(VAIEN)   ;EP
 ; Checks to see if all of the required fields of the IPAC vendor agreement have
 ; been entered and if so, change the status of the agreement to 'A' 
 ; Input:       VAIEN       - IEN of the IPAC Vendor agreement to be checked
 ; Called From: FBAAIAE, FBAAIAC
 ; NOTE:        Quits if the current status of the agreement is not 'N' without
 ;              doing anything. Also, the fields of the Vendor agreement are
 ;              HARD CODED in this method - if a new required field is added this
 ;              method must be modified
 N ARR,ERR,DA,DIE,DR,DTOUT,FLD,FLDINFO,NDE,PCE,STOP
 Q:'$D(^FBAA(161.95,VAIEN,0))                       ; Invalid IPAC agreement IEN
 Q:$P(^FBAA(161.95,VAIEN,0),U,4)'="N"               ; Status isn't 'N'
 ;
 ; First get a list of all the required fields
 F FLD=1:1:16,7.5 D                                 ; NOTE: HARD CODED field list
 . D FIELD^DID(161.95,FLD,,"GLOBAL SUBSCRIPT LOCATION;SPECIFIER","ARR","ERR")
 . Q:$E(ARR("SPECIFIER"),1)'="R"                    ; Not a required field
 . S FLDINFO(FLD)=ARR("GLOBAL SUBSCRIPT LOCATION")  ; Node;Piece 
 ;
 ; Now loop Through all of the required fields and check for data
 S FLD=0,STOP=0
 F  D  Q:FLD=""  Q:STOP
 . S FLD=$O(FLDINFO(FLD))
 . Q:FLD=""
 . S NDE=$P(FLDINFO(FLD),";",1),PCE=$P(FLDINFO(FLD),";",2)
 . S:$P($G(^FBAA(161.95,VAIEN,NDE)),U,PCE)="" STOP=1    ; Missing required field
 Q:STOP
 ;
 S DIE=161.95,DA=VAIEN
 S DR="3////A"
 D ^DIE
 Q
 ;
DELALL ;EP
 ; Clean-up utility to delete all existing Vendor agreements and MRA records
 ; Input:    None
 ; Output:   ^FBAA(161.95) AND ^FBAA(161.96) are cleared
 N DA,DIE,DIK,DR,DTOUT
 S DIK="^FBAA(161.95,"
 S DA=0
 F  D  Q:DA=""
 . S DA=$O(^FBAA(161.95,DA))
 . Q:DA=""
 . D ^DIK
 ;
 S DIK="^FBAA(161.96,"
 S DA=0
 F  D  Q:DA=""
 . S DA=$O(^FBAA(161.96,DA))
 . Q:DA=""
 . D ^DIK
 ;
 ; Reset the Last IPAC number
 S DIE=161.4,DA=1,DR="80///100"
 D ^DIE                                         ; File the new last number
 Q
 ;
SELVA(FLINE,STEXT,NEW,SVENIEN) ;EP
 ; Displays all of the currently filed IPAC Vendor agreements and allows the user
 ; to select one to edit or type 'NEW' to enter a new one
 ; Input:   FLINE       - Text of the first line to be displayed
 ;          STEXT       - User Selection prompt to be displayed
 ;                        NOTE: "" is allowed here.  If null, this becomes a 
 ;                              display only method with no ability select a Vendor
 ;                              OR to type NEW to enter a new one
 ;          NEW         - 1 to allow NEW as a valid selection, 0 otherwise
 ;          SVENIEN     - IEN of a specified vendor
 ;                        Optional, if specified, only IPAC agreements for the
 ;                        specified vendor will be displayed
 ; Output:  Current IPAC Vendor agreements displayed to the screen, if there are none,
 ;          a message is displayed
 ; Returns: VAIEN       - IEN of the selected IPAC Agreement
 ;                        0  - User wants/needs to enter a new agreement
 ;                        "" - No IPAC Vendor Agreement was selected
 N CNT,LN,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IX,OUT,VADATA,VAIEN,VENIEN,X,XX,Y
 S:'$D(SVENIEN) SVENIEN=""
 ;
 ; First create and array of all current IPAC Vendor Agreement data to display
 S CNT=0,VAIEN=0
 F  D  Q:+VAIEN=0
 . S VAIEN=$O(^FBAA(161.95,VAIEN))
 . Q:+VAIEN=0
 . S VENIEN=$P(^FBAA(161.95,VAIEN,0),U,2)                       ; Vendor IEN
 . Q:(SVENIEN'="")&(SVENIEN'=VENIEN)                            ; Not the selected Vendor
 . S CNT=CNT+1
 . S XX=$$LJ^XLFSTR(CNT,3)                                      ; Selection #
 . S XX=XX_$$LJ^XLFSTR($P(^FBAA(161.95,VAIEN,0),U,1),11)        ; ID
 . S XX=XX_$$LJ^XLFSTR($P(^FBAA(161.95,VAIEN,0),U,3),5)         ; Fiscal Year
 . S XX=XX_$$LJ^XLFSTR($$GET1^DIQ(161.2,VENIEN_",",.01),"29T")  ; Vendor Name
 . S XX=XX_"  "
 . S XX=XX_$P(^FBAA(161.95,VAIEN,0),U,4)_" "                    ; Status
 . S XX=XX_$$LJ^XLFSTR($P(^FBAA(161.95,VAIEN,0),U,5),"26T")     ; Description
 . S VADATA(CNT)=VAIEN_U_XX
 ;
 I 'CNT D  Q OUT
 . S OUT=""
 . Q:STEXT=""
 . W !!,"No IPAC Agreements are currently on file."
 . H:'NEW 1
 . Q:'NEW
 . S DIR("A")="Enter a new agreement"
 . S DIR(0)="Y"
 . D ^DIR
 . S:+Y=1 OUT=0
 ;
 ; Next display all of the current IPAC Vendor Agreements
 S DIR(0)="FO",LN=0
 S:NEW DIR("B")="NEW"
 S LN=LN+1,DIR("A",LN)=FLINE
 S LN=LN+1,DIR("A",LN)=" "
 S LN=LN+1,DIR("A",LN)="#  ID         FY   Vendor                         S Description"
 S LN=LN+1,DIR("A",LN)="-- ---------- ---- ------------------------------ - -------------------------"
 S IX=""
 F  D  Q:IX=""
 . S IX=$O(VADATA(IX))
 . Q:IX=""
 . S LN=LN+1,DIR("A",LN)=$P(VADATA(IX),U,2)
 I STEXT="" D  Q ""                                             ; Just display, no selection
 . W !!
 . S LN=""
 . F  D  Q:LN=""
 . . S LN=$O(DIR("A",LN))
 . . Q:LN=""
 . . W !,DIR("A",LN)
 S LN=LN+1,DIR("A",LN)=" "
 S LN=LN+1,DIR("A",LN)=STEXT
 S DIR("A")="Selection #"
SELVA1 ; Looping tag
 W !!
 K X,Y
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q ""                                     ; User timed out or pressed ^
 S XX=$$UP^XLFSTR(Y)
 I NEW Q:(XX="NEW")!(XX="N")!(XX="NE")!(XX="") 0                ; Creating a new one
 I 'NEW Q:XX="" ""                                              ; User quitting
 I XX>0,XX'>CNT,XX?.N Q $P(VADATA(XX),U,1)                      ; Selected IEN
 ;
 W !!,*7,"Enter a number from 1-"_CNT
 W:NEW " or Type 'NEW'"
 H 1
 G SELVA1
 ;
SELMRA(FLINE,STEXT,STATUS,ACTION) ;EP
 ; Displays all of the currently filed MRA records with a status of 'T' and
 ; allows the user to select one
 ; Input:   FLINE       - Text of the first line to be displayed
 ;          STEXT       - User Selection prompt to be displayed
 ;          STATUS      - 'P'   - Display pending MRA Records
 ;                        'T'   - Display transmitted MRA records
 ;                        ''    - Display both pending and transmitted records
 ;          ACTION      - 'A'   - Display Add MRA records
 ;                        'C'   - Display Change MRA records
 ;                        'D'   - Display Deleted MRA records
 ;                        ''    - Display MRA records with any type of action
 ; Output:  MRA Records that match the specified criteria are displayed to the screen.
 ;          If there are none, a message is displayed
 ; Returns: MRAIEN      - IEN of the selected MRA Record
 ;                        "" - No MRA record was selected
 N CNT,LN,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IX,MRAACT,MRADATA,MRAIEN,MRASTAT
 N OUT,TDT,VAIEN,VENIEN,X,XX,Y,ZZ
 ;
 ; First create and array of all current MRA records that match the selection criteria
 S CNT=0,MRAIEN=0
 F  D  Q:+MRAIEN=0
 . S MRAIEN=$O(^FBAA(161.96,MRAIEN))
 . Q:+MRAIEN=0
 . S ZZ=^FBAA(161.96,MRAIEN,0)
 . S MRAACT=$P(ZZ,U,4)                                          ; Action of the MRA Record
 . S MRASTAT=$P(ZZ,U,5)                                         ; Status of the MRA Record
 . I STATUS'="",STATUS'=MRASTAT Q                               ; Not the specified status
 . I ACTION'="",ACTION'=MRAACT Q                                ; Not the specified action
 . S CNT=CNT+1
 . S XX=$$LJ^XLFSTR(CNT,3)                                      ; Selection #
 . S XX=XX_$$LJ^XLFSTR($P(ZZ,U,3),11)                           ; IPAC Agreement ID
 . S XX=XX_$$LJ^XLFSTR(MRASTAT,2)                               ; Status
 . S XX=XX_$$LJ^XLFSTR(MRAACT,2)                                ; Action
 . I (STATUS="")!(STATUS="T") D                                 ; Transmit Date
 . . S TDT=$P(ZZ,U,6)
 . . S:TDT'="" TDT=$$FMTE^XLFDT(TDT,2)                          ; Converted to external
 . . S XX=XX_$$LJ^XLFSTR(TDT,9)
 . ;
 . ; Only displaying MRA records with an action of DELETE - no more columns to display
 . I ACTION="D" S MRADATA(CNT)=MRAIEN_U_XX Q
 . S VAIEN=$P(ZZ,U,2)                                           ; IPAC Agreement IEN
 . S VENIEN=$P($G(^FBAA(161.95,VAIEN,0)),U,2)                   ; Vendor IEN
 . S XX=XX_$$LJ^XLFSTR($$GET1^DIQ(161.2,VENIEN_",",.01),"30T")_" "  ; Vendor Name
 . S XX=XX_$$LJ^XLFSTR($P(^FBAA(161.95,VAIEN,0),U,5),"23T")     ; Description
 . S MRADATA(CNT)=MRAIEN_U_XX
 ;
 I 'CNT D  Q OUT
 . S OUT=""
 . Q:STEXT=""
 . W !!,"No MRA records that match the specified criteria are currently on file."
 ;
 ; Next display all of the found MRA Records
 S DIR(0)="FO",LN=0
 S LN=LN+1,DIR("A",LN)=FLINE
 S LN=LN+1,DIR("A",LN)=" "
 S LN=LN+1,DIR("A",LN)="#  ID         A "
 I (STATUS="")!(STATUS="T") D
 . S DIR("A",LN)=DIR("A",LN)_"S Trans Dt "
 I (ACTION'="D") D
 . S DIR("A",LN)=DIR("A",LN)_"Vendor                         Description"
 S LN=LN+1,DIR("A",LN)="-- ---------- - "
 I (STATUS="")!(STATUS="T") D
 . S DIR("A",LN)=DIR("A",LN)_"- -------- "
 I (ACTION'="D") D
 . S DIR("A",LN)=DIR("A",LN)_"------------------------------ ----------------------"
 S IX=""
 F  D  Q:IX=""
 . S IX=$O(MRADATA(IX))
 . Q:IX=""
 . S LN=LN+1,DIR("A",LN)=$P(MRADATA(IX),U,2)
 S LN=LN+1,DIR("A",LN)=" "
 S LN=LN+1,DIR("A",LN)=STEXT
 S DIR("A")="Selection #"
SELMRA1 ; Looping tag
 W !!
 K X,Y
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q ""                                     ; User timed out or pressed ^
 S XX=$$UP^XLFSTR(Y)
 Q:XX="" ""                                                     ; User quitting
 I XX>0,XX'>CNT,XX?.N Q $P(MRADATA(XX),U,1)                     ; Selected IEN
 ;
 W !!,*7,"Enter a number from 1-"_CNT
 H 1
 G SELMRA1
 ;
VADISP(VAIEN,TOSCREEN,VAOUT)   ;EP
 ; Returns the IPAC Vendor Agreement Display Layout for a specified vendor 
 ; agreement
 ; Input:   VAIEN   - Vendor Agreement IEN to build display layout for
 ;          TOSCREEN    - 1 - Display the Vendor Agreement to the screen, don't return VAOUT
 ;                        0 - Don't display it, return array VAOUT instead
 ; Output:  VAOUT       - Array of IPAC Vendor Agreement Display Layout lines
 ;                        Only returned if TOSCREEN=0
 ;
 N LN,VADATA,XX
 K VAOUT
 ; Invalid Vendor Agreement
 Q:'$D(^FBAA(161.95,VAIEN))
 ;
 D VALOAD(VAIEN,.VADATA)
 S XX=VADATA("ID"),VAOUT(1)="IPAC Vendor Agreement ID: "_$$LJ^XLFSTR(XX,12)
 S XX=VADATA("STAT"),VAOUT(1)=VAOUT(1)_"Status: "_$$LJ^XLFSTR(XX,10)
 S XX=VADATA("FY"),VAOUT(1)=VAOUT(1)_"FY: "_$$LJ^XLFSTR(XX,1,6)
 S XX=VADATA("VENDOR"),VAOUT(2)="Vendor: "_$$LJ^XLFSTR(XX,48)
 S XX=VADATA("DESC"),VAOUT(3)="  Desc: "_$$LJ^XLFSTR(XX,62)
 S XX=VADATA("SHAN"),VAOUT(4)="     Sharing Agreement #: "_$$LJ^XLFSTR(XX,"15T")
 S XX=VADATA("CALC"),VAOUT(5)="Customer ALC: "_$$LJ^XLFSTR(XX,10)
 S XX=VADATA("RTAS"),VAOUT(5)=VAOUT(5)_"Receiver TAS: "_$$LJ^XLFSTR(XX,"29T")
 S XX=VADATA("STAS"),VAOUT(6)=$$LJ^XLFSTR("",24," ")_"  Sender TAS: "_$$LJ^XLFSTR(XX,"29T")
 S XX=VADATA("ASN"),VAOUT(7)="Agency Field Station #: "_$$LJ^XLFSTR(XX,"10T")
 S XX=VADATA("OB"),VAOUT(7)=VAOUT(7)_"Obligating Document #: "_$$LJ^XLFSTR(XX,"19T")
 S VAOUT(8)="Station Contact: "
 S XX=VADATA("CON"),VAOUT(9)="    Name: "_$$LJ^XLFSTR(XX,62)
 S XX=VADATA("CONPHN"),VAOUT(10)="   Phone: "_$$LJ^XLFSTR(XX,"17T")
 S XX=VADATA("CONEM"),VAOUT(10)=VAOUT(10)_" Email: "_$$LJ^XLFSTR(XX,"40T") ; 1st 40 chars or email
 S VAOUT(11)=$S($L(XX)'>40:"",1:"   "_$E(XX,41,$L(XX)))         ; Remaining chars of email
 S VAOUT(12)="Complete Line of Accounting: "
 S XX=VADATA("LOA"),VAOUT(13)="   "_$$LJ^XLFSTR(XX,62)
 S VAOUT(14)="Description of Goods & Services: "
 S XX=VADATA("GOOD"),VAOUT(15)="   "_$$LJ^XLFSTR(XX,"70T")
 S VAOUT(16)=$S($L(XX)'>70:"",1:"   "_$E(XX,71,140))            ; Next 70 chars
 S VAOUT(17)=$S($L(XX)'>140:"",1:"   "_$E(XX,141,$L(XX)))       ; Remaining chars
 S VAOUT(18)="Miscellaneous Info: "
 S XX=VADATA("MISC1"),VAOUT(19)="1) "_$$LJ^XLFSTR(XX,"75T")
 S VAOUT(20)=$S($L(XX)'>75:"",1:"   "_$E(XX,76,150))            ; Next 75 chars
 S VAOUT(21)=$S($L(XX)'>150:"",1:"   "_$E(XX,151,$L(XX)))       ; Remaining chars
 S XX=VADATA("MISC2"),VAOUT(22)="2) "_$$LJ^XLFSTR(XX,"75T")
 S VAOUT(23)=$S($L(XX)'>75:"",1:"   "_$E(XX,76,$L(XX)))         ; Remaining chars
 Q:'TOSCREEN
 ;
 S LN=""
 F  D  Q:LN=""
 . S LN=$O(VAOUT(LN))
 . Q:LN=""
 . I VAOUT(LN)="***" W ! Q
 . W:$TR(VAOUT(LN)," ","")'="" !,VAOUT(LN)
 K VAOUT
 Q
 ;
VALOAD(VAIEN,VADATA) ;EP
 ; Returns an array of external field values for a specified Vendor Agreement
 ; Input:   VAIEN           - Vendor Agreement IEN
 ; Output:  VADATA("ASN")   - Agency Field Station Number
 ;          VADATA("CALC")  - Customer ALC
 ;          VADATA("CON")   - Station Contact Name
 ;          VADATA("CONEM") - Station Contact Email
 ;          VADATA("CONPHN")- Station Contact Phone
 ;          VADATA("DESC")  - Vendor Agreement Description
 ;          VADATA("FY")    - Fiscal Year
 ;          VADATA("GOOD")  - Description of Goods and Services
 ;          VADATA("ID")    - Vendor Agreement ID
 ;          VADATA("LOA")   - Complete line of Accounting
 ;          VADATA("OB")    - Obligating document number
 ;          VADATA("MISC1") - Miscellaneous Info 1
 ;          VADATA("MISC2") - Miscellaneous Info 2
 ;          VADATA("RTAS")  - Receiver TAS
 ;          VADATA("SHAN")  - Sharing Agreement Number
 ;          VADATA("STAS")  - Sender TAS
 ;          VADATA("STAT")  - Vendor Agreement Status
 ;          VADATA("VENDOR")- External Vendor name
 ;         
 ;
 N IPAC
 D GETS^DIQ(161.95,VAIEN_",","**","E","IPAC")
 S VADATA("ID")=IPAC(161.95,VAIEN_",",".01","E")
 ;
 S VADATA("VENDOR")=IPAC(161.95,VAIEN_",",1,"E")
 S VADATA("FY")=IPAC(161.95,VAIEN_",",2,"E")
 S VADATA("STAT")=IPAC(161.95,VAIEN_",",3,"E")
 S VADATA("DESC")=IPAC(161.95,VAIEN_",",4,"E")
 S VADATA("SHAN")=IPAC(161.95,VAIEN_",",5,"E")
 S VADATA("CALC")=IPAC(161.95,VAIEN_",",6,"E")
 S VADATA("RTAS")=IPAC(161.95,VAIEN_",",7,"E")
 S VADATA("STAS")=IPAC(161.95,VAIEN_",",7.5,"E")
 S VADATA("ASN")=IPAC(161.95,VAIEN_",",8,"E")
 S VADATA("OB")=IPAC(161.95,VAIEN_",",9,"E")
 S VADATA("CON")=IPAC(161.95,VAIEN_",",10,"E")
 S VADATA("CONPHN")=IPAC(161.95,VAIEN_",",11,"E")
 S VADATA("CONEM")=IPAC(161.95,VAIEN_",",12,"E")
 S VADATA("LOA")=IPAC(161.95,VAIEN_",",13,"E")
 S VADATA("GOOD")=IPAC(161.95,VAIEN_",",14,"E")
 S VADATA("MISC1")=IPAC(161.95,VAIEN_",",15,"E")
 S VADATA("MISC2")=IPAC(161.95,VAIEN_",",16,"E")
 Q
 ;
LOCKVA(VAIEN,DMSG) ;EP
 ; Attempt to lock IPAC Vendor Agreement
 ; Input:   VAIEN    - IPAC Vendor Agreement to be locked
 ;          DMSG     - 1 - Display locked message
 ;                     0 - Don't display locked message
 ;                     Optional, defaults to 1
 ; Returns: 1 - IPAC Vendor Agreement locked, 0 otherwise
 ;
 S:'$D(DMSG) DMSG=1
 L +^FBAA(161.95,VAIEN):0
 I '$T D  Q 0
 . W:DMSG !!,"Somebody is already editing this agreement.  Try again later."
 . H 1
 Q 1
 ;
UNLOCKVA(VAIEN)    ;EP
 ; Unlock the IPAC Vendor Agreement
 ; Input:   VAIEN    - Vendor Agreement to be locked
 ; Output:  IPAC Vendor Agreement is unlocked
 L -^FBAA(161.95,VAIEN)
 Q
 ;
