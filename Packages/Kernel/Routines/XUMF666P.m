XUMF666P ;OIFO-BP/BATRAN - MFS parameters file ;04/21/2016
 ;;8.0;KERNEL;**666**;Jul 10, 1995;Build 1
 ;Per VHA Directive 10-92-142, this routine should not be modified
 Q
 ;----------------------------------------------
POST ; -- Entry point
 N XUMF S XUMF=1
 D 7199
 N X S X="XUMF666" X ^%ZOSF("DEL")
 K XMY
 Q
 ;----------------------------------------------
TEST ; -- Entry point
 N XUMF S XUMF=1
 S XMY("TRAN.BA_D@DOMAIN.EXT")=""
 D 7199
 K XMY
 Q
 ;---------------------------------------------
7199 ; FILE 71.99 MASTER RADIOLOGY PROCEDURE FILE
 N XFIEN,XFILE
 S XFIEN=71.99
 S XFILE="Radiology Procedures"
 D DEL^XUMF666(XFIEN) ; delete entry
 D ADD^XUMF666(XFIEN,".03;Radiology Procedures].07;Radiology Procedures") ; add entry
 D NODES^XUMF666(XFIEN,"DATA7199",8) ; call ADD1 to add sub_entry
 D DELMD5^XUMF666(XFILE)
 D ADDMD5^XUMF666(XFILE,XFIEN)
 D SCMD5^XUMF666(XFILE,XFIEN)
 D SUBMD5^XUMF666(XFILE,".01^20^^^",XFIEN,.01)
 D SUBMD5^XUMF666(XFILE,"1^30^^^",XFIEN,1)
 D SUBMD5^XUMF666(XFILE,"2^40^^^",XFIEN,2)
 D SUBMD5^XUMF666(XFILE,"2.2^70^^^",XFIEN,2.2)
 D SUBMD5^XUMF666(XFILE,"2.3^50^^^",XFIEN,2.3)
 D SUBMD5^XUMF666(XFILE,"3^60^^^",XFIEN,3)
 D SUBMD5^XUMF666(XFILE,"99.97^80^^71.99^",XFIEN,99.97)
 D SUBMD5^XUMF666(XFILE,"99.99^10^^^",XFIEN,99.99)
 Q
