XUMF665P ;OIFO-BP/BATRAN - MFS parameters file ;04/21/2016
 ;;8.0;KERNEL;**665**;Jul 10, 1995;Build 1
 ;Per VHA Directive 10-92-142, this routine should not be modified
 Q
 ;----------------------------------------------
POST ; -- Entry point
 N XUMF S XUMF=1
 D 663
 N X S X="XUMF665" X ^%ZOSF("DEL")
 K XMY
 Q
 ;----------------------------------------------
TEST ; -- Entry point
 N XUMF S XUMF=1
 S XMY("TRAN.BA_D@DOMAIN.EXT")=""
 D 663
 K XMY
 Q
 ;---------------------------------------------
663 ; FILE 66.3 MASTER LABORATORY TEST FILE
 N XFIEN,XFILE
 S XFIEN=66.3
 S XFILE="Laboratory Tests"
 D DEL^XUMF665(XFIEN) ; delete entry
 D ADD^XUMF665(XFIEN,".03;Laboratory Tests].07;Laboratory Tests") ; add entry
 D NODES^XUMF665(XFIEN,"DATA663",11) ; call ADD1 to add sub_entry
 D DELMD5^XUMF665(XFILE)
 D ADDMD5^XUMF665(XFILE,XFIEN)
 D SCMD5^XUMF665(XFILE,XFIEN)
 D SUBMD5^XUMF665(XFILE,".01^20^^^",XFIEN,.01)
 D SUBMD5^XUMF665(XFILE,".02^100^^^",XFIEN,.02)
 D SUBMD5^XUMF665(XFILE,".04^90^^^",XFIEN,.04)
 D SUBMD5^XUMF665(XFILE,".05^30^^^",XFIEN,.05)
 D SUBMD5^XUMF665(XFILE,".06^50^^^",XFIEN,.06)
 D SUBMD5^XUMF665(XFILE,".07^80^^^",XFIEN,.07)
 D SUBMD5^XUMF665(XFILE,".08^70^^^",XFIEN,.08)
 D SUBMD5^XUMF665(XFILE,".09^60^^^",XFIEN,.09)
 D SUBMD5^XUMF665(XFILE,"1^40^^^",XFIEN,1)
 D SUBMD5^XUMF665(XFILE,"99.97^110^^66.3^",XFIEN,99.97)
 D SUBMD5^XUMF665(XFILE,"99.99^10^^^",XFIEN,99.99)
 Q
 ;----------------------------------------------------
