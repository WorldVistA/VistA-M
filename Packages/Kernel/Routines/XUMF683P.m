XUMF683P ;OIFO-BP/BATRAN - MFS parameters file ; 07/27/2017
 ;;8.0;KERNEL;**683**;Jul 10, 1995;Build 8
 ;Per VHA Directive 10-92-142, this routine should not be modified
 Q
 ;----------------------------------------------
POST ; -- Entry point
 N XUMF S XUMF=1
 D 35599
 N X S X="XUMF683" X ^%ZOSF("DEL")
 K XMY
 Q
 ;----------------------------------------------
TEST ; -- Entry point
 N XUMF S XUMF=1
 D 35599
 K XMY
 Q
 ;
35599 ;FILE 355.99 
 ; FILE 4.001
 N XFIEN,XFILE,XUIENOLD,XUMAIL,XUIEN
 S XFIEN=355.99
 S XFILE="Plans"
 D DEL^XUMF683(XFIEN) ; delete entry
 D ADD^XUMF683(XFIEN,".03;Plans].07;Plans]",355.99) ; add entry
 D NODES^XUMF683(XFIEN,"DATA355",5) ; call ADD1 to add sub_entry
 D ADD2^XUMF683(XFIEN,"VistA_Mapping_Target",1,"1^VistA_Mapping_Target^.01^^")
 ; file 4.005
 D DELMD5^XUMF683(XFILE)
 D ADDMD5^XUMF683(XFILE,XFIEN)
 S XFIEN=355.99
 D SCMD5^XUMF683(XFILE,XFIEN)
 D SUBMD5^XUMF683(XFILE,".01^20^^^",XFIEN,.01) ;
 D SUBMD5^XUMF683(XFILE,"1^30^^^",XFIEN,1) ;
 D SUBMD5^XUMF683(XFILE,"2^40^^355.99^",XFIEN,2) ;
 D SUBMD5^XUMF683(XFILE,"99.97^50^^355.99^",XFIEN,99.97) ;
 D SUBMD5^XUMF683(XFILE,"99.99^10^^^",XFIEN,99.99) ;
 Q
 ;
