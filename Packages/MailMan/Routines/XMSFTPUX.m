XMSFTPUX ;(WASH ISC)/CAP-TCP/IP-FTP Sender ;04/17/2002  11:30
 ;;8.0;MailMan;;Jun 28, 2002
 ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ;XXX/KCMO - Modified for UCX, added a field to the network location
 ;file called 'maps to reference' that can be used to map the DOS 
 ;locations to Unix/VMS references.
 ;-----------------------------------------------------------------
 ;
 ;TCP/IP-FTP COMMUNICATIONS
 ;Send file via FTP / File located on another TCP/IP node
FTP K TEST N XMIO,OREF,LOC,FILE,IFILE S XMIO=$I
 ;
 ;Get unique number for file to send
 S (XMSFTP,X)=$G(^XMBX(4.2995,"F",0))+1,^(0)=X
 ;
XX S LOC=$P($G(^MAG(2005,+XMSFTP("IMAGE-PTR"),0)),U,3)
 S OREF=$P($G(^MAG(2005.2,LOC,589001)),U)
 ;
 S FILE="XM"_X_".COM",IFILE="XM"_X_".INP" O FILE:NEW O IFILE:NEW U FILE
 W "$! FTP COM procedure for sending binary files, UCX/XXX",!
 W "$ set noon",!
 W "$ ftp:=$ucx$ftp/ultrix",!
 W "$ ftp /input="_IFILE_" "_XMSFTP(3),!
 W "$ exit !Need to check status",! C FILE G PUT
 ;
 ;Get file from local network
 S %=$G(XMSFTP(4)) W %,!
 S %=$G(XMSFTP(5)) I $L(%) W %,!
 W "bin",!
 W "get "_$P(XMSFTP(2),U,2)_XMSFTP(2,"F")_" "_XMSFTP(2,"F"),!
 W "close",!
 ;
 ;Put file to remote location
 W "open "_XMSFTP(3),! G P
 ;
PUT U IFILE
 S %=$G(XMSFTP(6)) W "user ",%," "
P S %=$G(XMSFTP(7)) I $L(%) H 3 W %,! I $L($G(XMSFTP(7.1))) H 3 W XMSFTP(7.1),!
 W "bin",!
 W "lcd ",OREF,!
 ;
 ;Need to know directory on remote side
 S %=$G(XMSFTP(8)) I $L(%) W "cd "_%,!
 S %=$G(XMSFTP(2)) I $L(%) W "cd "_%,!
 W "delete "_XMSFTP(2,"F")_";*",!
 W "put ",XMSFTP(2,"F"),!
 C IFILE
 ;
 ;The following code originally spawned off an FTP transaction
 ;immediately when the XMnnn.COM file was created.  It has been
 ;replaced with code in XMRTCP.
 ;
 ;S %=$H*86400+$P($H,",",2)+600,%H=%\86400_","_(%#86400) D YX^%DTC S %=$P($P(Y,",")," ",2)_"-"_$P(Y," ")_"-"_$P($P(Y,"@"),", ",2)_":"_$P(Y,"@",2)
 ;
 S X=$$FILE(FILE) K FILE,XMTMPFIL
 U XMIO Q
B36 ;Calculate base 36 number
 N %,N,O,I,Z S O=X,%=X#36+1 D N S Y=N
 S %=X\(36)#36+1 D N S Y=N_Y
 S %=X\(36*36)#36+1 D N S Y=N_Y
 S %=X\(36*36*36)#36+1 D N S Y=N_Y
 S X=O Q
 Q
N S N=$E("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",%)
 Q
FILE(X) ;Add record to FTP list
 N DD,DO,DIC,DTOUT,DUOUT,Y
 S DIC="^XMBX(4.2995,",DIC(0)="LF",DIC("DR")="1///"_($H*86400+$P($H,",",2))_";2///"_$S($G(XMDUZ):XMDUZ,1:DUZ)
 D FILE^DICN S %=$G(XMSFTP("IMAGE-PTR")) I % S $P(^XMBX(4.2995,+Y,0),U,4)=%
 Q Y
TEST S TEST=1
 ;;XMSFTP(1)=get file IP address (EG   89.0.0.79 - sstu)
 ;;XMSFTP(2)=DOS dir / subdir... Other than default to IMPORT file into
 ;;XMSFTP(2,"F")=File to get (s:\image\nfibpd2.756)
 ;;XMSFTP(3)=put to IP address
 ;;XMSFTP(4)=User ID at origination node
 ;;XMSFTP(5)=User Password at origination node
 ;;XMSFTP(6)=User ID at destination node
 ;;XMSFTP(7)=User Password at destination node
 ;;XMSFTP(8)=FTP IMPORT PATH [VMS has DIR.SUBD..., see XMSFTP(2) for DOS]
 Q
 ;
 ;To display image on Pete's terminal
 ;>stage
 ;>C:\t\test3 file_name
 ;
 ;find differences:  diff file1 file2 (no display=no differences)
