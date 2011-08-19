DGROHLR1 ;GTS/PHH,TDM - ROM HL7 RECEIVE DRIVERS ; 9/29/09 2:08pm
 ;;5.3;Registration;**572,622,647,809,754**;Aug 13, 1993;Build 46
 ;
CONVFDA(DFN,DGDATA) ; LOOP THROUGH DATA TO FILE
 N DFNC,F,IEN,FIELD,DGROAR,FNUM,QVAR,INX,DGRONUPD
 ;
 ;*DGROAR: Indirect reference to DGROAYi where "i" is the ORDER INDEX
 ;* field value in 391.23.  ORDER INDEX defines order for a group of
 ;* fields loaded into the LST.
 ;* DGROAYi defined for each group maintaining proper order.
 ;*  DG*5.3*572
 ;* DGRONUPD flag used to suppress updating the 'CHANGE DT/TM' &
 ;*          'CHANGE SITE' fields for CONF & TEMP address data.
 ;
 S DFNC=DFN_","
 S INX=""
 S DGRONUPD=1
 F  S INX=$O(^DGRO(391.23,"D",INX)) Q:INX=""  D
 . S DGROAR="DGROAY"_INX
 . S QVAR=0
 . S F=""
 . F  S F=$O(@DGDATA@(F)) Q:F=""  D
 . . S IEN=""
 . . F  S IEN=$O(@DGDATA@(F,IEN)) Q:IEN=""  D
 . . . S FIELD=""
 . . . F  S FIELD=$O(@DGDATA@(F,IEN,FIELD)) Q:FIELD=""  D
 . . . . Q:$$DIS(F,FIELD)
 . . . . S ORDINX=$O(^DGRO(391.23,"E",F,FIELD,""))
 . . . . D:(ORDINX=INX) SETARY
 . . . . ;* Following line files Internal PEC, Rmv once Ext PEC is filed
 . . . . I (ORDINX=INX)&(F=2) DO
 . . . . .D:(FIELD=.1417) FILECSTD
 . . . . .D:(FIELD=.361) FILEPEC
 . . . . .D:((FIELD=.117)!(FIELD=.12111)!(FIELD=.14111)) FILECNTY
 . . I (+$O(@DGROAR@(""))>0) S QVAR=1 D FILE
 Q
 ;
FILECSTD ;File CONFIDENTIAL START DATE bypassing FM restrictions
 ;Called from CONVFDA^DGROHLR1
 I $D(@DGROAR@(F,DFNC,FIELD)) D
 . S X=@DGROAR@(F,DFNC,FIELD)
 . S %DT="X" D ^%DT I Y D
 . . S DGROCST(F,DFNC,FIELD)=Y
 . . D FILE^DIE("U","DGROCST","ERR")
 . K @DGROAR@(F,DFNC,FIELD)
 . K DGROCST,X,%DT,Y
 Q
 ;
FILECNTY ;*Retrieve county IEN and file county
 ;*Retrieve State IEN corresponding to Temp, Conf, or Perm State
 I (FIELD=.117),($D(^DPT(DFN,.11))) S STATEIEN=$P(^DPT(DFN,.11),"^",5)
 I (FIELD=.12111),($D(^DPT(DFN,.121))) S STATEIEN=$P(^DPT(DFN,.121),"^",5)
 I (FIELD=.14111),($D(^DPT(DFN,.141))) S STATEIEN=$P(^DPT(DFN,.141),"^",5)
 ;
 ;*Retrieve County IEN for exact county returned from LST
 ; DG*647
 I $G(STATEIEN)="" G NOCNTY
 I '$D(@DGROAR@(F,DFNC,FIELD)) G NOCNTY
 S DIC="^DIC(5,"_STATEIEN_",1,"
 S DIC(0)="XS"
 S X=@DGROAR@(F,DFNC,FIELD)
 D ^DIC
 S DGROCTY(F,DFNC,FIELD)=+Y
 D FILE^DIE("","DGROCTY","ERR") ;File County IEN
NOCNTY K @DGROAR@(F,DFNC,FIELD)
 K STATEIEN,DGROCTY
 Q
 ;
FILEPEC ;File Internal value of Prim Elig Code
 ;Called from CONVFDA^DGROHLR1
 ;Remove this call when fields required by PEC are received
 ; from LST
 I $D(@DGROAR@(F,DFNC,FIELD)) DO
 . S DIC="^DIC(8,"
 . S DIC(0)="MNSX"
 . S X=@DGROAR@(F,DFNC,FIELD)
 . D ^DIC
 . S DGROPEC(F,DFNC,FIELD)=+Y
 . D FILE^DIE("","DGROPEC","ERR")
 . K @DGROAR@(F,DFNC,FIELD)
 . K DGROPEC,DIC,X
 Q
 ;
FILE ;*Execute FILE or UPDATE per FNUM (1st subscpt) for file # according
 ;* to file/multiple record add or adding existing Patient data add
 S FNUM=$O(@DGROAR@(""))
 K %DT ;* Clean up leaks from Input transforms that set %DT(0)
 ;
 ;* Patient file processing
 I +FNUM=2 DO
 . D FILE^DIE("E","@DGROAR","ERR") ;*Add to existing Patient entry
 ;
 ;* Patient file multiples processing
 I (+FNUM=2.01)!(+FNUM=2.141)!(+FNUM=2.11) DO
 . D UPDATE^DIE("E","@DGROAR","","ERR")
 I (+FNUM=2.02)!(+FNUM=2.06) DO
 . N DGRODNUM,DGIEN,DNUMDATA,DGIEN2,DGROIEN
 . S DGRODNUM=0
 . F  S DGRODNUM=$O(@DGROAR@(+FNUM,DGRODNUM)) Q:DGRODNUM=""  D
 . . S DGIEN=$P(DGRODNUM,",")
 . . I DGIEN S DGIEN2=$P(DGIEN,"+",2)
 . . S DNUMDATA=$G(@DGROAR@(+FNUM,DGRODNUM,.01))
 . . I DGIEN2 S DGROIEN(DGIEN2)=DNUMDATA D
 . . . D UPDATE^DIE("","@DGROAR","DGROIEN","ERR") ;*Converted Ext to Int
 ;
 ;* Processing fields [indicated in 391.23] not part of Patient file.
 ;* Define IF section for each file not a Patient file field or
 ;* Multiple.
 I (+$P(FNUM,".")'=2) DO
 . I +FNUM=38.1 DO
 . . N DGROARBI
 . . S DGROARBI(1)=DFN ;*Set 38.1 IEN to DFN
 . . D UPDATE^DIE("E","@DGROAR","DGROARBI","ERR")
 ;
 K @DGROAR
 Q
 ;
SETARY ;* Setup arrays of data to be filed
 N U,D,DATA,NODE,NODE2,INENNUM
 ;
 I '$D(^DGRO(391.23,"C",F,FIELD)) Q
 ;
 S U="^"
 ;
 ;CHECK LOCAL PATIENT FILE FOR EXISTING DATA, DO NOT OVERWRITE
 S D=$$GET1^DIQ(F,DFNC,FIELD)
 I D'="" K @DGDATA@(F,IEN,FIELD) Q
 ;
 S DATA=$G(@DGDATA@(F,IEN,FIELD,"E"))
 Q:DATA=""
 ;
 ;* Design of this Subroutine:
 ;* Set array defining groups of date for Fileman filing in
 ;*  a predefined order.
 ;* Indirection defined various array names for different ordered
 ;*  data groups in CONVFDA.
 ;* File Ext. values returned from LST per ORDER INDEX.
 ;* DG*5.3*572
 ;
 ;* Get field entry IEN in ROM 391.23 file
 S INENNUM=INX
 ;
 I F=2 DO  Q
 . S @DGROAR@(F,DFNC,FIELD)=DATA ;*Indirection to Patient Array
 . K @DGDATA@(F,IEN,FIELD)
 ;
 ;* Set array for all other files (not Patient or Security files)
 ;* This section is for new entries in files.  Not for Multiples.
 ;*  Code to process specific files needed in CONVFDA
 I (+$P(F,".")'=2),(F'=38.1) DO  Q
 . S @DGROAR@(F,"+1,",FIELD)=DATA
 . K @DGDATA@(F,IEN,FIELD)
 ;
 ;SET ALIAS AND CONFIDENTIAL ADDRESS CAT. SUBFILE ARRAYS
 I (F=2.01)!(F=2.141)!(F=2.11) D  Q
 . S NODE2="+"
 . S NODE2=NODE2_$P(IEN,",")_","_DFNC
 . S @DGROAR@(F,NODE2,FIELD)=DATA ;*Indirection to Patient Array
 . K @DGDATA@(F,IEN,FIELD)
 ;
 ;SET RACE AND ETHNICITY ARRAYS
 I (F=2.02)!(F=2.06) D  Q
 . N REFILE,REIEN,DATA30,QFL,DATACOMP,TEST,ERR,INACTIVE
 . I (F=2.02),(FIELD=.01) S REFILE=10
 . I (F=2.06),(FIELD=.01) S REFILE=10.2
 . I FIELD=.02 S REFILE=10.3
 . S DATA30=$E(DATA,1,30) D
 . . S QFL=0,REIEN="",NODE=""
 . . D FIND^DIC(REFILE,"","@;.01;200","",DATA30,,"B","","","TEST","ERR")
 . . F  S NODE=$O(TEST("DILIST",2,NODE)) Q:'NODE  D  Q:$G(QFL)=1
 . . . S REIEN=$G(TEST("DILIST",2,NODE))
 . . . S INACTIVE=$G(TEST("DILIST","ID",NODE,200))
 . . . Q:INACTIVE="YES"  ;* QUIT if Race or Eth Inact
 . . . S DATACOMP=$G(TEST("DILIST","ID",NODE,.01))
 . . . I DATACOMP=DATA S QFL=1
 . Q:'QFL
 . Q:$G(INACTIVE)="YES"  ;* No entry for Inactive Race/Ethncty
 . S DATA=REIEN ;*Race/Ethncty/MOC (10/10.2/10.3) IEN for data recvd
 . ;
 . S NODE2="+" ;*+ for all fields, All fields added in one UPDATE
 . S NODE2=NODE2_$P(IEN,",")_","_DFNC ;*No + for DFNC, DPT record exists
 . S @DGROAR@(F,NODE2,FIELD)=DATA ;*Indirection to Patient Array
 . K @DGDATA@(F,IEN,FIELD)
 ;
 ;* Set all sensitive fields (38.1) in array
 I F=38.1 D  Q
 . Q:('$D(@DGDATA@(F)))  ;*Data already filed
 . S FIELD=.01
 . S @DGROAR@(F,"+1,",FIELD)=$$GET1^DIQ(2,DFN,.01)
 . F  S FIELD=$O(@DGDATA@(F,IEN,FIELD)) Q:'FIELD  D
 . . S @DGROAR@(F,"+1,",FIELD)=@DGDATA@(F,IEN,FIELD,"E")
 . K @DGDATA@(F,IEN)
 . S FIELD=999999 ;*Skip to end of 38.1 field list in @DGDATA
 Q
 ;
DIS(F,FIELD) ;Check for disabled
 N SUB S SUB=$O(^DGRO(391.23,"C",F,FIELD,0)) Q:'SUB 1
 I $P($G(^DGRO(391.23,SUB,0)),"^",5)=1 Q 1
 Q 0
