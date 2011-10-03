PXRMDBL1 ; SLC/PJH - Reminder Dialog Generation. ;04/19/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;Build Reminder Dialog
 ;---------------------
BUILD(REM,NAME,ARRAY) ;
 ;Lock the entire file
 L +^PXRMD(801.41):30
 E  W !!,?5,"Another user is editing this file, try later" H 4 Q
 ;
 N ACNT,ASUB,ATXT,CNT,DATA,DIEN,DNAME,DNODE,FGLOB,FITEM,FNODE,FSUB,FTYP
 N INAME,MIEN,MSUB,PNAME,RESN,RNAME,RNODE,RPRE,RREQ,RSHORT,RSUB,RSUF
 N TDMOD,TDPAR,TDX,TITEM,TPMOD,TPPAR,TPR,TSEQ,TSUB,TTYP
 N TDHTXT,TDTXT,TPHTXT,TPTXT
 N WPTXT,DSET,DSHORT
 W !!,"Building dialog  - "_NAME
 ;
 ;Upper and lower case transforms
 N LOWER,UPPER
 S LOWER="abcdefghijklmnopqrstuvwxyz"
 S UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 ;
 ;Build index of finding type to globals
 N DEF,DEF1,DEF2 D DEF^PXRMRUTL("811.902",.DEF,.DEF1,.DEF2)
 ;
 ;Save name for use in building SET
 S DSET(1)=NAME
 ;
 ;Get findings for this reminder
 S FSUB=0,CNT=0
 F  S FSUB=$O(^PXD(811.9,REM,20,FSUB)) Q:'FSUB  D
 .S DATA=$G(^PXD(811.9,REM,20,FSUB,0)) Q:DATA=""
 .;Single finding
 .S RESN=$P(DATA,U)
 .I $P(RESN,";",2)'="PXRMD(811.5," D FIND^PXRMDBL2(DATA) Q
 .;Terms - 1st check finding item dialog file
 .I $D(^PXRMD(801.43,"AC",RESN)) D  Q:DIEN
 ..S DIEN=$$OK(RESN) Q:'DIEN
 ..;Create array used to build reminder dialog
 ..S CNT=CNT+1,ARRAY(CNT)=801.43_U_DIEN
 ..W !!,CNT,?5,"Finding item dialog "_$$FNAM(RESN)
 .;Else process all the term findings
 .S MIEN=$P($P(DATA,U),";") Q:'MIEN
 .S MSUB=0
 .F  S MSUB=$O(^PXRMD(811.5,MIEN,20,MSUB)) Q:'MSUB  D
 ..S DATA=$G(^PXRMD(811.5,MIEN,20,MSUB,0)) Q:DATA=""
 ..D FIND^PXRMDBL2(DATA)
 ;
 ;Update dialog file from FDA
 D ^PXRMDBL3
 ;Unlock the file
 L -^PXRMD(801.41)
 Q
 ;
 ;Get Finding Item name
 ;---------------------
FNAM(FIND) ;
 N DATA,GLOB,NAME,NODE
 S NAME="Unknown"
 S NODE=$O(^PXRMD(801.43,"AC",FIND,"")) Q:'NODE NAME
 S DATA=$G(^PXRMD(801.43,NODE,0)) Q:DATA="" NAME
 I $P(DATA,U)'="" S NAME=$P(DATA,U)
 S GLOB=$P($P(FIND,U),";",2) S:GLOB]"" NAME=$G(DEF1(GLOB))_" - "_NAME
 Q NAME
 ;
 ;Checks if an enabled finding item dialog exists
 ;-----------------------------------------------
OK(FIND) ;
 N DATA,DIEN,DTYP,NODE
 S NODE=$O(^PXRMD(801.43,"AC",FIND,"")) Q:'NODE 0
 S DATA=$G(^PXRMD(801.43,NODE,0)) Q:DATA="" 0
 ;Ignore disabled entries
 I $P(DATA,U,3) Q 0
 ;Ignore finding item dialogs no longer valid
 S DIEN=$P(DATA,U,4) Q:DIEN="" 0
 S DATA=$G(^PXRMD(801.41,DIEN,0)) Q:DATA="" 0
 ;Ignore disabled dialogs
 I $P(DATA,U,3)=1 Q 0
 ;Return dialog ien
 Q DIEN
