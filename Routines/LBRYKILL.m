LBRYKILL ;SSI/KMB - DELETION OF LIBRARY FILES ;[ 03/11/98  11:51 AM ]
 ;;2.5;Library;**2**;Mar 11, 1996
 ;
 ;  *********  WARNING!  ************
 ;***** DO NOT RUN THIS PROGRAM UNLESS DIRECTED BY DEVELOPER *****
 ;
DELETE ;This routine will delete the DD and data for Library Files
 D MES^XPDUTL("The data will be deleted for the following files:")
 F I=680,680.4,680.5,680.7,681,682 D
 . S N=0
 . F  S N=$O(^LBRY(I,N)) Q:N=""  K ^LBRY(I,N)
 . S $P(^LBRY(I,0),"^",3)=0,$P(^(0),"^",4)=0
 . D MES^XPDUTL("File # "_I_" has been deleted.")
 Q
