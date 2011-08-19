RMPRPIU1 ;HINCIO/ODJ - PIP STOCK ISSUE TO PATIENT UPDATE UILITY ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ; MOD - Modify a Stock 'Issue to Patient' Transaction
 ;
 ; Inputs:
 ;    RMPR60 - array of data fields for 660 file record...
 ;             RMPR60("IEN") must be set to the ien of 660 rec.
 ;                           being modified.
 ;             The other elements should ONLY be set if modifying.
 ;    RMPR60("IEN")        - IEN of 660 record being modified
 ;    RMPR60("PATIENT IEN")- Prosthetic Patient 
 ;                           (.01 field ptr to ^RMPR(665,)
 ;    RMPR60("ISSUE TYPE") - Type of Issue (fld 2 - see FM set of codes)
 ;    RMPR60("QUANTITY")   - Number of items issued (fld 5)
 ;    RMPR60("IFCAP ITEM") - IFCAP item (fld 4 ptr to ^RMPR(661,)
 ;    RMPR60("VENDOR IEN") - Item Vendor (fld 7 ptr to ^PRC(440,)
 ;    RMPR60("SERIAL NUM") - Serial Number (fld 9)
 ;    RMPR60("REQ TYPE")   - Request Type (fld 11 - see FM set of codes)
 ;    RMPR60("REMARKS")    - Comments (fld 16)
 ;    RMPR60("LOT NUM")    - Lot number (fld 21)
 ;    RMPR60("CPT MOD")    - CPT modifier string (fld 4.7)
 ;    RMPR60("COST")       - Total value of issue (fld 14)
 ;    RMPR60("CPT IEN")    - field 21 ptr to ^ICPT
 ;    RMPR60("SITE IEN")   - ptr to prosthetic site param file 669.9
 ;    RMPR60("PAT CAT")    - Patient category
 ;                           (fld 62 see FM set of codes)
 ;    RMPR60("SPEC CAT")   - fld 63
 ;
 ;    RMPR11 - array of data fields for 661.11 record
 ;             If any changes then RMPR11("HCPCS"), RMPR11("ITEM")
 ;             and RMPR11("DESCRIPTION") must be set, otherwise only
 ;             set those fields which are being changed.
 ;    RMPR11("STATION")     - Station ien
 ;    RMPR11("HCPCS")       - HCPCS code
 ;    RMPR11("ITEM")        - Item number
 ;    RMPR11("UNIT")        - Unit (optional)
 ;    RMPR11("DESCRIPTION") - Item description
 ;    RMPR11("SOURCE")      - V - VA, C - Commercial
 ;
 ;    RMPR5 - array of data fields for 661.5 record
 ;            only set if modifying stock location
 ;    RMPR5("IEN")          - Location ien (ptr to ^RMPR(661.5,)
 ;
MOD(RMPR60,RMPR11,RMPR5) ;
 N RMPRERR,RMPR6,RMPR9,RMPR1,RMPRCSTK,RMPR,RMPRQDIF,RMPRVDIF,RMPRC5
 N RMPRC6,RMPRC60,RMPRC11,RMPRC1,RMPRC6I,RMPRC60I,RMPRC1I,RMPRIREV
 S RMPRERR=0
 S:$D(RMPR11("STATION")) RMPR11("STATION IEN")=RMPR11("STATION")
 ;
 ; STEP 1
 ; read in existing 660 and 661.6 recs.
 S RMPRC60("IEN")=RMPR60("IEN")
 M:$D(RMPR11) RMPRC11=RMPR11
 S:$D(RMPR5("IEN")) RMPRC5("IEN")=RMPR5("IEN")
 S RMPRERR=$$GET^RMPRPIX2(.RMPRC60,.RMPRC11) ;660 rec
 I RMPRERR S RMPRERR=11 G MODX^RMPRPIU2
 S RMPRERR=$$ETOI^RMPRPIX2(.RMPRC60,.RMPRC11,.RMPRC60I,.RMPRC1I)
 I RMPRERR S RMPRERR=11 G MODX^RMPRPIU2
 S RMPRC6("IEN")=RMPRC60("TRANS IEN")
 S RMPRERR=$$GET^RMPRPIX6(.RMPRC6) ;661.6 rec
 I RMPRERR S RMPRERR=12 G MODX^RMPRPIU2
 S RMPRERR=$$ETOI^RMPRPIX6(.RMPRC6,.RMPRC6I)
 I RMPRERR S RMPRERR=12 G MODX^RMPRPIU2
 S:'$D(RMPR5("IEN")) RMPRC5("IEN")=RMPRC6I("LOCATION")
 I '$D(RMPR11("STATION IEN")) D
 . S RMPRC11("STATION")=RMPRC6I("STATION")
 . S RMPRC11("STATION IEN")=RMPRC6I("STATION")
 . Q
 S:'$D(RMPR11("HCPCS")) RMPRC11("HCPCS")=RMPRC6I("HCPCS")
 S:'$D(RMPR11("ITEM")) RMPRC11("ITEM")=RMPRC6I("ITEM")
 S RMPRC60("VENDOR IEN")=$S('$D(RMPR60("VENDOR IEN")):RMPRC6I("VENDOR"),1:RMPR60("VENDOR IEN"))
 S RMPRQDIF=""
 I $D(RMPR60("QUANTITY")) S RMPRQDIF=RMPR60("QUANTITY")-RMPRC60I("QUANTITY")
 S RMPRVDIF=""
 I $D(RMPR60("COST")) S RMPRVDIF=RMPR60("COST")-RMPRC60I("COST")
 ;
 ; STEP 2
 ; if HCPCS, Item, Location, Vendor, Quanity or Cost has changed
 ; then need to go to the complex update rules at MOD3
 ; otherwise just update the 660
 S RMPRIREV=1 ;set if HCPCS, Item, Vendor or Location modified
 I RMPRC6I("HCPCS")'=RMPRC11("HCPCS") G MOD3
 I RMPRC6I("ITEM")'=RMPRC11("ITEM") G MOD3
 I RMPRC6I("VENDOR")'=RMPRC60("VENDOR IEN") G MOD3
 I RMPRC6I("LOCATION")'=RMPRC5("IEN") G MOD3
 S RMPRIREV=0 ;only qty. or cost may have changed
 I +RMPRQDIF G MOD3
 I +RMPRVDIF G MOD3
 ;
 ; if we get here just update 660 and exit
 S RMPRERR=$$UPD^RMPRPIX2(.RMPR60,.RMPR11)
 G MODX^RMPRPIU2
 ;
 ; if we get here then update is complex
MOD3 G MOD3^RMPRPIU2
 ;
 ; REVI - bring back Issue transaction into stock
REVI(RMPRC6I) ;
 Q $$REVI^RMPRPIU2(.RMPRC6I)
