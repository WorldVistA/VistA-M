PRCHLO4 ;WOIFO/RLL/DAP-EXTRACT ROUTINE CLO REPORT SERVER ;12/30/10  15:01
 ;;5.1;IFCAP;**83,98,130,154**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ; Continuation of PRCHLO3
 ;
 ; PRCHLO3 routines are used to Write out the Header and data
 ; associated with each of the 29 tables created for the Clinical
 ; logistics Report Server. The files are built from the extracts
 ; located in the ^TMP($J) global.
 ;
 Q
GETDIR ; Get directory from System parameter for CLRS
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 ;
 Q
CLRSFIL ; Create output files for CLRS
 N FILEDIR
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 ; GET station id
 N STID
 ; S STID=$G(^DD("SITE",1)) Old call
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
TSTFIL ; Test entry point
 ;
 D POMASTF  ; Po Master Data
 D POOBF  ; Po Obligation Data
 D POMETHF  ; PO Method of Purchase Data
 D PODISCF  ; PO Discount Data
 D POITMF  ; Po Item Data
 D POITIVF  ; PO Item Inventory Point Data
 D POITDRF  ; PO Item Desc Data
 D PODSCF  ; PO Description
 D POPRTF  ; PO Partial Data
 D PO2237F  ; PO 2237 data
 D POBOCF  ; PO BOC Data
 D POCOMF  ; PO Comments data
 D POREMF  ; PO Remarks data
 D POPPTF  ; PO Prompt Payment Terms data
 D POAMTF  ; PO Amount data
 D POAMDF  ; PO Amendment Data
 D POAMDCF  ; PO Amendment Changes Data
 D POAMDDF  ; PO Amendment Description Data
 D POAMBKF  ; PO Amount Breakout Code Data
 D FIL410   ; FILE 410
 D FIL424   ; FILE 424
 D FIL4241  ; FILE 424.1
 D INVHDR^PRCHLO7 ;File 421.5 header
 D INVPAY^PRCHLO7 ;Subfile 421.531
 D INVFMS^PRCHLO7 ;Subfile 421.541
 D INVCERT^PRCHLO7 ;Subfile 421.51
GIPBL1 ; GIP REPORTS
 D BLDGP1^PRCPLO3
 D BLDGP2^PRCPLO3
 Q
POMASTF ; Save PO Master table data to a file to FTP to report Server
 ; build file name
 N OUTFIL1
 S OUTFIL1="IFCP"_STID_"F1.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL1,"W")  ; Open the file
 D USE^%ZISUTL("FILE1")  ; Use the file as the output device
 D POMASTH^PRCHLO3   ; Write the Header to the file
 D POMASTW^PRCHLO3   ; Write the data to the file
 D CLOSE^%ZISH("FILE1")  ; Close the file
 Q
POOBF ; Create flat file for PO OBLIGATION DATA
 N OUTFIL2
 S OUTFIL2="IFCP"_STID_"F2.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL2,"W")  ; Open the file
 D USE^%ZISUTL("FILE1")  ; Use the file as the output device
 D POOBHD^PRCHLO3
 D POOBW^PRCHLO3
 D CLOSE^%ZISH("FILE1")  ; Close the file
 Q
POMETHF ; Create flat for for Purchase Order Method
 N OUTFIL3
 S OUTFIL3="IFCP"_STID_"F3.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL3,"W")  ; Open the file
 D USE^%ZISUTL("FILE1")  ; Use the file as the output device
 D POPMEH^PRCHLO3
 D POPMEW^PRCHLO3
 D CLOSE^%ZISH("FILE1")  ; Close the file
 Q
PODISCF ; Create flat file for Purchase Order Discount
 N OUTFIL4
 S OUTFIL4="IFCP"_STID_"F4.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL4,"W")  ; Open the file
 D USE^%ZISUTL("FILE1")
 D PODISCH^PRCHLO1
 D PODISCW^PRCHLO1
 D CLOSE^%ZISH("FILE1")
 Q
POITMF ; Create flat file for PO Item data
 N OUTFIL5
 S OUTFIL5="IFCP"_STID_"F5.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL5,"W")  ; Open the file
 D USE^%ZISUTL("FILE1")
 D POITEMH^PRCHLO2
 D POITEMW^PRCHLO2
 D CLOSE^%ZISH("FILE1")
 Q
POITIVF ; Create flat file for PO Item inv. point data
 N OUTFIL6
 S OUTFIL6="IFCP"_STID_"F6.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL6,"W")  ; Open the file
 D USE^%ZISUTL("FILE1")
 D POITLNH^PRCHLO2
 D POITLNW^PRCHLO2
 D CLOSE^%ZISH("FILE1")
 Q
POITDRF ; Create flat file for PO Item date received
 N OUTFIL7
 S OUTFIL7="IFCP"_STID_"F7.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL7,"W")  ; Open the file
 D USE^%ZISUTL("FILE1")
 D POITDRCH^PRCHLO2
 D POITDRCW^PRCHLO2
 D CLOSE^%ZISH("FILE1")
 Q
PODSCF ; Create flat file for PO item description
 N OUTFIL8
 S OUTFIL8="IFCP"_STID_"F8.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL8,"W")  ; Open the file
 D USE^%ZISUTL("FILE1")
 D POITDSH^PRCHLO2
 D POITDSW^PRCHLO2
 D CLOSE^%ZISH("FILE1")
 Q
POPRTF ; Create flat file for PO Partial data
 N OUTFIL9
 S OUTFIL9="IFCP"_STID_"F9.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL9,"W")  ; Open the file
 D USE^%ZISUTL("FILE1")
 D POPART^PRCHLO3
 D POPARTW^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
PO2237F ; Create flat file for 2237 data
 N OUTFIL10
 S OUTFIL10="IFCP"_STID_"F10.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL10,"W")  ; Open the file
 D USE^%ZISUTL("FILE1")
 D PO2237H^PRCHLO3
 D PO2237W^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
POBOCF ; Create flat file for PO BOC data
 N OUTFIL11
 S OUTFIL11="IFCP"_STID_"F11.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL11,"W")
 D USE^%ZISUTL("FILE1")
 D POBOCH^PRCHLO3
 D POBOCW^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
POCOMF ; Create flat file for PO Comments
 N OUTFIL12
 S OUTFIL12="IFCP"_STID_"F12.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL12,"W")
 D USE^%ZISUTL("FILE1")
 D POCMTSH^PRCHLO3
 D POCMTSW^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
POREMF ; Create flat file for PO Remarks
 N OUTFIL13
 S OUTFIL13="IFCP"_STID_"F13.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL13,"W")
 D USE^%ZISUTL("FILE1")
 D PORMKH^PRCHLO3
 D PORMKW^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
POPPTF ; Create flat file for PO Prompt payment terms data
 N OUTFIL14
 S OUTFIL14="IFCP"_STID_"F14.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL14,"W")
 D USE^%ZISUTL("FILE1")
 D POPPTH^PRCHLO3
 D POPPTW^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
POAMTF ; Create flat file for PO Amount data
 N OUTFIL15
 S OUTFIL15="IFCP"_STID_"F15.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL15,"W")
 D USE^%ZISUTL("FILE1")
 D POAMTH^PRCHLO3
 D POAMTW^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
POAMDF ; Create flat file for PO Amendment data
 N OUTFIL16
 S OUTFIL16="IFCP"_STID_"F16.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL16,"W")
 D USE^%ZISUTL("FILE1")
 D POAMDH^PRCHLO3
 D POAMDW^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
POAMDCF ; Create flat file for PO Amendment changes
 N OUTFIL17
 S OUTFIL17="IFCP"_STID_"F17.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL17,"W")
 D USE^%ZISUTL("FILE1")
 D POAMDCH^PRCHLO3
 D POAMDCW^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
POAMDDF ; Create flat file for PO Amendment Desc data
 N OUTFIL18
 S OUTFIL18="IFCP"_STID_"F18.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL18,"W")
 D USE^%ZISUTL("FILE1")
 D PAMDDH^PRCHLO3
 D PAMDDW^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
POAMBKF ; Create flat file for PO amount breakout code
 N OUTFIL19
 S OUTFIL19="IFCP"_STID_"F19.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL19,"W")
 D USE^%ZISUTL("FILE1")
 D PAMTBKH^PRCHLO3
 D PAMTBKW^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
FIL410 ; Create flat file for file 410 (Control Point Activity)
 N OUTFIL20
 S OUTFIL20="IFCP"_STID_"F20.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL20,"W")
 D USE^%ZISUTL("FILE1")
 D CONTRPH^PRCHLO3
 D CONTRPW^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 N OUTFIL21
 S OUTFIL21="IFCP"_STID_"F21.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL21,"W")
 D USE^%ZISUTL("FILE1")
 D SUBCPH^PRCHLO3
 D SUBCPW^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
FIL424 ; Create flat file for file 424 (1358 Daily Record)
 N OUTFIL22
 S OUTFIL22="IFCP"_STID_"F22.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL22,"W")
 D USE^%ZISUTL("FILE1")
 D DR1358H^PRCHLO3
 D DR1358W^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
FIL4241 ;Create flat file for file 424.1 (1358 Authorization Detail)
 N OUTFIL23
 S OUTFIL23="IFCP"_STID_"F23.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL23,"W")
 D USE^%ZISUTL("FILE1")
 D AD1358H^PRCHLO3
 D AD1358W^PRCHLO3
 D CLOSE^%ZISH("FILE1")
 Q
TSTF ; Test directory for file creation
 N FILEDIR,TFILE,OUTFILT,POP,STID
 ; POP is returned by OPEN^%ZISH if file cannot be created.
 S POP=""
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S OUTFILT="CLRSREADME"_STID_".TXT"
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 D OPEN^%ZISH("TFILE",FILEDIR,OUTFILT,"W")
 I POP  D
 . S CLRSERR=2
 . Q
 I CLRSERR'=2  D
 . D USE^%ZISUTL("TFILE")
 . W !,"$ ! This directory is used to store PO activity"
 . W !,"$ ! extracts and GIP Extracts which are transmitted"
 . W !,"$ ! to the Clinical Logistics Report Server on a monthly"
 . W !,"$ ! basis. There are 29 extract files IFCPXXXF1 through"
 . W !,"$ ! IFCPXXXF27, IFCPXXXG1 and IFCPXXXG2. In addition, there"
 . W !,"$ ! are 2 working files used for the FTP Transfer:"
 . W !,"$ ! CLRSxxx.DAT and CLRS1xxx.COM. CLRSREADMExxx.TXT is also present"
 . W !,"$ EXIT"
 . D CLOSE^%ZISH("TFILE")
 . Q
 Q
 ;
CRTCOM ; Create .DAT file to transfer file(s)
 N FILEDIR,POP,STID,OUTFLL1
 ; PRC*5.1*130 begin
 N PRCHUSN,PRCHPSW
 S PRCHUSN=$$GET^XPAR("SYS","PRCPLO USER NAME",1,"Q")
 I PRCHUSN="" S PRCPMSG(1)="There is no user name identified in the CLRS USER NAME Parameter.",PRCPMSG(2)="Please correct and retry." D MAILFTP^PRCHLO4A S CLRSERR=3 Q
 S PRCHUSN=$$DECRYP^XUSRB1(PRCHUSN)
 S PRCHPSW=$$GET^XPAR("SYS","PRCPLO PASSWORD",1,"Q")
 I PRCHPSW="" S PRCPMSG(1)="There is no password identified in the CLRS PASSWORD Parameter.",PRCPMSG(2)="Please correct and retry." D MAILFTP^PRCHLO4A S CLRSERR=3 Q
 S PRCHPSW=$$DECRYP^XUSRB1(PRCHPSW)
 ; PRC*5.1*130 end
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S POP=""  ; POP is returned by OPEN^%ZISH
 ; S FILEDIR="$1$DGA2:[ANONYMOUS.CLRS]"  ;set dir for outpt files.
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 S OUTFLL1="CLRS"_STID_"FTP.DAT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFLL1,"W")
 I POP  D
 . S CLRSERR=3
 . Q
 I CLRSERR'=3  D
 . D USE^%ZISUTL("FILE1")
 . ; Enter user name and password for Report Server Login ; PRC*5.1*130
 . W PRCHUSN,!,PRCHPSW,!
 . W "SET DEFAULT /LOCAL "_FILEDIR,!
 . W "PUT IFCP"_STID_"*.*;*",!  ; new code to issue PUT command
 . W "EXIT",!  ; Exit FTP
 . D CLOSE^%ZISH("FILE1")
 . Q
 Q
CRTCOM1 ; Run CLRSFTP1.COM as com file for exception handling
 ;
 ;*98 Modified code to work with PRC CLRS ADDRESS parameter
 ;
 N FILEDIR,STID,OUTFLL2,ADDR
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 S ADDR=$$GET^XPAR("SYS","PRC CLRS ADDRESS",1,"Q")
 I ADDR="" S PRCPMSG(1)="There is no address identified in the CLRS Address Parameter.",PRCPMSG(2)="Please correct and retry." D MAILFTP^PRCHLO4A S CLRSERR=1 Q
 S OUTFLL2="CLRS"_STID_"FTP1.COM"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFLL2,"W")
 D USE^%ZISUTL("FILE1")
 W "$ SET VERIFY=(PROCEDURE,IMAGE)",!
 W "$ SET DEFAULT "_FILEDIR,!
 W "$ FTP "_ADDR_" /INPUT="_FILEDIR_"CLRS"_STID_"FTP.DAT",!
 ;
 W "$ EXIT 3",!
 D CLOSE^%ZISH("FILE1")
 Q
FTPCOM ; Issue the FTP command after CLRS1.TXT file is built
 ; remain in CACHE during FTP Process using
 ; $ZF(-1) call
 ; ; SACC Exception received for usage of $ZF(-1) in PRC*5.1*83
 ; See IFCAP technical manual
 ;
 ; commented out for testing
 ; add hook to mailman messaging for ftp, check variable PV
 N PV,XPV1,FILEDIR,STID
 ;
 ;
 S FILEDIR=$$GET^XPAR("SYS","PRCPLO EXTRACT DIRECTORY",1,"Q")
 S STID=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S XPV1="S PV=$ZF(-1,""@"_FILEDIR_"CLRS"_STID_"FTP1.COM/OUTPUT="_FILEDIR_"CLRS"_STID_"FTP1.LOG"")"
 X XPV1  ; Run the .COM file to transfer files
 ;
 ; Error flag logic
 I PV=-1  D  ; This error is generated if failure during xfer occurs
 . S CLRSERR=1
 . Q
 Q
