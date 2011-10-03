RMPRDVN1 ;HOIFO/SPS - MANDATORY PATIENT NOTIFICATION FILE CREATE;12/11/07
 ;;3.0;PROSTHETICS;**125**;Feb 09, 1996;Build 21
 ;
DVNSFIL ; Create output files for DVN(Delivery Verification Notice)
 ;
 ; Save DVN file for FTP
 ; build file name
 N OUTFIL1
 S OUTFIL1="RMPRDVN"_STID_"F1.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFIL1,"W")  ; Open the file
 D USE^%ZISUTL("FILE1")  ; Use the file as the output device
WRT ;
 S (I,D,G,N)=""
 F  S I=$O(^TMP($J,"RMPRDVN",I)) Q:I=""  D
 . F  S D=$O(^TMP($J,"RMPRDVN",I,D)) Q:D=""  D
 .. F  S G=$O(^TMP($J,"RMPRDVN",I,D,G)) Q:G=""  D
 ... F  S N=$O(^TMP($J,"RMPRDVN",I,D,G,N)) Q:N=""  D
 .... Q:'$D(^TMP($J,"RMPRDVN",I,D,G,N))
 .... W ^TMP($J,"RMPRDVN",I,D,G,N),!
 D CLOSE^%ZISH("FILE1")  ; Close the file
 K D,G,I,N
 Q
TSTF ; Test directory for file creation
 N TFILE,OUTFILT,POP
 ; POP is returned by OPEN^%ZISH if file cannot be created.
 S POP="",RMPRERR=0
 S OUTFILT="RMPRREADME"_STID_".TXT"
 D OPEN^%ZISH("TFILE",FILEDIR,OUTFILT,"W")
 I POP  D
 . S RMPRERR=2
 . Q
 I RMPRERR'=2  D
 . D USE^%ZISUTL("TFILE")
 . W !,"$ ! This directory is used to store Prosthetics PO activity"
 . W !,"$ ! extracts which are transmitted"
 . W !,"$ EXIT"
 . D CLOSE^%ZISH("TFILE")
 . Q
 ;
CRTCOM ; Create .DAT file to transfer file(s)
 N POP,OUTFLL1
 S POP=""  ; POP is returned by OPEN^%ZISH
 S RMPRERR=0
 S OUTFLL1="RMPRDVN"_STID_"FTP.DAT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFLL1,"W")
 I POP  D
 . S RMPRERR=3
 . Q
 I RMPRERR'=3  D
 . D USE^%ZISUTL("FILE1")
 . W "put RMPRDVN"_STID_"F1.TXT",!
 . W "exit",!  ; Exit FTP
 . D CLOSE^%ZISH("FILE1")
 . Q
 Q
CRTCOM1 ; Run RMPRDVNFTP1.COM as com file for exception handling
 ;
 ;
 N OUTFLL2
 S OUTFLL2="RMPRDVN"_STID_"FTP1.COM"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFLL2,"W")
 ;U IO
 D USE^%ZISUTL("FILE1")
 W "$ SET VERIFY=(PROCEDURE,IMAGE)",!
 W "$ SET DEFAULT "_FILEDIR,!
 W "$ sftp -""B"" RMPRDVN"_STID_"FTP.DAT "_RMPRUSR_"@"_ADDR,!
 W "$ exit",!
 D CLOSE^%ZISH("FILE1")
 Q
FTPCOM ; Issue the FTP command after RMPRDVN1.TXT file is built
 ; remain in CACHE during FTP Process using
 ; $ZF(-1) call
 ; ; SACC Exception received for usage of $ZF(-1)
 ;
 ; commented out for testing
 ; add hook to mailman messaging for ftp, check variable PV
 N PV,XPV1
 ;
 ;
 S XPV1="S PV=$ZF(-1,""@"_FILEDIR_"RMPRDVN"_STID_"FTP1.COM/OUTPUT="_FILEDIR_"RMPRDVN"_STID_"FTP1.LOG"")"
 X XPV1  ; Run the .COM file to transfer files
 ;
 ; Error flag logic
 I PV=-1  D  ; This error is generated if failure during xfer occurs
 . S RMPRERR=1
 . Q
 Q
