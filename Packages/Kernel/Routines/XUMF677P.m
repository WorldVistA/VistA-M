XUMF677P ;OIFO-BP/BATRAN - MFS parameters file ;09/26/2017
 ;;8.0;KERNEL;**677**;Jul 10, 1995;Build 9
 ;Per VHA Directive 10-92-142, this routine should not be modified
 Q
 ;----------------------------------------------
POST ; -- Entry point
 N XUMF S XUMF=1
 D 89321
 N X S X="XUMF677" X ^%ZOSF("DEL")
 K XMY
 Q
 ;----------------------------------------------
TEST ; -- Entry point
 N XUMF S XUMF=1
 S XMY("G.XUPATH@DOMAIN.EXT")=""
 D 89321
 K XMY
 Q
 ;---------------------------------------------
89321 ; FILE #8932.1 PERSON CLASS
 N XFIEN,XFILE
 S XFIEN=8932.1
 S XFILE="Person Class"
 D DEL^XUMF677(XFIEN) ; delete entry
 D ADD^XUMF677(XFIEN,".03;Person Class].07;Person Class]5;D ZRT^XUPCZRT]2;D P89321^XUPCZRT]6;D D89321^XUPCZRT") ; add entry
 D NODES^XUMF677(XFIEN,"DATA89",10) ; call ADD1 to add sub_entry
 D DELMD5^XUMF677(XFILE)
 D ADDMD5^XUMF677(XFILE,XFIEN)
 D SCMD5^XUMF677(XFILE,XFIEN)
 D SUBMD5^XUMF677(XFILE,".01^20^^^",XFIEN,.01)
 D SUBMD5^XUMF677(XFILE,"1^60^^^",XFIEN,1)
 D SUBMD5^XUMF677(XFILE,"2^50^^^",XFIEN,2)
 D SUBMD5^XUMF677(XFILE,"5^30^^^",XFIEN,5)
 D SUBMD5^XUMF677(XFILE,"6^40^^^",XFIEN,6)
 D SUBMD5^XUMF677(XFILE,"8^70^^^",XFIEN,8)
 D SUBMD5^XUMF677(XFILE,"11^80^^^",XFIEN,11)
 D SUBMD5^XUMF677(XFILE,"99.97^90^^8932.1^",XFIEN,99.97)
 D SUBMD5^XUMF677(XFILE,"99.99^10^^^",XFIEN,99.99)
 D SUBMD5^XUMF677(XFILE,"90002^65^I^^",XFIEN,90002)
 ;----------------------------------------------------
