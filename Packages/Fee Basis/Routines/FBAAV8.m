FBAAV8 ;ALB/FA - BUILD IPAC MRA MESSAGE ;18 Dec 2013 10:04 AM
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 ;-----------------------------------------------------------------------------
 ;                           Entry Points
 ; EN  - Transmit IPAC MRA Messages
 ;       NOTE: (actually called from first line of routine)
 ;-----------------------------------------------------------------------------
 ;
EN ;EP
 ; Transmit IPAC MRA messages
 ; Input:       FBFEE       - Current # of FEE messages
 ; Output:      IPAC MRA messages Transmitted
 ;              FBFEE       - Updated # of FEE messages
 ;              FBNVP       - 1 (if its not already set)
 ;              FBSITE      - Array Fee Basis Site Parameters (161.4)
 ;                            (if not already passed in)
 ; Called From: RTRAN@FBAAV0
 N FBMSG,FBLN,FBSN,FBTXT,FBXMZ,MARIEN,X,ZMCNT
 S ZMCNT=0,FBTXT=0,FBLN=0
 S MRAIEN=""
 F  D  Q:MRAIEN=""
 . S MRAIEN=$O(^FBAA(161.96,"AS","P",MRAIEN))
 . Q:MRAIEN=""
 . Q:'$$EN1(MRAIEN,.FBMSG,.FBTXT,.FBLN,.FBSN,.FBXMZ,.ZMCNT)  ; Build Message
 ;
 Q:'$D(FBMSG)                                   ; No more records to transmit
 D XMIT^FBAAV01                                 ; Transmit data remaining records
 D MRAUPDT(.FBMSG)                              ; Update MRA records with transmission date
 Q
 ;
EN1(MRAIEN,FBMSG,FBTXT,FBLN,FBSN,FBXMZ,ZMCNT) ; Build the message lines for the specified
 ; MRA Record.
 ; Input:       MRAIEN  - IEN of the IPAC MRA record being sent
 ;              FBMSG   - Current Array of the MRA records that have currently been built
 ;                        for transmission, sorted by message number
 ;              FBTXT   - 0 - Header message not yet built
 ;                        1 - Header message already built
 ;              FBLN    - Current Line count
 ;              FBSN    - 6 character (blank padded) station number or "" if not yet set
 ;              FBXMZ   - Current Message Number, "" if no header has been built yet
 ;              ZMCNT   - Current total line count
 ; Output:      FBMSG   - Updated Array of the MRA records that have currently been built
 ;                        for transmission, sorted by message number
 ;              FBTXT   - Updated to 1 if it was initially 0 to indicate that the
 ;                        IPAC MRA message header line was built
 ;              FBLN    - Updated Line count
 ;              FBSN    - 6 character (blank padded) station number
 ;              FBXMZ   - Updated Message Number (only updated if HEAD is called)
 ;              ZMCNT   - Updated total line count
 ; Returns:     1 - Message is built for the specified MRA record, 0 otherwise
 ; Called From: EN
 N IX1,VAIEN
 S VAIEN=$P(^FBAA(161.96,MRAIEN,0),U,2)                 ; IEN of the selected IPAC agreement
 I VAIEN'="",'$D(^FBAA(161.95,VAIEN)) Q 0               ; Invalid IPAC Agreement IEN
 S FBMSG(MRAIEN)=""                                     ; Log the MRA record to be transmitted
 D LNBLD(VAIEN,MRAIEN,.FBMSG,.FBXMZ,.FBLN,.FBSN,.FBTXT,.ZMCNT) ; Build message to be transmitted
 Q 1
 ;
LNBLD(VAIEN,MRAIEN,FBMSG,FBXMZ,FBLN,FBSN,FBTXT,ZMCNT) ; Build the message
 ; Input:       VAIEN   - IEN of the IPAC Agreement of selected MRA record
 ;              MRAIEN  - IEN of the selected MRA record
 ;              FBMSG   - Array of the MRA records that have currently been built for 
 ;                        transmission, sorted by message number
 ;              FBXMZ   - Current Message number
 ;              FBLN    - Current Line count
 ;              FBSN    - 6 character (blank padded) station number or "" if not yet set
 ;              FBTXT   - 0 - Header message not yet built
 ;                        1 - Header message already built
 ;              ZMCNT   - Current total line count
 ; Output:      FBXMZ   - Updated Message number
 ;              FBLN    - Updated line count
 ;              FBSN    - 6 character (blank padded) station number
 ;              FBTXT   - Updated to 1 if it was initially 0 to indicate that the
 ;                        IPAC MRA message header line was built
 ;              ZMCNT   - Updated total line count
 ;
 N ACT,FBSTR,IX1,VADATA,VAID,XX
 S ACT=$P(^FBAA(161.96,MRAIEN,0),U,4)           ; MRA Record Action
 S VAID=$P(^FBAA(161.96,MRAIEN,0),U,3)          ; Agreement ID
 I ACT'="D" D                                   ; Not a delete record
 . F IX1=0:1:6 D
 . . S VADATA(IX1)=$G(^FBAA(161.95,VAIEN,IX1))  ; Array of IPAC Vendor Agreement data
 E  D
 . S VADATA(0)=VAID
 ;
 I 'FBTXT D                                     ; No header yet, build it now
 . S FBTXT=1,ZMCNT=1,FBLN=0
 . D HEAD(.FBLN,.FBXMZ,.FBSN)
 ;
 S FBSTR=$$LINE1(MRAIEN,FBSN,.VADATA)           ; 1st line of data for the MRA record
 D STORE^FBAAV01
 S ZMCNT=ZMCNT+1
 I ACT'="D" D                                   ; If we're not transmitting a delete record
 . S FBSTR=$$LINE2(.VADATA)                     ; 2nd line of data for the MRA record
 . D STORE^FBAAV01
 . S FBSTR=$$LINE3(.VADATA)                     ; 3rd line of data for the MRA record
 . D STORE^FBAAV01
 . S FBSTR=$$LINE4(.VADATA)                     ; 4th line of data for the MRA record
 . D STORE^FBAAV01
 . S FBSTR=$$LINE5(.VADATA)                     ; 5th line of data for the MRA record
 . D STORE^FBAAV01
 . S FBSTR=$$LINE6(.VADATA)                     ; 6th line of data for the MRA record
 . D STORE^FBAAV01
 . S FBSTR=$$LINE7(.VADATA)                     ; 7th line of data for the MRA record
 . D STORE^FBAAV01
 . S ZMCNT=ZMCNT+6                              ; Increment total line count
 ;
 ; Maximum total line count reached, transmit current lines
 I ZMCNT>27 D
 . D XMIT^FBAAV01                               ; Transmit the current data
 . D MRAUPDT(.FBMSG)                            ; Update MRA records with transmission date
 . S ZMCNT=0,FBLN=0,FBTXT=0                     ; Reset total line count, line count, header flag
 Q
 ;
HEAD(FBLN,FBXMZ,FBSN)    ; Create header line for IPAC MRA Message
 ; Input:       FBLN    - Current Line count of the message
 ;              FBXMZ   - Current Message number
 ; Output:      FBLN    - Updated Line count
 ;              FBSN    - Agency Station Number
 ;              FBXMZ   - Updated Message Number
 ;
 N FB,FBAASN,FBBN,FBHD,FBJ,FBSTR
 D NEWMSG^FBAAV01                               ; FBOKTX,XMSUB,XMDUZ
 S FBHD=$$HDR^FBAAUTL3()                        ; 'FEE' - first piece of batch header
 D STATION^FBAAUTL                              ; Returns FBSN,FBAASN (and maybe FBSITE)
 S FBSN=$$LJ^XLFSTR(FBSN,6)                     ; Station number padded with trailing spaces
 D GETNXB^FBAAUTL                               ; Next Fee Basis Batch Number (FBBN)
 S FBBN=$$RJ^XLFSTR(FBBN,5,"0")                 ; Padded with leading 0s to 5 digits as necessary
 ;
 ; Build header line for IPAC MRA Messages
 S FBSTR=FBHD_"C8"_$TR($$FMTE^XLFDT(DT,"5DZ"),"/","")_FBSN_FBBN_"$"
 D STORE^FBAAV01
 Q
 ;
LINE1(MRAIEN,FBSN,VADATA)  ; Create 1st message line for an MRA record
 ; Input:       MRAIEN      - IEN of the IPAC MRA record being transmitted
 ;              FBSN        - Agency Station # (6 chars padded with trailing spaces)
 ;              VADATA      - Array of IPAC Agreement data
 ; Returns:     1st line of data for the MRA record
 ; Called From: LNBLD 
 N FBSTR,VID,XX
 ;
 ; Build Line 1 of the Message for the selected MRA record
 S FBSTR=8                                      ; 1st char, 1st line of IPAC Agreement data
 S FBSTR=FBSTR_$P(^FBAA(161.96,MRAIEN,0),U,4)   ; 2nd char - IPAC MRA Action type (A,C,D)
 S FBSTR=FBSTR_FBSN                             ; 3-8 char - Agency Station Number
 S XX=$P(VADATA(0),U,1)                         ; IPAC Agreement ID
 S XX=$$LJ^XLFSTR(XX,10)                        ; IPAC Agreement ID padded with trailing spaces
 S FBSTR=FBSTR_XX                               ; 9-18 char - IPAC Agreement ID
 I '$D(VADATA(1)) Q FBSTR_"~$"                  ; Delete action being transmitted, quit now
 S VID=$P(VADATA(0),U,2)                        ; IEN of the IPAC Agreement Vendor, "" for deleted
 S XX=$P(^FBAAV(VID,0),U,2)                     ; Vendor ID number
 S XX=$$LJ^XLFSTR(XX,11)                        ; Vendor ID # left justified, padded with trailing spaces
 I $P(^FBAAV(VID,0),U,7)="3" D                  ; Pharmacy Vendor
 . N CHAIN
 . S CHAIN=$P(^FBAAV(VID,0),U,10)               ; Pharmacy chain #
 . S CHAIN=$$RJ^XLFSTR(CHAIN,4,"0")             ; Chain padded with leading 0's
 . S XX=$E(XX,1,9)_CHAIN                        ; Chain appended to the Vendor ID for pharmacy
 E  S XX=XX_"  "                                ; Non-Pharmacy Vendor
 S FBSTR=FBSTR_XX                               ; 19-31 char - Vendor ID
 S FBSTR=FBSTR_$P(VADATA(0),U,3)                ; 32-35 - IPAC Agreement Fiscal Year
 S XX=$P(VADATA(0),U,5)                         ; IPAC Agreement Description
 S XX=$$LJ^XLFSTR(XX,60)                        ; Description with trailing spaces
 S FBSTR=FBSTR_XX                               ; 36-95 char - IPAC Agreement Description
 S XX=$P(VADATA(0),U,6)                         ; IPAC Agreement Sharing #
 S XX=$$LJ^XLFSTR(XX,13)                        ; Sharing Agreement padded with trailing spaces
 S FBSTR=FBSTR_XX                               ; 96-108 char - Sharing Agreement #
 S FBSTR=FBSTR_$P(VADATA(0),U,4)_"~"            ; 109 char - IPAC Agreement Status ('A' or 'I') 
 Q FBSTR
 ;
LINE2(VADATA)  ; Create 2nd message line for an MRA record
 ; Input:       VADATA      - Array of IPAC Agreement data
 ; Returns:     2nd line of data for the MRA record
 ; Called From: LNBLD 
 N FBSTR,XX
 S XX=$P(VADATA(1),U,1)                         ; IPAC Agreement Customer ALC
 S XX=$$LJ^XLFSTR(XX,8)                         ; Customer ALC with trailing spaces
 S FBSTR=XX                                     ; 1-8 Char - Customer ALC
 S XX=$P(VADATA(1),U,2)                         ; IPAC Agreement Receiver TAS
 S XX=$$LJ^XLFSTR(XX,27)                        ; Receiver TAS with trailing spaces
 S FBSTR=FBSTR_XX                               ; 9-35 Char - Receiver TAS
 S XX=$P(VADATA(1),U,5)                         ; IPAC Agreement Sender TAS
 S XX=$$LJ^XLFSTR(XX,27)                        ; Sender TAS with trailing spaces
 S FBSTR=FBSTR_XX                               ; 36-62 Char - Receiver TAS
 S XX=$P(VADATA(1),U,3)                         ; IPAC Agreement Agency Field Station Number
 S XX=$$LJ^XLFSTR(XX,8)                         ; Agency Field Station Number with trailing spaces
 S FBSTR=FBSTR_XX                               ; 63-70 Char - Agency Field Station Number
 S XX=$P(VADATA(1),U,4)                         ; IPAC Agreement Obligating Document #
 S XX=$$LJ^XLFSTR(XX,17)                        ; Obligating Document # with trailing spaces
 S FBSTR=FBSTR_XX_"~"                           ; 71-87 Char - Obligating Document #
 Q FBSTR
LINE3(VADATA)  ; Create 3rd message line for an MRA record
 ; Input:       VADATA      - Array of IPAC Agreement data
 ; Returns:     3rd line of data for the MRA record
 ; Called From: LNBLD 
 N FBSTR,XX
 S XX=$P(VADATA(2),U,1)                         ; IPAC Agreement Station Contact Name
 S XX=$$LJ^XLFSTR(XX,60)                        ; Station Contact Name with trailing spaces
 S FBSTR=XX                                     ; 1-60 char - Station Contact Name
 S XX=$P(VADATA(2),U,2)                         ; IPAC Agreement Station Contact Phone
 S XX=$$LJ^XLFSTR(XX,17)                        ; Station Contact Phone with trailing spaces
 S FBSTR=FBSTR_XX                               ; 61-77 char - Station Contact Phone
 S XX=$P(VADATA(2),U,3)                         ; IPAC Agreement Station Contact Email
 S XX=$$LJ^XLFSTR(XX,100)                       ; Station Contact Email with trailing spaces
 S FBSTR=FBSTR_XX_"~"                           ; 78-177 char - Station Contact Phone
 Q FBSTR
 ; 
LINE4(VADATA)  ; Create 4th message line for an MRA record
 ; Input:       VADATA      - Array of IPAC Agreement data
 ; Returns:     4th line of data for the MRA record
 ; Called From: LNBLD 
 N FBSTR,XX
 S XX=$P(VADATA(3),U,1)                         ; IPAC Agreement Station Complete line of Accounting
 S XX=$$LJ^XLFSTR(XX,60)                        ; Complete line of accounting with trailing spaces
 S FBSTR=XX_"~"                                 ; 1-60 char - Complete line of Accounting
 Q FBSTR
 ; 
LINE5(VADATA)  ; Create 5th message line for an MRA record
 ; Input:       VADATA      - Array of IPAC Agreement data
 ; Returns:     5th line of data for the MRA record
 ; Called From: LNBLD 
 N FBSTR,XX
 S XX=$P(VADATA(4),U,1)                         ; IPAC Agreement Station Goods & Services
 S XX=$$LJ^XLFSTR(XX,200)                       ; Goods & Services with trailing spaces
 S FBSTR=XX_"~"                                 ; 1-200 char - Goods & Services
 Q FBSTR
 ;
LINE6(VADATA)  ; Create 6th message line for an MRA record
 ; Input:       VADATA      - Array of IPAC Agreement data
 ; Returns:     6th line of data for the MRA record
 ; Called From: LNBLD 
 N FBSTR,XX
 S XX=$P(VADATA(5),U,1)                         ; IPAC Agreement Miscellaneous Line 1
 S XX=$$LJ^XLFSTR(XX,220)                       ; Miscellaneous Line 1 with trailing spaces
 S FBSTR=XX_"~"                                 ; 1-220 char - Miscellaneous Line 1
 Q FBSTR
 ;
LINE7(VADATA)  ; Create 7th message line for an MRA record
 ; Input:       VADATA      - Array of IPAC Agreement data
 ; Returns:     7tht line of data for the MRA record
 ; Called From: LNBLD 
 N FBSTR,XX
 S XX=$P(VADATA(6),U,1)                         ; IPAC Agreement Miscellaneous Line 2
 S XX=$$LJ^XLFSTR(XX,100)                       ; Miscellaneous Line 2 with trailing spaces
 S FBSTR=XX_"~$"                                ; 1-100 char - Miscellaneous Line 2
 Q FBSTR
 Q
 ;
MRAUPDT(FBMSG)   ; Update MRA records with transmit status and date
 ; Input:       FBMSG()         - Array of MRA IENs that were transmitted
 ; Output:      MRA records updated with transmit status and date
 ; Called From: EN, LNBLD
 N DA,DIE,DR,MRAIEN,X
 S MRAIEN=""
 F  D  Q:MRAIEN=""
 . S MRAIEN=$O(FBMSG(MRAIEN))
 . Q:MRAIEN=""
 . S DIE="^FBAA(161.96,",DA=MRAIEN
 . S DR="4///^S X="_"""TRANSMITTED"""
 . S DR=DR_";5///TODAY"
 . D ^DIE
 . K FBMSG(MRAIEN)
 Q
 ;
