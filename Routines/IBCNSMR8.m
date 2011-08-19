IBCNSMR8 ;ALB/TJK - MRA EXTRACT ;3/8/01  7:51 AM
 ;;2.0;INTEGRATED BILLING;**146**;21-MAR-94
OPEN ;open .dat file and write data to file
 D OPEN^%ZISH("MRAEXTRACT",PATH,FILENM,"W")
 I POP D EMSG G END
 U IO
 S I=0 F  S I=$O(^TMP("IBCNSMR7",$J,"DATA",I)) Q:'I  W ^(I),!
CLOSE ;close .dat file and send completion message to user
 D CLOSE^%ZISH("MRAEXTRACT")
MSG ;ENTER CODE FOR MESSAGE
 N XMSUB,XMY,XMTEXT,MSG,XMDUZ
 S XMSUB="Completion of MRA Extract"
 S XMY(DUZ)=""
 S XMDUZ="IB PACKAGE"
 S XMTEXT="MSG("
 S MSG(1)="The MRA Extract has been completed and data stored in file:"
 S MSG(2)="               "_FILENM
 S MSG(3)=" "
 S MSG(4)="This file must be sent via FTP to the following address:"
 S MSG(5)="  152.127.156.131"
 S MSG(6)="  Username:  MCCF"
 S MSG(7)="  Password:  MCCFEXT"
 D ^XMD
END Q
EMSG ;send error message to user if file not opened
 N XMSUB,XMY,XMTEXT,MSG
 S XMSUB="MRA EXTRACT OPEN ERROR"
 S XMY(DUZ)=""
 S XMTEXT="MSG("
 S MSG(1)="The file for the MRA extract could not be opened."
 S MSG(2)="The job will need to be requeued"
 D ^XMD
 Q
